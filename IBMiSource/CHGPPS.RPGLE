000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300111216    ? *  Description:  Change Start Date
000400000000    ? *
000500111216    ? *  (c)Copyright 2011 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700111216    ?FCHGPPSD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000801100617     FACCMST    IF   E           K DISK
000802111216     FWEBPAYCHP IF   E           K DISK
001000000000    ? *
001100000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001300030313    ?D WTM             S             80    DIM(11) CTDATA PERRCD(1)             PANEL MESSAGES
001301100618     D WSDESC          S             20A
001400000000    ? *_________________________________________________________________________
001500000406    ? * Data structure
001501111216    ?D WUDTA         E DS                  EXTNAME(WEBPAYSTR)
001502111216    ?D WGDTA         E DS                  EXTNAME(WEBPAYCHP)
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
002800000000    ? *_________________________________________________________________________
002900000000    ? *
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
004600030313 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
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
007000991108    ?C                   Move      'N'           WWERR                          NO ERRORS
007100000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
007200000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
007300000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007400000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
007500000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
007600000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
007700000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
007800000000    ? *
007900000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
008000000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
008100000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
008200000000E002?C                   Endif                                                  ENDIF SAME REQUEST
008300000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
008400000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
008500000000    ? *
008600000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
008700100520    ? *
008800100520     C     KEYACC        Klist
008900111216     C                   kfld                    PPTRST
009000111216     C                   kfld                    PPSUB#
009100111216     C                   kfld                    PPACCT
009300100520     C     KEYACC        Chain     ACCMST
009400100520     C                   if        %found(ACCMST)
009500100520     C                   Eval      WWANAM = %trim(ACNAM1)
009600100520     C                   Else
009700100617     C                   Eval      WWANAM = *blanks
009800100521     C                   End
009801111216    ? *
009802111216     C                   Eval      WWDIV  = *blanks
009803111216     C                   If        PPDIV  <> *blanks
009804111216     C                   Eval      PCGRPR  = 'DIVISION'
009805111216     C                   Eval      PCCODE  = PPDIV
009807111216     C     KEYOPT        Klist
009808111216     C                   kfld                    PPTRST
009809111216     C                   kfld                    PPSUB#
009810111216     C                   kfld                    PPACCT
009811111216     C                   kfld                    PCGRPR
009812111216     C                   kfld                    PCCODE
009813111216     C     KEYOPT        Chain     WEBPAYCHP
009814111216     C                   if        %found(WEBPAYCHP)
009815111216     C                   Eval      WWDIV = %trim(PCDESC)
009816111216     C                   Else
009817111216     C                   Eval      WWDIV = *blanks
009818111216     C                   End
009819111216     C                   End
010234100617    ? *
010300000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
010400000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
010500000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
010600000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
010700000000    ?C                   Cas                     PRCERR                         PROC ERROR
010800000000    ?C                   Endcs                                                  END CASE
010900000000    ? *
011000000000    ?C                   Endsr                                                  END PRPPNL
011100000000    ? *___________________________________________________________________
011200000000    ? * Prepare ADD request
011300000000    ? *___________________________________________________________________
011400000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
011500000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
011503100617     C                   Clear                   WWANAM
011600000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
011700000000    ?C                   Endsr                                                  END PRP ADD
011800000000    ? *___________________________________________________________________
011900000000    ? * Prepare CHANGE request
012000000000    ? *___________________________________________________________________
012100000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
012200111216    ?C                   Call      'UPDPPS  '                                   PROCESS REC IO
012300000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
012400000000    ?C                   Parm                    WWRTN                          RETURN CODE
012500000614    ?C                   Parm                    WUDTA                          REC DATA
012600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
012700000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
012800000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
012900000000X002?C                   Else                                                   ELSE
013000000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
013100000000E002?C                   Endif                                                  END RCD NOT AVL
013200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
013300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
013500000810E001?C                   Endif                                                  END IF ERROR
013600000000    ?C                   Endsr                                                  END PRP CHANGE
013700000000    ? *___________________________________________________________________
013800000000    ? * Prepare COPY request
013900000000    ? *___________________________________________________________________
014000000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
014100000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
014200111216    ?C                   Call      'UPDPPS  '                                   PROCESS REC IO
014300000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
014400000000    ?C                   Parm                    WWRTN                          RETURN CODE
014500000614    ?C                   Parm                    WUDTA                          REC DATA
014600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014700000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014900000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015000000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015100000000X001?C                   Else                                                   ELSE
015200000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
015300000000E001?C                   Endif                                                  END IF ERROR
015400000000    ?C                   Endsr                                                  END PREP COPY
015500000000    ? *___________________________________________________________________
015600000000    ? * Default Data
015700000000    ? *___________________________________________________________________
015800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
015900111216    ?C                   Call      'CHKPPS  '                                   PROCESS REC IO
016000000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
016100000000    ?C                   Parm                    WWRTN                          RETURN CODE
016200000614    ?C                   Parm                    WUDTA                          REC DATA
016300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016400000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
016500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016800000000E001?C                   Endif                                                  END IF ERROR
016900000000    ?C                   Endsr                                                  END DFTDTA
017000000000    ? *___________________________________________________________________
017100000000    ? * Process ERROR function
017200000000    ? *___________________________________________________________________
017300000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
017400000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
017500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
017600000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017700000000    ?C                   Move      'END'         WWSTT                          END STATE
017800000000    ?C                   Endsr                                                  END PRCERR
017900000000    ? *___________________________________________________________________
018000000000    ? * Receive messages
018100000000    ? *___________________________________________________________________
018200000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
018300000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
018400000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
018500000000X001?C                   Else                                                   ELSE
018600000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
018700000000E001?C                   Endif                                                  ENDIF NOT NORESET
018800000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
018900000000    ?C                   Movea     *IN           WWIN                           INDICATORS
019000000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
019100000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
019200000000    ?C                   Parm                    WWIN                           INDICATORS
019300000000    ?C                   Parm                    WWRTN                          RETURN CODE
019400000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
019500000000    ?C                   Endsr                                                  END RCV MSG
019600000000    ? *___________________________________________________________________
019700000000    ? * Display panels
019800000000    ? *___________________________________________________________________
019900000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
020000000000    ? *
020100000000    ? * Set PUTOVR based on last display file processed
020200000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
020300000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
020400000000 001?C                   Setoff                                       35        PUTOVR OFF
020500000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
020600000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
020700000000X001?C                   Else                                                   ELSE SAME PGM
020800000000 001?C                   Seton                                        35        PUTOVR ON
020900000000E001?C                   Endif                                                  END IF NEW PGM
021000000000    ? *
021100000614    ? * Set PROTECT key based on request
021200000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
021300000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
021400000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
021500000000 001?C                   Setoff                                       40        NO PROTECT KEY
021600000000X001?C                   Else                                                   ELSE
021700000000 001?C                   Seton                                        40        PROTECT KEY
021800000000E001?C                   Endif                                                  END IF ADD
021900000000    ? *
022000000000    ? * Select title
022100000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
022200000000 001?C                   Setoff                                       38        CHANGE TITLE
022300000000X001?C                   Else                                                   ELSE
022400000000 001?C                   Seton                                        38        ADD TITLE
022500000000E001?C                   Endif                                                  END IF CHANGE
022600000000    ? *
022700000000    ? * Position cursor based on error status
022800000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
022900000000 001?C                   Seton                                        99        POS CSR TO ERROR
023000000000X001?C                   Else                                                   ELSE
023100000000 001?C                   Setoff                                       99        POS CSR TO FIRST
023200000000E001?C                   Endif                                                  END IF ERROR
023300000000    ? *
023400000000    ? * Write message subfile
023500000000    ?C                   Seton                                        30        MSGSFL DISPLAY
023600000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
023700000000    ? *
023800000000    ? * Write entry panel
023900000000B001?C                   Select
024000000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
024100000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
024200000000 001?C                   Setoff                                       37        RESET CRSLOC
024300000000E001?C                   Endsl                                                  END SELECT
024400000000    ? *
024500000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
024600000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
024700000000E001?C                   Endif                                                  END IF DATA CHG
024800000000    ?C                   Endsr                                                  END DSPENT
024900000000    ? *___________________________________________________________________
025000000000    ? * Process function key
025100000000    ? *___________________________________________________________________
025200000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
025300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
025400991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
025500000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
025600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
025700000000    ?C                   Parm                    WAD                            FNC DESC
025800991108    ?C                   Parm                    WWIN                           AID BYTE
025900000000    ?C                   Parm                    WAF                            FNC KEY TABLE
026000000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
026100000000    ?C                   Endsr                                                  END PRCFKY
026200000000    ? *___________________________________________________________________
026300000000    ? * Process KEYS function
026400000000    ? *___________________________________________________________________
026500000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
026600000000    ?C                   Z-add     1             WW                             KEY DSC IDX
026700000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
026800000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
026900000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
027000000000 001? *
027100000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
027200000000 002?C                   Z-add     1             WWFKS                          SET TO 1
027300000000E002?C                   Endif                                                  END IF OVER 3
027400000000 001? *
027500000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
027600000000 001?C                   Sub       1             WW                             KEY DESCR IDX
027700000000E001?C                   Enddo                                                  END DO KEYS
027800000000    ? *
027900010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
028000010913    ?C                   Add       1             WW                             BUMP IDX
028100010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
028200010913    ?C                   Endsr                                                  END PRCDKY
028300000000    ? *___________________________________________________________________
028400000000    ? * Process EXIT Function
028500000000    ? *___________________________________________________________________
028600000000    ?C     PRCEXT        Begsr                                                  RETURN
028700000000    ? *
028800000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
028900000000    ? *
029000000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
029100000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
029200000000X001?C                   Else                                                   ELSE NO ERRORS
029900000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
030000000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
030200011024E001?C                   Endif                                                  END IF ERRORS
030201100610
030300000000    ?C                   Endsr                                                  END PRCEXT
030400000000    ? *___________________________________________________________________
030500000000    ? * Process PROMPT function
030600000000    ? *___________________________________________________________________
030700000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
030800000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
030900000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
031000000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
031100000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
031200020920    ? *
031300000000B001?C                   Select                                                 SELECT
031400020923    ? *
031500101019 001 C                   When      WSFLD = 'PGCODE '
032500020923    ? *
032600000000 001?C                   Other                                                  WHERE ERROR
032700000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
032800000000 001?C                   Exsr      SNDMSG                                       SEND MSG
032900000000E001?C                   Endsl                                                  END SELECT
033000000000    ? *
033100000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
033200000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
033300000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
033400000000    ?C                   Mvr                     WSLIN                          CURSOR COL
033500000000    ?C                   Seton                                        37        SET ON CRSLOC
033600000000    ? *
033700000000    ?C                   Endsr                                                  END PRCPMT
033800000000    ? *___________________________________________________________________
033900000000    ? * Process CANCEL Function
034000000000    ? *___________________________________________________________________
034100000000    ?C     PRCCNL        Begsr                                                  CANCEL
034200000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
034300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
034400000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
034500000000    ?C                   Endsr                                                  END RETURN
034600000000    ? *___________________________________________________________________
034700000000    ? * Process ROLLUP function
034800000000    ? *___________________________________________________________________
034900000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
035000000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
035100000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
035200000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
035300000000E001?C                   Endif                                                  END IF GT LST PNL
035400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
035500000000    ?C                   Endsr                                                  END PRCRUP
035600000000    ? *___________________________________________________________________
035700000000    ? * Process ROLLDOWN function
035800000000    ? *___________________________________________________________________
035900000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
036000000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
036100000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
036200000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
036300000000E001?C                   Endif                                                  END IF LT FST PNL
036400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
036500000000    ?C                   Endsr                                                  END PRCRDN
036600000000    ? *___________________________________________________________________
036700000000    ? * Process ENTER function
036800000000    ? *___________________________________________________________________
036900000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
037000000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
037100000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
037200000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
037300000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
037400000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
037500111216 001?C                   Call      'CHKPPS  '                                   CHECK DATA
037600000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
037700000000 001?C                   Parm                    WWRTN                          RETURN CODE
037800000614 001?C                   Parm                    WUDTA                          REC DATA
037900000000E001?C                   Endif                                                  ENDIF
038000100521    ? *
038200100521     C     KEYACC        Chain     ACCMST
038300100521     C                   if        %found(ACCMST)
038400100521     C                   Eval      WWANAM = %trim(ACNAM1)
038500100521     C                   Else
038600100617     C                   Eval      WWANAM = *Blanks
038700100521     C                   End
038701111216    ? *
038702111216     C                   Eval      WWDIV  = *blanks
038703111216     C                   If        PPDIV  <> *blanks
038704111216     C                   Eval      PCGRPR  = 'DIVISION'
038705111216     C                   Eval      PCCODE  = PPDIV
038712111216     C     KEYOPT        Chain     WEBPAYCHP
038713111216     C                   if        %found(WEBPAYCHP)
038714111216     C                   Eval      WWDIV = %trim(PCDESC)
038715111216     C                   Else
038716111216     C                   Eval      WWDIV = *blanks
038717111216     C                   End
038718111216     C                   End
039100000000    ? *
039200000000B001?C                   Select                                                 PRC RETURN CDE
039300000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
039400000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
039500000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
039600000000 001? *
039700000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
039800000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
039900000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
040000000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
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
041700000000    ? *
041800000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
041900000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
042000000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
042100000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
042200000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
042300000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
042400000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
042500000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
042600000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
042700000000 001?C                   Endcs                                                  END CASE
042800000000 001? *
042900000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
043000000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
043100000000 002? *
043200000000X002?C                   Else                                                   ELSE NO WRT ERR
043300000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
043400000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
043500000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
043600000000 004?C                   Exsr      PRPPNL                                       DO NOT END
043700000810E004?C                   Endif                                                  END IF ADD
043800000000E003?C                   Endif                                                  END IF NOT END
043900000000E002?C                   Endif                                                  END IF WRITE ERROR
044000000000 001? *
044100000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
044200000000 001?C                   Exsr      RELREC                                       RELEASE REC
044300000000E001?C                   Endif                                                  END IF RCD CHANGED
044400000000    ? *
044500000000    ?C                   Endsr                                                  END PRCEND
044600000000    ? *___________________________________________________________________
044700000000    ? * Add new record
044800000000    ? *___________________________________________________________________
044900000000    ?C     WRTADD        Begsr                                                  WRITE ADD
045000000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
045100000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
045200000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
045300000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
045400000000E001?C                   Endif                                                  END IF ADD
045500000000    ? *
045600000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
045700000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
045800000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
045900000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
046000000000E001?C                   Endif                                                  END IF ADD KEY
046100000000    ? *
046200111216    ?C                   Call      'UPDPPS  '                                   PROCESS REC IO
046300000000    ?C                   Parm                    WWRQS                          ADD RECORD
046400000000    ?C                   Parm                    WWRTN                          RETURN CODE
046500000614    ?C                   Parm                    WUDTA                          REC DATA
046600000000    ? *
046700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
046800000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
046900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047000000000X001?C                   Else                                                   ELSE
047100000000E001?C                   Endif                                                  END IF CALL ERROR
047200000000    ? *
047300000000    ?C                   Endsr                                                  END WRTADD
047400000000    ? *___________________________________________________________________
047500000000    ? * Write changed record
047600000000    ? *___________________________________________________________________
047700000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
047800111216    ?C                   Call      'UPDPPS  '                                   PROCESS REC IO
047900000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
048000000000    ?C                   Parm                    WWRTN                          RETURN CODE
048100000614    ?C                   Parm                    WUDTA                          REC DATA
048200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
048300000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
048400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
048500000000E001?C                   Endif                                                  END IF CALL ERROR
048600000000    ? *
048700000000    ?C                   Endsr                                                  END WRTCHG
048800011024    ? *___________________________________________________________________
048900011024    ? * Inz NO Key
049000011024    ? *___________________________________________________________________
049100011024    ?C     INZNKY        Begsr                                                  WRITE CHANGE
049200111216    ?C                   Call      'UPDPPS  '                                   PROCESS REC IO
049300011024    ?C                   Parm      'INZNKY'      WWRQS                          UPDATE RECORD
049400011024    ?C                   Parm                    WWRTN                          RETURN CODE
049500011024    ?C                   Parm                    WUDTA                          REC DATA
049600011024B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
049700011024 001?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
049800011024 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
049900011024E001?C                   Endif                                                  END IF CALL ERROR
050000011024    ? *
050100011024    ?C                   Endsr                                                  END WRTCHG
050200000000    ? *___________________________________________________________________
050300000000    ? * Release record
050400000000    ? *___________________________________________________________________
050500000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
050600111216    ?C                   Call      'UPDPPS  '                                   PROCESS REC IO
050700000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
050800000000    ?C                   Parm                    WWRTN                          RETURN CODE
050900000614    ?C                   Parm                    WUDTA                          REC DATA
051000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
051100000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
051200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
051300000000E001?C                   Endif                                                  END IF CALL ERROR
051400000000    ?C                   Endsr                                                  END RELREC
051500000000    ? *___________________________________________________________________
051600000000    ? * Build function keys
051700000000    ? *___________________________________________________________________
051800000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
051900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
052000991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
052100000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
052200000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
052300000000    ?C                   Parm                    WAD                            FNC DESC
052400991108    ?C                   Parm                    WWIN                           AID BYTE
052500000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
052600000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
052700010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
052800010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
052900010913    ?C                   Sub       1             WW                             BUMP IDX
053000010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
053100000000    ?C                   Endsr                                                  END BLD FNCTNS
053200000000    ? *___________________________________________________________________
053300000000    ? * Send message
053400000000    ? *___________________________________________________________________
053500000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
053600000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
053700000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
053800000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
053900000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
054000000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
054100000000    ?C                   Endsr                                                  END SNDMSG
054200000000    ? *___________________________________________________________________
054300000000    ? * Paremater list
054400000000    ? *___________________________________________________________________
054500000000    ?C     PLIST         Begsr                                                  PARM LISTS
054600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
054700000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
054800000000    ?C                   Parm                    WORTN             8            RETURN CODE
054900000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
055000000614    ?C                   Parm                    WUDTA                          RECORD KEY
055100000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
055200000000    ?C                   Endsr                                                  END PLIST
055300000000    ? *___________________________________________________________________
055400000000    ? * Initialize routine
055500000000    ? *___________________________________________________________________
055600000000    ?C     *INZSR        Begsr                                                  INITIALIZE
055700000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
055800000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
055900000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
056000000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
056100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
056200000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
056300000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
056400000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
056500000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
056600000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
056700000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
056800000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
056900000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
057000000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
057100000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
057200000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
057300000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
057400000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
057500000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
057600000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
057700000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
057800000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
057900000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
058000000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
058100000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
058200111216    ?C                   Movel     'WEBPAYSTR'   WWFIL            10            FILE NAME-NOTES
058300000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
058400000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
058500000000    ?C                   Endsr                                                  END INITIALIZE
058600000000    ? *___________________________________________________________________
058700000000    ? * Program error handler
058800000000    ? *___________________________________________________________________
058900000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
059000000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
059100000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
059200000000    ?C                   Parm                    WQSTSC                         STATUS CODE
059300000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
059400000000    ?C                   Parm                    WQMSG                          MESSAGE ID
059500000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
059600000000    ? *___________________________________________________________________
059700000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05980000000003EXIT    F3=Exit
05990000000004PROMPT  F4=Prompt
06000003031305REFRESH F5=Refresh
06010000070710UPDATE  F10=Update
06020000061412CANCEL  F12=Cancel
06030000000025ROLLUP
06040000000026ROLLDOWN
060500000000** WTM
06060011121600Request not supported in program CHGPPS.
06070000000000Update error.  Data was not updated.
06080000000000Duplicate key detected.  Data was NOT added to file.
06090000000000Call to notes ended in error.
06100000000000Initialize error.  Record not initialized.
06110000000000Record not found.
06120000000000Generate error.  Key not generated.
06130000000000Record not available now.
06140000000000The cursor is not in a prompt area.
06150003031300Default error.  Data not defaulted.
06160010052000
