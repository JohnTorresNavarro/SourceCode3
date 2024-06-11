000100110930     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200110930     H option(*SRCSTMT: *NODEBUGIO)
000300110930
000400000000      *_________________________________________________________________________
000500000000      *
000600110621      *  Description:  Display On-Demand Deductions
000700000000      *
000800100521      *  (c)Copyright 2010 by GBS, Inc.
000900220126      *
001000220126      *  01.26.2022  J.ALLEN BS01 - Fix call to BENSUM
001100000000      *
001200000000    ? *_________________________________________________________________________
001300000000    ? *
001400110621    ?FDSPONDD   CF   E             WORKSTN
001500000000     F                                     INFDS(DSPD)
001600110523     FACCMST    IF   E           K DISK
001700110523     FMEMBER    IF   E           K DISK
001800110930     FWEBPAYONL3IF   E           K DISK
001900110930     FWEBPAYCHP IF   E           K DISK
002000000000    ? *_________________________________________________________________________
002100000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002200000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002300010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
002400100618     D WSDESC          S             20A
002500000000    ? *_________________________________________________________________________
002600110930
002700110930      * Prototypes
002800110930      /copy *libl/qmodsrc,#pchainpr
002900110930     d  WEBPAY       e ds                  extname(webpayroll) inz
003000110930
003100000000    ? *
003200000406    ? * Data structure
003300110621    ?D WDDTA         E DS                  EXTNAME(WEBPAYOND)
003400000000    ? *
003500000000    ? * Program status data structure
003600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003700000000    ? *
003800000000    ? * Display file data structure
003900991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
004000000000    ? *_________________________________________________________________________
004100000000    ? * Process display panel
004200000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
004300000000    ? *
004400000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
004500000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
004600000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
004700000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
004800000000 001? *
004900111006 001?C     WWFNC         CASEQ     'INQBSM'      PRCBSM                         DISPLAY KEYS
005000000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
005100000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
005200000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
005300000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
005400000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005500000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
005600000000 001?C                   ENDCS                                                  END CASE
005700000000 001? *
005800000000E001?C                   ENDDO                                                  END DOWHILE
005900000000    ?C                   RETURN                                                 RETURN
006000000000    ? *___________________________________________________________________
006100000000    ? * Prepare display panel
006200000000    ? *___________________________________________________________________
006300000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
006400000000    ? *
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
008100010914E001?C                   ENDIF                                                  END IF ERROR
008200000000    ?C                   ENDSR                                                  END PRPPNL
008300000000    ? *___________________________________________________________________
008400000000    ? * Get record
008500000000    ? *___________________________________________________________________
008600000000    ?C     GETREC        BEGSR                                                  GET RECORD
008700110923    ?C***                CALL      'UPDOND  '                                   PROCESS REC IO
008800110923    ?C***                PARM      'GETNL '      WWRQS             8            GET RECORD
008900110923    ?C***                PARM                    WWRTN                          RETURN CODE
009000110923    ?C***                PARM                    WDDTA                          REC DATA
009100110923
009200110923     C     ONDKEY        Klist
009300110923     C                   kfld                    POTRS
009400110923     C                   kfld                    POSUB
009500110923     C                   kfld                    POACT
009600110923     C                   kfld                    POSSN
009700110923     C                   kfld                    POPLN
009800110923     C                   kfld                    POSENT
009900110923     C                   kfld                    POTIME
010000110923     C                   kfld                    POUSER
010100110923     C     ONDKEY        Chain     WEBPAYONL3
010200100521
010300100521     C     KEYACC        Klist
010400110621     C                   kfld                    POTRS
010500110621     C                   kfld                    POSUB
010600110621     C                   kfld                    POACT
010700100521
010800100521     C     KEYACC        Chain     ACCMST
010900110523     C                   if        %found(ACCMST)
011000110523     C                   Eval      WSANAM = %trim(ACNAM1)
011100110523     C                   Else
011200110523     C                   Eval      WSANAM = *BLANKS
011300110523     C                   End
011400110930      * Get Rule
011500110930     C                   Eval      WEBPAY = #pchain(potrs:posub:poact:possn)
011600110930
011700110930     C     KEYRULE       Klist
011800110930     C                   kfld                    POTRS
011900110930     C                   kfld                    POSUB
012000110930     C                   kfld                    POACT
012100110930     C                   kfld                    PCGRPR
012200110930     C                   kfld                    PCCODE
012300110930     C                   Eval      PCGRPR = 'RULE'
012400110930     C                   Eval      PCCODE = %trim(PYBPC)
012500110930     C     KEYRULE       Chain     WEBPAYCHP
012600110930     C                   If        %found(WEBPAYCHP)
012700110930     C                   Eval      WSRULE = %trim(PCDESC)
012800110930     C                   Else
012900110930     C                   Eval      WSRULE = *blanks
013000110930     C                   End
013100110523
013200110621     C     POSSN         Chain     MEMBER
013300110523     C                   If        %found(MEMBER)
013400110523     C                   If        %trim(MMI) = *blanks
013500110523     C                   Eval      WSMNAM = %trim(MFNAME) + ' ' +
013600110523     C                             %trim(MLNAME)
013700110523     C                   Else
013800110523     C                   Eval      WSMNAM = %trim(MFNAME) + ' ' +
013900110523     C                             %trim(MMI) + ' ' + %trim(MLNAME)
014000110523     C                   End
014100110523     C                   Else
014200110523     C                   Eval      WSMNAM = *Blanks
014300110523     C                   End
014400110621     C     POSTART       Mult      10000.0001    POSTART
014500111130     C     POSTOP        Mult      10000.0001    POSTOP
014600111130     C     POEFDT        Mult      10000.0001    POEFDT
014700110621     C     POSENT        Mult      10000.0001    POSENT
014800100617
014900000000    ?C                   ENDSR                                                  END GETREC
015000000000    ? *___________________________________________________________________
015100000000    ? * Receive messages
015200000000    ? *___________________________________________________________________
015300000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
015400000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
015500000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
015600110923    ?C                   PARM      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
015700000000    ?C                   PARM                    WWIN                           INDICATORS
015800000000    ?C                   PARM                    WWRTN             8            RETURN CODE
015900000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
016000000000    ?C                   ENDSR                                                  END RCV MSG
016100000000    ? *___________________________________________________________________
016200000000    ? * Display the display panel
016300000000    ? *___________________________________________________________________
016400000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
016500000000    ? *
016600000000    ? * Set OVERLAY based on last display file processed
016700000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
016800000000 001?C                   SETOFF                                       35        OVERLAY OFF
016900000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
017000000000X001?C                   ELSE                                                   SAME PGM
017100000000 001?C                   SETON                                        35        OVERLAY ON
017200000000E001?C                   ENDIF                                                  END IF NEW PGM
017300000000    ? *
017400000000    ? * Write message subfile
017500000000    ?C                   SETON                                        30        SFLMSG DISPLAY
017600000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
017700000000    ? *
017800000000    ? * Write display panels
017900000000B001?C                   SELECT
018000000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
018100000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
018200000000E001?C                   ENDSL                                                  END SELECT
018300000000    ?C                   ENDSR                                                  END DSP DSP
018400000000    ? *___________________________________________________________________
018500000000    ? * Build function key information
018600000000    ? *___________________________________________________________________
018700000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
018800991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
018900991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
019000000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
019100000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
019200000000    ?C                   PARM                    WAD                            FNC DESC
019300991108    ?C                   PARM                    WWIN                           *IN
019400000000    ?C                   PARM                    WAF                            FNC KEY TABLE
019500000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
019600000000    ? *
019700010913    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
019800010913    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
019900010913    ?C                   SUB       1             WW                             BUMP IDX
020000010913    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
020100000000    ?C                   ENDSR                                                  END BLD FKY
020200000000    ? *___________________________________________________________________
020300000000    ? * Process function keys
020400000000    ? *___________________________________________________________________
020500000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
020600991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
020700991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
020800000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
020900000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
021000000000    ?C                   PARM                    WAD                            FNC DESC
021100991108    ?C                   PARM                    WWIN                           *IN
021200000000    ?C                   PARM                    WAF                            FNC KEY TABLE
021300000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
021400000000    ?C                   ENDSR                                                  END PRCFKY
021500000000    ? *___________________________________________________________________
021600000000    ? * Process KEYS function
021700000000    ? *___________________________________________________________________
021800000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
021900000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
022000000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
022100000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
022200000000 001? *
022300000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
022400000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
022500000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
022600000000E002?C                   ENDIF                                                  END IF OVER 3
022700000000 001? *
022800000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
022900000000 001?C                   SUB       1             WW                             KEY DESCR IDX
023000000000E001?C                   ENDDO                                                  END DO KEYS
023100000000    ? *
023200000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
023300000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
023400000000    ?C                   SUB       1             WW                             BUMP IDX
023500000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
023600000000    ? *
023700000000    ?C                   ENDSR                                                  END PRCDKY
023800111006    ? *___________________________________________________________________
023900111006    ? * Process BENSUM option
024000111006    ? *___________________________________________________________________
024100111006    ?C     PRCBSM        Begsr                                                  DISPLAY
024200111006    ? *
024300220126BS01?C*********          Call      'INQBSMODCL'                         99      DLT RECORD
024400220126BS01 C                   Call      'INQBSMCL  '                         99      DLT RECORD
024500111006    ?C                   Parm                    POTRS                          DLT REQUEST
024600111006    ?C                   Parm                    POSUB                          RETURN CODE
024700111006    ?C                   Parm                    POACT                          PROGRAM NAME
024800111006    ?C                   Parm                    POSSN                          RECORD DS
024900111006    ? *
025000111006    ?C                   Endsr                                                  END PRC DSPL
025100000000    ? *___________________________________________________________________
025200000000    ? * Process RETURN function
025300000000    ? *___________________________________________________________________
025400000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
025500000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
025600000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
025700000000    ?C                   ENDSR                                                  END RETURN
025800000000    ? *___________________________________________________________________
025900000000    ? * Process CANCEL function
026000000000    ? *___________________________________________________________________
026100000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
026200000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
026300000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
026400000000    ?C                   ENDSR                                                  END PRCCNL
026500000000    ? *___________________________________________________________________
026600000000    ? * Process ROLLUP function
026700000000    ? *___________________________________________________________________
026800000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
026900000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
027000000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
027100000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
027200000000E001?C                   ENDIF                                                  END IF GT LST PNL
027300000000    ?C                   ENDSR                                                  END PRCRUP
027400000000    ? *___________________________________________________________________
027500000000    ? * Process ROLLDOWN function
027600000000    ? *___________________________________________________________________
027700000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
027800000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
027900000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
028000000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
028100000000E001?C                   ENDIF                                                  END IF LT FST PNL
028200000000    ?C                   ENDSR                                                  END PRCRDN
028300000000    ? *___________________________________________________________________
028400000000    ? * Process ENTER function
028500000000    ? *___________________________________________________________________
028600000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
028700000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
028800000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
028900000000    ?C                   ENDSR                                                  END PRCENT
029000000000    ? *___________________________________________________________________
029100000000    ? * Send message
029200000000    ? *___________________________________________________________________
029300000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
029400000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
029500000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
029600000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
029700000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
029800000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
029900000000    ?C                   ENDSR                                                  END SND MSG
030000000000    ? *___________________________________________________________________
030100000000    ? * Parameter lists
030200000000    ? *___________________________________________________________________
030300000000    ?C     PLIST         BEGSR                                                  PARM LISTS
030400000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
030500000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
030600000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
030700000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
030800000614    ?C                   PARM                    WDDTA                          RECORD DS
030900000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
031000000000    ?C                   ENDSR                                                  END PLIST
031100000000    ? *___________________________________________________________________
031200000000    ? * Initialize routine
031300000000    ? *___________________________________________________________________
031400000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
031500000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
031600110621    ?C                   MOVEL     'WEBPAYOND'   WWFIL            10            FILE NAME-NOTES
031700000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
031800000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
031900000000    ?C                   ENDSR                                                  END *INZSR
032000000000    ? *___________________________________________________________________
032100000000    ? * Define  routine
032200000000    ? *___________________________________________________________________
032300000000    ?C     DEFN          BEGSR                                                  Define Fields
032400000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
032500000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
032600000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
032700000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
032800000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
032900000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
033000000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
033100000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
033200000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
033300000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
033400000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
033500000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
033600000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
033700000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
033800000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
033900000000    ?C                   ENDSR                                                  END DEFN
034000000000    ? *___________________________________________________________________
034100000000    ? * Program error handler
034200000000    ? *___________________________________________________________________
034300000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
034400000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
034500000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
034600000000    ?C                   PARM                    WQSTSC                         STATUS CODE
034700000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
034800000000    ?C                   PARM                    WQMSG                          MESSAGE ID
034900000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
035000000000    ? *___________________________________________________________________
035100000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03520011100603CANCEL  F3=Exit
03530011100607INQBSM  F7=Benefit Summary
03540000000012CANCEL  F12=Cancel
03550000000025ROLLUP
03560000000026ROLLDOWN
035700000000** WTM
03580011052300Deduction not found.
