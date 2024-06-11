000100000000      *_________________________________________________________________________
000200000000      *
000300101019      *  Description:  Display Pay Date Ranges
000400000000      *
000500100521      *  (c)Copyright 2010 by GBS, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900101019    ?FDSPDTRD   CF   E             WORKSTN
001000000000     F                                     INFDS(DSPD)
001100100521     FACCMST    IF   E           K DISK
001200100617     FWEBPAYCHP IF   E           K DISK
001300000000    ? *_________________________________________________________________________
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001600010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001700100618     D WSDESC          S             20A
001800000000    ? *_________________________________________________________________________
001900000000    ? *
002000000406    ? * Data structure
002100101019    ?D WDDTA         E DS                  EXTNAME(WEBPAYDTR)
002200170822    ?D OEStatus                       1a
002300000000    ? *
002400000000    ? * Program status data structure
002500991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002600000000    ? *
002700000000    ? * Display file data structure
002800991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002900000000    ? *_________________________________________________________________________
003000000000    ? * Process display panel
003100000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
003200000000    ? *
003300000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
003400000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
003500000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
003600000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
003700000000 001? *
003800000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
003900000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
004000000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
004100000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
004200000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004300000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
004400000000 001?C                   ENDCS                                                  END CASE
004500000000 001? *
004600000000E001?C                   ENDDO                                                  END DOWHILE
004700000000    ?C                   RETURN                                                 RETURN
004800000000    ? *___________________________________________________________________
004900000000    ? * Prepare display panel
005000000000    ? *___________________________________________________________________
005100000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
005200000000    ? *
005300000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
005400000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
005500000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
005600000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
005700000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
005800010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
005900000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
006000000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
006100000000    ? *
006200000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
006300000000    ?C                   EXSR      GETREC                                       GET RECORD
006400000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
006500000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
006600000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
006700000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
006800000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
006900010914E001?C                   ENDIF                                                  END IF ERROR
007000000000    ?C                   ENDSR                                                  END PRPPNL
007100000000    ? *___________________________________________________________________
007200000000    ? * Get record
007300000000    ? *___________________________________________________________________
007400000000    ?C     GETREC        BEGSR                                                  GET RECORD
007500101019    ?C                   CALL      'UPDDTR  '                                   PROCESS REC IO
007600000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
007700991201    ?C                   PARM                    WWRTN                          RETURN CODE
007800000614    ?C                   PARM                    WDDTA                          REC DATA
007900100521
008000100521     C     KEYACC        Klist
008100101019     C                   kfld                    PGTRST
008200101019     C                   kfld                    PGSUB#
008300101019     C                   kfld                    PGACCT
008400100521
008500100521     C     KEYACC        Chain     ACCMST
008600100521     C                   if        %found(ACCMST)
008700100521     C                   Eval      WWANAM = %trim(ACNAM1)
008800100521     C                   Else
008900100617     C                   Eval      WWANAM = *BLANKS
009000100521     C                   End
009100100617    ? *
009200100617     C                   Eval      WSDESC = *blanks
009300101019     C                   If        PGGRPR <> *blanks
009400101019     C                   eval      PCTRST = 0
009500101019     C                   eval      PCSUB# = 0
009600101019     C                   eval      PCACCT = 0
009700100617     C     KEYOPT        Klist
009800101019     C                   kfld                    PCTRST
009900101019     C                   kfld                    PCSUB#
010000101019     C                   kfld                    PCACCT
010100101019     C                   kfld                    PGGRPR
010200101019     C                   kfld                    PGCODE
010300100617     C     KEYOPT        Chain     WEBPAYCHP
010400100617     C                   if        %found(WEBPAYCHP)
010500100617     C                   Eval      WSDESC = %trim(PCDESC)
010600100617     C                   Else
010700100617     C                   Eval      WSDESC = *blanks
010800100617     C                   End
010900100617     C                   End
011000100521
011100101019     C                   Eval      WSFRDT = PGFRDT
011200101019     C                   Eval      WSTODT = PGTODT
011300161014     C                   Eval      WSEFDT = PGEFDT
011400161014     C                   Eval      WSMFDT = PGMFDT
011500161014     C                   Eval      WSMTDT = PGMTDT
011600100617
011700000000    ?C                   ENDSR                                                  END GETREC
011800000000    ? *___________________________________________________________________
011900000000    ? * Receive messages
012000000000    ? *___________________________________________________________________
012100000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
012200000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
012300000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
012400000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
012500000000    ?C                   PARM                    WWIN                           INDICATORS
012600000000    ?C                   PARM                    WWRTN             8            RETURN CODE
012700000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
012800000000    ?C                   ENDSR                                                  END RCV MSG
012900000000    ? *___________________________________________________________________
013000000000    ? * Display the display panel
013100000000    ? *___________________________________________________________________
013200000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
013300000000    ? *
013400000000    ? * Set OVERLAY based on last display file processed
013500000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
013600000000 001?C                   SETOFF                                       35        OVERLAY OFF
013700000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
013800000000X001?C                   ELSE                                                   SAME PGM
013900000000 001?C                   SETON                                        35        OVERLAY ON
014000000000E001?C                   ENDIF                                                  END IF NEW PGM
014100000000    ? *
014200000000    ? * Write message subfile
014300000000    ?C                   SETON                                        30        SFLMSG DISPLAY
014400000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
014500000000    ? *
014600000000    ? * Write display panels
014700000000B001?C                   SELECT
014800000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
014900000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
015000000000E001?C                   ENDSL                                                  END SELECT
015100000000    ?C                   ENDSR                                                  END DSP DSP
015200000000    ? *___________________________________________________________________
015300000000    ? * Build function key information
015400000000    ? *___________________________________________________________________
015500000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
015600991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
015700991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
015800000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
015900000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
016000000000    ?C                   PARM                    WAD                            FNC DESC
016100991108    ?C                   PARM                    WWIN                           *IN
016200000000    ?C                   PARM                    WAF                            FNC KEY TABLE
016300000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
016400000000    ? *
016500010913    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
016600010913    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
016700010913    ?C                   SUB       1             WW                             BUMP IDX
016800010913    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
016900000000    ?C                   ENDSR                                                  END BLD FKY
017000000000    ? *___________________________________________________________________
017100000000    ? * Process function keys
017200000000    ? *___________________________________________________________________
017300000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
017400991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
017500991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
017600000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
017700000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
017800000000    ?C                   PARM                    WAD                            FNC DESC
017900991108    ?C                   PARM                    WWIN                           *IN
018000000000    ?C                   PARM                    WAF                            FNC KEY TABLE
018100000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
018200000000    ?C                   ENDSR                                                  END PRCFKY
018300000000    ? *___________________________________________________________________
018400000000    ? * Process KEYS function
018500000000    ? *___________________________________________________________________
018600000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
018700000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
018800000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
018900000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
019000000000 001? *
019100000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
019200000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
019300000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
019400000000E002?C                   ENDIF                                                  END IF OVER 3
019500000000 001? *
019600000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
019700000000 001?C                   SUB       1             WW                             KEY DESCR IDX
019800000000E001?C                   ENDDO                                                  END DO KEYS
019900000000    ? *
020000000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
020100000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
020200000000    ?C                   SUB       1             WW                             BUMP IDX
020300000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
020400000000    ? *
020500000000    ?C                   ENDSR                                                  END PRCDKY
020600000000    ? *___________________________________________________________________
020700000000    ? * Process RETURN function
020800000000    ? *___________________________________________________________________
020900000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
021000000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
021100000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
021200000000    ?C                   ENDSR                                                  END RETURN
021300000000    ? *___________________________________________________________________
021400000000    ? * Process CANCEL function
021500000000    ? *___________________________________________________________________
021600000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
021700000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
021800000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
021900000000    ?C                   ENDSR                                                  END PRCCNL
022000000000    ? *___________________________________________________________________
022100000000    ? * Process ROLLUP function
022200000000    ? *___________________________________________________________________
022300000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
022400000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
022500000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
022600000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
022700000000E001?C                   ENDIF                                                  END IF GT LST PNL
022800000000    ?C                   ENDSR                                                  END PRCRUP
022900000000    ? *___________________________________________________________________
023000000000    ? * Process ROLLDOWN function
023100000000    ? *___________________________________________________________________
023200000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
023300000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
023400000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
023500000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
023600000000E001?C                   ENDIF                                                  END IF LT FST PNL
023700000000    ?C                   ENDSR                                                  END PRCRDN
023800000000    ? *___________________________________________________________________
023900000000    ? * Process ENTER function
024000000000    ? *___________________________________________________________________
024100000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
024200000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
024300000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
024400000000    ?C                   ENDSR                                                  END PRCENT
024500000000    ? *___________________________________________________________________
024600000000    ? * Send message
024700000000    ? *___________________________________________________________________
024800000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
024900000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
025000000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
025100000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
025200000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
025300000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
025400000000    ?C                   ENDSR                                                  END SND MSG
025500000000    ? *___________________________________________________________________
025600000000    ? * Parameter lists
025700000000    ? *___________________________________________________________________
025800000000    ?C     PLIST         BEGSR                                                  PARM LISTS
025900000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
026000000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
026100000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
026200000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
026300000614    ?C                   PARM                    WDDTA                          RECORD DS
026400000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
026500000000    ?C                   ENDSR                                                  END PLIST
026600000000    ? *___________________________________________________________________
026700000000    ? * Initialize routine
026800000000    ? *___________________________________________________________________
026900000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
027000000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
027100101019    ?C                   MOVEL     'WEBPAYDTR'   WWFIL            10            FILE NAME-NOTES
027200000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
027300000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
027400000000    ?C                   ENDSR                                                  END *INZSR
027500000000    ? *___________________________________________________________________
027600000000    ? * Define  routine
027700000000    ? *___________________________________________________________________
027800000000    ?C     DEFN          BEGSR                                                  Define Fields
027900000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
028000000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
028100000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
028200000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
028300000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
028400000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
028500000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
028600000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
028700000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
028800000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
028900000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
029000000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
029100000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
029200000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
029300000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
029400000000    ?C                   ENDSR                                                  END DEFN
029500000000    ? *___________________________________________________________________
029600000000    ? * Program error handler
029700000000    ? *___________________________________________________________________
029800000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
029900000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
030000000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
030100000000    ?C                   PARM                    WQSTSC                         STATUS CODE
030200000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
030300000000    ?C                   PARM                    WQMSG                          MESSAGE ID
030400000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
030500000000    ? *___________________________________________________________________
030600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03070000000003EXIT    F3=Exit
03080000000012CANCEL  F12=Cancel
03090000000025ROLLUP
03100000000026ROLLDOWN
031100000000** WTM
03120010101900Grouper Code not found.
