000100090707
000200090707    ?FADDCCOD   CF   E             WORKSTN
000300000000    ?F                                     INFDS(DSPD)
000400090707     FACCMST    IF   E           K Disk
000500000000    ? *
000600000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
000700000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
000800000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
000900000000    ? *_________________________________________________________________________
001000000406    ? * Data structure
001100090707    ?D WUDTA         E DS                  EXTNAME(ODCCTLP)
001200000000    ? *
001300000000    ? * Program status data structure
001400991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001500000000    ? *
001600000000    ? * Display file data structure
001700991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
001800000000    ? *
001900000000    ? * CURSOR LOCATION
002000000000    ?D                 DS
002100000000    ?D  WWCRSL                 1      2
002200000000    ?D  WWCRSN                 1      2B 0
002300090309     D HstTracker      DS
002400090309     D  Rout                   1      1
002500090309     D  Act#                   2      2
002600090309     D  CSF                    3      3
002700090309     D  PreN                   4      4
002800090601     D  BegDt                  5      5
002900090601     D  EndDt                  6      6
003000090601     D  SaveField              6     64
003100090309     D   SaveRout              6     20
003200090611     D   SaveAct#             21     38
003300090611     D   SaveCSF              39     45
003400090611     D   SavePreN             46     60
003500090611     D   SaveBegDt            61     70
003600090611     D   SaveEndDt            71     85
003700090309    ? *
003800090707     D WWTRST          S                   LIKE(CCTRST)
003900090707     D WWSUB#          S                   LIKE(CCSUB#)
004000090707     D WWACCT          S                   LIKE(CCACCT)
004100000000    ? *_________________________________________________________________________
004200000000    ? *
004300000614    ? * Process Entry Panel
004400000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
004500000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
004600000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
004700000000E001?C                   Endif                                                  END COPY/CPYKEY
004800000000    ? *
004900000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005000000000    ? *
005100000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005200000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005300000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
005400000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005500000000 001? *
005600000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
005700000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
005800000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005900000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
006000000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006100000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
006200000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
006300000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
006400000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
006500000000 001?C                   Endcs                                                  END CASE
006600000000 001? *
006700000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
006800000000 002?C                   Exsr      PRCEND                                       PROCESS END
006900000000E002?C                   Endif                                                  END IF END REQ
007000000000E001?C                   Enddo                                                  END DOWHILE
007100000000    ? *
007200000707    ? * Send Info Updated message.
007300000707     C     WwChg         Ifeq      'Y'
007400000707     C                   Movel     'UPDATE  '    WORTN
007500000707     C                   Endif
007600000707    ? *
007700000000    ?C                   Return                                                 RETURN
007800000000    ? *___________________________________________________________________
007900000000    ? * Prepare panel
008000000000    ? *___________________________________________________________________
008100000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008200000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
008300991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008400000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008500000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008600000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008700000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008800000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008900000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
009000000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
009100000000    ? *
009200000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
009300000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009400000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009500000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009600000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009700000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009800050318      *
009900090707     C                   Eval      WWTRST = CCTRST
010000090707     C                   Eval      WWSUB# = CCSUB#
010100090707     C                   Eval      WWACCT = CCACCT
010200090707     C                   Movel     CCTRST        Trst              3
010300090707     C                   Movel     CCSUB#        Sub#              3
010400090707     C                   Movel     CCACCT        Acct              4
010500090224     C     AKey          Chain     ACCMST
010600050318     C                   If        %Found(ACCMST)
010700050318     C                   Eval      WWNAME  = %trim(Trst) + '-'   +
010800050318     C                                       %trim(Sub#) + '-'   +
010900050318     C                                       %trim(Acct) + '  '  +
011000050318     C                                       %trim(ACNAM1)
011100050318     C                   Movel(P)  WWNAME        WISTR
011200051028     C                   Z-add     60            WILEN
011300050318     C                   Call      'UTLCENSTR'
011400050318     C                   Parm                    WISTR           256
011500050318     C                   Parm                    WILEN             3 0
011600050318     C                   Movel     WISTR         WWNAME
011700050318     C                   End
011800000000    ? *
011900000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
012000000000    ? *
012100000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
012200090707    ?C     WWTSK         Caseq     'ADDCCO  '    PRPADD                         PREP FOR ADD
012300000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
012400000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
012500000000    ?C                   Cas                     PRCERR                         PROC ERROR
012600000000    ?C                   Endcs                                                  END CASE
012700000000    ? *
012800000000    ?C                   Endsr                                                  END PRPPNL
012900000000    ? *___________________________________________________________________
013000000000    ? * Prepare ADD request
013100000000    ? *___________________________________________________________________
013200000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
013300090707    ?C                   Clear                   CCCCOD                         CLEAR RECORD
013400090707    ?C                   Clear                   CCTITL                         CLEAR RECORD
013500000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
013600000000    ?C                   Endsr                                                  END PRP ADD
013700000000    ? *___________________________________________________________________
013800000000    ? * Prepare CHANGE request
013900000000    ? *___________________________________________________________________
014000000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
014100090707    ?C                   Call      'UPDCCO  '                                   PROCESS REC IO
014200000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
014300000000    ?C                   Parm                    WWRTN                          RETURN CODE
014400000614    ?C                   Parm                    WUDTA                          REC DATA
014600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014700000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
014800000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
014900000000X002?C                   Else                                                   ELSE
015000000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
015100000000E002?C                   Endif                                                  END RCD NOT AVL
015200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
015300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015500000810E001?C                   Else                                                   END IF ERROR
015600000810E001?C                   Endif                                                  END IF ERROR
015700000000    ?C                   Endsr                                                  END PRP CHANGE
015800000000    ? *___________________________________________________________________
015900000000    ? * Prepare COPY request
016000000000    ? *___________________________________________________________________
016100000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
016200000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
016300090707    ?C                   Call      'UPDCCO  '                                   PROCESS REC IO
016400000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
016500000000    ?C                   Parm                    WWRTN                          RETURN CODE
016600000614    ?C                   Parm                    WUDTA                          REC DATA
016800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016900000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
017000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
017100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017200000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
017300000000X001?C                   Else                                                   ELSE
017400000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
017500000000E001?C                   Endif                                                  END IF ERROR
017600000000    ?C                   Endsr                                                  END PREP COPY
017700000000    ? *___________________________________________________________________
017800000000    ? * Default Data
017900000000    ? *___________________________________________________________________
018000000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
018100090707    ?C                   Call      'CHKCCO  '                                   PROCESS REC IO
018200000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
018300000000    ?C                   Parm                    WWRTN                          RETURN CODE
018400000614    ?C                   Parm                    WUDTA                          REC DATA
018500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
018600000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
018700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018800000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018900000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
019000000000E001?C                   Endif                                                  END IF ERROR
019100000000    ?C                   Endsr                                                  END DFTDTA
019200000000    ? *___________________________________________________________________
019300000000    ? * Process ERROR function
019400000000    ? *___________________________________________________________________
019500000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
019600000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
019700000000    ?C                   Exsr      SNDMSG                                       SEND MSG
019800000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019900000000    ?C                   Move      'END'         WWSTT                          END STATE
020000000000    ?C                   Endsr                                                  END PRCERR
020100000000    ? *___________________________________________________________________
020200000000    ? * Receive messages
020300000000    ? *___________________________________________________________________
020400000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
020500000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
020600000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
020700000000X001?C                   Else                                                   ELSE
020800000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
020900000000E001?C                   Endif                                                  ENDIF NOT NORESET
021000000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
021100000000    ?C                   Movea     *IN           WWIN                           INDICATORS
021200000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
021300000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
021400000000    ?C                   Parm                    WWIN                           INDICATORS
021500000000    ?C                   Parm                    WWRTN                          RETURN CODE
021600000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
021700000000    ?C                   Endsr                                                  END RCV MSG
021800000000    ? *___________________________________________________________________
021900000000    ? * Display panels
022000000000    ? *___________________________________________________________________
022100000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
022200000000    ? *
022300000000    ? * Set PUTOVR based on last display file processed
022400000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
022500000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
022600000000 001?C                   Setoff                                       35        PUTOVR OFF
022700000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
022800000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
022900000000X001?C                   Else                                                   ELSE SAME PGM
023000000000 001?C                   Seton                                        35        PUTOVR ON
023100000000E001?C                   Endif                                                  END IF NEW PGM
023200000000    ? *
023300000614    ? * Set PROTECT key based on request
023400090707B001?C     WWTSK         Ifeq      'ADDCCO'                                     IF ADD
023500000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
023600000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
023700000000 001?C                   Setoff                                       40        NO PROTECT KEY
023800000000X001?C                   Else                                                   ELSE
023900000000 001?C                   Seton                                        40        PROTECT KEY
024000000000E001?C                   Endif                                                  END IF ADD
024100000000    ? *
024200000000    ? * Select title
024300000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
024400000000 001?C                   Setoff                                       38        CHANGE TITLE
024500000000X001?C                   Else                                                   ELSE
024600000000 001?C                   Seton                                        38        ADD TITLE
024700000000E001?C                   Endif                                                  END IF CHANGE
024800000000    ? *
024900000000    ? * Position cursor based on error status
025000000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
025100000000 001?C                   Seton                                        99        POS CSR TO ERROR
025200000000X001?C                   Else                                                   ELSE
025300000000 001?C                   Setoff                                       99        POS CSR TO FIRST
025400000000E001?C                   Endif                                                  END IF ERROR
025500000000    ? *
025600000000    ? * Write message subfile
025700000000    ?C                   Seton                                        30        MSGSFL DISPLAY
025800000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
025900000000    ? *
026000000000    ? * Write entry panel
026100000000B001?C                   Select
026200000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
026300000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
026400000000 001?C                   Setoff                                       37        RESET CRSLOC
026500000000E001?C                   Endsl                                                  END SELECT
026600000000    ? *
026700000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
026800000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
026900000000E001?C                   Endif                                                  END IF DATA CHG
027000000000    ?C                   Endsr                                                  END DSPENT
027100000000    ? *___________________________________________________________________
027200000000    ? * Process function key
027300000000    ? *___________________________________________________________________
027400000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
027500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
027600991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
027700000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
027800000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
027900000000    ?C                   Parm                    WAD                            FNC DESC
028000991108    ?C                   Parm                    WWIN                           AID BYTE
028100000000    ?C                   Parm                    WAF                            FNC KEY TABLE
028200000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
028300000000    ?C                   Endsr                                                  END PRCFKY
028400000000    ? *___________________________________________________________________
028500000000    ? * Process KEYS function
028600000000    ? *___________________________________________________________________
028700000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
028800000000    ?C                   Z-add     1             WW                             KEY DSC IDX
028900000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
029000000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
029100000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
029200000000 001? *
029300000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
029400000000 002?C                   Z-add     1             WWFKS                          SET TO 1
029500000000E002?C                   Endif                                                  END IF OVER 3
029600000000 001? *
029700000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
029800000000 001?C                   Sub       1             WW                             KEY DESCR IDX
029900000000E001?C                   Enddo                                                  END DO KEYS
030000000000    ? *
030100000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
030200000000    ?C                   Add       1             WW                             BUMP IDX
030300000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
030400000000    ?C                   Endsr                                                  END PRCDKY
030500000000    ? *___________________________________________________________________
030600000000    ? * Process EXIT Function
030700000000    ? *___________________________________________________________________
030800000000    ?C     PRCEXT        Begsr                                                  RETURN
030900000000    ? *
031000000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
031100000000    ? *
031200000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
031300000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
031400000000X001?C                   Else                                                   ELSE NO ERRORS
031500000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
031600000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
031700000000E001?C                   Endif                                                  END IF ERRORS
031800000000    ?C                   Endsr                                                  END PRCEXT
031900000000    ? *___________________________________________________________________
032000000000    ? * Process PROMPT function
032100000000    ? *___________________________________________________________________
032200000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
032300000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
032400000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
032500000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
032600000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
032700000000    ? *
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
036900000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
037000000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
037100000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
037200090707 001?C                   Call      'CHKCCO  '                                   CHECK DATA
037300000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
037400000000 001?C                   Parm                    WWRTN                          RETURN CODE
037500000614 001?C                   Parm                    WUDTA                          REC DATA
037600000000E001?C                   Endif                                                  ENDIF
037700000000    ? *
037800000000B001?C                   Select                                                 PRC RETURN CDE
037900000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
038000000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
038100000000 001? *
038200000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
038300000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
038400000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
038500000000X002?C                   Else                                                   ELSE
038600000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
038700000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
038800000000E002?C                   Endif                                                  IF WARNING
038900000000 001? *
039000000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
039100000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
039200000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
039300000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
039400000000E001?C                   Endsl                                                  RETURN CODE SEL
039500000000    ? *
039600000000    ?C                   Endsr                                                  END PRCPNL
039700000000    ? *___________________________________________________________________
039800000000    ? * Process end - write data or release record
039900000000    ? *___________________________________________________________________
040000000000    ?C     PRCEND        Begsr                                                  PROCESS END
040100000000    ? *
040200000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
040300000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
040400090707 001?C     WWTSK         Caseq     'ADDCCO  '    WRTADD                         WRITE ADD
040500000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
040600000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
040700000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
040800000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
040900000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
041000000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
041100000000 001?C                   Endcs                                                  END CASE
041200000000 001? *
041300000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
041400000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
041500000000 002? *
041600000000X002?C                   Else                                                   ELSE NO WRT ERR
041700000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
041800000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
041900000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
042000000000 004?C                   Exsr      PRPPNL                                       DO NOT END
042100000810E004?C                   Endif                                                  END IF ADD
042200000000E003?C                   Endif                                                  END IF NOT END
042300000000E002?C                   Endif                                                  END IF WRITE ERROR
042400000000 001? *
042500000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
042600000000 001?C                   Exsr      RELREC                                       RELEASE REC
042700000000E001?C                   Endif                                                  END IF RCD CHANGED
042800000000    ? *
042900000000    ?C                   Endsr                                                  END PRCEND
043000000000    ? *___________________________________________________________________
043100000000    ? * Add new record
043200000000    ? *___________________________________________________________________
043300000000    ?C     WRTADD        Begsr                                                  WRITE ADD
043400090707B001?C     WWTSK         Ifeq      'ADDCCO '                                    IF ADD
043500000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
043600000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
043700090707 001?C                   Movel     'ADDCCO '     WWRQS                          THEN ADD RCD
043800000000E001?C                   Endif                                                  END IF ADD
043900000000    ? *
044000000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
044100000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
044200000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
044300000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
044400000000E001?C                   Endif                                                  END IF ADD KEY
044500000000    ? *
044600090707    ?C                   Call      'UPDCCO  '                                   PROCESS REC IO
044700000000    ?C                   Parm                    WWRQS                          ADD RECORD
044800000000    ?C                   Parm                    WWRTN                          RETURN CODE
044900000614    ?C                   Parm                    WUDTA                          REC DATA
045100000000    ? *
045200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
045300000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
045400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
045500000000X001?C                   Else                                                   ELSE
045600000000E001?C                   Endif                                                  END IF CALL ERROR
045700000000    ? *
045800000000    ?C                   Endsr                                                  END WRTADD
045900000000    ? *___________________________________________________________________
046000000000    ? * Write changed record
046100000000    ? *___________________________________________________________________
046200000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
046300090707    ?C                   Call      'UPDCCO  '                                   PROCESS REC IO
046400000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
046500000000    ?C                   Parm                    WWRTN                          RETURN CODE
046600000614    ?C                   Parm                    WUDTA                          REC DATA
046800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
046900070614 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
047000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047100000000E001?C                   Endif                                                  END IF CALL ERROR
047200000000    ? *
047300000000    ?C                   Endsr                                                  END WRTCHG
047400000000    ? *___________________________________________________________________
047500000000    ? * Release record
047600000000    ? *___________________________________________________________________
047700000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
047800090707    ?C                   Call      'UPDCCO  '                                   PROCESS REC IO
047900000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
048000000000    ?C                   Parm                    WWRTN                          RETURN CODE
048100000614    ?C                   Parm                    WUDTA                          REC DATA
048300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
048400000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
048500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
048600000000E001?C                   Endif                                                  END IF CALL ERROR
048700000000    ?C                   Endsr                                                  END RELREC
048800000000    ? *___________________________________________________________________
048900000000    ? * Build function keys
049000000000    ? *___________________________________________________________________
049100000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
049200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
049300991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
049400000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
049500000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
049600000000    ?C                   Parm                    WAD                            FNC DESC
049700991108    ?C                   Parm                    WWIN                           AID BYTE
049800000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
049900000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
050000000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
050100000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
050200000000    ?C                   Sub       1             WW                             BUMP IDX
050300000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
050400000000    ?C                   Endsr                                                  END BLD FNCTNS
050500000000    ? *___________________________________________________________________
050600000000    ? * Send message
050700000000    ? *___________________________________________________________________
050800000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
050900000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
051000000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
051100000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
051200000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
051300000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
051400000000    ?C                   Endsr                                                  END SNDMSG
051500000000    ? *___________________________________________________________________
051600000000    ? * Paremater list
051700000000    ? *___________________________________________________________________
051800000000    ?C     PLIST         Begsr                                                  PARM LISTS
051900000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
052000000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
052100000000    ?C                   Parm                    WORTN             8            RETURN CODE
052200000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
052300000614    ?C                   Parm                    WUDTA                          RECORD KEY
052400000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
052600000000    ?C                   Endsr                                                  END PLIST
052700050318    ? *___________________________________________________________________
052800050318    ? * Key lists
052900050318    ? *___________________________________________________________________
053000050318    ?C     KLIST         Begsr                                                  KEY LISTS
053100050318    ?C     AKey          Klist                                                  ACKCTL
053200090707    ?C                   Kfld                    CCTRST
053300090707    ?C                   Kfld                    CCSUB#
053400090707    ?C                   Kfld                    CCACCT                         POSITION TO 1
053500090226    ?C     AccKey        Klist                                                  ACKCTL
053600090226    ?C                   Kfld                    ACTRST
053700090226    ?C                   Kfld                    ACSUB#
053800090226    ?C                   Kfld                    ACACCT                         POSITION TO 1
053900050318    ?C                   Endsr                                                  END KLIST
054000000000    ? *___________________________________________________________________
054100000000    ? * Initialize routine
054200000000    ? *___________________________________________________________________
054300000000    ?C     *INZSR        Begsr                                                  INITIALIZE
054400000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
054500000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
054600000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
054700000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
054800000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
054900000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
055000000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
055100000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
055200000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
055300000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
055400000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
055500000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
055600000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
055700000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
055800000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
055900000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
056000000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
056100000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
056200000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
056300000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
056400000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
056500000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
056600000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
056700000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
056800000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
056900090707    ?C                   Movel     'ODCCTLP '    WWFIL            10            FILE NAME-NOTES
057000000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
057100000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
057200000000    ?C                   Endsr                                                  END INITIALIZE
057300000000    ? *___________________________________________________________________
057400000000    ? * Program error handler
057500000000    ? *___________________________________________________________________
057600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
057700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
057800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
057900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
058000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
058100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
058200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
058300000000    ? *___________________________________________________________________
058400000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05850000000003EXIT    F3=Exit
05860000000005REFRESH F5=Refresh
05870000070710UPDATE  F10=Update
05880000061412CANCEL  F12=Cancel
05890000000025ROLLUP
05900000000026ROLLDOWN
059100000000** WTM
05920009070700Request not supported in program ADDCCO.
05930000000000Update error.  Data was not updated.
05940009070700
05950000000000Call to notes ended in error.
05960000000000Initialize error.  Record not initialized.
05970000000000Record not found.
05980000000000Generate error.  Key not generated.
05990000000000Record not available now.
06000000000000The cursor is not in a prompt area.
06010000000000Default error.  Data not defaulted.
