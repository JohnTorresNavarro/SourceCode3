000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300030716    ? *  Description:  Change Broker Carrier Licensing file
000400000000    ? *
000500030716    ? *  (c)Copyright 2003 by Group Benefit Services, Inc.
000600000000    ? *_________________________________________________________________________
000700030812    ?FCHGLSUD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900030812    ?FSUPRAGCY  IF   E           K DISK
001400000000    ? *
001500000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001600000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001700000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001800000000    ? *_________________________________________________________________________
001900000406    ? * Data structure
002000030812    ?D WUDTA         E DS                  EXTNAME(BLILSU)
002100030812    ?D WDSUPR        E DS                  EXTNAME(SUPRAGCY)
002200000000    ? *
002300000000    ? * Program status data structure
002400991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002500000000    ? *
002600000000    ? * Display file data structure
002700991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002800000000    ? *
002900000000    ? * CURSOR LOCATION
003000000000    ?D                 DS
003100000000    ?D  WWCRSL                 1      2
003200000000    ?D  WWCRSN                 1      2B 0
003300000000    ? *_________________________________________________________________________
003400000000    ? *
003500000614    ? * Process Entry Panel
003600000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
003700000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
003800000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
003900000000E001?C                   Endif                                                  END COPY/CPYKEY
004000000000    ? *
004100000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004200000000    ? *
004300000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004400000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004500000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
004600000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004700000000 001? *
004800000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
004900000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
005000000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005100000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
005200000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005300000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
005400000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005500000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
005600000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
005700000000 001?C                   Endcs                                                  END CASE
005800000000 001? *
005900000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
006000000000 002?C                   Exsr      PRCEND                                       PROCESS END
006100000000E002?C                   Endif                                                  END IF END REQ
006200000000E001?C                   Enddo                                                  END DOWHILE
006300000000    ? *
006400000707    ? * Send Info Updated message.
006500000707     C     WwChg         Ifeq      'Y'
006600000707     C                   Movel     'UPDATE  '    WORTN
006700000707     C                   Endif
006800000707    ? *
006900000000    ?C                   Return                                                 RETURN
007000000000    ? *___________________________________________________________________
007100000000    ? * Prepare panel
007200000000    ? *___________________________________________________________________
007300000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007400000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007500010223    ?C                   Move      *ZEROS        WSDATE                         RETURN CODE
007600010223    ?C                   Move      *ZEROS        WSEFDT                         RETURN CODE
007700010223    ?C                   Move      *ZEROS        WSTRDT                         RETURN CODE
007800991108    ?C                   Move      'N'           WWERR                          NO ERRORS
007900000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008000000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008100000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008200000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008300000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008400000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
008500000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
008600000000    ? *
008700000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
008800000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
008900000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009000000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009100000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009200000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009300000000    ? *
009400000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
009500000000    ? *
009600000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
009700000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
009800000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
009900000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
010000000000    ?C                   Cas                     PRCERR                         PROC ERROR
010100000000    ?C                   Endcs                                                  END CASE
010200000000    ? *
010300000000    ?C                   Endsr                                                  END PRPPNL
010400000000    ? *___________________________________________________________________
010500000000    ? * Prepare ADD request
010600000000    ? *___________________________________________________________________
010700000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
010800000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
011200030811     C                   CLEAR                   WSNAME
011500000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
011600000000    ?C                   Endsr                                                  END PRP ADD
011700000000    ? *___________________________________________________________________
011800000000    ? * Prepare CHANGE request
011900000000    ? *___________________________________________________________________
012000000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
012100030812    ?C                   Call      'UPDLSU  '                                   PROCESS REC IO
012200000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
012300000000    ?C                   Parm                    WWRTN                          RETURN CODE
012400000614    ?C                   Parm                    WUDTA                          REC DATA
012500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
012600000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
012700000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
012800000000X002?C                   Else                                                   ELSE
012900000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
013000000000E002?C                   Endif                                                  END RCD NOT AVL
013100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
013200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
013400000810E001?C                   Else                                                   END IF ERROR
013500030812     C     LUCHGD        MULT      10000.0001    WSDATE
013600030812     C     LUEFFD        MULT      10000.0001    WSEFDT
013700030812     C     LUEXPD        MULT      10000.0001    WSTRDT
013800030812     C                   EXSR      GETSUPR
013900000810E001?C                   Endif                                                  END IF ERROR
014000000000    ?C                   Endsr                                                  END PRP CHANGE
014100000000    ? *___________________________________________________________________
014200000000    ? * Prepare COPY request
014300000000    ? *___________________________________________________________________
014400000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
014500000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
014600030812    ?C                   Call      'UPDLSU  '                                   PROCESS REC IO
014700000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
014800000000    ?C                   Parm                    WWRTN                          RETURN CODE
014900000614    ?C                   Parm                    WUDTA                          REC DATA
015000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015100000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
015200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
015300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015500000000X001?C                   Else                                                   ELSE
015600000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
015601030812 001?C                   Clear                   LUSUPR                         CLEAR KEY
015700030812 001?C                   Clear                   LUSTAT                         CLEAR KEY
015800000000E001?C                   Endif                                                  END IF ERROR
015900000000    ?C                   Endsr                                                  END PREP COPY
016000000000    ? *___________________________________________________________________
016100000000    ? * Default Data
016200000000    ? *___________________________________________________________________
016300000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
016400030812    ?C                   Call      'CHKLSU  '                                   PROCESS REC IO
016500000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
016600000000    ?C                   Parm                    WWRTN                          RETURN CODE
016700000614    ?C                   Parm                    WUDTA                          REC DATA
016800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016900000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
017000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
017100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017200000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
017300000000E001?C                   Endif                                                  END IF ERROR
017400000000    ?C                   Endsr                                                  END DFTDTA
017500000000    ? *___________________________________________________________________
017600000000    ? * Process ERROR function
017700000000    ? *___________________________________________________________________
017800000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
017900000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
018000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
018100000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018200000000    ?C                   Move      'END'         WWSTT                          END STATE
018300000000    ?C                   Endsr                                                  END PRCERR
018400000000    ? *___________________________________________________________________
018500000000    ? * Receive messages
018600000000    ? *___________________________________________________________________
018700000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
018800000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
018900000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
019000000000X001?C                   Else                                                   ELSE
019100000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
019200000000E001?C                   Endif                                                  ENDIF NOT NORESET
019300000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
019400000000    ?C                   Movea     *IN           WWIN                           INDICATORS
019500000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
019600000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
019700000000    ?C                   Parm                    WWIN                           INDICATORS
019800000000    ?C                   Parm                    WWRTN                          RETURN CODE
019900000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
020000000000    ?C                   Endsr                                                  END RCV MSG
020100000000    ? *___________________________________________________________________
020200000000    ? * Display panels
020300000000    ? *___________________________________________________________________
020400000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
020500000000    ? *
020600000000    ? * Set PUTOVR based on last display file processed
020700000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
020800000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
020900000000 001?C                   Setoff                                       35        PUTOVR OFF
021000000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
021100000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
021200000000X001?C                   Else                                                   ELSE SAME PGM
021300000000 001?C                   Seton                                        35        PUTOVR ON
021400000000E001?C                   Endif                                                  END IF NEW PGM
021500000000    ? *
021600000614    ? * Set PROTECT key based on request
021700000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
021800000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
021900030722 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
022000000000 001?C                   Setoff                                       40        NO PROTECT KEY
022100000000X001?C                   Else                                                   ELSE
022200000000 001?C                   Seton                                        40        PROTECT KEY
022300000000E001?C                   Endif                                                  END IF ADD
022900000000    ? *
023000000000    ? * Select title
023100000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
023200000000 001?C                   Setoff                                       38        CHANGE TITLE
023300000000X001?C                   Else                                                   ELSE
023400000000 001?C                   Seton                                        38        ADD TITLE
023500000000E001?C                   Endif                                                  END IF CHANGE
023600000000    ? *
023700000000    ? * Position cursor based on error status
023800000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
023900000000 001?C                   Seton                                        99        POS CSR TO ERROR
024000000000X001?C                   Else                                                   ELSE
024100000000 001?C                   Setoff                                       99        POS CSR TO FIRST
024200000000E001?C                   Endif                                                  END IF ERROR
024300000000    ? *
024400000000    ? * Write message subfile
024500000000    ?C                   Seton                                        30        MSGSFL DISPLAY
024600000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
024700000000    ? *
024800000000    ? * Write entry panel
024900000000B001?C                   Select
025000000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
025100000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
025200000000 001?C                   Setoff                                       37        RESET CRSLOC
025300000000E001?C                   Endsl                                                  END SELECT
025400000000    ? *
025500000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
025600000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
025700000000E001?C                   Endif                                                  END IF DATA CHG
025800000000    ?C                   Endsr                                                  END DSPENT
025900000000    ? *___________________________________________________________________
026000000000    ? * Process function key
026100000000    ? *___________________________________________________________________
026200000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
026300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
026400991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
026500000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
026600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
026700000000    ?C                   Parm                    WAD                            FNC DESC
026800991108    ?C                   Parm                    WWIN                           AID BYTE
026900000000    ?C                   Parm                    WAF                            FNC KEY TABLE
027000000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
027100000000    ?C                   Endsr                                                  END PRCFKY
027200000000    ? *___________________________________________________________________
027300000000    ? * Process KEYS function
027400000000    ? *___________________________________________________________________
027500000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
027600000000    ?C                   Z-add     1             WW                             KEY DSC IDX
027700000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
027800000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
027900000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
028000000000 001? *
028100000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
028200000000 002?C                   Z-add     1             WWFKS                          SET TO 1
028300000000E002?C                   Endif                                                  END IF OVER 3
028400000000 001? *
028500000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
028600000000 001?C                   Sub       1             WW                             KEY DESCR IDX
028700000000E001?C                   Enddo                                                  END DO KEYS
028800000000    ? *
028900000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
029000000000    ?C                   Add       1             WW                             BUMP IDX
029100000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
029200000000    ?C                   Endsr                                                  END PRCDKY
029300000000    ? *___________________________________________________________________
029400000000    ? * Process EXIT Function
029500000000    ? *___________________________________________________________________
029600000000    ?C     PRCEXT        Begsr                                                  RETURN
029700000000    ? *
029800000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
029900000000    ? *
030000000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
030100000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
030200000000X001?C                   Else                                                   ELSE NO ERRORS
030300000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
030400000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
030500000000E001?C                   Endif                                                  END IF ERRORS
030600000000    ?C                   Endsr                                                  END PRCEXT
030700000000    ? *___________________________________________________________________
030800000000    ? * Process PROMPT function
030900000000    ? *___________________________________________________________________
031000000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
031100000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
031200000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
031300000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
031400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
031500000000    ? *
031600000000B001?C                   Select                                                 SELECT
031700030812 001 C                   When      WSFLD = 'LUSUPR'
031800030812 001?C                   Call      'SLCSUPER'                                   CALL SELECT PROGRAM
031801030811    ?C                   Parm                    WWRQS             8            PROGRAM REQUEST
031802030811    ?C                   Parm                    WWRTN             8            RETURN CODE
031803030811    ?C                   Parm                    WUPGM            10            LAST PGM NAME
031804030812    ?C                   Parm                    WDSUPR                         RECORD DS
031805030811     C                   If        WWRTN = *Blanks
031806030812     C                   Eval      LUSUPR = SACODE
032200030812     C                   EXSR      GETSUPR
032300030716E001?C                   Endif
032400000112 001? *
032500000000 001?C                   Other                                                  WHERE ERROR
032600000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
032700000000 001?C                   Exsr      SNDMSG                                       SEND MSG
032800000000E001?C                   Endsl                                                  END SELECT
032900000000    ? *
033000000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
033100000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
033200000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
033300000000    ?C                   Mvr                     WSLIN                          CURSOR COL
033400000000    ?C                   Seton                                        37        SET ON CRSLOC
033500000000    ? *
033600000000    ?C                   Endsr                                                  END PRCPMT
033700000000    ? *___________________________________________________________________
033800000000    ? * Process CANCEL Function
033900000000    ? *___________________________________________________________________
034000000000    ?C     PRCCNL        Begsr                                                  CANCEL
034100000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
034200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
034300000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
034400000000    ?C                   Endsr                                                  END RETURN
034500000000    ? *___________________________________________________________________
034600000000    ? * Process ROLLUP function
034700000000    ? *___________________________________________________________________
034800000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
034900000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
035000000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
035100000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
035200000000E001?C                   Endif                                                  END IF GT LST PNL
035300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
035400000000    ?C                   Endsr                                                  END PRCRUP
035500000000    ? *___________________________________________________________________
035600000000    ? * Process ROLLDOWN function
035700000000    ? *___________________________________________________________________
035800000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
035900000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
036000000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
036100000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
036200000000E001?C                   Endif                                                  END IF LT FST PNL
036300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
036400000000    ?C                   Endsr                                                  END PRCRDN
036500000000    ? *___________________________________________________________________
036600000000    ? * Process ENTER function
036700000000    ? *___________________________________________________________________
036800000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
036900000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
037000000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
037100000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
037200000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
037300000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
037400030812     C                   Z-add     WSEFDT        LUEFFD
037500030812     C                   Z-add     WSTRDT        LUEXPD
037600030812 001?C                   Call      'CHKLSU  '                                   CHECK DATA
037700000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
037800000000 001?C                   Parm                    WWRTN                          RETURN CODE
037900000614 001?C                   Parm                    WUDTA                          REC DATA
038000000000E001?C                   Endif                                                  ENDIF
038100000000    ? *
038200000000B001?C                   Select                                                 PRC RETURN CDE
038300000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
038400000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
038500010219 001?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
038600000000 001? *
038700000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
038800000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
038900000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
039000010219 002?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
039100000000X002?C                   Else                                                   ELSE
039200000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
039300000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
039400000000E002?C                   Endif                                                  IF WARNING
039500000000 001? *
039600000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
039700000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
039800000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
039900000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
040000000000E001?C                   Endsl                                                  RETURN CODE SEL
040100000000    ? *
040200000000    ?C                   Endsr                                                  END PRCPNL
040300000000    ? *___________________________________________________________________
040400000000    ? * Process end - write data or release record
040500000000    ? *___________________________________________________________________
040600000000    ?C     PRCEND        Begsr                                                  PROCESS END
040700000000    ? *
040800000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
040900000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
041000000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
041100000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
041200000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
041300000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
041400000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
041500000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
041600000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
041700000000 001?C                   Endcs                                                  END CASE
041800000000 001? *
041900000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
042000000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
042100000000 002? *
042200000000X002?C                   Else                                                   ELSE NO WRT ERR
042300000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
042400000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
042500000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
042600000000 004?C                   Exsr      PRPPNL                                       DO NOT END
042700000810E004?C                   Endif                                                  END IF ADD
042800000000E003?C                   Endif                                                  END IF NOT END
042900000000E002?C                   Endif                                                  END IF WRITE ERROR
043000000000 001? *
043100000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
043200000000 001?C                   Exsr      RELREC                                       RELEASE REC
043300000000E001?C                   Endif                                                  END IF RCD CHANGED
043400000000    ? *
043500000000    ?C                   Endsr                                                  END PRCEND
043600000000    ? *___________________________________________________________________
043700000000    ? * Add new record
043800000000    ? *___________________________________________________________________
043900000000    ?C     WRTADD        Begsr                                                  WRITE ADD
044000000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
044100000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
044200000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
044300000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
044400000000E001?C                   Endif                                                  END IF ADD
044500000000    ? *
044600000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
044700000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
044800000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
044900000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
045000000000E001?C                   Endif                                                  END IF ADD KEY
045100000000    ? *
045200030812    ?C                   Call      'UPDLSU  '                                   PROCESS REC IO
045300000000    ?C                   Parm                    WWRQS                          ADD RECORD
045400000000    ?C                   Parm                    WWRTN                          RETURN CODE
045500000614    ?C                   Parm                    WUDTA                          REC DATA
045600000000    ? *
045700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
045800000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
045900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
046000000000X001?C                   Else                                                   ELSE
046100000000E001?C                   Endif                                                  END IF CALL ERROR
046200000000    ? *
046300000000    ?C                   Endsr                                                  END WRTADD
046400000000    ? *___________________________________________________________________
046500000000    ? * Write changed record
046600000000    ? *___________________________________________________________________
046700000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
046800030812    ?C                   Call      'UPDLSU  '                                   PROCESS REC IO
046900000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
047000000000    ?C                   Parm                    WWRTN                          RETURN CODE
047100000614    ?C                   Parm                    WUDTA                          REC DATA
047200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
047300000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
047400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047500000000E001?C                   Endif                                                  END IF CALL ERROR
047600000000    ? *
047700000000    ?C                   Endsr                                                  END WRTCHG
047800000000    ? *___________________________________________________________________
047900000000    ? * Release record
048000000000    ? *___________________________________________________________________
048100000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
048200030812    ?C                   Call      'UPDLSU  '                                   PROCESS REC IO
048300000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
048400000000    ?C                   Parm                    WWRTN                          RETURN CODE
048500000614    ?C                   Parm                    WUDTA                          REC DATA
048600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
048700000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
048800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
048900000000E001?C                   Endif                                                  END IF CALL ERROR
049000000000    ?C                   Endsr                                                  END RELREC
049100000000    ? *___________________________________________________________________
049200000000    ? * Build function keys
049300000000    ? *___________________________________________________________________
049400000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
049500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
049600991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
049700000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
049800000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
049900000000    ?C                   Parm                    WAD                            FNC DESC
050000991108    ?C                   Parm                    WWIN                           AID BYTE
050100000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
050200000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
050300000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
050400000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
050500000000    ?C                   Sub       1             WW                             BUMP IDX
050600000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
050700000000    ?C                   Endsr                                                  END BLD FNCTNS
050800000000    ? *___________________________________________________________________
050900000000    ? * Send message
051000000000    ? *___________________________________________________________________
051100000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
051200000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
051300000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
051400000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
051500000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
051600000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
051700000000    ?C                   Endsr                                                  END SNDMSG
051800000000    ? *___________________________________________________________________
051900000000    ? * Paremater list
052000000000    ? *___________________________________________________________________
052100000000    ?C     PLIST         Begsr                                                  PARM LISTS
052200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
052300000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
052400000000    ?C                   Parm                    WORTN             8            RETURN CODE
052500000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
052600000614    ?C                   Parm                    WUDTA                          RECORD KEY
052700000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
052800000000    ?C                   Endsr                                                  END PLIST
052900030716    ? *___________________________________________________________________
053000030812    ? * GET SUPER AGENCY
053100030716    ? *___________________________________________________________________
053200030812    ?C     GETSUPR       Begsr                                                  PARM LISTS
053800030812     C     LUSUPR        CHAIN     SUPRAGCY
053900030717     C                   IF        NOT %FOUND
054000030811     C                   CLEAR                   WSNAME
054100030717     C                   ELSE
054200030812     C                   EVAL      WSNAME = %trim(SANAME1)
054300030717     C                   END
056400030716    ?C                   Endsr                                                  END PLIST
056500000000    ? *___________________________________________________________________
056600000000    ? * Initialize routine
056700000000    ? *___________________________________________________________________
056800000000    ?C     *INZSR        Begsr                                                  INITIALIZE
056900000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
057000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
057100000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
057200000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
057300000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
057400000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
057500000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
057600000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
057700000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
057800000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
057900000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
058000000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
058100000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
058200000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
058300000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
058400000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
058500000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
058600000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
058700000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
058800000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
058900000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
059000000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
059100000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
059200000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
059300000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
059400030812    ?C                   Movel     'BLILSU  '    WWFIL            10            FILE NAME-NOTES
059500000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
059600000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
059700000000    ?C                   Endsr                                                  END INITIALIZE
059800000000    ? *___________________________________________________________________
059900000000    ? * Program error handler
060000000000    ? *___________________________________________________________________
060100000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
060200000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
060300000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
060400000000    ?C                   Parm                    WQSTSC                         STATUS CODE
060500000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
060600000000    ?C                   Parm                    WQMSG                          MESSAGE ID
060700000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
060800000000    ? *___________________________________________________________________
060900000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06100000000003EXIT    F3=Exit
06110000000004PROMPT  F4=Prompt
06120000000005REFRESH F5=Refresh
06130000070710UPDATE  F10=Update
06140000061412CANCEL  F12=Cancel
06150000000025ROLLUP
06160000000026ROLLDOWN
061700000000** WTM
06180003081200Request not supported in program CHGLSU.
06190000000000Update error.  Data was not updated.
06200000000000Duplicate key detected.  Data was NOT added to file.
06210000000000Call to notes ended in error.
06220000000000Initialize error.  Record not initialized.
06230000000000Record not found.
06240000000000Generate error.  Key not generated.
06250000000000Record not available now.
06260000000000The cursor is not in a prompt area.
06270000000000Default error.  Data not defaulted.
