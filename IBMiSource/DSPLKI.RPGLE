000100000000      *_________________________________________________________________________
000200000000      *
000300090317      *  Description:  Display LINK ID MAINT
000400000000      *
000500090204      *  (C)COPYRIGHT 2009 BY GROUP BENEFIT SERVICES, INC.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900090317     FDSPLKID   CF   E             WORKSTN INFDS(DSPD)
001000000000      *_________________________________________________________________________
001100000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001300000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001400000000      *_________________________________________________________________________
001500000000      *
001600090318     D #ISO            S               D   DATFMT(*ISO)
001700090318     D @44             S             44A
001800090318      *
001900000000      * Data structure
002000090317     D WDDTA         E DS                  EXTNAME(SPRAGXRF)
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
012500000000      *
012600090318     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
012700090318     C                   IN        @DTA50
012800090318     C                   EVAL      WSNAME = %SUBST(@DTA50:1:40)
012900090318    ***
013000000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
013100000000     C                   EXSR      GETREC                                       GET RECORD
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
014500090317     C                   CALL      'UPDLKI  '                                   PROCESS REC IO
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
018100090318     C                   EXSR      $GETDTA
018200000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
018300000000E001 C                   ENDSL                                                  END SELECT
018400000000     C                   ENDSR                                                  END DSP DSP
018500090318   S***S
018600090318     C     $GETDTA       Begsr
018700090318    ***
018800090318     C                   EVAL      D_AGENCY = *BLANKS
018900090318     C                   EVAL      D_SUPER  = *BLANKS
019000090318    ***
019100090318     C                   IF        SXEFFDTE <> 0
019200090318     C                   MOVE      SXEFFDTE      #ISO
019300090318     C     *USA          MOVE      #ISO          SCEFFDTE
019400090318     C                   ELSE
019500090318     C                   EVAL      SCEFFDTE = 0
019600090318     C                   ENDIF
019700090318    ***
019800090318     C                   IF        SXTRMDTE <> 0
019900090318     C                   MOVE      SXTRMDTE      #ISO
020000090318     C     *USA          MOVE      #ISO          SCTRMDTE
020100090318     C                   ELSE
020200090318     C                   EVAL      SCTRMDTE = 0
020300090318     C                   ENDIF
020400090318    ***
020500090318     C                   IF        SXAGCY <> *BLANKS
020600090318     C                   EVAL      @44 = SXAGCY
020700090318     C                   EVAL      %SUBST(@44:44:1) = 'A'
020800090318     C                   CALL      'RTVSAS'
020900090318     C                   PARM                    @44
021000090318     C                   EVAL      D_AGENCY = %SUBST(@44:4:40)
021100090318     C                   ENDIF
021200090318    ***
021300090318     C                   IF        SXSUPER <> *BLANKS
021400090318     C                   EVAL      @44 = SXSUPER
021500090318     C                   EVAL      %SUBST(@44:44:1) = 'U'
021600090318     C                   CALL      'RTVSAS'
021700090318     C                   PARM                    @44
021800090318     C                   EVAL      D_SUPER  = %SUBST(@44:4:40)
021900090318     C                   ENDIF
022000090318    ***
022100090318     C                   ENDSR
022200090318   S***S
022300000000      *___________________________________________________________________
022400000000      * Build function key information
022500000000      *___________________________________________________________________
022600000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
022700000000     C                   MOVEA     *IN           WWIN                           INDICATORS
022800000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
022900000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
023000000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
023100000000     C                   PARM                    WAD                            FNC DESC
023200000000     C                   PARM                    WWIN                           *IN
023300000000     C                   PARM                    WAF                            FNC KEY TABLE
023400000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
023500000000      *
023600000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
023700000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
023800000000     C                   SUB       1             WW                             BUMP IDX
023900000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
024000000000     C                   ENDSR                                                  END BLD FKY
024100000000      *___________________________________________________________________
024200000000      * Process function keys
024300000000      *___________________________________________________________________
024400000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
024500000000     C                   MOVEA     *IN           WWIN                           INDICATORS
024600000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
024700000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
024800000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
024900000000     C                   PARM                    WAD                            FNC DESC
025000000000     C                   PARM                    WWIN                           *IN
025100000000     C                   PARM                    WAF                            FNC KEY TABLE
025200000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
025300000000     C                   ENDSR                                                  END PRCFKY
025400000000      *___________________________________________________________________
025500000000      * Process KEYS function
025600000000      *___________________________________________________________________
025700000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
025800000000     C                   Z-ADD     1             WW                             KEY DSC IDX
025900000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
026000000000 001 C*                                                                         OR KEYS FOUND
026100000000 001  *
026200000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
026300000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
026400000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
026500000000E002 C                   ENDIF                                                  END IF OVER 3
026600000000 001  *
026700000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
026800000000 001 C                   SUB       1             WW                             KEY DESCR IDX
026900000000E001 C                   ENDDO                                                  END DO KEYS
027000000000      *
027100000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
027200000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
027300000000     C                   SUB       1             WW                             BUMP IDX
027400000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
027500000000      *
027600000000     C                   ENDSR                                                  END PRCDKY
027700000000      *___________________________________________________________________
027800000000      * Process RETURN function
027900000000      *___________________________________________________________________
028000000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
028100000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
028200000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
028300000000     C                   ENDSR                                                  END RETURN
028400000000      *___________________________________________________________________
028500000000      * Process CANCEL function
028600000000      *___________________________________________________________________
028700000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
028800000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
028900000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
029000000000     C                   ENDSR                                                  END PRCCNL
029100000000      *___________________________________________________________________
029200000000      * Process ROLLUP function
029300000000      *___________________________________________________________________
029400000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
029500000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
029600000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
029700000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
029800000000E001 C                   ENDIF                                                  END IF GT LST PNL
029900000000     C                   ENDSR                                                  END PRCRUP
030000000000      *___________________________________________________________________
030100000000      * Process ROLLDOWN function
030200000000      *___________________________________________________________________
030300000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
030400000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
030500000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
030600000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
030700000000E001 C                   ENDIF                                                  END IF LT FST PNL
030800000000     C                   ENDSR                                                  END PRCRDN
030900000000      *___________________________________________________________________
031000000000      * Process ENTER function
031100000000      *___________________________________________________________________
031200000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
031300000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
031400000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
031500000000     C                   ENDSR                                                  END PRCENT
031600000000      *___________________________________________________________________
031700000000      * Send message
031800000000      *___________________________________________________________________
031900000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
032000000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
032100000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
032200000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
032300000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
032400000000     C                   PARM                    WWMSG                          ERROR MESSAGE
032500000000     C                   ENDSR                                                  END SND MSG
032600000000      *___________________________________________________________________
032700000000      * Parameter lists
032800000000      *___________________________________________________________________
032900000000     C     PLIST         BEGSR                                                  PARM LISTS
033000000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
033100000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
033200000000     C                   PARM                    WORTN                          INTERNAL MODE
033300000000     C                   PARM                    WUPGM                          LAST PGM NAME
033400000000     C                   PARM                    WDDTA                          RECORD DS
033500000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
033600000000     C                   ENDSR                                                  END PLIST
033700000000      *___________________________________________________________________
033800000000      * Initialize routine
033900000000      *___________________________________________________________________
034000000000     C     *INZSR        BEGSR                                                  INITIALIZE
034100000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
034200090317     C                   MOVEL     'SPRAGXRF'    WWFIL                          FILE NAME-NOTES
034300000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
034400000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
034500000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
034600000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
034700000000     C                   MOVE      WWSTT         WWSTT                          STATUS
034800000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
034900000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
035000000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
035100000000     C                   Z-ADD     WW            WW                             WORK INDEX
035200000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
035300000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
035400000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
035500000000     C                   ENDSR                                                  END DEFN
035600000000      *___________________________________________________________________
035700000000      * Program error handler
035800000000      *___________________________________________________________________
035900000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
036000000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
036100000000     C                   PARM                    WQPGMN                         PROGRAM NAME
036200000000     C                   PARM                    WQSTSC                         STATUS CODE
036300000000     C                   PARM                    WQRPGS                         RPG STATEMENT
036400000000     C                   PARM                    WQMSG                          MESSAGE ID
036500000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
036600000000      *___________________________________________________________________
036700000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03680000000003EXIT    F3=Exit
03690000000012CANCEL  F12=Cancel
03700000000025ROLLUP
03710000000026ROLLDOWN
037200000000** WTM
03730009031700LINK ID MAINT File record not found.
