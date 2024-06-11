000100150202     h option(*noDebugIo)
000200000000    ? *_________________________________________________________________________
000300000000    ? *
000400010914    ? *  Description:  Change Plan Level Text
000500000000    ? *
000600020920    ? *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000700000000    ? *_________________________________________________________________________
000800150202      * * Modifications
000900150202      *
001000150202      * Programmer         Date         MOD
001100150202      *-------------------------------------------------------------------------
001200150202      * B.Rees             02/02/2015   br01
001300150202      *  Added Prompt program for Code Values SLCPCVL
001400150202      *
001500150916      * B.Rees             09/16/2015   br02
001600150916      *  Added Prompt program for Code Values SLCPCCG
001700150916      *
001800150202      *-------------------------------------------------------------------------
001900100520    ?FCHGPCCD   CF   E             WORKSTN
002000000000    ?F                                     INFDS(DSPD)
002100100902     FACCMST    IF   E           K DISK
002200100902     FWEBPAYGRP IF   E           K DISK
002300000000    ? *
002400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002600030313    ?D WTM             S             80    DIM(11) CTDATA PERRCD(1)             PANEL MESSAGES
002700000000    ? *_________________________________________________________________________
002800000406    ? * Data structure
002900100610    ?D WUDTA         E DS                  EXTNAME(WEBPAYCHP)
003000100610    ?D WGDTA         E DS                  EXTNAME(WEBPAYGRP)
003100000000    ? *
003200000000    ? * Program status data structure
003300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003400000000    ? *
003500000000    ? * Display file data structure
003600991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003700000000    ? *
003800000000    ? * CURSOR LOCATION
003900000000    ?D                 DS
004000000000    ?D  WWCRSL                 1      2
004100000000    ?D  WWCRSN                 1      2B 0
004200150202     D
004300150202     d Cancel          s              1a
004400150202     d SavValue        s             20a
004500150202     d SavDesc         s             40a
004600000000    ? *_________________________________________________________________________
004700000000    ? *
004800000614    ? * Process Entry Panel
004900000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
005000000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
005100000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
005200000000E001?C                   Endif                                                  END COPY/CPYKEY
005300000000    ? *
005400000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005500000000    ? *
005600000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005700000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005800000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
005900000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
006000000000 001? *
006100000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
006200000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
006300000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
006400030313 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
006500000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006600000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
006700000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
006800000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
006900000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
007000000000 001?C                   Endcs                                                  END CASE
007100000000 001? *
007200000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
007300000000 002?C                   Exsr      PRCEND                                       PROCESS END
007400000000E002?C                   Endif                                                  END IF END REQ
007500000000E001?C                   Enddo                                                  END DOWHILE
007600000000    ? *
007700000707    ? * Send Info Updated message.
007800000707     C     WwChg         Ifeq      'Y'
007900000707     C                   Movel     'UPDATE  '    WORTN
008000000707     C                   Endif
008100000707    ? *
008200000000    ?C                   Return                                                 RETURN
008300000000    ? *___________________________________________________________________
008400000000    ? * Prepare panel
008500000000    ? *___________________________________________________________________
008600000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008700000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
008800991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008900000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
009000000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
009100000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
009200000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
009300000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
009400000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
009500000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
009600000000    ? *
009700000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
009800000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009900000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
010000000000E002?C                   Endif                                                  ENDIF SAME REQUEST
010100000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
010200000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
010300000000    ? *
010400000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
010500100520    ? *
010600100520     C     KEYACC        Klist
010700100520     C                   kfld                    PCTRST
010800100520     C                   kfld                    PCSUB#
010900100520     C                   kfld                    PCACCT
011000100521     C                   If        PCTRST <> *Zeros
011100100520     C     KEYACC        Chain     ACCMST
011200100520     C                   if        %found(ACCMST)
011300100520     C                   Eval      WWANAM = %trim(ACNAM1)
011400100520     C                   Else
011500100521     C                   Eval      WWANAM = '*INVALID ACCOUNT NUMBER'
011600100521     C                   End
011700100521     C                   Else
011800100521     C                   Eval      WWANAM = '*DEFAULT PAYCHOICE CODE'
011900100520     C                   End
012000100902    ? *
012100100902     C     PCGRPR        Chain     WEBPAYGRP
012200100902     C                   if        not %found(WEBPAYGRP)
012300100902     C                   Clear                   WGDTA
012400100902     C                   end
012500100902    ? *
012600000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
012700000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
012800000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
012900000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
013000000000    ?C                   Cas                     PRCERR                         PROC ERROR
013100000000    ?C                   Endcs                                                  END CASE
013200100902    ? *
013300100902     C                   Eval      *IN75 = *OFF
013400100915     C                   Eval      *IN76 = *OFF
013500100915     C                   Eval      *IN77 = *OFF
013600100915     C                   Eval      *IN78 = *OFF
013700100902     C                   Select
013800100913     C                   When      %trim(PCGRPR) = '401K PLAN'
013900100913     C                   Eval      *IN75 = *ON
014000100915     C                   Eval      *IN76 = *ON
014100130113     C                   When      %trim(PCGRPR) = '401K ROTH'
014200130113     C                   Eval      *IN75 = *ON
014300130113     C                   Eval      *IN76 = *ON
014400100902     C                   When      %trim(PCGRPR) = 'FSA MED'
014500100902     C                   Eval      *IN75 = *ON
014600100902     C                   Eval      *IN76 = *ON
014700100902     C                   When      %trim(PCGRPR) = 'FSA PARK'
014800100902     C                   Eval      *IN75 = *ON
014900100902     C                   Eval      *IN76 = *ON
015000120920     C                   When      %trim(PCGRPR) = 'FSA PREM'
015100120920     C                   Eval      *IN75 = *ON
015200120920     C                   Eval      *IN76 = *ON
015300100902     C                   When      %trim(PCGRPR) = 'FSA TRAN'
015400100902     C                   Eval      *IN75 = *ON
015500100902     C                   Eval      *IN76 = *ON
015600100902     C                   When      %trim(PCGRPR) = 'FSA DEP'
015700100902     C                   Eval      *IN75 = *ON
015800100916     C                   Eval      *IN76 = *ON
015900110103     C                   When      %trim(PCGRPR) = 'LABOR'  AND
016000110103     C                             %trim(PCCODE) = 'I'
016100101115     C                   Eval      *IN77 = *ON
016200101215     C                   When      %trim(PCGRPR) = 'HRSWRK'
016300101215     C                   Eval      *IN78 = *ON
016400100902     C                   Endsl
016500000000    ? *
016600000000    ?C                   Endsr                                                  END PRPPNL
016700000000    ? *___________________________________________________________________
016800000000    ? * Prepare ADD request
016900000000    ? *___________________________________________________________________
017000000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
017100100902    ?C                   Clear                   WUDTA                          CLEAR RECORD
017200100902    ?C                   Clear                   WGDTA                          CLEAR RECORD
017300000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
017400000000    ?C                   Endsr                                                  END PRP ADD
017500000000    ? *___________________________________________________________________
017600000000    ? * Prepare CHANGE request
017700000000    ? *___________________________________________________________________
017800000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
017900100520    ?C                   Call      'UPDPCC  '                                   PROCESS REC IO
018000000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
018100000000    ?C                   Parm                    WWRTN                          RETURN CODE
018200000614    ?C                   Parm                    WUDTA                          REC DATA
018300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
018400000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
018500000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
018600000000X002?C                   Else                                                   ELSE
018700000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
018800000000E002?C                   Endif                                                  END RCD NOT AVL
018900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
019000000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019100000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
019200000810E001?C                   Endif                                                  END IF ERROR
019300000000    ?C                   Endsr                                                  END PRP CHANGE
019400000000    ? *___________________________________________________________________
019500000000    ? * Prepare COPY request
019600000000    ? *___________________________________________________________________
019700000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
019800000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
019900100520    ?C                   Call      'UPDPCC  '                                   PROCESS REC IO
020000000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
020100000000    ?C                   Parm                    WWRTN                          RETURN CODE
020200000614    ?C                   Parm                    WUDTA                          REC DATA
020300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
020400000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
020500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
020600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
020700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
020800000000X001?C                   Else                                                   ELSE
020900000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
021000000000E001?C                   Endif                                                  END IF ERROR
021100000000    ?C                   Endsr                                                  END PREP COPY
021200000000    ? *___________________________________________________________________
021300000000    ? * Default Data
021400000000    ? *___________________________________________________________________
021500000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
021600100520    ?C                   Call      'CHKPCC  '                                   PROCESS REC IO
021700000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
021800000000    ?C                   Parm                    WWRTN                          RETURN CODE
021900000614    ?C                   Parm                    WUDTA                          REC DATA
022000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
022100000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
022200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
022300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
022400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
022500000000E001?C                   Endif                                                  END IF ERROR
022600000000    ?C                   Endsr                                                  END DFTDTA
022700000000    ? *___________________________________________________________________
022800000000    ? * Process ERROR function
022900000000    ? *___________________________________________________________________
023000000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
023100000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
023200000000    ?C                   Exsr      SNDMSG                                       SEND MSG
023300000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
023400000000    ?C                   Move      'END'         WWSTT                          END STATE
023500000000    ?C                   Endsr                                                  END PRCERR
023600000000    ? *___________________________________________________________________
023700000000    ? * Receive messages
023800000000    ? *___________________________________________________________________
023900000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
024000000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
024100000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
024200000000X001?C                   Else                                                   ELSE
024300000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
024400000000E001?C                   Endif                                                  ENDIF NOT NORESET
024500000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
024600000000    ?C                   Movea     *IN           WWIN                           INDICATORS
024700000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
024800000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
024900000000    ?C                   Parm                    WWIN                           INDICATORS
025000000000    ?C                   Parm                    WWRTN                          RETURN CODE
025100000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
025200000000    ?C                   Endsr                                                  END RCV MSG
025300000000    ? *___________________________________________________________________
025400000000    ? * Display panels
025500000000    ? *___________________________________________________________________
025600000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
025700000000    ? *
025800000000    ? * Set PUTOVR based on last display file processed
025900000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
026000000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
026100000000 001?C                   Setoff                                       35        PUTOVR OFF
026200000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
026300000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
026400000000X001?C                   Else                                                   ELSE SAME PGM
026500000000 001?C                   Seton                                        35        PUTOVR ON
026600000000E001?C                   Endif                                                  END IF NEW PGM
026700000000    ? *
026800000614    ? * Set PROTECT key based on request
026900000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
027000000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
027100000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
027200000000 001?C                   Setoff                                       40        NO PROTECT KEY
027300000000X001?C                   Else                                                   ELSE
027400000000 001?C                   Seton                                        40        PROTECT KEY
027500000000E001?C                   Endif                                                  END IF ADD
027600000000    ? *
027700000000    ? * Select title
027800000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
027900000000 001?C                   Setoff                                       38        CHANGE TITLE
028000000000X001?C                   Else                                                   ELSE
028100000000 001?C                   Seton                                        38        ADD TITLE
028200000000E001?C                   Endif                                                  END IF CHANGE
028300000000    ? *
028400000000    ? * Position cursor based on error status
028500000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
028600000000 001?C                   Seton                                        99        POS CSR TO ERROR
028700000000X001?C                   Else                                                   ELSE
028800000000 001?C                   Setoff                                       99        POS CSR TO FIRST
028900000000E001?C                   Endif                                                  END IF ERROR
029000000000    ? *
029100000000    ? * Write message subfile
029200000000    ?C                   Seton                                        30        MSGSFL DISPLAY
029300000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
029400000000    ? *
029500000000    ? * Write entry panel
029600000000B001?C                   Select
029700000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
029800000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
029900000000 001?C                   Setoff                                       37        RESET CRSLOC
030000000000E001?C                   Endsl                                                  END SELECT
030100000000    ? *
030200000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
030300000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
030400000000E001?C                   Endif                                                  END IF DATA CHG
030500000000    ?C                   Endsr                                                  END DSPENT
030600000000    ? *___________________________________________________________________
030700000000    ? * Process function key
030800000000    ? *___________________________________________________________________
030900000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
031000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
031100991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
031200000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
031300000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
031400000000    ?C                   Parm                    WAD                            FNC DESC
031500991108    ?C                   Parm                    WWIN                           AID BYTE
031600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
031700000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
031800000000    ?C                   Endsr                                                  END PRCFKY
031900000000    ? *___________________________________________________________________
032000000000    ? * Process KEYS function
032100000000    ? *___________________________________________________________________
032200000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
032300000000    ?C                   Z-add     1             WW                             KEY DSC IDX
032400000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
032500000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
032600000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
032700000000 001? *
032800000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
032900000000 002?C                   Z-add     1             WWFKS                          SET TO 1
033000000000E002?C                   Endif                                                  END IF OVER 3
033100000000 001? *
033200000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
033300000000 001?C                   Sub       1             WW                             KEY DESCR IDX
033400000000E001?C                   Enddo                                                  END DO KEYS
033500000000    ? *
033600010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
033700010913    ?C                   Add       1             WW                             BUMP IDX
033800010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
033900010913    ?C                   Endsr                                                  END PRCDKY
034000000000    ? *___________________________________________________________________
034100000000    ? * Process EXIT Function
034200000000    ? *___________________________________________________________________
034300000000    ?C     PRCEXT        Begsr                                                  RETURN
034400000000    ? *
034500000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
034600000000    ? *
034700000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
034800000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
034900000000X001?C                   Else                                                   ELSE NO ERRORS
035000000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
035100000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
035200011024E001?C                   Endif                                                  END IF ERRORS
035300100610
035400000000    ?C                   Endsr                                                  END PRCEXT
035500000000    ? *___________________________________________________________________
035600000000    ? * Process PROMPT function
035700000000    ? *___________________________________________________________________
035800000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
035900000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
036000000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
036100000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
036200000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
036300020920    ? *
036400000000B001?C                   Select                                                 SELECT
036500020923    ? *
036600150916br02 C                   When      WSFLD = 'PCGRPR '
036700150916    ?C                   Call      'SLCPCCG '                                   CALL SELECT PROGRAM
036800150916     C                   Parm                    SavValue
036900150916     C                   Parm                    SavDesc
037000150916     C                   Parm                    cancel
037100150916     C                   if        Cancel = *Blanks
037200150916     C                   eval      pcGrpr = SavValue
037300150916     C                   eval      pgGrpr = SavValue
037400150916     C                   eval      pgGrpd = SavDesc
037500150916     C                   eval      wwRtn = *Blanks
037600150916     C                   EndIf
037700150916    ?C                   eval      wuPgm = 'SLCPCCG'                            PROGRAM
037800150916
037900150916
038000150916br01 C                   When      WSFLD = 'PCCODE '
038100150202     C                   Call      'SLCPCVL'                                    CALL SELECT PROGRAM
038200150202     C                   Parm                    pcGrpr                         Grouper Code
038300150202     C                   Parm                    SavValue                       Returned Value
038400150202     C                   Parm                    SavDesc                        Returned Value
038500150202     C                   Parm                    cancel                         Cancel Parm
038600150202     C                   if        Cancel = *Blanks
038700150202     C                   eval      pcCode = SavValue
038800150202     C                   eval      pcDesc = SavDesc
038900150202     C                   EndIf
039000150202 001?C                   eval      wuPgm = 'SLCPCVL'                            PROGRAM
039100150202    ? *
039200000000 001?C                   Other                                                  WHERE ERROR
039300000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
039400000000 001?C                   Exsr      SNDMSG                                       SEND MSG
039500000000E001?C                   Endsl                                                  END SELECT
039600000000    ? *
039700000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
039800000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
039900000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
040000000000    ?C                   Mvr                     WSLIN                          CURSOR COL
040100000000    ?C                   Seton                                        37        SET ON CRSLOC
040200100914    ? *
040300100914    ? * custom
040400100914     C                   Exsr      PRCPNL
040500000000    ? *
040600000000    ?C                   Endsr                                                  END PRCPMT
040700000000    ? *___________________________________________________________________
040800000000    ? * Process CANCEL Function
040900000000    ? *___________________________________________________________________
041000000000    ?C     PRCCNL        Begsr                                                  CANCEL
041100000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
041200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
041300000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
041400000000    ?C                   Endsr                                                  END RETURN
041500000000    ? *___________________________________________________________________
041600000000    ? * Process ROLLUP function
041700000000    ? *___________________________________________________________________
041800000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
041900000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
042000000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
042100000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
042200000000E001?C                   Endif                                                  END IF GT LST PNL
042300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
042400000000    ?C                   Endsr                                                  END PRCRUP
042500000000    ? *___________________________________________________________________
042600000000    ? * Process ROLLDOWN function
042700000000    ? *___________________________________________________________________
042800000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
042900000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
043000000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
043100000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
043200000000E001?C                   Endif                                                  END IF LT FST PNL
043300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
043400000000    ?C                   Endsr                                                  END PRCRDN
043500000000    ? *___________________________________________________________________
043600000000    ? * Process ENTER function
043700000000    ? *___________________________________________________________________
043800000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
043900000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
044000000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
044100000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
044200000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
044300000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
044400100520 001?C                   Call      'CHKPCC  '                                   CHECK DATA
044500000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
044600000000 001?C                   Parm                    WWRTN                          RETURN CODE
044700000614 001?C                   Parm                    WUDTA                          REC DATA
044800000000E001?C                   Endif                                                  ENDIF
044900100521    ? *
045000100521     C                   If        PCTRST <> *Zeros
045100100521     C     KEYACC        Chain     ACCMST
045200100521     C                   if        %found(ACCMST)
045300100521     C                   Eval      WWANAM = %trim(ACNAM1)
045400100521     C                   Else
045500100521     C                   Eval      WWANAM = '*INVALID ACCOUNT NUMBER'
045600100521     C                   End
045700100521     C                   Else
045800100521     C                   Eval      WWANAM = '*DEFAULT PAYCHOICE CODE'
045900100521     C                   End
046000100902    ? *
046100100902     C     PCGRPR        Chain     WEBPAYGRP
046200100902     C                   if        not %found(WEBPAYGRP)
046300100902     C                   Clear                   WGDTA
046400100902     C                   end
046500100902    ? *
046600100902     C                   Eval      *IN75 = *OFF
046700100915     C                   Eval      *IN76 = *OFF
046800100915     C                   Eval      *IN77 = *OFF
046900100915     C                   Eval      *IN78 = *OFF
047000100902     C                   Select
047100100913     C                   When      %trim(PCGRPR) = '401K PLAN'
047200100913     C                   Eval      *IN75 = *ON
047300100915     C                   Eval      *IN76 = *ON
047400130113     C                   When      %trim(PCGRPR) = '401K ROTH'
047500130113     C                   Eval      *IN75 = *ON
047600130113     C                   Eval      *IN76 = *ON
047700100902     C                   When      %trim(PCGRPR) = 'FSA MED'
047800100902     C                   Eval      *IN75 = *ON
047900100902     C                   Eval      *IN76 = *ON
048000120920     C                   When      %trim(PCGRPR) = 'FSA PARK'
048100120920     C                   Eval      *IN75 = *ON
048200120920     C                   Eval      *IN76 = *ON
048300120920     C                   When      %trim(PCGRPR) = 'FSA PREM'
048400100902     C                   Eval      *IN75 = *ON
048500100902     C                   Eval      *IN76 = *ON
048600100902     C                   When      %trim(PCGRPR) = 'FSA TRAN'
048700100902     C                   Eval      *IN75 = *ON
048800100902     C                   Eval      *IN76 = *ON
048900100902     C                   When      %trim(PCGRPR) = 'FSA DEP'
049000100902     C                   Eval      *IN75 = *ON
049100100916     C                   Eval      *IN76 = *ON
049200110103     C                   When      %trim(PCGRPR) = 'LABOR'  AND
049300110103     C                             %trim(PCCODE) = 'I'
049400101115     C                   Eval      *IN77 = *ON
049500101215     C                   When      %trim(PCGRPR) = 'HRSWRK'
049600101215     C                   Eval      *IN78 = *ON
049700100902     C                   Endsl
049800000000    ? *
049900000000B001?C                   Select                                                 PRC RETURN CDE
050000000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
050100000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
050200000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
050300000000 001? *
050400000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
050500000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
050600000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
050700000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
050800000000X002?C                   Else                                                   ELSE
050900000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
051000000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
051100000000E002?C                   Endif                                                  IF WARNING
051200000000 001? *
051300000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
051400000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
051500000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
051600000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
051700000000E001?C                   Endsl                                                  RETURN CODE SEL
051800000000    ? *
051900000000    ?C                   Endsr                                                  END PRCPNL
052000000000    ? *___________________________________________________________________
052100000000    ? * Process end - write data or release record
052200000000    ? *___________________________________________________________________
052300000000    ?C     PRCEND        Begsr                                                  PROCESS END
052400000000    ? *
052500000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
052600000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
052700000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
052800000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
052900000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
053000000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
053100000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
053200000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
053300000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
053400000000 001?C                   Endcs                                                  END CASE
053500000000 001? *
053600000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
053700000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
053800000000 002? *
053900000000X002?C                   Else                                                   ELSE NO WRT ERR
054000000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
054100000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
054200000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
054300000000 004?C                   Exsr      PRPPNL                                       DO NOT END
054400000810E004?C                   Endif                                                  END IF ADD
054500000000E003?C                   Endif                                                  END IF NOT END
054600000000E002?C                   Endif                                                  END IF WRITE ERROR
054700000000 001? *
054800000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
054900000000 001?C                   Exsr      RELREC                                       RELEASE REC
055000000000E001?C                   Endif                                                  END IF RCD CHANGED
055100000000    ? *
055200000000    ?C                   Endsr                                                  END PRCEND
055300000000    ? *___________________________________________________________________
055400000000    ? * Add new record
055500000000    ? *___________________________________________________________________
055600000000    ?C     WRTADD        Begsr                                                  WRITE ADD
055700000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
055800000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
055900000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
056000000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
056100000000E001?C                   Endif                                                  END IF ADD
056200000000    ? *
056300000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
056400000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
056500000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
056600000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
056700000000E001?C                   Endif                                                  END IF ADD KEY
056800000000    ? *
056900100520    ?C                   Call      'UPDPCC  '                                   PROCESS REC IO
057000000000    ?C                   Parm                    WWRQS                          ADD RECORD
057100000000    ?C                   Parm                    WWRTN                          RETURN CODE
057200000614    ?C                   Parm                    WUDTA                          REC DATA
057300000000    ? *
057400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
057500000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
057600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
057700000000X001?C                   Else                                                   ELSE
057800000000E001?C                   Endif                                                  END IF CALL ERROR
057900000000    ? *
058000000000    ?C                   Endsr                                                  END WRTADD
058100000000    ? *___________________________________________________________________
058200000000    ? * Write changed record
058300000000    ? *___________________________________________________________________
058400000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
058500100520    ?C                   Call      'UPDPCC  '                                   PROCESS REC IO
058600000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
058700000000    ?C                   Parm                    WWRTN                          RETURN CODE
058800000614    ?C                   Parm                    WUDTA                          REC DATA
058900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
059000000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
059100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
059200000000E001?C                   Endif                                                  END IF CALL ERROR
059300000000    ? *
059400000000    ?C                   Endsr                                                  END WRTCHG
059500011024    ? *___________________________________________________________________
059600011024    ? * Inz NO Key
059700011024    ? *___________________________________________________________________
059800011024    ?C     INZNKY        Begsr                                                  WRITE CHANGE
059900100520    ?C                   Call      'UPDPCC  '                                   PROCESS REC IO
060000011024    ?C                   Parm      'INZNKY'      WWRQS                          UPDATE RECORD
060100011024    ?C                   Parm                    WWRTN                          RETURN CODE
060200011024    ?C                   Parm                    WUDTA                          REC DATA
060300011024B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
060400011024 001?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
060500011024 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
060600011024E001?C                   Endif                                                  END IF CALL ERROR
060700011024    ? *
060800011024    ?C                   Endsr                                                  END WRTCHG
060900000000    ? *___________________________________________________________________
061000000000    ? * Release record
061100000000    ? *___________________________________________________________________
061200000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
061300100520    ?C                   Call      'UPDPCC  '                                   PROCESS REC IO
061400000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
061500000000    ?C                   Parm                    WWRTN                          RETURN CODE
061600000614    ?C                   Parm                    WUDTA                          REC DATA
061700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
061800000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
061900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
062000000000E001?C                   Endif                                                  END IF CALL ERROR
062100000000    ?C                   Endsr                                                  END RELREC
062200000000    ? *___________________________________________________________________
062300000000    ? * Build function keys
062400000000    ? *___________________________________________________________________
062500000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
062600991108    ?C                   Movea     *IN           WWIN                           INDICATORS
062700991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
062800000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
062900000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
063000000000    ?C                   Parm                    WAD                            FNC DESC
063100991108    ?C                   Parm                    WWIN                           AID BYTE
063200000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
063300000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
063400010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
063500010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
063600010913    ?C                   Sub       1             WW                             BUMP IDX
063700010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
063800000000    ?C                   Endsr                                                  END BLD FNCTNS
063900000000    ? *___________________________________________________________________
064000000000    ? * Send message
064100000000    ? *___________________________________________________________________
064200000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
064300000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
064400000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
064500000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
064600000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
064700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
064800000000    ?C                   Endsr                                                  END SNDMSG
064900000000    ? *___________________________________________________________________
065000000000    ? * Paremater list
065100000000    ? *___________________________________________________________________
065200000000    ?C     PLIST         Begsr                                                  PARM LISTS
065300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
065400000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
065500000000    ?C                   Parm                    WORTN             8            RETURN CODE
065600000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
065700000614    ?C                   Parm                    WUDTA                          RECORD KEY
065800000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
065900000000    ?C                   Endsr                                                  END PLIST
066000000000    ? *___________________________________________________________________
066100000000    ? * Initialize routine
066200000000    ? *___________________________________________________________________
066300000000    ?C     *INZSR        Begsr                                                  INITIALIZE
066400000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
066500000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
066600000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
066700000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
066800000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
066900000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
067000000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
067100000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
067200000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
067300000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
067400000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
067500000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
067600000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
067700000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
067800000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
067900000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
068000000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
068100000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
068200000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
068300000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
068400000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
068500000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
068600000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
068700000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
068800000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
068900100520    ?C                   Movel     'WEBPAYCHP'   WWFIL            10            FILE NAME-NOTES
069000000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
069100000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
069200000000    ?C                   Endsr                                                  END INITIALIZE
069300000000    ? *___________________________________________________________________
069400000000    ? * Program error handler
069500000000    ? *___________________________________________________________________
069600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
069700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
069800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
069900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
070000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
070100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
070200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
070300000000    ? *___________________________________________________________________
070400000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
07050000000003EXIT    F3=Exit
07060000000004PROMPT  F4=Prompt
07070003031305REFRESH F5=Refresh
07080000070710UPDATE  F10=Update
07090000061412CANCEL  F12=Cancel
07100000000025ROLLUP
07110000000026ROLLDOWN
071200000000** WTM
07130010052000Request not supported in program CHGPCC.
07140000000000Update error.  Data was not updated.
07150000000000Duplicate key detected.  Data was NOT added to file.
07160000000000Call to notes ended in error.
07170000000000Initialize error.  Record not initialized.
07180000000000Record not found.
07190000000000Generate error.  Key not generated.
07200000000000Record not available now.
07210000000000The cursor is not in a prompt area.
07220003031300Default error.  Data not defaulted.
07230010052000
