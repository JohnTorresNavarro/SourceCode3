000100000000      *_________________________________________________________________________
000200000000      *
000300060315      *  Description:  Display AGENCY RELATIONSHIP MANAGERS
000400000000      *
000500060310      *  (C)COPYRIGHT 2006 BY GROUP BENEFIT SERVICES, INC.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900060315     FDSPARMD   CF   E             WORKSTN INFDS(DSPD)
001000060315     FAGENCY    IF   E           K DISK
001100060315     FRMGRMST0  IF   E           K DISK
001200000000      *_________________________________________________________________________
001300000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001500000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001600000000      *_________________________________________________________________________
001700000000      *
001800000000      * Data structure
001900060315     D WDDTA         E DS                  EXTNAME(AGCYRMG0)
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
014000060315     C                   CALL      'UPDARM  '                                   PROCESS REC IO
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
016900060315     C                   EXSR      $GETDESC
017000060315      *
017100000000      * Write message subfile
017200000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
017300000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
017400000000      *
017500000000      * Write display panels
017600000000B001 C                   SELECT
017700000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
017800000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
017900000000E001 C                   ENDSL                                                  END SELECT
018000000000     C                   ENDSR                                                  END DSP DSP
018100060315   S***S
018200060315     C     $GETDESC      BEGSR
018300060315      *
018400060315     C                   IF        ARAGCY = *BLANKS
018500060315     C                   EVAL      D_AGCY = '*ERROR'
018600060315     C                   ELSE
018700060315     C     ARAGCY        CHAIN     AGENR
018800060315     C                   IF        %FOUND(AGENCY)
018900060315     C                   EVAL      D_AGCY  = AGNAM1
019000060315     C                   ELSE
019100060315     C                   EVAL      D_AGCY  = '*ERROR'
019200060315     C                   ENDIF
019300060315     C                   ENDIF
019400060315      *
019500060315     C                   IF        ARSGR = *BLANKS
019600060315     C                   EVAL      D_SGR  = '*ERROR'
019700060315     C                   ELSE
019800060315     C     ARSGR         CHAIN     RMGRMSTR
019900060315     C                   IF        %FOUND(RMGRMST0)
020000060315     C                   EVAL      D_SGR   = RMNAME
020100060315     C                   ELSE
020200060315     C                   EVAL      D_SGR   = '*ERROR'
020300060315     C                   ENDIF
020400060315     C                   ENDIF
020500060315      *
020600060315     C                   IF        ARLGR = *BLANKS
020700060315     C                   EVAL      D_LGR  = '*ERROR'
020800060315     C                   ELSE
020900060315     C     ARLGR         CHAIN     RMGRMSTR
021000060315     C                   IF        %FOUND(RMGRMST0)
021100060315     C                   EVAL      D_LGR   = RMNAME
021200060315     C                   ELSE
021300060315     C                   EVAL      D_LGR   = '*ERROR'
021400060315     C                   ENDIF
021500060315     C                   ENDIF
021600060315      *
021700060315     C                   IF        ARRMGR = *BLANKS
021800060315     C                   EVAL      D_RMGR  = '*ERROR'
021900060315     C                   ELSE
022000060315     C     ARRMGR        CHAIN     RMGRMSTR
022100060315     C                   IF        %FOUND(RMGRMST0)
022200060315     C                   EVAL      D_RMGR  = RMNAME
022300060315     C                   ELSE
022400060315     C                   EVAL      D_RMGR  = '*ERROR'
022500060315     C                   ENDIF
022600060315     C                   ENDIF
022700060315      *
022800060315     C                   ENDSR
022900060315   S***S
023000000000      *___________________________________________________________________
023100000000      * Build function key information
023200000000      *___________________________________________________________________
023300000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
023400000000     C                   MOVEA     *IN           WWIN                           INDICATORS
023500000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
023600000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
023700000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
023800000000     C                   PARM                    WAD                            FNC DESC
023900000000     C                   PARM                    WWIN                           *IN
024000000000     C                   PARM                    WAF                            FNC KEY TABLE
024100000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
024200000000      *
024300000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
024400000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
024500000000     C                   SUB       1             WW                             BUMP IDX
024600000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
024700000000     C                   ENDSR                                                  END BLD FKY
024800000000      *___________________________________________________________________
024900000000      * Process function keys
025000000000      *___________________________________________________________________
025100000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
025200000000     C                   MOVEA     *IN           WWIN                           INDICATORS
025300000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
025400000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
025500000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
025600000000     C                   PARM                    WAD                            FNC DESC
025700000000     C                   PARM                    WWIN                           *IN
025800000000     C                   PARM                    WAF                            FNC KEY TABLE
025900000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
026000000000     C                   ENDSR                                                  END PRCFKY
026100000000      *___________________________________________________________________
026200000000      * Process KEYS function
026300000000      *___________________________________________________________________
026400000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
026500000000     C                   Z-ADD     1             WW                             KEY DSC IDX
026600000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
026700000000 001 C*                                                                         OR KEYS FOUND
026800000000 001  *
026900000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
027000000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
027100000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
027200000000E002 C                   ENDIF                                                  END IF OVER 3
027300000000 001  *
027400000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
027500000000 001 C                   SUB       1             WW                             KEY DESCR IDX
027600000000E001 C                   ENDDO                                                  END DO KEYS
027700000000      *
027800000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
027900000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
028000000000     C                   SUB       1             WW                             BUMP IDX
028100000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
028200000000      *
028300000000     C                   ENDSR                                                  END PRCDKY
028400000000      *___________________________________________________________________
028500000000      * Process RETURN function
028600000000      *___________________________________________________________________
028700000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
028800000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
028900000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
029000000000     C                   ENDSR                                                  END RETURN
029100000000      *___________________________________________________________________
029200000000      * Process CANCEL function
029300000000      *___________________________________________________________________
029400000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
029500000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
029600000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
029700000000     C                   ENDSR                                                  END PRCCNL
029800000000      *___________________________________________________________________
029900000000      * Process ROLLUP function
030000000000      *___________________________________________________________________
030100000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
030200000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
030300000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
030400000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
030500000000E001 C                   ENDIF                                                  END IF GT LST PNL
030600000000     C                   ENDSR                                                  END PRCRUP
030700000000      *___________________________________________________________________
030800000000      * Process ROLLDOWN function
030900000000      *___________________________________________________________________
031000000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
031100000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
031200000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
031300000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
031400000000E001 C                   ENDIF                                                  END IF LT FST PNL
031500000000     C                   ENDSR                                                  END PRCRDN
031600000000      *___________________________________________________________________
031700000000      * Process ENTER function
031800000000      *___________________________________________________________________
031900000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
032000000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
032100000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
032200000000     C                   ENDSR                                                  END PRCENT
032300000000      *___________________________________________________________________
032400000000      * Send message
032500000000      *___________________________________________________________________
032600000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
032700000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
032800000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
032900000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
033000000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
033100000000     C                   PARM                    WWMSG                          ERROR MESSAGE
033200000000     C                   ENDSR                                                  END SND MSG
033300000000      *___________________________________________________________________
033400000000      * Parameter lists
033500000000      *___________________________________________________________________
033600000000     C     PLIST         BEGSR                                                  PARM LISTS
033700000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
033800000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
033900000000     C                   PARM                    WORTN                          INTERNAL MODE
034000000000     C                   PARM                    WUPGM                          LAST PGM NAME
034100000000     C                   PARM                    WDDTA                          RECORD DS
034200000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
034300000000     C                   ENDSR                                                  END PLIST
034400000000      *___________________________________________________________________
034500000000      * Initialize routine
034600000000      *___________________________________________________________________
034700000000     C     *INZSR        BEGSR                                                  INITIALIZE
034800000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
034900060315     C                   MOVEL     'AGCYMGR0'    WWFIL                          FILE NAME-NOTES
035000000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
035100000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
035200000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
035300000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
035400000000     C                   MOVE      WWSTT         WWSTT                          STATUS
035500000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
035600000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
035700000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
035800000000     C                   Z-ADD     WW            WW                             WORK INDEX
035900000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
036000000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
036100000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
036200000000     C                   ENDSR                                                  END DEFN
036300000000      *___________________________________________________________________
036400000000      * Program error handler
036500000000      *___________________________________________________________________
036600000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
036700000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
036800000000     C                   PARM                    WQPGMN                         PROGRAM NAME
036900000000     C                   PARM                    WQSTSC                         STATUS CODE
037000000000     C                   PARM                    WQRPGS                         RPG STATEMENT
037100000000     C                   PARM                    WQMSG                          MESSAGE ID
037200000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
037300000000      *___________________________________________________________________
037400000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03750000000003EXIT    F3=Exit
03760000000012CANCEL  F12=Cancel
03770000000025ROLLUP
03780000000026ROLLDOWN
037900000000** WTM
03800006031500AGENCY RELATIONSHIP MANAGERS File record not found.
