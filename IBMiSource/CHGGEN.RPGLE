000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300030717    ? *  Description:  Change E&O Coverage file
000400000000    ? *
000500030716    ? *  (c)Copyright 2003 by Group Benefit Services, Inc.
000600000000    ? *_________________________________________________________________________
000700180319    ?FCHGGEND   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900030717    ?FSMAN      IF   E           K DISK
001000030717    ?FSMANRLT   IF   E           K DISK
001100030717    ?FAGENCY    IF   E           K DISK
001200030717    ?FSPRAGXR2  IF   E           K DISK
001300030717    ?FSUPRAGCY  IF   E           K DISK
001400031117    ?FBLILMANL2 IF   E           K DISK
001500000000    ? *
001600000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001700000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001800000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001900000000    ? *_________________________________________________________________________
002000000406    ? * Data structure
002100180319    ?D WUDTA         E DS                  EXTNAME(BLIGEN)
002200030716    ?D WDSMN         E DS                  EXTNAME(SMANRLT)
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
003400000000    ? *_________________________________________________________________________
003500000000    ? *
003600000614    ? * Process Entry Panel
003700000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
003800000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
003900000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
004000000000E001?C                   Endif                                                  END COPY/CPYKEY
004100000000    ? *
004200000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004300000000    ? *
004400000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004500000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004600000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
004700000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004800000000 001? *
004900000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
005000000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
005100000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005200000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
005300000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005400000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
005500000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005600000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
005700000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
005800000000 001?C                   Endcs                                                  END CASE
005900000000 001? *
006000000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
006100000000 002?C                   Exsr      PRCEND                                       PROCESS END
006200000000E002?C                   Endif                                                  END IF END REQ
006300000000E001?C                   Enddo                                                  END DOWHILE
006400000000    ? *
006500000707    ? * Send Info Updated message.
006600000707     C     WwChg         Ifeq      'Y'
006700000707     C                   Movel     'UPDATE  '    WORTN
006800000707     C                   Endif
006900000707    ? *
007000000000    ?C                   Return                                                 RETURN
007100000000    ? *___________________________________________________________________
007200000000    ? * Prepare panel
007300000000    ? *___________________________________________________________________
007400000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007500031117     C                   If        WORTN    =    'NON'
007600031117     C                   Move      'Y'           Noncom            1
007700031117     C                   Eval      WTITLE = 'Non Commission'
007800031117     C                   Else
007900031117     C                   Move      ' '           Noncom
008000031117     C                   Eval      WTITLE = '  Commission  '
008100031117     C                   End
008200000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
008300010223    ?C                   Move      *ZEROS        WSDATE                         RETURN CODE
008400010223    ?C                   Move      *ZEROS        WSEFDT                         RETURN CODE
008500010223    ?C                   Move      *ZEROS        WSTRDT                         RETURN CODE
008600991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008700000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008800000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008900000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
009000000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
009100000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
009200000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
009300000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
009400000000    ? *
009500000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
009600000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009700000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009800000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009900000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
010000000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
010100000000    ? *
010200000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
010300000000    ? *
010400000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
010500000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
010600000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
010700000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
010800000000    ?C                   Cas                     PRCERR                         PROC ERROR
010900000000    ?C                   Endcs                                                  END CASE
011000000000    ? *
011100000000    ?C                   Endsr                                                  END PRPPNL
011200000000    ? *___________________________________________________________________
011300000000    ? * Prepare ADD request
011400000000    ? *___________________________________________________________________
011500000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
011600000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
011700030716     C                   CLEAR                   SRSMAN
011800030716     C                   CLEAR                   SXSUPER
011900030716     C                   CLEAR                   SXAGCY
012000031211     C                   CLEAR                   WSSMAN
012100030717     C                   CLEAR                   WSNAM1
012200031211     C                   CLEAR                   WSAGCY
012300030717     C                   CLEAR                   WSNAM2
012400031211     C                   CLEAR                   WSSUPR
012500030717     C                   CLEAR                   WSNAM3
012600000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
012700000000    ?C                   Endsr                                                  END PRP ADD
012800000000    ? *___________________________________________________________________
012900000000    ? * Prepare CHANGE request
013000000000    ? *___________________________________________________________________
013100000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
013200180319    ?C                   Call      'UPDGEN  '                                   PROCESS REC IO
013300000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
013400000000    ?C                   Parm                    WWRTN                          RETURN CODE
013500000614    ?C                   Parm                    WUDTA                          REC DATA
013600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
013700000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
013800000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
013900000000X002?C                   Else                                                   ELSE
014000000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014100000000E002?C                   Endif                                                  END RCD NOT AVL
014200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
014500000810E001?C                   Else                                                   END IF ERROR
014600030717     C     LECHGD        MULT      10000.0001    WSDATE
014700030722     C     LEEFFD        MULT      10000.0001    WSEFDT
014800030722     C     LEEXPD        MULT      10000.0001    WSTRDT
014900030716     C                   EXSR      GETSMAN
015000000810E001?C                   Endif                                                  END IF ERROR
015100000000    ?C                   Endsr                                                  END PRP CHANGE
015200000000    ? *___________________________________________________________________
015300000000    ? * Prepare COPY request
015400000000    ? *___________________________________________________________________
015500000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
015600000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
015700180319    ?C                   Call      'UPDGEN  '                                   PROCESS REC IO
015800000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
015900000000    ?C                   Parm                    WWRTN                          RETURN CODE
016000000614    ?C                   Parm                    WUDTA                          REC DATA
016100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016200000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
016300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016400000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016500000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016600000000X001?C                   Else                                                   ELSE
016700000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
016800030717 001?C                   Clear                   LERELI                         CLEAR KEY
016900000000E001?C                   Endif                                                  END IF ERROR
017000000000    ?C                   Endsr                                                  END PREP COPY
017100000000    ? *___________________________________________________________________
017200000000    ? * Default Data
017300000000    ? *___________________________________________________________________
017400000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
017500180319    ?C                   Call      'CHKGEN  '                                   PROCESS REC IO
017600000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
017700000000    ?C                   Parm                    WWRTN                          RETURN CODE
017800000614    ?C                   Parm                    WUDTA                          REC DATA
017900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
018000000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
018100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
018400000000E001?C                   Endif                                                  END IF ERROR
018500000000    ?C                   Endsr                                                  END DFTDTA
018600000000    ? *___________________________________________________________________
018700000000    ? * Process ERROR function
018800000000    ? *___________________________________________________________________
018900000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
019000000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
019100000000    ?C                   Exsr      SNDMSG                                       SEND MSG
019200000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019300000000    ?C                   Move      'END'         WWSTT                          END STATE
019400000000    ?C                   Endsr                                                  END PRCERR
019500000000    ? *___________________________________________________________________
019600000000    ? * Receive messages
019700000000    ? *___________________________________________________________________
019800000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
019900000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
020000000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
020100000000X001?C                   Else                                                   ELSE
020200000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
020300000000E001?C                   Endif                                                  ENDIF NOT NORESET
020400000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
020500000000    ?C                   Movea     *IN           WWIN                           INDICATORS
020600000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
020700000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
020800000000    ?C                   Parm                    WWIN                           INDICATORS
020900000000    ?C                   Parm                    WWRTN                          RETURN CODE
021000000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
021100000000    ?C                   Endsr                                                  END RCV MSG
021200000000    ? *___________________________________________________________________
021300000000    ? * Display panels
021400000000    ? *___________________________________________________________________
021500000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
021600000000    ? *
021700000000    ? * Set PUTOVR based on last display file processed
021800000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
021900000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
022000000000 001?C                   Setoff                                       35        PUTOVR OFF
022100000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
022200000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
022300000000X001?C                   Else                                                   ELSE SAME PGM
022400000000 001?C                   Seton                                        35        PUTOVR ON
022500000000E001?C                   Endif                                                  END IF NEW PGM
022600000000    ? *
022700000614    ? * Set PROTECT key based on request
022800000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
022900000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
023000000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
023100000000 001?C                   Setoff                                       40        NO PROTECT KEY
023200000000X001?C                   Else                                                   ELSE
023300000000 001?C                   Seton                                        40        PROTECT KEY
023400000000E001?C                   Endif                                                  END IF ADD
023500030722    ? *
023600030722    ? * Set PROTECT key based on Relationship id
023700030722 001?C     LERELI        Ifne      *Blanks                                      OR COPY
023800030722 001?C                   Seton                                        40        PROTECT KEY
023900030722E001?C                   Endif                                                  END IF ADD
024000000000    ? *
024100000000    ? * Select title
024200000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
024300000000 001?C                   Setoff                                       38        CHANGE TITLE
024400000000X001?C                   Else                                                   ELSE
024500000000 001?C                   Seton                                        38        ADD TITLE
024600000000E001?C                   Endif                                                  END IF CHANGE
024700000000    ? *
024800000000    ? * Position cursor based on error status
024900000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
025000000000 001?C                   Seton                                        99        POS CSR TO ERROR
025100000000X001?C                   Else                                                   ELSE
025200000000 001?C                   Setoff                                       99        POS CSR TO FIRST
025300000000E001?C                   Endif                                                  END IF ERROR
025400000000    ? *
025500000000    ? * Write message subfile
025600000000    ?C                   Seton                                        30        MSGSFL DISPLAY
025700000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
025800000000    ? *
025900000000    ? * Write entry panel
026000000000B001?C                   Select
026100000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
026200000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
026300000000 001?C                   Setoff                                       37        RESET CRSLOC
026400000000E001?C                   Endsl                                                  END SELECT
026500000000    ? *
026600000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
026700000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
026800000000E001?C                   Endif                                                  END IF DATA CHG
026900000000    ?C                   Endsr                                                  END DSPENT
027000000000    ? *___________________________________________________________________
027100000000    ? * Process function key
027200000000    ? *___________________________________________________________________
027300000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
027400991108    ?C                   Movea     *IN           WWIN                           INDICATORS
027500991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
027600000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
027700000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
027800000000    ?C                   Parm                    WAD                            FNC DESC
027900991108    ?C                   Parm                    WWIN                           AID BYTE
028000000000    ?C                   Parm                    WAF                            FNC KEY TABLE
028100000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
028200000000    ?C                   Endsr                                                  END PRCFKY
028300000000    ? *___________________________________________________________________
028400000000    ? * Process KEYS function
028500000000    ? *___________________________________________________________________
028600000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
028700000000    ?C                   Z-add     1             WW                             KEY DSC IDX
028800000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
028900000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
029000000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
029100000000 001? *
029200000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
029300000000 002?C                   Z-add     1             WWFKS                          SET TO 1
029400000000E002?C                   Endif                                                  END IF OVER 3
029500000000 001? *
029600000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
029700000000 001?C                   Sub       1             WW                             KEY DESCR IDX
029800000000E001?C                   Enddo                                                  END DO KEYS
029900000000    ? *
030000000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
030100000000    ?C                   Add       1             WW                             BUMP IDX
030200000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
030300000000    ?C                   Endsr                                                  END PRCDKY
030400000000    ? *___________________________________________________________________
030500000000    ? * Process EXIT Function
030600000000    ? *___________________________________________________________________
030700000000    ?C     PRCEXT        Begsr                                                  RETURN
030800000000    ? *
030900000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
031000000000    ? *
031100000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
031200000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
031300000000X001?C                   Else                                                   ELSE NO ERRORS
031400000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
031500000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
031600000000E001?C                   Endif                                                  END IF ERRORS
031700000000    ?C                   Endsr                                                  END PRCEXT
031800000000    ? *___________________________________________________________________
031900000000    ? * Process PROMPT function
032000000000    ? *___________________________________________________________________
032100000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
032200000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
032300000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
032400000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
032500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
032600000000    ? *
032700000000B001?C                   Select                                                 SELECT
032800030717 001 C                   When      WSFLD = 'LERELI'
032900030716 001?C                   Call      'FM484CL '                                   CALL SELECT PROGRAM
033000030716 001?C                   Parm                    WDSMN                          RECORD DS
033100030716B002?C                   If        %TRIM(WDSMN) <> '*LR'                        ENTER
033200030717 003?C                   Movel     SRRELID       LERELI                         SET CODE
033300030716     C                   EXSR      GETSMAN
033400030716E001?C                   Endif
033500000112 001? *
033600000000 001?C                   Other                                                  WHERE ERROR
033700000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
033800000000 001?C                   Exsr      SNDMSG                                       SEND MSG
033900000000E001?C                   Endsl                                                  END SELECT
034000000000    ? *
034100000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
034200000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
034300000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
034400000000    ?C                   Mvr                     WSLIN                          CURSOR COL
034500000000    ?C                   Seton                                        37        SET ON CRSLOC
034600000000    ? *
034700000000    ?C                   Endsr                                                  END PRCPMT
034800000000    ? *___________________________________________________________________
034900000000    ? * Process CANCEL Function
035000000000    ? *___________________________________________________________________
035100000000    ?C     PRCCNL        Begsr                                                  CANCEL
035200000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
035300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
035400000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
035500000000    ?C                   Endsr                                                  END RETURN
035600000000    ? *___________________________________________________________________
035700000000    ? * Process ROLLUP function
035800000000    ? *___________________________________________________________________
035900000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
036000000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
036100000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
036200000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
036300000000E001?C                   Endif                                                  END IF GT LST PNL
036400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
036500000000    ?C                   Endsr                                                  END PRCRUP
036600000000    ? *___________________________________________________________________
036700000000    ? * Process ROLLDOWN function
036800000000    ? *___________________________________________________________________
036900000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
037000000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
037100000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
037200000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
037300000000E001?C                   Endif                                                  END IF LT FST PNL
037400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
037500000000    ?C                   Endsr                                                  END PRCRDN
037600000000    ? *___________________________________________________________________
037700000000    ? * Process ENTER function
037800000000    ? *___________________________________________________________________
037900000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
038000000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
038100000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
038200000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
038300000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
038400000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
038500030722     C                   Z-add     WSEFDT        LEEFFD
038600030722     C                   Z-add     WSTRDT        LEEXPD
038700180319 001?C                   Call      'CHKGEN  '                                   CHECK DATA
038800000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
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
046300180319    ?C                   Call      'UPDGEN  '                                   PROCESS REC IO
046400000000    ?C                   Parm                    WWRQS                          ADD RECORD
046500000000    ?C                   Parm                    WWRTN                          RETURN CODE
046600000614    ?C                   Parm                    WUDTA                          REC DATA
046700000000    ? *
046800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
046900000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
047000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047100000000X001?C                   Else                                                   ELSE
047200000000E001?C                   Endif                                                  END IF CALL ERROR
047300000000    ? *
047400000000    ?C                   Endsr                                                  END WRTADD
047500000000    ? *___________________________________________________________________
047600000000    ? * Write changed record
047700000000    ? *___________________________________________________________________
047800000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
047900180319    ?C                   Call      'UPDGEN  '                                   PROCESS REC IO
048000000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
048100000000    ?C                   Parm                    WWRTN                          RETURN CODE
048200000614    ?C                   Parm                    WUDTA                          REC DATA
048300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
048400000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
048500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
048600000000E001?C                   Endif                                                  END IF CALL ERROR
048700000000    ? *
048800000000    ?C                   Endsr                                                  END WRTCHG
048900000000    ? *___________________________________________________________________
049000000000    ? * Release record
049100000000    ? *___________________________________________________________________
049200000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
049300180319    ?C                   Call      'UPDGEN  '                                   PROCESS REC IO
049400000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
049500000000    ?C                   Parm                    WWRTN                          RETURN CODE
049600000614    ?C                   Parm                    WUDTA                          REC DATA
049700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
049800000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
049900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
050000000000E001?C                   Endif                                                  END IF CALL ERROR
050100000000    ?C                   Endsr                                                  END RELREC
050200000000    ? *___________________________________________________________________
050300000000    ? * Build function keys
050400000000    ? *___________________________________________________________________
050500000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
050600991108    ?C                   Movea     *IN           WWIN                           INDICATORS
050700991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
050800000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
050900000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
051000000000    ?C                   Parm                    WAD                            FNC DESC
051100991108    ?C                   Parm                    WWIN                           AID BYTE
051200000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
051300000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
051400000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
051500000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
051600000000    ?C                   Sub       1             WW                             BUMP IDX
051700000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
051800000000    ?C                   Endsr                                                  END BLD FNCTNS
051900000000    ? *___________________________________________________________________
052000000000    ? * Send message
052100000000    ? *___________________________________________________________________
052200000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
052300000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
052400000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
052500000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
052600000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
052700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
052800000000    ?C                   Endsr                                                  END SNDMSG
052900000000    ? *___________________________________________________________________
053000000000    ? * Paremater list
053100000000    ? *___________________________________________________________________
053200000000    ?C     PLIST         Begsr                                                  PARM LISTS
053300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
053400000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
053500000000    ?C                   Parm                    WORTN             8            RETURN CODE
053600000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
053700000614    ?C                   Parm                    WUDTA                          RECORD KEY
053800000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
053900000000    ?C                   Endsr                                                  END PLIST
054000030716    ? *___________________________________________________________________
054100030716    ? * GET SALESMAN
054200030716    ? *___________________________________________________________________
054300030716    ?C     GETSMAN       Begsr                                                  PARM LISTS
054400031117     C                   If        NonCom = 'Y'
054500031117     C     LERELI        CHAIN     BLILMANL2
054600031117     C                   IF        %FOUND
054700031117     C                   Eval      wssman = lmanc
054800031117     C                   Eval      wsnam1 = %trim(lmann)
054900031117     C                   Eval      wsagcy = lagcy
055000031117     C                   Eval      wsnam2 = %trim(lagcn)
055100031117     C                   Eval      wssupr = lsupr
055200031117     C                   Eval      wsnam3 = %trim(lsupn)
055300031117     C                   End
055400031117     C                   Else
055500030717     C     LERELI        CHAIN     SMANRLT
055600030717     C                   IF        NOT %FOUND
055700031117     C                   CLEAR                   WSSMAN
055800030717     C                   ELSE
055900031117     C                   EVAL      WSSMAN   =    SRSMAN
056000030717     C     SRSMAN        CHAIN     SMAN
056100030717     C                   IF        NOT %FOUND
056200030717     C                   CLEAR                   WSNAM1
056300030717     C                   ELSE
056400030717     C                   EVAL      WSNAM1 = %trim(SFNAME) + ' ' + %trim(SLNAME)
056500030717     C                   END
056600030717     C                   END
056700030717     C     SRASID        CHAIN     SPRAGXR2
056800030717     C                   IF        NOT %FOUND
056900031117     C                   CLEAR                   WSSUPR
057000031117     C                   CLEAR                   WSAGCY
057100030717     C                   CLEAR                   WSNAM3
057200030717     C                   ELSE
057300031117     C                   EVAL      WSSUPR =      SXSUPER
057400031117     C                   EVAL      WSAGCY =      SXAGCY
057500030717     C     SXAGCY        CHAIN     AGENCY
057600030717     C                   IF        NOT %FOUND
057700030717     C                   CLEAR                   WSNAM2
057800030717     C                   ELSE
057900030717     C                   EVAL      WSNAM2 = %trim(AGNAM1)
058000030717     C                   END
058100030717     C     SXSUPER       CHAIN     SUPRAGCY
058200030717     C                   IF        NOT %FOUND
058300030717     C                   CLEAR                   WSNAM3
058400030717     C                   ELSE
058500030717     C                   EVAL      WSNAM3 = %trim(SANAME1)
058600030717     C                   END
058700031117     C                   END
058800030717     C                   END
058900030716    ?C                   Endsr                                                  END PLIST
059000000000    ? *___________________________________________________________________
059100000000    ? * Initialize routine
059200000000    ? *___________________________________________________________________
059300000000    ?C     *INZSR        Begsr                                                  INITIALIZE
059400000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
059500000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
059600000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
059700000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
059800000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
059900000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
060000000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
060100000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
060200000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
060300000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
060400000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
060500000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
060600000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
060700000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
060800000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
060900000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
061000000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
061100000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
061200000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
061300000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
061400000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
061500000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
061600000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
061700000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
061800000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
061900180319    ?C                   Movel     'BLIGEN  '    WWFIL            10            FILE NAME-NOTES
062000000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
062100000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
062200000000    ?C                   Endsr                                                  END INITIALIZE
062300000000    ? *___________________________________________________________________
062400000000    ? * Program error handler
062500000000    ? *___________________________________________________________________
062600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
062700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
062800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
062900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
063000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
063100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
063200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
063300000000    ? *___________________________________________________________________
063400000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06350000000003EXIT    F3=Exit
06360000000004PROMPT  F4=Prompt
06370000000005REFRESH F5=Refresh
06380000070710UPDATE  F10=Update
06390000061412CANCEL  F12=Cancel
06400000000025ROLLUP
06410000000026ROLLDOWN
064200000000** WTM
06430018031900Request not supported in program CHGGEN.
06440000000000Update error.  Data was not updated.
06450000000000Duplicate key detected.  Data was NOT added to file.
06460000000000Call to notes ended in error.
06470000000000Initialize error.  Record not initialized.
06480000000000Record not found.
06490000000000Generate error.  Key not generated.
06500000000000Record not available now.
06510000000000The cursor is not in a prompt area.
06520000000000Default error.  Data not defaulted.
