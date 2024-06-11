000100220121     h option(*noDebugIO)    DftActGrp(*no)
000101220121    ? *_________________________________________________________________________
000200000000    ? *
000300070316    ? *  Description:  Change OLE Account User
000400000000    ? *
000500070316    ? *  (c)Copyright 2007 by GBS,Inc.
000600051028    ? *
000601220128      * 1/28/2022  B.Rees Converted screen to Profound Logic.
000700051028    ? *_________________________________________________________________________
000701220128      *
000702220128      *
000800070316    ?FCHGUSRD   CF   E             WORKSTN
000900000000    ?F                                     INFDS(DSPD)
000901220121     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001000070316    ?FOEUSER    If   E           k Disk
001100121012     FACCMST    IF   E           K Disk
001200121012     FSLCOLELF  IF   E           K Disk
001300000000    ? *
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001600061201    ?D WTM             S             80    DIM(11) CTDATA PERRCD(1)             PANEL MESSAGES
001700000000    ? *_________________________________________________________________________
001800000406    ? * Data structure
001900121012    ?D WUDTA         E DS                  EXTNAME(OEUSER)
002000121012    ?D WCDTA         E DS                  EXTNAME(SLCOLEP)
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
003200070316     D WWTRST          S                   LIKE(OUTRST)
003300070316     D WWSUB#          S                   LIKE(OUSUB#)
003400070316     D WWACCT          S                   LIKE(OUACCT)
003500000000    ? *_________________________________________________________________________
003501220128
003502220128       dcl-pr WN0026R ExtPgm('WN0026R');
003503220128         pCode   Char(1);
003504220128         pDesc   Char(30);
003505220128         pcancel Char(1);
003506220128       End-Pr;
003507220128       dcl-s pCode   Char(1);
003508220128       dcl-s pDesc   Char(30);
003509220128       dcl-s pCancel Char(1);
003510220128
003511220128
003512220128
003513220128
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
006800000707     C                   Movel     'UPDATE  '    WORTN
006900000707     C                   Endif
007000000707    ? *
007100220121    ?C**                 Return                                                 RETURN
007101220121
007102220121       *inlr = *on;
007103220121
007200000000    ? *___________________________________________________________________
007300000000    ? * Prepare panel
007400000000    ? *___________________________________________________________________
007500000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007600000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007700050317    ?C                   Move      *ZEROS        WSBEDT                         RETURN CODE
007800050317    ?C                   Move      *ZEROS        WSENDT                         RETURN CODE
007900991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008000000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008100000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008200000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008300000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008400000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008500000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
008600070316    ?C                   Move      *BLANKS       WWSTT                          RESET END
008700000000    ? *
008800000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
008900000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009000000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009100000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009200000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009300000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009400000000    ? *
009500070316     C                   Eval      WWTRST = OUTRST
009600070316     C                   Eval      WWSUB# = OUSUB#
009700070316     C                   Eval      WWACCT = OUACCT
009800070316     C                   Movel     OUTRST        Trst              3
009900070316     C                   Movel     OUSUB#        Sub#              3
010000070316     C                   Movel     OUACCT        Acct              4
010100070316     C     AKey          Chain     ACCMST
010200070316     C                   If        %Found(ACCMST)
010300070316     C                   Eval      WWNAME  = %trim(Trst) + '-'   +
010400070316     C                                       %trim(Sub#) + '-'   +
010500070316     C                                       %trim(Acct) + '  '  +
010600070316     C                                       %trim(ACNAM1)
010700070316     C                   Movel(P)  WWNAME        WISTR
010800070316     C                   Z-add     60            WILEN
010900070316     C                   Call      'UTLCENSTR'
011000070316     C                   Parm                    WISTR           256
011100070316     C                   Parm                    WILEN             3 0
011200070316     C                   Movel     WISTR         WWNAME
011300070316     C                   End
011400121012    ? *
011500121012     C     OUEMEX        Chain     SLCOLELF
011600121012     C                   If        %found(SLCOLELF)
011700121012     C                   Eval      WSOLE = %trim(SLDESC)
011800121012     C                   Else
011900121012     C                   Eval      WSOLE = *blanks
012000121012     C                   End
012100070316    ? *
012200000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
012300000000    ? *
012400000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
012500000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
012600000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
012700000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
012800000000    ?C                   Cas                     PRCERR                         PROC ERROR
012900000000    ?C                   Endcs                                                  END CASE
013000000000    ? *
013100000000    ?C                   Endsr                                                  END PRPPNL
013200000000    ? *___________________________________________________________________
013300000000    ? * Prepare ADD request
013400000000    ? *___________________________________________________________________
013500000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
013600070320     C                   Clear                   OUEMAL
013700070706     C                   Clear                   OUEMEX
013800070320     C                   Clear                   OULNAM
013900070320     C                   Clear                   OUFNAM
014000120606     C                   Clear                   OUUSER
014100120606     C                   Clear                   OUUSPW
014200070316    ?C                   Clear                   OUBEDT                         CLEAR RECORD
014300070316    ?C                   Clear                   OUENDT                         CLEAR RECORD
014400070316    ?C                   Clear                   OUADDT                         CLEAR RECORD
014500070316     C                   Clear                   OUADGU
014600070320    ?C                   Clear                   OUCHDT                         CLEAR RECORD
014700070320     C                   Clear                   OUCHGU
014800121221     C                   Eval      WSOLE = *blanks
014900000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
015000000000    ?C                   Endsr                                                  END PRP ADD
015100000000    ? *___________________________________________________________________
015200000000    ? * Prepare CHANGE request
015300000000    ? *___________________________________________________________________
015400000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
015500070316    ?C                   Call      'UPDUSR  '                                   PROCESS REC IO
015600000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
015700000000    ?C                   Parm                    WWRTN                          RETURN CODE
015800000614    ?C                   Parm                    WUDTA                          REC DATA
015900050413    ?C                   Parm                    Whist             3            DATA
016000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016100000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
016200000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
016300000000X002?C                   Else                                                   ELSE
016400000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
016500000000E002?C                   Endif                                                  END RCD NOT AVL
016600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016800000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016900000810E001?C                   Else                                                   END IF ERROR
017000070316     C     OUBEDT        MULT      10000.0001    WSBEDT
017100070316     C     OUENDT        MULT      10000.0001    WSENDT
017200070316     C     OUADDT        MULT      10000.0001    WSADDT
017300070316     C     OUCHDT        MULT      10000.0001    WSCHDT
017400121221    ? *
017500121221     C     OUEMEX        Chain     SLCOLELF
017600121221     C                   If        %found(SLCOLELF)
017700121221     C                   Eval      WSOLE = %trim(SLDESC)
017800121221     C                   Else
017900121221     C                   Eval      WSOLE = *blanks
018000121221     C                   End
018100121221    ? *
018200000810E001?C                   Endif                                                  END IF ERROR
018300000000    ?C                   Endsr                                                  END PRP CHANGE
018400000000    ? *___________________________________________________________________
018500000000    ? * Prepare COPY request
018600000000    ? *___________________________________________________________________
018700000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
018800000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
018900070316    ?C                   Call      'UPDUSR  '                                   PROCESS REC IO
019000000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
019100000000    ?C                   Parm                    WWRTN                          RETURN CODE
019200000614    ?C                   Parm                    WUDTA                          REC DATA
019300050413    ?C                   Parm                    Whist             3            DATA
019400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
019500000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
019600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
019700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019800000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
019900000000X001?C                   Else                                                   ELSE
020000000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
020100070316     C     OUBEDT        MULT      10000.0001    WSBEDT
020200070316     C     OUENDT        MULT      10000.0001    WSENDT
020300070316     C     OUADDT        MULT      10000.0001    WSADDT
020400070316     C     OUCHDT        MULT      10000.0001    WSCHDT
020500121221    ? *
020600121221     C     OUEMEX        Chain     SLCOLELF
020700121221     C                   If        %found(SLCOLELF)
020800121221     C                   Eval      WSOLE = %trim(SLDESC)
020900121221     C                   Else
021000121221     C                   Eval      WSOLE = *blanks
021100121221     C                   End
021200121221    ? *
021300000000E001?C                   Endif                                                  END IF ERROR
021400000000    ?C                   Endsr                                                  END PREP COPY
021500000000    ? *___________________________________________________________________
021600000000    ? * Default Data
021700000000    ? *___________________________________________________________________
021800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
021900070316    ?C                   Call      'CHKUSR  '                                   PROCESS REC IO
022000000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
022100000000    ?C                   Parm                    WWRTN                          RETURN CODE
022200200423    ?C                   Parm                    WUDTA                          REC DATA
022300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
022400000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
022500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
022600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
022700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
022800000000E001?C                   Endif                                                  END IF ERROR
022900061221    ?C****               Movel     WTM(11)       WWMSG                          PASS MESSAGE
023000061221    ?C****               Exsr      SNDMSG                                       SEND MESSAGE
023100061221    ?C****               Move      'ERROR   '    WORTN                          RETURN ERROR
023200061221    ?C****               Move      'END'         WWSTT                          EXIT CHG PGM
023300061221     C****               Leave
023400000000    ?C                   Endsr                                                  END DFTDTA
023500000000    ? *___________________________________________________________________
023600000000    ? * Process ERROR function
023700000000    ? *___________________________________________________________________
023800000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
023900000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
024000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
024100000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
024200000000    ?C                   Move      'END'         WWSTT                          END STATE
024300000000    ?C                   Endsr                                                  END PRCERR
024400000000    ? *___________________________________________________________________
024500000000    ? * Receive messages
024600000000    ? *___________________________________________________________________
024700000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
024800000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
024900000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
025000000000X001?C                   Else                                                   ELSE
025100000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
025200000000E001?C                   Endif                                                  ENDIF NOT NORESET
025300000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
025400000000    ?C                   Movea     *IN           WWIN                           INDICATORS
025500000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
025600000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
025700000000    ?C                   Parm                    WWIN                           INDICATORS
025800000000    ?C                   Parm                    WWRTN                          RETURN CODE
025900000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
026000000000    ?C                   Endsr                                                  END RCV MSG
026100000000    ? *___________________________________________________________________
026200000000    ? * Display panels
026300000000    ? *___________________________________________________________________
026400000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
026500000000    ? *
026600000000    ? * Set PUTOVR based on last display file processed
026700000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
026800000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
026900000000 001?C                   Setoff                                       35        PUTOVR OFF
027000000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
027100000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
027200000000X001?C                   Else                                                   ELSE SAME PGM
027300000000 001?C                   Seton                                        35        PUTOVR ON
027400000000E001?C                   Endif                                                  END IF NEW PGM
027500000000    ? *
027600000614    ? * Set PROTECT key based on request
027700000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
027800000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
027900000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
028000000000 001?C                   Setoff                                       40        NO PROTECT KEY
028100000000X001?C                   Else                                                   ELSE
028200000000 001?C                   Seton                                        40        PROTECT KEY
028300000000E001?C                   Endif                                                  END IF ADD
028400000000    ? *
028500000000    ? * Select title
028600000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
028700000000 001?C                   Setoff                                       38        CHANGE TITLE
028800000000X001?C                   Else                                                   ELSE
028900000000 001?C                   Seton                                        38        ADD TITLE
029000000000E001?C                   Endif                                                  END IF CHANGE
029100000000    ? *
029200000000    ? * Position cursor based on error status
029300000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
029400000000 001?C                   Seton                                        99        POS CSR TO ERROR
029500000000X001?C                   Else                                                   ELSE
029600000000 001?C                   Setoff                                       99        POS CSR TO FIRST
029700000000E001?C                   Endif                                                  END IF ERROR
029800000000    ? *
029900000000    ? * Write message subfile
030000000000    ?C                   Seton                                        30        MSGSFL DISPLAY
030100000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
030200000000    ? *
030300000000    ? * Write entry panel
030400000000B001?C                   Select
030500000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
030600000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
030700000000 001?C                   Setoff                                       37        RESET CRSLOC
030800000000E001?C                   Endsl                                                  END SELECT
030900000000    ? *
031000000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
031100000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
031200000000E001?C                   Endif                                                  END IF DATA CHG
031300000000    ?C                   Endsr                                                  END DSPENT
031400000000    ? *___________________________________________________________________
031500000000    ? * Process function key
031600000000    ? *___________________________________________________________________
031700000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
031800991108    ?C                   Movea     *IN           WWIN                           INDICATORS
031900991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
032000000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
032100000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
032200000000    ?C                   Parm                    WAD                            FNC DESC
032300991108    ?C                   Parm                    WWIN                           AID BYTE
032400000000    ?C                   Parm                    WAF                            FNC KEY TABLE
032500000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
032600000000    ?C                   Endsr                                                  END PRCFKY
032700000000    ? *___________________________________________________________________
032800000000    ? * Process KEYS function
032900000000    ? *___________________________________________________________________
033000000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
033100000000    ?C                   Z-add     1             WW                             KEY DSC IDX
033200000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
033300000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
033400000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
033500000000 001? *
033600000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
033700000000 002?C                   Z-add     1             WWFKS                          SET TO 1
033800000000E002?C                   Endif                                                  END IF OVER 3
033900000000 001? *
034000000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
034100000000 001?C                   Sub       1             WW                             KEY DESCR IDX
034200000000E001?C                   Enddo                                                  END DO KEYS
034300000000    ? *
034400000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
034500000000    ?C                   Add       1             WW                             BUMP IDX
034600000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
034700000000    ?C                   Endsr                                                  END PRCDKY
034800000000    ? *___________________________________________________________________
034900000000    ? * Process EXIT Function
035000000000    ? *___________________________________________________________________
035100000000    ?C     PRCEXT        Begsr                                                  RETURN
035200000000    ? *
035300000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
035400000000    ? *
035500000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
035600000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
035700000000X001?C                   Else                                                   ELSE NO ERRORS
035800000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
035900000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
036000000000E001?C                   Endif                                                  END IF ERRORS
036100000000    ?C                   Endsr                                                  END PRCEXT
036200000000    ? *___________________________________________________________________
036300000000    ? * Process PROMPT function
036400000000    ? *___________________________________________________________________
036500000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
036600000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
036700000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
036800000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
036900000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
037000061130      *
037100121012B001 C                   Select
037200121012 001 C                   When      WSFLD = 'OUEMEX'
037201220128
037202220128
037203220128        wn0026R( pCode : pDesc : pCancel );
037204220128        if pCancel = '';
037205220128          ouemex = pCode;
037206220128          wsole = pDesc;
037207220128        EndIf;
037208220128
037209220128
037210220128
037300220128     C**                 Call      'SLCOLE'                                     *ENTRY LIST
037400220128     C**                 Parm                    WWRQS                          PROGRAM REQUEST
037500220128     C**                 Parm                    WWRTN                          RETURN CODE
037600220128     C**                 Parm                    WUPGM                          LAST PGM NAME
037700220128     C**                 Parm                    WCDTA                          RECORD DS
037800220128     C**                 If        WWRTN = *BLANKS
037900220128    ?C**                 Eval      OUEMEX = SLTYPE                              POSITION TO 1
038000220128    ?C**                 Eval      WSOLE  = SLDESC                              POSITION TO 1
038100220128E001 C**                 End
038200121012 001  *
038300121012 001 C                   Other
038400121012 001 C                   Move      WTM(6)        WWMSG
038500121012 001 C                   Exsr      SNDMSG
038600121012E001 C                   Endsl
038700000000    ? *
038800000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
038900000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
039000000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
039100000000    ?C                   Mvr                     WSLIN                          CURSOR COL
039200000000    ?C                   Seton                                        37        SET ON CRSLOC
039300000000    ? *
039400000000    ?C                   Endsr                                                  END PRCPMT
039500000000    ? *___________________________________________________________________
039600000000    ? * Process CANCEL Function
039700000000    ? *___________________________________________________________________
039800000000    ?C     PRCCNL        Begsr                                                  CANCEL
039900000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
040000000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
040100000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
040200000000    ?C                   Endsr                                                  END RETURN
040300000000    ? *___________________________________________________________________
040400000000    ? * Process ROLLUP function
040500000000    ? *___________________________________________________________________
040600000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
040700000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
040800000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
040900000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
041000000000E001?C                   Endif                                                  END IF GT LST PNL
041100000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
041200000000    ?C                   Endsr                                                  END PRCRUP
041300000000    ? *___________________________________________________________________
041400000000    ? * Process ROLLDOWN function
041500000000    ? *___________________________________________________________________
041600000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
041700000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
041800000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
041900000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
042000000000E001?C                   Endif                                                  END IF LT FST PNL
042100000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
042200000000    ?C                   Endsr                                                  END PRCRDN
042300000000    ? *___________________________________________________________________
042400000000    ? * Process ENTER function
042500000000    ? *___________________________________________________________________
042600000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
042700000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
042800000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
042900000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
043000000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
043100000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
043200070316     C                   Z-add     WSBEDT        OUBEDT
043300070316     C                   Z-add     WSENDT        OUENDT
043400070316     C                   Z-add     WSADDT        OUADDT
043500070316     C                   Z-add     WSCHDT        OUCHDT
043600061221
043700061221      * If Add Mode do edit
043800061221     C                   If        *in38 = *on
043900061221     C                   Eval      wwrtn = 'ADD'
044000121107 001?C                   Call      'CHKUSR  '                                   CHECK DATA
044100121107 001?C                   Parm      'EDTADD  '    WWRQS                          EDIT REQUEST
044200121107 001?C                   Parm                    WWRTN                          RETURN CODE
044300121107 001?C                   Parm                    WUDTA                          REC DATA
044400061221     C                   Else
044500061221     C                   Eval      wwrtn = *blanks
044600121107 001?C                   Call      'CHKUSR  '                                   CHECK DATA
044700121107 001?C                   Parm      'EDTCHG  '    WWRQS                          EDIT REQUEST
044800121107 001?C                   Parm                    WWRTN                          RETURN CODE
044900121107 001?C                   Parm                    WUDTA                          REC DATA
045000061221     C                   End
045100061221
045200000000E001?C                   Endif                                                  ENDIF
045300000000    ? *
045400000000B001?C                   Select                                                 PRC RETURN CDE
045500000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
045600000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
045700000000 001? *
045800000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
045900000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
046000000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
046100000000X002?C                   Else                                                   ELSE
046200000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
046300000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
046400000000E002?C                   Endif                                                  IF WARNING
046500000000 001? *
046600000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
046700000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
046800000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
046900000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
047000000000E001?C                   Endsl                                                  RETURN CODE SEL
047100000000    ? *
047200161104
047300161104     C     OUEMEX        Chain     SLCOLELF
047400161104     C                   If        %found(SLCOLELF)
047500161104     C                   Eval      WSOLE = %trim(SLDESC)
047600161104     C                   Else
047700161104     C                   Eval      WSOLE = *blanks
047800161104     C                   End
047900161104
048000000000    ?C                   Endsr                                                  END PRCPNL
048100000000    ? *___________________________________________________________________
048200000000    ? * Process end - write data or release record
048300000000    ? *___________________________________________________________________
048400000000    ?C     PRCEND        Begsr                                                  PROCESS END
048500000000    ? *
048600000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
048700000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
048800000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
048900000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
049000000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
049100000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
049200000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
049300000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
049400000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
049500000000 001?C                   Endcs                                                  END CASE
049600000000 001? *
049700000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
049800000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
049900000000 002? *
050000000000X002?C                   Else                                                   ELSE NO WRT ERR
050100000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
050200000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
050300000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
050400000000 004?C                   Exsr      PRPPNL                                       DO NOT END
050500000810E004?C                   Endif                                                  END IF ADD
050600000000E003?C                   Endif                                                  END IF NOT END
050700000000E002?C                   Endif                                                  END IF WRITE ERROR
050800000000 001? *
050900000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
051000000000 001?C                   Exsr      RELREC                                       RELEASE REC
051100000000E001?C                   Endif                                                  END IF RCD CHANGED
051200000000    ? *
051300000000    ?C                   Endsr                                                  END PRCEND
051400000000    ? *___________________________________________________________________
051500000000    ? * Add new record
051600000000    ? *___________________________________________________________________
051700000000    ?C     WRTADD        Begsr                                                  WRITE ADD
051800000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
051900000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
052000000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
052100000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
052200000000E001?C                   Endif                                                  END IF ADD
052300000000    ? *
052400000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
052500000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
052600000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
052700000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
052800000000E001?C                   Endif                                                  END IF ADD KEY
052900000000    ? *
053000070316    ?C                   Call      'UPDUSR  '                                   PROCESS REC IO
053100000000    ?C                   Parm                    WWRQS                          ADD RECORD
053200000000    ?C                   Parm                    WWRTN                          RETURN CODE
053300000614    ?C                   Parm                    WUDTA                          REC DATA
053400050413    ?C                   Parm                    Whist             3            DATA
053500000000    ? *
053600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
053700000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
053800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
053900000000X001?C                   Else                                                   ELSE
054000000000E001?C                   Endif                                                  END IF CALL ERROR
054100000000    ? *
054200000000    ?C                   Endsr                                                  END WRTADD
054300000000    ? *___________________________________________________________________
054400000000    ? * Write changed record
054500000000    ? *___________________________________________________________________
054600000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
054700070316    ?C                   Call      'UPDUSR  '                                   PROCESS REC IO
054800000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
054900000000    ?C                   Parm                    WWRTN                          RETURN CODE
055000000614    ?C                   Parm                    WUDTA                          REC DATA
055100050413    ?C                   Parm                    Whist             3            DATA
055200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
055300121009 001?C***                Movel     WTM(2)        WWMSG                          PASS MESSAGE
055400121009 001?C***                Exsr      SNDMSG                                       SEND MESSAGE
055500000000E001?C                   Endif                                                  END IF CALL ERROR
055600000000    ? *
055700000000    ?C                   Endsr                                                  END WRTCHG
055800000000    ? *___________________________________________________________________
055900000000    ? * Release record
056000000000    ? *___________________________________________________________________
056100000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
056200070316    ?C                   Call      'UPDUSR  '                                   PROCESS REC IO
056300000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
056400000000    ?C                   Parm                    WWRTN                          RETURN CODE
056500000614    ?C                   Parm                    WUDTA                          REC DATA
056600050413    ?C                   Parm                    Whist             3            DATA
056700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
056800000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
056900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
057000000000E001?C                   Endif                                                  END IF CALL ERROR
057100000000    ?C                   Endsr                                                  END RELREC
057200000000    ? *___________________________________________________________________
057300000000    ? * Build function keys
057400000000    ? *___________________________________________________________________
057500000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
057600991108    ?C                   Movea     *IN           WWIN                           INDICATORS
057700991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
057800000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
057900000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
058000000000    ?C                   Parm                    WAD                            FNC DESC
058100991108    ?C                   Parm                    WWIN                           AID BYTE
058200000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
058300000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
058400000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
058500000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
058600000000    ?C                   Sub       1             WW                             BUMP IDX
058700000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
058800000000    ?C                   Endsr                                                  END BLD FNCTNS
058900000000    ? *___________________________________________________________________
059000000000    ? * Send message
059100000000    ? *___________________________________________________________________
059200000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
059300000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
059400000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
059500000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
059600000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
059700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
059800000000    ?C                   Endsr                                                  END SNDMSG
059900000000    ? *___________________________________________________________________
060000000000    ? * Paremater list
060100000000    ? *___________________________________________________________________
060200000000    ?C     PLIST         Begsr                                                  PARM LISTS
060300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
060400000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
060500000000    ?C                   Parm                    WORTN             8            RETURN CODE
060600000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
060700000614    ?C                   Parm                    WUDTA                          RECORD KEY
060800000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
060900050413    ?C                   Parm                    Whist             3            DATA
061000000000    ?C                   Endsr                                                  END PLIST
061100050318    ? *___________________________________________________________________
061200050318    ? * Key lists
061300050318    ? *___________________________________________________________________
061400050318    ?C     KLIST         Begsr                                                  KEY LISTS
061500070316    ?C     AKey          Klist                                                  ACKCTL
061600070316    ?C                   Kfld                    OUTRST
061700070316    ?C                   Kfld                    OUSUB#
061800070316    ?C                   Kfld                    OUACCT                         POSITION TO 1
061900050318    ?C                   Endsr                                                  END KLIST
062000000000    ? *___________________________________________________________________
062100000000    ? * Initialize routine
062200000000    ? *___________________________________________________________________
062300000000    ?C     *INZSR        Begsr                                                  INITIALIZE
062400061201     C     *DATE         Mult      10000.0001    Today             8 0
062500000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
062600000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
062700000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
062800000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
062900000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
063000000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
063100000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
063200000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
063300000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
063400000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
063500000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
063600000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
063700000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
063800000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
063900000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
064000000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
064100000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
064200000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
064300000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
064400000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
064500000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
064600000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
064700000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
064800000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
064900000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
065000070316    ?C                   Movel     'OEUSER  '    WWFIL            10            FILE NAME-NOTES
065100000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
065200000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
065300000000    ?C                   Endsr                                                  END INITIALIZE
065400000000    ? *___________________________________________________________________
065500000000    ? * Program error handler
065600000000    ? *___________________________________________________________________
065700000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
065800000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
065900000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
066000000000    ?C                   Parm                    WQSTSC                         STATUS CODE
066100000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
066200000000    ?C                   Parm                    WQMSG                          MESSAGE ID
066300000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
066400000000    ? *___________________________________________________________________
066500000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06660000000003EXIT    F3=Exit
06670012101204PROMPT  F4=Prompt
06680000000005REFRESH F5=Refresh
06690000070710UPDATE  F10=Update
06700021070812CANCEL  F12=Exit
06710000000025ROLLUP
06720000000026ROLLDOWN
067300000000** WTM
06740007031600Request not supported in program CHGUSR.
06750000000000Update error.  Data was not updated.
06760000000000Duplicate key detected.  Data was NOT added to file.
06770000000000Call to notes ended in error.
06780000000000Initialize error.  Record not initialized.
06790000000000Record not found.
06800000000000Generate error.  Key not generated.
06810000000000Record not available now.
06820000000000The cursor is not in a prompt area.
06830000000000Default error.  Data not defaulted.
06840006120100An active range already exists for the account.
