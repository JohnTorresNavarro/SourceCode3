000100000000      *_________________________________________________________________________
000200000000      *
000300070216      *  Description:  Display Market Exclude Account
000400000000      *
000500070216      *  (c)Copyright 2007 by GBS, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900070216    ?FDSPMKED   CF   E             WORKSTN
001000000000     F                                     INFDS(DSPD)
001100070216    ?FMKTRNE    if   e           k disk
001300060712    ?FACCMST    if   e           k disk
001400000000    ? *_________________________________________________________________________
001500000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001600000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001700010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001800000000    ? *_________________________________________________________________________
001900000000    ? *
002000000406    ? * Data structure
002100070216    ?D WDDTA         E DS                  EXTNAME(MKTRNE)
003200000000    ? *
003300000000    ? * Program status data structure
003400991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003500000000    ? *
003600000000    ? * Display file data structure
003700991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003800000000    ? *_________________________________________________________________________
003900000000    ? * Process display panel
004000000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
004100000000    ? *
004200000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
004300000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
004400000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
004500000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
004600000000 001? *
004700000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
004800000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
004900000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
005000000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
005100000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005200000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
005300000000 001?C                   ENDCS                                                  END CASE
005400000000 001? *
005500000000E001?C                   ENDDO                                                  END DOWHILE
005600000000    ?C                   RETURN                                                 RETURN
005700000000    ? *___________________________________________________________________
005800000000    ? * Prepare display panel
005900000000    ? *___________________________________________________________________
006000000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
006100000000    ? *
006300060712     C                   Clear                   ACNAM1
006400060712    ? *
006500000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
006600000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
006700000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
006800000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
006900000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
007000010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
007100000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
007200000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
007300000000    ? *
007400000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
007500000000    ?C                   EXSR      GETREC                                       GET RECORD
007600000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
007700000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
007800000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
007900000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
008000000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
008100000000E001?C                   ENDIF                                                  END IF ERROR
008200000000    ?C                   ENDSR                                                  END PRPPNL
008300000000    ? *___________________________________________________________________
008400000000    ? * Get record
008500000000    ? *___________________________________________________________________
008600000000    ?C     GETREC        BEGSR                                                  GET RECORD
008700070216    ?C                   CALL      'UPDMKE  '                                   PROCESS REC IO
008800000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
008900991201    ?C                   PARM                    WWRTN                          RETURN CODE
009000000614    ?C                   PARM                    WDDTA                          REC DATA
009001070216     C     MEEEDT        MULT      10000.0001    MEEEDT
009002070216     C     MECHDT        MULT      10000.0001    MECHDT
009100000000    ?C                   ENDSR                                                  END GETREC
009200000000    ? *___________________________________________________________________
009300000000    ? * Receive messages
009400000000    ? *___________________________________________________________________
009500000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
009600000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
009700000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
009800000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
009900000000    ?C                   PARM                    WWIN                           INDICATORS
010000000000    ?C                   PARM                    WWRTN             8            RETURN CODE
010100000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
010200000000    ?C                   ENDSR                                                  END RCV MSG
010300000000    ? *___________________________________________________________________
010400000000    ? * Display the display panel
010500000000    ? *___________________________________________________________________
010600000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
010700000000    ? *
010800000000    ? * Set OVERLAY based on last display file processed
010900000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
011000000000 001?C                   SETOFF                                       35        OVERLAY OFF
011100000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
011200000000X001?C                   ELSE                                                   SAME PGM
011300000000 001?C                   SETON                                        35        OVERLAY ON
011400000000E001?C                   ENDIF                                                  END IF NEW PGM
011500000000    ? *
011600000000    ? * Write message subfile
011700000000    ?C                   SETON                                        30        SFLMSG DISPLAY
011800000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
011900000000    ? *
012000000000    ? * Write display panels
012100000000B001?C                   SELECT
012200000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
012800070216    ?C     ACCKEY        Chain     MKTRNE
012900060712    ? *
012901070216     C     MEEEDT        Mult      10000.0001    MEEEDT
012902070216     C     MECHDT        Mult      10000.0001    MECHDT
012903070216    ? *
013500060712     C     ACCKEY        klist
013600070216     C                   kfld                    METRST
013700070216     C                   kfld                    MESUB#
013800070216     C                   kfld                    MEACCT
013900060712     C     ACCKEY        Chain     ACCMST
014000060712    ? *
014100000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
014200000000E001?C                   ENDSL                                                  END SELECT
014300000000    ?C                   ENDSR                                                  END DSP DSP
014400000000    ? *___________________________________________________________________
014500000000    ? * Build function key information
014600000000    ? *___________________________________________________________________
014700000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
014800991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
014900991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
015000000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
015100000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
015200000000    ?C                   PARM                    WAD                            FNC DESC
015300991108    ?C                   PARM                    WWIN                           *IN
015400000000    ?C                   PARM                    WAF                            FNC KEY TABLE
015500000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
015600000000    ? *
015700010913    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
015800010913    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
015900010913    ?C                   SUB       1             WW                             BUMP IDX
016000010913    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
016100000000    ?C                   ENDSR                                                  END BLD FKY
016200000000    ? *___________________________________________________________________
016300000000    ? * Process function keys
016400000000    ? *___________________________________________________________________
016500000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
016600991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
016700991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
016800000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
016900000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
017000000000    ?C                   PARM                    WAD                            FNC DESC
017100991108    ?C                   PARM                    WWIN                           *IN
017200000000    ?C                   PARM                    WAF                            FNC KEY TABLE
017300000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
017400000000    ?C                   ENDSR                                                  END PRCFKY
017500000000    ? *___________________________________________________________________
017600000000    ? * Process KEYS function
017700000000    ? *___________________________________________________________________
017800000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
017900000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
018000000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
018100000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
018200000000 001? *
018300000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
018400000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
018500000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
018600000000E002?C                   ENDIF                                                  END IF OVER 3
018700000000 001? *
018800000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
018900000000 001?C                   SUB       1             WW                             KEY DESCR IDX
019000000000E001?C                   ENDDO                                                  END DO KEYS
019100000000    ? *
019200000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
019300000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
019400000000    ?C                   SUB       1             WW                             BUMP IDX
019500000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
019600000000    ? *
019700000000    ?C                   ENDSR                                                  END PRCDKY
019800000000    ? *___________________________________________________________________
019900000000    ? * Process RETURN function
020000000000    ? *___________________________________________________________________
020100000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
020200000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
020300000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
020400000000    ?C                   ENDSR                                                  END RETURN
020500000000    ? *___________________________________________________________________
020600000000    ? * Process CANCEL function
020700000000    ? *___________________________________________________________________
020800000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
020900000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
021000000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
021100000000    ?C                   ENDSR                                                  END PRCCNL
021200000000    ? *___________________________________________________________________
021300000000    ? * Process ROLLUP function
021400000000    ? *___________________________________________________________________
021500000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
021600000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
021700000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
021800000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
021900000000E001?C                   ENDIF                                                  END IF GT LST PNL
022000000000    ?C                   ENDSR                                                  END PRCRUP
022100000000    ? *___________________________________________________________________
022200000000    ? * Process ROLLDOWN function
022300000000    ? *___________________________________________________________________
022400000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
022500000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
022600000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
022700000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
022800000000E001?C                   ENDIF                                                  END IF LT FST PNL
022900000000    ?C                   ENDSR                                                  END PRCRDN
023000000000    ? *___________________________________________________________________
023100000000    ? * Process ENTER function
023200000000    ? *___________________________________________________________________
023300000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
023400000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
023500000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
023600000000    ?C                   ENDSR                                                  END PRCENT
023700000000    ? *___________________________________________________________________
023800000000    ? * Send message
023900000000    ? *___________________________________________________________________
024000000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
024100000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
024200000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
024300000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
024400000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
024500000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
024600000000    ?C                   ENDSR                                                  END SND MSG
024700000000    ? *___________________________________________________________________
024800000000    ? * Parameter lists
024900000000    ? *___________________________________________________________________
025000000000    ?C     PLIST         BEGSR                                                  PARM LISTS
025100000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
025200000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
025300000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
025400000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
025500000614    ?C                   PARM                    WDDTA                          RECORD DS
025600000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
025700000000    ?C                   ENDSR                                                  END PLIST
025800000000    ? *___________________________________________________________________
025900000000    ? * Initialize routine
026000000000    ? *___________________________________________________________________
026100000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
026200000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
026300070216    ?C                   MOVEL     'MKTRNE  '    WWFIL            10            FILE NAME-
026400070216    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY -
026500070216    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT -
026600000000    ?C                   ENDSR                                                  END *INZSR
026700000000    ? *___________________________________________________________________
026800000000    ? * Define  routine
026900000000    ? *___________________________________________________________________
027000000000    ?C     DEFN          BEGSR                                                  Define Fields
027100000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
027200000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
027300000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
027400000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
027500000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
027600000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
027700000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
027800000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
027900000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
028000000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
028100000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
028200000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
028300070216    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-
028400070216    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY -
028500070216    ?C                   MOVE      WWTXT         WWTXT            60            TEXT -
028600000000    ?C                   ENDSR                                                  END DEFN
028700000000    ? *___________________________________________________________________
028800000000    ? * Program error handler
028900000000    ? *___________________________________________________________________
029000000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
029100000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
029200000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
029300000000    ?C                   PARM                    WQSTSC                         STATUS CODE
029400000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
029500000000    ?C                   PARM                    WQMSG                          MESSAGE ID
029600000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
029700000000    ? *___________________________________________________________________
029800070216**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A               |
02990000000003EXIT    F3=Exit
03000000000012CANCEL  F12=Cancel
03010000000025ROLLUP
03020000000026ROLLDOWN
030300000000** WTM
03040007021600Exclusion not found.
