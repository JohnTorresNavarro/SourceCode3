000100000000      *_________________________________________________________________________
000200000000      *
000300130131      *  Description:  Display MEMBER ALTERNATE ID
000400000000      *
000500130131      *  (C)COPYRIGHT 2013 BY GROUP BENEFIT SERVICES, INC.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900130208     FDSPMLTD   CF   E             WORKSTN INFDS(DSPD)
001000000000      *_________________________________________________________________________
001100000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001300000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001400000000      *_________________________________________________________________________
001500000000      *
001600000000      * Data structure
001700130208     D WDDTA         E DS                  EXTNAME(MEMALT)
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
008900000000      *
009000000000      *_________________________________________________________________________
009100000000      * Process display panel
009200000000     C                   EXSR      PRPPNL                                       PREPARE PANEL
009300000000      *
009400000000B001 C                   DOW       WWSTT <> 'END'                               DOWHILE NOT END
009500000000 001 C                   EXSR      RCVMSG                                       RECEIVE MSGS
009600000000 001 C                   EXSR      DSPPNL                                       DISPLAY PANEL
009700000000 001 C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
009800000000 001  *
009900000000 001 C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
010000000000 001 C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
010100000000 001 C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
010200000000 001 C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
010300000000 001 C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
010400000000 001 C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
010500000000 001 C                   ENDCS                                                  END CASE
010600000000 001  *
010700000000E001 C                   ENDDO                                                  END DOWHILE
010800000000     C                   RETURN                                                 RETURN
010900000000      *___________________________________________________________________
011000000000      * Prepare display panel
011100000000      *___________________________________________________________________
011200000000     C     PRPPNL        BEGSR                                                  PREPARE PANEL
011300130208      *
011400130208     C     *DTAARA       DEFINE    COMPANY       @LDA             50
011500130208     C                   IN        @LDA
011600130208     c                   EVAL      WSNAME = %SUBST(@LDA:1:40)
011700000000      *
011800000000     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
011900000000     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
012000000000     C                   MOVE      *BLANKS       WWSTT                          STATUS
012100000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
012200000000     C                   Z-ADD     1             WWPNL                          CURRENT PNL
012300000000     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
012400000000     C                   Z-ADD     1             WWFKS                          FNC KEY SET
012500000000     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
012600000000      *
012700000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
012800000000     C                   EXSR      GETREC                                       GET RECORD
012900000000B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
013000000000 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
013100000000 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
013200000000 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
013300000000 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
013400000000E001 C                   ENDIF                                                  END IF ERROR
013500000000      *
013600000000      *
013700000000     C                   ENDSR                                                  END PRPPNL
013800000000      *___________________________________________________________________
013900000000      * Get record
014000000000      *___________________________________________________________________
014100000000     C     GETREC        BEGSR                                                  GET RECORD
014200130208     C                   CALL      'UPDMLT  '                                   PROCESS REC IO
014300000000     C                   PARM      'GETNL '      WWRQS                          GET RECORD
014400000000     C                   PARM                    WWRTN                          RETURN CODE
014500000000     C                   PARM                    WDDTA                          REC DATA
014600000000     C                   ENDSR                                                  END GETREC
014700000000      *___________________________________________________________________
014800000000      * Receive messages
014900000000      *___________________________________________________________________
015000000000     C     RCVMSG        BEGSR                                                  RECEIVE MSG
015100000000     C                   MOVEA     *IN           WWIN                           INDICATORS
015200000000     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
015300000000     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
015400000000     C                   PARM                    WWIN                           INDICATORS
015500000000     C                   PARM                    WWRTN                          RETURN CODE
015600000000     C                   MOVEA     WWIN          *IN                            INDICATORS RET
015700000000     C                   ENDSR                                                  END RCV MSG
015800000000      *___________________________________________________________________
015900000000      * Display the display panel
016000000000      *___________________________________________________________________
016100000000     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
016200000000      *
016300000000      * Set OVERLAY based on last display file processed
016400000000     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
016500000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
016600000000 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
016700000000X001 C                   ELSE                                                   SAME PGM
016800000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
016900000000E001 C                   ENDIF                                                  END IF NEW PGM
017000000000      *
017100000000      * Write message subfile
017200000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
017300000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
017400000000      *
017500000000      * Write display panels
017600000000B001 C                   SELECT
017700000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
017800130208     C                   EXSR      $GETDTA
017900000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
018000000000E001 C                   ENDSL                                                  END SELECT
018100000000     C                   ENDSR                                                  END DSP DSP
018200130208   S***S
018300130208     C     $GETDTA       BEGSR
018400130208    ***
018500130208     C                   EVAL      D_ALTTP = *BLANKS
018600130208     C                   SELECT
018700130208     C                   WHEN      MAALTTP = 'AH'
018800130208     C                   EVAL      D_ALTTP = 'AETNA (US) HEALTHCARE'
018900130208     C                   WHEN      MAALTTP = 'CH '
019000130208     C                   EVAL      D_ALTTP = 'COVENTRY HEALTH'
019100130208     C                   WHEN      MAALTTP = 'CI '
019200130208     C                   EVAL      D_ALTTP = 'CIGNA'
019300130208     C                   WHEN      MAALTTP = 'FI '
019400130208     C                   EVAL      D_ALTTP = 'MARYLAND FIDELITY'
019500130208     C                   WHEN      MAALTTP = 'GBS'
019600130208     C                   EVAL      D_ALTTP = 'GBS - ALTERNATE ID'
019700130208     C                   WHEN      MAALTTP = 'HI '
019800130208     C                   EVAL      D_ALTTP = 'HIGHMARK'
019900130208     C                   WHEN      MAALTTP = 'HRO'
020000130208     C                   EVAL      D_ALTTP = 'HR OFFICE'
020100130208     C                   WHEN      MAALTTP = 'IMD'
020200130208     C                   EVAL      D_ALTTP = 'G.A.S. IND MKT DIV MEMBERS'
020300130208     C                   WHEN      MAALTTP = 'KP '
020400130208     C                   EVAL      D_ALTTP = 'KAISER PERMANENTE'
020500130208     C                   WHEN      MAALTTP = 'MA '
020600130208     C                   EVAL      D_ALTTP = 'MAMSI/OPTIMUM'
020700130208     C                   WHEN      MAALTTP = 'UH '
020800130208     C                   EVAL      D_ALTTP = 'UNITED HEALTHCARE'
020900130208     C                   WHEN      MAALTTP = '00 '
021000130208     C                   EVAL      D_ALTTP = 'CARE FIRST - NASCO'
021100130208     C                   WHEN      MAALTTP = '01 '
021200130208     C                   EVAL      D_ALTTP = 'CARE FIRST - EAB'
021300130208     C                   WHEN      MAALTTP = '08 '
021400130208     C                   EVAL      D_ALTTP = 'CARE FIRST - FACETS'
021500130208     C                   ENDSL
021600130208    ***
021700130208     C     MACRTDT       MULT      10000.0001    SCCRTDT
021800130208    ***
021900130208     C                   ENDSR
022000130208   S***S
022100000000      *___________________________________________________________________
022200000000      * Build function key information
022300000000      *___________________________________________________________________
022400000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
022500000000     C                   MOVEA     *IN           WWIN                           INDICATORS
022600000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
022700000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
022800000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
022900000000     C                   PARM                    WAD                            FNC DESC
023000000000     C                   PARM                    WWIN                           *IN
023100000000     C                   PARM                    WAF                            FNC KEY TABLE
023200000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
023300000000      *
023400000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
023500000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
023600000000     C                   SUB       1             WW                             BUMP IDX
023700000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
023800000000     C                   ENDSR                                                  END BLD FKY
023900000000      *___________________________________________________________________
024000000000      * Process function keys
024100000000      *___________________________________________________________________
024200000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
024300000000     C                   MOVEA     *IN           WWIN                           INDICATORS
024400000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
024500000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
024600000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
024700000000     C                   PARM                    WAD                            FNC DESC
024800000000     C                   PARM                    WWIN                           *IN
024900000000     C                   PARM                    WAF                            FNC KEY TABLE
025000000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
025100000000     C                   ENDSR                                                  END PRCFKY
025200000000      *___________________________________________________________________
025300000000      * Process KEYS function
025400000000      *___________________________________________________________________
025500000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
025600000000     C                   Z-ADD     1             WW                             KEY DSC IDX
025700000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
025800000000 001 C*                                                                         OR KEYS FOUND
025900000000 001  *
026000000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
026100000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
026200000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
026300000000E002 C                   ENDIF                                                  END IF OVER 3
026400000000 001  *
026500000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
026600000000 001 C                   SUB       1             WW                             KEY DESCR IDX
026700000000E001 C                   ENDDO                                                  END DO KEYS
026800000000      *
026900000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
027000000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
027100000000     C                   SUB       1             WW                             BUMP IDX
027200000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
027300000000      *
027400000000     C                   ENDSR                                                  END PRCDKY
027500000000      *___________________________________________________________________
027600000000      * Process RETURN function
027700000000      *___________________________________________________________________
027800000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
027900000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
028000000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
028100000000     C                   ENDSR                                                  END RETURN
028200000000      *___________________________________________________________________
028300000000      * Process CANCEL function
028400000000      *___________________________________________________________________
028500000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
028600000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
028700000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
028800000000     C                   ENDSR                                                  END PRCCNL
028900000000      *___________________________________________________________________
029000000000      * Process ROLLUP function
029100000000      *___________________________________________________________________
029200000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
029300000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
029400000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
029500000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
029600000000E001 C                   ENDIF                                                  END IF GT LST PNL
029700000000     C                   ENDSR                                                  END PRCRUP
029800000000      *___________________________________________________________________
029900000000      * Process ROLLDOWN function
030000000000      *___________________________________________________________________
030100000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
030200000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
030300000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
030400000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
030500000000E001 C                   ENDIF                                                  END IF LT FST PNL
030600000000     C                   ENDSR                                                  END PRCRDN
030700000000      *___________________________________________________________________
030800000000      * Process ENTER function
030900000000      *___________________________________________________________________
031000000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
031100000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
031200000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
031300000000     C                   ENDSR                                                  END PRCENT
031400000000      *___________________________________________________________________
031500000000      * Send message
031600000000      *___________________________________________________________________
031700000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
031800000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
031900000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
032000000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
032100000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
032200000000     C                   PARM                    WWMSG                          ERROR MESSAGE
032300000000     C                   ENDSR                                                  END SND MSG
032400000000      *___________________________________________________________________
032500000000      * Parameter lists
032600000000      *___________________________________________________________________
032700000000     C     PLIST         BEGSR                                                  PARM LISTS
032800000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
032900000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
033000000000     C                   PARM                    WORTN                          INTERNAL MODE
033100000000     C                   PARM                    WUPGM                          LAST PGM NAME
033200000000     C                   PARM                    WDDTA                          RECORD DS
033300000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
033400000000     C                   ENDSR                                                  END PLIST
033500000000      *___________________________________________________________________
033600000000      * Initialize routine
033700000000      *___________________________________________________________________
033800000000     C     *INZSR        BEGSR                                                  INITIALIZE
033900000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
034000130208     C                   MOVEL(P)  'MEMALT'      WWFIL                          FILE NAME-NOTES
034100000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
034200000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
034300000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
034400000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
034500000000     C                   MOVE      WWSTT         WWSTT                          STATUS
034600000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
034700000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
034800000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
034900000000     C                   Z-ADD     WW            WW                             WORK INDEX
035000000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
035100000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
035200000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
035300000000     C                   ENDSR                                                  END DEFN
035400000000      *___________________________________________________________________
035500000000      * Program error handler
035600000000      *___________________________________________________________________
035700000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
035800000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
035900000000     C                   PARM                    WQPGMN                         PROGRAM NAME
036000000000     C                   PARM                    WQSTSC                         STATUS CODE
036100000000     C                   PARM                    WQRPGS                         RPG STATEMENT
036200000000     C                   PARM                    WQMSG                          MESSAGE ID
036300000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
036400000000      *___________________________________________________________________
036500000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03660000000003EXIT    F3=Exit
03670000000012CANCEL  F12=Cancel
03680000000025ROLLUP
03690000000026ROLLDOWN
037000000000** WTM
03710013020800MEMBER ALTERNATE ID File record not found.
