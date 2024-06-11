000100981030     F*-------------------------------------------------------------------------
000200021204      * DBSETUPR   GROUP BENIFIT SERVICES SOFTWARE           2001
000300981030      *            WRITTEN BY - R.L.J.
000400021204      *            DATE - 12/2002
000500021204      *  DESCRIPTION - Maintain Del Billing Group/Plan Xfef File
000600981030      *  Technical Specs- This program uses a Load All Subfile technique - this
000700981030      *            used when the subfile to be loaded is known to be small ( 100
000800981105      *  Indicator Usage:
000900981030      *            31     Display Subfile
001000981030      *            32     Display Subfile Control
001100981030      *            33     Clear Subfile
001200981030      *            34     Subfile End
001300981030      *-------------------------------------------------------------------------
001400010620      *  Change Log
001500131230      * rlj  12/30/2013   Allow status of 'I' - ignore
001600140909      * rlj  09/09/2014   Ensure that plan type matches PLNMST plan type
001700170202      * rlj  02/02/2017   Ensure that T-S-A matches for a groupID's recs
001800000306      *-------------------------------------------------------------------------
001900040629     Fdel2gxrl2 IF   E           K DISK    RENAME(DEL2GXRR:DELGXR2)
002000170202     Fdel2gxrl3 IF   E           K DISK    PREFIX(X)
002100170202     F                                     RENAME(DEL2GXRR:DELGXR3)
002200040629     Fdel2gxrl  UF A E           K DISK
002300021210     Faccmst    IF   E           K DISK
002400021210     Fgrate     IF   E           K DISK
002500140909     Fplnmst    IF   E           K DISK
002600140909     Fcodes     IF   E           K DISK
002700040629     Fdbsetup2d CF   E             WORKSTN
002800981027     F                                     SFILE(DETAIL:RRN)
002900011127      *
003000011127     D                 DS
003100021205     D  updt                          1
003200021210     D  vrfy                          1
003300170202     D  terr                          1
003400010621      *
003500010621     D                 DS
003600010621     D  clparm                 1     11
003700140909      *
003800140909     D                 DS
003900140909     D  plncat                 1      3
004000140909     D   cdky1                 1      1
004100140909     D   cdky2                 2      3
004200040720      *
004300040720     D                 DS
004400040720     D  kgrid                              LIKE(dggrid)
004500040720      *
0046000212100053 D                 DS
0047000212100054 D  acerr          C                   'New Trst, Sub#, Acct not valid'
0048001702020054 D  tsaer          C                   'T-S-A must match across the Group'
0049000212100054 D  plerr          C                   'New Trst, Sub#, Plan not valid'
0050000212100054 D  dterr          C                   'There are no completed recs   '
0051000407200054 D  nonam          C                   'Cannot set to A with name blank'
0052001312310054 D  rierr          C                   'Status I can only be for RX Plan'
0053001409090054 D  pterr          C                   'Plan types do not match         '
005400011120      *
005500021204     C     xrkey         KLIST
005600021204     C                   KFLD                    dsgrid
005700021204     C                   KFLD                    dscsid
005800040629     C                   KFLD                    dsplnc
005900021210      *
006000021210     C     ackey         KLIST
006100021210     C                   KFLD                    dctrst
006200021210     C                   KFLD                    dcsub#
006300021210     C                   KFLD                    dcacct
006400021210      *
006500021210     C     plkey         KLIST
006600021210     C                   KFLD                    dctrst
006700021210     C                   KFLD                    dcsub#
006800021210     C                   KFLD                    dcplan
006900140909      *
007000140909     C     cdkey         KLIST
007100140909     C                   KFLD                    cdky1
007200140909     C                   KFLD                    cdky2
007300021206      *
007400021206     C     *ENTRY        PLIST
007500021206     C                   PARM                    usrnam           10
007600991116      *
007700981030      *    MAINLINE
007800021204      *
007900011120      *    PROCESS SELECTION
008000981027     C     *IN03         DOWEQ     *OFF
008100981027     C     *IN12         ANDEQ     *OFF
008200021210      *
008300981102     C                   EXSR      $CLEAR
008400021227     C                   EXSR      $POSIT
008500981109     C                   EXSR      $LOAD
008600981109     C                   EXSR      $DISPLAY
008700011108     C                   setoff                                       88
008800021210     C                   movel(P)  *blanks       dtlerr
008900021209      *    Cmd-6 - Show/Hide completed recs
009000981027     C     *IN03         IFEQ      *OFF
009100981027     C     *IN12         ANDEQ     *OFF
009200021209     C     *IN06         ANDEQ     *ON
009300021210     C     *in76         ifeq      *OFF
009400021210      *   Make sure there are some C recs
009500040629     C     'C'           chain     del2gxrl2                          79
009600021210     C                   if        *in79 = '1'
009700021210     C                   movel(P)  dterr         dtlerr
009800021210     C                   iter
009900021210     C                   Endif
010000021210      *
010100021210     C                   seton                                        76
010200021210     C                   Else
010300021210     C                   setoff                                       76
010400021209     C                   ENDIF
010500021209     C                   ENDIF
010600021209      *    PROCESS SELECTION
010700021209     C     *IN03         IFEQ      *OFF
010800021209     C     *IN12         ANDEQ     *OFF
010900021209     C     RRN           ANDNE     *ZERO
011000021209     C                   EXSR      $PROCES
011100021209     C                   ENDIF
011200021209      *
011300981027     C                   ENDDO
011400981112     C                   MOVE      *ON           *INLR
011500981112     C                   RETURN
011600981030      ******************************************************************
011700981109      *       SUBROUTINE - $CLEAR                                      *
011800981030      *                    CLEAR SUBF AND RRN                          *
011900981030      ******************************************************************
012000981102     C     $CLEAR        BEGSR
012100981027     C                   MOVEA     '001'         *IN(31)
012200981027     C                   WRITE     HEADER
012300030423     C                   Z-ADD     *ZERO         RRN               4 0
012400981027     C                   WRITE     HEADER
012500981027     C                   MOVEA     '010'         *IN(31)
012600981027     C                   ENDSR
012700021227      ******************************************************************
012800021227      *       SUBROUTINE - $POSIT                                      *
012900021227      *                    POSITION Group FILE                        *
013000021227      ******************************************************************
013100021227     C     $POSIT        BEGSR
013200040720     C     pgrpid        SETLL     del2gxrl
013300021227     C                   ENDSR
013400981030      ******************************************************************
013500981109      *       SUBROUTINE - $LOAD                                       *
013600981102      *                    LOAD SUBFILE W/ Client Info                 *
013700981030      ******************************************************************
013800981109     C     $LOAD         BEGSR
013900981112     C                   SETOFF                                       3495
014000030423     C                   z-add     0             RRN
014100981112     C     *IN34         DOUEQ     *ON
014200981027     C     *IN95         OREQ      *ON
014300040720     C                   READ(N)   del2gxrl                               34
014400040629     C                   IF        *In34 <> *ON
014500991116      *
014600021209     C                   IF        (*In76 = *ON and dgstat = 'C') or
014700021209     C                             (*In76 = *OFF and dgstat <> 'C')
014800021209      *
014900991116     C                   ADD       1             RRN
015000021204     C                   MOVEL     dggrid        dsgrid
015100021204     C                   MOVEL     dgcsid        dscsid
015200021204     C                   MOVEL     dgplnc        dsplnc
015300021204     C                   MOVEL     dgtrst        dstrst
015400021204     C                   MOVEL     dgsub#        dssub#
015500021204     C                   MOVEL     dgacct        dsacct
015600021204     C                   MOVEL     dgplan        dsplan
015700021204     C                   MOVEL     dgstat        dsstat
015800021206     C                   setoff                                       5556
015900021206      *
016000021206     C                   If        dsstat = ' ' or dsstat = 'O'
016100021206     C                   seton                                        55
016200021206     C                   else
016300021206     C                   If        dsstat = 'P'
016400021206     C                   seton                                        56
016500021206     C                   endif
016600021206     C                   endif
016700021206      *
016800021206     C                   MOVEL     dggnam        dsgnam
016900021206     C                   MOVEL     dgpdes        dspdes
017000021206      *
017100981027     C                   WRITE     DETAIL
017200981027     C                   ENDIF
017300021209     C                   ENDIF
017400981027     C                   ENDDO
017500981027     C                   ENDSR
017600981030      ******************************************************************
017700981109      *       SUBROUTINE - $DISPLAY                                    *
017800981102      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
017900981030      ******************************************************************
018000981109     C     $DISPLAY      BEGSR
018100981102     C                   If        RRN <> *Zero
018200981027     C                   MOVE      *ON           *IN31
018300981027     C                   ENDIF
018400981112     C                   WRITE     TRAILER
018500981112     C                   EXFMT     HEADER
018600981027     C                   ENDSR
018700981030      ******************************************************************
018800981109      *       SUBROUTINE - $PROCES                                     *
018900981030      *                    PROCESS THE SELECTION                       *
019000981030      ******************************************************************
019100981109     C     $PROCES       BEGSR
019200030522      *
019300030522     C                   IF        *IN08 = *ON
019400040629     C                   call      'DBEDTRPT2C'
019500030522     C                   leavesr
019600030522     C                   ENDIF
019700030806      *
019800030922     C                   IF        *IN13 = *ON
019900040629     C                   call      'DBCONVRT2C'
020000030806     C                   leavesr
020100030806     C                   ENDIF
020200030522      *
020300010620     C     *IN95         DOUEQ     *ON
020400010620     C                   READC     DETAIL                                 95
020500010620     C                   IF        *IN95 = *OFF
020600040720     C                   IF        SELECT = '3'
020700040720     C                   exsr      $chgnam
020800981027     C                   ENDIF
020900040720     C                   IF        SELECT = '2'
021000040720     C                   exsr      $chgdtl
021100040720     C                   ENDIF
021200021205     C                   IF        SELECT = '1'
021300021204     C                   exsr      $disdtl
021400010620     C                   ENDIF
021500981027     C                   CLEAR                   SELECT
021600981027     C                   UPDATE    DETAIL
021700981027     C                   ENDIF
021800981027     C                   ENDDO
021900981027     C                   ENDSR
022000010620      ******************************************************************
022100021204      *       SUBROUTINE - $CHGDTL                                     *
022200021204      *              Allow user to change certain fields              *
022300010620      ******************************************************************
022400021204     C     $chgdtl       BEGSR
022500131231     C                   movel(P)  *blanks       chgerr
022600010620     C     *IN03         DOWEQ     *OFF
022700010620     C     *IN12         ANDEQ     *OFF
022800040629     C     xrkey         chain     del2gxrl
022900040720     C                   MOVEL     dgplnc        dcplnc
023000021205     C                   MOVEL     dgtrst        dctrst
023100021205     C                   MOVEL     dgsub#        dcsub#
023200021205     C                   MOVEL     dgacct        dcacct
023300021205     C                   MOVEL     dgplan        dcplan
023400021205     C                   MOVEL     dgstat        dcstat
023500021206      *
023600021206     C                   setoff                                       5556
023700021206     C                   If        dcstat = ' ' or dcstat = 'O'
023800021206     C                   seton                                        55
023900021206     C                   else
024000021206     C                   If        dcstat = 'P'
024100021209     C**************     seton                                        56
024200021206     C                   endif
024300021206     C                   endif
024400021206      *
024500021204     C                   exfmt     detchg
024600010620     C                   IF        *IN03 = *ON
024700010620     C                   MOVE      *ON           *INLR
024800010620     C                   RETURN
024900010620     C                   ENDIF
025000021205      *
025100021205     C                   IF        *IN12 = *ON
025200021205     C                   leave
025300021205     C                   ENDIF
025400021205      *
025500021205     C                   eval      updt = 'N'
025600021210     C                   eval      vrfy = 'N'
025700021205      *
025800040720     C                   If        dgtrst<>dctrst
025900040720     C                   movel     dctrst        dgtrst
026000040720     C                   eval      updt = 'Y'
026100040720     C                   eval      vrfy = 'Y'
026200040720     C                   endif
026300021205      *
026400021205     C                   If        dgsub#<>dcsub#
026500021205     C                   movel     dcsub#        dgsub#
026600021206     C                   eval      updt = 'Y'
026700021210     C                   eval      vrfy = 'Y'
026800021205     C                   endif
026900021205      *
027000021205     C                   If        dgacct<>dcacct
027100021205     C                   movel     dcacct        dgacct
027200021206     C                   eval      updt = 'Y'
027300021210     C                   eval      vrfy = 'Y'
027400021205     C                   endif
027500021205      *
027600021205     C                   If        dgplan<>dcplan
027700021205     C                   movel     dcplan        dgplan
027800021206     C                   eval      updt = 'Y'
027900021210     C                   eval      vrfy = 'Y'
028000021205     C                   endif
028100021205      *
028200021205     C                   If        dgplnc<>dcplnc
028300021205     C                   movel     dcplnc        dgplnc
028400021205     C                   movel     dcplnc        dsplnc
028500021206     C                   eval      updt = 'Y'
028600021205     C                   endif
028700021205      *
028800021205     C                   If        dgstat<>dcstat
028900131231     C                   If        dcstat = 'I' and
029000131231     C                             dcplnc <> 'R'
029100131231     C                   movel(P)  rierr         chgerr
029200040720     C                   iter
029300131231     C                   else
029400131231     C                   movel(P)  *blanks       chgerr
029500131231     C                   endif
029600131231     C                   endif
029700131231      *
029800131231     C                   If        dgstat<>dcstat
029900131231     C                   If        dcstat = 'A' and
030000131231     C                             dggnam = *blanks
030100131231     C                   movel(P)  nonam         chgerr
030200131231     C                   iter
030300131231     C                   endif
030400040720      *
030500021205     C                   movel     dcstat        dgstat
030600021206     C                   eval      updt = 'Y'
030700021205     C                   endif
030800021205      *
030900021205     C                   If        updt = 'Y'
031000021210      *
031100021210     C                   If        vrfy = 'Y'
031200170202      *            See if TSA matches across GroupID
031300170202     C                   eval      terr = 'N'
031400170202     C     dsgrid        setll     del2gxrl3                          59
031500170202     C     *IN59         DOUEQ     *ON
031600170202     C     dsgrid        READe     del2gxrl3                              59
031700170202     C                   IF        *In59 <> *ON and dsgrid = xdggrid
031800170202      *
031900170202     C                   if        xdgtrst <> 0 and xdgtrst <> dctrst and
032000170202     C                             dctrst <> 0
032100170202     C                   eval      terr = 'Y'
032200170202     C                   leave
032300170202     C                   endif
032400170202      *
032500170202     C                   if        xdgsub# <> 0 and xdgsub# <> dcsub# and
032600170202     C                             dcsub# <> 0
032700170202     C                   eval      terr = 'Y'
032800170202     C                   leave
032900170202     C                   endif
033000170202      *
033100170202     C                   if        xdgacct <> 0 and xdgacct <> dcacct and
033200170202     C                             dcacct <> 0
033300170202     C                   eval      terr = 'Y'
033400170202     C                   leave
033500170202     C                   endif
033600170202      *
033700170202     C                   endif
033800170202      *
033900170202     C                   enddo
034000170202      *
034100170202     C                   If        terr = 'Y'
034200170202     C                   movel(P)  tsaer         chgerr
034300170202     C                   iter
034400170202     C                   endif
034500170202      *
034600021210     C                   movel     *blanks       chgerr
034700021210     C     ackey         chain     accmst                             46
034800021210     C                   If        *in46 = '1' or atrmdt <> 0
034900021210     C                   movel(P)  acerr         chgerr
035000021210     C                   iter
035100021205     C                   endif
035200021205      *
035300021210     C     plkey         chain     grate                              47
035400021210     C                   If        *in47 = '1'
035500021210     C                   movel(P)  plerr         chgerr
035600021210     C                   iter
035700021210     C                   endif
035800140909      *
035900140909     C     plkey         chain     plnmst                             47
036000140909     C                   If        *in47 = '1'
036100140909     C                   movel(P)  plerr         chgerr
036200140909     C                   iter
036300140909     C                   else
036400140909      *
036500140909     C     cdkey         chain     codes                              48
036600140909     C                   If        *in48 = '1' or action <> dcplnc
036700140909     C                   movel(P)  pterr         chgerr
036800140909     C                   iter
036900140909     C                   endif
037000140909     C                   endif
037100021210      *
037200021210     C                   endif
037300021210      *
037400021210     C                   movel     usrnam        dgoper
037500021210     C                   movel     *date         dgupdt
037600040629     C                   update    del2gxrr
037700021210      *            Set all other recs w/ same grp#
037800021210     C                   If        vrfy = 'Y'
037900040629     C     dsgrid        setll     del2gxrl                           58
038000021210     C     *IN58         DOUEQ     *ON
038100040629     C     dsgrid        READe     del2gxrl                               58
038200021210     C                   IF        *In58 <> *ON and dgtrst = 0
038300021210      *
038400021210     C                   movel     dctrst        dgtrst
038500021210     C                   movel     dcsub#        dgsub#
038600021210     C                   movel     dcacct        dgacct
038700021210     C                   movel     usrnam        dgoper
038800021210     C                   movel     *date         dgupdt
038900040629     C                   update    del2gxrr
039000021210      *
039100021210     C                   endif
039200021210      *
039300021210     C                   enddo
039400021210      *
039500021210     C                   endif
039600021210     C                   endif
039700021210      *
039800010620     C                   ENDDO
039900010627     C                   movel     '0'           *in12
040000040720      *
040100010620     C                   ENDSR
040200040720      ******************************************************************
040300040720      *       SUBROUTINE - $chgnam                                     *
040400040720      *                    change group name for all group IDs        *
040500040720      ******************************************************************
040600040720     C     $chgnam       BEGSR
040700040720     C                   movel     dsgrid        gngrid
040800040720     C                   movel     dsgnam        gngnam
040900040720      *
041000040720     C     *IN03         DOWEQ     *OFF
041100040720     C     *IN12         ANDEQ     *OFF
041200040720      *
041300040720     C                   exfmt     grpchg
041400040720     C                   IF        *IN03 = *ON
041500040720     C                   MOVE      *ON           *INLR
041600040720     C                   RETURN
041700040720     C                   ENDIF
041800040720      *
041900040720     C                   IF        *IN12 = *ON
042000040720     C                   leave
042100040720     C                   ENDIF
042200040720      *
042300040720     C                   IF        dsgnam <> gngnam
042400040720     C     dsgrid        SETLL     del2gxrl
042500040720     C     *IN68         DOUEQ     *ON
042600040720     C     dsgrid        READe     del2gxrl                               68
042700040720     C                   IF        *In68 <> *ON and dggrid = dsgrid
042800040720      *
042900040720     C                   movel     gngnam        dggnam
043000040720     C                   update    del2gxrr
043100040720      *
043200040720     C                   endif
043300040720      *
043400040720     C                   enddo
043500040720     C                   leave
043600040720      *
043700040720     C                   endif
043800040720      *
043900040720     C                   enddo
044000040720     C                   ENDSR
044100021204      ******************************************************************
044200021204      *       SUBROUTINE - $DISDTL                                     *
044300021204      *             Display record details                             *
044400021204      ******************************************************************
044500021204     C     $disdtl       BEGSR
044600021204     C     *IN03         DOWEQ     *OFF
044700021204     C     *IN12         ANDEQ     *OFF
044800040629     C     xrkey         chain     del2gxrl
044900021206      *
045000021206     C                   setoff                                       5556
045100021206     C                   If        dgstat = ' ' or dgstat = 'O'
045200021206     C                   seton                                        55
045300021206     C                   else
045400021206     C                   If        dgstat = 'P'
045500021206     C                   seton                                        56
045600021206     C                   endif
045700021206     C                   endif
045800021206      *
045900021205     C                   exfmt     detdsp
046000021204     C                   IF        *IN03 = *ON
046100021204     C                   MOVE      *ON           *INLR
046200021204     C                   RETURN
046300021204     C                   ENDIF
046400021204     C                   ENDDO
046500021204     C                   movel     '0'           *in12
046600021204     C                   ENDSR
