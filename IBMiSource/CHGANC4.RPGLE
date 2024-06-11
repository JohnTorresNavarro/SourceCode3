000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300100817    ? *  Description:  Change Ancillary Product Formulas
000400000000    ? *
000500100506    ? *  (c)Copyright 2010 by GBS,Inc.
000600051028    ? *
000700051028    ? *_________________________________________________________________________
000800100819    ?FCHGANC4D  CF   E             WORKSTN
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
004000100921B001?C                   if        WWTSK  =  'CHANGEB' or                       IF COPY
004100100921B001?C                             WWTSK  =  'CHANGES'                          IF COPY
004200100921     C                   Eval      WWTSK  =  'CHANGE '
004300100921E001?C                   Endif                                                  END COPY/CPYKEY
004400100921    ? *
004500000614    ? * Process Entry Panel
004600000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
004700000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
004800000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
004900000000E001?C                   Endif                                                  END COPY/CPYKEY
005000000000    ? *
005100000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005200000000    ? *
005300000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005400000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005500000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
005600000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005700000000 001? *
005800000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
005900000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
006000000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
006100000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
006200000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006300000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
006400000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
006500000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
006600000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
006700000000 001?C                   Endcs                                                  END CASE
006800000000 001? *
006900000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
007000000000 002?C                   Exsr      PRCEND                                       PROCESS END
007100000000E002?C                   Endif                                                  END IF END REQ
007200000000E001?C                   Enddo                                                  END DOWHILE
007300000000    ? *
007400000707    ? * Send Info Updated message.
007500000707     C     WwChg         Ifeq      'Y'
007600000707     C                   Movel     'UPDATE  '    WORTN
007700000707     C                   Endif
007800000707    ? *
007900000000    ?C                   Return                                                 RETURN
008000000000    ? *___________________________________________________________________
008100000000    ? * Prepare panel
008200000000    ? *___________________________________________________________________
008300000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008400000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
008500050317    ?C                   Move      *ZEROS        WSBEDT                         RETURN CODE
008600050317    ?C                   Move      *ZEROS        WSENDT                         RETURN CODE
008700991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008800000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008900000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
009000000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
009100000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
009200000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
009300000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
009400000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
009500000000    ? *
009600000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
009700000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009800000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009900000000E002?C                   Endif                                                  ENDIF SAME REQUEST
010000000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
010100000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
010200050318      *
010300100818     C                   Eval      WSRULE = PARULE
010400100817     C                   Movel     PATRST        Trst              3
010500100817     C                   Movel     PASUB#        Sub#              3
010600100817     C                   Movel     PAPLAN        Plan              4
010700100817     C     PATRST        Chain     TRSMST
010800100506     C     SKey          Chain     SUBMST
010900100506     C     PKey          Chain     PLNMST
011000100506     C     PCARR         Chain     CARMST
011100100506     C                   If        %Found(PLNMST)
011200100506     C                   Eval      WWTRSD = %Trim(Trst  + ' ' + %Trim(TNAME))
011300100506     C                   Eval      WWSUBD = %Trim(Sub#  + ' ' + %Trim(SUBNAM))
011400100506     C                   Eval      WWPLND = %Trim(Plan  + ' ' + %Trim(PDESCR))
011500100506     C                   Eval      WWCARD = %Trim(PCARR + ' ' + %Trim(CNAME))
011600050318     C                   End
011700000000    ? *
011800000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
011900000000    ? *
012000000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
012100000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
012200000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
012300000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
012400000000    ?C                   Cas                     PRCERR                         PROC ERROR
012500000000    ?C                   Endcs                                                  END CASE
012600000000    ? *
012700000000    ?C                   Endsr                                                  END PRPPNL
012800000000    ? *___________________________________________________________________
012900000000    ? * Prepare ADD request
013000000000    ? *___________________________________________________________________
013100000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
013200100817    ?C                   Clear                   PAFIXA                         CLEAR RECORD
013300100817    ?C                   Clear                   PAPPBE                         CLEAR RECORD
013400000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
013500000000    ?C                   Endsr                                                  END PRP ADD
013600000000    ? *___________________________________________________________________
013700000000    ? * Prepare CHANGE request
013800000000    ? *___________________________________________________________________
013900000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
014000100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
014100000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
014200000000    ?C                   Parm                    WWRTN                          RETURN CODE
014300000614    ?C                   Parm                    WUDTA                          REC DATA
014400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014500000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
014600000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
014700000000X002?C                   Else                                                   ELSE
014800000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014900000000E002?C                   Endif                                                  END RCD NOT AVL
015000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
015100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015200000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015300000810E001?C                   Else                                                   END IF ERROR
015400100817     C     PABEDT        MULT      10000.0001    WSBEDT
015500100817     C     PAENDT        MULT      10000.0001    WSENDT
015600000810E001?C                   Endif                                                  END IF ERROR
015700000000    ?C                   Endsr                                                  END PRP CHANGE
015800000000    ? *___________________________________________________________________
015900000000    ? * Prepare COPY request
016000000000    ? *___________________________________________________________________
016100000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
016200000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
016300100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
016400000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
016500000000    ?C                   Parm                    WWRTN                          RETURN CODE
016600000614    ?C                   Parm                    WUDTA                          REC DATA
016700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016800000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
016900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
017000000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017100000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
017200000000X001?C                   Else                                                   ELSE
017300000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
017400100817     C     PABEDT        MULT      10000.0001    WSBEDT
017500100817     C     PAENDT        MULT      10000.0001    WSENDT
017600000000E001?C                   Endif                                                  END IF ERROR
017700000000    ?C                   Endsr                                                  END PREP COPY
017800000000    ? *___________________________________________________________________
017900000000    ? * Default Data
018000000000    ? *___________________________________________________________________
018100000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
018200100817    ?C                   Call      'CHKANC  '                                   PROCESS REC IO
018300000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
018400000000    ?C                   Parm                    WWRTN                          RETURN CODE
018500000614    ?C                   Parm                    WUDTA                          REC DATA
018600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
018700000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
018800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018900000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019000000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
019100000000E001?C                   Endif                                                  END IF ERROR
019200000000    ?C                   Endsr                                                  END DFTDTA
019300000000    ? *___________________________________________________________________
019400000000    ? * Process ERROR function
019500000000    ? *___________________________________________________________________
019600000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
019700000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
019800000000    ?C                   Exsr      SNDMSG                                       SEND MSG
019900000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
020000000000    ?C                   Move      'END'         WWSTT                          END STATE
020100000000    ?C                   Endsr                                                  END PRCERR
020200000000    ? *___________________________________________________________________
020300000000    ? * Receive messages
020400000000    ? *___________________________________________________________________
020500000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
020600000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
020700000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
020800000000X001?C                   Else                                                   ELSE
020900000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
021000000000E001?C                   Endif                                                  ENDIF NOT NORESET
021100000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
021200000000    ?C                   Movea     *IN           WWIN                           INDICATORS
021300000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
021400000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
021500000000    ?C                   Parm                    WWIN                           INDICATORS
021600000000    ?C                   Parm                    WWRTN                          RETURN CODE
021700000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
021800000000    ?C                   Endsr                                                  END RCV MSG
021900000000    ? *___________________________________________________________________
022000000000    ? * Display panels
022100000000    ? *___________________________________________________________________
022200000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
022300000000    ? *
022400000000    ? * Set PUTOVR based on last display file processed
022500000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
022600000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
022700000000 001?C                   Setoff                                       35        PUTOVR OFF
022800000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
022900000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
023000000000X001?C                   Else                                                   ELSE SAME PGM
023100000000 001?C                   Seton                                        35        PUTOVR ON
023200000000E001?C                   Endif                                                  END IF NEW PGM
023300000000    ? *
023400000614    ? * Set PROTECT key based on request
023500000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
023600000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
023700000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
023800000000 001?C                   Setoff                                       40        NO PROTECT KEY
023900000000X001?C                   Else                                                   ELSE
024000000000 001?C                   Seton                                        40        PROTECT KEY
024100000000E001?C                   Endif                                                  END IF ADD
024200000000    ? *
024300000000    ? * Select title
024400000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
024500000000 001?C                   Setoff                                       38        CHANGE TITLE
024600000000X001?C                   Else                                                   ELSE
024700000000 001?C                   Seton                                        38        ADD TITLE
024800000000E001?C                   Endif                                                  END IF CHANGE
024900100921    ? *
025000100921B001?C                   if        WIRQS  =  'CHANGEB'                          IF COPY
025100100921 001?C                   Seton                                        75        CHANGE TITLE
025200100921X001?C                   Else                                                   ELSE
025300100921 001?C                   Setoff                                       75        ADD TITLE
025400100921E001?C                   Endif                                                  END COPY/CPYKEY
025500000000    ? *
025600000000    ? * Position cursor based on error status
025700000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
025800000000 001?C                   Seton                                        99        POS CSR TO ERROR
025900000000X001?C                   Else                                                   ELSE
026000000000 001?C                   Setoff                                       99        POS CSR TO FIRST
026100000000E001?C                   Endif                                                  END IF ERROR
026200000000    ? *
026300000000    ? * Write message subfile
026400000000    ?C                   Seton                                        30        MSGSFL DISPLAY
026500000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
026600000000    ? *
026700000000    ? * Write entry panel
026800000000B001?C                   Select
026900000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
027000000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
027100000000 001?C                   Setoff                                       37        RESET CRSLOC
027200000000E001?C                   Endsl                                                  END SELECT
027300000000    ? *
027400000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
027500000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
027600000000E001?C                   Endif                                                  END IF DATA CHG
027700000000    ?C                   Endsr                                                  END DSPENT
027800000000    ? *___________________________________________________________________
027900000000    ? * Process function key
028000000000    ? *___________________________________________________________________
028100000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
028200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
028300991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
028400000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
028500000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
028600000000    ?C                   Parm                    WAD                            FNC DESC
028700991108    ?C                   Parm                    WWIN                           AID BYTE
028800000000    ?C                   Parm                    WAF                            FNC KEY TABLE
028900000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
029000000000    ?C                   Endsr                                                  END PRCFKY
029100000000    ? *___________________________________________________________________
029200000000    ? * Process KEYS function
029300000000    ? *___________________________________________________________________
029400000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
029500000000    ?C                   Z-add     1             WW                             KEY DSC IDX
029600000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
029700000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
029800000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
029900000000 001? *
030000000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
030100000000 002?C                   Z-add     1             WWFKS                          SET TO 1
030200000000E002?C                   Endif                                                  END IF OVER 3
030300000000 001? *
030400000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
030500000000 001?C                   Sub       1             WW                             KEY DESCR IDX
030600000000E001?C                   Enddo                                                  END DO KEYS
030700000000    ? *
030800000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
030900000000    ?C                   Add       1             WW                             BUMP IDX
031000000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
031100000000    ?C                   Endsr                                                  END PRCDKY
031200000000    ? *___________________________________________________________________
031300000000    ? * Process EXIT Function
031400000000    ? *___________________________________________________________________
031500000000    ?C     PRCEXT        Begsr                                                  RETURN
031600000000    ? *
031700000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
031800000000    ? *
031900000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
032000000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
032100000000X001?C                   Else                                                   ELSE NO ERRORS
032200000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
032300000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
032400000000E001?C                   Endif                                                  END IF ERRORS
032500000000    ?C                   Endsr                                                  END PRCEXT
032600000000    ? *___________________________________________________________________
032700000000    ? * Process PROMPT function
032800000000    ? *___________________________________________________________________
032900000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
033000000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
033100000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
033200000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
033300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
033400100817    ? *
033500100817    ? *
033600100817    ? * HERE
033700100817    ? *
033800100526    ? *
033900000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
034000000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
034100000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
034200000000    ?C                   Mvr                     WSLIN                          CURSOR COL
034300000000    ?C                   Seton                                        37        SET ON CRSLOC
034400000000    ? *
034500000000    ?C                   Endsr                                                  END PRCPMT
034600000000    ? *___________________________________________________________________
034700000000    ? * Process CANCEL Function
034800000000    ? *___________________________________________________________________
034900000000    ?C     PRCCNL        Begsr                                                  CANCEL
035000000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
035100000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
035200000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
035300000000    ?C                   Endsr                                                  END RETURN
035400000000    ? *___________________________________________________________________
035500000000    ? * Process ROLLUP function
035600000000    ? *___________________________________________________________________
035700000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
035800000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
035900000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
036000000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
036100000000E001?C                   Endif                                                  END IF GT LST PNL
036200000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
036300000000    ?C                   Endsr                                                  END PRCRUP
036400000000    ? *___________________________________________________________________
036500000000    ? * Process ROLLDOWN function
036600000000    ? *___________________________________________________________________
036700000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
036800000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
036900000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
037000000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
037100000000E001?C                   Endif                                                  END IF LT FST PNL
037200000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
037300000000    ?C                   Endsr                                                  END PRCRDN
037400000000    ? *___________________________________________________________________
037500000000    ? * Process ENTER function
037600000000    ? *___________________________________________________________________
037700000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
037800000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
037900000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
038000100819    ?C                   If        WWFKA = 'UPDATE  '  or                       ENTER
038100100819    ?C                             WWFKA = 'ENTER   '                           ENTER
038200000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
038300000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
038400000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
038500100817     C                   Z-add     WSBEDT        PABEDT
038600100817     C                   Z-add     WSENDT        PAENDT
038700100817 001?C                   Call      'CHKANC  '                                   CHECK DATA
038800100819 001?C                   Parm      'EDIT4   '    WWRQS                          EDIT REQUEST
038900000000 001?C                   Parm                    WWRTN                          RETURN CODE
039000000614 001?C                   Parm                    WUDTA                          REC DATA
039100100819E001?C                   End                                                    ENDIF
039200100819E001?C                   End                                                    ENDIF
039300000000    ? *
039400000000B001?C                   Select                                                 PRC RETURN CDE
039500000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
039600000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
039700000000 001? *
039800000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
039900000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
040000000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
040100000000X002?C                   Else                                                   ELSE
040200000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
040300000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
040400000000E002?C                   Endif                                                  IF WARNING
040500000000 001? *
040600000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
040700000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
040800000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
040900000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
041000000000E001?C                   Endsl                                                  RETURN CODE SEL
041100000000    ? *
041200000000    ?C                   Endsr                                                  END PRCPNL
041300000000    ? *___________________________________________________________________
041400000000    ? * Process end - write data or release record
041500000000    ? *___________________________________________________________________
041600000000    ?C     PRCEND        Begsr                                                  PROCESS END
041700161011    ? *
041800161011    ? * Prevent update on F1 exit
041900161011     C                   If        WWCHG = 'Y' and
042000161011     C                             WWFKA = 'EXIT'
042100161011     C                   eval      WWCHG = 'N'
042200161011     C                   eval      WWTSK = *blanks
042300161011     C                   end
042400000000    ? *
042500000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
042600000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
042700000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
042800000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
042900000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
043000000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
043100000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
043200000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
043300000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
043400000000 001?C                   Endcs                                                  END CASE
043500000000 001? *
043600000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
043700000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
043800000000 002? *
043900000000X002?C                   Else                                                   ELSE NO WRT ERR
044000000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
044100000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
044200000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
044300000000 004?C                   Exsr      PRPPNL                                       DO NOT END
044400000810E004?C                   Endif                                                  END IF ADD
044500000000E003?C                   Endif                                                  END IF NOT END
044600000000E002?C                   Endif                                                  END IF WRITE ERROR
044700000000 001? *
044800000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
044900000000 001?C                   Exsr      RELREC                                       RELEASE REC
045000000000E001?C                   Endif                                                  END IF RCD CHANGED
045100000000    ? *
045200000000    ?C                   Endsr                                                  END PRCEND
045300000000    ? *___________________________________________________________________
045400000000    ? * Add new record
045500000000    ? *___________________________________________________________________
045600000000    ?C     WRTADD        Begsr                                                  WRITE ADD
045700000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
045800000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
045900000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
046000000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
046100000000E001?C                   Endif                                                  END IF ADD
046200000000    ? *
046300000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
046400000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
046500000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
046600000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
046700000000E001?C                   Endif                                                  END IF ADD KEY
046800000000    ? *
046900100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
047000000000    ?C                   Parm                    WWRQS                          ADD RECORD
047100000000    ?C                   Parm                    WWRTN                          RETURN CODE
047200000614    ?C                   Parm                    WUDTA                          REC DATA
047300000000    ? *
047400100526B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
047500100526 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
047600100526 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047700100526X001?C                   Else                                                   ELSE
047800100526E001?C                   Endif                                                  END IF CALL ERROR
047900000000    ? *
048000000000    ?C                   Endsr                                                  END WRTADD
048100000000    ? *___________________________________________________________________
048200000000    ? * Write changed record
048300000000    ? *___________________________________________________________________
048400000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
048500100825      *
048600100825      * Reset Other Formulas
048700100825     C                   Clear                   PASALM
048800100928     C                   Clear                   PAVARI
048900100825     C                   Clear                   PALMIN
049000100825     C                   Clear                   PALRND
049100100825     C                   Clear                   PALABR
049200100928     C                   Clear                   PASPSL
049300100928     C                   Clear                   PAFIXA
049400100928     C                   Clear                   PAINCR
049500100928     C                   Clear                   PAGISS
049600090309      *
049700100921     C                   Select
049800100921     C                   When      WIRQS = 'CHANGEB'
049900100921     C                   Eval      PAFORM = 'STDBEN    '
050000100921     C                   When      WIRQS = 'CHANGES'
050100100921     C                   Eval      PAFORM = 'STDSAL    '
050200100921     C                   Endsl
050300100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
050400000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
050500000000    ?C                   Parm                    WWRTN                          RETURN CODE
050600000614    ?C                   Parm                    WUDTA                          REC DATA
050700100526B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
050800100526 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
050900100526 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
051000100526E001?C                   Endif                                                  END IF CALL ERROR
051100000000    ? *
051200000000    ?C                   Endsr                                                  END WRTCHG
051300000000    ? *___________________________________________________________________
051400000000    ? * Release record
051500000000    ? *___________________________________________________________________
051600000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
051700100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
051800000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
051900000000    ?C                   Parm                    WWRTN                          RETURN CODE
052000000614    ?C                   Parm                    WUDTA                          REC DATA
052100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
052200000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
052300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
052400000000E001?C                   Endif                                                  END IF CALL ERROR
052500000000    ?C                   Endsr                                                  END RELREC
052600000000    ? *___________________________________________________________________
052700000000    ? * Build function keys
052800000000    ? *___________________________________________________________________
052900000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
053000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
053100991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
053200000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
053300000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
053400000000    ?C                   Parm                    WAD                            FNC DESC
053500991108    ?C                   Parm                    WWIN                           AID BYTE
053600000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
053700000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
053800000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
053900000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
054000000000    ?C                   Sub       1             WW                             BUMP IDX
054100000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
054200000000    ?C                   Endsr                                                  END BLD FNCTNS
054300000000    ? *___________________________________________________________________
054400000000    ? * Send message
054500000000    ? *___________________________________________________________________
054600000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
054700000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
054800000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
054900000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
055000000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
055100000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
055200000000    ?C                   Endsr                                                  END SNDMSG
055300000000    ? *___________________________________________________________________
055400000000    ? * Paremater list
055500000000    ? *___________________________________________________________________
055600000000    ?C     PLIST         Begsr                                                  PARM LISTS
055700000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
055800000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
055900000000    ?C                   Parm                    WORTN             8            RETURN CODE
056000000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
056100000614    ?C                   Parm                    WUDTA                          RECORD KEY
056200000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
056300000000    ?C                   Endsr                                                  END PLIST
056400050318    ? *___________________________________________________________________
056500050318    ? * Key lists
056600050318    ? *___________________________________________________________________
056700050318    ?C     KLIST         Begsr                                                  KEY LISTS
056800100506    ?C     PKey          Klist                                                  ACKCTL
056900100817    ?C                   Kfld                    PATRST
057000100817    ?C                   Kfld                    PASUB#
057100100817    ?C                   Kfld                    PAPLAN                         POSITION TO 1
057200100506    ?C     SKey          Klist                                                  ACKCTL
057300100817    ?C                   Kfld                    PATRST
057400100817    ?C                   Kfld                    PASUB#
057500050318    ?C                   Endsr                                                  END KLIST
057600000000    ? *___________________________________________________________________
057700000000    ? * Initialize routine
057800000000    ? *___________________________________________________________________
057900000000    ?C     *INZSR        Begsr                                                  INITIALIZE
058000000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
058100000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
058200000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
058300000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
058400000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
058500000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
058600000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
058700000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
058800000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
058900100506     C                   Clear                   SV$AMT            5 2
059000000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
059100000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
059200000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
059300000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
059400000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
059500000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
059600000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
059700000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
059800000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
059900000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
060000000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
060100000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
060200000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
060300000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
060400000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
060500000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
060600100817    ?C                   Movel     'CHGANC  '    WWFIL            10            FILE NAME-NOTES
060700000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
060800000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
060900000000    ?C                   Endsr                                                  END INITIALIZE
061000000000    ? *___________________________________________________________________
061100000000    ? * Program error handler
061200000000    ? *___________________________________________________________________
061300000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
061400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
061500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
061600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
061700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
061800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
061900000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
062000000000    ? *___________________________________________________________________
062100000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06220010081701EXIT    F1=Return
06230000000005REFRESH F5=Refresh
06240000070710UPDATE  F10=Update
06250000061412CANCEL  F12=Cancel
06260000000025ROLLUP
06270000000026ROLLDOWN
062800000000** WTM
06290010081700Request not supported in program CHGANC.
06300000000000Update error.  Data was not updated.
06310010052600Update error.  Data was not updated.
06320000000000Call to notes ended in error.
06330000000000Initialize error.  Record not initialized.
06340000000000Record not found.
06350000000000Generate error.  Key not generated.
06360000000000Record not available now.
06370000000000The cursor is not in a prompt area.
06380000000000Default error.  Data not defaulted.
