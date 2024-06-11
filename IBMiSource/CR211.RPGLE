0001009102150002 F******************************************************************
0002000107240003 F* CR211      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009102150004 F*                                                                *
0004000107240004 F*          DLK - 07/24/01                                        *
0005009510040004 F*                                                                *
0006000107240013 F*          Read CR130HST & CR130HSP, get agency code and create  *
0007000107240014 F*          workifle CR210WK.                                     *
0008009808120015 F*                                                                *
0009000202040015 F* 02/04/02 dlk - agency code and market size added to cr130hst,  *
0010000202040015 F*                no longer need to chain back to sman to get     *
0011000202040015 F*                agency.                                         *
0012000301090015 F* 01/07/03 dlk - add dbe file and field "cbpd"                   *
0013000301310015 F* 01/31/03 dlk - add product type to DBE records                 *
0014000304300015 F* 04/30/03 ssk - salesman relationship project                   *
0015000401300015 F* 12/18/03 dlk - add sa info to cr210wk                          *
0016000601060015 F* 01/06/06 dlk - use cfrelchg file to change who was paid in     *
0017000601060015 F*                2005 when the persistency bonus is selected.    *
0018000701310015 F* 02/20/06 dlk - add use this carrier for persistency bonus      *
0019000602200015 F*                count and prem/com fields to workfile           *
0020000612120015 F* 12/12/06 dlk - remove phn, add coventry                        *
0021001306130015 F* 06/13/13 dlk - add nasco                                       *
0021011504200015 F* 04/20/15 dlk - add new carrier group code for coventry         *
0021021612300015 F* 12/30/16 dlk - remove admin (cr130hst) and coventry            *
0022000602200015 F*                                                                *
0023000304300015 F*                                                                *
0024009102150016 F******************************************************************
0026000301070018 FCR130HSd  If   E             DISK    rename(crhstr:crhsdr)
0027000612120018 FCR130HSo  If   E             DISK    rename(crhstr:crhsor)
0028000301310018 FCarmst    If   E           k DISK    prefix(C_)
002900030430     fspragxr2  if   e           k disk
003000030430     fsmanrlt   if   e           k disk
003100030430     fagency    if   e           k disk
003200030430     fsupragcy  if   e           k disk
003300031222     fsman      if   e           k disk
003400060105     fcfrelchg  if   e           k disk
0035000107240027 FCR210wk   O  a e             disk
006000061213
006100061213      ******************************
006200061213     c* do for CR130hsd - DBE
006300061213      ******************************
006400030107
006500030107     c                   dow       not(%eof(cr130hsd))
006600030107     c                   read      crhsdr
006700030107     c                   if        %eof(cr130hsd)
006800030107     c                   leave
006900030107     c                   end
007000030107
007100070131     c                   exsr      #getcar
007200030131
007300060105      * check for relation correction when persistency bonus is run
007400060105     c                   if        parmrel = 'Y'
007500060105     c                   exsr      #chkrel
007600060105     c                   end
007700030430
007800030430     c                   exsr      $comnrtn
007900030430
008000060105     c                   eval      cbpd = 'D'
008100030107     c                   write     cr210wkr
008200061213     c                   clear                   cr210wkr
008300030107     c                   enddo
008400030107
008500061213      ******************************
008600161230     c* do for CR130HSO for Nasco
008700061213      ******************************
008800061212
008900061212     c                   dow       not(%eof(cr130hso))
009000061212     c                   read      crhsor
009100061212     c                   if        %eof(cr130hso)
009200061212     c                   leave
009300061212     c                   end
009400061212
009500140116     c                   exsr      #getcar
009600140116
009700161230     c                   if        not %found(carmst) or
009801161230     c                             (cgrpcd <> 'NA')
009900061212     c                   iter
010000061212     c                   end
010100061212
010200061212      * check for relation correction when persistency bonus is run
010300061212     c                   if        parmrel = 'Y'
010400061212     c                   exsr      #chkrel
010500061212     c                   end
010600061212
010700061212     c                   exsr      $comnrtn
010800061212
010900130613     c                   clear                   cbpd
011000130613
011100161230      * nasco
011200130613     c                   select
011500130613     c                   when      cgrpcd = 'NA'
011600130613     c                   eval      cbpd = 'N'
011700130613     c                   endsl
011800130613
011900061212     c                   write     cr210wkr
012000061213     c                   clear                   cr210wkr
012100061212     c                   enddo
012200061212
012300010724     c                   eval      *inlr = *on
012400031218   S*
012500070131      **********************************************
012600070131      * get carrier info
012700070131      **********************************************
012800070131     c     #getcar       begsr
012900070131
013000070131     c     ccarcd        chain     carmst
013100070131     c                   if        %found(carmst)
013200070131     c                   move      c_capdty      cptype
013300070131     c                   move      c_capbcc      cr2capbcc
013400070131     c                   move      c_capbpc      cr2capbpc
013500070131     c                   move      c_carbc       cr2carbc
013600070131     c                   else
013700070131     c                   clear                   cptype
013800070131     c                   clear                   cr2capbcc
013900070131     c                   clear                   cr2capbpc
014000070131     c                   clear                   cr2carbc
014100070131     c                   end
014200070131
014300070131     c                   endsr
014400070131    *
014500070131
014600030430     c     $comnrtn      begsr
014700031218    *
014800031218
014900031218     c                   clear                   casacode
015000031218     c                   clear                   casanam
015100031218     c                   clear                   casatid
015200031222     c                   clear                   casmtid
015300031222     c                   clear                   casmnam
015400031218    *
015500030430     c                   if        crelid = *blanks
015600030430     c                   exsr      $agcylkup
015700030430     c                   leavesr
015800030430     c                   endif
015900030430    ***
016000031218     c     crelid        chain     smanrlt
016100030430     c                   if        not %found(smanrlt)
016200030430     c                   exsr      $agcylkup
016300030430     c                   leavesr
016400030430     c                   endif
016500031222
016600031222    * * sman info from relation
016700031222     c                   move      srsman        cbcode
016800031222     c     srsman        chain     sman
016900031222     c                   if        %found(sman)
017000031222     c                   eval      casmnam = %trim(sfname)
017100031222     c                   if        smi <> ' '
017200031222     c                   cat       smi:1         casmnam
017300031222     c                   end
017400031222     c                   cat       slname:1      casmnam
017500031222     c                   eval      casmtid = stin
017600030430     c                   endif
017700031218    *
017800031222     c     srasid        chain     spragxr2
017900031222     c                   if        not %found(spragxr2)
018000031222     c                   exsr      $agcylkup
018100031222     c                   leavesr
018200031222     c                   endif
018300031222    *
018400031218     c                   eval      casacode = sxsuper
018500031219     c                   eval      cagcod   = sxagcy
018600031219     c                   exsr      $agcylkup
018700031218      * get super agency
018800031218
018900031218     c     sxsuper       chain     supragcy
019000031218     c                   if        %found(supragcy)
019100031218     c                   eval      casanam = %trim(saname1)
019200031218     c                   eval      casatid = %subst(sataxid:1:9)
019300031218     c                   end
019400031218
019500030430     c                   endsr
019600031218   S*
019700030430     c     $agcylkup     begsr
019800031218    *
019900030430     c     cagcod        chain     agenr
020000030430     c                   if        %found(agency)
020100030430     c                   eval      cagnam = %trim(agnam1)
020200030430     c                   eval      cagtin = %editc(agtxid:'X')
020300030430     c                   endif
020400030430    ***
020500030430     c                   endsr
020600060105
020700060105      ********************************************************************
020800080102      * check CFRELCHG file for relation change to previous year
020900080102      * premium & comm $
021000060105      ********************************************************************
021100060105     c     #chkrel       begsr
021200060105     c     crelid        chain     cfrelchg
021300060105     c                   if        %found(cfrelchg) and cxchprm = 'Yes' and
021400060105     c                             cxnrel <> *blanks
021500060105     c                   move      cxnrel        crelid
021600060105     c                   end
021700060105     c                   endsr
021800060105
021900060105     c     *inzsr        begsr
022000060105     c     *entry        plist
022100060105     c                   parm                    parmrel           1
022200060105     c                   endsr
