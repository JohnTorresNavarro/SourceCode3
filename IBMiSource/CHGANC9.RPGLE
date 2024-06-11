000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300100817    ? *  Description:  Change Ancillary Product Formulas
000400000000    ? *
000500100506    ? *  (c)Copyright 2010 by GBS,Inc.
000600051028    ? *
000700051028    ? *_________________________________________________________________________
000800140606    ?FCHGANC9D  CF   E             WORKSTN
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
004000100921     C                   Eval      WWTSK  =  'CHANGE '
004100100921    ? *
004200000614    ? * Process Entry Panel
004300000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
004400000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
004500000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
004600000000E001?C                   Endif                                                  END COPY/CPYKEY
004700000000    ? *
004800000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004900000000    ? *
005000000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005100000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005200000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
005300000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005400000000 001? *
005500000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
005600000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
005700000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005800000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
005900000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006000000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
006100000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
006200000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
006300000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
006400000000 001?C                   Endcs                                                  END CASE
006500000000 001? *
006600000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
006700000000 002?C                   Exsr      PRCEND                                       PROCESS END
006800000000E002?C                   Endif                                                  END IF END REQ
006900000000E001?C                   Enddo                                                  END DOWHILE
007000000000    ? *
007100000707    ? * Send Info Updated message.
007200000707     C     WwChg         Ifeq      'Y'
007300000707     C                   Movel     'UPDATE  '    WORTN
007400000707     C                   Endif
007500000707    ? *
007600000000    ?C                   Return                                                 RETURN
007700000000    ? *___________________________________________________________________
007800000000    ? * Prepare panel
007900000000    ? *___________________________________________________________________
008000000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008100000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
008200050317    ?C                   Move      *ZEROS        WSBEDT                         RETURN CODE
008300050317    ?C                   Move      *ZEROS        WSENDT                         RETURN CODE
008400991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008500000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008600000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008700000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008800000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008900000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
009000000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
009100000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
009200000000    ? *
009300000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
009400000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009500000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009600000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009700000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009800000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009900050318      *
010000100818     C                   Eval      WSRULE = PARULE
010100100817     C                   Movel     PATRST        Trst              3
010200100817     C                   Movel     PASUB#        Sub#              3
010300100817     C                   Movel     PAPLAN        Plan              4
010400100817     C     PATRST        Chain     TRSMST
010500100506     C     SKey          Chain     SUBMST
010600100506     C     PKey          Chain     PLNMST
010700100506     C     PCARR         Chain     CARMST
010800100506     C                   If        %Found(PLNMST)
010900100506     C                   Eval      WWTRSD = %Trim(Trst  + ' ' + %Trim(TNAME))
011000100506     C                   Eval      WWSUBD = %Trim(Sub#  + ' ' + %Trim(SUBNAM))
011100100506     C                   Eval      WWPLND = %Trim(Plan  + ' ' + %Trim(PDESCR))
011200100506     C                   Eval      WWCARD = %Trim(PCARR + ' ' + %Trim(CNAME))
011300050318     C                   End
011400000000    ? *
011500000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
011600000000    ? *
011700000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
011800000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
011900000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
012000000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
012100000000    ?C                   Cas                     PRCERR                         PROC ERROR
012200000000    ?C                   Endcs                                                  END CASE
012300000000    ? *
012400000000    ?C                   Endsr                                                  END PRPPNL
012500000000    ? *___________________________________________________________________
012600000000    ? * Prepare ADD request
012700000000    ? *___________________________________________________________________
012800000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
012900100817    ?C                   Clear                   PAFIXA                         CLEAR RECORD
013000100817    ?C                   Clear                   PAPPBE                         CLEAR RECORD
013100000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
013200000000    ?C                   Endsr                                                  END PRP ADD
013300000000    ? *___________________________________________________________________
013400000000    ? * Prepare CHANGE request
013500000000    ? *___________________________________________________________________
013600000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
013700100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
013800000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
013900000000    ?C                   Parm                    WWRTN                          RETURN CODE
014000000614    ?C                   Parm                    WUDTA                          REC DATA
014100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014200000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
014300000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
014400000000X002?C                   Else                                                   ELSE
014500000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014600000000E002?C                   Endif                                                  END RCD NOT AVL
014700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014800000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014900000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015000000810E001?C                   Else                                                   END IF ERROR
015100100817     C     PABEDT        MULT      10000.0001    WSBEDT
015200100817     C     PAENDT        MULT      10000.0001    WSENDT
015300000810E001?C                   Endif                                                  END IF ERROR
015400000000    ?C                   Endsr                                                  END PRP CHANGE
015500000000    ? *___________________________________________________________________
015600000000    ? * Prepare COPY request
015700000000    ? *___________________________________________________________________
015800000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
015900000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
016000100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
016100000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
016200000000    ?C                   Parm                    WWRTN                          RETURN CODE
016300000614    ?C                   Parm                    WUDTA                          REC DATA
016400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016500000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
016600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016800000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016900000000X001?C                   Else                                                   ELSE
017000000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
017100100817     C     PABEDT        MULT      10000.0001    WSBEDT
017200100817     C     PAENDT        MULT      10000.0001    WSENDT
017300000000E001?C                   Endif                                                  END IF ERROR
017400000000    ?C                   Endsr                                                  END PREP COPY
017500000000    ? *___________________________________________________________________
017600000000    ? * Default Data
017700000000    ? *___________________________________________________________________
017800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
017900100817    ?C                   Call      'CHKANC  '                                   PROCESS REC IO
018000000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
018100000000    ?C                   Parm                    WWRTN                          RETURN CODE
018200000614    ?C                   Parm                    WUDTA                          REC DATA
018300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
018400000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
018500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
018800000000E001?C                   Endif                                                  END IF ERROR
018900000000    ?C                   Endsr                                                  END DFTDTA
019000000000    ? *___________________________________________________________________
019100000000    ? * Process ERROR function
019200000000    ? *___________________________________________________________________
019300000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
019400000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
019500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
019600000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019700000000    ?C                   Move      'END'         WWSTT                          END STATE
019800000000    ?C                   Endsr                                                  END PRCERR
019900000000    ? *___________________________________________________________________
020000000000    ? * Receive messages
020100000000    ? *___________________________________________________________________
020200000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
020300000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
020400000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
020500000000X001?C                   Else                                                   ELSE
020600000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
020700000000E001?C                   Endif                                                  ENDIF NOT NORESET
020800000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
020900000000    ?C                   Movea     *IN           WWIN                           INDICATORS
021000000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
021100000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
021200000000    ?C                   Parm                    WWIN                           INDICATORS
021300000000    ?C                   Parm                    WWRTN                          RETURN CODE
021400000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
021500000000    ?C                   Endsr                                                  END RCV MSG
021600000000    ? *___________________________________________________________________
021700000000    ? * Display panels
021800000000    ? *___________________________________________________________________
021900000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
022000000000    ? *
022100000000    ? * Set PUTOVR based on last display file processed
022200000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
022300000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
022400000000 001?C                   Setoff                                       35        PUTOVR OFF
022500000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
022600000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
022700000000X001?C                   Else                                                   ELSE SAME PGM
022800000000 001?C                   Seton                                        35        PUTOVR ON
022900000000E001?C                   Endif                                                  END IF NEW PGM
023000000000    ? *
023100000614    ? * Set PROTECT key based on request
023200000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
023300000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
023400000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
023500000000 001?C                   Setoff                                       40        NO PROTECT KEY
023600000000X001?C                   Else                                                   ELSE
023700000000 001?C                   Seton                                        40        PROTECT KEY
023800000000E001?C                   Endif                                                  END IF ADD
023900000000    ? *
024000000000    ? * Select title
024100000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
024200000000 001?C                   Setoff                                       38        CHANGE TITLE
024300000000X001?C                   Else                                                   ELSE
024400000000 001?C                   Seton                                        38        ADD TITLE
024500000000E001?C                   Endif                                                  END IF CHANGE
024600100921    ? *
024700130430B001?C***                if        WIRQS  =  'CHANGEB'                          IF COPY
024800100921 001?C                   Seton                                        75        CHANGE TITLE
024900130430X001?C***                Else                                                   ELSE
025000130430 001?C***                Setoff                                       75        ADD TITLE
025100130430E001?C***                Endif                                                  END COPY/CPYKEY
025200000000    ? *
025300000000    ? * Position cursor based on error status
025400000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
025500000000 001?C                   Seton                                        99        POS CSR TO ERROR
025600000000X001?C                   Else                                                   ELSE
025700000000 001?C                   Setoff                                       99        POS CSR TO FIRST
025800000000E001?C                   Endif                                                  END IF ERROR
025900000000    ? *
026000000000    ? * Write message subfile
026100000000    ?C                   Seton                                        30        MSGSFL DISPLAY
026200000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
026300000000    ? *
026400000000    ? * Write entry panel
026500000000B001?C                   Select
026600000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
026700000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
026800000000 001?C                   Setoff                                       37        RESET CRSLOC
026900000000E001?C                   Endsl                                                  END SELECT
027000000000    ? *
027100000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
027200000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
027300000000E001?C                   Endif                                                  END IF DATA CHG
027400000000    ?C                   Endsr                                                  END DSPENT
027500000000    ? *___________________________________________________________________
027600000000    ? * Process function key
027700000000    ? *___________________________________________________________________
027800000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
027900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
028000991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
028100000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
028200000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
028300000000    ?C                   Parm                    WAD                            FNC DESC
028400991108    ?C                   Parm                    WWIN                           AID BYTE
028500000000    ?C                   Parm                    WAF                            FNC KEY TABLE
028600000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
028700000000    ?C                   Endsr                                                  END PRCFKY
028800000000    ? *___________________________________________________________________
028900000000    ? * Process KEYS function
029000000000    ? *___________________________________________________________________
029100000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
029200000000    ?C                   Z-add     1             WW                             KEY DSC IDX
029300000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
029400000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
029500000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
029600000000 001? *
029700000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
029800000000 002?C                   Z-add     1             WWFKS                          SET TO 1
029900000000E002?C                   Endif                                                  END IF OVER 3
030000000000 001? *
030100000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
030200000000 001?C                   Sub       1             WW                             KEY DESCR IDX
030300000000E001?C                   Enddo                                                  END DO KEYS
030400000000    ? *
030500000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
030600000000    ?C                   Add       1             WW                             BUMP IDX
030700000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
030800000000    ?C                   Endsr                                                  END PRCDKY
030900000000    ? *___________________________________________________________________
031000000000    ? * Process EXIT Function
031100000000    ? *___________________________________________________________________
031200000000    ?C     PRCEXT        Begsr                                                  RETURN
031300000000    ? *
031400000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
031500000000    ? *
031600000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
031700000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
031800000000X001?C                   Else                                                   ELSE NO ERRORS
031900000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
032000000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
032100000000E001?C                   Endif                                                  END IF ERRORS
032200000000    ?C                   Endsr                                                  END PRCEXT
032300000000    ? *___________________________________________________________________
032400000000    ? * Process PROMPT function
032500000000    ? *___________________________________________________________________
032600000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
032700000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
032800000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
032900000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
033000000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
033100100817    ? *
033200100817    ? *
033300100817    ? * HERE
033400100817    ? *
033500100526    ? *
033600000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
033700000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
033800000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
033900000000    ?C                   Mvr                     WSLIN                          CURSOR COL
034000000000    ?C                   Seton                                        37        SET ON CRSLOC
034100000000    ? *
034200000000    ?C                   Endsr                                                  END PRCPMT
034300000000    ? *___________________________________________________________________
034400000000    ? * Process CANCEL Function
034500000000    ? *___________________________________________________________________
034600000000    ?C     PRCCNL        Begsr                                                  CANCEL
034700000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
034800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
034900000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
035000000000    ?C                   Endsr                                                  END RETURN
035100000000    ? *___________________________________________________________________
035200000000    ? * Process ROLLUP function
035300000000    ? *___________________________________________________________________
035400000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
035500000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
035600000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
035700000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
035800000000E001?C                   Endif                                                  END IF GT LST PNL
035900000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
036000000000    ?C                   Endsr                                                  END PRCRUP
036100000000    ? *___________________________________________________________________
036200000000    ? * Process ROLLDOWN function
036300000000    ? *___________________________________________________________________
036400000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
036500000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
036600000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
036700000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
036800000000E001?C                   Endif                                                  END IF LT FST PNL
036900000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
037000000000    ?C                   Endsr                                                  END PRCRDN
037100000000    ? *___________________________________________________________________
037200000000    ? * Process ENTER function
037300000000    ? *___________________________________________________________________
037400000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
037500000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
037600000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
037700100819    ?C                   If        WWFKA = 'UPDATE  '  or                       ENTER
037800100819    ?C                             WWFKA = 'ENTER   '                           ENTER
037900000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
038000000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
038100000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
038200100817     C                   Z-add     WSBEDT        PABEDT
038300100817     C                   Z-add     WSENDT        PAENDT
038400100817 001?C                   Call      'CHKANC  '                                   CHECK DATA
038500100819 001?C                   Parm      'EDIT4   '    WWRQS                          EDIT REQUEST
038600000000 001?C                   Parm                    WWRTN                          RETURN CODE
038700000614 001?C                   Parm                    WUDTA                          REC DATA
038800100819E001?C                   End                                                    ENDIF
038900100819E001?C                   End                                                    ENDIF
039000000000    ? *
039100000000B001?C                   Select                                                 PRC RETURN CDE
039200000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
039300000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
039400000000 001? *
039500000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
039600000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
039700000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
039800000000X002?C                   Else                                                   ELSE
039900000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
040000000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
040100000000E002?C                   Endif                                                  IF WARNING
040200000000 001? *
040300000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
040400000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
040500000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
040600000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
040700000000E001?C                   Endsl                                                  RETURN CODE SEL
040800000000    ? *
040900000000    ?C                   Endsr                                                  END PRCPNL
041000000000    ? *___________________________________________________________________
041100000000    ? * Process end - write data or release record
041200000000    ? *___________________________________________________________________
041300000000    ?C     PRCEND        Begsr                                                  PROCESS END
041400161011    ? *
041500161011    ? * Prevent update on F1 exit
041600161011     C                   If        WWCHG = 'Y' and
041700161011     C                             WWFKA = 'EXIT'
041800161011     C                   eval      WWCHG = 'N'
041900161011     C                   eval      WWTSK = *blanks
042000161011     C                   end
042100000000    ? *
042200000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
042300000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
042400000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
042500000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
042600000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
042700000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
042800000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
042900000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
043000000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
043100000000 001?C                   Endcs                                                  END CASE
043200000000 001? *
043300000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
043400000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
043500000000 002? *
043600000000X002?C                   Else                                                   ELSE NO WRT ERR
043700000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
043800000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
043900000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
044000000000 004?C                   Exsr      PRPPNL                                       DO NOT END
044100000810E004?C                   Endif                                                  END IF ADD
044200000000E003?C                   Endif                                                  END IF NOT END
044300000000E002?C                   Endif                                                  END IF WRITE ERROR
044400000000 001? *
044500000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
044600000000 001?C                   Exsr      RELREC                                       RELEASE REC
044700000000E001?C                   Endif                                                  END IF RCD CHANGED
044800000000    ? *
044900000000    ?C                   Endsr                                                  END PRCEND
045000000000    ? *___________________________________________________________________
045100000000    ? * Add new record
045200000000    ? *___________________________________________________________________
045300000000    ?C     WRTADD        Begsr                                                  WRITE ADD
045400000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
045500000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
045600000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
045700000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
045800000000E001?C                   Endif                                                  END IF ADD
045900000000    ? *
046000000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
046100000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
046200000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
046300000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
046400000000E001?C                   Endif                                                  END IF ADD KEY
046500000000    ? *
046600100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
046700000000    ?C                   Parm                    WWRQS                          ADD RECORD
046800000000    ?C                   Parm                    WWRTN                          RETURN CODE
046900000614    ?C                   Parm                    WUDTA                          REC DATA
047000000000    ? *
047100100526B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
047200100526 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
047300100526 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047400100526X001?C                   Else                                                   ELSE
047500100526E001?C                   Endif                                                  END IF CALL ERROR
047600000000    ? *
047700000000    ?C                   Endsr                                                  END WRTADD
047800000000    ? *___________________________________________________________________
047900000000    ? * Write changed record
048000000000    ? *___________________________________________________________________
048100000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
048200100825      *
048300100825      * Reset Other Formulas
048400100825     C                   Clear                   PASALM
048500100928     C                   Clear                   PAVARI
048600100825     C                   Clear                   PALRND
048700100825     C                   Clear                   PALABR
048800100928     C                   Clear                   PASPSL
048900100928     C                   Clear                   PAGISS
049000090309      *
049100100921     C                   Select
049200130430     C                   When      WIRQS = 'CHANGER'
049300140606     C                   Eval      PAFORM = 'LTDRNG    '
049400100921     C                   Endsl
049500100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
049600000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
049700000000    ?C                   Parm                    WWRTN                          RETURN CODE
049800000614    ?C                   Parm                    WUDTA                          REC DATA
049900100526B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
050000100526 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
050100100526 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
050200100526E001?C                   Endif                                                  END IF CALL ERROR
050300000000    ? *
050400000000    ?C                   Endsr                                                  END WRTCHG
050500000000    ? *___________________________________________________________________
050600000000    ? * Release record
050700000000    ? *___________________________________________________________________
050800000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
050900100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
051000000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
051100000000    ?C                   Parm                    WWRTN                          RETURN CODE
051200000614    ?C                   Parm                    WUDTA                          REC DATA
051300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
051400000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
051500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
051600000000E001?C                   Endif                                                  END IF CALL ERROR
051700000000    ?C                   Endsr                                                  END RELREC
051800000000    ? *___________________________________________________________________
051900000000    ? * Build function keys
052000000000    ? *___________________________________________________________________
052100000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
052200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
052300991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
052400000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
052500000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
052600000000    ?C                   Parm                    WAD                            FNC DESC
052700991108    ?C                   Parm                    WWIN                           AID BYTE
052800000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
052900000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
053000000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
053100000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
053200000000    ?C                   Sub       1             WW                             BUMP IDX
053300000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
053400000000    ?C                   Endsr                                                  END BLD FNCTNS
053500000000    ? *___________________________________________________________________
053600000000    ? * Send message
053700000000    ? *___________________________________________________________________
053800000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
053900000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
054000000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
054100000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
054200000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
054300000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
054400000000    ?C                   Endsr                                                  END SNDMSG
054500000000    ? *___________________________________________________________________
054600000000    ? * Paremater list
054700000000    ? *___________________________________________________________________
054800000000    ?C     PLIST         Begsr                                                  PARM LISTS
054900000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
055000000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
055100000000    ?C                   Parm                    WORTN             8            RETURN CODE
055200000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
055300000614    ?C                   Parm                    WUDTA                          RECORD KEY
055400000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
055500000000    ?C                   Endsr                                                  END PLIST
055600050318    ? *___________________________________________________________________
055700050318    ? * Key lists
055800050318    ? *___________________________________________________________________
055900050318    ?C     KLIST         Begsr                                                  KEY LISTS
056000100506    ?C     PKey          Klist                                                  ACKCTL
056100100817    ?C                   Kfld                    PATRST
056200100817    ?C                   Kfld                    PASUB#
056300100817    ?C                   Kfld                    PAPLAN                         POSITION TO 1
056400100506    ?C     SKey          Klist                                                  ACKCTL
056500100817    ?C                   Kfld                    PATRST
056600100817    ?C                   Kfld                    PASUB#
056700050318    ?C                   Endsr                                                  END KLIST
056800000000    ? *___________________________________________________________________
056900000000    ? * Initialize routine
057000000000    ? *___________________________________________________________________
057100000000    ?C     *INZSR        Begsr                                                  INITIALIZE
057200000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
057300000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
057400000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
057500000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
057600000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
057700000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
057800000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
057900000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
058000000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
058100100506     C                   Clear                   SV$AMT            5 2
058200000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
058300000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
058400000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
058500000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
058600000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
058700000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
058800000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
058900000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
059000000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
059100000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
059200000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
059300000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
059400000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
059500000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
059600000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
059700000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
059800100817    ?C                   Movel     'CHGANC  '    WWFIL            10            FILE NAME-NOTES
059900000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
060000000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
060100000000    ?C                   Endsr                                                  END INITIALIZE
060200000000    ? *___________________________________________________________________
060300000000    ? * Program error handler
060400000000    ? *___________________________________________________________________
060500000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
060600000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
060700000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
060800000000    ?C                   Parm                    WQSTSC                         STATUS CODE
060900000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
061000000000    ?C                   Parm                    WQMSG                          MESSAGE ID
061100000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
061200000000    ? *___________________________________________________________________
061300000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06140010081701EXIT    F1=Return
06150000000005REFRESH F5=Refresh
06160000070710UPDATE  F10=Update
06170000061412CANCEL  F12=Cancel
06180000000025ROLLUP
06190000000026ROLLDOWN
062000000000** WTM
06210010081700Request not supported in program CHGANC.
06220000000000Update error.  Data was not updated.
06230010052600Update error.  Data was not updated.
06240000000000Call to notes ended in error.
06250000000000Initialize error.  Record not initialized.
06260000000000Record not found.
06270000000000Generate error.  Key not generated.
06280000000000Record not available now.
06290000000000The cursor is not in a prompt area.
06300000000000Default error.  Data not defaulted.
