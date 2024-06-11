000100000000      *_________________________________________________________________________
000200000000      *
000300030521      *  Description:  Display TEMPORARY GROUP NUMBER
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900030521     FDSPTMPD   CF   E             WORKSTN INFDS(DSPD)
001000000000      *_________________________________________________________________________
001100000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001300000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001400000000      *_________________________________________________________________________
001500000000      *
001600000000      * Data structure
001700030521     D WDDTA         E DS                  EXTNAME(TEMPG#)
001800000000      *
001900000000      * Program status data structure
002000000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002100000000      *
002200000000      * Display file data structure
002300000000     D DSPD          E DS                  EXTNAME(IODSPD)
002400000000      *
002500021008     D WIFKV           S             60A
002600021008     D WIFKY           S                   LIKE(WIFKV)
002700030521     D WILEN           S              3P 0
002800021008     D WIOPV           S                   LIKE(WIFKV)
002900021008     D WIRQS           S              8A
003000030521     D WISTR           S            256A
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
014000030521     C                   CALL      'UPDTMP  '                                   PROCESS REC IO
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
017200030521      *
017300030521     C                   IF        TEADDT > 0
017400030521     C     TEADDT        MULT      10000.0001    TEADDT
017500030521     C                   ENDIF
017600030521      *
017700030521     C                   IF        TECHDT > 0
017800030521     C     TECHDT        MULT      10000.0001    TECHDT
017900030521     C                   ENDIF
018000030521      *
018100000000      *
018200000000      * Write display panels
018300000000B001 C                   SELECT
018400000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
018500000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
018600000000E001 C                   ENDSL                                                  END SELECT
018700000000     C                   ENDSR                                                  END DSP DSP
018800000000      *___________________________________________________________________
018900000000      * Build function key information
019000000000      *___________________________________________________________________
019100000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
019200000000     C                   MOVEA     *IN           WWIN                           INDICATORS
019300000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
019400000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
019500000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
019600000000     C                   PARM                    WAD                            FNC DESC
019700000000     C                   PARM                    WWIN                           *IN
019800000000     C                   PARM                    WAF                            FNC KEY TABLE
019900000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
020000000000      *
020100000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
020200000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
020300000000     C                   SUB       1             WW                             BUMP IDX
020400000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
020500000000     C                   ENDSR                                                  END BLD FKY
020600000000      *___________________________________________________________________
020700000000      * Process function keys
020800000000      *___________________________________________________________________
020900000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
021000000000     C                   MOVEA     *IN           WWIN                           INDICATORS
021100000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
021200000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
021300000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
021400000000     C                   PARM                    WAD                            FNC DESC
021500000000     C                   PARM                    WWIN                           *IN
021600000000     C                   PARM                    WAF                            FNC KEY TABLE
021700000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
021800000000     C                   ENDSR                                                  END PRCFKY
021900000000      *___________________________________________________________________
022000000000      * Process KEYS function
022100000000      *___________________________________________________________________
022200000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
022300000000     C                   Z-ADD     1             WW                             KEY DSC IDX
022400000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
022500000000 001 C*                                                                         OR KEYS FOUND
022600000000 001  *
022700000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
022800000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
022900000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
023000000000E002 C                   ENDIF                                                  END IF OVER 3
023100000000 001  *
023200000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
023300000000 001 C                   SUB       1             WW                             KEY DESCR IDX
023400000000E001 C                   ENDDO                                                  END DO KEYS
023500000000      *
023600000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
023700000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
023800000000     C                   SUB       1             WW                             BUMP IDX
023900000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
024000000000      *
024100000000     C                   ENDSR                                                  END PRCDKY
024200000000      *___________________________________________________________________
024300000000      * Process RETURN function
024400000000      *___________________________________________________________________
024500000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
024600000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
024700000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
024800000000     C                   ENDSR                                                  END RETURN
024900000000      *___________________________________________________________________
025000000000      * Process CANCEL function
025100000000      *___________________________________________________________________
025200000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
025300000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
025400000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
025500000000     C                   ENDSR                                                  END PRCCNL
025600000000      *___________________________________________________________________
025700000000      * Process ROLLUP function
025800000000      *___________________________________________________________________
025900000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
026000000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
026100000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
026200000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
026300000000E001 C                   ENDIF                                                  END IF GT LST PNL
026400000000     C                   ENDSR                                                  END PRCRUP
026500000000      *___________________________________________________________________
026600000000      * Process ROLLDOWN function
026700000000      *___________________________________________________________________
026800000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
026900000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
027000000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
027100000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
027200000000E001 C                   ENDIF                                                  END IF LT FST PNL
027300000000     C                   ENDSR                                                  END PRCRDN
027400000000      *___________________________________________________________________
027500000000      * Process ENTER function
027600000000      *___________________________________________________________________
027700000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
027800000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
027900000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
028000000000     C                   ENDSR                                                  END PRCENT
028100000000      *___________________________________________________________________
028200000000      * Send message
028300000000      *___________________________________________________________________
028400000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
028500000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
028600000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
028700000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
028800000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
028900000000     C                   PARM                    WWMSG                          ERROR MESSAGE
029000000000     C                   ENDSR                                                  END SND MSG
029100000000      *___________________________________________________________________
029200000000      * Parameter lists
029300000000      *___________________________________________________________________
029400000000     C     PLIST         BEGSR                                                  PARM LISTS
029500000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
029600000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
029700000000     C                   PARM                    WORTN                          INTERNAL MODE
029800000000     C                   PARM                    WUPGM                          LAST PGM NAME
029900000000     C                   PARM                    WDDTA                          RECORD DS
030000000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
030100000000     C                   ENDSR                                                  END PLIST
030200000000      *___________________________________________________________________
030300000000      * Initialize routine
030400000000      *___________________________________________________________________
030500000000     C     *INZSR        BEGSR                                                  INITIALIZE
030600030521    ***
030700030521     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
030800030521     C                   IN        @DTA50
030900030521    ***
031000030521     C                   EVAL      wistr = %SUBST(@DTA50:1:40)
031100030521     C                   Z-ADD     50            WILEN
031200030521     C                   CALL      'UTLCENSTR'
031300030521     C                   PARM                    WISTR
031400030521     C                   PARM                    WILEN
031500030521     C                   MOVEL     WISTR         WSNAME
031600030521    ***
031700000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
031800030521     C                   MOVEL     'TEMPG#  '    WWFIL                          FILE NAME-NOTES
031900000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
032000000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
032100000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
032200000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
032300000000     C                   MOVE      WWSTT         WWSTT                          STATUS
032400000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
032500000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
032600000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
032700000000     C                   Z-ADD     WW            WW                             WORK INDEX
032800000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
032900000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
033000000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
033100000000     C                   ENDSR                                                  END DEFN
033200000000      *___________________________________________________________________
033300000000      * Program error handler
033400000000      *___________________________________________________________________
033500000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
033600000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
033700000000     C                   PARM                    WQPGMN                         PROGRAM NAME
033800000000     C                   PARM                    WQSTSC                         STATUS CODE
033900000000     C                   PARM                    WQRPGS                         RPG STATEMENT
034000000000     C                   PARM                    WQMSG                          MESSAGE ID
034100000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
034200000000      *___________________________________________________________________
034300000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03440000000003EXIT    F3=Exit
03450000000012CANCEL  F12=Cancel
03460000000025ROLLUP
03470000000026ROLLDOWN
034800000000** WTM
03490003052100TEMPORARY GROUP NUMBER File record not found.
