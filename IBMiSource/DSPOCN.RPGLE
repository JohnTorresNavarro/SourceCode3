000100000000      *_________________________________________________________________________
000200000000      *
000300090305      *  Description:  Display Onsite Dental Contact Data
000400000000      *
000500090224      *  (c)Copyright 2009 by GBS, Inc.
000600000000      *
000800000000    ? *_________________________________________________________________________
000900000000    ? *
001000090305    ?FDSPOCND   CF   E             WORKSTN
001100000000     F                                     INFDS(DSPD)
001103090305    ?FODCNTCP   if   e           k Disk
001104090312     FTRSMST    IF   E           K Disk
001105050318     FACCMST    IF   E           K Disk
001106090312     FSUBMST    IF   E           K Disk
001107090323     FODCMGRP   IF   E           K Disk
001200000000    ? *_________________________________________________________________________
001300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001500010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001600000000    ? *_________________________________________________________________________
001700000000    ? *
001800000406    ? * Data structure
001900090305    ?D WDDTA         E DS                  EXTNAME(ODCNTCP)
002000000000    ? *
002100000000    ? * Program status data structure
002200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000    ? *
002400000000    ? * Display file data structure
002500991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002501050318    ? *
002502090305     D WWTRST          S                   LIKE(OCTRST)
002503090305     D WWSUB#          S                   LIKE(OCSUB#)
002504090305     D WWACCT          S                   LIKE(OCACCT)
002600000000    ? *_________________________________________________________________________
002700000000    ? * Process display panel
002800000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
002900000000    ? *
003000000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
003100000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
003200000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
003300000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
003400000000 001? *
003500000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
003600000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
003700000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
003800000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
003900000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004000000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
004100000000 001?C                   ENDCS                                                  END CASE
004200000000 001? *
004300000000E001?C                   ENDDO                                                  END DOWHILE
004400000000    ?C                   RETURN                                                 RETURN
004500000000    ? *___________________________________________________________________
004600000000    ? * Prepare display panel
004700000000    ? *___________________________________________________________________
004800000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
004900000000    ? *
005000000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
005100000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
005200000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
005300000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
005400000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
005500010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
005600000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
005700000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
005800000000    ? *
005801090305     C                   Eval      WWTRST = OCTRST
005802090305     C                   Eval      WWSUB# = OCSUB#
005803090305     C                   Eval      WWACCT = OCACCT
005804090305     C                   Movel     OCTRST        Trst              3
005805090305     C                   Movel     OCSUB#        Sub#              3
005806090305     C                   Movel     OCACCT        Acct              4
005807090312     C     OCTRST        Chain     TRSMST
005808090312     C                   If        %Found(TRSMST)
005809090312     C     SKey          Chain     SUBMST
005810090312     C                   If        %Found(SUBMST)
005817090312     C                   If        Acct   <> '0000'
005818050318     C     AKey          Chain     ACCMST
005819050318     C                   If        %Found(ACCMST)
005820090312     C                   Eval      WWNAME  = 'Trust#     ' + ' '  +
005821090312     C                                       %trim(Trst) + '  ' + TDESCR
005822090312     C                   Eval      WWNAM1  = %trim('Subdivision') + ' ' +
005823090312     C                                       %trim(Sub#) + '  ' + SUBDSC
005824090312     C                   Eval      WWNAM2  = 'Account    ' + ' ' +
005825090312     C                                       %trim(Acct) + ' ' + ACNAM1
005826090312     C                   End
005827050318     C                   End
005828090312     C                   If        Acct    = '0000'
005829090312     C                   Eval      WWNAME  = 'Trust#     ' + ' '  +
005830090312     C                                       %trim(Trst) + ' ' + TDESCR
005831090312     C                   Eval      WWNAM1  = %trim('Subdivision') + ' ' +
005832090312     C                                       %trim(Sub#) + ' ' + SUBDSC
005833090312     C                   End
005834090312     C                   End
005835090312     C                   End
005836050318    ? *
005900000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
006000000000    ?C                   EXSR      GETREC                                       GET RECORD
006100000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
006200000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
006300000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
006400000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
006500000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
006600000000E001?C                   ENDIF                                                  END IF ERROR
006700000000    ?C                   ENDSR                                                  END PRPPNL
006800000000    ? *___________________________________________________________________
006900000000    ? * Get record
007000000000    ? *___________________________________________________________________
007100000000    ?C     GETREC        BEGSR                                                  GET RECORD
007200090305    ?C                   CALL      'UPDOCN  '                                   PROCESS REC IO
007300000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
007400991201    ?C                   PARM                    WWRTN                          RETURN CODE
007500000614    ?C                   PARM                    WDDTA                          REC DATA
007503090323     C                   Movel     'ACM'         ACM               3
007504090323     C                   If        OCCCOD  <>    ACM
007505090323     C                   Eval      WSLNAM   =    %Trim(OCLNAM)
007506090323     C                   Eval      WSFNAM   =    %Trim(OCFNAM)
007507090324     C     OCEFF         MULT      10000.0001    WSBEDT
007508090324     C     OCTRM         MULT      10000.0001    WSENDT
007509090407     C                   Movel     OCPHN1        WSPHN1
007510090408     C                   Movel     OCPHN2        WSPHN2
007511090408     C                   Movel     OCPHN3        WSPHN3
007512090408     C                   Movel     OCFAX         WSFAX
007513090323     C                   Else
007514090323     C     ACMKey        Chain     ODCMGRP
007515090323     C                   If        %Found(ODCMGRP)
007516090323     C                   Eval      WSLNAM   =    %Trim(CMLNAM)
007517090323     C                   Eval      WSFNAM   =    %Trim(CMFNAM)
007518090324     C     CMEFF         MULT      10000.0001    WSBEDT
007519090324     C     CMTRM         MULT      10000.0001    WSENDT
007520090323     C                   Else
007521090323     C                   Eval      WSLNAM = %Trim('Not on File')
007522090323     C                   End
007523090323     C                   End
007600000000    ?C                   ENDSR                                                  END GETREC
007700000000    ? *___________________________________________________________________
007800000000    ? * Receive messages
007900000000    ? *___________________________________________________________________
008000000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
008100000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
008200000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
008300000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
008400000000    ?C                   PARM                    WWIN                           INDICATORS
008500000000    ?C                   PARM                    WWRTN             8            RETURN CODE
008600000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
008700000000    ?C                   ENDSR                                                  END RCV MSG
008800000000    ? *___________________________________________________________________
008900000000    ? * Display the display panel
009000000000    ? *___________________________________________________________________
009100000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
009200000000    ? *
009300000000    ? * Set OVERLAY based on last display file processed
009400000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
009500000000 001?C                   SETOFF                                       35        OVERLAY OFF
009600000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
009700000000X001?C                   ELSE                                                   SAME PGM
009800000000 001?C                   SETON                                        35        OVERLAY ON
009900000000E001?C                   ENDIF                                                  END IF NEW PGM
010000000000    ? *
010100000000    ? * Write message subfile
010200000000    ?C                   SETON                                        30        SFLMSG DISPLAY
010300000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
010400000000    ? *
010500000000    ? * Write display panels
010600000000B001?C                   SELECT
010700000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
010900000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
011000000000E001?C                   ENDSL                                                  END SELECT
011100000000    ?C                   ENDSR                                                  END DSP DSP
011200000000    ? *___________________________________________________________________
011300000000    ? * Build function key information
011400000000    ? *___________________________________________________________________
011500000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
011600991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
011700991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
011800000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
011900000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
012000000000    ?C                   PARM                    WAD                            FNC DESC
012100991108    ?C                   PARM                    WWIN                           *IN
012200000000    ?C                   PARM                    WAF                            FNC KEY TABLE
012300000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
012400000000    ? *
012500000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
012600000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
012700000000    ?C                   SUB       1             WW                             BUMP IDX
012800000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
012900000000    ?C                   ENDSR                                                  END BLD FKY
013000000000    ? *___________________________________________________________________
013100000000    ? * Process function keys
013200000000    ? *___________________________________________________________________
013300000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
013400991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
013500991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
013600000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
013700000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
013800000000    ?C                   PARM                    WAD                            FNC DESC
013900991108    ?C                   PARM                    WWIN                           *IN
014000000000    ?C                   PARM                    WAF                            FNC KEY TABLE
014100000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
014200000000    ?C                   ENDSR                                                  END PRCFKY
014300000000    ? *___________________________________________________________________
014400000000    ? * Process KEYS function
014500000000    ? *___________________________________________________________________
014600000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
014700000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
014800000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
014900000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
015000000000 001? *
015100000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
015200000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
015300000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
015400000000E002?C                   ENDIF                                                  END IF OVER 3
015500000000 001? *
015600000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
015700000000 001?C                   SUB       1             WW                             KEY DESCR IDX
015800000000E001?C                   ENDDO                                                  END DO KEYS
015900000000    ? *
016000000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
016100000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
016200000000    ?C                   SUB       1             WW                             BUMP IDX
016300000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
016400000000    ? *
016500000000    ?C                   ENDSR                                                  END PRCDKY
016600000000    ? *___________________________________________________________________
016700000000    ? * Process RETURN function
016800000000    ? *___________________________________________________________________
016900000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
017000000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
017100000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
017200000000    ?C                   ENDSR                                                  END RETURN
017300000000    ? *___________________________________________________________________
017400000000    ? * Process CANCEL function
017500000000    ? *___________________________________________________________________
017600000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
017700000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
017800000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
017900000000    ?C                   ENDSR                                                  END PRCCNL
018000000000    ? *___________________________________________________________________
018100000000    ? * Process ROLLUP function
018200000000    ? *___________________________________________________________________
018300000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
018400000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
018500000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
018600000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
018700000000E001?C                   ENDIF                                                  END IF GT LST PNL
018800000000    ?C                   ENDSR                                                  END PRCRUP
018900000000    ? *___________________________________________________________________
019000000000    ? * Process ROLLDOWN function
019100000000    ? *___________________________________________________________________
019200000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
019300000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
019400000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
019500000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
019600000000E001?C                   ENDIF                                                  END IF LT FST PNL
019700000000    ?C                   ENDSR                                                  END PRCRDN
019800000000    ? *___________________________________________________________________
019900000000    ? * Process ENTER function
020000000000    ? *___________________________________________________________________
020100000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
020200000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
020300000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
020400000000    ?C                   ENDSR                                                  END PRCENT
020401090312    ? *___________________________________________________________________
020402090312    ? * Center the Name Across Top of Screen
020403090312    ? *___________________________________________________________________
020404090312    ?C     CenterName    Begsr                                                  POSITION TO
020405090312    ? *
020406090312     C                   Movel(P)  WWNAME        WISTR
020407090312     C                   Z-add     60            WILEN
020408090312     C                   Call      'UTLCENSTR'
020409090312     C                   Parm                    WISTR           256
020410090312     C                   Parm                    WILEN             3 0
020411090312     C                   Movel     WISTR         WWNAME
020412090312    ? *
020413090312    ?C                   Endsr                                                  END POSITION TO
020500000000    ? *___________________________________________________________________
020600000000    ? * Send message
020700000000    ? *___________________________________________________________________
020800000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
020900000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
021000000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
021100000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
021200000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
021300000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
021400000000    ?C                   ENDSR                                                  END SND MSG
021500000000    ? *___________________________________________________________________
021600000000    ? * Parameter lists
021700000000    ? *___________________________________________________________________
021800000000    ?C     PLIST         BEGSR                                                  PARM LISTS
021900000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
022000000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
022100000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
022200000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
022300000614    ?C                   PARM                    WDDTA                          RECORD DS
022400000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
022500000000    ?C                   ENDSR                                                  END PLIST
022501050318    ? *___________________________________________________________________
022502050318    ? * Key lists
022503050318    ? *___________________________________________________________________
022504050318    ?C     KLIST         Begsr                                                  KEY LISTS
022511050318    ?C     AKey          Klist                                                  ACKCTL
022512090305    ?C                   Kfld                    OCTRST
022513090305    ?C                   Kfld                    OCSUB#
022514090305    ?C                   Kfld                    OCACCT                         POSITION TO 1
022515090312    ?C     SKey          Klist                                                  ACKCTL
022516090312    ?C                   Kfld                    OCTRST
022517090312    ?C                   Kfld                    OCSUB#
022518090323    ?C     ACMKey        Klist                                                  AGENCY
022519090323    ?C                   Kfld                    OCTRST                         POSITION TO 1
022520090323    ?C                   Kfld                    OCCMGR                         POSITION TO 1
022521050318    ?C                   Endsr                                                  END KLIST
022600000000    ? *___________________________________________________________________
022700000000    ? * Initialize routine
022800000000    ? *___________________________________________________________________
022900000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
023000000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
023100090305    ?C                   MOVEL     'ODCNTCP '    WWFIL            10            FILE NAME-NOTES
023200000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
023300000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
023400000000    ?C                   ENDSR                                                  END *INZSR
023500000000    ? *___________________________________________________________________
023600000000    ? * Define  routine
023700000000    ? *___________________________________________________________________
023800000000    ?C     DEFN          BEGSR                                                  Define Fields
023900000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
024000000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
024100000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
024200000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
024300000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
024400000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
024500000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
024600000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
024700000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
024800000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
024900000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
025000000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
025100000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
025200000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
025300000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
025400000000    ?C                   ENDSR                                                  END DEFN
025500000000    ? *___________________________________________________________________
025600000000    ? * Program error handler
025700000000    ? *___________________________________________________________________
025800000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
025900000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
026000000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
026100000000    ?C                   PARM                    WQSTSC                         STATUS CODE
026200000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
026300000000    ?C                   PARM                    WQMSG                          MESSAGE ID
026400000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
026500000000    ? *___________________________________________________________________
026600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02660109031201CANCEL  F1=Return
02670009031207EXIT    F7=End Job
02690000000025ROLLUP
02700000000026ROLLDOWN
027100000000** WTM
02720009032300This account contact is not available.
