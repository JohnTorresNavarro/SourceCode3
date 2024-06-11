000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300140326    ? *  Description:  Change Longer Names
000400000000    ? *
000500140326    ? *  (c)Copyright 2014 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700140326    ?FCHG100D   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900140326     FMEMBER    IF   E           K DISK    EXTFILE('F.MEMBER')
001000140326     FDEPNDC    IF   E           K DISK    EXTFILE('F.DEPNDC')
001100140326     FCFS100P   IF   E           K DISK
001200000000    ? *
001300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001500030313    ?D WTM             S             80    DIM(11) CTDATA PERRCD(1)             PANEL MESSAGES
001600100618     D WSDESC          S             20A
001700000000    ? *_________________________________________________________________________
001800000406    ? * Data structure
001900140326    ?D WUDTA         E DS                  EXTNAME(CFS100P)
002000000000    ? *
002100000000    ? * Program status data structure
002200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000    ? *
002400000000    ? * Display file data structure
002500991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002600140327
002700140327     D                UDS
002800140327     D  TITLE                201    240
002900000000    ? *
003000000000    ? * CURSOR LOCATION
003100000000    ?D                 DS
003200000000    ?D  WWCRSL                 1      2
003300000000    ?D  WWCRSN                 1      2B 0
003400000000    ? *_________________________________________________________________________
003500000000    ? *
003600000614    ? * Process Entry Panel
003700000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
003800000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
003900000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
004000000000E001?C                   Endif                                                  END COPY/CPYKEY
004100000000    ? *
004200000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004300000000    ? *
004400000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004500000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004600000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
004700000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004800000000 001? *
004900000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
005000000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
005100000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005200030313 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
005300000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005400000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
005500000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005600000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
005700000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
005800000000 001?C                   Endcs                                                  END CASE
005900000000 001? *
006000000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
006100000000 002?C                   Exsr      PRCEND                                       PROCESS END
006200000000E002?C                   Endif                                                  END IF END REQ
006300000000E001?C                   Enddo                                                  END DOWHILE
006400000000    ? *
006500000707    ? * Send Info Updated message.
006600000707     C     WwChg         Ifeq      'Y'
006700000707     C                   Movel     'UPDATE  '    WORTN
006800000707     C                   Endif
006900000707    ? *
007000140408     C                   clear                   WSFST
007100140408     C                   clear                   WSLST
007200140408     C                   clear                   WSMID
007300000000    ?C                   Return                                                 RETURN
007400000000    ? *___________________________________________________________________
007500000000    ? * Prepare panel
007600000000    ? *___________________________________________________________________
007700000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007800000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007900991108    ?C                   Move      'N'           WWERR                          NO ERRORS
008000000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
008100000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
008200000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008300000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008400000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008500000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
008600000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
008700000000    ? *
008800000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
008900000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
009000000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
009100000000E002?C                   Endif                                                  ENDIF SAME REQUEST
009200000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
009300000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
009400000000    ? *
009500000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
009600100520    ? *
009700140326     C     DPKEY         Klist
009800140326     C                   kfld                    CFSSN
009900140326     C                   kfld                    CFSEQ
010000140327
010100140327     C                   exsr      PRPSCR
010200140327
010300100617    ? *
010400000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
010500000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
010600000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
010700000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
010800000000    ?C                   Cas                     PRCERR                         PROC ERROR
010900000000    ?C                   Endcs                                                  END CASE
011000000000    ? *
011100000000    ?C                   Endsr                                                  END PRPPNL
011200140327    ? *___________________________________________________________________
011300140327    ? * Prepare SCREEN
011400140327    ? *___________________________________________________________________
011500140327    ?C     PRPSCR        Begsr                                                  PREP FOR ADD
011600140408    ? *
011700140327     C                   If        CFSEQ = 0
011800140327     C     CFSSN         Chain     MEMBER
011900140327     C                   if        %found(MEMBER)
012000140327     C                   Eval      WSFST  = %trim(MFNAME)
012100140408     C                   Eval      WSLST  = %trim(MLNAME)
012200140408     C                   Eval      WSMID  = %trim(MMI)
012300140327     C                   Else
012400140327     C                   Eval      WSFST = *blanks
012500140408     C                   Eval      WSLST = *blanks
012600140408     C                   Eval      WSMID = *blanks
012700140327     C                   End
012800140327
012900140327     C                   Else
013000140327     C     DPKEY         Chain     DEPNDC
013100140327     C                   if        %found(DEPNDC)
013200140327     C                   Eval      WSFST  = %trim(DFNAME)
013300140327     C                   Eval      WSLST  = %trim(DLNAME)
013400140408     C                   Eval      WSMID  = %trim(DMI)
013500140327     C                   Else
013600140327     C                   Eval      WSFST = *blanks
013700140327     C                   Eval      WSLST = *blanks
013800140408     C                   Eval      WSMID = *blanks
013900140327     C                   End
014000140327     C                   End
014100140327      * Pre-load if blank
014200140327     C                   If        %trim(WSFST) <> *blanks and
014300140327     C                             %trim(CFSFST) = *blanks
014400140327     C                   eval      CFSFST = %trim(WSFST)
014500140327     C                   End
014600140327
014700140327      * Pre-load if blank
014800140327     C                   If        %trim(WSLST) <> *blanks and
014900140327     C                             %trim(CFSLST) = *blanks
015000140327     C                   eval      CFSLST = %trim(WSLST)
015100140327     C                   End
015200140408
015300140408      * Pre-load if blank
015400140408     C                   If        %trim(WSMID) <> *blanks and
015500140408     C                             %trim(CFSMID) = *blanks
015600140408     C                   eval      CFSMID = %trim(WSMID)
015700140408     C                   End
015800140327    ?C                   Endsr                                                  END PRPPNL
015900000000    ? *___________________________________________________________________
016000000000    ? * Prepare ADD request
016100000000    ? *___________________________________________________________________
016200000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
016300000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
016400000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
016500000000    ?C                   Endsr                                                  END PRP ADD
016600000000    ? *___________________________________________________________________
016700000000    ? * Prepare CHANGE request
016800000000    ? *___________________________________________________________________
016900000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
017000140326    ?C                   Call      'UPD100  '                                   PROCESS REC IO
017100000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
017200000000    ?C                   Parm                    WWRTN                          RETURN CODE
017300000614    ?C                   Parm                    WUDTA                          REC DATA
017400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
017500000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
017600000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
017700000000X002?C                   Else                                                   ELSE
017800000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
017900000000E002?C                   Endif                                                  END RCD NOT AVL
018000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018200000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
018300000810E001?C                   Endif                                                  END IF ERROR
018400140327
018500000000    ?C                   Endsr                                                  END PRP CHANGE
018600000000    ? *___________________________________________________________________
018700000000    ? * Prepare COPY request
018800000000    ? *___________________________________________________________________
018900000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
019000000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
019100140326    ?C                   Call      'UPD100  '                                   PROCESS REC IO
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
020200000000E001?C                   Endif                                                  END IF ERROR
020300000000    ?C                   Endsr                                                  END PREP COPY
020400000000    ? *___________________________________________________________________
020500000000    ? * Default Data
020600000000    ? *___________________________________________________________________
020700000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
020800140327
020900140327     C                   exsr      PRPSCR
021000140327
021100140327    ?C                   Call      'CHK100  '                                   PROCESS REC IO
021200140327    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
021300140327    ?C                   Parm                    WWRTN                          RETURN CODE
021400140327    ?C                   Parm                    WUDTA                          REC DATA
021500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
021600000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
021700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
021800000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
021900000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
022000000000E001?C                   Endif                                                  END IF ERROR
022100140327
022200000000    ?C                   Endsr                                                  END DFTDTA
022300000000    ? *___________________________________________________________________
022400000000    ? * Process ERROR function
022500000000    ? *___________________________________________________________________
022600000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
022700000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
022800000000    ?C                   Exsr      SNDMSG                                       SEND MSG
022900000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
023000000000    ?C                   Move      'END'         WWSTT                          END STATE
023100000000    ?C                   Endsr                                                  END PRCERR
023200000000    ? *___________________________________________________________________
023300000000    ? * Receive messages
023400000000    ? *___________________________________________________________________
023500000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
023600000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
023700000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
023800000000X001?C                   Else                                                   ELSE
023900000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
024000000000E001?C                   Endif                                                  ENDIF NOT NORESET
024100000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
024200000000    ?C                   Movea     *IN           WWIN                           INDICATORS
024300000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
024400000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
024500000000    ?C                   Parm                    WWIN                           INDICATORS
024600000000    ?C                   Parm                    WWRTN                          RETURN CODE
024700000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
024800000000    ?C                   Endsr                                                  END RCV MSG
024900000000    ? *___________________________________________________________________
025000000000    ? * Display panels
025100000000    ? *___________________________________________________________________
025200000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
025300000000    ? *
025400000000    ? * Set PUTOVR based on last display file processed
025500000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
025600000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
025700000000 001?C                   Setoff                                       35        PUTOVR OFF
025800000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
025900000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
026000000000X001?C                   Else                                                   ELSE SAME PGM
026100000000 001?C                   Seton                                        35        PUTOVR ON
026200000000E001?C                   Endif                                                  END IF NEW PGM
026300000000    ? *
026400000614    ? * Set PROTECT key based on request
026500000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
026600000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
026700000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
026800000000 001?C                   Setoff                                       40        NO PROTECT KEY
026900000000X001?C                   Else                                                   ELSE
027000000000 001?C                   Seton                                        40        PROTECT KEY
027100000000E001?C                   Endif                                                  END IF ADD
027200000000    ? *
027300000000    ? * Select title
027400000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
027500000000 001?C                   Setoff                                       38        CHANGE TITLE
027600000000X001?C                   Else                                                   ELSE
027700000000 001?C                   Seton                                        38        ADD TITLE
027800000000E001?C                   Endif                                                  END IF CHANGE
027900000000    ? *
028000000000    ? * Position cursor based on error status
028100000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
028200000000 001?C                   Seton                                        99        POS CSR TO ERROR
028300000000X001?C                   Else                                                   ELSE
028400000000 001?C                   Setoff                                       99        POS CSR TO FIRST
028500000000E001?C                   Endif                                                  END IF ERROR
028600140327
028700140327     C                   exsr      PRPSCR
028800000000    ? *
028900000000    ? * Write message subfile
029000000000    ?C                   Seton                                        30        MSGSFL DISPLAY
029100000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
029200000000    ? *
029300000000    ? * Write entry panel
029400000000B001?C                   Select
029500000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
029600000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
029700000000 001?C                   Setoff                                       37        RESET CRSLOC
029800000000E001?C                   Endsl                                                  END SELECT
029900000000    ? *
030000000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
030100000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
030200000000E001?C                   Endif                                                  END IF DATA CHG
030300000000    ?C                   Endsr                                                  END DSPENT
030400000000    ? *___________________________________________________________________
030500000000    ? * Process function key
030600000000    ? *___________________________________________________________________
030700000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
030800991108    ?C                   Movea     *IN           WWIN                           INDICATORS
030900991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
031000000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
031100000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
031200000000    ?C                   Parm                    WAD                            FNC DESC
031300991108    ?C                   Parm                    WWIN                           AID BYTE
031400000000    ?C                   Parm                    WAF                            FNC KEY TABLE
031500000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
031600000000    ?C                   Endsr                                                  END PRCFKY
031700000000    ? *___________________________________________________________________
031800000000    ? * Process KEYS function
031900000000    ? *___________________________________________________________________
032000000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
032100000000    ?C                   Z-add     1             WW                             KEY DSC IDX
032200000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
032300000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
032400000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
032500000000 001? *
032600000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
032700000000 002?C                   Z-add     1             WWFKS                          SET TO 1
032800000000E002?C                   Endif                                                  END IF OVER 3
032900000000 001? *
033000000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
033100000000 001?C                   Sub       1             WW                             KEY DESCR IDX
033200000000E001?C                   Enddo                                                  END DO KEYS
033300000000    ? *
033400010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
033500010913    ?C                   Add       1             WW                             BUMP IDX
033600010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
033700010913    ?C                   Endsr                                                  END PRCDKY
033800000000    ? *___________________________________________________________________
033900000000    ? * Process EXIT Function
034000000000    ? *___________________________________________________________________
034100000000    ?C     PRCEXT        Begsr                                                  RETURN
034200000000    ? *
034300000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
034400000000    ? *
034500000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
034600000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
034700000000X001?C                   Else                                                   ELSE NO ERRORS
034800000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
034900000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
035000011024E001?C                   Endif                                                  END IF ERRORS
035100100610
035200000000    ?C                   Endsr                                                  END PRCEXT
035300000000    ? *___________________________________________________________________
035400000000    ? * Process PROMPT function
035500000000    ? *___________________________________________________________________
035600000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
035700000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
035800000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
035900000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
036000000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
036100020920    ? *
036200000000B001?C                   Select                                                 SELECT
036300020923    ? *
036400101019 001 C                   When      WSFLD = 'PGCODE '
036500020923    ? *
036600000000 001?C                   Other                                                  WHERE ERROR
036700000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
036800000000 001?C                   Exsr      SNDMSG                                       SEND MSG
036900000000E001?C                   Endsl                                                  END SELECT
037000000000    ? *
037100000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
037200000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
037300000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
037400000000    ?C                   Mvr                     WSLIN                          CURSOR COL
037500000000    ?C                   Seton                                        37        SET ON CRSLOC
037600000000    ? *
037700000000    ?C                   Endsr                                                  END PRCPMT
037800000000    ? *___________________________________________________________________
037900000000    ? * Process CANCEL Function
038000000000    ? *___________________________________________________________________
038100000000    ?C     PRCCNL        Begsr                                                  CANCEL
038200000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
038300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
038400000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
038500000000    ?C                   Endsr                                                  END RETURN
038600000000    ? *___________________________________________________________________
038700000000    ? * Process ROLLUP function
038800000000    ? *___________________________________________________________________
038900000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
039000000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
039100000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
039200000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
039300000000E001?C                   Endif                                                  END IF GT LST PNL
039400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
039500000000    ?C                   Endsr                                                  END PRCRUP
039600000000    ? *___________________________________________________________________
039700000000    ? * Process ROLLDOWN function
039800000000    ? *___________________________________________________________________
039900000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
040000000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
040100000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
040200000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
040300000000E001?C                   Endif                                                  END IF LT FST PNL
040400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
040500000000    ?C                   Endsr                                                  END PRCRDN
040600000000    ? *___________________________________________________________________
040700000000    ? * Process ENTER function
040800000000    ? *___________________________________________________________________
040900000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
041000140327
041100140327     C                   exsr      PRPSCR
041200140327
041300000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
041400000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
041500000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
041600000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
041700000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
041800140326 001?C                   Call      'CHK100  '                                   CHECK DATA
041900000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
042000000000 001?C                   Parm                    WWRTN                          RETURN CODE
042100000614 001?C                   Parm                    WUDTA                          REC DATA
042200000000E001?C                   Endif                                                  ENDIF
042300100521    ? *
042400000000    ? *
042500000000B001?C                   Select                                                 PRC RETURN CDE
042600000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
042700000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
042800000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
042900000000 001? *
043000000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
043100000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
043200000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
043300000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
043400000000X002?C                   Else                                                   ELSE
043500000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
043600000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
043700000000E002?C                   Endif                                                  IF WARNING
043800000000 001? *
043900000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
044000000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
044100000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
044200000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
044300000000E001?C                   Endsl                                                  RETURN CODE SEL
044400000000    ? *
044500000000    ?C                   Endsr                                                  END PRCPNL
044600000000    ? *___________________________________________________________________
044700000000    ? * Process end - write data or release record
044800000000    ? *___________________________________________________________________
044900000000    ?C     PRCEND        Begsr                                                  PROCESS END
045000000000    ? *
045100000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
045200000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
045300000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
045400000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
045500000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
045600000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
045700000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
045800000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
045900000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
046000000000 001?C                   Endcs                                                  END CASE
046100000000 001? *
046200000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
046300000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
046400000000 002? *
046500000000X002?C                   Else                                                   ELSE NO WRT ERR
046600000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
046700000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
046800000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
046900000000 004?C                   Exsr      PRPPNL                                       DO NOT END
047000000810E004?C                   Endif                                                  END IF ADD
047100000000E003?C                   Endif                                                  END IF NOT END
047200000000E002?C                   Endif                                                  END IF WRITE ERROR
047300000000 001? *
047400000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
047500000000 001?C                   Exsr      RELREC                                       RELEASE REC
047600000000E001?C                   Endif                                                  END IF RCD CHANGED
047700000000    ? *
047800000000    ?C                   Endsr                                                  END PRCEND
047900000000    ? *___________________________________________________________________
048000000000    ? * Add new record
048100000000    ? *___________________________________________________________________
048200000000    ?C     WRTADD        Begsr                                                  WRITE ADD
048300000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
048400000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
048500000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
048600000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
048700000000E001?C                   Endif                                                  END IF ADD
048800000000    ? *
048900000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
049000000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
049100000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
049200000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
049300000000E001?C                   Endif                                                  END IF ADD KEY
049400000000    ? *
049500140326    ?C                   Call      'UPD100  '                                   PROCESS REC IO
049600000000    ?C                   Parm                    WWRQS                          ADD RECORD
049700000000    ?C                   Parm                    WWRTN                          RETURN CODE
049800000614    ?C                   Parm                    WUDTA                          REC DATA
049900000000    ? *
050000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
050100000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
050200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
050300000000X001?C                   Else                                                   ELSE
050400000000E001?C                   Endif                                                  END IF CALL ERROR
050500000000    ? *
050600000000    ?C                   Endsr                                                  END WRTADD
050700000000    ? *___________________________________________________________________
050800000000    ? * Write changed record
050900000000    ? *___________________________________________________________________
051000000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
051100140326    ?C                   Call      'UPD100  '                                   PROCESS REC IO
051200000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
051300000000    ?C                   Parm                    WWRTN                          RETURN CODE
051400000614    ?C                   Parm                    WUDTA                          REC DATA
051500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
051600000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
051700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
051800000000E001?C                   Endif                                                  END IF CALL ERROR
051900000000    ? *
052000000000    ?C                   Endsr                                                  END WRTCHG
052100011024    ? *___________________________________________________________________
052200011024    ? * Inz NO Key
052300011024    ? *___________________________________________________________________
052400011024    ?C     INZNKY        Begsr                                                  WRITE CHANGE
052500140326    ?C                   Call      'UPD100  '                                   PROCESS REC IO
052600011024    ?C                   Parm      'INZNKY'      WWRQS                          UPDATE RECORD
052700011024    ?C                   Parm                    WWRTN                          RETURN CODE
052800011024    ?C                   Parm                    WUDTA                          REC DATA
052900011024B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
053000011024 001?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
053100011024 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
053200011024E001?C                   Endif                                                  END IF CALL ERROR
053300011024    ? *
053400011024    ?C                   Endsr                                                  END WRTCHG
053500000000    ? *___________________________________________________________________
053600000000    ? * Release record
053700000000    ? *___________________________________________________________________
053800000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
053900140326    ?C                   Call      'UPD100  '                                   PROCESS REC IO
054000000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
054100000000    ?C                   Parm                    WWRTN                          RETURN CODE
054200000614    ?C                   Parm                    WUDTA                          REC DATA
054300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
054400000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
054500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
054600000000E001?C                   Endif                                                  END IF CALL ERROR
054700000000    ?C                   Endsr                                                  END RELREC
054800000000    ? *___________________________________________________________________
054900000000    ? * Build function keys
055000000000    ? *___________________________________________________________________
055100000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
055200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
055300991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
055400000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
055500000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
055600000000    ?C                   Parm                    WAD                            FNC DESC
055700991108    ?C                   Parm                    WWIN                           AID BYTE
055800000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
055900000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
056000010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
056100010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
056200010913    ?C                   Sub       1             WW                             BUMP IDX
056300010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
056400000000    ?C                   Endsr                                                  END BLD FNCTNS
056500000000    ? *___________________________________________________________________
056600000000    ? * Send message
056700000000    ? *___________________________________________________________________
056800000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
056900000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
057000000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
057100000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
057200000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
057300000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
057400000000    ?C                   Endsr                                                  END SNDMSG
057500000000    ? *___________________________________________________________________
057600000000    ? * Paremater list
057700000000    ? *___________________________________________________________________
057800000000    ?C     PLIST         Begsr                                                  PARM LISTS
057900000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
058000000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
058100000000    ?C                   Parm                    WORTN             8            RETURN CODE
058200000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
058300000614    ?C                   Parm                    WUDTA                          RECORD KEY
058400000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
058500000000    ?C                   Endsr                                                  END PLIST
058600000000    ? *___________________________________________________________________
058700000000    ? * Initialize routine
058800000000    ? *___________________________________________________________________
058900000000    ?C     *INZSR        Begsr                                                  INITIALIZE
059000000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
059100000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
059200000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
059300000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
059400000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
059500000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
059600000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
059700000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
059800000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
059900000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
060000000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
060100000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
060200000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
060300000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
060400000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
060500000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
060600000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
060700000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
060800000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
060900000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
061000000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
061100000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
061200000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
061300000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
061400000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
061500140326    ?C                   Movel     'CFS100P  '   WWFIL            10            FILE NAME-NOTES
061600000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
061700000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
061800000000    ?C                   Endsr                                                  END INITIALIZE
061900000000    ? *___________________________________________________________________
062000000000    ? * Program error handler
062100000000    ? *___________________________________________________________________
062200000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
062300000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
062400000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
062500000000    ?C                   Parm                    WQSTSC                         STATUS CODE
062600000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
062700000000    ?C                   Parm                    WQMSG                          MESSAGE ID
062800000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
062900000000    ? *___________________________________________________________________
063000000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06310000000003EXIT    F3=Exit
06320000000004PROMPT  F4=Prompt
06330003031305REFRESH F5=Refresh
06340000070710UPDATE  F10=Update
06350000061412CANCEL  F12=Cancel
06360000000025ROLLUP
06370000000026ROLLDOWN
063800000000** WTM
06390014032600Request not supported in program CHG100.
06400000000000Update error.  Data was not updated.
06410000000000Duplicate key detected.  Data was NOT added to file.
06420000000000Call to notes ended in error.
06430000000000Initialize error.  Record not initialized.
06440000000000Record not found.
06450000000000Generate error.  Key not generated.
06460000000000Record not available now.
06470000000000The cursor is not in a prompt area.
06480003031300Default error.  Data not defaulted.
06490010052000
