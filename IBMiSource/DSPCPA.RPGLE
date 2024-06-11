000100000000      *_________________________________________________________________________
000200000000      *
000300040825      *  Description:  Display Claims Payment Address
000400000000      *
000500040825      *  (c)Copyright 2004 by Group Benefit Services, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900040825    ?FDSPCPAD   CF   E             WORKSTN
001000000000     F                                     INFDS(DSPD)
001600000000    ? *_________________________________________________________________________
001700000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001800000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001900010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
002000000000    ? *_________________________________________________________________________
002100000000    ? *
002200000406    ? * Data structure
002300040825    ?D WDDTA         E DS                  EXTNAME(CPAYAD)
002400000000    ? *
002500000000    ? * Program status data structure
002600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002700000000    ? *
002800000000    ? * Display file data structure
002900991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003000000000    ? *_________________________________________________________________________
003100000000    ? * Process display panel
003200000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
003300000000    ? *
003400000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
003500000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
003600000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
003700000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
003800000000 001? *
003900000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
004000000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
004100000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
004200000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
004300000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004400000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
004500000000 001?C                   ENDCS                                                  END CASE
004600000000 001? *
004700000000E001?C                   ENDDO                                                  END DOWHILE
004800000000    ?C                   RETURN                                                 RETURN
004900000000    ? *___________________________________________________________________
005000000000    ? * Prepare display panel
005100000000    ? *___________________________________________________________________
005200000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
005308031117    ? *
005400000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
005500000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
005600000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
005700000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
005800000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
005900010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
006000000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
006100000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
006200000000    ? *
006300000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
006400000000    ?C                   EXSR      GETREC                                       GET RECORD
006500000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
006600000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
006700000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
006800000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
006900000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
007000000000E001?C                   ENDIF                                                  END IF ERROR
007200000000    ?C                   ENDSR                                                  END PRPPNL
010800000000    ? *___________________________________________________________________
010900000000    ? * Get record
011000000000    ? *___________________________________________________________________
011100000000    ?C     GETREC        BEGSR                                                  GET RECORD
011200040825    ?C                   CALL      'UPDCPA  '                                   PROCESS REC IO
011300000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
011400991201    ?C                   PARM                    WWRTN                          RETURN CODE
011500000614    ?C                   PARM                    WDDTA                          REC DATA
012000000000    ?C                   ENDSR                                                  END GETREC
012100000000    ? *___________________________________________________________________
012200000000    ? * Receive messages
012300000000    ? *___________________________________________________________________
012400000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
012500000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
012600000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
012700000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
012800000000    ?C                   PARM                    WWIN                           INDICATORS
012900000000    ?C                   PARM                    WWRTN             8            RETURN CODE
013000000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
013100000000    ?C                   ENDSR                                                  END RCV MSG
013200000000    ? *___________________________________________________________________
013300000000    ? * Display the display panel
013400000000    ? *___________________________________________________________________
013500000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
013600000000    ? *
013700000000    ? * Set OVERLAY based on last display file processed
013800000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
013900000000 001?C                   SETOFF                                       35        OVERLAY OFF
014000000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
014100000000X001?C                   ELSE                                                   SAME PGM
014200000000 001?C                   SETON                                        35        OVERLAY ON
014300000000E001?C                   ENDIF                                                  END IF NEW PGM
014400000000    ? *
014500000000    ? * Write message subfile
014600000000    ?C                   SETON                                        30        SFLMSG DISPLAY
014700000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
014800000000    ? *
014900000000    ? * Write display panels
015000000000B001?C                   SELECT
015100000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
015200000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
015300000000E001?C                   ENDSL                                                  END SELECT
015400000000    ?C                   ENDSR                                                  END DSP DSP
015500000000    ? *___________________________________________________________________
015600000000    ? * Build function key information
015700000000    ? *___________________________________________________________________
015800000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
015900991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
016000991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
016100000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
016200000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
016300000000    ?C                   PARM                    WAD                            FNC DESC
016400991108    ?C                   PARM                    WWIN                           *IN
016500000000    ?C                   PARM                    WAF                            FNC KEY TABLE
016600000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
016700000000    ? *
016800000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
016900000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
017000000000    ?C                   SUB       1             WW                             BUMP IDX
017100000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
017200000000    ?C                   ENDSR                                                  END BLD FKY
017300000000    ? *___________________________________________________________________
017400000000    ? * Process function keys
017500000000    ? *___________________________________________________________________
017600000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
017700991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
017800991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
017900000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
018000000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
018100000000    ?C                   PARM                    WAD                            FNC DESC
018200991108    ?C                   PARM                    WWIN                           *IN
018300000000    ?C                   PARM                    WAF                            FNC KEY TABLE
018400000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
018500000000    ?C                   ENDSR                                                  END PRCFKY
018600000000    ? *___________________________________________________________________
018700000000    ? * Process KEYS function
018800000000    ? *___________________________________________________________________
018900000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
019000000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
019100000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
019200000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
019300000000 001? *
019400000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
019500000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
019600000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
019700000000E002?C                   ENDIF                                                  END IF OVER 3
019800000000 001? *
019900000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
020000000000 001?C                   SUB       1             WW                             KEY DESCR IDX
020100000000E001?C                   ENDDO                                                  END DO KEYS
020200000000    ? *
020300000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
020400000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
020500000000    ?C                   SUB       1             WW                             BUMP IDX
020600000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
020700000000    ? *
020800000000    ?C                   ENDSR                                                  END PRCDKY
020900000000    ? *___________________________________________________________________
021000000000    ? * Process RETURN function
021100000000    ? *___________________________________________________________________
021200000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
021300000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
021400000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
021500000000    ?C                   ENDSR                                                  END RETURN
021600000000    ? *___________________________________________________________________
021700000000    ? * Process CANCEL function
021800000000    ? *___________________________________________________________________
021900000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
022000000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
022100000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
022200000000    ?C                   ENDSR                                                  END PRCCNL
022300000000    ? *___________________________________________________________________
022400000000    ? * Process ROLLUP function
022500000000    ? *___________________________________________________________________
022600000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
022700000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
022800000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
022900000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
023000000000E001?C                   ENDIF                                                  END IF GT LST PNL
023100000000    ?C                   ENDSR                                                  END PRCRUP
023200000000    ? *___________________________________________________________________
023300000000    ? * Process ROLLDOWN function
023400000000    ? *___________________________________________________________________
023500000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
023600000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
023700000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
023800000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
023900000000E001?C                   ENDIF                                                  END IF LT FST PNL
024000000000    ?C                   ENDSR                                                  END PRCRDN
024100000000    ? *___________________________________________________________________
024200000000    ? * Process ENTER function
024300000000    ? *___________________________________________________________________
024400000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
024500000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
024600000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
024700000000    ?C                   ENDSR                                                  END PRCENT
024800000000    ? *___________________________________________________________________
024900000000    ? * Send message
025000000000    ? *___________________________________________________________________
025100000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
025200000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
025300000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
025400000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
025500000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
025600000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
025700000000    ?C                   ENDSR                                                  END SND MSG
025800000000    ? *___________________________________________________________________
025900000000    ? * Parameter lists
026000000000    ? *___________________________________________________________________
026100000000    ?C     PLIST         BEGSR                                                  PARM LISTS
026200000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
026300000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
026400000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
026500000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
026600000614    ?C                   PARM                    WDDTA                          RECORD DS
026700000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
026800000000    ?C                   ENDSR                                                  END PLIST
026900000000    ? *___________________________________________________________________
027000000000    ? * Initialize routine
027100000000    ? *___________________________________________________________________
027200000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
027300000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
027400040825    ?C                   MOVEL     'CPAYAD  '    WWFIL            10            FILE NAME-NOTES
027500000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
027600000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
027700000000    ?C                   ENDSR                                                  END *INZSR
027800000000    ? *___________________________________________________________________
027900000000    ? * Define  routine
028000000000    ? *___________________________________________________________________
028100000000    ?C     DEFN          BEGSR                                                  Define Fields
028200000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
028300000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
028400000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
028500000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
028600000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
028700000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
028800000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
028900000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
029000000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
029100000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
029200000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
029300000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
029400000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
029500000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
029600000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
029700000000    ?C                   ENDSR                                                  END DEFN
029800000000    ? *___________________________________________________________________
029900000000    ? * Program error handler
030000000000    ? *___________________________________________________________________
030100000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
030200000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
030300000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
030400000000    ?C                   PARM                    WQSTSC                         STATUS CODE
030500000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
030600000000    ?C                   PARM                    WQMSG                          MESSAGE ID
030700000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
030800000000    ? *___________________________________________________________________
030900000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03100000000003EXIT    F3=Exit
03110000000012CANCEL  F12=Cancel
03120000000025ROLLUP
03130000000026ROLLDOWN
031400000000** WTM
03150004082500
