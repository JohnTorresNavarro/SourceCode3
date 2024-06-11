000100000000      *_________________________________________________________________________
000400000000      *
000500070524      *  (c)Copyright 2007 by GBS, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900070524    ?FDSPOLOD   CF   E             WORKSTN
001000000000     F                                     INFDS(DSPD)
001100000000    ? *_________________________________________________________________________
001200000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001400010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001500000000    ? *_________________________________________________________________________
001600000000    ? *
001700000406    ? * Data structure
001800070524    ?D WDDTA         E DS                  EXTNAME(OLFCOVTP)
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
007100070524    ?C                   CALL      'UPDOLO  '                                   PROCESS REC IO
007200000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
007300991201    ?C                   PARM                    WWRTN                          RETURN CODE
007400000614    ?C                   PARM                    WDDTA                          REC DATA
007600070524     C*    IGCHGD        MULT      10000.0001    WSDATE
007700070524     C*    IGEFDT        MULT      10000.0001    WSEFDT
007800070524     C*    IGTRDT        MULT      10000.0001    WSTRDT
007900000000    ?C                   ENDSR                                                  END GETREC
008000000000    ? *___________________________________________________________________
008100000000    ? * Receive messages
008200000000    ? *___________________________________________________________________
008300000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
008400000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
008500000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
008600000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
008700000000    ?C                   PARM                    WWIN                           INDICATORS
008800000000    ?C                   PARM                    WWRTN             8            RETURN CODE
008900000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
009000000000    ?C                   ENDSR                                                  END RCV MSG
009100000000    ? *___________________________________________________________________
009200000000    ? * Display the display panel
009300000000    ? *___________________________________________________________________
009400000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
009500000000    ? *
009600000000    ? * Set OVERLAY based on last display file processed
009700000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
009800000000 001?C                   SETOFF                                       35        OVERLAY OFF
009900000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
010000000000X001?C                   ELSE                                                   SAME PGM
010100000000 001?C                   SETON                                        35        OVERLAY ON
010200000000E001?C                   ENDIF                                                  END IF NEW PGM
010300000000    ? *
010400000000    ? * Write message subfile
010500000000    ?C                   SETON                                        30        SFLMSG DISPLAY
010600000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
010700000000    ? *
010800000000    ? * Write display panels
010900000000B001?C                   SELECT
011000000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
011100000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
011200000000E001?C                   ENDSL                                                  END SELECT
011300000000    ?C                   ENDSR                                                  END DSP DSP
011400000000    ? *___________________________________________________________________
011500000000    ? * Build function key information
011600000000    ? *___________________________________________________________________
011700000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
011800991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
011900991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
012000000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
012100000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
012200000000    ?C                   PARM                    WAD                            FNC DESC
012300991108    ?C                   PARM                    WWIN                           *IN
012400000000    ?C                   PARM                    WAF                            FNC KEY TABLE
012500000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
012600000000    ? *
012700000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
012800000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
012900000000    ?C                   SUB       1             WW                             BUMP IDX
013000000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
013100000000    ?C                   ENDSR                                                  END BLD FKY
013200000000    ? *___________________________________________________________________
013300000000    ? * Process function keys
013400000000    ? *___________________________________________________________________
013500000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
013600991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
013700991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
013800000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
013900000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
014000000000    ?C                   PARM                    WAD                            FNC DESC
014100991108    ?C                   PARM                    WWIN                           *IN
014200000000    ?C                   PARM                    WAF                            FNC KEY TABLE
014300000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
014400000000    ?C                   ENDSR                                                  END PRCFKY
014500000000    ? *___________________________________________________________________
014600000000    ? * Process KEYS function
014700000000    ? *___________________________________________________________________
014800000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
014900000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
015000000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
015100000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
015200000000 001? *
015300000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
015400000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
015500000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
015600000000E002?C                   ENDIF                                                  END IF OVER 3
015700000000 001? *
015800000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
015900000000 001?C                   SUB       1             WW                             KEY DESCR IDX
016000000000E001?C                   ENDDO                                                  END DO KEYS
016100000000    ? *
016200000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
016300000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
016400000000    ?C                   SUB       1             WW                             BUMP IDX
016500000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
016600000000    ? *
016700000000    ?C                   ENDSR                                                  END PRCDKY
016800000000    ? *___________________________________________________________________
016900000000    ? * Process RETURN function
017000000000    ? *___________________________________________________________________
017100000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
017200000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
017300000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
017400000000    ?C                   ENDSR                                                  END RETURN
017500000000    ? *___________________________________________________________________
017600000000    ? * Process CANCEL function
017700000000    ? *___________________________________________________________________
017800000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
017900000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
018000000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
018100000000    ?C                   ENDSR                                                  END PRCCNL
018200000000    ? *___________________________________________________________________
018300000000    ? * Process ROLLUP function
018400000000    ? *___________________________________________________________________
018500000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
018600000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
018700000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
018800000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
018900000000E001?C                   ENDIF                                                  END IF GT LST PNL
019000000000    ?C                   ENDSR                                                  END PRCRUP
019100000000    ? *___________________________________________________________________
019200000000    ? * Process ROLLDOWN function
019300000000    ? *___________________________________________________________________
019400000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
019500000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
019600000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
019700000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
019800000000E001?C                   ENDIF                                                  END IF LT FST PNL
019900000000    ?C                   ENDSR                                                  END PRCRDN
020000000000    ? *___________________________________________________________________
020100000000    ? * Process ENTER function
020200000000    ? *___________________________________________________________________
020300000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
020400000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
020500000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
020600000000    ?C                   ENDSR                                                  END PRCENT
020700000000    ? *___________________________________________________________________
020800000000    ? * Send message
020900000000    ? *___________________________________________________________________
021000000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
021100000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
021200000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
021300000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
021400000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
021500000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
021600000000    ?C                   ENDSR                                                  END SND MSG
021700000000    ? *___________________________________________________________________
021800000000    ? * Parameter lists
021900000000    ? *___________________________________________________________________
022000000000    ?C     PLIST         BEGSR                                                  PARM LISTS
022100000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
022200000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
022300000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
022400000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
022500000614    ?C                   PARM                    WDDTA                          RECORD DS
022600000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
022800000000    ?C                   ENDSR                                                  END PLIST
022900000000    ? *___________________________________________________________________
023000000000    ? * Initialize routine
023100000000    ? *___________________________________________________________________
023200000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
023300000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
023400070524    ?C                   MOVEL     'OLFCOVTP'    WWFIL            10            FILE NAME-NOTES
023500000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
023600000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
023700000000    ?C                   ENDSR                                                  END *INZSR
023800000000    ? *___________________________________________________________________
023900000000    ? * Define  routine
024000000000    ? *___________________________________________________________________
024100000000    ?C     DEFN          BEGSR                                                  Define Fields
024200000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
024300000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
024400000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
024500000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
024600000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
024700000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
024800000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
024900000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
025000000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
025100000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
025200000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
025300000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
025400000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
025500000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
025600000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
025700000000    ?C                   ENDSR                                                  END DEFN
025800000000    ? *___________________________________________________________________
025900000000    ? * Program error handler
026000000000    ? *___________________________________________________________________
026100000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
026200000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
026300000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
026400000000    ?C                   PARM                    WQSTSC                         STATUS CODE
026500000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
026600000000    ?C                   PARM                    WQMSG                          MESSAGE ID
026700000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
026800000000    ? *___________________________________________________________________
026900000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02700000000003EXIT    F3=Exit
02710000000012CANCEL  F12=Cancel
02720000000025ROLLUP
02730000000026ROLLDOWN
027400000000** WTM
02750007052400Online Form Coverage Type not found.
