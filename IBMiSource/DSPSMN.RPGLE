000100000000      *_________________________________________________________________________
000200000000      *
000300010219      *  Description:  Display ISC Salesman
000400000000      *
000500010219      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900010219    ?FDSPSMND   CF   E             WORKSTN
001000000000     F                                     INFDS(DSPD)
001100000000    ? *_________________________________________________________________________
001200000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001400010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001500000000    ? *_________________________________________________________________________
001600000000    ? *
001700000406    ? * Data structure
001800010219    ?D WDDTA         E DS                  EXTNAME(ISCSMN)
001900000000    ? *
002000000000    ? * Program status data structure
002100991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002200000000    ? *
002300000000    ? * Display file data structure
002400991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002500000000    ? *_________________________________________________________________________
002600000000    ? * Process display panel
002700000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
002800000000    ? *
002900000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
003000000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
003100000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
003200000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
003300000000 001? *
003400000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
003500000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
003600000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
003700000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
003800000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
003900000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
004000000000 001?C                   ENDCS                                                  END CASE
004100000000 001? *
004200000000E001?C                   ENDDO                                                  END DOWHILE
004300000000    ?C                   RETURN                                                 RETURN
004400000000    ? *___________________________________________________________________
004500000000    ? * Prepare display panel
004600000000    ? *___________________________________________________________________
004700000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
004800000000    ? *
004900000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
005000000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
005100000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
005200000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
005300000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
005400010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
005500000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
005600000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
005700000000    ? *
005800000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
005900000000    ?C                   EXSR      GETREC                                       GET RECORD
006000000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
006100000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
006200000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
006300000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
006400000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
006500000000E001?C                   ENDIF                                                  END IF ERROR
006600000000    ?C                   ENDSR                                                  END PRPPNL
006700000000    ? *___________________________________________________________________
006800000000    ? * Get record
006900000000    ? *___________________________________________________________________
007000000000    ?C     GETREC        BEGSR                                                  GET RECORD
007100010219    ?C                   CALL      'UPDSMN  '                                   PROCESS REC IO
007200000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
007300991201    ?C                   PARM                    WWRTN                          RETURN CODE
007400000614    ?C                   PARM                    WDDTA                          REC DATA
007500020220    ?C                   PARM                    FRRN                           FUNCTIONS VALID
007600000000    ?C                   ENDSR                                                  END GETREC
007700000000    ? *___________________________________________________________________
007800000000    ? * Receive messages
007900000000    ? *___________________________________________________________________
008000000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
008100000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
008200000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
008300000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
008400000000    ?C                   PARM                    WWIN                           INDICATORS
008500000000    ?C                   PARM                    WWRTN             8            RETURN CODE
008600000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
008700000000    ?C                   ENDSR                                                  END RCV MSG
008800000000    ? *___________________________________________________________________
008900000000    ? * Display the display panel
009000000000    ? *___________________________________________________________________
009100000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
009200000000    ? *
009300000000    ? * Set OVERLAY based on last display file processed
009400000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
009500000000 001?C                   SETOFF                                       35        OVERLAY OFF
009600000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
009700000000X001?C                   ELSE                                                   SAME PGM
009800000000 001?C                   SETON                                        35        OVERLAY ON
009900000000E001?C                   ENDIF                                                  END IF NEW PGM
010000000000    ? *
010100000000    ? * Write message subfile
010200000000    ?C                   SETON                                        30        SFLMSG DISPLAY
010300000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
010400000000    ? *
010500000000    ? * Write display panels
010600000000B001?C                   SELECT
010700000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
010800000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
010900000000E001?C                   ENDSL                                                  END SELECT
011000000000    ?C                   ENDSR                                                  END DSP DSP
011100000000    ? *___________________________________________________________________
011200000000    ? * Build function key information
011300000000    ? *___________________________________________________________________
011400000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
011500991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
011600991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
011700000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
011800000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
011900000000    ?C                   PARM                    WAD                            FNC DESC
012000991108    ?C                   PARM                    WWIN                           *IN
012100000000    ?C                   PARM                    WAF                            FNC KEY TABLE
012200000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
012300000000    ? *
012400000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
012500000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
012600000000    ?C                   SUB       1             WW                             BUMP IDX
012700000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
012800000000    ?C                   ENDSR                                                  END BLD FKY
012900000000    ? *___________________________________________________________________
013000000000    ? * Process function keys
013100000000    ? *___________________________________________________________________
013200000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
013300991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
013400991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
013500000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
013600000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
013700000000    ?C                   PARM                    WAD                            FNC DESC
013800991108    ?C                   PARM                    WWIN                           *IN
013900000000    ?C                   PARM                    WAF                            FNC KEY TABLE
014000000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
014100000000    ?C                   ENDSR                                                  END PRCFKY
014200000000    ? *___________________________________________________________________
014300000000    ? * Process KEYS function
014400000000    ? *___________________________________________________________________
014500000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
014600000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
014700000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
014800000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
014900000000 001? *
015000000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
015100000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
015200000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
015300000000E002?C                   ENDIF                                                  END IF OVER 3
015400000000 001? *
015500000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
015600000000 001?C                   SUB       1             WW                             KEY DESCR IDX
015700000000E001?C                   ENDDO                                                  END DO KEYS
015800000000    ? *
015900000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
016000000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
016100000000    ?C                   SUB       1             WW                             BUMP IDX
016200000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
016300000000    ? *
016400000000    ?C                   ENDSR                                                  END PRCDKY
016500000000    ? *___________________________________________________________________
016600000000    ? * Process RETURN function
016700000000    ? *___________________________________________________________________
016800000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
016900000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
017000000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
017100000000    ?C                   ENDSR                                                  END RETURN
017200000000    ? *___________________________________________________________________
017300000000    ? * Process CANCEL function
017400000000    ? *___________________________________________________________________
017500000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
017600000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
017700000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
017800000000    ?C                   ENDSR                                                  END PRCCNL
017900000000    ? *___________________________________________________________________
018000000000    ? * Process ROLLUP function
018100000000    ? *___________________________________________________________________
018200000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
018300000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
018400000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
018500000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
018600000000E001?C                   ENDIF                                                  END IF GT LST PNL
018700000000    ?C                   ENDSR                                                  END PRCRUP
018800000000    ? *___________________________________________________________________
018900000000    ? * Process ROLLDOWN function
019000000000    ? *___________________________________________________________________
019100000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
019200000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
019300000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
019400000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
019500000000E001?C                   ENDIF                                                  END IF LT FST PNL
019600000000    ?C                   ENDSR                                                  END PRCRDN
019700000000    ? *___________________________________________________________________
019800000000    ? * Process ENTER function
019900000000    ? *___________________________________________________________________
020000000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
020100000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
020200000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
020300000000    ?C                   ENDSR                                                  END PRCENT
020400000000    ? *___________________________________________________________________
020500000000    ? * Send message
020600000000    ? *___________________________________________________________________
020700000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
020800000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
020900000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
021000000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
021100000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
021200000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
021300000000    ?C                   ENDSR                                                  END SND MSG
021400000000    ? *___________________________________________________________________
021500000000    ? * Parameter lists
021600000000    ? *___________________________________________________________________
021700000000    ?C     PLIST         BEGSR                                                  PARM LISTS
021800000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
021900000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
022000000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
022100000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
022200000614    ?C                   PARM                    WDDTA                          RECORD DS
022300000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
022400020220    ?C                   PARM                    FRRN              6 0          FUNCTIONS VALID
022500000000    ?C                   ENDSR                                                  END PLIST
022600000000    ? *___________________________________________________________________
022700000000    ? * Initialize routine
022800000000    ? *___________________________________________________________________
022900000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
023000000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
023100010219    ?C                   MOVEL     'ISCSMN  '    WWFIL            10            FILE NAME-NOTES
023200000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
023300000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
023400000000    ?C                   ENDSR                                                  END *INZSR
023500000000    ? *___________________________________________________________________
023600000000    ? * Define  routine
023700000000    ? *___________________________________________________________________
023800000000    ?C     DEFN          BEGSR                                                  Define Fields
023900000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
024000000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
024100000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
024200000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
024300000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
024400000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
024500000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
024600000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
024700000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
024800000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
024900000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
025000000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
025100000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
025200000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
025300000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
025400000000    ?C                   ENDSR                                                  END DEFN
025500000000    ? *___________________________________________________________________
025600000000    ? * Program error handler
025700000000    ? *___________________________________________________________________
025800000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
025900000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
026000000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
026100000000    ?C                   PARM                    WQSTSC                         STATUS CODE
026200000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
026300000000    ?C                   PARM                    WQMSG                          MESSAGE ID
026400000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
026500000000    ? *___________________________________________________________________
026600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02670000000003EXIT    F3=Exit
02680000000012CANCEL  F12=Cancel
02690000000025ROLLUP
02700000000026ROLLDOWN
027100000000** WTM
02720001021900Internal Sales Commission Salesman not found.
