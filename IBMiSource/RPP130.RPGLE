0001009211230002 F******************************************************************
0002009510160003 F* RPP130  GROUP BENEFIT SERVICES SOFTWARE           1995         *
0003009211230007 F*                                                                *
0004009409150005 F*            WRITTEN BY - G.L.C.                                 *
0005009510160006 F*            DATE - 10/95                                        *
0006009211230007 F*                                                                *
0007009502070006 F*  DESCRIPTION - THIS PROGRAM WILL PROVIDE UPDATE OF THE SGR     *
0008009510160007 F*                PACKAGE PLANS FILE. THIS FILE HOLDS THE         *
0009009510160008 F*                PLANS THAT COMPRISE A SINGLE PACKAGE FOR THE    *
0010009510160008 F*                SGR SMALL GROUP RATER. A SELECTION OF THESE     *
0011009510160008 F*                PACKAGES WILL BE USED AT THE ACCOUNT LEVEL      *
0012009510160008 F*                TO CUSTOMIZE EACH RENEWAL PER ACCOUNT.          *
0013009812100008 F* DLW 12.98 CHANGE TO PLAN CODE DUE TO ALPHA FORMAT.             *
0014009211230009 F******************************************************************
0015009211230010 F*                                                                *
001600951016     FRPP130D   CF   E             WORKSTN
001700951016     FPACKAG    UF A E           K DISK
001800951017     FPACKL     IF   E           K DISK
001900951016     F                                     RENAME(PACKR:PACKRL)
002000951017     FPLNMST    IF   E           K DISK
002100951016     F*
002200951016     D ERR             S             40    DIM(1) CTDATA PERRCD(1)
002300940915     D*
002400951017     D                 DS
002500941003     D*
002600960410     D  PK                     1     60
002700990513     D                                     DIM(15)
002800981210     D  PKGP1                  1      4
002900981210     D  PKGP2                  5      8
003000981210     D  PKGP3                  9     12
003100981210     D  PKGP4                 13     16
003200981210     D  PKGP5                 17     20
003300981210     D  PKGP6                 21     24
003400981210     D  PKGP7                 25     28
003500981210     D  PKGP8                 29     32
003600981210     D  PKGP9                 33     36
003700981210     D  PKGP10                37     40
003800981210     D  PKGP11                41     44
003900981210     D  PKGP12                45     48
004000981210     D  PKGP13                49     52
004100981210     D  PKGP14                53     56
004200981210     D  PKGP15                57     60
004300951017     D                 DS
004400951017     D*
004500960410     D  PO                     1     60
004600990513     D                                     DIM(15)
004700981210     D  P1                     1      4
004800981210     D  P2                     5      8
004900981210     D  P3                     9     12
005000981210     D  P4                    13     16
005100981210     D  P5                    17     20
005200981210     D  P6                    21     24
005300981210     D  P7                    25     28
005400981210     D  P8                    29     32
005500981210     D  P9                    33     36
005600981210     D  P10                   37     40
005700981210     D  P11                   41     44
005800981210     D  P12                   45     48
005900981210     D  P13                   49     52
006000981210     D  P14                   53     56
006100981210     D  P15                   57     60
006200951017     D                 DS
006300951017     D*
006400990910     D  PW                     1     60
006500990910     D                                     DIM(15)
006600990910     D  PK1                    1      4
006700990910     D  PK2                    5      8
006800990910     D  PK3                    9     12
006900990910     D  PK4                   13     16
007000990910     D  PK5                   17     20
007100990910     D  PK6                   21     24
007200990910     D  PK7                   25     28
007300990910     D  PK8                   29     32
007400990910     D  PK9                   33     36
007500990910     D  PK10                  37     40
007600990910     D  PK11                  41     44
007700990910     D  PK12                  45     48
007800990910     D  PK13                  49     52
007900990910     D  PK14                  53     56
008000990910     D  PK15                  57     60
008100951016     D                 DS
008200951016     D  D                      1    675
008300951016     D                                     DIM(15)
008400951016     D  D1                     1     45
008500951016     D  D2                    46     90
008600951016     D  D3                    91    135
008700951016     D  D4                   136    180
008800951016     D  D5                   181    225
008900951016     D  D6                   226    270
009000951016     D  D7                   271    315
009100951016     D  D8                   316    360
009200951016     D  D9                   361    405
009300951016     D  D10                  406    450
009400951016     D  D11                  451    495
009500951016     D  D12                  496    540
009600951016     D  D13                  541    585
009700951016     D  D14                  586    630
009800951016     D  D15                  631    675
009900951017     D                 DS
010000960410     D  DE                     1    600
010100960410     D                                     DIM(15)
010200951017     D  DE1                    1     40
010300951017     D  DE2                   41     80
010400951017     D  DE3                   81    120
010500951017     D  DE4                  121    160
010600951017     D  DE5                  161    200
010700951017     D  DE6                  201    240
010800951017     D  DE7                  241    280
010900951017     D  DE8                  281    320
011000951017     D  DE9                  321    360
011100960410     D  DE10                 361    400
011200960410     D  DE11                 401    440
011300960410     D  DE12                 441    480
011400960410     D  DE13                 481    520
011500960410     D  DE14                 521    560
011600960410     D  DE15                 561    600
011700940915     C************************************************
011800940915     C************************************************
011900951016     C* KEY PACKAGE MASTER FILE
012000951016     C     KEYPAK        KLIST
012100951016     C                   KFLD                    KPAK              5 0
012200950207     C************************************************
012300951016     C************************************************
012400951016     C* KEY PACKAGE LOGICAL FILE
012500951016     C     KEYPKL        KLIST
012600951018     C                   KFLD                    KPAKL            50
012700951016     C************************************************
012800951016     C************************************************
012900951016     C* KEY PLAN MASTER FILE
013000951016     C     KEYPLN        KLIST
013100951017     C                   KFLD                    KTST              3 0
013200951017     C                   KFLD                    KSUB              3 0
013300981210     C                   KFLD                    KPLN              4
013400951016     C************************************************
013500940929     C*
013600951016     C* GET SELECTION - EITHER DIRECT PACKAGE NUMBER OR
013700951016     C* PACKAGE DESCRIPTION. IF PACKAGE DESC.,DISPLAY WINDOW
013800940929     C******************************************************
013900951016     C     #BEG          TAG
014000950208     C*
014100951018     C* INITIALIZE ARRAYS AND FIELDS
014200951018     C*
014300951017     C                   MOVE      *BLANKS       PKGDSC
014400990513     C                   MOVE      *BLANKS       PK
014500990513     C                   MOVE      *BLANKS       PO
014600990910     C                   MOVE      *BLANKS       PW
014700951016     C                   EXFMT     SCRN01
014800950207     C* FUNCTION KEY 7 TO END PROGRAM
014900951016     C     *IN07         CABEQ     '1'           ENDPGM
015000950207     C*
015100950207     C******************************************************
015200950207     C* MOVE SELECTION TO KEY AND RETRIEVE RECORD
015300950207     C*
015400951016     C     PKG#          IFEQ      0
015500951016     C                   EXSR      $WIND
015600951016     C                   END
015700951017     C*
015800951017     C                   Z-ADD     PKG#          PKGNUM
015900951017     C     #AGN          TAG
016000951017     C                   MOVE      *BLANKS       DE
016100950207     C*
016200951017     C                   Z-ADD     PKG#          KPAK
016300951016     C     KEYPAK        CHAIN     PACKAG                             10
016400951016     C* IF NOT THERE, DISPLAY EMPTY SCREEN
016500951016     C     *IN10         CABEQ     '1'           #OVR
016600951016     C*
016700951018     C                   MOVEL     PKGDSC        DESC
016800951017     C                   MOVEA     PK            PO
016900951016     C* ALL RENEWAL PLANS KEPT IN TRUST 794, SUBDIVISION 1
017000951016     C                   Z-ADD     794           KTST
017100951016     C                   Z-ADD     001           KSUB
017200951017     C                   Z-ADD     1             Y                 2 0
017300960410     C     Y             DOUGT     15
017400990513     C     PK(Y)         IFNE      *BLANKS
017500981210     C                   MOVE      PK(Y)         KPLN
017600951016     C     KEYPLN        CHAIN     PLNMST                             20
017700951018     C* IF PLAN DOES NOT EXIST, DISPLAY ERROR MSG
017800951017     C   20              MOVE      ERR(1)        DE(Y)
017900951017     C  N20              MOVE      PDESCR        DE(Y)
018000951016     C                   END
018100951017     C                   ADD       1             Y
018200951017     C                   ENDDO
018300950207     C******************************************************
018400950207     C* WRITE SCREEN FOR OPERATOR INPUT
018500950207     C******************************************************
018600951016     C     #OVR          TAG
018700951016     C*
018800951017     C   10              MOVE      *BLANKS       DE
018900951016     C                   EXFMT     SCRN02
019000951018     C* COMMAND 1 TO RETURN TO FIRST SCREEN
019100951016     C     *IN01         CABEQ     '1'           #BEG
019200950207     C*
019300950207     C* FUNCTION KEY 7 TO END PROGRAM
019400951016     C     *IN07         CABEQ     '1'           ENDPGM
019500950208     C*
019600951017     C                   MOVEA     PO            PK
019700951020     C                   MOVEL     DESC          PKGDSC
019800951017     C*
019900951018     C* UPDATE SCREEN INPUT TO PACKAGE RECORD
020000951017     C  N10              UPDATE    PACKR
020100951018     C* WRITE NEW PACKAGE RECORD
020200951017     C   10              WRITE     PACKR
020300950208     C*
020400951018     C* DISPLAY SCREEN INPUT FOR VERIFICATION
020500951016     C                   GOTO      #AGN
020600950208     C*
020700950208     C     ENDPGM        TAG
020800950208     C                   SETON                                        LR
020900951016     C*******************************************************
021000951016     C     $WIND         BEGSR
021100951018     C* KEYPKL IS KEY FIELD FOR ALPHA SEARCH WINDOW
021200951018     C                   MOVEL     PKGDSC        KPAKL
021300951016     C     BEGIN         TAG
021400951020     C                   SETOFF                                       75
021500951018     C     KEYPKL        SETLL     PACKL
021600951016     C********************************
021700951018     C* FILL SEARCH WINDOW WITH ALPHA DESCRIPTION FOR PACKAGES
021800951016     C*
021900951017     C                   Z-ADD     1             Z                 2 0
022000951020     C     Z             DOUGT     15
022100951017     C                   READ      PACKRL                                 75
022200951018     C* FROM WINDOW
022300951017     C  N75              MOVEL     PKGDSC        D(Z)
022400951017     C  N75              MOVE      PKG#          PW(Z)
022500951017     C                   ADD       1             Z
022600951017     C                   ENDDO
022700951016     C*******************************
022800951016     C                   EXFMT     WINDO1
022900951116     C                   READ      PACKRL                                 75
023000951020     C  N75              MOVEL     PKGDSC        KPAKL
023100951018     C* IF NO SELECTION, START FROM WHERE WINDOW LEFT OFF
023200951018     C* AND DISPLAY NEXT FIFTEEN RECORDS
023300951016     C     SELECT        IFEQ      0
023400951017     C                   GOTO      BEGIN
023500951016     C                   ELSE
023600951018     C* PLACE SELECTED PACKAGE INTO PACKAGE NUMBER
023700951016     C                   Z-ADD     SELECT        Z
023800951017     C                   MOVE      PW(Z)         PKG#
023900951016     C                   END
024000951016     C                   ENDSR
024100951016     C*******************************
024200951018**
024300951018PLAN NUMBER IN ERROR, PLEASE RE-INTER
