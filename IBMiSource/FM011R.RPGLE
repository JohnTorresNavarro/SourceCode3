000100991124     F*-------------------------------------------------------------------------
000200000222     F* FM011      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300991124     F*            WRITTEN BY - S.S.K.
000400000211     F*            DATE - 02/00
000500000222     F*  DESCRIPTION - DISPLAY HISTORY RECORDS FOR TRUST MASTER MAINTENANCE
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
001900991209     **                                                                   **
002000991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100220817     FTRMHIST1  IF   E           K DISK    extfile('F.TRMHIST1')
002200001019     FTRMHIST2  IF   E           K DISK    PREFIX(K:1) RENAME(RTRMHIST:THIST)
002201220817     f                                     extfile('F.TRMHIST2')
002300001019     FGBSECURE  IF   E           K DISK
002400000428     FFM011D    CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
002500991124   X***X
002600220817     D*@PARM           DS
002700220817     D* TRUST#                 1      3S 0
002800000211    ***
002900000211     D                UDS
003000000211     D  TITLE                201    240A
003100001019    ***
003200001019     D #ISO            S               D   DATFMT(*ISO)
003300001019     D #USA            S               D   DATFMT(*USA)
003400000222    ***
003500000222     D HATDESCR        DS
003600000222     D  HATDESCR1              1     25A
003700000222     D  HATDESCR2             26     50A
003800000222    ***
003900000222     D HBTDESCR        DS
004000000222     D  HBTDESCR1              1     25A
004100000222     D  HBTDESCR2             26     50A
004200000211    ***
004300991216     D WSDS            DS
004400991216     D  FKEY                 369    369A
004500991216    ***
004600991216     D  F1             C                   CONST(X'31')
004700991216     D  F2             C                   CONST(X'32')
004800991216     D  F3             C                   CONST(X'33')
004900991216     D  F4             C                   CONST(X'34')
005000991216     D  F5             C                   CONST(X'35')
005100991216     D  F6             C                   CONST(X'36')
005200991216     D  F7             C                   CONST(X'37')
005300991216     D  F8             C                   CONST(X'38')
005400991216     D  F9             C                   CONST(X'39')
005500991216     D  F10            C                   CONST(X'3A')
005600991216     D  F11            C                   CONST(X'3B')
005700991216     D  F12            C                   CONST(X'3C')
005800991216     D  F13            C                   CONST(X'B1')
005900991216     D  F14            C                   CONST(X'B2')
006000991216     D  F15            C                   CONST(X'B3')
006100991216     D  F16            C                   CONST(X'B4')
006200991216     D  F17            C                   CONST(X'B5')
006300991216     D  F18            C                   CONST(X'B6')
006400991216     D  F19            C                   CONST(X'B7')
006500991216     D  F20            C                   CONST(X'B8')
006600991216     D  F21            C                   CONST(X'B9')
006700991216     D  F22            C                   CONST(X'BA')
006800991216     D  F23            C                   CONST(X'BB')
006900991216     D  F24            C                   CONST(X'BC')
006901220817
006902220817     d fm011r          pi
006903220817     D  trust#                        3  0
007000991124   X***X
007100991124     C* MAINLINE
007200991124    ***
007300991124     C                   EXSR      ONCE
007400991124     C*
007500991216     C                   DOU       @EXIT = '1'
007600991124     C*
007700991124     C                   MOVE      '0'           @ACTION
007800991124     C*
007900991124     C                   EXSR      $CHKFXN
008000000222     C*
008100000222     C                   IF        FKEY <> F1
008200000222     C                   EXSR      $CHKSELC
008300000222     C                   ENDIF
008400991124     C*
008500000211     C                   IF        FKEY <> F1
008600991124     C                   EXSR      $DISPLAY
008700991124     C                   ENDIF
008800991124     C*
008900991124     C                   ENDDO
009000991124     C*
009100991124     C                   MOVE      *ON           *INLR
009200991124     C                   RETURN
009300991124   S***S
009400991124     C* ONETIME ROUTINE
009500991124    ***
009600991124     C     ONCE          BEGSR
009700000211    ***
009800220817     C*    *ENTRY        PLIST
009900220817     C*                  PARM                    @PARM
010000000222    ***
010100000222     C     *LIKE         DEFINE    HTRST         #KEYTRST
010200001019     C     *LIKE         DEFINE    HDATE         #KD
010300001019     C     *LIKE         DEFINE    HTIME         #KT
010400001019     C     *LIKE         DEFINE    SCUSR         @KEYUSR
010500001019    ***
010600001019     C     @KL           KLIST
010700001019     C                   KFLD                    #KEYTRST
010800001019     C                   KFLD                    #KD
010900001019     C                   KFLD                    #KT
011000000222    ***
011100991124     C                   MOVE      *BLANKS       @ACTNTYPE         1
011200991124    ***
011300991124     C                   MOVE      *ZEROS        RRT               3 0
011400991124     C                   MOVE      *ZEROS        #CNTREC           2 0
011500991124    ***
011600991124     C                   MOVE      '0'           @1STLOOP          1
011700991124     C                   MOVE      '0'           @SFLOOP           1
011800991124     C                   MOVE      '0'           @CNFRM            1
011900991124     C                   MOVE      '1'           @LOOPIT           1
012000991124     C                   MOVE      '0'           @ACTION           1
012100991124     C                   MOVEA     '0'           *IN
012200991124     C                   MOVE      '0'           @EXIT             1
012300000114     C                   MOVE      *OFF          *IN31
012400000113    ***
012500000222     C                   Z-ADD     TRUST#        #KEYTRST
012600991124     C                   EXSR      $CLEAR
012700000211    ***
012800991124     C                   EXSR      $BUILD
012900991124     C                   EXSR      $DISPLAY
013000991124    ***
013100991124     C                   ENDSR
013200991124   S***S
013300991124     C* INITIALIZE THE SUBFILE
013400991124    ***
013500991124     C     $CLEAR        BEGSR
013600991124    ***
013700991124     C                   MOVEA     '011'         *IN(25)
013800000211     C                   WRITE     GBSCTL
013900991124     C                   MOVEA     '010'         *IN(25)
014000991124     C                   Z-ADD     *ZERO         RRT
014100991124    ***
014200991124     C                   ENDSR
014300991124   S***S
014400991124     C* DISPLAY THE SCREEN
014500991124    ***
014600991124     C     $DISPLAY      BEGSR
014700991124    ***
014800000211     C                   WRITE     GBSREC
014900000211     C                   EXFMT     GBSCTL
015000991124    ***
015100991124     C                   ENDSR
015200991124   S***S
015300991124     C* CHECK FOR FUNCTION KEY USAGE
015400991124    ***
015500991124     C     $CHKFXN       BEGSR
015600991124    ***
015700000113     C                   SELECT
015800000113     C*
015900000211     C                   WHEN      FKEY = F1
016000000113     C                   MOVE      '1'           @EXIT
016100000113     C*
016200000113     C                   WHEN      *IN29 = *ON AND *IN30 = *ON
016300000113     C                   EXSR      $RELOAD
016400000113     C                   MOVE      '1'           @ACTION
016500000113     C*
016600000113     C                   ENDSL
016700000113    ***
016800000113     C                   ENDSR
016900000113   S***S
017000000113     C* BUILD SUBFILE CONTROL ROUTINE
017100000113    ***
017200000113     C     $BUILD        BEGSR
017300000113    ***
017400000113     C                   EXSR      $CLEAR
017500000113     C                   MOVE      *ZEROS        #CNTREC
017600000113     C                   MOVE      '0'           @1STLOOP
017700000113     C                   MOVE      '0'           @SFLOOP
017800000113    ***
017900000222     C     #KEYTRST      SETLL     RTRMHIST
018000000222     C                   DOU       %EOF(TRMHIST1) OR @SFLOOP = '1'
018100000222     C     #KEYTRST      READE     RTRMHIST
018200000222     C                   IF        NOT %EOF(TRMHIST1)
018300000113     C                   EXSR      $LOADSFL
018400000113     C                   ENDIF
018500000113     C                   ENDDO
018600000113    ***
018700000222     C                   IF        %EOF(TRMHIST1)
018800000113     C                   MOVE      *OFF          *IN29
018900000113     C                   ELSE
019000000113     C                   MOVE      *ON           *IN29
019100000113     C                   ENDIF
019200000113    ***
019300000113     C                   ENDSR
019400000113   S***S
019500000113     C* LOAD SUBFILE RECORDS
019600000113    ***
019700000113     C     $LOADSFL      BEGSR
019800000113    ***
019900000113     C                   MOVE      *ON           *IN25
020000000211    ***
020100000222     C                   MOVEL(P)  HUSERID       SFUSERID
020200001019     C                   MOVEL(P)  HUSERID       @KEYUSR
020300001019     C     @KEYUSR       CHAIN     SECR
020400001019     C                   IF        %FOUND(GBSECURE)
020500001019     C                   MOVEL(P)  SCNAME        SFUSERID
020600001019     C                   ELSE
020700001019     C                   MOVE      *BLANKS       SFUSERID
020800001019     C                   END
020900001019********                 Z-ADD     HDATE         SFDATE
021000001019     C                   MOVE      HDATE         #ISO
021100001019     C                   MOVE      #ISO          #USA
021200001019     C                   MOVE      #USA          SFDATE
021300000222     C                   Z-ADD     HTIME         SFTIME
021400000211     C*
021500000222     C                   MOVEL(P)  HBTNAME       SFBTNAM
021600000222     C                   MOVEL(P)  HBTDESCR      SFBTDSC
021700000222     C                   MOVEL(P)  HBPTADL1      SFBPTA1
021800000222     C                   MOVEL(P)  HBPTADL2      SFBPTA2
021900000222     C                   MOVEL(P)  HBPTADL3      SFBPTA3
022000000222     C                   MOVEL(P)  HBPTADL4      SFBPTA4
022100000222     C                   Z-ADD     HBSTLOSS      SFBSTLS
022200000222     C                   MOVEL(P)  HBTRNBIL      SFBTRBI
022300000222     C                   MOVEL(P)  HBTSCODE      SFBTSCD
022400000222     C                   MOVEL(P)  HBTRDLTD      SFBTRDL
022500001019**********               Z-ADD     HBCONTDT      SFBCNDT
022600001019     C                   IF        HBCONTDT <> 0
022700001019     C                   MOVE      HBCONTDT      #ISO
022800001019     C                   MOVE      #ISO          #USA
022900001019     C                   MOVE      #USA          SFBCNDT
023000001019     C                   ELSE
023100001019     C                   MOVE      *ZEROS        SFBCNDT
023200001019     C                   ENDIF
023300000211     C*
023400000222     C                   MOVEL(P)  HATNAME       SFATNAM
023500000222     C                   MOVEL(P)  HATDESCR      SFATDSC
023600000222     C                   MOVEL(P)  HAPTADL1      SFAPTA1
023700000222     C                   MOVEL(P)  HAPTADL2      SFAPTA2
023800000222     C                   MOVEL(P)  HAPTADL3      SFAPTA3
023900000222     C                   MOVEL(P)  HAPTADL4      SFAPTA4
024000000222     C                   Z-ADD     HASTLOSS      SFASTLS
024100000222     C                   MOVEL(P)  HATRNBIL      SFATRBI
024200000222     C                   MOVEL(P)  HATSCODE      SFATSCD
024300000222     C                   MOVEL(P)  HATRDLTD      SFATRDL
024400001020*****C***                Z-ADD     HACONTDT      SFACNDT
024500001019     C                   IF        HACONTDT <> 0
024600001019     C                   MOVE      HACONTDT      #ISO
024700001019     C                   MOVE      #ISO          #USA
024800001019     C                   MOVE      #USA          SFACNDT
024900001019     C                   ELSE
025000001019     C                   MOVE      *ZEROS        SFACNDT
025100001019     C                   ENDIF
025200000211     C*
025300000113     C                   ADD       1             RRT
025400000113     C                   IF        @1STLOOP = '0'
025500000113     C                   Z-ADD     RRT           SFLPOS
025600000113     C                   MOVE      '1'           @1STLOOP
025700000113     C                   ENDIF
025800000211     C                   WRITE     GBSSFL
025900000113     C*
026000000113     C                   ADD       1             #CNTREC
026100000211     C                   IF        #CNTREC = 240
026200000113     C                   MOVE      '1'           @SFLOOP
026300000222     C                   ENDIF
026400000113    ***
026500000113     C                   ENDSR
026600000113   S***S
026700000113     C* ROLL CONTROL
026800000113    ***
026900000113     C     $RELOAD       BEGSR
027000000211    ***
027100000211     C                   EXSR      $CLEAR
027200000211     C                   MOVE      *ZEROS        #CNTREC
027300000211     C                   MOVE      '0'           @1STLOOP
027400000211     C                   MOVE      '0'           @SFLOOP
027500000211    ***
027600000222     C                   EXSR      $BUILD
027700000211    ***
027800000113     C                   ENDSR
027900000222   S***S
028000000222    SC     $CHKSELC      BEGSR
028100000222     C*
028200000222     C                   MOVE      *OFF          *IN33
028300001122    1C                   DOU       *IN33 = *ON OR *IN34 = *ON
028400001122     C                   READC     GBSSFL                               3433
028500001122    2C                   IF        *IN33 = *OFF AND *IN34 = *OFF
028600000222     C*
028700000222     C                   IF        SEL01 <> *BLANKS
028800000222     C*
028900000222    3C                   IF        SEL01 = 'X'
029000001019     C                   MOVE      SFDATE        #USA
029100001019     C                   MOVE      #USA          #ISO
029200001019     C                   MOVE      #ISO          #KD
029300001019     C                   Z-ADD     SFTIME        #KT
029400001019     C     @KL           CHAIN     THIST
029500001019     C                   MOVEL(P)  SFUSERID      KUSERID
029600001102     C                   EXSR      $SETINDC
029700001020     C                   MOVE      KDATE         #ISO
029800001020     C                   MOVE      #ISO          #USA
029900001020     C                   MOVE      #USA          KDATE
030000000222     C*
030100000222     C                   DOU       FKEY = F1
030200000222     C                   EXFMT     EXPNDSCRN
030300000222     C                   ENDDO
030400000222     C*
030500000222    3C                   ENDIF
030600000222     C*
030700000222     C                   MOVE      *BLANKS       SEL01
030800000222     C                   UPDATE    GBSSFL
030900000222     C*
031000000222    3C                   ENDIF
031100000222     C*
031200000222    2C                   ENDIF
031300000222     C*
031400000222    1C                   ENDDO
031500000222     C*
031600000222     C                   MOVE      X'BC'         FKEY
031700000222     C                   MOVE      '0'           @EXIT
031800000222     C*
031900000222    SC                   ENDSR
032000000222   S***S
032100001102     C     $SETINDC      BEGSR
032200001102     C*
032300001102     C                   MOVEA     '00000000'    *IN(40)
032400001102    1C                   IF        KBTNAME  <> KATNAME
032500001102     C                   MOVE      *ON           *IN40
032600001102    1C                   ENDIF
032700001102    1C                   IF        KBTDESCR1 <> KATDESCR1 OR
032800001102     C                             KBTDESCR2 <> KATDESCR2
032900001102     C                   MOVE      *ON           *IN41
033000001102    1C                   ENDIF
033100001102    1C                   IF        KBPTADL1 <> KAPTADL1 OR
033200001102     C                             KBPTADL2 <> KAPTADL2 OR
033300001102     C                             KBPTADL3 <> KAPTADL3 OR
033400001102     C                             KBPTADL4 <> KAPTADL4
033500001102     C                   MOVE      *ON           *IN42
033600001102    1C                   ENDIF
033700001102    1C                   IF        KBSTLOSS <> KASTLOSS
033800001102     C                   MOVE      *ON           *IN43
033900001102    1C                   ENDIF
034000001102    1C                   IF        KBTRNBIL <> KATRNBIL
034100001102     C                   MOVE      *ON           *IN44
034200001102    1C                   ENDIF
034300001102    1C                   IF        KBTSCODE <> KATSCODE
034400001102     C                   MOVE      *ON           *IN45
034500001102    1C                   ENDIF
034600001102    1C                   IF        KBTRDLTD <> KATRDLTD
034700001102     C                   MOVE      *ON           *IN46
034800001102    1C                   ENDIF
034900001102    1C                   IF        KBCONTDT <> KACONTDT
035000001102     C                   MOVE      *ON           *IN47
035100001102    2C                   IF        KBCONTDT <> 0
035200001102     C                   MOVE      KBCONTDT      #ISO
035300001102     C                   MOVE      #ISO          #USA
035400001102     C                   MOVE      #USA          KBCONTDT
035500001102    2C                   ENDIF
035600001102    2C                   IF        KACONTDT <> 0
035700001102     C                   MOVE      KACONTDT      #ISO
035800001102     C                   MOVE      #ISO          #USA
035900001102     C                   MOVE      #USA          KACONTDT
036000001102    2C                   ENDIF
036100001102    1C                   ENDIF
036200001102     C*
036300001102    SC                   ENDSR
036400001102   S***S
