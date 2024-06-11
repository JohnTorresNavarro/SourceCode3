000100120419     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200120419     H option(*SRCSTMT: *NODEBUGIO)
000300000000      *_________________________________________________________________________
000400000000      *
000500120419      *  Description:  Display Deduction Import
000600000000      *
000700120419      *  (c)Copyright 2012 by GBS, Inc.
000800000000    ? *_________________________________________________________________________
000900000000    ? *
001000130603    ?FDSPDA3D   CF   E             WORKSTN
001100000000     F                                     INFDS(DSPD)
001200120418     FACCMST    IF   E           K DISK
001300120418     FMEMBER    IF   E           K DISK
001400130603     FPC2013DARCIF   E           K DISK
001500120419
001600120419      * Prototypes
001700120419      /copy *libl/qmodsrc,#pchainpr
001800120419
001900000000    ? *_________________________________________________________________________
002000000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002100000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002200010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
002300100618     D WSDESC          S             20A
002400000000    ? *_________________________________________________________________________
002500000000    ? *
002600000406    ? * Data structure
002700130603    ?D WDDTA         E DS                  EXTNAME(PC2013DARC)
002800120419    ? *
002900120419     D                 ds
003000120419     D WSTSA                         10s 0
003100120419     D WT                      1      3s 0
003200120419     D WS                      4      6s 0
003300120419     D WA                      7     10s 0
003400120419    ? *
003500120419     d webpay        e ds                  extname(WEBPAYROLL)
003600000000    ? *
003700000000    ? * Program status data structure
003800991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003900000000    ? *
004000000000    ? * Display file data structure
004100991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
004200000000    ? *_________________________________________________________________________
004300000000    ? * Process display panel
004400000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
004500000000    ? *
004600000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
004700000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
004800000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
004900000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
005000000000 001? *
005100000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
005200000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
005300000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
005400000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
005500000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005600000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
005700000000 001?C                   ENDCS                                                  END CASE
005800000000 001? *
005900000000E001?C                   ENDDO                                                  END DOWHILE
006000000000    ?C                   RETURN                                                 RETURN
006100000000    ? *___________________________________________________________________
006200000000    ? * Prepare display panel
006300000000    ? *___________________________________________________________________
006400000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
006500000000    ? *
006600000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
006700000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
006800000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
006900000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
007000000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
007100120419    ?C                   Z-ADD     2             WWPNLN                         NBR OF PNLS
007200000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
007300000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
007400000000    ? *
007500000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
007600000000    ?C                   EXSR      GETREC                                       GET RECORD
007700000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
007800000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
007900000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
008000000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
008100000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
008200010914E001?C                   ENDIF                                                  END IF ERROR
008300000000    ?C                   ENDSR                                                  END PRPPNL
008400000000    ? *___________________________________________________________________
008500000000    ? * Get record
008600000000    ? *___________________________________________________________________
008700000000    ?C     GETREC        BEGSR                                                  GET RECORD
008800130603    ?C                   CALL      'UPDDA3  '                                   PROCESS REC IO
008900000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
009000991201    ?C                   PARM                    WWRTN                          RETURN CODE
009100000614    ?C                   PARM                    WDDTA                          REC DATA
009200100521
009300100521     C     KEYACC        Klist
009400120418     C                   kfld                    MBTRST
009500120418     C                   kfld                    MBSUB#
009600120418     C                   kfld                    MBACCT
009700120419
009800120419     C     DDSSN         Chain     MEMBER
009900100521
010000100521     C     KEYACC        Chain     ACCMST
010100100521     C                   if        %found(ACCMST)
010200100521     C                   Eval      WWANAM = %trim(ACNAM1)
010300100521     C                   Else
010400100617     C                   Eval      WWANAM = *BLANKS
010500100521     C                   End
010600120419
010700120419     C                   Eval      WT =  MBTRST
010800120419     C                   Eval      WS =  MBSUB#
010900120419     C                   Eval      WA =  MBACCT
011000120419
011100120718     C                   z-add     DDDATE        WSSENT
011200120419     C                   Eval      WSTIME = DDTIME
011300120419     C                   Eval      WSFTP = 'Ded_' + %trim(DDFTP) +
011400120419     C                                     '.csv'
011500120419      * Get Info
011600120419     C                   eval      webpay = #pchain(mbtrst:mbsub#:mbacct:ddssn)
011700120419     C                   If        %trim(PYMID) <> *blanks
011800120419     C                   Eval      WSMNAM = %trim(PYFST) + ' ' +
011900120419     C                                      %trim(PYMID) + ' ' +
012000120419     C                                      %trim(PYLST)
012100120419     C                   Else
012200120419     C                   Eval      WSMNAM = %trim(PYFST) + ' ' +
012300120419     C                                      %trim(PYLST)
012400120419     C                   End
012500100617
012600000000    ?C                   ENDSR                                                  END GETREC
012700000000    ? *___________________________________________________________________
012800000000    ? * Receive messages
012900000000    ? *___________________________________________________________________
013000000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
013100000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
013200000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
013300000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
013400000000    ?C                   PARM                    WWIN                           INDICATORS
013500000000    ?C                   PARM                    WWRTN             8            RETURN CODE
013600000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
013700000000    ?C                   ENDSR                                                  END RCV MSG
013800000000    ? *___________________________________________________________________
013900000000    ? * Display the display panel
014000000000    ? *___________________________________________________________________
014100000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
014200000000    ? *
014300000000    ? * Set OVERLAY based on last display file processed
014400000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
014500000000 001?C                   SETOFF                                       35        OVERLAY OFF
014600000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
014700000000X001?C                   ELSE                                                   SAME PGM
014800000000 001?C                   SETON                                        35        OVERLAY ON
014900000000E001?C                   ENDIF                                                  END IF NEW PGM
015000000000    ? *
015100000000    ? * Write message subfile
015200000000    ?C                   SETON                                        30        SFLMSG DISPLAY
015300000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
015400000000    ? *
015500000000    ? * Write display panels
015600000000B001?C                   SELECT
015700000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
015800000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
015900120419 001?C     WWPNL         WHENEQ    2                                            IF PANEL 1
016000120419 001?C                   EXFMT     DSPPNL2                                      DSPLY PNL1
016100000000E001?C                   ENDSL                                                  END SELECT
016200000000    ?C                   ENDSR                                                  END DSP DSP
016300000000    ? *___________________________________________________________________
016400000000    ? * Build function key information
016500000000    ? *___________________________________________________________________
016600000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
016700991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
016800991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
016900000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
017000000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
017100000000    ?C                   PARM                    WAD                            FNC DESC
017200991108    ?C                   PARM                    WWIN                           *IN
017300000000    ?C                   PARM                    WAF                            FNC KEY TABLE
017400000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
017500000000    ? *
017600010913    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
017700010913    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
017800010913    ?C                   SUB       1             WW                             BUMP IDX
017900010913    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
018000000000    ?C                   ENDSR                                                  END BLD FKY
018100000000    ? *___________________________________________________________________
018200000000    ? * Process function keys
018300000000    ? *___________________________________________________________________
018400000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
018500991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
018600991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
018700000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
018800000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
018900000000    ?C                   PARM                    WAD                            FNC DESC
019000991108    ?C                   PARM                    WWIN                           *IN
019100000000    ?C                   PARM                    WAF                            FNC KEY TABLE
019200000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
019300000000    ?C                   ENDSR                                                  END PRCFKY
019400000000    ? *___________________________________________________________________
019500000000    ? * Process KEYS function
019600000000    ? *___________________________________________________________________
019700000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
019800000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
019900000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
020000000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
020100000000 001? *
020200000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
020300000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
020400000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
020500000000E002?C                   ENDIF                                                  END IF OVER 3
020600000000 001? *
020700000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
020800000000 001?C                   SUB       1             WW                             KEY DESCR IDX
020900000000E001?C                   ENDDO                                                  END DO KEYS
021000000000    ? *
021100000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
021200000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
021300000000    ?C                   SUB       1             WW                             BUMP IDX
021400000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
021500000000    ? *
021600000000    ?C                   ENDSR                                                  END PRCDKY
021700000000    ? *___________________________________________________________________
021800000000    ? * Process RETURN function
021900000000    ? *___________________________________________________________________
022000000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
022100000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
022200000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
022300000000    ?C                   ENDSR                                                  END RETURN
022400000000    ? *___________________________________________________________________
022500000000    ? * Process CANCEL function
022600000000    ? *___________________________________________________________________
022700000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
022800000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
022900000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
023000000000    ?C                   ENDSR                                                  END PRCCNL
023100000000    ? *___________________________________________________________________
023200000000    ? * Process ROLLUP function
023300000000    ? *___________________________________________________________________
023400000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
023500000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
023600000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
023700000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
023800000000E001?C                   ENDIF                                                  END IF GT LST PNL
023900000000    ?C                   ENDSR                                                  END PRCRUP
024000000000    ? *___________________________________________________________________
024100000000    ? * Process ROLLDOWN function
024200000000    ? *___________________________________________________________________
024300000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
024400000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
024500000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
024600000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
024700000000E001?C                   ENDIF                                                  END IF LT FST PNL
024800000000    ?C                   ENDSR                                                  END PRCRDN
024900000000    ? *___________________________________________________________________
025000000000    ? * Process ENTER function
025100000000    ? *___________________________________________________________________
025200000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
025300000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
025400000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
025500000000    ?C                   ENDSR                                                  END PRCENT
025600000000    ? *___________________________________________________________________
025700000000    ? * Send message
025800000000    ? *___________________________________________________________________
025900000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
026000000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
026100000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
026200000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
026300000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
026400000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
026500000000    ?C                   ENDSR                                                  END SND MSG
026600000000    ? *___________________________________________________________________
026700000000    ? * Parameter lists
026800000000    ? *___________________________________________________________________
026900000000    ?C     PLIST         BEGSR                                                  PARM LISTS
027000000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
027100000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
027200000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
027300000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
027400000614    ?C                   PARM                    WDDTA                          RECORD DS
027500000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
027600000000    ?C                   ENDSR                                                  END PLIST
027700000000    ? *___________________________________________________________________
027800000000    ? * Initialize routine
027900000000    ? *___________________________________________________________________
028000000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
028100000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
028200130603    ?C                   MOVEL     'PC2013DARC'  WWFIL            10            FILE NAME-NOTES
028300000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
028400000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
028500000000    ?C                   ENDSR                                                  END *INZSR
028600000000    ? *___________________________________________________________________
028700000000    ? * Define  routine
028800000000    ? *___________________________________________________________________
028900000000    ?C     DEFN          BEGSR                                                  Define Fields
029000000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
029100000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
029200000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
029300000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
029400000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
029500000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
029600000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
029700000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
029800000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
029900000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
030000000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
030100000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
030200000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
030300000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
030400000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
030500000000    ?C                   ENDSR                                                  END DEFN
030600000000    ? *___________________________________________________________________
030700000000    ? * Program error handler
030800000000    ? *___________________________________________________________________
030900000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
031000000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
031100000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
031200000000    ?C                   PARM                    WQSTSC                         STATUS CODE
031300000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
031400000000    ?C                   PARM                    WQMSG                          MESSAGE ID
031500000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
031600000000    ? *___________________________________________________________________
031700000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03180000000003EXIT    F3=Exit
03190000000012CANCEL  F12=Cancel
03200000000025ROLLUP
03210000000026ROLLDOWN
032200000000** WTM
03230011121600
