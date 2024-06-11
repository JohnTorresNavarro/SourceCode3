000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010219    ? *  Description:  Change Internal Sales Commission Agency
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700010219    ?FCHGAGYD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900010219    ?FISCSMN    if   e           k disk
001000010219    ?FAGENCY    if   e           k Disk
001100000000    ? *
001200000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001400000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001500000000    ? *_________________________________________________________________________
001600000406    ? * Data structure
001700010219    ?D WUDTA         E DS                  EXTNAME(ISCAGY)
001800010219    ? *
001900010219    ?D WDAGNY        E DS                  EXTNAME(AGENCY)
002000010219    ?D WDISMN        E DS                  EXTNAME(ISCSMN)
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
007400010220    ?C                   Move      *BLANKS       WSAGNY                         RETURN CODE
007500010220    ?C                   Move      *BLANKS       WSNAME                         RETURN CODE
007600010301    ?C                   Move      *ZEROS        WSEFDT                         RETURN CODE
007700010301    ?C                   Move      *ZEROS        WSTRDT                         RETURN CODE
007800010301    ?C                   Move      *ZEROS        WSDATE                         RETURN CODE
007900991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008000000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008100000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008200000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008300000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008400000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008500000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
008600000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
008700000000    ? *
008800000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
008900000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009000000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009100000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009200000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009300000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009400000000    ? *
009500000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
009600000000    ? *
009700000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
009800000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
009900000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
010000000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
010100000000    ?C                   Cas                     PRCERR                         PROC ERROR
010200000000    ?C                   Endcs                                                  END CASE
010300000000    ? *
010400000000    ?C                   Endsr                                                  END PRPPNL
010500000000    ? *___________________________________________________________________
010600000000    ? * Prepare ADD request
010700000000    ? *___________________________________________________________________
010800000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
010900000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
011000000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
011100000000    ?C                   Endsr                                                  END PRP ADD
011200000000    ? *___________________________________________________________________
011300000000    ? * Prepare CHANGE request
011400000000    ? *___________________________________________________________________
011500000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
011600010219    ?C                   Call      'UPDAGY  '                                   PROCESS REC IO
011700000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
011800000000    ?C                   Parm                    WWRTN                          RETURN CODE
011900000614    ?C                   Parm                    WUDTA                          REC DATA
012000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
012100000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
012200000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
012300000000X002?C                   Else                                                   ELSE
012400000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
012500000000E002?C                   Endif                                                  END RCD NOT AVL
012600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
012700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
012800000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
012900000810E001?C                   Else                                                   END IF ERROR
013000010219    ?C     IAAGNY        Chain     AGENCY
013100010219B003?C                   If        %found
013200010219     C                   MOVEL     AGNAM1        WSAGNY
013300010219E003?C                   Else
013400010219     C                   Clear                   WSAGNY
013500010219E003?C                   End
013600010219    ?C     IASMAN        Chain     ISCSMN
013700010219B003?C                   If        %found
013800010219 003?C                   Eval      WSNAME   =    %trim(ISFNAM) +
013900010219 003?C                                           ' ' + ISLNAM
014000010219E003?C                   Else
014100010219     C                   Clear                   WSNAME
014200010219E003?C                   End
014300010301     C     IAEFDT        MULT      10000.0001    WSEFDT
014400010301     C     IATRDT        MULT      10000.0001    WSTRDT
014500010301     C     IACHGD        MULT      10000.0001    WSDATE
014600000810E001?C                   Endif                                                  END IF ERROR
014700000000    ?C                   Endsr                                                  END PRP CHANGE
014800000000    ? *___________________________________________________________________
014900000000    ? * Prepare COPY request
015000000000    ? *___________________________________________________________________
015100000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
015200000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
015300010219    ?C                   Call      'UPDAGY  '                                   PROCESS REC IO
015400000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
015500000000    ?C                   Parm                    WWRTN                          RETURN CODE
015600000614    ?C                   Parm                    WUDTA                          REC DATA
015700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015800000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
015900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016000000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016100000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016200000000X001?C                   Else                                                   ELSE
016300000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
016400020220 001?C                   Clear                   IASMAN                         CLEAR KEY
016500020220     C                   Clear                   WSNAME
016600020220    ?C     IAAGNY        Chain     AGENCY
016700020220B003?C                   If        %found
016800020220     C                   MOVEL     AGNAM1        WSAGNY
016900020220E003?C                   Else
017000020220     C                   Clear                   WSAGNY
017100020220E003?C                   End
017200020220     C     IAEFDT        MULT      10000.0001    WSEFDT
017300020220     C     IATRDT        MULT      10000.0001    WSTRDT
017400020220     C     IACHGD        MULT      10000.0001    WSDATE
017500000000E001?C                   Endif                                                  END IF ERROR
017600000000    ?C                   Endsr                                                  END PREP COPY
017700000000    ? *___________________________________________________________________
017800000000    ? * Default Data
017900000000    ? *___________________________________________________________________
018000000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
018100010219    ?C                   Call      'CHKAGY  '                                   PROCESS REC IO
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
023400000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
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
032800000000B001?C                   Select                                                 SELECT
032900010219 001 C                   When      WSFLD = 'IAAGNY'
033000010219 001?C                   Call      'SLCAGNY '                                   CALL SELECT PROGRAM
033100010219 001?C                   Parm                    WWRQS                          REQUEST
033200010219 001?C                   Parm                    WWRTN                          RETURN CODE
033300010219 001?C                   Parm                    WUPGM                          PROGRAM
033400010219 001?C                   Parm                    WDAGNY                         RECORD DS
033500010219B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
033600010219 003?C                   Movel     AGCODE        IAAGNY                         SET CODE
033700010219E001?C                   Endif
033800010220    ? *
033900010219 001 C                   When      WSFLD = 'IASMAN'
034000010219 001?C                   Call      'SLCSMN  '                                   CALL SELECT PROGRAM
034100010219 001?C                   Parm                    WWRQS                          REQUEST
034200010219 001?C                   Parm                    WWRTN                          RETURN CODE
034300010219 001?C                   Parm                    WUPGM                          PROGRAM
034400010219 001?C                   Parm                    WDISMN                         RECORD DS
034500010219B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
034600010219 003?C                   Movel     ISSMAN        IASMAN                         SET CODE
034700010219E001?C                   Endif
034800000112 001? *
034900000000 001?C                   Other                                                  WHERE ERROR
035000000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
035100000000 001?C                   Exsr      SNDMSG                                       SEND MSG
035200000000E001?C                   Endsl                                                  END SELECT
035300000000    ? *
035400000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
035500000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
035600000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
035700000000    ?C                   Mvr                     WSLIN                          CURSOR COL
035800000000    ?C                   Seton                                        37        SET ON CRSLOC
035900000000    ? *
036000000000    ?C                   Endsr                                                  END PRCPMT
036100000000    ? *___________________________________________________________________
036200000000    ? * Process CANCEL Function
036300000000    ? *___________________________________________________________________
036400000000    ?C     PRCCNL        Begsr                                                  CANCEL
036500000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
036600000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
036700000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
036800000000    ?C                   Endsr                                                  END RETURN
036900000000    ? *___________________________________________________________________
037000000000    ? * Process ROLLUP function
037100000000    ? *___________________________________________________________________
037200000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
037300000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
037400000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
037500000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
037600000000E001?C                   Endif                                                  END IF GT LST PNL
037700000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
037800000000    ?C                   Endsr                                                  END PRCRUP
037900000000    ? *___________________________________________________________________
038000000000    ? * Process ROLLDOWN function
038100000000    ? *___________________________________________________________________
038200000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
038300000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
038400000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
038500000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
038600000000E001?C                   Endif                                                  END IF LT FST PNL
038700000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
038800000000    ?C                   Endsr                                                  END PRCRDN
038900000000    ? *___________________________________________________________________
039000000000    ? * Process ENTER function
039100000000    ? *___________________________________________________________________
039200000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
039300000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
039400000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
039500000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
039600000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
039700000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
039800010301     C                   Z-add     WSEFDT        IAEFDT
039900010301     C                   Z-add     WSTRDT        IATRDT
040000010219 001?C                   Call      'CHKAGY  '                                   CHECK DATA
040100000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
040200000000 001?C                   Parm                    WWRTN                          RETURN CODE
040300000614 001?C                   Parm                    WUDTA                          REC DATA
040400000000E001?C                   Endif                                                  ENDIF
040500000000    ? *
040600000000B001?C                   Select                                                 PRC RETURN CDE
040700000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
040800000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
040900000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
041000000000 001? *
041100000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
041200000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
041300000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
041400000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
041500000000X002?C                   Else                                                   ELSE
041600000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
041700000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
041800000000E002?C                   Endif                                                  IF WARNING
041900000000 001? *
042000000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
042100000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
042200000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
042300000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
042400000000E001?C                   Endsl                                                  RETURN CODE SEL
042500000000    ? *
042600000000    ?C                   Endsr                                                  END PRCPNL
042700000000    ? *___________________________________________________________________
042800000000    ? * Process end - write data or release record
042900000000    ? *___________________________________________________________________
043000000000    ?C     PRCEND        Begsr                                                  PROCESS END
043100000000    ? *
043200000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
043300000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
043400000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
043500000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
043600000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
043700000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
043800000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
043900000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
044000000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
044100000000 001?C                   Endcs                                                  END CASE
044200000000 001? *
044300000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
044400000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
044500000000 002? *
044600000000X002?C                   Else                                                   ELSE NO WRT ERR
044700000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
044800000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
044900000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
045000000000 004?C                   Exsr      PRPPNL                                       DO NOT END
045100000810E004?C                   Endif                                                  END IF ADD
045200000000E003?C                   Endif                                                  END IF NOT END
045300000000E002?C                   Endif                                                  END IF WRITE ERROR
045400000000 001? *
045500000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
045600000000 001?C                   Exsr      RELREC                                       RELEASE REC
045700000000E001?C                   Endif                                                  END IF RCD CHANGED
045800000000    ? *
045900000000    ?C                   Endsr                                                  END PRCEND
046000000000    ? *___________________________________________________________________
046100000000    ? * Add new record
046200000000    ? *___________________________________________________________________
046300000000    ?C     WRTADD        Begsr                                                  WRITE ADD
046400000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
046500000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
046600000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
046700000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
046800000000E001?C                   Endif                                                  END IF ADD
046900000000    ? *
047000000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
047100000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
047200000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
047300000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
047400000000E001?C                   Endif                                                  END IF ADD KEY
047500000000    ? *
047600010219    ?C                   Call      'UPDAGY  '                                   PROCESS REC IO
047700000000    ?C                   Parm                    WWRQS                          ADD RECORD
047800000000    ?C                   Parm                    WWRTN                          RETURN CODE
047900000614    ?C                   Parm                    WUDTA                          REC DATA
048000000000    ? *
048100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
048200000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
048300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
048400000000X001?C                   Else                                                   ELSE
048500000000E001?C                   Endif                                                  END IF CALL ERROR
048600000000    ? *
048700000000    ?C                   Endsr                                                  END WRTADD
048800000000    ? *___________________________________________________________________
048900000000    ? * Write changed record
049000000000    ? *___________________________________________________________________
049100000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
049200010219    ?C                   Call      'UPDAGY  '                                   PROCESS REC IO
049300000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
049400000000    ?C                   Parm                    WWRTN                          RETURN CODE
049500000614    ?C                   Parm                    WUDTA                          REC DATA
049600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
049700000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
049800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
049900000000E001?C                   Endif                                                  END IF CALL ERROR
050000000000    ? *
050100000000    ?C                   Endsr                                                  END WRTCHG
050200000000    ? *___________________________________________________________________
050300000000    ? * Release record
050400000000    ? *___________________________________________________________________
050500000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
050600010219    ?C                   Call      'UPDAGY  '                                   PROCESS REC IO
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
052700000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
052800000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
052900000000    ?C                   Sub       1             WW                             BUMP IDX
053000000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
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
058200010219    ?C                   Movel     'ISCAGY  '    WWFIL            10            FILE NAME-NOTES
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
06000000000005REFRESH F5=Refresh
06010000070710UPDATE  F10=Update
06020000061412CANCEL  F12=Cancel
06030000000025ROLLUP
06040000000026ROLLDOWN
060500000000** WTM
06060001021900Request not supported in program CHGAGY.
06070000000000Update error.  Data was not updated.
06080000000000Duplicate key detected.  Data was NOT added to file.
06090000000000Call to notes ended in error.
06100000000000Initialize error.  Record not initialized.
06110000000000Record not found.
06120000000000Generate error.  Key not generated.
06130000000000Record not available now.
06140000000000The cursor is not in a prompt area.
06150000000000Default error.  Data not defaulted.
