000100000000      *_________________________________________________________________________
000200000000      *
000300010219      *  Description:  Display ISC Agency
000400000000      *
000500010219      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900010219    ?FDSPAGYD   CF   E             WORKSTN
001000000000     F                                     INFDS(DSPD)
001100010219    ?FISCSMN    if   e           k disk
001200010219    ?FAGENCY    if   e           k Disk
001300000000    ? *_________________________________________________________________________
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001600010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001700000000    ? *_________________________________________________________________________
001800000000    ? *
001900000406    ? * Data structure
002000010219    ?D WDDTA         E DS                  EXTNAME(ISCAGY)
002100000000    ? *
002200000000    ? * Program status data structure
002300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002400000000    ? *
002500000000    ? * Display file data structure
002600991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002700000000    ? *_________________________________________________________________________
002800000000    ? * Process display panel
002900000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
003000000000    ? *
003100000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
003200000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
003300000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
003400000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
003500000000 001? *
003600000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
003700000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
003800000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
003900000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
004000000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004100000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
004200000000 001?C                   ENDCS                                                  END CASE
004300000000 001? *
004400000000E001?C                   ENDDO                                                  END DOWHILE
004500000000    ?C                   RETURN                                                 RETURN
004600000000    ? *___________________________________________________________________
004700000000    ? * Prepare display panel
004800000000    ? *___________________________________________________________________
004900000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
005000000000    ? *
005100000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
005200000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
005300000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
005400000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
005500000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
005600010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
005700000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
005800000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
005900000000    ? *
006000000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
006100000000    ?C                   EXSR      GETREC                                       GET RECORD
006200000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
006300000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
006400000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
006500000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
006600000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
006700000000E001?C                   ENDIF                                                  END IF ERROR
006800000000    ?C                   ENDSR                                                  END PRPPNL
006900000000    ? *___________________________________________________________________
007000000000    ? * Get record
007100000000    ? *___________________________________________________________________
007200000000    ?C     GETREC        BEGSR                                                  GET RECORD
007300010219    ?C                   CALL      'UPDAGY  '                                   PROCESS REC IO
007400000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
007500991201    ?C                   PARM                    WWRTN                          RETURN CODE
007600000614    ?C                   PARM                    WDDTA                          REC DATA
007700010301     C     IAEFDT        MULT      10000.0001    WSEFDT
007800010301     C     IATRDT        MULT      10000.0001    WSTRDT
007900010301     C     IACHGD        MULT      10000.0001    WSDATE
008000000000    ?C                   ENDSR                                                  END GETREC
008100000000    ? *___________________________________________________________________
008200000000    ? * Receive messages
008300000000    ? *___________________________________________________________________
008400000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
008500000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
008600000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
008700000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
008800000000    ?C                   PARM                    WWIN                           INDICATORS
008900000000    ?C                   PARM                    WWRTN             8            RETURN CODE
009000000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
009100000000    ?C                   ENDSR                                                  END RCV MSG
009200000000    ? *___________________________________________________________________
009300000000    ? * Display the display panel
009400000000    ? *___________________________________________________________________
009500000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
009600000000    ? *
009700000000    ? * Set OVERLAY based on last display file processed
009800000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
009900000000 001?C                   SETOFF                                       35        OVERLAY OFF
010000000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
010100000000X001?C                   ELSE                                                   SAME PGM
010200000000 001?C                   SETON                                        35        OVERLAY ON
010300000000E001?C                   ENDIF                                                  END IF NEW PGM
010400000000    ? *
010500000000    ? * Write message subfile
010600000000    ?C                   SETON                                        30        SFLMSG DISPLAY
010700000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
010800000000    ? *
010900000000    ? * Write display panels
011000000000B001?C                   SELECT
011100000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
011200010219    ?C     IAAGNY        Chain     AGENCY
011300010219B003?C                   If        %found
011400010219     C                   MOVEL     AGNAM1        WSAGNY
011500010219E003?C                   Else
011600010219     C                   Clear                   WSAGNY
011700010219E003?C                   End
011800010219    ?C     IASMAN        Chain     ISCSMN
011900010219B003?C                   If        %found
012000010219 003?C                   Eval      WSNAME   =    %trim(ISFNAM) +
012100010219 003?C                                           ' ' + ISLNAM
012200010219E003?C                   Else
012300010219     C                   Clear                   WSNAME
012400010219E003?C                   End
012500000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
012600000000E001?C                   ENDSL                                                  END SELECT
012700000000    ?C                   ENDSR                                                  END DSP DSP
012800000000    ? *___________________________________________________________________
012900000000    ? * Build function key information
013000000000    ? *___________________________________________________________________
013100000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
013200991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
013300991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
013400000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
013500000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
013600000000    ?C                   PARM                    WAD                            FNC DESC
013700991108    ?C                   PARM                    WWIN                           *IN
013800000000    ?C                   PARM                    WAF                            FNC KEY TABLE
013900000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
014000000000    ? *
014100000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
014200000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
014300000000    ?C                   SUB       1             WW                             BUMP IDX
014400000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
014500000000    ?C                   ENDSR                                                  END BLD FKY
014600000000    ? *___________________________________________________________________
014700000000    ? * Process function keys
014800000000    ? *___________________________________________________________________
014900000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
015000991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
015100991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
015200000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
015300000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
015400000000    ?C                   PARM                    WAD                            FNC DESC
015500991108    ?C                   PARM                    WWIN                           *IN
015600000000    ?C                   PARM                    WAF                            FNC KEY TABLE
015700000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
015800000000    ?C                   ENDSR                                                  END PRCFKY
015900000000    ? *___________________________________________________________________
016000000000    ? * Process KEYS function
016100000000    ? *___________________________________________________________________
016200000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
016300000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
016400000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
016500000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
016600000000 001? *
016700000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
016800000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
016900000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
017000000000E002?C                   ENDIF                                                  END IF OVER 3
017100000000 001? *
017200000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
017300000000 001?C                   SUB       1             WW                             KEY DESCR IDX
017400000000E001?C                   ENDDO                                                  END DO KEYS
017500000000    ? *
017600000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
017700000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
017800000000    ?C                   SUB       1             WW                             BUMP IDX
017900000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
018000000000    ? *
018100000000    ?C                   ENDSR                                                  END PRCDKY
018200000000    ? *___________________________________________________________________
018300000000    ? * Process RETURN function
018400000000    ? *___________________________________________________________________
018500000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
018600000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
018700000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
018800000000    ?C                   ENDSR                                                  END RETURN
018900000000    ? *___________________________________________________________________
019000000000    ? * Process CANCEL function
019100000000    ? *___________________________________________________________________
019200000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
019300000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
019400000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
019500000000    ?C                   ENDSR                                                  END PRCCNL
019600000000    ? *___________________________________________________________________
019700000000    ? * Process ROLLUP function
019800000000    ? *___________________________________________________________________
019900000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
020000000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
020100000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
020200000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
020300000000E001?C                   ENDIF                                                  END IF GT LST PNL
020400000000    ?C                   ENDSR                                                  END PRCRUP
020500000000    ? *___________________________________________________________________
020600000000    ? * Process ROLLDOWN function
020700000000    ? *___________________________________________________________________
020800000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
020900000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
021000000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
021100000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
021200000000E001?C                   ENDIF                                                  END IF LT FST PNL
021300000000    ?C                   ENDSR                                                  END PRCRDN
021400000000    ? *___________________________________________________________________
021500000000    ? * Process ENTER function
021600000000    ? *___________________________________________________________________
021700000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
021800000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
021900000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
022000000000    ?C                   ENDSR                                                  END PRCENT
022100000000    ? *___________________________________________________________________
022200000000    ? * Send message
022300000000    ? *___________________________________________________________________
022400000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
022500000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
022600000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
022700000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
022800000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
022900000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
023000000000    ?C                   ENDSR                                                  END SND MSG
023100000000    ? *___________________________________________________________________
023200000000    ? * Parameter lists
023300000000    ? *___________________________________________________________________
023400000000    ?C     PLIST         BEGSR                                                  PARM LISTS
023500000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
023600000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
023700000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
023800000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
023900000614    ?C                   PARM                    WDDTA                          RECORD DS
024000000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
024100000000    ?C                   ENDSR                                                  END PLIST
024200000000    ? *___________________________________________________________________
024300000000    ? * Initialize routine
024400000000    ? *___________________________________________________________________
024500000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
024600000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
024700010219    ?C                   MOVEL     'ISCAGY  '    WWFIL            10            FILE NAME-NOTES
024800000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
024900000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
025000000000    ?C                   ENDSR                                                  END *INZSR
025100000000    ? *___________________________________________________________________
025200000000    ? * Define  routine
025300000000    ? *___________________________________________________________________
025400000000    ?C     DEFN          BEGSR                                                  Define Fields
025500000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
025600000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
025700000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
025800000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
025900000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
026000000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
026100000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
026200000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
026300000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
026400000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
026500000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
026600000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
026700000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
026800000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
026900000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
027000000000    ?C                   ENDSR                                                  END DEFN
027100000000    ? *___________________________________________________________________
027200000000    ? * Program error handler
027300000000    ? *___________________________________________________________________
027400000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
027500000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
027600000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
027700000000    ?C                   PARM                    WQSTSC                         STATUS CODE
027800000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
027900000000    ?C                   PARM                    WQMSG                          MESSAGE ID
028000000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
028100000000    ? *___________________________________________________________________
028200000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02830000000003EXIT    F3=Exit
02840000000012CANCEL  F12=Cancel
02850000000025ROLLUP
02860000000026ROLLDOWN
028700000000** WTM
02880001021900Internal Sales Commission Agency not found.
