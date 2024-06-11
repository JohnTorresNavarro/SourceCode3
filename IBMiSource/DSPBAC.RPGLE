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
001100040430    ?FDSPBACD   CF   E             WORKSTN INFDS(DSPD)
001200040220    ?FBRKACON   if   e           k disk
001300110504     fSMAN2L    if   e           k disk
001400040924     fsman      if   e           k disk
001500000000    ? *_________________________________________________________________________
001600000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001700000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001800010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001900000000    ? *_________________________________________________________________________
002000000000    ? *
002100040430     D A@20            S             20A
002200040430     D A@40            S             40A
002300040430    ? *_________________________________________________________________________
002400040430    ? *
002500000406    ? * Data structure
002600040220    ?D WDDTA         E DS                  EXTNAME(BRKACON)
002700000000    ? *
002800000000    ? * Program status data structure
002900991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003000000000    ? *
003100000000    ? * Display file data structure
003200991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003300040322    ? *_________________________________________________________________________
003400040322     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
003500040322     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
003600040927    ***
003700040927     d @lda            ds
003800040927     d blah                    1    240a
003900040927     d co_name               200    240a
004000040927    ***
004100000000    ? *_________________________________________________________________________
004200000000    ? * Process display panel
004300000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
004400000000    ? *
004500000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
004600000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
004700000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
004800000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
004900000000 001? *
005000000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
005100000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
005200000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
005300000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
005400000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005500000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
005600000000 001?C                   ENDCS                                                  END CASE
005700000000 001? *
005800000000E001?C                   ENDDO                                                  END DOWHILE
005900000000    ?C                   RETURN                                                 RETURN
006000000000    ? *___________________________________________________________________
006100000000    ? * Prepare display panel
006200000000    ? *___________________________________________________________________
006300000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
006400000000    ? *
006500000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
006600000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
006700000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
006800000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
006900000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
007000010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
007100000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
007200000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
007300040927    ***
007400040927     c     *DTAARA       DEFINE    *LDA          @LDA
007500040927     c                   IN        @LDA
007600040927     c                   eval      wsname = co_name
007700040927    ***
007800000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
007900000000    ?C                   EXSR      GETREC                                       GET RECORD
008000000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
008100000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
008200000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
008300000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
008400000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
008500000000E001?C                   ENDIF                                                  END IF ERROR
008600000000    ?C                   ENDSR                                                  END PRPPNL
008700000000    ? *___________________________________________________________________
008800000000    ? * Get record
008900000000    ? *___________________________________________________________________
009000000000    ?C     GETREC        BEGSR                                                  GET RECORD
009100040220    ?C                   CALL      'UPDBAC  '                                   PROCESS REC IO
009200000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
009300991201    ?C                   PARM                    WWRTN                          RETURN CODE
009400000614    ?C                   PARM                    WDDTA                          REC DATA
009500000000    ?C                   ENDSR                                                  END GETREC
009600000000    ? *___________________________________________________________________
009700000000    ? * Receive messages
009800000000    ? *___________________________________________________________________
009900000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
010000000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
010100000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
010200000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
010300000000    ?C                   PARM                    WWIN                           INDICATORS
010400000000    ?C                   PARM                    WWRTN             8            RETURN CODE
010500000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
010600000000    ?C                   ENDSR                                                  END RCV MSG
010700000000    ? *___________________________________________________________________
010800000000    ? * Display the display panel
010900000000    ? *___________________________________________________________________
011000000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
011100000000    ? *
011200000000    ? * Set OVERLAY based on last display file processed
011300000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
011400000000 001?C                   SETOFF                                       35        OVERLAY OFF
011500000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
011600000000X001?C                   ELSE                                                   SAME PGM
011700000000 001?C                   SETON                                        35        OVERLAY ON
011800000000E001?C                   ENDIF                                                  END IF NEW PGM
011900000000    ? *
012000000000    ? * Write message subfile
012100000000    ?C                   SETON                                        30        SFLMSG DISPLAY
012200000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
012300000000    ? *
012400000000    ? * Write display panels
012500000000B001?C                   SELECT
012600000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
012700040924    ?C     key#bra       Chain     BRKACON
012800010219B003?C                   If        %found
012900040322     C                   IF        BRaTMD <> *ZEROS
013000040322     C                   MOVE      BRaTMD        ISO_DATE
013100040322     C                   MOVE      ISO_DATE      USA_DATE
013200040322     C                   MOVE      USA_DATE      BRaTMD
013300040322    1C                   ENDIF
013400010219E003?C                   End
013500040924
013600040430     c                   exsr      $getdta
013700000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
013800040322
013900040322     C                   IF        BRaTMD <> *ZEROS
014000040322     C                   MOVE      BRaTMD        usa_DATE
014100040322     C                   MOVE      usa_DATE      iso_DATE
014200040322     C                   MOVE      iso_DATE      BRaTMD
014300040322    1C                   ENDIF
014400040322
014500000000E001?C                   ENDSL                                                  END SELECT
014600000000    ?C                   ENDSR                                                  END DSP DSP
014700040430   S***S
014800040430     c     $getdta       begsr
014900040430    ? *
015000040924     c                   if        bragrp = '00000'
015100040924     c                   eval      o_sname = '*UNKNOWN*'
015200040924     c                   leavesr
015300040924     c                   endif
015400040924    ? *
015500110504     c     bragrp        chain     SMAN2R
015600110504     c                   if        not %found(SMAN2L) or (grfuse <> 'F'
015700110504     c                             and %found(SMAN2L))
015800040924     c                   eval      o_sname = '*UNKNOWN*'
015900040924     c                   leavesr
016000040924     c                   endif
016100040924    ? *
016200040924     c     grdmgdft      chain     smanr
016300040924     c                   if        not %found(sman)
016400040924     c                   eval      o_sname = '*UNKNOWN*'
016500040924     c                   endif
016600040924    ? *
016700040924     c                   exsr      $namertn
016800040430    ? *
016900040430     c                   endsr
017000040430   S***S
017100040430     c     $namertn      begsr
017200040430    ***
017300040430     C                   CLEAR                   A@20
017400040430     C                   CLEAR                   A@40
017500040430    ***
017600040430     C                   IF        SFNAME <> *BLANKS
017700040430     C                   MOVEL     SFNAME        A@20
017800040430     C                   EXSR      $LDADDR
017900040430     C                   ENDIF
018000040430    ***
018100040430     C                   IF        SMI <> *BLANKS
018200040430     C                   MOVEL     SMI           A@20
018300040430     C                   EXSR      $LDADDR
018400040430     C                   ENDIF
018500040430    ***
018600040430     C                   IF        SLNAME <> *BLANKS
018700040430     C                   MOVEL     SLNAME        A@20
018800040430     C                   EXSR      $LDADDR
018900040430     C                   ENDIF
019000040430    ***
019100040430     C                   MOVEL(P)  A@40          O_SNAME
019200040430    ***
019300040430     C                   ENDSR
019400040430   S***S
019500040430     C     $LDADDR       BEGSR
019600040430    ***
019700040430     C                   EVAL      A@20 = %TRIM(A@20)
019800040430     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
019900040430     C                   CLEAR                   A@20
020000040430    ***
020100040430     c                   endsr
020200040430   S***S
020300000000    ? *___________________________________________________________________
020400000000    ? * Build function key information
020500000000    ? *___________________________________________________________________
020600000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
020700991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
020800991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
020900000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
021000000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
021100000000    ?C                   PARM                    WAD                            FNC DESC
021200991108    ?C                   PARM                    WWIN                           *IN
021300000000    ?C                   PARM                    WAF                            FNC KEY TABLE
021400000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
021500000000    ? *
021600010913    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
021700010913    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
021800010913    ?C                   SUB       1             WW                             BUMP IDX
021900010913    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
022000000000    ?C                   ENDSR                                                  END BLD FKY
022100000000    ? *___________________________________________________________________
022200000000    ? * Process function keys
022300000000    ? *___________________________________________________________________
022400000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
022500991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
022600991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
022700000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
022800000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
022900000000    ?C                   PARM                    WAD                            FNC DESC
023000991108    ?C                   PARM                    WWIN                           *IN
023100000000    ?C                   PARM                    WAF                            FNC KEY TABLE
023200000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
023300000000    ?C                   ENDSR                                                  END PRCFKY
023400000000    ? *___________________________________________________________________
023500000000    ? * Process KEYS function
023600000000    ? *___________________________________________________________________
023700000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
023800000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
023900000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
024000000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
024100000000 001? *
024200000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
024300000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
024400000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
024500000000E002?C                   ENDIF                                                  END IF OVER 3
024600000000 001? *
024700000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
024800000000 001?C                   SUB       1             WW                             KEY DESCR IDX
024900000000E001?C                   ENDDO                                                  END DO KEYS
025000000000    ? *
025100000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
025200000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
025300000000    ?C                   SUB       1             WW                             BUMP IDX
025400000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
025500000000    ? *
025600000000    ?C                   ENDSR                                                  END PRCDKY
025700000000    ? *___________________________________________________________________
025800000000    ? * Process RETURN function
025900000000    ? *___________________________________________________________________
026000000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
026100000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
026200000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
026300000000    ?C                   ENDSR                                                  END RETURN
026400000000    ? *___________________________________________________________________
026500000000    ? * Process CANCEL function
026600000000    ? *___________________________________________________________________
026700000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
026800000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
026900000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
027000000000    ?C                   ENDSR                                                  END PRCCNL
027100000000    ? *___________________________________________________________________
027200000000    ? * Process ROLLUP function
027300000000    ? *___________________________________________________________________
027400000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
027500000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
027600000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
027700000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
027800000000E001?C                   ENDIF                                                  END IF GT LST PNL
027900000000    ?C                   ENDSR                                                  END PRCRUP
028000000000    ? *___________________________________________________________________
028100000000    ? * Process ROLLDOWN function
028200000000    ? *___________________________________________________________________
028300000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
028400000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
028500000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
028600000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
028700000000E001?C                   ENDIF                                                  END IF LT FST PNL
028800000000    ?C                   ENDSR                                                  END PRCRDN
028900000000    ? *___________________________________________________________________
029000000000    ? * Process ENTER function
029100000000    ? *___________________________________________________________________
029200000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
029300000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
029400000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
029500000000    ?C                   ENDSR                                                  END PRCENT
029600000000    ? *___________________________________________________________________
029700000000    ? * Send message
029800000000    ? *___________________________________________________________________
029900000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
030000000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
030100000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
030200000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
030300000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
030400000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
030500000000    ?C                   ENDSR                                                  END SND MSG
030600000000    ? *___________________________________________________________________
030700000000    ? * Parameter lists
030800000000    ? *___________________________________________________________________
030900000000    ?C     PLIST         BEGSR                                                  PARM LISTS
031000000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
031100000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
031200000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
031300000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
031400000614    ?C                   PARM                    WDDTA                          RECORD DS
031500000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
031600000000    ?C                   ENDSR                                                  END PLIST
031700000000    ? *___________________________________________________________________
031800000000    ? * Initialize routine
031900000000    ? *___________________________________________________________________
032000000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
032100000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
032200040220    ?C                   MOVEL     'BRKACON'     WWFIL            10            FILE NAME-NOTES
032300000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
032400000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
032500040924     c     key#bra       klist
032600040924     c                   kfld                    bragrp
032700040924     c                   kfld                    braid
032800000000    ?C                   ENDSR                                                  END *INZSR
032900000000    ? *___________________________________________________________________
033000000000    ? * Define  routine
033100000000    ? *___________________________________________________________________
033200000000    ?C     DEFN          BEGSR                                                  Define Fields
033300000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
033400000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
033500000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
033600000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
033700000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
033800000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
033900000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
034000000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
034100000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
034200000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
034300000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
034400000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
034500000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
034600000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
034700000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
034800000000    ?C                   ENDSR                                                  END DEFN
034900000000    ? *___________________________________________________________________
035000000000    ? * Program error handler
035100000000    ? *___________________________________________________________________
035200000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
035300000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
035400000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
035500000000    ?C                   PARM                    WQSTSC                         STATUS CODE
035600000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
035700000000    ?C                   PARM                    WQMSG                          MESSAGE ID
035800000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
035900000000    ? *___________________________________________________________________
036000000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03610000000003EXIT    F3=Exit
03620000000012CANCEL  F12=Cancel
03630000000025ROLLUP
03640000000026ROLLDOWN
036500000000** WTM
03660004022000Alternate Contact not found.
