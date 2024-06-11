000100130204     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200130204     H option(*SRCSTMT: *NODEBUGIO)
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500101220    ? *  Description:  Change Payroll SSN X-Reference
000600000000    ? *
000700020920    ? *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000800000000    ? *_________________________________________________________________________
000900130204    ?FCHGXRFD   CF   E             WORKSTN
001000000000    ?F                                     INFDS(DSPD)
001100130204     FACCMST    IF   E           K DISK
001200130204     FPLNMST    IF   E           K DISK
001300000000    ? *
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001600030313    ?D WTM             S             80    DIM(11) CTDATA PERRCD(1)             PANEL MESSAGES
001700130204    ? *_________________________________________________________________________
001800130204      /COPY *LIBL/QMODSRC,#PROTO
001900130204     D w80date         s              8S 0 inz
002000000000    ? *_________________________________________________________________________
002100000406    ? * Data structure
002200130204    ?D WUDTA         E DS                  EXTNAME(WEBPLNXRFP)
002300130204     D webnote       e ds                  extname(webnotp) inz
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
005300030313 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
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
006800000707     C                   Movel     'UPDATE  '    WORTN
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
009400100520    ? *
009500130204     C     ACCKEY        Chain     ACCMST
009600130204     C                   If        %found(ACCMST)
009700130204     C                   Eval      WSNAME = %trim(ACNAM1)
009800101220     C                   Else
009900130204     C                   Eval      WSNAME = *Blanks
010000101220     C                   End
010100101220    ? *
010200130204     C     plnkey        Chain     PLNMST
010300130204     C                   Eval      webnote = #getnot(plncat:xltrst:xlsub#:
010400130204     C                                               xlacct:w80date:xlplan)
010500130204     C                   Eval      wsdesc = %trim(CNDSC)
010600130204     C     plnkeyx       Chain     PLNMST
010700130204     C                   Eval      webnote = #getnot(plncat:xltrst:xlsub#:
010800130204     C                                               xlacct:w80date:xlxpln)
010900130204     C                   Eval      wxdesc = %trim(CNDSC)
011000100617    ? *
011100000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
011200000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
011300000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
011400000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
011500000000    ?C                   Cas                     PRCERR                         PROC ERROR
011600000000    ?C                   Endcs                                                  END CASE
011700000000    ? *
011800000000    ?C                   Endsr                                                  END PRPPNL
011900000000    ? *___________________________________________________________________
012000000000    ? * Prepare ADD request
012100000000    ? *___________________________________________________________________
012200000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
012300000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
012400000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
012500000000    ?C                   Endsr                                                  END PRP ADD
012600000000    ? *___________________________________________________________________
012700000000    ? * Prepare CHANGE request
012800000000    ? *___________________________________________________________________
012900000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
013000130204    ?C                   Call      'UPDXRF  '                                   PROCESS REC IO
013100000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
013200000000    ?C                   Parm                    WWRTN                          RETURN CODE
013300000614    ?C                   Parm                    WUDTA                          REC DATA
013400101202    ? *
013500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
013600000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
013700000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
013800000000X002?C                   Else                                                   ELSE
013900000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014000000000E002?C                   Endif                                                  END RCD NOT AVL
014100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
014400000810E001?C                   Endif                                                  END IF ERROR
014500000000    ?C                   Endsr                                                  END PRP CHANGE
014600000000    ? *___________________________________________________________________
014700000000    ? * Prepare COPY request
014800000000    ? *___________________________________________________________________
014900000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
015000000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
015100130204    ?C                   Call      'UPDXRF  '                                   PROCESS REC IO
015200000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
015300000000    ?C                   Parm                    WWRTN                          RETURN CODE
015400000614    ?C                   Parm                    WUDTA                          REC DATA
015500101202    ? *
015600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015700000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
015800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
015900000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016000000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016100000000X001?C                   Else                                                   ELSE
016200000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
016300000000E001?C                   Endif                                                  END IF ERROR
016400000000    ?C                   Endsr                                                  END PREP COPY
016500000000    ? *___________________________________________________________________
016600000000    ? * Default Data
016700000000    ? *___________________________________________________________________
016800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
016900130204    ?C                   Call      'CHKXRF  '                                   PROCESS REC IO
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
022900000000    ? *
023000000000    ? * Select title
023100000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
023200000000 001?C                   Setoff                                       38        CHANGE TITLE
023300000000X001?C                   Else                                                   ELSE
023400000000 001?C                   Seton                                        38        ADD TITLE
023500000000E001?C                   Endif                                                  END IF CHANGE
023600000000    ? *
023700000000    ? * Position cursor based on error status
023800000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
023900000000 001?C                   Seton                                        99        POS CSR TO ERROR
024000000000X001?C                   Else                                                   ELSE
024100000000 001?C                   Setoff                                       99        POS CSR TO FIRST
024200000000E001?C                   Endif                                                  END IF ERROR
024300000000    ? *
024400000000    ? * Write message subfile
024500000000    ?C                   Seton                                        30        MSGSFL DISPLAY
024600000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
024700000000    ? *
024800000000    ? * Write entry panel
024900000000B001?C                   Select
025000000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
025100000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
025200000000 001?C                   Setoff                                       37        RESET CRSLOC
025300000000E001?C                   Endsl                                                  END SELECT
025400000000    ? *
025500000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
025600000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
025700000000E001?C                   Endif                                                  END IF DATA CHG
025800000000    ?C                   Endsr                                                  END DSPENT
025900000000    ? *___________________________________________________________________
026000000000    ? * Process function key
026100000000    ? *___________________________________________________________________
026200000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
026300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
026400991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
026500000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
026600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
026700000000    ?C                   Parm                    WAD                            FNC DESC
026800991108    ?C                   Parm                    WWIN                           AID BYTE
026900000000    ?C                   Parm                    WAF                            FNC KEY TABLE
027000000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
027100000000    ?C                   Endsr                                                  END PRCFKY
027200000000    ? *___________________________________________________________________
027300000000    ? * Process KEYS function
027400000000    ? *___________________________________________________________________
027500000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
027600000000    ?C                   Z-add     1             WW                             KEY DSC IDX
027700000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
027800000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
027900000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
028000000000 001? *
028100000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
028200000000 002?C                   Z-add     1             WWFKS                          SET TO 1
028300000000E002?C                   Endif                                                  END IF OVER 3
028400000000 001? *
028500000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
028600000000 001?C                   Sub       1             WW                             KEY DESCR IDX
028700000000E001?C                   Enddo                                                  END DO KEYS
028800000000    ? *
028900010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
029000010913    ?C                   Add       1             WW                             BUMP IDX
029100010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
029200010913    ?C                   Endsr                                                  END PRCDKY
029300000000    ? *___________________________________________________________________
029400000000    ? * Process EXIT Function
029500000000    ? *___________________________________________________________________
029600000000    ?C     PRCEXT        Begsr                                                  RETURN
029700000000    ? *
029800000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
029900000000    ? *
030000000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
030100000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
030200000000X001?C                   Else                                                   ELSE NO ERRORS
030300000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
030400000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
030500011024E001?C                   Endif                                                  END IF ERRORS
030600100610
030700000000    ?C                   Endsr                                                  END PRCEXT
030800000000    ? *___________________________________________________________________
030900000000    ? * Process PROMPT function
031000000000    ? *___________________________________________________________________
031100000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
031200000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
031300000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
031400000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
031500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
031600020920    ? *
031700000000B001?C                   Select                                                 SELECT
031800020923    ? *
031900130204 001 C                   When      WSFLD = 'XLPLAN '
032000130204 001?C                   Call      'SLCXRF  '                                   CALL SELECT PROGRAM
032100101220 001?C                   Parm                    WWRQS                          REQUEST
032200020923 001?C                   Parm                    WWRTN                          RETURN CODE
032300100610 001?C                   Parm                    WUPGM                          PROGRAM
032400020923B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
032500020923E001?C                   End
032600020923    ? *
032700000000 001?C                   Other                                                  WHERE ERROR
032800000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
032900000000 001?C                   Exsr      SNDMSG                                       SEND MSG
033000000000E001?C                   Endsl                                                  END SELECT
033100000000    ? *
033200000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
033300000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
033400000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
033500000000    ?C                   Mvr                     WSLIN                          CURSOR COL
033600000000    ?C                   Seton                                        37        SET ON CRSLOC
033700000000    ? *
033800000000    ?C                   Endsr                                                  END PRCPMT
033900000000    ? *___________________________________________________________________
034000000000    ? * Process CANCEL Function
034100000000    ? *___________________________________________________________________
034200000000    ?C     PRCCNL        Begsr                                                  CANCEL
034300000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
034400000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
034500000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
034600000000    ?C                   Endsr                                                  END RETURN
034700000000    ? *___________________________________________________________________
034800000000    ? * Process ROLLUP function
034900000000    ? *___________________________________________________________________
035000000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
035100000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
035200000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
035300000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
035400000000E001?C                   Endif                                                  END IF GT LST PNL
035500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
035600000000    ?C                   Endsr                                                  END PRCRUP
035700000000    ? *___________________________________________________________________
035800000000    ? * Process ROLLDOWN function
035900000000    ? *___________________________________________________________________
036000000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
036100000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
036200000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
036300000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
036400000000E001?C                   Endif                                                  END IF LT FST PNL
036500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
036600000000    ?C                   Endsr                                                  END PRCRDN
036700000000    ? *___________________________________________________________________
036800000000    ? * Process ENTER function
036900000000    ? *___________________________________________________________________
037000000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
037100000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
037200000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
037300101202    ? *
037400000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
037500000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
037600000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
037700130204 001?C                   Call      'CHKXRF  '                                   CHECK DATA
037800000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
037900000000 001?C                   Parm                    WWRTN                          RETURN CODE
038000000614 001?C                   Parm                    WUDTA                          REC DATA
038100000000E001?C                   Endif                                                  ENDIF
038200130204    ? *
038300130204     C     ACCKEY        Chain     ACCMST
038400130204     C                   If        %found(ACCMST)
038500130204     C                   Eval      WSNAME = %trim(ACNAM1)
038600130204     C                   Else
038700130204     C                   Eval      WSNAME = *Blanks
038800130204     C                   End
038900130204    ? *
039000130204     C     plnkey        Chain     PLNMST
039100130204     C                   Eval      webnote = #getnot(plncat:xltrst:xlsub#:
039200130204     C                                               xlacct:w80date:xlplan)
039300130204     C                   Eval      wsdesc = %trim(CNDSC)
039400130204     C     plnkeyx       Chain     PLNMST
039500130204     C                   Eval      webnote = #getnot(plncat:xltrst:xlsub#:
039600130204     C                                               xlacct:w80date:xlxpln)
039700130204     C                   Eval      wxdesc = %trim(CNDSC)
039800000000    ? *
039900000000B001?C                   Select                                                 PRC RETURN CDE
040000000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
040100000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
040200000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
040300000000 001? *
040400000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
040500000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
040600000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
040700000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
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
046800101220    ? *
046900130204    ?C                   Call      'UPDXRF  '                                   PROCESS REC IO
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
048500101220    ? *
048600130204    ?C                   Call      'UPDXRF  '                                   PROCESS REC IO
048700000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
048800000000    ?C                   Parm                    WWRTN                          RETURN CODE
048900000614    ?C                   Parm                    WUDTA                          REC DATA
049000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
049100000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
049200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
049300000000E001?C                   Endif                                                  END IF CALL ERROR
049400000000    ? *
049500000000    ?C                   Endsr                                                  END WRTCHG
049600011024    ? *___________________________________________________________________
049700011024    ? * Inz NO Key
049800011024    ? *___________________________________________________________________
049900011024    ?C     INZNKY        Begsr                                                  WRITE CHANGE
050000130204    ?C                   Call      'UPDXRF  '                                   PROCESS REC IO
050100011024    ?C                   Parm      'INZNKY'      WWRQS                          UPDATE RECORD
050200011024    ?C                   Parm                    WWRTN                          RETURN CODE
050300011024    ?C                   Parm                    WUDTA                          REC DATA
050400011024B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
050500011024 001?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
050600011024 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
050700011024E001?C                   Endif                                                  END IF CALL ERROR
050800011024    ? *
050900011024    ?C                   Endsr                                                  END WRTCHG
051000000000    ? *___________________________________________________________________
051100000000    ? * Release record
051200000000    ? *___________________________________________________________________
051300000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
051400130204    ?C                   Call      'UPDXRF  '                                   PROCESS REC IO
051500000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
051600000000    ?C                   Parm                    WWRTN                          RETURN CODE
051700000614    ?C                   Parm                    WUDTA                          REC DATA
051800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
051900000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
052000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
052100000000E001?C                   Endif                                                  END IF CALL ERROR
052200000000    ?C                   Endsr                                                  END RELREC
052300000000    ? *___________________________________________________________________
052400000000    ? * Build function keys
052500000000    ? *___________________________________________________________________
052600000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
052700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
052800991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
052900000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
053000000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
053100000000    ?C                   Parm                    WAD                            FNC DESC
053200991108    ?C                   Parm                    WWIN                           AID BYTE
053300000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
053400000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
053500010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
053600010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
053700010913    ?C                   Sub       1             WW                             BUMP IDX
053800010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
053900000000    ?C                   Endsr                                                  END BLD FNCTNS
054000000000    ? *___________________________________________________________________
054100000000    ? * Send message
054200000000    ? *___________________________________________________________________
054300000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
054400000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
054500000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
054600000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
054700000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
054800000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
054900000000    ?C                   Endsr                                                  END SNDMSG
055000000000    ? *___________________________________________________________________
055100000000    ? * Paremater list
055200000000    ? *___________________________________________________________________
055300000000    ?C     PLIST         Begsr                                                  PARM LISTS
055400000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
055500000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
055600000000    ?C                   Parm                    WORTN             8            RETURN CODE
055700000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
055800000614    ?C                   Parm                    WUDTA                          RECORD KEY
055900000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
056000000000    ?C                   Endsr                                                  END PLIST
056100000000    ? *___________________________________________________________________
056200000000    ? * Initialize routine
056300000000    ? *___________________________________________________________________
056400000000    ?C     *INZSR        Begsr                                                  INITIALIZE
056500130204     C     *date         Mult      10000.0001    w80date
056600000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
056700000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
056800000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
056900000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
057000000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
057100000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
057200000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
057300000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
057400000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
057500000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
057600000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
057700000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
057800000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
057900000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
058000000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
058100000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
058200000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
058300000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
058400000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
058500000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
058600000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
058700000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
058800000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
058900000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
059000000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
059100130204    ?C                   Movel     'WEBPLNXRFP'  WWFIL            10            FILE NAME-NOTES
059200000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
059300000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
059400130204    ?C     ACCKEY        Klist                                                  ACKCTL
059500130204    ?C                   Kfld                    XLTRST                         POSITION TO 1
059600130204    ?C                   Kfld                    XLSUB#                         POSITION TO 1
059700130204    ?C                   Kfld                    XLACCT                         POSITION TO 1
059800130204    ?C     PLNKEY        Klist                                                  ACKCTL
059900130204    ?C                   Kfld                    XLTRST                         POSITION TO 1
060000130204    ?C                   Kfld                    XLSUB#                         POSITION TO 1
060100130204    ?C                   Kfld                    XLPLAN                         POSITION TO 1
060200130204    ?C     PLNKEYx       Klist                                                  ACKCTL
060300130204    ?C                   Kfld                    XLTRST                         POSITION TO 1
060400130204    ?C                   Kfld                    XLSUB#                         POSITION TO 1
060500130204    ?C                   Kfld                    XLXPLN                         POSITION TO 1
060600000000    ?C                   Endsr                                                  END INITIALIZE
060700000000    ? *___________________________________________________________________
060800000000    ? * Program error handler
060900000000    ? *___________________________________________________________________
061000000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
061100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
061200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
061300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
061400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
061500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
061600000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
061700000000    ? *___________________________________________________________________
061800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06190000000003EXIT    F3=Exit
06200000000004PROMPT  F4=Prompt
06210003031305REFRESH F5=Refresh
06220000070710UPDATE  F10=Update
06230000061412CANCEL  F12=Cancel
06240000000025ROLLUP
06250000000026ROLLDOWN
062600000000** WTM
06270013020400Request not supported in program CHGXRF.
06280000000000Update error.  Data was not updated.
06290000000000Duplicate key detected.  Data was NOT added to file.
06300000000000Call to notes ended in error.
06310000000000Initialize error.  Record not initialized.
06320000000000Record not found.
06330000000000Generate error.  Key not generated.
06340000000000Record not available now.
06350000000000The cursor is not in a prompt area.
06360003031300Default error.  Data not defaulted.
06370010052000
