000100170720     H option(*noDebugIo)
000200000000      *_________________________________________________________________________
000300000000      *
000400110831      *  Description:  Display ACH Override Amounts
000500000000      *
000600110715      *  (C)COPYRIGHT 2011 BY GROUP BENEFIT SERVICES, INC.
000700000000      *
000800000000      *_________________________________________________________________________
000900000000      *
001000110831     FDSPACOD   CF   E             WORKSTN INFDS(DSPD)
001100170801     FACCMST    IF   E           K Disk    ExtFile('F.ACCMST')
001200170718     FAFAREM    IF   E           K DISK
001300000000      *_________________________________________________________________________
001400000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001600000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001700000000      *_________________________________________________________________________
001800000000      *
001900000000      * Data structure
002000170718     D WDDTA         E DS                  EXTNAME(AFAAOV)
002100000000      *
002200000000      * Program status data structure
002300000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002400000000      *
002500000000      * Display file data structure
002600000000     D DSPD          E DS                  EXTNAME(IODSPD)
002700000000      *
002800021008     D WIFKV           S             60A
002900021008     D WIFKY           S                   LIKE(WIFKV)
003000021008     D WIOPV           S                   LIKE(WIFKV)
003100021008     D WIRQS           S              8A
003200021008     D WORTN           S              8A
003300021008     D WUPGM           S             10A
003400021008     D WWCHG           S              1A
003500021008     D WWDLT           S              1A
003600021008     D WWDTAQ          S             10A
003700021008     D WWENDF          S              3A
003800021008     D WWENDO          S                   LIKE(WWENDF)
003900021008     D WWERR           S              1A
004000021008     D WWFIL           S             10A
004100021008     D WWFKA           S              8A
004200021008     D WWFKV           S                   LIKE(WIFKV)
004300021008     D WWFKY           S                   LIKE(WIFKV)
004400021008     D WWFLK           S            128A
004500021008     D WWFMTN          S              8A
004600021008     D WWFNC           S              8A
004700021008     D WWIJI           S             16A
004800021008     D WWIN            S             99A
004900021008     D WWLIB           S             10A
005000021008     D WWMSG           S             80A
005100021008     D WWMSGC          S              7A
005200021008     D WWOCD           S              8A
005300021008     D WWOPA           S              8A
005400021008     D WWOPN           S              1A
005500021008     D WWOPT           S              8A
005600021008     D WWOPV           S                   LIKE(WIFKV)
005700021008     D WWORQS          S                   LIKE(WIRQS)
005800021008     D WWPSNC          S              1A
005900021008     D WWQJN           S             26A
006000021008     D WWRQS           S                   LIKE(WIRQS)
006100021008     D WWRQSD          S                   LIKE(WIRQS)
006200021008     D WWRTN           S                   LIKE(WORTN)
006300021008     D WWRTND          S                   LIKE(WORTN)
006400021008     D WWRTNH          S                   LIKE(WORTN)
006500021008     D WWSFLE          S              1A
006600021008     D WWSTT           S              3A
006700021008     D WWTSK           S              8A
006800021008     D WWTXT           S             60A
006900021008     D WWUPD           S              1A
007000021008     D WWWRNF          S              1A
007100021008     D WWZERO          S             40A
007200021008     D WFRRN           S              4P 0
007300021008     D WW              S              3P 0
007400021008     D WWFKS           S              1P 0
007500021008     D WWFKSO          S                   LIKE(WWFKS)
007600021008     D WWLMT           S              2P 0
007700021008     D WWLNG           S             15P 5
007800021008     D WWLNGQ          S              5P 0
007900021008     D WWLOWR          S              4P 0
008000021008     D WWLSTS          S              2P 0
008100021008     D WWOPS           S              1P 0
008200021008     D WWOPSO          S                   LIKE(WWOPS)
008300021008     D WWPNL           S              1P 0
008400021008     D WWPNLN          S                   LIKE(WWPNL)
008500021008     D WWPNLO          S                   LIKE(WWPNL)
008600021008     D WWPSNI          S              2P 0
008700021008     D WWPSNN          S              1P 0
008800021008     D WWPSNP          S                   LIKE(WWPSNN)
008900021008     D WWRRN           S              4P 0
009000000000     ****
009100000000      *
009200040518     d bch@lda         ds
009300040518     d blah                    1    240a
009400040518     d co_name               200    240a
009500000000      *
009600000000      *_________________________________________________________________________
009700000000      * Process display panel
009800000000     C                   EXSR      PRPPNL                                       PREPARE PANEL
009900000000      *
010000000000B001 C                   DOW       WWSTT <> 'END'                               DOWHILE NOT END
010100000000 001 C                   EXSR      RCVMSG                                       RECEIVE MSGS
010200000000 001 C                   EXSR      DSPPNL                                       DISPLAY PANEL
010300000000 001 C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
010400000000 001  *
010500000000 001 C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
010600000000 001 C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
010700000000 001 C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
010800000000 001 C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
010900000000 001 C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
011000000000 001 C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
011100000000 001 C                   ENDCS                                                  END CASE
011200000000 001  *
011300000000E001 C                   ENDDO                                                  END DOWHILE
011400000000     C                   RETURN                                                 RETURN
011500000000      *___________________________________________________________________
011600000000      * Prepare display panel
011700000000      *___________________________________________________________________
011800000000     C     PRPPNL        BEGSR                                                  PREPARE PANEL
011900000000      *
012000000000     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
012100000000     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
012200000000     C                   MOVE      *BLANKS       WWSTT                          STATUS
012300000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
012400000000     C                   Z-ADD     1             WWPNL                          CURRENT PNL
012500000000     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
012600000000     C                   Z-ADD     1             WWFKS                          FNC KEY SET
012700000000     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
012800040518      *
012900040518     C     *dtaara       define    *lda          bch@lda
013000040518     C                   in        bch@lda
013100040518     c                   eval      wsname = co_name
013200000000      *
013300110715    ?C     AccKey        Chain     ACCMST
013400110715    ?C                   If        %Found(ACCMST)
013500110715     C                   Eval      WSNAM1   =    ACNAM1
013600110715    ?C                   Else
013700110715     C                   Clear                   WSNAM1
013800110715    ?C                   End
013900000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
014000000000     C                   EXSR      GETREC                                       GET RECORD
014100170718     C     AccKey        Chain     AFAREM
014200170718     C                   If        %Found(AFAREM)
014300110906     C                   Eval      ARWAMT = DATOT
014400110906     C                   Else
014500110906     C                   End
014600000000B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
014700000000 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
014800000000 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
014900000000 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
015000000000 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
015100000000E001 C                   ENDIF                                                  END IF ERROR
015200000000      *
015300000000      *
015400000000     C                   ENDSR                                                  END PRPPNL
015500000000      *___________________________________________________________________
015600000000      * Get record
015700000000      *___________________________________________________________________
015800000000     C     GETREC        BEGSR                                                  GET RECORD
015900170720     C                   CALL      'UPDAFO  '                                   PROCESS REC IO
016000000000     C                   PARM      'GETNL '      WWRQS                          GET RECORD
016100000000     C                   PARM                    WWRTN                          RETURN CODE
016200000000     C                   PARM                    WDDTA                          REC DATA
016300000000     C                   ENDSR                                                  END GETREC
016400000000      *___________________________________________________________________
016500000000      * Receive messages
016600000000      *___________________________________________________________________
016700000000     C     RCVMSG        BEGSR                                                  RECEIVE MSG
016800000000     C                   MOVEA     *IN           WWIN                           INDICATORS
016900000000     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
017000000000     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
017100000000     C                   PARM                    WWIN                           INDICATORS
017200000000     C                   PARM                    WWRTN                          RETURN CODE
017300000000     C                   MOVEA     WWIN          *IN                            INDICATORS RET
017400000000     C                   ENDSR                                                  END RCV MSG
017500000000      *___________________________________________________________________
017600000000      * Display the display panel
017700000000      *___________________________________________________________________
017800000000     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
017900000000      *
018000000000      * Set OVERLAY based on last display file processed
018100000000     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
018200000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
018300000000 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
018400000000X001 C                   ELSE                                                   SAME PGM
018500000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
018600000000E001 C                   ENDIF                                                  END IF NEW PGM
018700000000      *
018800000000      * Write message subfile
018900000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
019000000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
019100000000      *
019200000000      * Write display panels
019300000000B001 C                   SELECT
019400000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
019500000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
019600000000E001 C                   ENDSL                                                  END SELECT
019700000000     C                   ENDSR                                                  END DSP DSP
019800000000      *___________________________________________________________________
019900000000      * Build function key information
020000000000      *___________________________________________________________________
020100000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
020200000000     C                   MOVEA     *IN           WWIN                           INDICATORS
020300000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
020400000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
020500000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
020600000000     C                   PARM                    WAD                            FNC DESC
020700000000     C                   PARM                    WWIN                           *IN
020800000000     C                   PARM                    WAF                            FNC KEY TABLE
020900000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
021000000000      *
021100000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
021200000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
021300000000     C                   SUB       1             WW                             BUMP IDX
021400000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
021500000000     C                   ENDSR                                                  END BLD FKY
021600000000      *___________________________________________________________________
021700000000      * Process function keys
021800000000      *___________________________________________________________________
021900000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
022000000000     C                   MOVEA     *IN           WWIN                           INDICATORS
022100000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
022200000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
022300000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
022400000000     C                   PARM                    WAD                            FNC DESC
022500000000     C                   PARM                    WWIN                           *IN
022600000000     C                   PARM                    WAF                            FNC KEY TABLE
022700000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
022800000000     C                   ENDSR                                                  END PRCFKY
022900000000      *___________________________________________________________________
023000000000      * Process KEYS function
023100000000      *___________________________________________________________________
023200000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
023300000000     C                   Z-ADD     1             WW                             KEY DSC IDX
023400000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
023500000000 001 C*                                                                         OR KEYS FOUND
023600000000 001  *
023700000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
023800000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
023900000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
024000000000E002 C                   ENDIF                                                  END IF OVER 3
024100000000 001  *
024200000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
024300000000 001 C                   SUB       1             WW                             KEY DESCR IDX
024400000000E001 C                   ENDDO                                                  END DO KEYS
024500000000      *
024600000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
024700000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
024800000000     C                   SUB       1             WW                             BUMP IDX
024900000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
025000000000      *
025100000000     C                   ENDSR                                                  END PRCDKY
025200000000      *___________________________________________________________________
025300000000      * Process RETURN function
025400000000      *___________________________________________________________________
025500000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
025600000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
025700000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
025800000000     C                   ENDSR                                                  END RETURN
025900000000      *___________________________________________________________________
026000000000      * Process CANCEL function
026100000000      *___________________________________________________________________
026200000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
026300000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
026400000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
026500000000     C                   ENDSR                                                  END PRCCNL
026600000000      *___________________________________________________________________
026700000000      * Process ROLLUP function
026800000000      *___________________________________________________________________
026900000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
027000000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
027100000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
027200000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
027300000000E001 C                   ENDIF                                                  END IF GT LST PNL
027400000000     C                   ENDSR                                                  END PRCRUP
027500000000      *___________________________________________________________________
027600000000      * Process ROLLDOWN function
027700000000      *___________________________________________________________________
027800000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
027900000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
028000000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
028100000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
028200000000E001 C                   ENDIF                                                  END IF LT FST PNL
028300000000     C                   ENDSR                                                  END PRCRDN
028400000000      *___________________________________________________________________
028500000000      * Process ENTER function
028600000000      *___________________________________________________________________
028700000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
028800000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
028900000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
029000000000     C                   ENDSR                                                  END PRCENT
029100000000      *___________________________________________________________________
029200000000      * Send message
029300000000      *___________________________________________________________________
029400000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
029500000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
029600000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
029700000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
029800000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
029900000000     C                   PARM                    WWMSG                          ERROR MESSAGE
030000000000     C                   ENDSR                                                  END SND MSG
030100000000      *___________________________________________________________________
030200000000      * Parameter lists
030300000000      *___________________________________________________________________
030400000000     C     PLIST         BEGSR                                                  PARM LISTS
030500000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
030600000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
030700000000     C                   PARM                    WORTN                          INTERNAL MODE
030800000000     C                   PARM                    WUPGM                          LAST PGM NAME
030900000000     C                   PARM                    WDDTA                          RECORD DS
031000000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
031100000000     C                   ENDSR                                                  END PLIST
031200000000      *___________________________________________________________________
031300000000      * Initialize routine
031400000000      *___________________________________________________________________
031500000000     C     *INZSR        BEGSR                                                  INITIALIZE
031600000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
031700170718     C                   MOVEL     'AFAAOV'      WWFIL                          FILE NAME-NOTES
031800000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
031900000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
032000000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
032100000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
032200000000     C                   MOVE      WWSTT         WWSTT                          STATUS
032300000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
032400000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
032500000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
032600000000     C                   Z-ADD     WW            WW                             WORK INDEX
032700000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
032800000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
032900000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
033000000000     C                   ENDSR                                                  END DEFN
033100110715      *___________________________________________________________________
033200110715      * Key lists
033300110715      *___________________________________________________________________
033400110715     C     KLIST         Begsr                                                  KEY LISTS
033500110715    ?C     SubKey        Klist                                                  ACKCTL
033600110831    ?C                   Kfld                    ARTRST
033700110831    ?C                   Kfld                    ARSUB#
033800110715    ?C     AccKey        Klist                                                  ACKCTL
033900110831    ?C                   Kfld                    ARTRST
034000110831    ?C                   Kfld                    ARSUB#
034100110831    ?C                   Kfld                    ARACCT
034200110715     C                   Endsr                                                  END KLIST
034300000000      *___________________________________________________________________
034400000000      * Program error handler
034500000000      *___________________________________________________________________
034600000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
034700000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
034800000000     C                   PARM                    WQPGMN                         PROGRAM NAME
034900000000     C                   PARM                    WQSTSC                         STATUS CODE
035000000000     C                   PARM                    WQRPGS                         RPG STATEMENT
035100000000     C                   PARM                    WQMSG                          MESSAGE ID
035200000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
035300000000      *___________________________________________________________________
035400000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03550000000003EXIT    F3=Exit
03560000000012CANCEL  F12=Cancel
03570000000025ROLLUP
03580000000026ROLLDOWN
035900000000** WTM
03600017071800AFA Override Amount record not found.
