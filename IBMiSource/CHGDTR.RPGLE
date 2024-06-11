000100170822     h option(*noDebugIo)
000200170822
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500101019    ? *  Description:  Change Date Ranges
000600000000    ? *
000700020920    ? *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000800170822    ? *
000900170822    ? *-------------------------------------------------------------------------
001000170822    ? * Modifications
001100170822    ? * 08/22/2017   B.Rees   Added OE Status
001200170822    ? * Mod id: BR01
001300170822    ? *
001400000000    ? *_________________________________________________________________________
001500101019    ?FCHGDTRD   CF   E             WORKSTN
001600000000    ?F                                     INFDS(DSPD)
001700100617     FACCMST    IF   E           K DISK
001800100617     FWEBPAYCHP IF   E           K DISK
001900000000    ? *
002000000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002100000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002200030313    ?D WTM             S             80    DIM(11) CTDATA PERRCD(1)             PANEL MESSAGES
002300100618     D WSDESC          S             20A
002400000000    ? *_________________________________________________________________________
002500000406    ? * Data structure
002600101019    ?D WUDTA         E DS                  EXTNAME(WEBPAYDTR)
002700170822     D oeStatus                       1a
002800170822
002900100617    ?D WGDTA         E DS                  EXTNAME(WEBPAYCHP)
003000000000    ? *
003100000000    ? * Program status data structure
003200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003300000000    ? *
003400000000    ? * Display file data structure
003500991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003600000000    ? *
003700000000    ? * CURSOR LOCATION
003800000000    ?D                 DS
003900000000    ?D  WWCRSL                 1      2
004000000000    ?D  WWCRSN                 1      2B 0
004100000000    ? *_________________________________________________________________________
004200000000    ? *
004300000614    ? * Process Entry Panel
004400000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
004500000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
004600000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
004700000000E001?C                   Endif                                                  END COPY/CPYKEY
004800000000    ? *
004900000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005000000000    ? *
005100000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005200000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005300000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
005400000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005500000000 001? *
005600000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
005700000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
005800000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005900030313 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
006000000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006100000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
006200000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
006300000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
006400000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
006500000000 001?C                   Endcs                                                  END CASE
006600000000 001? *
006700000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
006800000000 002?C                   Exsr      PRCEND                                       PROCESS END
006900000000E002?C                   Endif                                                  END IF END REQ
007000000000E001?C                   Enddo                                                  END DOWHILE
007100000000    ? *
007200000707    ? * Send Info Updated message.
007300000707     C     WwChg         Ifeq      'Y'
007400000707     C                   Movel     'UPDATE  '    WORTN
007500000707     C                   Endif
007600000707    ? *
007700000000    ?C                   Return                                                 RETURN
007800000000    ? *___________________________________________________________________
007900000000    ? * Prepare panel
008000000000    ? *___________________________________________________________________
008100000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008200000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
008300991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008400000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008500000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008600000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008700000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008800000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008900000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
009000000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
009100000000    ? *
009200000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
009300000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009400000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009500000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009600000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009700000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009800000000    ? *
009900000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
010000100520    ? *
010100100520     C     KEYACC        Klist
010200101019     C                   kfld                    PGTRST
010300101019     C                   kfld                    PGSUB#
010400101019     C                   kfld                    PGACCT
010500100520     C     KEYACC        Chain     ACCMST
010600100520     C                   if        %found(ACCMST)
010700100520     C                   Eval      WWANAM = %trim(ACNAM1)
010800100520     C                   Else
010900100617     C                   Eval      WWANAM = *blanks
011000100521     C                   End
011100000000    ? *
011200100617     C                   Eval      WSDESC = *blanks
011300101019     C                   If        PGGRPR <> *blanks
011400100617     C                   eval      PCTRST = 0
011500100617     C                   eval      PCSUB# = 0
011600100617     C                   eval      PCACCT = 0
011700100617     C     KEYOPT        Klist
011800100617     C                   kfld                    PCTRST
011900100617     C                   kfld                    PCSUB#
012000100617     C                   kfld                    PCACCT
012100101019     C                   kfld                    PGGRPR
012200101019     C                   kfld                    PGCODE
012300100617     C     KEYOPT        Chain     WEBPAYCHP
012400100617     C                   if        %found(WEBPAYCHP)
012500100617     C                   Eval      WSDESC = %trim(PCDESC)
012600100617     C                   Else
012700100617     C                   Eval      WSDESC = *blanks
012800100617     C                   End
012900100617     C                   End
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
014400100617     C                   Clear                   WSDESC
014500100617     C                   Clear                   WWANAM
014600000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
014700000000    ?C                   Endsr                                                  END PRP ADD
014800000000    ? *___________________________________________________________________
014900000000    ? * Prepare CHANGE request
015000000000    ? *___________________________________________________________________
015100000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
015200101019    ?C                   Call      'UPDDTR  '                                   PROCESS REC IO
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
017200101019    ?C                   Call      'UPDDTR  '                                   PROCESS REC IO
017300000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
017400000000    ?C                   Parm                    WWRTN                          RETURN CODE
017500000614    ?C                   Parm                    WUDTA                          REC DATA
017600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
017700000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
017800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
017900000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018000170822 001?C
018100000000X001?C                   Else                                                   ELSE
018200000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
018300000000E001?C                   Endif                                                  END IF ERROR
018400000000    ?C                   Endsr                                                  END PREP COPY
018500000000    ? *___________________________________________________________________
018600000000    ? * Default Data
018700000000    ? *___________________________________________________________________
018800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
018900101019    ?C                   Call      'CHKDTR  '                                   PROCESS REC IO
019000000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
019100000000    ?C                   Parm                    WWRTN                          RETURN CODE
019200000614    ?C                   Parm                    WUDTA                          REC DATA
019300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
019400000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
019500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
019600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
019800000000E001?C                   Endif                                                  END IF ERROR
019900000000    ?C                   Endsr                                                  END DFTDTA
020000000000    ? *___________________________________________________________________
020100000000    ? * Process ERROR function
020200000000    ? *___________________________________________________________________
020300000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
020400000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
020500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
020600000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
020700000000    ?C                   Move      'END'         WWSTT                          END STATE
020800000000    ?C                   Endsr                                                  END PRCERR
020900000000    ? *___________________________________________________________________
021000000000    ? * Receive messages
021100000000    ? *___________________________________________________________________
021200000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
021300000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
021400000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
021500000000X001?C                   Else                                                   ELSE
021600000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
021700000000E001?C                   Endif                                                  ENDIF NOT NORESET
021800000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
021900000000    ?C                   Movea     *IN           WWIN                           INDICATORS
022000000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
022100000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
022200000000    ?C                   Parm                    WWIN                           INDICATORS
022300000000    ?C                   Parm                    WWRTN                          RETURN CODE
022400000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
022500000000    ?C                   Endsr                                                  END RCV MSG
022600000000    ? *___________________________________________________________________
022700000000    ? * Display panels
022800000000    ? *___________________________________________________________________
022900000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
023000000000    ? *
023100000000    ? * Set PUTOVR based on last display file processed
023200000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
023300000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
023400000000 001?C                   Setoff                                       35        PUTOVR OFF
023500000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
023600000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
023700000000X001?C                   Else                                                   ELSE SAME PGM
023800000000 001?C                   Seton                                        35        PUTOVR ON
023900000000E001?C                   Endif                                                  END IF NEW PGM
024000000000    ? *
024100000614    ? * Set PROTECT key based on request
024200000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
024300000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
024400000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
024500000000 001?C                   Setoff                                       40        NO PROTECT KEY
024600000000X001?C                   Else                                                   ELSE
024700000000 001?C                   Seton                                        40        PROTECT KEY
024800000000E001?C                   Endif                                                  END IF ADD
024900000000    ? *
025000000000    ? * Select title
025100000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
025200000000 001?C                   Setoff                                       38        CHANGE TITLE
025300000000X001?C                   Else                                                   ELSE
025400000000 001?C                   Seton                                        38        ADD TITLE
025500000000E001?C                   Endif                                                  END IF CHANGE
025600000000    ? *
025700000000    ? * Position cursor based on error status
025800000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
025900000000 001?C                   Seton                                        99        POS CSR TO ERROR
026000000000X001?C                   Else                                                   ELSE
026100000000 001?C                   Setoff                                       99        POS CSR TO FIRST
026200000000E001?C                   Endif                                                  END IF ERROR
026300000000    ? *
026400000000    ? * Write message subfile
026500000000    ?C                   Seton                                        30        MSGSFL DISPLAY
026600000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
026700000000    ? *
026800000000    ? * Write entry panel
026900000000B001?C                   Select
027000000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
027100000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
027200000000 001?C                   Setoff                                       37        RESET CRSLOC
027300000000E001?C                   Endsl                                                  END SELECT
027400000000    ? *
027500000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
027600000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
027700000000E001?C                   Endif                                                  END IF DATA CHG
027800000000    ?C                   Endsr                                                  END DSPENT
027900000000    ? *___________________________________________________________________
028000000000    ? * Process function key
028100000000    ? *___________________________________________________________________
028200000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
028300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
028400991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
028500000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
028600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
028700000000    ?C                   Parm                    WAD                            FNC DESC
028800991108    ?C                   Parm                    WWIN                           AID BYTE
028900000000    ?C                   Parm                    WAF                            FNC KEY TABLE
029000000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
029100000000    ?C                   Endsr                                                  END PRCFKY
029200000000    ? *___________________________________________________________________
029300000000    ? * Process KEYS function
029400000000    ? *___________________________________________________________________
029500000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
029600000000    ?C                   Z-add     1             WW                             KEY DSC IDX
029700000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
029800000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
029900000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
030000000000 001? *
030100000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
030200000000 002?C                   Z-add     1             WWFKS                          SET TO 1
030300000000E002?C                   Endif                                                  END IF OVER 3
030400000000 001? *
030500000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
030600000000 001?C                   Sub       1             WW                             KEY DESCR IDX
030700000000E001?C                   Enddo                                                  END DO KEYS
030800000000    ? *
030900010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
031000010913    ?C                   Add       1             WW                             BUMP IDX
031100010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
031200010913    ?C                   Endsr                                                  END PRCDKY
031300000000    ? *___________________________________________________________________
031400000000    ? * Process EXIT Function
031500000000    ? *___________________________________________________________________
031600000000    ?C     PRCEXT        Begsr                                                  RETURN
031700000000    ? *
031800000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
031900000000    ? *
032000000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
032100000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
032200000000X001?C                   Else                                                   ELSE NO ERRORS
032300000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
032400000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
032500011024E001?C                   Endif                                                  END IF ERRORS
032600100610
032700000000    ?C                   Endsr                                                  END PRCEXT
032800000000    ? *___________________________________________________________________
032900000000    ? * Process PROMPT function
033000000000    ? *___________________________________________________________________
033100000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
033200000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
033300000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
033400000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
033500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
033600020920    ? *
033700000000B001?C                   Select                                                 SELECT
033800020923    ? *
033900101019 001 C                   When      WSFLD = 'PGCODE '
034000100617     C                   Eval      PCTRST   =    *zeros
034100100617     C                   Eval      PCSUB#   =    *zeros
034200100617     C                   Eval      PCACCT   =    *zeros
034300101019     C                   Eval      PCGRPR   =    'RANGE '
034400100617 001?C                   Call      'SLCPCC  '                                   CALL SELECT PROGRAM
034500101019 001?C                   Parm      'RANGE '      WWRQS                          REQUEST
034600020923 001?C                   Parm                    WWRTN                          RETURN CODE
034700100610 001?C                   Parm                    WUPGM                          PROGRAM
034800100610 001?C                   Parm                    WGDTA                          PROGRAM
034900020923B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
035000101019 003?C                   Eval      PGGRPR  =     PCGRPR                         SET CODE
035100101019 003?C                   Eval      PGCODE  =     PCCODE                         SET CODE
035200100617 003?C                   Eval      WSDESC  =     PCDESC                         SET CODE
035300020923E001?C                   End
035400020923    ? *
035500000000 001?C                   Other                                                  WHERE ERROR
035600000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
035700000000 001?C                   Exsr      SNDMSG                                       SEND MSG
035800000000E001?C                   Endsl                                                  END SELECT
035900000000    ? *
036000000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
036100000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
036200000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
036300000000    ?C                   Mvr                     WSLIN                          CURSOR COL
036400000000    ?C                   Seton                                        37        SET ON CRSLOC
036500000000    ? *
036600000000    ?C                   Endsr                                                  END PRCPMT
036700000000    ? *___________________________________________________________________
036800000000    ? * Process CANCEL Function
036900000000    ? *___________________________________________________________________
037000000000    ?C     PRCCNL        Begsr                                                  CANCEL
037100000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
037200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
037300000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
037400000000    ?C                   Endsr                                                  END RETURN
037500000000    ? *___________________________________________________________________
037600000000    ? * Process ROLLUP function
037700000000    ? *___________________________________________________________________
037800000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
037900000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
038000000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
038100000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
038200000000E001?C                   Endif                                                  END IF GT LST PNL
038300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
038400000000    ?C                   Endsr                                                  END PRCRUP
038500000000    ? *___________________________________________________________________
038600000000    ? * Process ROLLDOWN function
038700000000    ? *___________________________________________________________________
038800000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
038900000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
039000000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
039100000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
039200000000E001?C                   Endif                                                  END IF LT FST PNL
039300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
039400000000    ?C                   Endsr                                                  END PRCRDN
039500000000    ? *___________________________________________________________________
039600000000    ? * Process ENTER function
039700000000    ? *___________________________________________________________________
039800000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
039900000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
040000000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
040100000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
040200000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
040300000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
040400101019 001?C                   Call      'CHKDTR  '                                   CHECK DATA
040500000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
040600000000 001?C                   Parm                    WWRTN                          RETURN CODE
040700000614 001?C                   Parm                    WUDTA                          REC DATA
040800000000E001?C                   Endif                                                  ENDIF
040900100521    ? *
041000100521     C     KEYACC        Chain     ACCMST
041100100521     C                   if        %found(ACCMST)
041200100521     C                   Eval      WWANAM = %trim(ACNAM1)
041300100521     C                   Else
041400100617     C                   Eval      WWANAM = *Blanks
041500100521     C                   End
041600100622
041700100617     C                   eval      PCTRST = 0
041800100617     C                   eval      PCSUB# = 0
041900100617     C                   eval      PCACCT = 0
042000100617     C     KEYOPT        Chain     WEBPAYCHP
042100100617     C                   if        %found(WEBPAYCHP)
042200100617     C                   Eval      WSDESC = %trim(PCDESC)
042300100617     C                   Else
042400100622     C                   Eval      WSDESC = *blanks
042500100617     C                   End
042600000000    ? *
042700000000B001?C                   Select                                                 PRC RETURN CDE
042800000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
042900000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
043000000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
043100000000 001? *
043200000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
043300000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
043400000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
043500000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
043600000000X002?C                   Else                                                   ELSE
043700000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
043800000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
043900000000E002?C                   Endif                                                  IF WARNING
044000000000 001? *
044100000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
044200000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
044300000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
044400000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
044500000000E001?C                   Endsl                                                  RETURN CODE SEL
044600000000    ? *
044700000000    ?C                   Endsr                                                  END PRCPNL
044800000000    ? *___________________________________________________________________
044900000000    ? * Process end - write data or release record
045000000000    ? *___________________________________________________________________
045100000000    ?C     PRCEND        Begsr                                                  PROCESS END
045200000000    ? *
045300000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
045400000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
045500000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
045600000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
045700000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
045800000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
045900000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
046000000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
046100000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
046200000000 001?C                   Endcs                                                  END CASE
046300000000 001? *
046400000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
046500000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
046600000000 002? *
046700000000X002?C                   Else                                                   ELSE NO WRT ERR
046800000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
046900000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
047000000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
047100000000 004?C                   Exsr      PRPPNL                                       DO NOT END
047200000810E004?C                   Endif                                                  END IF ADD
047300000000E003?C                   Endif                                                  END IF NOT END
047400000000E002?C                   Endif                                                  END IF WRITE ERROR
047500000000 001? *
047600000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
047700000000 001?C                   Exsr      RELREC                                       RELEASE REC
047800000000E001?C                   Endif                                                  END IF RCD CHANGED
047900000000    ? *
048000000000    ?C                   Endsr                                                  END PRCEND
048100000000    ? *___________________________________________________________________
048200000000    ? * Add new record
048300000000    ? *___________________________________________________________________
048400000000    ?C     WRTADD        Begsr                                                  WRITE ADD
048500000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
048600000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
048700000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
048800000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
048900000000E001?C                   Endif                                                  END IF ADD
049000000000    ? *
049100000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
049200000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
049300000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
049400000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
049500000000E001?C                   Endif                                                  END IF ADD KEY
049600000000    ? *
049700101019    ?C                   Call      'UPDDTR  '                                   PROCESS REC IO
049800000000    ?C                   Parm                    WWRQS                          ADD RECORD
049900000000    ?C                   Parm                    WWRTN                          RETURN CODE
050000000614    ?C                   Parm                    WUDTA                          REC DATA
050100000000    ? *
050200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
050300000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
050400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
050500000000X001?C                   Else                                                   ELSE
050600000000E001?C                   Endif                                                  END IF CALL ERROR
050700000000    ? *
050800000000    ?C                   Endsr                                                  END WRTADD
050900000000    ? *___________________________________________________________________
051000000000    ? * Write changed record
051100000000    ? *___________________________________________________________________
051200000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
051300101019    ?C                   Call      'UPDDTR  '                                   PROCESS REC IO
051400000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
051500000000    ?C                   Parm                    WWRTN                          RETURN CODE
051600000614    ?C                   Parm                    WUDTA                          REC DATA
051700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
051800000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
051900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
052000000000E001?C                   Endif                                                  END IF CALL ERROR
052100000000    ? *
052200000000    ?C                   Endsr                                                  END WRTCHG
052300011024    ? *___________________________________________________________________
052400011024    ? * Inz NO Key
052500011024    ? *___________________________________________________________________
052600011024    ?C     INZNKY        Begsr                                                  WRITE CHANGE
052700101019    ?C                   Call      'UPDDTR  '                                   PROCESS REC IO
052800011024    ?C                   Parm      'INZNKY'      WWRQS                          UPDATE RECORD
052900011024    ?C                   Parm                    WWRTN                          RETURN CODE
053000011024    ?C                   Parm                    WUDTA                          REC DATA
053100011024B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
053200011024 001?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
053300011024 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
053400011024E001?C                   Endif                                                  END IF CALL ERROR
053500011024    ? *
053600011024    ?C                   Endsr                                                  END WRTCHG
053700000000    ? *___________________________________________________________________
053800000000    ? * Release record
053900000000    ? *___________________________________________________________________
054000000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
054100101019    ?C                   Call      'UPDDTR  '                                   PROCESS REC IO
054200000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
054300000000    ?C                   Parm                    WWRTN                          RETURN CODE
054400000614    ?C                   Parm                    WUDTA                          REC DATA
054500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
054600000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
054700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
054800000000E001?C                   Endif                                                  END IF CALL ERROR
054900000000    ?C                   Endsr                                                  END RELREC
055000000000    ? *___________________________________________________________________
055100000000    ? * Build function keys
055200000000    ? *___________________________________________________________________
055300000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
055400991108    ?C                   Movea     *IN           WWIN                           INDICATORS
055500991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
055600000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
055700000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
055800000000    ?C                   Parm                    WAD                            FNC DESC
055900991108    ?C                   Parm                    WWIN                           AID BYTE
056000000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
056100000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
056200010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
056300010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
056400010913    ?C                   Sub       1             WW                             BUMP IDX
056500010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
056600000000    ?C                   Endsr                                                  END BLD FNCTNS
056700000000    ? *___________________________________________________________________
056800000000    ? * Send message
056900000000    ? *___________________________________________________________________
057000000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
057100000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
057200000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
057300000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
057400000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
057500000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
057600000000    ?C                   Endsr                                                  END SNDMSG
057700000000    ? *___________________________________________________________________
057800000000    ? * Paremater list
057900000000    ? *___________________________________________________________________
058000000000    ?C     PLIST         Begsr                                                  PARM LISTS
058100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
058200000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
058300000000    ?C                   Parm                    WORTN             8            RETURN CODE
058400000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
058500000614    ?C                   Parm                    WUDTA                          RECORD KEY
058600000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
058700000000    ?C                   Endsr                                                  END PLIST
058800000000    ? *___________________________________________________________________
058900000000    ? * Initialize routine
059000000000    ? *___________________________________________________________________
059100000000    ?C     *INZSR        Begsr                                                  INITIALIZE
059200000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
059300000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
059400000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
059500000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
059600000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
059700000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
059800000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
059900000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
060000000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
060100000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
060200000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
060300000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
060400000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
060500000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
060600000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
060700000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
060800000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
060900000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
061000000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
061100000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
061200000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
061300000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
061400000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
061500000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
061600000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
061700101019    ?C                   Movel     'WEBPAYDTR'   WWFIL            10            FILE NAME-NOTES
061800000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
061900000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
062000000000    ?C                   Endsr                                                  END INITIALIZE
062100000000    ? *___________________________________________________________________
062200000000    ? * Program error handler
062300000000    ? *___________________________________________________________________
062400000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
062500000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
062600000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
062700000000    ?C                   Parm                    WQSTSC                         STATUS CODE
062800000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
062900000000    ?C                   Parm                    WQMSG                          MESSAGE ID
063000000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
063100000000    ? *___________________________________________________________________
063200000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06330000000003EXIT    F3=Exit
06340000000004PROMPT  F4=Prompt
06350003031305REFRESH F5=Refresh
06360000070710UPDATE  F10=Update
06370000061412CANCEL  F12=Cancel
06380000000025ROLLUP
06390000000026ROLLDOWN
064000000000** WTM
06410010101900Request not supported in program CHGDTR.
06420000000000Update error.  Data was not updated.
06430000000000Duplicate key detected.  Data was NOT added to file.
06440000000000Call to notes ended in error.
06450000000000Initialize error.  Record not initialized.
06460000000000Record not found.
06470000000000Generate error.  Key not generated.
06480000000000Record not available now.
06490000000000The cursor is not in a prompt area.
06500003031300Default error.  Data not defaulted.
06510010052000
