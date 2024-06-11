000100981030     F*------------------------------------------------------------------------------------------*
000200090421      * FM013R     GROUP BENIFIT SERVICES SOFTWARE           2009                                *
000300981030      *            WRITTEN BY - R.L.J.                                                           *
000400090421      *            DATE - 04/2009                                                                *
000500090421      *  DESCRIPTION - Maintain Trust Onsite Dental Monthly Premium File                         *
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
001800090421     FODMNPP    UF A E           K DISK
001900090421     FFM013D    CF   E             WORKSTN
002000981027     F                                     SFILE(DETAIL:RRN)
002100981030      *
002200081205     D @PARM           DS
002300081205     D  TRUST#                 1      3S 0
002400081215    * *
002500081215     D                 DS
002600090421     D wkmdy8                  1      8  0
002700090421     D  wk8mm                  1      2
002800090421     D  wk8dd                  3      4
002900090421     D  wk8yy                  5      8
003000090305    * *
003100090305     D                 DS
003200090421     D mpeff                   1      8  0
003300090421     D  mefyy                  1      4
003400090421     D  mefmm                  5      6
003500090421     D  mefdd                  7      8
003600081215    * *
003700081215     D                 DS
003800090421     D dpeff                   1     10
003900081215     D  defmm                  1      2
004000081215     D  def1                   3      3    INZ('/')
004100081215     D  defdd                  4      5
004200081215     D  def2                   6      6    INZ('/')
004300081215     D  defyy                  7     10
004400081215    * *
004500081215     D                 DS
004600090421     D dptrm                   1     10
004700081215     D  dtrmm                  1      2
004800081215     D  dtr1                   3      3    INZ('/')
004900081215     D  dtrdd                  4      5
005000081215     D  dtr2                   6      6    INZ('/')
005100081215     D  dtryy                  7     10
005200081215    * *
005300081215     D                 DS
005400090421     D mptrm                   1      8  0
005500090421     D  mtryy                  1      4
005600090421     D  mtrmm                  5      6
005700090421     D  mtrdd                  7      8
005800090318    * *
005900090318     D                 DS
006000090318     D ma999           S              3  0 INZ(999)
006100090423     D clearadd        S              1
006200081219    * *
0063000812190053 D                 DS
0064000903050054 D  inveffd        C                   'Invalid Effective Date             '
0065000903050054 D  invtrmd        C                   'Invalid Term Date                  '
0066000904230054 D  recadd         C                   'Record has been added              '
0067000904230054 D  recchg         C                   'Record has been changed            '
006800081208    * *
006900081208     D USCLAS          S             10
007000090421      *
007100090421     C     dpckey        klist
007200090421     C                   kfld                    dptrst
007300090421     C                   kfld                    dpneff
007400081205    * *
007500081205     C     *ENTRY        PLIST
007600081205     C                   PARM                    @PARM
007700081205    * *
007800090318      *
007900981030      *    MAINLINE
008000081205     C     *IN01         DOWEQ     *OFF
008100081215     C***  *IN07         ANDEQ     *OFF
008200081205      *
008300981102     C                   EXSR      $CLEAR
008400081229     C                   EXSR      $LOAD
008500081229     C                   EXSR      $DISPLAY
008600081229      *    PROCESS SELECTION
008700081229     C     *IN01         IFEQ      *OFF
008800081229     C***  *IN07         ANDEQ     *OFF
008900081229     C***  RRN           ANDNE     *ZERO
009000081229     C                   EXSR      $PROCES
009100081229     C                   ENDIF
009200081229     C                   ENDDO
009300081229     C                   MOVE      *ON           *INLR
009400081229     C                   RETURN
009500981030      ******************************************************************
009600081208      *       SUBROUTINE - *INZSR                                      *
009700081229      *                    FIRST PASS LOGIC                            *
009800981030      ******************************************************************
009900081208     C***  *INZSR        BEGSR
010000081229     C*                  MOVEA     '0100'        *IN(31)
010100081208     C*                  WRITE     TRAILER
010200081208     C*                  EXFMT     HEADER
010300081208     C*****              ENDSR
010400981030      ******************************************************************
010500981109      *       SUBROUTINE - $CLEAR                                      *
010600981030      *                    CLEAR SUBF AND RRN                          *
010700981030      ******************************************************************
010800981102     C     $CLEAR        BEGSR
010900981027     C                   MOVEA     '001'         *IN(31)
011000981027     C                   WRITE     HEADER
011100981027     C                   Z-ADD     *ZERO         RRN               3 0
011200981027     C                   WRITE     HEADER
011300981027     C                   MOVEA     '010'         *IN(31)
011400981027     C                   ENDSR
011500981030      ******************************************************************
011600981109      *       SUBROUTINE - $LOAD                                       *
011700090421      *                    LOAD SUBFILE W/ Trust and Premium Info      *
011800981030      ******************************************************************
011900981109     C     $LOAD         BEGSR
012000090421     C     TRUST#        SETLL     ODMNPP
012100090109     C                   SETOFF                                       3495
012200090109     C     *IN34         DOUEQ     *ON
012300090109     C     *IN95         OREQ      *ON
012400090421     C                   READ      ODMNPP                                 34
012500090109     C                   IF        (*In34 <> *ON)
012600090109      *
012700090421     C                   IF        mptrst <> trust#
012800081208     C                   leave
012900081208     C                   endif
013000081208      *
013100081208     C                   ADD       1             RRN
013200090421     C                   MOVEL     MPTRST        DPTRST
013300090421      *
013400090421     C                   eval      wk8mm = mefmm
013500090421     C                   eval      wk8dd = mefdd
013600090421     C                   eval      wk8yy = mefyy
013700090421     C                   eval      dpeff = %EDITW(wkmdy8:'0 /  /    ')
013800090421      *
013900090421     C                   eval      wk8mm = mtrmm
014000090421     C                   eval      wk8dd = mtrdd
014100090421     C                   eval      wk8yy = mtryy
014200090421     C                   eval      dptrm = %EDITW(wkmdy8:'0 /  /    ')
014300090421      *
014400090421     C                   eval      dpprem = %EDITC(mpprem:'N')
014500090421      *
014600090421     C                   eval      dpneff = mpeff
014700081208     C                   WRITE     DETAIL
014800081208     C                   ENDIF
014900081208      *
015000081208     C                   ENDDO
015100081208     C                   ENDSR
015200981030      ******************************************************************
015300981109      *       SUBROUTINE - $DISPLAY                                    *
015400081223      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
015500981030      ******************************************************************
015600081223     C     $DISPLAY      BEGSR
015700081223     C                   If        RRN <> *Zero
015800081223     C                   MOVE      *ON           *IN31
015900081223     C                   ENDIF
016000081223     C                   WRITE     TRAILER
016100081223     C                   EXFMT     HEADER
016200981027     C                   ENDSR
016300981030      ******************************************************************
016400981109      *       SUBROUTINE - $PROCES                                     *
016500981030      *                    PROCESS THE SELECTION                       *
016600981030      ******************************************************************
016700981109     C     $PROCES       BEGSR
016800081208     C     *IN95         DOUEQ     *ON
016900081208      *      Add new record
017000081208     C                   IF        *in10 = *ON
017100081208     C                   exsr      adddtl
017200081208     C                   eval      *in10 = *OFF
017300090421     C                   leavesr
017400081208     C                   endif
017500081208      *
017600081208     C                   READC     DETAIL                                 95
017700081205      *      Display detail
017800081208     C                   IF        SELECT = '2'
017900081208     C                   exsr      chgdtl
018000090421     C                   leavesr
018100081208     C                   endif
018200081208      *
018300981027     C                   CLEAR                   SELECT
018400981027     C                   UPDATE    DETAIL
018500981027     C                   ENDDO
018600981027     C                   ENDSR
018700081208      ******************************************************************
018800081208      *       SUBROUTINE - ADDDTL                                      *
018900081208      *                    Add a new Dental Location Rec               *
019000081208      ******************************************************************
019100081208     C     adddtl        BEGSR
019200090305      *
019300090421     C                   eval      smsg = *blanks
019400090421     C                   eval      *in61 = *off
019500090423     C                   eval      clearadd = 'Y'
019600090421      *
019700090421     C     *IN01         DOWEQ     *OFF
019800090421     C**** *IN07         ANDEQ     *OFF
019900090421     C     trust#        chain     trsmst
020000090421      *
020100090423     C                   if        clearadd = 'Y'
020200090421      *
020300090421     C                   eval      aefyy = *blanks
020400090421     C                   eval      aefmm = *blanks
020500090421     C                   eval      aefdd = *blanks
020600090421     C                   eval      atryy = *blanks
020700090421     C                   eval      atrmm = *blanks
020800090421     C                   eval      atrdd = *blanks
020900090421     C                   eval      aprem = 0
021000090423      *
021100090423     C                   eval      clearadd = 'N'
021200090421      *
021300090421     C                   endif
021400090421      *
021500090421     C                   exfmt     add01
021600090421      *
021700090421     C                   IF        *IN01 = *ON
021800090423     C                   eval      smsg = *blanks
021900090421     C                   MOVE      *Off          *IN01
022000090421     C                   leavesr
022100090421     C                   endif
022200090421      *           If F5 => Add new rec - edit Fields
022300090421      *               Allow Enter key to mimick F5
022400090421     C*******            IF        *IN05 = *ON
022500090421      *
022600090421     C                   eval      smsg = *blanks
022700090421     C                   eval      *in61 = *off
022800090421      *
022900090421     C                   If        aefyy = '    '
023000090421     C                   movel     0000          mefyy
023100090421     C                   else
023200090421     C                   movel     aefyy         mefyy
023300090421     C                   endif
023400090421     C                   If        aefmm = '  '
023500090421     C                   movel     00            mefmm
023600090421     C                   else
023700090421     C                   movel     aefmm         mefmm
023800090421     C                   endif
023900090421     C                   If        aefdd = '  '
024000090421     C                   movel     00            mefdd
024100090421     C                   else
024200090421     C                   movel     aefdd         mefdd
024300090421     C                   endif
024400090421      *
024500090421     C                   test(D)                 mpeff                  21
024600090421     C                   if        *in21 = *ON
024700090421     C                   eval      smsg = inveffd
024800090421     C                   eval      *in61 = *on
024900090421     C                   iter
025000090421     C                   endif
025100090421      *
025200090421     C                   If        atryy = '    '
025300090421     C                   movel     0000          mtryy
025400090421     C                   else
025500090421     C                   movel     atryy         mtryy
025600090421     C                   endif
025700090421     C                   If        atrmm = '  '
025800090421     C                   movel     00            mtrmm
025900090421     C                   else
026000090421     C                   movel     atrmm         mtrmm
026100090421     C                   endif
026200090421     C                   If        atrdd = '  '
026300090421     C                   movel     00            mtrdd
026400090421     C                   else
026500090421     C                   movel     atrdd         mtrdd
026600090421     C                   endif
026700090421      *
026800090421     C                   If        mptrm <> 0
026900090421     C                   test(D)                 mptrm                  21
027000090421     C                   if        *in21 = *ON
027100090421     C                   eval      smsg = invtrmd
027200090421     C                   eval      *in61 = *on
027300090421     C                   iter
027400090421     C                   endif
027500090421     C                   endif
027600090421      *
027700090421      *  Add record
027800090421     C                   eval      mptrst = trust#
027900090421     C                   eval      mpprem = aprem
028000090421      *
028100090421     C                   write     ODMNPR
028200090423     C                   eval      smsg = recadd
028300090423     C                   eval      *in61 = *on
028400090423     C                   eval      clearadd = 'Y'
028500090421      *
028600090421     C                   MOVE      *OFF          *IN05
028700090421     C***                endif
028800090421      *
028900090421     C                   ENDDO
029000090421      *
029100081208      *
029200081208     C                   ENDSR
029300081208      ******************************************************************
029400081208      *       SUBROUTINE - CHGDTL                                      *
029500081208      *                    Change Office Detail                       *
029600081208      ******************************************************************
029700081208     C     chgdtl        BEGSR
029800090305      *
029900090421     C                   eval      smsg = *blanks
030000090421     C                   eval      *in61 = *off
030100090421      *
030200090421     C     *IN01         DOWEQ     *OFF
030300090421      *
030400090421     C                   if        smsg = *blanks
030500090421      *
030600090421     C     trust#        chain     trsmst
030700090421     C     dpckey        chain     ODMNPP
030800090421      *
030900090421     C                   movel     mefmm         cefmm
031000090421     C                   movel     mefdd         cefdd
031100090421     C                   movel     mefyy         cefyy
031200090421      *
031300090421     C                   movel     mtrmm         ctrmm
031400090421     C                   movel     mtrdd         ctrdd
031500090421     C                   movel     mtryy         ctryy
031600090421      *
031700090421     C                   eval      cprem = mpprem
031800090421      *
031900090421     C                   endif
032000090421      *
032100090421     C                   exfmt     chg01
032200090421      *
032300090421     C*****              IF        *IN07 = *ON or *IN01 = *ON
032400090421     C**                 MOVE      *ON           *INLR
032500090421     C**                 return
032600090421     C****               endif
032700090421      *
032800090421     C                   IF        *IN01 = *ON
032900090423     C                   eval      smsg = *blanks
033000090421     C                   MOVE      *Off          *IN01
033100090421     C                   leavesr
033200090421     C                   endif
033300090421      *           If F5 => Change rec - edit Fields
033400090421      *             F5 or Enter key allows change to record
033500090421     C******             IF        *IN05 = *ON
033600090421      *
033700090421     C                   eval      smsg = *blanks
033800090421     C                   eval      *in61 = *off
033900090421      *
034000090421     C                   If        cefyy = '    '
034100090421     C                   movel     0000          mefyy
034200090421     C                   else
034300090421     C                   movel     cefyy         mefyy
034400090421     C                   endif
034500090421     C                   If        cefmm = '  '
034600090421     C                   movel     00            mefmm
034700090421     C                   else
034800090421     C                   movel     cefmm         mefmm
034900090421     C                   endif
035000090421     C                   If        cefdd = '  '
035100090421     C                   movel     00            mefdd
035200090421     C                   else
035300090421     C                   movel     cefdd         mefdd
035400090421     C                   endif
035500090421      *
035600090421     C                   test(D)                 mpeff                  21
035700090421     C                   if        *in21 = *ON
035800090421     C                   eval      smsg = inveffd
035900090421     C                   eval      *in61 = *on
036000090421     C                   iter
036100090421     C                   endif
036200090421      *
036300090421     C                   If        ctryy = '    '
036400090421     C                   movel     0000          mtryy
036500090421     C                   else
036600090421     C                   movel     ctryy         mtryy
036700090421     C                   endif
036800090421     C                   If        ctrmm = '  '
036900090421     C                   movel     00            mtrmm
037000090421     C                   else
037100090421     C                   movel     ctrmm         mtrmm
037200090421     C                   endif
037300090421     C                   If        ctrdd = '  '
037400090421     C                   movel     00            mtrdd
037500090421     C                   else
037600090421     C                   movel     ctrdd         mtrdd
037700090421     C                   endif
037800090421      *
037900090421     C                   If        mptrm <> 0
038000090421     C                   test(D)                 mptrm                  21
038100090421     C                   if        *in21 = *ON
038200090421     C                   eval      smsg = invtrmd
038300090421     C                   eval      *in61 = *on
038400090421     C                   iter
038500090421     C                   endif
038600090421     C                   endif
038700090421      *
038800090421      *      Update Changed Record
038900090421     C                   eval      mpprem = cprem
039000090421      *
039100090421     C                   update    ODMNPR
039200090421      *
039300090421     C                   MOVE      *OFF          *IN05
039400090421      *
039500090421     C                   ENDDO
039600090421      *
039700090421     C                   movel     '0'           *in12
039800081208     C                   ENDSR
039900081208      ******************************************************************
