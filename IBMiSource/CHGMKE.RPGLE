000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300070215    ? *  Description:  Change Market Exclude Account File
000400010914    ? *
000500070215    ? *  (c)Copyright 2007 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700070215    ?FCHGMKED   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900070215    ?FMKTRNE    if   e           k disk
001000060712    ?FCODES     if   e           k disk
001100060712    ?FACCMST    if   e           k disk
001200000000    ? *
001300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001500000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001600000000    ? *_________________________________________________________________________
001700000406    ? * Data structure
001800070215    ?D WUDTA         E DS                  EXTNAME(MKTRNE)
003000000000    ? *
003100000000    ? * Program status data structure
003200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003300000000    ? *
003400000000    ? * Display file data structure
003500991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003600000000    ? *
003700060712    ? *
003800000000    ? * CURSOR LOCATION
003900000000    ?D                 DS
004000000000    ?D  WWCRSL                 1      2
004100000000    ?D  WWCRSN                 1      2B 0
004200000000    ? *_________________________________________________________________________
004300000000    ? *
004400000614    ? * Process Entry Panel
004500000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
004600000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
004700000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
004800000000E001?C                   Endif                                                  END COPY/CPYKEY
004900000000    ? *
005000000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005100000000    ? *
005200000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005300000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005400000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
005500000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005600000000 001? *
005700000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
005800000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
005900000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
006000000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
006100000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006200000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
006300000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
006400000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
006500000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
006600000000 001?C                   Endcs                                                  END CASE
006700000000 001? *
006800000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
006900000000 002?C                   Exsr      PRCEND                                       PROCESS END
007000000000E002?C                   Endif                                                  END IF END REQ
007100000000E001?C                   Enddo                                                  END DOWHILE
007200000000    ? *
007300000707    ? * Send Info Updated message.
007400000707     C     WwChg         Ifeq      'Y'
007500000707     C                   Movel     'UPDATE  '    WORTN
007600000707     C                   Endif
007700000707    ? *
007800000000    ?C                   Return                                                 RETURN
007900000000    ? *___________________________________________________________________
008000000000    ? * Prepare panel
008100000000    ? *___________________________________________________________________
008200000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008300060712     C                   Clear                   LDESCR
008400060712     C                   Clear                   ACNAM1
008500000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
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
010200000000    ? *
010300000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
010400000000    ? *
010500000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
010600000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
010700000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
010800000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
010900000000    ?C                   Cas                     PRCERR                         PROC ERROR
011000000000    ?C                   Endcs                                                  END CASE
011100000000    ? *
011200000000    ?C                   Endsr                                                  END PRPPNL
011300000000    ? *___________________________________________________________________
011400000000    ? * Prepare ADD request
011500000000    ? *___________________________________________________________________
011600000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
011700000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
011800000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
011900000000    ?C                   Endsr                                                  END PRP ADD
012000000000    ? *___________________________________________________________________
012100000000    ? * Prepare CHANGE request
012200000000    ? *___________________________________________________________________
012300000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
012400070215    ?C                   Call      'UPDMKE  '                                   PROCESS REC IO
012500000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
012600000000    ?C                   Parm                    WWRTN                          RETURN CODE
012700000614    ?C                   Parm                    WUDTA                          REC DATA
012800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
012900000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
013000000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
013100000000X002?C                   Else                                                   ELSE
013200000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
013300000000E002?C                   Endif                                                  END RCD NOT AVL
013400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
013500000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013600000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
013700000810E001?C                   Else                                                   END IF ERROR
013800000810E001?C                   Endif                                                  END IF ERROR
013802070216     C     MEEEDT        Mult      10000.0001    MEEEDT
013803070216     C     MECHDT        Mult      10000.0001    MECHDT
013900000000    ?C                   Endsr                                                  END PRP CHANGE
014000000000    ? *___________________________________________________________________
014100000000    ? * Prepare COPY request
014200000000    ? *___________________________________________________________________
014300000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
014400000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
014500070215    ?C                   Call      'UPDMKE  '                                   PROCESS REC IO
014600000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
014700000000    ?C                   Parm                    WWRTN                          RETURN CODE
014800000614    ?C                   Parm                    WUDTA                          REC DATA
014900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015000000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
015100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
015200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015400000000X001?C                   Else                                                   ELSE
015500000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
015700000000E001?C                   Endif                                                  END IF ERROR
015800000000    ?C                   Endsr                                                  END PREP COPY
015900000000    ? *___________________________________________________________________
016000000000    ? * Default Data
016100000000    ? *___________________________________________________________________
016200000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
016300070215    ?C                   Call      'CHKMKE  '                                   PROCESS REC IO
016400000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
016500000000    ?C                   Parm                    WWRTN                          RETURN CODE
016600000614    ?C                   Parm                    WUDTA                          REC DATA
016700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016800000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
016900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
017000000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017100000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
017200000000E001?C                   Endif                                                  END IF ERROR
017300000000    ?C                   Endsr                                                  END DFTDTA
017400000000    ? *___________________________________________________________________
017500000000    ? * Process ERROR function
017600000000    ? *___________________________________________________________________
017700000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
017800000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
017900000000    ?C                   Exsr      SNDMSG                                       SEND MSG
018000000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018100000000    ?C                   Move      'END'         WWSTT                          END STATE
018200000000    ?C                   Endsr                                                  END PRCERR
018300000000    ? *___________________________________________________________________
018400000000    ? * Receive messages
018500000000    ? *___________________________________________________________________
018600000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
018700000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
018800000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
018900000000X001?C                   Else                                                   ELSE
019000000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
019100000000E001?C                   Endif                                                  ENDIF NOT NORESET
019200000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
019300000000    ?C                   Movea     *IN           WWIN                           INDICATORS
019400000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
019500000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
019600000000    ?C                   Parm                    WWIN                           INDICATORS
019700000000    ?C                   Parm                    WWRTN                          RETURN CODE
019800000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
019900000000    ?C                   Endsr                                                  END RCV MSG
020000000000    ? *___________________________________________________________________
020100000000    ? * Display panels
020200000000    ? *___________________________________________________________________
020300000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
020400000000    ? *
020500000000    ? * Set PUTOVR based on last display file processed
020600000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
020700000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
020800000000 001?C                   Setoff                                       35        PUTOVR OFF
020900000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
021000000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
021100000000X001?C                   Else                                                   ELSE SAME PGM
021200000000 001?C                   Seton                                        35        PUTOVR ON
021300000000E001?C                   Endif                                                  END IF NEW PGM
021400000000    ? *
021500000614    ? * Set PROTECT key based on request
021600000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
021700000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
021800000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
021900000000 001?C                   Setoff                                       40        NO PROTECT KEY
022000000000X001?C                   Else                                                   ELSE
022100000000 001?C                   Seton                                        40        PROTECT KEY
022200000000E001?C                   Endif                                                  END IF ADD
022300000000    ? *
022400000000    ? * Select title
022500000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
022600000000 001?C                   Setoff                                       38        CHANGE TITLE
022700000000X001?C                   Else                                                   ELSE
022800000000 001?C                   Seton                                        38        ADD TITLE
022900000000E001?C                   Endif                                                  END IF CHANGE
023000000000    ? *
023100000000    ? * Position cursor based on error status
023200000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
023300000000 001?C                   Seton                                        99        POS CSR TO ERROR
023400000000X001?C                   Else                                                   ELSE
023500000000 001?C                   Setoff                                       99        POS CSR TO FIRST
023600000000E001?C                   Endif                                                  END IF ERROR
023700000000    ? *
023800000000    ? * Write message subfile
023900000000    ?C                   Seton                                        30        MSGSFL DISPLAY
024000000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
024100000000    ? *
024200000000    ? * Write entry panel
024300000000B001?C                   Select
024400000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
024500060712    ? *
024600060712     C     CATKEY        klist
024700060712     C                   kfld                    TYPE
024800070215     C****************   kfld                    CNCAT
024900060712     C                   eval      type = 'P'
025000060712     C     CATKEY        Chain     CODES
025100060712     C     ACCKEY        klist
025200070215     C                   kfld                    METRST
025300070215     C                   kfld                    MESUB#
025400070215     C                   kfld                    MEACCT
025500060712     C     ACCKEY        Chain     ACCMST
025600060712    ? *
025700000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
025800000000 001?C                   Setoff                                       37        RESET CRSLOC
025900000000E001?C                   Endsl                                                  END SELECT
026000060712    ? *
026100000000    ? *
026200000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
026300000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
026400000000E001?C                   Endif                                                  END IF DATA CHG
026500000000    ?C                   Endsr                                                  END DSPENT
026600000000    ? *___________________________________________________________________
026700000000    ? * Process function key
026800000000    ? *___________________________________________________________________
026900000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
027000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
027100991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
027200000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
027300000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
027400000000    ?C                   Parm                    WAD                            FNC DESC
027500991108    ?C                   Parm                    WWIN                           AID BYTE
027600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
027700000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
027800000000    ?C                   Endsr                                                  END PRCFKY
027900000000    ? *___________________________________________________________________
028000000000    ? * Process KEYS function
028100000000    ? *___________________________________________________________________
028200000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
028300000000    ?C                   Z-add     1             WW                             KEY DSC IDX
028400000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
028500000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
028600000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
028700000000 001? *
028800000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
028900000000 002?C                   Z-add     1             WWFKS                          SET TO 1
029000000000E002?C                   Endif                                                  END IF OVER 3
029100000000 001? *
029200000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
029300000000 001?C                   Sub       1             WW                             KEY DESCR IDX
029400000000E001?C                   Enddo                                                  END DO KEYS
029500000000    ? *
029600010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
029700010913    ?C                   Add       1             WW                             BUMP IDX
029800010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
029900010913    ?C                   Endsr                                                  END PRCDKY
030000000000    ? *___________________________________________________________________
030100000000    ? * Process EXIT Function
030200000000    ? *___________________________________________________________________
030300000000    ?C     PRCEXT        Begsr                                                  RETURN
030400000000    ? *
030500000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
030600000000    ? *
030700000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
030800000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
030900000000X001?C                   Else                                                   ELSE NO ERRORS
031000000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
031100000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
031200000000E001?C                   Endif                                                  END IF ERRORS
031300000000    ?C                   Endsr                                                  END PRCEXT
031400000000    ? *___________________________________________________________________
031500000000    ? * Process PROMPT function
031600000000    ? *___________________________________________________________________
031700000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
031800000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
031900000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
032000000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
032100000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
032200000000    ? *
032300000000B001?C                   Select                                                 SELECT
032400000112 001? *
032500000000 001?C                   Other                                                  WHERE ERROR
032600000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
032700000000 001?C                   Exsr      SNDMSG                                       SEND MSG
032800000000E001?C                   Endsl                                                  END SELECT
032900000000    ? *
033000000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
033100000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
033200000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
033300000000    ?C                   Mvr                     WSLIN                          CURSOR COL
033400000000    ?C                   Seton                                        37        SET ON CRSLOC
033500000000    ? *
033600000000    ?C                   Endsr                                                  END PRCPMT
033700000000    ? *___________________________________________________________________
033800000000    ? * Process CANCEL Function
033900000000    ? *___________________________________________________________________
034000000000    ?C     PRCCNL        Begsr                                                  CANCEL
034100000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
034200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
034300000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
034400000000    ?C                   Endsr                                                  END RETURN
034500000000    ? *___________________________________________________________________
034600000000    ? * Process ROLLUP function
034700000000    ? *___________________________________________________________________
034800000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
034900000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
035000000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
035100000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
035200000000E001?C                   Endif                                                  END IF GT LST PNL
035300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
035400000000    ?C                   Endsr                                                  END PRCRUP
035500000000    ? *___________________________________________________________________
035600000000    ? * Process ROLLDOWN function
035700000000    ? *___________________________________________________________________
035800000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
035900000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
036000000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
036100000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
036200000000E001?C                   Endif                                                  END IF LT FST PNL
036300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
036400000000    ?C                   Endsr                                                  END PRCRDN
036500000000    ? *___________________________________________________________________
036600000000    ? * Process ENTER function
036700000000    ? *___________________________________________________________________
036800000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
036900000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
037000000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
037100000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
037200000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
037300000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
037400070215 001?C                   Call      'CHKMKE  '                                   CHECK DATA
037500000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
037600000000 001?C                   Parm                    WWRTN                          RETURN CODE
037700000614 001?C                   Parm                    WUDTA                          REC DATA
037800000000E001?C                   Endif                                                  ENDIF
037900000000    ? *
038000000000B001?C                   Select                                                 PRC RETURN CDE
038100000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
038200000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
038300000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
038400000000 001? *
038500000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
038600000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
038700000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
038800000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
038900000000X002?C                   Else                                                   ELSE
039000000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
039100000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
039200000000E002?C                   Endif                                                  IF WARNING
039300000000 001? *
039400000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
039500000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
039600000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
039700000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
039800000000E001?C                   Endsl                                                  RETURN CODE SEL
039900000000    ? *
040000000000    ?C                   Endsr                                                  END PRCPNL
040100000000    ? *___________________________________________________________________
040200000000    ? * Process end - write data or release record
040300000000    ? *___________________________________________________________________
040400000000    ?C     PRCEND        Begsr                                                  PROCESS END
040500000000    ? *
040600000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
040700000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
040800000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
040900000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
041000000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
041100000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
041200000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
041300000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
041400000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
041500000000 001?C                   Endcs                                                  END CASE
041600000000 001? *
041700000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
041800000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
041900000000 002? *
042000000000X002?C                   Else                                                   ELSE NO WRT ERR
042100000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
042200000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
042300000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
042400000000 004?C                   Exsr      PRPPNL                                       DO NOT END
042500000810E004?C                   Endif                                                  END IF ADD
042600000000E003?C                   Endif                                                  END IF NOT END
042700000000E002?C                   Endif                                                  END IF WRITE ERROR
042800000000 001? *
042900000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
043000000000 001?C                   Exsr      RELREC                                       RELEASE REC
043100000000E001?C                   Endif                                                  END IF RCD CHANGED
043200000000    ? *
043300000000    ?C                   Endsr                                                  END PRCEND
043400000000    ? *___________________________________________________________________
043500000000    ? * Add new record
043600000000    ? *___________________________________________________________________
043700000000    ?C     WRTADD        Begsr                                                  WRITE ADD
043800000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
043900000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
044000000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
044100000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
044200000000E001?C                   Endif                                                  END IF ADD
044300000000    ? *
044400000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
044500000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
044600000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
044700000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
044800000000E001?C                   Endif                                                  END IF ADD KEY
044900000000    ? *
045000070215    ?C                   Call      'UPDMKE  '                                   PROCESS REC IO
045100000000    ?C                   Parm                    WWRQS                          ADD RECORD
045200000000    ?C                   Parm                    WWRTN                          RETURN CODE
045300000614    ?C                   Parm                    WUDTA                          REC DATA
045400000000    ? *
045500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
045600000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
045700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
045800000000X001?C                   Else                                                   ELSE
045900000000E001?C                   Endif                                                  END IF CALL ERROR
046000000000    ? *
046100000000    ?C                   Endsr                                                  END WRTADD
046200000000    ? *___________________________________________________________________
046300000000    ? * Write changed record
046400000000    ? *___________________________________________________________________
046500000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
046600070215    ?C                   Call      'UPDMKE  '                                   PROCESS REC IO
046700000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
046800000000    ?C                   Parm                    WWRTN                          RETURN CODE
046900000614    ?C                   Parm                    WUDTA                          REC DATA
047000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
047100000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
047200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047300000000E001?C                   Endif                                                  END IF CALL ERROR
047400000000    ? *
047500000000    ?C                   Endsr                                                  END WRTCHG
047600000000    ? *___________________________________________________________________
047700000000    ? * Release record
047800000000    ? *___________________________________________________________________
047900000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
048000070215    ?C                   Call      'UPDMKE  '                                   PROCESS REC IO
048100000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
048200000000    ?C                   Parm                    WWRTN                          RETURN CODE
048300000614    ?C                   Parm                    WUDTA                          REC DATA
048400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
048500000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
048600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
048700000000E001?C                   Endif                                                  END IF CALL ERROR
048800000000    ?C                   Endsr                                                  END RELREC
048900000000    ? *___________________________________________________________________
049000000000    ? * Build function keys
049100000000    ? *___________________________________________________________________
049200000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
049300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
049400991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
049500000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
049600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
049700000000    ?C                   Parm                    WAD                            FNC DESC
049800991108    ?C                   Parm                    WWIN                           AID BYTE
049900000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
050000000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
050100010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
050200010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
050300010913    ?C                   Sub       1             WW                             BUMP IDX
050400010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
050500000000    ?C                   Endsr                                                  END BLD FNCTNS
050600000000    ? *___________________________________________________________________
050700000000    ? * Send message
050800000000    ? *___________________________________________________________________
050900000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
051000000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
051100000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
051200000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
051300000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
051400000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
051500000000    ?C                   Endsr                                                  END SNDMSG
051600000000    ? *___________________________________________________________________
051700000000    ? * Paremater list
051800000000    ? *___________________________________________________________________
051900000000    ?C     PLIST         Begsr                                                  PARM LISTS
052000000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
052100000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
052200000000    ?C                   Parm                    WORTN             8            RETURN CODE
052300000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
052400000614    ?C                   Parm                    WUDTA                          RECORD KEY
052500000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
052600000000    ?C                   Endsr                                                  END PLIST
052700000000    ? *___________________________________________________________________
052800000000    ? * Initialize routine
052900000000    ? *___________________________________________________________________
053000000000    ?C     *INZSR        Begsr                                                  INITIALIZE
053100000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
053200000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
053300000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
053400000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
053500000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
053600000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
053700000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
053800000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
053900000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
054000000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
054100000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
054200000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
054300000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
054400000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
054500000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
054600000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
054700000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
054800000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
054900000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
055000000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
055100000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
055200000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
055300000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
055400000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
055500000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
055600070215    ?C                   Movel     'MKTRNE  '    WWFIL            10            FILE NAME-Excludes
055700070215    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY -
055800070215    ?C                   Move      *BLANKS       WWTXT            60            TEXT -
055900000000    ?C                   Endsr                                                  END INITIALIZE
056000000000    ? *___________________________________________________________________
056100000000    ? * Program error handler
056200000000    ? *___________________________________________________________________
056300000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
056400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
056500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
056600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
056700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
056800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
056900000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
057000000000    ? *___________________________________________________________________
057100000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05720000000003EXIT    F3=Exit
05730000000004PROMPT  F4=Prompt
05740000000005REFRESH F5=Refresh
05750000070710UPDATE  F10=Update
05760000061412CANCEL  F12=Cancel
05770000000025ROLLUP
05780000000026ROLLDOWN
057900000000** WTM
05800007021500Request not supported in program CHGMKE.
05810000000000Update error.  Data was not updated.
05820000000000Duplicate key detected.  Data was NOT added to file.
05830007021500Call to excludes ended in error.
05840000000000Initialize error.  Record not initialized.
05850000000000Record not found.
05860000000000Generate error.  Key not generated.
05870000000000Record not available now.
05880000000000The cursor is not in a prompt area.
05890000000000Default error.  Data not defaulted.
