000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300040220    ? *  Description:  Change Broker Representative
000400010914    ? *
000500040220    ? *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700040928    ?FCHGBRLD   CF   E             WORKSTN INFDS(DSPD)
000800040928    ?FBRKREP    if   e           k disk    PREFIX(ZZ:2)
000900000000    ? *
001000000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001100000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001200000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001300040308    ? *
001400040308     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
001500040308     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
001600000000    ? *_________________________________________________________________________
001700000406    ? * Data structure
001800040219    ?D WUDTA         E DS                  EXTNAME(BRKREP)
001900010219    ? *
002000000000    ? *
002100000000    ? * Program status data structure
002200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000    ? *
002400000000    ? * Display file data structure
002500991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002600000000    ? *
002700000000    ? * CURSOR LOCATION
002800000000    ?D                 DS
002900000000    ?D  WWCRSL                 1      2
003000000000    ?D  WWCRSN                 1      2B 0
003100040322    ? *
003200040928    ?D HBRkID          S              5s 0
003300040928     ***
003400040928     d @lda            ds
003500040928     d blah                    1    240a
003600040928     d co_name               200    240a
003700000000    ? *_________________________________________________________________________
003800000000    ? *
003900040223B001?C     WWTSK         Ifeq      'ADD     '
004000040322     C                   Eval      HBRkID = *ZEROS                              Hist cover-trhu date
004100040322     C     *Loval        Setll     BRkrepR
004200040322    2C                   Dou       %EOF(BRKrep)
004300040322     C                   Read      BRkrepR
004400040322     C                   If        NOT %EOF(BRKrep)
004500040928     C                   If        zzkID > HBRkID
004600040928     C                   Eval      HBrkID = zzkID                               Hist cover-trhu date
004700040322     C                   Endif
004800040322     C                   Endif
004900040322    1C                   Enddo
005000040322     C                   EVAL      BRkID = HBRkID + 1
005100040322     C                   ENDIF
005200040223    ? *
005300000614    ? * Process Entry Panel
005400000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
005500000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
005600000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
005700000000E001?C                   Endif                                                  END COPY/CPYKEY
005800000000    ? *
005900000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
006000000000    ? *
006100000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
006200000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
006300000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
006400000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
006500000000 001? *
006600000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
006700000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
006800000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
006900000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
007000000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
007100000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
007200000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
007300000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
007400000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
007500000000 001?C                   Endcs                                                  END CASE
007600000000 001? *
007700000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
007800000000 002?C                   Exsr      PRCEND                                       PROCESS END
007900000000E002?C                   Endif                                                  END IF END REQ
008000000000E001?C                   Enddo                                                  END DOWHILE
008100000000    ? *
008200000707    ? * Send Info Updated message.
008300000707     C     WwChg         Ifeq      'Y'
008400000707     C                   Movel     'UPDATE  '    WORTN
008500000707     C                   Endif
008600000707    ? *
008700000000    ?C                   Return                                                 RETURN
008800000000    ? *___________________________________________________________________
008900000000    ? * Prepare panel
009000000000    ? *___________________________________________________________________
009100000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
009200000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
009300991108    ?C                   Move      'N'           WWERR                          NO ERRORS
009400000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
009500000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
009600000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
009700000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
009800000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
009900000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
010000000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
010100040325    ?C                   Move      'Y'           FIRST                          FIRST TIME
010200000000    ? *
010300040928     C     *DTAARA       DEFINE    *LDA          @LDA
010400040928     C                   IN        @LDA
010500040928     c                   eval      wsname = co_name
010600040928    ? *
010700000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
010800000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
010900000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
011000000000E002?C                   Endif                                                  ENDIF SAME REQUEST
011100000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
011200000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
011300000000    ? *
011400000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
011500000000    ? *
011600000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
011700000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
011800000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
011900000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
012000000000    ?C                   Cas                     PRCERR                         PROC ERROR
012100000000    ?C                   Endcs                                                  END CASE
012200000000    ? *
012300000000    ?C                   Endsr                                                  END PRPPNL
012400000000    ? *___________________________________________________________________
012500000000    ? * Prepare ADD request
012600000000    ? *___________________________________________________________________
012700000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
012800040223    ?C*                  Clear                   WUDTA                          CLEAR RECORD
012900040223    ?C                   Clear                   BRKFNM                         CLEAR FIELD
013000040223    ?C                   Clear                   BRKLNM                         CLEAR FIELD
013100040223    ?C                   Clear                   BRKTMD                         CLEAR FIELD
013200000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
013300000000    ?C                   Endsr                                                  END PRP ADD
013400000000    ? *___________________________________________________________________
013500000000    ? * Prepare CHANGE request
013600000000    ? *___________________________________________________________________
013700000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
013800040219    ?C                   Call      'UPDBRL  '                                   PROCESS REC IO
013900000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
014000000000    ?C                   Parm                    WWRTN                          RETURN CODE
014100000614    ?C                   Parm                    WUDTA                          REC DATA
014200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014300000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
014400000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
014500000000X002?C                   Else                                                   ELSE
014600000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014700000000E002?C                   Endif                                                  END RCD NOT AVL
014800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014900000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015000000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015100000810E001?C                   Else                                                   END IF ERROR
015200000810E001?C                   Endif                                                  END IF ERROR
015300000000    ?C                   Endsr                                                  END PRP CHANGE
015400000000    ? *___________________________________________________________________
015500000000    ? * Prepare COPY request
015600000000    ? *___________________________________________________________________
015700000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
015800000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
015900040219    ?C                   Call      'UPDBRL  '                                   PROCESS REC IO
016000000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
016100000000    ?C                   Parm                    WWRTN                          RETURN CODE
016200000614    ?C                   Parm                    WUDTA                          REC DATA
016300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016400000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
016500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016800000000X001?C                   Else                                                   ELSE
016900000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
017000000000E001?C                   Endif                                                  END IF ERROR
017100000000    ?C                   Endsr                                                  END PREP COPY
017200000000    ? *___________________________________________________________________
017300000000    ? * Default Data
017400000000    ? *___________________________________________________________________
017500000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
017600040219    ?C                   Call      'CHKBRL  '                                   PROCESS REC IO
017700000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
017800000000    ?C                   Parm                    WWRTN                          RETURN CODE
017900000614    ?C                   Parm                    WUDTA                          REC DATA
018000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
018100000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
018200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
018500000000E001?C                   Endif                                                  END IF ERROR
018600000000    ?C                   Endsr                                                  END DFTDTA
018700000000    ? *___________________________________________________________________
018800000000    ? * Process ERROR function
018900000000    ? *___________________________________________________________________
019000000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
019100000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
019200000000    ?C                   Exsr      SNDMSG                                       SEND MSG
019300000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019400000000    ?C                   Move      'END'         WWSTT                          END STATE
019500000000    ?C                   Endsr                                                  END PRCERR
019600000000    ? *___________________________________________________________________
019700000000    ? * Receive messages
019800000000    ? *___________________________________________________________________
019900000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
020000000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
020100000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
020200000000X001?C                   Else                                                   ELSE
020300000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
020400000000E001?C                   Endif                                                  ENDIF NOT NORESET
020500000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
020600000000    ?C                   Movea     *IN           WWIN                           INDICATORS
020700000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
020800000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
020900000000    ?C                   Parm                    WWIN                           INDICATORS
021000000000    ?C                   Parm                    WWRTN                          RETURN CODE
021100000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
021200000000    ?C                   Endsr                                                  END RCV MSG
021300000000    ? *___________________________________________________________________
021400000000    ? * Display panels
021500000000    ? *___________________________________________________________________
021600000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
021700000000    ? *
021800000000    ? * Set PUTOVR based on last display file processed
021900000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
022000000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
022100000000 001?C                   Setoff                                       35        PUTOVR OFF
022200000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
022300000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
022400000000X001?C                   Else                                                   ELSE SAME PGM
022500000000 001?C                   Seton                                        35        PUTOVR ON
022600000000E001?C                   Endif                                                  END IF NEW PGM
022700000000    ? *
022800000614    ? * Set PROTECT key based on request
022900000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
023000000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
023100000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
023200000000 001?C                   Setoff                                       40        NO PROTECT KEY
023300000000X001?C                   Else                                                   ELSE
023400000000 001?C                   Seton                                        40        PROTECT KEY
023500000000E001?C                   Endif                                                  END IF ADD
023600000000    ? *
023700000000    ? * Select title
023800000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
023900000000 001?C                   Setoff                                       38        CHANGE TITLE
024000000000X001?C                   Else                                                   ELSE
024100000000 001?C                   Seton                                        38        ADD TITLE
024200000000E001?C                   Endif                                                  END IF CHANGE
024300000000    ? *
024400000000    ? * Position cursor based on error status
024500000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
024600000000 001?C                   Seton                                        99        POS CSR TO ERROR
024700000000X001?C                   Else                                                   ELSE
024800000000 001?C                   Setoff                                       99        POS CSR TO FIRST
024900000000E001?C                   Endif                                                  END IF ERROR
025000000000    ? *
025100000000    ? * Write message subfile
025200000000    ?C                   Seton                                        30        MSGSFL DISPLAY
025300000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
025400000000    ? *
025500040325     C                   IF        FIRST = 'Y'
025600040325     C                   EVAL      FIRST = 'N'
025700040325     C     *USA          TEST(DE)                brktmd
025800040325     c
025900040325    1C                   IF        %ERROR
026000040325     C                   IF        BRkTMD <> *ZEROS
026100040325     C                   MOVE      BRkTMD        ISO_DATE
026200040325     C                   MOVE      ISO_DATE      USA_DATE
026300040325     C                   MOVE      USA_DATE      BRkTMD
026400040325    1C                   ENDIF
026500040325    1C                   ENDIF
026600040325    1C                   ENDIF
026700040322     c
026800000000    ? * Write entry panel
026900000000B001?C                   Select
027000000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
027100000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
027200000000 001?C                   Setoff                                       37        RESET CRSLOC
027300000000E001?C                   Endsl                                                  END SELECT
027400000000    ? *
027500040322     c
027600040322     C*** temp           IF        BRkTMD <> *ZEROS
027700040322     C*                  MOVE      BRkTMD        usa_DATE
027800040322     C*                  MOVE      usa_DATE      iso_DATE
027900040322     C*                  MOVE      iso_DATE      BRkTMD
028000040322    1C***                ENDIF
028100040322     c
028200000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
028300000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
028400000000E001?C                   Endif                                                  END IF DATA CHG
028500000000    ?C                   Endsr                                                  END DSPENT
028600000000    ? *___________________________________________________________________
028700000000    ? * Process function key
028800000000    ? *___________________________________________________________________
028900000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
029000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
029100991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
029200000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
029300000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
029400000000    ?C                   Parm                    WAD                            FNC DESC
029500991108    ?C                   Parm                    WWIN                           AID BYTE
029600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
029700000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
029800000000    ?C                   Endsr                                                  END PRCFKY
029900000000    ? *___________________________________________________________________
030000000000    ? * Process KEYS function
030100000000    ? *___________________________________________________________________
030200000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
030300000000    ?C                   Z-add     1             WW                             KEY DSC IDX
030400000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
030500000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
030600000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
030700000000 001? *
030800000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
030900000000 002?C                   Z-add     1             WWFKS                          SET TO 1
031000000000E002?C                   Endif                                                  END IF OVER 3
031100000000 001? *
031200000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
031300000000 001?C                   Sub       1             WW                             KEY DESCR IDX
031400000000E001?C                   Enddo                                                  END DO KEYS
031500000000    ? *
031600010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
031700010913    ?C                   Add       1             WW                             BUMP IDX
031800010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
031900010913    ?C                   Endsr                                                  END PRCDKY
032000000000    ? *___________________________________________________________________
032100000000    ? * Process EXIT Function
032200000000    ? *___________________________________________________________________
032300000000    ?C     PRCEXT        Begsr                                                  RETURN
032400000000    ? *
032500000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
032600000000    ? *
032700000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
032800000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
032900000000X001?C                   Else                                                   ELSE NO ERRORS
033000000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
033100000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
033200000000E001?C                   Endif                                                  END IF ERRORS
033300000000    ?C                   Endsr                                                  END PRCEXT
033400000000    ? *___________________________________________________________________
033500000000    ? * Process PROMPT function
033600000000    ? *___________________________________________________________________
033700000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
033800000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
033900000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
034000000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
034100000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
034200000000    ? *
034300000000B001?C                   Select                                                 SELECT
034400000112 001? *
034500000000 001?C                   Other                                                  WHERE ERROR
034600000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
034700000000 001?C                   Exsr      SNDMSG                                       SEND MSG
034800000000E001?C                   Endsl                                                  END SELECT
034900000000    ? *
035000000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
035100000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
035200000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
035300000000    ?C                   Mvr                     WSLIN                          CURSOR COL
035400000000    ?C                   Seton                                        37        SET ON CRSLOC
035500000000    ? *
035600000000    ?C                   Endsr                                                  END PRCPMT
035700000000    ? *___________________________________________________________________
035800000000    ? * Process CANCEL Function
035900000000    ? *___________________________________________________________________
036000000000    ?C     PRCCNL        Begsr                                                  CANCEL
036100000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
036200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
036300000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
036400000000    ?C                   Endsr                                                  END RETURN
036500000000    ? *___________________________________________________________________
036600000000    ? * Process ROLLUP function
036700000000    ? *___________________________________________________________________
036800000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
036900000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
037000000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
037100000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
037200000000E001?C                   Endif                                                  END IF GT LST PNL
037300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
037400000000    ?C                   Endsr                                                  END PRCRUP
037500000000    ? *___________________________________________________________________
037600000000    ? * Process ROLLDOWN function
037700000000    ? *___________________________________________________________________
037800000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
037900000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
038000000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
038100000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
038200000000E001?C                   Endif                                                  END IF LT FST PNL
038300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
038400000000    ?C                   Endsr                                                  END PRCRDN
038500000000    ? *___________________________________________________________________
038600000000    ? * Process ENTER function
038700000000    ? *___________________________________________________________________
038800000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
038900000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
039000000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
039100000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
039200000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
039300040325     ****CONVERT DATE FROM MDY TO YMD (IF NECESSARY)
039400040325     C*    *ISO          TEST(DE)                brktmd
039500040325    1C*                  IF        %ERROR
039600040325     C*                  IF        BRKTMD <> *ZEROS
039700040325     C*                  MOVE      BRKTMD        USA_DATE
039800040325     C*                  MOVE      USA_DATE      ISO_DATE
039900040325     C*                  MOVE      ISO_DATE      BRKTMD
040000040325    1C*                  ENDIF
040100040325    1C*                  ENDIF
040200040322     ****
040300000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
040400040219 001?C                   Call      'CHKBRL  '                                   CHECK DATA
040500000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
040600000000 001?C                   Parm                    WWRTN                          RETURN CODE
040700000614 001?C                   Parm                    WUDTA                          REC DATA
040800000000E001?C                   Endif                                                  ENDIF
040900040322    ? *
041000040325     C*                  IF        BRkTMD <> *ZEROS
041100040325     C*                  MOVE      BRkTMD        ISO_DATE
041200040325     C*                  MOVE      ISO_DATE      USA_DATE
041300040325     C*                  MOVE      USA_DATE      BRkTMD
041400040325    1C*                  ENDIF
041500000000    ? *
041600000000B001?C                   Select                                                 PRC RETURN CDE
041700000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
041800000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
041900000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
042000000000 001? *
042100000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
042200000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
042300000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
042400000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
042500000000X002?C                   Else                                                   ELSE
042600000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
042700000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
042800000000E002?C                   Endif                                                  IF WARNING
042900000000 001? *
043000000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
043100000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
043200000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
043300000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
043400000000E001?C                   Endsl                                                  RETURN CODE SEL
043500000000    ? *
043600000000    ?C                   Endsr                                                  END PRCPNL
043700000000    ? *___________________________________________________________________
043800000000    ? * Process end - write data or release record
043900000000    ? *___________________________________________________________________
044000000000    ?C     PRCEND        Begsr                                                  PROCESS END
044100000000    ? *
044200000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
044300000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
044400000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
044500000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
044600000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
044700000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
044800000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
044900000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
045000000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
045100000000 001?C                   Endcs                                                  END CASE
045200000000 001? *
045300000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
045400000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
045500000000 002? *
045600000000X002?C                   Else                                                   ELSE NO WRT ERR
045700000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
045800000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
045900000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
046000000000 004?C                   Exsr      PRPPNL                                       DO NOT END
046100000810E004?C                   Endif                                                  END IF ADD
046200000000E003?C                   Endif                                                  END IF NOT END
046300000000E002?C                   Endif                                                  END IF WRITE ERROR
046400000000 001? *
046500000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
046600000000 001?C                   Exsr      RELREC                                       RELEASE REC
046700000000E001?C                   Endif                                                  END IF RCD CHANGED
046800000000    ? *
046900000000    ?C                   Endsr                                                  END PRCEND
047000000000    ? *___________________________________________________________________
047100000000    ? * Add new record
047200000000    ? *___________________________________________________________________
047300000000    ?C     WRTADD        Begsr                                                  WRITE ADD
047400000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
047500000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
047600000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
047700000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
047800000000E001?C                   Endif                                                  END IF ADD
047900000000    ? *
048000000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
048100000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
048200000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
048300000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
048400000000E001?C                   Endif                                                  END IF ADD KEY
048500000000    ? *
048600040219    ?C                   Call      'UPDBRL  '                                   PROCESS REC IO
048700000000    ?C                   Parm                    WWRQS                          ADD RECORD
048800000000    ?C                   Parm                    WWRTN                          RETURN CODE
048900000614    ?C                   Parm                    WUDTA                          REC DATA
049000000000    ? *
049100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
049200000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
049300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
049400000000X001?C                   Else                                                   ELSE
049500000000E001?C                   Endif                                                  END IF CALL ERROR
049600000000    ? *
049700000000    ?C                   Endsr                                                  END WRTADD
049800000000    ? *___________________________________________________________________
049900000000    ? * Write changed record
050000000000    ? *___________________________________________________________________
050100000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
050200040308     ****CONVERT DATE FROM MDY TO YMD
050300040308     C                   IF        BRKTMD <> *ZEROS
050400040308     C                   MOVE      BRKTMD        USA_DATE
050500040308     C                   MOVE      USA_DATE      ISO_DATE
050600040308     C                   MOVE      ISO_DATE      BRKTMD
050700040308    1C                   ENDIF
050800040308     ****
050900040219    ?C                   Call      'UPDBRL  '                                   PROCESS REC IO
051000000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
051100000000    ?C                   Parm                    WWRTN                          RETURN CODE
051200000614    ?C                   Parm                    WUDTA                          REC DATA
051300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
051400000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
051500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
051600000000E001?C                   Endif                                                  END IF CALL ERROR
051700000000    ? *
051800000000    ?C                   Endsr                                                  END WRTCHG
051900000000    ? *___________________________________________________________________
052000000000    ? * Release record
052100000000    ? *___________________________________________________________________
052200000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
052300040219    ?C                   Call      'UPDBRL  '                                   PROCESS REC IO
052400000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
052500000000    ?C                   Parm                    WWRTN                          RETURN CODE
052600000614    ?C                   Parm                    WUDTA                          REC DATA
052700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
052800000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
052900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
053000000000E001?C                   Endif                                                  END IF CALL ERROR
053100000000    ?C                   Endsr                                                  END RELREC
053200000000    ? *___________________________________________________________________
053300000000    ? * Build function keys
053400000000    ? *___________________________________________________________________
053500000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
053600991108    ?C                   Movea     *IN           WWIN                           INDICATORS
053700991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
053800000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
053900000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
054000000000    ?C                   Parm                    WAD                            FNC DESC
054100991108    ?C                   Parm                    WWIN                           AID BYTE
054200000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
054300000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
054400010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
054500010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
054600010913    ?C                   Sub       1             WW                             BUMP IDX
054700010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
054800000000    ?C                   Endsr                                                  END BLD FNCTNS
054900000000    ? *___________________________________________________________________
055000000000    ? * Send message
055100000000    ? *___________________________________________________________________
055200000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
055300000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
055400000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
055500000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
055600000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
055700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
055800000000    ?C                   Endsr                                                  END SNDMSG
055900000000    ? *___________________________________________________________________
056000000000    ? * Paremater list
056100000000    ? *___________________________________________________________________
056200000000    ?C     PLIST         Begsr                                                  PARM LISTS
056300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
056400000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
056500000000    ?C                   Parm                    WORTN             8            RETURN CODE
056600000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
056700000614    ?C                   Parm                    WUDTA                          RECORD KEY
056800000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
056900000000    ?C                   Endsr                                                  END PLIST
057000000000    ? *___________________________________________________________________
057100000000    ? * Initialize routine
057200000000    ? *___________________________________________________________________
057300000000    ?C     *INZSR        Begsr                                                  INITIALIZE
057400000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
057500000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
057600000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
057700000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
057800000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
057900000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
058000000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
058100000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
058200000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
058300000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
058400000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
058500000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
058600000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
058700000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
058800000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
058900000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
059000000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
059100000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
059200000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
059300000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
059400000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
059500000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
059600000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
059700000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
059800000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
059900040220    ?C                   Movel     'BRKREP'      WWFIL            10            FILE NAME-NOTES
060000000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
060100000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
060200040325    ?C                   Move      'Y'           FIRST             1            FIRST TIME
060300000000    ?C                   Endsr                                                  END INITIALIZE
060400000000    ? *___________________________________________________________________
060500000000    ? * Program error handler
060600000000    ? *___________________________________________________________________
060700000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
060800000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
060900000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
061000000000    ?C                   Parm                    WQSTSC                         STATUS CODE
061100000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
061200000000    ?C                   Parm                    WQMSG                          MESSAGE ID
061300000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
061400000000    ? *___________________________________________________________________
061500000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06160000000003EXIT    F3=Exit
06170000000004PROMPT  F4=Prompt
06180000000005REFRESH F5=Refresh
06190000070710UPDATE  F10=Update
06200000061412CANCEL  F12=Cancel
06210000000025ROLLUP
06220000000026ROLLDOWN
062300000000** WTM
06240004021900Request not supported in program CHGBRL.
06250000000000Update error.  Data was not updated.
06260000000000Duplicate key detected.  Data was NOT added to file.
06270000000000Call to notes ended in error.
06280000000000Initialize error.  Record not initialized.
06290000000000Record not found.
06300000000000Generate error.  Key not generated.
06310000000000Record not available now.
06320000000000The cursor is not in a prompt area.
06330000000000Default error.  Data not defaulted.
