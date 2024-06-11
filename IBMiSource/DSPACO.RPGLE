000100000000      *_________________________________________________________________________
000200000000      *
000300110831      *  Description:  Display ACH Override Amounts
000400000000      *
000500110715      *  (C)COPYRIGHT 2011 BY GROUP BENEFIT SERVICES, INC.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900110831     FDSPACOD   CF   E             WORKSTN INFDS(DSPD)
000902110715     FACCMST    IF   E           K Disk
000903110906     FACHREM    IF   E           K DISK
001000000000      *_________________________________________________________________________
001100000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001300000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001400000000      *_________________________________________________________________________
001500000000      *
001600000000      * Data structure
001700110831     D WDDTA         E DS                  EXTNAME(ACHAOV)
001800000000      *
001900000000      * Program status data structure
002000000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002100000000      *
002200000000      * Display file data structure
002300000000     D DSPD          E DS                  EXTNAME(IODSPD)
002400000000      *
002500021008     D WIFKV           S             60A
002600021008     D WIFKY           S                   LIKE(WIFKV)
002700021008     D WIOPV           S                   LIKE(WIFKV)
002800021008     D WIRQS           S              8A
002900021008     D WORTN           S              8A
003000021008     D WUPGM           S             10A
003100021008     D WWCHG           S              1A
003200021008     D WWDLT           S              1A
003300021008     D WWDTAQ          S             10A
003400021008     D WWENDF          S              3A
003500021008     D WWENDO          S                   LIKE(WWENDF)
003600021008     D WWERR           S              1A
003700021008     D WWFIL           S             10A
003800021008     D WWFKA           S              8A
003900021008     D WWFKV           S                   LIKE(WIFKV)
004000021008     D WWFKY           S                   LIKE(WIFKV)
004100021008     D WWFLK           S            128A
004200021008     D WWFMTN          S              8A
004300021008     D WWFNC           S              8A
004400021008     D WWIJI           S             16A
004500021008     D WWIN            S             99A
004600021008     D WWLIB           S             10A
004700021008     D WWMSG           S             80A
004800021008     D WWMSGC          S              7A
004900021008     D WWOCD           S              8A
005000021008     D WWOPA           S              8A
005100021008     D WWOPN           S              1A
005200021008     D WWOPT           S              8A
005300021008     D WWOPV           S                   LIKE(WIFKV)
005400021008     D WWORQS          S                   LIKE(WIRQS)
005500021008     D WWPSNC          S              1A
005600021008     D WWQJN           S             26A
005700021008     D WWRQS           S                   LIKE(WIRQS)
005800021008     D WWRQSD          S                   LIKE(WIRQS)
005900021008     D WWRTN           S                   LIKE(WORTN)
006000021008     D WWRTND          S                   LIKE(WORTN)
006100021008     D WWRTNH          S                   LIKE(WORTN)
006200021008     D WWSFLE          S              1A
006300021008     D WWSTT           S              3A
006400021008     D WWTSK           S              8A
006500021008     D WWTXT           S             60A
006600021008     D WWUPD           S              1A
006700021008     D WWWRNF          S              1A
006800021008     D WWZERO          S             40A
006900021008     D WFRRN           S              4P 0
007000021008     D WW              S              3P 0
007100021008     D WWFKS           S              1P 0
007200021008     D WWFKSO          S                   LIKE(WWFKS)
007300021008     D WWLMT           S              2P 0
007400021008     D WWLNG           S             15P 5
007500021008     D WWLNGQ          S              5P 0
007600021008     D WWLOWR          S              4P 0
007700021008     D WWLSTS          S              2P 0
007800021008     D WWOPS           S              1P 0
007900021008     D WWOPSO          S                   LIKE(WWOPS)
008000021008     D WWPNL           S              1P 0
008100021008     D WWPNLN          S                   LIKE(WWPNL)
008200021008     D WWPNLO          S                   LIKE(WWPNL)
008300021008     D WWPSNI          S              2P 0
008400021008     D WWPSNN          S              1P 0
008500021008     D WWPSNP          S                   LIKE(WWPSNN)
008600021008     D WWRRN           S              4P 0
008700000000     ****
008800000000      *
008900040518     d bch@lda         ds
009000040518     d blah                    1    240a
009100040518     d co_name               200    240a
009200000000      *
009300000000      *_________________________________________________________________________
009400000000      * Process display panel
009500000000     C                   EXSR      PRPPNL                                       PREPARE PANEL
009600000000      *
009700000000B001 C                   DOW       WWSTT <> 'END'                               DOWHILE NOT END
009800000000 001 C                   EXSR      RCVMSG                                       RECEIVE MSGS
009900000000 001 C                   EXSR      DSPPNL                                       DISPLAY PANEL
010000000000 001 C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
010100000000 001  *
010200000000 001 C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
010300000000 001 C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
010400000000 001 C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
010500000000 001 C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
010600000000 001 C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
010700000000 001 C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
010800000000 001 C                   ENDCS                                                  END CASE
010900000000 001  *
011000000000E001 C                   ENDDO                                                  END DOWHILE
011100000000     C                   RETURN                                                 RETURN
011200000000      *___________________________________________________________________
011300000000      * Prepare display panel
011400000000      *___________________________________________________________________
011500000000     C     PRPPNL        BEGSR                                                  PREPARE PANEL
011600000000      *
011700000000     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
011800000000     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
011900000000     C                   MOVE      *BLANKS       WWSTT                          STATUS
012000000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
012100000000     C                   Z-ADD     1             WWPNL                          CURRENT PNL
012200000000     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
012300000000     C                   Z-ADD     1             WWFKS                          FNC KEY SET
012400000000     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
012500040518      *
012600040518     C     *dtaara       define    *lda          bch@lda
012700040518     C                   in        bch@lda
012800040518     c                   eval      wsname = co_name
012900000000      *
012901110715    ?C     AccKey        Chain     ACCMST
012902110715    ?C                   If        %Found(ACCMST)
012903110715     C                   Eval      WSNAM1   =    ACNAM1
012904110715    ?C                   Else
012905110715     C                   Clear                   WSNAM1
012906110715    ?C                   End
013000000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
013100000000     C                   EXSR      GETREC                                       GET RECORD
013101110906     C     AccKey        Chain     ACHREM
013102110906     C                   If        %Found(ACHREM)
013103110906     C                   Eval      ARWAMT = DATOT
013104110906     C                   Else
013105110906     C                   End
013200000000B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
013300000000 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
013400000000 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
013500000000 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
013600000000 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
013700000000E001 C                   ENDIF                                                  END IF ERROR
013800000000      *
013900000000      *
014000000000     C                   ENDSR                                                  END PRPPNL
014100000000      *___________________________________________________________________
014200000000      * Get record
014300000000      *___________________________________________________________________
014400000000     C     GETREC        BEGSR                                                  GET RECORD
014500110831     C                   CALL      'UPDACO  '                                   PROCESS REC IO
014600000000     C                   PARM      'GETNL '      WWRQS                          GET RECORD
014700000000     C                   PARM                    WWRTN                          RETURN CODE
014800000000     C                   PARM                    WDDTA                          REC DATA
014900000000     C                   ENDSR                                                  END GETREC
015000000000      *___________________________________________________________________
015100000000      * Receive messages
015200000000      *___________________________________________________________________
015300000000     C     RCVMSG        BEGSR                                                  RECEIVE MSG
015400000000     C                   MOVEA     *IN           WWIN                           INDICATORS
015500000000     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
015600000000     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
015700000000     C                   PARM                    WWIN                           INDICATORS
015800000000     C                   PARM                    WWRTN                          RETURN CODE
015900000000     C                   MOVEA     WWIN          *IN                            INDICATORS RET
016000000000     C                   ENDSR                                                  END RCV MSG
016100000000      *___________________________________________________________________
016200000000      * Display the display panel
016300000000      *___________________________________________________________________
016400000000     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
016500000000      *
016600000000      * Set OVERLAY based on last display file processed
016700000000     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
016800000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
016900000000 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
017000000000X001 C                   ELSE                                                   SAME PGM
017100000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
017200000000E001 C                   ENDIF                                                  END IF NEW PGM
017300000000      *
017400000000      * Write message subfile
017500000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
017600000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
017700000000      *
017800000000      * Write display panels
017900000000B001 C                   SELECT
018000000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
018100000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
018200000000E001 C                   ENDSL                                                  END SELECT
018300000000     C                   ENDSR                                                  END DSP DSP
018400000000      *___________________________________________________________________
018500000000      * Build function key information
018600000000      *___________________________________________________________________
018700000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
018800000000     C                   MOVEA     *IN           WWIN                           INDICATORS
018900000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
019000000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
019100000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
019200000000     C                   PARM                    WAD                            FNC DESC
019300000000     C                   PARM                    WWIN                           *IN
019400000000     C                   PARM                    WAF                            FNC KEY TABLE
019500000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
019600000000      *
019700000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
019800000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
019900000000     C                   SUB       1             WW                             BUMP IDX
020000000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
020100000000     C                   ENDSR                                                  END BLD FKY
020200000000      *___________________________________________________________________
020300000000      * Process function keys
020400000000      *___________________________________________________________________
020500000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
020600000000     C                   MOVEA     *IN           WWIN                           INDICATORS
020700000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
020800000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
020900000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
021000000000     C                   PARM                    WAD                            FNC DESC
021100000000     C                   PARM                    WWIN                           *IN
021200000000     C                   PARM                    WAF                            FNC KEY TABLE
021300000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
021400000000     C                   ENDSR                                                  END PRCFKY
021500000000      *___________________________________________________________________
021600000000      * Process KEYS function
021700000000      *___________________________________________________________________
021800000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
021900000000     C                   Z-ADD     1             WW                             KEY DSC IDX
022000000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
022100000000 001 C*                                                                         OR KEYS FOUND
022200000000 001  *
022300000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
022400000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
022500000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
022600000000E002 C                   ENDIF                                                  END IF OVER 3
022700000000 001  *
022800000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
022900000000 001 C                   SUB       1             WW                             KEY DESCR IDX
023000000000E001 C                   ENDDO                                                  END DO KEYS
023100000000      *
023200000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
023300000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
023400000000     C                   SUB       1             WW                             BUMP IDX
023500000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
023600000000      *
023700000000     C                   ENDSR                                                  END PRCDKY
023800000000      *___________________________________________________________________
023900000000      * Process RETURN function
024000000000      *___________________________________________________________________
024100000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
024200000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
024300000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
024400000000     C                   ENDSR                                                  END RETURN
024500000000      *___________________________________________________________________
024600000000      * Process CANCEL function
024700000000      *___________________________________________________________________
024800000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
024900000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
025000000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
025100000000     C                   ENDSR                                                  END PRCCNL
025200000000      *___________________________________________________________________
025300000000      * Process ROLLUP function
025400000000      *___________________________________________________________________
025500000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
025600000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
025700000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
025800000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
025900000000E001 C                   ENDIF                                                  END IF GT LST PNL
026000000000     C                   ENDSR                                                  END PRCRUP
026100000000      *___________________________________________________________________
026200000000      * Process ROLLDOWN function
026300000000      *___________________________________________________________________
026400000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
026500000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
026600000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
026700000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
026800000000E001 C                   ENDIF                                                  END IF LT FST PNL
026900000000     C                   ENDSR                                                  END PRCRDN
027000000000      *___________________________________________________________________
027100000000      * Process ENTER function
027200000000      *___________________________________________________________________
027300000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
027400000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
027500000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
027600000000     C                   ENDSR                                                  END PRCENT
027700000000      *___________________________________________________________________
027800000000      * Send message
027900000000      *___________________________________________________________________
028000000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
028100000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
028200000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
028300000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
028400000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
028500000000     C                   PARM                    WWMSG                          ERROR MESSAGE
028600000000     C                   ENDSR                                                  END SND MSG
028700000000      *___________________________________________________________________
028800000000      * Parameter lists
028900000000      *___________________________________________________________________
029000000000     C     PLIST         BEGSR                                                  PARM LISTS
029100000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
029200000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
029300000000     C                   PARM                    WORTN                          INTERNAL MODE
029400000000     C                   PARM                    WUPGM                          LAST PGM NAME
029500000000     C                   PARM                    WDDTA                          RECORD DS
029600000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
029700000000     C                   ENDSR                                                  END PLIST
029800000000      *___________________________________________________________________
029900000000      * Initialize routine
030000000000      *___________________________________________________________________
030100000000     C     *INZSR        BEGSR                                                  INITIALIZE
030200000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
030300110831     C                   MOVEL     'ACHAOV'      WWFIL                          FILE NAME-NOTES
030400000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
030500000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
030600000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
030700000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
030800000000     C                   MOVE      WWSTT         WWSTT                          STATUS
030900000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
031000000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
031100000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
031200000000     C                   Z-ADD     WW            WW                             WORK INDEX
031300000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
031400000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
031500000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
031600000000     C                   ENDSR                                                  END DEFN
031601110715      *___________________________________________________________________
031602110715      * Key lists
031603110715      *___________________________________________________________________
031604110715     C     KLIST         Begsr                                                  KEY LISTS
031605110715    ?C     SubKey        Klist                                                  ACKCTL
031606110831    ?C                   Kfld                    ARTRST
031607110831    ?C                   Kfld                    ARSUB#
031608110715    ?C     AccKey        Klist                                                  ACKCTL
031609110831    ?C                   Kfld                    ARTRST
031610110831    ?C                   Kfld                    ARSUB#
031611110831    ?C                   Kfld                    ARACCT
031615110715     C                   Endsr                                                  END KLIST
031700000000      *___________________________________________________________________
031800000000      * Program error handler
031900000000      *___________________________________________________________________
032000000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
032100000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
032200000000     C                   PARM                    WQPGMN                         PROGRAM NAME
032300000000     C                   PARM                    WQSTSC                         STATUS CODE
032400000000     C                   PARM                    WQRPGS                         RPG STATEMENT
032500000000     C                   PARM                    WQMSG                          MESSAGE ID
032600000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
032700000000      *___________________________________________________________________
032800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03290000000003EXIT    F3=Exit
03300000000012CANCEL  F12=Cancel
03310000000025ROLLUP
03320000000026ROLLDOWN
033300000000** WTM
03340011083100ACH Override Amount record not found.
