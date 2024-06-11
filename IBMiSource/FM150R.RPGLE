000100010927      *********************************************************************
000200010928      * FM150R     - Duplicate Coverage Maintenance                       *
000300010927      *                                                                   *
000400010927      * ORIGINALLY WRITTEN BY Rick Jones      09/27/2001                  *
000500010927      *                       GROUP BENEFIT SERVICES SOFTWARE 2001        *
000600010927      *                                                                   *
000700010927      *  DESCRIPTION - This program will allow maintenance to the         *
000800010927      *            duplicate coverage file (ADD CHANGE).                  *
000900010927      *                                                                   *
001000010927      *********************************************************************
001100010927      * MODIFICATION HISTORY                                              *
001200010927      * ### UUU CCYYMMDD X-->                                             *
001300010927      *                                                                   *
001400010927      *********************************************************************
001500010926     FFM150D    CF   E             WORKSTN
001600011004     F                                     SFILE(ACCDTL:RRNA)
001700010927     F                                     SFILE(DUPDTL:RRND)
001800011009     F                                     SFILE(APLDTL:RRNP)
001900011003     FACCMST    IF   E           K DISK
002000010926     FPLNMST    IF   E           K DISK
002100011010     FDUPCOVL   IF   E           K DISK    RENAME(DUPCOVR:DUPCOL)
002200011010     FDUPCOVP   UF A E           K DISK
002300010926      *
002400010927      * USER DATA STRUCTURE FOR TITLE OF SCREENS
002500000216     D                UDS
002600000216     D  TITLE                201    240
002700011004      *   Account array
002800010926     D                 DS
002900011004     D  acar           S              4  0 DIM(999)
003000011004      *
003100011004     D                 DS
003200011004     D  wildcd                        1
003300011011     D  wkdt                           D
003400011015     D  todate                         D
003500011015     D  frdate                         D
003600011015     D  daterr                       65
003700011016     D  goback                        1
003800010926      *
003900011003     D tserr           C                   'Trust, Sub is invalid'
004000011003     D tsaerr          C                   'Trust, Sub, Acct is invalid'
004100011003     D tsperr          C                   'Trust, Sub, Plan is invalid'
004200011003     D noplans         C                   'There are no valid plans for TSA'
004300011009     D nosel           C                   'There were no accts selected'
004400011002     D dbcver          C                   'Dup Cvg must be Y-yes or N-no'
004500011002     D dusger          C                   'Usage must be W-web or M-migrate'
004600011011     D dateer          C                   'Overlap of date range with existing-
004700011011     D                                      T,S,A,Plan, New Plan Cat'
004800011011     D fr01er          C                   'From date must be first of month'
004900011011     D to01er          C                   'To date must be last day of month'
005000011012     D frtoer          C                   'From date is after to date'
005100011015     D lowver          C                   'From date is invalid'
005200010927      *
005300010927     C     dupcky        klist
005400010926     C                   kfld                    trust#
005500010926     C                   kfld                    sub#
005600010926     C                   kfld                    acct
005700010927     C                   kfld                    plan
005800011010      *
005900011010     C     duplky        klist
006000011010     C                   kfld                    trust#
006100011010     C                   kfld                    sub#
006200011010     C                   kfld                    acct
006300011010     C                   kfld                    plan
006400011010     C                   kfld                    apcat
006500011001      *
006600011001     C     dupxky        klist
006700011001     C                   kfld                    trust#
006800011001     C                   kfld                    sub#
006900011001     C                   kfld                    acct
007000011001     C                   kfld                    plan
007100011001     C                   kfld                    dnplan
007200010927      *
007300011003     C     acckey        klist
007400010927     C                   kfld                    trust#
007500010927     C                   kfld                    sub#
007600010927     C                   kfld                    acct
007700011003      *
007800011003     C     tskey         klist
007900011003     C                   kfld                    trust#
008000011003     C                   kfld                    sub#
008100010926      *
008200011009     C     plnke2        klist
008300011004     C                   kfld                    trust#
008400011004     C                   kfld                    sub#
008500011009      *
008600011009     C     plnkey        klist
008700011009     C                   kfld                    trust#
008800011009     C                   kfld                    sub#
008900011004     C                   kfld                    plan
009000010926      *
009100011003      *      MainLine
009200011003      *
009300011009      *        Determine T,S,A and Plan
009400011016     C     a150          tag
009500011016     C                   DOU       *inkg = '1' or
009600011003     C                             *inka = '1'
009700010926      *
009800010927     C                   exfmt     fm150a
009900010927      *
010000011003     C                   if        *inkg = '1' or
010100011003     C                             *inka = '1'
010200011009     C                   eval       *inlr = '1'
010300011009     C                   return
010400011008     C                   endif                                                  *inkg = '1'...
010500011008      *       See if T,S, Plan is valid
010600011008     C     plnkey        chain     plnmst                             15
010700011008     C                   if        *in15 = '1'
010800011008     C                   movel(P)  tsperr        smsg
010900011008     C                   iter
011000011008     C                   endif                                                  *in15 = '1'
011100011009      *         F4 - Display screen of possible accts to select
011200011001     C                   if        *inkd = '1'
011300011003      *       See if Trust, Sub is valid
011400011004     C     tskey         setll     accmst
011500011004      *
011600011004     C                   dou       *in11 = '1'
011700011004     C     tskey         reade     accmst                                 11
011800011004     C                   if        *in11 = '1'
011900011004     C                   movel(P)  tserr         smsg
012000011004     C                   iter
012100011008     C                   endif                                                  *in11 = '1'
012200011008      *        If Term Date is 0 => T,S is valid
012300011004     C                   if        atrmdt = 0
012400011004     C                   exsr      $winacct
012500011016     C                   if        goback = 'Y'
012600011016     C                   eval      goback = ' '
012700011016     C                   iter
012800011016     C                   endif                                                  *in11 = '1'
012900011004     C                   leave
013000011008     C                   endif                                                  atrmdt = 0
013100011008     C                   enddo                                                  *in11 = '1'
013200011003      *
013300011009     C                   if        acnt < 1 and
013400011009     C                             wildcd <> 'Y'
013500011009     C                   movel(P)  nosel         smsg
013600011009     C                   iter
013700011009     C                   else                                                   -- acnt < 1
013800011009     C                   leave
013900011009     C                   endif                                                  acnt < 1
014000011009      *
014100011008     C                   else                                                   -- *inkd = '1'
014200011003      *       See if T,S,A is valid
014300011003     C     acckey        chain     accmst                             15
014400011003     C                   if        *in15 = '1'
014500011003     C                   movel(P)  tsaerr        smsg
014600011003     C                   iter
014700011009     C                   else                                                   -- *in15 = '1'
014800011009     C                   z-add     1             acnt              3 0
014900011009     C                   leave
015000011009     C                   endif                                                  *in15 = '1'
015100011008     C                   endif                                                  *inkd = '1'
015200011003      *
015300011008     C                   enddo                                                  *inkg = '1'...
015400011009      *       Display and allow changes to existing DUPCOVP recs
015500011016     C     adup          tag
015600011016     C                   exsr      $dupcov
015700011016     C                   if        goback = 'Y'
015800011016     C                   eval      goback = ' '
015900011016     C                   goto      a150
016000011016     C                   endif
016100011009      *       Display non-PMM plans to allow bundling selection
016200011009     C                   exsr      $plnbun
016300011016     C                   if        goback = 'Y'
016400011016     C                   eval      goback = ' '
016500011016     C                   if        rrnd <> 0
016600011016     C                   goto      adup
016700011016     C                   else
016800011016     C                   goto      a150
016900011016     C                   endif
017000011016     C                   endif
017100011009      *       Redisplay and allow changes to existing DUPCOVP recs
017200011010     C                   if        chgcnt > 0
017300011010     C                   seton                                        19
017400011010     C                   endif
017500011009     C                   exsr      $dupcov
017600011009      *
017700011009     C                   eval      *inlr = '1'
017800010927     C                   return
017900010927      ******************************************************************
018000011003      *       SUBROUTINE - $WINACCT                                    *
018100011003      *           Build and display subfile of accts for T,S           *
018200010927      ******************************************************************
018300011003     C     $winacct      BEGSR
018400010926      *
018500011003     C     *INKg         DOWEQ     *OFF
018600011003     C     *INka         ANDEQ     *OFF
018700010926      *
018800011004     C                   EXSR      $ACLEAR
018900011004     C                   EXSR      $ALOAD
019000011004     C                   EXSR      $ADISP
019100010926      *    PROCESS SELECTION
019200011003     C     *INkg         IFEQ      *OFF
019300011003     C     *INka         ANDEQ     *OFF
019400011004     C     rrna          ANDNE     *ZERO
019500011004     C                   EXSR      $APROC
019600010928      *
019700011005     C                   if        acnt > 0 or
019800011005     C                             wildcd = 'Y'
019900011005     C                   leave
020000011005     C                   endif
020100011005      *
020200011016     C                   endif
020300011016     C                   enddo
020400011016      *
020500011016     C     *INka         IFEQ      *ON
020600011016     C                   eval      *inka = *OFF
020700011016     C                   eval      goback = 'Y'
020800010926     C                   ENDIF
020900011016      *
021000011016     C     *INkg         IFEQ      *ON
021100011016     C                   MOVE      *ON           *INLR
021200011016     C                   RETURN
021300011016     C                   ENDIF
021400011016      *
021500010926     C                   ENDSR
021600010926      ******************************************************************
021700011004      *       SUBROUTINE - $ACLEAR                                     *
021800010926      *                    CLEAR SUBF AND RRNH                         *
021900010926      ******************************************************************
022000011004     C     $ACLEAR       BEGSR
022100010927     C                   MOVEA     '001'         *IN(31)
022200011004     C                   WRITE     ACCHDR
022300011004     C                   Z-ADD     *ZERO         rrna              3 0
022400011004     C                   WRITE     ACCHDR
022500010927     C                   MOVEA     '010'         *IN(31)
022600010926     C                   ENDSR
022700010926      ******************************************************************
022800011004      *       SUBROUTINE - $ALOAD                                      *
022900011004      *                    LOAD SUBFILE W/ Acct Info                   *
023000010926      ******************************************************************
023100011004     C     $ALOAD        BEGSR
023200011004      *
023300011004     C     tskey         setll     accmst
023400011004      *
023500011004     C                   dou       *in11 = '1'
023600011004     C     tskey         reade     accmst                                 11
023700011004     C                   if        *in11 = '0' and
023800011004     C                             atrmdt = 0
023900011004     C                   add       1             rrna
024000011004     C                   write     accdtl
024100011004      *
024200011004     C                   endif
024300011004      *
024400011004     C                   enddo
024500010927      *
024600010926     C                   ENDSR
024700010926      ******************************************************************
024800011004      *       SUBROUTINE - $ADISP                                      *
024900011004      *         DISPLAY HEADER AND SUBFILE DETAIL for Acct selection   *
025000010926      ******************************************************************
025100011004     C     $ADISP        BEGSR
025200011004     C                   If        rrna <> *Zero
025300010927     C                   MOVE      *ON           *IN31
025400010926     C                   ENDIF
025500011004     C                   WRITE     acctrl
025600011004     C                   EXFMT     acchdr
025700010926     C                   ENDSR
025800010926      ******************************************************************
025900011004      *       SUBROUTINE - $APROC                                      *
026000010926      *                    PROCESS THE SELECTION                       *
026100010926      ******************************************************************
026200011004     C     $APROC        BEGSR
026300011004      *       If F2 => Wildcard - use all accts
026400011004     C                   IF        *inkb = '1'
026500011004     C                   z-add     0             acct
026600011004     C                   movel     'Y'           wildcd
026700011004     C                   else
026800011004      *
026900011005     C                   z-add     0             acnt              3 0
027000010926     C     *IN96         DOUEQ     *ON
027100011004     C                   READC     accdtl                                 96
027200010926     C                   IF        *IN96 = *OFF
027300011011     C                   IF        select = '1' or
027400011011     C                             select = 'X' or
027500011011     C                             select = 'x'
027600011005     C                   add       1             acnt
027700011004      *
027800011004     C                   IF        acnt = 1
027900011004     C                   z-add     acacct        acct
028000011004     C                   clear                   select
028100011004     C                   update    accdtl
028200011004     C                   iter
028300011004     C                   else
028400011004      *
028500011004     C                   IF        acnt = 2
028600011004     C                   z-add     acct          acar(1)
028700011004     C                   endif                                                  acnt = 2
028800011004      *
028900011004     C                   z-add     acacct        acar(acnt)
029000011004     C                   endif                                                  acnt = 1
029100011004     C                   clear                   select
029200011004     C                   update    accdtl
029300011004     C                   endif                                                  select = '1'
029400011004     C                   endif                                                  *in96 = *OFF
029500010926     C                   ENDDO
029600011004     C                   endif                                                  *inkb = '1'
029700010927     C                   ENDSR
029800010927      ******************************************************************
029900010927      *       SUBROUTINE - $DUPCOV                                     *
030000010927      *          Display Existing DUPCOVP records for T,S,A,P          *
030100010927      ******************************************************************
030200010927     C     $dupcov       BEGSR
030300010927      *
030400011003     C     *INkg         DOWEQ     *OFF
030500011003     C     *INka         ANDEQ     *OFF
030600010927      *
030700010927     C                   EXSR      $DCLEAR
030800010927     C                   EXSR      $DLOAD
030900011009     C                   if        rrnd = 0
031000011009     C                   leave
031100011009     C                   endif
031200010927     C                   EXSR      $DDISP
031300010927      *    PROCESS SELECTION
031400011003     C     *INkg         IFEQ      *OFF
031500011003     C     *INka         ANDEQ     *OFF
031600010927     C     RRND          ANDNE     *ZERO
031700010927     C                   EXSR      $DPROC
031800011016     C                   if        goback = 'Y'
031900011016     C                   eval      goback = ' '
032000011016     C                   iter
032100011016     C                   endif
032200011009     C                   if        dupup <> 'Y'
032300011009     C                   leave
032400011009     C                   endif
032500011009     C                   ENDIF
032600010927     C                   ENDDO
032700011016      *
032800011016     C     *inka         ifeq      *on
032900011016     C                   eval      *inka = *OFF
033000011016     C                   eval      goback = 'Y'
033100011016     C                   endif
033200011016      *
033300011016     C     *INkg         IFEQ      *ON
033400011016     C                   MOVE      *ON           *INLR
033500011016     C                   RETURN
033600011016     C                   ENDIF
033700010927     C                   ENDSR
033800010927      ******************************************************************
033900010927      *       SUBROUTINE - $DCLEAR                                     *
034000010927      *                    CLEAR SUBF AND RRNH                         *
034100010927      ******************************************************************
034200010927     C     $DCLEAR       BEGSR
034300010927     C                   MOVEA     '001'         *IN(61)
034400010927     C                   WRITE     DUPHDR
034500010927     C                   Z-ADD     *ZERO         RRND              3 0
034600010927     C                   WRITE     DUPHDR
034700010927     C                   MOVEA     '010'         *IN(61)
034800010927     C                   ENDSR
034900010927      ******************************************************************
035000010927      *       SUBROUTINE - $DLOAD                                       *
035100010927      *                    LOAD SUBFILE W/ DUPCOVP info              *
035200010927      ******************************************************************
035300010927     C     $DLOAD        BEGSR
035400010927     C                   SETOFF                                       6496
035500011009      *       If there is only 1 account or account = wildcard
035600011009     C                   if        acnt = 1 or
035700011009     C                             wildcd = 'Y'
035800010927     C     dupcky        setll     dupcovp                            64
035900010927     C     *IN64         DOUEQ     *ON
036000010927     C     *IN96         OREQ      *ON
036100010927     C     dupcky        reade     dupcovp                                64
036200010927     C                   IF        (*In64 <> *ON)
036300010927      *
036400011011     C                   if        duactv <> 'D'
036500010927     C                   ADD       1             RRNd
036600011009     C                   movel     acct          dnacct
036700011009     C                   movel     dunpln        dnplan
036800010927     C                   movel     duncat        dncat
036900010927     C                   movel     dudpcv        dndpcv
037000010927     C                   movel     dudusg        dnusg
037100010927     C                   movel     dufrdt        dnfrdt
037200010927     C                   movel     dutodt        dntodt
037300010927     C                   WRITE     dupdtl
037400010927     C                   ENDIF
037500011011     C                   ENDIF
037600010927     C                   ENDDO
037700011009      *
037800011009     C                   else
037900011009      *      More than 1 account - spin thru acar array
038000011009     C     1             do        999           x                 3 0
038100011009     C                   if        acar(x) = 0
038200011009     C                   leave
038300011009     C                   endif
038400011009      *
038500011009     C                   z-add     acar(x)       acct
038600011009     C     dupcky        setll     dupcovp                            64
038700011009     C     *IN64         DOUEQ     *ON
038800011009     C     *IN96         OREQ      *ON
038900011009     C     dupcky        reade     dupcovp                                64
039000011009     C                   IF        (*In64 <> *ON)
039100011009      *
039200011011     C                   if        duactv <> 'D'
039300011009     C                   ADD       1             RRNd
039400011009     C                   movel     acct          dnacct
039500011009     C                   movel     dunpln        dnplan
039600011009     C                   movel     duncat        dncat
039700011009     C                   movel     dudpcv        dndpcv
039800011009     C                   movel     dudusg        dnusg
039900011009     C                   movel     dufrdt        dnfrdt
040000011009     C                   movel     dutodt        dntodt
040100011009     C                   WRITE     dupdtl
040200011009     C                   ENDIF
040300011011     C                   ENDIF
040400011009     C                   ENDDO
040500011009      *
040600011009     C                   enddo
040700011009      *
040800011009     C                   endif
040900011009      *
041000010927     C                   ENDSR
041100010927      ******************************************************************
041200010927      *       SUBROUTINE - $DDISP                                      *
041300010927      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
041400010927      ******************************************************************
041500010927     C     $DDISP        BEGSR
041600010927     C                   If        rrnd <> *Zero
041700010927     C                   MOVE      *ON           *IN61
041800010927     C                   ENDIF
041900010927     C                   WRITE     duptrl
042000010927     C                   EXFMT     duphdr
042100010927     C                   ENDSR
042200010927      ******************************************************************
042300010927      *       SUBROUTINE - $DPROC                                      *
042400010927      *                    PROCESS THE SELECTION                       *
042500010927      ******************************************************************
042600010927     C     $DPROC        BEGSR
042700011009      *
042800011001     C                   movel     'N'           dupup             1
042900010928     C     *IN98         DOUEQ     *ON
043000010928     C                   READC     dupdtl                                 98
043100010928     C                   IF        *IN98 = *OFF
043200011011      *
043300011011     C                   if        dnsel = 'D' or
043400011011     C                             dnsel = 'd'
043500011009     C                   movel     dnacct        acct
043600011001     C     dupxky        chain     dupcovp                            68
043700011011     C                   IF        *In68 <> *ON
043800011011     C                   movel     'D'           duactv
043900011011     C                   movel     *date         dudltd
044000011001     C                   update    dupcovr
044100011001     C                   movel     'Y'           dupup             1
044200011011     C                   endif                                                  *in68 <> *on
044300011011     C                   iter
044400011011     C                   endif                                                  dnsel = 'D'...
044500011011      *
044600011011     C                   if        dnsel = 'C' or
044700011011     C                             dnsel = 'c'
044800011011     C                   movel     dnfrdt        cdfrdt
044900011011     C                   movel     dntodt        cdtodt
045000011011     C                   exsr      $chgdat
045100011016      *
045200011016     C                   if        goback = 'Y'
045300011016     C                   leave
045400011016     C                   endif
045500011016      *
045600011011     C                   movel     'Y'           dupup
045700011011     C                   iter
045800011011     C                   endif                                                  dnsel = 'C'...
045900011011      *
046000011011     C                   endif                                                  *in68 <> *on
046100011011      *
046200011011     C                   enddo
046300011011     C                   endsr
046400011011      ******************************************************************
046500011011      *       SUBROUTINE - $CHGDAT                                     *
046600011011      *                    Change validity dates of existing rec       *
046700011011      ******************************************************************
046800011011     C     $CHGDAT       BEGSR
046900011011      *
047000011011     C                   dou       *inkg = '1'
047100011011     C                   exfmt     chgdat
047200011011      *
047300011016     C                   if        *inkg = '1'
047400011016     C                   eval      *inlr = '1'
047500011016     C                   return
047600011011     C                   endif
047700011016      *
047800011016     C                   if        *inka = '1'
047900011016     C                   eval      *inka = *OFF
048000011016     C                   eval      goback = 'Y'
048100011016     C                   leave
048200011016     C                   endif
048300011015      *
048400011012     C                   movel     *blanks       cmsg
048500011015      *       Call routine to edit dates
048600011015     C                   if        cdfrdt <> dnfrdt or
048700011015     C                             cdtodt <> dntodt
048800011015     C                   eval      frdate = cdfrdt
048900011015     C                   eval      todate = cdtodt
049000011011      *
049100011015     C                   exsr      $chkdat
049200011015      *
049300011015     C                   if        daterr <> *blanks
049400011015     C                   movel(P)  daterr        cmsg
049500011015     C                   iter
049600011015     C                   endif
049700011015      *
049800011015     C                   endif
049900011015      *
050000011015     C                   leave
050100011011      *
050200011011     C                   enddo
050300011016     C                   if        goback <> 'Y'
050400011015      *     Update existing rcord with changed dates
050500011015     C                   movel     dnacct        acct
050600011015     C     dupxky        chain     dupcovp                            68
050700011015     C                   IF        *In68 <> *ON
050800011015     C                   movel     cdfrdt        dufrdt
050900011015     C                   movel     cdtodt        dutodt
051000011015     C                   update    dupcovr
051100011015     C                   movel     'Y'           dupup             1
051200011015     C                   endif                                                  *in68 <> *on
051300011011      *
051400011016     C                   endif                                                  goback <> 'Y'
051500011016      *
051600011011     C                   endsr
051700011009      ******************************************************************
051800011009      *       SUBROUTINE - $PLNBUN                                     *
051900011009      *           Build and display subfile of non-PMM plans           *
052000011009      ******************************************************************
052100011009     C     $plnbun       BEGSR
052200011009      *
052300011009     C     *INKg         DOWEQ     *OFF
052400011009     C     *INka         ANDEQ     *OFF
052500011009      *
052600011009     C                   EXSR      $PCLEAR
052700011009     C                   EXSR      $PLOAD
052800011009     C                   EXSR      $PDISP
052900011009      *    PROCESS SELECTION
053000011009     C     *INkg         IFEQ      *OFF
053100011009     C     *INka         ANDEQ     *OFF
053200011009     C     rrnp          ANDNE     *ZERO
053300011009     C                   EXSR      $PPROC
053400011009      *
053500011009     C                   leave
053600011009     C                   ENDIF
053700011009     C                   ENDDO
053800011016      *
053900011016     C     *inka         ifeq      *on
054000011016     C                   eval      *inka = *OFF
054100011016     C                   eval      goback = 'Y'
054200011016     C                   endif
054300011016      *
054400011016     C     *INkg         IFEQ      *ON
054500011016     C                   MOVE      *ON           *INLR
054600011016     C                   RETURN
054700011016     C                   ENDIF
054800011009     C                   movel     '0'           *in12
054900011009     C                   ENDSR
055000011009      ******************************************************************
055100011009      *       SUBROUTINE - $PCLEAR                                     *
055200011009      *                    CLEAR SUBF AND RRNP                         *
055300011009      ******************************************************************
055400011009     C     $PCLEAR       BEGSR
055500011009     C                   MOVEA     '001'         *IN(41)
055600011009     C                   WRITE     aplHDR
055700011009     C                   Z-ADD     *ZERO         rrnp              3 0
055800011009     C                   WRITE     aplHDR
055900011009     C                   MOVEA     '010'         *IN(41)
056000011009     C                   ENDSR
056100011009      ******************************************************************
056200011009      *       SUBROUTINE - $PLOAD                                      *
056300011009      *                    LOAD SUBFILE W/ Plan Info                   *
056400011009      ******************************************************************
056500011009     C     $PLOAD        BEGSR
056600011009      *
056700011009     C     plnke2        setll     plnmst
056800011009      *
056900011009     C                   dou       *in41 = '1'
057000011009     C     plnke2        reade     plnmst                                 41
057100011009     C                   if        *in41 = '0' and
057200011009     C                             pldltd <> 'D' and
057300011009     C                             plncat <> 'PMM'
057400011009     C                   add       1             rrnp
057500011009     C                   movel     plplan        applan
057600011009     C                   movel     plncat        apcat
057700011009     C                   movel     pdescr        apdesc
057800011009     C                   write     apldtl
057900011009      *
058000011009     C                   endif
058100011009      *
058200011009     C                   enddo
058300011009      *
058400011009     C                   ENDSR
058500011009      ******************************************************************
058600011009      *       SUBROUTINE - $PDISP                                      *
058700011009      *         DISPLAY HDR AND SUBFILE DTL for plan bundling selection*
058800011009      ******************************************************************
058900011009     C     $PDISP        BEGSR
059000011009     C                   If        rrnp <> *Zero
059100011009     C                   MOVE      *ON           *IN41
059200011009     C                   ENDIF
059300011009     C                   WRITE     apltrl
059400011009     C                   EXFMT     aplhdr
059500011009     C                   ENDSR
059600011009      ******************************************************************
059700011009      *       SUBROUTINE - $PPROC                                      *
059800011009      *                    PROCESS THE SELECTION                       *
059900011009      ******************************************************************
060000011009     C     $PPROC        BEGSR
060100011010     C                   z-add     0             chgcnt
060200011009     C     *IN99         DOUEQ     *ON
060300011009     C                   READC     apldtl                                 99
060400011009     C                   IF        *IN99 = *OFF
060500011011     C                   IF        sela = '1' or
060600011011     C                             sela = 'X' or
060700011011     C                             sela = 'x'
060800011009     C                   exsr      $procnew
060900011009     C                   ENDIF
061000011009     C                   CLEAR                   sela
061100011009     C                   UPDATE    apldtl
061200011009     C                   ENDIF
061300011009     C                   ENDDO
061400011009     C                   ENDSR
061500011001      ******************************************************************
061600011001      *       SUBROUTINE - $PROCNEW                                    *
061700011001      *                    PROCESS NEW PLN RECORD                      *
061800011001      ******************************************************************
061900011001     C     $PROCNEW      BEGSR
062000011009      *       If there is only 1 account or account = wildcard
062100011009     C                   if        acnt = 1 or
062200011009     C                             wildcd = 'Y'
062300011009      *
062400011003     C                   dou       *inkg = '1'
062500011001     C                   exfmt     aplprc
062600011002      *
062700011003     C                   if        *inkg = '1'
062800011002     C                   leave
062900011002     C                   endif
063000011002      *
063100011002     C                   if        dudpcv <> 'Y' and
063200011002     C                             dudpcv <> 'N'
063300011002     C                   movel     dbcver        amsg
063400011002     C                   iter
063500011002     C                   endif
063600011002      *
063700011002     C                   if        dudusg <> 'W' and
063800011002     C                             dudusg <> 'M'
063900011002     C                   movel     dusger        amsg
064000011002     C                   iter
064100011002     C                   endif
064200011015      *       Edit for valid dates
064300011015     C                   eval      frdate = apfrdt
064400011015     C                   eval      todate = aptodt
064500011015      *
064600011015     C                   exsr      $chkdat
064700011015      *
064800011015     C                   if        daterr <> *blanks
064900011015     C                   movel(P)  daterr        amsg
065000011015     C                   iter
065100011015     C                   endif
065200011011      *
065300011011     C     duplky        chain     dupcovl                            14
065400011011     C                   if        *in14 = '0'
065500011011     C                   if        apfrdt >= dufrdt and
065600011011     C                             apfrdt <= dutodt
065700011011     C                   movel     dateer        amsg
065800011011     C                   iter
065900011011     C                   endif
066000011011     C                   if        aptodt >= dufrdt and
066100011011     C                             aptodt <= dutodt
066200011011     C                   movel     dateer        amsg
066300011011     C                   iter
066400011011     C                   endif
066500011011     C                   endif
066600011002      *
066700011002     C                   z-add     trust#        dutrst
066800011002     C                   z-add     sub#          dusub#
066900011002     C                   z-add     acct          duacct
067000011002     C                   movel     plan          duplan
067100011002     C                   movel     'PMM'         duplct
067200011002     C                   movel     applan        dunpln
067300011002     C                   movel     apcat         duncat
067400011002     C                   movel     apfrdt        dufrdt
067500011002     C                   movel     aptodt        dutodt
067600011002     C                   write     dupcovr
067700011010     C                   add       1             chgcnt
067800011016      *      Display info message
067900011016     C                   z-add     acct          macct
068000011016     C                   movel     plan          mplan
068100011016     C                   movel     applan        mnplan
068200011016     C                   seton                                        18
068300011016     C                   exfmt     aplprc
068400011016     C                   setoff                                       18
068500011016      *
068600011002     C                   leave
068700011002      *
068800011002     C                   enddo
068900011009      *
069000011009     C                   else
069100011009      *      More than 1 account - spin thru acar array
069200011009     C     1             do        999           x                 3 0
069300011009     C                   if        acar(x) = 0
069400011009     C                   leave
069500011009     C                   endif
069600011009      *
069700011009     C                   z-add     acar(x)       acct
069800011009      *
069900011009     C                   dou       *inkg = '1'
070000011009     C                   exfmt     aplprc
070100011009      *
070200011009     C                   if        *inkg = '1'
070300011009     C                   leave
070400011009     C                   endif
070500011009      *
070600011009     C                   if        dudpcv <> 'Y' and
070700011009     C                             dudpcv <> 'N'
070800011009     C                   movel     dbcver        amsg
070900011009     C                   iter
071000011009     C                   endif
071100011009      *
071200011009     C                   if        dudusg <> 'W' and
071300011009     C                             dudusg <> 'M'
071400011009     C                   movel     dusger        amsg
071500011009     C                   iter
071600011009     C                   endif
071700011015      *       Edit for valid dates
071800011015     C                   eval      frdate = apfrdt
071900011015     C                   eval      todate = aptodt
072000011015      *
072100011015     C                   exsr      $chkdat
072200011015      *
072300011015     C                   if        daterr <> *blanks
072400011015     C                   movel(P)  daterr        amsg
072500011015     C                   iter
072600011015     C                   endif
072700011010      *
072800011010     C     duplky        chain     dupcovl                            14
072900011010     C                   if        *in14 = '0'
073000011010     C                   if        apfrdt >= dufrdt and
073100011010     C                             apfrdt <= dutodt
073200011010     C                   movel     dateer        amsg
073300011010     C                   iter
073400011010     C                   endif
073500011010     C                   if        aptodt >= dufrdt and
073600011010     C                             aptodt <= dutodt
073700011010     C                   movel     dateer        amsg
073800011010     C                   iter
073900011010     C                   endif
074000011010     C                   endif
074100011009      *
074200011009     C                   z-add     trust#        dutrst
074300011009     C                   z-add     sub#          dusub#
074400011009     C                   z-add     acct          duacct
074500011009     C                   movel     plan          duplan
074600011009     C                   movel     'PMM'         duplct
074700011009     C                   movel     applan        dunpln
074800011009     C                   movel     apcat         duncat
074900011009     C                   movel     apfrdt        dufrdt
075000011009     C                   movel     aptodt        dutodt
075100011009     C                   write     dupcovr
075200011016      *      Display info message
075300011016     C                   z-add     acct          macct
075400011016     C                   movel     plan          mplan
075500011016     C                   movel     applan        mnplan
075600011016     C                   seton                                        18
075700011016     C                   exfmt     aplprc
075800011016     C                   setoff                                       18
075900011016      *
076000011009     C                   leave
076100011009      *
076200011009     C                   enddo
076300011009      *
076400011009     C                   enddo
076500011009      *
076600011009     C                   endif
076700011002     C                   ENDSR
076800011015      ******************************************************************
076900011015      *       SUBROUTINE - $CHKDAT                                     *
077000011015      *           Check for validity fo from/to dates                  *
077100011015      ******************************************************************
077200011015     C     $chkdat       BEGSR
077300011015      *
077400011015     C                   movel     *blanks       daterr
077500011015      *
077600011015     C                   if        frdate = *loval
077700011015     C                   movel(P)  lowver        daterr
077800011015     C                   else
077900011015      *
078000011015     C                   extrct    frdate:*D     frday             2 0
078100011015     C                   if        frday <> 01
078200011015     C                   movel(P)  fr01er        daterr
078300011015     C                   else
078400011015      *
078500011015     C                   if        frdate > todate
078600011015     C                   movel(P)  frtoer        daterr
078700011015     C                   else
078800011015      *
078900011015     C     todate        adddur    1:*D          wkdt
079000011015     C                   extrct    wkdt:*D       frday             2 0
079100011015     C                   if        frday <> 01
079200011015     C                   movel     to01er        daterr
079300011015     C                   else
079400011015      *
079500011015     C                   if        frdate > todate
079600011015     C                   movel     frtoer        daterr
079700011015     C                   endif
079800011015     C                   endif
079900011015     C                   endif
080000011015     C                   endif
080100011015     C                   endif
080200011015      *
080300011015     C                   endsr
