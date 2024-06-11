000100101110     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200101110     H option(*SRCSTMT: *NODEBUGIO)
000300000000    ? *_________________________________________________________________________
000400101110    ? *
000500101110    ? * DSPF RSTDSP(*YES)
000600000000    ? *
000700100826    ? *  Description:  Change Ancillary Product Formulas - Validate Formula
000800000000    ? *
000900100506    ? *  (c)Copyright 2010 by GBS,Inc.
001000051028    ? *
001100051028    ? *_________________________________________________________________________
001200100826    ?FCHGANC0D  CF   E             WORKSTN
001300000000    ?F                                     INFDS(DSPD)
001400100506     FTRSMST    IF   E           K DISK
001500100506     FSUBMST    IF   E           K DISK
001600100506     FPLNMST    IF   E           K DISK
001700101110     FCARMST    IF   E           K DISK
001800101110     FWEBPAYVAL UF A E             DISK
001900101110    ? *
002000101110      * Prototypes
002100101110      /COPY *LIBL/QMODSRC,#GETDEDPR
002200000000    ? *
002300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002500101230    ?D WTM             S             80    DIM(14) CTDATA PERRCD(1)             PANEL MESSAGES
002600000000    ? *_________________________________________________________________________
002700000406    ? * Data structure
002800100817    ?D WUDTA         E DS                  EXTNAME(PAYDEDANP)
002900100526    ?D WDCLS         E DS                  EXTNAME(WEBPAYCHP)
003000101020    ?D WCDTA         E DS                  EXTNAME(WEBPAY0DS) INZ
003100101110    ?D WGDTA         E DS                  EXTNAME(WEBPAYDS) INZ
003200000000    ? *
003300000000    ? * Program status data structure
003400991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003500000000    ? *
003600000000    ? * Display file data structure
003700991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003800000000    ? *
003900000000    ? * CURSOR LOCATION
004000000000    ?D                 DS
004100000000    ?D  WWCRSL                 1      2
004200000000    ?D  WWCRSN                 1      2B 0
004300100506    ? *
004400100817     D WWTRST          S                   LIKE(PATRST)
004500100817     D WWSUB#          S                   LIKE(PASUB#)
004600101110     D WWACCT          S                   LIKE(PAPLAN)
004700101110     D TODAY           S              8S 0 inz
004800000000    ? *_________________________________________________________________________
004900000000    ? *
005000000614    ? * Process Entry Panel
005100000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
005200000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
005300000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
005400000000E001?C                   Endif                                                  END COPY/CPYKEY
005500000000    ? *
005600000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005700000000    ? *
005800000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005900000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
006000000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
006100000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
006200000000 001? *
006300000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
006400000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
006500000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
006600000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
006700000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006800000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
006900000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
007000101110 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
007100101110 001?C***  WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
007200000000 001?C                   Endcs                                                  END CASE
007300000000 001? *
007400000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
007500000000 002?C                   Exsr      PRCEND                                       PROCESS END
007600000000E002?C                   Endif                                                  END IF END REQ
007700000000E001?C                   Enddo                                                  END DOWHILE
007800000000    ? *
007900000707    ? * Send Info Updated message.
008000000707     C     WwChg         Ifeq      'Y'
008100000707     C                   Movel     'UPDATE  '    WORTN
008200000707     C                   Endif
008300000707    ? *
008400000000    ?C                   Return                                                 RETURN
008500000000    ? *___________________________________________________________________
008600000000    ? * Prepare panel
008700000000    ? *___________________________________________________________________
008800000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008900000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
009000050317    ?C                   Move      *ZEROS        WSBEDT                         RETURN CODE
009100050317    ?C                   Move      *ZEROS        WSENDT                         RETURN CODE
009200991108    ?C                   Move      'N'           WWERR                          NO ERRORS
009300000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
009400000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
009500000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
009600000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
009700000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
009800000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
009900000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
010000000000    ? *
010100000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
010200000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
010300000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
010400000000E002?C                   Endif                                                  ENDIF SAME REQUEST
010500000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
010600000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
010700050318      *
010800100826     C                   Eval      WSRULE = PARULE
010900101110     C                   Eval      WSFORM = PAFORM
011000101110     C                   Eval      WSWAIT = PAWAIT
011100101110     C                   Eval      WSFREQ = PAPYFR
011200101110     C                   Eval      WSPRCD = PAPCMT
011300101110     C                   Eval      WSDEDC = PAPDCD
011400100817     C                   Movel     PATRST        Trst              3
011500100817     C                   Movel     PASUB#        Sub#              3
011600100817     C                   Movel     PAPLAN        Plan              4
011700100817     C     PATRST        Chain     TRSMST
011800100506     C     SKey          Chain     SUBMST
011900100506     C     PKey          Chain     PLNMST
012000100506     C     PCARR         Chain     CARMST
012100100506     C                   If        %Found(PLNMST)
012200100506     C                   Eval      WWTRSD = %Trim(Trst  + ' ' + %Trim(TNAME))
012300100506     C                   Eval      WWSUBD = %Trim(Sub#  + ' ' + %Trim(SUBNAM))
012400100506     C                   Eval      WWPLND = %Trim(Plan  + ' ' + %Trim(PDESCR))
012500100506     C                   Eval      WWCARD = %Trim(PCARR + ' ' + %Trim(CNAME))
012600050318     C                   End
012700101110     C     *DATE         Mult      10000.0001    Today
012800101111    ? *
012900101112    ? * Birth Date not required
013000101111    ?C                   If        %subst(%trim(PAFORM):1:3) = 'STD' or
013100101111    ?C                             %subst(%trim(PAFORM):1:3) = 'LTD'
013200101111     C                   Eval      *in69 = *on
013300101111     C                   Eval      *in68 = *on
013400101111     C                   Else
013500101111     C                   Eval      *in69 = *off
013600101111     C                   Eval      *in68 = *off
013700101111     C                   End
013800101112    ? *
013900101112    ? * Enter Spouse Birth Date
014000101112     C                   If        %trim(PLNCAT) = 'PSP'
014100101112     C                   Eval      *in67 = *on
014200101112     C                   Else
014300101112     C                   Eval      *in67 = *off
014400101112     C                   End
014500000000    ? *
014600000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
014700000000    ? *
014800000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
014900000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
015000000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
015100000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
015200000000    ?C                   Cas                     PRCERR                         PROC ERROR
015300000000    ?C                   Endcs                                                  END CASE
015400000000    ? *
015500000000    ?C                   Endsr                                                  END PRPPNL
015600000000    ? *___________________________________________________________________
015700000000    ? * Prepare ADD request
015800000000    ? *___________________________________________________________________
015900000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
016000100817    ?C                   Clear                   PAFIXA                         CLEAR RECORD
016100100817    ?C                   Clear                   PAPPBE                         CLEAR RECORD
016200000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
016300000000    ?C                   Endsr                                                  END PRP ADD
016400000000    ? *___________________________________________________________________
016500000000    ? * Prepare CHANGE request
016600000000    ? *___________________________________________________________________
016700000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
016800100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
016900000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
017000000000    ?C                   Parm                    WWRTN                          RETURN CODE
017100000614    ?C                   Parm                    WUDTA                          REC DATA
017200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
017300000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
017400000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
017500000000X002?C                   Else                                                   ELSE
017600000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
017700000000E002?C                   Endif                                                  END RCD NOT AVL
017800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
017900000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018000000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
018100000810E001?C                   Else                                                   END IF ERROR
018200100817     C     PABEDT        MULT      10000.0001    WSBEDT
018300100817     C     PAENDT        MULT      10000.0001    WSENDT
018400000810E001?C                   Endif                                                  END IF ERROR
018500000000    ?C                   Endsr                                                  END PRP CHANGE
018600000000    ? *___________________________________________________________________
018700000000    ? * Prepare COPY request
018800000000    ? *___________________________________________________________________
018900000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
019000000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
019100100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
019200000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
019300000000    ?C                   Parm                    WWRTN                          RETURN CODE
019400000614    ?C                   Parm                    WUDTA                          REC DATA
019500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
019600000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
019700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
019800000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019900000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
020000000000X001?C                   Else                                                   ELSE
020100000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
020200100817     C     PABEDT        MULT      10000.0001    WSBEDT
020300100817     C     PAENDT        MULT      10000.0001    WSENDT
020400000000E001?C                   Endif                                                  END IF ERROR
020500000000    ?C                   Endsr                                                  END PREP COPY
020600000000    ? *___________________________________________________________________
020700000000    ? * Default Data
020800000000    ? *___________________________________________________________________
020900000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
021000101110    ?C***                Call      'CHKANC0 '                                   PROCESS REC IO
021100101110    ?C***                Parm      'DFTDTA'      WWRQS                          GENERATE KEY
021200101110    ?C***                Parm                    WWRTN                          RETURN CODE
021300101110    ?C***                Parm                    WCDTA                          REC DATA
021400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
021500000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
021600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
021700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
021800000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
021900000000E001?C                   Endif                                                  END IF ERROR
022000000000    ?C                   Endsr                                                  END DFTDTA
022100000000    ? *___________________________________________________________________
022200000000    ? * Process ERROR function
022300000000    ? *___________________________________________________________________
022400000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
022500000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
022600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
022700000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
022800000000    ?C                   Move      'END'         WWSTT                          END STATE
022900000000    ?C                   Endsr                                                  END PRCERR
023000000000    ? *___________________________________________________________________
023100000000    ? * Receive messages
023200000000    ? *___________________________________________________________________
023300000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
023400000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
023500000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
023600000000X001?C                   Else                                                   ELSE
023700000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
023800000000E001?C                   Endif                                                  ENDIF NOT NORESET
023900000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
024000000000    ?C                   Movea     *IN           WWIN                           INDICATORS
024100000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
024200000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
024300000000    ?C                   Parm                    WWIN                           INDICATORS
024400000000    ?C                   Parm                    WWRTN                          RETURN CODE
024500000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
024600000000    ?C                   Endsr                                                  END RCV MSG
024700000000    ? *___________________________________________________________________
024800000000    ? * Display panels
024900000000    ? *___________________________________________________________________
025000000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
025100000000    ? *
025200000000    ? * Set PUTOVR based on last display file processed
025300000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
025400000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
025500000000 001?C                   Setoff                                       35        PUTOVR OFF
025600000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
025700000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
025800000000X001?C                   Else                                                   ELSE SAME PGM
025900000000 001?C                   Seton                                        35        PUTOVR ON
026000000000E001?C                   Endif                                                  END IF NEW PGM
026100000000    ? *
026200000614    ? * Set PROTECT key based on request
026300000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
026400000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
026500000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
026600000000 001?C                   Setoff                                       40        NO PROTECT KEY
026700000000X001?C                   Else                                                   ELSE
026800000000 001?C                   Seton                                        40        PROTECT KEY
026900000000E001?C                   Endif                                                  END IF ADD
027000000000    ? *
027100000000    ? * Select title
027200000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
027300000000 001?C                   Setoff                                       38        CHANGE TITLE
027400000000X001?C                   Else                                                   ELSE
027500000000 001?C                   Seton                                        38        ADD TITLE
027600000000E001?C                   Endif                                                  END IF CHANGE
027700000000    ? *
027800000000    ? * Position cursor based on error status
027900000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
028000000000 001?C                   Seton                                        99        POS CSR TO ERROR
028100000000X001?C                   Else                                                   ELSE
028200000000 001?C                   Setoff                                       99        POS CSR TO FIRST
028300000000E001?C                   Endif                                                  END IF ERROR
028400000000    ? *
028500000000    ? * Write message subfile
028600000000    ?C                   Seton                                        30        MSGSFL DISPLAY
028700000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
028800000000    ? *
028900000000    ? * Write entry panel
029000000000B001?C                   Select
029100000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
029200000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
029300000000 001?C                   Setoff                                       37        RESET CRSLOC
029400000000E001?C                   Endsl                                                  END SELECT
029500000000    ? *
029600000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
029700000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
029800000000E001?C                   Endif                                                  END IF DATA CHG
029900000000    ?C                   Endsr                                                  END DSPENT
030000000000    ? *___________________________________________________________________
030100000000    ? * Process function key
030200000000    ? *___________________________________________________________________
030300000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
030400991108    ?C                   Movea     *IN           WWIN                           INDICATORS
030500991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
030600000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
030700000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
030800000000    ?C                   Parm                    WAD                            FNC DESC
030900991108    ?C                   Parm                    WWIN                           AID BYTE
031000000000    ?C                   Parm                    WAF                            FNC KEY TABLE
031100000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
031200000000    ?C                   Endsr                                                  END PRCFKY
031300000000    ? *___________________________________________________________________
031400000000    ? * Process KEYS function
031500000000    ? *___________________________________________________________________
031600000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
031700000000    ?C                   Z-add     1             WW                             KEY DSC IDX
031800000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
031900000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
032000000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
032100000000 001? *
032200000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
032300000000 002?C                   Z-add     1             WWFKS                          SET TO 1
032400000000E002?C                   Endif                                                  END IF OVER 3
032500000000 001? *
032600000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
032700000000 001?C                   Sub       1             WW                             KEY DESCR IDX
032800000000E001?C                   Enddo                                                  END DO KEYS
032900000000    ? *
033000000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
033100000000    ?C                   Add       1             WW                             BUMP IDX
033200000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
033300000000    ?C                   Endsr                                                  END PRCDKY
033400000000    ? *___________________________________________________________________
033500000000    ? * Process EXIT Function
033600000000    ? *___________________________________________________________________
033700000000    ?C     PRCEXT        Begsr                                                  RETURN
033800000000    ? *
033900101110    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
034000000000    ? *
034100000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
034200000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
034300000000X001?C                   Else                                                   ELSE NO ERRORS
034400000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
034500000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
034600000000E001?C                   Endif                                                  END IF ERRORS
034700000000    ?C                   Endsr                                                  END PRCEXT
034800000000    ? *___________________________________________________________________
034900000000    ? * Process PROMPT function
035000000000    ? *___________________________________________________________________
035100000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
035200000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
035300000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
035400000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
035500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
035600100817    ? *
035700100817    ? *
035800100817    ? * HERE
035900100817    ? *
036000100526    ? *
036100000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
036200000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
036300000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
036400000000    ?C                   Mvr                     WSLIN                          CURSOR COL
036500000000    ?C                   Seton                                        37        SET ON CRSLOC
036600000000    ? *
036700000000    ?C                   Endsr                                                  END PRCPMT
036800000000    ? *___________________________________________________________________
036900000000    ? * Process CANCEL Function
037000000000    ? *___________________________________________________________________
037100000000    ?C     PRCCNL        Begsr                                                  CANCEL
037200000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
037300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
037400000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
037500000000    ?C                   Endsr                                                  END RETURN
037600000000    ? *___________________________________________________________________
037700000000    ? * Process ROLLUP function
037800000000    ? *___________________________________________________________________
037900000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
038000000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
038100000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
038200000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
038300000000E001?C                   Endif                                                  END IF GT LST PNL
038400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
038500000000    ?C                   Endsr                                                  END PRCRUP
038600000000    ? *___________________________________________________________________
038700000000    ? * Process ROLLDOWN function
038800000000    ? *___________________________________________________________________
038900000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
039000000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
039100000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
039200000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
039300000000E001?C                   Endif                                                  END IF LT FST PNL
039400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
039500000000    ?C                   Endsr                                                  END PRCRDN
039600101109    ? *___________________________________________________________________
039700101109    ? * Process ENTER function
039800101109    ? *___________________________________________________________________
039900101110    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
040000101111    ?C                   Move      *BLANKS       WORTN                          RESET RETURN
040100101110    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
040200101110    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
040300101112    ? *
040400101112    ? * Birth Date not required
040500101111     C                   If        %subst(%trim(PAFORM):1:3) = 'STD' or
040600101111     C                             %subst(%trim(PAFORM):1:3) = 'LTD'
040700101111     C                   Eval      *in69 = *on
040800101111     C                   Eval      *in68 = *on
040900101111     C                   Eval      WSBIRTH = 07301963
041000101111     C                   Else
041100101111     C                   Eval      *in69 = *off
041200101111     C                   Eval      *in68 = *off
041300101111     C                   End
041400101112    ? *
041500101112    ? * Enter Spouse Birth Date
041600101112     C                   If        %trim(PLNCAT) = 'PSP'
041700101112     C                   Eval      *in67 = *on
041800101112     C                   Else
041900101112     C                   Eval      *in67 = *off
042000101112     C                   End
042100101111    ? *
042200101111     C                   If        WSSALY = *Zeros
042300101111    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
042400101111    ?C                   Move      WTM(12)       WWMSG                          PASS MSG
042500101111    ?C                   Exsr      SNDMSG                                       SEND MSG
042600101111     C                   End
042700101111    ? *
042800101111     C                   If        *in69 = *off      and
042900101111     C                             WSBENA = *Zeros
043000101111    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
043100101111    ?C                   Move      WTM(13)       WWMSG                          PASS MSG
043200101111    ?C                   Exsr      SNDMSG                                       SEND MSG
043300101111     C                   End
043400101230      *
043500101230     C                   If        WSEFFD <> *zeros
043600101230     C                   Movel     WSEFFD        Input_Date
043700101230     C                   Exsr      EDTDAT
043800101230     C                   If        Output_Error <> *Blanks
043900101230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
044000101230    ?C                   Move      WTM(14)       WWMSG                          PASS MSG
044100101230    ?C                   Exsr      SNDMSG                                       SEND MSG
044200101230     C                   End
044300101230     C                   End
044400101111    ? *
044500101111     C                   If        WORTN = *Blanks
044600101111     C                   Movel     WSBIRTH       Input_Date
044700101111     C                   Exsr      EDTDAT
044800101111     C                   If        Output_Error <> *Blanks
044900101111    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
045000101111    ?C                   Move      WTM(11)       WWMSG                          PASS MSG
045100101111    ?C                   Exsr      SNDMSG                                       SEND MSG
045200101111     C                   Else
045300101111    ? *
045400101111    ?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
045500101110
045600101110     C     1             CHAIN     WEBPAYVAL
045700101110     C                   If        %found(WEBPAYVAL)
045800101230     C     WSBIRTH       Mult      10000.0001    PVBIRTH
045900101230     C     WSEFFD        Mult      10000.0001    PVEFFD
046000101111     C                   Eval      PVSALRY = WSSALY
046100101111     C                   Eval      PVBENAM = WSBENA
046200101110     C                   Eval      PVRULE  = WSRULE
046300101110     C                   Update    WEBPAYVAR
046400101110     C                   Else
046500101110     C     WSBIRTH       Mult      10000.0001    PVBIRTH
046600101230     C     WSEFFD        Mult      10000.0001    PVEFFD
046700101110     C                   Eval      PVSALRY = WSSALY
046800101110     C                   Eval      PVRULE  = WSRULE
046900101111     C                   Eval      PVBENAM = WSBENA
047000101110     C                   Write     WEBPAYVAR
047100101110     C                   End
047200101230
047300101230     C                   If        WSEFFD <> *Zeros
047400101230     C     WSEFFD        Mult      10000.0001    Today
047500101230     C                   End
047600101110
047700101110     C                   Eval      WGDTA = #GETDED(PATRST:PASUB#:0:
047800101115     C                                     999999999:0:PAPLAN:PLNCAT:
047900160418     C                                     'INDIVIDUAL':Today:0:'')
048000101110
048100101110     C                   Eval      WSDEDAMT = DSDAMT
048200101110    ? *
048300101111     C                   End
048400101110     C                   End
048500101110    ? *
048600101110B001?C                   Select                                                 PRC RETURN CDE
048700101110 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
048800101110 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
048900101110 001? *
049000101110 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
049100101110B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
049200101110 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
049300101110X002?C                   Else                                                   ELSE
049400101110 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
049500101110 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
049600101110E002?C                   Endif                                                  IF WARNING
049700101110 001? *
049800101110 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
049900101110 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
050000101110 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
050100101110 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
050200101110E001?C                   Endsl                                                  RETURN CODE SEL
050300101110    ? *
050400101110
050500101109    ?C                   Endsr                                                  END PRCRDN
050600000000    ? *___________________________________________________________________
050700000000    ? * Process ENTER function
050800000000    ? *___________________________________________________________________
050900101110    ?C     PRCPNLX       Begsr                                                  PROCESS PANEL
051000000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
051100000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
051200100819    ?C                   If        WWFKA = 'UPDATE  '  or                       ENTER
051300100819    ?C                             WWFKA = 'ENTER   '                           ENTER
051400000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
051500000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
051600000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
051700100817     C                   Z-add     WSBEDT        PABEDT
051800100817     C                   Z-add     WSENDT        PAENDT
051900101110 001?C***                Call      'CHKANC0 '                                   CHECK DATA
052000101110 001?C***                Parm      'EDIT    '    WWRQS                          EDIT REQUEST
052100101110 001?C***                Parm                    WWRTN                          RETURN CODE
052200101110 001?C***                Parm                    WCDTA                          REC DATA
052300100819E001?C                   End                                                    ENDIF
052400100819E001?C                   End                                                    ENDIF
052500000000    ? *
052600000000B001?C                   Select                                                 PRC RETURN CDE
052700000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
052800000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
052900000000 001? *
053000000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
053100000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
053200000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
053300000000X002?C                   Else                                                   ELSE
053400000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
053500000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
053600000000E002?C                   Endif                                                  IF WARNING
053700000000 001? *
053800000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
053900000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
054000000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
054100000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
054200000000E001?C                   Endsl                                                  RETURN CODE SEL
054300000000    ? *
054400000000    ?C                   Endsr                                                  END PRCPNL
054500000000    ? *___________________________________________________________________
054600000000    ? * Process end - write data or release record
054700000000    ? *___________________________________________________________________
054800000000    ?C     PRCEND        Begsr                                                  PROCESS END
054900161011    ? *
055000161011    ? * Prevent update on F1 exit
055100161011     C                   If        WWCHG = 'Y' and
055200161011     C                             WWFKA = 'EXIT'
055300161011     C                   eval      WWCHG = 'N'
055400161011     C                   eval      WWTSK = *blanks
055500161011     C                   end
055600000000    ? *
055700000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
055800000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
055900000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
056000000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
056100000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
056200000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
056300000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
056400000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
056500000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
056600000000 001?C                   Endcs                                                  END CASE
056700000000 001? *
056800000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
056900000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
057000000000 002? *
057100000000X002?C                   Else                                                   ELSE NO WRT ERR
057200000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
057300000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
057400000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
057500000000 004?C                   Exsr      PRPPNL                                       DO NOT END
057600000810E004?C                   Endif                                                  END IF ADD
057700000000E003?C                   Endif                                                  END IF NOT END
057800000000E002?C                   Endif                                                  END IF WRITE ERROR
057900000000 001? *
058000000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
058100000000 001?C                   Exsr      RELREC                                       RELEASE REC
058200000000E001?C                   Endif                                                  END IF RCD CHANGED
058300000000    ? *
058400000000    ?C                   Endsr                                                  END PRCEND
058500000000    ? *___________________________________________________________________
058600000000    ? * Add new record
058700000000    ? *___________________________________________________________________
058800000000    ?C     WRTADD        Begsr                                                  WRITE ADD
058900000000    ? *
059000000000    ?C                   Endsr                                                  END WRTADD
059100000000    ? *___________________________________________________________________
059200000000    ? * Write changed record
059300000000    ? *___________________________________________________________________
059400000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
059500100825      *
059600000000    ? *
059700000000    ?C                   Endsr                                                  END WRTCHG
059800101111    ? *___________________________________________________________________
059900101111    ? * format Date edit
060000101111    ? *___________________________________________________________________
060100101111    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
060200101111     C                   movel     'MMDDYYYY'    Input_Format
060300101111     C                   Call      'FMTDATE'
060400101111     C                   Parm                    Input_Date       32
060500101111     C                   Parm                    Input_Format     32
060600101111     C                   Parm                    Output_Format    32
060700101111     C                   Parm                    Output_Date      32
060800101111     C                   Parm                    Output_Error     10
060900101111    ?C                   Endsr                                                  END DLT RQST
061000000000    ? *___________________________________________________________________
061100000000    ? * Release record
061200000000    ? *___________________________________________________________________
061300000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
061400100817    ?C                   Call      'UPDANC  '                                   PROCESS REC IO
061500000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
061600000000    ?C                   Parm                    WWRTN                          RETURN CODE
061700000614    ?C                   Parm                    WUDTA                          REC DATA
061800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
061900000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
062000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
062100000000E001?C                   Endif                                                  END IF CALL ERROR
062200000000    ?C                   Endsr                                                  END RELREC
062300000000    ? *___________________________________________________________________
062400000000    ? * Build function keys
062500000000    ? *___________________________________________________________________
062600000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
062700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
062800991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
062900000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
063000000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
063100000000    ?C                   Parm                    WAD                            FNC DESC
063200991108    ?C                   Parm                    WWIN                           AID BYTE
063300000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
063400000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
063500000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
063600000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
063700000000    ?C                   Sub       1             WW                             BUMP IDX
063800000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
063900000000    ?C                   Endsr                                                  END BLD FNCTNS
064000000000    ? *___________________________________________________________________
064100000000    ? * Send message
064200000000    ? *___________________________________________________________________
064300000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
064400000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
064500000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
064600000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
064700000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
064800000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
064900000000    ?C                   Endsr                                                  END SNDMSG
065000000000    ? *___________________________________________________________________
065100000000    ? * Paremater list
065200000000    ? *___________________________________________________________________
065300000000    ?C     PLIST         Begsr                                                  PARM LISTS
065400000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
065500000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
065600000000    ?C                   Parm                    WORTN             8            RETURN CODE
065700000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
065800000614    ?C                   Parm                    WUDTA                          RECORD KEY
065900000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
066000000000    ?C                   Endsr                                                  END PLIST
066100050318    ? *___________________________________________________________________
066200050318    ? * Key lists
066300050318    ? *___________________________________________________________________
066400050318    ?C     KLIST         Begsr                                                  KEY LISTS
066500100506    ?C     PKey          Klist                                                  ACKCTL
066600100817    ?C                   Kfld                    PATRST
066700100817    ?C                   Kfld                    PASUB#
066800100817    ?C                   Kfld                    PAPLAN                         POSITION TO 1
066900100506    ?C     SKey          Klist                                                  ACKCTL
067000100817    ?C                   Kfld                    PATRST
067100100817    ?C                   Kfld                    PASUB#
067200050318    ?C                   Endsr                                                  END KLIST
067300000000    ? *___________________________________________________________________
067400000000    ? * Initialize routine
067500000000    ? *___________________________________________________________________
067600000000    ?C     *INZSR        Begsr                                                  INITIALIZE
067700000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
067800000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
067900000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
068000000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
068100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
068200000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
068300000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
068400000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
068500000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
068600100506     C                   Clear                   SV$AMT            5 2
068700000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
068800000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
068900000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
069000000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
069100000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
069200000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
069300000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
069400000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
069500000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
069600000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
069700000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
069800000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
069900000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
070000000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
070100000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
070200000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
070300100817    ?C                   Movel     'CHGANC  '    WWFIL            10            FILE NAME-NOTES
070400000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
070500000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
070600000000    ?C                   Endsr                                                  END INITIALIZE
070700000000    ? *___________________________________________________________________
070800000000    ? * Program error handler
070900000000    ? *___________________________________________________________________
071000000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
071100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
071200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
071300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
071400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
071500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
071600000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
071700000000    ? *___________________________________________________________________
071800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
07190010081701EXIT    F1=Return
07200010102004PROMPT  F4=Prompt
07210000000005REFRESH F5=Refresh
07220010082610VALIDATEF10=Validate Formula
07230000061412CANCEL  F12=Cancel
07240000000025ROLLUP
07250000000026ROLLDOWN
072600000000** WTM
07270010081700Request not supported in program CHGANC.
07280000000000Update error.  Data was not updated.
07290010052600Update error.  Data was not updated.
07300000000000Call to notes ended in error.
07310000000000Initialize error.  Record not initialized.
07320000000000Record not found.
07330000000000Generate error.  Key not generated.
07340000000000Record not available now.
07350000000000The cursor is not in a prompt area.
07360010111100Default error.  Data not defaulted.
07370010111100You must enter a valid Birth Date MMDDYYYY.
07380010111100You must enter a Annual Salary amount.
07390010111100You must enter a Benefit Amount.
07400010123000You must enter a valid Effective Date MMDDYYYY.
