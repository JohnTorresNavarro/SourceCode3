000100110524     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200110524     H option(*SRCSTMT: *NODEBUGIO)
000300110524
000400000000    ? *_________________________________________________________________________
000500000000    ? *
000600110523    ? *  Description:  Change Benefit Amount
000700000000    ? *
000800110523    ? *  (c)Copyright 2011 by GBS, Inc.
000900000000    ? *_________________________________________________________________________
001000110523    ?FCHGDEDD   CF   E             WORKSTN
001100000000    ?F                                     INFDS(DSPD)
001200110523     FACCMST    IF   E           K DISK
001300110523     FMEMBER    IF   E           K DISK
001400110524
001500110524      * Prototypes
001600110524      /copy *libl/qmodsrc,#getdedpr
001700110524      /copy *libl/qmodsrc,#getclvlpr
001800110524      /copy *libl/qmodsrc,#chknhrpr
001900000000    ? *
002000110524
002100000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002200000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002300030313    ?D WTM             S             80    DIM(11) CTDATA PERRCD(1)             PANEL MESSAGES
002400100618     D WSDESC          S             20A
002500110524
002600110524     d CovLevel        s             25a   inz
002700110524     d NewHire         s              1s 0 inz
002800110524     d wwcov           s             20a   inz
002900110524     d w80date         s              8s 0 inz
003000000000    ? *_________________________________________________________________________
003100000406    ? * Data structure
003200110523    ?D WUDTA         E DS                  EXTNAME(WEBPAYARC)
003300110524     d payded        e ds                  extname(WEBPAYDS)
003400000000    ? *
003500000000    ? * Program status data structure
003600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003700000000    ? *
003800000000    ? * Display file data structure
003900991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
004000000000    ? *
004100000000    ? * CURSOR LOCATION
004200000000    ?D                 DS
004300000000    ?D  WWCRSL                 1      2
004400000000    ?D  WWCRSN                 1      2B 0
004500000000    ? *_________________________________________________________________________
004600000000    ? *
004700000614    ? * Process Entry Panel
004800000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
004900000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
005000000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
005100000000E001?C                   Endif                                                  END COPY/CPYKEY
005200000000    ? *
005300000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005400000000    ? *
005500000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005600000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005700000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
005800000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005900000000 001? *
006000000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
006100000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
006200000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
006300030313 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
006400000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006500000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
006600000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
006700000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
006800000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
006900000000 001?C                   Endcs                                                  END CASE
007000000000 001? *
007100000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
007200000000 002?C                   Exsr      PRCEND                                       PROCESS END
007300000000E002?C                   Endif                                                  END IF END REQ
007400000000E001?C                   Enddo                                                  END DOWHILE
007500000000    ? *
007600000707    ? * Send Info Updated message.
007700000707     C     WwChg         Ifeq      'Y'
007800000707     C                   Movel     'UPDATE  '    WORTN
007900000707     C                   Endif
008000000707    ? *
008100000000    ?C                   Return                                                 RETURN
008200000000    ? *___________________________________________________________________
008300000000    ? * Prepare panel
008400000000    ? *___________________________________________________________________
008500000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008600000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
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
010400100520    ? *
010500110523     C     KEYACC        Klist
010600110523     C                   kfld                    PQTRS
010700110523     C                   kfld                    PQSUB
010800110523     C                   kfld                    PQACT
010900110523
011000110523     C     KEYACC        Chain     ACCMST
011100110523     C                   if        %found(ACCMST)
011200110523     C                   Eval      WSANAM = %trim(ACNAM1)
011300110523     C                   Else
011400110523     C                   Eval      WSANAM = *BLANKS
011500110523     C                   End
011600110523
011700110523     C     PQSSN         Chain     MEMBER
011800110523     C                   If        %found(MEMBER)
011900110523     C                   If        %trim(MMI) = *blanks
012000110523     C                   Eval      WSMNAM = %trim(MFNAME) + ' ' +
012100110523     C                             %trim(MLNAME)
012200110523     C                   Else
012300110523     C                   Eval      WSMNAM = %trim(MFNAME) + ' ' +
012400110523     C                             %trim(MMI) + ' ' + %trim(MLNAME)
012500110523     C                   End
012600110523     C                   Else
012700110523     C                   Eval      WSMNAM = *Blanks
012800110523     C                   End
012900110523     C     PQSTART       Mult      10000.0001    PQSTART
013000100617    ? *
013100000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
013200000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
013300000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
013400000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
013500000000    ?C                   Cas                     PRCERR                         PROC ERROR
013600000000    ?C                   Endcs                                                  END CASE
013700000000    ? *
013800000000    ?C                   Endsr                                                  END PRPPNL
013900000000    ? *___________________________________________________________________
014000000000    ? * Prepare ADD request
014100000000    ? *___________________________________________________________________
014200000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
014300000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
014400110523     C                   Clear                   WSANAM
014500110523     C                   Clear                   WSMNAM
014600000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
014700000000    ?C                   Endsr                                                  END PRP ADD
014800000000    ? *___________________________________________________________________
014900000000    ? * Prepare CHANGE request
015000000000    ? *___________________________________________________________________
015100000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
015200110523    ?C                   Call      'UPDDED  '                                   PROCESS REC IO
015300000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
015400000000    ?C                   Parm                    WWRTN                          RETURN CODE
015500000614    ?C                   Parm                    WUDTA                          REC DATA
015600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015700000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
015800000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
015900000000X002?C                   Else                                                   ELSE
016000000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
016100000000E002?C                   Endif                                                  END RCD NOT AVL
016200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016500000810E001?C                   Endif                                                  END IF ERROR
016600000000    ?C                   Endsr                                                  END PRP CHANGE
016700000000    ? *___________________________________________________________________
016800000000    ? * Prepare COPY request
016900000000    ? *___________________________________________________________________
017000000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
017100000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
017200110523    ?C                   Call      'UPDDED  '                                   PROCESS REC IO
017300000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
017400000000    ?C                   Parm                    WWRTN                          RETURN CODE
017500000614    ?C                   Parm                    WUDTA                          REC DATA
017600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
017700000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
017800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
017900000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018000000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
018100000000X001?C                   Else                                                   ELSE
018200000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
018300110523     C     PQSTART       Mult      10000.0001    PQSTART
018400000000E001?C                   Endif                                                  END IF ERROR
018500000000    ?C                   Endsr                                                  END PREP COPY
018600000000    ? *___________________________________________________________________
018700000000    ? * Default Data
018800000000    ? *___________________________________________________________________
018900000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
019000110523    ?C                   Call      'CHKDED  '                                   PROCESS REC IO
019100000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
019200000000    ?C                   Parm                    WWRTN                          RETURN CODE
019300000614    ?C                   Parm                    WUDTA                          REC DATA
019400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
019500000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
019600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
019700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019800000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
019900000000E001?C                   Endif                                                  END IF ERROR
020000000000    ?C                   Endsr                                                  END DFTDTA
020100000000    ? *___________________________________________________________________
020200000000    ? * Process ERROR function
020300000000    ? *___________________________________________________________________
020400000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
020500000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
020600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
020700000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
020800000000    ?C                   Move      'END'         WWSTT                          END STATE
020900000000    ?C                   Endsr                                                  END PRCERR
021000000000    ? *___________________________________________________________________
021100000000    ? * Receive messages
021200000000    ? *___________________________________________________________________
021300000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
021400000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
021500000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
021600000000X001?C                   Else                                                   ELSE
021700000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
021800000000E001?C                   Endif                                                  ENDIF NOT NORESET
021900000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
022000000000    ?C                   Movea     *IN           WWIN                           INDICATORS
022100000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
022200000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
022300000000    ?C                   Parm                    WWIN                           INDICATORS
022400000000    ?C                   Parm                    WWRTN                          RETURN CODE
022500000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
022600000000    ?C                   Endsr                                                  END RCV MSG
022700000000    ? *___________________________________________________________________
022800000000    ? * Display panels
022900000000    ? *___________________________________________________________________
023000000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
023100000000    ? *
023200000000    ? * Set PUTOVR based on last display file processed
023300000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
023400000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
023500000000 001?C                   Setoff                                       35        PUTOVR OFF
023600000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
023700000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
023800000000X001?C                   Else                                                   ELSE SAME PGM
023900000000 001?C                   Seton                                        35        PUTOVR ON
024000000000E001?C                   Endif                                                  END IF NEW PGM
024100000000    ? *
024200000614    ? * Set PROTECT key based on request
024300000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
024400000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
024500110524 001?C**** WWTSK         Oreq      'COPY  '                                     OR COPY
024600000000 001?C                   Setoff                                       40        NO PROTECT KEY
024700000000X001?C                   Else                                                   ELSE
024800000000 001?C                   Seton                                        40        PROTECT KEY
024900000000E001?C                   Endif                                                  END IF ADD
025000000000    ? *
025100000000    ? * Select title
025200000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
025300000000 001?C                   Setoff                                       38        CHANGE TITLE
025400000000X001?C                   Else                                                   ELSE
025500000000 001?C                   Seton                                        38        ADD TITLE
025600000000E001?C                   Endif                                                  END IF CHANGE
025700000000    ? *
025800000000    ? * Position cursor based on error status
025900000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
026000000000 001?C                   Seton                                        99        POS CSR TO ERROR
026100000000X001?C                   Else                                                   ELSE
026200000000 001?C                   Setoff                                       99        POS CSR TO FIRST
026300000000E001?C                   Endif                                                  END IF ERROR
026400000000    ? *
026500000000    ? * Write message subfile
026600000000    ?C                   Seton                                        30        MSGSFL DISPLAY
026700000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
026800000000    ? *
026900000000    ? * Write entry panel
027000000000B001?C                   Select
027100000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
027200000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
027300000000 001?C                   Setoff                                       37        RESET CRSLOC
027400000000E001?C                   Endsl                                                  END SELECT
027500000000    ? *
027600000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
027700000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
027800000000E001?C                   Endif                                                  END IF DATA CHG
027900000000    ?C                   Endsr                                                  END DSPENT
028000000000    ? *___________________________________________________________________
028100000000    ? * Process function key
028200000000    ? *___________________________________________________________________
028300000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
028400991108    ?C                   Movea     *IN           WWIN                           INDICATORS
028500991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
028600000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
028700000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
028800000000    ?C                   Parm                    WAD                            FNC DESC
028900991108    ?C                   Parm                    WWIN                           AID BYTE
029000000000    ?C                   Parm                    WAF                            FNC KEY TABLE
029100000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
029200000000    ?C                   Endsr                                                  END PRCFKY
029300000000    ? *___________________________________________________________________
029400000000    ? * Process KEYS function
029500000000    ? *___________________________________________________________________
029600000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
029700000000    ?C                   Z-add     1             WW                             KEY DSC IDX
029800000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
029900000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
030000000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
030100000000 001? *
030200000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
030300000000 002?C                   Z-add     1             WWFKS                          SET TO 1
030400000000E002?C                   Endif                                                  END IF OVER 3
030500000000 001? *
030600000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
030700000000 001?C                   Sub       1             WW                             KEY DESCR IDX
030800000000E001?C                   Enddo                                                  END DO KEYS
030900000000    ? *
031000010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
031100010913    ?C                   Add       1             WW                             BUMP IDX
031200010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
031300010913    ?C                   Endsr                                                  END PRCDKY
031400000000    ? *___________________________________________________________________
031500000000    ? * Process EXIT Function
031600000000    ? *___________________________________________________________________
031700000000    ?C     PRCEXT        Begsr                                                  RETURN
031800000000    ? *
031900000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
032000000000    ? *
032100000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
032200000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
032300000000X001?C                   Else                                                   ELSE NO ERRORS
032400000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
032500000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
032600011024E001?C                   Endif                                                  END IF ERRORS
032700100610
032800000000    ?C                   Endsr                                                  END PRCEXT
032900000000    ? *___________________________________________________________________
033000000000    ? * Process PROMPT function
033100000000    ? *___________________________________________________________________
033200000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
033300000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
033400000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
033500000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
033600000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
033700020920    ? *
033800000000B001?C                   Select                                                 SELECT
033900020923    ? *
034000020923    ? *
034100000000 001?C                   Other                                                  WHERE ERROR
034200000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
034300000000 001?C                   Exsr      SNDMSG                                       SEND MSG
034400000000E001?C                   Endsl                                                  END SELECT
034500000000    ? *
034600000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
034700000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
034800000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
034900000000    ?C                   Mvr                     WSLIN                          CURSOR COL
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
039000110523 001?C                   Call      'CHKDED  '                                   CHECK DATA
039100000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
039200000000 001?C                   Parm                    WWRTN                          RETURN CODE
039300000614 001?C                   Parm                    WUDTA                          REC DATA
039400000000E001?C                   Endif                                                  ENDIF
039500100521    ? *
039600110523     C     KEYACC        Chain     ACCMST
039700110523     C                   if        %found(ACCMST)
039800110523     C                   Eval      WSANAM = %trim(ACNAM1)
039900110523     C                   Else
040000110523     C                   Eval      WSANAM = *BLANKS
040100110523     C                   End
040200110523
040300110523     C     PQSSN         Chain     MEMBER
040400110523     C                   If        %found(MEMBER)
040500110523     C                   If        %trim(MMI) = *blanks
040600110523     C                   Eval      WSMNAM = %trim(MFNAME) + ' ' +
040700110523     C                             %trim(MLNAME)
040800110523     C                   Else
040900110523     C                   Eval      WSMNAM = %trim(MFNAME) + ' ' +
041000110523     C                             %trim(MMI) + ' ' + %trim(MLNAME)
041100110523     C                   End
041200110523     C                   Else
041300110523     C                   Eval      WSMNAM = *Blanks
041400110523     C                   End
041500110523     C**** PQSTART       Mult      10000.0001    PQSTART
041600000000    ? *
041700000000B001?C                   Select                                                 PRC RETURN CDE
041800000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
041900000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
042000110524     C************       Exsr      RECALC
042100000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
042200000000 001? *
042300000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
042400000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
042500000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
042600000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
042700000000X002?C                   Else                                                   ELSE
042800000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
042900000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
043000000000E002?C                   Endif                                                  IF WARNING
043100000000 001? *
043200000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
043300000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
043400000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
043500000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
043600000000E001?C                   Endsl                                                  RETURN CODE SEL
043700000000    ? *
043800000000    ?C                   Endsr                                                  END PRCPNL
043900110524    ? *___________________________________________________________________
044000110524    ? * Recalculate Deductions
044100110524    ? *___________________________________________________________________
044200110524    ?C     RECALC        Begsr                                                  ERROR
044300110524     C     pqstart       Mult      10000.0001    w80date
044400110524      * Get Coverage Level
044500110524     C                   Eval      CovLevel = #getclvl(pqtrs:pqsub:pqact:
044600110524     C                                        pqssn:pqpln:pqcat)
044700110524     C                   Eval      wwcov = %trim(CovLevel)
044800110524
044900110524      * Recalculate Deductions
045000110524     C                   Eval      PayDed = #getded(pqtrs:pqsub:pqact:
045100110524     C                                        pqssn:pqseq:pqpln:pqcat:
045200160418     C                                        wwcov:w80date:0:'')
045300110524
045400110524      * Update Deductions
045500110524     C                   Eval      pqdamt = dsdamt
045600110524    ?C                   Endsr                                                  END ERROR
045700000000    ? *___________________________________________________________________
045800000000    ? * Process end - write data or release record
045900000000    ? *___________________________________________________________________
046000000000    ?C     PRCEND        Begsr                                                  PROCESS END
046100000000    ? *
046200000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
046300000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
046400000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
046500000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
046600000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
046700000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
046800000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
046900000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
047000000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
047100000000 001?C                   Endcs                                                  END CASE
047200000000 001? *
047300000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
047400000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
047500000000 002? *
047600000000X002?C                   Else                                                   ELSE NO WRT ERR
047700000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
047800000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
047900000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
048000000000 004?C                   Exsr      PRPPNL                                       DO NOT END
048100000810E004?C                   Endif                                                  END IF ADD
048200000000E003?C                   Endif                                                  END IF NOT END
048300000000E002?C                   Endif                                                  END IF WRITE ERROR
048400000000 001? *
048500000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
048600000000 001?C                   Exsr      RELREC                                       RELEASE REC
048700000000E001?C                   Endif                                                  END IF RCD CHANGED
048800000000    ? *
048900000000    ?C                   Endsr                                                  END PRCEND
049000000000    ? *___________________________________________________________________
049100000000    ? * Add new record
049200000000    ? *___________________________________________________________________
049300000000    ?C     WRTADD        Begsr                                                  WRITE ADD
049400000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
049500000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
049600000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
049700000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
049800000000E001?C                   Endif                                                  END IF ADD
049900000000    ? *
050000000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
050100000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
050200000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
050300000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
050400000000E001?C                   Endif                                                  END IF ADD KEY
050500000000    ? *
050600110523    ?C                   Call      'UPDDED  '                                   PROCESS REC IO
050700000000    ?C                   Parm                    WWRQS                          ADD RECORD
050800000000    ?C                   Parm                    WWRTN                          RETURN CODE
050900000614    ?C                   Parm                    WUDTA                          REC DATA
051000000000    ? *
051100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
051200000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
051300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
051400000000X001?C                   Else                                                   ELSE
051500000000E001?C                   Endif                                                  END IF CALL ERROR
051600000000    ? *
051700000000    ?C                   Endsr                                                  END WRTADD
051800000000    ? *___________________________________________________________________
051900000000    ? * Write changed record
052000000000    ? *___________________________________________________________________
052100000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
052200110523    ?C                   Call      'UPDDED  '                                   PROCESS REC IO
052300000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
052400000000    ?C                   Parm                    WWRTN                          RETURN CODE
052500000614    ?C                   Parm                    WUDTA                          REC DATA
052600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
052700000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
052800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
052900000000E001?C                   Endif                                                  END IF CALL ERROR
053000000000    ? *
053100000000    ?C                   Endsr                                                  END WRTCHG
053200011024    ? *___________________________________________________________________
053300011024    ? * Inz NO Key
053400011024    ? *___________________________________________________________________
053500011024    ?C     INZNKY        Begsr                                                  WRITE CHANGE
053600110523    ?C                   Call      'UPDDED  '                                   PROCESS REC IO
053700011024    ?C                   Parm      'INZNKY'      WWRQS                          UPDATE RECORD
053800011024    ?C                   Parm                    WWRTN                          RETURN CODE
053900011024    ?C                   Parm                    WUDTA                          REC DATA
054000011024B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
054100011024 001?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
054200011024 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
054300011024E001?C                   Endif                                                  END IF CALL ERROR
054400011024    ? *
054500011024    ?C                   Endsr                                                  END WRTCHG
054600000000    ? *___________________________________________________________________
054700000000    ? * Release record
054800000000    ? *___________________________________________________________________
054900000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
055000110523    ?C                   Call      'UPDDED  '                                   PROCESS REC IO
055100000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
055200000000    ?C                   Parm                    WWRTN                          RETURN CODE
055300000614    ?C                   Parm                    WUDTA                          REC DATA
055400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
055500000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
055600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
055700000000E001?C                   Endif                                                  END IF CALL ERROR
055800000000    ?C                   Endsr                                                  END RELREC
055900000000    ? *___________________________________________________________________
056000000000    ? * Build function keys
056100000000    ? *___________________________________________________________________
056200000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
056300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
056400991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
056500000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
056600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
056700000000    ?C                   Parm                    WAD                            FNC DESC
056800991108    ?C                   Parm                    WWIN                           AID BYTE
056900000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
057000000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
057100010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
057200010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
057300010913    ?C                   Sub       1             WW                             BUMP IDX
057400010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
057500000000    ?C                   Endsr                                                  END BLD FNCTNS
057600000000    ? *___________________________________________________________________
057700000000    ? * Send message
057800000000    ? *___________________________________________________________________
057900000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
058000000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
058100000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
058200000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
058300000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
058400000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
058500000000    ?C                   Endsr                                                  END SNDMSG
058600000000    ? *___________________________________________________________________
058700000000    ? * Paremater list
058800000000    ? *___________________________________________________________________
058900000000    ?C     PLIST         Begsr                                                  PARM LISTS
059000000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
059100000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
059200000000    ?C                   Parm                    WORTN             8            RETURN CODE
059300000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
059400000614    ?C                   Parm                    WUDTA                          RECORD KEY
059500000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
059600000000    ?C                   Endsr                                                  END PLIST
059700000000    ? *___________________________________________________________________
059800000000    ? * Initialize routine
059900000000    ? *___________________________________________________________________
060000000000    ?C     *INZSR        Begsr                                                  INITIALIZE
060100000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
060200000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
060300000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
060400000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
060500000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
060600000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
060700000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
060800000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
060900000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
061000000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
061100000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
061200000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
061300000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
061400000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
061500000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
061600000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
061700000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
061800000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
061900000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
062000000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
062100000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
062200000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
062300000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
062400000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
062500000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
062600110523    ?C                   Movel     'WEBPAYDED'   WWFIL            10            FILE NAME-NOTES
062700000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
062800000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
062900000000    ?C                   Endsr                                                  END INITIALIZE
063000000000    ? *___________________________________________________________________
063100000000    ? * Program error handler
063200000000    ? *___________________________________________________________________
063300000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
063400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
063500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
063600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
063700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
063800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
063900000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
064000000000    ? *___________________________________________________________________
064100000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06420000000003EXIT    F3=Exit
06430000000004PROMPT  F4=Prompt
06440003031305REFRESH F5=Refresh
06450011052310UPDATE  F10=Create Deduction
06460000061412CANCEL  F12=Cancel
06470000000025ROLLUP
06480000000026ROLLDOWN
064900000000** WTM
06500011052300Request not supported in program CHGDED.
06510000000000Update error.  Data was not updated.
06520000000000Duplicate key detected.  Data was NOT added to file.
06530000000000Call to notes ended in error.
06540000000000Initialize error.  Record not initialized.
06550000000000Record not found.
06560000000000Generate error.  Key not generated.
06570000000000Record not available now.
06580000000000The cursor is not in a prompt area.
06590003031300Default error.  Data not defaulted.
06600010052000
