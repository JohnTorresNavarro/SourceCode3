000100000000      *_________________________________________________________________________
000200000000      *
000300140328      *  Description:  Display Longer Names
000400000000      *
000500140328      *  (c)Copyright 2014 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800140328    ?FDSP100D   CF   E             WORKSTN
000900000000     F                                     INFDS(DSPD)
001000140328     FMEMBER    IF   E           K DISK    EXTFILE('F.MEMBER')
001100140328     FDEPNDC    IF   E           K DISK    EXTFILE('F.DEPNDC')
001200140328     FCFS100P   IF   E           K DISK
001300000000    ? *_________________________________________________________________________
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001600010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001700100618     D WSDESC          S             20A
001800000000    ? *_________________________________________________________________________
001900000000    ? *
002000000406    ? * Data structure
002100140328    ?D WDDTA         E DS                  EXTNAME(CFS100P)
002200000000    ? *
002300000000    ? * Program status data structure
002400991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002500000000    ? *
002600000000    ? * Display file data structure
002700991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002800140328
002900140328     D                UDS
003000140328     D  TITLE                201    240
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
006300000000    ? *
006400000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
006500000000    ?C                   EXSR      GETREC                                       GET RECORD
006600000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
006700000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
006800000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
006900000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
007000000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
007100010914E001?C                   ENDIF                                                  END IF ERROR
007200000000    ?C                   ENDSR                                                  END PRPPNL
007300000000    ? *___________________________________________________________________
007400000000    ? * Get record
007500000000    ? *___________________________________________________________________
007600000000    ?C     GETREC        BEGSR                                                  GET RECORD
007700140328    ?C                   CALL      'UPD100  '                                   PROCESS REC IO
007800000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
007900991201    ?C                   PARM                    WWRTN                          RETURN CODE
008000000614    ?C                   PARM                    WDDTA                          REC DATA
008100100521
008200140328     C                   If        CFSEQ = 0
008300140328     C     CFSSN         Chain     MEMBER
008400140328     C                   if        %found(MEMBER)
008500140328     C                   Eval      WSFST  = %trim(MFNAME)
008600140328     C                   Eval      WSLST  = %trim(MLNAME)
008700140328     C                   Else
008800140328     C                   Eval      WSFST = *blanks
008900140328     C                   Eval      WSLST = *blanks
009000140328     C                   End
009100140328
009200140328     C                   Else
009300140328     C     DPKEY         Chain     DEPNDC
009400140328     C                   if        %found(DEPNDC)
009500140328     C                   Eval      WSFST  = %trim(DFNAME)
009600140328     C                   Eval      WSLST  = %trim(DLNAME)
009700140328     C                   Else
009800140328     C                   Eval      WSFST = *blanks
009900140328     C                   Eval      WSLST = *blanks
010000140328     C                   End
010100140328     C                   End
010200140328
010300140328     C     DPKEY         Klist
010400140328     C                   kfld                    CFSSN
010500140328     C                   kfld                    CFSEQ
010600100617
010700000000    ?C                   ENDSR                                                  END GETREC
010800000000    ? *___________________________________________________________________
010900000000    ? * Receive messages
011000000000    ? *___________________________________________________________________
011100000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
011200000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
011300000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
011400000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
011500000000    ?C                   PARM                    WWIN                           INDICATORS
011600000000    ?C                   PARM                    WWRTN             8            RETURN CODE
011700000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
011800000000    ?C                   ENDSR                                                  END RCV MSG
011900000000    ? *___________________________________________________________________
012000000000    ? * Display the display panel
012100000000    ? *___________________________________________________________________
012200000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
012300000000    ? *
012400000000    ? * Set OVERLAY based on last display file processed
012500000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
012600000000 001?C                   SETOFF                                       35        OVERLAY OFF
012700000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
012800000000X001?C                   ELSE                                                   SAME PGM
012900000000 001?C                   SETON                                        35        OVERLAY ON
013000000000E001?C                   ENDIF                                                  END IF NEW PGM
013100000000    ? *
013200000000    ? * Write message subfile
013300000000    ?C                   SETON                                        30        SFLMSG DISPLAY
013400000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
013500000000    ? *
013600000000    ? * Write display panels
013700000000B001?C                   SELECT
013800000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
013900000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
014000000000E001?C                   ENDSL                                                  END SELECT
014100000000    ?C                   ENDSR                                                  END DSP DSP
014200000000    ? *___________________________________________________________________
014300000000    ? * Build function key information
014400000000    ? *___________________________________________________________________
014500000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
014600991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
014700991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
014800000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
014900000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
015000000000    ?C                   PARM                    WAD                            FNC DESC
015100991108    ?C                   PARM                    WWIN                           *IN
015200000000    ?C                   PARM                    WAF                            FNC KEY TABLE
015300000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
015400000000    ? *
015500010913    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
015600010913    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
015700010913    ?C                   SUB       1             WW                             BUMP IDX
015800010913    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
015900000000    ?C                   ENDSR                                                  END BLD FKY
016000000000    ? *___________________________________________________________________
016100000000    ? * Process function keys
016200000000    ? *___________________________________________________________________
016300000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
016400991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
016500991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
016600000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
016700000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
016800000000    ?C                   PARM                    WAD                            FNC DESC
016900991108    ?C                   PARM                    WWIN                           *IN
017000000000    ?C                   PARM                    WAF                            FNC KEY TABLE
017100000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
017200000000    ?C                   ENDSR                                                  END PRCFKY
017300000000    ? *___________________________________________________________________
017400000000    ? * Process KEYS function
017500000000    ? *___________________________________________________________________
017600000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
017700000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
017800000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
017900000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
018000000000 001? *
018100000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
018200000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
018300000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
018400000000E002?C                   ENDIF                                                  END IF OVER 3
018500000000 001? *
018600000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
018700000000 001?C                   SUB       1             WW                             KEY DESCR IDX
018800000000E001?C                   ENDDO                                                  END DO KEYS
018900000000    ? *
019000000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
019100000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
019200000000    ?C                   SUB       1             WW                             BUMP IDX
019300000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
019400000000    ? *
019500000000    ?C                   ENDSR                                                  END PRCDKY
019600000000    ? *___________________________________________________________________
019700000000    ? * Process RETURN function
019800000000    ? *___________________________________________________________________
019900000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
020000000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
020100000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
020200000000    ?C                   ENDSR                                                  END RETURN
020300000000    ? *___________________________________________________________________
020400000000    ? * Process CANCEL function
020500000000    ? *___________________________________________________________________
020600000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
020700000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
020800000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
020900000000    ?C                   ENDSR                                                  END PRCCNL
021000000000    ? *___________________________________________________________________
021100000000    ? * Process ROLLUP function
021200000000    ? *___________________________________________________________________
021300000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
021400000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
021500000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
021600000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
021700000000E001?C                   ENDIF                                                  END IF GT LST PNL
021800000000    ?C                   ENDSR                                                  END PRCRUP
021900000000    ? *___________________________________________________________________
022000000000    ? * Process ROLLDOWN function
022100000000    ? *___________________________________________________________________
022200000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
022300000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
022400000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
022500000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
022600000000E001?C                   ENDIF                                                  END IF LT FST PNL
022700000000    ?C                   ENDSR                                                  END PRCRDN
022800000000    ? *___________________________________________________________________
022900000000    ? * Process ENTER function
023000000000    ? *___________________________________________________________________
023100000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
023200000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
023300000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
023400000000    ?C                   ENDSR                                                  END PRCENT
023500000000    ? *___________________________________________________________________
023600000000    ? * Send message
023700000000    ? *___________________________________________________________________
023800000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
023900000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
024000000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
024100000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
024200000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
024300000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
024400000000    ?C                   ENDSR                                                  END SND MSG
024500000000    ? *___________________________________________________________________
024600000000    ? * Parameter lists
024700000000    ? *___________________________________________________________________
024800000000    ?C     PLIST         BEGSR                                                  PARM LISTS
024900000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
025000000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
025100000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
025200000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
025300000614    ?C                   PARM                    WDDTA                          RECORD DS
025400000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
025500000000    ?C                   ENDSR                                                  END PLIST
025600000000    ? *___________________________________________________________________
025700000000    ? * Initialize routine
025800000000    ? *___________________________________________________________________
025900000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
026000000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
026100140328    ?C                   MOVEL     'CFS100P  '   WWFIL            10            FILE NAME-NOTES
026200000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
026300000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
026400000000    ?C                   ENDSR                                                  END *INZSR
026500000000    ? *___________________________________________________________________
026600000000    ? * Define  routine
026700000000    ? *___________________________________________________________________
026800000000    ?C     DEFN          BEGSR                                                  Define Fields
026900000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
027000000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
027100000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
027200000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
027300000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
027400000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
027500000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
027600000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
027700000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
027800000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
027900000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
028000000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
028100000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
028200000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
028300000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
028400000000    ?C                   ENDSR                                                  END DEFN
028500000000    ? *___________________________________________________________________
028600000000    ? * Program error handler
028700000000    ? *___________________________________________________________________
028800000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
028900000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
029000000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
029100000000    ?C                   PARM                    WQSTSC                         STATUS CODE
029200000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
029300000000    ?C                   PARM                    WQMSG                          MESSAGE ID
029400000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
029500000000    ? *___________________________________________________________________
029600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02970000000003EXIT    F3=Exit
02980000000012CANCEL  F12=Cancel
02990000000025ROLLUP
03000000000026ROLLDOWN
030100000000** WTM
03020011121600
