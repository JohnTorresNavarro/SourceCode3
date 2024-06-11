000100000000      *_________________________________________________________________________
000200000000      *
000300010220      *  Description:  Display ISC Override
000400000000      *
000500010219      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900010220    ?FDSPOVRD   CF   E             WORKSTN
001000000000     F                                     INFDS(DSPD)
001100010220    ?FACCMST    IF   E           K DISK
001200010220    ?FPLNMST    IF   E           K DISK
001400000000    ? *_________________________________________________________________________
001500000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001600000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001700010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001800000000    ? *_________________________________________________________________________
001900000000    ? *
002000000406    ? * Data structure
002100010220    ?D WDDTA         E DS                  EXTNAME(ISCOVR)
002200000000    ? *
002300000000    ? * Program status data structure
002400991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002500000000    ? *
002600000000    ? * Display file data structure
002700991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002800000000    ? *_________________________________________________________________________
002900000000    ? * Process display panel
003000000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
003100000000    ? *
003200000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
003300000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
003400000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
003500000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
003600000000 001? *
003700000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
003800000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
003900000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
004000000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
004100000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004200000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
004300000000 001?C                   ENDCS                                                  END CASE
004400000000 001? *
004500000000E001?C                   ENDDO                                                  END DOWHILE
004600000000    ?C                   RETURN                                                 RETURN
004700000000    ? *___________________________________________________________________
004800000000    ? * Prepare display panel
004900000000    ? *___________________________________________________________________
005000000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
005100000000    ? *
005200000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
005300000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
005400000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
005500000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
005600000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
005700010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
005800000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
005900000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
006000000000    ? *
006100000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
006200000000    ?C                   EXSR      GETREC                                       GET RECORD
006300000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
006400000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
006500000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
006600000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
006700000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
006800000000E001?C                   ENDIF                                                  END IF ERROR
006900000000    ?C                   ENDSR                                                  END PRPPNL
007000000000    ? *___________________________________________________________________
007100000000    ? * Get record
007200000000    ? *___________________________________________________________________
007300000000    ?C     GETREC        BEGSR                                                  GET RECORD
007400010220    ?C                   CALL      'UPDOVR  '                                   PROCESS REC IO
007500000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
007600991201    ?C                   PARM                    WWRTN                          RETURN CODE
007700000614    ?C                   PARM                    WDDTA                          REC DATA
007800010223     C     IOEFDT        MULT      10000.0001    WSEFDT
007900010223     C     IOTRDT        MULT      10000.0001    WSTRDT
008000010220     C     IOCHGD        MULT      10000.0001    WSDATE
008100010220     C     KACC          Chain     ACCMST
008200010220     C                   If        %Found
008300010220     C                   Movel     acnam1        wsdes1
008400010220E001?C                   Endif                                                  END IF ERROR
008500010220     C     KPLN          Chain     PLNMST
008600010220     C                   If        %Found
008700010220     C                   Movel     pdescr        wsdes2
008800010220E001?C                   Endif                                                  END IF ERROR
008900000000    ?C                   ENDSR                                                  END GETREC
009000000000    ? *___________________________________________________________________
009100000000    ? * Receive messages
009200000000    ? *___________________________________________________________________
009300000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
009400000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
009500000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
009600000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
009700000000    ?C                   PARM                    WWIN                           INDICATORS
009800000000    ?C                   PARM                    WWRTN             8            RETURN CODE
009900000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
010000000000    ?C                   ENDSR                                                  END RCV MSG
010100000000    ? *___________________________________________________________________
010200000000    ? * Display the display panel
010300000000    ? *___________________________________________________________________
010400000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
010500000000    ? *
010600000000    ? * Set OVERLAY based on last display file processed
010700000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
010800000000 001?C                   SETOFF                                       35        OVERLAY OFF
010900000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
011000000000X001?C                   ELSE                                                   SAME PGM
011100000000 001?C                   SETON                                        35        OVERLAY ON
011200000000E001?C                   ENDIF                                                  END IF NEW PGM
011300000000    ? *
011400000000    ? * Write message subfile
011500000000    ?C                   SETON                                        30        SFLMSG DISPLAY
011600000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
011700000000    ? *
011800000000    ? * Write display panels
011900000000B001?C                   SELECT
012000000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
012100000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
012200000000E001?C                   ENDSL                                                  END SELECT
012300000000    ?C                   ENDSR                                                  END DSP DSP
012400000000    ? *___________________________________________________________________
012500000000    ? * Build function key information
012600000000    ? *___________________________________________________________________
012700000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
012800991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
012900991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
013000000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
013100000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
013200000000    ?C                   PARM                    WAD                            FNC DESC
013300991108    ?C                   PARM                    WWIN                           *IN
013400000000    ?C                   PARM                    WAF                            FNC KEY TABLE
013500000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
013600000000    ? *
013700000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
013800000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
013900000000    ?C                   SUB       1             WW                             BUMP IDX
014000000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
014100000000    ?C                   ENDSR                                                  END BLD FKY
014200000000    ? *___________________________________________________________________
014300000000    ? * Process function keys
014400000000    ? *___________________________________________________________________
014500000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
014600991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
014700991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
014800000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
014900000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
015000000000    ?C                   PARM                    WAD                            FNC DESC
015100991108    ?C                   PARM                    WWIN                           *IN
015200000000    ?C                   PARM                    WAF                            FNC KEY TABLE
015300000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
015400000000    ?C                   ENDSR                                                  END PRCFKY
015500000000    ? *___________________________________________________________________
015600000000    ? * Process KEYS function
015700000000    ? *___________________________________________________________________
015800000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
015900000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
016000000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
016100000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
016200000000 001? *
016300000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
016400000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
016500000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
016600000000E002?C                   ENDIF                                                  END IF OVER 3
016700000000 001? *
016800000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
016900000000 001?C                   SUB       1             WW                             KEY DESCR IDX
017000000000E001?C                   ENDDO                                                  END DO KEYS
017100000000    ? *
017200000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
017300000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
017400000000    ?C                   SUB       1             WW                             BUMP IDX
017500000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
017600000000    ? *
017700000000    ?C                   ENDSR                                                  END PRCDKY
017800000000    ? *___________________________________________________________________
017900000000    ? * Process RETURN function
018000000000    ? *___________________________________________________________________
018100000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
018200000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
018300000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
018400000000    ?C                   ENDSR                                                  END RETURN
018500000000    ? *___________________________________________________________________
018600000000    ? * Process CANCEL function
018700000000    ? *___________________________________________________________________
018800000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
018900000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
019000000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
019100000000    ?C                   ENDSR                                                  END PRCCNL
019200000000    ? *___________________________________________________________________
019300000000    ? * Process ROLLUP function
019400000000    ? *___________________________________________________________________
019500000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
019600000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
019700000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
019800000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
019900000000E001?C                   ENDIF                                                  END IF GT LST PNL
020000000000    ?C                   ENDSR                                                  END PRCRUP
020100000000    ? *___________________________________________________________________
020200000000    ? * Process ROLLDOWN function
020300000000    ? *___________________________________________________________________
020400000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
020500000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
020600000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
020700000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
020800000000E001?C                   ENDIF                                                  END IF LT FST PNL
020900000000    ?C                   ENDSR                                                  END PRCRDN
021000000000    ? *___________________________________________________________________
021100000000    ? * Process ENTER function
021200000000    ? *___________________________________________________________________
021300000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
021400000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
021500000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
021600000000    ?C                   ENDSR                                                  END PRCENT
021700000000    ? *___________________________________________________________________
021800000000    ? * Send message
021900000000    ? *___________________________________________________________________
022000000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
022100000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
022200000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
022300000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
022400000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
022500000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
022600000000    ?C                   ENDSR                                                  END SND MSG
022700000000    ? *___________________________________________________________________
022800000000    ? * Parameter lists
022900000000    ? *___________________________________________________________________
023000000000    ?C     PLIST         BEGSR                                                  PARM LISTS
023100000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
023200000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
023300000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
023400000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
023500000614    ?C                   PARM                    WDDTA                          RECORD DS
023600000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
023700000000    ?C                   ENDSR                                                  END PLIST
023800000000    ? *___________________________________________________________________
023900000000    ? * Initialize routine
024000000000    ? *___________________________________________________________________
024100000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
024200000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
024300010220    ?C                   MOVEL     'ISCOVR  '    WWFIL            10            FILE NAME-NOTES
024400000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
024500000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
024600010220    ?C     KACC          Klist                                                  DEFAULT DATA
024700010220     C                   Kfld                    IOTRST
024800010220     C                   Kfld                    IOSUB#
024900010220     C                   Kfld                    IOACCT
025000010220    ?C     KPLN          Klist                                                  DEFAULT DATA
025100010220     C                   Kfld                    IOTRST
025200010220     C                   Kfld                    IOSUB#
025300010220     C                   Kfld                    IOPLAN
025400000000    ?C                   ENDSR                                                  END *INZSR
025500000000    ? *___________________________________________________________________
025600000000    ? * Define  routine
025700000000    ? *___________________________________________________________________
025800000000    ?C     DEFN          BEGSR                                                  Define Fields
025900000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
026000000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
026100000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
026200000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
026300000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
026400000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
026500000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
026600000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
026700000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
026800000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
026900000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
027000000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
027100000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
027200000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
027300000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
027400000000    ?C                   ENDSR                                                  END DEFN
027500000000    ? *___________________________________________________________________
027600000000    ? * Program error handler
027700000000    ? *___________________________________________________________________
027800000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
027900000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
028000000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
028100000000    ?C                   PARM                    WQSTSC                         STATUS CODE
028200000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
028300000000    ?C                   PARM                    WQMSG                          MESSAGE ID
028400000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
028500000000    ? *___________________________________________________________________
028600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02870000000003EXIT    F3=Exit
02880000000012CANCEL  F12=Cancel
02890000000025ROLLUP
02900000000026ROLLDOWN
029100000000** WTM
02920001022000Internal Sales Commission Type not found.
