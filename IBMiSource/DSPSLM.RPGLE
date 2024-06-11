000100000000      *_________________________________________________________________________
000200000000      *
000300030507      *  Description:  Display Salesman Master Inquiry
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900030529     FDSPSLMD   CF   E             WORKSTN INFDS(DSPD)
001000030529     FSMAN      IF   E           K DISK
001100030507     FCODES     IF   E           K DISK
001200000000      *_________________________________________________________________________
001300000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001500000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001600000000      *_________________________________________________________________________
001700000000      *
001800000000      * Data structure
001900030507     D WDDTA         E DS                  EXTNAME(SMAN)
002000030529     D WUDTA         E DS                  EXTNAME(SLMUNION)
002100000000      *
002200000000      * Program status data structure
002300000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002400000000      *
002500000000      * Display file data structure
002600000000     D DSPD          E DS                  EXTNAME(IODSPD)
002700000000      *
002800021008     D WIFKV           S             60A
002900021008     D WIFKY           S                   LIKE(WIFKV)
003000030507     D WILEN           S              3P 0
003100021008     D WIOPV           S                   LIKE(WIFKV)
003200021008     D WIRQS           S              8A
003300030507     D WISTR           S            256A
003400021008     D WORTN           S              8A
003500021008     D WUPGM           S             10A
003600021008     D WWCHG           S              1A
003700021008     D WWDLT           S              1A
003800021008     D WWDTAQ          S             10A
003900021008     D WWENDF          S              3A
004000021008     D WWENDO          S                   LIKE(WWENDF)
004100021008     D WWERR           S              1A
004200021008     D WWFIL           S             10A
004300021008     D WWFKA           S              8A
004400021008     D WWFKV           S                   LIKE(WIFKV)
004500021008     D WWFKY           S                   LIKE(WIFKV)
004600021008     D WWFLK           S            128A
004700021008     D WWFMTN          S              8A
004800021008     D WWFNC           S              8A
004900021008     D WWIJI           S             16A
005000021008     D WWIN            S             99A
005100021008     D WWLIB           S             10A
005200021008     D WWMSG           S             80A
005300021008     D WWMSGC          S              7A
005400021008     D WWOCD           S              8A
005500021008     D WWOPA           S              8A
005600021008     D WWOPN           S              1A
005700021008     D WWOPT           S              8A
005800021008     D WWOPV           S                   LIKE(WIFKV)
005900021008     D WWORQS          S                   LIKE(WIRQS)
006000021008     D WWPSNC          S              1A
006100021008     D WWQJN           S             26A
006200021008     D WWRQS           S                   LIKE(WIRQS)
006300021008     D WWRQSD          S                   LIKE(WIRQS)
006400021008     D WWRTN           S                   LIKE(WORTN)
006500021008     D WWRTND          S                   LIKE(WORTN)
006600021008     D WWRTNH          S                   LIKE(WORTN)
006700021008     D WWSFLE          S              1A
006800021008     D WWSTT           S              3A
006900021008     D WWTSK           S              8A
007000021008     D WWTXT           S             60A
007100021008     D WWUPD           S              1A
007200021008     D WWWRNF          S              1A
007300021008     D WWZERO          S             40A
007400021008     D WFRRN           S              4P 0
007500021008     D WW              S              3P 0
007600021008     D WWFKS           S              1P 0
007700021008     D WWFKSO          S                   LIKE(WWFKS)
007800021008     D WWLMT           S              2P 0
007900021008     D WWLNG           S             15P 5
008000021008     D WWLNGQ          S              5P 0
008100021008     D WWLOWR          S              4P 0
008200021008     D WWLSTS          S              2P 0
008300021008     D WWOPS           S              1P 0
008400021008     D WWOPSO          S                   LIKE(WWOPS)
008500021008     D WWPNL           S              1P 0
008600021008     D WWPNLN          S                   LIKE(WWPNL)
008700021008     D WWPNLO          S                   LIKE(WWPNL)
008800021008     D WWPSNI          S              2P 0
008900021008     D WWPSNN          S              1P 0
009000021008     D WWPSNP          S                   LIKE(WWPSNN)
009100021008     D WWRRN           S              4P 0
009200000000     ****
009300030507     D KEY@TYPE        S                   LIKE(TYPE)
009400030507     D KEY@CODE        S                   LIKE(CODE)
009500000000      *
009600000000      *
009700000000      *_________________________________________________________________________
009800000000      * Process display panel
009900000000     C                   EXSR      PRPPNL                                       PREPARE PANEL
010000000000      *
010100000000B001 C                   DOW       WWSTT <> 'END'                               DOWHILE NOT END
010200000000 001 C                   EXSR      RCVMSG                                       RECEIVE MSGS
010300000000 001 C                   EXSR      DSPPNL                                       DISPLAY PANEL
010400000000 001 C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
010500000000 001  *
010600000000 001 C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
010700000000 001 C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
010800000000 001 C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
010900000000 001 C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
011000000000 001 C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
011100000000 001 C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
011200000000 001 C                   ENDCS                                                  END CASE
011300000000 001  *
011400000000E001 C                   ENDDO                                                  END DOWHILE
011500000000     C                   RETURN                                                 RETURN
011600000000      *___________________________________________________________________
011700000000      * Prepare display panel
011800000000      *___________________________________________________________________
011900000000     C     PRPPNL        BEGSR                                                  PREPARE PANEL
012000030507      *
012100030529     C                   MOVEL     WUDTA         SMANCD
012200030529     C     SMANCD        CHAIN     SMANR
012300030529      *
012400000000     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
012500000000     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
012600000000     C                   MOVE      *BLANKS       WWSTT                          STATUS
012700000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
012800000000     C                   Z-ADD     1             WWPNL                          CURRENT PNL
012900000000     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
013000000000     C                   Z-ADD     1             WWFKS                          FNC KEY SET
013100000000     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
013200000000      *
013300000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
013400000000     C                   EXSR      GETREC                                       GET RECORD
013500000000B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
013600000000 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
013700000000 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
013800000000 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
013900000000 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
014000000000E001 C                   ENDIF                                                  END IF ERROR
014100000000      *
014200000000      *
014300000000     C                   ENDSR                                                  END PRPPNL
014400000000      *___________________________________________________________________
014500000000      * Get record
014600000000      *___________________________________________________________________
014700000000     C     GETREC        BEGSR                                                  GET RECORD
014800030529     C                   CALL      'UPDSLM  '                                   PROCESS REC IO
014900000000     C                   PARM      'GETNL '      WWRQS                          GET RECORD
015000000000     C                   PARM                    WWRTN                          RETURN CODE
015100000000     C                   PARM                    WDDTA                          REC DATA
015200000000     C                   ENDSR                                                  END GETREC
015300000000      *___________________________________________________________________
015400000000      * Receive messages
015500000000      *___________________________________________________________________
015600000000     C     RCVMSG        BEGSR                                                  RECEIVE MSG
015700000000     C                   MOVEA     *IN           WWIN                           INDICATORS
015800000000     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
015900000000     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
016000000000     C                   PARM                    WWIN                           INDICATORS
016100000000     C                   PARM                    WWRTN                          RETURN CODE
016200000000     C                   MOVEA     WWIN          *IN                            INDICATORS RET
016300000000     C                   ENDSR                                                  END RCV MSG
016400000000      *___________________________________________________________________
016500000000      * Display the display panel
016600000000      *___________________________________________________________________
016700000000     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
016800000000      *
016900000000      * Set OVERLAY based on last display file processed
017000000000     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
017100000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
017200000000 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
017300000000X001 C                   ELSE                                                   SAME PGM
017400000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
017500000000E001 C                   ENDIF                                                  END IF NEW PGM
017600000000      *
017700000000      * Write message subfile
017800000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
017900000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
018000030507      *
018100030507      * Prepare display panel specifics
018200030507     C                   MOVEl     stype         KEY@TYPE
018300030507     C                   MOVE      stype         KEY@CODE
018400030507     C     KEY@CODES     CHAIN(N)  CODESR
018500030507    1C                   IF        NOT %FOUND(CODES)
018600030529     C                   EVAL      d_OTYP = *BLANKS
018700030507    1C                   ELSE
018800030529     C                   MOVEL(P)  LDESCR        D_OTYP
018900030507    1C                   ENDIF
019000030529     C                   MOVE      STYPE         O_OTYP
019100030530     c     *usa          test(de)                sbegdt
019200030530     c                   if        %error
019300030529     C     SBEGDT        MULT      10000.0001    SBEGDT
019400030530     c                   endif
019500030529    1C                   IF        SENDDT > 0
019600030530     c     *usa          test(de)                senddt
019700030530     c                   if        %error
019800030529     C     SENDDT        MULT      10000.0001    SENDDT
019900030529    1C                   ENDIF
020000030530     c                   endif
020100000000      *
020200000000      * Write display panels
020300000000B001 C                   SELECT
020400000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
020500000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
020600000000E001 C                   ENDSL                                                  END SELECT
020700000000     C                   ENDSR                                                  END DSP DSP
020800000000      *___________________________________________________________________
020900000000      * Build function key information
021000000000      *___________________________________________________________________
021100000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
021200000000     C                   MOVEA     *IN           WWIN                           INDICATORS
021300000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
021400000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
021500000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
021600000000     C                   PARM                    WAD                            FNC DESC
021700000000     C                   PARM                    WWIN                           *IN
021800000000     C                   PARM                    WAF                            FNC KEY TABLE
021900000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
022000000000      *
022100000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
022200000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
022300000000     C                   SUB       1             WW                             BUMP IDX
022400000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
022500000000     C                   ENDSR                                                  END BLD FKY
022600000000      *___________________________________________________________________
022700000000      * Process function keys
022800000000      *___________________________________________________________________
022900000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
023000000000     C                   MOVEA     *IN           WWIN                           INDICATORS
023100000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
023200000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
023300000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
023400000000     C                   PARM                    WAD                            FNC DESC
023500000000     C                   PARM                    WWIN                           *IN
023600000000     C                   PARM                    WAF                            FNC KEY TABLE
023700000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
023800000000     C                   ENDSR                                                  END PRCFKY
023900000000      *___________________________________________________________________
024000000000      * Process KEYS function
024100000000      *___________________________________________________________________
024200000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
024300000000     C                   Z-ADD     1             WW                             KEY DSC IDX
024400000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
024500000000 001 C*                                                                         OR KEYS FOUND
024600000000 001  *
024700000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
024800000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
024900000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
025000000000E002 C                   ENDIF                                                  END IF OVER 3
025100000000 001  *
025200000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
025300000000 001 C                   SUB       1             WW                             KEY DESCR IDX
025400000000E001 C                   ENDDO                                                  END DO KEYS
025500000000      *
025600000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
025700000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
025800000000     C                   SUB       1             WW                             BUMP IDX
025900000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
026000000000      *
026100000000     C                   ENDSR                                                  END PRCDKY
026200000000      *___________________________________________________________________
026300000000      * Process RETURN function
026400000000      *___________________________________________________________________
026500000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
026600000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
026700000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
026800000000     C                   ENDSR                                                  END RETURN
026900000000      *___________________________________________________________________
027000000000      * Process CANCEL function
027100000000      *___________________________________________________________________
027200000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
027300000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
027400000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
027500000000     C                   ENDSR                                                  END PRCCNL
027600000000      *___________________________________________________________________
027700000000      * Process ROLLUP function
027800000000      *___________________________________________________________________
027900000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
028000000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
028100000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
028200000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
028300000000E001 C                   ENDIF                                                  END IF GT LST PNL
028400000000     C                   ENDSR                                                  END PRCRUP
028500000000      *___________________________________________________________________
028600000000      * Process ROLLDOWN function
028700000000      *___________________________________________________________________
028800000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
028900000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
029000000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
029100000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
029200000000E001 C                   ENDIF                                                  END IF LT FST PNL
029300000000     C                   ENDSR                                                  END PRCRDN
029400000000      *___________________________________________________________________
029500000000      * Process ENTER function
029600000000      *___________________________________________________________________
029700000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
029800000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
029900000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
030000000000     C                   ENDSR                                                  END PRCENT
030100000000      *___________________________________________________________________
030200000000      * Send message
030300000000      *___________________________________________________________________
030400000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
030500000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
030600000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
030700000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
030800000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
030900000000     C                   PARM                    WWMSG                          ERROR MESSAGE
031000000000     C                   ENDSR                                                  END SND MSG
031100000000      *___________________________________________________________________
031200000000      * Parameter lists
031300000000      *___________________________________________________________________
031400000000     C     PLIST         BEGSR                                                  PARM LISTS
031500000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
031600000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
031700000000     C                   PARM                    WORTN                          INTERNAL MODE
031800000000     C                   PARM                    WUPGM                          LAST PGM NAME
031900030529     C                   PARM                    WUDTA                          RECORD DS
032000000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
032100000000     C                   ENDSR                                                  END PLIST
032200000000      *___________________________________________________________________
032300000000      * Initialize routine
032400000000      *___________________________________________________________________
032500000000     C     *INZSR        BEGSR                                                  INITIALIZE
032600030507    ***
032700030507     C     KEY@CODES     KLIST
032800030507     C                   KFLD                    KEY@TYPE
032900030507     C                   KFLD                    KEY@CODE
033000030507    ***
033100000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
033200030507     C                   MOVEL     'SMAN    '    WWFIL                          FILE NAME-NOTES
033300000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
033400000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
033500000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
033600000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
033700000000     C                   MOVE      WWSTT         WWSTT                          STATUS
033800000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
033900000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
034000000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
034100000000     C                   Z-ADD     WW            WW                             WORK INDEX
034200000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
034300000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
034400000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
034500030507    ***
034600030507     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
034700030507     C                   IN        @DTA50
034800030507    ***
034900030507     C                   EVAL      wistr = %SUBST(@DTA50:1:40)
035000030507     C                   Z-ADD     50            WILEN
035100030507     C                   CALL      'UTLCENSTR'
035200030507     C                   PARM                    WISTR
035300030507     C                   PARM                    WILEN
035400030507     C                   MOVEL     WISTR         WSNAME
035500030507    ***
035600000000     C                   ENDSR                                                  END DEFN
035700000000      *___________________________________________________________________
035800000000      * Program error handler
035900000000      *___________________________________________________________________
036000000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
036100000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
036200000000     C                   PARM                    WQPGMN                         PROGRAM NAME
036300000000     C                   PARM                    WQSTSC                         STATUS CODE
036400000000     C                   PARM                    WQRPGS                         RPG STATEMENT
036500000000     C                   PARM                    WQMSG                          MESSAGE ID
036600000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
036700000000      *___________________________________________________________________
036800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03690000000003EXIT    F3=Exit
03700000000012CANCEL  F12=Cancel
03710000000025ROLLUP
03720000000026ROLLDOWN
037300000000** WTM
03740003050700Salesman Master record not found.
