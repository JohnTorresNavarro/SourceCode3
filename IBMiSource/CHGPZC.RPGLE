000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300020227    ? *  Description:  Change ISC Print Zero Commissions
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700020227    ?FCHGPZCD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900020227     FCARMST    IF   E           K DISK
001000000000    ? *
001100000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001300000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001400000000    ? *_________________________________________________________________________
001500000406    ? * Data structure
001600020227    ?D WUDTA         E DS                  EXTNAME(ISCPZC)
001700000000    ? *
001800000000    ? * Program status data structure
001900991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002000000000    ? *
002100000000    ? * Display file data structure
002200991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002300000000    ? *
002400000000    ? * CURSOR LOCATION
002500000000    ?D                 DS
002600000000    ?D  WWCRSL                 1      2
002700000000    ?D  WWCRSN                 1      2B 0
002800000000    ? *_________________________________________________________________________
002900000000    ? *
003000000614    ? * Process Entry Panel
003100000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
003200000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
003300000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
003400000000E001?C                   Endif                                                  END COPY/CPYKEY
003500000000    ? *
003600000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
003700000000    ? *
003800000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
003900000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004000000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
004100000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004200000000 001? *
004300000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
004400000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
004500000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
004600000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
004700000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
004800000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
004900000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005000000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
005100000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
005200000000 001?C                   Endcs                                                  END CASE
005300000000 001? *
005400000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
005500000000 002?C                   Exsr      PRCEND                                       PROCESS END
005600000000E002?C                   Endif                                                  END IF END REQ
005700000000E001?C                   Enddo                                                  END DOWHILE
005800000000    ? *
005900000707    ? * Send Info Updated message.
006000000707     C     WwChg         Ifeq      'Y'
006100000707     C                   Movel     'UPDATE  '    WORTN
006200000707     C                   Endif
006300000707    ? *
006400000000    ?C                   Return                                                 RETURN
006500000000    ? *___________________________________________________________________
006600000000    ? * Prepare panel
006700000000    ? *___________________________________________________________________
006800000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
006900000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007000991108    ?C                   Move      'N'           WWERR                          NO ERRORS
007100000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
007200000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
007300000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007400000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
007500000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
007600000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
007700000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
007800000000    ? *
007900000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
008000000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
008100000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
008200000000E002?C                   Endif                                                  ENDIF SAME REQUEST
008300000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
008400000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
008500000000    ? *
008600000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
008700000000    ? *
008800000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
008900000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
009000000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
009100000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
009200000000    ?C                   Cas                     PRCERR                         PROC ERROR
009300000000    ?C                   Endcs                                                  END CASE
009400000000    ? *
009500000000    ?C                   Endsr                                                  END PRPPNL
009600000000    ? *___________________________________________________________________
009700000000    ? * Prepare ADD request
009800000000    ? *___________________________________________________________________
009900000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
010000000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
010100000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
010200000000    ?C                   Endsr                                                  END PRP ADD
010300000000    ? *___________________________________________________________________
010400000000    ? * Prepare CHANGE request
010500000000    ? *___________________________________________________________________
010600000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
010700020227    ?C                   Call      'UPDPZC  '                                   PROCESS REC IO
010800000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
010900000000    ?C                   Parm                    WWRTN                          RETURN CODE
011000000614    ?C                   Parm                    WUDTA                          REC DATA
011100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
011200000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
011300000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
011400000000X002?C                   Else                                                   ELSE
011500000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
011600000000E002?C                   Endif                                                  END RCD NOT AVL
011700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
011800000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
011900000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
012000000810E001?C                   Else                                                   END IF ERROR
012100020227     C     IZCAR         Chain     CARMST
012200020227     C                   if        %Found
012300020227     C                   Eval      wsdesc = cname
012400020227     C                   Else
012500020227     C                   Eval      wsdesc = *blanks
012600020227     C                   End
012700000810E001?C                   Endif                                                  END IF ERROR
012800000000    ?C                   Endsr                                                  END PRP CHANGE
012900000000    ? *___________________________________________________________________
013000000000    ? * Prepare COPY request
013100000000    ? *___________________________________________________________________
013200000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
013300000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
013400020227    ?C                   Call      'UPDPZC  '                                   PROCESS REC IO
013500000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
013600000000    ?C                   Parm                    WWRTN                          RETURN CODE
013700000614    ?C                   Parm                    WUDTA                          REC DATA
013800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
013900000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014200000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
014300000000X001?C                   Else                                                   ELSE
014400000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
014500020227 001?C                   Clear                   IZCAR                          CLEAR KEY
014600000000E001?C                   Endif                                                  END IF ERROR
014700000000    ?C                   Endsr                                                  END PREP COPY
014800000000    ? *___________________________________________________________________
014900000000    ? * Default Data
015000000000    ? *___________________________________________________________________
015100000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
015200020227    ?C                   Call      'CHKPZC  '                                   PROCESS REC IO
015300000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
015400000000    ?C                   Parm                    WWRTN                          RETURN CODE
015500000614    ?C                   Parm                    WUDTA                          REC DATA
015600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015700000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
015800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
015900000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016000000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016100000000E001?C                   Endif                                                  END IF ERROR
016200000000    ?C                   Endsr                                                  END DFTDTA
016300000000    ? *___________________________________________________________________
016400000000    ? * Process ERROR function
016500000000    ? *___________________________________________________________________
016600000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
016700000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
016800000000    ?C                   Exsr      SNDMSG                                       SEND MSG
016900000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017000000000    ?C                   Move      'END'         WWSTT                          END STATE
017100000000    ?C                   Endsr                                                  END PRCERR
017200000000    ? *___________________________________________________________________
017300000000    ? * Receive messages
017400000000    ? *___________________________________________________________________
017500000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
017600000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
017700000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
017800000000X001?C                   Else                                                   ELSE
017900000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
018000000000E001?C                   Endif                                                  ENDIF NOT NORESET
018100000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
018200000000    ?C                   Movea     *IN           WWIN                           INDICATORS
018300000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
018400000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
018500000000    ?C                   Parm                    WWIN                           INDICATORS
018600000000    ?C                   Parm                    WWRTN                          RETURN CODE
018700000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
018800000000    ?C                   Endsr                                                  END RCV MSG
018900000000    ? *___________________________________________________________________
019000000000    ? * Display panels
019100000000    ? *___________________________________________________________________
019200000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
019300000000    ? *
019400000000    ? * Set PUTOVR based on last display file processed
019500000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
019600000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
019700000000 001?C                   Setoff                                       35        PUTOVR OFF
019800000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
019900000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
020000000000X001?C                   Else                                                   ELSE SAME PGM
020100000000 001?C                   Seton                                        35        PUTOVR ON
020200000000E001?C                   Endif                                                  END IF NEW PGM
020300000000    ? *
020400000614    ? * Set PROTECT key based on request
020500000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
020600000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
020700000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
020800000000 001?C                   Setoff                                       40        NO PROTECT KEY
020900000000X001?C                   Else                                                   ELSE
021000000000 001?C                   Seton                                        40        PROTECT KEY
021100000000E001?C                   Endif                                                  END IF ADD
021200000000    ? *
021300000000    ? * Select title
021400000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
021500000000 001?C                   Setoff                                       38        CHANGE TITLE
021600000000X001?C                   Else                                                   ELSE
021700000000 001?C                   Seton                                        38        ADD TITLE
021800000000E001?C                   Endif                                                  END IF CHANGE
021900000000    ? *
022000000000    ? * Position cursor based on error status
022100000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
022200000000 001?C                   Seton                                        99        POS CSR TO ERROR
022300000000X001?C                   Else                                                   ELSE
022400000000 001?C                   Setoff                                       99        POS CSR TO FIRST
022500000000E001?C                   Endif                                                  END IF ERROR
022600000000    ? *
022700000000    ? * Write message subfile
022800000000    ?C                   Seton                                        30        MSGSFL DISPLAY
022900000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
023000000000    ? *
023100000000    ? * Write entry panel
023200000000B001?C                   Select
023300000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
023400000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
023500000000 001?C                   Setoff                                       37        RESET CRSLOC
023600000000E001?C                   Endsl                                                  END SELECT
023700000000    ? *
023800000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
023900000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
024000000000E001?C                   Endif                                                  END IF DATA CHG
024100000000    ?C                   Endsr                                                  END DSPENT
024200000000    ? *___________________________________________________________________
024300000000    ? * Process function key
024400000000    ? *___________________________________________________________________
024500000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
024600991108    ?C                   Movea     *IN           WWIN                           INDICATORS
024700991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
024800000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
024900000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
025000000000    ?C                   Parm                    WAD                            FNC DESC
025100991108    ?C                   Parm                    WWIN                           AID BYTE
025200000000    ?C                   Parm                    WAF                            FNC KEY TABLE
025300000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
025400000000    ?C                   Endsr                                                  END PRCFKY
025500000000    ? *___________________________________________________________________
025600000000    ? * Process KEYS function
025700000000    ? *___________________________________________________________________
025800000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
025900000000    ?C                   Z-add     1             WW                             KEY DSC IDX
026000000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
026100000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
026200000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
026300000000 001? *
026400000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
026500000000 002?C                   Z-add     1             WWFKS                          SET TO 1
026600000000E002?C                   Endif                                                  END IF OVER 3
026700000000 001? *
026800000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
026900000000 001?C                   Sub       1             WW                             KEY DESCR IDX
027000000000E001?C                   Enddo                                                  END DO KEYS
027100000000    ? *
027200000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
027300000000    ?C                   Add       1             WW                             BUMP IDX
027400000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
027500000000    ?C                   Endsr                                                  END PRCDKY
027600000000    ? *___________________________________________________________________
027700000000    ? * Process EXIT Function
027800000000    ? *___________________________________________________________________
027900000000    ?C     PRCEXT        Begsr                                                  RETURN
028000000000    ? *
028100000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
028200000000    ? *
028300000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
028400000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
028500000000X001?C                   Else                                                   ELSE NO ERRORS
028600000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
028700000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
028800000000E001?C                   Endif                                                  END IF ERRORS
028900000000    ?C                   Endsr                                                  END PRCEXT
029000000000    ? *___________________________________________________________________
029100000000    ? * Process PROMPT function
029200000000    ? *___________________________________________________________________
029300000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
029400000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
029500000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
029600000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
029700000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
029800000000    ? *
029900000000B001?C                   Select                                                 SELECT
030000000112 001? *
030100000000 001?C                   Other                                                  WHERE ERROR
030200000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
030300000000 001?C                   Exsr      SNDMSG                                       SEND MSG
030400000000E001?C                   Endsl                                                  END SELECT
030500000000    ? *
030600000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
030700000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
030800000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
030900000000    ?C                   Mvr                     WSLIN                          CURSOR COL
031000000000    ?C                   Seton                                        37        SET ON CRSLOC
031100000000    ? *
031200000000    ?C                   Endsr                                                  END PRCPMT
031300000000    ? *___________________________________________________________________
031400000000    ? * Process CANCEL Function
031500000000    ? *___________________________________________________________________
031600000000    ?C     PRCCNL        Begsr                                                  CANCEL
031700000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
031800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
031900000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
032000000000    ?C                   Endsr                                                  END RETURN
032100000000    ? *___________________________________________________________________
032200000000    ? * Process ROLLUP function
032300000000    ? *___________________________________________________________________
032400000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
032500000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
032600000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
032700000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
032800000000E001?C                   Endif                                                  END IF GT LST PNL
032900000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
033000000000    ?C                   Endsr                                                  END PRCRUP
033100000000    ? *___________________________________________________________________
033200000000    ? * Process ROLLDOWN function
033300000000    ? *___________________________________________________________________
033400000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
033500000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
033600000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
033700000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
033800000000E001?C                   Endif                                                  END IF LT FST PNL
033900000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
034000000000    ?C                   Endsr                                                  END PRCRDN
034100000000    ? *___________________________________________________________________
034200000000    ? * Process ENTER function
034300000000    ? *___________________________________________________________________
034400000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
034500000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
034600000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
034700000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
034800000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
034900000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
035000020227 001?C                   Call      'CHKPZC  '                                   CHECK DATA
035100000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
035200000000 001?C                   Parm                    WWRTN                          RETURN CODE
035300000614 001?C                   Parm                    WUDTA                          REC DATA
035400000000E001?C                   Endif                                                  ENDIF
035500000000    ? *
035600000000B001?C                   Select                                                 PRC RETURN CDE
035700000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
035800000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
035900010219 001?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
036000000000 001? *
036100000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
036200000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
036300000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
036400010219 002?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
036500000000X002?C                   Else                                                   ELSE
036600000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
036700000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
036800000000E002?C                   Endif                                                  IF WARNING
036900000000 001? *
037000000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
037100000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
037200000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
037300000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
037400000000E001?C                   Endsl                                                  RETURN CODE SEL
037500000000    ? *
037600000000    ?C                   Endsr                                                  END PRCPNL
037700000000    ? *___________________________________________________________________
037800000000    ? * Process end - write data or release record
037900000000    ? *___________________________________________________________________
038000000000    ?C     PRCEND        Begsr                                                  PROCESS END
038100000000    ? *
038200000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
038300000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
038400000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
038500000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
038600000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
038700000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
038800000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
038900000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
039000000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
039100000000 001?C                   Endcs                                                  END CASE
039200000000 001? *
039300000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
039400000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
039500000000 002? *
039600000000X002?C                   Else                                                   ELSE NO WRT ERR
039700000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
039800000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
039900000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
040000000000 004?C                   Exsr      PRPPNL                                       DO NOT END
040100000810E004?C                   Endif                                                  END IF ADD
040200000000E003?C                   Endif                                                  END IF NOT END
040300000000E002?C                   Endif                                                  END IF WRITE ERROR
040400000000 001? *
040500000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
040600000000 001?C                   Exsr      RELREC                                       RELEASE REC
040700000000E001?C                   Endif                                                  END IF RCD CHANGED
040800000000    ? *
040900000000    ?C                   Endsr                                                  END PRCEND
041000000000    ? *___________________________________________________________________
041100000000    ? * Add new record
041200000000    ? *___________________________________________________________________
041300000000    ?C     WRTADD        Begsr                                                  WRITE ADD
041400000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
041500000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
041600000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
041700000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
041800000000E001?C                   Endif                                                  END IF ADD
041900000000    ? *
042000000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
042100000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
042200000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
042300000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
042400000000E001?C                   Endif                                                  END IF ADD KEY
042500000000    ? *
042600020227    ?C                   Call      'UPDPZC  '                                   PROCESS REC IO
042700000000    ?C                   Parm                    WWRQS                          ADD RECORD
042800000000    ?C                   Parm                    WWRTN                          RETURN CODE
042900000614    ?C                   Parm                    WUDTA                          REC DATA
043000000000    ? *
043100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
043200000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
043300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
043400000000X001?C                   Else                                                   ELSE
043500000000E001?C                   Endif                                                  END IF CALL ERROR
043600000000    ? *
043700000000    ?C                   Endsr                                                  END WRTADD
043800000000    ? *___________________________________________________________________
043900000000    ? * Write changed record
044000000000    ? *___________________________________________________________________
044100000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
044200020227    ?C                   Call      'UPDPZC  '                                   PROCESS REC IO
044300000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
044400000000    ?C                   Parm                    WWRTN                          RETURN CODE
044500000614    ?C                   Parm                    WUDTA                          REC DATA
044600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
044700000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
044800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
044900000000E001?C                   Endif                                                  END IF CALL ERROR
045000000000    ? *
045100000000    ?C                   Endsr                                                  END WRTCHG
045200000000    ? *___________________________________________________________________
045300000000    ? * Release record
045400000000    ? *___________________________________________________________________
045500000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
045600020227    ?C                   Call      'UPDPZC  '                                   PROCESS REC IO
045700000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
045800000000    ?C                   Parm                    WWRTN                          RETURN CODE
045900000614    ?C                   Parm                    WUDTA                          REC DATA
046000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
046100000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
046200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
046300000000E001?C                   Endif                                                  END IF CALL ERROR
046400000000    ?C                   Endsr                                                  END RELREC
046500000000    ? *___________________________________________________________________
046600000000    ? * Build function keys
046700000000    ? *___________________________________________________________________
046800000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
046900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
047000991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
047100000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
047200000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
047300000000    ?C                   Parm                    WAD                            FNC DESC
047400991108    ?C                   Parm                    WWIN                           AID BYTE
047500000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
047600000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
047700000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
047800000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
047900000000    ?C                   Sub       1             WW                             BUMP IDX
048000000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
048100000000    ?C                   Endsr                                                  END BLD FNCTNS
048200000000    ? *___________________________________________________________________
048300000000    ? * Send message
048400000000    ? *___________________________________________________________________
048500000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
048600000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
048700000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
048800000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
048900000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
049000000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
049100000000    ?C                   Endsr                                                  END SNDMSG
049200000000    ? *___________________________________________________________________
049300000000    ? * Paremater list
049400000000    ? *___________________________________________________________________
049500000000    ?C     PLIST         Begsr                                                  PARM LISTS
049600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
049700000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
049800000000    ?C                   Parm                    WORTN             8            RETURN CODE
049900000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
050000000614    ?C                   Parm                    WUDTA                          RECORD KEY
050100000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
050200000000    ?C                   Endsr                                                  END PLIST
050300000000    ? *___________________________________________________________________
050400000000    ? * Initialize routine
050500000000    ? *___________________________________________________________________
050600000000    ?C     *INZSR        Begsr                                                  INITIALIZE
050700000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
050800000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
050900000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
051000000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
051100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
051200000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
051300000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
051400000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
051500000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
051600000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
051700000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
051800000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
051900000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
052000000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
052100000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
052200000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
052300000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
052400000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
052500000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
052600000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
052700000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
052800000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
052900000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
053000000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
053100000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
053200020227    ?C                   Movel     'ISCPZC  '    WWFIL            10            FILE NAME-NOTES
053300000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
053400000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
053500000000    ?C                   Endsr                                                  END INITIALIZE
053600000000    ? *___________________________________________________________________
053700000000    ? * Program error handler
053800000000    ? *___________________________________________________________________
053900000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
054000000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
054100000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
054200000000    ?C                   Parm                    WQSTSC                         STATUS CODE
054300000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
054400000000    ?C                   Parm                    WQMSG                          MESSAGE ID
054500000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
054600000000    ? *___________________________________________________________________
054700000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05480000000003EXIT    F3=Exit
05490000000004PROMPT  F4=Prompt
05500000000005REFRESH F5=Refresh
05510000070710UPDATE  F10=Update
05520000061412CANCEL  F12=Cancel
05530000000025ROLLUP
05540000000026ROLLDOWN
055500000000** WTM
05560002022700Request not supported in program CHGPZC.
05570000000000Update error.  Data was not updated.
05580000000000Duplicate key detected.  Data was NOT added to file.
05590000000000Call to notes ended in error.
05600000000000Initialize error.  Record not initialized.
05610000000000Record not found.
05620000000000Generate error.  Key not generated.
05630000000000Record not available now.
05640000000000The cursor is not in a prompt area.
05650000000000Default error.  Data not defaulted.
