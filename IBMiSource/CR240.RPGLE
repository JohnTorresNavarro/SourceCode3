000100030821     h option(*nodebugio)
000200000000  02  ******************************************************************
000300030814  03  *  CR240     GROUP BENEFIT SERVICES SOFTWARE                     *
000400000000  04  *                                                                *
000500000000  05  *            WRITTEN BY - DAVID KETTERMAN                        *
000600030814  06  *            DATE - 08/14/03                                     *
000700000000  07  *                                                                *
000800030814  08  *  DESCRIPTION - DBCR130NG file maintenance - allows finance to  *
000900030814  09  *                enter an account cancel date in all records     *
001000030814  09  *                for an account or just one line.                *
001100000000  07  *                                                                *
001200030909  07  * 09/09/03 dlk - remove "F6 - Update only one line" since it     *
001300030909  07  *                will cause update problems in DW330             *
001301050308  07  * 03/07/05 dlk - add F8 - change group number, do invdet update  *
001302050308  07  *                at the same time.                               *
001303071204  07  * 12/04/07 dlk - change orig/late to run sequence                *
001304100226  07  * 02/24/10 dlk - update dbrpa06ng also. make sure only the seq # *
001305100226  07  *                selected is updated for both dbcr130ng and      *
001400100226  07  *                dbrpa06ng.                                      *
001401141110  07  * 10/27/14 dlk - Show total unpaid on screen so user can see if  *
001402141110  07  *                it matches dbcr130ng. If total is positive show *
001403141110  07  *                warning on screen and email report back to user.*
001406141110  07  *                                                                *
001500000000  13  ******************************************************************
001600000000  13 F***
001700030814     FCR240D    CF   E             WORKSTN
001800030814     F                                     SFILE(S02SFL:rr2)
001900030826     Fdbcr130ng uf   e           k disk
001901100225     Fdbrpa06ng uf   e           k disk
001902050308     Finvdet    uf   e           k disk
0019031410270019 Fcr240p    O    F  132        PRINTER OFLIND(*INOF)
002000030818  00 D                 DS
002100030818  01 D  search                 1     10  0
002200030818  01 D  st                     1      3  0
002300030818  01 D  ss                     4      6  0
002400030818  01 D  sa                     7     10  0
002500030818  00 D                 DS
002600030818  01 D  remitdt                1      8  0
002700030814  01 D  remitmm                1      2  0
002800030814  01 D  remitdd                3      4  0
002900030814  01 D  remityy                5      8  0
003000030818  00 D                 DS
003100030818  01 D  scanmdy                1      8  0
003200030818  01 D  scanmm                 1      2  0
003300030818  01 D  scandd                 3      4  0
003400030818  01 D  scanyy                 5      8  0
003500030818  00 D                 DS
003600030818  01 D  scefimdy               1      8  0
003700030818  01 D  scefimm                1      2  0
003800030818  01 D  scefidd                3      4  0
003900030818  01 D  scefiyy                5      8  0
004000030818  00 D                 DS
004100030818  01 D  cefiymd                1      8  0
004200030818  01 D  cefiyy                 1      4  0
004300030818  01 D  cefimm                 5      6  0
004400030818  01 D  cefidd                 7      8  0
004601141027     D                UDS
0046031410280054 D  lreport                1      1
0046041410280054 D  CONAME               201    240
004700030814
004800030820      ***********************
004900030820     C* screen 1            *
005000030820     C* remit date select   *
005100030820      ***********************
005200030821     c                   dou       *in07
005300030820
005400030814     C                   exfmt     S01
005500030820     c                   clear                   *in20
005600030930     c                   clear                   *in21
005700030814     C* F7
005800030821     c                   if        *in07
005900030820     c                   leave
006000030814     c                   end
006100030814
006200030814     c                   if        remitmm < 01 or remitmm > 12 or
006300030814     c                             remitdd <> 01
006400030818     c                   eval      *in20 = *on
006500030820     c                   iter
006600030814     c                   end
006700030814
006800071204     c                   if        seq < 01 or  seq > 99
006900030930     c                   eval      *in21 = *on
007000030930     c                   iter
007100030930     c                   end
007200030930
007300030930     C                   clear                   search
007400030930
007500030820     c                   exsr      #screen2
007600030820
007700030820     c                   enddo
007800030820
007900030820     c                   eval      *inlr = *on
008000030820
008100030820      ***********************
008200030820      * screen 2            *
008300030820      ***********************
008400030820     c     #screen2      begsr
008500030820
008600030820
008700030814     C                   MOVE      remitdt       @DATIN
008800030814     C                   EXSR      #DATYM
008900030814     C                   MOVE      @DATOU        remitdtymd        8 0
009000030820
009100030820     C* clear and build subfile
009200030820     c                   exsr      #clrsfl
009300030821     C     dbkey         SETLL     dbcr130ng
009400030820     c                   exsr      #bldsfl
009500030820
009600030821     c                   dou       *in01 or *in07
009700030814
009800000000     C* DISPLAY SUBFILE
009900000000     C*
010000000000     C* *IN63 IS ON WHEN LAST PAGE IS DISPLAYED AND ROLLUP
010100000000     C* KEY IS PRESSED AGAIN... IF ANY MORE RECORDS WERE ADDED
010200000000     C* TO SUBFILE THEN DISPLAY NEXT PAGE,  ELSE IF THE LAST RECORD
010300000000     C* TO DISPLAY WAS EXACTLY THE LAST ONE ON THE LAST PAGE, THEN
010400000000     C* DISPLAY THE LAST PAGE
010500000000     C*
010600030821     C                   if        *in63
010700030821     C                   if        count > 0
010800000000     C                   ADD       75            SFREC#
010900000000     C                   ELSE
011000000000     C                   ADD       74            SFREC#
011100000000     C                   END
011200030821     C                   eval      *in63 = *off
011300000000     C                   END
011400000000     C*
011500030821     C                   eval      *IN61 = *on
011600030821     C                   if        rr2 > 0
011700030821     C                   eval      *IN60 = *on
011800000000     C                   END
011900030821
012000030814     C                   WRITE     S02CMDKY
012100030814     C                   EXFMT     S02CTL
012200030820      * f1 or f7
012300030821     c                   if        *in01 or *in07
012400030820     c                   leavesr
012500030820     c                   end
012600000000     C*
012700000000     C* IF ENTER PRESSED BUT NO RECORDS IN SUBFILE, RE-DISPLAY SCREEN
012800000000     C*
012900030821     C                   if        *in60 = *off
013000030821     C                   iter
013100030821     C                   END
013200000000     C*
013300000000     C* *IN63 IS ON WHEN LAST PAGE IS DISPLAYED AND ROLLUP
013400000000     C* KEY IS PRESSED AGAIN... LOAD NEXT 75  RECORDS IN SUBFILE
013500000000     C*
013600030821     C                   if        *in63
013700030821     C                   clear                   COUNT
013800030821     c                   exsr      #bldsfl
013900030821     C                   iter
014000000000     C                   END
014100030821
014200030819      * READ SUBFILE FOR Acct SELECTED
014300030819
014400030819     c                   dou       %eof(cr240d)
014500030819     C                   readc     s02sfl
014600030821     c                   if        not %eof(cr240d) and select = ' '
014700030821     C                   iter
014800030821     C                   end
014900030819     C                   enddo
015000030819
015100030820     C* display selected rec
015200030820
015300030820     c                   if        select <> ' '
015400030820     C                   exsr      #screen3
015500030821     c                   eval      *in01 = *off
015600030819     c                   end
015700030820
015800030821      * position to
015900030821     c*                  if        search <> *zeros
016000030821     c                   exsr      #clrsfl
016100030821     C     dbkey         SETLL     dbcr130ng
016200030821     C                   clear                   COUNT
016300030821     c                   exsr      #bldsfl
016400030821     C*                  clear                   search
016500030821     C*                  END
016600030821
016700030820     C* ENTER PRESSED with no selection... REDISPLAY AND TRY AGAIN
016800030820     c                   enddo
016900030820
017000030820     c                   endsr
017100030820
017200030820      *****************************
017300030820     C* screen 3 -                *
017400030820     C* DISPLAY DBCR130NG INFO    *
017500030820      *****************************
017600030820     c     #screen3      begsr
017700030818
017800030818     C     s03key        CHAIN     dbcr130ng
017900030818
018000030818     C                   if        %found(dbcr130ng)
018100030818     C* move fields to output for screen 3
018200030818
018300030818     C                   MOVE      caccandt      @DATIN
018400030818     C                   EXSR      #DATYM
018500030818     C                   MOVE      @DATOU        scanmdy
018502050307     C                   MOVE      cgroup        groupchg
018503141027
018504141027      * calc total amount unpaid in INVDET for display on screen
018505141027     c                   exsr      #calctotdet
018700030818
018800030821     c                   dou       *in01
018900030821
019000030814     C                   EXFMT     S03
019100030818     c                   eval      *in30 = *off
019200030821      * F1
019300030821     c                   if        *in01
019400030821     c                   leavesr
019500030821     c                   end
019600030818
019700030819     c                   if        scanmdy <> 0
019800030819     c                   if        scanmm < 01 or scanmm > 12 or
019900030818     c                             scandd <> 01 or scanyy < 2000 or
020000030818     c                             scanyy > 2050
020100030818     c                   eval      *in30 = *on
020200030821     C                   iter
020300030818     c                   end
020400030819     c                   end
020500030818
020600030818      * F6 - update this record
020700030909     c*                  if        *in06
020800030909     C*                  MOVE      scanmdy       @DATIN
020900030909     c*                  EXSR      #DATYM
021000030909     C*                  MOVE      @DATOU        caccandt
021100030909     c*                  update    crhstr
021200030909     C*                  leavesr
021300030909     c*                  end
021400030818
021401050307      * F9 - acct cancel date update for all records with this acc#
021500050307      *      and remittance effdt
021600030818     c                   if        *in09
021700030818     C                   MOVE      scanmdy       @DATIN
021800030818     C                   EXSR      #DATYM
021900030818     C                   MOVE      @DATOU        h_canymd          8 0
022000030818
022100030818     C                   MOVE      ctrust        h_trust           3 0
022200030818     C                   MOVE      csub          h_sub             3 0
022300030818     C                   MOVE      cacct         h_acct            4 0
022400030818     C                   MOVE      remitdtymd    h_remitymd        8 0
022500030818
022600100226      * change all rec for this eff/t/s/a and seq#
022700030818
022701141027     c                   clear                   totdbneg          9 2
022800030818     C     dbkey2        SETLL     dbcr130ng
022900030818     c                   dou       %eof(dbcr130ng)
023000030818     C     dbkey2        reade     dbcr130ng
023100100226     C                   if        not %eof(dbcr130ng) and cseq = seq
023200030819     c                   move      h_canymd      caccandt
023201141027     c                   add       cpamt         totdbneg
023300030818     c                   update    crhstr
023400030818     c                   end
023500030818     c                   enddo
023600030818
023601141110      * write report if dbcr130ng total does not match invoice detail total
023602141027     c                   if        totdbneg <> totdet
023603141027     c                   if        firste = ' '
023604141027     c                   move      'Y'           firste            1
023605141027     c                   except    head
023606141027     c                   end
023610141027     c   of              except    head
023611141027     c                   except    error1
023612141028     c                   move      'Y'           lreport
023613141027     c                   end
023614141027
023615141027
023616100226      * change all rec in dbrpa60ng for this eff/t/s/a seq# also
023617100225     C     dbkey2        SETLL     dbrpa06ng
023618100225     c                   dou       %eof(dbrpa06ng)
023619100225     C     dbkey2        reade     dbrpa06ng
023620100226     C                   if        not %eof(dbrpa06ng) and rpseq# = seq
023621100225     c                   move      h_canymd      RPACCANDT
023622100225     c                   update    rpa60r
023623100225     c                   end
023624100225     c                   enddo
023625100225
023700030821     C                   leavesr
023800030818     c                   end
023900030818     C*
023901050307
023902050307      * F8 - Group # update for all records with this acc# and remittance
023903050307      *      effdt
023904050307     c                   if        *in08
023909050307     C                   MOVE      ctrust        h_trust
023910050307     C                   MOVE      csub          h_sub
023911050307     C                   MOVE      cacct         h_acct
023912050307     C                   MOVE      cgroup        h_cgroup         15
023913050307     C                   MOVE      remitdtymd    h_remitymd
023914050307
023915100226      * change all group # for this eff/t/s/a/group # and seq
023916050307
023917050307     C     dbkey2        SETLL     dbcr130ng
023918050307     c                   dou       %eof(dbcr130ng)
023919050307     C     dbkey2        reade     dbcr130ng
023920050307     C                   if        not %eof(dbcr130ng) and
023921100226     C                             cgroup = h_cgroup and cseq = seq
023922050307     c                   move      groupchg      cgroup
023923050307     c                   update    crhstr
023924050307     c                   end
023925050307     c                   enddo
023926050307
023927100225      * change all group # in dbrpa06ng for this eff/t/s/a/group #
023928100225
023929100225     C     dbkey2        SETLL     dbrpa06ng
023930100225     c                   dou       %eof(dbrpa06ng)
023931100225     C     dbkey2        reade     dbrpa06ng
023932100225     C                   if        not %eof(dbrpa06ng) and
023933100226     C                             rpgrp = h_cgroup and rpseq# = seq
023934100225     c                   move      groupchg      rpgrp
023935100225     c                   update    rpa60r
023936100225     c                   end
023937100225     c                   enddo
023938100225
023939050308      * change group # in invdet
023940050308
023941050308     c                   exsr      #upinvdet
023942050308
023943050307     C                   leavesr
023944050307     c                   end
023945050307     C*
024000030818      * enter pressed w/no selection
024100030821     C                   enddo
024200030821
024300030821     C* NO HIT ON FILE...error
024400000000     C                   ELSE
024500030820     C                   leavesr
024600000000     C                   END
024700030814
024800030820     C                   endsr
024900030820
025000030820      ***********************
025100050308      * update invdet with new group number for all records that make
025101050308      * up the negative gpr group selected
025200030820      ***********************
025300050308     c     #upinvdet     begsr
025306050308
025307050308     c     invdetkey     setll     invdet
025308050308     C                   dou       %eof(invdet)
025309050308     c     invdetkey     reade     invdet
025310050308
025311050308     c                   if        not %eof(invdet) and idbccc = 'D' and
025312050308     c                             idtrnd <> 0 and idpaid = 0 and
025313050308     C                             idgrp# = h_cgroup
025315050308
025316050308     c                   move      groupchg      idgrp#
025321050308     c                   update    invdr
025322050308     c                   end
025323050308
025324050308     c                   enddo
025325050308     C                   endsr
025326050308
025327141027      ***********************
025328141027      * calculate total billed but not paid in invdet.
025329141027      * This is the amount DW330 will update when it runs. This amount
025330141027      * allows Finance to verify the amount matches the amount in
025331141027      * dbcr130ng in case there are other unpaid months not showing in
025332141027      * dbcr130ng
025333141027      ***********************
025334141027     c     #calctotdet   begsr
025335141027
025336141027     c                   clear                   totdet
025338141027
025339141027     C                   MOVE      ctrust        h_trust
025340141027     C                   MOVE      csub          h_sub
025341141027     C                   MOVE      cacct         h_acct
025342141027
025343141027     c     invdetkey     setll     invdet
025344141027     C                   dou       %eof(invdet)
025345141027     c     invdetkey     reade(n)  invdet
025346141027     c                   if        not %eof(invdet) and idbccc = 'D' and
025347141027     c                             idtrnd <> 0 and
025348141027     c                             (idpaid = 0 or idcomdt = 0)
025350141027     c                   add       idtram        totdet
025351141027     c                   end
025352141027     c                   enddo
025353141027
025354141027      * if amount is positive then there must be other months unpaid in
025355141027      * f.invdet so display warning message on screen.
025356141027     c                   eval      *in44 = *off
025357141027     c                   if        totdet > 0
025358141027     c                   eval      *in44 = *on
025359141027     c                   end
025360141027
025361141027     C                   endsr
025400030820
025401050308      ***********************
025402050308      * clear subfile       *
025403050308      ***********************
025404050308     c     #clrsfl       begsr
025405050308
025500030820     C                   MOVEA     '0010'        *IN(60)
025600030820     C                   clear                   select
025700030820     C                   Z-ADD     1             SFREC#
025800030820     C                   clear                   rr2               5 0
025900030820     C                   clear                   COUNT             5 0
026000030820     C                   WRITE     S02CTL
026100030820     C                   eval      *in62 = *off
026200030820     C                   endsr
026300030820
026400030820      ***********************
026500030820      * build subfile       *
026600030820      ***********************
026700030820     c     #bldsfl       begsr
026800030821
026900031013     c                   dou       count = 75 or %eof(dbcr130ng)
027000030930     c     remitdtymd    reade     dbcr130ng                              64
027100030930
027200071204      * select seq
027300071204     C                   if        *in64 = *off and cseq = seq
027800030820     C                   ADD       1             rr2
027900030820     C                   ADD       1             COUNT
028000030820     c                   move      ctrust        sctrust
028100030820     c                   move      csub          scsub
028200030820     c                   move      cacct         scacct
028300030820     c                   move      cgrpcd        scgrpcd
028400030820     c                   move      ccarcd        sccarcd
028500030820     c                   move      cgroup        scgroup
028600030820     c                   move      cplan         scplan
028700071204     c                   move      cseq          scseq
028800030820
028900030820     C                   MOVE      cefiymd       @DATIN
029000030820     C                   EXSR      #DATYM
029100030820     C                   MOVE      @DATOU        scefimdy
029200030820
029300030820
029400030820     C                   MOVE      caccandt      @DATIN
029500030820     C                   EXSR      #DATYM
029600030820     C                   MOVE      @DATOU        scaccanmdy
029700030820
029800030820     C                   WRITE     S02SFL
029900030820
030000031013     c*                  else
030100030821      * eof
030200031013     c*                  leave
030300030820     c                   end
030400030820
030500030820     c                   enddo
030600030820
030700030820     C                   endsr
0308009903230107 C*
0309009903230103 C***************************************************
0310009903230104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0311009903230105 C***************************************************
0312009903230107 C*
0313009903230107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0314009903230107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0315009903230107 C*
0316009903230106 C     #DATYM        BEGSR
031700990323     C                   MOVE      @DATIN        @MD               4 0
031800990323     C                   MOVEL     @DATIN        @Y                4 0
031900990323     C                   MOVEL     @MD           @DATOU            8 0
032000990323     C                   MOVE      @Y            @DATOU
032100990323     C                   MOVE      *ZEROS        @DATIN            8 0
0322009903230120 C                   ENDSR
032300990323     C*
0324000308200106 C     *inzsr        BEGSR
032500030820
032600030820     c     dbkey         klist
032700030820     c                   kfld                    remitdtymd
032800030820     c                   kfld                    st
032900030820     c                   kfld                    ss
033000030820     c                   kfld                    sa
033100030820
033200030820     c     dbkey2        klist
033300030820     c                   kfld                    h_remitymd
033301050308     c                   kfld                    h_trust
033302050308     c                   kfld                    h_sub
033303050308     c                   kfld                    h_acct
033601050308
033602050308     c     invdetkey     klist
033603050308     c                   kfld                    h_trust
033604050308     c                   kfld                    h_sub
033605050308     c                   kfld                    h_acct
033609050308
033700030820
033800030820     c     s03key        klist
033900030820     c                   kfld                    remitdtymd
034000030820     c                   kfld                    sctrust
034100030820     c                   kfld                    scsub
034200030820     c                   kfld                    scacct
034300030820     c                   kfld                    scgrpcd
034400030820     c                   kfld                    sccarcd
034500030820     c                   kfld                    scgroup
034600030820     c                   kfld                    scplan
034700030820     c                   kfld                    scefiyy
034800030820     c                   kfld                    scefimm
034900030820     c                   kfld                    scefidd
035000071204     c                   kfld                    scseq
035100030820
035200030820     c                   clear                   remitdt
035301141027     C                   TIME                    HTIME             6 0
035302141027
0354000308200120 C                   ENDSR
0355001410270237 Ocr240p    e            head           2 03
0356001410270239 O                                           44 '*****'
0357001410270240 O                       CONAME              85
0358001410270241 O                                           91 '*****'
0359001410270242 O          e            head           1
0360001410270244 O                                           73 'TAB 5 ACCOUNT CANCEL DATE'
0360011410270244 O                                           87 ' UPDATE REPORT'
0361001410270242 O          e            head           1
0362001410270248 O                                           24 'PROGRAM NAME: CR240'
0363001410270249 O                                          122 'PAGE :'
0364001410270250 O                       PAGE          Z    131
0365001410270242 O          e            head           1
0366001410270253 O                                           14 'RUN DATE:'
0367001410270254 O                       UDATE         Y     25
0368001410270255 O                                          122 'TIME :'
0369001410270256 O                       htime              131 '  :  :  '
0370001410270242 O          e            head           1
0371001410270259 O                                           24 '""""""""""""""""""""""""'
0372001410270260 O                                           48 '""""""""""""""""""""""""'
0373001410270261 O                                           72 '""""""""""""""""""""""""'
0374001410270262 O                                           96 '""""""""""""""""""""""""'
0375001410270263 O                                          120 '""""""""""""""""""""""""'
0376001410270264 O                                          132 '""""""""""""'
0377001410270242 O          e            head           1
0379001410270275 O                                            6 'ACCT #'
0380001410270276 O                                           25 'CANCEL DATE'
0380011410270276 O                                           42 'TAB 5 TOTAL'
0380021410280276 O                                           58 'DETAIL TOTAL'
0380031410270276 O                                           72 'MESSAGE'
0381001410270242 O          e            head           2
0382001410270281 O                                           24 '""""""""""""""""""""""""'
0383001410270282 O                                           48 '""""""""""""""""""""""""'
0384001410270283 O                                           72 '""""""""""""""""""""""""'
0385001410270284 O                                           96 '""""""""""""""""""""""""'
0386001410270285 O                                          120 '""""""""""""""""""""""""'
0387001410270286 O                                          132 '""""""""""""'
0388001410270287 O          E            error1         1
038801141027     o                       h_trust              3
038802141028     o                                            4 '-'
038803141028     o                       h_sub                7
038804141028     o                                            8 '-'
038805141027     o                       h_acct              12
0394001410280289 O                       scanmdy             25 '  /  /    '
0396001410270289 O                       totdbneg      j     42
0397001410280289 O                       totdet        j     58
0398001410280289 O                                           91 'TAB 5 TOTAL DOES NOT MATCH'
0399001410280289 O                                          104 ' DETAIL TOTAL'
