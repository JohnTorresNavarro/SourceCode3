000100000000      *_________________________________________________________________________
000200000000      *
000300030520      *  Description:  Display Agency Master Inquiry
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900030520     FDSPAGCD   CF   E             WORKSTN INFDS(DSPD)
001000030523     fagency    if   e           k disk
001100000000      *_________________________________________________________________________
001200000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001400000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001500000000      *_________________________________________________________________________
001600000000      *
001700000000      * Data structure
001800030520     D WDDTA         E DS                  EXTNAME(agency)
001900030523     D WUDTA         E DS                  EXTNAME(agcunion)
002000000000      *
002100000000      * Program status data structure
002200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000      *
002400000000      * Display file data structure
002500000000     D DSPD          E DS                  EXTNAME(IODSPD)
002600000000      *
002700021008     D WIFKV           S             60A
002800021008     D WIFKY           S                   LIKE(WIFKV)
002900030523     D WILEN           S              3P 0
003000021008     D WIOPV           S                   LIKE(WIFKV)
003100021008     D WIRQS           S              8A
003200030523     D WISTR           S            256A
003300021008     D WORTN           S              8A
003400021008     D WUPGM           S             10A
003500021008     D WWCHG           S              1A
003600021008     D WWDLT           S              1A
003700021008     D WWDTAQ          S             10A
003800021008     D WWENDF          S              3A
003900021008     D WWENDO          S                   LIKE(WWENDF)
004000021008     D WWERR           S              1A
004100021008     D WWFIL           S             10A
004200021008     D WWFKA           S              8A
004300021008     D WWFKV           S                   LIKE(WIFKV)
004400021008     D WWFKY           S                   LIKE(WIFKV)
004500021008     D WWFLK           S            128A
004600021008     D WWFMTN          S              8A
004700021008     D WWFNC           S              8A
004800021008     D WWIJI           S             16A
004900021008     D WWIN            S             99A
005000021008     D WWLIB           S             10A
005100021008     D WWMSG           S             80A
005200021008     D WWMSGC          S              7A
005300021008     D WWOCD           S              8A
005400021008     D WWOPA           S              8A
005500021008     D WWOPN           S              1A
005600021008     D WWOPT           S              8A
005700021008     D WWOPV           S                   LIKE(WIFKV)
005800021008     D WWORQS          S                   LIKE(WIRQS)
005900021008     D WWPSNC          S              1A
006000021008     D WWQJN           S             26A
006100021008     D WWRQS           S                   LIKE(WIRQS)
006200021008     D WWRQSD          S                   LIKE(WIRQS)
006300021008     D WWRTN           S                   LIKE(WORTN)
006400021008     D WWRTND          S                   LIKE(WORTN)
006500021008     D WWRTNH          S                   LIKE(WORTN)
006600021008     D WWSFLE          S              1A
006700021008     D WWSTT           S              3A
006800021008     D WWTSK           S              8A
006900021008     D WWTXT           S             60A
007000021008     D WWUPD           S              1A
007100021008     D WWWRNF          S              1A
007200021008     D WWZERO          S             40A
007300021008     D WFRRN           S              4P 0
007400021008     D WW              S              3P 0
007500021008     D WWFKS           S              1P 0
007600021008     D WWFKSO          S                   LIKE(WWFKS)
007700021008     D WWLMT           S              2P 0
007800021008     D WWLNG           S             15P 5
007900021008     D WWLNGQ          S              5P 0
008000021008     D WWLOWR          S              4P 0
008100021008     D WWLSTS          S              2P 0
008200021008     D WWOPS           S              1P 0
008300021008     D WWOPSO          S                   LIKE(WWOPS)
008400021008     D WWPNL           S              1P 0
008500021008     D WWPNLN          S                   LIKE(WWPNL)
008600021008     D WWPNLO          S                   LIKE(WWPNL)
008700021008     D WWPSNI          S              2P 0
008800021008     D WWPSNN          S              1P 0
008900021008     D WWPSNP          S                   LIKE(WWPSNN)
009000021008     D WWRRN           S              4P 0
009100000000     ****
009200030530     d #xsx            s              8s 0
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
011800000000      *
011900000000     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
012000000000     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
012100000000     C                   MOVE      *BLANKS       WWSTT                          STATUS
012200000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
012300000000     C                   Z-ADD     1             WWPNL                          CURRENT PNL
012400000000     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
012500000000     C                   Z-ADD     1             WWFKS                          FNC KEY SET
012600000000     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
012700030529    * *
012800030529     c                   move      *blanks       @3                3
012900030529     c                   eval      @3 = %subst(wudta:4:3)
013000030529     c     @3            chain     agenr
013100030529     c                   if        not %found(agency)
013200030529     c                   clear                   wddta
013300030529     c                   endif
013400000000      *
013500000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
013600000000     C                   EXSR      GETREC                                       GET RECORD
013700000000B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
013800000000 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
013900000000 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
014000000000 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
014100000000 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
014200000000E001 C                   ENDIF                                                  END IF ERROR
014300000000      *
014400000000      *
014500000000     C                   ENDSR                                                  END PRPPNL
014600000000      *___________________________________________________________________
014700000000      * Get record
014800000000      *___________________________________________________________________
014900000000     C     GETREC        BEGSR                                                  GET RECORD
015000030520     C                   CALL      'UPDAGC  '                                   PROCESS REC IO
015100000000     C                   PARM      'GETNL '      WWRQS                          GET RECORD
015200000000     C                   PARM                    WWRTN                          RETURN CODE
015300000000     C                   PARM                    WDDTA                          REC DATA
015400000000     C                   ENDSR                                                  END GETREC
015500000000      *___________________________________________________________________
015600000000      * Receive messages
015700000000      *___________________________________________________________________
015800000000     C     RCVMSG        BEGSR                                                  RECEIVE MSG
015900000000     C                   MOVEA     *IN           WWIN                           INDICATORS
016000000000     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
016100000000     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
016200000000     C                   PARM                    WWIN                           INDICATORS
016300000000     C                   PARM                    WWRTN                          RETURN CODE
016400000000     C                   MOVEA     WWIN          *IN                            INDICATORS RET
016500000000     C                   ENDSR                                                  END RCV MSG
016600000000      *___________________________________________________________________
016700000000      * Display the display panel
016800000000      *___________________________________________________________________
016900000000     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
017000000000      *
017100000000      * Set OVERLAY based on last display file processed
017200000000     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
017300000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
017400000000 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
017500000000X001 C                   ELSE                                                   SAME PGM
017600000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
017700000000E001 C                   ENDIF                                                  END IF NEW PGM
017800000000      *
017900000000      * Write message subfile
018000000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
018100000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
018200030520      *
018300030530     c                   z-add     agefdt        #xsx
018400030530     c     *usa          test(de)                #xsx
018500030530     c                   if        %error
018600030520     c                   if        agefdt > 0
018700030520     c     agefdt        mult      10000.0001    agefdt
018800030530     c                   endif
018900030520     c                   endif
019000030520      *
019100030520     c                   if        agtmdt > 0
019200030530     c                   z-add     agtmdt        #xsx
019300030530     c     *usa          test(de)                #xsx
019400030530     c                   if        %error
019500030520     c     agtmdt        mult      10000.0001    agtmdt
019600030530     c                   endif
019700030520     c                   endif
019800000000      *
019900000000      * Write display panels
020000000000B001 C                   SELECT
020100000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
020200000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
020300000000E001 C                   ENDSL                                                  END SELECT
020400000000     C                   ENDSR                                                  END DSP DSP
020500000000      *___________________________________________________________________
020600000000      * Build function key information
020700000000      *___________________________________________________________________
020800000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
020900000000     C                   MOVEA     *IN           WWIN                           INDICATORS
021000000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
021100000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
021200000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
021300000000     C                   PARM                    WAD                            FNC DESC
021400000000     C                   PARM                    WWIN                           *IN
021500000000     C                   PARM                    WAF                            FNC KEY TABLE
021600000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
021700000000      *
021800000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
021900000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
022000000000     C                   SUB       1             WW                             BUMP IDX
022100000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
022200000000     C                   ENDSR                                                  END BLD FKY
022300000000      *___________________________________________________________________
022400000000      * Process function keys
022500000000      *___________________________________________________________________
022600000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
022700000000     C                   MOVEA     *IN           WWIN                           INDICATORS
022800000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
022900000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
023000000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
023100000000     C                   PARM                    WAD                            FNC DESC
023200000000     C                   PARM                    WWIN                           *IN
023300000000     C                   PARM                    WAF                            FNC KEY TABLE
023400000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
023500000000     C                   ENDSR                                                  END PRCFKY
023600000000      *___________________________________________________________________
023700000000      * Process KEYS function
023800000000      *___________________________________________________________________
023900000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
024000000000     C                   Z-ADD     1             WW                             KEY DSC IDX
024100000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
024200000000 001 C*                                                                         OR KEYS FOUND
024300000000 001  *
024400000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
024500000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
024600000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
024700000000E002 C                   ENDIF                                                  END IF OVER 3
024800000000 001  *
024900000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
025000000000 001 C                   SUB       1             WW                             KEY DESCR IDX
025100000000E001 C                   ENDDO                                                  END DO KEYS
025200000000      *
025300000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
025400000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
025500000000     C                   SUB       1             WW                             BUMP IDX
025600000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
025700000000      *
025800000000     C                   ENDSR                                                  END PRCDKY
025900000000      *___________________________________________________________________
026000000000      * Process RETURN function
026100000000      *___________________________________________________________________
026200000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
026300000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
026400000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
026500000000     C                   ENDSR                                                  END RETURN
026600000000      *___________________________________________________________________
026700000000      * Process CANCEL function
026800000000      *___________________________________________________________________
026900000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
027000000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
027100000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
027200000000     C                   ENDSR                                                  END PRCCNL
027300000000      *___________________________________________________________________
027400000000      * Process ROLLUP function
027500000000      *___________________________________________________________________
027600000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
027700000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
027800000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
027900000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
028000000000E001 C                   ENDIF                                                  END IF GT LST PNL
028100000000     C                   ENDSR                                                  END PRCRUP
028200000000      *___________________________________________________________________
028300000000      * Process ROLLDOWN function
028400000000      *___________________________________________________________________
028500000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
028600000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
028700000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
028800000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
028900000000E001 C                   ENDIF                                                  END IF LT FST PNL
029000000000     C                   ENDSR                                                  END PRCRDN
029100000000      *___________________________________________________________________
029200000000      * Process ENTER function
029300000000      *___________________________________________________________________
029400000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
029500000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
029600000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
029700000000     C                   ENDSR                                                  END PRCENT
029800000000      *___________________________________________________________________
029900000000      * Send message
030000000000      *___________________________________________________________________
030100000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
030200000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
030300000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
030400000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
030500000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
030600000000     C                   PARM                    WWMSG                          ERROR MESSAGE
030700000000     C                   ENDSR                                                  END SND MSG
030800000000      *___________________________________________________________________
030900000000      * Parameter lists
031000000000      *___________________________________________________________________
031100000000     C     PLIST         BEGSR                                                  PARM LISTS
031200000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
031300000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
031400000000     C                   PARM                    WORTN                          INTERNAL MODE
031500000000     C                   PARM                    WUPGM                          LAST PGM NAME
031600030523     C                   PARM                    WUDTA                          RECORD DS
031700000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
031800000000     C                   ENDSR                                                  END PLIST
031900000000      *___________________________________________________________________
032000000000      * Initialize routine
032100000000      *___________________________________________________________________
032200000000     C     *INZSR        BEGSR                                                  INITIALIZE
032300000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
032400030523     C                   MOVEL     'AGENCY  '    WWFIL                          FILE NAME-NOTES
032500000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
032600000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
032700000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
032800000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
032900000000     C                   MOVE      WWSTT         WWSTT                          STATUS
033000000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
033100000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
033200000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
033300000000     C                   Z-ADD     WW            WW                             WORK INDEX
033400000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
033500000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
033600000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
033700030523    * *
033800030523     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
033900030523     C                   IN        @DTA50
034000030523    * *
034100030523     C                   EVAL      wistr = %SUBST(@DTA50:1:40)
034200030523     C                   Z-ADD     50            WILEN
034300030523     C                   CALL      'UTLCENSTR'
034400030523     C                   PARM                    WISTR
034500030523     C                   PARM                    WILEN
034600030523     C                   MOVEL     WISTR         WSNAME
034700030523    * *
034800000000     C                   ENDSR                                                  END DEFN
034900000000      *___________________________________________________________________
035000000000      * Program error handler
035100000000      *___________________________________________________________________
035200000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
035300000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
035400000000     C                   PARM                    WQPGMN                         PROGRAM NAME
035500000000     C                   PARM                    WQSTSC                         STATUS CODE
035600000000     C                   PARM                    WQRPGS                         RPG STATEMENT
035700000000     C                   PARM                    WQMSG                          MESSAGE ID
035800000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
035900000000      *___________________________________________________________________
036000000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03610000000003EXIT    F3=Exit
03620000000012CANCEL  F12=Cancel
03630000000025ROLLUP
03640000000026ROLLDOWN
036500000000** WTM
03660003052000Agency File record not found.
