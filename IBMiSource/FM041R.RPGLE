000100991124     F*-------------------------------------------------------------------------
000200000211     F* FM041      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300991124     F*            WRITTEN BY - S.S.K.
000400000211     F*            DATE - 02/00
000500000211     F*  DESCRIPTION - DISPLAY HISTORY RECORDS FOR GROUP RATE MAINTENANCE
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
001800000211     ** 000  SSK  02112000  ORIGINAL SOURCE                               **
001900001019     ** 001  SSK  10192000  CHANGE DATE DISPLAYS AND TYPE CODES           **
002000991209     **                                                                   **
002100991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002200000211     FGRTHIST2  IF   E           K DISK    RENAME(RGRTHIST:BEFSEQ)
002300000211     FGRTHIST3  IF   E           K DISK    RENAME(RGRTHIST:AFTSEQ)
002400001019     FGBSECURE  IF   E           K DISK
002500000428     FFM041D    CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
002600991124   X***X
002700000211     D @PARM           DS
002800000211     D  TRUST#                 1      3S 0
002900000211     D  SUB#                   4      6S 0
003000000211     D  PLANCD                 7     10A
003100000216     D  TRNAME                11     24A
003200000216     D  SBNAME                25     38A
003300000216     D  PCNAME                39     52A
003400001019    ***
003500001019     D #ISO            S               D   DATFMT(*ISO)
003600001019     D #USA            S               D   DATFMT(*USA)
003700000211    ***
003800000211     D                UDS
003900000211     D  TITLE                201    240A
004000000211    ***
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
006400991216     D  F21            C                   CONST(X'B9')
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
007800991124     C*
007900000211     C                   IF        FKEY <> F1
008000991124     C                   EXSR      $DISPLAY
008100991124     C                   ENDIF
008200991124     C*
008300991124     C                   ENDDO
008400991124     C*
008500991124     C                   MOVE      *ON           *INLR
008600991124     C                   RETURN
008700991124   S***S
008800991124     C* ONETIME ROUTINE
008900991124    ***
009000991124     C     ONCE          BEGSR
009100000211    ***
009200000211     C     *ENTRY        PLIST
009300000211     C                   PARM                    @PARM
009400000211    ***
009500000211     C     UNVKEY        KLIST
009600000211     C                   KFLD                    TRUST#
009700000211     C                   KFLD                    SUB#
009800000211     C                   KFLD                    PLANCD
009900991124    ***
010000001019     C     *LIKE         DEFINE    SCUSR         @KEYUSR
010100991124     C                   MOVE      *BLANKS       @ACTNTYPE         1
010200991124    ***
010300991124     C                   MOVE      *ZEROS        RRT               3 0
010400991124     C                   MOVE      *ZEROS        #CNTREC           2 0
010500991124    ***
010600991124     C                   MOVE      '0'           @1STLOOP          1
010700991124     C                   MOVE      '0'           @SFLOOP           1
010800991124     C                   MOVE      '0'           @CNFRM            1
010900991124     C                   MOVE      '1'           @LOOPIT           1
011000991124     C                   MOVE      '0'           @ACTION           1
011100991124     C                   MOVEA     '0'           *IN
011200991124     C                   MOVE      '0'           @EXIT             1
011300000113     C                   MOVE      'M'           @SEQ              1
011400000114     C                   MOVE      *OFF          *IN31
011500000113    ***
011600991124     C                   EXSR      $CLEAR
011700000211    ***
011800991124     C                   EXSR      $BUILD
011900991124     C                   EXSR      $DISPLAY
012000991124    ***
012100991124     C                   ENDSR
012200991124   S***S
012300991124     C* INITIALIZE THE SUBFILE
012400991124    ***
012500991124     C     $CLEAR        BEGSR
012600991124    ***
012700991124     C                   MOVEA     '011'         *IN(25)
012800000211     C                   WRITE     GBSCTL
012900991124     C                   MOVEA     '010'         *IN(25)
013000991124     C                   Z-ADD     *ZERO         RRT
013100991124    ***
013200991124     C                   ENDSR
013300991124   S***S
013400991124     C* DISPLAY THE SCREEN
013500991124    ***
013600991124     C     $DISPLAY      BEGSR
013700991124    ***
013800000211     C                   WRITE     GBSREC
013900000211     C                   EXFMT     GBSCTL
014000991124    ***
014100991124     C                   ENDSR
014200991124   S***S
014300991124     C* CHECK FOR FUNCTION KEY USAGE
014400991124    ***
014500991124     C     $CHKFXN       BEGSR
014600991124    ***
014700000113     C                   SELECT
014800000113     C*
014900000211     C                   WHEN      FKEY = F1
015000000113     C                   MOVE      '1'           @EXIT
015100000113     C                   MOVE      '1'           @ACTION
015200000113     C*
015300000114     C                   WHEN      FKEY = F8
015400000113     C                   EXSR      $ALTSEQ
015500000113     C                   MOVE      '1'           @ACTION
015600000113     C*
015700000113     C                   WHEN      *IN29 = *ON AND *IN30 = *ON
015800000113     C                   EXSR      $RELOAD
015900000113     C                   MOVE      '1'           @ACTION
016000000113     C*
016100000113     C                   ENDSL
016200000113    ***
016300000113     C                   ENDSR
016400000113   S***S
016500000113     C* CHANGE THE PROCESSING SEQUENCE OF THE SUBFILE
016600000113    ***
016700000113     C     $ALTSEQ       BEGSR
016800000113    ***
016900000113     C                   IF        @SEQ = 'M'
017000000113     C                   MOVE      'N'           @SEQ
017100000113     C                   ELSE
017200000113     C                   MOVE      'M'           @SEQ
017300000211     C                   ENDIF
017400000113     C*
017500000113     C                   EXSR      $BUILD
017600000113     C                   MOVE      '1'           @ACTION
017700000113    ***
017800000113     C                   ENDSR
017900000113   S***S
018000000113     C* BUILD SUBFILE CONTROL ROUTINE
018100000113    ***
018200000113     C     $BUILD        BEGSR
018300000113    ***
018400000113     C                   EXSR      $CLEAR
018500000113     C                   MOVE      *ZEROS        #CNTREC
018600000113     C                   MOVE      '0'           @1STLOOP
018700000113     C                   MOVE      '0'           @SFLOOP
018800001019     C                   MOVE      *ZEROS        HFDATE
018900000113    ***
019000000211     C                   IF        @SEQ = 'M'
019100000211     C     UNVKEY        SETLL     BEFSEQ
019200000211     C                   EXSR      $BLDBEF
019300000211     C                   ELSE
019400000211     C     UNVKEY        SETLL     AFTSEQ
019500000211     C                   EXSR      $BLDAFT
019600000211     C                   ENDIF
019700000113    ***
019800000113     C                   ENDSR
019900000113   S***S
020000000211     C* BUILD BY BEFORE IMAGE
020100000113    ***
020200000211     C     $BLDBEF       BEGSR
020300000113    ***
020400000211     C                   DOU       %EOF(GRTHIST2) OR @SFLOOP = '1'
020500000211     C     UNVKEY        READE     BEFSEQ
020600000211     C                   IF        NOT %EOF(GRTHIST2)
020700000113     C                   EXSR      $LOADSFL
020800000113     C                   ENDIF
020900000113     C                   ENDDO
021000000113    ***
021100000211     C                   IF        %EOF(GRTHIST2)
021200000113     C                   MOVE      *OFF          *IN29
021300000113     C                   ELSE
021400000113     C                   MOVE      *ON           *IN29
021500000113     C                   ENDIF
021600000113    ***
021700000113     C                   ENDSR
021800000113   S***S
021900000113     C* LOAD SUBFILE RECORDS
022000000113    ***
022100000113     C     $LOADSFL      BEGSR
022200000113    ***
022300000113     C                   MOVE      *ON           *IN25
022400000211    ***
022500001019     C                   MOVEL(P)  HFUSERID      @KEYUSR
022600001019     C     @KEYUSR       CHAIN     SECR
022700001019     C                   IF        %FOUND(GBSECURE)
022800001019     C                   MOVEL(P)  SCNAME        SFUSERID
022900001019     C                   ELSE
023000001019     C                   MOVE      *BLANKS       SFUSERID
023100001019     C                   END
023200001019     C                   MOVE      HFDATE        #ISO
023300001019     C                   MOVE      #ISO          #USA
023400001019     C                   MOVE      #USA          SFTRNSDATE
023500001019     C                   Z-ADD     HFTIME        SFTRNSTIME
023600001019     C*                  MOVEL(P)  HFJOBNAM      SFJOBNAME
023700001019     C*                  MOVE      HFJOBNBR      SFJOBNUMBR
023800000211     C*
023900001019     C                   Z-ADD     HFBFAGBN      SFBAGEBAND
024000001019     C                   MOVEL(P)  HFBFTYCD      SFBTYPECOD
024100001019     C                   MOVEL     ' '           SFBTYPECOD
024200001019     C                   Z-ADD     HFBFNETR      SFBNETRATE
024300001019     C                   Z-ADD     HFBFBILR      SFBBILLRAT
024400001019     C                   MOVEL(P)  HFBFGRP#      SFBGROUP
024500001019     C                   MOVEL(P)  HFBFDLTC      SFBDLTCODE
024600001019     C                   IF        HFBFFRDT <> 0
024700001019     C                   MOVE      HFBFFRDT      #ISO
024800001019     C                   MOVE      #ISO          #USA
024900001019     C                   MOVE      #USA          SFBFROMDAT
025000001019     C                   ELSE
025100001019     C                   MOVE      *ZEROS        SFBFROMDAT
025200001019     C                   ENDIF
025300001019     C                   IF        HFBFTODT <> 0
025400001019     C                   MOVE      HFBFTODT      #ISO
025500001019     C                   MOVE      #ISO          #USA
025600001019     C                   MOVE      #USA          SFBTODATE
025700001019     C                   ELSE
025800001019     C                   MOVE      *ZEROS        SFBTODATE
025900001019     C                   ENDIF
026000000211     C*
026100001019     C                   Z-ADD     HFAFAGBN      SFAAGEBAND
026200001019     C                   MOVEL(P)  HFAFTYCD      SFATYPECOD
026300001019     C                   MOVEL     ' '           SFATYPECOD
026400001019     C                   Z-ADD     HFAFNETR      SFANETRATE
026500001019     C                   Z-ADD     HFAFBILR      SFABILLRAT
026600001019     C                   MOVEL(P)  HFAFGRP#      SFAGROUP
026700001019     C                   MOVEL(P)  HFAFDLTC      SFADLTCODE
026800001019     C                   IF        HFAFFRDT <> 0
026900001019     C                   MOVE      HFAFFRDT      #ISO
027000001019     C                   MOVE      #ISO          #USA
027100001019     C                   MOVE      #USA          SFAFROMDAT
027200001019     C                   ELSE
027300001019     C                   MOVE      *ZEROS        SFAFROMDAT
027400001019     C                   ENDIF
027500001019     C                   IF        HFAFTODT <> 0
027600001019     C                   MOVE      HFAFTODT      #ISO
027700001019     C                   MOVE      #ISO          #USA
027800001019     C                   MOVE      #USA          SFATODAT
027900001019     C                   ELSE
028000001019     C                   MOVE      *ZEROS        SFATODAT
028100001019     C                   ENDIF
028200001102     C*
028300001102     C                   EXSR      $SETIND
028400000211     C*
028500000113     C                   ADD       1             RRT
028600000113     C                   IF        @1STLOOP = '0'
028700000113     C                   Z-ADD     RRT           SFLPOS
028800000113     C                   MOVE      '1'           @1STLOOP
028900000113     C                   ENDIF
029000000211     C                   WRITE     GBSSFL
029100000113     C*
029200000113     C                   ADD       1             #CNTREC
029300000211     C                   IF        #CNTREC = 240
029400000113     C                   MOVE      '1'           @SFLOOP
029500000211     C*                  EXSR      $CPNXTREC
029600000113     C                   ENDIF
029700001102    ***
029800001102     C                   ENDSR
029900001102   S***S
030000001102     C     $SETIND       BEGSR
030100001102    ***
030200011009     C                   MOVEA     '1111111'     *IN(41)
030300001102     C*
030400011009    *C*                  IF        HFBFFRDT <> HFAFFRDT OR
030500011009    *C*                            HFBFTODT <> HFAFTODT
030600011009    *C*                  MOVE      *ON           *IN41
030700011009    *C*                  ENDIF
030800011009    *C*
030900011009    *C*                  IF        HFBFAGBN <> HFAFAGBN
031000011009    *C*                  MOVE      *ON           *IN42
031100011009    *C*                  ENDIF
031200011009    *C*
031300011009    *C*                  IF        HFBFTYCD <> HFAFTYCD
031400011009    *C*                  MOVE      *ON           *IN43
031500011009    *C*                  ENDIF
031600011009    *C*
031700011009    *C*                  IF        HFBFNETR <> HFAFNETR
031800011009    *C*                  MOVE      *ON           *IN44
031900011009    *C*                  ENDIF
032000011009    *C*
032100011009    *C*                  IF        HFBFBILR <> HFAFBILR
032200011009    *C*                  MOVE      *ON           *IN45
032300011009    *C*                  ENDIF
032400011009    *C*
032500011009    *C*                  IF        HFBFGRP# <> HFAFGRP#
032600011009    *C*                  MOVE      *ON           *IN46
032700011009    *C*                  ENDIF
032800011009    *C*
032900011009    *C*                  IF        HFBFDLTC <> HFAFDLTC
033000011009    *C*                  MOVE      *ON           *IN47
033100011009    *C*                  ENDIF
033200001102     C*
033300000113    ***
033400000113     C                   ENDSR
033500000113   S***S
033600000211     C* BUILD BY AFTER  IMAGE
033700000113    ***
033800000211     C     $BLDAFT       BEGSR
033900000211    ***
034000001019     C                   MOVE      *ZEROS        HFDATE
034100000211     C*
034200000211     C     UNVKEY        SETLL     AFTSEQ
034300000211     C                   DOU       %EOF(GRTHIST3) OR @SFLOOP = '1'
034400000211     C     UNVKEY        READE     AFTSEQ
034500000211     C                   IF        NOT %EOF(GRTHIST3)
034600000211     C                   EXSR      $LOADSFL
034700000211     C                   ENDIF
034800000211     C                   ENDDO
034900000211    ***
035000000211     C                   IF        %EOF(GRTHIST3)
035100000211     C                   MOVE      *OFF          *IN29
035200000211     C                   ELSE
035300000211     C                   MOVE      *ON           *IN29
035400000211     C                   ENDIF
035500000211    ***
035600000211     C                   ENDSR
035700000113   S***S
035800000113     C* ROLL CONTROL
035900000113    ***
036000000113     C     $RELOAD       BEGSR
036100000211    ***
036200000211     C                   EXSR      $CLEAR
036300000211     C                   MOVE      *ZEROS        #CNTREC
036400000211     C                   MOVE      '0'           @1STLOOP
036500000211     C                   MOVE      '0'           @SFLOOP
036600000211    ***
036700000211     C                   IF        @SEQ = 'M'
036800000211     C                   EXSR      $BLDBEF
036900000211     C                   ELSE
037000000211     C                   EXSR      $BLDAFT
037100000211     C                   ENDIF
037200000211    ***
037300000113     C                   ENDSR
037400000113     C**************************************************************************
