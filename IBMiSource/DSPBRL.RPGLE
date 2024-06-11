000100000000      *_________________________________________________________________________
000200000000      *
000300040220      *  Description:  Display Broker Representative
000400000000      *
000500040220      *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900040928    ?FDSPBRLD   CF   E             WORKSTN INFDS(DSPD)
001000040220    ?FBRKREP    if   e           k disk
001100000000    ? *_________________________________________________________________________
001200000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001400010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001500000000    ? *_________________________________________________________________________
001600000000    ? *
001700000406    ? * Data structure
001800040220    ?D WDDTA         E DS                  EXTNAME(BRKREP)
001900000000    ? *
002000000000    ? * Program status data structure
002100991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002200000000    ? *
002300000000    ? * Display file data structure
002400991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002500040322    ? *_________________________________________________________________________
002600040322     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
002700040322     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
002800040928     d @lda            ds
002900040928     d blah                    1    240a
003000040928     d co_name               200    240a
003100000000    ? *_________________________________________________________________________
003200000000    ? * Process display panel
003300000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
003400000000    ? *
003500000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
003600000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
003700000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
003800000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
003900000000 001? *
004000000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
004100000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
004200000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
004300000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
004400000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004500000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
004600000000 001?C                   ENDCS                                                  END CASE
004700000000 001? *
004800000000E001?C                   ENDDO                                                  END DOWHILE
004900000000    ?C                   RETURN                                                 RETURN
005000000000    ? *___________________________________________________________________
005100000000    ? * Prepare display panel
005200000000    ? *___________________________________________________________________
005300000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
005400000000    ? *
005500000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
005600000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
005700000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
005800000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
005900000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
006000010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
006100000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
006200000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
006300040928    ? *
006400040928     C     *DTAARA       DEFINE    *LDA          @LDA
006500040928     C                   IN        @LDA
006600040928     c                   eval      wsname = co_name
006700000000    ? *
006800000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
006900000000    ?C                   EXSR      GETREC                                       GET RECORD
007000000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
007100000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
007200000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
007300000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
007400000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
007500000000E001?C                   ENDIF                                                  END IF ERROR
007600000000    ?C                   ENDSR                                                  END PRPPNL
007700000000    ? *___________________________________________________________________
007800000000    ? * Get record
007900000000    ? *___________________________________________________________________
008000000000    ?C     GETREC        BEGSR                                                  GET RECORD
008100040220    ?C                   CALL      'UPDBRL  '                                   PROCESS REC IO
008200000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
008300991201    ?C                   PARM                    WWRTN                          RETURN CODE
008400000614    ?C                   PARM                    WDDTA                          REC DATA
008500000000    ?C                   ENDSR                                                  END GETREC
008600000000    ? *___________________________________________________________________
008700000000    ? * Receive messages
008800000000    ? *___________________________________________________________________
008900000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
009000000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
009100000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
009200000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
009300000000    ?C                   PARM                    WWIN                           INDICATORS
009400000000    ?C                   PARM                    WWRTN             8            RETURN CODE
009500000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
009600000000    ?C                   ENDSR                                                  END RCV MSG
009700000000    ? *___________________________________________________________________
009800000000    ? * Display the display panel
009900000000    ? *___________________________________________________________________
010000000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
010100000000    ? *
010200000000    ? * Set OVERLAY based on last display file processed
010300000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
010400000000 001?C                   SETOFF                                       35        OVERLAY OFF
010500000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
010600000000X001?C                   ELSE                                                   SAME PGM
010700000000 001?C                   SETON                                        35        OVERLAY ON
010800000000E001?C                   ENDIF                                                  END IF NEW PGM
010900000000    ? *
011000000000    ? * Write message subfile
011100000000    ?C                   SETON                                        30        SFLMSG DISPLAY
011200000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
011300000000    ? *
011400000000    ? * Write display panels
011500000000B001?C                   SELECT
011600000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
011700040322     c
011800040322     C                   IF        BRkTMD <> *ZEROS
011900040322     C                   MOVE      BRkTMD        ISO_DATE
012000040322     C                   MOVE      ISO_DATE      USA_DATE
012100040322     C                   MOVE      USA_DATE      BRkTMD
012200040322    1C                   ENDIF
012300040322     c
012400000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
012500040322     c
012600040322     C                   IF        BRkTMD <> *ZEROS
012700040322     C                   MOVE      BRkTMD        usa_DATE
012800040322     C                   MOVE      usa_DATE      iso_DATE
012900040322     C                   MOVE      iso_DATE      BRkTMD
013000040322    1C                   ENDIF
013100040322     c
013200000000E001?C                   ENDSL                                                  END SELECT
013300000000    ?C                   ENDSR                                                  END DSP DSP
013400000000    ? *___________________________________________________________________
013500000000    ? * Build function key information
013600000000    ? *___________________________________________________________________
013700000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
013800991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
013900991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
014000000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
014100000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
014200000000    ?C                   PARM                    WAD                            FNC DESC
014300991108    ?C                   PARM                    WWIN                           *IN
014400000000    ?C                   PARM                    WAF                            FNC KEY TABLE
014500000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
014600000000    ? *
014700010913    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
014800010913    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
014900010913    ?C                   SUB       1             WW                             BUMP IDX
015000010913    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
015100000000    ?C                   ENDSR                                                  END BLD FKY
015200000000    ? *___________________________________________________________________
015300000000    ? * Process function keys
015400000000    ? *___________________________________________________________________
015500000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
015600991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
015700991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
015800000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
015900000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
016000000000    ?C                   PARM                    WAD                            FNC DESC
016100991108    ?C                   PARM                    WWIN                           *IN
016200000000    ?C                   PARM                    WAF                            FNC KEY TABLE
016300000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
016400000000    ?C                   ENDSR                                                  END PRCFKY
016500000000    ? *___________________________________________________________________
016600000000    ? * Process KEYS function
016700000000    ? *___________________________________________________________________
016800000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
016900000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
017000000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
017100000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
017200000000 001? *
017300000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
017400000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
017500000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
017600000000E002?C                   ENDIF                                                  END IF OVER 3
017700000000 001? *
017800000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
017900000000 001?C                   SUB       1             WW                             KEY DESCR IDX
018000000000E001?C                   ENDDO                                                  END DO KEYS
018100000000    ? *
018200000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
018300000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
018400000000    ?C                   SUB       1             WW                             BUMP IDX
018500000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
018600000000    ? *
018700000000    ?C                   ENDSR                                                  END PRCDKY
018800000000    ? *___________________________________________________________________
018900000000    ? * Process RETURN function
019000000000    ? *___________________________________________________________________
019100000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
019200000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
019300000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
019400000000    ?C                   ENDSR                                                  END RETURN
019500000000    ? *___________________________________________________________________
019600000000    ? * Process CANCEL function
019700000000    ? *___________________________________________________________________
019800000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
019900000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
020000000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
020100000000    ?C                   ENDSR                                                  END PRCCNL
020200000000    ? *___________________________________________________________________
020300000000    ? * Process ROLLUP function
020400000000    ? *___________________________________________________________________
020500000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
020600000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
020700000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
020800000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
020900000000E001?C                   ENDIF                                                  END IF GT LST PNL
021000000000    ?C                   ENDSR                                                  END PRCRUP
021100000000    ? *___________________________________________________________________
021200000000    ? * Process ROLLDOWN function
021300000000    ? *___________________________________________________________________
021400000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
021500000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
021600000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
021700000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
021800000000E001?C                   ENDIF                                                  END IF LT FST PNL
021900000000    ?C                   ENDSR                                                  END PRCRDN
022000000000    ? *___________________________________________________________________
022100000000    ? * Process ENTER function
022200000000    ? *___________________________________________________________________
022300000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
022400000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
022500000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
022600000000    ?C                   ENDSR                                                  END PRCENT
022700000000    ? *___________________________________________________________________
022800000000    ? * Send message
022900000000    ? *___________________________________________________________________
023000000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
023100000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
023200000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
023300000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
023400000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
023500000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
023600000000    ?C                   ENDSR                                                  END SND MSG
023700000000    ? *___________________________________________________________________
023800000000    ? * Parameter lists
023900000000    ? *___________________________________________________________________
024000000000    ?C     PLIST         BEGSR                                                  PARM LISTS
024100000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
024200000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
024300000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
024400000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
024500000614    ?C                   PARM                    WDDTA                          RECORD DS
024600000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
024700000000    ?C                   ENDSR                                                  END PLIST
024800000000    ? *___________________________________________________________________
024900000000    ? * Initialize routine
025000000000    ? *___________________________________________________________________
025100000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
025200000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
025300040220    ?C                   MOVEL     'BRKREP'      WWFIL            10            FILE NAME-NOTES
025400000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
025500000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
025600000000    ?C                   ENDSR                                                  END *INZSR
025700000000    ? *___________________________________________________________________
025800000000    ? * Define  routine
025900000000    ? *___________________________________________________________________
026000000000    ?C     DEFN          BEGSR                                                  Define Fields
026100000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
026200000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
026300000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
026400000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
026500000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
026600000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
026700000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
026800000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
026900000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
027000000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
027100000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
027200000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
027300000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
027400000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
027500000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
027600000000    ?C                   ENDSR                                                  END DEFN
027700000000    ? *___________________________________________________________________
027800000000    ? * Program error handler
027900000000    ? *___________________________________________________________________
028000000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
028100000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
028200000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
028300000000    ?C                   PARM                    WQSTSC                         STATUS CODE
028400000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
028500000000    ?C                   PARM                    WQMSG                          MESSAGE ID
028600000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
028700000000    ? *___________________________________________________________________
028800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02890000000003EXIT    F3=Exit
02900000000012CANCEL  F12=Cancel
02910000000025ROLLUP
02920000000026ROLLDOWN
029300000000** WTM
02940004022000Broker Rep not found.
