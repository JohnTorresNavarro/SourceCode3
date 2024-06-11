000100051216      *_________________________________________________________________________
000200051216      *
000300051216      *  Description:  Display PROVIDERS FOR MBR/GRP
000400051216      *
000500051216      *  (C)COPYRIGHT 2004 BY GROUP BENEFIT SERVICES, INC.
000600051216      *
000700051216      *_________________________________________________________________________
000800051216      *
000900051216     FDSPDDCD   CF   E             WORKSTN INFDS(DSPD)
001000051216      *_________________________________________________________________________
001100051216     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200051216     D WAD             S             80    DIM(6)                               FUNCTION DESC
001300051216     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001400051216      *_________________________________________________________________________
001500051216      *
001600051216      * Data structure
001700051216     D WDDTA         E DS                  EXTNAME(DBEDOC)
001800051216      *
001900051216      * Program status data structure
002000051216     D PGMD          ESDS                  EXTNAME(IOPGMD)
002100051216      *
002200051216      * Display file data structure
002300051216     D DSPD          E DS                  EXTNAME(IODSPD)
002400051216      *
002500051216     D WIFKV           S             60A
002600051216     D WIFKY           S                   LIKE(WIFKV)
002700051216     D WIOPV           S                   LIKE(WIFKV)
002800051216     D WIRQS           S              8A
002900051216     D WORTN           S              8A
003000051216     D WUPGM           S             10A
003100051216     D WWCHG           S              1A
003200051216     D WWDLT           S              1A
003300051216     D WWDTAQ          S             10A
003400051216     D WWENDF          S              3A
003500051216     D WWENDO          S                   LIKE(WWENDF)
003600051216     D WWERR           S              1A
003700051216     D WWFIL           S             10A
003800051216     D WWFKA           S              8A
003900051216     D WWFKV           S                   LIKE(WIFKV)
004000051216     D WWFKY           S                   LIKE(WIFKV)
004100051216     D WWFLK           S            128A
004200051216     D WWFMTN          S              8A
004300051216     D WWFNC           S              8A
004400051216     D WWIJI           S             16A
004500051216     D WWIN            S             99A
004600051216     D WWLIB           S             10A
004700051216     D WWMSG           S             80A
004800051216     D WWMSGC          S              7A
004900051216     D WWOCD           S              8A
005000051216     D WWOPA           S              8A
005100051216     D WWOPN           S              1A
005200051216     D WWOPT           S              8A
005300051216     D WWOPV           S                   LIKE(WIFKV)
005400051216     D WWORQS          S                   LIKE(WIRQS)
005500051216     D WWPSNC          S              1A
005600051216     D WWQJN           S             26A
005700051216     D WWRQS           S                   LIKE(WIRQS)
005800051216     D WWRQSD          S                   LIKE(WIRQS)
005900051216     D WWRTN           S                   LIKE(WORTN)
006000051216     D WWRTND          S                   LIKE(WORTN)
006100051216     D WWRTNH          S                   LIKE(WORTN)
006200051216     D WWSFLE          S              1A
006300051216     D WWSTT           S              3A
006400051216     D WWTSK           S              8A
006500051216     D WWTXT           S             60A
006600051216     D WWUPD           S              1A
006700051216     D WWWRNF          S              1A
006800051216     D WWZERO          S             40A
006900051216     D WFRRN           S              4P 0
007000051216     D WW              S              3P 0
007100051216     D WWFKS           S              1P 0
007200051216     D WWFKSO          S                   LIKE(WWFKS)
007300051216     D WWLMT           S              2P 0
007400051216     D WWLNG           S             15P 5
007500051216     D WWLNGQ          S              5P 0
007600051216     D WWLOWR          S              4P 0
007700051216     D WWLSTS          S              2P 0
007800051216     D WWOPS           S              1P 0
007900051216     D WWOPSO          S                   LIKE(WWOPS)
008000051216     D WWPNL           S              1P 0
008100051216     D WWPNLN          S                   LIKE(WWPNL)
008200051216     D WWPNLO          S                   LIKE(WWPNL)
008300051216     D WWPSNI          S              2P 0
008400051216     D WWPSNN          S              1P 0
008500051216     D WWPSNP          S                   LIKE(WWPSNN)
008600051216     D WWRRN           S              4P 0
008700051216     ****
008800051216      *
008900051216      *
009000051216      *_________________________________________________________________________
009100051216      * Process display panel
009200051216     C                   EXSR      PRPPNL                                       PREPARE PANEL
009300051216      *
009400051216B001 C                   DOW       WWSTT <> 'END'                               DOWHILE NOT END
009500051216 001 C                   EXSR      RCVMSG                                       RECEIVE MSGS
009600051216 001 C                   EXSR      DSPPNL                                       DISPLAY PANEL
009700051216 001 C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
009800051216 001  *
009900051216 001 C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
010000051216 001 C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
010100051216 001 C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
010200051216 001 C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
010300051216 001 C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
010400051216 001 C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
010500051216 001 C                   ENDCS                                                  END CASE
010600051216 001  *
010700051216E001 C                   ENDDO                                                  END DOWHILE
010800051216     C                   RETURN                                                 RETURN
010900051216      *___________________________________________________________________
011000051216      * Prepare display panel
011100051216      *___________________________________________________________________
011200051216     C     PRPPNL        BEGSR                                                  PREPARE PANEL
011300051216      *
011400051216     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
011500051216     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
011600051216     C                   MOVE      *BLANKS       WWSTT                          STATUS
011700051216     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
011800051216     C                   Z-ADD     1             WWPNL                          CURRENT PNL
011900051216     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
012000051216     C                   Z-ADD     1             WWFKS                          FNC KEY SET
012100051216     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
012200051216      *
012300051216     C                   EXSR      BLDFKY                                       BUILD FNCTNS
012400051216     C                   EXSR      GETREC                                       GET RECORD
012500051216B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
012600051216 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
012700051216 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
012800051216 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
012900051216 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
013000051216E001 C                   ENDIF                                                  END IF ERROR
013100051216      *
013200051216      *
013300051216     C                   ENDSR                                                  END PRPPNL
013400051216      *___________________________________________________________________
013500051216      * Get record
013600051216      *___________________________________________________________________
013700051216     C     GETREC        BEGSR                                                  GET RECORD
013800051216     C                   CALL      'UPDDDC  '                                   PROCESS REC IO
013900051216     C                   PARM      'GETNL '      WWRQS                          GET RECORD
014000051216     C                   PARM                    WWRTN                          RETURN CODE
014100051216     C                   PARM                    WDDTA                          REC DATA
014200051216     C                   ENDSR                                                  END GETREC
014300051216      *___________________________________________________________________
014400051216      * Receive messages
014500051216      *___________________________________________________________________
014600051216     C     RCVMSG        BEGSR                                                  RECEIVE MSG
014700051216     C                   MOVEA     *IN           WWIN                           INDICATORS
014800051216     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
014900051216     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
015000051216     C                   PARM                    WWIN                           INDICATORS
015100051216     C                   PARM                    WWRTN                          RETURN CODE
015200051216     C                   MOVEA     WWIN          *IN                            INDICATORS RET
015300051216     C                   ENDSR                                                  END RCV MSG
015400051216      *___________________________________________________________________
015500051216      * Display the display panel
015600051216      *___________________________________________________________________
015700051216     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
015800051216      *
015900051216      * Set OVERLAY based on last display file processed
016000051216     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
016100051216 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
016200051216 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
016300051216X001 C                   ELSE                                                   SAME PGM
016400051216 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
016500051216E001 C                   ENDIF                                                  END IF NEW PGM
016600051216      *
016700051216      * Write message subfile
016800051216     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
016900051216     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
017000051216      *
017100051216      * Write display panels
017200051216B001 C                   SELECT
017300051216 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
017400051220     C                   EXSR      $FMTDTA
017500051216 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
017600051216E001 C                   ENDSL                                                  END SELECT
017700051216     C                   ENDSR                                                  END DSP DSP
017800051220     C     $FMTDTA       BEGSR
017900051220     C                   IF        DDOED > 0
018000051220     C     DDOED         MULT      10000.0001    SCOED
018100051220     C                   ENDIF
018200051220     C                   IF        DDMPD > 0
018300051220     C     DDMPD         MULT      10000.0001    SCMPD
018400051220     C                   ENDIF
018500051220     C                   IF        DDMPE > 0
018600051220     C     DDMPE         MULT      10000.0001    SCMPE
018700051220     C                   ENDIF
018800051220     C                   ENDSR
018900051216      *___________________________________________________________________
019000051216      * Build function key information
019100051216      *___________________________________________________________________
019200051216     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
019300051216     C                   MOVEA     *IN           WWIN                           INDICATORS
019400051216     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
019500051216     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
019600051216     C     WWFNC         PARM                    WWRTN                          RETURN CODE
019700051216     C                   PARM                    WAD                            FNC DESC
019800051216     C                   PARM                    WWIN                           *IN
019900051216     C                   PARM                    WAF                            FNC KEY TABLE
020000051216     C                   PARM                    WIFKY                          FNC KYS ALLWD
020100051216      *
020200051216     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
020300051216     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
020400051216     C                   SUB       1             WW                             BUMP IDX
020500051216     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
020600051216     C                   ENDSR                                                  END BLD FKY
020700051216      *___________________________________________________________________
020800051216      * Process function keys
020900051216      *___________________________________________________________________
021000051216     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
021100051216     C                   MOVEA     *IN           WWIN                           INDICATORS
021200051216     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
021300051216     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
021400051216     C     WWFNC         PARM                    WWRTN                          RETURN CODE
021500051216     C                   PARM                    WAD                            FNC DESC
021600051216     C                   PARM                    WWIN                           *IN
021700051216     C                   PARM                    WAF                            FNC KEY TABLE
021800051216     C                   PARM                    WIFKY                          FNC KYS ALLWD
021900051216     C                   ENDSR                                                  END PRCFKY
022000051216      *___________________________________________________________________
022100051216      * Process KEYS function
022200051216      *___________________________________________________________________
022300051216     C     PRCDKY        BEGSR                                                  PROCESS KEYS
022400051216     C                   Z-ADD     1             WW                             KEY DSC IDX
022500051216B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
022600051216 001 C*                                                                         OR KEYS FOUND
022700051216 001  *
022800051216 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
022900051216B002 C                   IF        WWFKS > 3                                    IF OVER 3
023000051216 002 C                   Z-ADD     1             WWFKS                          SET TO 1
023100051216E002 C                   ENDIF                                                  END IF OVER 3
023200051216 001  *
023300051216 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
023400051216 001 C                   SUB       1             WW                             KEY DESCR IDX
023500051216E001 C                   ENDDO                                                  END DO KEYS
023600051216      *
023700051216     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
023800051216     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
023900051216     C                   SUB       1             WW                             BUMP IDX
024000051216     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
024100051216      *
024200051216     C                   ENDSR                                                  END PRCDKY
024300051216      *___________________________________________________________________
024400051216      * Process RETURN function
024500051216      *___________________________________________________________________
024600051216     C     PRCRTN        BEGSR                                                  PROCESS RETURN
024700051216     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
024800051216     C                   MOVE      'END'         WWSTT                          END INVOCATION
024900051216     C                   ENDSR                                                  END RETURN
025000051216      *___________________________________________________________________
025100051216      * Process CANCEL function
025200051216      *___________________________________________________________________
025300051216     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
025400051216     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
025500051216     C                   MOVE      'END'         WWSTT                          END INVOCATION
025600051216     C                   ENDSR                                                  END PRCCNL
025700051216      *___________________________________________________________________
025800051216      * Process ROLLUP function
025900051216      *___________________________________________________________________
026000051216     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
026100051216     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
026200051216B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
026300051216 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
026400051216E001 C                   ENDIF                                                  END IF GT LST PNL
026500051216     C                   ENDSR                                                  END PRCRUP
026600051216      *___________________________________________________________________
026700051216      * Process ROLLDOWN function
026800051216      *___________________________________________________________________
026900051216     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
027000051216     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
027100051216B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
027200051216 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
027300051216E001 C                   ENDIF                                                  END IF LT FST PNL
027400051216     C                   ENDSR                                                  END PRCRDN
027500051216      *___________________________________________________________________
027600051216      * Process ENTER function
027700051216      *___________________________________________________________________
027800051216     C     PRCENT        BEGSR                                                  PROCESS ENTER
027900051216     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
028000051216     C                   MOVE      'END'         WWSTT                          END INVOCATION
028100051216     C                   ENDSR                                                  END PRCENT
028200051216      *___________________________________________________________________
028300051216      * Send message
028400051216      *___________________________________________________________________
028500051216     C     SNDMSG        BEGSR                                                  SEND MESSAGE
028600051216     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
028700051216     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
028800051216     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
028900051216     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
029000051216     C                   PARM                    WWMSG                          ERROR MESSAGE
029100051216     C                   ENDSR                                                  END SND MSG
029200051216      *___________________________________________________________________
029300051216      * Parameter lists
029400051216      *___________________________________________________________________
029500051216     C     PLIST         BEGSR                                                  PARM LISTS
029600051216     C     *ENTRY        PLIST                                                  *ENTRY LIST
029700051216     C     WWTSK         PARM                    WIRQS                          EXT MODE
029800051216     C                   PARM                    WORTN                          INTERNAL MODE
029900051216     C                   PARM                    WUPGM                          LAST PGM NAME
030000051216     C                   PARM                    WDDTA                          RECORD DS
030100051216     C                   PARM                    WIFKY                          FUNCTIONS VALID
030200051216     C                   ENDSR                                                  END PLIST
030300051216      *___________________________________________________________________
030400051216      * Initialize routine
030500051216      *___________________________________________________________________
030600051216     C     *INZSR        BEGSR                                                  INITIALIZE
030700051216     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
030800051216     C                   MOVEL     'DBEDOC'      WWFIL                          FILE NAME-NOTES
030900051216     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
031000051216     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
031100051216     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
031200051216     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
031300051216     C                   MOVE      WWSTT         WWSTT                          STATUS
031400051216     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
031500051216     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
031600051216     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
031700051216     C                   Z-ADD     WW            WW                             WORK INDEX
031800051216     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
031900051216     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
032000051216     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
032100051216     C                   ENDSR                                                  END DEFN
032200051216      *___________________________________________________________________
032300051216      * Program error handler
032400051216      *___________________________________________________________________
032500051216     C     *PSSR         BEGSR                                                  PROGRAM ERROR
032600051216     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
032700051216     C                   PARM                    WQPGMN                         PROGRAM NAME
032800051216     C                   PARM                    WQSTSC                         STATUS CODE
032900051216     C                   PARM                    WQRPGS                         RPG STATEMENT
033000051216     C                   PARM                    WQMSG                          MESSAGE ID
033100051216     C                   ENDSR     '*CANCL'                                     END PGM ERROR
033200051216      *___________________________________________________________________
033300051216**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03340005121603EXIT    F3=Exit
03350005121612CANCEL  F12=Cancel
03360005121625ROLLUP
03370005121626ROLLDOWN
033800051216** WTM
03390005121600PROVIDERS FOR MBR/GRP File record not found.
