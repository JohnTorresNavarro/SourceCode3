000100991124     F*-------------------------------------------------------------------------
000200000222     F* FM021      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300991124     F*            WRITTEN BY - S.S.K.
000400000211     F*            DATE - 02/00
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
001900991209     **                                                                   **
002000991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100220817     FSUBHIST1  IF   E           K DISK    extfile('F.SUBHIST1')
002200220817     FTRSMST    IF   E           K DISK    extfile('F.TRSMST')
002300001019     FGBSECURE  IF   E           K DISK
002400000428     FFM021D    CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
002500991124   X***X
002600220817     D*@PARM           DS
002700220817     D* TRUST#                 1      3S 0
002800220817     D* SUBNO                  4      6S 0
002900001019    ***
003000001019     D #USA            S               D   DATFMT(*USA)
003100001019     D #ISO            S               D   DATFMT(*ISO)
003200000211    ***
003300000211     D                UDS
003400000211     D  TITLE                201    240A
003500000222    ***
003600000222     D HASUBDSC        DS
003700000222     D  HASUBDSC1              1     25A
003800000222     D  HASUBDSC2             26     50A
003900000222    ***
004000000222     D HBSUBDSC        DS
004100000222     D  HBSUBDSC1              1     25A
004200000222     D  HBSUBDSC2             26     50A
004300000211    ***
004400000222     D HAIDVARY        DS
004500000222     D  HAIDVARY1              1     25A
004600000222     D  HAIDVARY2             26     45A
004700000222    ***
004800000222     D HBIDVARY        DS
004900000222     D  HBIDVARY1              1     25A
005000000222     D  HBIDVARY2             26     45A
005100000222    ***
005200000222     D                 DS
005300000222     D @BH                     1    126A
005400000222     D  HBIH1T                 1      7A
005500000222     D  HBIH1B                 8     14A
005600000222     D  HBIH2T                15     21A
005700000222     D  HBIH2B                22     28A
005800000222     D  HBIH3T                29     35A
005900000222     D  HBIH3B                36     42A
006000000222     D  HBIH4T                43     49A
006100000222     D  HBIH4B                50     56A
006200000222     D  HBIH5T                57     63A
006300000222     D  HBIH5B                64     70A
006400000222     D  HBIH6T                71     77A
006500000222     D  HBIH6B                78     84A
006600000222     D  HBIH7T                85     91A
006700000222     D  HBIH7B                92     98A
006800000222     D  HBIH8T                99    105A
006900000222     D  HBIH8B               106    112A
007000000222     D  HBIH9T               113    119A
007100000222     D  HBIH9B               120    126A
007200000222    ***
007300000222     D                 DS
007400000222     D @AH                     1    126A
007500000222     D  HAIH1T                 1      7A
007600000222     D  HAIH1B                 8     14A
007700000222     D  HAIH2T                15     21A
007800000222     D  HAIH2B                22     28A
007900000222     D  HAIH3T                29     35A
008000000222     D  HAIH3B                36     42A
008100000222     D  HAIH4T                43     49A
008200000222     D  HAIH4B                50     56A
008300000222     D  HAIH5T                57     63A
008400000222     D  HAIH5B                64     70A
008500000222     D  HAIH6T                71     77A
008600000222     D  HAIH6B                78     84A
008700000222     D  HAIH7T                85     91A
008800000222     D  HAIH7B                92     98A
008900000222     D  HAIH8T                99    105A
009000000222     D  HAIH8B               106    112A
009100000222     D  HAIH9T               113    119A
009200000222     D  HAIH9B               120    126A
009300000222    ***
009400991216     D WSDS            DS
009500991216     D  FKEY                 369    369A
009600991216    ***
009700991216     D  F1             C                   CONST(X'31')
009800991216     D  F2             C                   CONST(X'32')
009900991216     D  F3             C                   CONST(X'33')
010000991216     D  F4             C                   CONST(X'34')
010100991216     D  F5             C                   CONST(X'35')
010200991216     D  F6             C                   CONST(X'36')
010300991216     D  F7             C                   CONST(X'37')
010400991216     D  F8             C                   CONST(X'38')
010500991216     D  F9             C                   CONST(X'39')
010600991216     D  F10            C                   CONST(X'3A')
010700991216     D  F11            C                   CONST(X'3B')
010800991216     D  F12            C                   CONST(X'3C')
010900991216     D  F13            C                   CONST(X'B1')
011000991216     D  F14            C                   CONST(X'B2')
011100991216     D  F15            C                   CONST(X'B3')
011200991216     D  F16            C                   CONST(X'B4')
011300991216     D  F17            C                   CONST(X'B5')
011400991216     D  F18            C                   CONST(X'B6')
011500991216     D  F19            C                   CONST(X'B7')
011600991216     D  F20            C                   CONST(X'B8')
011700991216     D  F21            C                   CONST(X'B9')
011800991216     D  F22            C                   CONST(X'BA')
011900991216     D  F23            C                   CONST(X'BB')
012000991216     D  F24            C                   CONST(X'BC')
012001220817
012002220817     d fm021r          pi
012003220817     D  trust#                        3  0
012004220817     D  subno                         3  0
012100991124   X***X
012200991124     C* MAINLINE
012300991124    ***
012400991124     C                   EXSR      ONCE
012500991124     C*
012600991216     C                   DOU       @EXIT = '1'
012700991124     C*
012800991124     C                   MOVE      '0'           @ACTION
012900991124     C*
013000991124     C                   EXSR      $CHKFXN
013100000222     C*
013200000222     C                   IF        FKEY <> F1
013300000222     C                   EXSR      $CHKSELC
013400000222     C                   ENDIF
013500991124     C*
013600000211     C                   IF        FKEY <> F1
013700991124     C                   EXSR      $DISPLAY
013800991124     C                   ENDIF
013900991124     C*
014000991124     C                   ENDDO
014100991124     C*
014200991124     C                   MOVE      *ON           *INLR
014300991124     C                   RETURN
014400991124   S***S
014500991124     C* ONETIME ROUTINE
014600991124    ***
014700991124     C     ONCE          BEGSR
014800000211    ***
014900220817     C**** *ENTRY        PLIST
015000220817     C****               PARM                    @PARM
015100000222    ***
015200000222     C     *LIKE         DEFINE    HTRST         #KEYTRST
015300000222     C     *LIKE         DEFINE    HSUB          #KEYSUB
015400001019     C     *LIKE         DEFINE    SCUSR         @KEYSC
015500000222    ***
015600991124     C                   MOVE      *BLANKS       @ACTNTYPE         1
015700991124    ***
015800991124     C                   MOVE      *ZEROS        RRT               3 0
015900991124     C                   MOVE      *ZEROS        #CNTREC           2 0
016000991124    ***
016100991124     C                   MOVE      '0'           @1STLOOP          1
016200991124     C                   MOVE      '0'           @SFLOOP           1
016300991124     C                   MOVE      '0'           @CNFRM            1
016400991124     C                   MOVE      '1'           @LOOPIT           1
016500991124     C                   MOVE      '0'           @ACTION           1
016600991124     C                   MOVEA     '0'           *IN
016700991124     C                   MOVE      '0'           @EXIT             1
016800000114     C                   MOVE      *OFF          *IN31
016900000222    ***
017000000222     C     @SUBKEY       KLIST
017100000222     C                   KFLD                    #KEYTRST
017200000222     C                   KFLD                    #KEYSUB
017300000113    ***
017400000222     C                   Z-ADD     TRUST#        #KEYTRST
017500000222     C                   Z-ADD     SUBNO         #KEYSUB
017600000222    ***
017700000222     C     #KEYTRST      CHAIN(N)  TRSMSR
017800000222    ***
017900991124     C                   EXSR      $CLEAR
018000000211    ***
018100991124     C                   EXSR      $BUILD
018200991124     C                   EXSR      $DISPLAY
018300991124    ***
018400991124     C                   ENDSR
018500991124   S***S
018600991124     C* INITIALIZE THE SUBFILE
018700991124    ***
018800991124     C     $CLEAR        BEGSR
018900991124    ***
019000991124     C                   MOVEA     '011'         *IN(25)
019100000211     C                   WRITE     GBSCTL
019200991124     C                   MOVEA     '010'         *IN(25)
019300991124     C                   Z-ADD     *ZERO         RRT
019400991124    ***
019500991124     C                   ENDSR
019600991124   S***S
019700991124     C* DISPLAY THE SCREEN
019800991124    ***
019900991124     C     $DISPLAY      BEGSR
020000991124    ***
020100000211     C                   WRITE     GBSREC
020200000211     C                   EXFMT     GBSCTL
020300991124    ***
020400991124     C                   ENDSR
020500991124   S***S
020600991124     C* CHECK FOR FUNCTION KEY USAGE
020700991124    ***
020800991124     C     $CHKFXN       BEGSR
020900991124    ***
021000000113     C                   SELECT
021100000113     C*
021200000211     C                   WHEN      FKEY = F1
021300000113     C                   MOVE      '1'           @EXIT
021400000113     C*
021500000113     C                   WHEN      *IN29 = *ON AND *IN30 = *ON
021600000113     C                   EXSR      $RELOAD
021700000113     C                   MOVE      '1'           @ACTION
021800000113     C*
021900000113     C                   ENDSL
022000000113    ***
022100000113     C                   ENDSR
022200000113   S***S
022300000113     C* BUILD SUBFILE CONTROL ROUTINE
022400000113    ***
022500000113     C     $BUILD        BEGSR
022600000113    ***
022700000113     C                   EXSR      $CLEAR
022800000113     C                   MOVE      *ZEROS        #CNTREC
022900000113     C                   MOVE      '0'           @1STLOOP
023000000113     C                   MOVE      '0'           @SFLOOP
023100000113    ***
023200000222     C     @SUBKEY       SETLL     RSUBHIST
023300000222     C                   DOU       %EOF(SUBHIST1) OR @SFLOOP = '1'
023400000222     C     @SUBKEY       READE     RSUBHIST
023500000222     C                   IF        NOT %EOF(SUBHIST1)
023600000113     C                   EXSR      $LOADSFL
023700000113     C                   ENDIF
023800000113     C                   ENDDO
023900000113    ***
024000000222     C                   IF        %EOF(SUBHIST1)
024100000113     C                   MOVE      *OFF          *IN29
024200000113     C                   ELSE
024300000113     C                   MOVE      *ON           *IN29
024400000113     C                   ENDIF
024500000113    ***
024600000113     C                   ENDSR
024700000113   S***S
024800000113     C* LOAD SUBFILE RECORDS
024900000113    ***
025000000113     C     $LOADSFL      BEGSR
025100000113    ***
025200000113     C                   MOVE      *ON           *IN25
025300000211    ***
025400001019***********              MOVEL(P)  HUSERID       SFUSERID
025500001019     C                   MOVEL(P)  HUSERID       @KEYSC
025600001019     C     @KEYSC        CHAIN     SECR
025700001019     C                   IF        %FOUND(GBSECURE)
025800001019     C                   MOVEL     SCNAME        SFUSERID
025900001019     C                   ELSE
026000001019     C                   MOVE      *BLANKS       SFUSERID
026100001019     C                   ENDIF
026200001019*********                Z-ADD     HDATE         SFDATE
026300001019     C                   MOVE      HDATE         #ISO
026400001019     C                   MOVE      #ISO          #USA
026500001019     C                   MOVE      #USA          SFDATE
026600000222     C                   Z-ADD     HTIME         SFTIME
026700000211     C*
026800000222     C                   MOVEL(P)  HBSUBNAM      SFBSUBNAM
026900000222     C                   MOVEL(P)  HBSUBDSC      SFBSUBDSC
027000000222     C                   Z-ADD     HBSADMFE      SFBSADMFE
027100000222     C                   Z-ADD     HBAFICOL      SFBAFICOL
027200000222     C                   Z-ADD     HBCOMFEE      SFBCOMFEE
027300000222     C                   Z-ADD     HBGRCPRD      SFBGRCPRD
027400000222     C                   MOVEL(P)  HBIDVARY      SFBIDVARY
027500000222     C                   Z-ADD     HBDUEDAY      SFBDUEDAY
027600000222     C                   MOVEL(P)  HBSBDLTD      SFBSBDLTD
027700000211     C*
027800000222     C                   MOVEL(P)  HASUBNAM      SFASUBNAM
027900000222     C                   MOVEL(P)  HASUBDSC      SFASUBDSC
028000000222     C                   Z-ADD     HASADMFE      SFASADMFE
028100000222     C                   Z-ADD     HAAFICOL      SFAAFICOL
028200000222     C                   Z-ADD     HACOMFEE      SFACOMFEE
028300000222     C                   Z-ADD     HAGRCPRD      SFAGRCPRD
028400000222     C                   MOVEL(P)  HAIDVARY      SFAIDVARY
028500000222     C                   Z-ADD     HADUEDAY      SFADUEDAY
028600000222     C                   MOVEL(P)  HASBDLTD      SFASBDLTD
028700000222     C*
028800000222     C                   IF        @BH <> *BLANKS AND @AH <> *BLANKS
028900000222     C                   MOVE(P)   'YES'         SFYORN
029000000222     C                   ELSE
029100000222     C                   MOVE(P)   'NO'          SFYORN
029200000222     C                   ENDIF
029300000211     C*
029400000113     C                   ADD       1             RRT
029500000113     C                   IF        @1STLOOP = '0'
029600000113     C                   Z-ADD     RRT           SFLPOS
029700000113     C                   MOVE      '1'           @1STLOOP
029800000113     C                   ENDIF
029900000211     C                   WRITE     GBSSFL
030000000113     C*
030100000113     C                   ADD       1             #CNTREC
030200000211     C                   IF        #CNTREC = 240
030300000113     C                   MOVE      '1'           @SFLOOP
030400000222     C                   ENDIF
030500000113    ***
030600000113     C                   ENDSR
030700000113   S***S
030800000113     C* ROLL CONTROL
030900000113    ***
031000000113     C     $RELOAD       BEGSR
031100000211    ***
031200000211     C                   EXSR      $CLEAR
031300000211     C                   MOVE      *ZEROS        #CNTREC
031400000211     C                   MOVE      '0'           @1STLOOP
031500000211     C                   MOVE      '0'           @SFLOOP
031600000211    ***
031700000222     C                   EXSR      $BUILD
031800000211    ***
031900000113     C                   ENDSR
032000000222   S***S
032100000222    SC     $CHKSELC      BEGSR
032200000222     C*
032300000222     C                   MOVE      *OFF          *IN33
032400001122    1C                   DOU       *IN33 = *ON OR *IN34 = *ON
032500001122     C                   READC     GBSSFL                               3433
032600001122    2C                   IF        *IN33 = *OFF AND *IN34 = *OFF
032700000222     C*
032800000222     C                   IF        SEL01 <> *BLANKS
032900000222     C*
033000000222    3C                   IF        SEL01 = 'X'
033100001019     C                   MOVE      HDATE         #ISO
033200001019     C                   MOVE      #ISO          #USA
033300001019     C                   MOVE      #USA          HDATE
033400001102     C*
033500001102     C                   MOVE      SFUSERID      HUSERID
033600001102     C                   EXSR      $SETIND
033700000222     C*
033800000222     C                   MOVE      *OFF          *IN50
033900000222     C                   DOU       FKEY = F1
034000000222     C                   EXFMT     EXPNDSCRN
034100000222     C                   IF        FKEY = F11
034200000222     C                   IF        *IN50 = *OFF
034300000222     C                   MOVE      *ON           *IN50
034400000222     C                   ELSE
034500000222     C                   MOVE      *OFF          *IN50
034600000222     C                   ENDIF
034700000222     C                   ENDIF
034800000222     C                   ENDDO
034900000222     C*
035000000222    3C                   ENDIF
035100000222     C*
035200000222     C                   MOVE      *BLANKS       SEL01
035300000222     C                   UPDATE    GBSSFL
035400000222     C*
035500000222    3C                   ENDIF
035600000222     C*
035700000222    2C                   ENDIF
035800000222     C*
035900000222    1C                   ENDDO
036000000222     C*
036100000222     C                   MOVE      X'BC'         FKEY
036200000222     C                   MOVE      '0'           @EXIT
036300001102     C*
036400001102    SC                   ENDSR
036500001102   S***S
036600001102     C     $SETIND       BEGSR
036700001102     C*
036800001102     C                   MOVEA     '0000000000'  *IN(31)
036900001102     C                   MOVEA     '00000000'    *IN(41)
037000001102     C*
037100001102     C                   IF        HBSUBNAM <> HASUBNAM
037200001102     C                   MOVE      *ON           *IN31
037300001102     C                   ENDIF
037400001102     C                   IF        HBSUBDSC1 <> HASUBDSC1 OR
037500001102     C                             HBSUBDSC2 <> HASUBDSC2
037600001102     C                   MOVE      *ON           *IN32
037700001102     C                   ENDIF
037800001102     C                   IF        HBIH1T <> HAIH1T OR HBIH1B <> HAIH1B
037900001102     C                   MOVE      *ON           *IN33
038000001102     C                   ENDIF
038100001102     C                   IF        HBIH2T <> HAIH2T OR HBIH2B <> HAIH2B
038200001102     C                   MOVE      *ON           *IN34
038300001102     C                   ENDIF
038400001102     C                   IF        HBIH3T <> HAIH3T OR HBIH3B <> HAIH3B
038500001102     C                   MOVE      *ON           *IN35
038600001102     C                   ENDIF
038700001102     C                   IF        HBIH4T <> HAIH4T OR HBIH4B <> HAIH4B
038800001102     C                   MOVE      *ON           *IN36
038900001102     C                   ENDIF
039000001102     C                   IF        HBIH5T <> HAIH5T OR HBIH5B <> HAIH5B
039100001102     C                   MOVE      *ON           *IN37
039200001102     C                   ENDIF
039300001102     C                   IF        HBIH6T <> HAIH6T OR HBIH6B <> HAIH6B
039400001102     C                   MOVE      *ON           *IN38
039500001102     C                   ENDIF
039600001103     C                   IF        HBIH7T <> HAIH7T OR HBIH7B <> HAIH7B
039700001102     C                   MOVE      *ON           *IN39
039800001102     C                   ENDIF
039900001102     C                   IF        HBIH8T <> HAIH8T OR HBIH8B <> HAIH8B
040000001102     C                   MOVE      *ON           *IN40
040100001102     C                   ENDIF
040200001102     C                   IF        HBIH9T <> HAIH9T OR HBIH9B <> HAIH9B
040300001102     C                   MOVE      *ON           *IN41
040400001102     C                   ENDIF
040500001102     C                   IF        HBSADMFE <> HASADMFE
040600001102     C                   MOVE      *ON           *IN42
040700001102     C                   ENDIF
040800001102     C                   IF        HBAFICOL <> HAAFICOL
040900001102     C                   MOVE      *ON           *IN43
041000001102     C                   ENDIF
041100001102     C                   IF        HBCOMFEE <> HACOMFEE
041200001102     C                   MOVE      *ON           *IN44
041300001102     C                   ENDIF
041400001102     C                   IF        HBGRCPRD <> HAGRCPRD
041500001102     C                   MOVE      *ON           *IN45
041600001102     C                   ENDIF
041700001102     C                   IF        HBIDVARY1 <> HAIDVARY1 OR
041800001102     C                             HBIDVARY2 <> HAIDVARY2
041900001102     C                   MOVE      *ON           *IN46
042000001102     C                   ENDIF
042100001102     C                   IF        HBDUEDAY <> HADUEDAY
042200001102     C                   MOVE      *ON           *IN47
042300001102     C                   ENDIF
042400001102     C                   IF        HBSBDLTD <> HASBDLTD
042500001102     C                   MOVE      *ON           *IN48
042600001102     C                   ENDIF
042700001102     C*
042800000222    SC                   ENDSR
042900000222   S***S
