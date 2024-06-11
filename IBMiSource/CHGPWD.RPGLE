000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300020306    ? *  Description:  Change PassWord Validation User Details
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700020306    ?FCHGPWDD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900020306     FPWVMNU    IF   E           K DISK
001000000000    ? *
001100000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001300000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001400000000    ? *_________________________________________________________________________
001500000406    ? * Data structure
001600020306    ?D WUDTA         E DS                  EXTNAME(PWVDTL)
001700020306    ?D WWDTAM        E DS                  EXTNAME(PWVMNU)
001800000000    ? *
001900000000    ? * Program status data structure
002000991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002100000000    ? *
002200000000    ? * Display file data structure
002300991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002400000000    ? *
002500000000    ? * CURSOR LOCATION
002600000000    ?D                 DS
002700000000    ?D  WWCRSL                 1      2
002800000000    ?D  WWCRSN                 1      2B 0
002900000000    ? *_________________________________________________________________________
003000000000    ? *
003100000614    ? * Process Entry Panel
003200000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
003300000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
003400000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
003500000000E001?C                   Endif                                                  END COPY/CPYKEY
003600000000    ? *
003700000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
003800000000    ? *
003900000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004000000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004100000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
004200000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004300000000 001? *
004400000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
004500000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
004600000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
004700000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
004800000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
004900000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
005000000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005100000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
005200000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
005300000000 001?C                   Endcs                                                  END CASE
005400000000 001? *
005500000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
005600000000 002?C                   Exsr      PRCEND                                       PROCESS END
005700000000E002?C                   Endif                                                  END IF END REQ
005800000000E001?C                   Enddo                                                  END DOWHILE
005900000000    ? *
006000000707    ? * Send Info Updated message.
006100000707     C     WwChg         Ifeq      'Y'
006200000707     C                   Movel     'UPDATE  '    WORTN
006300000707     C                   Endif
006400000707    ? *
006500020306     C                   Move      *On           *InLR
006600000000    ?C                   Return                                                 RETURN
006700000000    ? *___________________________________________________________________
006800000000    ? * Prepare panel
006900000000    ? *___________________________________________________________________
007000000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007100000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
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
010300020306     C                   Eval      PDUSER    =   WDUSER
010400000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
010500000000    ?C                   Endsr                                                  END PRP ADD
010600000000    ? *___________________________________________________________________
010700000000    ? * Prepare CHANGE request
010800000000    ? *___________________________________________________________________
010900000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
011000020306    ?C                   Call      'UPDPWD  '                                   PROCESS REC IO
011100000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
011200000000    ?C                   Parm                    WWRTN                          RETURN CODE
011300000614    ?C                   Parm                    WUDTA                          REC DATA
011400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
011500000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
011600000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
011700000000X002?C                   Else                                                   ELSE
011800000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
011900000000E002?C                   Endif                                                  END RCD NOT AVL
012000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
012100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
012200000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
012300000810E001?C                   Endif                                                  END IF ERROR
012400000000    ?C                   Endsr                                                  END PRP CHANGE
012500000000    ? *___________________________________________________________________
012600000000    ? * Prepare COPY request
012700000000    ? *___________________________________________________________________
012800000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
012900000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
013000020306    ?C                   Call      'UPDPWD  '                                   PROCESS REC IO
013100000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
013200000000    ?C                   Parm                    WWRTN                          RETURN CODE
013300000614    ?C                   Parm                    WUDTA                          REC DATA
013400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
013500000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
013600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
013700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013800000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
013900000000X001?C                   Else                                                   ELSE
014000000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
014100020306 001?C                   Clear                   PDUSER                         CLEAR KEY
014200000000E001?C                   Endif                                                  END IF ERROR
014300000000    ?C                   Endsr                                                  END PREP COPY
014400000000    ? *___________________________________________________________________
014500000000    ? * Default Data
014600000000    ? *___________________________________________________________________
014700000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
014800020306    ?C                   Call      'CHKPWD  '                                   PROCESS REC IO
014900000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
015000000000    ?C                   Parm                    WWRTN                          RETURN CODE
015100000614    ?C                   Parm                    WUDTA                          REC DATA
015200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
015300000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
015400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
015500000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015600000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015700000000E001?C                   Endif                                                  END IF ERROR
015800000000    ?C                   Endsr                                                  END DFTDTA
015900000000    ? *___________________________________________________________________
016000000000    ? * Process ERROR function
016100000000    ? *___________________________________________________________________
016200000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
016300000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
016400000000    ?C                   Exsr      SNDMSG                                       SEND MSG
016500000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016600000000    ?C                   Move      'END'         WWSTT                          END STATE
016700000000    ?C                   Endsr                                                  END PRCERR
016800000000    ? *___________________________________________________________________
016900000000    ? * Receive messages
017000000000    ? *___________________________________________________________________
017100000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
017200000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
017300000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
017400000000X001?C                   Else                                                   ELSE
017500000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
017600000000E001?C                   Endif                                                  ENDIF NOT NORESET
017700000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
017800000000    ?C                   Movea     *IN           WWIN                           INDICATORS
017900000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
018000000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
018100000000    ?C                   Parm                    WWIN                           INDICATORS
018200000000    ?C                   Parm                    WWRTN                          RETURN CODE
018300000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
018400000000    ?C                   Endsr                                                  END RCV MSG
018500000000    ? *___________________________________________________________________
018600000000    ? * Display panels
018700000000    ? *___________________________________________________________________
018800000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
018900000000    ? *
019000000000    ? * Set PUTOVR based on last display file processed
019100000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
019200000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
019300000000 001?C                   Setoff                                       35        PUTOVR OFF
019400000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
019500000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
019600000000X001?C                   Else                                                   ELSE SAME PGM
019700000000 001?C                   Seton                                        35        PUTOVR ON
019800000000E001?C                   Endif                                                  END IF NEW PGM
019900000000    ? *
020000000614    ? * Set PROTECT key based on request
020100000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
020200000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
020300000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
020400000000 001?C                   Setoff                                       40        NO PROTECT KEY
020500000000X001?C                   Else                                                   ELSE
020600000000 001?C                   Seton                                        40        PROTECT KEY
020700000000E001?C                   Endif                                                  END IF ADD
020800000000    ? *
020900000000    ? * Select title
021000000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
021100000000 001?C                   Setoff                                       38        CHANGE TITLE
021200000000X001?C                   Else                                                   ELSE
021300000000 001?C                   Seton                                        38        ADD TITLE
021400000000E001?C                   Endif                                                  END IF CHANGE
021500000000    ? *
021600000000    ? * Position cursor based on error status
021700000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
021800000000 001?C                   Seton                                        99        POS CSR TO ERROR
021900000000X001?C                   Else                                                   ELSE
022000000000 001?C                   Setoff                                       99        POS CSR TO FIRST
022100000000E001?C                   Endif                                                  END IF ERROR
022200000000    ? *
022300000000    ? * Write message subfile
022400000000    ?C                   Seton                                        30        MSGSFL DISPLAY
022500000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
022600000000    ? *
022700000000    ? * Write entry panel
022800000000B001?C                   Select
022900000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
023000000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
023100000000 001?C                   Setoff                                       37        RESET CRSLOC
023200000000E001?C                   Endsl                                                  END SELECT
023300000000    ? *
023400000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
023500000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
023600000000E001?C                   Endif                                                  END IF DATA CHG
023700000000    ?C                   Endsr                                                  END DSPENT
023800000000    ? *___________________________________________________________________
023900000000    ? * Process function key
024000000000    ? *___________________________________________________________________
024100000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
024200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
024300991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
024400000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
024500000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
024600000000    ?C                   Parm                    WAD                            FNC DESC
024700991108    ?C                   Parm                    WWIN                           AID BYTE
024800000000    ?C                   Parm                    WAF                            FNC KEY TABLE
024900000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
025000000000    ?C                   Endsr                                                  END PRCFKY
025100000000    ? *___________________________________________________________________
025200000000    ? * Process KEYS function
025300000000    ? *___________________________________________________________________
025400000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
025500000000    ?C                   Z-add     1             WW                             KEY DSC IDX
025600000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
025700000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
025800000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
025900000000 001? *
026000000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
026100000000 002?C                   Z-add     1             WWFKS                          SET TO 1
026200000000E002?C                   Endif                                                  END IF OVER 3
026300000000 001? *
026400000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
026500000000 001?C                   Sub       1             WW                             KEY DESCR IDX
026600000000E001?C                   Enddo                                                  END DO KEYS
026700000000    ? *
026800000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
026900000000    ?C                   Add       1             WW                             BUMP IDX
027000000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
027100000000    ?C                   Endsr                                                  END PRCDKY
027200000000    ? *___________________________________________________________________
027300000000    ? * Process EXIT Function
027400000000    ? *___________________________________________________________________
027500000000    ?C     PRCEXT        Begsr                                                  RETURN
027600000000    ? *
027700000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
027800000000    ? *
027900000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
028000000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
028100000000X001?C                   Else                                                   ELSE NO ERRORS
028200000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
028300000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
028400000000E001?C                   Endif                                                  END IF ERRORS
028500000000    ?C                   Endsr                                                  END PRCEXT
028600000000    ? *___________________________________________________________________
028700000000    ? * Process PROMPT function
028800000000    ? *___________________________________________________________________
028900000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
029000000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
029100000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
029200000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
029300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
029400000000    ? *
029500000000B001?C                   Select                                                 SELECT
029600020306 001? *
029700020306     C                   When      WSFLD    =   'PDMENU' or
029800020306     C                             WSFLD    =   'PDOPTN'
029900020306    ?C                   Call      'SLCPWM'                                     *ENTRY LIST
030000020306    ?C                   Parm                    WWRQS             8            PROGRAM REQUEST
030100020306    ?C                   Parm      *BLANKS       WWRTN             8            RETURN CODE
030200020306    ?C                   Parm                    WUPGM            10            LAST PGM NAME
030300020306    ?C                   Parm                    WWDTAM                         RECORD DS
030400020307     C                   If        WWRTN    =    *BLANKS
030500020307     C                   Dow       WXRTN    =    *BLANKS
030600020306     C                   Eval      PDMENU   =    PMMENU
030700020306     C                   Eval      PDOPTN   =    PMOPTN
030800020307     C                   Exsr      WrtAdd
030900020307     C                   Exsr      SlcNxt
031000020307     C                   Enddo
031100020307     C                   Movel     'UPDATE  '    WORTN
031200020307     C                   Move      *On           *InLR
031300020307    ?C                   Return                                                 RETURN
031400020307     C                   Else
031500020307     C                   Eval      PMDESC   =    *BLANKS
031600020307     C                   End
031700020306 001? *
031800000000 001?C                   Other                                                  WHERE ERROR
031900000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
032000000000 001?C                   Exsr      SNDMSG                                       SEND MSG
032100000000E001?C                   Endsl                                                  END SELECT
032200000000    ? *
032300000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
032400000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
032500000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
032600000000    ?C                   Mvr                     WSLIN                          CURSOR COL
032700000000    ?C                   Seton                                        37        SET ON CRSLOC
032800000000    ? *
032900000000    ?C                   Endsr                                                  END PRCPMT
033000020307    ? *___________________________________________________________________
033100020307    ? * Select NEXT
033200020307    ? *___________________________________________________________________
033300020307    ?C     SLCNXT        Begsr                                                  CANCEL
033400020307    ?C                   Call      'SLCPWM'                                     *ENTRY LIST
033500020307    ?C                   Parm      'SLCNXT'      WWRQS             8            PROGRAM REQUEST
033600020307    ?C                   Parm      *BLANKS       WXRTN             8            RETURN CODE
033700020307    ?C                   Parm                    WUPGM            10            LAST PGM NAME
033800020307    ?C                   Parm                    WWDTAM                         RECORD DS
033900020307    ?C                   Endsr                                                  END PRCPMT
034000000000    ? *___________________________________________________________________
034100000000    ? * Process CANCEL Function
034200000000    ? *___________________________________________________________________
034300000000    ?C     PRCCNL        Begsr                                                  CANCEL
034400000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
034500000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
034600000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
034700000000    ?C                   Endsr                                                  END RETURN
034800000000    ? *___________________________________________________________________
034900000000    ? * Process ROLLUP function
035000000000    ? *___________________________________________________________________
035100000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
035200000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
035300000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
035400000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
035500000000E001?C                   Endif                                                  END IF GT LST PNL
035600000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
035700000000    ?C                   Endsr                                                  END PRCRUP
035800000000    ? *___________________________________________________________________
035900000000    ? * Process ROLLDOWN function
036000000000    ? *___________________________________________________________________
036100000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
036200000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
036300000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
036400000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
036500000000E001?C                   Endif                                                  END IF LT FST PNL
036600000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
036700000000    ?C                   Endsr                                                  END PRCRDN
036800000000    ? *___________________________________________________________________
036900000000    ? * Process ENTER function
037000000000    ? *___________________________________________________________________
037100000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
037200000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
037300000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
037400000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
037500000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
037600000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
037700020306 001?C                   Call      'CHKPWD  '                                   CHECK DATA
037800000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
037900000000 001?C                   Parm                    WWRTN                          RETURN CODE
038000000614 001?C                   Parm                    WUDTA                          REC DATA
038100020306     C     WKMNU         Klist
038200020306     C                   Kfld                    PDMENU
038300020306     C                   Kfld                    PDOPTN
038400020306     C     WKMNU         Chain     PWVMNU
038500020306     C                   If        not %Found
038600020306     C                   Clear                   PMDESC
038700020306E001?C                   End                                                    ENDIF
038800020306E001?C                   Endif                                                  ENDIF
038900000000    ? *
039000000000B001?C                   Select                                                 PRC RETURN CDE
039100000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
039200000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
039300010219 001?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
039400000000 001? *
039500000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
039600000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
039700000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
039800010219 002?C****F10*****       Move      'END'         WWSTT                          END INVOCATION
039900000000X002?C                   Else                                                   ELSE
040000000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
040100000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
040200000000E002?C                   Endif                                                  IF WARNING
040300000000 001? *
040400000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
040500000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
040600000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
040700000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
040800000000E001?C                   Endsl                                                  RETURN CODE SEL
040900000000    ? *
041000000000    ?C                   Endsr                                                  END PRCPNL
041100000000    ? *___________________________________________________________________
041200000000    ? * Process end - write data or release record
041300000000    ? *___________________________________________________________________
041400000000    ?C     PRCEND        Begsr                                                  PROCESS END
041500000000    ? *
041600000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
041700000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
041800000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
041900000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
042000000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
042100000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
042200000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
042300000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
042400000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
042500000000 001?C                   Endcs                                                  END CASE
042600000000 001? *
042700000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
042800000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
042900000000 002? *
043000000000X002?C                   Else                                                   ELSE NO WRT ERR
043100000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
043200000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
043300000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
043400000000 004?C                   Exsr      PRPPNL                                       DO NOT END
043500000810E004?C                   Endif                                                  END IF ADD
043600000000E003?C                   Endif                                                  END IF NOT END
043700000000E002?C                   Endif                                                  END IF WRITE ERROR
043800000000 001? *
043900000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
044000000000 001?C                   Exsr      RELREC                                       RELEASE REC
044100000000E001?C                   Endif                                                  END IF RCD CHANGED
044200000000    ? *
044300000000    ?C                   Endsr                                                  END PRCEND
044400000000    ? *___________________________________________________________________
044500000000    ? * Add new record
044600000000    ? *___________________________________________________________________
044700000000    ?C     WRTADD        Begsr                                                  WRITE ADD
044800000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
044900000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
045000000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
045100000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
045200000000E001?C                   Endif                                                  END IF ADD
045300000000    ? *
045400000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
045500000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
045600000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
045700000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
045800000000E001?C                   Endif                                                  END IF ADD KEY
045900000000    ? *
046000020306    ?C                   Call      'UPDPWD  '                                   PROCESS REC IO
046100000000    ?C                   Parm                    WWRQS                          ADD RECORD
046200000000    ?C                   Parm                    WWRTN                          RETURN CODE
046300000614    ?C                   Parm                    WUDTA                          REC DATA
046400000000    ? *
046500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
046600000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
046700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
046800000000X001?C                   Else                                                   ELSE
046900000000E001?C                   Endif                                                  END IF CALL ERROR
047000000000    ? *
047100000000    ?C                   Endsr                                                  END WRTADD
047200000000    ? *___________________________________________________________________
047300000000    ? * Write changed record
047400000000    ? *___________________________________________________________________
047500000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
047600020306    ?C                   Call      'UPDPWD  '                                   PROCESS REC IO
047700000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
047800000000    ?C                   Parm                    WWRTN                          RETURN CODE
047900000614    ?C                   Parm                    WUDTA                          REC DATA
048000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
048100000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
048200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
048300000000E001?C                   Endif                                                  END IF CALL ERROR
048400000000    ? *
048500000000    ?C                   Endsr                                                  END WRTCHG
048600000000    ? *___________________________________________________________________
048700000000    ? * Release record
048800000000    ? *___________________________________________________________________
048900000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
049000020306    ?C                   Call      'UPDPWD  '                                   PROCESS REC IO
049100000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
049200000000    ?C                   Parm                    WWRTN                          RETURN CODE
049300000614    ?C                   Parm                    WUDTA                          REC DATA
049400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
049500000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
049600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
049700000000E001?C                   Endif                                                  END IF CALL ERROR
049800000000    ?C                   Endsr                                                  END RELREC
049900000000    ? *___________________________________________________________________
050000000000    ? * Build function keys
050100000000    ? *___________________________________________________________________
050200000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
050300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
050400991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
050500000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
050600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
050700000000    ?C                   Parm                    WAD                            FNC DESC
050800991108    ?C                   Parm                    WWIN                           AID BYTE
050900000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
051000000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
051100000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
051200000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
051300000000    ?C                   Sub       1             WW                             BUMP IDX
051400000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
051500000000    ?C                   Endsr                                                  END BLD FNCTNS
051600000000    ? *___________________________________________________________________
051700000000    ? * Send message
051800000000    ? *___________________________________________________________________
051900000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
052000000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
052100000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
052200000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
052300000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
052400000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
052500000000    ?C                   Endsr                                                  END SNDMSG
052600000000    ? *___________________________________________________________________
052700000000    ? * Paremater list
052800000000    ? *___________________________________________________________________
052900000000    ?C     PLIST         Begsr                                                  PARM LISTS
053000000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
053100000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
053200000000    ?C                   Parm                    WORTN             8            RETURN CODE
053300000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
053400000614    ?C                   Parm                    WUDTA                          RECORD KEY
053500000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
053600000000    ?C                   Endsr                                                  END PLIST
053700000000    ? *___________________________________________________________________
053800000000    ? * Initialize routine
053900000000    ? *___________________________________________________________________
054000000000    ?C     *INZSR        Begsr                                                  INITIALIZE
054100000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
054200000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
054300000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
054400000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
054500000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
054600000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
054700000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
054800000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
054900000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
055000020306    ?C     *LIKE         Define    PDUSER        WDUSER                         FUNCTIONS VALID
055100020306    ?C                   Move      PDUSER        WDUSER                         FUNCTIONS VALID
055200000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
055300000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
055400000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
055500000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
055600000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
055700000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
055800000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
055900000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
056000000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
056100000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
056200000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
056300000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
056400000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
056500000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
056600000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
056700000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
056800020306    ?C                   Movel     'PWVDTL  '    WWFIL            10            FILE NAME-NOTES
056900000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
057000000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
057100000000    ?C                   Endsr                                                  END INITIALIZE
057200000000    ? *___________________________________________________________________
057300000000    ? * Program error handler
057400000000    ? *___________________________________________________________________
057500000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
057600000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
057700000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
057800000000    ?C                   Parm                    WQSTSC                         STATUS CODE
057900000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
058000000000    ?C                   Parm                    WQMSG                          MESSAGE ID
058100000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
058200000000    ? *___________________________________________________________________
058300000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05840000000003EXIT    F3=Exit
05850000000004PROMPT  F4=Prompt
05860000000005REFRESH F5=Refresh
05870000070710UPDATE  F10=Update
05880000061412CANCEL  F12=Cancel
05890000000025ROLLUP
05900000000026ROLLDOWN
059100000000** WTM
05920002030600Request not supported in program CHGPWD.
05930000000000Update error.  Data was not updated.
05940000000000Duplicate key detected.  Data was NOT added to file.
05950000000000Call to notes ended in error.
05960000000000Initialize error.  Record not initialized.
05970000000000Record not found.
05980000000000Generate error.  Key not generated.
05990000000000Record not available now.
06000000000000The cursor is not in a prompt area.
06010000000000Default error.  Data not defaulted.
