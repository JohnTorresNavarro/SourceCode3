000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300070524    ? *  Description:  Change Online Forms - Plans
000400000000    ? *
000500070524    ? *  (c)Copyright 2007 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700070524    ?FCHGOLPD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000801070524     FCARMST    IF   E           K DISK
000802070524     FOLFCOVTP  IF   E           K DISK
000803071009     FOLFCARTP  IF   E           K DISK
000804071009     FOLFTIERP  IF   E           K DISK
000900000000    ? *
001000000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001100000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001200000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001300000000    ? *_________________________________________________________________________
001400000406    ? * Data structure
001401070524    ?D WUDTA         E DS                  EXTNAME(OLFPLANP)
001402070524    ?D WCDTA         E DS                  EXTNAME(OLFCARTP)
001500070524    ?D WODTA         E DS                  EXTNAME(OLFCOVTP)
001501070524    ?D WADTA         E DS                  EXTNAME(CARMST)
001502071009    ?D WSDTA         E DS                  EXTNAME(OLFSTATP)
001503071009    ?D WTDTA         E DS                  EXTNAME(OLFTIERP)
001600000000    ? *
001700000000    ? * Program status data structure
001800991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001900000000    ? *
002000000000    ? * Display file data structure
002100991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002200000000    ? *
002300000000    ? * CURSOR LOCATION
002400000000    ?D                 DS
002500000000    ?D  WWCRSL                 1      2
002600000000    ?D  WWCRSN                 1      2B 0
002700000000    ? *_________________________________________________________________________
002800000000    ? *
002900000614    ? * Process Entry Panel
003000000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
003100000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
003200000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
003300000000E001?C                   Endif                                                  END COPY/CPYKEY
003400000000    ? *
003500000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
003600000000    ? *
003700000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
003800000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
003900000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
004000000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004100000000 001? *
004200000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
004300000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
004400000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
004500000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
004600000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
004700000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
004800000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004900000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
005000000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
005100000000 001?C                   Endcs                                                  END CASE
005200000000 001? *
005300000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
005400000000 002?C                   Exsr      PRCEND                                       PROCESS END
005500000000E002?C                   Endif                                                  END IF END REQ
005600000000E001?C                   Enddo                                                  END DOWHILE
005700000000    ? *
005800000707    ? * Send Info Updated message.
005900000707     C     WwChg         Ifeq      'Y'
006000000707     C                   Movel     'UPDATE  '    WORTN
006100000707     C                   Endif
006200000707    ? *
006300000000    ?C                   Return                                                 RETURN
006400000000    ? *___________________________________________________________________
006500000000    ? * Prepare panel
006600000000    ? *___________________________________________________________________
006700000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
006800000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
006801070525 003?C                   Move      *blanks       WCARD                          SET CODE
006802070525 003?C                   Move      *blanks       WTYPD                          SET CODE
006900070523    ?C***                Move      *ZEROS        WSDATE                         RETURN CODE
007000070523    ?C***                Move      *ZEROS        WSEFDT                         RETURN CODE
007100070523    ?C***                Move      *ZEROS        WSTRDT                         RETURN CODE
007200991108    ?C                   Move      'N'           WWERR                          NO ERRORS
007300000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
007400000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
007500000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007600000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
007700000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
007800000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
007900000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
008000000000    ? *
008100000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
008200000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
008300000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
008400000000E002?C                   Endif                                                  ENDIF SAME REQUEST
008500000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
008600000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
008700000000    ? *
008800000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
008900000000    ? *
009000000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
009100000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
009200000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
009300000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
009400000000    ?C                   Cas                     PRCERR                         PROC ERROR
009500000000    ?C                   Endcs                                                  END CASE
009600000000    ? *
009700000000    ?C                   Endsr                                                  END PRPPNL
009800000000    ? *___________________________________________________________________
009900000000    ? * Prepare ADD request
010000000000    ? *___________________________________________________________________
010100000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
010200000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
010300000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
010400000000    ?C                   Endsr                                                  END PRP ADD
010500000000    ? *___________________________________________________________________
010600000000    ? * Prepare CHANGE request
010700000000    ? *___________________________________________________________________
010800000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
010900070524    ?C                   Call      'UPDOLP  '                                   PROCESS REC IO
011000000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
011100000000    ?C                   Parm                    WWRTN                          RETURN CODE
011200000614    ?C                   Parm                    WUDTA                          REC DATA
011400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
011500000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
011600000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
011700000000X002?C                   Else                                                   ELSE
011800000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
011900000000E002?C                   Endif                                                  END RCD NOT AVL
012000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
012100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
012200000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
012300000810E001?C                   Else                                                   END IF ERROR
012400070523     C**   IGCHGD        MULT      10000.0001    WSDATE
012500070523     C**   IGEFDT        MULT      10000.0001    WSEFDT
012501071009     C**   IGTRDT        MULT      10000.0001    WSTRDT
012600071009     C     OPTIER        CHAIN     OLFTIERP
012700000810E001?C                   Endif                                                  END IF ERROR
012800000000    ?C                   Endsr                                                  END PRP CHANGE
012900000000    ? *___________________________________________________________________
013000000000    ? * Prepare COPY request
013100000000    ? *___________________________________________________________________
013200000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
013300000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
013400070524    ?C                   Call      'UPDOLP  '                                   PROCESS REC IO
013500000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
013600000000    ?C                   Parm                    WWRTN                          RETURN CODE
013700000614    ?C                   Parm                    WUDTA                          REC DATA
013900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014000000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
014400000000X001?C                   Else                                                   ELSE
014500000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
014501070524 001?C                   Clear                   OPCARC                         CLEAR KEY
014502070524 001?C                   Clear                   OPTYPC                         CLEAR KEY
014600070524 001?C                   Clear                   OPPLAN                         CLEAR KEY
014700000000E001?C                   Endif                                                  END IF ERROR
014800000000    ?C                   Endsr                                                  END PREP COPY
014900000000    ? *___________________________________________________________________
015000000000    ? * Default Data
015100000000    ? *___________________________________________________________________
015200000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
015300070524    ?C                   Call      'CHKOLP  '                                   PROCESS REC IO
015400000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
015500000000    ?C                   Parm                    WWRTN                          RETURN CODE
015600000614    ?C                   Parm                    WUDTA                          REC DATA
015700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015800000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
015900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016000000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016100000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016200000000E001?C                   Endif                                                  END IF ERROR
016300000000    ?C                   Endsr                                                  END DFTDTA
016400000000    ? *___________________________________________________________________
016500000000    ? * Process ERROR function
016600000000    ? *___________________________________________________________________
016700000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
016800000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
016900000000    ?C                   Exsr      SNDMSG                                       SEND MSG
017000000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017100000000    ?C                   Move      'END'         WWSTT                          END STATE
017200000000    ?C                   Endsr                                                  END PRCERR
017300000000    ? *___________________________________________________________________
017400000000    ? * Receive messages
017500000000    ? *___________________________________________________________________
017600000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
017700000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
017800000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
017900000000X001?C                   Else                                                   ELSE
018000000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
018100000000E001?C                   Endif                                                  ENDIF NOT NORESET
018200000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
018300000000    ?C                   Movea     *IN           WWIN                           INDICATORS
018400000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
018500000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
018600000000    ?C                   Parm                    WWIN                           INDICATORS
018700000000    ?C                   Parm                    WWRTN                          RETURN CODE
018800000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
018900000000    ?C                   Endsr                                                  END RCV MSG
019000000000    ? *___________________________________________________________________
019100000000    ? * Display panels
019200000000    ? *___________________________________________________________________
019300000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
019400000000    ? *
019500000000    ? * Set PUTOVR based on last display file processed
019600000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
019700000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
019800000000 001?C                   Setoff                                       35        PUTOVR OFF
019900000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
020000000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
020100000000X001?C                   Else                                                   ELSE SAME PGM
020200000000 001?C                   Seton                                        35        PUTOVR ON
020300000000E001?C                   Endif                                                  END IF NEW PGM
020400000000    ? *
020500000614    ? * Set PROTECT key based on request
020600000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
020700000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
020800000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
020900000000 001?C                   Setoff                                       40        NO PROTECT KEY
020901070525 003?C                   Move      *blanks       WCARD                          SET CODE
020902070525 003?C                   Move      *blanks       WTYPD                          SET CODE
021000000000X001?C                   Else                                                   ELSE
021100000000 001?C                   Seton                                        40        PROTECT KEY
021200000000E001?C                   Endif                                                  END IF ADD
021300000000    ? *
021400000000    ? * Select title
021500000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
021600000000 001?C                   Setoff                                       38        CHANGE TITLE
021700000000X001?C                   Else                                                   ELSE
021800000000 001?C                   Seton                                        38        ADD TITLE
021900000000E001?C                   Endif                                                  END IF CHANGE
022000000000    ? *
022100000000    ? * Position cursor based on error status
022200000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
022300000000 001?C                   Seton                                        99        POS CSR TO ERROR
022400000000X001?C                   Else                                                   ELSE
022500000000 001?C                   Setoff                                       99        POS CSR TO FIRST
022600000000E001?C                   Endif                                                  END IF ERROR
022700000000    ? *
022800000000    ? * Write message subfile
022900000000    ?C                   Seton                                        30        MSGSFL DISPLAY
023000000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
023001070524    ? *
023002070524     C     OKEY          Klist
023003070524     C                   Kfld                    OPCARC
023004070524     C                   Kfld                    OPTYPC
023005070524    ? *
023006070525     C                   Move      *blanks       CNAME
023007070525     C                   Move      *blanks       OCDESC
023008070525    ?C     OPCARC        Chain     CARMST
023009070524 003?C                   Movel     CNAME         WCARD            30            SET CODE
023010070524    ?C     OKEY          Chain     OLFCARTP
023011070524 003?C                   Movel     OCDESC        WTYPD                          SET CODE
023100000000    ? *
023200000000    ? * Write entry panel
023300000000B001?C                   Select
023400000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
023500000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
023600000000 001?C                   Setoff                                       37        RESET CRSLOC
023700000000E001?C                   Endsl                                                  END SELECT
023800000000    ? *
023900000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
024000000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
024100000000E001?C                   Endif                                                  END IF DATA CHG
024200000000    ?C                   Endsr                                                  END DSPENT
024300000000    ? *___________________________________________________________________
024400000000    ? * Process function key
024500000000    ? *___________________________________________________________________
024600000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
024700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
024800991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
024900000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
025000000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
025100000000    ?C                   Parm                    WAD                            FNC DESC
025200991108    ?C                   Parm                    WWIN                           AID BYTE
025300000000    ?C                   Parm                    WAF                            FNC KEY TABLE
025400000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
025500000000    ?C                   Endsr                                                  END PRCFKY
025600000000    ? *___________________________________________________________________
025700000000    ? * Process KEYS function
025800000000    ? *___________________________________________________________________
025900000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
026000000000    ?C                   Z-add     1             WW                             KEY DSC IDX
026100000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
026200000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
026300000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
026400000000 001? *
026500000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
026600000000 002?C                   Z-add     1             WWFKS                          SET TO 1
026700000000E002?C                   Endif                                                  END IF OVER 3
026800000000 001? *
026900000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
027000000000 001?C                   Sub       1             WW                             KEY DESCR IDX
027100000000E001?C                   Enddo                                                  END DO KEYS
027200000000    ? *
027300000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
027400000000    ?C                   Add       1             WW                             BUMP IDX
027500000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
027600000000    ?C                   Endsr                                                  END PRCDKY
027700000000    ? *___________________________________________________________________
027800000000    ? * Process EXIT Function
027900000000    ? *___________________________________________________________________
028000000000    ?C     PRCEXT        Begsr                                                  RETURN
028100000000    ? *
028200000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
028300000000    ? *
028400000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
028500000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
028600000000X001?C                   Else                                                   ELSE NO ERRORS
028700000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
028800000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
028900000000E001?C                   Endif                                                  END IF ERRORS
029000000000    ?C                   Endsr                                                  END PRCEXT
029100000000    ? *___________________________________________________________________
029200000000    ? * Process PROMPT function
029300000000    ? *___________________________________________________________________
029400000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
029500000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
029600000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
029700000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
029800000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
029900000000    ? *
030000000000B001?C                   Select                                                 SELECT
030001070524    ? *
030002070524 001 C                   When      WSFLD = 'OPCARC' or
030003070524 001 C                             WSFLD = 'OPTYPC'
030004070524 001?C                   Call      'SLCOLA  '                                   CALL SELECT PROGRAM
030005070524 001?C                   Parm                    WWRQS                          REQUEST
030006070524 001?C                   Parm                    WWRTN                          RETURN CODE
030007070524 001?C                   Parm                    WUPGM                          PROGRAM
030008070524 001?C                   Parm                    WCDTA                          RECORD DS
030009070524B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030010070524 003?C                   Movel     OCCARC        OPCARC                         SET CODE
030011070524 003?C                   Movel     OCTYPC        OPTYPC                         SET CODE
030012070524 003?C                   Movel     OCDESC        WTYPD                          SET CODE
030013070524E001?C                   Endif
030014070612    ? *
030015070612 001 C                   When      WSFLD = 'OPST01'
030017070612 001?C                   Call      'SLCOLS  '                                   CALL SELECT PROGRAM
030018070612 001?C                   Parm                    WWRQS                          REQUEST
030019070612 001?C                   Parm                    WWRTN                          RETURN CODE
030020070612 001?C                   Parm                    WUPGM                          PROGRAM
030021070612 001?C                   Parm                    WSDTA                          RECORD DS
030022070612B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030023070612 003?C                   Movel     OSTATE        OPST01                         SET CODE
030026070612E001?C                   Endif
030027070612    ? *
030028070612 001 C                   When      WSFLD = 'OPST02'
030029070612 001?C                   Call      'SLCOLS  '                                   CALL SELECT PROGRAM
030030070612 001?C                   Parm                    WWRQS                          REQUEST
030031070612 001?C                   Parm                    WWRTN                          RETURN CODE
030032070612 001?C                   Parm                    WUPGM                          PROGRAM
030033070612 001?C                   Parm                    WSDTA                          RECORD DS
030034070612B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030035070612 003?C                   Movel     OSTATE        OPST02                         SET CODE
030036070612E001?C                   Endif
030037070612    ? *
030038070612 001 C                   When      WSFLD = 'OPST03'
030039070612 001?C                   Call      'SLCOLS  '                                   CALL SELECT PROGRAM
030040070612 001?C                   Parm                    WWRQS                          REQUEST
030041070612 001?C                   Parm                    WWRTN                          RETURN CODE
030042070612 001?C                   Parm                    WUPGM                          PROGRAM
030043070612 001?C                   Parm                    WSDTA                          RECORD DS
030044070612B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030045070612 003?C                   Movel     OSTATE        OPST03                         SET CODE
030046070612E001?C                   Endif
030047070612    ? *
030048070612 001 C                   When      WSFLD = 'OPST04'
030049070612 001?C                   Call      'SLCOLS  '                                   CALL SELECT PROGRAM
030050070612 001?C                   Parm                    WWRQS                          REQUEST
030051070612 001?C                   Parm                    WWRTN                          RETURN CODE
030052070612 001?C                   Parm                    WUPGM                          PROGRAM
030053070612 001?C                   Parm                    WSDTA                          RECORD DS
030054070612B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030055070612 003?C                   Movel     OSTATE        OPST04                         SET CODE
030056070612E001?C                   Endif
030057070612    ? *
030058070612 001 C                   When      WSFLD = 'OPST05'
030059070612 001?C                   Call      'SLCOLS  '                                   CALL SELECT PROGRAM
030060070612 001?C                   Parm                    WWRQS                          REQUEST
030061070612 001?C                   Parm                    WWRTN                          RETURN CODE
030062070612 001?C                   Parm                    WUPGM                          PROGRAM
030063070612 001?C                   Parm                    WSDTA                          RECORD DS
030064070612B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030065070612 003?C                   Movel     OSTATE        OPST05                         SET CODE
030066070612E001?C                   Endif
030067070612    ? *
030068070612 001 C                   When      WSFLD = 'OPST06'
030069070612 001?C                   Call      'SLCOLS  '                                   CALL SELECT PROGRAM
030070070612 001?C                   Parm                    WWRQS                          REQUEST
030071070612 001?C                   Parm                    WWRTN                          RETURN CODE
030072070612 001?C                   Parm                    WUPGM                          PROGRAM
030073070612 001?C                   Parm                    WSDTA                          RECORD DS
030074070612B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030075070612 003?C                   Movel     OSTATE        OPST06                         SET CODE
030076070612E001?C                   Endif
030077070612    ? *
030078070612 001 C                   When      WSFLD = 'OPST07'
030079070612 001?C                   Call      'SLCOLS  '                                   CALL SELECT PROGRAM
030080070612 001?C                   Parm                    WWRQS                          REQUEST
030081070612 001?C                   Parm                    WWRTN                          RETURN CODE
030082070612 001?C                   Parm                    WUPGM                          PROGRAM
030083070612 001?C                   Parm                    WSDTA                          RECORD DS
030084070612B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030085070612 003?C                   Movel     OSTATE        OPST07                         SET CODE
030086070612E001?C                   Endif
030087070612    ? *
030088070612 001 C                   When      WSFLD = 'OPST08'
030089070612 001?C                   Call      'SLCOLS  '                                   CALL SELECT PROGRAM
030090070612 001?C                   Parm                    WWRQS                          REQUEST
030091070612 001?C                   Parm                    WWRTN                          RETURN CODE
030092070612 001?C                   Parm                    WUPGM                          PROGRAM
030093070612 001?C                   Parm                    WSDTA                          RECORD DS
030094070612B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030095070612 003?C                   Movel     OSTATE        OPST08                         SET CODE
030096070612E001?C                   Endif
030097070612    ? *
030098070612 001 C                   When      WSFLD = 'OPST09'
030099070612 001?C                   Call      'SLCOLS  '                                   CALL SELECT PROGRAM
030100070612 001?C                   Parm                    WWRQS                          REQUEST
030101070612 001?C                   Parm                    WWRTN                          RETURN CODE
030102070612 001?C                   Parm                    WUPGM                          PROGRAM
030103070612 001?C                   Parm                    WSDTA                          RECORD DS
030104070612B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030105070612 003?C                   Movel     OSTATE        OPST09                         SET CODE
030106070612E001?C                   Endif
030107070612    ? *
030108070612 001 C                   When      WSFLD = 'OPST10'
030109070612 001?C                   Call      'SLCOLS  '                                   CALL SELECT PROGRAM
030110070612 001?C                   Parm                    WWRQS                          REQUEST
030111070612 001?C                   Parm                    WWRTN                          RETURN CODE
030112070612 001?C                   Parm                    WUPGM                          PROGRAM
030113070612 001?C                   Parm                    WSDTA                          RECORD DS
030114070612B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030115070612 003?C                   Movel     OSTATE        OPST10                         SET CODE
030116070612E001?C                   Endif
030117071009    ? *
030118071009 001 C                   When      WSFLD = 'OPTIER'
030119071009 001?C                   Call      'SLCOLT  '                                   CALL SELECT PROGRAM
030120071009 001?C                   Parm                    WWRQS                          REQUEST
030121071009 001?C                   Parm                    WWRTN                          RETURN CODE
030122071009 001?C                   Parm                    WUPGM                          PROGRAM
030123071009 001?C                   Parm                    WTDTA                          RECORD DS
030124071009B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
030125071009 003?C                   Movel     OTTIER        OPTIER                         SET CODE
030126071009     C     OPTIER        CHAIN     OLFTIERP
030127071009E001?C                   Endif
030128000112 001? *
030200000000 001?C                   Other                                                  WHERE ERROR
030300000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
030400000000 001?C                   Exsr      SNDMSG                                       SEND MSG
030500000000E001?C                   Endsl                                                  END SELECT
030600000000    ? *
030700000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
030800000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
030900000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
031000000000    ?C                   Mvr                     WSLIN                          CURSOR COL
031100000000    ?C                   Seton                                        37        SET ON CRSLOC
031200000000    ? *
031300000000    ?C                   Endsr                                                  END PRCPMT
031400000000    ? *___________________________________________________________________
031500000000    ? * Process CANCEL Function
031600000000    ? *___________________________________________________________________
031700000000    ?C     PRCCNL        Begsr                                                  CANCEL
031800000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
031900000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
032000000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
032100000000    ?C                   Endsr                                                  END RETURN
032200000000    ? *___________________________________________________________________
032300000000    ? * Process ROLLUP function
032400000000    ? *___________________________________________________________________
032500000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
032600000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
032700000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
032800000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
032900000000E001?C                   Endif                                                  END IF GT LST PNL
033000000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
033100000000    ?C                   Endsr                                                  END PRCRUP
033200000000    ? *___________________________________________________________________
033300000000    ? * Process ROLLDOWN function
033400000000    ? *___________________________________________________________________
033500000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
033600000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
033700000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
033800000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
033900000000E001?C                   Endif                                                  END IF LT FST PNL
034000000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
034100000000    ?C                   Endsr                                                  END PRCRDN
034200000000    ? *___________________________________________________________________
034300000000    ? * Process ENTER function
034400000000    ? *___________________________________________________________________
034500000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
034600000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
034700000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
034800000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
034900000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
035000000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
035100070523     C***                Z-add     WSEFDT        IGEFDT
035200070523     C***                Z-add     WSTRDT        IGTRDT
035300070524 001?C                   Call      'CHKOLP  '                                   CHECK DATA
035400000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
035500000000 001?C                   Parm                    WWRTN                          RETURN CODE
035600000614 001?C                   Parm                    WUDTA                          REC DATA
035700000000E001?C                   Endif                                                  ENDIF
035800000000    ? *
035900000000B001?C                   Select                                                 PRC RETURN CDE
036000000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
036100000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
036200010219 001?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
036300000000 001? *
036400000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
036500000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
036600000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
036700010219 002?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
036800000000X002?C                   Else                                                   ELSE
036900000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
037000000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
037100000000E002?C                   Endif                                                  IF WARNING
037200000000 001? *
037300000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
037400000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
037500000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
037600000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
037700000000E001?C                   Endsl                                                  RETURN CODE SEL
037800000000    ? *
037900000000    ?C                   Endsr                                                  END PRCPNL
038000000000    ? *___________________________________________________________________
038100000000    ? * Process end - write data or release record
038200000000    ? *___________________________________________________________________
038300000000    ?C     PRCEND        Begsr                                                  PROCESS END
038400000000    ? *
038500000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
038600000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
038700000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
038800000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
038900000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
039000000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
039100000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
039200000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
039300000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
039400000000 001?C                   Endcs                                                  END CASE
039500000000 001? *
039600000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
039700000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
039800000000 002? *
039900000000X002?C                   Else                                                   ELSE NO WRT ERR
040000000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
040100000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
040200000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
040300000000 004?C                   Exsr      PRPPNL                                       DO NOT END
040400000810E004?C                   Endif                                                  END IF ADD
040500000000E003?C                   Endif                                                  END IF NOT END
040600000000E002?C                   Endif                                                  END IF WRITE ERROR
040700000000 001? *
040800000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
040900000000 001?C                   Exsr      RELREC                                       RELEASE REC
041000000000E001?C                   Endif                                                  END IF RCD CHANGED
041100000000    ? *
041200000000    ?C                   Endsr                                                  END PRCEND
041300000000    ? *___________________________________________________________________
041400000000    ? * Add new record
041500000000    ? *___________________________________________________________________
041600000000    ?C     WRTADD        Begsr                                                  WRITE ADD
041700000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
041800000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
041900000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
042000000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
042100000000E001?C                   Endif                                                  END IF ADD
042200000000    ? *
042300000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
042400000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
042500000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
042600000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
042700000000E001?C                   Endif                                                  END IF ADD KEY
042800000000    ? *
042900070524    ?C                   Call      'UPDOLP  '                                   PROCESS REC IO
043000000000    ?C                   Parm                    WWRQS                          ADD RECORD
043100000000    ?C                   Parm                    WWRTN                          RETURN CODE
043200000614    ?C                   Parm                    WUDTA                          REC DATA
043400000000    ? *
043500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
043600000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
043700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
043800000000X001?C                   Else                                                   ELSE
043900000000E001?C                   Endif                                                  END IF CALL ERROR
044000000000    ? *
044100000000    ?C                   Endsr                                                  END WRTADD
044200000000    ? *___________________________________________________________________
044300000000    ? * Write changed record
044400000000    ? *___________________________________________________________________
044500000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
044600070524    ?C                   Call      'UPDOLP  '                                   PROCESS REC IO
044700000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
044800000000    ?C                   Parm                    WWRTN                          RETURN CODE
044900000614    ?C                   Parm                    WUDTA                          REC DATA
045100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
045200000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
045300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
045400000000E001?C                   Endif                                                  END IF CALL ERROR
045500000000    ? *
045600000000    ?C                   Endsr                                                  END WRTCHG
045700000000    ? *___________________________________________________________________
045800000000    ? * Release record
045900000000    ? *___________________________________________________________________
046000000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
046100070524    ?C                   Call      'UPDOLP  '                                   PROCESS REC IO
046200000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
046300000000    ?C                   Parm                    WWRTN                          RETURN CODE
046400000614    ?C                   Parm                    WUDTA                          REC DATA
046600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
046700000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
046800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
046900000000E001?C                   Endif                                                  END IF CALL ERROR
047000000000    ?C                   Endsr                                                  END RELREC
047100000000    ? *___________________________________________________________________
047200000000    ? * Build function keys
047300000000    ? *___________________________________________________________________
047400000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
047500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
047600991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
047700000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
047800000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
047900000000    ?C                   Parm                    WAD                            FNC DESC
048000991108    ?C                   Parm                    WWIN                           AID BYTE
048100000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
048200000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
048300000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
048400000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
048500000000    ?C                   Sub       1             WW                             BUMP IDX
048600000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
048700000000    ?C                   Endsr                                                  END BLD FNCTNS
048800000000    ? *___________________________________________________________________
048900000000    ? * Send message
049000000000    ? *___________________________________________________________________
049100000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
049200000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
049300000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
049400000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
049500000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
049600000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
049700000000    ?C                   Endsr                                                  END SNDMSG
049800000000    ? *___________________________________________________________________
049900000000    ? * Paremater list
050000000000    ? *___________________________________________________________________
050100000000    ?C     PLIST         Begsr                                                  PARM LISTS
050200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
050300000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
050400000000    ?C                   Parm                    WORTN             8            RETURN CODE
050500000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
050600000614    ?C                   Parm                    WUDTA                          RECORD KEY
050700000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
050900000000    ?C                   Endsr                                                  END PLIST
051000000000    ? *___________________________________________________________________
051100000000    ? * Initialize routine
051200000000    ? *___________________________________________________________________
051300000000    ?C     *INZSR        Begsr                                                  INITIALIZE
051400000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
051500000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
051600000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
051700000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
051800000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
051900000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
052000000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
052100000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
052200000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
052300000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
052400000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
052500000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
052600000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
052700000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
052800000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
052900000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
053000000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
053100000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
053200000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
053300000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
053400000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
053500000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
053600000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
053700000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
053800000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
053900070524    ?C                   Movel     'OLFPLANP'    WWFIL            10            FILE NAME-NOTES
054000000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
054100000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
054200000000    ?C                   Endsr                                                  END INITIALIZE
054300000000    ? *___________________________________________________________________
054400000000    ? * Program error handler
054500000000    ? *___________________________________________________________________
054600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
054700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
054800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
054900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
055000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
055100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
055200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
055300000000    ? *___________________________________________________________________
055400000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05550000000003EXIT    F3=Exit
05560000000004PROMPT  F4=Prompt
05570000000005REFRESH F5=Refresh
05580000070710UPDATE  F10=Update
05590000061412CANCEL  F12=Cancel
05600000000025ROLLUP
05610000000026ROLLDOWN
056200000000** WTM
05630007052400Request not supported in program CHGOLP.
05640000000000Update error.  Data was not updated.
05650000000000Duplicate key detected.  Data was NOT added to file.
05660000000000Call to notes ended in error.
05670000000000Initialize error.  Record not initialized.
05680000000000Record not found.
05690000000000Generate error.  Key not generated.
05700000000000Record not available now.
05710000000000The cursor is not in a prompt area.
05720000000000Default error.  Data not defaulted.
