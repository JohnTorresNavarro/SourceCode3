000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300040220    ? *  Description:  Change Broker Alternate Contact
000400010914    ? *
000500040220    ? *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000600110504    ? *
000700110504    ? * 05/04/2011.SSK.CHANGE FROM GROUPER TO SMAN2
000800110504    ? *
000900110504    ? *
001000000000    ? *_________________________________________________________________________
001100040430    ?FCHGBACD   CF   E             WORKSTN INFDS(DSPD)
001200040927    ?FBRKACON   if   e           k disk    prefix(v)
001300110504     fSMAN2L    if   e           k disk
001400040924     fsman      if   e           k disk
001500000000    ? *
001600000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001700000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001800000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001900040308    ? *
002000040308     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
002100040308     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
002200040312    ? *
002300040312    ?D HBRAID          S              5  0
002400040312    ? *_________________________________________________________________________
002500000406    ? * Data structure
002600040220    ?D WUDTA         E DS                  EXTNAME(BRKACON)
002700040430    ?D WaDTA         E DS                  EXTNAME(SMAN)
002800040430     D A@20            S             20A
002900040430     D A@40            S             40A
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
004900000614    ? * Process Entry Panel
005000000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
005100000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
005200000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
005300000000E001?C                   Endif                                                  END COPY/CPYKEY
005400000000    ? *
005500000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005600000000    ? *
005700000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005800000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005900000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
006000000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
006100000000 001? *
006200000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
006300000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
006400000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
006500000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
006600000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006700000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
006800000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
006900000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
007000000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
007100000000 001?C                   Endcs                                                  END CASE
007200000000 001? *
007300000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
007400000000 002?C                   Exsr      PRCEND                                       PROCESS END
007500000000E002?C                   Endif                                                  END IF END REQ
007600000000E001?C                   Enddo                                                  END DOWHILE
007700000000    ? *
007800000707    ? * Send Info Updated message.
007900000707     C     WwChg         Ifeq      'Y'
008000000707     C                   Movel     'UPDATE  '    WORTN
008100000707     C                   Endif
008200000707    ? *
008300000000    ?C                   Return                                                 RETURN
008400000000    ? *___________________________________________________________________
008500000000    ? * Prepare panel
008600000000    ? *___________________________________________________________________
008700000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008800000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
008900991108    ?C                   Move      'N'           WWERR                          NO ERRORS
009000000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
009100000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
009200000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
009300000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
009400000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
009500000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
009600000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
009700040325    ?C                   Move      'Y'           FIRST                          FIRST TIME
009800040924    ? *
009900040924     C     *DTAARA       DEFINE    *LDA          @LDA
010000040924     C                   IN        @LDA
010100040924     c                   eval      wsname = co_name
010200000000    ? *
010300000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
010400000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
010500000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
010600000000E002?C                   Endif                                                  ENDIF SAME REQUEST
010700000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
010800000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
010900000000    ? *
011000000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
011100000000    ? *
011200000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
011300000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
011400000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
011500000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
011600000000    ?C                   Cas                     PRCERR                         PROC ERROR
011700000000    ?C                   Endcs                                                  END CASE
011800000000    ? *
011900000000    ?C                   Endsr                                                  END PRPPNL
012000000000    ? *___________________________________________________________________
012100000000    ? * Prepare ADD request
012200000000    ? *___________________________________________________________________
012300000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
012400040223    ?C*                  Clear                   WUDTA                          CLEAR RECORD
012500040924    ?C                   Clear                   BRAgrp                         CLEAR FIELD
012600040223    ?C                   Clear                   BRAFNM                         CLEAR FIELD
012700040223    ?C                   Clear                   BRALNM                         CLEAR FIELD
012800040223    ?C                   Clear                   BRAPHN                         CLEAR FIELD
012900040223    ?C                   Clear                   BRAFAX                         CLEAR FIELD
013000040223    ?C                   Clear                   BRAEML                         CLEAR FIELD
013100040223    ?C                   Clear                   BRATMD                         CLEAR FIELD
013200000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
013300000000    ?C                   Endsr                                                  END PRP ADD
013400000000    ? *___________________________________________________________________
013500000000    ? * Prepare CHANGE request
013600000000    ? *___________________________________________________________________
013700000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
013800040220    ?C                   Call      'UPDBAC  '                                   PROCESS REC IO
013900000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
014000000000    ?C                   Parm                    WWRTN                          RETURN CODE
014100000614    ?C                   Parm                    WUDTA                          REC DATA
014200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
014300000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
014400000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
014500000000X002?C                   Else                                                   ELSE
014600000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
014700000000E002?C                   Endif                                                  END RCD NOT AVL
014800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014900000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015000000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
015100000810E001?C                   Else                                                   END IF ERROR
015200000810E001?C                   Endif                                                  END IF ERROR
015300000000    ?C                   Endsr                                                  END PRP CHANGE
015400000000    ? *___________________________________________________________________
015500000000    ? * Prepare COPY request
015600000000    ? *___________________________________________________________________
015700000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
015800000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
015900040220    ?C                   Call      'UPDBAC  '                                   PROCESS REC IO
016000000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
016100000000    ?C                   Parm                    WWRTN                          RETURN CODE
016200000614    ?C                   Parm                    WUDTA                          REC DATA
016300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
016400000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
016500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
016600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
016800000000X001?C                   Else                                                   ELSE
016900000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
017000000000E001?C                   Endif                                                  END IF ERROR
017100000000    ?C                   Endsr                                                  END PREP COPY
017200000000    ? *___________________________________________________________________
017300000000    ? * Default Data
017400000000    ? *___________________________________________________________________
017500000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
017600040220    ?C                   Call      'CHKBAC  '                                   PROCESS REC IO
017700000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
017800000000    ?C                   Parm                    WWRTN                          RETURN CODE
017900000614    ?C                   Parm                    WUDTA                          REC DATA
018000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
018100000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
018200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018400000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
018500000000E001?C                   Endif                                                  END IF ERROR
018600000000    ?C                   Endsr                                                  END DFTDTA
018700000000    ? *___________________________________________________________________
018800000000    ? * Process ERROR function
018900000000    ? *___________________________________________________________________
019000000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
019100000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
019200000000    ?C                   Exsr      SNDMSG                                       SEND MSG
019300000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019400000000    ?C                   Move      'END'         WWSTT                          END STATE
019500000000    ?C                   Endsr                                                  END PRCERR
019600000000    ? *___________________________________________________________________
019700000000    ? * Receive messages
019800000000    ? *___________________________________________________________________
019900000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
020000000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
020100000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
020200000000X001?C                   Else                                                   ELSE
020300000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
020400000000E001?C                   Endif                                                  ENDIF NOT NORESET
020500000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
020600000000    ?C                   Movea     *IN           WWIN                           INDICATORS
020700000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
020800000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
020900000000    ?C                   Parm                    WWIN                           INDICATORS
021000000000    ?C                   Parm                    WWRTN                          RETURN CODE
021100000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
021200000000    ?C                   Endsr                                                  END RCV MSG
021300000000    ? *___________________________________________________________________
021400000000    ? * Display panels
021500000000    ? *___________________________________________________________________
021600000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
021700000000    ? *
021800000000    ? * Set PUTOVR based on last display file processed
021900000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
022000000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
022100000000 001?C                   Setoff                                       35        PUTOVR OFF
022200000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
022300000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
022400000000X001?C                   Else                                                   ELSE SAME PGM
022500000000 001?C                   Seton                                        35        PUTOVR ON
022600000000E001?C                   Endif                                                  END IF NEW PGM
022700000000    ? *
022800000614    ? * Set PROTECT key based on request
022900000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
023000000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
023100000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
023200000000 001?C                   Setoff                                       40        NO PROTECT KEY
023300040324 001?C                   Seton                                        62        NO PROTECT KEY
023400000000X001?C                   Else                                                   ELSE
023500000000 001?C                   Seton                                        40        PROTECT KEY
023600040324 001?C                   Setoff                                       62        PROTECT KEY
023700000000E001?C                   Endif                                                  END IF ADD
023800000000    ? *
023900000000    ? * Select title
024000000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
024100000000 001?C                   Setoff                                       38        CHANGE TITLE
024200000000X001?C                   Else                                                   ELSE
024300000000 001?C                   Seton                                        38        ADD TITLE
024400000000E001?C                   Endif                                                  END IF CHANGE
024500000000    ? *
024600000000    ? * Position cursor based on error status
024700000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
024800000000 001?C                   Seton                                        99        POS CSR TO ERROR
024900000000X001?C                   Else                                                   ELSE
025000000000 001?C                   Setoff                                       99        POS CSR TO FIRST
025100000000E001?C                   Endif                                                  END IF ERROR
025200000000    ? *
025300000000    ? * Write message subfile
025400000000    ?C                   Seton                                        30        MSGSFL DISPLAY
025500000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
025600000000    ? *
025700040325     C                   IF        FIRST = 'Y'
025800040325     C                   EVAL      FIRST = 'N'
025900040325     C     *USA          TEST(DE)                bratmd
026000040325     c
026100040325    1C                   IF        %ERROR
026200040325     C                   IF        BRaTMD <> *ZEROS
026300040325     C                   MOVE      BRaTMD        ISO_DATE
026400040325     C                   MOVE      ISO_DATE      USA_DATE
026500040325     C                   MOVE      USA_DATE      BRaTMD
026600040325    1C                   ENDIF
026700040325    1C                   ENDIF
026800040325    1C                   ENDIF
026900040325    ? *
027000000000    ? * Write entry panel
027100000000B001?C                   Select
027200000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
027300040430     c                   exsr      $getdta
027400000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
027500000000 001?C                   Setoff                                       37        RESET CRSLOC
027600000000E001?C                   Endsl                                                  END SELECT
027700000000    ? *
027800000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
027900000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
028000000000E001?C                   Endif                                                  END IF DATA CHG
028100000000    ?C                   Endsr                                                  END DSPENT
028200040430   S***S
028300040430     c     $getdta       begsr
028400040430    ? *
028500040924     c                   if        bragrp = '00000'
028600040430     c                   eval      o_sname = '*UNKNOWN*'
028700040430     c                   leavesr
028800040430     c                   endif
028900040430    ? *
029000110504     c     bragrp        CHAIN     SMAN2R
029100110504     c                   if        not %found(SMAN2L) or (grfuse <> 'F'
029200110504     c                             and %found(SMAN2L))
029300040924     c                   eval      o_sname = '*UNKNOWN*'
029400040924     c                   leavesr
029500040924     c                   endif
029600040924    ? *
029700040927     c                   if        wwtsk = 'ADD     '
029800040927    ? * Get next BRAID
029900040927     C                   Eval      HBRAID = *ZEROS                              Hist cover-trhu date
030000040927     C     bragrp        Setll     BRACONR
030100040927    2C                   Dou       %EOF(BRKACON)
030200040927     C     bragrp        Reade     BRACONR
030300040927     C                   If        NOT %EOF(BRKACON)
030400040927     C                   If        vBRAID > HBRAID
030500040927     C                   Eval      HBRAID = vBRAID                              Hist cover-trhu date
030600040927     C                   Endif
030700040927     C                   Endif
030800040927    1C                   Enddo
030900040927     C                   EVAL      BRAID = HBRAID + 1
031000040927     C                   ENDIF
031100040927
031200040924     c     grdmgdft      chain     smanr
031300040924     c                   if        not %found(sman)
031400040430     c                   eval      o_sname = '*UNKNOWN*'
031500040430     c                   endif
031600040924    ? *
031700040924     c                   exsr      $namertn
031800040430    ? *
031900040430     c                   endsr
032000040430   S***S
032100040430     c     $namertn      begsr
032200040430    ***
032300040430     C                   CLEAR                   A@20
032400040430     C                   CLEAR                   A@40
032500040430    ***
032600040430     C                   IF        SFNAME <> *BLANKS
032700040430     C                   MOVEL     SFNAME        A@20
032800040430     C                   EXSR      $LDADDR
032900040430     C                   ENDIF
033000040430    ***
033100040430     C                   IF        SMI <> *BLANKS
033200040430     C                   MOVEL     SMI           A@20
033300040430     C                   EXSR      $LDADDR
033400040430     C                   ENDIF
033500040430    ***
033600040430     C                   IF        SLNAME <> *BLANKS
033700040430     C                   MOVEL     SLNAME        A@20
033800040430     C                   EXSR      $LDADDR
033900040430     C                   ENDIF
034000040430    ***
034100040430     C                   MOVEL(P)  A@40          O_SNAME
034200040430    ***
034300040430     C                   ENDSR
034400040430   S***S
034500040430     C     $LDADDR       BEGSR
034600040430    ***
034700040430     C                   EVAL      A@20 = %TRIM(A@20)
034800040430     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
034900040430     C                   CLEAR                   A@20
035000040430    ***
035100040430     c                   endsr
035200040430   S***S
035300000000    ? *___________________________________________________________________
035400000000    ? * Process function key
035500000000    ? *___________________________________________________________________
035600000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
035700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
035800991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
035900000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
036000000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
036100000000    ?C                   Parm                    WAD                            FNC DESC
036200991108    ?C                   Parm                    WWIN                           AID BYTE
036300000000    ?C                   Parm                    WAF                            FNC KEY TABLE
036400000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
036500000000    ?C                   Endsr                                                  END PRCFKY
036600000000    ? *___________________________________________________________________
036700000000    ? * Process KEYS function
036800000000    ? *___________________________________________________________________
036900000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
037000000000    ?C                   Z-add     1             WW                             KEY DSC IDX
037100000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
037200000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
037300000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
037400000000 001? *
037500000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
037600000000 002?C                   Z-add     1             WWFKS                          SET TO 1
037700000000E002?C                   Endif                                                  END IF OVER 3
037800000000 001? *
037900000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
038000000000 001?C                   Sub       1             WW                             KEY DESCR IDX
038100000000E001?C                   Enddo                                                  END DO KEYS
038200000000    ? *
038300010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
038400010913    ?C                   Add       1             WW                             BUMP IDX
038500010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
038600010913    ?C                   Endsr                                                  END PRCDKY
038700000000    ? *___________________________________________________________________
038800000000    ? * Process EXIT Function
038900000000    ? *___________________________________________________________________
039000000000    ?C     PRCEXT        Begsr                                                  RETURN
039100000000    ? *
039200000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
039300000000    ? *
039400000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
039500000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
039600000000X001?C                   Else                                                   ELSE NO ERRORS
039700000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
039800000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
039900000000E001?C                   Endif                                                  END IF ERRORS
040000000000    ?C                   Endsr                                                  END PRCEXT
040100000000    ? *___________________________________________________________________
040200000000    ? * Process PROMPT function
040300000000    ? *___________________________________________________________________
040400000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
040500000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
040600000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
040700000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
040800000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
040900000000    ? *
041000000000B001?C                   Select                                                 SELECT
041100040924 001 C                   When      WSFLD = 'XXXXXX'
041200040924     C*******************Call      'SLCSTN'                                     *ENTRY LIST
041300040924     C*******************Parm                    WWRQS                          PROGRAM REQUEST
041400040924     C*******************Parm                    WWRTN                          RETURN CODE
041500040924     C*******************Parm                    WUPGM                          LAST PGM NAME
041600040924     C*******************Parm                    WaDTA                          RECORD DS
041700040924     C*******************IF        WWRTN = *BLANKS
041800040924     C*******************move      stin          bragrp
041900040924E001 C*******************Endif
042000040924     **********************
042100000112 001? *
042200000000 001?C                   Other                                                  WHERE ERROR
042300000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
042400000000 001?C                   Exsr      SNDMSG                                       SEND MSG
042500000000E001?C                   Endsl                                                  END SELECT
042600000000    ? *
042700000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
042800000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
042900000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
043000000000    ?C                   Mvr                     WSLIN                          CURSOR COL
043100000000    ?C                   Seton                                        37        SET ON CRSLOC
043200000000    ? *
043300000000    ?C                   Endsr                                                  END PRCPMT
043400000000    ? *___________________________________________________________________
043500000000    ? * Process CANCEL Function
043600000000    ? *___________________________________________________________________
043700000000    ?C     PRCCNL        Begsr                                                  CANCEL
043800000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
043900000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
044000000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
044100000000    ?C                   Endsr                                                  END RETURN
044200000000    ? *___________________________________________________________________
044300000000    ? * Process ROLLUP function
044400000000    ? *___________________________________________________________________
044500000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
044600000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
044700000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
044800000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
044900000000E001?C                   Endif                                                  END IF GT LST PNL
045000000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
045100000000    ?C                   Endsr                                                  END PRCRUP
045200000000    ? *___________________________________________________________________
045300000000    ? * Process ROLLDOWN function
045400000000    ? *___________________________________________________________________
045500000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
045600000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
045700000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
045800000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
045900000000E001?C                   Endif                                                  END IF LT FST PNL
046000000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
046100000000    ?C                   Endsr                                                  END PRCRDN
046200000000    ? *___________________________________________________________________
046300000000    ? * Process ENTER function
046400000000    ? *___________________________________________________________________
046500000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
046600000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
046700000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
046800000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
046900000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
047000000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
047100040220 001?C                   Call      'CHKBAC  '                                   CHECK DATA
047200000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
047300000000 001?C                   Parm                    WWRTN                          RETURN CODE
047400000614 001?C                   Parm                    WUDTA                          REC DATA
047500000000E001?C                   Endif                                                  ENDIF
047600000000    ? *
047700000000B001?C                   Select                                                 PRC RETURN CDE
047800000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
047900000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
048000000707 001?C************       Move      'END'         WWSTT                          END INVOCATION
048100000000 001? *
048200000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
048300000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
048400000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
048500000707 002?C************       Move      'END'         WWSTT                          END INVOCATION
048600000000X002?C                   Else                                                   ELSE
048700000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
048800000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
048900000000E002?C                   Endif                                                  IF WARNING
049000000000 001? *
049100000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
049200000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
049300000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
049400000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
049500000000E001?C                   Endsl                                                  RETURN CODE SEL
049600000000    ? *
049700000000    ?C                   Endsr                                                  END PRCPNL
049800000000    ? *___________________________________________________________________
049900000000    ? * Process end - write data or release record
050000000000    ? *___________________________________________________________________
050100000000    ?C     PRCEND        Begsr                                                  PROCESS END
050200000000    ? *
050300000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
050400000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
050500000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
050600000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
050700000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
050800000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
050900000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
051000000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
051100000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
051200000000 001?C                   Endcs                                                  END CASE
051300000000 001? *
051400000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
051500000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
051600000000 002? *
051700000000X002?C                   Else                                                   ELSE NO WRT ERR
051800000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
051900000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
052000000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
052100000000 004?C                   Exsr      PRPPNL                                       DO NOT END
052200000810E004?C                   Endif                                                  END IF ADD
052300000000E003?C                   Endif                                                  END IF NOT END
052400000000E002?C                   Endif                                                  END IF WRITE ERROR
052500000000 001? *
052600000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
052700000000 001?C                   Exsr      RELREC                                       RELEASE REC
052800000000E001?C                   Endif                                                  END IF RCD CHANGED
052900000000    ? *
053000000000    ?C                   Endsr                                                  END PRCEND
053100000000    ? *___________________________________________________________________
053200000000    ? * Add new record
053300000000    ? *___________________________________________________________________
053400000000    ?C     WRTADD        Begsr                                                  WRITE ADD
053500000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
053600000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
053700000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
053800000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
053900000000E001?C                   Endif                                                  END IF ADD
054000000000    ? *
054100000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
054200000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
054300000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
054400000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
054500000000E001?C                   Endif                                                  END IF ADD KEY
054600000000    ? *
054700040220    ?C                   Call      'UPDBAC  '                                   PROCESS REC IO
054800000000    ?C                   Parm                    WWRQS                          ADD RECORD
054900000000    ?C                   Parm                    WWRTN                          RETURN CODE
055000000614    ?C                   Parm                    WUDTA                          REC DATA
055100000000    ? *
055200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
055300000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
055400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
055500000000X001?C                   Else                                                   ELSE
055600000000E001?C                   Endif                                                  END IF CALL ERROR
055700000000    ? *
055800000000    ?C                   Endsr                                                  END WRTADD
055900000000    ? *___________________________________________________________________
056000000000    ? * Write changed record
056100000000    ? *___________________________________________________________________
056200000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
056300040308     ****CONVERT DATE FROM MDY TO YMD
056400040308     C                   IF        BRATMD <> *ZEROS
056500040308     C                   MOVE      BRATMD        USA_DATE
056600040308     C                   MOVE      USA_DATE      ISO_DATE
056700040308     C                   MOVE      ISO_DATE      BRATMD
056800040308    1C                   ENDIF
056900040308     ****
057000040220    ?C                   Call      'UPDBAC  '                                   PROCESS REC IO
057100000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
057200000000    ?C                   Parm                    WWRTN                          RETURN CODE
057300000614    ?C                   Parm                    WUDTA                          REC DATA
057400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
057500000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
057600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
057700000000E001?C                   Endif                                                  END IF CALL ERROR
057800000000    ? *
057900000000    ?C                   Endsr                                                  END WRTCHG
058000000000    ? *___________________________________________________________________
058100000000    ? * Release record
058200000000    ? *___________________________________________________________________
058300000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
058400040220    ?C                   Call      'UPDBAC  '                                   PROCESS REC IO
058500000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
058600000000    ?C                   Parm                    WWRTN                          RETURN CODE
058700000614    ?C                   Parm                    WUDTA                          REC DATA
058800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
058900000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
059000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
059100000000E001?C                   Endif                                                  END IF CALL ERROR
059200000000    ?C                   Endsr                                                  END RELREC
059300000000    ? *___________________________________________________________________
059400000000    ? * Build function keys
059500000000    ? *___________________________________________________________________
059600000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
059700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
059800991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
059900000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
060000000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
060100000000    ?C                   Parm                    WAD                            FNC DESC
060200991108    ?C                   Parm                    WWIN                           AID BYTE
060300000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
060400000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
060500010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
060600010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
060700010913    ?C                   Sub       1             WW                             BUMP IDX
060800010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
060900000000    ?C                   Endsr                                                  END BLD FNCTNS
061000000000    ? *___________________________________________________________________
061100000000    ? * Send message
061200000000    ? *___________________________________________________________________
061300000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
061400000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
061500000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
061600000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
061700000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
061800000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
061900000000    ?C                   Endsr                                                  END SNDMSG
062000000000    ? *___________________________________________________________________
062100000000    ? * Paremater list
062200000000    ? *___________________________________________________________________
062300000000    ?C     PLIST         Begsr                                                  PARM LISTS
062400000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
062500000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
062600000000    ?C                   Parm                    WORTN             8            RETURN CODE
062700000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
062800000614    ?C                   Parm                    WUDTA                          RECORD KEY
062900000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
063000000000    ?C                   Endsr                                                  END PLIST
063100000000    ? *___________________________________________________________________
063200000000    ? * Initialize routine
063300000000    ? *___________________________________________________________________
063400040325    ?C     *INZSR        Begsr                                                  INITIALIZE
063500000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
063600000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
063700000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
063800000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
063900000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
064000000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
064100000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
064200000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
064300000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
064400000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
064500000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
064600000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
064700000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
064800000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
064900000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
065000000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
065100000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
065200000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
065300000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
065400000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
065500000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
065600000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
065700000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
065800000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
065900000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
066000040220    ?C                   Movel     'BRKACON'     WWFIL            10            FILE NAME-NOTES
066100000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
066200000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
066300040325    ?C                   Move      'Y'           FIRST             1            FIRST TIME
066400040312    ? *
066500000000    ?C                   Endsr                                                  END INITIALIZE
066600000000    ? *___________________________________________________________________
066700000000    ? * Program error handler
066800000000    ? *___________________________________________________________________
066900000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
067000000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
067100000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
067200000000    ?C                   Parm                    WQSTSC                         STATUS CODE
067300000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
067400000000    ?C                   Parm                    WQMSG                          MESSAGE ID
067500000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
067600000000    ? *___________________________________________________________________
067700000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06780000000003EXIT    F3=Exit
06790000000004PROMPT  F4=Prompt
06800000000005REFRESH F5=Refresh
06810000070710UPDATE  F10=Update
06820000061412CANCEL  F12=Cancel
06830000000025ROLLUP
06840000000026ROLLDOWN
068500000000** WTM
06860004022000Request not supported in program CHGBAC.
06870000000000Update error.  Data was not updated.
06880000000000Duplicate key detected.  Data was NOT added to file.
06890000000000Call to notes ended in error.
06900000000000Initialize error.  Record not initialized.
06910000000000Record not found.
06920000000000Generate error.  Key not generated.
06930000000000Record not available now.
06940000000000The cursor is not in a prompt area.
06950000000000Default error.  Data not defaulted.
