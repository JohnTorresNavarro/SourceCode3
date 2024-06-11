000100000000      *_________________________________________________________________________
000200000000      *
000300020927      *  Description:  Display Zip Code Cross Reference
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *_________________________________________________________________________
000800000000      *
000900021003     FDSPZIPD   CF   E             WORKSTN INFDS(DSPD)
001000020927     FNYSUASM0  IF   E           K DISK
001100000000      *_________________________________________________________________________
001200000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001400000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
001500000000      *_________________________________________________________________________
001600000000      *
001700000000      * Data structure
001800020927     D WDDTA         E DS                  EXTNAME(NYZIPXF0)
001900000000      *
002000000000      * Program status data structure
002100000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002200000000      *
002300000000      * Display file data structure
002400000000     D DSPD          E DS                  EXTNAME(IODSPD)
002500000000      *
002600000000     D WIFKY           S             60A
002700000000     D WIRQS           S              8A
002800000000     D WORTN           S              8A
002900000000     D WUPGM           S             10A
003000000000     D WW              S              3P 0
003100000000     D WWDTAQ          S             10A
003200000000     D WWFIL           S             10A
003300000000     D WWFKV           S                   LIKE(WIFKY)                          FUNCTION KEY VALID
003400000000     D WWFKS           S              1P 0
003500000000     D WWFKY           S                   LIKE(WIFKY)                          FUNCTIONS VALID
003600000000     D WWFLK           S            128A
003700000000     D WWFNC           S                   LIKE(WORTN)                          FUNCTION CODE
003800000000     D WWIN            S             99A
003900000000     D WWLIB           S             10A
004000000000     D WWLNGQ          S              5P 0
004100000000     D WWMSG           S             80A
004200000000     D WWOCD           S              8A
004300000000     D WWOPV           S                   LIKE(WIFKY)                          OPTIONS VALID
004400000000     D WWPNL           S              1P 0
004500000000     D WWPNLN          S              1P 0
004600000000     D WWRQS           S              8A
004700000000     D WWRTN           S              8A
004800000000     D WWSTT           S              3A
004900000000     D WWTSK           S                   LIKE(WIRQS)                          TASK REQUESTED
005000000000     D WWTXT           S             60A
005100000000     ****
005200000000      *
005300000000      *
005400000000      *_________________________________________________________________________
005500000000      * Process display panel
005600000000     C                   EXSR      PRPPNL                                       PREPARE PANEL
005700000000      *
005800000000B001 C                   DOW       WWSTT <> 'END'                               DOWHILE NOT END
005900000000 001 C                   EXSR      RCVMSG                                       RECEIVE MSGS
006000000000 001 C                   EXSR      DSPPNL                                       DISPLAY PANEL
006100000000 001 C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
006200000000 001  *
006300000000 001 C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
006400000000 001 C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
006500000000 001 C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
006600000000 001 C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
006700000000 001 C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
006800000000 001 C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
006900000000 001 C                   ENDCS                                                  END CASE
007000000000 001  *
007100000000E001 C                   ENDDO                                                  END DOWHILE
007200000000     C                   RETURN                                                 RETURN
007300000000      *___________________________________________________________________
007400000000      * Prepare display panel
007500000000      *___________________________________________________________________
007600000000     C     PRPPNL        BEGSR                                                  PREPARE PANEL
007700000000      *
007800000000     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
007900000000     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
008000000000     C                   MOVE      *BLANKS       WWSTT                          STATUS
008100000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
008200000000     C                   Z-ADD     1             WWPNL                          CURRENT PNL
008300000000     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
008400000000     C                   Z-ADD     1             WWFKS                          FNC KEY SET
008500000000     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
008600000000      *
008700000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
008800000000     C                   EXSR      GETREC                                       GET RECORD
008900000000B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
009000000000 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
009100000000 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
009200000000 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
009300000000 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
009400000000E001 C                   ENDIF                                                  END IF ERROR
009500000000      *
009600000000      *
009700000000     C                   ENDSR                                                  END PRPPNL
009800000000      *___________________________________________________________________
009900000000      * Get record
010000000000      *___________________________________________________________________
010100000000     C     GETREC        BEGSR                                                  GET RECORD
010200021003     C                   CALL      'UPDZIP  '                                   PROCESS REC IO
010300000000     C                   PARM      'GETNL '      WWRQS                          GET RECORD
010400000000     C                   PARM                    WWRTN                          RETURN CODE
010500000000     C                   PARM                    WDDTA                          REC DATA
010600000000     C                   ENDSR                                                  END GETREC
010700000000      *___________________________________________________________________
010800000000      * Receive messages
010900000000      *___________________________________________________________________
011000000000     C     RCVMSG        BEGSR                                                  RECEIVE MSG
011100000000     C                   MOVEA     *IN           WWIN                           INDICATORS
011200000000     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
011300000000     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
011400000000     C                   PARM                    WWIN                           INDICATORS
011500000000     C                   PARM                    WWRTN                          RETURN CODE
011600000000     C                   MOVEA     WWIN          *IN                            INDICATORS RET
011700000000     C                   ENDSR                                                  END RCV MSG
011800000000      *___________________________________________________________________
011900000000      * Display the display panel
012000000000      *___________________________________________________________________
012100000000     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
012200000000      *
012300000000      * Set OVERLAY based on last display file processed
012400000000     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
012500000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
012600000000 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
012700000000X001 C                   ELSE                                                   SAME PGM
012800000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
012900000000E001 C                   ENDIF                                                  END IF NEW PGM
013000000000      *
013100000000      * Write message subfile
013200000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
013300000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
013400000000      *
013500000000      * Write display panels
013600020927     C     ZXREGION      CHAIN     RNYSUASM
013700020927     C                   IF        %FOUND(NYSUASM0)
013800020927     C                   EVAL      WWDESC = SURGDESC
013900020927     C                   ELSE
014000020927     C                   EVAL      WWDESC = *BLANKS
014100020927     C                   ENDIF
014200000000B001 C                   SELECT
014300000000 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
014400000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
014500000000E001 C                   ENDSL                                                  END SELECT
014600000000     C                   ENDSR                                                  END DSP DSP
014700000000      *___________________________________________________________________
014800000000      * Build function key information
014900000000      *___________________________________________________________________
015000000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
015100000000     C                   MOVEA     *IN           WWIN                           INDICATORS
015200000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
015300000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
015400000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
015500000000     C                   PARM                    WAD                            FNC DESC
015600000000     C                   PARM                    WWIN                           *IN
015700000000     C                   PARM                    WAF                            FNC KEY TABLE
015800000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
015900000000      *
016000000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
016100000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
016200000000     C                   SUB       1             WW                             BUMP IDX
016300000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
016400000000     C                   ENDSR                                                  END BLD FKY
016500000000      *___________________________________________________________________
016600000000      * Process function keys
016700000000      *___________________________________________________________________
016800000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
016900000000     C                   MOVEA     *IN           WWIN                           INDICATORS
017000000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
017100000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
017200000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
017300000000     C                   PARM                    WAD                            FNC DESC
017400000000     C                   PARM                    WWIN                           *IN
017500000000     C                   PARM                    WAF                            FNC KEY TABLE
017600000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
017700000000     C                   ENDSR                                                  END PRCFKY
017800000000      *___________________________________________________________________
017900000000      * Process KEYS function
018000000000      *___________________________________________________________________
018100000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
018200000000     C                   Z-ADD     1             WW                             KEY DSC IDX
018300000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
018400000000 001 C*                                                                         OR KEYS FOUND
018500000000 001  *
018600000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
018700000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
018800000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
018900000000E002 C                   ENDIF                                                  END IF OVER 3
019000000000 001  *
019100000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
019200000000 001 C                   SUB       1             WW                             KEY DESCR IDX
019300000000E001 C                   ENDDO                                                  END DO KEYS
019400000000      *
019500000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
019600000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
019700000000     C                   SUB       1             WW                             BUMP IDX
019800000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
019900000000      *
020000000000     C                   ENDSR                                                  END PRCDKY
020100000000      *___________________________________________________________________
020200000000      * Process RETURN function
020300000000      *___________________________________________________________________
020400000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
020500000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
020600000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
020700000000     C                   ENDSR                                                  END RETURN
020800000000      *___________________________________________________________________
020900000000      * Process CANCEL function
021000000000      *___________________________________________________________________
021100000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
021200000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
021300000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
021400000000     C                   ENDSR                                                  END PRCCNL
021500000000      *___________________________________________________________________
021600000000      * Process ROLLUP function
021700000000      *___________________________________________________________________
021800000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
021900000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
022000000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
022100000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
022200000000E001 C                   ENDIF                                                  END IF GT LST PNL
022300000000     C                   ENDSR                                                  END PRCRUP
022400000000      *___________________________________________________________________
022500000000      * Process ROLLDOWN function
022600000000      *___________________________________________________________________
022700000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
022800000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
022900000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
023000000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
023100000000E001 C                   ENDIF                                                  END IF LT FST PNL
023200000000     C                   ENDSR                                                  END PRCRDN
023300000000      *___________________________________________________________________
023400000000      * Process ENTER function
023500000000      *___________________________________________________________________
023600000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
023700000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
023800000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
023900000000     C                   ENDSR                                                  END PRCENT
024000000000      *___________________________________________________________________
024100000000      * Send message
024200000000      *___________________________________________________________________
024300000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
024400000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
024500000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
024600000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
024700000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
024800000000     C                   PARM                    WWMSG                          ERROR MESSAGE
024900000000     C                   ENDSR                                                  END SND MSG
025000000000      *___________________________________________________________________
025100000000      * Parameter lists
025200000000      *___________________________________________________________________
025300000000     C     PLIST         BEGSR                                                  PARM LISTS
025400000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
025500000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
025600000000     C                   PARM                    WORTN                          INTERNAL MODE
025700000000     C                   PARM                    WUPGM                          LAST PGM NAME
025800000000     C                   PARM                    WDDTA                          RECORD DS
025900000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
026000000000     C                   ENDSR                                                  END PLIST
026100000000      *___________________________________________________________________
026200000000      * Initialize routine
026300000000      *___________________________________________________________________
026400000000     C     *INZSR        BEGSR                                                  INITIALIZE
026500000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
026600020927     C                   MOVEL     'NYZIPXF0'    WWFIL                          FILE NAME-NOTES
026700000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
026800000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
026900000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
027000000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
027100000000     C                   MOVE      WWSTT         WWSTT                          STATUS
027200000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
027300000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
027400000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
027500000000     C                   Z-ADD     WW            WW                             WORK INDEX
027600000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
027700000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
027800000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
027900000000     C                   ENDSR                                                  END DEFN
028000000000      *___________________________________________________________________
028100000000      * Program error handler
028200000000      *___________________________________________________________________
028300000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
028400000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
028500000000     C                   PARM                    WQPGMN                         PROGRAM NAME
028600000000     C                   PARM                    WQSTSC                         STATUS CODE
028700000000     C                   PARM                    WQRPGS                         RPG STATEMENT
028800000000     C                   PARM                    WQMSG                          MESSAGE ID
028900000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
029000000000      *___________________________________________________________________
029100000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02920000000003EXIT    F3=Exit
02930000000012CANCEL  F12=Cancel
02940000000025ROLLUP
02950000000026ROLLDOWN
029600000000** WTM
02970002092700Zip Code Cross Reference File record not found.
