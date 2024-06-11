000100220121     h option(*noDebugIO)    DftActGrp(*no)
000200170913
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500061207    ? *  Description:  Change OLE Code Supplemental Data
000600000000    ? *
000700061129    ? *  (c)Copyright 2006 by GBS,Inc.
000800051028    ? *
000900051028    ? *_________________________________________________________________________
001000110331      * Revised by szz 3/31/11  Users could be added if a non-future begin
001100110329      *                          date was entered so now the program will
001200110331      *                          check for a future date before allowing
001300110329      *                          users to be added.
001400170914      *
001500170914      * New Window for AOECOD lookup.
001600170914      * B.Rees  9/14/2015
001700200422      *
001800200422      * Issue with msgf(13) should not be called from there
001900200422      * J.Allen 4/22/2020
002000220121      *  B.Rees  1/20/2022  Converted to use PL Screens.
002001220121      *    * New AO Codes Screen
002100220121      *-------------------------------------------------------------
002200061129    ?FCHGOSPD   CF   E             WORKSTN
002300000000    ?F                                     INFDS(DSPD)
002301220121     F                                     HANDLER('PROFOUNDUI(HANDLER)')
002400061129    ?FACCOSP    If   E           k Disk
002500061212    ?FAOECOD    If   E           k Disk
002600111017     FACCMST    IF   E           K Disk
002700111017     FACCMSP    IF   E           K Disk
002800000000    ? *
002900120228     D ALLOW           s              1a   inz
003000120228    ? *
003100000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
003200000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
003300110331    ?D WTM             S             80    DIM(13) CTDATA PERRCD(1)             PANEL MESSAGES
003400000000    ? *_________________________________________________________________________
003500000406    ? * Data structure
003600111017    ?D WUDTA         E DS                  EXTNAME(ACCOSP)
003700000000    ? *
003800000000    ? * Program status data structure
003900991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
004000000000    ? *
004100000000    ? * Display file data structure
004200991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
004300000000    ? *
004400000000    ? * CURSOR LOCATION
004500000000    ?D                 DS
004600000000    ?D  WWCRSL                 1      2
004700000000    ?D  WWCRSN                 1      2B 0
004800061129     D WWTRST          S                   LIKE(AOTRST)
004900061129     D WWSUB#          S                   LIKE(AOSUB#)
005000061129     D WWACCT          S                   LIKE(AOACCT)
005100170914br01 D Cancel          s              1
005200000000    ? *_________________________________________________________________________
005300120228     C                   If        %trim(WORTN) = '*ALLOW'
005400120228     C                   eval      allow = 'Y'
005500120228     C                   eval      *in75 = *on
005600120228     C                   else
005700120228     C                   eval      allow = 'N'
005800120228     C                   eval      *in75 = *off
005900120228     C                   end
006000120228     C                   eval      wortn = *blanks
006100000000    ? *
006200000614    ? * Process Entry Panel
006300000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
006400000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
006500000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
006600000000E001?C                   Endif                                                  END COPY/CPYKEY
006700100518    ? *
006800100518     C                   Select
006900100518     C                   When      WIRQS = 'ADD    '
007000210708     C                   Eval      WIFKV = 'X 0308'
007100100518     C                   Other
007200210708     C                   Eval      WIFKV = 'X 0310'
007300100518     C                   Endsl
007400000000    ? *
007500111017     C                   Move      WUDTA         SAVEWAS
007600070417    ? *
007700000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
007800000000    ? *
007900000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
008000000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
008100000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
008200000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
008300000000 001? *
008400000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
008500000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
008600000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
008700000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
008800000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
008900000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
009000000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
009100000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
009200000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
009300070316 001?C     WWFKA         Caseq     'USERS   '    PRCUSR                         ENTER
009400000000 001?C                   Endcs                                                  END CASE
009500000000 001? *
009600000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
009700000000 002?C                   Exsr      PRCEND                                       PROCESS END
009800000000E002?C                   Endif                                                  END IF END REQ
009900000000E001?C                   Enddo                                                  END DOWHILE
010000000000    ? *
010100000707    ? * Send Info Updated message.
010200000707     C     WwChg         Ifeq      'Y'
010300000707     C                   Movel     'UPDATE  '    WORTN
010400000707     C                   Endif
010500000707    ? *
010600220121    ?C**                 Return                                                 RETURN
010601220121
010602220121       *inlr = *on;
010603220121
010700000000    ? *___________________________________________________________________
010800000000    ? * Prepare panel
010900000000    ? *___________________________________________________________________
011000000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
011100000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
011200050317    ?C                   Move      *ZEROS        WSBEDT                         RETURN CODE
011300050317    ?C                   Move      *ZEROS        WSENDT                         RETURN CODE
011400061212     C                   Move      *Blanks       WSDESC
011500991108    ?C                   Move      'N'           WWERR                          NO ERRORS
011600000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
011700000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
011800000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
011900000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
012000000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
012100000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
012200000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
012300000000    ? *
012400000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
012500000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
012600000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
012700000000E002?C                   Endif                                                  ENDIF SAME REQUEST
012800000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
012900000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
013000050318      *
013100061129     C                   Eval      WWTRST = AOTRST
013200061129     C                   Eval      WWSUB# = AOSUB#
013300061129     C                   Eval      WWACCT = AOACCT
013400061212     C                   Clear                   WSDESC
013500070315 001?C                   If        WIRQS  = 'ADD '                              SAVE REQUEST
013600070315     C                   Clear                   AOCODE
013700070417     C                   End
013800061212     C     AOCODE        Chain     AOECOD
013900061212     C                   If        %Found(AOECOD)
014000070315     C                   If        AEPERF   =    'Y'
014100070315     C                   Eval      *In70    =    *On
014200070315     C                   Else
014300070315     C                   Eval      *In70    =    *Off
014400070315     C                   Clear                   AOPERF
014500070315     C                   End
014600061212     C                   Eval      WSDESC   =    %Trim(AEDESC)
014700070510     C                   Else
014800070315     C                   Eval      *In70    =    *Off
014900070315     C                   Clear                   AOPERF
015000061212     C                   End
015100061129     C                   Movel     AOTRST        Trst              3
015200061129     C                   Movel     AOSUB#        Sub#              3
015300061129     C                   Movel     AOACCT        Acct              4
015400050318     C     AKey          Chain     ACCMST
015500050318     C                   If        %Found(ACCMST)
015600050318     C                   Eval      WWNAME  = %trim(Trst) + '-'   +
015700050318     C                                       %trim(Sub#) + '-'   +
015800050318     C                                       %trim(Acct) + '  '  +
015900050318     C                                       %trim(ACNAM1)
016000050318     C                   Movel(P)  WWNAME        WISTR
016100051028     C                   Z-add     60            WILEN
016200050318     C                   Call      'UTLCENSTR'
016300050318     C                   Parm                    WISTR           256
016400050318     C                   Parm                    WILEN             3 0
016500050318     C                   Movel     WISTR         WWNAME
016600050318     C                   End
016700120228    ? *
016800120228     C                   If        %trim(allow) = 'Y'
016900120228     C                   eval      *in75 = *on
017000120228     C                   end
017100000000    ? *
017200000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
017300000000    ? *
017400000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
017500000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
017600000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
017700000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
017800000000    ?C                   Cas                     PRCERR                         PROC ERROR
017900000000    ?C                   Endcs                                                  END CASE
018000000000    ? *
018100000000    ?C                   Endsr                                                  END PRPPNL
018200000000    ? *___________________________________________________________________
018300000000    ? * Prepare ADD request
018400000000    ? *___________________________________________________________________
018500000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
018600061129    ?C                   Clear                   AOBEDT                         CLEAR RECORD
018700061129    ?C                   Clear                   AOENDT                         CLEAR RECORD
018800061129    ?C                   Clear                   AOCHDT                         CLEAR RECORD
018900061129    ?C                   Clear                   AOCHGU                         CLEAR RECORD
019000070327    ?C                   Clear                   AODTDT                         CLEAR RECORD
019100070327    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
019200070327    ?C                   Clear                   AOCODE                         CLEAR RECORD
019300070327     C                   Clear                   WSDESC
019400000000    ?C                   Endsr                                                  END PRP ADD
019500000000    ? *___________________________________________________________________
019600000000    ? * Prepare CHANGE request
019700000000    ? *___________________________________________________________________
019800000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
019900070402     C                   Movel     AOPERF        CmpPERF           1
020000061129    ?C                   Call      'UPDOSP  '                                   PROCESS REC IO
020100000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
020200000000    ?C                   Parm                    WWRTN                          RETURN CODE
020300000614    ?C                   Parm                    WUDTA                          REC DATA
020400050413    ?C                   Parm                    Whist             3            DATA
020500070402     C                   Parm                    CmpPERF
020600070417     C                   Parm                    SAVEWAS
020700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
020800000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
020900000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
021000000000X002?C                   Else                                                   ELSE
021100000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
021200000000E002?C                   Endif                                                  END RCD NOT AVL
021300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
021400000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
021500000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
021600000810E001?C                   Else                                                   END IF ERROR
021700061129     C     AOBEDT        MULT      10000.0001    WSBEDT
021800061129     C     AOENDT        MULT      10000.0001    WSENDT
021900070313     C**** AODTDT        MULT      10000.0001    WSDTDT
022000061212     C                   Clear                   WSDESC
022100061212     C     AOCODE        Chain     AOECOD
022200061212     C                   If        %Found(AOECOD)
022300061212     C                   Eval      WSDESC   =    %Trim(AEDESC)
022400061212     C                   End
022500000810E001?C                   Endif                                                  END IF ERROR
022600000000    ?C                   Endsr                                                  END PRP CHANGE
022700000000    ? *___________________________________________________________________
022800000000    ? * Prepare COPY request
022900000000    ? *___________________________________________________________________
023000000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
023100000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
023200070402     C                   Movel     AOPERF        CmpPERF           1
023300061129    ?C                   Call      'UPDOSP  '                                   PROCESS REC IO
023400000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
023500000000    ?C                   Parm                    WWRTN                          RETURN CODE
023600000614    ?C                   Parm                    WUDTA                          REC DATA
023700050413    ?C                   Parm                    Whist             3            DATA
023800070402     C                   Parm                    CmpPERF
023900070417     C                   Parm                    SAVEWAS
024000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
024100000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
024200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
024300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
024400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
024500000000X001?C                   Else                                                   ELSE
024600000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
024700061129     C     AOBEDT        MULT      10000.0001    WSBEDT
024800061129     C     AOENDT        MULT      10000.0001    WSENDT
024900070313     C***  AODTDT        MULT      10000.0001    WSDTDT
025000061212     C                   Clear                   WSDESC
025100061212     C     AOCODE        Chain     AOECOD
025200061212     C                   If        %Found(AOECOD)
025300061212     C                   Eval      WSDESC   =    %Trim(AEDESC)
025400061212     C                   End
025500000000E001?C                   Endif                                                  END IF ERROR
025600000000    ?C                   Endsr                                                  END PREP COPY
025700000000    ? *___________________________________________________________________
025800000000    ? * Default Data
025900000000    ? *___________________________________________________________________
026000000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
026100061129    ?C                   Call      'CHKOSP  '                                   PROCESS REC IO
026200000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
026300000000    ?C                   Parm                    WWRTN                          RETURN CODE
026400000614    ?C                   Parm                    WUDTA                          REC DATA
026500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
026600000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
026700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
026800000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
026900000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
027000000000E001?C                   Endif                                                  END IF ERROR
027100061201    ? *---                                                             ___
027200061201    ? * Do not allow add if an active ACCOSP record exists
027300061201    ? *---                                                             ___
027400061201     C     AccKey        Setll     ACCOSP
027500061201     C     AccKey        Reade     ACCOSP
027600061201     C                   Dou       %Eof(ACCOSP)
027700061204     C                   If        Not %Eof(ACCOSP)
027800061204      *
027900061212     C     AOCODE        Chain     AOECOD
028000061212     C                   If        %Found(AOECOD)
028100061212     C                   Eval      WSDESC   =    %Trim(AEDESC)
028200061212     C                   End
028300061204     C                   If        (AOBEDT  <   Today    And
028400061204     C                              AOENDT   =  *Zero)
028500061204     C                                    Or
028600061201     C                             (AOBEDT  <   Today    And
028700061204     C                              AOENDT  >   Today)
028800061204      *
028900061221    ?C****               Movel     WTM(11)       WWMSG                          PASS MESSAGE
029000061221    ?C****               Exsr      SNDMSG                                       SEND MESSAGE
029100061221    ?C****               Move      'ERROR   '    WORTN                          RETURN ERROR
029200061221    ?C****               Move      'END'         WWSTT                          EXIT CHG PGM
029300061221     C****               Leave
029400061201     C                   End
029500061204     C                   End
029600061201     C     AccKey        Reade     ACCOSP
029700061201     C                   Enddo
029800000000    ?C                   Endsr                                                  END DFTDTA
029900000000    ? *___________________________________________________________________
030000000000    ? * Process ERROR function
030100000000    ? *___________________________________________________________________
030200000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
030300000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
030400000000    ?C                   Exsr      SNDMSG                                       SEND MSG
030500000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
030600000000    ?C                   Move      'END'         WWSTT                          END STATE
030700000000    ?C                   Endsr                                                  END PRCERR
030800000000    ? *___________________________________________________________________
030900000000    ? * Receive messages
031000000000    ? *___________________________________________________________________
031100000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
031200000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
031300000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
031400000000X001?C                   Else                                                   ELSE
031500000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
031600000000E001?C                   Endif                                                  ENDIF NOT NORESET
031700000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
031800000000    ?C                   Movea     *IN           WWIN                           INDICATORS
031900000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
032000000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
032100000000    ?C                   Parm                    WWIN                           INDICATORS
032200000000    ?C                   Parm                    WWRTN                          RETURN CODE
032300000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
032400000000    ?C                   Endsr                                                  END RCV MSG
032500000000    ? *___________________________________________________________________
032600000000    ? * Display panels
032700000000    ? *___________________________________________________________________
032800000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
032900070510      *
033000070510     C                   Eval      WWTRST = AOTRST
033100070510     C                   Eval      WWSUB# = AOSUB#
033200070510     C                   Eval      WWACCT = AOACCT
033300070510     C                   Clear                   WSDESC
033400070510 001?C****               If        WIRQS  = 'ADD '                              SAVE REQUEST
033500070510     C****               Clear                   AOCODE
033600070510     C****               End
033700070510     C     AOCODE        Chain     AOECOD
033800070510     C                   If        %Found(AOECOD)
033900070510     C                   If        AEPERF   =    'Y'
034000070510     C                   Eval      *In70    =    *On
034100070510     C                   Else
034200070510     C                   Eval      *In70    =    *Off
034300070510     C                   Clear                   AOPERF
034400070510     C                   End
034500070510     C                   Eval      WSDESC   =    %Trim(AEDESC)
034600070510     C                   Else
034700070510     C                   Eval      *In70    =    *Off
034800070510     C                   Clear                   AOPERF
034900070510     C                   End
035000070510     C                   Movel     AOTRST        Trst              3
035100070510     C                   Movel     AOSUB#        Sub#              3
035200070510     C                   Movel     AOACCT        Acct              4
035300070510     C     AKey          Chain     ACCMST
035400070510     C                   If        %Found(ACCMST)
035500070510     C                   Eval      WWNAME  = %trim(Trst) + '-'   +
035600070510     C                                       %trim(Sub#) + '-'   +
035700070510     C                                       %trim(Acct) + '  '  +
035800070510     C                                       %trim(ACNAM1)
035900070510     C                   Movel(P)  WWNAME        WISTR
036000070510     C                   Z-add     60            WILEN
036100070510     C                   Call      'UTLCENSTR'
036200070510     C                   Parm                    WISTR           256
036300070510     C                   Parm                    WILEN             3 0
036400070510     C                   Movel     WISTR         WWNAME
036500070510     C                   End
036600120228    ? *
036700120228     C                   If        %trim(allow) = 'Y'
036800120228     C                   eval      *in75 = *on
036900120228     C                   end
037000070510    ? *
037100000000    ? *
037200000000    ? * Set PUTOVR based on last display file processed
037300000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
037400070315 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
037500000000 001?C                   Setoff                                       35        PUTOVR OFF
037600000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
037700000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
037800000000X001?C                   Else                                                   ELSE SAME PGM
037900000000 001?C                   Seton                                        35        PUTOVR ON
038000000000E001?C                   Endif                                                  END IF NEW PGM
038100000000    ? *
038200000614    ? * Set PROTECT key based on request
038300000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
038400000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
038500000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
038600000000 001?C                   Setoff                                       40        NO PROTECT KEY
038700000000X001?C                   Else                                                   ELSE
038800000000 001?C                   Seton                                        40        PROTECT KEY
038900000000E001?C                   Endif                                                  END IF ADD
039000000000    ? *
039100000000    ? * Select title
039200000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
039300000000 001?C                   Setoff                                       38        CHANGE TITLE
039400000000X001?C                   Else                                                   ELSE
039500000000 001?C                   Seton                                        38        ADD TITLE
039600000000E001?C                   Endif                                                  END IF CHANGE
039700000000    ? *
039800000000    ? * Position cursor based on error status
039900000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
040000000000 001?C                   Seton                                        99        POS CSR TO ERROR
040100000000X001?C                   Else                                                   ELSE
040200000000 001?C                   Setoff                                       99        POS CSR TO FIRST
040300000000E001?C                   Endif                                                  END IF ERROR
040400000000    ? *
040500000000    ? * Write message subfile
040600000000    ?C                   Seton                                        30        MSGSFL DISPLAY
040700000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
040800000000    ? *
040900000000    ? * Write entry panel
041000000000B001?C                   Select
041100000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
041200000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
041300000000 001?C                   Setoff                                       37        RESET CRSLOC
041400000000E001?C                   Endsl                                                  END SELECT
041500000000    ? *
041600000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
041700000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
041800000000E001?C                   Endif                                                  END IF DATA CHG
041900000000    ?C                   Endsr                                                  END DSPENT
042000000000    ? *___________________________________________________________________
042100000000    ? * Process function key
042200000000    ? *___________________________________________________________________
042300000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
042400991108    ?C                   Movea     *IN           WWIN                           INDICATORS
042500991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
042600000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
042700000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
042800000000    ?C                   Parm                    WAD                            FNC DESC
042900991108    ?C                   Parm                    WWIN                           AID BYTE
043000000000    ?C                   Parm                    WAF                            FNC KEY TABLE
043100000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
043200000000    ?C                   Endsr                                                  END PRCFKY
043300000000    ? *___________________________________________________________________
043400000000    ? * Process KEYS function
043500000000    ? *___________________________________________________________________
043600000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
043700000000    ?C                   Z-add     1             WW                             KEY DSC IDX
043800000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
043900000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
044000000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
044100000000 001? *
044200000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
044300000000 002?C                   Z-add     1             WWFKS                          SET TO 1
044400000000E002?C                   Endif                                                  END IF OVER 3
044500000000 001? *
044600000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
044700000000 001?C                   Sub       1             WW                             KEY DESCR IDX
044800000000E001?C                   Enddo                                                  END DO KEYS
044900000000    ? *
045000000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
045100000000    ?C                   Add       1             WW                             BUMP IDX
045200000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
045300000000    ?C                   Endsr                                                  END PRCDKY
045400000000    ? *___________________________________________________________________
045500000000    ? * Process EXIT Function
045600000000    ? *___________________________________________________________________
045700000000    ?C     PRCEXT        Begsr                                                  RETURN
045800080604
045900080604    ? * 3/29/07 per Dave A, go to User mode and do not allow update w/o a user
046000080604     C                   If        WIRQS    =   'ADD '
046100080604    ?C                   Exsr      PRCUSR                                       PROCESS THE PANEL
046200080604     C                   End
046300000000    ? *
046400000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
046500000000    ? *
046600000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
046700000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
046800000000X001?C                   Else                                                   ELSE NO ERRORS
046900000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
047000000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
047100000000E001?C                   Endif                                                  END IF ERRORS
047200080604    ? *
047300000000    ?C                   Endsr                                                  END PRCEXT
047400000000    ? *___________________________________________________________________
047500000000    ? * Process PROMPT function
047600000000    ? *___________________________________________________________________
047700000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
047800000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
047900000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
048000000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
048100111017    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
048200111017    ?C                   Move      AOPERF        WWPERF            1            DON'T CLEAR PGMQ
048300111017      *
048400111017      * Send PAYR code into select to filter out codes
048500111017     C     AKey          Chain     ACCMSP
048600111017     C                   If        %Found(ACCMSP)
048700111017     C                   Eval      WWRTN = %trim(AMPAYR)
048800111017     C                   Else
048900111017     C                   Eval      WWRTN = *blanks
049000111017     C                   End
049100061130      *
049200061130B001 C                   Select
049300061130 001 C                   When      WSFLD = 'AOCODE'
049400170914br01 C*                  Call      'SLCOEC'                                     *ENTRY LIST
049500170914     C*                  Parm                    WWRQS                          PROGRAM REQUEST
049600170914     C*                  Parm                    WWRTN                          RETURN CODE
049700170914     C*                  Parm                    WUPGM                          LAST PGM NAME
049800170914     C*                  Parm                    AOCODE                         RECORD DS
049900170914     C*                  IF        WWRTN = *BLANKS
050000170914
050100220121     C*                  call      'WN0010R'
050101220121     C                   call      'WN0025R'
050200170914     C                   parm                    aoCode
050300170914     C                   parm                    cancel
050400170914
050500170914
050600170914     C                   if        Cancel = ''
050700061212     C     AOCODE        Chain     AOECOD
050800061212     C                   If        %Found(AOECOD)
050900061212     C                   Eval      WSDESC   =    %Trim(AEDESC)
051000061212     C                   End
051100061130E001 C                   Endif
051200111017    ?C                   Move      WWPERF        AOPERF                         DON'T CLEAR PGMQ
051300061130 001  *
051400061130 001 C                   Other
051500061130 001 C                   Move      WTM(6)        WWMSG
051600061130 001 C                   Exsr      SNDMSG
051700061130E001 C                   Endsl
051800000000    ? *
051900000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
052000000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
052100000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
052200000000    ?C                   Mvr                     WSLIN                          CURSOR COL
052300000000    ?C                   Seton                                        37        SET ON CRSLOC
052400000000    ? *
052500000000    ?C                   Endsr                                                  END PRCPMT
052600000000    ? *___________________________________________________________________
052700000000    ? * Process CANCEL Function
052800000000    ? *___________________________________________________________________
052900000000    ?C     PRCCNL        Begsr                                                  CANCEL
053000000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
053100000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
053200000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
053300000000    ?C                   Endsr                                                  END RETURN
053400000000    ? *___________________________________________________________________
053500000000    ? * Process ROLLUP function
053600000000    ? *___________________________________________________________________
053700000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
053800000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
053900000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
054000000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
054100000000E001?C                   Endif                                                  END IF GT LST PNL
054200000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
054300000000    ?C                   Endsr                                                  END PRCRUP
054400000000    ? *___________________________________________________________________
054500000000    ? * Process ROLLDOWN function
054600000000    ? *___________________________________________________________________
054700000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
054800000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
054900000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
055000000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
055100000000E001?C                   Endif                                                  END IF LT FST PNL
055200000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
055300000000    ?C                   Endsr                                                  END PRCRDN
055400070316    ? *___________________________________________________________________
055500070316    ? * Process USERS  function
055600070316    ? *___________________________________________________________________
055700070316    ?C     PRCUSR        Begsr                                                  PROCESS ROLLDOWN
055800110331     C                   If        AOBEDT  <= Today
055900200422    ?C***                Movel     WTM(13)       WWMSG                          PASS MESSAGE
056000200422    ?C***                Exsr      SNDMSG                                       SEND MESSAGE
056100200422    ?C***                Move      'ERROR   '    WORTN                          RETURN ERROR
056200110331     C                   End
056300110331     C                   If        AOBEDT  = *ZEROS
056400200422    ?C***                Movel     WTM(12)       WWMSG                          PASS MESSAGE
056500200422    ?C***                Exsr      SNDMSG                                       SEND MESSAGE
056600200422    ?C***                Move      'ERROR   '    WORTN                          RETURN ERROR
056700110329     C                   Else
056800110329     C                   Exsr      PRCPNL
056900120621     C                   Exsr      WRTCHG2
057000070316    ?C                   Call      'WRKUSRCL'                                   PROCESS REC IO
057100070316    ?C                   Parm                    WUDTA                          REC DATA
057200070316    ?C                   Parm                    Whist             3            DATA
057300100514     C                   End
057400070316    ?C                   Endsr                                                  END PRCRDN
057500000000    ? *___________________________________________________________________
057600000000    ? * Process ENTER function
057700000000    ? *___________________________________________________________________
057800000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
057900000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
058000000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
058100000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
058200000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
058300000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
058400061129     C                   Z-add     WSBEDT        AOBEDT
058500061129     C                   Z-add     WSENDT        AOENDT
058600070313     C***********        Z-add     WSDTDT        AODTDT
058700061221
058800061221      * If Add Mode do edit
058900061221     C                   If        *in38 = *on
059000061221     C                   Eval      wwrtn = 'ADD'
059100061221     C                   Else
059200061221     C                   Eval      wwrtn = *blanks
059300061221     C                   End
059400061221
059500061129 001?C                   Call      'CHKOSP  '                                   CHECK DATA
059600000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
059700000000 001?C                   Parm                    WWRTN                          RETURN CODE
059800000614 001?C                   Parm                    WUDTA                          REC DATA
059900000000E001?C                   Endif                                                  ENDIF
060000000000    ? *
060100070315     C     AOCODE        Chain     AOECOD
060200070315     C                   If        %Found(AOECOD)
060300070315     C                   If        AEPERF   =    'Y'
060400070315     C                   Eval      *In70    =    *On
060500070315     C                   Else
060600070315     C                   Eval      *In70    =    *Off
060700070315     C                   Clear                   AOPERF
060800070315     C                   End
060900070315     C                   Eval      WSDESC   =    %Trim(AEDESC)
061000070315     C                   Else
061100070315     C                   Eval      *In70    =    *Off
061200070315     C                   Clear                   AOPERF
061300070315     C                   End
061400070315     C                   Movel     AOTRST        Trst              3
061500070315     C                   Movel     AOSUB#        Sub#              3
061600070315     C                   Movel     AOACCT        Acct              4
061700070315     C     AKey          Chain     ACCMST
061800070315     C                   If        %Found(ACCMST)
061900070315     C                   Eval      WWNAME  = %trim(Trst) + '-'   +
062000070315     C                                       %trim(Sub#) + '-'   +
062100070315     C                                       %trim(Acct) + '  '  +
062200070315     C                                       %trim(ACNAM1)
062300070315     C                   Movel(P)  WWNAME        WISTR
062400070315     C                   Z-add     60            WILEN
062500070315     C                   Call      'UTLCENSTR'
062600070315     C                   Parm                    WISTR           256
062700070315     C                   Parm                    WILEN             3 0
062800070315     C                   Movel     WISTR         WWNAME
062900070315     C                   End
063000120228    ? *
063100120228     C                   If        %trim(allow) = 'Y'
063200120228     C                   eval      *in75 = *on
063300120228     C                   end
063400070315    ? *
063500000000B001?C                   Select                                                 PRC RETURN CDE
063600000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
063700000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
063800000000 001? *
063900000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
064000000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
064100000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
064200000000X002?C                   Else                                                   ELSE
064300000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
064400000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
064500000000E002?C                   Endif                                                  IF WARNING
064600000000 001? *
064700000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
064800000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
064900000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
065000000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
065100000000E001?C                   Endsl                                                  RETURN CODE SEL
065200000000    ? *
065300000000    ?C                   Endsr                                                  END PRCPNL
065400000000    ? *___________________________________________________________________
065500000000    ? * Process end - write data or release record
065600000000    ? *___________________________________________________________________
065700000000    ?C     PRCEND        Begsr                                                  PROCESS END
065800000000    ? *
065900000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
066000000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
066100000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
066200000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
066300000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
066400000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
066500000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
066600000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
066700000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
066800000000 001?C                   Endcs                                                  END CASE
066900000000 001? *
067000000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
067100000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
067200000000 002? *
067300000000X002?C                   Else                                                   ELSE NO WRT ERR
067400000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
067500000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
067600000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
067700000000 004?C                   Exsr      PRPPNL                                       DO NOT END
067800000810E004?C                   Endif                                                  END IF ADD
067900000000E003?C                   Endif                                                  END IF NOT END
068000000000E002?C                   Endif                                                  END IF WRITE ERROR
068100000000 001? *
068200000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
068300000000 001?C                   Exsr      RELREC                                       RELEASE REC
068400000000E001?C                   Endif                                                  END IF RCD CHANGED
068500000000    ? *
068600000000    ?C                   Endsr                                                  END PRCEND
068700000000    ? *___________________________________________________________________
068800000000    ? * Add new record
068900000000    ? *___________________________________________________________________
069000000000    ?C     WRTADD        Begsr                                                  WRITE ADD
069100000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
069200000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
069300000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
069400000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
069500000000E001?C                   Endif                                                  END IF ADD
069600000000    ? *
069700000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
069800000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
069900000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
070000000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
070100000000E001?C                   Endif                                                  END IF ADD KEY
070200111017
070300070402     C                   Movel     AOPERF        CmpPERF           1
070400061129    ?C                   Call      'UPDOSP  '                                   PROCESS REC IO
070500000000    ?C                   Parm                    WWRQS                          ADD RECORD
070600000000    ?C                   Parm                    WWRTN                          RETURN CODE
070700000614    ?C                   Parm                    WUDTA                          REC DATA
070800050413    ?C                   Parm                    Whist             3            DATA
070900070402     C                   Parm                    CmpPERF
071000070417     C                   Parm                    SAVEWAS
071100000000    ? *
071200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
071300000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
071400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
071500000000X001?C                   Else                                                   ELSE
071600000000E001?C                   Endif                                                  END IF CALL ERROR
071700000000    ? *
071800000000    ?C                   Endsr                                                  END WRTADD
071900000000    ? *___________________________________________________________________
072000000000    ? * Write changed record
072100000000    ? *___________________________________________________________________
072200000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
072300111017
072400061129    ?C                   Call      'UPDOSP  '                                   PROCESS REC IO
072500000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
072600000000    ?C                   Parm                    WWRTN                          RETURN CODE
072700000614    ?C                   Parm                    WUDTA                          REC DATA
072800050413    ?C                   Parm                    Whist             3            DATA
072900070402     C                   Parm                    CmpPERF
073000070417     C                   Parm                    SAVEWAS
073100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
073200121105 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
073300121105 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
073400000000E001?C                   Endif                                                  END IF CALL ERROR
073500000000    ? *
073600000000    ?C                   Endsr                                                  END WRTCHG
073700120621    ? *___________________________________________________________________
073800120621    ? * Write changed record
073900120621    ? *___________________________________________________________________
074000120621    ?C     WRTCHG2       Begsr                                                  WRITE CHANGE
074100120621    ?C                   Call      'UPDOSP  '                                   PROCESS REC IO
074200120621    ?C                   Parm      'CHANG2'      WWRQS                          UPDATE RECORD
074300120621    ?C                   Parm                    WWRTN                          RETURN CODE
074400120621    ?C                   Parm                    WUDTA                          REC DATA
074500120621    ?C                   Parm                    Whist             3            DATA
074600120621     C                   Parm                    CmpPERF
074700120621     C                   Parm                    SAVEWAS
074800120621B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
074900121105 001?C***                Movel     WTM(2)        WWMSG                          PASS MESSAGE
075000121105 001?C***                Exsr      SNDMSG                                       SEND MESSAGE
075100120621E001?C                   Endif                                                  END IF CALL ERROR
075200120621    ? *
075300120621    ?C                   Endsr                                                  END WRTCHG
075400000000    ? *___________________________________________________________________
075500000000    ? * Release record
075600000000    ? *___________________________________________________________________
075700000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
075800070402     C                   Movel     AOPERF        CmpPERF           1
075900061129    ?C                   Call      'UPDOSP  '                                   PROCESS REC IO
076000000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
076100000000    ?C                   Parm                    WWRTN                          RETURN CODE
076200000614    ?C                   Parm                    WUDTA                          REC DATA
076300050413    ?C                   Parm                    Whist             3            DATA
076400070402     C                   Parm                    CmpPERF
076500070417     C                   Parm                    SAVEWAS
076600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
076700000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
076800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
076900000000E001?C                   Endif                                                  END IF CALL ERROR
077000000000    ?C                   Endsr                                                  END RELREC
077100000000    ? *___________________________________________________________________
077200000000    ? * Build function keys
077300000000    ? *___________________________________________________________________
077400000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
077500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
077600991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
077700000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
077800000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
077900000000    ?C                   Parm                    WAD                            FNC DESC
078000991108    ?C                   Parm                    WWIN                           AID BYTE
078100000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
078200000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
078300000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
078400000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
078500000000    ?C                   Sub       1             WW                             BUMP IDX
078600000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
078700000000    ?C                   Endsr                                                  END BLD FNCTNS
078800000000    ? *___________________________________________________________________
078900000000    ? * Send message
079000000000    ? *___________________________________________________________________
079100000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
079200000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
079300000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
079400000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
079500000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
079600000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
079700000000    ?C                   Endsr                                                  END SNDMSG
079800000000    ? *___________________________________________________________________
079900000000    ? * Paremater list
080000000000    ? *___________________________________________________________________
080100000000    ?C     PLIST         Begsr                                                  PARM LISTS
080200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
080300000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
080400000000    ?C                   Parm                    WORTN             8            RETURN CODE
080500000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
080600000614    ?C                   Parm                    WUDTA                          RECORD KEY
080700000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
080800050413    ?C                   Parm                    Whist             3            DATA
080900000000    ?C                   Endsr                                                  END PLIST
081000050318    ? *___________________________________________________________________
081100050318    ? * Key lists
081200050318    ? *___________________________________________________________________
081300050318    ?C     KLIST         Begsr                                                  KEY LISTS
081400050318    ?C     AKey          Klist                                                  ACKCTL
081500061129    ?C                   Kfld                    AOTRST
081600061129    ?C                   Kfld                    AOSUB#
081700061129    ?C                   Kfld                    AOACCT                         POSITION TO 1
081800061201    ?C     AccKey        Klist                                                  ACKCTL
081900061201    ?C                   Kfld                    ACTRST
082000061201    ?C                   Kfld                    ACSUB#
082100061201    ?C                   Kfld                    ACACCT                         POSITION TO 1
082200050318    ?C                   Endsr                                                  END KLIST
082300000000    ? *___________________________________________________________________
082400000000    ? * Initialize routine
082500000000    ? *___________________________________________________________________
082600000000    ?C     *INZSR        Begsr                                                  INITIALIZE
082700061201     C     *DATE         Mult      10000.0001    Today             8 0
082800000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
082900070417     C     *LIKE         Define    WUDTA         SAVEWAS
083000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
083100000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
083200000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
083300000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
083400000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
083500000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
083600000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
083700000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
083800000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
083900000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
084000000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
084100000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
084200000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
084300000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
084400000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
084500000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
084600000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
084700000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
084800000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
084900000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
085000000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
085100000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
085200000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
085300000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
085400061129    ?C                   Movel     'ISCOSP  '    WWFIL            10            FILE NAME-NOTES
085500000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
085600000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
085700000000    ?C                   Endsr                                                  END INITIALIZE
085800000000    ? *___________________________________________________________________
085900000000    ? * Program error handler
086000000000    ? *___________________________________________________________________
086100000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
086200000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
086300000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
086400000000    ?C                   Parm                    WQSTSC                         STATUS CODE
086500000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
086600000000    ?C                   Parm                    WQMSG                          MESSAGE ID
086700000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
086800000000    ? *___________________________________________________________________
086900000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
08700000000003EXIT    F3=Exit
08710006113004PROMPT  F4=Prompt
08720000000005REFRESH F5=Refresh
08730007031608USERS   F8=Users
08740010051810UPDATE  F10=Add Users
08750021070812CANCEL  F12=Exit
08760000000025ROLLUP
08770000000026ROLLDOWN
087800000000** WTM
08790006112900Request not supported in program CHGOSP.
08800000000000Update error.  Data was not updated.
08810000000000Duplicate key detected.  Data was NOT added to file.
08820000000000Call to notes ended in error.
08830000000000Initialize error.  Record not initialized.
08840000000000Record not found.
08850000000000Generate error.  Key not generated.
08860000000000Record not available now.
08870000000000The cursor is not in a prompt area.
08880000000000Default error.  Data not defaulted.
08890006120100An active range already exists for the account.
08900010051800Press F10 to add OLE date range before adding users.
08910011033100Begin Date must be a valid future date (CHGOSP).
