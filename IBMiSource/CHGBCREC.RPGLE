000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010126    ? *  Description:  Change BCREC Records
000400000000    ? *
000500010126    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700010126    ?FCHGBCRECD CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900000000    ? *
001000000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001100000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001200010426    ?D WTM             S             80    DIM(11) CTDATA PERRCD(1)             PANEL MESSAGES
001300000000    ? *_________________________________________________________________________
001400000406    ? * Data structure
001500010126    ?D WUDTA         E DS                  EXTNAME(BCREC)
001600000000    ? *
001700000000    ? * Program status data structure
001800991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001900000000    ? *
002000000000    ? * Display file data structure
002100991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002200000000    ? *
002300000000    ? * CURSOR LOCATION
002400000000    ?D                 DS
002500000000    ?D  WWCRSL                 1      2
002600000000    ?D  WWCRSN                 1      2B 0
002700010129    ? *
002800010129    ?D                 DS
002900010129    ?D  wsdate                 1      8  0  inz
003000010129    ?D  wcefmm                 1      2  0
003100010129    ?D  wcefdd                 3      4  0
003200010129    ?D  wcefyy                 5      8  0
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
011200010126    ?C                   Call      'UPDBCREC'                                   PROCESS REC IO
011300000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
011400000000    ?C                   Parm                    WWRTN                          RETURN CODE
011500000614    ?C                   Parm                    WUDTA                          REC DATA
011600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
011700000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
011800000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
011900000000X002?C                   Else                                                   ELSE
012000000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
012100000000E002?C                   Endif                                                  END RCD NOT AVL
012200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
012300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
012400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
012500000000E001?C                   Endif                                                  END IF ERROR
012600010129     C                   z-add     bcefyy        wcefyy
012700010129     C                   z-add     bcefmm        wcefmm
012800010129     C                   z-add     bcefdd        wcefdd
012900000000    ?C                   Endsr                                                  END PRP CHANGE
013000000000    ? *___________________________________________________________________
013100000000    ? * Prepare COPY request
013200000000    ? *___________________________________________________________________
013300000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
013400000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
013500010126    ?C                   Call      'UPDBCREC'                                   PROCESS REC IO
013600000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
013700000000    ?C                   Parm                    WWRTN                          RETURN CODE
013800000614    ?C                   Parm                    WUDTA                          REC DATA
013900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014000000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
014400000000X001?C                   Else                                                   ELSE
014500000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
014600000000E001?C                   Endif                                                  END IF ERROR
014700000000    ?C                   Endsr                                                  END PREP COPY
014800000000    ? *___________________________________________________________________
014900000000    ? * Default Data
015000000000    ? *___________________________________________________________________
015100000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
015200010126    ?C                   Call      'CHKBCREC'                                   PROCESS REC IO
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
023600000614 001?C     WWPNL         Wheneq    2                                            IF PANEL 1
023700000614 001?C                   Exfmt     ENTPNL2                                      DSPLY ENTRY PNL1
023800000614 001?C                   Setoff                                       37        RESET CRSLOC
023900000614 001?C     WWPNL         Wheneq    3                                            IF PANEL 1
024000000614 001?C                   Exfmt     ENTPNL3                                      DSPLY ENTRY PNL1
024100000614 001?C                   Setoff                                       37        RESET CRSLOC
024200000000E001?C                   Endsl                                                  END SELECT
024300000000    ? *
024400000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
024500000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
024600000000E001?C                   Endif                                                  END IF DATA CHG
024700000000    ?C                   Endsr                                                  END DSPENT
024800000000    ? *___________________________________________________________________
024900000000    ? * Process function key
025000000000    ? *___________________________________________________________________
025100000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
025200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
025300991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
025400000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
025500000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
025600000000    ?C                   Parm                    WAD                            FNC DESC
025700991108    ?C                   Parm                    WWIN                           AID BYTE
025800000000    ?C                   Parm                    WAF                            FNC KEY TABLE
025900000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
026000000000    ?C                   Endsr                                                  END PRCFKY
026100000000    ? *___________________________________________________________________
026200000000    ? * Process KEYS function
026300000000    ? *___________________________________________________________________
026400000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
026500000000    ?C                   Z-add     1             WW                             KEY DSC IDX
026600000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
026700000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
026800000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
026900000000 001? *
027000000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
027100000000 002?C                   Z-add     1             WWFKS                          SET TO 1
027200000000E002?C                   Endif                                                  END IF OVER 3
027300000000 001? *
027400000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
027500000000 001?C                   Sub       1             WW                             KEY DESCR IDX
027600000000E001?C                   Enddo                                                  END DO KEYS
027700000000    ? *
027800000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
027900000000    ?C                   Add       1             WW                             BUMP IDX
028000000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
028100000000    ?C                   Endsr                                                  END PRCDKY
028200000000    ? *___________________________________________________________________
028300000000    ? * Process EXIT Function
028400000000    ? *___________________________________________________________________
028500000000    ?C     PRCEXT        Begsr                                                  RETURN
028600000000    ? *
028700000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
028800000000    ? *
028900000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
029000000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
029100000000X001?C                   Else                                                   ELSE NO ERRORS
029200000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
029300000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
029400000000E001?C                   Endif                                                  END IF ERRORS
029500000000    ?C                   Endsr                                                  END PRCEXT
029600000000    ? *___________________________________________________________________
029700000000    ? * Process PROMPT function
029800000000    ? *___________________________________________________________________
029900000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
030000000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
030100000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
030200000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
030300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
030400000000    ? *
030500000000B001?C                   Select                                                 SELECT
030600000112 001? *
030700000000 001?C                   Other                                                  WHERE ERROR
030800000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
030900000000 001?C                   Exsr      SNDMSG                                       SEND MSG
031000000000E001?C                   Endsl                                                  END SELECT
031100000000    ? *
031200000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
031300000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
031400000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
031500000000    ?C                   Mvr                     WSLIN                          CURSOR COL
031600000000    ?C                   Seton                                        37        SET ON CRSLOC
031700000000    ? *
031800000000    ?C                   Endsr                                                  END PRCPMT
031900000000    ? *___________________________________________________________________
032000000000    ? * Process CANCEL Function
032100000000    ? *___________________________________________________________________
032200000000    ?C     PRCCNL        Begsr                                                  CANCEL
032300000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
032400000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
032500000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
032600000000    ?C                   Endsr                                                  END RETURN
032700000000    ? *___________________________________________________________________
032800000000    ? * Process ROLLUP function
032900000000    ? *___________________________________________________________________
033000000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
033100000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
033200000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
033300000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
033400000000E001?C                   Endif                                                  END IF GT LST PNL
033500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
033600000000    ?C                   Endsr                                                  END PRCRUP
033700000000    ? *___________________________________________________________________
033800000000    ? * Process ROLLDOWN function
033900000000    ? *___________________________________________________________________
034000000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
034100000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
034200000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
034300000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
034400000000E001?C                   Endif                                                  END IF LT FST PNL
034500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
034600000000    ?C                   Endsr                                                  END PRCRDN
034700000000    ? *___________________________________________________________________
034800000000    ? * Process ENTER function
034900000000    ? *___________________________________________________________________
035000000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
035100000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
035200000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
035300000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
035400010426 001?C**** WWWRNF        Oreq      'N'                                          OR NO WARNINGS
035500000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
035600010126 001?C                   Call      'CHKBCREC'                                   CHECK DATA
035700000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
035800000000 001?C                   Parm                    WWRTN                          RETURN CODE
035900000614 001?C                   Parm                    WUDTA                          REC DATA
036000010426     C                   If        WWRTN   =     *Blanks
036100010426     C                   Exsr      CALCCHG
036200010426     C                   End
036300000000E001?C                   Endif                                                  ENDIF
036400000000    ? *
036500000000B001?C                   Select                                                 PRC RETURN CDE
036600000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
036700000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
036800000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
036900000000 001? *
037000000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
037100000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
037200000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
037300000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
037400000000X002?C                   Else                                                   ELSE
037500000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
037600000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
037700000000E002?C                   Endif                                                  IF WARNING
037800000000 001? *
037900000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
038000000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
038100000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
038200000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
038300000000E001?C                   Endsl                                                  RETURN CODE SEL
038400000000    ? *
038500000000    ?C                   Endsr                                                  END PRCPNL
038600000000    ? *___________________________________________________________________
038700000000    ? * Process end - write data or release record
038800000000    ? *___________________________________________________________________
038900000000    ?C     PRCEND        Begsr                                                  PROCESS END
039000000000    ? *
039100000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
039200000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
039300000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
039400000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
039500000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
039600000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
039700000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
039800000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
039900000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
040000000000 001?C                   Endcs                                                  END CASE
040100000000 001? *
040200000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
040300000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
040400000000 002? *
040500000000X002?C                   Else                                                   ELSE NO WRT ERR
040600000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
040700000000B004?C     WWTSK         Ifeq      'ADD     '                                   IF ADD
040800000000 004?C     WWTSK         Oreq      'ADDKEY  '                                   OR ADD KEY
040900000000 004?C                   Exsr      PRPPNL                                       DO NOT END
041000000000E004?C                   Endif                                                  END IF ADD
041100000000E003?C                   Endif                                                  END IF NOT END
041200000000E002?C                   Endif                                                  END IF WRITE ERROR
041300000000 001? *
041400000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
041500000000 001?C                   Exsr      RELREC                                       RELEASE REC
041600000000E001?C                   Endif                                                  END IF RCD CHANGED
041700000000    ? *
041800000000    ?C                   Endsr                                                  END PRCEND
041900000000    ? *___________________________________________________________________
042000000000    ? * Add new record
042100000000    ? *___________________________________________________________________
042200000000    ?C     WRTADD        Begsr                                                  WRITE ADD
042300000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
042400000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
042500000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
042600000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
042700000000E001?C                   Endif                                                  END IF ADD
042800000000    ? *
042900000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
043000000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
043100000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
043200000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
043300000000E001?C                   Endif                                                  END IF ADD KEY
043400000000    ? *
043500010126    ?C                   Call      'UPDBCREC'                                   PROCESS REC IO
043600000000    ?C                   Parm                    WWRQS                          ADD RECORD
043700000000    ?C                   Parm                    WWRTN                          RETURN CODE
043800000614    ?C                   Parm                    WUDTA                          REC DATA
043900000000    ? *
044000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
044100000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
044200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
044300000000X001?C                   Else                                                   ELSE
044400000000E001?C                   Endif                                                  END IF CALL ERROR
044500000000    ? *
044600000000    ?C                   Endsr                                                  END WRTADD
044700000000    ? *___________________________________________________________________
044800000000    ? * Write changed record
044900000000    ? *___________________________________________________________________
045000000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
045100010126    ?C                   Call      'UPDBCREC'                                   PROCESS REC IO
045200000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
045300000000    ?C                   Parm                    WWRTN                          RETURN CODE
045400000614    ?C                   Parm                    WUDTA                          REC DATA
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
046500010126    ?C                   Call      'UPDBCREC'                                   PROCESS REC IO
046600000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
046700000000    ?C                   Parm                    WWRTN                          RETURN CODE
046800000614    ?C                   Parm                    WUDTA                          REC DATA
046900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
047000000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
047100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047200000000E001?C                   Endif                                                  END IF CALL ERROR
047300000000    ?C                   Endsr                                                  END RELREC
047400000000    ? *___________________________________________________________________
047500000000    ? * Build function keys
047600000000    ? *___________________________________________________________________
047700000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
047800991108    ?C                   Movea     *IN           WWIN                           INDICATORS
047900991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
048000000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
048100000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
048200000000    ?C                   Parm                    WAD                            FNC DESC
048300991108    ?C                   Parm                    WWIN                           AID BYTE
048400000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
048500000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
048600000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
048700000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
048800000000    ?C                   Sub       1             WW                             BUMP IDX
048900000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
049000000000    ?C                   Endsr                                                  END BLD FNCTNS
049100000000    ? *___________________________________________________________________
049200000000    ? * Send message
049300000000    ? *___________________________________________________________________
049400000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
049500000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
049600000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
049700000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
049800000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
049900000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
050000000000    ?C                   Endsr                                                  END SNDMSG
050100000000    ? *___________________________________________________________________
050200000000    ? * Paremater list
050300000000    ? *___________________________________________________________________
050400000000    ?C     PLIST         Begsr                                                  PARM LISTS
050500000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
050600000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
050700000000    ?C                   Parm                    WORTN             8            RETURN CODE
050800000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
050900000614    ?C                   Parm                    WUDTA                          RECORD KEY
051000000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
051100000000    ?C                   Endsr                                                  END PLIST
051200000000    ? *___________________________________________________________________
051300000000    ? * Initialize routine
051400000000    ? *___________________________________________________________________
051500000000    ?C     *INZSR        Begsr                                                  INITIALIZE
051600000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
051700000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
051800000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
051900000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
052000000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
052100000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
052200000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
052300000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
052400000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
052500000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
052600000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
052700000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
052800000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
052900000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
053000000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
053100000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
053200000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
053300000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
053400000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
053500010126    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
053600000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
053700000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
053800000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
053900000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
054000000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
054100010126    ?C                   Movel     'BCREC   '    WWFIL            10            FILE NAME-NOTES
054200000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
054300000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
054400000000    ?C                   Endsr                                                  END INITIALIZE
054500010426    ? *___________________________________________________________________
054600010426    ? * Calculate Charges
054700010426    ? *___________________________________________________________________
054800010426    ?C     CALCCHG       Begsr                                                  BUILD FNCT KEYS
054900010427    ? *
055000010427    ? * Only recalculate Comm Chg if Method is P.
055100010427     C                   If        BCCMTH   =   'P'
055200010427     C                   If        bcpada   <>   0
055300010427     C                   Eval      bccchg   =    0
055400010426     C     bccpct        Div       100           wccpct            7 4
055500010426     C     bcpada        Mult      wccpct        bccchg
055600010426     C                   End
055700010427     C                   End
055800010427    ? *
055900010427    ? * Always recalculate Draw Chg.
056000010427     C                   Eval      bcdchg   =    0
056100010426     C     bcdpct        Div       100           wccpct
056200020219     C     bcfchg        Mult      wccpct        bcdchg
056300010426    ?C                   Movel     WTM(11)       WWMSG                          PASS MESSAGE
056400010426    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
056500010427    ? *
056600010426    ?C                   Endsr                                                  END INITIALIZE
056700000000    ? *___________________________________________________________________
056800000000    ? * Program error handler
056900000000    ? *___________________________________________________________________
057000000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
057100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
057200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
057300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
057400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
057500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
057600000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
057700000000    ? *___________________________________________________________________
057800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05790000000003EXIT    F3=Exit
05800000000004PROMPT  F4=Prompt
05810000000005REFRESH F5=Refresh
05820000070710UPDATE  F10=Update
05830000061412CANCEL  F12=Cancel
05840000000025ROLLUP
05850000000026ROLLDOWN
058600000000** WTM
05870001012600Request not supported in program CHGBCREC
05880000000000Update error.  Data was not updated.
05890000000000Duplicate key detected.  Data was NOT added to file.
05900000000000Call to notes ended in error.
05910000000000Initialize error.  Record not initialized.
05920000000000Record not found.
05930000000000Generate error.  Key not generated.
05940000000000Record not available now.
05950000000000The cursor is not in a prompt area.
05960000000000Default error.  Data not defaulted.
05970001042600Charges have been recalculated.
