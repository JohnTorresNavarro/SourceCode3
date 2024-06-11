000100000000      *_________________________________________________________________________
000200000000      *
000300020227      *  Description:  Display ISC Print Zero Commissions
000400000000      *
000500010219      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900020227    ?FDSPPZCD   CF   E             WORKSTN
001000000000     F                                     INFDS(DSPD)
001100020227     FCARMST    IF   E           K DISK
001200000000    ? *_________________________________________________________________________
001300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001500010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001600000000    ? *_________________________________________________________________________
001700000000    ? *
001800000406    ? * Data structure
001900020227    ?D WDDTA         E DS                  EXTNAME(ISCPZC)
002000000000    ? *
002100000000    ? * Program status data structure
002200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000    ? *
002400000000    ? * Display file data structure
002500991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002600000000    ? *_________________________________________________________________________
002700000000    ? * Process display panel
002800000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
002900000000    ? *
003000000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
003100000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
003200000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
003300000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
003400000000 001? *
003500000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
003600000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
003700000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
003800000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
003900000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004000000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
004100000000 001?C                   ENDCS                                                  END CASE
004200000000 001? *
004300000000E001?C                   ENDDO                                                  END DOWHILE
004400000000    ?C                   RETURN                                                 RETURN
004500000000    ? *___________________________________________________________________
004600000000    ? * Prepare display panel
004700000000    ? *___________________________________________________________________
004800000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
004900000000    ? *
005000000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
005100000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
005200000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
005300000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
005400000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
005500010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
005600000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
005700000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
005800000000    ? *
005900000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
006000000000    ?C                   EXSR      GETREC                                       GET RECORD
006100000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
006200000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
006300000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
006400000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
006500000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
006600000000E001?C                   ENDIF                                                  END IF ERROR
006700000000    ?C                   ENDSR                                                  END PRPPNL
006800000000    ? *___________________________________________________________________
006900000000    ? * Get record
007000000000    ? *___________________________________________________________________
007100000000    ?C     GETREC        BEGSR                                                  GET RECORD
007200020227    ?C                   CALL      'UPDPZC  '                                   PROCESS REC IO
007300000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
007400991201    ?C                   PARM                    WWRTN                          RETURN CODE
007500000614    ?C                   PARM                    WDDTA                          REC DATA
007600020220    ?C                   PARM                    FRRN                           FUNCTIONS VALID
007700020227     C     IZCAR         Chain     CARMST
007800020227     C                   if        %Found
007900020227     C                   Eval      wsdesc = cname
008000020227     C                   Else
008100020227     C                   Eval      wsdesc = *blanks
008200020227     C                   End
008300000000    ?C                   ENDSR                                                  END GETREC
008400000000    ? *___________________________________________________________________
008500000000    ? * Receive messages
008600000000    ? *___________________________________________________________________
008700000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
008800000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
008900000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
009000000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
009100000000    ?C                   PARM                    WWIN                           INDICATORS
009200000000    ?C                   PARM                    WWRTN             8            RETURN CODE
009300000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
009400000000    ?C                   ENDSR                                                  END RCV MSG
009500000000    ? *___________________________________________________________________
009600000000    ? * Display the display panel
009700000000    ? *___________________________________________________________________
009800000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
009900000000    ? *
010000000000    ? * Set OVERLAY based on last display file processed
010100000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
010200000000 001?C                   SETOFF                                       35        OVERLAY OFF
010300000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
010400000000X001?C                   ELSE                                                   SAME PGM
010500000000 001?C                   SETON                                        35        OVERLAY ON
010600000000E001?C                   ENDIF                                                  END IF NEW PGM
010700000000    ? *
010800000000    ? * Write message subfile
010900000000    ?C                   SETON                                        30        SFLMSG DISPLAY
011000000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
011100000000    ? *
011200000000    ? * Write display panels
011300000000B001?C                   SELECT
011400000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
011500000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
011600000000E001?C                   ENDSL                                                  END SELECT
011700000000    ?C                   ENDSR                                                  END DSP DSP
011800000000    ? *___________________________________________________________________
011900000000    ? * Build function key information
012000000000    ? *___________________________________________________________________
012100000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
012200991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
012300991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
012400000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
012500000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
012600000000    ?C                   PARM                    WAD                            FNC DESC
012700991108    ?C                   PARM                    WWIN                           *IN
012800000000    ?C                   PARM                    WAF                            FNC KEY TABLE
012900000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
013000000000    ? *
013100000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
013200000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
013300000000    ?C                   SUB       1             WW                             BUMP IDX
013400000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
013500000000    ?C                   ENDSR                                                  END BLD FKY
013600000000    ? *___________________________________________________________________
013700000000    ? * Process function keys
013800000000    ? *___________________________________________________________________
013900000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
014000991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
014100991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
014200000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
014300000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
014400000000    ?C                   PARM                    WAD                            FNC DESC
014500991108    ?C                   PARM                    WWIN                           *IN
014600000000    ?C                   PARM                    WAF                            FNC KEY TABLE
014700000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
014800000000    ?C                   ENDSR                                                  END PRCFKY
014900000000    ? *___________________________________________________________________
015000000000    ? * Process KEYS function
015100000000    ? *___________________________________________________________________
015200000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
015300000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
015400000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
015500000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
015600000000 001? *
015700000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
015800000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
015900000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
016000000000E002?C                   ENDIF                                                  END IF OVER 3
016100000000 001? *
016200000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
016300000000 001?C                   SUB       1             WW                             KEY DESCR IDX
016400000000E001?C                   ENDDO                                                  END DO KEYS
016500000000    ? *
016600000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
016700000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
016800000000    ?C                   SUB       1             WW                             BUMP IDX
016900000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
017000000000    ? *
017100000000    ?C                   ENDSR                                                  END PRCDKY
017200000000    ? *___________________________________________________________________
017300000000    ? * Process RETURN function
017400000000    ? *___________________________________________________________________
017500000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
017600000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
017700000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
017800000000    ?C                   ENDSR                                                  END RETURN
017900000000    ? *___________________________________________________________________
018000000000    ? * Process CANCEL function
018100000000    ? *___________________________________________________________________
018200000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
018300000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
018400000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
018500000000    ?C                   ENDSR                                                  END PRCCNL
018600000000    ? *___________________________________________________________________
018700000000    ? * Process ROLLUP function
018800000000    ? *___________________________________________________________________
018900000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
019000000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
019100000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
019200000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
019300000000E001?C                   ENDIF                                                  END IF GT LST PNL
019400000000    ?C                   ENDSR                                                  END PRCRUP
019500000000    ? *___________________________________________________________________
019600000000    ? * Process ROLLDOWN function
019700000000    ? *___________________________________________________________________
019800000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
019900000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
020000000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
020100000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
020200000000E001?C                   ENDIF                                                  END IF LT FST PNL
020300000000    ?C                   ENDSR                                                  END PRCRDN
020400000000    ? *___________________________________________________________________
020500000000    ? * Process ENTER function
020600000000    ? *___________________________________________________________________
020700000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
020800000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
020900000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
021000000000    ?C                   ENDSR                                                  END PRCENT
021100000000    ? *___________________________________________________________________
021200000000    ? * Send message
021300000000    ? *___________________________________________________________________
021400000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
021500000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
021600000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
021700000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
021800000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
021900000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
022000000000    ?C                   ENDSR                                                  END SND MSG
022100000000    ? *___________________________________________________________________
022200000000    ? * Parameter lists
022300000000    ? *___________________________________________________________________
022400000000    ?C     PLIST         BEGSR                                                  PARM LISTS
022500000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
022600000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
022700000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
022800000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
022900000614    ?C                   PARM                    WDDTA                          RECORD DS
023000000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
023100020220    ?C                   PARM                    FRRN              6 0          FUNCTIONS VALID
023200000000    ?C                   ENDSR                                                  END PLIST
023300000000    ? *___________________________________________________________________
023400000000    ? * Initialize routine
023500000000    ? *___________________________________________________________________
023600000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
023700000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
023800020227    ?C                   MOVEL     'ISCPZC  '    WWFIL            10            FILE NAME-NOTES
023900000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
024000000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
024100000000    ?C                   ENDSR                                                  END *INZSR
024200000000    ? *___________________________________________________________________
024300000000    ? * Define  routine
024400000000    ? *___________________________________________________________________
024500000000    ?C     DEFN          BEGSR                                                  Define Fields
024600000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
024700000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
024800000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
024900000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
025000000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
025100000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
025200000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
025300000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
025400000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
025500000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
025600000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
025700000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
025800000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
025900000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
026000000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
026100000000    ?C                   ENDSR                                                  END DEFN
026200000000    ? *___________________________________________________________________
026300000000    ? * Program error handler
026400000000    ? *___________________________________________________________________
026500000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
026600000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
026700000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
026800000000    ?C                   PARM                    WQSTSC                         STATUS CODE
026900000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
027000000000    ?C                   PARM                    WQMSG                          MESSAGE ID
027100000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
027200000000    ? *___________________________________________________________________
027300000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02740000000003EXIT    F3=Exit
02750000000012CANCEL  F12=Cancel
02760000000025ROLLUP
02770000000026ROLLDOWN
027800000000** WTM
02790002022700ISC Print Zero Commissions record not found.
