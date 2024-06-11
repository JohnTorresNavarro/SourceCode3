000100220307        Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000200220307                         DftActGrp(*no)
000300220307                         bnddir('GBSBIND' )   ;
000400000000    ? *_________________________________________________________________________
000500000000    ? *
000600060712    ? *  Description:  Change Category Notes
000700010914    ? *
000800010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000900000000    ? *_________________________________________________________________________
001000151109    ? * Modifications
001100151109    ? * 11/9/2015   B.Rees  Error with cnGia.  (Had a space in the name)
001200151109    ? *
001300151109    ? *
001400151109    ? *_________________________________________________________________________
001500060712    ?FCHGNOTD   CF   E             WORKSTN
001600000000    ?F                                     INFDS(DSPD)
001700220307     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001800060712    ?FWEBNOTP   if   e           k disk
001900060712    ?FCODES     if   e           k disk
002000060712    ?FACCMST    if   e           k disk
002100000000    ? *
002200000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002300000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002400000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
002500000000    ? *_________________________________________________________________________
002600000406    ? * Data structure
002700060712    ?D WUDTA         E DS                  EXTNAME(WEBNOTP)
002800151111    ?D  NOT01                106    155
002900151111    ?D  NOT02                156    205
003000151111    ?D  NOT03                206    255
003100151111    ?D  NOT04                256    305
003200151111    ?D  NOT05                306    355
003300151111    ?D  NOT06                356    405
003400151111    ?D  NOT07                406    455
003500151111    ?D  NOT08                456    505
003600151111    ?D  NOT09                506    555
003700151111    ?D  NOT10                556    605
003800110207
003900000000    ? *
004000000000    ? * Program status data structure
004100991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
004200000000    ? *
004300000000    ? * Display file data structure
004400991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
004500000000    ? *
004600060712    ? *
004700000000    ? * CURSOR LOCATION
004800000000    ?D                 DS
004900000000    ?D  WWCRSL                 1      2
005000000000    ?D  WWCRSN                 1      2B 0
005100000000    ? *_________________________________________________________________________
005200000000    ? *
005300000614    ? * Process Entry Panel
005400000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
005500000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
005600000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
005700000000E001?C                   Endif                                                  END COPY/CPYKEY
005800000000    ? *
005900000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
006000000000    ? *
006100000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
006200000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
006300000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
006400000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
006500000000 001? *
006600000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
006700000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
006800000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
006900000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
007000000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
007100000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
007200000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
007300000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
007400000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
007500000000 001?C                   Endcs                                                  END CASE
007600000000 001? *
007700000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
007800000000 002?C                   Exsr      PRCEND                                       PROCESS END
007900000000E002?C                   Endif                                                  END IF END REQ
008000000000E001?C                   Enddo                                                  END DOWHILE
008100000000    ? *
008200000707    ? * Send Info Updated message.
008300000707     C     WwChg         Ifeq      'Y'
008400000707     C                   Movel     'UPDATE  '    WORTN
008500000707     C                   Endif
008600000707    ? *
008700000000    ?C                   Return                                                 RETURN
008800000000    ? *___________________________________________________________________
008900000000    ? * Prepare panel
009000000000    ? *___________________________________________________________________
009100000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
009200060712     C                   Clear                   LDESCR
009300060712     C                   Clear                   ACNAM1
009400000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
009500991108    ?C                   Move      'N'           WWERR                          NO ERRORS
009600000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
009700000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
009800000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
009900000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
010000000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
010100000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
010200000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
010300000000    ? *
010400000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
010500000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
010600000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
010700000000E002?C                   Endif                                                  ENDIF SAME REQUEST
010800000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
010900000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
011000000000    ? *
011100000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
011200000000    ? *
011300000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
011400000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
011500000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
011600000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
011700000000    ?C                   Cas                     PRCERR                         PROC ERROR
011800000000    ?C                   Endcs                                                  END CASE
011900000000    ? *
012000000000    ?C                   Endsr                                                  END PRPPNL
012100000000    ? *___________________________________________________________________
012200000000    ? * Prepare ADD request
012300000000    ? *___________________________________________________________________
012400000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
012500000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
012600000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
012700000000    ?C                   Endsr                                                  END PRP ADD
012800000000    ? *___________________________________________________________________
012900000000    ? * Prepare CHANGE request
013000000000    ? *___________________________________________________________________
013100000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
013200060712    ?C                   Call      'UPDNOT  '                                   PROCESS REC IO
013300000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
013400000000    ?C                   Parm                    WWRTN                          RETURN CODE
013500000614    ?C                   Parm                    WUDTA                          REC DATA
013600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
013700000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
013800000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
013900000000X002?C                   Else                                                   ELSE
014000000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014100000000E002?C                   Endif                                                  END RCD NOT AVL
014200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
014500000810E001?C                   Else                                                   END IF ERROR
014600000810E001?C                   Endif                                                  END IF ERROR
014700061129     C     CNBEG         Mult      10000.0001    CNBEG
014800061129     C     CNEND         Mult      10000.0001    CNEND
014900000000    ?C                   Endsr                                                  END PRP CHANGE
015000000000    ? *___________________________________________________________________
015100000000    ? * Prepare COPY request
015200000000    ? *___________________________________________________________________
015300000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
015400000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
015500060712    ?C                   Call      'UPDNOT  '                                   PROCESS REC IO
015600000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
015700000000    ?C                   Parm                    WWRTN                          RETURN CODE
015800000614    ?C                   Parm                    WUDTA                          REC DATA
015900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016000000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
016100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016400000000X001?C                   Else                                                   ELSE
016500000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
016600000000E001?C                   Endif                                                  END IF ERROR
016700061129     C     CNBEG         Mult      10000.0001    CNBEG
016800061129     C     CNEND         Mult      10000.0001    CNEND
016900000000    ?C                   Endsr                                                  END PREP COPY
017000000000    ? *___________________________________________________________________
017100000000    ? * Default Data
017200000000    ? *___________________________________________________________________
017300000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
017400060712    ?C                   Call      'CHKNOT  '                                   PROCESS REC IO
017500000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
017600000000    ?C                   Parm                    WWRTN                          RETURN CODE
017700000614    ?C                   Parm                    WUDTA                          REC DATA
017800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
017900000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
018000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018200000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
018300000000E001?C                   Endif                                                  END IF ERROR
018400000000    ?C                   Endsr                                                  END DFTDTA
018500000000    ? *___________________________________________________________________
018600000000    ? * Process ERROR function
018700000000    ? *___________________________________________________________________
018800000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
018900000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
019000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
019100000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019200000000    ?C                   Move      'END'         WWSTT                          END STATE
019300000000    ?C                   Endsr                                                  END PRCERR
019400000000    ? *___________________________________________________________________
019500000000    ? * Receive messages
019600000000    ? *___________________________________________________________________
019700000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
019800000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
019900000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
020000000000X001?C                   Else                                                   ELSE
020100000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
020200000000E001?C                   Endif                                                  ENDIF NOT NORESET
020300000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
020400000000    ?C                   Movea     *IN           WWIN                           INDICATORS
020500000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
020600000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
020700000000    ?C                   Parm                    WWIN                           INDICATORS
020800000000    ?C                   Parm                    WWRTN                          RETURN CODE
020900000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
021000000000    ?C                   Endsr                                                  END RCV MSG
021100000000    ? *___________________________________________________________________
021200000000    ? * Display panels
021300000000    ? *___________________________________________________________________
021400000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
021500000000    ? *
021600000000    ? * Set PUTOVR based on last display file processed
021700000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
021800000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
021900000000 001?C                   Setoff                                       35        PUTOVR OFF
022000000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
022100000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
022200000000X001?C                   Else                                                   ELSE SAME PGM
022300000000 001?C                   Seton                                        35        PUTOVR ON
022400000000E001?C                   Endif                                                  END IF NEW PGM
022500000000    ? *
022600000614    ? * Set PROTECT key based on request
022700000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
022800000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
022900000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
023000000000 001?C                   Setoff                                       40        NO PROTECT KEY
023100000000X001?C                   Else                                                   ELSE
023200000000 001?C                   Seton                                        40        PROTECT KEY
023300000000E001?C                   Endif                                                  END IF ADD
023400000000    ? *
023500000000    ? * Select title
023600000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
023700000000 001?C                   Setoff                                       38        CHANGE TITLE
023800000000X001?C                   Else                                                   ELSE
023900000000 001?C                   Seton                                        38        ADD TITLE
024000000000E001?C                   Endif                                                  END IF CHANGE
024100000000    ? *
024200000000    ? * Position cursor based on error status
024300000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
024400000000 001?C                   Seton                                        99        POS CSR TO ERROR
024500000000X001?C                   Else                                                   ELSE
024600000000 001?C                   Setoff                                       99        POS CSR TO FIRST
024700000000E001?C                   Endif                                                  END IF ERROR
024800000000    ? *
024900000000    ? * Write message subfile
025000000000    ?C                   Seton                                        30        MSGSFL DISPLAY
025100000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
025200000000    ? *
025300000000    ? * Write entry panel
025400000000B001?C                   Select
025500000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
025600060712    ? *
025700060712     C     CATKEY        klist
025800060712     C                   kfld                    TYPE
025900060712     C                   kfld                    CNCAT
026000060712     C                   eval      type = 'P'
026100060712     C     CATKEY        Chain     CODES
026200060712     C     ACCKEY        klist
026300060712     C                   kfld                    CNTRS
026400060712     C                   kfld                    CNSUB
026500060712     C                   kfld                    CNACC
026600060712     C     ACCKEY        Chain     ACCMST
026700060712    ? *
026800151109br01 C* Fix Error with cnGia
026900151109  |  C*
027000151109  |  C                   monitor
027100151109  |  C                   eval      cnGia = cnGia + 0
027200151109     C                   on-Error
027300151109  |  C                   eval      cnGia = 0
027400151109  |  C                   endmon
027500151109    ? *
027600151109    ? *
027700000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
027800000000 001?C                   Setoff                                       37        RESET CRSLOC
027900000000E001?C                   Endsl                                                  END SELECT
028000060712    ? *
028100000000    ? *
028200000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
028300000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
028400000000E001?C                   Endif                                                  END IF DATA CHG
028500000000    ?C                   Endsr                                                  END DSPENT
028600000000    ? *___________________________________________________________________
028700000000    ? * Process function key
028800000000    ? *___________________________________________________________________
028900000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
029000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
029100991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
029200000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
029300000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
029400000000    ?C                   Parm                    WAD                            FNC DESC
029500991108    ?C                   Parm                    WWIN                           AID BYTE
029600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
029700000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
029800000000    ?C                   Endsr                                                  END PRCFKY
029900000000    ? *___________________________________________________________________
030000000000    ? * Process KEYS function
030100000000    ? *___________________________________________________________________
030200000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
030300000000    ?C                   Z-add     1             WW                             KEY DSC IDX
030400000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
030500000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
030600000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
030700000000 001? *
030800000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
030900000000 002?C                   Z-add     1             WWFKS                          SET TO 1
031000000000E002?C                   Endif                                                  END IF OVER 3
031100000000 001? *
031200000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
031300000000 001?C                   Sub       1             WW                             KEY DESCR IDX
031400000000E001?C                   Enddo                                                  END DO KEYS
031500000000    ? *
031600010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
031700010913    ?C                   Add       1             WW                             BUMP IDX
031800010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
031900010913    ?C                   Endsr                                                  END PRCDKY
032000000000    ? *___________________________________________________________________
032100000000    ? * Process EXIT Function
032200000000    ? *___________________________________________________________________
032300000000    ?C     PRCEXT        Begsr                                                  RETURN
032400000000    ? *
032500000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
032600000000    ? *
032700000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
032800000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
032900000000X001?C                   Else                                                   ELSE NO ERRORS
033000000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
033100000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
033200000000E001?C                   Endif                                                  END IF ERRORS
033300000000    ?C                   Endsr                                                  END PRCEXT
033400000000    ? *___________________________________________________________________
033500000000    ? * Process PROMPT function
033600000000    ? *___________________________________________________________________
033700000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
033800000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
033900000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
034000000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
034100000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
034200000000    ? *
034300000000B001?C                   Select                                                 SELECT
034400000112 001? *
034500000000 001?C                   Other                                                  WHERE ERROR
034600000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
034700000000 001?C                   Exsr      SNDMSG                                       SEND MSG
034800000000E001?C                   Endsl                                                  END SELECT
034900000000    ? *
035000000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
035100000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
035200000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
035300000000    ?C                   Mvr                     WSLIN                          CURSOR COL
035400000000    ?C                   Seton                                        37        SET ON CRSLOC
035500000000    ? *
035600000000    ?C                   Endsr                                                  END PRCPMT
035700000000    ? *___________________________________________________________________
035800000000    ? * Process CANCEL Function
035900000000    ? *___________________________________________________________________
036000000000    ?C     PRCCNL        Begsr                                                  CANCEL
036100000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
036200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
036300000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
036400000000    ?C                   Endsr                                                  END RETURN
036500000000    ? *___________________________________________________________________
036600000000    ? * Process ROLLUP function
036700000000    ? *___________________________________________________________________
036800000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
036900000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
037000000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
037100000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
037200000000E001?C                   Endif                                                  END IF GT LST PNL
037300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
037400000000    ?C                   Endsr                                                  END PRCRUP
037500000000    ? *___________________________________________________________________
037600000000    ? * Process ROLLDOWN function
037700000000    ? *___________________________________________________________________
037800000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
037900000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
038000000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
038100000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
038200000000E001?C                   Endif                                                  END IF LT FST PNL
038300000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
038400000000    ?C                   Endsr                                                  END PRCRDN
038500000000    ? *___________________________________________________________________
038600000000    ? * Process ENTER function
038700000000    ? *___________________________________________________________________
038800000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
038900000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
039000000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
039100000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
039200000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
039300000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
039400060712 001?C                   Call      'CHKNOT  '                                   CHECK DATA
039500000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
039600000000 001?C                   Parm                    WWRTN                          RETURN CODE
039700000614 001?C                   Parm                    WUDTA                          REC DATA
039800000000E001?C                   Endif                                                  ENDIF
039900000000    ? *
040000000000B001?C                   Select                                                 PRC RETURN CDE
040100000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
040200000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
040300000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
040400000000 001? *
040500000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
040600000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
040700000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
040800000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
040900000000X002?C                   Else                                                   ELSE
041000000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
041100000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
041200000000E002?C                   Endif                                                  IF WARNING
041300000000 001? *
041400000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
041500000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
041600000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
041700000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
041800000000E001?C                   Endsl                                                  RETURN CODE SEL
041900000000    ? *
042000000000    ?C                   Endsr                                                  END PRCPNL
042100000000    ? *___________________________________________________________________
042200000000    ? * Process end - write data or release record
042300000000    ? *___________________________________________________________________
042400000000    ?C     PRCEND        Begsr                                                  PROCESS END
042500000000    ? *
042600000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
042700000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
042800000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
042900000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
043000000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
043100000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
043200000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
043300000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
043400000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
043500000000 001?C                   Endcs                                                  END CASE
043600000000 001? *
043700000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
043800000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
043900000000 002? *
044000000000X002?C                   Else                                                   ELSE NO WRT ERR
044100000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
044200000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
044300000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
044400000000 004?C                   Exsr      PRPPNL                                       DO NOT END
044500000810E004?C                   Endif                                                  END IF ADD
044600000000E003?C                   Endif                                                  END IF NOT END
044700000000E002?C                   Endif                                                  END IF WRITE ERROR
044800000000 001? *
044900000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
045000000000 001?C                   Exsr      RELREC                                       RELEASE REC
045100000000E001?C                   Endif                                                  END IF RCD CHANGED
045200000000    ? *
045300000000    ?C                   Endsr                                                  END PRCEND
045400000000    ? *___________________________________________________________________
045500000000    ? * Add new record
045600000000    ? *___________________________________________________________________
045700000000    ?C     WRTADD        Begsr                                                  WRITE ADD
045800000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
045900000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
046000000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
046100000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
046200000000E001?C                   Endif                                                  END IF ADD
046300000000    ? *
046400000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
046500000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
046600000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
046700000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
046800000000E001?C                   Endif                                                  END IF ADD KEY
046900000000    ? *
047000060712    ?C                   Call      'UPDNOT  '                                   PROCESS REC IO
047100000000    ?C                   Parm                    WWRQS                          ADD RECORD
047200000000    ?C                   Parm                    WWRTN                          RETURN CODE
047300000614    ?C                   Parm                    WUDTA                          REC DATA
047400000000    ? *
047500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
047600000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
047700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
047800000000X001?C                   Else                                                   ELSE
047900000000E001?C                   Endif                                                  END IF CALL ERROR
048000000000    ? *
048100000000    ?C                   Endsr                                                  END WRTADD
048200000000    ? *___________________________________________________________________
048300000000    ? * Write changed record
048400000000    ? *___________________________________________________________________
048500000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
048600060712    ?C                   Call      'UPDNOT  '                                   PROCESS REC IO
048700000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
048800000000    ?C                   Parm                    WWRTN                          RETURN CODE
048900000614    ?C                   Parm                    WUDTA                          REC DATA
049000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
049100000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
049200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
049300000000E001?C                   Endif                                                  END IF CALL ERROR
049400000000    ? *
049500000000    ?C                   Endsr                                                  END WRTCHG
049600000000    ? *___________________________________________________________________
049700000000    ? * Release record
049800000000    ? *___________________________________________________________________
049900000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
050000060712    ?C                   Call      'UPDNOT  '                                   PROCESS REC IO
050100000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
050200000000    ?C                   Parm                    WWRTN                          RETURN CODE
050300000614    ?C                   Parm                    WUDTA                          REC DATA
050400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
050500000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
050600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
050700000000E001?C                   Endif                                                  END IF CALL ERROR
050800000000    ?C                   Endsr                                                  END RELREC
050900000000    ? *___________________________________________________________________
051000000000    ? * Build function keys
051100000000    ? *___________________________________________________________________
051200000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
051300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
051400991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
051500000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
051600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
051700000000    ?C                   Parm                    WAD                            FNC DESC
051800991108    ?C                   Parm                    WWIN                           AID BYTE
051900000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
052000000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
052100010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
052200010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
052300010913    ?C                   Sub       1             WW                             BUMP IDX
052400010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
052500000000    ?C                   Endsr                                                  END BLD FNCTNS
052600000000    ? *___________________________________________________________________
052700000000    ? * Send message
052800000000    ? *___________________________________________________________________
052900000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
053000000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
053100000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
053200000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
053300000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
053400000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
053500000000    ?C                   Endsr                                                  END SNDMSG
053600000000    ? *___________________________________________________________________
053700000000    ? * Paremater list
053800000000    ? *___________________________________________________________________
053900000000    ?C     PLIST         Begsr                                                  PARM LISTS
054000000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
054100000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
054200000000    ?C                   Parm                    WORTN             8            RETURN CODE
054300000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
054400000614    ?C                   Parm                    WUDTA                          RECORD KEY
054500000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
054600000000    ?C                   Endsr                                                  END PLIST
054700000000    ? *___________________________________________________________________
054800000000    ? * Initialize routine
054900000000    ? *___________________________________________________________________
055000000000    ?C     *INZSR        Begsr                                                  INITIALIZE
055100000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
055200000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
055300000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
055400000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
055500000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
055600000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
055700000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
055800000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
055900000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
056000000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
056100000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
056200000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
056300000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
056400000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
056500000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
056600000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
056700000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
056800000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
056900000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
057000000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
057100000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
057200000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
057300000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
057400000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
057500000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
057600060712    ?C                   Movel     'WEBNOTP '    WWFIL            10            FILE NAME-NOTES
057700000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
057800000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
057900000000    ?C                   Endsr                                                  END INITIALIZE
058000000000    ? *___________________________________________________________________
058100000000    ? * Program error handler
058200000000    ? *___________________________________________________________________
058300000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
058400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
058500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
058600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
058700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
058800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
058900000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
059000000000    ? *___________________________________________________________________
059100000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05920000000003EXIT    F3=Exit
05930000000004PROMPT  F4=Prompt
05940000000005REFRESH F5=Refresh
05950000070710UPDATE  F10=Update
05960000061412CANCEL  F12=Cancel
05970000000025ROLLUP
05980000000026ROLLDOWN
059900000000** WTM
06000006071200Request not supported in program CHGNOT.
06010000000000Update error.  Data was not updated.
06020000000000Duplicate key detected.  Data was NOT added to file.
06030000000000Call to notes ended in error.
06040000000000Initialize error.  Record not initialized.
06050000000000Record not found.
06060000000000Generate error.  Key not generated.
06070000000000Record not available now.
06080000000000The cursor is not in a prompt area.
06090000000000Default error.  Data not defaulted.
