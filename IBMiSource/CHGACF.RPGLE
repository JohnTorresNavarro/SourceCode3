000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300090319    ? *  Description:  Change ACH Supplemental Data from Finance Menu
000400000000    ? *
000500090224    ? *  (c)Copyright 2009 by GBS,Inc.
000501051028    ? *
000611051028    ? *_________________________________________________________________________
000700090319    ?FCHGACFD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900090224    ?FACCACH    If   E           k Disk
000901050318     FACCMST    IF   E           K Disk
001000000000    ? *
001100000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001300000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001400000000    ? *_________________________________________________________________________
001500000406    ? * Data structure
001600090224    ?D WUDTA         E DS                  EXTNAME(ACCACH)
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
002701090309     D HstTracker      DS
002702090309     D  Rout                   1      1
002703090309     D  Act#                   2      2
002704090309     D  CSF                    3      3
002705090309     D  PreN                   4      4
002706090309     D  EndDt                  5      5
002707090309     D  SaveField              5     64
002708090309     D   SaveRout              6     20
002709090611     D   SaveAct#             21     38
002710090611     D   SaveCSF              39     55
002711090611     D   SavePreN             56     70
002712090611     D   SaveEndDt            71     85
002713090309    ? *
002714090224     D WWTRST          S                   LIKE(AHTRST)
002715090224     D WWSUB#          S                   LIKE(AHSUB#)
002716090224     D WWACCT          S                   LIKE(AHACCT)
002800000000    ? *_________________________________________________________________________
002900000000    ? *
002901090224     C                   Eval      SVBEDT   =    AHBEDT
002902090224     C                   Eval      SVENDT   =    AHENDT
002903090224     C                   Eval      SVROUT   =    AHROUT
002904090224     C                   Eval      SVACT#   =    AHACT#
002905090224     C                   Eval      SVCSFL   =    AHCSFL
002906090304     C                   Eval      SVPREN   =    AHPREN
002907070614     C     SVBEDT        MULT      10000.0001    SVBEDT
002910070614     C     SVENDT        MULT      10000.0001    SVENDT
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
007000050317    ?C                   Move      *ZEROS        WSBEDT                         RETURN CODE
007100050317    ?C                   Move      *ZEROS        WSENDT                         RETURN CODE
007200991108    ?C                   Move      'N'           WWERR                          NO ERRORS
007300000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
007400000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
007500000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007600000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
007700000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
007800000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
007900000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
008000000000    ? *
008100000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
008200000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
008300000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
008400000000E002?C                   Endif                                                  ENDIF SAME REQUEST
008500000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
008600000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
008601050318      *
008602090224     C                   Eval      WWTRST = AHTRST
008603090224     C                   Eval      WWSUB# = AHSUB#
008604090224     C                   Eval      WWACCT = AHACCT
008605090224     C                   Movel     AHTRST        Trst              3
008606090224     C                   Movel     AHSUB#        Sub#              3
008607090224     C                   Movel     AHACCT        Acct              4
008608090224     C     AKey          Chain     ACCMST
008609050318     C                   If        %Found(ACCMST)
008610050318     C                   Eval      WWNAME  = %trim(Trst) + '-'   +
008611050318     C                                       %trim(Sub#) + '-'   +
008612050318     C                                       %trim(Acct) + '  '  +
008613050318     C                                       %trim(ACNAM1)
008614050318     C                   Movel(P)  WWNAME        WISTR
008615051028     C                   Z-add     60            WILEN
008616050318     C                   Call      'UTLCENSTR'
008617050318     C                   Parm                    WISTR           256
008618050318     C                   Parm                    WILEN             3 0
008619050318     C                   Movel     WISTR         WWNAME
008620050318     C                   End
008700000000    ? *
008800000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
008900000000    ? *
009000000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
009100000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
009200000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
009300000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
009400000000    ?C                   Cas                     PRCERR                         PROC ERROR
009500000000    ?C                   Endcs                                                  END CASE
009600000000    ? *
009700000000    ?C                   Endsr                                                  END PRPPNL
009800000000    ? *___________________________________________________________________
009900000000    ? * Prepare ADD request
010000000000    ? *___________________________________________________________________
010100000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
010200090224    ?C                   Clear                   AHBEDT                         CLEAR RECORD
010300090224    ?C                   Clear                   AHENDT                         CLEAR RECORD
010500090224    ?C                   Clear                   AHCHDT                         CLEAR RECORD
010600090224    ?C                   Clear                   AHCHGU                         CLEAR RECORD
010601090224    ?C                   Clear                   AHROUT                         CLEAR RECORD
010602090224    ?C                   Clear                   AHACT#                         CLEAR RECORD
010603090224    ?C                   Clear                   AHCSFL                         CLEAR RECORD
010604090304    ?C                   Clear                   AHPREN                         CLEAR RECORD
010700000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
010800000000    ?C                   Endsr                                                  END PRP ADD
010900000000    ? *___________________________________________________________________
011000000000    ? * Prepare CHANGE request
011100000000    ? *___________________________________________________________________
011200000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
011300090319    ?C                   Call      'UPDACF  '                                   PROCESS REC IO
011400000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
011500000000    ?C                   Parm                    WWRTN                          RETURN CODE
011600000614    ?C                   Parm                    WUDTA                          REC DATA
011601090309    ?C                   Parm                    Whist            80            DATA
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
012700090224     C     AHBEDT        MULT      10000.0001    WSBEDT
012800090224     C     AHENDT        MULT      10000.0001    WSENDT
012900000810E001?C                   Endif                                                  END IF ERROR
013000000000    ?C                   Endsr                                                  END PRP CHANGE
013100000000    ? *___________________________________________________________________
013200000000    ? * Prepare COPY request
013300000000    ? *___________________________________________________________________
013400000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
013500000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
013600090319    ?C                   Call      'UPDACF  '                                   PROCESS REC IO
013700000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
013800000000    ?C                   Parm                    WWRTN                          RETURN CODE
013900000614    ?C                   Parm                    WUDTA                          REC DATA
013901090309    ?C                   Parm                    Whist                          DATA
014000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014100000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
014500000000X001?C                   Else                                                   ELSE
014600000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
014700090224     C     AHBEDT        MULT      10000.0001    WSBEDT
014800090224     C     AHENDT        MULT      10000.0001    WSENDT
014900000000E001?C                   Endif                                                  END IF ERROR
015000000000    ?C                   Endsr                                                  END PREP COPY
015100000000    ? *___________________________________________________________________
015200000000    ? * Default Data
015300000000    ? *___________________________________________________________________
015400000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
015500090319    ?C                   Call      'CHKACF  '                                   PROCESS REC IO
015600000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
015700000000    ?C                   Parm                    WWRTN                          RETURN CODE
015800000614    ?C                   Parm                    WUDTA                          REC DATA
015900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016000000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
016100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016400000000E001?C                   Endif                                                  END IF ERROR
016500000000    ?C                   Endsr                                                  END DFTDTA
016600000000    ? *___________________________________________________________________
016700000000    ? * Process ERROR function
016800000000    ? *___________________________________________________________________
016900000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
017000000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
017100000000    ?C                   Exsr      SNDMSG                                       SEND MSG
017200000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017300000000    ?C                   Move      'END'         WWSTT                          END STATE
017400000000    ?C                   Endsr                                                  END PRCERR
017500000000    ? *___________________________________________________________________
017600000000    ? * Receive messages
017700000000    ? *___________________________________________________________________
017800000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
017900000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
018000000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
018100000000X001?C                   Else                                                   ELSE
018200000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
018300000000E001?C                   Endif                                                  ENDIF NOT NORESET
018400000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
018500000000    ?C                   Movea     *IN           WWIN                           INDICATORS
018600000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
018700000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
018800000000    ?C                   Parm                    WWIN                           INDICATORS
018900000000    ?C                   Parm                    WWRTN                          RETURN CODE
019000000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
019100000000    ?C                   Endsr                                                  END RCV MSG
019200000000    ? *___________________________________________________________________
019300000000    ? * Display panels
019400000000    ? *___________________________________________________________________
019500000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
019600000000    ? *
019700000000    ? * Set PUTOVR based on last display file processed
019800000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
019900000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
020000000000 001?C                   Setoff                                       35        PUTOVR OFF
020100000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
020200000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
020300000000X001?C                   Else                                                   ELSE SAME PGM
020400000000 001?C                   Seton                                        35        PUTOVR ON
020500000000E001?C                   Endif                                                  END IF NEW PGM
020600000000    ? *
020700000614    ? * Set PROTECT key based on request
020800000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
020900000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
021000000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
021100000000 001?C                   Setoff                                       40        NO PROTECT KEY
021200000000X001?C                   Else                                                   ELSE
021300000000 001?C                   Seton                                        40        PROTECT KEY
021400000000E001?C                   Endif                                                  END IF ADD
021500000000    ? *
021600000000    ? * Select title
021700000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
021800000000 001?C                   Setoff                                       38        CHANGE TITLE
021900000000X001?C                   Else                                                   ELSE
022000000000 001?C                   Seton                                        38        ADD TITLE
022100000000E001?C                   Endif                                                  END IF CHANGE
022200000000    ? *
022300000000    ? * Position cursor based on error status
022400000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
022500000000 001?C                   Seton                                        99        POS CSR TO ERROR
022600000000X001?C                   Else                                                   ELSE
022700000000 001?C                   Setoff                                       99        POS CSR TO FIRST
022800000000E001?C                   Endif                                                  END IF ERROR
022900000000    ? *
023000000000    ? * Write message subfile
023100000000    ?C                   Seton                                        30        MSGSFL DISPLAY
023200000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
023300000000    ? *
023400000000    ? * Write entry panel
023500000000B001?C                   Select
023600000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
023700000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
023800000000 001?C                   Setoff                                       37        RESET CRSLOC
023900000000E001?C                   Endsl                                                  END SELECT
024000000000    ? *
024100000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
024200000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
024300000000E001?C                   Endif                                                  END IF DATA CHG
024400000000    ?C                   Endsr                                                  END DSPENT
024500000000    ? *___________________________________________________________________
024600000000    ? * Process function key
024700000000    ? *___________________________________________________________________
024800000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
024900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
025000991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
025100000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
025200000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
025300000000    ?C                   Parm                    WAD                            FNC DESC
025400991108    ?C                   Parm                    WWIN                           AID BYTE
025500000000    ?C                   Parm                    WAF                            FNC KEY TABLE
025600000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
025700000000    ?C                   Endsr                                                  END PRCFKY
025800000000    ? *___________________________________________________________________
025900000000    ? * Process KEYS function
026000000000    ? *___________________________________________________________________
026100000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
026200000000    ?C                   Z-add     1             WW                             KEY DSC IDX
026300000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
026400000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
026500000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
026600000000 001? *
026700000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
026800000000 002?C                   Z-add     1             WWFKS                          SET TO 1
026900000000E002?C                   Endif                                                  END IF OVER 3
027000000000 001? *
027100000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
027200000000 001?C                   Sub       1             WW                             KEY DESCR IDX
027300000000E001?C                   Enddo                                                  END DO KEYS
027400000000    ? *
027500000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
027600000000    ?C                   Add       1             WW                             BUMP IDX
027700000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
027800000000    ?C                   Endsr                                                  END PRCDKY
027900000000    ? *___________________________________________________________________
028000000000    ? * Process EXIT Function
028100000000    ? *___________________________________________________________________
028200000000    ?C     PRCEXT        Begsr                                                  RETURN
028300000000    ? *
028400000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
028500000000    ? *
028600000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
028700000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
028800000000X001?C                   Else                                                   ELSE NO ERRORS
028900000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
029000000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
029100000000E001?C                   Endif                                                  END IF ERRORS
029200000000    ?C                   Endsr                                                  END PRCEXT
029300000000    ? *___________________________________________________________________
029400000000    ? * Process PROMPT function
029500000000    ? *___________________________________________________________________
029600000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
029700000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
029800000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
029900000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
030000000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
030100000000    ? *
030200000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
030300000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
030400000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
030500000000    ?C                   Mvr                     WSLIN                          CURSOR COL
030600000000    ?C                   Seton                                        37        SET ON CRSLOC
030700000000    ? *
030800000000    ?C                   Endsr                                                  END PRCPMT
030900000000    ? *___________________________________________________________________
031000000000    ? * Process CANCEL Function
031100000000    ? *___________________________________________________________________
031200000000    ?C     PRCCNL        Begsr                                                  CANCEL
031300000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
031400000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
031500000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
031600000000    ?C                   Endsr                                                  END RETURN
031700000000    ? *___________________________________________________________________
031800000000    ? * Process ROLLUP function
031900000000    ? *___________________________________________________________________
032000000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
032100000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
032200000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
032300000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
032400000000E001?C                   Endif                                                  END IF GT LST PNL
032500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
032600000000    ?C                   Endsr                                                  END PRCRUP
032700000000    ? *___________________________________________________________________
032800000000    ? * Process ROLLDOWN function
032900000000    ? *___________________________________________________________________
033000000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
033100000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
033200000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
033300000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
033400000000E001?C                   Endif                                                  END IF LT FST PNL
033500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
033600000000    ?C                   Endsr                                                  END PRCRDN
033700000000    ? *___________________________________________________________________
033800000000    ? * Process ENTER function
033900000000    ? *___________________________________________________________________
034000000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
034100000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
034200000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
034300000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
034400000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
034500000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
034600090224     C                   Z-add     WSBEDT        AHBEDT
034700090224     C                   Z-add     WSENDT        AHENDT
034800090319 001?C                   Call      'CHKACF  '                                   CHECK DATA
034900000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
035000000000 001?C                   Parm                    WWRTN                          RETURN CODE
035100000614 001?C                   Parm                    WUDTA                          REC DATA
035200000000E001?C                   Endif                                                  ENDIF
035300000000    ? *
035400000000B001?C                   Select                                                 PRC RETURN CDE
035500000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
035600000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
035700000000 001? *
035800000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
035900000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
036000000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
036100000000X002?C                   Else                                                   ELSE
036200000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
036300000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
036400000000E002?C                   Endif                                                  IF WARNING
036500000000 001? *
036600000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
036700000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
036800000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
036900000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
037000000000E001?C                   Endsl                                                  RETURN CODE SEL
037100000000    ? *
037200000000    ?C                   Endsr                                                  END PRCPNL
037300000000    ? *___________________________________________________________________
037400000000    ? * Process end - write data or release record
037500000000    ? *___________________________________________________________________
037600000000    ?C     PRCEND        Begsr                                                  PROCESS END
037700000000    ? *
037800000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
037900000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
038000000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
038100000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
038200000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
038300000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
038400000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
038500000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
038600000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
038700000000 001?C                   Endcs                                                  END CASE
038800000000 001? *
038900000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
039000000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
039100000000 002? *
039200000000X002?C                   Else                                                   ELSE NO WRT ERR
039300000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
039400000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
039500000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
039600000000 004?C                   Exsr      PRPPNL                                       DO NOT END
039700000810E004?C                   Endif                                                  END IF ADD
039800000000E003?C                   Endif                                                  END IF NOT END
039900000000E002?C                   Endif                                                  END IF WRITE ERROR
040000000000 001? *
040100000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
040200000000 001?C                   Exsr      RELREC                                       RELEASE REC
040300000000E001?C                   Endif                                                  END IF RCD CHANGED
040400000000    ? *
040500000000    ?C                   Endsr                                                  END PRCEND
040600000000    ? *___________________________________________________________________
040700000000    ? * Add new record
040800000000    ? *___________________________________________________________________
040900000000    ?C     WRTADD        Begsr                                                  WRITE ADD
041000000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
041100000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
041200000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
041300000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
041400000000E001?C                   Endif                                                  END IF ADD
041500000000    ? *
041600000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
041700000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
041800000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
041900000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
042000000000E001?C                   Endif                                                  END IF ADD KEY
042100000000    ? *
042200090319    ?C                   Call      'UPDACF  '                                   PROCESS REC IO
042300000000    ?C                   Parm                    WWRQS                          ADD RECORD
042400000000    ?C                   Parm                    WWRTN                          RETURN CODE
042500000614    ?C                   Parm                    WUDTA                          REC DATA
042501090309    ?C                   Parm                    Whist                          DATA
042600000000    ? *
042700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
042800000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
042900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
043000000000X001?C                   Else                                                   ELSE
043100000000E001?C                   Endif                                                  END IF CALL ERROR
043200000000    ? *
043300000000    ?C                   Endsr                                                  END WRTADD
043400000000    ? *___________________________________________________________________
043500000000    ? * Write changed record
043600000000    ? *___________________________________________________________________
043700000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
043704070614     C                   If        SVBEDT     >  20000000
043705070614     C     SVBEDT        MULT      10000.0001    SVBEDT
043706070614     C                   End
043707070614     C                   If        SVENDT     >  20000000
043708070614     C     SVENDT        MULT      10000.0001    SVENDT
043709070614     C                   End
043710090309     C                   Clear                   HstTracker
043711090305      * Routing Number has changed
043712090309     C                   If        SVROUT    <>  AHROUT
043713090309     C                   Movel     SVROUT        SaveRout
043714090309     C                   Eval      Rout      =   'X'
043715090309     C                   End
043716090305      * Bank Account Number has changed
043717090309     C                   If        SVACT#    <>  AHACT#
043718090309     C                   Movel     SVACT#        SaveACT#
043719090309     C                   Eval      Act#      =   'X'                            Change runout days
043720090309     C                   End
043721090305      * Checking/Savings Flaf has changed
043722090309     C                   If        SVCSFL    <>  AHCSFL
043723090309     C                   Movel     SVCSFL        SaveCSF
043724090309     C                   Eval      CSF       =   'X'                            Change runout days
043725090309     C                   End
043726090305      * Prenote has changed
043727090309     C                   If        SVPREN    <>  AHPREN
043728090309     C                   Movel     SVPREN        SavePreN
043729090309     C                   Eval      PreN      =   'X'                            Change runout days
043730090309     C                   End
043732090309      * End Date has changed
043733090309     C                   If        SVENDT    <>  AHENDT
043734090309     C                   Movel     SVENDT        SaveEndDt
043735090309     C                   Eval      EndDt     =   'X'                            Change runout days
043736090309     C                   End
043737090309      *
043738090309     C                   Movel     HstTracker    Whist
043800090319    ?C                   Call      'UPDACF  '                                   PROCESS REC IO
043900000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
044000000000    ?C                   Parm                    WWRTN                          RETURN CODE
044100000614    ?C                   Parm                    WUDTA                          REC DATA
044101090309    ?C                   Parm                    Whist                          DATA
044200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
044300070614 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
044400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
044500000000E001?C                   Endif                                                  END IF CALL ERROR
044600000000    ? *
044700000000    ?C                   Endsr                                                  END WRTCHG
044800000000    ? *___________________________________________________________________
044900000000    ? * Release record
045000000000    ? *___________________________________________________________________
045100000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
045200090319    ?C                   Call      'UPDACF  '                                   PROCESS REC IO
045300000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
045400000000    ?C                   Parm                    WWRTN                          RETURN CODE
045500000614    ?C                   Parm                    WUDTA                          REC DATA
045501090309    ?C                   Parm                    Whist                          DATA
045600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
045700000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
045800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
045900000000E001?C                   Endif                                                  END IF CALL ERROR
046000000000    ?C                   Endsr                                                  END RELREC
046100000000    ? *___________________________________________________________________
046200000000    ? * Build function keys
046300000000    ? *___________________________________________________________________
046400000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
046500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
046600991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
046700000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
046800000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
046900000000    ?C                   Parm                    WAD                            FNC DESC
047000991108    ?C                   Parm                    WWIN                           AID BYTE
047100000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
047200000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
047300000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
047400000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
047500000000    ?C                   Sub       1             WW                             BUMP IDX
047600000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
047700000000    ?C                   Endsr                                                  END BLD FNCTNS
047800000000    ? *___________________________________________________________________
047900000000    ? * Send message
048000000000    ? *___________________________________________________________________
048100000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
048200000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
048300000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
048400000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
048500000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
048600000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
048700000000    ?C                   Endsr                                                  END SNDMSG
048800000000    ? *___________________________________________________________________
048900000000    ? * Paremater list
049000000000    ? *___________________________________________________________________
049100000000    ?C     PLIST         Begsr                                                  PARM LISTS
049200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
049300000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
049400000000    ?C                   Parm                    WORTN             8            RETURN CODE
049500000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
049600000614    ?C                   Parm                    WUDTA                          RECORD KEY
049700000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
049701090309    ?C                   Parm                    Whist                          DATA
049800000000    ?C                   Endsr                                                  END PLIST
049801050318    ? *___________________________________________________________________
049802050318    ? * Key lists
049803050318    ? *___________________________________________________________________
049804050318    ?C     KLIST         Begsr                                                  KEY LISTS
049805050318    ?C     AKey          Klist                                                  ACKCTL
049806090224    ?C                   Kfld                    AHTRST
049807090224    ?C                   Kfld                    AHSUB#
049808090224    ?C                   Kfld                    AHACCT                         POSITION TO 1
049809090226    ?C     AccKey        Klist                                                  ACKCTL
049810090226    ?C                   Kfld                    ACTRST
049811090226    ?C                   Kfld                    ACSUB#
049812090226    ?C                   Kfld                    ACACCT                         POSITION TO 1
049813050318    ?C                   Endsr                                                  END KLIST
049900000000    ? *___________________________________________________________________
050000000000    ? * Initialize routine
050100000000    ? *___________________________________________________________________
050200000000    ?C     *INZSR        Begsr                                                  INITIALIZE
050300000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
050400000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
050500000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
050600000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
050700000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
050800000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
050900000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
051000000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
051100000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
051102090611     C                   Clear                   SVACT#           17
051103090224     C                   Clear                   SVROUT            9 0
051104070614     C                   Clear                   SVBEDT            8 0
051105070614     C                   Clear                   SVENDT            8 0
051106090224     C                   Clear                   SVCSFL            1
051107090304     C                   Clear                   SVPREN            1
051200000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
051300000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
051400000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
051500000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
051600000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
051700000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
051800000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
051900000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
052000000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
052100000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
052200000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
052300000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
052400000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
052500000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
052600000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
052700000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
052800090224    ?C                   Movel     'ISCACH  '    WWFIL            10            FILE NAME-NOTES
052900000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
053000000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
053100000000    ?C                   Endsr                                                  END INITIALIZE
053200000000    ? *___________________________________________________________________
053300000000    ? * Program error handler
053400000000    ? *___________________________________________________________________
053500000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
053600000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
053700000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
053800000000    ?C                   Parm                    WQSTSC                         STATUS CODE
053900000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
054000000000    ?C                   Parm                    WQMSG                          MESSAGE ID
054100000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
054200000000    ? *___________________________________________________________________
054300000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05440000000003EXIT    F3=Exit
05460000000005REFRESH F5=Refresh
05470000070710UPDATE  F10=Update
05480000061412CANCEL  F12=Cancel
05490000000025ROLLUP
05500000000026ROLLDOWN
055100000000** WTM
05520009031900Request not supported in program CHGACF.
05530000000000Update error.  Data was not updated.
05540007061400Duplicate Begin Date not allowed.
05550000000000Call to notes ended in error.
05560000000000Initialize error.  Record not initialized.
05570000000000Record not found.
05580000000000Generate error.  Key not generated.
05590000000000Record not available now.
05600000000000The cursor is not in a prompt area.
05610000000000Default error.  Data not defaulted.
