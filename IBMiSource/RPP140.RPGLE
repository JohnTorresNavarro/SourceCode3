0001009211230002 F******************************************************************
0002009510180003 F* RPP140  GROUP BENEFIT SERVICES SOFTWARE           1995         *
0003009211230007 F*                                                                *
0004009409150005 F*            WRITTEN BY - G.L.C.                                 *
0005009510160006 F*            DATE - 10/95                                        *
0006009211230007 F*                                                                *
0007009502070006 F*  DESCRIPTION - THIS PROGRAM WILL PROVIDE UPDATE OF THE SGR     *
0008009510180007 F*                PACKAGE PLANS THAT WILL BE USED PER ACCOUNT     *
0009009510180008 F*                TO DISPLAY FOR THAT ACCOUNT A SERIES OF         *
0010009510180008 F*                PACKAGES FROM THE F.PACKAG FILE ON THEIR        *
0011009510180008 F*                SMALL GROUP RATER RENEWAL.                      *
0012009510180008 F*                                                                *
0013009812140008 F* DLW 12.98 CHANGE TO PKGP1-9, TO ALPHA FORMAT                   *
0014009211230009 F******************************************************************
0015009211230010 F*                                                                *
001600951018     FRPP140D   CF   E             WORKSTN
001700951018     FPACKAG    UF A E           K DISK
001800951018     FPACCPK    UF A E           K DISK
001900951018     F*ACKL   IF  E           K        DISK
002000951018     F*           PACKR                             KRENAMEPACKRL
002100951018     FACCMST    IF   E           K DISK
002200951018     FACCNAM    IF   E           K DISK
002300951018     F                                     RENAME(ACCMSR:ACCMSL)
002400951016     F*
002500951016     D ERR             S             40    DIM(1) CTDATA PERRCD(1)
002600940915     D*
002700951018     D                 DS
002800951018     D OPACK           C                   CONST('RPP130CL')
002900951017     D                 DS
003000941003     D*
003100951017     D  PK                     1     36
003200981214     D                                     DIM(9)
003300981214     D  PKGP1                  1      4
003400981214     D  PKGP2                  5      8
003500981214     D  PKGP3                  9     12
003600981214     D  PKGP4                 13     16
003700981214     D  PKGP5                 17     20
003800981214     D  PKGP6                 21     24
003900981214     D  PKGP7                 25     28
004000981214     D  PKGP8                 29     32
004100981214     D  PKGP9                 33     36
004200951017     D                 DS
004300951017     D*
004400951018     D  PO                     1     45  0
004500951018     D                                     DIM(9)
004600951018     D  P1                     1      5  0
004700951018     D  P2                     6     10  0
004800951018     D  P3                    11     15  0
004900951018     D  P4                    16     20  0
005000951018     D  P5                    21     25  0
005100951018     D  P6                    26     30  0
005200951018     D  P7                    31     35  0
005300951018     D  P8                    36     40  0
005400951018     D  P9                    41     45  0
005500951017     D                 DS
005600951017     D*
005700951017     D  PW                     1     75  0
005800951017     D                                     DIM(15)
005900951017     D  PK1                    1      5  0
006000951017     D  PK2                    6     10  0
006100951017     D  PK3                   11     15  0
006200951017     D  PK4                   16     20  0
006300951017     D  PK5                   21     25  0
006400951017     D  PK6                   26     30  0
006500951017     D  PK7                   31     35  0
006600951017     D  PK8                   36     40  0
006700951017     D  PK9                   41     45  0
006800951017     D  PK10                  46     50  0
006900951017     D  PK11                  51     55  0
007000951017     D  PK12                  56     60  0
007100951017     D  PK13                  61     65  0
007200951017     D  PK14                  66     70  0
007300951017     D  PK15                  71     75  0
007400951016     D                 DS
007500951016     D  D                      1    675
007600951016     D                                     DIM(15)
007700951016     D  D1                     1     45
007800951016     D  D2                    46     90
007900951016     D  D3                    91    135
008000951016     D  D4                   136    180
008100951016     D  D5                   181    225
008200951016     D  D6                   226    270
008300951016     D  D7                   271    315
008400951016     D  D8                   316    360
008500951016     D  D9                   361    405
008600951016     D  D10                  406    450
008700951016     D  D11                  451    495
008800951016     D  D12                  496    540
008900951016     D  D13                  541    585
009000951016     D  D14                  586    630
009100951016     D  D15                  631    675
009200951017     D                 DS
009300951017     D  DE                     1    360
009400951017     D                                     DIM(9)
009500951017     D  DE1                    1     40
009600951017     D  DE2                   41     80
009700951017     D  DE3                   81    120
009800951017     D  DE4                  121    160
009900951017     D  DE5                  161    200
010000951017     D  DE6                  201    240
010100951017     D  DE7                  241    280
010200951017     D  DE8                  281    320
010300951017     D  DE9                  321    360
010400951018     D                 DS
010500951018     D  AD                     1    600
010600951018     D                                     DIM(15)
010700951018     D  AD1                    1     40
010800951018     D  AD2                   41     80
010900951018     D  AD3                   81    120
011000951018     D  AD4                  121    160
011100951018     D  AD5                  161    200
011200951018     D  AD6                  201    240
011300951018     D  AD7                  241    280
011400951018     D  AD8                  281    320
011500951018     D  AD9                  321    360
011600951018     D  AD10                 361    400
011700951018     D  AD11                 401    440
011800951018     D  AD12                 441    480
011900951018     D  AD13                 481    520
012000951018     D  AD14                 521    560
012100951018     D  AD15                 561    600
012200951018     D                 DS
012300951018     D  AN                     1    150  0
012400951018     D                                     DIM(15)
012500951018     D  AC1                    1     10  0
012600951018     D  AC2                   11     20  0
012700951018     D  AC3                   21     30  0
012800951018     D  AC4                   31     40  0
012900951018     D  AC5                   41     50  0
013000951018     D  AC6                   51     60  0
013100951018     D  AC7                   61     70  0
013200951018     D  AC8                   71     80  0
013300951018     D  AC9                   81     90  0
013400951018     D  AC10                  91    100  0
013500951018     D  AC11                 101    110  0
013600951018     D  AC12                 111    120  0
013700951018     D  AC13                 121    130  0
013800951018     D  AC14                 131    140  0
013900951018     D  AC15                 141    150  0
014000951018     D                 DS
014100951018     D*
014200951018     D  APK                    1     45  0
014300951018     D                                     DIM(9)
014400951018     D  PAGP1                  1      5  0
014500951018     D  PAGP2                  6     10  0
014600951018     D  PAGP3                 11     15  0
014700951018     D  PAGP4                 16     20  0
014800951018     D  PAGP5                 21     25  0
014900951018     D  PAGP6                 26     30  0
015000951018     D  PAGP7                 31     35  0
015100951018     D  PAGP8                 36     40  0
015200951018     D  PAGP9                 41     45  0
015300951018     D                 DS
015400951018     D  ATSA                   1     10  0
015500951018     D  ATST                   1      3  0
015600951018     D  ASUB                   4      6  0
015700951018     D  AACC                   7     10  0
015800951018     D                 DS
015900951018     D  KTSA                   1     10  0
016000951018     D  KPTST                  1      3  0
016100951018     D  KPSUB                  4      6  0
016200951018     D  KPACC                  7     10  0
016300951018     D                 DS
016400951018     D  ACKY                   1     10  0
016500951018     D  ACTRST                 1      3  0
016600951018     D  ACSUB#                 4      6  0
016700951018     D  ACACCT                 7     10  0
016800940915     C************************************************
016900940915     C************************************************
017000951016     C* KEY PACKAGE MASTER FILE
017100951016     C     KEYPAK        KLIST
017200951016     C                   KFLD                    KPAK              5 0
017300950207     C************************************************
017400951018     C************************************************
017500951018     C* KEY ACCOUNT PACKAGE MASTER FILE
017600951018     C     KEYAP         KLIST
017700951018     C                   KFLD                    KTSA
017800951018     C************************************************
017900951016     C************************************************
018000951016     C* KEY PACKAGE LOGICAL FILE
018100951016     C     KEYPKL        KLIST
018200951018     C                   KFLD                    KPAKL            50
018300951016     C************************************************
018400951016     C************************************************
018500951018     C* KEY ACCOUNT MASTER FILE
018600951018     C     KEYACC        KLIST
018700951017     C                   KFLD                    KTST              3 0
018800951017     C                   KFLD                    KSUB              3 0
018900951018     C                   KFLD                    KACC              4 0
019000951018     C************************************************
019100951018     C* KEY ACCOUNT LOGICAL BY NAME
019200951018     C     KEYACN        KLIST
019300951018     C                   KFLD                    KACN             40
019400951016     C************************************************
019500940929     C*
019600951016     C* GET SELECTION - EITHER DIRECT PACKAGE NUMBER OR
019700951016     C* PACKAGE DESCRIPTION. IF PACKAGE DESC.,DISPLAY WINDOW
019800940929     C******************************************************
019900951016     C     #BEG          TAG
020000950208     C*
020100951018     C* OPEN FILE PACKAG TO ALLOW UPDATE, SO THAT THE CALL
020200951018     C* IN SUBR $WIND CAN CALL PROGRAM RPP130. HOWEVER, NEVER
020300951018     C* ACTUALLY LET THE FILE BE WRITTEN.
020400951018     C                   MOVE      'NEVER'       UPFLG             5
020500951018     C     UPFLG         IFNE      'NEVER'
020600951018     C                   WRITE     PACKR
020700951018     C                   END
020800951018     C* INITIALIZE ARRAYS AND FIELDS
020900951018     C*
021000951018     C                   MOVE      *BLANKS       ANAMIN
021100981214     C                   MOVE      *BLANKS       PK
021200951018     C                   Z-ADD     0             PO
021300951018     C                   Z-ADD     0             PW
021400951018     C                   Z-ADD     0             ATST
021500951018     C                   Z-ADD     0             ASUB
021600951018     C                   Z-ADD     0             AACC
021700951016     C                   EXFMT     SCRN01
021800950207     C* FUNCTION KEY 7 TO END PROGRAM
021900951016     C     *IN07         CABEQ     '1'           ENDPGM
022000950207     C*
022100950207     C******************************************************
022200950207     C* MOVE SELECTION TO KEY AND RETRIEVE RECORD
022300950207     C*
022400951018     C     ATST          IFEQ      0
022500951018     C                   EXSR      $WIND2
022600951016     C                   END
022700951017     C*
022800951017     C     #AGN          TAG
022900951017     C                   MOVE      *BLANKS       DE
023000950207     C*
023100951018     C                   Z-ADD     ATST          KTST
023200951018     C                   Z-ADD     ASUB          KSUB
023300951018     C                   Z-ADD     AACC          KACC
023400951018     C                   Z-ADD     ATST          KPTST
023500951018     C                   Z-ADD     ASUB          KPSUB
023600951018     C                   Z-ADD     AACC          KPACC
023700951018     C     KEYACC        CHAIN     ACCMST                             99
023800951018     C                   MOVEL     ACNAM1        ANAM
023900951018     C                   MOVE      ACKY          AC#
024000951018     C     KEYAP         CHAIN     PACCPK                             10
024100951016     C* IF NOT THERE, DISPLAY EMPTY SCREEN
024200951016     C     *IN10         CABEQ     '1'           #OVR
024300951016     C*
024400951018     C                   MOVEA     APK           PO
024500951017     C                   Z-ADD     1             Y                 2 0
024600951025     C     Y             DOUGT     9
024700951018     C     PO(Y)         IFNE      0
024800951018     C                   Z-ADD     PO(Y)         KPAK
024900951018     C     KEYPAK        CHAIN     PACKAG                             20
025000951018     C* IF PACKAGE DOES NOT EXIST, DISPLAY ERROR MSG
025100951017     C   20              MOVE      ERR(1)        DE(Y)
025200951018     C  N20              MOVEL     PKGDSC        DE(Y)
025300951024     C                   UNLOCK    PACKAG
025400951016     C                   END
025500951017     C                   ADD       1             Y
025600951017     C                   ENDDO
025700950207     C******************************************************
025800950207     C* WRITE SCREEN FOR OPERATOR INPUT
025900950207     C******************************************************
026000951016     C     #OVR          TAG
026100951016     C*
026200951017     C   10              MOVE      *BLANKS       DE
026300951016     C                   EXFMT     SCRN02
026400951018     C* COMMAND 1 TO RETURN TO FIRST SCREEN
026500951016     C     *IN01         CABEQ     '1'           #BEG
026600950207     C*
026700950207     C* FUNCTION KEY 7 TO END PROGRAM
026800951016     C     *IN07         CABEQ     '1'           ENDPGM
026900950208     C*
027000951018     C* FUNCTION KEY 5 TO SEE PACKAGES MASTER FILE
027100951018     C     *IN05         CASEQ     '1'           $WIND
027200951018     C                   ENDCS
027300951018     C*
027400951018     C                   Z-ADD     ATSA          PACC
027500951018     C                   MOVEA     PO            APK
027600951017     C*
027700951018     C* UPDATE SCREEN INPUT TO PACKAGE RECORD
027800951018     C  N10              UPDATE    PACCR
027900951018     C* WRITE NEW PACKAGE RECORD
028000951018     C   10              WRITE     PACCR
028100950208     C*
028200951018     C* DISPLAY SCREEN INPUT FOR VERIFICATION
028300951016     C                   GOTO      #AGN
028400950208     C*
028500950208     C     ENDPGM        TAG
028600950208     C                   SETON                                        LR
028700951018     C*******************************************************
028800951016     C*******************************************************
028900951016     C     $WIND         BEGSR
029000951018     C* KEYPKL IS KEY FIELD FOR ALPHA SEARCH WINDOW
029100951018     C                   CALL      OPACK
029200951016     C                   ENDSR
029300951016     C*******************************
029400951018     C*******************************************************
029500951018     C     $WIND2        BEGSR
029600951018     C* KEYPKL IS KEY FIELD FOR ALPHA ACCOUNT SEARCH WINDOW
029700951018     C                   MOVEL     ANAMIN        KACN
029800951018     C                   Z-ADD     0             AN
029900951018     C                   MOVE      *BLANKS       AD
030000951018     C     BEGIN2        TAG
030100951018     C     KEYACN        SETLL     ACCNAM
030200951018     C********************************
030300951018     C* FILL SEARCH WINDOW WITH ACCOUNT NAMES
030400951018     C*
030500951018     C                   Z-ADD     1             Z                 2 0
030600951018     C     Z             DOUGT     15
030700951018     C                   READ      ACCMSL                                 76
030800951018     C* FILL SCREEN WITH ACCOUNT NUMBERS AND NAMES
030900951018     C  N76              MOVEL     ACNAM1        AD(Z)
031000951018     C  N76ATRMDT        IFGT      0
031100951018     C                   MOVE      'CANCELED'    AD(Z)
031200951018     C                   END
031300951018     C  N76              MOVE      ACKY          AN(Z)
031400951018     C                   ADD       1             Z
031500951018     C                   ENDDO
031600951018     C*******************************
031700951018     C                   EXFMT     WINDO2
031800951018     C                   READ      ACCMSL                                 76
031900951018     C                   MOVEL     ACNAM1        KACN
032000951018     C* IF NO SELECTION, START FROM WHERE WINDOW LEFT OFF
032100951018     C* AND DISPLAY NEXT FIFTEEN RECORDS
032200951018     C     SELECT        IFEQ      0
032300951018     C                   GOTO      BEGIN2
032400951018     C                   ELSE
032500951018     C* PLACE SELECTED ACCOUNT NAME AND NUMBER INTO SCRN02 FIELDS
032600951018     C                   Z-ADD     SELECT        Z
032700951018     C                   MOVE      AD(Z)         ANAM
032800951018     C                   MOVE      AN(Z)         AC#
032900951018     C                   MOVE      AN(Z)         ATSA
033000951018     C                   END
033100951018     C                   ENDSR
033200951018     C*******************************
033300951018**
033400951018PLAN NUMBER IN ERROR, PLEASE RE-INTER
