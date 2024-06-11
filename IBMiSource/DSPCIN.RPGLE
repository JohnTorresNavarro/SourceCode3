000100000000      *_________________________________________________________________________
000200000000      *
000300120531      *  Description:  Display COBRA INITIAL LETTER
000400000000      *
000500120531      *  (C)COPYRIGHT 2012 BY GROUP BENEFIT SERVICES, INC.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900120531     FACMUNIQUE IF   E           K DISK
001000120531     FDSPCIND   CF   E             WORKSTN INFDS(DSPD)
001100000000      *_________________________________________________________________________
001200000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001400000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001500000000      *_________________________________________________________________________
001600000000      *
001700000000      * Data structure
001800120531     D WDDTA         E DS                  EXTNAME(COB440W2)
001900000000      *
002000000000      * Program status data structure
002100000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002200000000      *
002300000000      * Display file data structure
002400000000     D DSPD          E DS                  EXTNAME(IODSPD)
002500000000      *
002600021008     D WIFKV           S             60A
002700021008     D WIFKY           S                   LIKE(WIFKV)
002800021008     D WIOPV           S                   LIKE(WIFKV)
002900021008     D WIRQS           S              8A
003000021008     D WORTN           S              8A
003100021008     D WUPGM           S             10A
003200021008     D WWCHG           S              1A
003300021008     D WWDLT           S              1A
003400021008     D WWDTAQ          S             10A
003500021008     D WWENDF          S              3A
003600021008     D WWENDO          S                   LIKE(WWENDF)
003700021008     D WWERR           S              1A
003800021008     D WWFIL           S             10A
003900021008     D WWFKA           S              8A
004000021008     D WWFKV           S                   LIKE(WIFKV)
004100021008     D WWFKY           S                   LIKE(WIFKV)
004200021008     D WWFLK           S            128A
004300021008     D WWFMTN          S              8A
004400021008     D WWFNC           S              8A
004500021008     D WWIJI           S             16A
004600021008     D WWIN            S             99A
004700021008     D WWLIB           S             10A
004800021008     D WWMSG           S             80A
004900021008     D WWMSGC          S              7A
005000021008     D WWOCD           S              8A
005100021008     D WWOPA           S              8A
005200021008     D WWOPN           S              1A
005300021008     D WWOPT           S              8A
005400021008     D WWOPV           S                   LIKE(WIFKV)
005500021008     D WWORQS          S                   LIKE(WIRQS)
005600021008     D WWPSNC          S              1A
005700021008     D WWQJN           S             26A
005800021008     D WWRQS           S                   LIKE(WIRQS)
005900021008     D WWRQSD          S                   LIKE(WIRQS)
006000021008     D WWRTN           S                   LIKE(WORTN)
006100021008     D WWRTND          S                   LIKE(WORTN)
006200021008     D WWRTNH          S                   LIKE(WORTN)
006300021008     D WWSFLE          S              1A
006400021008     D WWSTT           S              3A
006500021008     D WWTSK           S              8A
006600021008     D WWTXT           S             60A
006700021008     D WWUPD           S              1A
006800021008     D WWWRNF          S              1A
006900021008     D WWZERO          S             40A
007000021008     D WFRRN           S              4P 0
007100021008     D WW              S              3P 0
007200021008     D WWFKS           S              1P 0
007300021008     D WWFKSO          S                   LIKE(WWFKS)
007400021008     D WWLMT           S              2P 0
007500021008     D WWLNG           S             15P 5
007600021008     D WWLNGQ          S              5P 0
007700021008     D WWLOWR          S              4P 0
007800021008     D WWLSTS          S              2P 0
007900021008     D WWOPS           S              1P 0
008000021008     D WWOPSO          S                   LIKE(WWOPS)
008100021008     D WWPNL           S              1P 0
008200021008     D WWPNLN          S                   LIKE(WWPNL)
008300021008     D WWPNLO          S                   LIKE(WWPNL)
008400021008     D WWPSNI          S              2P 0
008500021008     D WWPSNN          S              1P 0
008600021008     D WWPSNP          S                   LIKE(WWPSNN)
008700021008     D WWRRN           S              4P 0
008800000000     ****
008900120531     D CMPNY           DS
009000120531     D  BLAH                   1    240a
009100120531     D  CONAME               200    240a
009200120531      *
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
011800120531      *
011900120531     C     *DTAARA       DEFINE    *LDA          CMPNY
012000120531     C                   IN        CMPNY
012100120531     C                   EVAL      WSNAME = CONAME
012200000000      *
012300000000     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
012400000000     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
012500000000     C                   MOVE      *BLANKS       WWSTT                          STATUS
012600000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
012700000000     C                   Z-ADD     1             WWPNL                          CURRENT PNL
012800000000     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
012900000000     C                   Z-ADD     1             WWFKS                          FNC KEY SET
013000000000     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
013100000000      *
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
014700120531     C                   CALL      'UPDCIN  '                                   PROCESS REC IO
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
018300120531     C                   EXSR      $GETDTA
018400000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
018500000000E001 C                   ENDSL                                                  END SELECT
018600000000     C                   ENDSR                                                  END DSP DSP
018700120531   S***S
018800120531     C     $GETDTA       BEGSR
018900120531      *
019000120531     C                   EVAL      D_ACCT = *BLANKS
019100120531     C     KL#TSA        KLIST
019200120531     C                   KFLD                    C2TRST
019300120531     C                   KFLD                    C2SUB#
019400120531     C                   KFLD                    C2ACCT
019500120531      *
019600120531     C     KL#TSA        CHAIN     ACCMSR
019700120531     C                   IF        NOT %FOUND(ACMUNIQUE)
019800120531     C                   EVAL      D_ACCT = %TRIM(ACNAM1)
019900120531     C                   ENDIF
020000120531      *
020100120531     C                   IF        C2START > 0
020200120531     C     C2START       MULT      10000.0001    SCSTART
020300120531     C                   ELSE
020400120531     C                   EVAL      SCSTART = 0
020500120531     C                   ENDIF
020600120531      *
020700120531     C                   IF        C2ENDDT > 0
020800120531     C     C2ENDDT       MULT      10000.0001    SCENDDT
020900120531     C                   ELSE
021000120531     C                   EVAL      SCENDDT = 0
021100120531     C                   ENDIF
021200120531      *
021300120531     C                   IF        C2EDATE > 0
021400120531     C     C2EDATE       MULT      10000.0001    SCEDATE
021500120531     C                   ELSE
021600120531     C                   EVAL      SCEDATE = 0
021700120531     C                   ENDIF
021800120531      *
021900120531     C                   IF        C2CDATE > 0
022000120531     C     C2CDATE       MULT      10000.0001    SCCDATE
022100120531     C                   ELSE
022200120531     C                   EVAL      SCCDATE = 0
022300120531     C                   ENDIF
022400120531      *
022500120531     C                   ENDSR
022600120531   S***S
022700000000      *___________________________________________________________________
022800000000      * Build function key information
022900000000      *___________________________________________________________________
023000000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
023100000000     C                   MOVEA     *IN           WWIN                           INDICATORS
023200000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
023300000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
023400000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
023500000000     C                   PARM                    WAD                            FNC DESC
023600000000     C                   PARM                    WWIN                           *IN
023700000000     C                   PARM                    WAF                            FNC KEY TABLE
023800000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
023900000000      *
024000000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
024100000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
024200000000     C                   SUB       1             WW                             BUMP IDX
024300000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
024400000000     C                   ENDSR                                                  END BLD FKY
024500000000      *___________________________________________________________________
024600000000      * Process function keys
024700000000      *___________________________________________________________________
024800000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
024900000000     C                   MOVEA     *IN           WWIN                           INDICATORS
025000000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
025100000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
025200000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
025300000000     C                   PARM                    WAD                            FNC DESC
025400000000     C                   PARM                    WWIN                           *IN
025500000000     C                   PARM                    WAF                            FNC KEY TABLE
025600000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
025700000000     C                   ENDSR                                                  END PRCFKY
025800000000      *___________________________________________________________________
025900000000      * Process KEYS function
026000000000      *___________________________________________________________________
026100000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
026200000000     C                   Z-ADD     1             WW                             KEY DSC IDX
026300000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
026400000000 001 C*                                                                         OR KEYS FOUND
026500000000 001  *
026600000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
026700000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
026800000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
026900000000E002 C                   ENDIF                                                  END IF OVER 3
027000000000 001  *
027100000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
027200000000 001 C                   SUB       1             WW                             KEY DESCR IDX
027300000000E001 C                   ENDDO                                                  END DO KEYS
027400000000      *
027500000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
027600000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
027700000000     C                   SUB       1             WW                             BUMP IDX
027800000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
027900000000      *
028000000000     C                   ENDSR                                                  END PRCDKY
028100000000      *___________________________________________________________________
028200000000      * Process RETURN function
028300000000      *___________________________________________________________________
028400000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
028500000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
028600000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
028700000000     C                   ENDSR                                                  END RETURN
028800000000      *___________________________________________________________________
028900000000      * Process CANCEL function
029000000000      *___________________________________________________________________
029100000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
029200000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
029300000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
029400000000     C                   ENDSR                                                  END PRCCNL
029500000000      *___________________________________________________________________
029600000000      * Process ROLLUP function
029700000000      *___________________________________________________________________
029800000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
029900000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
030000000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
030100000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
030200000000E001 C                   ENDIF                                                  END IF GT LST PNL
030300000000     C                   ENDSR                                                  END PRCRUP
030400000000      *___________________________________________________________________
030500000000      * Process ROLLDOWN function
030600000000      *___________________________________________________________________
030700000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
030800000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
030900000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
031000000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
031100000000E001 C                   ENDIF                                                  END IF LT FST PNL
031200000000     C                   ENDSR                                                  END PRCRDN
031300000000      *___________________________________________________________________
031400000000      * Process ENTER function
031500000000      *___________________________________________________________________
031600000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
031700000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
031800000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
031900000000     C                   ENDSR                                                  END PRCENT
032000000000      *___________________________________________________________________
032100000000      * Send message
032200000000      *___________________________________________________________________
032300000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
032400000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
032500000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
032600000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
032700000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
032800000000     C                   PARM                    WWMSG                          ERROR MESSAGE
032900000000     C                   ENDSR                                                  END SND MSG
033000000000      *___________________________________________________________________
033100000000      * Parameter lists
033200000000      *___________________________________________________________________
033300000000     C     PLIST         BEGSR                                                  PARM LISTS
033400000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
033500000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
033600000000     C                   PARM                    WORTN                          INTERNAL MODE
033700000000     C                   PARM                    WUPGM                          LAST PGM NAME
033800000000     C                   PARM                    WDDTA                          RECORD DS
033900000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
034000000000     C                   ENDSR                                                  END PLIST
034100000000      *___________________________________________________________________
034200000000      * Initialize routine
034300000000      *___________________________________________________________________
034400000000     C     *INZSR        BEGSR                                                  INITIALIZE
034500000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
034600120531     C                   MOVEL     'COB440W2'    WWFIL                          FILE NAME-NOTES
034700000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
034800000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
034900000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
035000000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
035100000000     C                   MOVE      WWSTT         WWSTT                          STATUS
035200000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
035300000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
035400000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
035500000000     C                   Z-ADD     WW            WW                             WORK INDEX
035600000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
035700000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
035800000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
035900000000     C                   ENDSR                                                  END DEFN
036000000000      *___________________________________________________________________
036100000000      * Program error handler
036200000000      *___________________________________________________________________
036300000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
036400000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
036500000000     C                   PARM                    WQPGMN                         PROGRAM NAME
036600000000     C                   PARM                    WQSTSC                         STATUS CODE
036700000000     C                   PARM                    WQRPGS                         RPG STATEMENT
036800000000     C                   PARM                    WQMSG                          MESSAGE ID
036900000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
037000000000      *___________________________________________________________________
037100000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03720000000003EXIT    F3=Exit
03730000000012CANCEL  F12=Cancel
03740000000025ROLLUP
03750000000026ROLLDOWN
037600000000** WTM
03770012053100COBRA INITIAL LETTER record not found.
