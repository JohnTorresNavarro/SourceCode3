000100000000      *_________________________________________________________________________
000200000000      *
000300111212      *  Description:  Display EMPLOYEE AUXILIARY
000400000000      *
000500090204      *  (C)COPYRIGHT 2009 BY GROUP BENEFIT SERVICES, INC.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900111221     FACMUNIQUE IF   E           K DISK
001000111221     FMEMBER    IF   E           K DISK
001100111221     FDEPNDC    IF   E           K DISK
001200111212     FDSPEMPD   CF   E             WORKSTN INFDS(DSPD)
001300000000      *_________________________________________________________________________
001400000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001600000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001700000000      *_________________________________________________________________________
001800000000      *
001900000000      * Data structure
002000111213     D WDDTA         E DS                  EXTNAME(EMPAUX)
002100111222      *
002200111222     D                UDS
002300111222     D  CONAME               201    240
002400000000      *
002500000000      * Program status data structure
002600000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002700000000      *
002800000000      * Display file data structure
002900000000     D DSPD          E DS                  EXTNAME(IODSPD)
003000000000      *
003100021008     D WIFKV           S             60A
003200021008     D WIFKY           S                   LIKE(WIFKV)
003300021008     D WIOPV           S                   LIKE(WIFKV)
003400021008     D WIRQS           S              8A
003500021008     D WORTN           S              8A
003600021008     D WUPGM           S             10A
003700021008     D WWCHG           S              1A
003800021008     D WWDLT           S              1A
003900021008     D WWDTAQ          S             10A
004000021008     D WWENDF          S              3A
004100021008     D WWENDO          S                   LIKE(WWENDF)
004200021008     D WWERR           S              1A
004300021008     D WWFIL           S             10A
004400021008     D WWFKA           S              8A
004500021008     D WWFKV           S                   LIKE(WIFKV)
004600021008     D WWFKY           S                   LIKE(WIFKV)
004700021008     D WWFLK           S            128A
004800021008     D WWFMTN          S              8A
004900021008     D WWFNC           S              8A
005000021008     D WWIJI           S             16A
005100021008     D WWIN            S             99A
005200021008     D WWLIB           S             10A
005300021008     D WWMSG           S             80A
005400021008     D WWMSGC          S              7A
005500021008     D WWOCD           S              8A
005600021008     D WWOPA           S              8A
005700021008     D WWOPN           S              1A
005800021008     D WWOPT           S              8A
005900021008     D WWOPV           S                   LIKE(WIFKV)
006000021008     D WWORQS          S                   LIKE(WIRQS)
006100021008     D WWPSNC          S              1A
006200021008     D WWQJN           S             26A
006300021008     D WWRQS           S                   LIKE(WIRQS)
006400021008     D WWRQSD          S                   LIKE(WIRQS)
006500021008     D WWRTN           S                   LIKE(WORTN)
006600021008     D WWRTND          S                   LIKE(WORTN)
006700021008     D WWRTNH          S                   LIKE(WORTN)
006800021008     D WWSFLE          S              1A
006900021008     D WWSTT           S              3A
007000021008     D WWTSK           S              8A
007100021008     D WWTXT           S             60A
007200021008     D WWUPD           S              1A
007300021008     D WWWRNF          S              1A
007400021008     D WWZERO          S             40A
007500021008     D WFRRN           S              4P 0
007600021008     D WW              S              3P 0
007700021008     D WWFKS           S              1P 0
007800021008     D WWFKSO          S                   LIKE(WWFKS)
007900021008     D WWLMT           S              2P 0
008000021008     D WWLNG           S             15P 5
008100021008     D WWLNGQ          S              5P 0
008200021008     D WWLOWR          S              4P 0
008300021008     D WWLSTS          S              2P 0
008400021008     D WWOPS           S              1P 0
008500021008     D WWOPSO          S                   LIKE(WWOPS)
008600021008     D WWPNL           S              1P 0
008700021008     D WWPNLN          S                   LIKE(WWPNL)
008800021008     D WWPNLO          S                   LIKE(WWPNL)
008900021008     D WWPSNI          S              2P 0
009000021008     D WWPSNN          S              1P 0
009100021008     D WWPSNP          S                   LIKE(WWPSNN)
009200021008     D WWRRN           S              4P 0
009300000000     ****
009400000000      *
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
014400111213     C                   CALL      'UPDEMP  '                                   PROCESS REC IO
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
018000111221     C                   EXSR      $GETDTA
018100000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
018200000000E001 C                   ENDSL                                                  END SELECT
018300000000     C                   ENDSR                                                  END DSP DSP
018400111221   S***S
018500111221     C     $GETDTA       BEGSR
018600111222      *
018700111222     C                   EVAL      WSNAME = CONAME
018800111222      *
018900111222     C                   IF        EASALEFFD > 0
019000111222     C     EASALEFFD     MULT      10000.0001    SCSALEFFD
019100111222     C                   ELSE
019200111222     C                   MOVE      *ZEROS        SCSALEFFD
019300111222     C                   ENDIF
019400111221      *
019500111222     C                   IF        EACOBEDT  > 0
019600111222     C     EACOBEDT      MULT      10000.0001    SCCOBEDT
019700111222     C                   ELSE
019800111222     C                   MOVE      *ZEROS        SCCOBEDT
019900111222     C                   ENDIF
020000111222      *
020100111222     C                   IF        EACOBTDT  > 0
020200111222     C     EACOBTDT      MULT      10000.0001    SCCOBTDT
020300111222     C                   ELSE
020400111222     C                   MOVE      *ZEROS        SCCOBTDT
020500111222     C                   ENDIF
020600111222      *
020700111222     C                   IF        EAFTSEFFD > 0
020800111222     C     EAFTSEFFD     MULT      10000.0001    SCFTSEFFD
020900111222     C                   ELSE
021000111222     C                   MOVE      *ZEROS        SCFTSEFFD
021100111222     C                   ENDIF
021200111222      *
021300111222     C                   IF        EAADDT    > 0
021400111222     C     EAADDT        MULT      10000.0001    SCADDT
021500111222     C                   ELSE
021600111222     C                   MOVE      *ZEROS        SCADDT
021700111222     C                   ENDIF
021800111222      *
021900111221     C                   IF        EASSEQ = 0
022000111221     C     EASSNO        CHAIN     MEMBR
022100111221     C                   IF        %FOUND(MEMBER)
022200111221     C                   MOVEL(P)  MLNAME        @70              70
022300111221     C                   EVAL      @70 = %TRIM(@70) + ', ' + MFNAME
022400111221     C                   ELSE
022500111221     C                   EVAL      @70 = '**UNKNOWN**'
022600111221     C                   ENDIF
022700111221     C                   ELSE
022800111221     C     KL#DEP        CHAIN     DEPENR
022900111221     C                   IF        %FOUND(DEPNDC)
023000111221     C                   MOVEL(P)  DLNAME        @70              70
023100111221     C                   EVAL      @70 = %TRIM(@70) + ', ' + DFNAME
023200111221     C                   ELSE
023300111221     C                   EVAL      @70 = '**UNKNOWN**'
023400111221     C                   ENDIF
023500111221     C                   ENDIF
023600111221     C                   MOVEL(P)  @70           D_MBR
023700111221      *
023800111221     C     KL#DEP        KLIST
023900111221     C                   KFLD                    EASSNO
024000111221     C                   KFLD                    EASSEQ
024100111221     C     KL#ACM        KLIST
024200111221     C                   KFLD                    EATRST
024300111221     C                   KFLD                    EASUB#
024400111221     C                   KFLD                    EAACCT
024500111221     C     KL#ACM        CHAIN     ACCMSR
024600111221     C                   IF        %FOUND(ACMUNIQUE)
024700111221     C                   MOVEL(P)  ACNAM1        D_ACC
024800111221     C                   ELSE
024900111221     C                   EVAL      D_ACC = *BLANKS
025000111221     C                   ENDIF
025100111221      *
025200111221      *
025300111221     C                   ENDSR
025400111221   S***S
025500000000      *___________________________________________________________________
025600000000      * Build function key information
025700000000      *___________________________________________________________________
025800000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
025900000000     C                   MOVEA     *IN           WWIN                           INDICATORS
026000000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
026100000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
026200000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
026300000000     C                   PARM                    WAD                            FNC DESC
026400000000     C                   PARM                    WWIN                           *IN
026500000000     C                   PARM                    WAF                            FNC KEY TABLE
026600000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
026700000000      *
026800000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
026900000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
027000000000     C                   SUB       1             WW                             BUMP IDX
027100000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
027200000000     C                   ENDSR                                                  END BLD FKY
027300000000      *___________________________________________________________________
027400000000      * Process function keys
027500000000      *___________________________________________________________________
027600000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
027700000000     C                   MOVEA     *IN           WWIN                           INDICATORS
027800000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
027900000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
028000000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
028100000000     C                   PARM                    WAD                            FNC DESC
028200000000     C                   PARM                    WWIN                           *IN
028300000000     C                   PARM                    WAF                            FNC KEY TABLE
028400000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
028500000000     C                   ENDSR                                                  END PRCFKY
028600000000      *___________________________________________________________________
028700000000      * Process KEYS function
028800000000      *___________________________________________________________________
028900000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
029000000000     C                   Z-ADD     1             WW                             KEY DSC IDX
029100000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
029200000000 001 C*                                                                         OR KEYS FOUND
029300000000 001  *
029400000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
029500000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
029600000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
029700000000E002 C                   ENDIF                                                  END IF OVER 3
029800000000 001  *
029900000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
030000000000 001 C                   SUB       1             WW                             KEY DESCR IDX
030100000000E001 C                   ENDDO                                                  END DO KEYS
030200000000      *
030300000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
030400000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
030500000000     C                   SUB       1             WW                             BUMP IDX
030600000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
030700000000      *
030800000000     C                   ENDSR                                                  END PRCDKY
030900000000      *___________________________________________________________________
031000000000      * Process RETURN function
031100000000      *___________________________________________________________________
031200000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
031300000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
031400000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
031500000000     C                   ENDSR                                                  END RETURN
031600000000      *___________________________________________________________________
031700000000      * Process CANCEL function
031800000000      *___________________________________________________________________
031900000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
032000000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
032100000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
032200000000     C                   ENDSR                                                  END PRCCNL
032300000000      *___________________________________________________________________
032400000000      * Process ROLLUP function
032500000000      *___________________________________________________________________
032600000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
032700000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
032800000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
032900000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
033000000000E001 C                   ENDIF                                                  END IF GT LST PNL
033100000000     C                   ENDSR                                                  END PRCRUP
033200000000      *___________________________________________________________________
033300000000      * Process ROLLDOWN function
033400000000      *___________________________________________________________________
033500000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
033600000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
033700000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
033800000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
033900000000E001 C                   ENDIF                                                  END IF LT FST PNL
034000000000     C                   ENDSR                                                  END PRCRDN
034100000000      *___________________________________________________________________
034200000000      * Process ENTER function
034300000000      *___________________________________________________________________
034400000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
034500000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
034600000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
034700000000     C                   ENDSR                                                  END PRCENT
034800000000      *___________________________________________________________________
034900000000      * Send message
035000000000      *___________________________________________________________________
035100000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
035200000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
035300000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
035400000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
035500000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
035600000000     C                   PARM                    WWMSG                          ERROR MESSAGE
035700000000     C                   ENDSR                                                  END SND MSG
035800000000      *___________________________________________________________________
035900000000      * Parameter lists
036000000000      *___________________________________________________________________
036100000000     C     PLIST         BEGSR                                                  PARM LISTS
036200000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
036300000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
036400000000     C                   PARM                    WORTN                          INTERNAL MODE
036500000000     C                   PARM                    WUPGM                          LAST PGM NAME
036600000000     C                   PARM                    WDDTA                          RECORD DS
036700000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
036800000000     C                   ENDSR                                                  END PLIST
036900000000      *___________________________________________________________________
037000000000      * Initialize routine
037100000000      *___________________________________________________________________
037200000000     C     *INZSR        BEGSR                                                  INITIALIZE
037300000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
037400111213     C                   MOVEL     'EMPAUX  '    WWFIL                          FILE NAME-NOTES
037500000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
037600000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
037700000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
037800000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
037900000000     C                   MOVE      WWSTT         WWSTT                          STATUS
038000000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
038100000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
038200000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
038300000000     C                   Z-ADD     WW            WW                             WORK INDEX
038400000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
038500000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
038600000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
038700000000     C                   ENDSR                                                  END DEFN
038800000000      *___________________________________________________________________
038900000000      * Program error handler
039000000000      *___________________________________________________________________
039100000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
039200000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
039300000000     C                   PARM                    WQPGMN                         PROGRAM NAME
039400000000     C                   PARM                    WQSTSC                         STATUS CODE
039500000000     C                   PARM                    WQRPGS                         RPG STATEMENT
039600000000     C                   PARM                    WQMSG                          MESSAGE ID
039700000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
039800000000      *___________________________________________________________________
039900000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
04000000000003EXIT    F3=Exit
04010000000012CANCEL  F12=Cancel
04020000000025ROLLUP
04030000000026ROLLDOWN
040400000000** WTM
04050011121300EMPLOYEE AUX File record not found.
