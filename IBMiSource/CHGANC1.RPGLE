000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300100817    ? *  Description:  Change Ancillary Product Formulas
000400000000    ? *
000500100506    ? *  (c)Copyright 2010 by GBS,Inc.
000600051028    ? *
000700051028    ? *_________________________________________________________________________
000800100817    ?FCHGANC1D  CF   E             WORKSTN
000900000000    ?F                                     INFDS(DSPD)
001000101004    ?FPAYDEDANL1If   E           k Disk
001100100506     FTRSMST    IF   E           K DISK
001200100506     FSUBMST    IF   E           K DISK
001300100506     FPLNMST    IF   E           K DISK
001400100506     FCARMST    IF   E           K DISK
001500000000    ? *
001600000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001700000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001800000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001900000000    ? *_________________________________________________________________________
002000000406    ? * Data structure
002100100817    ?D WUDTA         E DS                  EXTNAME(PAYDEDANP)
002200100526    ?D WDCLS         E DS                  EXTNAME(WEBPAYCHP)
002300000000    ? *
002400000000    ? * Program status data structure
002500991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002600000000    ? *
002700000000    ? * Display file data structure
002800991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002900000000    ? *
003000000000    ? * CURSOR LOCATION
003100000000    ?D                 DS
003200000000    ?D  WWCRSL                 1      2
003300000000    ?D  WWCRSN                 1      2B 0
003400100506    ? *
003500100817     D WWTRST          S                   LIKE(PATRST)
003600100817     D WWSUB#          S                   LIKE(PASUB#)
003700100817     D WWACCT          S                   LIKE(PAPLAN)
003800000000    ? *_________________________________________________________________________
003900000000    ? *
004000000614    ? * Process Entry Panel
004100000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
004200000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
004300000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
004400000000E001?C                   Endif                                                  END COPY/CPYKEY
004500000000    ? *
004600000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004700000000    ? *
004800000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004900000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005000000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
005100000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005200000000 001? *
005300000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
005400000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
005500000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005600000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
005700000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005800000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
005900000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
006000000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
006100000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
006200000000 001?C                   Endcs                                                  END CASE
006300000000 001? *
006400000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
006500000000 002?C                   Exsr      PRCEND                                       PROCESS END
006600000000E002?C                   Endif                                                  END IF END REQ
006700000000E001?C                   Enddo                                                  END DOWHILE
006800000000    ? *
006900000707    ? * Send Info Updated message.
007000000707     C     WwChg         Ifeq      'Y'
007100000707     C                   Movel     'UPDATE  '    WORTN
007200000707     C                   Endif
007300000707    ? *
007400000000    ?C                   Return                                                 RETURN
007500000000    ? *___________________________________________________________________
007600000000    ? * Prepare panel
007700000000    ? *___________________________________________________________________
007800000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007900000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
008000050317    ?C                   Move      *ZEROS        WSBEDT                         RETURN CODE
008100050317    ?C                   Move      *ZEROS        WSENDT                         RETURN CODE
008200991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008300000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008400000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008500000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008600000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008700000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008800000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
008900000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
009000000000    ? *
009100000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
009200000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009300000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009400000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009500000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009600000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009700050318      *
009800100818     C                   Eval      WSRULE = PARULE
009900100817     C                   Movel     PATRST        Trst              3
010000100817     C                   Movel     PASUB#        Sub#              3
010100100817     C                   Movel     PAPLAN        Plan              4
010200100817     C     PATRST        Chain     TRSMST
010300100506     C     SKey          Chain     SUBMST
010400100506     C     PKey          Chain     PLNMST
010500100506     C     PCARR         Chain     CARMST
010600100506     C                   If        %Found(PLNMST)
010700100506     C                   Eval      WWTRSD = %Trim(Trst  + ' ' + %Trim(TNAME))
010800100506     C                   Eval      WWSUBD = %Trim(Sub#  + ' ' + %Trim(SUBNAM))
010900100506     C                   Eval      WWPLND = %Trim(Plan  + ' ' + %Trim(PDESCR))
011000100506     C                   Eval      WWCARD = %Trim(PCARR + ' ' + %Trim(CNAME))
011100050318     C                   End
011200000000    ? *
011300000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
011400000000    ? *
011500000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
011600000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
011700000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
011800000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
011900000000    ?C                   Cas                     PRCERR                         PROC ERROR
012000000000    ?C                   Endcs                                                  END CASE
012100000000    ? *
012200000000    ?C                   Endsr                                                  END PRPPNL
012300000000    ? *___________________________________________________________________
012400000000    ? * Prepare ADD request
012500000000    ? *___________________________________________________________________
012600000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
012700100817    ?C                   Clear                   PAFIXA                         CLEAR RECORD
012800100817    ?C                   Clear                   PAPPBE                         CLEAR RECORD
012900000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
013000000000    ?C                   Endsr                                                  END PRP ADD
013100000000    ? *___________________________________________________________________
013200000000    ? * Prepare CHANGE request
013300000000    ? *___________________________________________________________________
013400000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
013500100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
013600000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
013700000000    ?C                   Parm                    WWRTN                          RETURN CODE
013800000614    ?C                   Parm                    WUDTA                          REC DATA
013900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014000000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
014100000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
014200000000X002?C                   Else                                                   ELSE
014300000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014400000000E002?C                   Endif                                                  END RCD NOT AVL
014500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
014800000810E001?C                   Else                                                   END IF ERROR
014900100817     C     PABEDT        MULT      10000.0001    WSBEDT
015000100817     C     PAENDT        MULT      10000.0001    WSENDT
015100000810E001?C                   Endif                                                  END IF ERROR
015200000000    ?C                   Endsr                                                  END PRP CHANGE
015300000000    ? *___________________________________________________________________
015400000000    ? * Prepare COPY request
015500000000    ? *___________________________________________________________________
015600000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
015700000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
015800100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
015900000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
016000000000    ?C                   Parm                    WWRTN                          RETURN CODE
016100000614    ?C                   Parm                    WUDTA                          REC DATA
016200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016300000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
016400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016500000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016600000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016700000000X001?C                   Else                                                   ELSE
016800000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
016900100817     C     PABEDT        MULT      10000.0001    WSBEDT
017000100817     C     PAENDT        MULT      10000.0001    WSENDT
017100000000E001?C                   Endif                                                  END IF ERROR
017200000000    ?C                   Endsr                                                  END PREP COPY
017300000000    ? *___________________________________________________________________
017400000000    ? * Default Data
017500000000    ? *___________________________________________________________________
017600000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
017700100817    ?C                   Call      'CHKANC  '                                   PROCESS REC IO
017800000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
017900000000    ?C                   Parm                    WWRTN                          RETURN CODE
018000000614    ?C                   Parm                    WUDTA                          REC DATA
018100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
018200000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
018300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018400000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018500000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
018600000000E001?C                   Endif                                                  END IF ERROR
018700000000    ?C                   Endsr                                                  END DFTDTA
018800000000    ? *___________________________________________________________________
018900000000    ? * Process ERROR function
019000000000    ? *___________________________________________________________________
019100000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
019200000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
019300000000    ?C                   Exsr      SNDMSG                                       SEND MSG
019400000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019500000000    ?C                   Move      'END'         WWSTT                          END STATE
019600000000    ?C                   Endsr                                                  END PRCERR
019700000000    ? *___________________________________________________________________
019800000000    ? * Receive messages
019900000000    ? *___________________________________________________________________
020000000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
020100000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
020200000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
020300000000X001?C                   Else                                                   ELSE
020400000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
020500000000E001?C                   Endif                                                  ENDIF NOT NORESET
020600000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
020700000000    ?C                   Movea     *IN           WWIN                           INDICATORS
020800000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
020900000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
021000000000    ?C                   Parm                    WWIN                           INDICATORS
021100000000    ?C                   Parm                    WWRTN                          RETURN CODE
021200000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
021300000000    ?C                   Endsr                                                  END RCV MSG
021400000000    ? *___________________________________________________________________
021500000000    ? * Display panels
021600000000    ? *___________________________________________________________________
021700000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
021800000000    ? *
021900000000    ? * Set PUTOVR based on last display file processed
022000000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
022100000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
022200000000 001?C                   Setoff                                       35        PUTOVR OFF
022300000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
022400000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
022500000000X001?C                   Else                                                   ELSE SAME PGM
022600000000 001?C                   Seton                                        35        PUTOVR ON
022700000000E001?C                   Endif                                                  END IF NEW PGM
022800000000    ? *
022900000614    ? * Set PROTECT key based on request
023000000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
023100000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
023200000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
023300000000 001?C                   Setoff                                       40        NO PROTECT KEY
023400000000X001?C                   Else                                                   ELSE
023500000000 001?C                   Seton                                        40        PROTECT KEY
023600000000E001?C                   Endif                                                  END IF ADD
023700000000    ? *
023800000000    ? * Select title
023900000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
024000000000 001?C                   Setoff                                       38        CHANGE TITLE
024100000000X001?C                   Else                                                   ELSE
024200000000 001?C                   Seton                                        38        ADD TITLE
024300000000E001?C                   Endif                                                  END IF CHANGE
024400000000    ? *
024500000000    ? * Position cursor based on error status
024600000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
024700000000 001?C                   Seton                                        99        POS CSR TO ERROR
024800000000X001?C                   Else                                                   ELSE
024900000000 001?C                   Setoff                                       99        POS CSR TO FIRST
025000000000E001?C                   Endif                                                  END IF ERROR
025100000000    ? *
025200000000    ? * Write message subfile
025300000000    ?C                   Seton                                        30        MSGSFL DISPLAY
025400000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
025500000000    ? *
025600000000    ? * Write entry panel
025700000000B001?C                   Select
025800000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
025900000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
026000000000 001?C                   Setoff                                       37        RESET CRSLOC
026100000000E001?C                   Endsl                                                  END SELECT
026200000000    ? *
026300000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
026400000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
026500000000E001?C                   Endif                                                  END IF DATA CHG
026600000000    ?C                   Endsr                                                  END DSPENT
026700000000    ? *___________________________________________________________________
026800000000    ? * Process function key
026900000000    ? *___________________________________________________________________
027000000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
027100991108    ?C                   Movea     *IN           WWIN                           INDICATORS
027200991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
027300000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
027400000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
027500000000    ?C                   Parm                    WAD                            FNC DESC
027600991108    ?C                   Parm                    WWIN                           AID BYTE
027700000000    ?C                   Parm                    WAF                            FNC KEY TABLE
027800000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
027900000000    ?C                   Endsr                                                  END PRCFKY
028000000000    ? *___________________________________________________________________
028100000000    ? * Process KEYS function
028200000000    ? *___________________________________________________________________
028300000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
028400000000    ?C                   Z-add     1             WW                             KEY DSC IDX
028500000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
028600000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
028700000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
028800000000 001? *
028900000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
029000000000 002?C                   Z-add     1             WWFKS                          SET TO 1
029100000000E002?C                   Endif                                                  END IF OVER 3
029200000000 001? *
029300000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
029400000000 001?C                   Sub       1             WW                             KEY DESCR IDX
029500000000E001?C                   Enddo                                                  END DO KEYS
029600000000    ? *
029700000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
029800000000    ?C                   Add       1             WW                             BUMP IDX
029900000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
030000000000    ?C                   Endsr                                                  END PRCDKY
030100000000    ? *___________________________________________________________________
030200000000    ? * Process EXIT Function
030300000000    ? *___________________________________________________________________
030400000000    ?C     PRCEXT        Begsr                                                  RETURN
030500000000    ? *
030600000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
030700000000    ? *
030800000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
030900000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
031000000000X001?C                   Else                                                   ELSE NO ERRORS
031100000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
031200000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
031300000000E001?C                   Endif                                                  END IF ERRORS
031400000000    ?C                   Endsr                                                  END PRCEXT
031500000000    ? *___________________________________________________________________
031600000000    ? * Process PROMPT function
031700000000    ? *___________________________________________________________________
031800000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
031900000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
032000000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
032100000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
032200000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
032300100817    ? *
032400100817    ? *
032500100817    ? * HERE
032600100817    ? *
032700100526    ? *
032800000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
032900000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
033000000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
033100000000    ?C                   Mvr                     WSLIN                          CURSOR COL
033200000000    ?C                   Seton                                        37        SET ON CRSLOC
033300000000    ? *
033400000000    ?C                   Endsr                                                  END PRCPMT
033500000000    ? *___________________________________________________________________
033600000000    ? * Process CANCEL Function
033700000000    ? *___________________________________________________________________
033800000000    ?C     PRCCNL        Begsr                                                  CANCEL
033900000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
034000000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
034100000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
034200000000    ?C                   Endsr                                                  END RETURN
034300000000    ? *___________________________________________________________________
034400000000    ? * Process ROLLUP function
034500000000    ? *___________________________________________________________________
034600000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
034700000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
034800000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
034900000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
035000000000E001?C                   Endif                                                  END IF GT LST PNL
035100000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
035200000000    ?C                   Endsr                                                  END PRCRUP
035300000000    ? *___________________________________________________________________
035400000000    ? * Process ROLLDOWN function
035500000000    ? *___________________________________________________________________
035600000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
035700000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
035800000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
035900000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
036000000000E001?C                   Endif                                                  END IF LT FST PNL
036100000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
036200000000    ?C                   Endsr                                                  END PRCRDN
036300000000    ? *___________________________________________________________________
036400000000    ? * Process ENTER function
036500000000    ? *___________________________________________________________________
036600000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
036700000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
036800000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
036900100819    ?C                   If        WWFKA = 'UPDATE  '  or                       ENTER
037000100819    ?C                             WWFKA = 'ENTER   '                           ENTER
037100000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
037200000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
037300000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
037400100817     C                   Z-add     WSBEDT        PABEDT
037500100817     C                   Z-add     WSENDT        PAENDT
037600100817 001?C                   Call      'CHKANC  '                                   CHECK DATA
037700100818 001?C                   Parm      'EDIT1   '    WWRQS                          EDIT REQUEST
037800000000 001?C                   Parm                    WWRTN                          RETURN CODE
037900000614 001?C                   Parm                    WUDTA                          REC DATA
038000100819E001?C                   End                                                    ENDIF
038100100819E001?C                   End                                                    ENDIF
038200000000    ? *
038300000000B001?C                   Select                                                 PRC RETURN CDE
038400000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
038500000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
038600000000 001? *
038700000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
038800000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
038900000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
039000000000X002?C                   Else                                                   ELSE
039100000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
039200000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
039300000000E002?C                   Endif                                                  IF WARNING
039400000000 001? *
039500000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
039600000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
039700000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
039800000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
039900000000E001?C                   Endsl                                                  RETURN CODE SEL
040000000000    ? *
040100000000    ?C                   Endsr                                                  END PRCPNL
040200000000    ? *___________________________________________________________________
040300000000    ? * Process end - write data or release record
040400000000    ? *___________________________________________________________________
040500000000    ?C     PRCEND        Begsr                                                  PROCESS END
040600161011    ? *
040700161011    ? * Prevent update on F1 exit
040800161011     C                   If        WWCHG = 'Y' and
040900161011     C                             WWFKA = 'EXIT'
041000161011     C                   eval      WWCHG = 'N'
041100161011     C                   eval      WWTSK = *blanks
041200161011     C                   end
041300000000    ? *
041400000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
041500000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
041600000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
041700000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
041800000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
041900000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
042000000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
042100000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
042200000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
042300000000 001?C                   Endcs                                                  END CASE
042400000000 001? *
042500000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
042600000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
042700000000 002? *
042800000000X002?C                   Else                                                   ELSE NO WRT ERR
042900000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
043000000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
043100000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
043200000000 004?C                   Exsr      PRPPNL                                       DO NOT END
043300000810E004?C                   Endif                                                  END IF ADD
043400000000E003?C                   Endif                                                  END IF NOT END
043500000000E002?C                   Endif                                                  END IF WRITE ERROR
043600000000 001? *
043700000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
043800000000 001?C                   Exsr      RELREC                                       RELEASE REC
043900000000E001?C                   Endif                                                  END IF RCD CHANGED
044000000000    ? *
044100000000    ?C                   Endsr                                                  END PRCEND
044200000000    ? *___________________________________________________________________
044300000000    ? * Add new record
044400000000    ? *___________________________________________________________________
044500000000    ?C     WRTADD        Begsr                                                  WRITE ADD
044600000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
044700000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
044800000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
044900000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
045000000000E001?C                   Endif                                                  END IF ADD
045100000000    ? *
045200000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
045300000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
045400000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
045500000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
045600000000E001?C                   Endif                                                  END IF ADD KEY
045700000000    ? *
045800100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
045900000000    ?C                   Parm                    WWRQS                          ADD RECORD
046000000000    ?C                   Parm                    WWRTN                          RETURN CODE
046100000614    ?C                   Parm                    WUDTA                          REC DATA
046200000000    ? *
046300100526B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
046400100526 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
046500100526 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
046600100526X001?C                   Else                                                   ELSE
046700100526E001?C                   Endif                                                  END IF CALL ERROR
046800000000    ? *
046900000000    ?C                   Endsr                                                  END WRTADD
047000000000    ? *___________________________________________________________________
047100000000    ? * Write changed record
047200000000    ? *___________________________________________________________________
047300000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
047400090309      *
047500100825      * Reset Other Formulas
047600100825     C                   Clear                   PASALM
047700100928     C                   Clear                   PAVARI
047800100825     C                   Clear                   PALMIN
047900100825     C                   Clear                   PALMAX
048000100825     C                   Clear                   PALRND
048100100825     C                   Clear                   PALABR
048200100928     C                   Clear                   PAPSAL
048300100928     C                   Clear                   PASPSL
048400100928     C                   Clear                   PAINCR
048500100928     C                   Clear                   PAGISS
048600100825      *
048700100825     C                   Eval      PAFORM = 'FLAT      '
048800100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
048900000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
049000000000    ?C                   Parm                    WWRTN                          RETURN CODE
049100000614    ?C                   Parm                    WUDTA                          REC DATA
049200100526B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
049300100526 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
049400100526 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
049500100526E001?C                   Endif                                                  END IF CALL ERROR
049600000000    ? *
049700000000    ?C                   Endsr                                                  END WRTCHG
049800000000    ? *___________________________________________________________________
049900000000    ? * Release record
050000000000    ? *___________________________________________________________________
050100000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
050200100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
050300000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
050400000000    ?C                   Parm                    WWRTN                          RETURN CODE
050500000614    ?C                   Parm                    WUDTA                          REC DATA
050600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
050700000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
050800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
050900000000E001?C                   Endif                                                  END IF CALL ERROR
051000000000    ?C                   Endsr                                                  END RELREC
051100000000    ? *___________________________________________________________________
051200000000    ? * Build function keys
051300000000    ? *___________________________________________________________________
051400000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
051500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
051600991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
051700000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
051800000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
051900000000    ?C                   Parm                    WAD                            FNC DESC
052000991108    ?C                   Parm                    WWIN                           AID BYTE
052100000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
052200000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
052300000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
052400000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
052500000000    ?C                   Sub       1             WW                             BUMP IDX
052600000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
052700000000    ?C                   Endsr                                                  END BLD FNCTNS
052800000000    ? *___________________________________________________________________
052900000000    ? * Send message
053000000000    ? *___________________________________________________________________
053100000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
053200000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
053300000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
053400000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
053500000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
053600000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
053700000000    ?C                   Endsr                                                  END SNDMSG
053800000000    ? *___________________________________________________________________
053900000000    ? * Paremater list
054000000000    ? *___________________________________________________________________
054100000000    ?C     PLIST         Begsr                                                  PARM LISTS
054200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
054300000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
054400000000    ?C                   Parm                    WORTN             8            RETURN CODE
054500000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
054600000614    ?C                   Parm                    WUDTA                          RECORD KEY
054700000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
054800000000    ?C                   Endsr                                                  END PLIST
054900050318    ? *___________________________________________________________________
055000050318    ? * Key lists
055100050318    ? *___________________________________________________________________
055200050318    ?C     KLIST         Begsr                                                  KEY LISTS
055300100506    ?C     PKey          Klist                                                  ACKCTL
055400100817    ?C                   Kfld                    PATRST
055500100817    ?C                   Kfld                    PASUB#
055600100817    ?C                   Kfld                    PAPLAN                         POSITION TO 1
055700100506    ?C     SKey          Klist                                                  ACKCTL
055800100817    ?C                   Kfld                    PATRST
055900100817    ?C                   Kfld                    PASUB#
056000050318    ?C                   Endsr                                                  END KLIST
056100000000    ? *___________________________________________________________________
056200000000    ? * Initialize routine
056300000000    ? *___________________________________________________________________
056400000000    ?C     *INZSR        Begsr                                                  INITIALIZE
056500000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
056600000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
056700000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
056800000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
056900000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
057000000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
057100000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
057200000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
057300000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
057400100506     C                   Clear                   SV$AMT            5 2
057500000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
057600000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
057700000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
057800000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
057900000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
058000000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
058100000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
058200000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
058300000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
058400000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
058500000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
058600000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
058700000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
058800000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
058900000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
059000000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
059100100817    ?C                   Movel     'CHGANC  '    WWFIL            10            FILE NAME-NOTES
059200000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
059300000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
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
06070010081701EXIT    F1=Return
06080000000005REFRESH F5=Refresh
06090000070710UPDATE  F10=Update
06100000061412CANCEL  F12=Cancel
06110000000025ROLLUP
06120000000026ROLLDOWN
061300000000** WTM
06140010081700Request not supported in program CHGANC.
06150000000000Update error.  Data was not updated.
06160010052600Update error.  Data was not updated.
06170000000000Call to notes ended in error.
06180000000000Initialize error.  Record not initialized.
06190000000000Record not found.
06200000000000Generate error.  Key not generated.
06210000000000Record not available now.
06220000000000The cursor is not in a prompt area.
06230000000000Default error.  Data not defaulted.
