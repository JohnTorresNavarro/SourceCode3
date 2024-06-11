000100000000      *_________________________________________________________________________
000200000000      *
000300040220      *  Description:  Display Broker Alternate Contact
000400000000      *
000500040220      *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000600000000      *
000700110504      * 05/04/2011.SSK.CHANGE FROM GROUPER TO SMAN2
000800110504      *
000900000000    ? *_________________________________________________________________________
001000000000    ? *
001100040430    ?FDSPBAC2D  CF   E             WORKSTN INFDS(DSPD)
001200040220    ?FBRKACON   if   e           k disk
001300110504     fSMAN2L    if   e           k disk
001400040927     fsman      if   e           k disk
001500000000    ? *_________________________________________________________________________
001600040430     D A@20            S             20A
001700040430     D A@40            S             40A
001800040430    ? *_________________________________________________________________________
001900000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002000000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002100010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
002200040317    ? *
002300040317     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
002400040317     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
002500040927    ***
002600040927     d @lda            ds
002700040927     d blah                    1    240a
002800040927     d co_name               200    240a
002900040927    ***
003000000000    ? *_________________________________________________________________________
003100000000    ? *
003200000406    ? * Data structure
003300040220    ?D WDDTA         E DS                  EXTNAME(BRKACON)
003400000000    ? *
003500000000    ? * Program status data structure
003600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003700000000    ? *
003800000000    ? * Display file data structure
003900991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
004000000000    ? *_________________________________________________________________________
004100000000    ? * Process display panel
004200000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
004300000000    ? *
004400000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
004500000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
004600000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
004700000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
004800000000 001? *
004900000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
005000000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
005100000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
005200000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
005300000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005400000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
005500000000 001?C                   ENDCS                                                  END CASE
005600000000 001? *
005700000000E001?C                   ENDDO                                                  END DOWHILE
005800000000    ?C                   RETURN                                                 RETURN
005900000000    ? *___________________________________________________________________
006000000000    ? * Prepare display panel
006100000000    ? *___________________________________________________________________
006200000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
006300000000    ? *
006400000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
006500000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
006600000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
006700000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
006800000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
006900010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
007000000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
007100000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
007200040927    ***
007300040927     c     *DTAARA       DEFINE    *LDA          @LDA
007400040927     c                   IN        @LDA
007500040927     c                   eval      wsname = co_name
007600040927    ***
007700000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
007800000000    ?C                   EXSR      GETREC                                       GET RECORD
007900000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
008000000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
008100000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
008200000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
008300000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
008400000000E001?C                   ENDIF                                                  END IF ERROR
008500000000    ?C                   ENDSR                                                  END PRPPNL
008600000000    ? *___________________________________________________________________
008700000000    ? * Get record
008800000000    ? *___________________________________________________________________
008900000000    ?C     GETREC        BEGSR                                                  GET RECORD
009000040220    ?C                   CALL      'UPDBAC  '                                   PROCESS REC IO
009100000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
009200991201    ?C                   PARM                    WWRTN                          RETURN CODE
009300000614    ?C                   PARM                    WDDTA                          REC DATA
009400000000    ?C                   ENDSR                                                  END GETREC
009500000000    ? *___________________________________________________________________
009600000000    ? * Receive messages
009700000000    ? *___________________________________________________________________
009800000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
009900000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
010000000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
010100000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
010200000000    ?C                   PARM                    WWIN                           INDICATORS
010300000000    ?C                   PARM                    WWRTN             8            RETURN CODE
010400000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
010500000000    ?C                   ENDSR                                                  END RCV MSG
010600000000    ? *___________________________________________________________________
010700000000    ? * Display the display panel
010800000000    ? *___________________________________________________________________
010900000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
011000000000    ? *
011100000000    ? * Set OVERLAY based on last display file processed
011200000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
011300000000 001?C                   SETOFF                                       35        OVERLAY OFF
011400000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
011500000000X001?C                   ELSE                                                   SAME PGM
011600000000 001?C                   SETON                                        35        OVERLAY ON
011700000000E001?C                   ENDIF                                                  END IF NEW PGM
011800000000    ? *
011900000000    ? * Write message subfile
012000000000    ?C                   SETON                                        30        SFLMSG DISPLAY
012100000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
012200000000    ? *
012300000000    ? * Write display panels
012400000000B001?C                   SELECT
012500000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
012600040927    ?C     BRAgrp        Chain     BRKACON
012700010219B003?C                   If        %found
012800040317     ****CONVERT DATE FROM YMD TO MDY
012900040317     C                   IF        BRATMD <> *ZEROS
013000040317     C                   MOVE      BRATMD        ISO_DATE
013100040317     C                   MOVE      ISO_DATE      USA_DATE
013200040317     C                   MOVE      USA_DATE      BRATMD
013300040317    1C                   ENDIF
013400040317     ****
013500010219E003?C                   Else
013600010219E003?C                   End
013700040430     c                   exsr      $getdta
013800000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
013900000000E001?C                   ENDSL                                                  END SELECT
014000000000    ?C                   ENDSR                                                  END DSP DSP
014100040430   S***S
014200040430     c     $getdta       begsr
014300040430    ? *
014400040927     c                   if        bragrp = '00000'
014500040927     c                   eval      o_sname = '*UNKNOWN*'
014600040927     c                   leavesr
014700040927     c                   endif
014800040927    ? *
014900110504     c     bragrp        chain     SMAN2R
015000110504     c                   if        not %found(SMAN2L) or (grfuse <> 'F'
015100110504     c                             and %found(SMAN2L))
015200040927     c                   eval      o_sname = '*UNKNOWN*'
015300040927     c                   leavesr
015400040927     c                   endif
015500040927    ? *
015600040927     c     grdmgdft      chain     smanr
015700040927     c                   if        not %found(sman)
015800040927     c                   eval      o_sname = '*UNKNOWN*'
015900040927     c                   endif
016000040927    ? *
016100040927     c                   exsr      $namertn
016200040430    ? *
016300040430     c                   endsr
016400040430   S***S
016500040430     c     $namertn      begsr
016600040430    ***
016700040430     C                   CLEAR                   A@20
016800040430     C                   CLEAR                   A@40
016900040430    ***
017000040430     C                   IF        SFNAME <> *BLANKS
017100040430     C                   MOVEL     SFNAME        A@20
017200040430     C                   EXSR      $LDADDR
017300040430     C                   ENDIF
017400040430    ***
017500040430     C                   IF        SMI <> *BLANKS
017600040430     C                   MOVEL     SMI           A@20
017700040430     C                   EXSR      $LDADDR
017800040430     C                   ENDIF
017900040430    ***
018000040430     C                   IF        SLNAME <> *BLANKS
018100040430     C                   MOVEL     SLNAME        A@20
018200040430     C                   EXSR      $LDADDR
018300040430     C                   ENDIF
018400040430    ***
018500040430     C                   MOVEL(P)  A@40          O_SNAME
018600040430    ***
018700040430     C                   ENDSR
018800040430   S***S
018900040430     C     $LDADDR       BEGSR
019000040430    ***
019100040430     C                   EVAL      A@20 = %TRIM(A@20)
019200040430     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
019300040430     C                   CLEAR                   A@20
019400040430    ***
019500040430     c                   endsr
019600040430   S***S
019700000000    ? *___________________________________________________________________
019800000000    ? * Build function key information
019900000000    ? *___________________________________________________________________
020000000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
020100991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
020200991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
020300000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
020400000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
020500000000    ?C                   PARM                    WAD                            FNC DESC
020600991108    ?C                   PARM                    WWIN                           *IN
020700000000    ?C                   PARM                    WAF                            FNC KEY TABLE
020800000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
020900000000    ? *
021000010913    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
021100010913    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
021200010913    ?C                   SUB       1             WW                             BUMP IDX
021300010913    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
021400000000    ?C                   ENDSR                                                  END BLD FKY
021500000000    ? *___________________________________________________________________
021600000000    ? * Process function keys
021700000000    ? *___________________________________________________________________
021800000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
021900991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
022000991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
022100000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
022200000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
022300000000    ?C                   PARM                    WAD                            FNC DESC
022400991108    ?C                   PARM                    WWIN                           *IN
022500000000    ?C                   PARM                    WAF                            FNC KEY TABLE
022600000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
022700000000    ?C                   ENDSR                                                  END PRCFKY
022800000000    ? *___________________________________________________________________
022900000000    ? * Process KEYS function
023000000000    ? *___________________________________________________________________
023100000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
023200000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
023300000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
023400000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
023500000000 001? *
023600000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
023700000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
023800000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
023900000000E002?C                   ENDIF                                                  END IF OVER 3
024000000000 001? *
024100000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
024200000000 001?C                   SUB       1             WW                             KEY DESCR IDX
024300000000E001?C                   ENDDO                                                  END DO KEYS
024400000000    ? *
024500000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
024600000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
024700000000    ?C                   SUB       1             WW                             BUMP IDX
024800000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
024900000000    ? *
025000000000    ?C                   ENDSR                                                  END PRCDKY
025100000000    ? *___________________________________________________________________
025200000000    ? * Process RETURN function
025300000000    ? *___________________________________________________________________
025400000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
025500000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
025600000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
025700000000    ?C                   ENDSR                                                  END RETURN
025800000000    ? *___________________________________________________________________
025900000000    ? * Process CANCEL function
026000000000    ? *___________________________________________________________________
026100000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
026200000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
026300000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
026400000000    ?C                   ENDSR                                                  END PRCCNL
026500000000    ? *___________________________________________________________________
026600000000    ? * Process ROLLUP function
026700000000    ? *___________________________________________________________________
026800000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
026900000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
027000000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
027100000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
027200000000E001?C                   ENDIF                                                  END IF GT LST PNL
027300000000    ?C                   ENDSR                                                  END PRCRUP
027400000000    ? *___________________________________________________________________
027500000000    ? * Process ROLLDOWN function
027600000000    ? *___________________________________________________________________
027700000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
027800000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
027900000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
028000000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
028100000000E001?C                   ENDIF                                                  END IF LT FST PNL
028200000000    ?C                   ENDSR                                                  END PRCRDN
028300000000    ? *___________________________________________________________________
028400000000    ? * Process ENTER function
028500000000    ? *___________________________________________________________________
028600000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
028700000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
028800000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
028900000000    ?C                   ENDSR                                                  END PRCENT
029000000000    ? *___________________________________________________________________
029100000000    ? * Send message
029200000000    ? *___________________________________________________________________
029300000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
029400000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
029500000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
029600000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
029700000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
029800000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
029900000000    ?C                   ENDSR                                                  END SND MSG
030000000000    ? *___________________________________________________________________
030100000000    ? * Parameter lists
030200000000    ? *___________________________________________________________________
030300000000    ?C     PLIST         BEGSR                                                  PARM LISTS
030400000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
030500000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
030600000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
030700000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
030800000614    ?C                   PARM                    WDDTA                          RECORD DS
030900000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
031000000000    ?C                   ENDSR                                                  END PLIST
031100000000    ? *___________________________________________________________________
031200000000    ? * Initialize routine
031300000000    ? *___________________________________________________________________
031400000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
031500000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
031600040220    ?C                   MOVEL     'BRKACON'     WWFIL            10            FILE NAME-NOTES
031700000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
031800000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
031900000000    ?C                   ENDSR                                                  END *INZSR
032000000000    ? *___________________________________________________________________
032100000000    ? * Define  routine
032200000000    ? *___________________________________________________________________
032300000000    ?C     DEFN          BEGSR                                                  Define Fields
032400000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
032500000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
032600000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
032700000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
032800000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
032900000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
033000000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
033100000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
033200000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
033300000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
033400000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
033500000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
033600000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
033700000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
033800000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
033900000000    ?C                   ENDSR                                                  END DEFN
034000000000    ? *___________________________________________________________________
034100000000    ? * Program error handler
034200000000    ? *___________________________________________________________________
034300000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
034400000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
034500000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
034600000000    ?C                   PARM                    WQSTSC                         STATUS CODE
034700000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
034800000000    ?C                   PARM                    WQMSG                          MESSAGE ID
034900000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
035000000000    ? *___________________________________________________________________
035100000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03520000000003EXIT    F3=Exit
03530000000012CANCEL  F12=Cancel
03540000000025ROLLUP
03550000000026ROLLDOWN
035600000000** WTM
03570004022000Alternate Contact not found.
