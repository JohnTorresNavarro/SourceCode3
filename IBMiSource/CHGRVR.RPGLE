000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300080627    ? *  Description:  Change Payment Reversal Reason Codes
000400000000    ? *
000500080627    ? *  (c)Copyright 2008 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700080627    ?FCHGRVRD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
001200000000    ? *
001300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001500000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001600000000    ? *_________________________________________________________________________
001700000406    ? * Data structure
001800080627    ?D WUDTA         E DS                  EXTNAME(RVRCOD)
002100000000    ? *
002200000000    ? * Program status data structure
002300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002400000000    ? *
002500000000    ? * Display file data structure
002600991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002700000000    ? *
002800000000    ? * CURSOR LOCATION
002900000000    ?D                 DS
003000000000    ?D  WWCRSL                 1      2
003100000000    ?D  WWCRSN                 1      2B 0
003200000000    ? *_________________________________________________________________________
003300000000    ? *
003400000614    ? * Process Entry Panel
003500000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
003600000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
003700000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
003800000000E001?C                   Endif                                                  END COPY/CPYKEY
003900000000    ? *
004000000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004100000000    ? *
004200000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004300000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004400000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
004500000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004600000000 001? *
004700000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
004800000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
004900000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005000000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
005100000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005200000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
005300000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005400000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
005500000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
005600000000 001?C                   Endcs                                                  END CASE
005700000000 001? *
005800000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
005900000000 002?C                   Exsr      PRCEND                                       PROCESS END
006000000000E002?C                   Endif                                                  END IF END REQ
006100000000E001?C                   Enddo                                                  END DOWHILE
006200000000    ? *
006300000707    ? * Send Info Updated message.
006400000707     C     WwChg         Ifeq      'Y'
006500000707     C                   Movel     'UPDATE  '    WORTN
006600000707     C                   Endif
006700000707    ? *
006800000000    ?C                   Return                                                 RETURN
006900000000    ? *___________________________________________________________________
007000000000    ? * Prepare panel
007100000000    ? *___________________________________________________________________
007200000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007300000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007600080627    ?C                   Move      *BLANKS       RVDESC                         RETURN CODE
008000991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008100000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008200000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008300000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008400000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008500000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008600000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
008700000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
008800000000    ? *
008900000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
009000000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009100000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009200000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009300000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009400000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009500000000    ? *
009600000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
009700000000    ? *
009800000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
009900000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
010000000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
010100000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
010200000000    ?C                   Cas                     PRCERR                         PROC ERROR
010300000000    ?C                   Endcs                                                  END CASE
010400000000    ? *
010500000000    ?C                   Endsr                                                  END PRPPNL
010600000000    ? *___________________________________________________________________
010700000000    ? * Prepare ADD request
010800000000    ? *___________________________________________________________________
010900000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
011000000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
011100000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
011200000000    ?C                   Endsr                                                  END PRP ADD
011300000000    ? *___________________________________________________________________
011400000000    ? * Prepare CHANGE request
011500000000    ? *___________________________________________________________________
011600000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
011700080627    ?C                   Call      'UPDRVR  '                                   PROCESS REC IO
011800000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
011900000000    ?C                   Parm                    WWRTN                          RETURN CODE
012000000614    ?C                   Parm                    WUDTA                          REC DATA
012100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
012200000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
012300000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
012400000000X002?C                   Else                                                   ELSE
012500000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
012600000000E002?C                   Endif                                                  END RCD NOT AVL
012700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
012800000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
012900000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
013000000810E001?C                   Else                                                   END IF ERROR
014600010220E001?C                   Endif                                                  END IF ERROR
014700000000    ?C                   Endsr                                                  END PRP CHANGE
014800000000    ? *___________________________________________________________________
014900000000    ? * Prepare COPY request
015000000000    ? *___________________________________________________________________
015100000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
015200000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
015300080627    ?C                   Call      'UPDRVR  '                                   PROCESS REC IO
015400000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
015500000000    ?C                   Parm                    WWRTN                          RETURN CODE
015600000614    ?C                   Parm                    WUDTA                          REC DATA
015700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015800000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
015900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016000000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016100000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016200000000X001?C                   Else                                                   ELSE
016300000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
016400080627 001?C                   Clear                   RVCODE                         CLEAR KEY
016500080627 001?C                   Clear                   RVDESC                         CLEAR KEY
016900000000E001?C                   Endif                                                  END IF ERROR
017000000000    ?C                   Endsr                                                  END PREP COPY
017100000000    ? *___________________________________________________________________
017200000000    ? * Default Data
017300000000    ? *___________________________________________________________________
017400000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
017500080627    ?C                   Call      'CHKRVR  '                                   PROCESS REC IO
017600000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
017700000000    ?C                   Parm                    WWRTN                          RETURN CODE
017800000614    ?C                   Parm                    WUDTA                          REC DATA
017900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
018000000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
018100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
018400000000E001?C                   Endif                                                  END IF ERROR
018500000000    ?C                   Endsr                                                  END DFTDTA
018600000000    ? *___________________________________________________________________
018700000000    ? * Process ERROR function
018800000000    ? *___________________________________________________________________
018900000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
019000000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
019100000000    ?C                   Exsr      SNDMSG                                       SEND MSG
019200000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019300000000    ?C                   Move      'END'         WWSTT                          END STATE
019400000000    ?C                   Endsr                                                  END PRCERR
019500000000    ? *___________________________________________________________________
019600000000    ? * Receive messages
019700000000    ? *___________________________________________________________________
019800000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
019900000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
020000000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
020100000000X001?C                   Else                                                   ELSE
020200000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
020300000000E001?C                   Endif                                                  ENDIF NOT NORESET
020400000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
020500000000    ?C                   Movea     *IN           WWIN                           INDICATORS
020600000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
020700000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
020800000000    ?C                   Parm                    WWIN                           INDICATORS
020900000000    ?C                   Parm                    WWRTN                          RETURN CODE
021000000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
021100000000    ?C                   Endsr                                                  END RCV MSG
021200000000    ? *___________________________________________________________________
021300000000    ? * Display panels
021400000000    ? *___________________________________________________________________
021500000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
021600000000    ? *
021700000000    ? * Set PUTOVR based on last display file processed
021800000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
021900000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
022000000000 001?C                   Setoff                                       35        PUTOVR OFF
022100000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
022200000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
022300000000X001?C                   Else                                                   ELSE SAME PGM
022400000000 001?C                   Seton                                        35        PUTOVR ON
022500000000E001?C                   Endif                                                  END IF NEW PGM
022600000000    ? *
022700000614    ? * Set PROTECT key based on request
022800000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
022900000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
023000000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
023100000000 001?C                   Setoff                                       40        NO PROTECT KEY
023200000000X001?C                   Else                                                   ELSE
023300000000 001?C                   Seton                                        40        PROTECT KEY
023400000000E001?C                   Endif                                                  END IF ADD
023500000000    ? *
023600000000    ? * Select title
023700000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
023800000000 001?C                   Setoff                                       38        CHANGE TITLE
023900000000X001?C                   Else                                                   ELSE
024000000000 001?C                   Seton                                        38        ADD TITLE
024100000000E001?C                   Endif                                                  END IF CHANGE
024200000000    ? *
024300000000    ? * Position cursor based on error status
024400000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
024500000000 001?C                   Seton                                        99        POS CSR TO ERROR
024600000000X001?C                   Else                                                   ELSE
024700000000 001?C                   Setoff                                       99        POS CSR TO FIRST
024800000000E001?C                   Endif                                                  END IF ERROR
024900000000    ? *
025000000000    ? * Write message subfile
025100000000    ?C                   Seton                                        30        MSGSFL DISPLAY
025200000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
025300000000    ? *
025400000000    ? * Write entry panel
025500000000B001?C                   Select
025600000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
025700000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
025800000000 001?C                   Setoff                                       37        RESET CRSLOC
025900000000E001?C                   Endsl                                                  END SELECT
026000000000    ? *
026100000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
026200000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
026300000000E001?C                   Endif                                                  END IF DATA CHG
026400000000    ?C                   Endsr                                                  END DSPENT
026500000000    ? *___________________________________________________________________
026600000000    ? * Process function key
026700000000    ? *___________________________________________________________________
026800000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
026900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
027000991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
027100000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
027200000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
027300000000    ?C                   Parm                    WAD                            FNC DESC
027400991108    ?C                   Parm                    WWIN                           AID BYTE
027500000000    ?C                   Parm                    WAF                            FNC KEY TABLE
027600000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
027700000000    ?C                   Endsr                                                  END PRCFKY
027800000000    ? *___________________________________________________________________
027900000000    ? * Process KEYS function
028000000000    ? *___________________________________________________________________
028100000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
028200000000    ?C                   Z-add     1             WW                             KEY DSC IDX
028300000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
028400000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
028500000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
028600000000 001? *
028700000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
028800000000 002?C                   Z-add     1             WWFKS                          SET TO 1
028900000000E002?C                   Endif                                                  END IF OVER 3
029000000000 001? *
029100000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
029200000000 001?C                   Sub       1             WW                             KEY DESCR IDX
029300000000E001?C                   Enddo                                                  END DO KEYS
029400000000    ? *
029500000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
029600000000    ?C                   Add       1             WW                             BUMP IDX
029700000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
029800000000    ?C                   Endsr                                                  END PRCDKY
029900000000    ? *___________________________________________________________________
030000000000    ? * Process EXIT Function
030100000000    ? *___________________________________________________________________
030200000000    ?C     PRCEXT        Begsr                                                  RETURN
030300000000    ? *
030400000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
030500000000    ? *
030600000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
030700000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
030800000000X001?C                   Else                                                   ELSE NO ERRORS
030900000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
031000000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
031100000000E001?C                   Endif                                                  END IF ERRORS
031200000000    ?C                   Endsr                                                  END PRCEXT
031300000000    ? *___________________________________________________________________
031400000000    ? * Process PROMPT function
031500000000    ? *___________________________________________________________________
031600000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
031700000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
031800000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
031900000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
032000000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
032100000000    ? *
032200000000B001?C                   Select                                                 SELECT
032300010220    ? *
032400080627 001 C                   When      WSFLD = 'RVCODE'
032500080627 001?C***                Call      'SLCRVR  '                                   CALL SELECT PROGRAM
032600020220 001?C***                Parm                    WWRQS                          REQUEST
032700020220 001?C***                Parm                    WWRTN                          RETURN CODE
032800020220 001?C***                Parm                    WUPGM                          PROGRAM
032900020220 001?C***                Parm                    WDIGLB                         RECORD DS
033000020220B002?C***  WWRTN         Ifeq      *BLANKS                                      ENTER
033100020220 003?C***                Movel     IGITYP        IOITYP                         SET CODE
033200020220E001?C***                Else
033300080627 003?C***                Clear                   RVDESC                         SET CODE
033400020220E001?C***                Endif
033500000112 001? *
034800010516 001? *
034900000000 001?C                   Other                                                  WHERE ERROR
035000000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
035100000000 001?C                   Exsr      SNDMSG                                       SEND MSG
035200000000E001?C                   Endsl                                                  END SELECT
035300000000    ? *
035400000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
035500000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
035600000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
035700000000    ?C                   Mvr                     WSLIN                          CURSOR COL
035800000000    ?C                   Seton                                        37        SET ON CRSLOC
035900000000    ? *
036000000000    ?C                   Endsr                                                  END PRCPMT
036100000000    ? *___________________________________________________________________
036200000000    ? * Process CANCEL Function
036300000000    ? *___________________________________________________________________
036400000000    ?C     PRCCNL        Begsr                                                  CANCEL
036500000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
036600000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
036700000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
036800000000    ?C                   Endsr                                                  END RETURN
036900000000    ? *___________________________________________________________________
037000000000    ? * Process ROLLUP function
037100000000    ? *___________________________________________________________________
037200000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
037300000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
037400000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
037500000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
037600000000E001?C                   Endif                                                  END IF GT LST PNL
037700000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
037800000000    ?C                   Endsr                                                  END PRCRUP
037900000000    ? *___________________________________________________________________
038000000000    ? * Process ROLLDOWN function
038100000000    ? *___________________________________________________________________
038200000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
038300000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
038400000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
038500000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
038600000000E001?C                   Endif                                                  END IF LT FST PNL
038700000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
038800000000    ?C                   Endsr                                                  END PRCRDN
038900000000    ? *___________________________________________________________________
039000000000    ? * Process ENTER function
039100000000    ? *___________________________________________________________________
039200000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
039300000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
039400000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
039500000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
039600000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
039700000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
040000080627 001?C                   Call      'CHKRVR  '                                   CHECK DATA
040100000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
040200000000 001?C                   Parm                    WWRTN                          RETURN CODE
040300000614 001?C                   Parm                    WUDTA                          REC DATA
040400000000E001?C                   Endif                                                  ENDIF
040500000000    ? *
040600000000B001?C                   Select                                                 PRC RETURN CDE
040700000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
040800000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
040900010219 001?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
041000000000 001? *
041100000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
041200000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
041300000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
041400010219 002?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
041500000000X002?C                   Else                                                   ELSE
041600000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
041700000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
041800000000E002?C                   Endif                                                  IF WARNING
041900000000 001? *
042000000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
042100000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
042200000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
042300000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
042400000000E001?C                   Endsl                                                  RETURN CODE SEL
042500000000    ? *
042600000000    ?C                   Endsr                                                  END PRCPNL
042700000000    ? *___________________________________________________________________
042800000000    ? * Process end - write data or release record
042900000000    ? *___________________________________________________________________
043000000000    ?C     PRCEND        Begsr                                                  PROCESS END
043100000000    ? *
043200000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
043300000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
043400000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
043500000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
043600000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
043700000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
043800000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
043900000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
044000000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
044100000000 001?C                   Endcs                                                  END CASE
044200000000 001? *
044300000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
044400000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
044500000000 002? *
044600000000X002?C                   Else                                                   ELSE NO WRT ERR
044700000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
044800000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
044900000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
045000000000 004?C                   Exsr      PRPPNL                                       DO NOT END
045100000810E004?C                   Endif                                                  END IF ADD
045200000000E003?C                   Endif                                                  END IF NOT END
045300000000E002?C                   Endif                                                  END IF WRITE ERROR
045400000000 001? *
045500000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
045600000000 001?C                   Exsr      RELREC                                       RELEASE REC
045700000000E001?C                   Endif                                                  END IF RCD CHANGED
045800000000    ? *
045900000000    ?C                   Endsr                                                  END PRCEND
046000000000    ? *___________________________________________________________________
046100000000    ? * Add new record
046200000000    ? *___________________________________________________________________
046300000000    ?C     WRTADD        Begsr                                                  WRITE ADD
046400000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
046500000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
046600000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
046700000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
046800000000E001?C                   Endif                                                  END IF ADD
046900000000    ? *
047000000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
047100000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
047200000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
047300000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
047400000000E001?C                   Endif                                                  END IF ADD KEY
047500000000    ? *
047600080627    ?C                   Call      'UPDRVR  '                                   PROCESS REC IO
047700000000    ?C                   Parm                    WWRQS                          ADD RECORD
047800000000    ?C                   Parm                    WWRTN                          RETURN CODE
047900000614    ?C                   Parm                    WUDTA                          REC DATA
048000000000    ? *
048100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
048200000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
048300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
048400000000X001?C                   Else                                                   ELSE
048500000000E001?C                   Endif                                                  END IF CALL ERROR
048600000000    ? *
048700000000    ?C                   Endsr                                                  END WRTADD
048800000000    ? *___________________________________________________________________
048900000000    ? * Write changed record
049000000000    ? *___________________________________________________________________
049100000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
049200080627    ?C                   Call      'UPDRVR  '                                   PROCESS REC IO
049300000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
049400000000    ?C                   Parm                    WWRTN                          RETURN CODE
049500000614    ?C                   Parm                    WUDTA                          REC DATA
049600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
049700000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
049800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
049900000000E001?C                   Endif                                                  END IF CALL ERROR
050000000000    ? *
050100000000    ?C                   Endsr                                                  END WRTCHG
050200000000    ? *___________________________________________________________________
050300000000    ? * Release record
050400000000    ? *___________________________________________________________________
050500000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
050600080627    ?C                   Call      'UPDRVR  '                                   PROCESS REC IO
050700000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
050800000000    ?C                   Parm                    WWRTN                          RETURN CODE
050900000614    ?C                   Parm                    WUDTA                          REC DATA
051000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
051100000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
051200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
051300000000E001?C                   Endif                                                  END IF CALL ERROR
051400000000    ?C                   Endsr                                                  END RELREC
051500000000    ? *___________________________________________________________________
051600000000    ? * Build function keys
051700000000    ? *___________________________________________________________________
051800000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
051900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
052000991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
052100000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
052200000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
052300000000    ?C                   Parm                    WAD                            FNC DESC
052400991108    ?C                   Parm                    WWIN                           AID BYTE
052500000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
052600000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
052700000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
052800000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
052900000000    ?C                   Sub       1             WW                             BUMP IDX
053000000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
053100000000    ?C                   Endsr                                                  END BLD FNCTNS
053200000000    ? *___________________________________________________________________
053300000000    ? * Send message
053400000000    ? *___________________________________________________________________
053500000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
053600000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
053700000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
053800000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
053900000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
054000000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
054100000000    ?C                   Endsr                                                  END SNDMSG
054200000000    ? *___________________________________________________________________
054300000000    ? * Paremater list
054400000000    ? *___________________________________________________________________
054500000000    ?C     PLIST         Begsr                                                  PARM LISTS
054600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
054700000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
054800000000    ?C                   Parm                    WORTN             8            RETURN CODE
054900000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
055000000614    ?C                   Parm                    WUDTA                          RECORD KEY
055100000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
055200000000    ?C                   Endsr                                                  END PLIST
055300000000    ? *___________________________________________________________________
055400000000    ? * Initialize routine
055500000000    ? *___________________________________________________________________
055600000000    ?C     *INZSR        Begsr                                                  INITIALIZE
055700000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
055800000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
055900000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
056000000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
056100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
056200000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
056300000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
056400000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
056500000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
056600000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
056700000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
056800000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
056900000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
057000000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
057100000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
057200000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
057300000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
057400000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
057500000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
057600000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
057700000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
057800000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
057900000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
058000000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
058100000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
058200080627    ?C                   Movel     'RVRCOD  '    WWFIL            10            FILE NAME-NOTES
058300000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
058400000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
058500010220    ? *
059400000000    ?C                   Endsr                                                  END INITIALIZE
059500000000    ? *___________________________________________________________________
059600000000    ? * Program error handler
059700000000    ? *___________________________________________________________________
059800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
059900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
060000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
060100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
060200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
060300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
060400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
060500000000    ? *___________________________________________________________________
060600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06070000000003EXIT    F3=Exit
06080000000004PROMPT  F4=Prompt
06090000000005REFRESH F5=Refresh
06100000070710UPDATE  F10=Update
06110000061412CANCEL  F12=Cancel
06120000000025ROLLUP
06130000000026ROLLDOWN
061400000000** WTM
06150008062700Request not supported in program CHGRVR.
06160000000000Update error.  Data was not updated.
06170000000000Duplicate key detected.  Data was NOT added to file.
06180000000000Call to notes ended in error.
06190000000000Initialize error.  Record not initialized.
06200000000000Record not found.
06210000000000Generate error.  Key not generated.
06220000000000Record not available now.
06230000000000The cursor is not in a prompt area.
06240000000000Default error.  Data not defaulted.
