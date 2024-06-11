000100220121     h option(*noDebugIO)    DftActGrp(*no)
000101220121      *_________________________________________________________________________
000200000000      *
000300061207      *  Description:  Display Account OLE Supplemental Data
000400000000      *
000500061130      *  (c)Copyright 2006 by GBS, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900070313    ?FDSPUSRD   CF   E             WORKSTN
001000000000     F                                     INFDS(DSPD)
001001220121     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001100070313    ?FOEUSER    if   e           k Disk
001200050318     FACCMST    IF   E           K Disk
001300121221     FSLCOLELF  IF   E           K Disk
001400000000    ? *_________________________________________________________________________
001500000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001600000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001700010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001800000000    ? *_________________________________________________________________________
001900000000    ? *
002000000406    ? * Data structure
002100070313    ?D WDDTA         E DS                  EXTNAME(OEUSER)
002200000000    ? *
002300000000    ? * Program status data structure
002400991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002500000000    ? *
002600000000    ? * Display file data structure
002700991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002800050318    ? *
002900070313     D WWTRST          S                   LIKE(OUTRST)
003000070313     D WWSUB#          S                   LIKE(OUSUB#)
003100070313     D WWACCT          S                   LIKE(OUACCT)
003200000000    ? *_________________________________________________________________________
003300000000    ? * Process display panel
003400000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
003500000000    ? *
003600000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
003700000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
003800000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
003900000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
004000000000 001? *
004100000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
004200000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
004300000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
004400000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
004500000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004600000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
004700000000 001?C                   ENDCS                                                  END CASE
004800000000 001? *
004900000000E001?C                   ENDDO                                                  END DOWHILE
005000220121    ?C*                  RETURN                                                 RETURN
005001220121
005002220121        *inlr = *on;
005003220121
005100000000    ? *___________________________________________________________________
005200000000    ? * Prepare display panel
005300000000    ? *___________________________________________________________________
005400000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
005500000000    ? *
005600000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
005700000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
005800000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
005900000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
006000000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
006100010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
006200000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
006300000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
006400000000    ? *
006500070313     C                   Eval      WWTRST = OUTRST
006600070313     C                   Eval      WWSUB# = OUSUB#
006700070313     C                   Eval      WWACCT = OUACCT
006800070313     C                   Movel     OUTRST        Trst              3
006900070313     C                   Movel     OUSUB#        Sub#              3
007000070313     C                   Movel     OUACCT        Acct              4
007100050318     C     AKey          Chain     ACCMST
007200050318     C                   If        %Found(ACCMST)
007300050318     C                   Eval      WWNAME  = %trim(Trst) + '-'   +
007400050318     C                                       %trim(Sub#) + '-'   +
007500050318     C                                       %trim(Acct) + '  '  +
007600050318     C                                       %trim(ACNAM1)
007700050318     C                   Movel(P)  WWNAME        WISTR
007800080807     C                   Z-add     60            WILEN
007900050318     C                   Call      'UTLCENSTR'
008000050318     C                   Parm                    WISTR           256
008100050318     C                   Parm                    WILEN             3 0
008200050318     C                   Movel     WISTR         WWNAME
008300050318     C                   End
008400121221    ? *
008500121221     C     OUEMEX        Chain     SLCOLELF
008600121221     C                   If        %found(SLCOLELF)
008700121221     C                   Eval      WSOLE = %trim(SLDESC)
008800121221     C                   Else
008900121221     C                   Eval      WSOLE = *blanks
009000121221     C                   End
009100121221    ? *
009200050318    ? *
009300000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
009400000000    ?C                   EXSR      GETREC                                       GET RECORD
009500000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
009600000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
009700000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
009800000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
009900000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
010000000000E001?C                   ENDIF                                                  END IF ERROR
010100000000    ?C                   ENDSR                                                  END PRPPNL
010200000000    ? *___________________________________________________________________
010300000000    ? * Get record
010400000000    ? *___________________________________________________________________
010500000000    ?C     GETREC        BEGSR                                                  GET RECORD
010600070313    ?C                   CALL      'UPDUSR  '                                   PROCESS REC IO
010700000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
010800991201    ?C                   PARM                    WWRTN                          RETURN CODE
010900000614    ?C                   PARM                    WDDTA                          REC DATA
011000070313     C     OUBEDT        MULT      10000.0001    WSBEDT
011100070313     C     OUENDT        MULT      10000.0001    WSENDT
011200070313     C     OUCHDT        MULT      10000.0001    WSCHDT
011300070313     C     OUADDT        MULT      10000.0001    WSADDT
011400000000    ?C                   ENDSR                                                  END GETREC
011500000000    ? *___________________________________________________________________
011600000000    ? * Receive messages
011700000000    ? *___________________________________________________________________
011800000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
011900000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
012000000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
012100000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
012200000000    ?C                   PARM                    WWIN                           INDICATORS
012300000000    ?C                   PARM                    WWRTN             8            RETURN CODE
012400000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
012500000000    ?C                   ENDSR                                                  END RCV MSG
012600000000    ? *___________________________________________________________________
012700000000    ? * Display the display panel
012800000000    ? *___________________________________________________________________
012900000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
013000000000    ? *
013100000000    ? * Set OVERLAY based on last display file processed
013200000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
013300000000 001?C                   SETOFF                                       35        OVERLAY OFF
013400000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
013500000000X001?C                   ELSE                                                   SAME PGM
013600000000 001?C                   SETON                                        35        OVERLAY ON
013700000000E001?C                   ENDIF                                                  END IF NEW PGM
013800000000    ? *
013900000000    ? * Write message subfile
014000000000    ?C                   SETON                                        30        SFLMSG DISPLAY
014100000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
014200000000    ? *
014300000000    ? * Write display panels
014400000000B001?C                   SELECT
014500000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
014600000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
014700000000E001?C                   ENDSL                                                  END SELECT
014800000000    ?C                   ENDSR                                                  END DSP DSP
014900000000    ? *___________________________________________________________________
015000000000    ? * Build function key information
015100000000    ? *___________________________________________________________________
015200000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
015300991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
015400991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
015500000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
015600000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
015700000000    ?C                   PARM                    WAD                            FNC DESC
015800991108    ?C                   PARM                    WWIN                           *IN
015900000000    ?C                   PARM                    WAF                            FNC KEY TABLE
016000000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
016100000000    ? *
016200000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
016300000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
016400000000    ?C                   SUB       1             WW                             BUMP IDX
016500000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
016600000000    ?C                   ENDSR                                                  END BLD FKY
016700000000    ? *___________________________________________________________________
016800000000    ? * Process function keys
016900000000    ? *___________________________________________________________________
017000000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
017100991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
017200991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
017300000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
017400000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
017500000000    ?C                   PARM                    WAD                            FNC DESC
017600991108    ?C                   PARM                    WWIN                           *IN
017700000000    ?C                   PARM                    WAF                            FNC KEY TABLE
017800000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
017900000000    ?C                   ENDSR                                                  END PRCFKY
018000000000    ? *___________________________________________________________________
018100000000    ? * Process KEYS function
018200000000    ? *___________________________________________________________________
018300000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
018400000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
018500000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
018600000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
018700000000 001? *
018800000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
018900000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
019000000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
019100000000E002?C                   ENDIF                                                  END IF OVER 3
019200000000 001? *
019300000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
019400000000 001?C                   SUB       1             WW                             KEY DESCR IDX
019500000000E001?C                   ENDDO                                                  END DO KEYS
019600000000    ? *
019700000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
019800000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
019900000000    ?C                   SUB       1             WW                             BUMP IDX
020000000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
020100000000    ? *
020200000000    ?C                   ENDSR                                                  END PRCDKY
020300000000    ? *___________________________________________________________________
020400000000    ? * Process RETURN function
020500000000    ? *___________________________________________________________________
020600000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
020700000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
020800000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
020900000000    ?C                   ENDSR                                                  END RETURN
021000000000    ? *___________________________________________________________________
021100000000    ? * Process CANCEL function
021200000000    ? *___________________________________________________________________
021300000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
021400000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
021500000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
021600000000    ?C                   ENDSR                                                  END PRCCNL
021700000000    ? *___________________________________________________________________
021800000000    ? * Process ROLLUP function
021900000000    ? *___________________________________________________________________
022000000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
022100000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
022200000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
022300000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
022400000000E001?C                   ENDIF                                                  END IF GT LST PNL
022500000000    ?C                   ENDSR                                                  END PRCRUP
022600000000    ? *___________________________________________________________________
022700000000    ? * Process ROLLDOWN function
022800000000    ? *___________________________________________________________________
022900000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
023000000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
023100000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
023200000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
023300000000E001?C                   ENDIF                                                  END IF LT FST PNL
023400000000    ?C                   ENDSR                                                  END PRCRDN
023500000000    ? *___________________________________________________________________
023600000000    ? * Process ENTER function
023700000000    ? *___________________________________________________________________
023800000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
023900000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
024000000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
024100000000    ?C                   ENDSR                                                  END PRCENT
024200000000    ? *___________________________________________________________________
024300000000    ? * Send message
024400000000    ? *___________________________________________________________________
024500000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
024600000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
024700000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
024800000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
024900000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
025000000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
025100000000    ?C                   ENDSR                                                  END SND MSG
025200000000    ? *___________________________________________________________________
025300000000    ? * Parameter lists
025400000000    ? *___________________________________________________________________
025500000000    ?C     PLIST         BEGSR                                                  PARM LISTS
025600000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
025700000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
025800000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
025900000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
026000000614    ?C                   PARM                    WDDTA                          RECORD DS
026100000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
026200000000    ?C                   ENDSR                                                  END PLIST
026300050318    ? *___________________________________________________________________
026400050318    ? * Key lists
026500050318    ? *___________________________________________________________________
026600050318    ?C     KLIST         Begsr                                                  KEY LISTS
026700050318    ?C     AKey          Klist                                                  ACKCTL
026800070313    ?C                   Kfld                    OUTRST
026900070313    ?C                   Kfld                    OUSUB#
027000070313    ?C                   Kfld                    OUACCT                         POSITION TO 1
027100050318    ?C                   Endsr                                                  END KLIST
027200000000    ? *___________________________________________________________________
027300000000    ? * Initialize routine
027400000000    ? *___________________________________________________________________
027500000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
027600000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
027700070313    ?C                   MOVEL     'OEUSER  '    WWFIL            10            FILE NAME-NOTES
027800000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
027900000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
028000000000    ?C                   ENDSR                                                  END *INZSR
028100000000    ? *___________________________________________________________________
028200000000    ? * Define  routine
028300000000    ? *___________________________________________________________________
028400000000    ?C     DEFN          BEGSR                                                  Define Fields
028500000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
028600000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
028700000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
028800000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
028900000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
029000000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
029100000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
029200000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
029300000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
029400000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
029500000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
029600000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
029700000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
029800000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
029900000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
030000000000    ?C                   ENDSR                                                  END DEFN
030100000000    ? *___________________________________________________________________
030200000000    ? * Program error handler
030300000000    ? *___________________________________________________________________
030400000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
030500000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
030600000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
030700000000    ?C                   PARM                    WQSTSC                         STATUS CODE
030800000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
030900000000    ?C                   PARM                    WQMSG                          MESSAGE ID
031000000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
031100000000    ? *___________________________________________________________________
031200000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03130000000003EXIT    F3=Exit
03140000000012CANCEL  F12=Cancel
03150000000025ROLLUP
03160000000026ROLLDOWN
031700000000** WTM
03180007031300Account User not found.
