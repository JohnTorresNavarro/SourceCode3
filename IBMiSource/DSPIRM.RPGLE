000100000000      *_________________________________________________________________________
000200000000      *
000300081230      *  Description:  Display INACTIVE REASON MAINT
000400000000      *
000500060310      *  (C)COPYRIGHT 2006 BY GROUP BENEFIT SERVICES, INC.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900081230     FDSPIRMD   CF   E             WORKSTN INFDS(DSPD)
001000000000      *_________________________________________________________________________
001100000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001300000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001400000000      *_________________________________________________________________________
001500000000      *
001600000000      * Data structure
001700081230     D WDDTA         E DS                  EXTNAME(IRMMSTP)
001800090206     D  IMTEXT1                4     43A
001900090206     D  IMTEXT2               44     83A
002000000000      *
002100000000      * Program status data structure
002200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000      *
002400000000      * Display file data structure
002500000000     D DSPD          E DS                  EXTNAME(IODSPD)
002600000000      *
002700021008     D WIFKV           S             60A
002800021008     D WIFKY           S                   LIKE(WIFKV)
002900021008     D WIOPV           S                   LIKE(WIFKV)
003000021008     D WIRQS           S              8A
003100021008     D WORTN           S              8A
003200021008     D WUPGM           S             10A
003300021008     D WWCHG           S              1A
003400021008     D WWDLT           S              1A
003500021008     D WWDTAQ          S             10A
003600021008     D WWENDF          S              3A
003700021008     D WWENDO          S                   LIKE(WWENDF)
003800021008     D WWERR           S              1A
003900021008     D WWFIL           S             10A
004000021008     D WWFKA           S              8A
004100021008     D WWFKV           S                   LIKE(WIFKV)
004200021008     D WWFKY           S                   LIKE(WIFKV)
004300021008     D WWFLK           S            128A
004400021008     D WWFMTN          S              8A
004500021008     D WWFNC           S              8A
004600021008     D WWIJI           S             16A
004700021008     D WWIN            S             99A
004800021008     D WWLIB           S             10A
004900021008     D WWMSG           S             80A
005000021008     D WWMSGC          S              7A
005100021008     D WWOCD           S              8A
005200021008     D WWOPA           S              8A
005300021008     D WWOPN           S              1A
005400021008     D WWOPT           S              8A
005500021008     D WWOPV           S                   LIKE(WIFKV)
005600021008     D WWORQS          S                   LIKE(WIRQS)
005700021008     D WWPSNC          S              1A
005800021008     D WWQJN           S             26A
005900021008     D WWRQS           S                   LIKE(WIRQS)
006000021008     D WWRQSD          S                   LIKE(WIRQS)
006100021008     D WWRTN           S                   LIKE(WORTN)
006200021008     D WWRTND          S                   LIKE(WORTN)
006300021008     D WWRTNH          S                   LIKE(WORTN)
006400021008     D WWSFLE          S              1A
006500021008     D WWSTT           S              3A
006600021008     D WWTSK           S              8A
006700021008     D WWTXT           S             60A
006800021008     D WWUPD           S              1A
006900021008     D WWWRNF          S              1A
007000021008     D WWZERO          S             40A
007100021008     D WFRRN           S              4P 0
007200021008     D WW              S              3P 0
007300021008     D WWFKS           S              1P 0
007400021008     D WWFKSO          S                   LIKE(WWFKS)
007500021008     D WWLMT           S              2P 0
007600021008     D WWLNG           S             15P 5
007700021008     D WWLNGQ          S              5P 0
007800021008     D WWLOWR          S              4P 0
007900021008     D WWLSTS          S              2P 0
008000021008     D WWOPS           S              1P 0
008100021008     D WWOPSO          S                   LIKE(WWOPS)
008200021008     D WWPNL           S              1P 0
008300021008     D WWPNLN          S                   LIKE(WWPNL)
008400021008     D WWPNLO          S                   LIKE(WWPNL)
008500021008     D WWPSNI          S              2P 0
008600021008     D WWPSNN          S              1P 0
008700021008     D WWPSNP          S                   LIKE(WWPSNN)
008800021008     D WWRRN           S              4P 0
008900000000     ****
009000000000      *
009100000000      *
009200000000      *_________________________________________________________________________
009300000000      * Process display panel
009400000000     C                   EXSR      PRPPNL                                       PREPARE PANEL
009500000000      *
009600000000B001 C                   DOW       WWSTT <> 'END'                               DOWHILE NOT END
009700000000 001 C                   EXSR      RCVMSG                                       RECEIVE MSGS
009800000000 001 C                   EXSR      DSPPNL                                       DISPLAY PANEL
009900000000 001 C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
010000000000 001  *
010100000000 001 C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
010200000000 001 C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
010300000000 001 C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
010400000000 001 C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
010500000000 001 C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
010600000000 001 C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
010700000000 001 C                   ENDCS                                                  END CASE
010800000000 001  *
010900000000E001 C                   ENDDO                                                  END DOWHILE
011000000000     C                   RETURN                                                 RETURN
011100000000      *___________________________________________________________________
011200000000      * Prepare display panel
011300000000      *___________________________________________________________________
011400000000     C     PRPPNL        BEGSR                                                  PREPARE PANEL
011500000000      *
011600000000     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
011700000000     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
011800000000     C                   MOVE      *BLANKS       WWSTT                          STATUS
011900000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
012000000000     C                   Z-ADD     1             WWPNL                          CURRENT PNL
012100000000     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
012200000000     C                   Z-ADD     1             WWFKS                          FNC KEY SET
012300000000     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
012400000000      *
012500000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
012600000000     C                   EXSR      GETREC                                       GET RECORD
012700000000B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
012800000000 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
012900000000 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
013000000000 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
013100000000 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
013200000000E001 C                   ENDIF                                                  END IF ERROR
013300000000      *
013400000000      *
013500000000     C                   ENDSR                                                  END PRPPNL
013600000000      *___________________________________________________________________
013700000000      * Get record
013800000000      *___________________________________________________________________
013900000000     C     GETREC        BEGSR                                                  GET RECORD
014000081230     C                   CALL      'UPDIRM  '                                   PROCESS REC IO
014100000000     C                   PARM      'GETNL '      WWRQS                          GET RECORD
014200000000     C                   PARM                    WWRTN                          RETURN CODE
014300000000     C                   PARM                    WDDTA                          REC DATA
014400000000     C                   ENDSR                                                  END GETREC
014500000000      *___________________________________________________________________
014600000000      * Receive messages
014700000000      *___________________________________________________________________
014800000000     C     RCVMSG        BEGSR                                                  RECEIVE MSG
014900000000     C                   MOVEA     *IN           WWIN                           INDICATORS
015000000000     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
015100000000     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
015200000000     C                   PARM                    WWIN                           INDICATORS
015300000000     C                   PARM                    WWRTN                          RETURN CODE
015400000000     C                   MOVEA     WWIN          *IN                            INDICATORS RET
015500000000     C                   ENDSR                                                  END RCV MSG
015600000000      *___________________________________________________________________
015700000000      * Display the display panel
015800000000      *___________________________________________________________________
015900000000     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
016000000000      *
016100000000      * Set OVERLAY based on last display file processed
016200000000     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
016300000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
016400000000 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
016500000000X001 C                   ELSE                                                   SAME PGM
016600000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
016700000000E001 C                   ENDIF                                                  END IF NEW PGM
016800000000      *
016900000000      * Write message subfile
017000000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
017100000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
017200000000      *
017300000000      * Write display panels
017400000000B001 C                   SELECT
017500000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
017600000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
017700000000E001 C                   ENDSL                                                  END SELECT
017800000000     C                   ENDSR                                                  END DSP DSP
017900000000      *___________________________________________________________________
018000000000      * Build function key information
018100000000      *___________________________________________________________________
018200000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
018300000000     C                   MOVEA     *IN           WWIN                           INDICATORS
018400000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
018500000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
018600000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
018700000000     C                   PARM                    WAD                            FNC DESC
018800000000     C                   PARM                    WWIN                           *IN
018900000000     C                   PARM                    WAF                            FNC KEY TABLE
019000000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
019100000000      *
019200000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
019300000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
019400000000     C                   SUB       1             WW                             BUMP IDX
019500000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
019600000000     C                   ENDSR                                                  END BLD FKY
019700000000      *___________________________________________________________________
019800000000      * Process function keys
019900000000      *___________________________________________________________________
020000000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
020100000000     C                   MOVEA     *IN           WWIN                           INDICATORS
020200000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
020300000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
020400000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
020500000000     C                   PARM                    WAD                            FNC DESC
020600000000     C                   PARM                    WWIN                           *IN
020700000000     C                   PARM                    WAF                            FNC KEY TABLE
020800000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
020900000000     C                   ENDSR                                                  END PRCFKY
021000000000      *___________________________________________________________________
021100000000      * Process KEYS function
021200000000      *___________________________________________________________________
021300000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
021400000000     C                   Z-ADD     1             WW                             KEY DSC IDX
021500000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
021600000000 001 C*                                                                         OR KEYS FOUND
021700000000 001  *
021800000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
021900000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
022000000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
022100000000E002 C                   ENDIF                                                  END IF OVER 3
022200000000 001  *
022300000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
022400000000 001 C                   SUB       1             WW                             KEY DESCR IDX
022500000000E001 C                   ENDDO                                                  END DO KEYS
022600000000      *
022700000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
022800000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
022900000000     C                   SUB       1             WW                             BUMP IDX
023000000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
023100000000      *
023200000000     C                   ENDSR                                                  END PRCDKY
023300000000      *___________________________________________________________________
023400000000      * Process RETURN function
023500000000      *___________________________________________________________________
023600000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
023700000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
023800000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
023900000000     C                   ENDSR                                                  END RETURN
024000000000      *___________________________________________________________________
024100000000      * Process CANCEL function
024200000000      *___________________________________________________________________
024300000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
024400000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
024500000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
024600000000     C                   ENDSR                                                  END PRCCNL
024700000000      *___________________________________________________________________
024800000000      * Process ROLLUP function
024900000000      *___________________________________________________________________
025000000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
025100000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
025200000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
025300000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
025400000000E001 C                   ENDIF                                                  END IF GT LST PNL
025500000000     C                   ENDSR                                                  END PRCRUP
025600000000      *___________________________________________________________________
025700000000      * Process ROLLDOWN function
025800000000      *___________________________________________________________________
025900000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
026000000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
026100000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
026200000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
026300000000E001 C                   ENDIF                                                  END IF LT FST PNL
026400000000     C                   ENDSR                                                  END PRCRDN
026500000000      *___________________________________________________________________
026600000000      * Process ENTER function
026700000000      *___________________________________________________________________
026800000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
026900000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
027000000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
027100000000     C                   ENDSR                                                  END PRCENT
027200000000      *___________________________________________________________________
027300000000      * Send message
027400000000      *___________________________________________________________________
027500000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
027600000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
027700000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
027800000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
027900000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
028000000000     C                   PARM                    WWMSG                          ERROR MESSAGE
028100000000     C                   ENDSR                                                  END SND MSG
028200000000      *___________________________________________________________________
028300000000      * Parameter lists
028400000000      *___________________________________________________________________
028500000000     C     PLIST         BEGSR                                                  PARM LISTS
028600000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
028700000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
028800000000     C                   PARM                    WORTN                          INTERNAL MODE
028900000000     C                   PARM                    WUPGM                          LAST PGM NAME
029000000000     C                   PARM                    WDDTA                          RECORD DS
029100000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
029200000000     C                   ENDSR                                                  END PLIST
029300000000      *___________________________________________________________________
029400000000      * Initialize routine
029500000000      *___________________________________________________________________
029600000000     C     *INZSR        BEGSR                                                  INITIALIZE
029700000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
029800081230     C                   MOVEL     'IRMMSTP '    WWFIL                          FILE NAME-NOTES
029900000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
030000000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
030100000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
030200000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
030300000000     C                   MOVE      WWSTT         WWSTT                          STATUS
030400000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
030500000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
030600000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
030700000000     C                   Z-ADD     WW            WW                             WORK INDEX
030800000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
030900000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
031000000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
031100000000     C                   ENDSR                                                  END DEFN
031200000000      *___________________________________________________________________
031300000000      * Program error handler
031400000000      *___________________________________________________________________
031500000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
031600000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
031700000000     C                   PARM                    WQPGMN                         PROGRAM NAME
031800000000     C                   PARM                    WQSTSC                         STATUS CODE
031900000000     C                   PARM                    WQRPGS                         RPG STATEMENT
032000000000     C                   PARM                    WQMSG                          MESSAGE ID
032100000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
032200000000      *___________________________________________________________________
032300000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03240000000003EXIT    F3=Exit
03250000000012CANCEL  F12=Cancel
03260000000025ROLLUP
03270000000026ROLLDOWN
032800000000** WTM
03290008123000INACTIVE REASON MAINT record not found.
