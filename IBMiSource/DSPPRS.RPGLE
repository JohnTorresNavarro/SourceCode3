000100000000      *_________________________________________________________________________
000200000000      *
000300060124      *  Description:  Display PERSISTENCY START COUNTS
000400000000      *
000500060125      *  (C)COPYRIGHT 2006 BY GROUP BENEFIT SERVICES, INC.
000600130823      *
000700130823      * JUST RECOMPILE FOR DISPLAY FILE CHANGES - SK
000800000000      *_________________________________________________________________________
000900000000      *
001000060125     FDSPPRSD   CF   E             WORKSTN INFDS(DSPD)
001100060125     FSUPRAGCY  IF   E           K DISK
001200060125     FAGENCY    IF   E           K DISK
001300060125     FSMAN      IF   E           K DISK
001400140225     FHYPERCARR IF   E           K DISK
001500000000      *_________________________________________________________________________
001600000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001700000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001800000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001900000000      *_________________________________________________________________________
002000000000      *
002100000000      * Data structure
002200061113     D WDDTA         E DS                  EXTNAME(XXEOYCC)
002300130823     D  SCNOTE1              107    156A
002400130823     D  SCNOTE2              157    206A
002500000000      *
002600000000      * Program status data structure
002700000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002800000000      *
002900000000      * Display file data structure
003000000000     D DSPD          E DS                  EXTNAME(IODSPD)
003100000000      *
003200021008     D WIFKV           S             60A
003300021008     D WIFKY           S                   LIKE(WIFKV)
003400021008     D WIOPV           S                   LIKE(WIFKV)
003500021008     D WIRQS           S              8A
003600021008     D WORTN           S              8A
003700021008     D WUPGM           S             10A
003800021008     D WWCHG           S              1A
003900021008     D WWDLT           S              1A
004000021008     D WWDTAQ          S             10A
004100021008     D WWENDF          S              3A
004200021008     D WWENDO          S                   LIKE(WWENDF)
004300021008     D WWERR           S              1A
004400021008     D WWFIL           S             10A
004500021008     D WWFKA           S              8A
004600021008     D WWFKV           S                   LIKE(WIFKV)
004700021008     D WWFKY           S                   LIKE(WIFKV)
004800021008     D WWFLK           S            128A
004900021008     D WWFMTN          S              8A
005000021008     D WWFNC           S              8A
005100021008     D WWIJI           S             16A
005200021008     D WWIN            S             99A
005300021008     D WWLIB           S             10A
005400021008     D WWMSG           S             80A
005500021008     D WWMSGC          S              7A
005600021008     D WWOCD           S              8A
005700021008     D WWOPA           S              8A
005800021008     D WWOPN           S              1A
005900021008     D WWOPT           S              8A
006000021008     D WWOPV           S                   LIKE(WIFKV)
006100021008     D WWORQS          S                   LIKE(WIRQS)
006200021008     D WWPSNC          S              1A
006300021008     D WWQJN           S             26A
006400021008     D WWRQS           S                   LIKE(WIRQS)
006500021008     D WWRQSD          S                   LIKE(WIRQS)
006600021008     D WWRTN           S                   LIKE(WORTN)
006700021008     D WWRTND          S                   LIKE(WORTN)
006800021008     D WWRTNH          S                   LIKE(WORTN)
006900021008     D WWSFLE          S              1A
007000021008     D WWSTT           S              3A
007100021008     D WWTSK           S              8A
007200021008     D WWTXT           S             60A
007300021008     D WWUPD           S              1A
007400021008     D WWWRNF          S              1A
007500021008     D WWZERO          S             40A
007600021008     D WFRRN           S              4P 0
007700021008     D WW              S              3P 0
007800021008     D WWFKS           S              1P 0
007900021008     D WWFKSO          S                   LIKE(WWFKS)
008000021008     D WWLMT           S              2P 0
008100021008     D WWLNG           S             15P 5
008200021008     D WWLNGQ          S              5P 0
008300021008     D WWLOWR          S              4P 0
008400021008     D WWLSTS          S              2P 0
008500021008     D WWOPS           S              1P 0
008600021008     D WWOPSO          S                   LIKE(WWOPS)
008700021008     D WWPNL           S              1P 0
008800021008     D WWPNLN          S                   LIKE(WWPNL)
008900021008     D WWPNLO          S                   LIKE(WWPNL)
009000021008     D WWPSNI          S              2P 0
009100021008     D WWPSNN          S              1P 0
009200021008     D WWPSNP          S                   LIKE(WWPSNN)
009300021008     D WWRRN           S              4P 0
009400081231     D @190            S            238A
009500000000     ****
009600140225     D                UDS
009700140225     D  CARR                   1      2A
009800140225     ****
009900000000      *
010000000000      *
010100000000      *_________________________________________________________________________
010200000000      * Process display panel
010300000000     C                   EXSR      PRPPNL                                       PREPARE PANEL
010400000000      *
010500000000B001 C                   DOW       WWSTT <> 'END'                               DOWHILE NOT END
010600000000 001 C                   EXSR      RCVMSG                                       RECEIVE MSGS
010700000000 001 C                   EXSR      DSPPNL                                       DISPLAY PANEL
010800000000 001 C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
010900000000 001  *
011000000000 001 C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
011100000000 001 C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
011200000000 001 C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
011300000000 001 C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
011400000000 001 C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
011500000000 001 C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
011600000000 001 C                   ENDCS                                                  END CASE
011700000000 001  *
011800000000E001 C                   ENDDO                                                  END DOWHILE
011900060214     C                   EVAL      WDDTA = @190
012000000000     C                   RETURN                                                 RETURN
012100000000      *___________________________________________________________________
012200000000      * Prepare display panel
012300000000      *___________________________________________________________________
012400000000     C     PRPPNL        BEGSR                                                  PREPARE PANEL
012500140225      *
012600140225     C                   EVAL      DPCARR = CARR
012700140225     C     CARR          CHAIN     RHC
012800140225     C                   IF        %FOUND(HYPERCARR)
012900140225     C                   EVAL      DPNAME = %TRIM(HCNAME)
013000140225     C                   ENDIF
013100000000      *
013200060214     C                   EVAL      @190 = WDDTA
013300000000     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
013400000000     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
013500000000     C                   MOVE      *BLANKS       WWSTT                          STATUS
013600000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
013700000000     C                   Z-ADD     1             WWPNL                          CURRENT PNL
013800000000     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
013900000000     C                   Z-ADD     1             WWFKS                          FNC KEY SET
014000000000     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
014100000000      *
014200000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
014300000000     C                   EXSR      GETREC                                       GET RECORD
014400000000B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
014500000000 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
014600000000 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
014700000000 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
014800000000 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
014900000000E001 C                   ENDIF                                                  END IF ERROR
015000000000      *
015100000000      *
015200000000     C                   ENDSR                                                  END PRPPNL
015300000000      *___________________________________________________________________
015400000000      * Get record
015500000000      *___________________________________________________________________
015600000000     C     GETREC        BEGSR                                                  GET RECORD
015700060125     C                   CALL      'UPDPRS  '                                   PROCESS REC IO
015800000000     C                   PARM      'GETNL '      WWRQS                          GET RECORD
015900000000     C                   PARM                    WWRTN                          RETURN CODE
016000000000     C                   PARM                    WDDTA                          REC DATA
016100000000     C                   ENDSR                                                  END GETREC
016200000000      *___________________________________________________________________
016300000000      * Receive messages
016400000000      *___________________________________________________________________
016500000000     C     RCVMSG        BEGSR                                                  RECEIVE MSG
016600000000     C                   MOVEA     *IN           WWIN                           INDICATORS
016700000000     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
016800000000     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
016900000000     C                   PARM                    WWIN                           INDICATORS
017000000000     C                   PARM                    WWRTN                          RETURN CODE
017100000000     C                   MOVEA     WWIN          *IN                            INDICATORS RET
017200000000     C                   ENDSR                                                  END RCV MSG
017300000000      *___________________________________________________________________
017400000000      * Display the display panel
017500000000      *___________________________________________________________________
017600000000     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
017700000000      *
017800000000      * Set OVERLAY based on last display file processed
017900000000     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
018000000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
018100000000 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
018200000000X001 C                   ELSE                                                   SAME PGM
018300000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
018400000000E001 C                   ENDIF                                                  END IF NEW PGM
018500000000      *
018600000000      * Write message subfile
018700000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
018800000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
018900000000      *
019000000000      * Write display panels
019100060125     C                   EXSR      $FMTOUT
019200000000B001 C                   SELECT
019300000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
019400000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
019500000000E001 C                   ENDSL                                                  END SELECT
019600060125     C                   EXSR      $FMTIN
019700000000     C                   ENDSR                                                  END DSP DSP
019800060125   S***S
019900060125     C     $FMTOUT       BEGSR
020000060125     C                   EVAL      D_SA = 'N/A'
020100060125     C                   EVAL      D_AG = 'N/A'
020200060125     C                   EVAL      D_SM = 'N/A'
020300060125     C     CYSA          CHAIN     SAF
020400060125     C                   IF        %FOUND(SUPRAGCY)
020500060125     C                   MOVEL(P)  SANAME1       D_SA
020600060125     C                   ENDIF
020700060125     C     CYAG          CHAIN     AGENR
020800060125     C                   IF        %FOUND(AGENCY)
020900060125     C                   MOVEL(P)  AGNAM1        D_AG
021000060125     C                   ENDIF
021100060125     C     CYSM          CHAIN     SMANR
021200060125     C                   IF        %FOUND(SMAN)
021300060125     C                   EXSR      $GETSNAME
021400060125     C                   MOVEL(P)  A@40          D_SM
021500060125     C                   ENDIF
021600060125     C                   IF        CYEFF <> 0
021700060125     C                   MULT      10000.0001    CYEFF
021800060125     C                   ENDIF
021900060125     C                   Endsr
022000060125   S***S
022100060125     C     $FMTIN        BEGSR
022200060125     C                   IF        CYEFF <> 0
022300060125     C                   MULT      10000.0001    CYEFF
022400060125     C                   ENDIF
022500060125     C                   Endsr
022600060125   S***S
022700060125     C     $GETSNAME     BEGSR
022800060125    ***
022900060125     C                   CLEAR                   A@20             20
023000060125     C                   CLEAR                   A@40             40
023100060125    ***
023200060125     C                   IF        SFNAME <> *BLANKS
023300060125     C                   MOVEL     SFNAME        A@20
023400060125     C                   EXSR      $LDADDR
023500060125     C                   ENDIF
023600060125    ***
023700060125     C                   IF        SMI <> *BLANKS
023800060125     C                   MOVEL     SMI           A@20
023900060125     C                   EXSR      $LDADDR
024000060125     C                   ENDIF
024100060125    ***
024200060125     C                   IF        SLNAME <> *BLANKS
024300060125     C                   MOVEL     SLNAME        A@20
024400060125     C                   EXSR      $LDADDR
024500060125     C                   ENDIF
024600060125    ***
024700060125     C                   ENDSR
024800060125   S***S
024900060125     C     $LDADDR       BEGSR
025000060125    ***
025100060125     C                   EVAL      A@20 = %TRIM(A@20)
025200060125     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
025300060125     C                   CLEAR                   A@20
025400060125    ***
025500060125     C                   ENDSR
025600060125   S***S
025700000000      *___________________________________________________________________
025800000000      * Build function key information
025900000000      *___________________________________________________________________
026000000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
026100000000     C                   MOVEA     *IN           WWIN                           INDICATORS
026200000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
026300000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
026400000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
026500000000     C                   PARM                    WAD                            FNC DESC
026600000000     C                   PARM                    WWIN                           *IN
026700000000     C                   PARM                    WAF                            FNC KEY TABLE
026800000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
026900000000      *
027000000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
027100000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
027200000000     C                   SUB       1             WW                             BUMP IDX
027300000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
027400000000     C                   ENDSR                                                  END BLD FKY
027500000000      *___________________________________________________________________
027600000000      * Process function keys
027700000000      *___________________________________________________________________
027800000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
027900000000     C                   MOVEA     *IN           WWIN                           INDICATORS
028000000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
028100000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
028200000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
028300000000     C                   PARM                    WAD                            FNC DESC
028400000000     C                   PARM                    WWIN                           *IN
028500000000     C                   PARM                    WAF                            FNC KEY TABLE
028600000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
028700000000     C                   ENDSR                                                  END PRCFKY
028800000000      *___________________________________________________________________
028900000000      * Process KEYS function
029000000000      *___________________________________________________________________
029100000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
029200000000     C                   Z-ADD     1             WW                             KEY DSC IDX
029300000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
029400000000 001 C*                                                                         OR KEYS FOUND
029500000000 001  *
029600000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
029700000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
029800000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
029900000000E002 C                   ENDIF                                                  END IF OVER 3
030000000000 001  *
030100000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
030200000000 001 C                   SUB       1             WW                             KEY DESCR IDX
030300000000E001 C                   ENDDO                                                  END DO KEYS
030400000000      *
030500000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
030600000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
030700000000     C                   SUB       1             WW                             BUMP IDX
030800000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
030900000000      *
031000000000     C                   ENDSR                                                  END PRCDKY
031100000000      *___________________________________________________________________
031200000000      * Process RETURN function
031300000000      *___________________________________________________________________
031400000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
031500000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
031600000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
031700000000     C                   ENDSR                                                  END RETURN
031800000000      *___________________________________________________________________
031900000000      * Process CANCEL function
032000000000      *___________________________________________________________________
032100000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
032200000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
032300000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
032400000000     C                   ENDSR                                                  END PRCCNL
032500000000      *___________________________________________________________________
032600000000      * Process ROLLUP function
032700000000      *___________________________________________________________________
032800000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
032900000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
033000000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
033100000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
033200000000E001 C                   ENDIF                                                  END IF GT LST PNL
033300000000     C                   ENDSR                                                  END PRCRUP
033400000000      *___________________________________________________________________
033500000000      * Process ROLLDOWN function
033600000000      *___________________________________________________________________
033700000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
033800000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
033900000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
034000000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
034100000000E001 C                   ENDIF                                                  END IF LT FST PNL
034200000000     C                   ENDSR                                                  END PRCRDN
034300000000      *___________________________________________________________________
034400000000      * Process ENTER function
034500000000      *___________________________________________________________________
034600000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
034700000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
034800000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
034900000000     C                   ENDSR                                                  END PRCENT
035000000000      *___________________________________________________________________
035100000000      * Send message
035200000000      *___________________________________________________________________
035300000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
035400000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
035500000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
035600000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
035700000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
035800000000     C                   PARM                    WWMSG                          ERROR MESSAGE
035900000000     C                   ENDSR                                                  END SND MSG
036000000000      *___________________________________________________________________
036100000000      * Parameter lists
036200000000      *___________________________________________________________________
036300000000     C     PLIST         BEGSR                                                  PARM LISTS
036400000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
036500000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
036600000000     C                   PARM                    WORTN                          INTERNAL MODE
036700000000     C                   PARM                    WUPGM                          LAST PGM NAME
036800000000     C                   PARM                    WDDTA                          RECORD DS
036900000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
037000000000     C                   ENDSR                                                  END PLIST
037100000000      *___________________________________________________________________
037200000000      * Initialize routine
037300000000      *___________________________________________________________________
037400000000     C     *INZSR        BEGSR                                                  INITIALIZE
037500000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
037600061113     C                   MOVEL     'XXEOYCC '    WWFIL                          FILE NAME-NOTES
037700000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
037800000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
037900000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
038000000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
038100000000     C                   MOVE      WWSTT         WWSTT                          STATUS
038200000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
038300000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
038400000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
038500000000     C                   Z-ADD     WW            WW                             WORK INDEX
038600000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
038700000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
038800000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
038900000000     C                   ENDSR                                                  END DEFN
039000000000      *___________________________________________________________________
039100000000      * Program error handler
039200000000      *___________________________________________________________________
039300000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
039400000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
039500000000     C                   PARM                    WQPGMN                         PROGRAM NAME
039600000000     C                   PARM                    WQSTSC                         STATUS CODE
039700000000     C                   PARM                    WQRPGS                         RPG STATEMENT
039800000000     C                   PARM                    WQMSG                          MESSAGE ID
039900000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
040000000000      *___________________________________________________________________
040100000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
04020000000003EXIT    F3=Exit
04030000000012CANCEL  F12=Cancel
04040000000025ROLLUP
04050000000026ROLLDOWN
040600000000** WTM
04070006012500PERSISTENCY START COUTNS File record not found.
