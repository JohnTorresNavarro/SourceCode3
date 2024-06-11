000100000000      *_________________________________________________________________________
000200000000      *
000300030717      *  Description:  Display E&O Coverage file
000400000000      *
000500030716      *  (c)Copyright 2003 by Group Benefit Services, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900180319    ?FDSPGEND   CF   E             WORKSTN
001000000000     F                                     INFDS(DSPD)
001100030717    ?FSMAN      IF   E           K DISK
001200030716    ?FSMANRLT   IF   E           K DISK
001300030717    ?FAGENCY    IF   E           K DISK
001400030716    ?FSPRAGXR2  IF   E           K DISK
001500030717    ?FSUPRAGCY  IF   E           K DISK
001600031117    ?FBLILMANL2 IF   E           K DISK
001700000000    ? *_________________________________________________________________________
001800000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001900000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002000010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
002100000000    ? *_________________________________________________________________________
002200000000    ? *
002300000406    ? * Data structure
002400180319    ?D WDDTA         E DS                  EXTNAME(BLIGEN)
002500000000    ? *
002600000000    ? * Program status data structure
002700991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002800000000    ? *
002900000000    ? * Display file data structure
003000991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
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
005500031117     C                   If        WORTN    =    'NON'
005600031117     C                   Move      'Y'           Noncom            1
005700031117     C                   Eval      WTITLE = 'Non Commission'
005800031117     C                   Else
005900031117     C                   Move      ' '           Noncom
006000031117     C                   Eval      WTITLE = '  Commission  '
006100031117     C                   End
006200031117    ? *
006300000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
006400000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
006500000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
006600000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
006700000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
006800010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
006900000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
007000000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
007100000000    ? *
007200000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
007300000000    ?C                   EXSR      GETREC                                       GET RECORD
007400000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
007500000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
007600000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
007700000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
007800000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
007900000000E001?C                   ENDIF                                                  END IF ERROR
008000030716     C                   EXSR      GETSMAN
008100000000    ?C                   ENDSR                                                  END PRPPNL
008200030716    ? *___________________________________________________________________
008300030716    ? * GET SALESMAN
008400030716    ? *___________________________________________________________________
008500030716    ?C     GETSMAN       Begsr                                                  PARM LISTS
008600031117     C                   If        NonCom = 'Y'
008700031117     C     LERELI        CHAIN     BLILMANL2
008800031117     C                   IF        %FOUND
008900031117     C                   Eval      wssman = lmanc
009000031117     C                   Eval      wsnam1 = %trim(lmann)
009100031117     C                   Eval      wsagcy = lagcy
009200031117     C                   Eval      wsnam2 = %trim(lagcn)
009300031117     C                   Eval      wssupr = lsupr
009400031117     C                   Eval      wsnam3 = %trim(lsupn)
009500031117     C                   End
009600031117     C                   Else
009700030717     C     LERELI        CHAIN     SMANRLT
009800030716     C                   IF        NOT %FOUND
009900031117     C                   CLEAR                   WSSMAN
010000030717     C                   ELSE
010100031117     C                   EVAL      WSSMAN   =    SRSMAN
010200030717     C     SRSMAN        CHAIN     SMAN
010300030717     C                   IF        NOT %FOUND
010400030717     C                   CLEAR                   WSNAM1
010500030717     C                   ELSE
010600030717     C                   EVAL      WSNAM1 = %trim(SFNAME) + ' ' + %trim(SLNAME)
010700030717     C                   END
010800030716     C                   END
010900030716     C     SRASID        CHAIN     SPRAGXR2
011000030716     C                   IF        NOT %FOUND
011100031117     C                   CLEAR                   WSSUPR
011200031117     C                   CLEAR                   WSAGCY
011300031117     C                   CLEAR                   WSNAM3
011400030717     C                   ELSE
011500031117     C                   EVAL      WSSUPR =      SXSUPER
011600031117     C                   EVAL      WSAGCY =      SXAGCY
011700030717     C     SXAGCY        CHAIN     AGENCY
011800030717     C                   IF        NOT %FOUND
011900030717     C                   CLEAR                   WSNAM2
012000030717     C                   ELSE
012100030717     C                   EVAL      WSNAM2 = %trim(AGNAM1)
012200030717     C                   END
012300030717     C     SXSUPER       CHAIN     SUPRAGCY
012400030717     C                   IF        NOT %FOUND
012500030717     C                   CLEAR                   WSNAM3
012600030717     C                   ELSE
012700030717     C                   EVAL      WSNAM3 = %trim(SANAME1)
012800030717     C                   END
012900031117     C                   END
013000030716     C                   END
013100030716    ?C                   Endsr                                                  END PLIST
013200000000    ? *___________________________________________________________________
013300000000    ? * Get record
013400000000    ? *___________________________________________________________________
013500000000    ?C     GETREC        BEGSR                                                  GET RECORD
013600180319    ?C                   CALL      'UPDGEN  '                                   PROCESS REC IO
013700000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
013800991201    ?C                   PARM                    WWRTN                          RETURN CODE
013900000614    ?C                   PARM                    WDDTA                          REC DATA
014000030717     C     LECHGD        MULT      10000.0001    WSDATE
014100030722     C     LEEFFD        MULT      10000.0001    WSEFDT
014200030722     C     LEEXPD        MULT      10000.0001    WSTRDT
014300000000    ?C                   ENDSR                                                  END GETREC
014400000000    ? *___________________________________________________________________
014500000000    ? * Receive messages
014600000000    ? *___________________________________________________________________
014700000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
014800000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
014900000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
015000000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
015100000000    ?C                   PARM                    WWIN                           INDICATORS
015200000000    ?C                   PARM                    WWRTN             8            RETURN CODE
015300000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
015400000000    ?C                   ENDSR                                                  END RCV MSG
015500000000    ? *___________________________________________________________________
015600000000    ? * Display the display panel
015700000000    ? *___________________________________________________________________
015800000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
015900000000    ? *
016000000000    ? * Set OVERLAY based on last display file processed
016100000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
016200000000 001?C                   SETOFF                                       35        OVERLAY OFF
016300000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
016400000000X001?C                   ELSE                                                   SAME PGM
016500000000 001?C                   SETON                                        35        OVERLAY ON
016600000000E001?C                   ENDIF                                                  END IF NEW PGM
016700000000    ? *
016800000000    ? * Write message subfile
016900000000    ?C                   SETON                                        30        SFLMSG DISPLAY
017000000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
017100000000    ? *
017200000000    ? * Write display panels
017300000000B001?C                   SELECT
017400000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
017500000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
017600000000E001?C                   ENDSL                                                  END SELECT
017700000000    ?C                   ENDSR                                                  END DSP DSP
017800000000    ? *___________________________________________________________________
017900000000    ? * Build function key information
018000000000    ? *___________________________________________________________________
018100000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
018200991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
018300991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
018400000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
018500000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
018600000000    ?C                   PARM                    WAD                            FNC DESC
018700991108    ?C                   PARM                    WWIN                           *IN
018800000000    ?C                   PARM                    WAF                            FNC KEY TABLE
018900000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
019000000000    ? *
019100000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
019200000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
019300000000    ?C                   SUB       1             WW                             BUMP IDX
019400000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
019500000000    ?C                   ENDSR                                                  END BLD FKY
019600000000    ? *___________________________________________________________________
019700000000    ? * Process function keys
019800000000    ? *___________________________________________________________________
019900000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
020000991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
020100991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
020200000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
020300000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
020400000000    ?C                   PARM                    WAD                            FNC DESC
020500991108    ?C                   PARM                    WWIN                           *IN
020600000000    ?C                   PARM                    WAF                            FNC KEY TABLE
020700000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
020800000000    ?C                   ENDSR                                                  END PRCFKY
020900000000    ? *___________________________________________________________________
021000000000    ? * Process KEYS function
021100000000    ? *___________________________________________________________________
021200000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
021300000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
021400000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
021500000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
021600000000 001? *
021700000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
021800000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
021900000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
022000000000E002?C                   ENDIF                                                  END IF OVER 3
022100000000 001? *
022200000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
022300000000 001?C                   SUB       1             WW                             KEY DESCR IDX
022400000000E001?C                   ENDDO                                                  END DO KEYS
022500000000    ? *
022600000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
022700000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
022800000000    ?C                   SUB       1             WW                             BUMP IDX
022900000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
023000000000    ? *
023100000000    ?C                   ENDSR                                                  END PRCDKY
023200000000    ? *___________________________________________________________________
023300000000    ? * Process RETURN function
023400000000    ? *___________________________________________________________________
023500000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
023600000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
023700000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
023800000000    ?C                   ENDSR                                                  END RETURN
023900000000    ? *___________________________________________________________________
024000000000    ? * Process CANCEL function
024100000000    ? *___________________________________________________________________
024200000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
024300000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
024400000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
024500000000    ?C                   ENDSR                                                  END PRCCNL
024600000000    ? *___________________________________________________________________
024700000000    ? * Process ROLLUP function
024800000000    ? *___________________________________________________________________
024900000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
025000000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
025100000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
025200000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
025300000000E001?C                   ENDIF                                                  END IF GT LST PNL
025400000000    ?C                   ENDSR                                                  END PRCRUP
025500000000    ? *___________________________________________________________________
025600000000    ? * Process ROLLDOWN function
025700000000    ? *___________________________________________________________________
025800000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
025900000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
026000000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
026100000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
026200000000E001?C                   ENDIF                                                  END IF LT FST PNL
026300000000    ?C                   ENDSR                                                  END PRCRDN
026400000000    ? *___________________________________________________________________
026500000000    ? * Process ENTER function
026600000000    ? *___________________________________________________________________
026700000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
026800000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
026900000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
027000000000    ?C                   ENDSR                                                  END PRCENT
027100000000    ? *___________________________________________________________________
027200000000    ? * Send message
027300000000    ? *___________________________________________________________________
027400000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
027500000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
027600000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
027700000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
027800000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
027900000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
028000000000    ?C                   ENDSR                                                  END SND MSG
028100000000    ? *___________________________________________________________________
028200000000    ? * Parameter lists
028300000000    ? *___________________________________________________________________
028400000000    ?C     PLIST         BEGSR                                                  PARM LISTS
028500000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
028600000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
028700000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
028800000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
028900000614    ?C                   PARM                    WDDTA                          RECORD DS
029000000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
029100000000    ?C                   ENDSR                                                  END PLIST
029200000000    ? *___________________________________________________________________
029300000000    ? * Initialize routine
029400000000    ? *___________________________________________________________________
029500000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
029600000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
029700180319    ?C                   MOVEL     'BLIGEN  '    WWFIL            10            FILE NAME-NOTES
029800000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
029900000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
030000000000    ?C                   ENDSR                                                  END *INZSR
030100000000    ? *___________________________________________________________________
030200000000    ? * Define  routine
030300000000    ? *___________________________________________________________________
030400000000    ?C     DEFN          BEGSR                                                  Define Fields
030500000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
030600000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
030700000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
030800000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
030900000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
031000000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
031100000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
031200000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
031300000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
031400000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
031500000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
031600000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
031700000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
031800000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
031900000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
032000000000    ?C                   ENDSR                                                  END DEFN
032100000000    ? *___________________________________________________________________
032200000000    ? * Program error handler
032300000000    ? *___________________________________________________________________
032400000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
032500000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
032600000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
032700000000    ?C                   PARM                    WQSTSC                         STATUS CODE
032800000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
032900000000    ?C                   PARM                    WQMSG                          MESSAGE ID
033000000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
033100000000    ? *___________________________________________________________________
033200000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03330000000003EXIT    F3=Exit
03340000000012CANCEL  F12=Cancel
03350000000025ROLLUP
03360000000026ROLLDOWN
033700000000** WTM
03380003071700E&O Coverage record not found.
