000100000000      *_________________________________________________________________________
000200000000      *
000300111216      *  Description:  Display Pay Start Date
000400000000      *
000500111216      *  (c)Copyright 2011 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800130603    ?FDSPAR3D   CF   E             WORKSTN
000900000000     F                                     INFDS(DSPD)
001000120418     FACCMST    IF   E           K DISK
001100120418     FMEMBER    IF   E           K DISK
001200130603     FPC2013ARC IF   E           K DISK
001300000000    ? *_________________________________________________________________________
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001600010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001700100618     D WSDESC          S             20A
001800000000    ? *_________________________________________________________________________
001900000000    ? *
002000000406    ? * Data structure
002100130603    ?D WDDTA         E DS                  EXTNAME(PC2013ARC)
002200120419    ? *
002300120419     D                 ds
002400120419     D WSTSA                         10s 0
002500120419     D WT                      1      3s 0
002600120419     D WS                      4      6s 0
002700120419     D WA                      7     10s 0
002800000000    ? *
002900000000    ? * Program status data structure
003000991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003100000000    ? *
003200000000    ? * Display file data structure
003300991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003400000000    ? *_________________________________________________________________________
003500000000    ? * Process display panel
003600000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
003700000000    ? *
003800000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
003900000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
004000000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
004100000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
004200000000 001? *
004300000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
004400000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
004500000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
004600000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
004700000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004800000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
004900000000 001?C                   ENDCS                                                  END CASE
005000000000 001? *
005100000000E001?C                   ENDDO                                                  END DOWHILE
005200000000    ?C                   RETURN                                                 RETURN
005300000000    ? *___________________________________________________________________
005400000000    ? * Prepare display panel
005500000000    ? *___________________________________________________________________
005600000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
005700000000    ? *
005800000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
005900000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
006000000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
006100000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
006200000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
006300120419    ?C                   Z-ADD     2             WWPNLN                         NBR OF PNLS
006400000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
006500000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
006600000000    ? *
006700000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
006800000000    ?C                   EXSR      GETREC                                       GET RECORD
006900000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
007000000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
007100000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
007200000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
007300000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
007400010914E001?C                   ENDIF                                                  END IF ERROR
007500000000    ?C                   ENDSR                                                  END PRPPNL
007600000000    ? *___________________________________________________________________
007700000000    ? * Get record
007800000000    ? *___________________________________________________________________
007900000000    ?C     GETREC        BEGSR                                                  GET RECORD
008000130603    ?C                   CALL      'UPDAR3  '                                   PROCESS REC IO
008100000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
008200991201    ?C                   PARM                    WWRTN                          RETURN CODE
008300000614    ?C                   PARM                    WDDTA                          REC DATA
008400100521
008500100521     C     KEYACC        Klist
008600120418     C                   kfld                    MBTRST
008700120418     C                   kfld                    MBSUB#
008800120418     C                   kfld                    MBACCT
008900120419
009000130603     C     P3SSN         Chain     MEMBER
009100100521
009200100521     C     KEYACC        Chain     ACCMST
009300100521     C                   if        %found(ACCMST)
009400100521     C                   Eval      WWANAM = %trim(ACNAM1)
009500100521     C                   Else
009600100617     C                   Eval      WWANAM = *BLANKS
009700100521     C                   End
009800120419
009900120419     C                   Eval      WT =  MBTRST
010000120419     C                   Eval      WS =  MBSUB#
010100120419     C                   Eval      WA =  MBACCT
010200120419
010300130603     C                   Z-add     P3DATE        WSSENT
010400130603     C                   Eval      WSTIME = P3TIME
010500130603     C                   Eval      WSFTP = 'Dem_' + %trim(P3FTP) +
010600120419     C                                     '.csv'
010700130603     C                   If        %trim(P3MID) <> *blanks
010800130603     C                   Eval      WSMNAM = %trim(P3FST) + ' ' +
010900130603     C                                      %trim(P3MID) + ' ' +
011000130603     C                                      %trim(P3LST)
011100120419     C                   Else
011200130603     C                   Eval      WSMNAM = %trim(P3FST) + ' ' +
011300130603     C                                      %trim(P3LST)
011400120419     C                   End
011500100617
011600000000    ?C                   ENDSR                                                  END GETREC
011700000000    ? *___________________________________________________________________
011800000000    ? * Receive messages
011900000000    ? *___________________________________________________________________
012000000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
012100000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
012200000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
012300000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
012400000000    ?C                   PARM                    WWIN                           INDICATORS
012500000000    ?C                   PARM                    WWRTN             8            RETURN CODE
012600000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
012700000000    ?C                   ENDSR                                                  END RCV MSG
012800000000    ? *___________________________________________________________________
012900000000    ? * Display the display panel
013000000000    ? *___________________________________________________________________
013100000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
013200000000    ? *
013300000000    ? * Set OVERLAY based on last display file processed
013400000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
013500000000 001?C                   SETOFF                                       35        OVERLAY OFF
013600000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
013700000000X001?C                   ELSE                                                   SAME PGM
013800000000 001?C                   SETON                                        35        OVERLAY ON
013900000000E001?C                   ENDIF                                                  END IF NEW PGM
014000000000    ? *
014100000000    ? * Write message subfile
014200000000    ?C                   SETON                                        30        SFLMSG DISPLAY
014300000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
014400120718
014500130603     C     P3SSN         Chain     MEMBER
014600120718
014700120718     C     KEYACC        Chain     ACCMST
014800120718     C                   if        %found(ACCMST)
014900120718     C                   Eval      WWANAM = %trim(ACNAM1)
015000120718     C                   Else
015100120718     C                   Eval      WWANAM = *BLANKS
015200120718     C                   End
015300120718
015400120718     C                   Eval      WT =  MBTRST
015500120718     C                   Eval      WS =  MBSUB#
015600120718     C                   Eval      WA =  MBACCT
015700120718
015800130603     C                   Z-add     P3DATE        WSSENT
015900130603     C                   Eval      WSTIME = P3TIME
016000130603     C                   Eval      WSFTP = 'Dem_' + %trim(P3FTP) +
016100120718     C                                     '.csv'
016200130603     C                   If        %trim(P3MID) <> *blanks
016300130603     C                   Eval      WSMNAM = %trim(P3FST) + ' ' +
016400130603     C                                      %trim(P3MID) + ' ' +
016500130603     C                                      %trim(P3LST)
016600120718     C                   Else
016700130603     C                   Eval      WSMNAM = %trim(P3FST) + ' ' +
016800130603     C                                      %trim(P3LST)
016900120718     C                   End
017000000000    ? *
017100000000    ? * Write display panels
017200000000B001?C                   SELECT
017300000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
017400000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
017500120419 001?C     WWPNL         WHENEQ    2                                            IF PANEL 1
017600120419 001?C                   EXFMT     DSPPNL2                                      DSPLY PNL1
017700000000E001?C                   ENDSL                                                  END SELECT
017800000000    ?C                   ENDSR                                                  END DSP DSP
017900000000    ? *___________________________________________________________________
018000000000    ? * Build function key information
018100000000    ? *___________________________________________________________________
018200000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
018300991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
018400991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
018500000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
018600000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
018700000000    ?C                   PARM                    WAD                            FNC DESC
018800991108    ?C                   PARM                    WWIN                           *IN
018900000000    ?C                   PARM                    WAF                            FNC KEY TABLE
019000000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
019100000000    ? *
019200010913    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
019300010913    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
019400010913    ?C                   SUB       1             WW                             BUMP IDX
019500010913    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
019600000000    ?C                   ENDSR                                                  END BLD FKY
019700000000    ? *___________________________________________________________________
019800000000    ? * Process function keys
019900000000    ? *___________________________________________________________________
020000000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
020100991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
020200991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
020300000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
020400000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
020500000000    ?C                   PARM                    WAD                            FNC DESC
020600991108    ?C                   PARM                    WWIN                           *IN
020700000000    ?C                   PARM                    WAF                            FNC KEY TABLE
020800000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
020900000000    ?C                   ENDSR                                                  END PRCFKY
021000000000    ? *___________________________________________________________________
021100000000    ? * Process KEYS function
021200000000    ? *___________________________________________________________________
021300000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
021400000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
021500000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
021600000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
021700000000 001? *
021800000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
021900000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
022000000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
022100000000E002?C                   ENDIF                                                  END IF OVER 3
022200000000 001? *
022300000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
022400000000 001?C                   SUB       1             WW                             KEY DESCR IDX
022500000000E001?C                   ENDDO                                                  END DO KEYS
022600000000    ? *
022700000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
022800000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
022900000000    ?C                   SUB       1             WW                             BUMP IDX
023000000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
023100000000    ? *
023200000000    ?C                   ENDSR                                                  END PRCDKY
023300000000    ? *___________________________________________________________________
023400000000    ? * Process RETURN function
023500000000    ? *___________________________________________________________________
023600000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
023700000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
023800000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
023900000000    ?C                   ENDSR                                                  END RETURN
024000000000    ? *___________________________________________________________________
024100000000    ? * Process CANCEL function
024200000000    ? *___________________________________________________________________
024300000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
024400000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
024500000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
024600000000    ?C                   ENDSR                                                  END PRCCNL
024700000000    ? *___________________________________________________________________
024800000000    ? * Process ROLLUP function
024900000000    ? *___________________________________________________________________
025000000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
025100000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
025200000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
025300000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
025400000000E001?C                   ENDIF                                                  END IF GT LST PNL
025500000000    ?C                   ENDSR                                                  END PRCRUP
025600000000    ? *___________________________________________________________________
025700000000    ? * Process ROLLDOWN function
025800000000    ? *___________________________________________________________________
025900000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
026000000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
026100000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
026200000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
026300000000E001?C                   ENDIF                                                  END IF LT FST PNL
026400000000    ?C                   ENDSR                                                  END PRCRDN
026500000000    ? *___________________________________________________________________
026600000000    ? * Process ENTER function
026700000000    ? *___________________________________________________________________
026800000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
026900000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
027000000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
027100000000    ?C                   ENDSR                                                  END PRCENT
027200000000    ? *___________________________________________________________________
027300000000    ? * Send message
027400000000    ? *___________________________________________________________________
027500000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
027600000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
027700000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
027800000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
027900000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
028000000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
028100000000    ?C                   ENDSR                                                  END SND MSG
028200000000    ? *___________________________________________________________________
028300000000    ? * Parameter lists
028400000000    ? *___________________________________________________________________
028500000000    ?C     PLIST         BEGSR                                                  PARM LISTS
028600000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
028700000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
028800000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
028900000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
029000000614    ?C                   PARM                    WDDTA                          RECORD DS
029100000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
029200000000    ?C                   ENDSR                                                  END PLIST
029300000000    ? *___________________________________________________________________
029400000000    ? * Initialize routine
029500000000    ? *___________________________________________________________________
029600000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
029700000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
029800130603    ?C                   MOVEL     'PC2013ARC'   WWFIL            10            FILE NAME-NOTES
029900000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
030000000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
030100000000    ?C                   ENDSR                                                  END *INZSR
030200000000    ? *___________________________________________________________________
030300000000    ? * Define  routine
030400000000    ? *___________________________________________________________________
030500000000    ?C     DEFN          BEGSR                                                  Define Fields
030600000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
030700000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
030800000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
030900000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
031000000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
031100000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
031200000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
031300000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
031400000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
031500000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
031600000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
031700000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
031800000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
031900000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
032000000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
032100000000    ?C                   ENDSR                                                  END DEFN
032200000000    ? *___________________________________________________________________
032300000000    ? * Program error handler
032400000000    ? *___________________________________________________________________
032500000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
032600000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
032700000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
032800000000    ?C                   PARM                    WQSTSC                         STATUS CODE
032900000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
033000000000    ?C                   PARM                    WQMSG                          MESSAGE ID
033100000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
033200000000    ? *___________________________________________________________________
033300000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03340000000003EXIT    F3=Exit
03350000000012CANCEL  F12=Cancel
03360000000025ROLLUP
03370000000026ROLLDOWN
033800000000** WTM
03390011121600
