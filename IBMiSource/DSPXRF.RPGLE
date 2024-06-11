000100220120        Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000200220120                         DftActGrp(*no)
000300220120                         bnddir('GBSBDIR' )   ;
000400000000      *_________________________________________________________________________
000500000000      *
000600101220      *  Description:  Display Payroll SSN Xref
000700000000      *
000800100521      *  (c)Copyright 2010 by GBS, Inc.
000900000000      *
001000000000    ? *_________________________________________________________________________
001100000000    ? *
001200130204    ?FDSPXRFD   CF   E             WORKSTN
001300220120     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001400000000     F                                     INFDS(DSPD)
001500130204     FACCMST    IF   E           K DISK
001600130204     FPLNMST    IF   E           K DISK
001700000000    ? *_________________________________________________________________________
001800000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001900000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002000010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
002100000000    ? *_________________________________________________________________________
002200130204      /COPY *LIBL/QMODSRC,#PROTO
002300130204     D w80date         s              8S 0 inz
002400000000    ? *
002500000406    ? * Data structure
002600130204    ?D WDDTA         E DS                  EXTNAME(WEBPLNXRFP)
002700130204     D webnote       e ds                  extname(webnotp) inz
002800000000    ? *
002900000000    ? * Program status data structure
003000991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003100000000    ? *
003200000000    ? * Display file data structure
003300991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003400000000    ? *_________________________________________________________________________
003500000000    ? * Process display panel
003600000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
003700000000    ? *
003800000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
003900000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
004000000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
004100000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
004200000000 001? *
004300000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
004400000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
004500000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
004600000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
004700000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
004800000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
004900000000 001?C                   ENDCS                                                  END CASE
005000000000 001? *
005100000000E001?C                   ENDDO                                                  END DOWHILE
005200220120    ?C                   eval      *inLR = *on                                  RETURN
005300000000    ? *___________________________________________________________________
005400000000    ? * Prepare display panel
005500000000    ? *___________________________________________________________________
005600000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
005700000000    ? *
005800000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
005900000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
006000000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
006100000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
006200000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
006300010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
006400000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
006500000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
006600000000    ? *
006700000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
006800000000    ?C                   EXSR      GETREC                                       GET RECORD
006900000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
007000000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
007100000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
007200000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
007300000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
007400010914E001?C                   ENDIF                                                  END IF ERROR
007500000000    ?C                   ENDSR                                                  END PRPPNL
007600000000    ? *___________________________________________________________________
007700000000    ? * Get record
007800000000    ? *___________________________________________________________________
007900000000    ?C     GETREC        BEGSR                                                  GET RECORD
008000130204    ?C                   CALL      'UPDXRF  '                                   PROCESS REC IO
008100000000    ?C                   PARM      'GETNL '      WWRQS             8            GET RECORD
008200991201    ?C                   PARM                    WWRTN                          RETURN CODE
008300000614    ?C                   PARM                    WDDTA                          REC DATA
008400130204    ? *
008500130204     C     ACCKEY        Chain     ACCMST
008600130204     C                   If        %found(ACCMST)
008700130204     C                   Eval      WSNAME = %trim(ACNAM1)
008800130204     C                   Else
008900130204     C                   Eval      WSNAME = *Blanks
009000130204     C                   End
009100130204    ? *
009200130204     C     plnkey        Chain     PLNMST
009300130204     C                   Eval      webnote = #getnot(plncat:xltrst:xlsub#:
009400130204     C                                               xlacct:w80date:xlplan)
009500130204     C                   Eval      wsdesc = %trim(CNDSC)
009600130204     C     plnkeyx       Chain     PLNMST
009700130204     C                   Eval      webnote = #getnot(plncat:xltrst:xlsub#:
009800130204     C                                               xlacct:w80date:xlxpln)
009900130204     C                   Eval      wxdesc = %trim(CNDSC)
010000130204    ? *
010100000000    ?C                   ENDSR                                                  END GETREC
010200000000    ? *___________________________________________________________________
010300000000    ? * Receive messages
010400000000    ? *___________________________________________________________________
010500000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
010600000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
010700000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
010800000000    ?C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
010900000000    ?C                   PARM                    WWIN                           INDICATORS
011000000000    ?C                   PARM                    WWRTN             8            RETURN CODE
011100000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
011200000000    ?C                   ENDSR                                                  END RCV MSG
011300000000    ? *___________________________________________________________________
011400000000    ? * Display the display panel
011500000000    ? *___________________________________________________________________
011600000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
011700000000    ? *
011800000000    ? * Set OVERLAY based on last display file processed
011900000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
012000000000 001?C                   SETOFF                                       35        OVERLAY OFF
012100000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
012200000000X001?C                   ELSE                                                   SAME PGM
012300000000 001?C                   SETON                                        35        OVERLAY ON
012400000000E001?C                   ENDIF                                                  END IF NEW PGM
012500000000    ? *
012600000000    ? * Write message subfile
012700000000    ?C                   SETON                                        30        SFLMSG DISPLAY
012800000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
012900000000    ? *
013000000000    ? * Write display panels
013100000000B001?C                   SELECT
013200000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
013300000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
013400000000E001?C                   ENDSL                                                  END SELECT
013500000000    ?C                   ENDSR                                                  END DSP DSP
013600000000    ? *___________________________________________________________________
013700000000    ? * Build function key information
013800000000    ? *___________________________________________________________________
013900000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
014000991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
014100991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
014200000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
014300000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
014400000000    ?C                   PARM                    WAD                            FNC DESC
014500991108    ?C                   PARM                    WWIN                           *IN
014600000000    ?C                   PARM                    WAF                            FNC KEY TABLE
014700000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
014800000000    ? *
014900010913    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
015000010913    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
015100010913    ?C                   SUB       1             WW                             BUMP IDX
015200010913    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
015300000000    ?C                   ENDSR                                                  END BLD FKY
015400000000    ? *___________________________________________________________________
015500000000    ? * Process function keys
015600000000    ? *___________________________________________________________________
015700000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
015800991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
015900991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
016000000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
016100000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
016200000000    ?C                   PARM                    WAD                            FNC DESC
016300991108    ?C                   PARM                    WWIN                           *IN
016400000000    ?C                   PARM                    WAF                            FNC KEY TABLE
016500000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
016600000000    ?C                   ENDSR                                                  END PRCFKY
016700000000    ? *___________________________________________________________________
016800000000    ? * Process KEYS function
016900000000    ? *___________________________________________________________________
017000000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
017100000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
017200000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
017300000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
017400000000 001? *
017500000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
017600000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
017700000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
017800000000E002?C                   ENDIF                                                  END IF OVER 3
017900000000 001? *
018000000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
018100000000 001?C                   SUB       1             WW                             KEY DESCR IDX
018200000000E001?C                   ENDDO                                                  END DO KEYS
018300000000    ? *
018400000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
018500000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
018600000000    ?C                   SUB       1             WW                             BUMP IDX
018700000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
018800000000    ? *
018900000000    ?C                   ENDSR                                                  END PRCDKY
019000000000    ? *___________________________________________________________________
019100000000    ? * Process RETURN function
019200000000    ? *___________________________________________________________________
019300000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
019400000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
019500000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
019600000000    ?C                   ENDSR                                                  END RETURN
019700000000    ? *___________________________________________________________________
019800000000    ? * Process CANCEL function
019900000000    ? *___________________________________________________________________
020000000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
020100000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
020200000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
020300000000    ?C                   ENDSR                                                  END PRCCNL
020400000000    ? *___________________________________________________________________
020500000000    ? * Process ROLLUP function
020600000000    ? *___________________________________________________________________
020700000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
020800000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
020900000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
021000000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
021100000000E001?C                   ENDIF                                                  END IF GT LST PNL
021200000000    ?C                   ENDSR                                                  END PRCRUP
021300000000    ? *___________________________________________________________________
021400000000    ? * Process ROLLDOWN function
021500000000    ? *___________________________________________________________________
021600000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
021700000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
021800000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
021900000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
022000000000E001?C                   ENDIF                                                  END IF LT FST PNL
022100000000    ?C                   ENDSR                                                  END PRCRDN
022200000000    ? *___________________________________________________________________
022300000000    ? * Process ENTER function
022400000000    ? *___________________________________________________________________
022500000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
022600000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
022700000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
022800000000    ?C                   ENDSR                                                  END PRCENT
022900000000    ? *___________________________________________________________________
023000000000    ? * Send message
023100000000    ? *___________________________________________________________________
023200000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
023300000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
023400000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
023500000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
023600000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
023700000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
023800000000    ?C                   ENDSR                                                  END SND MSG
023900000000    ? *___________________________________________________________________
024000000000    ? * Parameter lists
024100000000    ? *___________________________________________________________________
024200000000    ?C     PLIST         BEGSR                                                  PARM LISTS
024300000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
024400000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
024500000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
024600000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
024700000614    ?C                   PARM                    WDDTA                          RECORD DS
024800000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
024900000000    ?C                   ENDSR                                                  END PLIST
025000000000    ? *___________________________________________________________________
025100000000    ? * Initialize routine
025200000000    ? *___________________________________________________________________
025300000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
025400000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
025500130204    ?C                   MOVEL     'WEBPLNXRFP'  WWFIL            10            FILE NAME-NOTES
025600000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
025700000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
025800130204     C     *date         Mult      10000.0001    w80date
025900130204    ?C     ACCKEY        Klist                                                  ACKCTL
026000130204    ?C                   Kfld                    XLTRST                         POSITION TO 1
026100130204    ?C                   Kfld                    XLSUB#                         POSITION TO 1
026200130204    ?C                   Kfld                    XLACCT                         POSITION TO 1
026300130204    ?C     PLNKEY        Klist                                                  ACKCTL
026400130204    ?C                   Kfld                    XLTRST                         POSITION TO 1
026500130204    ?C                   Kfld                    XLSUB#                         POSITION TO 1
026600130204    ?C                   Kfld                    XLPLAN                         POSITION TO 1
026700130204    ?C     PLNKEYx       Klist                                                  ACKCTL
026800130204    ?C                   Kfld                    XLTRST                         POSITION TO 1
026900130204    ?C                   Kfld                    XLSUB#                         POSITION TO 1
027000130204    ?C                   Kfld                    XLXPLN                         POSITION TO 1
027100000000    ?C                   ENDSR                                                  END *INZSR
027200000000    ? *___________________________________________________________________
027300000000    ? * Define  routine
027400000000    ? *___________________________________________________________________
027500000000    ?C     DEFN          BEGSR                                                  Define Fields
027600000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
027700000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
027800000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
027900000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
028000000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
028100000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
028200000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
028300000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
028400000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
028500000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
028600000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
028700000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
028800000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
028900000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
029000000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
029100000000    ?C                   ENDSR                                                  END DEFN
029200000000    ? *___________________________________________________________________
029300000000    ? * Program error handler
029400000000    ? *___________________________________________________________________
029500000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
029600000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
029700000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
029800000000    ?C                   PARM                    WQSTSC                         STATUS CODE
029900000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
030000000000    ?C                   PARM                    WQMSG                          MESSAGE ID
030100000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
030200000000    ? *___________________________________________________________________
030300000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03040000000003EXIT    F3=Exit
03050000000012CANCEL  F12=Cancel
03060000000025ROLLUP
03070000000026ROLLDOWN
030800000000** WTM
03090010122000Record not found.
