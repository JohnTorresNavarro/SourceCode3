000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010126    ? *  Description:  Change BCREC Records
000400000000    ? *
000500010126    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700020218    ?FCHGBCAPPD CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900020218    ?FBCREC3    UF   E           K DISK
001000000000    ? *
001100000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001300020219    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001400000000    ? *_________________________________________________________________________
001500000406    ? * Data structure
001600010126    ?D WUDTA         E DS                  EXTNAME(BCREC)
001700020218    ?D WXDTA         E DS                  EXTNAME(BCREC) PREFIX(X)
001800000000    ? *
001900000000    ? * Program status data structure
002000991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002100000000    ? *
002200000000    ? * Display file data structure
002300991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002400000000    ? *
002500000000    ? * CURSOR LOCATION
002600000000    ?D                 DS
002700000000    ?D  WWCRSL                 1      2
002800000000    ?D  WWCRSN                 1      2B 0
002900010129    ? *
003000010129    ?D                 DS
003100010129    ?D  wsdate                 1      8  0  inz
003200010129    ?D  wcefmm                 1      2  0
003300010129    ?D  wcefdd                 3      4  0
003400010129    ?D  wcefyy                 5      8  0
003500000000    ? *_________________________________________________________________________
003600000000    ? *
003700000614    ? * Process Entry Panel
003800000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
003900000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
004000000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
004100000000E001?C                   Endif                                                  END COPY/CPYKEY
004200000000    ? *
004300000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004400000000    ? *
004500000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004600000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004700000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
004800000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004900000000 001? *
005000000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
005100000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
005200000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005300000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
005400000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005500000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
005600000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005700000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
005800000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
005900000000 001?C                   Endcs                                                  END CASE
006000000000 001? *
006100000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
006200000000 002?C                   Exsr      PRCEND                                       PROCESS END
006300000000E002?C                   Endif                                                  END IF END REQ
006400000000E001?C                   Enddo                                                  END DOWHILE
006500000000    ? *
006600000707    ? * Send Info Updated message.
006700000707     C     WwChg         Ifeq      'Y'
006800020218     C                   Movel     'APPLY   '    WORTN
006900000707     C                   Endif
007000000707    ? *
007100000000    ?C                   Return                                                 RETURN
007200000000    ? *___________________________________________________________________
007300000000    ? * Prepare panel
007400000000    ? *___________________________________________________________________
007500000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007600000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007700991108    ?C                   Move      'N'           WWERR                          NO ERRORS
007800000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
007900000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008000000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008100000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008200000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008300000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
008400000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
008500000000    ? *
008600000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
008700000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
008800000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
008900000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009000000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009100000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009200000000    ? *
009300000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
009400000000    ? *
009500020218    ?C     WWTSK         Caseq     'APPLY   '    PRPAPP                         PREP FOR CHANGE
009600020218    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
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
010800000000    ?C                   Endsr                                                  END PRP ADD
010900020218    ? *___________________________________________________________________
011000020218    ? * Prepare APPLY request
011100020218    ? *___________________________________________________________________
011200020218    ?C     PRPAPP        Begsr                                                  PREP FOR CHANGE
011300020218     C                   z-add     bcefyy        wcefyy
011400020218     C                   z-add     bcefmm        wcefmm
011500020218     C                   z-add     bcefdd        wcefdd
011600020218    ?C                   Endsr                                                  END PRP CHANGE
011700000000    ? *___________________________________________________________________
011800000000    ? * Prepare CHANGE request
011900000000    ? *___________________________________________________________________
012000000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
012100000000    ?C                   Endsr                                                  END PRP CHANGE
012200000000    ? *___________________________________________________________________
012300000000    ? * Prepare COPY request
012400000000    ? *___________________________________________________________________
012500000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
012600000000    ?C                   Endsr                                                  END PREP COPY
012700000000    ? *___________________________________________________________________
012800000000    ? * Default Data
012900000000    ? *___________________________________________________________________
013000000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
013100000000    ?C                   Endsr                                                  END DFTDTA
013200000000    ? *___________________________________________________________________
013300000000    ? * Process ERROR function
013400000000    ? *___________________________________________________________________
013500000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
013600000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
013700000000    ?C                   Exsr      SNDMSG                                       SEND MSG
013800000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013900000000    ?C                   Move      'END'         WWSTT                          END STATE
014000000000    ?C                   Endsr                                                  END PRCERR
014100000000    ? *___________________________________________________________________
014200000000    ? * Receive messages
014300000000    ? *___________________________________________________________________
014400000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
014500000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
014600000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
014700000000X001?C                   Else                                                   ELSE
014800000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
014900000000E001?C                   Endif                                                  ENDIF NOT NORESET
015000000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
015100000000    ?C                   Movea     *IN           WWIN                           INDICATORS
015200000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
015300000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
015400000000    ?C                   Parm                    WWIN                           INDICATORS
015500000000    ?C                   Parm                    WWRTN                          RETURN CODE
015600000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
015700000000    ?C                   Endsr                                                  END RCV MSG
015800000000    ? *___________________________________________________________________
015900000000    ? * Display panels
016000000000    ? *___________________________________________________________________
016100000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
016200000000    ? *
016300000000    ? * Set PUTOVR based on last display file processed
016400000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
016500000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
016600000000 001?C                   Setoff                                       35        PUTOVR OFF
016700000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
016800000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
016900000000X001?C                   Else                                                   ELSE SAME PGM
017000000000 001?C                   Seton                                        35        PUTOVR ON
017100000000E001?C                   Endif                                                  END IF NEW PGM
017200000000    ? *
017300000614    ? * Set PROTECT key based on request
017400000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
017500000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
017600000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
017700000000 001?C                   Setoff                                       40        NO PROTECT KEY
017800000000X001?C                   Else                                                   ELSE
017900000000 001?C                   Seton                                        40        PROTECT KEY
018000000000E001?C                   Endif                                                  END IF ADD
018100000000    ? *
018200000000    ? * Select title
018300020218B001?C     WWTSK         Ifeq      'APPLY '                                     IF CHANGE
018400000000 001?C                   Setoff                                       38        CHANGE TITLE
018500000000X001?C                   Else                                                   ELSE
018600000000 001?C                   Seton                                        38        ADD TITLE
018700000000E001?C                   Endif                                                  END IF CHANGE
018800000000    ? *
018900000000    ? * Position cursor based on error status
019000000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
019100000000 001?C                   Seton                                        99        POS CSR TO ERROR
019200000000X001?C                   Else                                                   ELSE
019300000000 001?C                   Setoff                                       99        POS CSR TO FIRST
019400000000E001?C                   Endif                                                  END IF ERROR
019500000000    ? *
019600000000    ? * Write message subfile
019700000000    ?C                   Seton                                        30        MSGSFL DISPLAY
019800000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
019900000000    ? *
020000000000    ? * Write entry panel
020100000000B001?C                   Select
020200000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
020300000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
020400000000 001?C                   Setoff                                       37        RESET CRSLOC
020500000614 001?C     WWPNL         Wheneq    2                                            IF PANEL 1
020600000614 001?C                   Exfmt     ENTPNL2                                      DSPLY ENTRY PNL1
020700000614 001?C                   Setoff                                       37        RESET CRSLOC
020800000614 001?C     WWPNL         Wheneq    3                                            IF PANEL 1
020900000614 001?C                   Exfmt     ENTPNL3                                      DSPLY ENTRY PNL1
021000000614 001?C                   Setoff                                       37        RESET CRSLOC
021100000000E001?C                   Endsl                                                  END SELECT
021200000000    ? *
021300000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
021400000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
021500000000E001?C                   Endif                                                  END IF DATA CHG
021600000000    ?C                   Endsr                                                  END DSPENT
021700000000    ? *___________________________________________________________________
021800000000    ? * Process function key
021900000000    ? *___________________________________________________________________
022000000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
022100991108    ?C                   Movea     *IN           WWIN                           INDICATORS
022200991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
022300000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
022400000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
022500000000    ?C                   Parm                    WAD                            FNC DESC
022600991108    ?C                   Parm                    WWIN                           AID BYTE
022700000000    ?C                   Parm                    WAF                            FNC KEY TABLE
022800000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
022900000000    ?C                   Endsr                                                  END PRCFKY
023000000000    ? *___________________________________________________________________
023100000000    ? * Process KEYS function
023200000000    ? *___________________________________________________________________
023300000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
023400000000    ?C                   Z-add     1             WW                             KEY DSC IDX
023500000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
023600000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
023700000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
023800000000 001? *
023900000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
024000000000 002?C                   Z-add     1             WWFKS                          SET TO 1
024100000000E002?C                   Endif                                                  END IF OVER 3
024200000000 001? *
024300000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
024400000000 001?C                   Sub       1             WW                             KEY DESCR IDX
024500000000E001?C                   Enddo                                                  END DO KEYS
024600000000    ? *
024700000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
024800000000    ?C                   Add       1             WW                             BUMP IDX
024900000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
025000000000    ?C                   Endsr                                                  END PRCDKY
025100000000    ? *___________________________________________________________________
025200000000    ? * Process EXIT Function
025300000000    ? *___________________________________________________________________
025400000000    ?C     PRCEXT        Begsr                                                  RETURN
025500000000    ? *
025600020218    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
025700000000    ? *
025800000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
025900000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
026000000000X001?C                   Else                                                   ELSE NO ERRORS
026100000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
026200000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
026300000000E001?C                   Endif                                                  END IF ERRORS
026400000000    ?C                   Endsr                                                  END PRCEXT
026500000000    ? *___________________________________________________________________
026600000000    ? * Process PROMPT function
026700000000    ? *___________________________________________________________________
026800000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
026900000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
027000000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
027100000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
027200000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
027300000000    ? *
027400000000B001?C                   Select                                                 SELECT
027500000112 001? *
027600000000 001?C                   Other                                                  WHERE ERROR
027700000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
027800000000 001?C                   Exsr      SNDMSG                                       SEND MSG
027900000000E001?C                   Endsl                                                  END SELECT
028000000000    ? *
028100000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
028200000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
028300000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
028400000000    ?C                   Mvr                     WSLIN                          CURSOR COL
028500000000    ?C                   Seton                                        37        SET ON CRSLOC
028600000000    ? *
028700000000    ?C                   Endsr                                                  END PRCPMT
028800000000    ? *___________________________________________________________________
028900000000    ? * Process CANCEL Function
029000000000    ? *___________________________________________________________________
029100000000    ?C     PRCCNL        Begsr                                                  CANCEL
029200000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
029300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
029400000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
029500000000    ?C                   Endsr                                                  END RETURN
029600000000    ? *___________________________________________________________________
029700000000    ? * Process ROLLUP function
029800000000    ? *___________________________________________________________________
029900000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
030000000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
030100000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
030200000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
030300000000E001?C                   Endif                                                  END IF GT LST PNL
030400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
030500000000    ?C                   Endsr                                                  END PRCRUP
030600000000    ? *___________________________________________________________________
030700000000    ? * Process ROLLDOWN function
030800000000    ? *___________________________________________________________________
030900000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
031000000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
031100000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
031200000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
031300000000E001?C                   Endif                                                  END IF LT FST PNL
031400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
031500000000    ?C                   Endsr                                                  END PRCRDN
031600000000    ? *___________________________________________________________________
031700000000    ? * Process ENTER function
031800000000    ? *___________________________________________________________________
031900000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
032000000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
032100000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
032200000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
032300010426 001?C**** WWWRNF        Oreq      'N'                                          OR NO WARNINGS
032400000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
032500010126 001?C                   Call      'CHKBCREC'                                   CHECK DATA
032600000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
032700000000 001?C                   Parm                    WWRTN                          RETURN CODE
032800000614 001?C                   Parm                    WUDTA                          REC DATA
032900010426     C                   If        WWRTN   =     *Blanks
033000010426     C                   Exsr      CALCCHG
033100010426     C                   End
033200000000E001?C                   Endif                                                  ENDIF
033300000000    ? *
033400000000B001?C                   Select                                                 PRC RETURN CDE
033500000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
033600000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
033700000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
033800000000 001? *
033900000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
034000000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
034100000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
034200000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
034300000000X002?C                   Else                                                   ELSE
034400000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
034500000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
034600000000E002?C                   Endif                                                  IF WARNING
034700000000 001? *
034800000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
034900000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
035000000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
035100000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
035200000000E001?C                   Endsl                                                  RETURN CODE SEL
035300000000    ? *
035400000000    ?C                   Endsr                                                  END PRCPNL
035500000000    ? *___________________________________________________________________
035600000000    ? * Process end - write data or release record
035700000000    ? *___________________________________________________________________
035800000000    ?C     PRCEND        Begsr                                                  PROCESS END
035900000000    ? *
036000000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
036100000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
036200000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
036300000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
036400000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
036500000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
036600000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
036700000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
036800000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
036900020218 001?C     WWTSK         Caseq     'APPLY   '    WRTAPP                         WRITE CHANGE
037000000000 001?C                   Endcs                                                  END CASE
037100000000 001? *
037200000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
037300000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
037400000000 002? *
037500000000X002?C                   Else                                                   ELSE NO WRT ERR
037600000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
037700000000B004?C     WWTSK         Ifeq      'ADD     '                                   IF ADD
037800000000 004?C     WWTSK         Oreq      'ADDKEY  '                                   OR ADD KEY
037900000000 004?C                   Exsr      PRPPNL                                       DO NOT END
038000000000E004?C                   Endif                                                  END IF ADD
038100000000E003?C                   Endif                                                  END IF NOT END
038200000000E002?C                   Endif                                                  END IF WRITE ERROR
038300000000 001? *
038400000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
038500000000 001?C                   Exsr      RELREC                                       RELEASE REC
038600000000E001?C                   Endif                                                  END IF RCD CHANGED
038700000000    ? *
038800000000    ?C                   Endsr                                                  END PRCEND
038900000000    ? *___________________________________________________________________
039000000000    ? * Add new record
039100000000    ? *___________________________________________________________________
039200000000    ?C     WRTADD        Begsr                                                  WRITE ADD
039300000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
039400000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
039500000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
039600000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
039700000000E001?C                   Endif                                                  END IF ADD
039800000000    ? *
039900000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
040000000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
040100000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
040200000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
040300000000E001?C                   Endif                                                  END IF ADD KEY
040400000000    ? *
040500010126    ?C                   Call      'UPDBCREC'                                   PROCESS REC IO
040600000000    ?C                   Parm                    WWRQS                          ADD RECORD
040700000000    ?C                   Parm                    WWRTN                          RETURN CODE
040800000614    ?C                   Parm                    WUDTA                          REC DATA
040900000000    ? *
041000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
041100000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
041200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
041300000000X001?C                   Else                                                   ELSE
041400000000E001?C                   Endif                                                  END IF CALL ERROR
041500000000    ? *
041600000000    ?C                   Endsr                                                  END WRTADD
041700000000    ? *___________________________________________________________________
041800020218    ? * Write Apply records
041900000000    ? *___________________________________________________________________
042000020218    ?C     WRTAPP        Begsr                                                  WRITE CHANGE
042100020218    ?C                   Move      WUDTA         WXDTA                          SAVE RECORD DS
042200020218     C     WXKEY         Klist
042300020218     C                   Kfld                    XBCTRST
042400020218     C                   Kfld                    XBCSUB
042500020218     C                   Kfld                    XBCACCT
042600020218     C                   Kfld                    XBCPLAN
042700020218     C                   Kfld                    XBCEFYY
042800020218     C                   Kfld                    XBCEFMM
042900020218     C                   Kfld                    XBCEFDD
043000020218     C     WXKEY         Setll     BCREC3
043100020218     C     WXKEY         Reade     BCREC3                                 99
043200020218     C                   Dow       *in99 = *off
043300020218     C                   Eval      bccchg    =   xbccchg
043400020218     C                   Eval      bccpct    =   xbccpct
043500020218     C                   Eval      bccmth    =   xbccmth
043600020218     C                   Eval      bcfchg    =   xbcfchg
043700020218     C                   Eval      bcfpct    =   xbcfpct
043800020218     C                   Eval      bcdchg    =   xbcdchg
043900020218     C                   Eval      bcdpct    =   xbcdpct
044000020218     C                   Exsr      CALCCHG
044100020218     C                   Update    bcrecr
044200020218     C     WXKEY         Reade     BCREC3                                 99
044300020218     C                   Enddo
044400000000    ?C                   Endsr                                                  END WRTCHG
044500020218    ? *___________________________________________________________________
044600020218    ? * Write changed record
044700020218    ? *___________________________________________________________________
044800020218    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
044900020218    ?C                   Call      'UPDBCREC'                                   PROCESS REC IO
045000020218    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
045100020218    ?C                   Parm                    WWRTN                          RETURN CODE
045200020218    ?C                   Parm                    WUDTA                          REC DATA
045300020218B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
045400020218 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
045500020218 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
045600020218E001?C                   Endif                                                  END IF CALL ERROR
045700020218    ? *
045800020218    ?C                   Endsr                                                  END WRTCHG
045900000000    ? *___________________________________________________________________
046000000000    ? * Release record
046100000000    ? *___________________________________________________________________
046200000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
046300010126    ?C                   Call      'UPDBCREC'                                   PROCESS REC IO
046400000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
046500000000    ?C                   Parm                    WWRTN                          RETURN CODE
046600000614    ?C                   Parm                    WUDTA                          REC DATA
046700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
046800000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
046900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047000000000E001?C                   Endif                                                  END IF CALL ERROR
047100000000    ?C                   Endsr                                                  END RELREC
047200000000    ? *___________________________________________________________________
047300000000    ? * Build function keys
047400000000    ? *___________________________________________________________________
047500000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
047600991108    ?C                   Movea     *IN           WWIN                           INDICATORS
047700991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
047800000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
047900000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
048000000000    ?C                   Parm                    WAD                            FNC DESC
048100991108    ?C                   Parm                    WWIN                           AID BYTE
048200000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
048300000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
048400000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
048500000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
048600000000    ?C                   Sub       1             WW                             BUMP IDX
048700000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
048800000000    ?C                   Endsr                                                  END BLD FNCTNS
048900000000    ? *___________________________________________________________________
049000000000    ? * Send message
049100000000    ? *___________________________________________________________________
049200000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
049300000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
049400000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
049500000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
049600000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
049700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
049800000000    ?C                   Endsr                                                  END SNDMSG
049900000000    ? *___________________________________________________________________
050000000000    ? * Paremater list
050100000000    ? *___________________________________________________________________
050200000000    ?C     PLIST         Begsr                                                  PARM LISTS
050300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
050400000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
050500000000    ?C                   Parm                    WORTN             8            RETURN CODE
050600000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
050700000614    ?C                   Parm                    WUDTA                          RECORD KEY
050800000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
050900000000    ?C                   Endsr                                                  END PLIST
051000000000    ? *___________________________________________________________________
051100000000    ? * Initialize routine
051200000000    ? *___________________________________________________________________
051300000000    ?C     *INZSR        Begsr                                                  INITIALIZE
051400000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
051500000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
051600000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
051700000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
051800000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
051900000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
052000000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
052100000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
052200000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
052300000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
052400000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
052500000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
052600000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
052700000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
052800000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
052900000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
053000000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
053100000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
053200000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
053300010126    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
053400000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
053500000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
053600000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
053700000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
053800000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
053900010126    ?C                   Movel     'BCREC   '    WWFIL            10            FILE NAME-NOTES
054000000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
054100000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
054200000000    ?C                   Endsr                                                  END INITIALIZE
054300010426    ? *___________________________________________________________________
054400010426    ? * Calculate Charges
054500010426    ? *___________________________________________________________________
054600010426    ?C     CALCCHG       Begsr                                                  BUILD FNCT KEYS
054700010427    ? *
054800010427    ? * Only recalculate Comm Chg if Method is P.
054900010427     C                   If        BCCMTH   =   'P'
055000010427     C                   If        bcpada   <>   0
055100010427     C                   Eval      bccchg   =    0
055200010426     C     bccpct        Div       100           wccpct            7 4
055300010426     C     bcpada        Mult      wccpct        bccchg
055400010426     C                   End
055500010427     C                   End
055600010427    ? *
055700010427    ? * Always recalculate Draw Chg.
055800010427     C                   Eval      bcdchg   =    0
055900010426     C     bcdpct        Div       100           wccpct
056000020219     C     bcfchg        Mult      wccpct        bcdchg
056100010427    ? *
056200010426    ?C                   Endsr                                                  END INITIALIZE
056300000000    ? *___________________________________________________________________
056400000000    ? * Program error handler
056500000000    ? *___________________________________________________________________
056600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
056700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
056800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
056900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
057000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
057100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
057200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
057300000000    ? *___________________________________________________________________
057400000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05750000000003EXIT    F3=Exit
05760000000004PROMPT  F4=Prompt
05770000000005REFRESH F5=Refresh
05780000070710UPDATE  F10=Update
05790000061412CANCEL  F12=Cancel
05800000000025ROLLUP
05810000000026ROLLDOWN
058200000000** WTM
05830001012600Request not supported in program CHGBCREC
05840000000000Update error.  Data was not updated.
05850000000000Duplicate key detected.  Data was NOT added to file.
05860000000000Call to notes ended in error.
05870000000000Initialize error.  Record not initialized.
05880000000000Record not found.
05890000000000Generate error.  Key not generated.
05900000000000Record not available now.
05910000000000The cursor is not in a prompt area.
05920000000000Default error.  Data not defaulted.
