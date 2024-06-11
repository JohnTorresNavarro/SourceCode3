000100981030     F*------------------------------------------------------------------------------------------*
000200081205      * FM012R     GROUP BENIFIT SERVICES SOFTWARE           2008                                *
000300981030      *            WRITTEN BY - R.L.J.                                                           *
000400081205      *            DATE - 12/2008                                                                *
000500081205      *  DESCRIPTION - Maintain Trust Onsite Dental Aux file                                     *
000600981030      *  Technical Specs- This program uses a Load All Subfile technique - this should only be   *
000700981030      *            used when the subfile to be loaded is known to be small ( 100 or less ).      *
000800981105      *  Indicator Usage:                                                                        *
000900981030      *            31     Display Subfile                                                        *
001000981030      *            32     Display Subfile Control                                                *
001100981030      *            33     Clear Subfile                                                          *
001200981030      *            34     Subfile End                                                            *
001300981030      *------------------------------------------------------------------------------------------*
001400081205      * Change Log
001500081205      * xxx mm/dd/yyyy
001600000306      *------------------------------------------------------------------------------------------*
001700081205     FTRSMST    IF   E           K DISK
001800100722     FODRGNP    UF A E           K DISK
001900081205     FFM012D    CF   E             WORKSTN
002000981027     F                                     SFILE(DETAIL:RRN)
002100981030      *
002200081205     D @PARM           DS
002300081205     D  TRUST#                 1      3S 0
002400081205    * *
002500081208     D                 DS
002600081208     D mozip                   1      9
002700081208     D  ozip5                  1      5
002800081208     D  ozip4                  6      9
002900090415    * *
003000081208     D                 DS
003100090415     D mdzip                   1     10
003200090415     D  dzip5                  1      5
003300090415     D  dzip                   6      6    INZ('-')
003400090415     D  dzip4                  7     10
003500090415    * *
003600090415     D                 DS
003700081208     D mophon                  1     10
003800081208     D  oph13                  1      3
003900081208     D  oph46                  4      6
004000081208     D  oph710                 7     10
004100081208    * *
004200081208     D                 DS
004300081208     D mdphon                  1     12
004400081208     D  dph13                  1      3
004500081208     D  dph1                   4      4    INZ('-')
004600081208     D  dph46                  5      7
004700081208     D  dph2                   8      8    INZ('-')
004800081208     D  dph710                 9     12
004900100722    * *
005000100722     D                 DS
005100100722     D mofax                   1     10
005200100722     D  ofx13                  1      3
005300100722     D  ofx46                  4      6
005400100722     D  ofx710                 7     10
005500100722    * *
005600100722     D                 DS
005700100722     D mdfax                   1     12
005800100722     D  dfx13                  1      3
005900100722     D  dfx1                   4      4    INZ('-')
006000100722     D  dfx46                  5      7
006100100722     D  dfx2                   8      8    INZ('-')
006200100722     D  dfx710                 9     12
006300081215    * *
006400081215     D                 DS
006500090305     D wkdat8                  1      8  0
006600090305     D  wk8yy                  1      4
006700090305     D  wk8mm                  5      6
006800090305     D  wk8dd                  7      8
006900090305    * *
007000090305     D                 DS
007100090305     D moeff                   1      8  0
007200090305     D  oefyy                  1      4
007300090305     D  oefmm                  5      6
007400090305     D  oefdd                  7      8
007500081215    * *
007600081215     D                 DS
007700081215     D mdeff                   1     10
007800081215     D  defmm                  1      2
007900081215     D  def1                   3      3    INZ('/')
008000081215     D  defdd                  4      5
008100081215     D  def2                   6      6    INZ('/')
008200081215     D  defyy                  7     10
008300081215    * *
008400081215     D                 DS
008500081215     D mdtrm                   1     10
008600081215     D  dtrmm                  1      2
008700081215     D  dtr1                   3      3    INZ('/')
008800081215     D  dtrdd                  4      5
008900081215     D  dtr2                   6      6    INZ('/')
009000081215     D  dtryy                  7     10
009100081215    * *
009200081215     D                 DS
009300081215     D motrm                   1      8  0
009400081219     D  otryy                  1      4
009500081219     D  otrmm                  5      6
009600081219     D  otrdd                  7      8
009700090318    * *
009800090318     D                 DS
009900090318     D ma999           S              3  0 INZ(999)
010000081219    * *
0101000812190053 D                 DS
0102000903050054 D  inveffd        C                   'Invalid Effective Date             '
0103000903050054 D  invtrmd        C                   'Invalid Term Date                  '
0104000903050054 D  invzip5        C                   'Invalid Zip5 - must be 5 numerics  '
0105000903050054 D  invzip4        C                   'Inv Zip4 - must be 4 num or blank'
0106000903050054 D  invphn         C                   'Invalid Phone# - 10 num or blank'
0107001007220054 D  invfax         C                   'Invalid Fax# - 10 num or blank'
0108000903050054 D  invofc         C                   'Invalid office number              '
0109000812190054 D  dupkey         C                   'Trust#/Office# already exists      '
011000081208    * *
011100081208     D USCLAS          S             10
011200081205    * *
011300081205     C     *ENTRY        PLIST
011400081205     C                   PARM                    @PARM
011500081205    * *
011600081208      *
011700081208     C     mcdkey        klist
011800081208     C                   kfld                    dstrst
011900081208     C                   kfld                    dsofc#
012000081208      *
012100081208     C     mcakey        klist
012200081208     C                   kfld                    trust#
012300081208     C                   kfld                    maofc#
012400090318      *
012500090318     C     mcnext        klist
012600090318     C                   kfld                    trust#
012700090318     C                   kfld                    ma999
012800991116      *
012900981030      *    MAINLINE
013000081205     C     *IN01         DOWEQ     *OFF
013100081215     C***  *IN07         ANDEQ     *OFF
013200081205      *
013300981102     C                   EXSR      $CLEAR
013400081229     C                   EXSR      $LOAD
013500081229     C                   EXSR      $DISPLAY
013600081229      *    PROCESS SELECTION
013700081229     C     *IN01         IFEQ      *OFF
013800081229     C***  *IN07         ANDEQ     *OFF
013900081229     C***  RRN           ANDNE     *ZERO
014000081229     C                   EXSR      $PROCES
014100081229     C                   ENDIF
014200081229     C                   ENDDO
014300081229     C                   MOVE      *ON           *INLR
014400081229     C                   RETURN
014500981030      ******************************************************************
014600081208      *       SUBROUTINE - *INZSR                                      *
014700081229      *                    FIRST PASS LOGIC                            *
014800981030      ******************************************************************
014900081208     C***  *INZSR        BEGSR
015000081229     C*                  MOVEA     '0100'        *IN(31)
015100081208     C*                  WRITE     TRAILER
015200081208     C*                  EXFMT     HEADER
015300081208     C*****              ENDSR
015400981030      ******************************************************************
015500981109      *       SUBROUTINE - $CLEAR                                      *
015600981030      *                    CLEAR SUBF AND RRN                          *
015700981030      ******************************************************************
015800981102     C     $CLEAR        BEGSR
015900981027     C                   MOVEA     '001'         *IN(31)
016000981027     C                   WRITE     HEADER
016100981027     C                   Z-ADD     *ZERO         RRN               3 0
016200981027     C                   WRITE     HEADER
016300981027     C                   MOVEA     '010'         *IN(31)
016400981027     C                   ENDSR
016500981030      ******************************************************************
016600981109      *       SUBROUTINE - $LOAD                                       *
016700081205      *                    LOAD SUBFILE W/ Trust and Office Info       *
016800981030      ******************************************************************
016900981109     C     $LOAD         BEGSR
017000100722     C     TRUST#        SETLL     ODRGNP
017100090109     C                   SETOFF                                       3495
017200090109     C     *IN34         DOUEQ     *ON
017300090109     C     *IN95         OREQ      *ON
017400100722     C                   READ      ODRGNP                                 34
017500090109     C                   IF        (*In34 <> *ON)
017600090109      *
017700090109     C                   IF        motrst <> trust#
017800081208     C                   leave
017900081208     C                   endif
018000081208      *
018100081208     C                   ADD       1             RRN
018200081208     C                   MOVEL     MOTRST        DSTRST
018300081205     C                   MOVEL     MOOFC#        DSOFC#
018400081205     C                   MOVEL     MOOLOC        DSOLOC
018500081208     C                   WRITE     DETAIL
018600081208     C                   ENDIF
018700081208      *
018800081208     C                   ENDDO
018900081208     C                   ENDSR
019000981030      ******************************************************************
019100981109      *       SUBROUTINE - $DISPLAY                                    *
019200081223      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
019300981030      ******************************************************************
019400081223     C     $DISPLAY      BEGSR
019500081223     C                   If        RRN <> *Zero
019600081223     C                   MOVE      *ON           *IN31
019700081223     C                   ENDIF
019800081223     C                   WRITE     TRAILER
019900081223     C                   EXFMT     HEADER
020000981027     C                   ENDSR
020100981030      ******************************************************************
020200981109      *       SUBROUTINE - $PROCES                                     *
020300981030      *                    PROCESS THE SELECTION                       *
020400981030      ******************************************************************
020500981109     C     $PROCES       BEGSR
020600081208     C     *IN95         DOUEQ     *ON
020700081208      *      Add new record
020800081208     C                   IF        *in10 = *ON
020900081208     C                   exsr      adddtl
021000081208     C                   eval      *in10 = *OFF
021100090512     C                   leavesr
021200081208     C                   endif
021300081208      *
021400081208     C                   READC     DETAIL                                 95
021500081208     C                   IF        *IN95 = *OFF
021600081208      *      Display detail
021700081208     C                   IF        SELECT = '5'
021800081208     C                   exsr      disdtl
021900081205     C                   else
022000081205      *      Display detail
022100081208     C                   IF        SELECT = '2'
022200081208     C                   exsr      chgdtl
022300081208     C                   endif
022400081208     C                   endif
022500081208      *
022600981027     C                   CLEAR                   SELECT
022700981027     C                   UPDATE    DETAIL
022800981027     C                   ENDIF
022900981027     C                   ENDDO
023000981027     C                   ENDSR
023100081208      ******************************************************************
023200081208      *       SUBROUTINE - DISDTL                                      *
023300081208      *                    Dispaly Office Detail                       *
023400081208      ******************************************************************
023500081208     C     disdtl        BEGSR
023600081208     C     *IN01         DOWEQ     *OFF
023700081215     C**** *IN07         ANDEQ     *OFF
023800081208     C     trust#        chain     trsmst
023900100722     C     mcdkey        chain     ODRGNP
024000081208     C                   movel     moofc#        mdofc#
024100081208     C                   eval      mdoloc = mooloc
024200081208     C                   eval      mdadd1 = moadd1
024300081208     C                   eval      mdadd2 = moadd2
024400081208     C                   eval      mdcity = mocity
024500081208     C                   eval      mdst = most
024600081208      *
024700081208     C                   eval      mdcntc = mocntc
024800081208     C                   eval      mdemal = moemal
024900081208      *
025000081208     C                   movel     ozip5         dzip5
025100081208     C                   movel     ozip4         dzip4
025200081208      *
025300081208     C                   movel     oph13         dph13
025400081208     C                   movel     oph46         dph46
025500081208     C                   movel     oph710        dph710
025600100722      *
025700100722     C                   movel     ofx13         dfx13
025800100722     C                   movel     ofx46         dfx46
025900100722     C                   movel     ofx710        dfx710
026000081215      *
026100081215     C                   movel     oefmm         defmm
026200081215     C                   movel     oefdd         defdd
026300081215     C                   movel     oefyy         defyy
026400081208      *
026500081215     C                   movel     otrmm         dtrmm
026600081215     C                   movel     otrdd         dtrdd
026700081215     C                   movel     otryy         dtryy
026800081208      *
026900081208     C                   exfmt     disp01
027000081208      *
027100081215     C****               IF        *IN07 = *ON or *IN01 = *ON
027200081215     C**                 MOVE      *ON           *INLR
027300081215     C**                 return
027400081215     C****               endif
027500081215      *
027600081215     C                   IF        *IN01 = *ON
027700081215     C                   MOVE      *Off          *IN01
027800081215     C                   leavesr
027900081215     C                   endif
028000081208      *
028100081208     C                   ENDDO
028200081208      *
028300081208     C                   movel     '0'           *in12
028400081208     C                   ENDSR
028500081208      ******************************************************************
028600081208      *       SUBROUTINE - ADDDTL                                      *
028700081208      *                    Add a new Dental Location Rec               *
028800081208      ******************************************************************
028900081208     C     adddtl        BEGSR
029000090305      *
029100090305     C                   eval      smsg = *blanks
029200090305     C                   eval      *in61 = *off
029300090305      *
029400081208     C     *IN01         DOWEQ     *OFF
029500081215     C**** *IN07         ANDEQ     *OFF
029600081208     C     trust#        chain     trsmst
029700081208      *
029800090305     C                   if        smsg = *blanks
029900090305      *
030000100722     C     mcnext        setgt     ODRGNP
030100100722     C                   readp     ODRGNP                                 23
030200090512     C                   if        *IN23 = *ON or
030300090512     C                             trust# <> motrst
030400090318     C                   eval      maofc# = 1
030500090318     C                   else
030600090318     C                   eval      maofc# = moofc# + 1
030700090318     C                   endif
030800090318      *
030900090305     C                   eval      maoloc = *blanks
031000090305     C                   eval      maadd1 = *blanks
031100090305     C                   eval      maadd2 = *blanks
031200090305     C                   eval      macity = *blanks
031300090305     C                   eval      mast = *blanks
031400090305     C                   eval      azip5 = *blanks
031500090305     C                   eval      azip4 = *blanks
031600090305     C                   eval      aph13 = *blanks
031700090305     C                   eval      aph46 = *blanks
031800090305     C                   eval      aph710 = *blanks
031900100722     C                   eval      afx13 = *blanks
032000100722     C                   eval      afx46 = *blanks
032100100722     C                   eval      afx710 = *blanks
032200090305     C                   eval      macntc = *blanks
032300090305     C                   eval      maemal = *blanks
032400090305     C                   eval      aefyy = *blanks
032500090305     C                   eval      aefmm = *blanks
032600090305     C                   eval      aefdd = *blanks
032700090305     C                   eval      atryy = *blanks
032800090305     C                   eval      atrmm = *blanks
032900090305     C                   eval      atrdd = *blanks
033000090305      *
033100090305     C                   endif
033200090305      *
033300090305     C                   exfmt     add01
033400081208      *
033500081208     C                   IF        *IN01 = *ON
033600081215     C                   MOVE      *Off          *IN01
033700081208     C                   leavesr
033800081208     C                   endif
033900081208      *           If F5 => Add new rec - edit Fields
034000090312      *               Allow Enter key to mimick F5
034100090312     C*******            IF        *IN05 = *ON
034200090305      *
034300090305     C                   if        maofc# = 0
034400090305     C                   eval      smsg = invofc
034500090305     C                   eval      *in61 = *on
034600090305     C                   iter
034700090305     C                   endif
034800090305      *
034900100722     C     mcakey        chain     ODRGNP                             21
035000090305     C                   IF        *IN21 = *Off
035100090305     C                   eval      smsg = dupkey
035200090305     C                   eval      *in61 = *on
035300090305     C                   iter
035400090305     C                   endif
035500090305      *
035600090305     C                   eval      smsg = *blanks
035700090305     C                   eval      *in61 = *off
035800090305      *
035900090305     C                   testn                   azip5                21
036000090305     C                   if        *in21 = *OFF
036100090305     C                   eval      smsg = invzip5
036200090305     C                   eval      *in61 = *on
036300090305     C                   iter
036400090305     C                   endif
036500090305      *
036600090305     C                   testn                   azip4                21
036700090305     C                   if        *in21 = *OFF and azip4 <> *blanks
036800090305     C                   eval      smsg = invzip4
036900090305     C                   eval      *in61 = *on
037000090305     C                   iter
037100090305     C                   endif
037200090305      *
037300090305     C                   if        aph13 <> *blanks or
037400090305     C                             aph46 <> *blanks or
037500090305     C                             aph710 <> *blanks
037600090305     C                   testn                   aph13                21
037700090305     C                   testn                   aph46                22
037800090305     C                   testn                   aph710               23
037900090305     C                   if        *IN21 = *OFF or *in22 = *OFF or
038000090305     C                             *IN23 = *OFF
038100090305     C                   eval      smsg = invphn
038200090305     C                   eval      *in61 = *on
038300090305     C                   iter
038400090312     C                   endif
038500090312     C                   endif
038600100722      *
038700100722     C                   if        afx13 <> *blanks or
038800100722     C                             afx46 <> *blanks or
038900100722     C                             afx710 <> *blanks
039000100722     C                   testn                   afx13                21
039100100722     C                   testn                   afx46                22
039200100722     C                   testn                   afx710               23
039300100722     C                   if        *IN21 = *OFF or *in22 = *OFF or
039400100722     C                             *IN23 = *OFF
039500100722     C                   eval      smsg = invfax
039600100722     C                   eval      *in61 = *on
039700100722     C                   iter
039800100722     C                   endif
039900100722     C                   endif
040000090312      *
040100090306     C                   If        aefyy = '    '
040200090305     C                   movel     0000          oefyy
040300090305     C                   else
040400090305     C                   movel     aefyy         oefyy
040500090305     C                   endif
040600090305     C                   If        aefmm = '  '
040700090305     C                   movel     00            oefmm
040800090305     C                   else
040900090305     C                   movel     aefmm         oefmm
041000090305     C                   endif
041100090305     C                   If        aefdd = '  '
041200090305     C                   movel     00            oefdd
041300090305     C                   else
041400090305     C                   movel     aefdd         oefdd
041500090305     C                   endif
041600090305      *
041700090305     C                   test(D)                 moeff                  21
041800090305     C                   if        *in21 = *ON
041900090305     C                   eval      smsg = inveffd
042000090305     C                   eval      *in61 = *on
042100090305     C                   iter
042200090305     C                   endif
042300090305      *
042400090306     C                   If        atryy = '    '
042500090305     C                   movel     0000          otryy
042600090305     C                   else
042700090305     C                   movel     atryy         otryy
042800090306     C                   endif
042900090305     C                   If        atrmm = '  '
043000090305     C                   movel     00            otrmm
043100090305     C                   else
043200090305     C                   movel     atrmm         otrmm
043300090305     C                   endif
043400090305     C                   If        atrdd = '  '
043500090305     C                   movel     00            otrdd
043600090305     C                   else
043700090305     C                   movel     atrdd         otrdd
043800090305     C                   endif
043900090305      *
044000090305     C                   If        motrm <> 0
044100090305     C                   test(D)                 motrm                  21
044200090305     C                   if        *in21 = *ON
044300090305     C                   eval      smsg = invtrmd
044400090305     C                   eval      *in61 = *on
044500090305     C                   iter
044600090305     C                   endif
044700090305     C                   endif
044800090305      *
044900081208      *  Add record
045000081208     C                   eval      motrst = trust#
045100081208     C                   eval      moofc# = maofc#
045200081208     C                   eval      mooloc = maoloc
045300081208     C                   eval      moadd1 = maadd1
045400081208     C                   eval      moadd2 = maadd2
045500081208     C                   eval      mocity = macity
045600081215     C                   eval      most = mast
045700081215     C                   movel     azip5         mozip
045800081215     C                   move      azip4         mozip
045900081215     C                   eval      oph13 = aph13
046000081215     C                   eval      oph46 = aph46
046100081215     C                   eval      oph710 = aph710
046200100722     C                   eval      ofx13 = afx13
046300100722     C                   eval      ofx46 = afx46
046400100722     C                   eval      ofx710 = afx710
046500081208     C                   eval      mocntc = macntc
046600081208     C                   eval      moemal = maemal
046700081208      *
046800100722     C                   write     ODRGNR
046900081208      *
047000081208     C                   MOVE      *OFF          *IN05
047100090312     C***                endif
047200081208      *
047300081208     C                   ENDDO
047400081208      *
047500081208     C                   ENDSR
047600081208      ******************************************************************
047700081208      *       SUBROUTINE - CHGDTL                                      *
047800081208      *                    Change Office Detail                       *
047900081208      ******************************************************************
048000081208     C     chgdtl        BEGSR
048100090305      *
048200090305     C                   eval      smsg = *blanks
048300090305     C                   eval      *in61 = *off
048400090305      *
048500081208     C     *IN01         DOWEQ     *OFF
048600090305      *
048700090305     C                   if        smsg = *blanks
048800090305      *
048900081208     C     trust#        chain     trsmst
049000100722     C     mcdkey        chain     ODRGNP
049100081208     C                   movel     moofc#        mcofc#
049200081208     C                   eval      mcoloc = mooloc
049300081208     C                   eval      mcadd1 = moadd1
049400081208     C                   eval      mcadd2 = moadd2
049500081208     C                   eval      mccity = mocity
049600081208     C                   eval      mcst = most
049700081208      *
049800081208     C                   eval      mccntc = mocntc
049900081208     C                   eval      mcemal = moemal
050000081208      *
050100081208     C                   movel     ozip5         czip5
050200081208     C                   movel     ozip4         czip4
050300081208      *
050400081208     C                   movel     oph13         cph13
050500081208     C                   movel     oph46         cph46
050600081208     C                   movel     oph710        cph710
050700100722      *
050800100722     C                   movel     ofx13         cfx13
050900100722     C                   movel     ofx46         cfx46
051000100722     C                   movel     ofx710        cfx710
051100081208      *
051200081215     C                   movel     oefmm         cefmm
051300081215     C                   movel     oefdd         cefdd
051400081215     C                   movel     oefyy         cefyy
051500081215      *
051600081215     C                   movel     otrmm         ctrmm
051700081215     C                   movel     otrdd         ctrdd
051800081215     C                   movel     otryy         ctryy
051900081208      *
052000090305     C                   endif
052100090305      *
052200090305     C                   exfmt     chg01
052300081208      *
052400081215     C*****              IF        *IN07 = *ON or *IN01 = *ON
052500081215     C**                 MOVE      *ON           *INLR
052600081215     C**                 return
052700081215     C****               endif
052800081215      *
052900081215     C                   IF        *IN01 = *ON
053000081215     C                   MOVE      *Off          *IN01
053100081215     C                   leavesr
053200081215     C                   endif
053300081208      *           If F5 => Change rec - edit Fields
053400081208      *
053500090305     C                   IF        *IN05 = *ON
053600090305      *
053700090305     C                   eval      smsg = *blanks
053800090305     C                   eval      *in61 = *off
053900090305      *
054000090305     C                   testn                   czip5                21
054100090305     C                   if        *in21 = *OFF
054200090305     C                   eval      smsg = invzip5
054300090305     C                   eval      *in61 = *on
054400090305     C                   iter
054500090305     C                   endif
054600090305      *
054700090305     C                   testn                   czip4                21
054800090305     C                   if        *in21 = *OFF and czip4 <> *blanks
054900090305     C                   eval      smsg = invzip4
055000090305     C                   eval      *in61 = *on
055100090305     C                   iter
055200090305     C                   endif
055300090305      *
055400090305     C                   if        cph13 <> *blanks or
055500090305     C                             cph46 <> *blanks or
055600090305     C                             cph710 <> *blanks
055700090305     C                   testn                   cph13                21
055800090305     C                   testn                   cph46                22
055900090305     C                   testn                   cph710               23
056000090305     C                   if        *IN21 = *OFF or *in22 = *OFF or
056100090305     C                             *IN23 = *OFF
056200090305     C                   eval      smsg = invphn
056300090305     C                   eval      *in61 = *on
056400090305     C                   iter
056500090305     C                   endif
056600090305     C                   endif
056700100722      *
056800100722     C                   if        cfx13 <> *blanks or
056900100722     C                             cfx46 <> *blanks or
057000100722     C                             cfx710 <> *blanks
057100100722     C                   testn                   cfx13                21
057200100722     C                   testn                   cfx46                22
057300100722     C                   testn                   cfx710               23
057400100722     C                   if        *IN21 = *OFF or *in22 = *OFF or
057500100722     C                             *IN23 = *OFF
057600100722     C                   eval      smsg = invfax
057700100722     C                   eval      *in61 = *on
057800100722     C                   iter
057900100722     C                   endif
058000100722     C                   endif
058100090305      *
058200090305     C                   If        cefyy = '    '
058300090305     C                   movel     0000          oefyy
058400090305     C                   else
058500090305     C                   movel     cefyy         oefyy
058600090305     C                   endif
058700090305     C                   If        cefmm = '  '
058800090305     C                   movel     00            oefmm
058900090305     C                   else
059000090305     C                   movel     cefmm         oefmm
059100090305     C                   endif
059200090305     C                   If        cefdd = '  '
059300090305     C                   movel     00            oefdd
059400090305     C                   else
059500090305     C                   movel     cefdd         oefdd
059600090305     C                   endif
059700090305      *
059800090305     C                   test(D)                 moeff                  21
059900090305     C                   if        *in21 = *ON
060000090305     C                   eval      smsg = inveffd
060100090305     C                   eval      *in61 = *on
060200090305     C                   iter
060300090305     C                   endif
060400090305      *
060500090305     C                   If        ctryy = '    '
060600090305     C                   movel     0000          otryy
060700090305     C                   else
060800090305     C                   movel     ctryy         otryy
060900090305     C                   endif
061000090305     C                   If        ctrmm = '  '
061100090305     C                   movel     00            otrmm
061200090305     C                   else
061300090305     C                   movel     ctrmm         otrmm
061400090305     C                   endif
061500090305     C                   If        ctrdd = '  '
061600090305     C                   movel     00            otrdd
061700090305     C                   else
061800090305     C                   movel     ctrdd         otrdd
061900090305     C                   endif
062000090305      *
062100090305     C                   If        motrm <> 0
062200090305     C                   test(D)                 motrm                  21
062300090305     C                   if        *in21 = *ON
062400090305     C                   eval      smsg = invtrmd
062500090305     C                   eval      *in61 = *on
062600090305     C                   iter
062700090305     C                   endif
062800090305     C                   endif
062900090305      *
063000090305      *      Update Changed Record
063100081208     C                   eval      mooloc = mcoloc
063200081208     C                   eval      moadd1 = mcadd1
063300081208     C                   eval      moadd2 = mcadd2
063400081208     C                   eval      mocity = mccity
063500081215     C                   eval      most = mcst
063600081208     C                   eval      ozip5 = czip5
063700081208     C                   eval      ozip4 = czip4
063800081208     C                   eval      oph13 = cph13
063900081208     C                   eval      oph46 = cph46
064000081208     C                   eval      oph710 = cph710
064100100722     C                   eval      ofx13 = cfx13
064200100722     C                   eval      ofx46 = cfx46
064300100722     C                   eval      ofx710 = cfx710
064400081208     C                   eval      mocntc = mccntc
064500081208     C                   eval      moemal = mcemal
064600081208      *
064700100722     C                   update    ODRGNR
064800081208      *
064900081208     C                   MOVE      *OFF          *IN05
065000081208     C                   endif
065100081208      *
065200081208     C                   ENDDO
065300081208      *
065400081208     C                   movel     '0'           *in12
065500081208     C                   ENDSR
065600081208      ******************************************************************
