000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300030717    ? *  Description:  Change Carrier Appointment
000400000000    ? *
000500030716    ? *  (c)Copyright 2003 by Group Benefit Services, Inc.
000600000000    ? *_________________________________________________________________________
000700030717    ?FCHGCOND   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900040603    ?FHYPERCARR IF   E           K DISK
001000030717    ?FSMAN      IF   E           K DISK
001100030717    ?FSMANRLT   IF   E           K DISK
001200030717    ?FAGENCY    IF   E           K DISK
001300030717    ?FSPRAGXR2  IF   E           K DISK
001301031117    ?FSUPRAGCY  IF   E           K DISK
001400031117    ?FBLILMANL2 IF   E           K DISK
001500000000    ? *
001600000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001700000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001800000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001900000000    ? *_________________________________________________________________________
002000000406    ? * Data structure
002100030717    ?D WUDTA         E DS                  EXTNAME(BLICON)
002200030716    ?D WDSMN         E DS                  EXTNAME(SMANRLT)
002300040603    ?D WDCAR         E DS                  EXTNAME(HYPERCARR)
002400000000    ? *
002500000000    ? * Program status data structure
002600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002700000000    ? *
002800000000    ? * Display file data structure
002900991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003000000000    ? *
003100000000    ? * CURSOR LOCATION
003200000000    ?D                 DS
003300000000    ?D  WWCRSL                 1      2
003400000000    ?D  WWCRSN                 1      2B 0
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
006701040603 003?C                   Eval      LCCARR = %trim(WGCARR)                       SET CODE
006800000707     C                   Movel     'UPDATE  '    WORTN
006900000707     C                   Endif
007000000707    ? *
007100000000    ?C                   Return                                                 RETURN
007200000000    ? *___________________________________________________________________
007300000000    ? * Prepare panel
007400000000    ? *___________________________________________________________________
007500000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007501031117     C                   If        WORTN    =    'NON'
007502031117     C                   Move      'Y'           Noncom            1
007503031117     C                   Eval      WTITLE = 'Non Commission'
007504031117     C                   Else
007505031117     C                   Move      ' '           Noncom
007506031117     C                   Eval      WTITLE = '  Commission  '
007507031117     C                   End
007600000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007700010223    ?C                   Move      *ZEROS        WSDATE                         RETURN CODE
007800010223    ?C                   Move      *ZEROS        WSEFDT                         RETURN CODE
007900030722    ?C                   Move      *ZEROS        WSTRDT                         RETURN CODE
008000030722    ?C                   Move      *ZEROS        WSAOCR                         RETURN CODE
008100991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008200000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008300000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008400000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008500000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008600000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008700000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
008800000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
008900000000    ? *
009000000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
009100000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009200000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009300000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009400000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009500000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009600000000    ? *
009700000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
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
011200030716     C                   CLEAR                   SRSMAN
011300030716     C                   CLEAR                   SXSUPER
011400030716     C                   CLEAR                   SXAGCY
011401031211     C                   CLEAR                   WSSMAN
011500030717     C                   CLEAR                   WSNAM1
011501031211     C                   CLEAR                   WSAGCY
011600030717     C                   CLEAR                   WSNAM2
011601031211     C                   CLEAR                   WSSUPR
011700030717     C                   CLEAR                   WSNAM3
011701040603     C                   CLEAR                   WDCARR
011800040603     C                   CLEAR                   WGCARR
011900000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
012000000000    ?C                   Endsr                                                  END PRP ADD
012100000000    ? *___________________________________________________________________
012200000000    ? * Prepare CHANGE request
012300000000    ? *___________________________________________________________________
012400000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
012500030717    ?C                   Call      'UPDCON  '                                   PROCESS REC IO
012600000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
012700000000    ?C                   Parm                    WWRTN                          RETURN CODE
012800000614    ?C                   Parm                    WUDTA                          REC DATA
012900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
013000000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
013100000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
013200000000X002?C                   Else                                                   ELSE
013300000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
013400000000E002?C                   Endif                                                  END RCD NOT AVL
013500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
013600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
013800000810E001?C                   Else                                                   END IF ERROR
013900030717     C     LCCHGD        MULT      10000.0001    WSDATE
014000030722     C     LCEFFD        MULT      10000.0001    WSEFDT
014100030722     C     LCEXPD        MULT      10000.0001    WSTRDT
014200030722     C     LCAOCR        MULT      10000.0001    WSAOCR
014300030716     C                   EXSR      GETSMAN
014400000810E001?C                   Endif                                                  END IF ERROR
014500000000    ?C                   Endsr                                                  END PRP CHANGE
014600000000    ? *___________________________________________________________________
014700000000    ? * Prepare COPY request
014800000000    ? *___________________________________________________________________
014900000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
015000000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
015100030717    ?C                   Call      'UPDCON  '                                   PROCESS REC IO
015200000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
015300000000    ?C                   Parm                    WWRTN                          RETURN CODE
015400000614    ?C                   Parm                    WUDTA                          REC DATA
015500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015600000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
015700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
015800000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015900000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016000000000X001?C                   Else                                                   ELSE
016100000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
016200030717 001?C                   Clear                   LCRELI                         CLEAR KEY
016300000000E001?C                   Endif                                                  END IF ERROR
016400000000    ?C                   Endsr                                                  END PREP COPY
016500000000    ? *___________________________________________________________________
016600000000    ? * Default Data
016700000000    ? *___________________________________________________________________
016800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
016900030717    ?C                   Call      'CHKCON  '                                   PROCESS REC IO
017000000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
017100000000    ?C                   Parm                    WWRTN                          RETURN CODE
017200000614    ?C                   Parm                    WUDTA                          REC DATA
017300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
017400000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
017500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
017600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
017800000000E001?C                   Endif                                                  END IF ERROR
017900000000    ?C                   Endsr                                                  END DFTDTA
018000000000    ? *___________________________________________________________________
018100000000    ? * Process ERROR function
018200000000    ? *___________________________________________________________________
018300000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
018400000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
018500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
018600000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018700000000    ?C                   Move      'END'         WWSTT                          END STATE
018800000000    ?C                   Endsr                                                  END PRCERR
018900000000    ? *___________________________________________________________________
019000000000    ? * Receive messages
019100000000    ? *___________________________________________________________________
019200000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
019300000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
019400000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
019500000000X001?C                   Else                                                   ELSE
019600000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
019700000000E001?C                   Endif                                                  ENDIF NOT NORESET
019800000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
019900000000    ?C                   Movea     *IN           WWIN                           INDICATORS
020000000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
020100000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
020200000000    ?C                   Parm                    WWIN                           INDICATORS
020300000000    ?C                   Parm                    WWRTN                          RETURN CODE
020400000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
020500000000    ?C                   Endsr                                                  END RCV MSG
020600000000    ? *___________________________________________________________________
020700000000    ? * Display panels
020800000000    ? *___________________________________________________________________
020900000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
021000000000    ? *
021100000000    ? * Set PUTOVR based on last display file processed
021200000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
021300000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
021400000000 001?C                   Setoff                                       35        PUTOVR OFF
021500000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
021600000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
021700000000X001?C                   Else                                                   ELSE SAME PGM
021800000000 001?C                   Seton                                        35        PUTOVR ON
021900000000E001?C                   Endif                                                  END IF NEW PGM
022000000000    ? *
022100000614    ? * Set PROTECT key based on request
022200000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
022300000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
022400000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
022500000000 001?C                   Setoff                                       40        NO PROTECT KEY
022600000000X001?C                   Else                                                   ELSE
022700000000 001?C                   Seton                                        40        PROTECT KEY
022800000000E001?C                   Endif                                                  END IF ADD
022900030722    ? *
023000030722    ? * Set PROTECT key based on Relationship id
023100030722 001?C     LCRELI        Ifne      *Blanks                                      OR COPY
023200030722 001?C                   Seton                                        40        PROTECT KEY
023300030722E001?C                   Endif                                                  END IF ADD
023400000000    ? *
023500000000    ? * Select title
023600000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
023700000000 001?C                   Setoff                                       38        CHANGE TITLE
023800000000X001?C                   Else                                                   ELSE
023900000000 001?C                   Seton                                        38        ADD TITLE
024000000000E001?C                   Endif                                                  END IF CHANGE
024100000000    ? *
024200000000    ? * Position cursor based on error status
024300000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
024400000000 001?C                   Seton                                        99        POS CSR TO ERROR
024500000000X001?C                   Else                                                   ELSE
024600000000 001?C                   Setoff                                       99        POS CSR TO FIRST
024700000000E001?C                   Endif                                                  END IF ERROR
024800000000    ? *
024900000000    ? * Write message subfile
025000000000    ?C                   Seton                                        30        MSGSFL DISPLAY
025100000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
025200000000    ? *
025300000000    ? * Write entry panel
025400000000B001?C                   Select
025500000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
025600000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
025700000000 001?C                   Setoff                                       37        RESET CRSLOC
025800000000E001?C                   Endsl                                                  END SELECT
025900000000    ? *
026000000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
026100000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
026200000000E001?C                   Endif                                                  END IF DATA CHG
026300000000    ?C                   Endsr                                                  END DSPENT
026400000000    ? *___________________________________________________________________
026500000000    ? * Process function key
026600000000    ? *___________________________________________________________________
026700000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
026800991108    ?C                   Movea     *IN           WWIN                           INDICATORS
026900991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
027000000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
027100000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
027200000000    ?C                   Parm                    WAD                            FNC DESC
027300991108    ?C                   Parm                    WWIN                           AID BYTE
027400000000    ?C                   Parm                    WAF                            FNC KEY TABLE
027500000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
027600000000    ?C                   Endsr                                                  END PRCFKY
027700000000    ? *___________________________________________________________________
027800000000    ? * Process KEYS function
027900000000    ? *___________________________________________________________________
028000000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
028100000000    ?C                   Z-add     1             WW                             KEY DSC IDX
028200000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
028300000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
028400000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
028500000000 001? *
028600000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
028700000000 002?C                   Z-add     1             WWFKS                          SET TO 1
028800000000E002?C                   Endif                                                  END IF OVER 3
028900000000 001? *
029000000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
029100000000 001?C                   Sub       1             WW                             KEY DESCR IDX
029200000000E001?C                   Enddo                                                  END DO KEYS
029300000000    ? *
029400000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
029500000000    ?C                   Add       1             WW                             BUMP IDX
029600000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
029700000000    ?C                   Endsr                                                  END PRCDKY
029800000000    ? *___________________________________________________________________
029900000000    ? * Process EXIT Function
030000000000    ? *___________________________________________________________________
030100000000    ?C     PRCEXT        Begsr                                                  RETURN
030200000000    ? *
030300000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
030400000000    ? *
030500000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
030600000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
030700000000X001?C                   Else                                                   ELSE NO ERRORS
030800000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
030900000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
031000000000E001?C                   Endif                                                  END IF ERRORS
031100000000    ?C                   Endsr                                                  END PRCEXT
031200000000    ? *___________________________________________________________________
031300000000    ? * Process PROMPT function
031400000000    ? *___________________________________________________________________
031500000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
031600000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
031700000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
031800000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
031900000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
032000000000    ? *
032100000000B001?C                   Select                                                 SELECT
032200030717 001 C                   When      WSFLD = 'LCRELI'
032300030717 001?C                   Call      'FM484CL '                                   CALL SELECT PROGRAM
032400030717 001?C                   Parm                    WDSMN                          RECORD DS
032500030716B002?C                   If        %TRIM(WDSMN) <> '*LR'                        ENTER
032600030717 003?C                   Movel     SRRELID       LCRELI                         SET CODE
032700030716     C                   EXSR      GETSMAN
032800030716E001?C                   Endif
032900030717 001? *
033000040603 001 C                   When      WSFLD = 'WGCARR'
033100040603 001?C                   Call      'SLCHYPER'                                   CALL SELECT PROGRAM
033200030717 001?C                   Parm                    WWRQS                          REQUEST
033300030717 001?C                   Parm                    WWRTN                          RETURN CODE
033400030717 001?C                   Parm                    WUPGM                          PROGRAM
033500030717 001?C                   Parm                    WDCAR                          RECORD DS
033600030717B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
033601040603 003?C                   Eval      LCCARR = %trim(HCCODE)                       SET CODE
033700040603 003?C                   Eval      WGCARR = %trim(HCCODE)                       SET CODE
033800040603 003?C                   Eval      WDCARR = %trim(HCNAME)                       SET CODE
033900030717E001?C                   Endif
034000000112 001? *
034100000000 001?C                   Other                                                  WHERE ERROR
034200000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
034300000000 001?C                   Exsr      SNDMSG                                       SEND MSG
034400000000E001?C                   Endsl                                                  END SELECT
034500000000    ? *
034600000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
034700000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
034800000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
034900030717    ?C                   Mvr                     WSLIN                          CURSOR COL
035000000000    ?C                   Seton                                        37        SET ON CRSLOC
035100000000    ? *
035200000000    ?C                   Endsr                                                  END PRCPMT
035300000000    ? *___________________________________________________________________
035400000000    ? * Process CANCEL Function
035500000000    ? *___________________________________________________________________
035600000000    ?C     PRCCNL        Begsr                                                  CANCEL
035700000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
035800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
035900000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
036000000000    ?C                   Endsr                                                  END RETURN
036100000000    ? *___________________________________________________________________
036200000000    ? * Process ROLLUP function
036300000000    ? *___________________________________________________________________
036400000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
036500000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
036600000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
036700000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
036800000000E001?C                   Endif                                                  END IF GT LST PNL
036900000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
037000000000    ?C                   Endsr                                                  END PRCRUP
037100000000    ? *___________________________________________________________________
037200000000    ? * Process ROLLDOWN function
037300000000    ? *___________________________________________________________________
037400000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
037500000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
037600000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
037700000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
037800000000E001?C                   Endif                                                  END IF LT FST PNL
037900000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
038000000000    ?C                   Endsr                                                  END PRCRDN
038100000000    ? *___________________________________________________________________
038200000000    ? * Process ENTER function
038300000000    ? *___________________________________________________________________
038400000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
038500000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
038600000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
038700000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
038800000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
038900000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
039000030722     C                   Z-add     WSEFDT        LCEFFD
039100030722     C                   Z-add     WSTRDT        LCEXPD
039200030722     C                   Z-add     WSAOCR        LCAOCR
039300030717 001?C                   Call      'CHKCON  '                                   CHECK DATA
039400000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
039500000000 001?C                   Parm                    WWRTN                          RETURN CODE
039600000614 001?C                   Parm                    WUDTA                          REC DATA
039700000000E001?C                   Endif                                                  ENDIF
039800000000    ? *
039900000000B001?C                   Select                                                 PRC RETURN CDE
040000000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
040100000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
040200010219 001?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
040300000000 001? *
040400000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
040500000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
040600000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
040700010219 002?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
040800000000X002?C                   Else                                                   ELSE
040900000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
041000000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
041100000000E002?C                   Endif                                                  IF WARNING
041200000000 001? *
041300000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
041400000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
041500000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
041600000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
041700000000E001?C                   Endsl                                                  RETURN CODE SEL
041800000000    ? *
041900000000    ?C                   Endsr                                                  END PRCPNL
042000000000    ? *___________________________________________________________________
042100000000    ? * Process end - write data or release record
042200000000    ? *___________________________________________________________________
042300000000    ?C     PRCEND        Begsr                                                  PROCESS END
042400000000    ? *
042500000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
042600000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
042700000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
042800000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
042900000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
043000000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
043100000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
043200000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
043300000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
043400000000 001?C                   Endcs                                                  END CASE
043500000000 001? *
043600000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
043700000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
043800000000 002? *
043900000000X002?C                   Else                                                   ELSE NO WRT ERR
044000000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
044100000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
044200000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
044300000000 004?C                   Exsr      PRPPNL                                       DO NOT END
044400000810E004?C                   Endif                                                  END IF ADD
044500000000E003?C                   Endif                                                  END IF NOT END
044600000000E002?C                   Endif                                                  END IF WRITE ERROR
044700000000 001? *
044800000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
044900000000 001?C                   Exsr      RELREC                                       RELEASE REC
045000000000E001?C                   Endif                                                  END IF RCD CHANGED
045100000000    ? *
045200000000    ?C                   Endsr                                                  END PRCEND
045300000000    ? *___________________________________________________________________
045400000000    ? * Add new record
045500000000    ? *___________________________________________________________________
045600000000    ?C     WRTADD        Begsr                                                  WRITE ADD
045700000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
045800000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
045900000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
046000000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
046100000000E001?C                   Endif                                                  END IF ADD
046200000000    ? *
046300000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
046400000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
046500000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
046600000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
046700000000E001?C                   Endif                                                  END IF ADD KEY
046800000000    ? *
046900030717    ?C                   Call      'UPDCON  '                                   PROCESS REC IO
047000000000    ?C                   Parm                    WWRQS                          ADD RECORD
047100000000    ?C                   Parm                    WWRTN                          RETURN CODE
047200000614    ?C                   Parm                    WUDTA                          REC DATA
047300000000    ? *
047400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
047500000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
047600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047700000000X001?C                   Else                                                   ELSE
047800000000E001?C                   Endif                                                  END IF CALL ERROR
047900000000    ? *
048000000000    ?C                   Endsr                                                  END WRTADD
048100000000    ? *___________________________________________________________________
048200000000    ? * Write changed record
048300000000    ? *___________________________________________________________________
048400000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
048500030717    ?C                   Call      'UPDCON  '                                   PROCESS REC IO
048600000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
048700000000    ?C                   Parm                    WWRTN                          RETURN CODE
048800000614    ?C                   Parm                    WUDTA                          REC DATA
048900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
049000000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
049100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
049200000000E001?C                   Endif                                                  END IF CALL ERROR
049300000000    ? *
049400000000    ?C                   Endsr                                                  END WRTCHG
049500000000    ? *___________________________________________________________________
049600000000    ? * Release record
049700000000    ? *___________________________________________________________________
049800000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
049900030717    ?C                   Call      'UPDCON  '                                   PROCESS REC IO
050000000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
050100000000    ?C                   Parm                    WWRTN                          RETURN CODE
050200000614    ?C                   Parm                    WUDTA                          REC DATA
050300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
050400000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
050500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
050600000000E001?C                   Endif                                                  END IF CALL ERROR
050700000000    ?C                   Endsr                                                  END RELREC
050800000000    ? *___________________________________________________________________
050900000000    ? * Build function keys
051000000000    ? *___________________________________________________________________
051100000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
051200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
051300991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
051400000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
051500000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
051600000000    ?C                   Parm                    WAD                            FNC DESC
051700991108    ?C                   Parm                    WWIN                           AID BYTE
051800000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
051900000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
052000000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
052100000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
052200000000    ?C                   Sub       1             WW                             BUMP IDX
052300000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
052400000000    ?C                   Endsr                                                  END BLD FNCTNS
052500000000    ? *___________________________________________________________________
052600000000    ? * Send message
052700000000    ? *___________________________________________________________________
052800000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
052900000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
053000000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
053100000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
053200000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
053300000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
053400000000    ?C                   Endsr                                                  END SNDMSG
053500000000    ? *___________________________________________________________________
053600000000    ? * Paremater list
053700000000    ? *___________________________________________________________________
053800000000    ?C     PLIST         Begsr                                                  PARM LISTS
053900000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
054000000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
054100000000    ?C                   Parm                    WORTN             8            RETURN CODE
054200000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
054300000614    ?C                   Parm                    WUDTA                          RECORD KEY
054400000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
054500000000    ?C                   Endsr                                                  END PLIST
054600030716    ? *___________________________________________________________________
054700030716    ? * GET SALESMAN
054800030716    ? *___________________________________________________________________
054900030716    ?C     GETSMAN       Begsr                                                  PARM LISTS
054901031117     C                   If        NonCom = 'Y'
054902031117     C     LCRELI        CHAIN     BLILMANL2
054903031117     C                   IF        %FOUND
054904031117     C                   Eval      wssman = lmanc
054905031117     C                   Eval      wsnam1 = %trim(lmann)
054906031117     C                   Eval      wsagcy = lagcy
054907031117     C                   Eval      wsnam2 = %trim(lagcn)
054908031117     C                   Eval      wssupr = lsupr
054909031117     C                   Eval      wsnam3 = %trim(lsupn)
054910031117     C                   End
054911031117     C                   Else
055000030717     C     LCRELI        CHAIN     SMANRLT
055100030717     C                   IF        NOT %FOUND
055200031117     C                   CLEAR                   WSSMAN
055300030718     C                   EVAL      *IN69 = *OFF
055400030717     C                   ELSE
055500030718     C                   EVAL      *IN69 = *ON
055501031117     C                   EVAL      WSSMAN   =    SRSMAN
055600030717     C     SRSMAN        CHAIN     SMAN
055700030717     C                   IF        NOT %FOUND
055800030717     C                   CLEAR                   WSNAM1
055900030717     C                   ELSE
056000030717     C                   EVAL      WSNAM1 = %trim(SFNAME) + ' ' + %trim(SLNAME)
056100030717     C                   END
056200030717     C                   END
056300030717     C     SRASID        CHAIN     SPRAGXR2
056400030717     C                   IF        NOT %FOUND
056500031117     C                   CLEAR                   WSSUPR
056600031117     C                   CLEAR                   WSAGCY
056700030717     C                   CLEAR                   WSNAM3
056800030717     C                   ELSE
056801031117     C                   EVAL      WSAGCY   =    SXAGCY
056802031117     C                   EVAL      WSSUPR   =    SXSUPER
056900030717     C     SXAGCY        CHAIN     AGENCY
057000030717     C                   IF        NOT %FOUND
057100030717     C                   CLEAR                   WSNAM2
057200030717     C                   ELSE
057300030717     C                   EVAL      WSNAM2 = %trim(AGNAM1)
057400030717     C                   END
057500030717     C     SXSUPER       CHAIN     SUPRAGCY
057600030717     C                   IF        NOT %FOUND
057700030717     C                   CLEAR                   WSNAM3
057800030717     C                   ELSE
057900030717     C                   EVAL      WSNAM3 = %trim(SANAME1)
058000030717     C                   END
058100030717     C                   END
058101031117     C                   END
058102040603     C                   EVAL      WGCARR = %TRIM(LCCARR)
058200040603     C     WGCARR        CHAIN     HYPERCARR
058300030717     C                   IF        NOT %FOUND
058400030717     C                   CLEAR                   WDCARR
058500030717     C                   ELSE
058600040603     C                   EVAL      WDCARR = %trim(HCNAME)
058700030717     C                   END
058800030716    ?C                   Endsr                                                  END PLIST
058900000000    ? *___________________________________________________________________
059000000000    ? * Initialize routine
059100000000    ? *___________________________________________________________________
059200000000    ?C     *INZSR        Begsr                                                  INITIALIZE
059300000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
059400000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
059500000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
059600000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
059700000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
059800000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
059900000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
060000000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
060100000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
060200000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
060300000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
060400000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
060500000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
060600000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
060700000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
060800000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
060900000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
061000000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
061100000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
061200000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
061300000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
061400000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
061500000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
061600000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
061700000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
061800030717    ?C                   Movel     'BLICON  '    WWFIL            10            FILE NAME-NOTES
061900000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
062000000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
062100000000    ?C                   Endsr                                                  END INITIALIZE
062200000000    ? *___________________________________________________________________
062300000000    ? * Program error handler
062400000000    ? *___________________________________________________________________
062500000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
062600000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
062700000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
062800000000    ?C                   Parm                    WQSTSC                         STATUS CODE
062900000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
063000000000    ?C                   Parm                    WQMSG                          MESSAGE ID
063100000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
063200000000    ? *___________________________________________________________________
063300000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06340000000003EXIT    F3=Exit
06350000000004PROMPT  F4=Prompt
06360000000005REFRESH F5=Refresh
06370000070710UPDATE  F10=Update
06380000061412CANCEL  F12=Cancel
06390000000025ROLLUP
06400000000026ROLLDOWN
064100000000** WTM
06420003071700Request not supported in program CHGCON.
06430000000000Update error.  Data was not updated.
06440000000000Duplicate key detected.  Data was NOT added to file.
06450000000000Call to notes ended in error.
06460000000000Initialize error.  Record not initialized.
06470000000000Record not found.
06480000000000Generate error.  Key not generated.
06490000000000Record not available now.
06500000000000The cursor is not in a prompt area.
06510000000000Default error.  Data not defaulted.
