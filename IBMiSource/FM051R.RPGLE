000100991124     F*-------------------------------------------------------------------------
000200000323     F* FM051      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300991124     F*            WRITTEN BY - S.S.K.
000400000323     F*            DATE - 03/00
000500000222     F*  DESCRIPTION - DISPLAY HISTORY RECORDS FOR SUBDIVISION MAINTENANCE
000600991124     F*  INDICATOR USAGE:
000700991124     F*    03 = EXIT FROM INITIAL SCREEN
000800000211     F*    08 = ALTERNATE SEQUENCE OF SUBFILE
000900991124     F*    25 = SFLDSP
001000991124     F*    26 = SFL DSP CTL
001100991124     F*    27 = SFL CLR
001200000211     F*    30 = ALLOW ROLL KEY
001300000211     F*    29 = ROLL FUNCTION SELECTED
001400991124     F*
001500991124     F*-------------------------------------------------------------------------
001600991209     ** MODIFICATION HISTORY                                              **
001700991209     ** ###  UUU  MMDDCCYY  X---->                                        **
001800000222     ** 000  SSK  02222000  ORIGINAL SOURCE                               **
001900001020     ** 001  SSK  10192000  MAKE A LOT OF CHANGES                         **
002000010914     ** 002  SSK  09142001  FIX HDATE DISPLAY ON EXPANDED SCREEN          **
002100991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002200220727     FDLFHIST1  IF   E           K DISK    extfile('F.DLFHIST1')
002300000323     FTRSMST    IF   E           K DISK    PREFIX(T_)
002301220727     f                                     extfile('F.TRSMST')
002400000323     FSUBMST    IF   E           K DISK    PREFIX(S_)
002401220727     f                                     extfile('F.SUBMST')
002500000323     FPLNMST    IF   E           K DISK    PREFIX(P_)
002501220727     f                                     extfile('F.PLNMST')
002600000428     FFM051D    CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
002700991124   X***X
002800000211     D @PARM           DS
002900000323     D  #PTRUST                1      3S 0
003000000323     D  #PSUBN                 4      6S 0
003100000323     D  @PPLAN                 7     10A
003200001020    ***
003300001020     D  #USA           S               D   DATFMT(*USA)
003400001020     D  #ISO           S               D   DATFMT(*ISO)
003500000323    ***
003600000428     D @BLOCK        E DS                  EXTNAME(DLFHIST0)
003700000211    ***
003800000211     D                UDS
003900000211     D  TITLE                201    240A
004000000222    ***
004100991216     D WSDS            DS
004200991216     D  FKEY                 369    369A
004300991216    ***
004400991216     D  F1             C                   CONST(X'31')
004500991216     D  F2             C                   CONST(X'32')
004600991216     D  F3             C                   CONST(X'33')
004700991216     D  F4             C                   CONST(X'34')
004800991216     D  F5             C                   CONST(X'35')
004900991216     D  F6             C                   CONST(X'36')
005000991216     D  F7             C                   CONST(X'37')
005100991216     D  F8             C                   CONST(X'38')
005200991216     D  F9             C                   CONST(X'39')
005300991216     D  F10            C                   CONST(X'3A')
005400991216     D  F11            C                   CONST(X'3B')
005500991216     D  F12            C                   CONST(X'3C')
005600991216     D  F13            C                   CONST(X'B1')
005700991216     D  F14            C                   CONST(X'B2')
005800991216     D  F15            C                   CONST(X'B3')
005900991216     D  F16            C                   CONST(X'B4')
006000991216     D  F17            C                   CONST(X'B5')
006100991216     D  F18            C                   CONST(X'B6')
006200991216     D  F19            C                   CONST(X'B7')
006300991216     D  F20            C                   CONST(X'B8')
006400000323     D  F51            C                   CONST(X'B9')
006500991216     D  F22            C                   CONST(X'BA')
006600991216     D  F23            C                   CONST(X'BB')
006700991216     D  F24            C                   CONST(X'BC')
006800991124   X***X
006900991124     C* MAINLINE
007000991124    ***
007100991124     C                   EXSR      ONCE
007200991124     C*
007300991216     C                   DOU       @EXIT = '1'
007400991124     C*
007500991124     C                   MOVE      '0'           @ACTION
007600991124     C*
007700991124     C                   EXSR      $CHKFXN
007800000222     C*
007900000222     C                   IF        FKEY <> F1
008000000222     C                   EXSR      $CHKSELC
008100000222     C                   ENDIF
008200991124     C*
008300000211     C                   IF        FKEY <> F1
008400991124     C                   EXSR      $DISPLAY
008500991124     C                   ENDIF
008600991124     C*
008700991124     C                   ENDDO
008800991124     C*
008900991124     C                   MOVE      *ON           *INLR
009000991124     C                   RETURN
009100991124   S***S
009200991124     C* ONETIME ROUTINE
009300991124    ***
009400991124     C     ONCE          BEGSR
009500000211    ***
009600000211     C     *ENTRY        PLIST
009700000211     C                   PARM                    @PARM
009800000222    ***
009900000222     C     *LIKE         DEFINE    HTRST         #KEYTRST
010000000222     C     *LIKE         DEFINE    HSUB          #KEYSUB
010100000323     C     *LIKE         DEFINE    HPLAN         #KEYPLAN
010200000222    ***
010300991124     C                   MOVE      *BLANKS       @ACTNTYPE         1
010400991124    ***
010500991124     C                   MOVE      *ZEROS        RRT               3 0
010600991124     C                   MOVE      *ZEROS        #CNTREC           2 0
010700991124    ***
010800991124     C                   MOVE      '0'           @1STLOOP          1
010900991124     C                   MOVE      '0'           @SFLOOP           1
011000991124     C                   MOVE      '0'           @CNFRM            1
011100991124     C                   MOVE      '1'           @LOOPIT           1
011200991124     C                   MOVE      '0'           @ACTION           1
011300991124     C                   MOVEA     '0'           *IN
011400991124     C                   MOVE      '0'           @EXIT             1
011500000114     C                   MOVE      *OFF          *IN31
011600000222    ***
011700000222     C     @SUBKEY       KLIST
011800000222     C                   KFLD                    #KEYTRST
011900000222     C                   KFLD                    #KEYSUB
012000000113    ***
012100000323     C     @PLNKEY       KLIST
012200000323     C                   KFLD                    #KEYTRST
012300000323     C                   KFLD                    #KEYSUB
012400000323     C                   KFLD                    #KEYPLAN
012500000323    ***
012600000323     C                   Z-ADD     #PTRUST       #KEYTRST
012700000323     C                   Z-ADD     #PSUBN        #KEYSUB
012800000428     C                   MOVEL     @PPLAN        #KEYPLAN
012900000222    ***
013000000222     C     #KEYTRST      CHAIN(N)  TRSMSR
013100000323     C                   Z-ADD     T_TRTRST      HTRST
013200000323     C                   MOVEL(P)  T_TNAME       TNAME
013300000222    ***
013400000323     C     @SUBKEY       CHAIN(N)  SUBMSR
013500000323     C                   Z-ADD     S_SBSUB#      HSUB
013600000323     C                   MOVEL(P)  S_SUBNAM      SUBNAM
013700000323    ***
013800000323     C     @PLNKEY       CHAIN(N)  PLNMSR
013900000428     C                   MOVEL     P_PLPLAN      HPLAN
014000000323     C                   MOVEL(P)  P_PDESCR      PDESCR
014100000323    ***
014200991124     C                   EXSR      $CLEAR
014300000211    ***
014400991124     C                   EXSR      $BUILD
014500991124     C                   EXSR      $DISPLAY
014600991124    ***
014700991124     C                   ENDSR
014800991124   S***S
014900991124     C* INITIALIZE THE SUBFILE
015000991124    ***
015100991124     C     $CLEAR        BEGSR
015200991124    ***
015300991124     C                   MOVEA     '011'         *IN(25)
015400000211     C                   WRITE     GBSCTL
015500991124     C                   MOVEA     '010'         *IN(25)
015600991124     C                   Z-ADD     *ZERO         RRT
015700991124    ***
015800991124     C                   ENDSR
015900991124   S***S
016000991124     C* DISPLAY THE SCREEN
016100991124    ***
016200991124     C     $DISPLAY      BEGSR
016300991124    ***
016400000211     C                   WRITE     GBSREC
016500000211     C                   EXFMT     GBSCTL
016600991124    ***
016700991124     C                   ENDSR
016800991124   S***S
016900991124     C* CHECK FOR FUNCTION KEY USAGE
017000991124    ***
017100991124     C     $CHKFXN       BEGSR
017200991124    ***
017300000113     C                   SELECT
017400000113     C*
017500000211     C                   WHEN      FKEY = F1
017600000113     C                   MOVE      '1'           @EXIT
017700000113     C*
017800000113     C                   WHEN      *IN29 = *ON AND *IN30 = *ON
017900000113     C                   EXSR      $RELOAD
018000000113     C                   MOVE      '1'           @ACTION
018100000113     C*
018200000113     C                   ENDSL
018300000113    ***
018400000113     C                   ENDSR
018500000113   S***S
018600000113     C* BUILD SUBFILE CONTROL ROUTINE
018700000113    ***
018800000113     C     $BUILD        BEGSR
018900000113    ***
019000000113     C                   EXSR      $CLEAR
019100000113     C                   MOVE      *ZEROS        #CNTREC
019200000113     C                   MOVE      '0'           @1STLOOP
019300000113     C                   MOVE      '0'           @SFLOOP
019400000113    ***
019500011108     C     @PLNKEY       SETLL     RDLFHIST
019600000323     C                   DOU       %EOF(DLFHIST1) OR @SFLOOP = '1'
019700011108     C     @PLNKEY       READE     RDLFHIST
019800000323     C                   IF        NOT %EOF(DLFHIST1)
019900000113     C                   EXSR      $LOADSFL
020000000113     C                   ENDIF
020100000113     C                   ENDDO
020200000113    ***
020300000323     C                   IF        %EOF(DLFHIST1)
020400000113     C                   MOVE      *OFF          *IN29
020500000113     C                   ELSE
020600000113     C                   MOVE      *ON           *IN29
020700000113     C                   ENDIF
020800000113    ***
020900000113     C                   ENDSR
021000000113   S***S
021100000113     C* LOAD SUBFILE RECORDS
021200000113    ***
021300000113     C     $LOADSFL      BEGSR
021400000113    ***
021500000113     C                   MOVE      *ON           *IN25
021600000211    ***
021700000428     C                   MOVEL(P)  @BLOCK        HDATA
021800000222     C                   MOVEL(P)  HUSERID       SFUSERID
021900001020*********                Z-ADD     HDATE         SFDATE
022000001020     C                   MOVE      HDATE         #ISO
022100001020     C                   MOVE      #ISO          #USA
022200001020     C                   MOVE      #USA          SFDATE
022300000222     C                   Z-ADD     HTIME         SFTIME
022400000211     C*
022500000323     C                   MOVEL(P)  HBRNDFLG      SFBRNDFLG
022600000323     C                   Z-ADD     HBRNDAMT      SFBRNDAMT
022700000323     C                   MOVEL(P)  HBDCDLTD      SFBDCDLTD
022800000222     C*
022900000428     C                   MOVEL(P)  HARNDFLG      SFARNDFLG
023000000428     C                   Z-ADD     HARNDAMT      SFARNDAMT
023100000428     C                   MOVEL(P)  HADCDLTD      SFADCDLTD
023200000211     C*
023300000113     C                   ADD       1             RRT
023400000113     C                   IF        @1STLOOP = '0'
023500000113     C                   Z-ADD     RRT           SFLPOS
023600000113     C                   MOVE      '1'           @1STLOOP
023700000113     C                   ENDIF
023800000211     C                   WRITE     GBSSFL
023900000113     C*
024000000113     C                   ADD       1             #CNTREC
024100000211     C                   IF        #CNTREC = 240
024200000113     C                   MOVE      '1'           @SFLOOP
024300000222     C                   ENDIF
024400000113    ***
024500000113     C                   ENDSR
024600000113   S***S
024700000113     C* ROLL CONTROL
024800000113    ***
024900000113     C     $RELOAD       BEGSR
025000000211    ***
025100000211     C                   EXSR      $CLEAR
025200000211     C                   MOVE      *ZEROS        #CNTREC
025300000211     C                   MOVE      '0'           @1STLOOP
025400000211     C                   MOVE      '0'           @SFLOOP
025500000211    ***
025600000222     C                   EXSR      $BUILD
025700000211    ***
025800000113     C                   ENDSR
025900000222   S***S
026000000222    SC     $CHKSELC      BEGSR
026100000222     C*
026200000222     C                   MOVE      *OFF          *IN33
026300001122    1C                   DOU       *IN33 = *ON OR *IN34 = *ON
026400001122     C                   READC     GBSSFL                               3433
026500001122    2C                   IF        *IN33 = *OFF AND *IN34 = *OFF
026600000222     C*
026700000222     C                   IF        SEL01 <> *BLANKS
026800000222     C*
026900000222    3C                   IF        SEL01 = 'X'
027000000222     C*
027100001102     C                   EXSR      $FMTSCN
027200000222     C                   DOU       FKEY = F1
027300000222     C                   EXFMT     EXPNDSCRN
027400000222     C                   IF        FKEY = F11
027500000222     C                   IF        *IN50 = *OFF
027600000222     C                   MOVE      *ON           *IN50
027700000222     C                   ELSE
027800000222     C                   MOVE      *OFF          *IN50
027900000222     C                   ENDIF
028000000222     C                   ENDIF
028100000222     C                   ENDDO
028200000222     C*
028300000222    3C                   ENDIF
028400000222     C*
028500000222     C                   MOVE      *BLANKS       SEL01
028600000222     C                   UPDATE    GBSSFL
028700000222     C*
028800000222    3C                   ENDIF
028900000222     C*
029000000222    2C                   ENDIF
029100000222     C*
029200000222    1C                   ENDDO
029300000222     C*
029400000222     C                   MOVE      X'BC'         FKEY
029500000222     C                   MOVE      '0'           @EXIT
029600000222     C*
029700000222    SC                   ENDSR
029800000222   S***S
029900001102     C     $FMTSCN       BEGSR
030000001102     C                   MOVE      *OFF          *IN50
030100001102     C                   MOVEL(P)  HDATA         @BLOCK
030200001102     C                   Z-ADD     T_TRTRST      TRTRST
030300001102     C                   MOVEL(P)  T_TNAME       TNAME
030400001102     C                   Z-ADD     S_SBSUB#      SBSUB#
030500001102     C                   MOVEL(P)  S_SUBNAM      SUBNAM
030600001102     C                   MOVEL     P_PLPLAN      DCPLAN
030700001102     C                   MOVEL(P)  P_PDESCR      PDESCR2
030800011009     C                   MOVEA     '1111111111'  *IN(40)
030900011009     C                   MOVEA     '1111111111'  *IN(50)
031000011009     C                   MOVEA     '111'         *IN(60)
031100010914     C*
031200010914     C                   MOVE      HDATE         #ISO
031300010914     C                   MOVE      #ISO          #USA
031400010914     C                   MOVE      #USA          @@HDATE
031500001102     C*
031600011009     C*                  IF        HBRNDFLG <> HARNDFLG
031700011009     C*                  MOVE      *ON           *IN40
031800011009     C*                  ENDIF
031900011009     C*
032000011009     C*                  IF        HBRNDAMT <> HARNDAMT
032100011009     C*                  MOVE      *ON           *IN41
032200011009     C*                  ENDIF
032300011009     C*
032400011009     C*                  IF        HBDCDLTD <> HADCDLTD
032500011009     C*                  MOVE      *ON           *IN42
032600011009     C*                  ENDIF
032700011009     C*
032800011009     C*                  IF        HBABF01 <> HAABF01 OR
032900011009     C*                            HBABT01 <> HAABT01 OR
033000011009     C*                            HBDPER01 <> HADPER01
033100011009     C*                  MOVE      *ON           *IN43
033200011009     C*                  ENDIF
033300011009     C*
033400011009     C*                  IF        HBABF11 <> HAABF11 OR
033500011009     C*                            HBABT11 <> HAABT11 OR
033600011009     C*                            HBDPER11 <> HADPER11
033700011009     C*                  MOVE      *ON           *IN44
033800011009     C*                  ENDIF
033900011009     C*
034000011009     C*                  IF        HBABF02 <> HAABF02 OR
034100011009     C*                            HBABT02 <> HAABT02 OR
034200011009     C*                            HBDPER02 <> HADPER02
034300011009     C*                  MOVE      *ON           *IN45
034400011009     C*                  ENDIF
034500011009     C*
034600011009     C*                  IF        HBABF12 <> HAABF12 OR
034700011009     C*                            HBABT12 <> HAABT12 OR
034800011009     C*                            HBDPER12 <> HADPER12
034900011009     C*                  MOVE      *ON           *IN46
035000011009     C*                  ENDIF
035100011009     C*
035200011009     C*                  IF        HBABF03 <> HAABF03 OR
035300011009     C*                            HBABT03 <> HAABT03 OR
035400011009     C*                            HBDPER03 <> HADPER03
035500011009     C*                  MOVE      *ON           *IN47
035600011009     C*                  ENDIF
035700011009     C*
035800011009     C*                  IF        HBABF13 <> HAABF13 OR
035900011009     C*                            HBABT13 <> HAABT13 OR
036000011009     C*                            HBDPER13 <> HADPER13
036100011009     C*                  MOVE      *ON           *IN48
036200011009     C*                  ENDIF
036300011009     C*
036400011009     C*                  IF        HBABF04 <> HAABF04 OR
036500011009     C*                            HBABT04 <> HAABT04 OR
036600011009     C*                            HBDPER04 <> HADPER04
036700011009     C*                  MOVE      *ON           *IN49
036800011009     C*                  ENDIF
036900011009     C*
037000011009     C*                  IF        HBABF14 <> HAABF14 OR
037100011009     C*                            HBABT14 <> HAABT14 OR
037200011009     C*                            HBDPER14 <> HADPER14
037300011009     C*                  MOVE      *ON           *IN50
037400011009     C*                  ENDIF
037500011009     C*
037600011009     C*                  IF        HBABF05 <> HAABF05 OR
037700011009     C*                            HBABT05 <> HAABT05 OR
037800011009     C*                            HBDPER05 <> HADPER05
037900011009     C*                  MOVE      *ON           *IN51
038000011009     C*                  ENDIF
038100011009     C*
038200011009     C*                  IF        HBABF15 <> HAABF15 OR
038300011009     C*                            HBABT15 <> HAABT15 OR
038400011009     C*                            HBDPER15 <> HADPER15
038500011009     C*                  MOVE      *ON           *IN52
038600011009     C*                  ENDIF
038700011009     C*
038800011009     C*                  IF        HBABF06 <> HAABF06 OR
038900011009     C*                            HBABT06 <> HAABT06 OR
039000011009     C*                            HBDPER06 <> HADPER06
039100011009     C*                  MOVE      *ON           *IN53
039200011009     C*                  ENDIF
039300011009     C*
039400011009     C*                  IF        HBABF16 <> HAABF16 OR
039500011009     C*                            HBABT16 <> HAABT16 OR
039600011009     C*                            HBDPER16 <> HADPER16
039700011009     C*                  MOVE      *ON           *IN54
039800011009     C*                  ENDIF
039900011009     C*
040000011009     C*                  IF        HBABF07 <> HAABF07 OR
040100011009     C*                            HBABT07 <> HAABT07 OR
040200011009     C*                            HBDPER07 <> HADPER07
040300011009     C*                  MOVE      *ON           *IN55
040400011009     C*                  ENDIF
040500011009     C*
040600011009     C*                  IF        HBABF17 <> HAABF17 OR
040700011009     C*                            HBABT17 <> HAABT17 OR
040800011009     C*                            HBDPER17 <> HADPER17
040900011009     C*                  MOVE      *ON           *IN56
041000011009     C*                  ENDIF
041100011009     C*
041200011009     C*                  IF        HBABF08 <> HAABF08 OR
041300011009     C*                            HBABT08 <> HAABT08 OR
041400011009     C*                            HBDPER08 <> HADPER08
041500011009     C*                  MOVE      *ON           *IN57
041600011009     C*                  ENDIF
041700011009     C*
041800011009     C*                  IF        HBABF18 <> HAABF18 OR
041900011009     C*                            HBABT18 <> HAABT18 OR
042000011009     C*                            HBDPER18 <> HADPER18
042100011009     C*                  MOVE      *ON           *IN58
042200011009     C*                  ENDIF
042300011009     C*
042400011009     C*                  IF        HBABF09 <> HAABF09 OR
042500011009     C*                            HBABT09 <> HAABT09 OR
042600011009     C*                            HBDPER09 <> HADPER09
042700011009     C*                  MOVE      *ON           *IN59
042800011009     C*                  ENDIF
042900011009     C*
043000011009     C*                  IF        HBABF19 <> HAABF19 OR
043100011009     C*                            HBABT19 <> HAABT19 OR
043200011009     C*                            HBDPER19 <> HADPER19
043300011009     C*                  MOVE      *ON           *IN60
043400011009     C*                  ENDIF
043500011009     C*
043600011009     C*                  IF        HBABF10 <> HAABF10 OR
043700011009     C*                            HBABT10 <> HAABT10 OR
043800011009     C*                            HBDPER10 <> HADPER10
043900011009     C*                  MOVE      *ON           *IN61
044000011009     C*                  ENDIF
044100011009     C*
044200011009     C*                  IF        HBABF20 <> HAABF20 OR
044300011009     C*                            HBABT20 <> HAABT20 OR
044400011009     C*                            HBDPER20 <> HADPER20
044500011009     C*                  MOVE      *ON           *IN62
044600011009     C*                  ENDIF
044700001102     C*
044800001102     C                   ENDSR
044900001102   S***S
