000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010219    ? *  Description:  Change Internal Sales Commission Salesman
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600030219    ? *
000700030219    ? *  Revised by: SZZ  February 19, 2003  Compile over modified file
000800000000    ? *_________________________________________________________________________
000900010219    ?FCHGSMND   CF   E             WORKSTN
001000000000    ?F                                     INFDS(DSPD)
001100000000    ? *
001200000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001400000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001500000000    ? *_________________________________________________________________________
001600000406    ? * Data structure
001700010219    ?D WUDTA         E DS                  EXTNAME(ISCSMN)
001800010220    ?D WDGLB         E DS                  EXTNAME(ISCGLB)
001900010220    ?D WDSMN         E DS                  EXTNAME(ISCSMN) PREFIX(M)
002000000000    ? *
002100000000    ? * Program status data structure
002200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000    ? *
002400000000    ? * Display file data structure
002500991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002600000000    ? *
002700000000    ? * CURSOR LOCATION
002800000000    ?D                 DS
002900000000    ?D  WWCRSL                 1      2
003000000000    ?D  WWCRSN                 1      2B 0
003100000000    ? *_________________________________________________________________________
003200000000    ? *
003300000614    ? * Process Entry Panel
003400000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
003500000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
003600000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
003700000000E001?C                   Endif                                                  END COPY/CPYKEY
003800000000    ? *
003900000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004000000000    ? *
004100000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004200000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004300000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
004400000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004500000000 001? *
004600000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
004700000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
004800000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
004900000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
005000000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005100000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
005200000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005300000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
005400000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
005500000000 001?C                   Endcs                                                  END CASE
005600000000 001? *
005700000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
005800000000 002?C                   Exsr      PRCEND                                       PROCESS END
005900000000E002?C                   Endif                                                  END IF END REQ
006000000000E001?C                   Enddo                                                  END DOWHILE
006100000000    ? *
006200000707    ? * Send Info Updated message.
006300000707     C     WwChg         Ifeq      'Y'
006400000707     C                   Movel     'UPDATE  '    WORTN
006500000707     C                   Endif
006600000707    ? *
006700000000    ?C                   Return                                                 RETURN
006800000000    ? *___________________________________________________________________
006900000000    ? * Prepare panel
007000000000    ? *___________________________________________________________________
007100000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007200000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007300010220    ?C                   Move      *ZEROS        WSZIP                          RETURN CODE
007400010220    ?C                   Move      *ZEROS        WSZIP4                         RETURN CODE
007500991108    ?C                   Move      'N'           WWERR                          NO ERRORS
007600000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
007700000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
007800000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007900000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008000000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008100000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
008200000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
008300000000    ? *
008400000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
008500000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
008600000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
008700000000E002?C                   Endif                                                  ENDIF SAME REQUEST
008800000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
008900000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009000000000    ? *
009100000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
009200000000    ? *
009300000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
009400000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
009500000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
009600000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
009700000000    ?C                   Cas                     PRCERR                         PROC ERROR
009800000000    ?C                   Endcs                                                  END CASE
009900000000    ? *
010000000000    ?C                   Endsr                                                  END PRPPNL
010100000000    ? *___________________________________________________________________
010200000000    ? * Prepare ADD request
010300000000    ? *___________________________________________________________________
010400000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
010500000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
010600000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
010700000000    ?C                   Endsr                                                  END PRP ADD
010800000000    ? *___________________________________________________________________
010900000000    ? * Prepare CHANGE request
011000000000    ? *___________________________________________________________________
011100000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
011200010219    ?C                   Call      'UPDSMN  '                                   PROCESS REC IO
011300000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
011400000000    ?C                   Parm                    WWRTN                          RETURN CODE
011500000614    ?C                   Parm                    WUDTA                          REC DATA
011600020220    ?C                   Parm                    FRRN                           FNC KEY ALLOWED
011700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
011800000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
011900000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
012000000000X002?C                   Else                                                   ELSE
012100000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
012200000000E002?C                   Endif                                                  END RCD NOT AVL
012300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
012400000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
012500000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
012600000810E001?C                   Else                                                   END IF ERROR
012700010220     C                   movel     iszip         wszip
012800010220     C                   move      iszip         wszip4
012900000810E001?C                   Endif                                                  END IF ERROR
013000000000    ?C                   Endsr                                                  END PRP CHANGE
013100000000    ? *___________________________________________________________________
013200000000    ? * Prepare COPY request
013300000000    ? *___________________________________________________________________
013400000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
013500000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
013600010219    ?C                   Call      'UPDSMN  '                                   PROCESS REC IO
013700000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
013800000000    ?C                   Parm                    WWRTN                          RETURN CODE
013900000614    ?C                   Parm                    WUDTA                          REC DATA
014000020220    ?C                   Parm                    FRRN                           FNC KEY ALLOWED
014100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014200000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014400000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014500000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
014600000000X001?C                   Else                                                   ELSE
014700000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
014800010219 001?C                   Clear                   ISSMAN                         CLEAR KEY
014900020220     C                   movel     iszip         wszip
015000020220     C                   move      iszip         wszip4
015100000000E001?C                   Endif                                                  END IF ERROR
015200000000    ?C                   Endsr                                                  END PREP COPY
015300000000    ? *___________________________________________________________________
015400000000    ? * Default Data
015500000000    ? *___________________________________________________________________
015600000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
015700010219    ?C                   Call      'CHKSMN  '                                   PROCESS REC IO
015800000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
015900000000    ?C                   Parm                    WWRTN                          RETURN CODE
016000000614    ?C                   Parm                    WUDTA                          REC DATA
016100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016200000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
016300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016400000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016500000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016600000000E001?C                   Endif                                                  END IF ERROR
016700000000    ?C                   Endsr                                                  END DFTDTA
016800000000    ? *___________________________________________________________________
016900000000    ? * Process ERROR function
017000000000    ? *___________________________________________________________________
017100000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
017200000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
017300000000    ?C                   Exsr      SNDMSG                                       SEND MSG
017400000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017500000000    ?C                   Move      'END'         WWSTT                          END STATE
017600000000    ?C                   Endsr                                                  END PRCERR
017700000000    ? *___________________________________________________________________
017800000000    ? * Receive messages
017900000000    ? *___________________________________________________________________
018000000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
018100000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
018200000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
018300000000X001?C                   Else                                                   ELSE
018400000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
018500000000E001?C                   Endif                                                  ENDIF NOT NORESET
018600000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
018700000000    ?C                   Movea     *IN           WWIN                           INDICATORS
018800000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
018900000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
019000000000    ?C                   Parm                    WWIN                           INDICATORS
019100000000    ?C                   Parm                    WWRTN                          RETURN CODE
019200000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
019300000000    ?C                   Endsr                                                  END RCV MSG
019400000000    ? *___________________________________________________________________
019500000000    ? * Display panels
019600000000    ? *___________________________________________________________________
019700000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
019800000000    ? *
019900000000    ? * Set PUTOVR based on last display file processed
020000000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
020100000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
020200000000 001?C                   Setoff                                       35        PUTOVR OFF
020300000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
020400000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
020500000000X001?C                   Else                                                   ELSE SAME PGM
020600000000 001?C                   Seton                                        35        PUTOVR ON
020700000000E001?C                   Endif                                                  END IF NEW PGM
020800000000    ? *
020900000614    ? * Set PROTECT key based on request
021000000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
021100000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
021200000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
021300000000 001?C                   Setoff                                       40        NO PROTECT KEY
021400000000X001?C                   Else                                                   ELSE
021500000000 001?C                   Seton                                        40        PROTECT KEY
021600000000E001?C                   Endif                                                  END IF ADD
021700000000    ? *
021800000000    ? * Select title
021900000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
022000000000 001?C                   Setoff                                       38        CHANGE TITLE
022100000000X001?C                   Else                                                   ELSE
022200000000 001?C                   Seton                                        38        ADD TITLE
022300000000E001?C                   Endif                                                  END IF CHANGE
022400000000    ? *
022500000000    ? * Position cursor based on error status
022600000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
022700000000 001?C                   Seton                                        99        POS CSR TO ERROR
022800000000X001?C                   Else                                                   ELSE
022900000000 001?C                   Setoff                                       99        POS CSR TO FIRST
023000000000E001?C                   Endif                                                  END IF ERROR
023100000000    ? *
023200000000    ? * Write message subfile
023300000000    ?C                   Seton                                        30        MSGSFL DISPLAY
023400000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
023500000000    ? *
023600000000    ? * Write entry panel
023700000000B001?C                   Select
023800000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
023900000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
024000000000 001?C                   Setoff                                       37        RESET CRSLOC
024100000000E001?C                   Endsl                                                  END SELECT
024200000000    ? *
024300000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
024400000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
024500000000E001?C                   Endif                                                  END IF DATA CHG
024600000000    ?C                   Endsr                                                  END DSPENT
024700000000    ? *___________________________________________________________________
024800000000    ? * Process function key
024900000000    ? *___________________________________________________________________
025000000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
025100991108    ?C                   Movea     *IN           WWIN                           INDICATORS
025200991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
025300000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
025400000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
025500000000    ?C                   Parm                    WAD                            FNC DESC
025600991108    ?C                   Parm                    WWIN                           AID BYTE
025700000000    ?C                   Parm                    WAF                            FNC KEY TABLE
025800000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
025900000000    ?C                   Endsr                                                  END PRCFKY
026000000000    ? *___________________________________________________________________
026100000000    ? * Process KEYS function
026200000000    ? *___________________________________________________________________
026300000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
026400000000    ?C                   Z-add     1             WW                             KEY DSC IDX
026500000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
026600000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
026700000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
026800000000 001? *
026900000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
027000000000 002?C                   Z-add     1             WWFKS                          SET TO 1
027100000000E002?C                   Endif                                                  END IF OVER 3
027200000000 001? *
027300000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
027400000000 001?C                   Sub       1             WW                             KEY DESCR IDX
027500000000E001?C                   Enddo                                                  END DO KEYS
027600000000    ? *
027700000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
027800000000    ?C                   Add       1             WW                             BUMP IDX
027900000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
028000000000    ?C                   Endsr                                                  END PRCDKY
028100000000    ? *___________________________________________________________________
028200000000    ? * Process EXIT Function
028300000000    ? *___________________________________________________________________
028400000000    ?C     PRCEXT        Begsr                                                  RETURN
028500000000    ? *
028600000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
028700000000    ? *
028800000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
028900000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
029000000000X001?C                   Else                                                   ELSE NO ERRORS
029100000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
029200000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
029300000000E001?C                   Endif                                                  END IF ERRORS
029400000000    ?C                   Endsr                                                  END PRCEXT
029500000000    ? *___________________________________________________________________
029600000000    ? * Process PROMPT function
029700000000    ? *___________________________________________________________________
029800000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
029900000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
030000000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
030100000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
030200000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
030300000000    ? *
030400000000B001?C                   Select                                                 SELECT
030500040729 001 C                   When      WSFLD = 'XXXXXX'
030600000000 001?C                   Other                                                  WHERE ERROR
030700000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
030800000000 001?C                   Exsr      SNDMSG                                       SEND MSG
030900000000E001?C                   Endsl                                                  END SELECT
031000000000    ? *
031100000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
031200000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
031300000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
031400000000    ?C                   Mvr                     WSLIN                          CURSOR COL
031500000000    ?C                   Seton                                        37        SET ON CRSLOC
031600000000    ? *
031700000000    ?C                   Endsr                                                  END PRCPMT
031800000000    ? *___________________________________________________________________
031900000000    ? * Process CANCEL Function
032000000000    ? *___________________________________________________________________
032100000000    ?C     PRCCNL        Begsr                                                  CANCEL
032200000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
032300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
032400000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
032500000000    ?C                   Endsr                                                  END RETURN
032600000000    ? *___________________________________________________________________
032700000000    ? * Process ROLLUP function
032800000000    ? *___________________________________________________________________
032900000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
033000000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
033100000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
033200000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
033300000000E001?C                   Endif                                                  END IF GT LST PNL
033400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
033500000000    ?C                   Endsr                                                  END PRCRUP
033600000000    ? *___________________________________________________________________
033700000000    ? * Process ROLLDOWN function
033800000000    ? *___________________________________________________________________
033900000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
034000000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
034100000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
034200000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
034300000000E001?C                   Endif                                                  END IF LT FST PNL
034400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
034500000000    ?C                   Endsr                                                  END PRCRDN
034600000000    ? *___________________________________________________________________
034700000000    ? * Process ENTER function
034800000000    ? *___________________________________________________________________
034900000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
035000000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
035100000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
035200000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
035300000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
035400000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
035500010220     C                   movel     wszip         iszip
035600010220     C                   move      wszip4        iszip
035700010219 001?C                   Call      'CHKSMN  '                                   CHECK DATA
035800000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
035900000000 001?C                   Parm                    WWRTN                          RETURN CODE
036000000614 001?C                   Parm                    WUDTA                          REC DATA
036100000000E001?C                   Endif                                                  ENDIF
036200000000    ? *
036300000000B001?C                   Select                                                 PRC RETURN CDE
036400000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
036500000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
036600010219 001?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
036700000000 001? *
036800000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
036900000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
037000000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
037100010219 002?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
037200000000X002?C                   Else                                                   ELSE
037300000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
037400000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
037500000000E002?C                   Endif                                                  IF WARNING
037600000000 001? *
037700000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
037800000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
037900000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
038000000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
038100000000E001?C                   Endsl                                                  RETURN CODE SEL
038200000000    ? *
038300000000    ?C                   Endsr                                                  END PRCPNL
038400000000    ? *___________________________________________________________________
038500000000    ? * Process end - write data or release record
038600000000    ? *___________________________________________________________________
038700000000    ?C     PRCEND        Begsr                                                  PROCESS END
038800000000    ? *
038900000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
039000000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
039100000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
039200000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
039300000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
039400000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
039500000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
039600000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
039700000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
039800000000 001?C                   Endcs                                                  END CASE
039900000000 001? *
040000000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
040100000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
040200000000 002? *
040300000000X002?C                   Else                                                   ELSE NO WRT ERR
040400000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
040500000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
040600000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
040700000000 004?C                   Exsr      PRPPNL                                       DO NOT END
040800000810E004?C                   Endif                                                  END IF ADD
040900000000E003?C                   Endif                                                  END IF NOT END
041000000000E002?C                   Endif                                                  END IF WRITE ERROR
041100000000 001? *
041200000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
041300000000 001?C                   Exsr      RELREC                                       RELEASE REC
041400000000E001?C                   Endif                                                  END IF RCD CHANGED
041500000000    ? *
041600000000    ?C                   Endsr                                                  END PRCEND
041700000000    ? *___________________________________________________________________
041800000000    ? * Add new record
041900000000    ? *___________________________________________________________________
042000000000    ?C     WRTADD        Begsr                                                  WRITE ADD
042100000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
042200000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
042300000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
042400000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
042500000000E001?C                   Endif                                                  END IF ADD
042600000000    ? *
042700000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
042800000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
042900000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
043000000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
043100000000E001?C                   Endif                                                  END IF ADD KEY
043200000000    ? *
043300010219    ?C                   Call      'UPDSMN  '                                   PROCESS REC IO
043400000000    ?C                   Parm                    WWRQS                          ADD RECORD
043500000000    ?C                   Parm                    WWRTN                          RETURN CODE
043600000614    ?C                   Parm                    WUDTA                          REC DATA
043700020220    ?C                   Parm                    FRRN                           FNC KEY ALLOWED
043800000000    ? *
043900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
044000000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
044100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
044200000000X001?C                   Else                                                   ELSE
044300000000E001?C                   Endif                                                  END IF CALL ERROR
044400000000    ? *
044500000000    ?C                   Endsr                                                  END WRTADD
044600000000    ? *___________________________________________________________________
044700000000    ? * Write changed record
044800000000    ? *___________________________________________________________________
044900000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
045000010219    ?C                   Call      'UPDSMN  '                                   PROCESS REC IO
045100000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
045200000000    ?C                   Parm                    WWRTN                          RETURN CODE
045300000614    ?C                   Parm                    WUDTA                          REC DATA
045400020220    ?C                   Parm                    FRRN                           FNC KEY ALLOWED
045500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
045600000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
045700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
045800000000E001?C                   Endif                                                  END IF CALL ERROR
045900000000    ? *
046000000000    ?C                   Endsr                                                  END WRTCHG
046100000000    ? *___________________________________________________________________
046200000000    ? * Release record
046300000000    ? *___________________________________________________________________
046400000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
046500010219    ?C                   Call      'UPDSMN  '                                   PROCESS REC IO
046600000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
046700000000    ?C                   Parm                    WWRTN                          RETURN CODE
046800000614    ?C                   Parm                    WUDTA                          REC DATA
046900020220    ?C                   Parm                    FRRN                           FNC KEY ALLOWED
047000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
047100000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
047200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047300000000E001?C                   Endif                                                  END IF CALL ERROR
047400000000    ?C                   Endsr                                                  END RELREC
047500000000    ? *___________________________________________________________________
047600000000    ? * Build function keys
047700000000    ? *___________________________________________________________________
047800000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
047900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
048000991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
048100000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
048200000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
048300000000    ?C                   Parm                    WAD                            FNC DESC
048400991108    ?C                   Parm                    WWIN                           AID BYTE
048500000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
048600000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
048700000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
048800000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
048900000000    ?C                   Sub       1             WW                             BUMP IDX
049000000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
049100000000    ?C                   Endsr                                                  END BLD FNCTNS
049200000000    ? *___________________________________________________________________
049300000000    ? * Send message
049400000000    ? *___________________________________________________________________
049500000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
049600000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
049700000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
049800000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
049900000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
050000000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
050100000000    ?C                   Endsr                                                  END SNDMSG
050200000000    ? *___________________________________________________________________
050300000000    ? * Paremater list
050400000000    ? *___________________________________________________________________
050500000000    ?C     PLIST         Begsr                                                  PARM LISTS
050600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
050700000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
050800000000    ?C                   Parm                    WORTN             8            RETURN CODE
050900000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
051000000614    ?C                   Parm                    WUDTA                          RECORD KEY
051100000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
051200020220    ?C                   Parm                    FRRN              6 0          FNC KEY ALLOWED
051300000000    ?C                   Endsr                                                  END PLIST
051400000000    ? *___________________________________________________________________
051500000000    ? * Initialize routine
051600000000    ? *___________________________________________________________________
051700000000    ?C     *INZSR        Begsr                                                  INITIALIZE
051800000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
051900000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
052000000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
052100000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
052200000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
052300000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
052400000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
052500000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
052600000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
052700000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
052800000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
052900000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
053000000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
053100000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
053200000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
053300000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
053400000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
053500000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
053600000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
053700000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
053800000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
053900000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
054000000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
054100000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
054200000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
054300010219    ?C                   Movel     'ISCSMN  '    WWFIL            10            FILE NAME-NOTES
054400000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
054500000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
054600000000    ?C                   Endsr                                                  END INITIALIZE
054700000000    ? *___________________________________________________________________
054800000000    ? * Program error handler
054900000000    ? *___________________________________________________________________
055000000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
055100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
055200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
055300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
055400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
055500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
055600000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
055700000000    ? *___________________________________________________________________
055800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05590000000003EXIT    F3=Exit
05600000000004PROMPT  F4=Prompt
05610000000005REFRESH F5=Refresh
05620000070710UPDATE  F10=Update
05630000061412CANCEL  F12=Cancel
05640000000025ROLLUP
05650000000026ROLLDOWN
056600000000** WTM
05670001021900Request not supported in program CHGSMN.
05680000000000Update error.  Data was not updated.
05690000000000Duplicate key detected.  Data was NOT added to file.
05700000000000Call to notes ended in error.
05710000000000Initialize error.  Record not initialized.
05720000000000Record not found.
05730000000000Generate error.  Key not generated.
05740000000000Record not available now.
05750000000000The cursor is not in a prompt area.
05760000000000Default error.  Data not defaulted.
