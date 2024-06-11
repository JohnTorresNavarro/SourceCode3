000100000000      *_________________________________________________________________________
000200000000      *
000300090316      *  Description:  Display RELATIONSHIP ID MAINT
000400000000      *
000500090204      *  (C)COPYRIGHT 2009 BY GROUP BENEFIT SERVICES, INC.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900090316     FDSPSRED   CF   E             WORKSTN INFDS(DSPD)
001000090316     FSPRAGXR2  IF   E           K DISK
001100000000      *_________________________________________________________________________
001200000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001400000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001500090316     D #ISO            S               D   DATFMT(*ISO)
001600000000      *_________________________________________________________________________
001700000000      *
001800000000      * Data structure
001900090316     D WDDTA         E DS                  EXTNAME(SMANRLT)
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
012400090317      *
012500090317     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
012600090317     C                   IN        @DTA50
012700090317     C                   EVAL      WSNAME = %SUBST(@DTA50:1:40)
012800000000      *
012900000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
013000000000     C                   EXSR      GETREC                                       GET RECORD
013100000000B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
013200000000 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
013300000000 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
013400000000 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
013500000000 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
013600000000E001 C                   ENDIF                                                  END IF ERROR
013700000000      *
013800000000      *
013900000000     C                   ENDSR                                                  END PRPPNL
014000000000      *___________________________________________________________________
014100000000      * Get record
014200000000      *___________________________________________________________________
014300000000     C     GETREC        BEGSR                                                  GET RECORD
014400090316     C                   CALL      'UPDSRE  '                                   PROCESS REC IO
014500000000     C                   PARM      'GETNL '      WWRQS                          GET RECORD
014600000000     C                   PARM                    WWRTN                          RETURN CODE
014700000000     C                   PARM                    WDDTA                          REC DATA
014800000000     C                   ENDSR                                                  END GETREC
014900000000      *___________________________________________________________________
015000000000      * Receive messages
015100000000      *___________________________________________________________________
015200000000     C     RCVMSG        BEGSR                                                  RECEIVE MSG
015300000000     C                   MOVEA     *IN           WWIN                           INDICATORS
015400000000     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
015500000000     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
015600000000     C                   PARM                    WWIN                           INDICATORS
015700000000     C                   PARM                    WWRTN                          RETURN CODE
015800000000     C                   MOVEA     WWIN          *IN                            INDICATORS RET
015900000000     C                   ENDSR                                                  END RCV MSG
016000000000      *___________________________________________________________________
016100000000      * Display the display panel
016200000000      *___________________________________________________________________
016300000000     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
016400000000      *
016500000000      * Set OVERLAY based on last display file processed
016600000000     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
016700000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
016800000000 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
016900000000X001 C                   ELSE                                                   SAME PGM
017000000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
017100000000E001 C                   ENDIF                                                  END IF NEW PGM
017200000000      *
017300000000      * Write message subfile
017400000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
017500000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
017600000000      *
017700000000      * Write display panels
017800000000B001 C                   SELECT
017900000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
018000090316     C                   EXSR      $GETDTA
018100000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
018200000000E001 C                   ENDSL                                                  END SELECT
018300000000     C                   ENDSR                                                  END DSP DSP
018400090316   S***S
018500090316     C     $GETDTA       BEGSR
018600090316    ***
018700090316     C                   EVAL      D_SMAN   = *BLANKS
018800090316     C                   EVAL      D_AGENCY = *BLANKS
018900090316     C                   EVAL      D_ANAME  = *BLANKS
019000090316     C                   EVAL      D_SUPER  = *BLANKS
019100090316     C                   EVAL      D_SNAME  = *BLANKS
019200090316    ***
019300090316     C                   IF        SRSMAN <> *BLANKS
019400090316     C                   EVAL      @44 = SRSMAN
019500090316     C                   EVAL      %SUBST(@44:44:1) = 'S'
019600090316     C                   CALL      'RTVSAS'
019700090316     C                   PARM                    @44              44
019800090316     C                   EVAL      D_SMAN = %SUBST(@44:4:40)
019900090316     C                   ENDIF
020000090316    ***
020100090316     C                   IF        SREFFDTE <> 0
020200090316     C                   MOVE      SREFFDTE      #ISO
020300090316     C     *USA          MOVE      #ISO          SCEFFDTE
020400090316     C                   ELSE
020500090316     C                   EVAL      SCEFFDTE = 0
020600090316     C                   ENDIF
020700090316    ***
020800090316     C                   IF        SRTRMDTE <> 0
020900090316     C                   MOVE      SRTRMDTE      #ISO
021000090316     C     *USA          MOVE      #ISO          SCTRMDTE
021100090316     C                   ELSE
021200090316     C                   EVAL      SCTRMDTE = 0
021300090316     C                   ENDIF
021400090316    ***
021500090316     C                   IF        SRASID <> *BLANKS AND
021600090316     C                             SRASID <> '00000000'
021700090316     C     SRASID        CHAIN     SXF
021800090316     C                   IF        NOT %FOUND(SPRAGXR2)
021900090316     C                   LEAVESR
022000090316     C                   ENDIF
022100090316     C                   ENDIF
022200090316    ***
022300090316     C                   EVAL      @44 = SXAGCY
022400090316     C                   EVAL      %SUBST(@44:44:1) = 'A'
022500090316     C                   CALL      'RTVSAS'
022600090316     C                   PARM                    @44
022700090316     C                   EVAL      D_ANAME = %SUBST(@44:4:40)
022800090316     C                   EVAL      D_AGENCY = SXAGCY
022900090316    ***
023000090316     C                   EVAL      @44 = SXSUPER
023100090316     C                   EVAL      %SUBST(@44:44:1) = 'U'
023200090316     C                   CALL      'RTVSAS'
023300090316     C                   PARM                    @44
023400090316     C                   EVAL      D_SUPER  = SXSUPER
023500090316     C                   EVAL      D_SNAME  = %SUBST(@44:4:40)
023600090316    ***
023700090316     C                   ENDSR
023800090316   S***S
023900000000      *___________________________________________________________________
024000000000      * Build function key information
024100000000      *___________________________________________________________________
024200000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
024300000000     C                   MOVEA     *IN           WWIN                           INDICATORS
024400000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
024500000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
024600000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
024700000000     C                   PARM                    WAD                            FNC DESC
024800000000     C                   PARM                    WWIN                           *IN
024900000000     C                   PARM                    WAF                            FNC KEY TABLE
025000000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
025100000000      *
025200000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
025300000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
025400000000     C                   SUB       1             WW                             BUMP IDX
025500000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
025600000000     C                   ENDSR                                                  END BLD FKY
025700000000      *___________________________________________________________________
025800000000      * Process function keys
025900000000      *___________________________________________________________________
026000000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
026100000000     C                   MOVEA     *IN           WWIN                           INDICATORS
026200000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
026300000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
026400000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
026500000000     C                   PARM                    WAD                            FNC DESC
026600000000     C                   PARM                    WWIN                           *IN
026700000000     C                   PARM                    WAF                            FNC KEY TABLE
026800000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
026900000000     C                   ENDSR                                                  END PRCFKY
027000000000      *___________________________________________________________________
027100000000      * Process KEYS function
027200000000      *___________________________________________________________________
027300000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
027400000000     C                   Z-ADD     1             WW                             KEY DSC IDX
027500000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
027600000000 001 C*                                                                         OR KEYS FOUND
027700000000 001  *
027800000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
027900000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
028000000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
028100000000E002 C                   ENDIF                                                  END IF OVER 3
028200000000 001  *
028300000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
028400000000 001 C                   SUB       1             WW                             KEY DESCR IDX
028500000000E001 C                   ENDDO                                                  END DO KEYS
028600000000      *
028700000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
028800000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
028900000000     C                   SUB       1             WW                             BUMP IDX
029000000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
029100000000      *
029200000000     C                   ENDSR                                                  END PRCDKY
029300000000      *___________________________________________________________________
029400000000      * Process RETURN function
029500000000      *___________________________________________________________________
029600000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
029700000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
029800000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
029900000000     C                   ENDSR                                                  END RETURN
030000000000      *___________________________________________________________________
030100000000      * Process CANCEL function
030200000000      *___________________________________________________________________
030300000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
030400000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
030500000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
030600000000     C                   ENDSR                                                  END PRCCNL
030700000000      *___________________________________________________________________
030800000000      * Process ROLLUP function
030900000000      *___________________________________________________________________
031000000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
031100000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
031200000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
031300000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
031400000000E001 C                   ENDIF                                                  END IF GT LST PNL
031500000000     C                   ENDSR                                                  END PRCRUP
031600000000      *___________________________________________________________________
031700000000      * Process ROLLDOWN function
031800000000      *___________________________________________________________________
031900000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
032000000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
032100000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
032200000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
032300000000E001 C                   ENDIF                                                  END IF LT FST PNL
032400000000     C                   ENDSR                                                  END PRCRDN
032500000000      *___________________________________________________________________
032600000000      * Process ENTER function
032700000000      *___________________________________________________________________
032800000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
032900000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
033000000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
033100000000     C                   ENDSR                                                  END PRCENT
033200000000      *___________________________________________________________________
033300000000      * Send message
033400000000      *___________________________________________________________________
033500000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
033600000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
033700000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
033800000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
033900000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
034000000000     C                   PARM                    WWMSG                          ERROR MESSAGE
034100000000     C                   ENDSR                                                  END SND MSG
034200000000      *___________________________________________________________________
034300000000      * Parameter lists
034400000000      *___________________________________________________________________
034500000000     C     PLIST         BEGSR                                                  PARM LISTS
034600000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
034700000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
034800000000     C                   PARM                    WORTN                          INTERNAL MODE
034900000000     C                   PARM                    WUPGM                          LAST PGM NAME
035000000000     C                   PARM                    WDDTA                          RECORD DS
035100000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
035200000000     C                   ENDSR                                                  END PLIST
035300000000      *___________________________________________________________________
035400000000      * Initialize routine
035500000000      *___________________________________________________________________
035600000000     C     *INZSR        BEGSR                                                  INITIALIZE
035700000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
035800090316     C                   MOVEL     'SMANRLT '    WWFIL                          FILE NAME-NOTES
035900000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
036000000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
036100000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
036200000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
036300000000     C                   MOVE      WWSTT         WWSTT                          STATUS
036400000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
036500000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
036600000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
036700000000     C                   Z-ADD     WW            WW                             WORK INDEX
036800000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
036900000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
037000000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
037100000000     C                   ENDSR                                                  END DEFN
037200000000      *___________________________________________________________________
037300000000      * Program error handler
037400000000      *___________________________________________________________________
037500000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
037600000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
037700000000     C                   PARM                    WQPGMN                         PROGRAM NAME
037800000000     C                   PARM                    WQSTSC                         STATUS CODE
037900000000     C                   PARM                    WQRPGS                         RPG STATEMENT
038000000000     C                   PARM                    WQMSG                          MESSAGE ID
038100000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
038200000000      *___________________________________________________________________
038300000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03840000000003EXIT    F3=Exit
03850000000012CANCEL  F12=Cancel
03860000000025ROLLUP
03870000000026ROLLDOWN
038800000000** WTM
03890009031600RELATIONSHIP ID File record not found.
