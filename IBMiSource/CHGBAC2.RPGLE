000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300040220    ? *  Description:  Change Broker Alternate Contact
000400010914    ? *
000500040220    ? *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000600110504      *
000700110504      *
000800110504      * 05/04/2011.SSK.CHANGE FROM GROUPER TO SMAN2
000900110504      *
001000000000    ? *_________________________________________________________________________
001100040430    ?FCHGBAC2D  CF   E             WORKSTN INFDS(DSPD)
001200040927    ?FBRKACON   if   e           k disk    prefix(v)
001300110504     fSMAN2L    if   e           k disk
001400040924     fsman      if   e           k disk
001500000000    ? *
001600040430     D A@20            S             20A
001700040430     D A@40            S             40A
001800040430    ? *
001900000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002000000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002100000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
002200040308    ? *
002300040308     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
002400040308     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
002500040312    ? *
002600040312    ?D HBRAID          S              5  0
002700040312    ? *_________________________________________________________________________
002800000406    ? * Data structure
002900040220    ?D WUDTA         E DS                  EXTNAME(BRKACON)
003000010219    ? *
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
004200040924     ***
004300040924     d @lda            ds
004400040924     d blah                    1    240a
004500040924     d co_name               200    240a
004600000000    ? *_________________________________________________________________________
004700000000    ? *
004800040713
004900040223B001?C     WWTSK         Ifeq      'ADD     '
005000040312    ? * Get next BRAID
005100040312     C                   Eval      HBRAID = *ZEROS                              Hist cover-trhu date
005200040927     C     grp           Setll     BRACONR
005300040312    2C                   Dou       %EOF(BRKACON)
005400040927     C     grp           Reade     BRACONR
005500040312     C                   If        NOT %EOF(BRKACON)
005600040927     C                   If        vBRAID > HBRAID
005700040927     C                   Eval      HBRAID = vBRAID                              Hist cover-trhu date
005800040312     C                   Endif
005900040312     C                   Endif
006000040312    1C                   Enddo
006100040312     C                   EVAL      BRAID = HBRAID + 1
006200040223     C                   ENDIF
006300040713
006400040317     ****convert term date  ymd to mdy
006500040317     C*                  IF        BRATMD <> *ZEROS
006600040317     C*                  MOVE      BRATMD        ISO_DATE
006700040317     C*                  MOVE      ISO_DATE      USA_DATE
006800040317     C*                  MOVE      USA_DATE      BRATMD
006900040317    1C*                  ENDIF
007000040317     ****convert term date
007100000614    ? * Process Entry Panel
007200000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
007300000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
007400000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
007500000000E001?C                   Endif                                                  END COPY/CPYKEY
007600000000    ? *
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
009300000000 001?C                   Endcs                                                  END CASE
009400000000 001? *
009500000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
009600000000 002?C                   Exsr      PRCEND                                       PROCESS END
009700000000E002?C                   Endif                                                  END IF END REQ
009800000000E001?C                   Enddo                                                  END DOWHILE
009900000000    ? *
010000000707    ? * Send Info Updated message.
010100000707     C     WwChg         Ifeq      'Y'
010200000707     C                   Movel     'UPDATE  '    WORTN
010300000707     C                   Endif
010400000707    ? *
010500000000    ?C                   Return                                                 RETURN
010600000000    ? *___________________________________________________________________
010700000000    ? * Prepare panel
010800000000    ? *___________________________________________________________________
010900000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
011000000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
011100991108    ?C                   Move      'N'           WWERR                          NO ERRORS
011200000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
011300000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
011400000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
011500000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
011600000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
011700000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
011800000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
011900040325    ?C                   Move      'Y'           FIRST                          FIRST TIME
012000000000    ? *
012100040924     C     *DTAARA       DEFINE    *LDA          @LDA
012200040924     C                   IN        @LDA
012300040924     c                   eval      wsname = co_name
012400040924    ? *
012500000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
012600000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
012700000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
012800000000E002?C                   Endif                                                  ENDIF SAME REQUEST
012900000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
013000000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
013100000000    ? *
013200000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
013300000000    ? *
013400000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
013500000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
013600000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
013700000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
013800000000    ?C                   Cas                     PRCERR                         PROC ERROR
013900000000    ?C                   Endcs                                                  END CASE
014000000000    ? *
014100000000    ?C                   Endsr                                                  END PRPPNL
014200000000    ? *___________________________________________________________________
014300000000    ? * Prepare ADD request
014400000000    ? *___________________________________________________________________
014500000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
014600040223    ?C*                  Clear                   WUDTA                          CLEAR RECORD
014700040924    ?C                   Move      grp           BRAgrp                         CLEAR FIELD
014800040223    ?C                   Clear                   BRAFNM                         CLEAR FIELD
014900040223    ?C                   Clear                   BRALNM                         CLEAR FIELD
015000040223    ?C                   Clear                   BRAPHN                         CLEAR FIELD
015100040223    ?C                   Clear                   BRAFAX                         CLEAR FIELD
015200040223    ?C                   Clear                   BRAEML                         CLEAR FIELD
015300040223    ?C                   Clear                   BRATMD                         CLEAR FIELD
015400000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
015500000000    ?C                   Endsr                                                  END PRP ADD
015600000000    ? *___________________________________________________________________
015700000000    ? * Prepare CHANGE request
015800000000    ? *___________________________________________________________________
015900000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
016000040317    ?C                   Call      'UPDBAC2 '                                   PROCESS REC IO
016100000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
016200000000    ?C                   Parm                    WWRTN                          RETURN CODE
016300000614    ?C                   Parm                    WUDTA                          REC DATA
016400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016500000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
016600000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
016700000000X002?C                   Else                                                   ELSE
016800000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
016900000000E002?C                   Endif                                                  END RCD NOT AVL
017000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
017100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017200000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
017300000810E001?C                   Else                                                   END IF ERROR
017400000810E001?C                   Endif                                                  END IF ERROR
017500000000    ?C                   Endsr                                                  END PRP CHANGE
017600000000    ? *___________________________________________________________________
017700000000    ? * Prepare COPY request
017800000000    ? *___________________________________________________________________
017900000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
018000000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
018100040317    ?C                   Call      'UPDBAC2 '                                   PROCESS REC IO
018200000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
018300000000    ?C                   Parm                    WWRTN                          RETURN CODE
018400000614    ?C                   Parm                    WUDTA                          REC DATA
018500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
018600000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
018700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018800000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018900000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
019000000000X001?C                   Else                                                   ELSE
019100000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
019200000000E001?C                   Endif                                                  END IF ERROR
019300000000    ?C                   Endsr                                                  END PREP COPY
019400000000    ? *___________________________________________________________________
019500000000    ? * Default Data
019600000000    ? *___________________________________________________________________
019700000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
019800040317    ?C                   Call      'CHKBAC2 '                                   PROCESS REC IO
019900000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
020000000000    ?C                   Parm                    WWRTN                          RETURN CODE
020100000614    ?C                   Parm                    WUDTA                          REC DATA
020200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
020300000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
020400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
020500000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
020600000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
020700000000E001?C                   Endif                                                  END IF ERROR
020800000000    ?C                   Endsr                                                  END DFTDTA
020900000000    ? *___________________________________________________________________
021000000000    ? * Process ERROR function
021100000000    ? *___________________________________________________________________
021200000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
021300000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
021400000000    ?C                   Exsr      SNDMSG                                       SEND MSG
021500000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
021600000000    ?C                   Move      'END'         WWSTT                          END STATE
021700000000    ?C                   Endsr                                                  END PRCERR
021800000000    ? *___________________________________________________________________
021900000000    ? * Receive messages
022000000000    ? *___________________________________________________________________
022100000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
022200000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
022300000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
022400000000X001?C                   Else                                                   ELSE
022500000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
022600000000E001?C                   Endif                                                  ENDIF NOT NORESET
022700000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
022800000000    ?C                   Movea     *IN           WWIN                           INDICATORS
022900000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
023000000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
023100000000    ?C                   Parm                    WWIN                           INDICATORS
023200000000    ?C                   Parm                    WWRTN                          RETURN CODE
023300000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
023400000000    ?C                   Endsr                                                  END RCV MSG
023500000000    ? *___________________________________________________________________
023600000000    ? * Display panels
023700000000    ? *___________________________________________________________________
023800000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
023900000000    ? *
024000000000    ? * Set PUTOVR based on last display file processed
024100000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
024200000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
024300000000 001?C                   Setoff                                       35        PUTOVR OFF
024400000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
024500000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
024600000000X001?C                   Else                                                   ELSE SAME PGM
024700000000 001?C                   Seton                                        35        PUTOVR ON
024800000000E001?C                   Endif                                                  END IF NEW PGM
024900000000    ? *
025000000614    ? * Set PROTECT key based on request
025100000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
025200000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
025300000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
025400000000 001?C                   Setoff                                       40        NO PROTECT KEY
025500000000X001?C                   Else                                                   ELSE
025600000000 001?C                   Seton                                        40        PROTECT KEY
025700000000E001?C                   Endif                                                  END IF ADD
025800000000    ? *
025900000000    ? * Select title
026000000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
026100000000 001?C                   Setoff                                       38        CHANGE TITLE
026200000000X001?C                   Else                                                   ELSE
026300000000 001?C                   Seton                                        38        ADD TITLE
026400000000E001?C                   Endif                                                  END IF CHANGE
026500000000    ? *
026600000000    ? * Position cursor based on error status
026700000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
026800000000 001?C                   Seton                                        99        POS CSR TO ERROR
026900000000X001?C                   Else                                                   ELSE
027000000000 001?C                   Setoff                                       99        POS CSR TO FIRST
027100000000E001?C                   Endif                                                  END IF ERROR
027200000000    ? *
027300000000    ? * Write message subfile
027400000000    ?C                   Seton                                        30        MSGSFL DISPLAY
027500000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
027600000000    ? *
027700040325     C                   IF        FIRST = 'Y'
027800040325     C                   EVAL      FIRST = 'N'
027900040325     C     *USA          TEST(DE)                bratmd
028000040325     c
028100040325    1C                   IF        %ERROR
028200040325     C                   IF        BRaTMD <> *ZEROS
028300040325     C                   MOVE      BRaTMD        ISO_DATE
028400040325     C                   MOVE      ISO_DATE      USA_DATE
028500040325     C                   MOVE      USA_DATE      BRaTMD
028600040325    1C                   ENDIF
028700040325    1C                   ENDIF
028800040325    1C                   ENDIF
028900040325    ? *
029000000000    ? * Write entry panel
029100000000B001?C                   Select
029200000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
029300040430     c                   exsr      $getdta
029400000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
029500000000 001?C                   Setoff                                       37        RESET CRSLOC
029600000000E001?C                   Endsl                                                  END SELECT
029700000000    ? *
029800000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
029900000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
030000000000E001?C                   Endif                                                  END IF DATA CHG
030100000000    ?C                   Endsr                                                  END DSPENT
030200040430   S***S
030300040430     c     $getdta       begsr
030400040430    ? *
030500040924     c                   if        bragrp = '00000'
030600040924     c                   eval      o_sname = '*UNKNOWN*'
030700040924     c                   leavesr
030800040924     c                   endif
030900040924    ? *
031000110504     c     bragrp        chain     SMAN2R
031100110504     c                   if        not %found(SMAN2L) or (grfuse <> 'F'
031200110504     c                             and %found(SMAN2L))
031300040924     c                   eval      o_sname = '*UNKNOWN*'
031400040924     c                   leavesr
031500040924     c                   endif
031600040924    ? *
031700040924     c     grdmgdft      chain     smanr
031800040924     c                   if        not %found(sman)
031900040924     c                   eval      o_sname = '*UNKNOWN*'
032000040924     c                   endif
032100040924    ? *
032200040924     c                   exsr      $namertn
032300040924    ? *
032400040430    ? *
032500040430     c                   endsr
032600040430   S***S
032700040430     c     $namertn      begsr
032800040430    ***
032900040430     C                   CLEAR                   A@20
033000040430     C                   CLEAR                   A@40
033100040430    ***
033200040430     C                   IF        SFNAME <> *BLANKS
033300040430     C                   MOVEL     SFNAME        A@20
033400040430     C                   EXSR      $LDADDR
033500040430     C                   ENDIF
033600040430    ***
033700040430     C                   IF        SMI <> *BLANKS
033800040430     C                   MOVEL     SMI           A@20
033900040430     C                   EXSR      $LDADDR
034000040430     C                   ENDIF
034100040430    ***
034200040430     C                   IF        SLNAME <> *BLANKS
034300040430     C                   MOVEL     SLNAME        A@20
034400040430     C                   EXSR      $LDADDR
034500040430     C                   ENDIF
034600040430    ***
034700040430     C                   MOVEL(P)  A@40          O_SNAME
034800040430    ***
034900040430     C                   ENDSR
035000040430   S***S
035100040430     C     $LDADDR       BEGSR
035200040430    ***
035300040430     C                   EVAL      A@20 = %TRIM(A@20)
035400040430     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
035500040430     C                   CLEAR                   A@20
035600040430    ***
035700040430     c                   endsr
035800040430   S***S
035900000000    ? *___________________________________________________________________
036000000000    ? * Process function key
036100000000    ? *___________________________________________________________________
036200000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
036300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
036400991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
036500000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
036600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
036700000000    ?C                   Parm                    WAD                            FNC DESC
036800991108    ?C                   Parm                    WWIN                           AID BYTE
036900000000    ?C                   Parm                    WAF                            FNC KEY TABLE
037000000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
037100000000    ?C                   Endsr                                                  END PRCFKY
037200000000    ? *___________________________________________________________________
037300000000    ? * Process KEYS function
037400000000    ? *___________________________________________________________________
037500000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
037600000000    ?C                   Z-add     1             WW                             KEY DSC IDX
037700000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
037800000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
037900000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
038000000000 001? *
038100000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
038200000000 002?C                   Z-add     1             WWFKS                          SET TO 1
038300000000E002?C                   Endif                                                  END IF OVER 3
038400000000 001? *
038500000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
038600000000 001?C                   Sub       1             WW                             KEY DESCR IDX
038700000000E001?C                   Enddo                                                  END DO KEYS
038800000000    ? *
038900010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
039000010913    ?C                   Add       1             WW                             BUMP IDX
039100010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
039200010913    ?C                   Endsr                                                  END PRCDKY
039300000000    ? *___________________________________________________________________
039400000000    ? * Process EXIT Function
039500000000    ? *___________________________________________________________________
039600000000    ?C     PRCEXT        Begsr                                                  RETURN
039700000000    ? *
039800000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
039900000000    ? *
040000000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
040100000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
040200000000X001?C                   Else                                                   ELSE NO ERRORS
040300000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
040400000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
040500000000E001?C                   Endif                                                  END IF ERRORS
040600000000    ?C                   Endsr                                                  END PRCEXT
040700000000    ? *___________________________________________________________________
040800000000    ? * Process PROMPT function
040900000000    ? *___________________________________________________________________
041000000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
041100000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
041200000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
041300000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
041400000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
041500000000    ? *
041600000000B001?C                   Select                                                 SELECT
041700000112 001? *
041800000000 001?C                   Other                                                  WHERE ERROR
041900000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
042000000000 001?C                   Exsr      SNDMSG                                       SEND MSG
042100000000E001?C                   Endsl                                                  END SELECT
042200000000    ? *
042300000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
042400000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
042500000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
042600000000    ?C                   Mvr                     WSLIN                          CURSOR COL
042700000000    ?C                   Seton                                        37        SET ON CRSLOC
042800000000    ? *
042900000000    ?C                   Endsr                                                  END PRCPMT
043000000000    ? *___________________________________________________________________
043100000000    ? * Process CANCEL Function
043200000000    ? *___________________________________________________________________
043300000000    ?C     PRCCNL        Begsr                                                  CANCEL
043400000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
043500000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
043600000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
043700000000    ?C                   Endsr                                                  END RETURN
043800000000    ? *___________________________________________________________________
043900000000    ? * Process ROLLUP function
044000000000    ? *___________________________________________________________________
044100000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
044200000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
044300000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
044400000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
044500000000E001?C                   Endif                                                  END IF GT LST PNL
044600000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
044700000000    ?C                   Endsr                                                  END PRCRUP
044800000000    ? *___________________________________________________________________
044900000000    ? * Process ROLLDOWN function
045000000000    ? *___________________________________________________________________
045100000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
045200000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
045300000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
045400000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
045500000000E001?C                   Endif                                                  END IF LT FST PNL
045600000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
045700000000    ?C                   Endsr                                                  END PRCRDN
045800000000    ? *___________________________________________________________________
045900000000    ? * Process ENTER function
046000000000    ? *___________________________________________________________________
046100000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
046200000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
046300000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
046400000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
046500000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
046600000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
046700040317 001?C                   Call      'CHKBAC2 '                                   CHECK DATA
046800000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
046900000000 001?C                   Parm                    WWRTN                          RETURN CODE
047000000614 001?C                   Parm                    WUDTA                          REC DATA
047100000000E001?C                   Endif                                                  ENDIF
047200000000    ? *
047300000000B001?C                   Select                                                 PRC RETURN CDE
047400000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
047500000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
047600000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
047700000000 001? *
047800000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
047900000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
048000000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
048100000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
048200000000X002?C                   Else                                                   ELSE
048300000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
048400000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
048500000000E002?C                   Endif                                                  IF WARNING
048600000000 001? *
048700000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
048800000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
048900000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
049000000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
049100000000E001?C                   Endsl                                                  RETURN CODE SEL
049200000000    ? *
049300000000    ?C                   Endsr                                                  END PRCPNL
049400000000    ? *___________________________________________________________________
049500000000    ? * Process end - write data or release record
049600000000    ? *___________________________________________________________________
049700000000    ?C     PRCEND        Begsr                                                  PROCESS END
049800000000    ? *
049900000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
050000000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
050100000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
050200000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
050300000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
050400000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
050500000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
050600000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
050700000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
050800000000 001?C                   Endcs                                                  END CASE
050900000000 001? *
051000000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
051100000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
051200000000 002? *
051300000000X002?C                   Else                                                   ELSE NO WRT ERR
051400000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
051500000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
051600000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
051700000000 004?C                   Exsr      PRPPNL                                       DO NOT END
051800000810E004?C                   Endif                                                  END IF ADD
051900000000E003?C                   Endif                                                  END IF NOT END
052000000000E002?C                   Endif                                                  END IF WRITE ERROR
052100000000 001? *
052200000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
052300000000 001?C                   Exsr      RELREC                                       RELEASE REC
052400000000E001?C                   Endif                                                  END IF RCD CHANGED
052500000000    ? *
052600000000    ?C                   Endsr                                                  END PRCEND
052700000000    ? *___________________________________________________________________
052800000000    ? * Add new record
052900000000    ? *___________________________________________________________________
053000000000    ?C     WRTADD        Begsr                                                  WRITE ADD
053100000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
053200000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
053300000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
053400000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
053500000000E001?C                   Endif                                                  END IF ADD
053600000000    ? *
053700000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
053800000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
053900000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
054000000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
054100000000E001?C                   Endif                                                  END IF ADD KEY
054200000000    ? *
054300040317    ?C                   Call      'UPDBAC2 '                                   PROCESS REC IO
054400000000    ?C                   Parm                    WWRQS                          ADD RECORD
054500000000    ?C                   Parm                    WWRTN                          RETURN CODE
054600000614    ?C                   Parm                    WUDTA                          REC DATA
054700000000    ? *
054800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
054900000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
055000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
055100000000X001?C                   Else                                                   ELSE
055200000000E001?C                   Endif                                                  END IF CALL ERROR
055300000000    ? *
055400000000    ?C                   Endsr                                                  END WRTADD
055500000000    ? *___________________________________________________________________
055600000000    ? * Write changed record
055700000000    ? *___________________________________________________________________
055800000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
055900040308     ****CONVERT DATE FROM MDY TO YMD
056000040308     C                   IF        BRATMD <> *ZEROS
056100040308     C                   MOVE      BRATMD        USA_DATE
056200040308     C                   MOVE      USA_DATE      ISO_DATE
056300040308     C                   MOVE      ISO_DATE      BRATMD
056400040308    1C                   ENDIF
056500040308     ****
056600040317    ?C                   Call      'UPDBAC2 '                                   PROCESS REC IO
056700000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
056800000000    ?C                   Parm                    WWRTN                          RETURN CODE
056900000614    ?C                   Parm                    WUDTA                          REC DATA
057000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
057100000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
057200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
057300000000E001?C                   Endif                                                  END IF CALL ERROR
057400000000    ? *
057500000000    ?C                   Endsr                                                  END WRTCHG
057600000000    ? *___________________________________________________________________
057700000000    ? * Release record
057800000000    ? *___________________________________________________________________
057900000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
058000040317    ?C                   Call      'UPDBAC2 '                                   PROCESS REC IO
058100000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
058200000000    ?C                   Parm                    WWRTN                          RETURN CODE
058300000614    ?C                   Parm                    WUDTA                          REC DATA
058400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
058500000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
058600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
058700000000E001?C                   Endif                                                  END IF CALL ERROR
058800000000    ?C                   Endsr                                                  END RELREC
058900000000    ? *___________________________________________________________________
059000000000    ? * Build function keys
059100000000    ? *___________________________________________________________________
059200000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
059300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
059400991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
059500000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
059600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
059700000000    ?C                   Parm                    WAD                            FNC DESC
059800991108    ?C                   Parm                    WWIN                           AID BYTE
059900000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
060000000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
060100010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
060200010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
060300010913    ?C                   Sub       1             WW                             BUMP IDX
060400010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
060500000000    ?C                   Endsr                                                  END BLD FNCTNS
060600000000    ? *___________________________________________________________________
060700000000    ? * Send message
060800000000    ? *___________________________________________________________________
060900000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
061000000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
061100000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
061200000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
061300000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
061400000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
061500000000    ?C                   Endsr                                                  END SNDMSG
061600000000    ? *___________________________________________________________________
061700000000    ? * Paremater list
061800000000    ? *___________________________________________________________________
061900000000    ?C     PLIST         Begsr                                                  PARM LISTS
062000000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
062100000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
062200000000    ?C                   Parm                    WORTN             8            RETURN CODE
062300000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
062400000614    ?C                   Parm                    WUDTA                          RECORD KEY
062500000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
062600040924    ?C                   Parm                    grp               5            FUNCTIONS VALID
062700000000    ?C                   Endsr                                                  END PLIST
062800000000    ? *___________________________________________________________________
062900000000    ? * Initialize routine
063000000000    ? *___________________________________________________________________
063100000000    ?C     *INZSR        Begsr                                                  INITIALIZE
063200000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
063300000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
063400000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
063500000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
063600000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
063700000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
063800000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
063900000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
064000000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
064100000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
064200000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
064300000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
064400000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
064500000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
064600000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
064700000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
064800000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
064900000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
065000000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
065100000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
065200000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
065300000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
065400000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
065500000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
065600000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
065700040220    ?C                   Movel     'BRKACON'     WWFIL            10            FILE NAME-NOTES
065800000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
065900000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
066000040325    ?C                   Move      'Y'           FIRST             1            FIRST TIME
066100040312    ? *
066200000000    ?C                   Endsr                                                  END INITIALIZE
066300000000    ? *___________________________________________________________________
066400000000    ? * Program error handler
066500000000    ? *___________________________________________________________________
066600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
066700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
066800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
066900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
067000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
067100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
067200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
067300000000    ? *___________________________________________________________________
067400000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06750000000003EXIT    F3=Exit
06760000000004PROMPT  F4=Prompt
06770000000005REFRESH F5=Refresh
06780000070710UPDATE  F10=Update
06790000061412CANCEL  F12=Cancel
06800000000025ROLLUP
06810000000026ROLLDOWN
068200000000** WTM
06830004031700Request not supported in program CHGBAC2.
06840000000000Update error.  Data was not updated.
06850000000000Duplicate key detected.  Data was NOT added to file.
06860000000000Call to notes ended in error.
06870000000000Initialize error.  Record not initialized.
06880000000000Record not found.
06890000000000Generate error.  Key not generated.
06900000000000Record not available now.
06910000000000The cursor is not in a prompt area.
06920000000000Default error.  Data not defaulted.
