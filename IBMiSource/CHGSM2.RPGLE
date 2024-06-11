000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010219    ? *  Description:  Change Internal Sales Commission Salesman
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600030219    ? *
000700030219    ? *  Revised by: SZZ  February 19, 2003  Compile over modified file
000800000000    ? *_________________________________________________________________________
000900040728    ?FCHGSM2D   CF   E             WORKSTN
001000000000    ?F                                     INFDS(DSPD)
001100040728     FISCSMN    IF   E           K DISK
001200000000    ? *
001300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001500000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001600000000    ? *_________________________________________________________________________
001700000406    ? * Data structure
001800040728    ?D WUDTA         E DS                  EXTNAME(ISCSM2)
001900010220    ?D WDGLB         E DS                  EXTNAME(ISCGLB)
002000010220    ?D WDSMN         E DS                  EXTNAME(ISCSMN) PREFIX(M)
002100040729    ?D WSDTA         E DS                  EXTNAME(ISCSM2) PREFIX(W_)
002200000000    ? *
002300000000    ? * Program status data structure
002400991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002500000000    ? *
002600000000    ? * Display file data structure
002700991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002800000000    ? *
002900000000    ? * CURSOR LOCATION
003000000000    ?D                 DS
003100000000    ?D  WWCRSL                 1      2
003200000000    ?D  WWCRSN                 1      2B 0
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
007500010220    ?C                   Move      *ZEROS        WSDATE                         RETURN CODE
007600020220    ?C                   Move      *ZEROS        WSEFDT                         RETURN CODE
007700020220    ?C                   Move      *ZEROS        WSTRDT                         RETURN CODE
007800991108    ?C                   Move      'N'           WWERR                          NO ERRORS
007900000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008000000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008100000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008200000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008300000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008400000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
008500000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
008600000000    ? *
008700000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
008800000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
008900000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009000000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009100000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009200000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009300000000    ? *
009400000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
009500040728    ? *
009600040729     C                   EVAL      W_ISSMAN = ISSMAN
009700040728     C     ISSMAN        CHAIN     ISCSMN
009800000000    ? *
009900000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
010000000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
010100000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
010200000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
010300000000    ?C                   Cas                     PRCERR                         PROC ERROR
010400000000    ?C                   Endcs                                                  END CASE
010500000000    ? *
010600000000    ?C                   Endsr                                                  END PRPPNL
010700000000    ? *___________________________________________________________________
010800000000    ? * Prepare ADD request
010900000000    ? *___________________________________________________________________
011000000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
011100000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
011200040729     C                   EVAL      ISSMAN = W_ISSMAN
011300000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
011400000000    ?C                   Endsr                                                  END PRP ADD
011500000000    ? *___________________________________________________________________
011600000000    ? * Prepare CHANGE request
011700000000    ? *___________________________________________________________________
011800000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
011900040728    ?C                   Call      'UPDSM2  '                                   PROCESS REC IO
012000000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
012100000000    ?C                   Parm                    WWRTN                          RETURN CODE
012200000614    ?C                   Parm                    WUDTA                          REC DATA
012300020220    ?C                   Parm                    FRRN                           FNC KEY ALLOWED
012400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
012500000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
012600000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
012700000000X002?C                   Else                                                   ELSE
012800000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
012900000000E002?C                   Endif                                                  END RCD NOT AVL
013000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
013100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013200000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
013300000810E001?C                   Else                                                   END IF ERROR
013400010219     C     ISCHGD        MULT      10000.0001    WSDATE
013500020220     C     ISEFDT        MULT      10000.0001    WSEFDT
013600020220     C     ISTRDT        MULT      10000.0001    WSTRDT
013700000810E001?C                   Endif                                                  END IF ERROR
013800000000    ?C                   Endsr                                                  END PRP CHANGE
013900000000    ? *___________________________________________________________________
014000000000    ? * Prepare COPY request
014100000000    ? *___________________________________________________________________
014200000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
014300000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
014400040728    ?C                   Call      'UPDSM2  '                                   PROCESS REC IO
014500000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
014600000000    ?C                   Parm                    WWRTN                          RETURN CODE
014700000614    ?C                   Parm                    WUDTA                          REC DATA
014800020220    ?C                   Parm                    FRRN                           FNC KEY ALLOWED
014900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015000000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
015100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
015200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015400000000X001?C                   Else                                                   ELSE
015500000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
015600040729 001?C                   Clear                   ISEFDT                         CLEAR KEY
015700020220     C     ISCHGD        MULT      10000.0001    WSDATE
015800020220     C     ISEFDT        MULT      10000.0001    WSEFDT
015900020220     C     ISTRDT        MULT      10000.0001    WSTRDT
016000000000E001?C                   Endif                                                  END IF ERROR
016100000000    ?C                   Endsr                                                  END PREP COPY
016200000000    ? *___________________________________________________________________
016300000000    ? * Default Data
016400000000    ? *___________________________________________________________________
016500000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
016600040728    ?C                   Call      'CHKSM2  '                                   PROCESS REC IO
016700000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
016800000000    ?C                   Parm                    WWRTN                          RETURN CODE
016900000614    ?C                   Parm                    WUDTA                          REC DATA
017000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
017100000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
017200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
017300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
017500000000E001?C                   Endif                                                  END IF ERROR
017600000000    ?C                   Endsr                                                  END DFTDTA
017700000000    ? *___________________________________________________________________
017800000000    ? * Process ERROR function
017900000000    ? *___________________________________________________________________
018000000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
018100000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
018200000000    ?C                   Exsr      SNDMSG                                       SEND MSG
018300000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018400000000    ?C                   Move      'END'         WWSTT                          END STATE
018500000000    ?C                   Endsr                                                  END PRCERR
018600000000    ? *___________________________________________________________________
018700000000    ? * Receive messages
018800000000    ? *___________________________________________________________________
018900000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
019000000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
019100000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
019200000000X001?C                   Else                                                   ELSE
019300000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
019400000000E001?C                   Endif                                                  ENDIF NOT NORESET
019500000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
019600000000    ?C                   Movea     *IN           WWIN                           INDICATORS
019700000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
019800000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
019900000000    ?C                   Parm                    WWIN                           INDICATORS
020000000000    ?C                   Parm                    WWRTN                          RETURN CODE
020100000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
020200000000    ?C                   Endsr                                                  END RCV MSG
020300000000    ? *___________________________________________________________________
020400000000    ? * Display panels
020500000000    ? *___________________________________________________________________
020600000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
020700000000    ? *
020800000000    ? * Set PUTOVR based on last display file processed
020900000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
021000000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
021100000000 001?C                   Setoff                                       35        PUTOVR OFF
021200000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
021300000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
021400000000X001?C                   Else                                                   ELSE SAME PGM
021500000000 001?C                   Seton                                        35        PUTOVR ON
021600000000E001?C                   Endif                                                  END IF NEW PGM
021700000000    ? *
021800000614    ? * Set PROTECT key based on request
021900000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
022000000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
022100000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
022200000000 001?C                   Setoff                                       40        NO PROTECT KEY
022300000000X001?C                   Else                                                   ELSE
022400000000 001?C                   Seton                                        40        PROTECT KEY
022500000000E001?C                   Endif                                                  END IF ADD
022600000000    ? *
022700000000    ? * Select title
022800000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
022900000000 001?C                   Setoff                                       38        CHANGE TITLE
023000000000X001?C                   Else                                                   ELSE
023100000000 001?C                   Seton                                        38        ADD TITLE
023200000000E001?C                   Endif                                                  END IF CHANGE
023300000000    ? *
023400000000    ? * Position cursor based on error status
023500000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
023600000000 001?C                   Seton                                        99        POS CSR TO ERROR
023700000000X001?C                   Else                                                   ELSE
023800000000 001?C                   Setoff                                       99        POS CSR TO FIRST
023900000000E001?C                   Endif                                                  END IF ERROR
024000000000    ? *
024100000000    ? * Write message subfile
024200000000    ?C                   Seton                                        30        MSGSFL DISPLAY
024300000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
024400000000    ? *
024500000000    ? * Write entry panel
024600000000B001?C                   Select
024700000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
024800000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
024900000000 001?C                   Setoff                                       37        RESET CRSLOC
025000000000E001?C                   Endsl                                                  END SELECT
025100000000    ? *
025200000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
025300000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
025400000000E001?C                   Endif                                                  END IF DATA CHG
025500000000    ?C                   Endsr                                                  END DSPENT
025600000000    ? *___________________________________________________________________
025700000000    ? * Process function key
025800000000    ? *___________________________________________________________________
025900000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
026000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
026100991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
026200000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
026300000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
026400000000    ?C                   Parm                    WAD                            FNC DESC
026500991108    ?C                   Parm                    WWIN                           AID BYTE
026600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
026700000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
026800000000    ?C                   Endsr                                                  END PRCFKY
026900000000    ? *___________________________________________________________________
027000000000    ? * Process KEYS function
027100000000    ? *___________________________________________________________________
027200000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
027300000000    ?C                   Z-add     1             WW                             KEY DSC IDX
027400000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
027500000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
027600000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
027700000000 001? *
027800000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
027900000000 002?C                   Z-add     1             WWFKS                          SET TO 1
028000000000E002?C                   Endif                                                  END IF OVER 3
028100000000 001? *
028200000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
028300000000 001?C                   Sub       1             WW                             KEY DESCR IDX
028400000000E001?C                   Enddo                                                  END DO KEYS
028500000000    ? *
028600000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
028700000000    ?C                   Add       1             WW                             BUMP IDX
028800000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
028900000000    ?C                   Endsr                                                  END PRCDKY
029000000000    ? *___________________________________________________________________
029100000000    ? * Process EXIT Function
029200000000    ? *___________________________________________________________________
029300000000    ?C     PRCEXT        Begsr                                                  RETURN
029400000000    ? *
029500000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
029600000000    ? *
029700000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
029800000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
029900000000X001?C                   Else                                                   ELSE NO ERRORS
030000000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
030100000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
030200000000E001?C                   Endif                                                  END IF ERRORS
030300000000    ?C                   Endsr                                                  END PRCEXT
030400000000    ? *___________________________________________________________________
030500000000    ? * Process PROMPT function
030600000000    ? *___________________________________________________________________
030700000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
030800000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
030900000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
031000000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
031100000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
031200000000    ? *
031300000000B001?C                   Select                                                 SELECT
031400010220 001 C                   When      WSFLD = 'ISITYP'
031500010220 001?C                   Call      'SLCGLB  '                                   CALL SELECT PROGRAM
031600010220 001?C                   Parm                    WWRQS                          REQUEST
031700010220 001?C                   Parm                    WWRTN                          RETURN CODE
031800010220 001?C                   Parm                    WUPGM                          PROGRAM
031900010220 001?C                   Parm                    WDGLB                          RECORD DS
032000010220B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
032100010220 003?C                   Movel     IGITYP        ISITYP                         SET CODE
032200010220E001?C                   Endif
032300010220    ? *
032400010220 001 C                   When      WSFLD = 'ISSMGR'
032500010220 001?C                   Call      'SLCSMNM '                                   CALL SELECT PROGRAM
032600010220 001?C                   Parm                    WWRQS                          REQUEST
032700010220 001?C                   Parm                    WWRTN                          RETURN CODE
032800010220 001?C                   Parm                    WUPGM                          PROGRAM
032900010220 001?C                   Parm                    WDSMN                          RECORD DS
033000010220B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
033100010220 003?C                   Movel     MISSMAN       ISSMGR                         SET CODE
033200010220E001?C                   Endif
033300000112 001? *
033400000000 001?C                   Other                                                  WHERE ERROR
033500000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
033600000000 001?C                   Exsr      SNDMSG                                       SEND MSG
033700000000E001?C                   Endsl                                                  END SELECT
033800000000    ? *
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
038000000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
038100000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
038200000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
038300020220     C                   Z-add     WSEFDT        IsEFDT
038400020220     C                   Z-add     WSTRDT        IsTRDT
038500040802     C  N40              Eval      WWRQS = 'EDTADD'
038600040802     C   40              Eval      WWRQS = 'EDIT  '
038700040728 001?C                   Call      'CHKSM2  '                                   CHECK DATA
038800040802 001?C                   Parm                    WWRQS                          EDIT REQUEST
038900000000 001?C                   Parm                    WWRTN                          RETURN CODE
039000000614 001?C                   Parm                    WUDTA                          REC DATA
039100000000E001?C                   Endif                                                  ENDIF
039200000000    ? *
039300000000B001?C                   Select                                                 PRC RETURN CDE
039400000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
039500000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
039600010219 001?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
039700000000 001? *
039800000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
039900000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
040000000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
040100010219 002?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
040200000000X002?C                   Else                                                   ELSE
040300000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
040400000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
040500000000E002?C                   Endif                                                  IF WARNING
040600000000 001? *
040700000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
040800000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
040900000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
041000000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
041100000000E001?C                   Endsl                                                  RETURN CODE SEL
041200000000    ? *
041300000000    ?C                   Endsr                                                  END PRCPNL
041400000000    ? *___________________________________________________________________
041500000000    ? * Process end - write data or release record
041600000000    ? *___________________________________________________________________
041700000000    ?C     PRCEND        Begsr                                                  PROCESS END
041800000000    ? *
041900000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
042000000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
042100000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
042200000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
042300000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
042400000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
042500000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
042600000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
042700000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
042800000000 001?C                   Endcs                                                  END CASE
042900000000 001? *
043000000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
043100000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
043200000000 002? *
043300000000X002?C                   Else                                                   ELSE NO WRT ERR
043400000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
043500000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
043600000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
043700000000 004?C                   Exsr      PRPPNL                                       DO NOT END
043800000810E004?C                   Endif                                                  END IF ADD
043900000000E003?C                   Endif                                                  END IF NOT END
044000000000E002?C                   Endif                                                  END IF WRITE ERROR
044100000000 001? *
044200000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
044300000000 001?C                   Exsr      RELREC                                       RELEASE REC
044400000000E001?C                   Endif                                                  END IF RCD CHANGED
044500000000    ? *
044600000000    ?C                   Endsr                                                  END PRCEND
044700000000    ? *___________________________________________________________________
044800000000    ? * Add new record
044900000000    ? *___________________________________________________________________
045000000000    ?C     WRTADD        Begsr                                                  WRITE ADD
045100000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
045200000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
045300000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
045400000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
045500000000E001?C                   Endif                                                  END IF ADD
045600000000    ? *
045700000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
045800000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
045900000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
046000000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
046100000000E001?C                   Endif                                                  END IF ADD KEY
046200000000    ? *
046300040728    ?C                   Call      'UPDSM2  '                                   PROCESS REC IO
046400000000    ?C                   Parm                    WWRQS                          ADD RECORD
046500000000    ?C                   Parm                    WWRTN                          RETURN CODE
046600000614    ?C                   Parm                    WUDTA                          REC DATA
046700020220    ?C                   Parm                    FRRN                           FNC KEY ALLOWED
046800000000    ? *
046900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
047000000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
047100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047200000000X001?C                   Else                                                   ELSE
047300000000E001?C                   Endif                                                  END IF CALL ERROR
047400000000    ? *
047500000000    ?C                   Endsr                                                  END WRTADD
047600000000    ? *___________________________________________________________________
047700000000    ? * Write changed record
047800000000    ? *___________________________________________________________________
047900000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
048000040728    ?C                   Call      'UPDSM2  '                                   PROCESS REC IO
048100000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
048200000000    ?C                   Parm                    WWRTN                          RETURN CODE
048300000614    ?C                   Parm                    WUDTA                          REC DATA
048400020220    ?C                   Parm                    FRRN                           FNC KEY ALLOWED
048500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
048600000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
048700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
048800000000E001?C                   Endif                                                  END IF CALL ERROR
048900000000    ? *
049000000000    ?C                   Endsr                                                  END WRTCHG
049100000000    ? *___________________________________________________________________
049200000000    ? * Release record
049300000000    ? *___________________________________________________________________
049400000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
049500040728    ?C                   Call      'UPDSM2  '                                   PROCESS REC IO
049600000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
049700000000    ?C                   Parm                    WWRTN                          RETURN CODE
049800000614    ?C                   Parm                    WUDTA                          REC DATA
049900020220    ?C                   Parm                    FRRN                           FNC KEY ALLOWED
050000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
050100000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
050200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
050300000000E001?C                   Endif                                                  END IF CALL ERROR
050400000000    ?C                   Endsr                                                  END RELREC
050500000000    ? *___________________________________________________________________
050600000000    ? * Build function keys
050700000000    ? *___________________________________________________________________
050800000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
050900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
051000991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
051100000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
051200000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
051300000000    ?C                   Parm                    WAD                            FNC DESC
051400991108    ?C                   Parm                    WWIN                           AID BYTE
051500000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
051600000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
051700000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
051800000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
051900000000    ?C                   Sub       1             WW                             BUMP IDX
052000000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
052100000000    ?C                   Endsr                                                  END BLD FNCTNS
052200000000    ? *___________________________________________________________________
052300000000    ? * Send message
052400000000    ? *___________________________________________________________________
052500000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
052600000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
052700000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
052800000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
052900000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
053000000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
053100000000    ?C                   Endsr                                                  END SNDMSG
053200000000    ? *___________________________________________________________________
053300000000    ? * Paremater list
053400000000    ? *___________________________________________________________________
053500000000    ?C     PLIST         Begsr                                                  PARM LISTS
053600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
053700000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
053800000000    ?C                   Parm                    WORTN             8            RETURN CODE
053900000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
054000000614    ?C                   Parm                    WUDTA                          RECORD KEY
054100000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
054200020220    ?C                   Parm                    FRRN              6 0          FNC KEY ALLOWED
054300000000    ?C                   Endsr                                                  END PLIST
054400000000    ? *___________________________________________________________________
054500000000    ? * Initialize routine
054600000000    ? *___________________________________________________________________
054700000000    ?C     *INZSR        Begsr                                                  INITIALIZE
054800000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
054900000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
055000000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
055100000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
055200000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
055300000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
055400000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
055500000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
055600000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
055700000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
055800000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
055900000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
056000000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
056100000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
056200000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
056300000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
056400000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
056500000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
056600000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
056700000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
056800000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
056900000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
057000000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
057100000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
057200000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
057300040728    ?C                   Movel     'ISCSM2  '    WWFIL            10            FILE NAME-NOTES
057400000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
057500000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
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
05970004072800Request not supported in program CHGSM2.
05980000000000Update error.  Data was not updated.
05990000000000Duplicate key detected.  Data was NOT added to file.
06000000000000Call to notes ended in error.
06010000000000Initialize error.  Record not initialized.
06020000000000Record not found.
06030000000000Generate error.  Key not generated.
06040000000000Record not available now.
06050000000000The cursor is not in a prompt area.
06060000000000Default error.  Data not defaulted.
