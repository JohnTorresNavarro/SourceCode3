000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300020306    ? *  Description:  Change Password Validation Menu Options
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700020306    ?FCHGPWMD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900000000    ? *
001000000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001100000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001200000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001300000000    ? *_________________________________________________________________________
001400000406    ? * Data structure
001500020306    ?D WUDTA         E DS                  EXTNAME(PWVMNU)
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
002700000000    ? *_________________________________________________________________________
002800000000    ? *
002900000614    ? * Process Entry Panel
003000000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
003100000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
003200000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
003300000000E001?C                   Endif                                                  END COPY/CPYKEY
003400000000    ? *
003500000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
003600000000    ? *
003700000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
003800000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
003900000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
004000000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004100000000 001? *
004200000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
004300000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
004400000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
004500000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
004600000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
004700000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
004800000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004900000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
005000000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
005100000000 001?C                   Endcs                                                  END CASE
005200000000 001? *
005300000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
005400000000 002?C                   Exsr      PRCEND                                       PROCESS END
005500000000E002?C                   Endif                                                  END IF END REQ
005600000000E001?C                   Enddo                                                  END DOWHILE
005700000000    ? *
005800000707    ? * Send Info Updated message.
005900000707     C     WwChg         Ifeq      'Y'
006000000707     C                   Movel     'UPDATE  '    WORTN
006100000707     C                   Endif
006200000707    ? *
006300000000    ?C                   Return                                                 RETURN
006400000000    ? *___________________________________________________________________
006500000000    ? * Prepare panel
006600000000    ? *___________________________________________________________________
006700000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
006800000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
006900991108    ?C                   Move      'N'           WWERR                          NO ERRORS
007000000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
007100000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
007200000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007300000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
007400000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
007500000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
007600000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
007700000000    ? *
007800000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
007900000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
008000000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
008100000000E002?C                   Endif                                                  ENDIF SAME REQUEST
008200000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
008300000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
008400000000    ? *
008500000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
008600000000    ? *
008700000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
008800000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
008900000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
009000000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
009100000000    ?C                   Cas                     PRCERR                         PROC ERROR
009200000000    ?C                   Endcs                                                  END CASE
009300000000    ? *
009400000000    ?C                   Endsr                                                  END PRPPNL
009500000000    ? *___________________________________________________________________
009600000000    ? * Prepare ADD request
009700000000    ? *___________________________________________________________________
009800000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
009900000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
010000000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
010100000000    ?C                   Endsr                                                  END PRP ADD
010200000000    ? *___________________________________________________________________
010300000000    ? * Prepare CHANGE request
010400000000    ? *___________________________________________________________________
010500000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
010600020306    ?C                   Call      'UPDPWM  '                                   PROCESS REC IO
010700000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
010800000000    ?C                   Parm                    WWRTN                          RETURN CODE
010900000614    ?C                   Parm                    WUDTA                          REC DATA
011000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
011100000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
011200000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
011300000000X002?C                   Else                                                   ELSE
011400000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
011500000000E002?C                   Endif                                                  END RCD NOT AVL
011600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
011700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
011800000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
011900000810E001?C                   Endif                                                  END IF ERROR
012000000000    ?C                   Endsr                                                  END PRP CHANGE
012100000000    ? *___________________________________________________________________
012200000000    ? * Prepare COPY request
012300000000    ? *___________________________________________________________________
012400000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
012500000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
012600020306    ?C                   Call      'UPDPWM  '                                   PROCESS REC IO
012700000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
012800000000    ?C                   Parm                    WWRTN                          RETURN CODE
012900000614    ?C                   Parm                    WUDTA                          REC DATA
013000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
013100000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
013200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
013300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
013500000000X001?C                   Else                                                   ELSE
013600000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
013700020306 001?C                   Clear                   PMOPTN                         CLEAR KEY
013800000000E001?C                   Endif                                                  END IF ERROR
013900000000    ?C                   Endsr                                                  END PREP COPY
014000000000    ? *___________________________________________________________________
014100000000    ? * Default Data
014200000000    ? *___________________________________________________________________
014300000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
014400020306    ?C                   Call      'CHKPWM  '                                   PROCESS REC IO
014500000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
014600000000    ?C                   Parm                    WWRTN                          RETURN CODE
014700000614    ?C                   Parm                    WUDTA                          REC DATA
014800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014900000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
015000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
015100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015200000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015300000000E001?C                   Endif                                                  END IF ERROR
015400000000    ?C                   Endsr                                                  END DFTDTA
015500000000    ? *___________________________________________________________________
015600000000    ? * Process ERROR function
015700000000    ? *___________________________________________________________________
015800000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
015900000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
016000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
016100000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016200000000    ?C                   Move      'END'         WWSTT                          END STATE
016300000000    ?C                   Endsr                                                  END PRCERR
016400000000    ? *___________________________________________________________________
016500000000    ? * Receive messages
016600000000    ? *___________________________________________________________________
016700000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
016800000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
016900000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
017000000000X001?C                   Else                                                   ELSE
017100000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
017200000000E001?C                   Endif                                                  ENDIF NOT NORESET
017300000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
017400000000    ?C                   Movea     *IN           WWIN                           INDICATORS
017500000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
017600000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
017700000000    ?C                   Parm                    WWIN                           INDICATORS
017800000000    ?C                   Parm                    WWRTN                          RETURN CODE
017900000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
018000000000    ?C                   Endsr                                                  END RCV MSG
018100000000    ? *___________________________________________________________________
018200000000    ? * Display panels
018300000000    ? *___________________________________________________________________
018400000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
018500000000    ? *
018600000000    ? * Set PUTOVR based on last display file processed
018700000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
018800000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
018900000000 001?C                   Setoff                                       35        PUTOVR OFF
019000000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
019100000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
019200000000X001?C                   Else                                                   ELSE SAME PGM
019300000000 001?C                   Seton                                        35        PUTOVR ON
019400000000E001?C                   Endif                                                  END IF NEW PGM
019500000000    ? *
019600000614    ? * Set PROTECT key based on request
019700000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
019800000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
019900000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
020000000000 001?C                   Setoff                                       40        NO PROTECT KEY
020100000000X001?C                   Else                                                   ELSE
020200000000 001?C                   Seton                                        40        PROTECT KEY
020300000000E001?C                   Endif                                                  END IF ADD
020400000000    ? *
020500000000    ? * Select title
020600000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
020700000000 001?C                   Setoff                                       38        CHANGE TITLE
020800000000X001?C                   Else                                                   ELSE
020900000000 001?C                   Seton                                        38        ADD TITLE
021000000000E001?C                   Endif                                                  END IF CHANGE
021100000000    ? *
021200000000    ? * Position cursor based on error status
021300000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
021400000000 001?C                   Seton                                        99        POS CSR TO ERROR
021500000000X001?C                   Else                                                   ELSE
021600000000 001?C                   Setoff                                       99        POS CSR TO FIRST
021700000000E001?C                   Endif                                                  END IF ERROR
021800000000    ? *
021900000000    ? * Write message subfile
022000000000    ?C                   Seton                                        30        MSGSFL DISPLAY
022100000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
022200000000    ? *
022300000000    ? * Write entry panel
022400000000B001?C                   Select
022500000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
022600000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
022700000000 001?C                   Setoff                                       37        RESET CRSLOC
022800000000E001?C                   Endsl                                                  END SELECT
022900000000    ? *
023000000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
023100000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
023200000000E001?C                   Endif                                                  END IF DATA CHG
023300000000    ?C                   Endsr                                                  END DSPENT
023400000000    ? *___________________________________________________________________
023500000000    ? * Process function key
023600000000    ? *___________________________________________________________________
023700000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
023800991108    ?C                   Movea     *IN           WWIN                           INDICATORS
023900991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
024000000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
024100000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
024200000000    ?C                   Parm                    WAD                            FNC DESC
024300991108    ?C                   Parm                    WWIN                           AID BYTE
024400000000    ?C                   Parm                    WAF                            FNC KEY TABLE
024500000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
024600000000    ?C                   Endsr                                                  END PRCFKY
024700000000    ? *___________________________________________________________________
024800000000    ? * Process KEYS function
024900000000    ? *___________________________________________________________________
025000000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
025100000000    ?C                   Z-add     1             WW                             KEY DSC IDX
025200000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
025300000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
025400000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
025500000000 001? *
025600000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
025700000000 002?C                   Z-add     1             WWFKS                          SET TO 1
025800000000E002?C                   Endif                                                  END IF OVER 3
025900000000 001? *
026000000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
026100000000 001?C                   Sub       1             WW                             KEY DESCR IDX
026200000000E001?C                   Enddo                                                  END DO KEYS
026300000000    ? *
026400000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
026500000000    ?C                   Add       1             WW                             BUMP IDX
026600000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
026700000000    ?C                   Endsr                                                  END PRCDKY
026800000000    ? *___________________________________________________________________
026900000000    ? * Process EXIT Function
027000000000    ? *___________________________________________________________________
027100000000    ?C     PRCEXT        Begsr                                                  RETURN
027200000000    ? *
027300000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
027400000000    ? *
027500000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
027600000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
027700000000X001?C                   Else                                                   ELSE NO ERRORS
027800000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
027900000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
028000000000E001?C                   Endif                                                  END IF ERRORS
028100000000    ?C                   Endsr                                                  END PRCEXT
028200000000    ? *___________________________________________________________________
028300000000    ? * Process PROMPT function
028400000000    ? *___________________________________________________________________
028500000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
028600000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
028700000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
028800000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
028900000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
029000000000    ? *
029100000000B001?C                   Select                                                 SELECT
029200000112 001? *
029300000000 001?C                   Other                                                  WHERE ERROR
029400000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
029500000000 001?C                   Exsr      SNDMSG                                       SEND MSG
029600000000E001?C                   Endsl                                                  END SELECT
029700000000    ? *
029800000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
029900000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
030000000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
030100000000    ?C                   Mvr                     WSLIN                          CURSOR COL
030200000000    ?C                   Seton                                        37        SET ON CRSLOC
030300000000    ? *
030400000000    ?C                   Endsr                                                  END PRCPMT
030500000000    ? *___________________________________________________________________
030600000000    ? * Process CANCEL Function
030700000000    ? *___________________________________________________________________
030800000000    ?C     PRCCNL        Begsr                                                  CANCEL
030900000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
031000000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
031100000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
031200000000    ?C                   Endsr                                                  END RETURN
031300000000    ? *___________________________________________________________________
031400000000    ? * Process ROLLUP function
031500000000    ? *___________________________________________________________________
031600000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
031700000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
031800000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
031900000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
032000000000E001?C                   Endif                                                  END IF GT LST PNL
032100000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
032200000000    ?C                   Endsr                                                  END PRCRUP
032300000000    ? *___________________________________________________________________
032400000000    ? * Process ROLLDOWN function
032500000000    ? *___________________________________________________________________
032600000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
032700000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
032800000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
032900000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
033000000000E001?C                   Endif                                                  END IF LT FST PNL
033100000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
033200000000    ?C                   Endsr                                                  END PRCRDN
033300000000    ? *___________________________________________________________________
033400000000    ? * Process ENTER function
033500000000    ? *___________________________________________________________________
033600000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
033700000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
033800000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
033900000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
034000000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
034100000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
034200020306 001?C                   Call      'CHKPWM  '                                   CHECK DATA
034300000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
034400000000 001?C                   Parm                    WWRTN                          RETURN CODE
034500000614 001?C                   Parm                    WUDTA                          REC DATA
034600000000E001?C                   Endif                                                  ENDIF
034700000000    ? *
034800000000B001?C                   Select                                                 PRC RETURN CDE
034900000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
035000000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
035100010219 001?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
035200000000 001? *
035300000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
035400000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
035500000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
035600010219 002?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
035700000000X002?C                   Else                                                   ELSE
035800000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
035900000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
036000000000E002?C                   Endif                                                  IF WARNING
036100000000 001? *
036200000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
036300000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
036400000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
036500000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
036600000000E001?C                   Endsl                                                  RETURN CODE SEL
036700000000    ? *
036800000000    ?C                   Endsr                                                  END PRCPNL
036900000000    ? *___________________________________________________________________
037000000000    ? * Process end - write data or release record
037100000000    ? *___________________________________________________________________
037200000000    ?C     PRCEND        Begsr                                                  PROCESS END
037300000000    ? *
037400000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
037500000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
037600000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
037700000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
037800000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
037900000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
038000000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
038100000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
038200000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
038300000000 001?C                   Endcs                                                  END CASE
038400000000 001? *
038500000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
038600000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
038700000000 002? *
038800000000X002?C                   Else                                                   ELSE NO WRT ERR
038900000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
039000000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
039100000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
039200000000 004?C                   Exsr      PRPPNL                                       DO NOT END
039300000810E004?C                   Endif                                                  END IF ADD
039400000000E003?C                   Endif                                                  END IF NOT END
039500000000E002?C                   Endif                                                  END IF WRITE ERROR
039600000000 001? *
039700000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
039800000000 001?C                   Exsr      RELREC                                       RELEASE REC
039900000000E001?C                   Endif                                                  END IF RCD CHANGED
040000000000    ? *
040100000000    ?C                   Endsr                                                  END PRCEND
040200000000    ? *___________________________________________________________________
040300000000    ? * Add new record
040400000000    ? *___________________________________________________________________
040500000000    ?C     WRTADD        Begsr                                                  WRITE ADD
040600000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
040700000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
040800000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
040900000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
041000000000E001?C                   Endif                                                  END IF ADD
041100000000    ? *
041200000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
041300000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
041400000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
041500000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
041600000000E001?C                   Endif                                                  END IF ADD KEY
041700000000    ? *
041800020306    ?C                   Call      'UPDPWM  '                                   PROCESS REC IO
041900000000    ?C                   Parm                    WWRQS                          ADD RECORD
042000000000    ?C                   Parm                    WWRTN                          RETURN CODE
042100000614    ?C                   Parm                    WUDTA                          REC DATA
042200000000    ? *
042300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
042400000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
042500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
042600000000X001?C                   Else                                                   ELSE
042700000000E001?C                   Endif                                                  END IF CALL ERROR
042800000000    ? *
042900000000    ?C                   Endsr                                                  END WRTADD
043000000000    ? *___________________________________________________________________
043100000000    ? * Write changed record
043200000000    ? *___________________________________________________________________
043300000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
043400020306    ?C                   Call      'UPDPWM  '                                   PROCESS REC IO
043500000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
043600000000    ?C                   Parm                    WWRTN                          RETURN CODE
043700000614    ?C                   Parm                    WUDTA                          REC DATA
043800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
043900000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
044000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
044100000000E001?C                   Endif                                                  END IF CALL ERROR
044200000000    ? *
044300000000    ?C                   Endsr                                                  END WRTCHG
044400000000    ? *___________________________________________________________________
044500000000    ? * Release record
044600000000    ? *___________________________________________________________________
044700000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
044800020306    ?C                   Call      'UPDPWM  '                                   PROCESS REC IO
044900000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
045000000000    ?C                   Parm                    WWRTN                          RETURN CODE
045100000614    ?C                   Parm                    WUDTA                          REC DATA
045200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
045300000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
045400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
045500000000E001?C                   Endif                                                  END IF CALL ERROR
045600000000    ?C                   Endsr                                                  END RELREC
045700000000    ? *___________________________________________________________________
045800000000    ? * Build function keys
045900000000    ? *___________________________________________________________________
046000000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
046100991108    ?C                   Movea     *IN           WWIN                           INDICATORS
046200991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
046300000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
046400000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
046500000000    ?C                   Parm                    WAD                            FNC DESC
046600991108    ?C                   Parm                    WWIN                           AID BYTE
046700000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
046800000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
046900000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
047000000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
047100000000    ?C                   Sub       1             WW                             BUMP IDX
047200000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
047300000000    ?C                   Endsr                                                  END BLD FNCTNS
047400000000    ? *___________________________________________________________________
047500000000    ? * Send message
047600000000    ? *___________________________________________________________________
047700000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
047800000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
047900000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
048000000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
048100000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
048200000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
048300000000    ?C                   Endsr                                                  END SNDMSG
048400000000    ? *___________________________________________________________________
048500000000    ? * Paremater list
048600000000    ? *___________________________________________________________________
048700000000    ?C     PLIST         Begsr                                                  PARM LISTS
048800000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
048900000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
049000000000    ?C                   Parm                    WORTN             8            RETURN CODE
049100000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
049200000614    ?C                   Parm                    WUDTA                          RECORD KEY
049300000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
049400000000    ?C                   Endsr                                                  END PLIST
049500000000    ? *___________________________________________________________________
049600000000    ? * Initialize routine
049700000000    ? *___________________________________________________________________
049800000000    ?C     *INZSR        Begsr                                                  INITIALIZE
049900000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
050000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
050100000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
050200000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
050300000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
050400000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
050500000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
050600000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
050700000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
050800000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
050900000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
051000000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
051100000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
051200000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
051300000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
051400000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
051500000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
051600000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
051700000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
051800000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
051900000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
052000000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
052100000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
052200000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
052300000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
052400020306    ?C                   Movel     'PWVMNU  '    WWFIL            10            FILE NAME-NOTES
052500000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
052600000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
052700000000    ?C                   Endsr                                                  END INITIALIZE
052800000000    ? *___________________________________________________________________
052900000000    ? * Program error handler
053000000000    ? *___________________________________________________________________
053100000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
053200000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
053300000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
053400000000    ?C                   Parm                    WQSTSC                         STATUS CODE
053500000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
053600000000    ?C                   Parm                    WQMSG                          MESSAGE ID
053700000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
053800000000    ? *___________________________________________________________________
053900000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05400000000003EXIT    F3=Exit
05410000000004PROMPT  F4=Prompt
05420000000005REFRESH F5=Refresh
05430000070710UPDATE  F10=Update
05440000061412CANCEL  F12=Cancel
05450000000025ROLLUP
05460000000026ROLLDOWN
054700000000** WTM
05480002030600Request not supported in program CHGPWM.
05490000000000Update error.  Data was not updated.
05500000000000Duplicate key detected.  Data was NOT added to file.
05510000000000Call to notes ended in error.
05520000000000Initialize error.  Record not initialized.
05530000000000Record not found.
05540000000000Generate error.  Key not generated.
05550000000000Record not available now.
05560000000000The cursor is not in a prompt area.
05570000000000Default error.  Data not defaulted.
