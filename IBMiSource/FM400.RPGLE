000100990211      *  FM400  - ACCMST MAINTENANCE PROGRAM TO CHANGE COVER THROUGH
000200990211      *           DATE ON-LINE.
000300990211      *  SEND SCREEN TO GET ACCOUNT NUMBER AND VERIFY BY DISPLAYING
000400990211      *  THE ACCOUNT NAME ON THE SCREEN. THE USER WILL CHANGE THE DATE
000500990211      *  AND HIT ENTER. THE PROGRAM WILL UPDATE THE ACCMST RECORD WITH
000600990212      *  THE DATE FROM THE SCREEN. A DIARY NOTE RECORD WILL BE ADDED TO
000700990212      *  THE HIST FILE DENOTING THE COVER THRU DATE CHANGE TO ACCMST.
000800990316      *
000900990211      * 2/1999  MM/DD/CCYY DLW
001000990215      * 2/1999 DLW CHANGED DATE USAGE TO USE 8 BYTES -Y2K COMPLIANT.
001100131010      * 10/10/13 sbt - hist file expansion project
001200990113      *
001300990211     FFM400D    CF   E             WORKSTN
001400990211     FACCMST    UF   E           K DISK
001500990212     FHIST      O  A E           K DISK
001600990215     D MSG             S             70    DIM(10) CTDATA PERRCD(1)
001700990127     D                 DS
001800990127     D  DSACTN                 1     10
001900990127     D  DSTRST                 1      3
002000990127     D  DSSUBN                 4      6
002100990127     D  DSACCT                 7     10
002200990128     D                 DS
002300990215     D  SCRDAT                 1      8  0
002400990128     D  SCRMM                  1      2  0
002500990128     D  SCRDD                  3      4  0
002600990215     D  SCRCC                  5      6  0
002700990215     D  SCRYY                  7      8  0
002800990212     D                 DS
002900990215     D  DSUDAT                 1      8  0
003000990215     D  DSUYY                  1      4  0
003100990215     D  DSUMM                  5      6  0
003200990215     D  DSUDD                  7      8  0
003300990212     D                 DS
003400990215     D DSNOT1          C                   CONST('CHG COVER THRU DT FR-
003500990215     D                                     M')
003600990212     D                 DS
003700990215     D  OLDAT                  1      8
003800990212     D                 DS
003900990218     D DSNOT2          C                   CONST(' TO')
004000990212     D                 DS
004100990215     D  NEWDT                  1      8
004200990218     D                 DS
004300990218     D  DNOTE2                 1     12
004400990218     D  TEXT                   1      4
004500990218     D  DATE                   5     12
004600990212     D**** LDA DATA AREA COMPANY NAME AND USER ID
004700990212     D                UDS
004800990212     D  COMP                   1     33
004900131014     D  USRID                 34     43
005000990129     C*****************************************************************
005100990127     C     #T0001        TAG
005200990127     C                   EXFMT     SCRN01
005300990201     C* F3 = EXIT
005400990127     C     *IN03         IFEQ      *ON
005500990127     C                   SETON                                        LR
005600990127     C                   GOTO      #END
005700990127     C                   ENDIF
005800990218     C* F12 = RESET
005900990218     C     *IN12         IFEQ      *ON
006000990218     C                   MOVE      *BLANK        ACTNAM
006100990218     C                   MOVE      *ZEROS        SCVTDT
006200990218     C                   MOVE      *ZEROS        TRST#
006300990218     C                   MOVE      *ZEROS        SUB#
006400990218     C                   MOVE      *ZEROS        ACCT#
006500990218     C                   MOVE      *OFF          *IN20
006600990218     C                   MOVE      *OFF          *IN97
006700990218     C                   GOTO      #T0001
006800990218     C                   ENDIF
006900990201     C*
007000990129     C     *IN20         IFEQ      *OFF
007100990129     C                   EXSR      #VALAC
007200990211     C                   ELSE
007300990216     C                   EXSR      #VALDT
007400990129     C                   ENDIF
007500990129     C*
007600990215     C                   MOVE      SCVTDT        MDCY#             8
007700990215     C                   EXSR      #MDCY8
007800990215     C                   MOVE      CYMD#         ACVTDT
007900990212     C                   MOVE      SCVTDT        NEWDT
008000990211     C                   UPDATE    ACCMSR                               40
008100990129     C* UPDATE OPERATION FAILED
008200990129     C     *IN40         IFEQ      *ON
008300990211     C                   Z-ADD     8             N                 2 0
008400990129     C                   MOVEL     MSG(N)        MESSG
008500990129     C                   ELSE
008600990211     C                   Z-ADD     7             N                 2 0
008700990211     C                   MOVEL     MSG(N)        MESSG
008800990212     C                   EXSR      #ADHST
008900990211     C                   ENDIF
009000990211     C                   MOVE      *BLANK        ACTNAM
009100990211     C                   MOVE      *ZEROS        SCVTDT
009200990129     C                   MOVE      *ZEROS        TRST#
009300990129     C                   MOVE      *ZEROS        SUB#
009400990129     C                   MOVE      *ZEROS        ACCT#
009500990129     C                   MOVE      *OFF          *IN20
009600990211     C                   MOVE      *OFF          *IN97
009700990129     C                   GOTO      #T0001
009800990127     C*
009900990127     C     #END          TAG
010000990129     C*****************************************************************
010100990129     C* VALIDATE THE ACCOUNT NUMBER ENTERED ON THE SCREEN
010200990129     C     #VALAC        BEGSR
010300990129     C                   MOVE      TRST#         ACTRST
010400990129     C                   MOVE      SUB#          ACSUB#
010500990129     C                   MOVE      ACCT#         ACACCT
010600990129     C     ACKEY         SETLL     ACCMST
010700990129     C     ACKEY         READE     ACCMST                                 99
010800990129     C     *IN99         IFEQ      *OFF
010900990215     C                   MOVE      *ON           *IN20
011000990129     C                   MOVE      ACNAM1        ACTNAM
011100990129     C                   MOVE      TRST#         DSTRST
011200990129     C                   MOVE      SUB#          DSSUBN
011300990129     C                   MOVE      ACCT#         DSACCT
011400990215     C                   MOVE      ACVTDT        CYMD#             8
011500990215     C                   EXSR      #CYMD8
011600990215     C                   MOVE      MDCY#         SCVTDT
011700990215     C                   MOVE      MDCY#         OLDAT
011800990211     C                   MOVE      *ON           *IN97
011900990211     C                   MOVE      *BLANK        MESSG
012000990129     C                   ELSE
012100990129     C                   Z-ADD     1             N                 2 0
012200990129     C                   MOVEL     MSG(N)        MESSG
012300990129     C                   ENDIF
012400990211     C                   GOTO      #T0001
012500990129     C                   ENDSR
012600990129     C*****************************************************************
012700990129     C* VALIDATE THE DATE ENTERED ON THE SCREEN
012800990129     C     #VALDT        BEGSR
012900990211     C     SCVTDT        IFEQ      *ZERO
013000990211     C     SCVTDT        OREQ      *BLANK
013100990129     C                   Z-ADD     2             N                 2 0
013200990129     C                   MOVEL     MSG(N)        MESSG
013300990205     C                   MOVE      *ON           *IN97
013400990129     C                   GOTO      #T0001
013500990129     C                   ELSE
013600990211     C                   MOVE      SCVTDT        SCRDAT
013700990129     C     SCRMM         IFLT      1
013800990129     C     SCRMM         ORGT      12
013900990211     C                   Z-ADD     4             N                 2 0
014000990129     C                   MOVEL     MSG(N)        MESSG
014100990205     C                   MOVE      *ON           *IN97
014200990129     C                   GOTO      #T0001
014300990129     C                   ENDIF
014400990129     C     SCRDD         IFLT      1
014500990129     C     SCRDD         ORGT      31
014600990211     C                   Z-ADD     5             N                 2 0
014700990129     C                   MOVEL     MSG(N)        MESSG
014800990205     C                   MOVE      *ON           *IN97
014900990129     C                   GOTO      #T0001
015000990129     C                   ENDIF
015100990211     C     SCRYY         IFEQ      *ZERO
015200990222     C     SCRCC         IFNE      20
015300990211     C                   Z-ADD     6             N                 2 0
015400990211     C                   MOVEL     MSG(N)        MESSG
015500990211     C                   MOVE      *ON           *IN97
015600990211     C                   GOTO      #T0001
015700990216     C                   ENDIF
015800990222     C                   ENDIF
015900990215     C     SCRCC         IFEQ      *ZERO
016000990215     C     SCRCC         ORLT      19
016100990215     C     SCRCC         ORGT      20
016200990215     C                   Z-ADD     3             N                 2 0
016300990215     C                   MOVEL     MSG(N)        MESSG
016400990215     C                   MOVE      *ON           *IN97
016500990215     C                   GOTO      #T0001
016600990215     C                   ENDIF
016700990211     C                   ENDIF
016800990129     C                   ENDSR
016900990212     C*****************************************************************
017000990212     C** ADD DIARY NOTE TO THE HISTORY FILE DENOTING DATE CHANGE IN ACCMST
017100990129     C*****************************************************************
017200990212     C     #ADHST        BEGSR
017300131014     C                   clear                   histr
017400990212     C                   MOVE      DSACTN        HKEY
017500990212     C                   MOVE      DSUDAT        TRDATE
017600990212     C                   MOVE      'UHM'         TRCODE
017700990212     C                   MOVEL     DSNOT1        CK#NOT
017800990212     C                   MOVE      OLDAT         CK#NOT
017900990218     C                   MOVEL     DSNOT2        TEXT
018000990218     C                   MOVE      NEWDT         DATE
018100990218     C                   MOVEL     DNOTE2        NOTE2
018200131025     C                   MOVEL     'FM400'       HPRGNM
018300990215     C                   MOVE      NEWDT         MDCY#             8
018400990215     C                   EXSR      #MDCY8
018500990215     C                   MOVE      CYMD#         COVTDT
018600990212     C                   MOVE      DSTRST        HSTRST
018700990212     C                   MOVE      DSSUBN        HSSUB#
018800990212     C                   MOVE      DSACCT        HSACCT
018900990212     C                   MOVE      'A'           HSDLTD
019000131014     C                   MOVEL     USRID         HOPER
019100131010     c                   eval      hstrtime = %time
019200990212     C                   WRITE     HISTR                                98
019300990212     C     *IN98         IFEQ      *ON
019400990212     C                   Z-ADD     9             N                 2 0
019500990212     C                   MOVEL     MSG(N)        MESSG
019600990212     C                   ENDIF
019700990212     C                   ENDSR
019800990212     C*
019900990215     C*****************************************************************
020000990215     C* REARRANGE DATE FROM CCYYMMDD TO MMDDCCYY
020100990215     C     #CYMD8        BEGSR
020200990215     C                   MOVE      CYMD#         MMDD#             4
020300990215     C                   MOVEL     CYMD#         CCYY#             4
020400990215     C                   MOVEL     MMDD#         MDCY#             8
020500990215     C                   MOVE      CCYY#         MDCY#
020600990215     C                   ENDSR
020700990215     C*****************************************************************
020800990215     C* REARRANGE DATE FROM MMDDCCYY TO CCYYMMDD
020900990215     C     #MDCY8        BEGSR
021000990215     C                   MOVEL     MDCY#         MMDD#             4
021100990215     C                   MOVE      MDCY#         CCYY#             4
021200990215     C                   MOVE      MMDD#         CYMD#             8
021300990215     C                   MOVEL     CCYY#         CYMD#
021400990215     C                   ENDSR
021500990212     C*****************************************************************
021600990127     C     *INZSR        BEGSR
021700990127     C                   MOVEL     COMP          COMPNY
021800990212     C*
021900990212     C                   MOVE      UMONTH        DSUMM
022000990212     C                   MOVE      UDAY          DSUDD
022100990215     C                   MOVE      *YEAR         DSUYY
022200990128     C*
022300990128     C     ACKEY         KLIST
022400990128     C                   KFLD                    ACTRST
022500990128     C                   KFLD                    ACSUB#
022600990128     C                   KFLD                    ACACCT
022700990211     C                   ENDSR
022800990128     C*****************************************************************
022900990212**  ERROR MESSAGES
023000990129INVALID ACCOUNT NUMBER PLEASE RETRY
023100990211INVALID COVER THROUGH DATE RETRY
023200990211INVALID CENTURY PLEASE RETRY
023300990128INVALID MONTH PLEASE RETRY
023400990128INVALID DAY PLEASE RETRY
023500990211INVALID YEAR PLEASE RETRY
023600990211TRANSACTION COMPLETE RECORD UPDATED
023700990129UPDATE RECORD OPERATION FAILURE SEE THE I.S. DEPARTMENT
023800990212DAIRY NOTE ADD ROUTINE FAILURE SEE THE I.S. DEPARTMENT
