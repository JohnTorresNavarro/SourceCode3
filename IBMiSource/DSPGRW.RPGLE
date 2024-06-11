000100000000      *_________________________________________________________________________
000200000000      *
000300101102      *  Description:  Display GAS RENEWAL
000400000000      *
000500090204      *  (C)COPYRIGHT 2009 BY GROUP BENEFIT SERVICES, INC.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900101102     FDSPGRWD   CF   E             WORKSTN INFDS(DSPD)
001000101102     FCARMSTP   IF   E           K DISK    PREFIX(RV:2) RENAME(CARMSTR:CARMSF)
001100000000      *_________________________________________________________________________
001200000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001400000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001500000000      *_________________________________________________________________________
001600000000      *
001700101102     d @lda            ds
001800101102     d blah                    1    240a
001900101102     d co_name               200    240a
002000101102      *
002100000000      * Data structure
002200101102     D WDDTA         E DS                  EXTNAME(RNW01GRW)
002300000000      *
002400000000      * Program status data structure
002500000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002600000000      *
002700000000      * Display file data structure
002800000000     D DSPD          E DS                  EXTNAME(IODSPD)
002900000000      *
003000021008     D WIFKV           S             60A
003100021008     D WIFKY           S                   LIKE(WIFKV)
003200021008     D WIOPV           S                   LIKE(WIFKV)
003300021008     D WIRQS           S              8A
003400021008     D WORTN           S              8A
003500021008     D WUPGM           S             10A
003600021008     D WWCHG           S              1A
003700021008     D WWDLT           S              1A
003800021008     D WWDTAQ          S             10A
003900021008     D WWENDF          S              3A
004000021008     D WWENDO          S                   LIKE(WWENDF)
004100021008     D WWERR           S              1A
004200021008     D WWFIL           S             10A
004300021008     D WWFKA           S              8A
004400021008     D WWFKV           S                   LIKE(WIFKV)
004500021008     D WWFKY           S                   LIKE(WIFKV)
004600021008     D WWFLK           S            128A
004700021008     D WWFMTN          S              8A
004800021008     D WWFNC           S              8A
004900021008     D WWIJI           S             16A
005000021008     D WWIN            S             99A
005100021008     D WWLIB           S             10A
005200021008     D WWMSG           S             80A
005300021008     D WWMSGC          S              7A
005400021008     D WWOCD           S              8A
005500021008     D WWOPA           S              8A
005600021008     D WWOPN           S              1A
005700021008     D WWOPT           S              8A
005800021008     D WWOPV           S                   LIKE(WIFKV)
005900021008     D WWORQS          S                   LIKE(WIRQS)
006000021008     D WWPSNC          S              1A
006100021008     D WWQJN           S             26A
006200021008     D WWRQS           S                   LIKE(WIRQS)
006300021008     D WWRQSD          S                   LIKE(WIRQS)
006400021008     D WWRTN           S                   LIKE(WORTN)
006500021008     D WWRTND          S                   LIKE(WORTN)
006600021008     D WWRTNH          S                   LIKE(WORTN)
006700021008     D WWSFLE          S              1A
006800021008     D WWSTT           S              3A
006900021008     D WWTSK           S              8A
007000021008     D WWTXT           S             60A
007100021008     D WWUPD           S              1A
007200021008     D WWWRNF          S              1A
007300021008     D WWZERO          S             40A
007400021008     D WFRRN           S              4P 0
007500021008     D WW              S              3P 0
007600021008     D WWFKS           S              1P 0
007700021008     D WWFKSO          S                   LIKE(WWFKS)
007800021008     D WWLMT           S              2P 0
007900021008     D WWLNG           S             15P 5
008000021008     D WWLNGQ          S              5P 0
008100021008     D WWLOWR          S              4P 0
008200021008     D WWLSTS          S              2P 0
008300021008     D WWOPS           S              1P 0
008400021008     D WWOPSO          S                   LIKE(WWOPS)
008500021008     D WWPNL           S              1P 0
008600021008     D WWPNLN          S                   LIKE(WWPNL)
008700021008     D WWPNLO          S                   LIKE(WWPNL)
008800021008     D WWPSNI          S              2P 0
008900021008     D WWPSNN          S              1P 0
009000021008     D WWPSNP          S                   LIKE(WWPSNN)
009100021008     D WWRRN           S              4P 0
009200000000     ****
009300000000      *
009400000000      *
009500000000      *_________________________________________________________________________
009600000000      * Process display panel
009700000000     C                   EXSR      PRPPNL                                       PREPARE PANEL
009800000000      *
009900000000B001 C                   DOW       WWSTT <> 'END'                               DOWHILE NOT END
010000000000 001 C                   EXSR      RCVMSG                                       RECEIVE MSGS
010100000000 001 C                   EXSR      DSPPNL                                       DISPLAY PANEL
010200000000 001 C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
010300000000 001  *
010400000000 001 C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
010500000000 001 C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
010600000000 001 C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
010700000000 001 C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
010800000000 001 C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
010900000000 001 C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
011000000000 001 C                   ENDCS                                                  END CASE
011100000000 001  *
011200000000E001 C                   ENDDO                                                  END DOWHILE
011300000000     C                   RETURN                                                 RETURN
011400000000      *___________________________________________________________________
011500000000      * Prepare display panel
011600000000      *___________________________________________________________________
011700000000     C     PRPPNL        BEGSR                                                  PREPARE PANEL
011800000000      *
011900000000     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
012000000000     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
012100000000     C                   MOVE      *BLANKS       WWSTT                          STATUS
012200000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
012300000000     C                   Z-ADD     1             WWPNL                          CURRENT PNL
012400000000     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
012500000000     C                   Z-ADD     1             WWFKS                          FNC KEY SET
012600000000     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
012700000000      *
012800101102     C     *DTAARA       DEFINE    *LDA          @LDA
012900101102     C                   IN        @LDA
013000101102     c                   eval      wsname = co_name
013100101102      *
013200000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
013300000000     C                   EXSR      GETREC                                       GET RECORD
013400000000B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
013500000000 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
013600000000 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
013700000000 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
013800000000 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
013900000000E001 C                   ENDIF                                                  END IF ERROR
014000000000      *
014100000000      *
014200000000     C                   ENDSR                                                  END PRPPNL
014300000000      *___________________________________________________________________
014400000000      * Get record
014500000000      *___________________________________________________________________
014600000000     C     GETREC        BEGSR                                                  GET RECORD
014700101102     C                   CALL      'UPDGRW  '                                   PROCESS REC IO
014800000000     C                   PARM      'GETNL '      WWRQS                          GET RECORD
014900000000     C                   PARM                    WWRTN                          RETURN CODE
015000000000     C                   PARM                    WDDTA                          REC DATA
015100000000     C                   ENDSR                                                  END GETREC
015200000000      *___________________________________________________________________
015300000000      * Receive messages
015400000000      *___________________________________________________________________
015500000000     C     RCVMSG        BEGSR                                                  RECEIVE MSG
015600000000     C                   MOVEA     *IN           WWIN                           INDICATORS
015700000000     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
015800000000     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
015900000000     C                   PARM                    WWIN                           INDICATORS
016000000000     C                   PARM                    WWRTN                          RETURN CODE
016100000000     C                   MOVEA     WWIN          *IN                            INDICATORS RET
016200000000     C                   ENDSR                                                  END RCV MSG
016300000000      *___________________________________________________________________
016400000000      * Display the display panel
016500000000      *___________________________________________________________________
016600000000     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
016700000000      *
016800000000      * Set OVERLAY based on last display file processed
016900000000     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
017000000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
017100000000 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
017200000000X001 C                   ELSE                                                   SAME PGM
017300000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
017400000000E001 C                   ENDIF                                                  END IF NEW PGM
017500000000      *
017600000000      * Write message subfile
017700000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
017800000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
017900000000      *
018000000000      * Write display panels
018100000000B001 C                   SELECT
018200000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
018300101102     C     RGCAID        CHAIN     CARMSF
018400101102     C                   IF        %FOUND(CARMSTP)
018500101102     C                   EVAL      SCNAME = %TRIM(RVNAME)
018600101102     C                   ELSE
018700101102     C                   EVAL      SCNAME = '***ERROR***'
018800101102     C                   ENDIF
018900000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
019000000000E001 C                   ENDSL                                                  END SELECT
019100000000     C                   ENDSR                                                  END DSP DSP
019200000000      *___________________________________________________________________
019300000000      * Build function key information
019400000000      *___________________________________________________________________
019500000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
019600000000     C                   MOVEA     *IN           WWIN                           INDICATORS
019700000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
019800000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
019900000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
020000000000     C                   PARM                    WAD                            FNC DESC
020100000000     C                   PARM                    WWIN                           *IN
020200000000     C                   PARM                    WAF                            FNC KEY TABLE
020300000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
020400000000      *
020500000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
020600000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
020700000000     C                   SUB       1             WW                             BUMP IDX
020800000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
020900000000     C                   ENDSR                                                  END BLD FKY
021000000000      *___________________________________________________________________
021100000000      * Process function keys
021200000000      *___________________________________________________________________
021300000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
021400000000     C                   MOVEA     *IN           WWIN                           INDICATORS
021500000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
021600000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
021700000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
021800000000     C                   PARM                    WAD                            FNC DESC
021900000000     C                   PARM                    WWIN                           *IN
022000000000     C                   PARM                    WAF                            FNC KEY TABLE
022100000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
022200000000     C                   ENDSR                                                  END PRCFKY
022300000000      *___________________________________________________________________
022400000000      * Process KEYS function
022500000000      *___________________________________________________________________
022600000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
022700000000     C                   Z-ADD     1             WW                             KEY DSC IDX
022800000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
022900000000 001 C*                                                                         OR KEYS FOUND
023000000000 001  *
023100000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
023200000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
023300000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
023400000000E002 C                   ENDIF                                                  END IF OVER 3
023500000000 001  *
023600000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
023700000000 001 C                   SUB       1             WW                             KEY DESCR IDX
023800000000E001 C                   ENDDO                                                  END DO KEYS
023900000000      *
024000000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
024100000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
024200000000     C                   SUB       1             WW                             BUMP IDX
024300000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
024400000000      *
024500000000     C                   ENDSR                                                  END PRCDKY
024600000000      *___________________________________________________________________
024700000000      * Process RETURN function
024800000000      *___________________________________________________________________
024900000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
025000000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
025100000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
025200000000     C                   ENDSR                                                  END RETURN
025300000000      *___________________________________________________________________
025400000000      * Process CANCEL function
025500000000      *___________________________________________________________________
025600000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
025700000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
025800000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
025900000000     C                   ENDSR                                                  END PRCCNL
026000000000      *___________________________________________________________________
026100000000      * Process ROLLUP function
026200000000      *___________________________________________________________________
026300000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
026400000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
026500000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
026600000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
026700000000E001 C                   ENDIF                                                  END IF GT LST PNL
026800000000     C                   ENDSR                                                  END PRCRUP
026900000000      *___________________________________________________________________
027000000000      * Process ROLLDOWN function
027100000000      *___________________________________________________________________
027200000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
027300000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
027400000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
027500000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
027600000000E001 C                   ENDIF                                                  END IF LT FST PNL
027700000000     C                   ENDSR                                                  END PRCRDN
027800000000      *___________________________________________________________________
027900000000      * Process ENTER function
028000000000      *___________________________________________________________________
028100000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
028200000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
028300000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
028400000000     C                   ENDSR                                                  END PRCENT
028500000000      *___________________________________________________________________
028600000000      * Send message
028700000000      *___________________________________________________________________
028800000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
028900000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
029000000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
029100000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
029200000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
029300000000     C                   PARM                    WWMSG                          ERROR MESSAGE
029400000000     C                   ENDSR                                                  END SND MSG
029500000000      *___________________________________________________________________
029600000000      * Parameter lists
029700000000      *___________________________________________________________________
029800000000     C     PLIST         BEGSR                                                  PARM LISTS
029900000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
030000000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
030100000000     C                   PARM                    WORTN                          INTERNAL MODE
030200000000     C                   PARM                    WUPGM                          LAST PGM NAME
030300000000     C                   PARM                    WDDTA                          RECORD DS
030400000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
030500000000     C                   ENDSR                                                  END PLIST
030600000000      *___________________________________________________________________
030700000000      * Initialize routine
030800000000      *___________________________________________________________________
030900000000     C     *INZSR        BEGSR                                                  INITIALIZE
031000000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
031100101102     C                   MOVEL     'RNW01GRW'    WWFIL                          FILE NAME-NOTES
031200000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
031300000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
031400000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
031500000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
031600000000     C                   MOVE      WWSTT         WWSTT                          STATUS
031700000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
031800000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
031900000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
032000000000     C                   Z-ADD     WW            WW                             WORK INDEX
032100000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
032200000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
032300000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
032400000000     C                   ENDSR                                                  END DEFN
032500000000      *___________________________________________________________________
032600000000      * Program error handler
032700000000      *___________________________________________________________________
032800000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
032900000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
033000000000     C                   PARM                    WQPGMN                         PROGRAM NAME
033100000000     C                   PARM                    WQSTSC                         STATUS CODE
033200000000     C                   PARM                    WQRPGS                         RPG STATEMENT
033300000000     C                   PARM                    WQMSG                          MESSAGE ID
033400000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
033500000000      *___________________________________________________________________
033600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03370000000003EXIT    F3=Exit
03380000000012CANCEL  F12=Cancel
03390000000025ROLLUP
03400000000026ROLLDOWN
034100000000** WTM
03420010110200GAS RENEWAL File record not found.
