000100990202      *  FM390  - FOR BCBS B.O.R TRANSFER SET FLAG PROCESS UPON REQUEST
000200990127      *
000300990127      *  SEND SCREEN TO GET CANCEL EFFECTIVE DATE AND ACCOUNT NUMBER.
000400990202      *  EDIT THE DATE TO INSURE A VALID VALUES AND EDIT ACCOUNT #.
000500990127      *  HOLD BOR TRANSFER ACCOUNTS TO BE USED IN CONJUNCTION WITH
000600990127      *  TR070 CANCELLATION PROGRAM.
000700990119      * MODS: --DATE-- PGMR DESC...
000800990121      * 1/99  MM/DD/CCYY DLW
000900990119      *
001000990113      *
001100990202     FFM390D    CF   E             WORKSTN
001200990128     FACCMST    IF   E           K DISK
001300990202     FFM390WK   UF A E           K DISK
001400990129     D MSG             S             70    DIM(13) CTDATA PERRCD(1)
001500990127     D                 DS
001600990127     D  DSACTN                 1     10
001700990127     D  DSTRST                 1      3
001800990127     D  DSSUBN                 4      6
001900990127     D  DSACCT                 7     10
002000990128     D                 DS
002100990128     D  SCRDAT                 1      8  0
002200990128     D  SCRMM                  1      2  0
002300990128     D  SCRDD                  3      4  0
002400990128     D  SCRCC                  5      6  0
002500990128     D  SCRYY                  7      8  0
002600990127     D COMPAN          DS
002700990127     D*  DATA AREA - COMPANY NAME
002800990127     D  COMP                   1     55
002900990129     C*****************************************************************
003000990127     C     #T0001        TAG
003100990127     C                   EXFMT     SCRN01
003200990201     C* F3 = EXIT
003300990127     C     *IN03         IFEQ      *ON
003400990127     C                   SETON                                        LR
003500990127     C                   GOTO      #END
003600990127     C                   ENDIF
003700990201     C* F12 = RESET
003800990201     C     *IN12         IFEQ      *ON
003900990201     C                   MOVE      *ZEROS        EFTDAT
004000990201     C                   MOVE      *ZEROS        TRST#
004100990201     C                   MOVE      *ZEROS        SUB#
004200990201     C                   MOVE      *ZEROS        ACCT#
004300990201     C                   MOVE      *OFF          *IN20
004400990201     C                   MOVE      *OFF          *IN30
004500990205     C                   MOVE      *OFF          *IN97
004600990201     C                   MOVE      *BLANK        ACTNAM
004700990201     C                   MOVE      *BLANK        MESSG
004800990201     C                   GOTO      #T0001
004900990201     C                   ENDIF
005000990201     C*
005100990129     C     *IN20         IFEQ      *OFF
005200990129     C                   EXSR      #VALAC
005300990129     C                   ENDIF
005400990128     C*
005500990129     C     *IN30         IFEQ      *OFF
005600990129     C                   EXSR      #READW
005700990129     C                   ENDIF
005800990129     C*
005900990129     C     *IN98         IFEQ      *ON                                                      ac#
006000990129     C                   EXSR      #VALDT
006100990205     C                   MOVE      *OFF          *IN97
006200990129     C                   MOVE      EFFYMD        EFFDAT
006300990202     C                   WRITE     FM390R                               10
006400990129     C     *IN10         IFEQ      *OFF
006500990129     C                   MOVE      *ZEROS        EFTDAT
006600990129     C                   MOVE      *ZEROS        TRST#
006700990129     C                   MOVE      *ZEROS        SUB#
006800990129     C                   MOVE      *ZEROS        ACCT#
006900990129     C                   MOVE      *OFF          *IN20
007000990129     C                   MOVE      *OFF          *IN30
007100990129     C                   MOVE      *BLANK        ACTNAM
007200990129     C                   Z-ADD     4             N                 2 0
007300990129     C                   MOVEL     MSG(N)        MESSG
007400990129     C                   GOTO      #T0001
007500990129     C* WRITE OPERATION FAILED
007600990129     C                   ELSE
007700990129     C                   Z-ADD     10            N                 2 0
007800990129     C                   MOVEL     MSG(N)        MESSG
007900990129     C                   GOTO      #T0001
008000990129     C                   ENDIF
008100990129     C                   ELSE
008200990129     C     *IN09         IFEQ      *ON
008300990202     C     DSACTN        DELETE    FM390R                             7788
008400990129     C     *IN77         IFEQ      *ON
008500990129     C                   Z-ADD     12            N                 2 0
008600990129     C                   MOVEL     MSG(N)        MESSG
008700990129     C                   GOTO      #T0001
008800990129     C                   ELSE
008900990129     C     *IN88         IFEQ      *ON
009000990129     C                   Z-ADD     13            N                 2 0
009100990129     C                   MOVEL     MSG(N)        MESSG
009200990129     C                   GOTO      #T0001
009300990129     C                   ELSE
009400990129     C                   MOVE      *ZEROS        EFTDAT
009500990129     C                   MOVE      *ZEROS        TRST#
009600990129     C                   MOVE      *ZEROS        SUB#
009700990129     C                   MOVE      *ZEROS        ACCT#
009800990129     C                   MOVE      *OFF          *IN20
009900990129     C                   MOVE      *OFF          *IN30
010000990129     C                   MOVE      *BLANK        ACTNAM
010100990129     C                   Z-ADD     6             N                 2 0
010200990129     C                   MOVEL     MSG(N)        MESSG
010300990129     C                   GOTO      #T0001
010400990129     C                   ENDIF
010500990129     C                   ENDIF
010600990129     C                   ELSE
010700990129     C                   EXSR      #VALDT
010800990205     C                   MOVE      *OFF          *IN97
010900990129     C                   MOVE      EFFYMD        EFFDAT
011000990202     C                   UPDATE    FM390R                               40
011100990129     C* UPDATE OPERATION FAILED
011200990129     C     *IN40         IFEQ      *ON
011300990129     C                   Z-ADD     11            N                 2 0
011400990129     C                   MOVEL     MSG(N)        MESSG
011500990129     C                   GOTO      #T0001
011600990129     C                   ELSE
011700990129     C                   MOVE      *ZEROS        EFTDAT
011800990129     C                   MOVE      *ZEROS        TRST#
011900990129     C                   MOVE      *ZEROS        SUB#
012000990129     C                   MOVE      *ZEROS        ACCT#
012100990129     C                   MOVE      *OFF          *IN20
012200990129     C                   MOVE      *OFF          *IN30
012300990129     C                   Z-ADD     5             N                 2 0
012400990129     C                   MOVEL     MSG(N)        MESSG
012500990129     C                   GOTO      #T0001
012600990129     C                   ENDIF
012700990129     C                   ENDIF
012800990129     C                   ENDIF
012900990127     C*
013000990127     C     #END          TAG
013100990129     C*****************************************************************
013200990129     C* VALIDATE THE ACCOUNT NUMBER ENTERED ON THE SCREEN
013300990129     C     #VALAC        BEGSR
013400990129     C                   MOVE      TRST#         ACTRST
013500990129     C                   MOVE      SUB#          ACSUB#
013600990129     C                   MOVE      ACCT#         ACACCT
013700990129     C     ACKEY         SETLL     ACCMST
013800990129     C     ACKEY         READE     ACCMST                                 99
013900990129     C     *IN99         IFEQ      *OFF                                                     ac#
014000990129     C                   MOVE      ACNAM1        ACTNAM
014100990129     C                   MOVE      *ON           *IN20
014200990129     C                   MOVE      TRST#         DSTRST
014300990129     C                   MOVE      SUB#          DSSUBN
014400990129     C                   MOVE      ACCT#         DSACCT
014500990129     C                   ELSE
014600990129     C                   Z-ADD     1             N                 2 0
014700990129     C                   MOVEL     MSG(N)        MESSG
014800990129     C                   GOTO      #T0001
014900990129     C                   ENDIF
015000990129     C                   ENDSR
015100990129     C*****************************************************************
015200990129     C* READ BOR TRANSFER FILE DETERMINE IF THE RECORD EXITS
015300990129     C     #READW        BEGSR
015400990129     C                   MOVE      DSACTN        ACCTNO
015500990202     C     BORKY         SETLL     FM390WK
015600990202     C     BORKY         READE     FM390WK                                98
015700990129     C                   MOVE      *ON           *IN30
015800990129     C     *IN98         IFEQ      *OFF
015900990129     C                   MOVE      EFFDAT        CYMD#             8
016000990129     C                   EXSR      #CYMD8
016100990129     C                   MOVE      MDCY#         EFTDAT
016200990129     C                   Z-ADD     3             N                 2 0
016300990129     C                   MOVEL     MSG(N)        MESSG
016400990129     C                   GOTO      #T0001
016500990129     C                   ENDIF
016600990129     C                   ENDSR
016700990129     C*****************************************************************
016800990129     C* VALIDATE THE DATE ENTERED ON THE SCREEN
016900990129     C     #VALDT        BEGSR
017000990129     C     EFTDAT        IFEQ      *ZERO
017100990129     C     EFTDAT        OREQ      *BLANK
017200990129     C                   Z-ADD     2             N                 2 0
017300990129     C                   MOVEL     MSG(N)        MESSG
017400990205     C                   MOVE      *ON           *IN97
017500990129     C                   GOTO      #T0001
017600990129     C                   ELSE
017700990129     C                   MOVE      EFTDAT        SCRDAT
017800990129     C     SCRCC         IFEQ      *ZERO
017900990129     C     SCRCC         ORLT      19
018000990129     C     SCRCC         ORGT      20
018100990129     C                   Z-ADD     7             N                 2 0
018200990129     C                   MOVEL     MSG(N)        MESSG
018300990205     C                   MOVE      *ON           *IN97
018400990129     C                   GOTO      #T0001
018500990129     C                   ENDIF
018600990129     C     SCRMM         IFLT      1
018700990129     C     SCRMM         ORGT      12
018800990129     C                   Z-ADD     8             N                 2 0
018900990129     C                   MOVEL     MSG(N)        MESSG
019000990205     C                   MOVE      *ON           *IN97
019100990129     C                   GOTO      #T0001
019200990129     C                   ENDIF
019300990129     C     SCRDD         IFLT      1
019400990129     C     SCRDD         ORGT      31
019500990129     C                   Z-ADD     9             N                 2 0
019600990129     C                   MOVEL     MSG(N)        MESSG
019700990205     C                   MOVE      *ON           *IN97
019800990129     C                   GOTO      #T0001
019900990129     C                   ENDIF
020000990129     C                   MOVE      EFTDAT        MDCY#             8
020100990129     C                   EXSR      #MDCY8
020200990129     C                   MOVE      CYMD#         EFFYMD            8
020300990129     C                   ENDIF
020400990129     C                   ENDSR
020500990128     C*****************************************************************
020600990128     C* REARRANGE DATE FROM CCYYMMDD TO MMDDCCYY
020700990128     C     #CYMD8        BEGSR
020800990128     C                   MOVE      CYMD#         MMDD#             4
020900990128     C                   MOVEL     CYMD#         CCYY#             4
021000990128     C                   MOVEL     MMDD#         MDCY#             8
021100990128     C                   MOVE      CCYY#         MDCY#
021200990128     C                   ENDSR
021300990127     C*****************************************************************
021400990129     C* REARRANGE DATE FROM MMDDCCYY TO CCYYMMDD
021500990129     C     #MDCY8        BEGSR
021600990129     C                   MOVEL     MDCY#         MMDD#             4
021700990129     C                   MOVE      MDCY#         CCYY#             4
021800990129     C                   MOVE      MMDD#         CYMD#             8
021900990129     C                   MOVEL     CCYY#         CYMD#
022000990129     C                   ENDSR
022100990129     C*****************************************************************
022200990127     C     *INZSR        BEGSR
022300990127     C     *DTAARA       DEFINE                  COMPAN
022400990127     C                   IN        COMPAN
022500990127     C                   MOVEL     COMP          COMPNY
022600990128     C*
022700990128     C     ACKEY         KLIST
022800990128     C                   KFLD                    ACTRST
022900990128     C                   KFLD                    ACSUB#
023000990128     C                   KFLD                    ACACCT
023100990128     C*
023200990128     C     BORKY         KLIST
023300990128     C                   KFLD                    ACCTNO
023400990127     C                   ENDSR
023500990128     C*****************************************************************
023600990129**  ERROR MESSAGES
023700990129INVALID ACCOUNT NUMBER PLEASE RETRY
023800990201RECORD DOES NOT EXIST,TO ADD RECORD SUPPLY EFFECTIVE DATE
023900990201RECORD EXISTS CHANGE DATE TO UPDATE? OR F9=DELETE, F3=EXIT, F12=RESET
024000990127TRANSACTION COMPLETE RECORD ADDED
024100990128TRANSACTION COMPLETE RECORD UPDATED
024200990128TRANSACTION COMPLETE RECORD DELETED
024300990128INVALID CENTURY PLEASE RETRY
024400990128INVALID MONTH PLEASE RETRY
024500990128INVALID DAY PLEASE RETRY
024600990129ADD RECORD OPERATION FAILURE SEE THE I.S. DEPARTMENT
024700990129UPDATE RECORD OPERATION FAILURE SEE THE I.S. DEPARTMENT
024800990129RECORD NOT FOUND FOR DELETE OPERATION SEE THE I.S. DEPARTMENT
024900990129ERROR OCCURRED DURING DELETE OPERATION SEE THE I.S. DEPARTMENT
