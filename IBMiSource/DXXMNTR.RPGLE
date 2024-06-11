000100981030     F*------------------------------------------------------------------------------------------*
000200090326      * DXXMNTR    GROUP BENIFIT SERVICES SOFTWARE           2009                                *
000300981030      *            WRITTEN BY - R.L.J.                                                           *
000400090326      *            DATE - 03/2009                                                                *
000500090326      *  DESCRIPTION - Maintain Denex Xref File                                                  *
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
001700090326     FACCMST    IF   E           K DISK
001800090326     FDXXREFP   UF A E           K DISK
001900090326     FDXXMNTD   CF   E             WORKSTN
002000981027     F                                     SFILE(DETAIL:RRN)
002100090326    * *
002200090326     D                 DS
002300090326     D date9           S              8S 0 INZ(99999999)
002400081215    * *
002500081215     D                 DS
002600090305     D wkdat8                  1      8  0
002700090305     D  wk8yy                  1      4
002800090305     D  wk8mm                  5      6
002900090715     D  wk8dd                  7      8
003000090715    * *
003100090715     D                 DS
003200090715     D drrdat                  1      8  0
003300090326     D  refyy                  1      4
003400090326     D  refmm                  5      6
003500090326     D  refdd                  7      8
003600090326    * *
003700090326     D                 DS
003800090326     D drtrm                   1      8  0
003900090326     D  rtryy                  1      4
004000090326     D  rtrmm                  5      6
004100090326     D  rtrdd                  7      8
004200081215    * *
004300081215     D                 DS
004400090326     D ddrdat                  1     10
004500081215     D  defmm                  1      2
004600081215     D  def1                   3      3    INZ('/')
004700081215     D  defdd                  4      5
004800081215     D  def2                   6      6    INZ('/')
004900081215     D  defyy                  7     10
005000081215    * *
005100081215     D                 DS
005200090326     D ddtrm                   1     10
005300081215     D  dtrmm                  1      2
005400081215     D  dtr1                   3      3    INZ('/')
005500081215     D  dtrdd                  4      5
005600081215     D  dtr2                   6      6    INZ('/')
005700081215     D  dtryy                  7     10
005800081219    * *
0059000812190053 D                 DS
0060000903050054 D  inveffd        C                   'Invalid Effective Date             '
0061000903050054 D  invtrmd        C                   'Invalid Term Date                  '
0062000903260054 D  invtsa         C                   'Invalid Trust - Sub - Acct         '
0063000903050054 D  invzip4        C                   'Inv Zip4 - must be 4 num or blank'
0064000903050054 D  invphn         C                   'Invalid Phone# - 10 num or blank'
0065000903050054 D  invofc         C                   'Invalid office number              '
0066000903260054 D  dupkey         C                   'T-S-A exists with same Renew Date  '
006700081208    * *
006800090326     C     dskey         klist
006900090717     C                   kfld                    dstrst
007000090717     C                   kfld                    dssub
007100090717     C                   kfld                    dsacct
007200090717     C                   kfld                    dsrdat
007300090326    * *
007400090326     C     dakey         klist
007500090326     C                   kfld                    datrst
007600090326     C                   kfld                    dasub
007700090326     C                   kfld                    daacct
007800090326     C                   kfld                    drrdat
007900090327    * *
008000090327     C     dckey         klist
008100090327     C                   kfld                    dctrst
008200090327     C                   kfld                    dcsub
008300090327     C                   kfld                    dcacct
008400090327     C                   kfld                    drrdat
008500081208      *
008600090326     C     tsakey        klist
008700090326     C                   kfld                    dstrst
008800090326     C                   kfld                    dssub
008900090326     C                   kfld                    dsacct
009000090326      *
009100090326     C     taakey        klist
009200090326     C                   kfld                    datrst
009300090326     C                   kfld                    dasub
009400090326     C                   kfld                    daacct
009500991116      *
009600981030      *    MAINLINE
009700081205     C     *IN01         DOWEQ     *OFF
009800081215     C***  *IN07         ANDEQ     *OFF
009900081205      *
010000981102     C                   EXSR      $CLEAR
010100081229     C                   EXSR      $LOAD
010200081229     C                   EXSR      $DISPLAY
010300081229      *    PROCESS SELECTION
010400081229     C     *IN01         IFEQ      *OFF
010500081229     C***  *IN07         ANDEQ     *OFF
010600081229     C***  RRN           ANDNE     *ZERO
010700081229     C                   EXSR      $PROCES
010800081229     C                   ENDIF
010900081229     C                   ENDDO
011000081229     C                   MOVE      *ON           *INLR
011100081229     C                   RETURN
011200981030      ******************************************************************
011300081208      *       SUBROUTINE - *INZSR                                      *
011400081229      *                    FIRST PASS LOGIC                            *
011500981030      ******************************************************************
011600081208     C***  *INZSR        BEGSR
011700081229     C*                  MOVEA     '0100'        *IN(31)
011800081208     C*                  WRITE     TRAILER
011900081208     C*                  EXFMT     HEADER
012000081208     C*****              ENDSR
012100981030      ******************************************************************
012200981109      *       SUBROUTINE - $CLEAR                                      *
012300981030      *                    CLEAR SUBF AND RRN                          *
012400981030      ******************************************************************
012500981102     C     $CLEAR        BEGSR
012600981027     C                   MOVEA     '001'         *IN(31)
012700981027     C                   WRITE     HEADER
012800981027     C                   Z-ADD     *ZERO         RRN               3 0
012900981027     C                   WRITE     HEADER
013000981027     C                   MOVEA     '010'         *IN(31)
013100981027     C                   ENDSR
013200981030      ******************************************************************
013300981109      *       SUBROUTINE - $LOAD                                       *
013400081205      *                    LOAD SUBFILE W/ Trust and Office Info       *
013500981030      ******************************************************************
013600981109     C     $LOAD         BEGSR
013700090326     C     *LOVAL        SETLL     DXXREFP
013800090109     C                   SETOFF                                       3495
013900090109     C     *IN34         DOUEQ     *ON
014000090109     C     *IN95         OREQ      *ON
014100090326     C                   READ      DXXREFP                                34
014200090109     C                   IF        (*In34 <> *ON)
014300081208      *
014400081208     C                   ADD       1             RRN
014500090326     C                   MOVEL     DRTRST        DSTRST
014600090326     C                   MOVEL     DRSUB         DSSUB
014700090326     C                   MOVEL     DRACCT        DSACCT
014800090326     C                   MOVEL     DRGRP#        DSGRP#
014900090326     C                   MOVEL     DRFTPID       DSFTPID
015000090326     C                   MOVEL     DRPLN         DSPLN
015100090326     C                   MOVEL     DRRDAT        DSRDAT
015200090326     C                   MOVEL     DRTRM         DSTRM
015300081208     C                   WRITE     DETAIL
015400081208     C                   ENDIF
015500081208      *
015600081208     C                   ENDDO
015700081208     C                   ENDSR
015800981030      ******************************************************************
015900981109      *       SUBROUTINE - $DISPLAY                                    *
016000081223      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
016100981030      ******************************************************************
016200081223     C     $DISPLAY      BEGSR
016300081223     C                   If        RRN <> *Zero
016400081223     C                   MOVE      *ON           *IN31
016500081223     C                   ENDIF
016600081223     C                   WRITE     TRAILER
016700081223     C                   EXFMT     HEADER
016800981027     C                   ENDSR
016900981030      ******************************************************************
017000981109      *       SUBROUTINE - $PROCES                                     *
017100981030      *                    PROCESS THE SELECTION                       *
017200981030      ******************************************************************
017300981109     C     $PROCES       BEGSR
017400081208     C     *IN95         DOUEQ     *ON
017500081208      *      Add new record
017600081208     C                   IF        *in10 = *ON
017700081208     C                   exsr      adddtl
017800081208     C                   eval      *in10 = *OFF
017900081208     C                   iter
018000081208     C                   endif
018100081208      *
018200081208     C                   READC     DETAIL                                 95
018300081208     C                   IF        *IN95 = *OFF
018400081208      *      Display detail
018500081208     C                   IF        SELECT = '5'
018600081208     C                   exsr      disdtl
018700081205     C                   else
018800081205      *      Display detail
018900081208     C                   IF        SELECT = '2'
019000081208     C                   exsr      chgdtl
019100081208     C                   endif
019200081208     C                   endif
019300081208      *
019400981027     C                   CLEAR                   SELECT
019500981027     C                   UPDATE    DETAIL
019600981027     C                   ENDIF
019700981027     C                   ENDDO
019800981027     C                   ENDSR
019900081208      ******************************************************************
020000081208      *       SUBROUTINE - DISDTL                                      *
020100081208      *                    Dispaly Office Detail                       *
020200081208      ******************************************************************
020300081208     C     disdtl        BEGSR
020400081208     C     *IN01         DOWEQ     *OFF
020500090326     C     dskey         chain     dxxrefp
020600090326     C     tsakey        chain     accmst
020700090326     C                   MOVEL     DRTRST        DDTRST
020800090326     C                   MOVEL     DRSUB         DDSUB
020900090326     C                   MOVEL     DRACCT        DDACCT
021000090326     C                   MOVEL     DRGRP#        DDGRP#
021100090326     C                   MOVEL     DRFTPID       DDFTPID
021200090326     C                   MOVEL     DRPLN         DDPLN
021300081215      *
021400090326     C                   MOVEL     acnam1        DDNAME
021500090326      *
021600090326     C                   movel     refmm         defmm
021700090326     C                   movel     refdd         defdd
021800090326     C                   movel     refyy         defyy
021900081208      *
022000090326     C                   movel     rtrmm         dtrmm
022100090326     C                   movel     rtrdd         dtrdd
022200090326     C                   movel     rtryy         dtryy
022300081208      *
022400081208     C                   exfmt     disp01
022500081208      *
022600081215     C****               IF        *IN07 = *ON or *IN01 = *ON
022700081215     C**                 MOVE      *ON           *INLR
022800081215     C**                 return
022900081215     C****               endif
023000081215      *
023100081215     C                   IF        *IN01 = *ON
023200081215     C                   MOVE      *Off          *IN01
023300081215     C                   leavesr
023400081215     C                   endif
023500081208      *
023600081208     C                   ENDDO
023700081208      *
023800081208     C                   movel     '0'           *in12
023900081208     C                   ENDSR
024000081208      ******************************************************************
024100081208      *       SUBROUTINE - ADDDTL                                      *
024200081208      *                    Add a new Dental Location Rec               *
024300081208      ******************************************************************
024400081208     C     adddtl        BEGSR
024500090305      *
024600090326     C                   eval      smsg = *blanks
024700090326     C                   eval      *in61 = *off
024800090305      *
024900090326     C     *IN01         DOWEQ     *OFF
025000090326     C                   if        smsg = *blanks
025100090326      *
025200090326     C                   eval      DATRST = 0
025300090326     C                   eval      DASUB = 0
025400090326     C                   eval      DAACCT = 0
025500090326     C                   eval      DAGRP# = *blanks
025600090326     C                   eval      DAFTPID = *blanks
025700090326     C                   eval      DAPLN = *blanks
025800090326     C                   eval      daname = *blanks
025900090326      *
026000090326     C                   eval      aefyy = *blanks
026100090326     C                   eval      aefmm = *blanks
026200090326     C                   eval      aefdd = *blanks
026300090326     C                   eval      atryy = *blanks
026400090326     C                   eval      atrmm = *blanks
026500090326     C                   eval      atrdd = *blanks
026600090326      *
026700090326     C                   endif
026800090326      *
026900090326     C                   exfmt     add01
027000090326      *
027100090326     C                   IF        *IN01 = *ON
027200090326     C                   MOVE      *Off          *IN01
027300090326     C                   leavesr
027400090326     C                   endif
027500090326      *           If F5 => Add new rec - edit Fields
027600090326      *               Allow Enter key to mimick F5
027700090326     C*******            IF        *IN05 = *ON
027800090326      *
027900090326     C                   eval      smsg = *blanks
028000090326     C                   eval      *in61 = *off
028100090326      *
028200090326     C     taakey        chain     accmst                             21
028300090326     C                   if        *in21 = '1'
028400090326     C                   eval      smsg = invtsa
028500090326     C                   eval      *in61 = *on
028600090326     C                   iter
028700090326     C                   else
028800090326     C                   eval      daname = acnam1
028900090326     C                   endif
029000090326      *
029100090326     C                   If        aefyy = '    '
029200090326     C                   movel     0000          refyy
029300090326     C                   else
029400090326     C                   movel     aefyy         refyy
029500090326     C                   endif
029600090326     C                   If        aefmm = '  '
029700090326     C                   movel     00            refmm
029800090326     C                   else
029900090326     C                   movel     aefmm         refmm
030000090326     C                   endif
030100090326     C                   If        aefdd = '  '
030200090326     C                   movel     00            refdd
030300090326     C                   else
030400090326     C                   movel     aefdd         refdd
030500090326     C                   endif
030600090326      *
030700090326     C                   test(D)                 drrdat                 21
030800090326     C                   if        *in21 = *ON
030900090326     C                   eval      smsg = inveffd
031000090326     C                   eval      *in61 = *on
031100090326     C                   iter
031200090326     C                   endif
031300090326      *
031400090326     C                   If        atryy = '    '
031500090326     C                   movel     0000          rtryy
031600090326     C                   else
031700090326     C                   movel     atryy         rtryy
031800090326     C                   endif
031900090326     C                   If        atrmm = '  '
032000090326     C                   movel     00            rtrmm
032100090326     C                   else
032200090326     C                   movel     atrmm         rtrmm
032300090326     C                   endif
032400090326     C                   If        atrdd = '  '
032500090326     C                   movel     00            rtrdd
032600090326     C                   else
032700090326     C                   movel     atrdd         rtrdd
032800090326     C                   endif
032900090326      *
033000090326     C                   If        drtrm <> 0
033100090326     C                   test(D)                 drtrm                  21
033200090326     C                   if        *in21 = *ON
033300090326     C                   eval      smsg = invtrmd
033400090326     C                   eval      *in61 = *on
033500090326     C                   iter
033600090326     C                   endif
033700090326     C                   endif
033800090326      *
033900090326     C     dakey         chain     dxxrefp                            21
034000090326     C                   if        *in21 = '0'
034100090326     C                   eval      smsg = dupkey
034200090326     C                   eval      *in61 = *on
034300090326     C                   iter
034400090326     C                   endif
034500090326      *
034600090326      *  Add record
034700090326     C                   eval      DRTRST = datrst
034800090326     C                   eval      DRSUB = dasub
034900090326     C                   eval      DRACCT = daacct
035000090326     C                   eval      DRGRP# = dagrp#
035100090326     C                   eval      DRFTPID = daftpid
035200090326     C                   eval      DRPLN = dapln
035300090326      *
035400090326     C                   write     dxxrefr
035500090326      *
035600090326     C                   MOVE      *OFF          *IN05
035700090326     C***                endif
035800090326      *
035900090326     C                   ENDDO
036000090326      *
036100081208     C                   ENDSR
036200081208      ******************************************************************
036300081208      *       SUBROUTINE - CHGDTL                                      *
036400081208      *                    Change Office Detail                       *
036500081208      ******************************************************************
036600081208     C     chgdtl        BEGSR
036700090305      *
036800090327     C                   eval      smsg = *blanks
036900090327     C                   eval      *in61 = *off
037000090327      *
037100090327     C     *IN01         DOWEQ     *OFF
037200090327     C                   if        smsg = *blanks
037300090327      *
037400090327     C     dskey         chain     dxxrefp
037500090327     C     tsakey        chain     accmst
037600090327     C                   MOVEL     DRTRST        DCTRST
037700090327     C                   MOVEL     DRSUB         DCSUB
037800090327     C                   MOVEL     DRACCT        DCACCT
037900090327     C                   MOVEL     DRGRP#        DCGRP#
038000090327     C                   MOVEL     DRFTPID       DCFTPID
038100090327     C                   MOVEL     DRPLN         DCPLN
038200090327      *
038300090327     C                   MOVEL     acnam1        DCNAME
038400090327      *
038500090327     C                   movel     refmm         cefmm
038600090327     C                   movel     refdd         cefdd
038700090327     C                   movel     refyy         cefyy
038800090327      *
038900090327     C                   movel     rtrmm         ctrmm
039000090327     C                   movel     rtrdd         ctrdd
039100090327     C                   movel     rtryy         ctryy
039200090327      *
039300090327     C                   endif
039400090327      *
039500090327     C                   exfmt     chg01
039600090327      *
039700090327     C                   IF        *IN01 = *ON
039800090327     C                   MOVE      *Off          *IN01
039900090327     C                   leavesr
040000090327     C                   endif
040100090327      *           If F5 => Chg rec - edit Fields
040200090327      *               Allow Enter key to mimick F5
040300090327     C*******            IF        *IN05 = *ON
040400090327      *
040500090327     C                   eval      smsg = *blanks
040600090327     C                   eval      *in61 = *off
040700090327      *
040800090327     C                   If        cefyy = '    '
040900090327     C                   movel     0000          refyy
041000090327     C                   else
041100090327     C                   movel     cefyy         refyy
041200090327     C                   endif
041300090327     C                   If        cefmm = '  '
041400090327     C                   movel     00            refmm
041500090327     C                   else
041600090327     C                   movel     cefmm         refmm
041700090327     C                   endif
041800090327     C                   If        cefdd = '  '
041900090327     C                   movel     00            refdd
042000090327     C                   else
042100090327     C                   movel     cefdd         refdd
042200090327     C                   endif
042300090327      *
042400090327     C                   test(D)                 drrdat                 21
042500090327     C                   if        *in21 = *ON
042600090327     C                   eval      smsg = inveffd
042700090327     C                   eval      *in61 = *on
042800090327     C                   iter
042900090327     C                   endif
043000090327      *
043100090327     C                   If        ctryy = '    '
043200090327     C                   movel     0000          rtryy
043300090327     C                   else
043400090327     C                   movel     ctryy         rtryy
043500090327     C                   endif
043600090327     C                   If        ctrmm = '  '
043700090327     C                   movel     00            rtrmm
043800090327     C                   else
043900090327     C                   movel     ctrmm         rtrmm
044000090327     C                   endif
044100090327     C                   If        ctrdd = '  '
044200090327     C                   movel     00            rtrdd
044300090327     C                   else
044400090327     C                   movel     ctrdd         rtrdd
044500090327     C                   endif
044600090327      *
044700090327     C                   If        drtrm <> 0
044800090327     C                   test(D)                 drtrm                  21
044900090327     C                   if        *in21 = *ON
045000090327     C                   eval      smsg = invtrmd
045100090327     C                   eval      *in61 = *on
045200090327     C                   iter
045300090327     C                   endif
045400090327     C                   endif
045500090327      *
045600090327      *  Change Record
045700090327     C                   eval      DRTRST = dctrst
045800090327     C                   eval      DRSUB = dcsub
045900090327     C                   eval      DRACCT = dcacct
046000090327     C                   eval      DRGRP# = dcgrp#
046100090327     C                   eval      DRFTPID = dcftpid
046200090327     C                   eval      DRPLN = dcpln
046300090327      *
046400090327     C                   update    dxxrefr
046500090327      *
046600090327     C                   MOVE      *OFF          *IN05
046700090327     C***                endif
046800090327      *
046900090327     C                   ENDDO
047000081208      *
047100081208     C                   ENDSR
047200081208      ******************************************************************
