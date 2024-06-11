000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010220    ? *  Description:  Change Internal Sales Commission Overrides
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700010220    ?FCHGOVRD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900010220    ?FACCMST    IF   E           K DISK
001000010220    ?FPLNMST    IF   E           K DISK
001100010223    ?FISCGLB    IF   E           K DISK
001200000000    ? *
001300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001500000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001600000000    ? *_________________________________________________________________________
001700000406    ? * Data structure
001800010220    ?D WUDTA         E DS                  EXTNAME(ISCOVR)
001900010223    ?D WDIGLB        E DS                  EXTNAME(ISCGLB)
002000010516    ?D WDSMAN        E DS                  EXTNAME(ISCSMN)
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
007400010220    ?C                   Move      *BLANKS       WSDES1                         RETURN CODE
007500010220    ?C                   Move      *BLANKS       WSDES2                         RETURN CODE
007600010223    ?C                   Move      *BLANKS       IGDESC                         RETURN CODE
007700010220    ?C                   Move      *ZEROS        WSDATE                         RETURN CODE
007800010223    ?C                   Move      *ZEROS        WSEFDT                         RETURN CODE
007900010223    ?C                   Move      *ZEROS        WSTRDT                         RETURN CODE
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
011700010220    ?C                   Call      'UPDOVR  '                                   PROCESS REC IO
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
013100010220     C     IOCHGD        MULT      10000.0001    WSDATE
013200010223     C     IOEFDT        MULT      10000.0001    WSEFDT
013300010223     C     IOTRDT        MULT      10000.0001    WSTRDT
013400010220     C     KACC          Chain     ACCMST
013500010220     C                   If        %Found
013600010220     C                   Movel     acnam1        wsdes1
013700000810E001?C                   Endif                                                  END IF ERROR
013800010220     C     KPLN          Chain     PLNMST
013900010220     C                   If        %Found
014000010220     C                   Movel     pdescr        wsdes2
014100010220E001?C                   Endif                                                  END IF ERROR
014200010220E001?C                   Endif                                                  END IF ERROR
014300000000    ?C                   Endsr                                                  END PRP CHANGE
014400000000    ? *___________________________________________________________________
014500000000    ? * Prepare COPY request
014600000000    ? *___________________________________________________________________
014700000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
014800000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
014900010220    ?C                   Call      'UPDOVR  '                                   PROCESS REC IO
015000000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
015100000000    ?C                   Parm                    WWRTN                          RETURN CODE
015200000614    ?C                   Parm                    WUDTA                          REC DATA
015300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015400000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
015500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
015600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015800000000X001?C                   Else                                                   ELSE
015900000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
016000010220 001?C                   Clear                   IOTRST                         CLEAR KEY
016100010220 001?C                   Clear                   IOSUB#                         CLEAR KEY
016200010220 001?C                   Clear                   IOACCT                         CLEAR KEY
016300010220 001?C                   Clear                   IOPLAN                         CLEAR KEY
016400000000E001?C                   Endif                                                  END IF ERROR
016500000000    ?C                   Endsr                                                  END PREP COPY
016600000000    ? *___________________________________________________________________
016700000000    ? * Default Data
016800000000    ? *___________________________________________________________________
016900000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
017000010220    ?C                   Call      'CHKOVR  '                                   PROCESS REC IO
017100000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
017200000000    ?C                   Parm                    WWRTN                          RETURN CODE
017300000614    ?C                   Parm                    WUDTA                          REC DATA
017400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
017500000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
017600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
017700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017800000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
017900000000E001?C                   Endif                                                  END IF ERROR
018000000000    ?C                   Endsr                                                  END DFTDTA
018100000000    ? *___________________________________________________________________
018200000000    ? * Process ERROR function
018300000000    ? *___________________________________________________________________
018400000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
018500000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
018600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
018700000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018800000000    ?C                   Move      'END'         WWSTT                          END STATE
018900000000    ?C                   Endsr                                                  END PRCERR
019000000000    ? *___________________________________________________________________
019100000000    ? * Receive messages
019200000000    ? *___________________________________________________________________
019300000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
019400000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
019500000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
019600000000X001?C                   Else                                                   ELSE
019700000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
019800000000E001?C                   Endif                                                  ENDIF NOT NORESET
019900000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
020000000000    ?C                   Movea     *IN           WWIN                           INDICATORS
020100000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
020200000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
020300000000    ?C                   Parm                    WWIN                           INDICATORS
020400000000    ?C                   Parm                    WWRTN                          RETURN CODE
020500000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
020600000000    ?C                   Endsr                                                  END RCV MSG
020700000000    ? *___________________________________________________________________
020800000000    ? * Display panels
020900000000    ? *___________________________________________________________________
021000000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
021100000000    ? *
021200000000    ? * Set PUTOVR based on last display file processed
021300000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
021400000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
021500000000 001?C                   Setoff                                       35        PUTOVR OFF
021600000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
021700000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
021800000000X001?C                   Else                                                   ELSE SAME PGM
021900000000 001?C                   Seton                                        35        PUTOVR ON
022000000000E001?C                   Endif                                                  END IF NEW PGM
022100000000    ? *
022200000614    ? * Set PROTECT key based on request
022300000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
022400000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
022500000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
022600000000 001?C                   Setoff                                       40        NO PROTECT KEY
022700000000X001?C                   Else                                                   ELSE
022800000000 001?C                   Seton                                        40        PROTECT KEY
022900000000E001?C                   Endif                                                  END IF ADD
023000000000    ? *
023100000000    ? * Select title
023200000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
023300000000 001?C                   Setoff                                       38        CHANGE TITLE
023400000000X001?C                   Else                                                   ELSE
023500000000 001?C                   Seton                                        38        ADD TITLE
023600000000E001?C                   Endif                                                  END IF CHANGE
023700000000    ? *
023800000000    ? * Position cursor based on error status
023900000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
024000000000 001?C                   Seton                                        99        POS CSR TO ERROR
024100000000X001?C                   Else                                                   ELSE
024200000000 001?C                   Setoff                                       99        POS CSR TO FIRST
024300000000E001?C                   Endif                                                  END IF ERROR
024400000000    ? *
024500000000    ? * Write message subfile
024600000000    ?C                   Seton                                        30        MSGSFL DISPLAY
024700000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
024800000000    ? *
024900000000    ? * Write entry panel
025000000000B001?C                   Select
025100000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
025200000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
025300000000 001?C                   Setoff                                       37        RESET CRSLOC
025400000000E001?C                   Endsl                                                  END SELECT
025500000000    ? *
025600000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
025700000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
025800000000E001?C                   Endif                                                  END IF DATA CHG
025900000000    ?C                   Endsr                                                  END DSPENT
026000000000    ? *___________________________________________________________________
026100000000    ? * Process function key
026200000000    ? *___________________________________________________________________
026300000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
026400991108    ?C                   Movea     *IN           WWIN                           INDICATORS
026500991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
026600000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
026700000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
026800000000    ?C                   Parm                    WAD                            FNC DESC
026900991108    ?C                   Parm                    WWIN                           AID BYTE
027000000000    ?C                   Parm                    WAF                            FNC KEY TABLE
027100000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
027200000000    ?C                   Endsr                                                  END PRCFKY
027300000000    ? *___________________________________________________________________
027400000000    ? * Process KEYS function
027500000000    ? *___________________________________________________________________
027600000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
027700000000    ?C                   Z-add     1             WW                             KEY DSC IDX
027800000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
027900000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
028000000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
028100000000 001? *
028200000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
028300000000 002?C                   Z-add     1             WWFKS                          SET TO 1
028400000000E002?C                   Endif                                                  END IF OVER 3
028500000000 001? *
028600000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
028700000000 001?C                   Sub       1             WW                             KEY DESCR IDX
028800000000E001?C                   Enddo                                                  END DO KEYS
028900000000    ? *
029000000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
029100000000    ?C                   Add       1             WW                             BUMP IDX
029200000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
029300000000    ?C                   Endsr                                                  END PRCDKY
029400000000    ? *___________________________________________________________________
029500000000    ? * Process EXIT Function
029600000000    ? *___________________________________________________________________
029700000000    ?C     PRCEXT        Begsr                                                  RETURN
029800000000    ? *
029900000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
030000000000    ? *
030100000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
030200000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
030300000000X001?C                   Else                                                   ELSE NO ERRORS
030400000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
030500000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
030600000000E001?C                   Endif                                                  END IF ERRORS
030700000000    ?C                   Endsr                                                  END PRCEXT
030800000000    ? *___________________________________________________________________
030900000000    ? * Process PROMPT function
031000000000    ? *___________________________________________________________________
031100000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
031200000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
031300000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
031400000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
031500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
031600000000    ? *
031700000000B001?C                   Select                                                 SELECT
031800000112 001? *
031900010516 001 C                   When      WSFLD = 'IOSMAN'
032000010516 001?C                   Call      'SLCSMN  '                                   CALL SELECT PROGRAM
032100010516 001?C                   Parm                    WWRQS                          REQUEST
032200010516 001?C                   Parm                    WWRTN                          RETURN CODE
032300010516 001?C                   Parm                    WUPGM                          PROGRAM
032400010516 001?C                   Parm                    WDSMAN                         RECORD DS
032500010516B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
032600010516 003?C                   Movel     ISSMAN        IOSMAN                         SET CODE
032700010516E001?C                   Else
032800010516 003?C                   Clear                   ISLNAM                         SET CODE
032900010516E002?C                   Endif
033000010516 001? *
033100000000 001?C                   Other                                                  WHERE ERROR
033200000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
033300000000 001?C                   Exsr      SNDMSG                                       SEND MSG
033400000000E001?C                   Endsl                                                  END SELECT
033500000000    ? *
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
037700000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
037800000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
037900000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
038000010223     C                   Z-add     WSEFDT        IOEFDT
038100010223     C                   Z-add     WSTRDT        IOTRDT
038200010220 001?C                   Call      'CHKOVR  '                                   CHECK DATA
038300000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
038400000000 001?C                   Parm                    WWRTN                          RETURN CODE
038500000614 001?C                   Parm                    WUDTA                          REC DATA
038600000000E001?C                   Endif                                                  ENDIF
038700000000    ? *
038800000000B001?C                   Select                                                 PRC RETURN CDE
038900000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
039000000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
039100010219 001?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
039200000000 001? *
039300000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
039400000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
039500000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
039600010219 002?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
039700000000X002?C                   Else                                                   ELSE
039800000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
039900000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
040000000000E002?C                   Endif                                                  IF WARNING
040100000000 001? *
040200000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
040300000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
040400000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
040500000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
040600000000E001?C                   Endsl                                                  RETURN CODE SEL
040700000000    ? *
040800000000    ?C                   Endsr                                                  END PRCPNL
040900000000    ? *___________________________________________________________________
041000000000    ? * Process end - write data or release record
041100000000    ? *___________________________________________________________________
041200000000    ?C     PRCEND        Begsr                                                  PROCESS END
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
045800010220    ?C                   Call      'UPDOVR  '                                   PROCESS REC IO
045900000000    ?C                   Parm                    WWRQS                          ADD RECORD
046000000000    ?C                   Parm                    WWRTN                          RETURN CODE
046100000614    ?C                   Parm                    WUDTA                          REC DATA
046200000000    ? *
046300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
046400000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
046500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
046600000000X001?C                   Else                                                   ELSE
046700000000E001?C                   Endif                                                  END IF CALL ERROR
046800000000    ? *
046900000000    ?C                   Endsr                                                  END WRTADD
047000000000    ? *___________________________________________________________________
047100000000    ? * Write changed record
047200000000    ? *___________________________________________________________________
047300000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
047400010220    ?C                   Call      'UPDOVR  '                                   PROCESS REC IO
047500000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
047600000000    ?C                   Parm                    WWRTN                          RETURN CODE
047700000614    ?C                   Parm                    WUDTA                          REC DATA
047800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
047900000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
048000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
048100000000E001?C                   Endif                                                  END IF CALL ERROR
048200000000    ? *
048300000000    ?C                   Endsr                                                  END WRTCHG
048400000000    ? *___________________________________________________________________
048500000000    ? * Release record
048600000000    ? *___________________________________________________________________
048700000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
048800010220    ?C                   Call      'UPDOVR  '                                   PROCESS REC IO
048900000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
049000000000    ?C                   Parm                    WWRTN                          RETURN CODE
049100000614    ?C                   Parm                    WUDTA                          REC DATA
049200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
049300000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
049400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
049500000000E001?C                   Endif                                                  END IF CALL ERROR
049600000000    ?C                   Endsr                                                  END RELREC
049700000000    ? *___________________________________________________________________
049800000000    ? * Build function keys
049900000000    ? *___________________________________________________________________
050000000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
050100991108    ?C                   Movea     *IN           WWIN                           INDICATORS
050200991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
050300000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
050400000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
050500000000    ?C                   Parm                    WAD                            FNC DESC
050600991108    ?C                   Parm                    WWIN                           AID BYTE
050700000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
050800000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
050900000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
051000000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
051100000000    ?C                   Sub       1             WW                             BUMP IDX
051200000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
051300000000    ?C                   Endsr                                                  END BLD FNCTNS
051400000000    ? *___________________________________________________________________
051500000000    ? * Send message
051600000000    ? *___________________________________________________________________
051700000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
051800000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
051900000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
052000000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
052100000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
052200000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
052300000000    ?C                   Endsr                                                  END SNDMSG
052400000000    ? *___________________________________________________________________
052500000000    ? * Paremater list
052600000000    ? *___________________________________________________________________
052700000000    ?C     PLIST         Begsr                                                  PARM LISTS
052800000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
052900000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
053000000000    ?C                   Parm                    WORTN             8            RETURN CODE
053100000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
053200000614    ?C                   Parm                    WUDTA                          RECORD KEY
053300000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
053400000000    ?C                   Endsr                                                  END PLIST
053500000000    ? *___________________________________________________________________
053600000000    ? * Initialize routine
053700000000    ? *___________________________________________________________________
053800000000    ?C     *INZSR        Begsr                                                  INITIALIZE
053900000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
054000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
054100000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
054200000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
054300000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
054400000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
054500000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
054600000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
054700000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
054800000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
054900000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
055000000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
055100000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
055200000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
055300000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
055400000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
055500000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
055600000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
055700000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
055800000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
055900000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
056000000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
056100000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
056200000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
056300000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
056400010220    ?C                   Movel     'ISCOVR  '    WWFIL            10            FILE NAME-NOTES
056500000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
056600000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
056700010220    ? *
056800010220    ?C     KACC          Klist                                                  DEFAULT DATA
056900010220     C                   Kfld                    IOTRST
057000010220     C                   Kfld                    IOSUB#
057100010220     C                   Kfld                    IOACCT
057200010220    ?C     KPLN          Klist                                                  DEFAULT DATA
057300010220     C                   Kfld                    IOTRST
057400010220     C                   Kfld                    IOSUB#
057500010220     C                   Kfld                    IOPLAN
057600000000    ?C                   Endsr                                                  END INITIALIZE
057700000000    ? *___________________________________________________________________
057800000000    ? * Program error handler
057900000000    ? *___________________________________________________________________
058000000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
058100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
058200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
058300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
058400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
058500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
058600000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
058700000000    ? *___________________________________________________________________
058800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05890000000003EXIT    F3=Exit
05900000000004PROMPT  F4=Prompt
05910000000005REFRESH F5=Refresh
05920000070710UPDATE  F10=Update
05930000061412CANCEL  F12=Cancel
05940000000025ROLLUP
05950000000026ROLLDOWN
059600000000** WTM
05970001022000Request not supported in program CHGOVR.
05980000000000Update error.  Data was not updated.
05990000000000Duplicate key detected.  Data was NOT added to file.
06000000000000Call to notes ended in error.
06010000000000Initialize error.  Record not initialized.
06020000000000Record not found.
06030000000000Generate error.  Key not generated.
06040000000000Record not available now.
06050000000000The cursor is not in a prompt area.
06060000000000Default error.  Data not defaulted.
