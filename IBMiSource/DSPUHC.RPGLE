000100220124        Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000200220124                         DftActGrp(*no)
000300220124                         bnddir('GBSBIND' )   ;
000400000000      *_________________________________________________________________________
000500000000      *
000600171207      *  Description:  Display United Health Care History Tracking
000700000000      *
000800171207      *  (C)COPYRIGHT 2017 BY GROUP BENEFIT SERVICES, INC.
000900000000      *
001000000000      *_________________________________________________________________________
001100000000      *
001200171207     FDSPUHCD   CF   E             WORKSTN INFDS(DSPD)
001300220124     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001400171208     FACCMST    IF   E           K DISK    EXTFILE('F.ACCMST') PREFIX(A_)
001500171208     FAACODE    IF   E           K DISK
001600171212     FCODESL1   IF   E           K DISK    EXTFILE('F.CODESL1')
001700220209     FTRNERRP   IF   e           K disk
001800000000      *_________________________________________________________________________
001900000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002000000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
002100000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
002200000000      *_________________________________________________________________________
002300000000      *
002400000000      * Data structure
002500171207     D WDDTA         E DS                  EXTNAME(UHCHSTP)
002600000000      *
002700000000      * Program status data structure
002800000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002900000000      *
003000000000      * Display file data structure
003100000000     D DSPD          E DS                  EXTNAME(IODSPD)
003200000000      *
003300021008     D WIFKV           S             60A
003400021008     D WIFKY           S                   LIKE(WIFKV)
003500021008     D WIOPV           S                   LIKE(WIFKV)
003600021008     D WIRQS           S              8A
003700021008     D WORTN           S              8A
003800021008     D WUPGM           S             10A
003900021008     D WWCHG           S              1A
004000021008     D WWDLT           S              1A
004100021008     D WWDTAQ          S             10A
004200021008     D WWENDF          S              3A
004300021008     D WWENDO          S                   LIKE(WWENDF)
004400021008     D WWERR           S              1A
004500021008     D WWFIL           S             10A
004600021008     D WWFKA           S              8A
004700021008     D WWFKV           S                   LIKE(WIFKV)
004800021008     D WWFKY           S                   LIKE(WIFKV)
004900021008     D WWFLK           S            128A
005000021008     D WWFMTN          S              8A
005100021008     D WWFNC           S              8A
005200021008     D WWIJI           S             16A
005300021008     D WWIN            S             99A
005400021008     D WWLIB           S             10A
005500021008     D WWMSG           S             80A
005600021008     D WWMSGC          S              7A
005700021008     D WWOCD           S              8A
005800021008     D WWOPA           S              8A
005900021008     D WWOPN           S              1A
006000021008     D WWOPT           S              8A
006100021008     D WWOPV           S                   LIKE(WIFKV)
006200021008     D WWORQS          S                   LIKE(WIRQS)
006300021008     D WWPSNC          S              1A
006400021008     D WWQJN           S             26A
006500021008     D WWRQS           S                   LIKE(WIRQS)
006600021008     D WWRQSD          S                   LIKE(WIRQS)
006700021008     D WWRTN           S                   LIKE(WORTN)
006800021008     D WWRTND          S                   LIKE(WORTN)
006900021008     D WWRTNH          S                   LIKE(WORTN)
007000021008     D WWSFLE          S              1A
007100021008     D WWSTT           S              3A
007200021008     D WWTSK           S              8A
007300021008     D WWTXT           S             60A
007400021008     D WWUPD           S              1A
007500021008     D WWWRNF          S              1A
007600021008     D WWZERO          S             40A
007700021008     D WFRRN           S              4P 0
007800021008     D WW              S              3P 0
007900021008     D WWFKS           S              1P 0
008000021008     D WWFKSO          S                   LIKE(WWFKS)
008100021008     D WWLMT           S              2P 0
008200021008     D WWLNG           S             15P 5
008300021008     D WWLNGQ          S              5P 0
008400021008     D WWLOWR          S              4P 0
008500021008     D WWLSTS          S              2P 0
008600021008     D WWOPS           S              1P 0
008700021008     D WWOPSO          S                   LIKE(WWOPS)
008800021008     D WWPNL           S              1P 0
008900021008     D WWPNLN          S                   LIKE(WWPNL)
009000021008     D WWPNLO          S                   LIKE(WWPNL)
009100021008     D WWPSNI          S              2P 0
009200021008     D WWPSNN          S              1P 0
009300021008     D WWPSNP          S                   LIKE(WWPSNN)
009400021008     D WWRRN           S              4P 0
009500000000     ****
009600000000      *
009700000000      *
009800000000      *_________________________________________________________________________
009900000000      * Process display panel
010000000000     C                   EXSR      PRPPNL                                       PREPARE PANEL
010100000000      *
010200000000B001 C                   DOW       WWSTT <> 'END'                               DOWHILE NOT END
010300000000 001 C                   EXSR      RCVMSG                                       RECEIVE MSGS
010400000000 001 C                   EXSR      DSPPNL                                       DISPLAY PANEL
010500000000 001 C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
010600000000 001  *
010700000000 001 C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
010800000000 001 C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
010900000000 001 C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
011000000000 001 C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
011100000000 001 C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
011200000000 001 C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
011300000000 001 C                   ENDCS                                                  END CASE
011400000000 001  *
011500000000E001 C                   ENDDO                                                  END DOWHILE
011600220124     C                   eval      *inLR = *on                                  RETURN
011700000000      *___________________________________________________________________
011800000000      * Prepare display panel
011900000000      *___________________________________________________________________
012000000000     C     PRPPNL        BEGSR                                                  PREPARE PANEL
012100000000      *
012200000000     C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
012300000000     C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
012400000000     C                   MOVE      *BLANKS       WWSTT                          STATUS
012500000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
012600000000     C                   Z-ADD     1             WWPNL                          CURRENT PNL
012700000000     C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
012800000000     C                   Z-ADD     1             WWFKS                          FNC KEY SET
012900000000     C                   Z-ADD     *ZEROS        WW                             WORK INDEX
013000000000      *
013100000000     C                   EXSR      BLDFKY                                       BUILD FNCTNS
013200000000     C                   EXSR      GETREC                                       GET RECORD
013300000000B001 C                   IF        WWRTN <> *BLANKS                             IF GET IN ERR
013400000000 001 C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
013500000000 001 C                   EXSR      SNDMSG                                       SEND MESSAGE
013600000000 001 C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
013700000000 001 C                   MOVE      'END'         WWSTT                          END PROGRAM
013800000000E001 C                   ENDIF                                                  END IF ERROR
013900000000      *
014000000000      *
014100000000     C                   ENDSR                                                  END PRPPNL
014200000000      *___________________________________________________________________
014300000000      * Get record
014400000000      *___________________________________________________________________
014500000000     C     GETREC        BEGSR                                                  GET RECORD
014600171207     C                   CALL      'UPDUHC  '                                   PROCESS REC IO
014700000000     C                   PARM      'GETNL '      WWRQS                          GET RECORD
014800000000     C                   PARM                    WWRTN                          RETURN CODE
014900000000     C                   PARM                    WDDTA                          REC DATA
015000000000     C                   ENDSR                                                  END GETREC
015100000000      *___________________________________________________________________
015200000000      * Receive messages
015300000000      *___________________________________________________________________
015400000000     C     RCVMSG        BEGSR                                                  RECEIVE MSG
015500000000     C                   MOVEA     *IN           WWIN                           INDICATORS
015600000000     C                   CALL      'PRCMSG2'                                    CALL MSG PGM
015700000000     C                   PARM      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
015800000000     C                   PARM                    WWIN                           INDICATORS
015900000000     C                   PARM                    WWRTN                          RETURN CODE
016000000000     C                   MOVEA     WWIN          *IN                            INDICATORS RET
016100000000     C                   ENDSR                                                  END RCV MSG
016200000000      *___________________________________________________________________
016300000000      * Display the display panel
016400000000      *___________________________________________________________________
016500000000     C     DSPPNL        BEGSR                                                  DISPLAY PANEL
016600000000      *
016700000000      * Set OVERLAY based on last display file processed
016800000000     C                   IF        WQPGMN <> WUPGM                              IF NEW PROGRAM
016900000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
017000000000 001 C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
017100000000X001 C                   ELSE                                                   SAME PGM
017200000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
017300000000E001 C                   ENDIF                                                  END IF NEW PGM
017400000000      *
017500000000      * Write message subfile
017600000000     C                   MOVE      *ON           *IN30                          SFLMSG DISPLAY
017700000000     C                   WRITE     MSGSFLC                                      WRITE MSG SFL
017800000000      *
017900000000      * Write display panels
018000060105B001 C                   SELECT
018100060105 001 C                   WHEN      WWPNL = 1                                    IF PANEL 1
018200171207     C                   eval      WSNAME = %trim(UHFIRST) + ' ' +
018300171207     C                                      %trim(UHLAST)
018400171208     C     UHTRND        mult      10000.0001    WSTRND
018500220216     C     UHAPPD        mult      10000.0001    WSAPPD
018600220216     C     UHERRD        mult      10000.0001    UHERRD
018700171207     C     ACCKEY        chain     ACCMST
018800180227     C                   eval      WSACNM = %editc(A_ACTRST:'X') + '-' +
018900180227     C                                      %editc(A_ACSUB#:'X') + '-' +
019000180227     C                                      %editc(A_ACACCT:'X') + '  ' +
019100180227     C                                      %trim(A_ACNAM1)
019200220209
019300220209     C                   clear                   WSERRR
019400220209     C     UHERRR        chain     TRNERRP
019500220209     C                   if        %found(TRNERRP)
019600220209     C                   eval      WSERRR  = %trim(ERREAS)
019700220209     C                   end
019800220209
019900171208     C     A_AACODE      chain     AACODE
020000171208     C                   eval      WSAANM = %trim(AFNAM) + ' ' +
020100171208     C                                      %trim(ALNAM)
020200171212     C     UHNOTE        chain     CODESL1
020300171212     C                   eval      WSNOTE = %trim(LDESCR)
020400180725     C                   if        UHNOTE = 'HLD'
020500180725     C                   eval      WSNOTE = 'HOLD'
020600180725     C                   end
020700200303     C                   if        UHNOTE = 'KEY'
020800200303     C                   eval      WSNOTE = 'KEY ACCOUNT'
020900200303     C                   end
021000180725     C                   if        UHNOTE = 'INC'
021100180725     C                   eval      WSNOTE = 'INCOMPLETE'
021200180725     C                   end
021300000000 001 C                   EXFMT     DSPPNL1                                      DSPLY PNL1
021400000000E001 C                   ENDSL                                                  END SELECT
021500171207    ***
021600171207     C     ACCKEY        klist
021700171207     C                   kfld                    UHTRST
021800171207     C                   kfld                    UHSUB#
021900171207     C                   kfld                    UHACCT
022000060105    ***
022100000000     C                   ENDSR                                                  END DSP DSP
022200000000      *___________________________________________________________________
022300000000      * Build function key information
022400000000      *___________________________________________________________________
022500000000     C     BLDFKY        BEGSR                                                  BLD FNC KEYS
022600000000     C                   MOVEA     *IN           WWIN                           INDICATORS
022700000000     C                   CALL      'PRCFKY2'                                    PROC FNC KYS
022800000000     C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
022900000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
023000000000     C                   PARM                    WAD                            FNC DESC
023100000000     C                   PARM                    WWIN                           *IN
023200000000     C                   PARM                    WAF                            FNC KEY TABLE
023300000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
023400000000      *
023500000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
023600000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
023700000000     C                   SUB       1             WW                             BUMP IDX
023800000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
023900000000     C                   ENDSR                                                  END BLD FKY
024000000000      *___________________________________________________________________
024100000000      * Process function keys
024200000000      *___________________________________________________________________
024300000000     C     PRCFKY        BEGSR                                                  PROC FNC KEYS
024400000000     C                   MOVEA     *IN           WWIN                           INDICATORS
024500000000     C                   CALL      'PRCFKY2'                                    PROC FNC KEY
024600000000     C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
024700000000     C     WWFNC         PARM                    WWRTN                          RETURN CODE
024800000000     C                   PARM                    WAD                            FNC DESC
024900000000     C                   PARM                    WWIN                           *IN
025000000000     C                   PARM                    WAF                            FNC KEY TABLE
025100000000     C                   PARM                    WIFKY                          FNC KYS ALLWD
025200000000     C                   ENDSR                                                  END PRCFKY
025300000000      *___________________________________________________________________
025400000000      * Process KEYS function
025500000000      *___________________________________________________________________
025600000000     C     PRCDKY        BEGSR                                                  PROCESS KEYS
025700000000     C                   Z-ADD     1             WW                             KEY DSC IDX
025800000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS              DO UNTIL SET=1
025900000000 001 C*                                                                         OR KEYS FOUND
026000000000 001  *
026100000000 001 C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
026200000000B002 C                   IF        WWFKS > 3                                    IF OVER 3
026300000000 002 C                   Z-ADD     1             WWFKS                          SET TO 1
026400000000E002 C                   ENDIF                                                  END IF OVER 3
026500000000 001  *
026600000000 001 C     WWFKS         MULT      2             WW                             KEY DESCR IDX
026700000000 001 C                   SUB       1             WW                             KEY DESCR IDX
026800000000E001 C                   ENDDO                                                  END DO KEYS
026900000000      *
027000000000     C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
027100000000     C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
027200000000     C                   SUB       1             WW                             BUMP IDX
027300000000     C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
027400000000      *
027500000000     C                   ENDSR                                                  END PRCDKY
027600000000      *___________________________________________________________________
027700000000      * Process RETURN function
027800000000      *___________________________________________________________________
027900000000     C     PRCRTN        BEGSR                                                  PROCESS RETURN
028000000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
028100000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
028200000000     C                   ENDSR                                                  END RETURN
028300000000      *___________________________________________________________________
028400000000      * Process CANCEL function
028500000000      *___________________________________________________________________
028600000000     C     PRCCNL        BEGSR                                                  PROCESS CANCEL
028700000000     C                   MOVEL     WWFNC         WORTN                          RETURN CODE
028800000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
028900000000     C                   ENDSR                                                  END PRCCNL
029000000000      *___________________________________________________________________
029100000000      * Process ROLLUP function
029200000000      *___________________________________________________________________
029300000000     C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
029400000000     C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
029500000000B001 C                   IF        WWPNL > WWPNLN                               IF GT LAST PNL
029600000000 001 C     WWPNL         SUB       1             WWPNL                          LAST PANEL
029700000000E001 C                   ENDIF                                                  END IF GT LST PNL
029800000000     C                   ENDSR                                                  END PRCRUP
029900000000      *___________________________________________________________________
030000000000      * Process ROLLDOWN function
030100000000      *___________________________________________________________________
030200000000     C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
030300000000     C     WWPNL         SUB       1             WWPNL                          PRV PANEL
030400000000B001 C                   IF        WWPNL < 1                                    IF LT FIRST PNL
030500000000 001 C     WWPNL         ADD       1             WWPNL                          LAST PANEL
030600000000E001 C                   ENDIF                                                  END IF LT FST PNL
030700000000     C                   ENDSR                                                  END PRCRDN
030800000000      *___________________________________________________________________
030900000000      * Process ENTER function
031000000000      *___________________________________________________________________
031100000000     C     PRCENT        BEGSR                                                  PROCESS ENTER
031200000000     C                   MOVE      *BLANKS       WORTN                          RETURN CODE
031300000000     C                   MOVE      'END'         WWSTT                          END INVOCATION
031400000000     C                   ENDSR                                                  END PRCENT
031500000000      *___________________________________________________________________
031600000000      * Send message
031700000000      *___________________________________________________________________
031800000000     C     SNDMSG        BEGSR                                                  SEND MESSAGE
031900000000     C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
032000000000     C                   PARM      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
032100000000     C                   PARM      'QTEMP'       WWLIB                          DATA QUEUE LIB
032200000000     C                   PARM      80            WWLNGQ                         MESSAGE LENGTH
032300000000     C                   PARM                    WWMSG                          ERROR MESSAGE
032400000000     C                   ENDSR                                                  END SND MSG
032500000000      *___________________________________________________________________
032600000000      * Parameter lists
032700000000      *___________________________________________________________________
032800000000     C     PLIST         BEGSR                                                  PARM LISTS
032900000000     C     *ENTRY        PLIST                                                  *ENTRY LIST
033000000000     C     WWTSK         PARM                    WIRQS                          EXT MODE
033100000000     C                   PARM                    WORTN                          INTERNAL MODE
033200000000     C                   PARM                    WUPGM                          LAST PGM NAME
033300000000     C                   PARM                    WDDTA                          RECORD DS
033400000000     C                   PARM                    WIFKY                          FUNCTIONS VALID
033500000000     C                   ENDSR                                                  END PLIST
033600000000      *___________________________________________________________________
033700000000      * Initialize routine
033800000000      *___________________________________________________________________
033900000000     C     *INZSR        BEGSR                                                  INITIALIZE
034000000000     C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
034100171207     C                   MOVEL     'UHCHSTP'     WWFIL                          FILE NAME-NOTES
034200000000     C                   MOVE      *BLANKS       WWFLK                          FILE KEY - NOTES
034300000000     C                   MOVE      *BLANKS       WWTXT                          TEXT - NOTES
034400000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
034500000000     C                   MOVE      WWOCD         WWOCD                          OPTION CODE
034600000000     C                   MOVE      WWSTT         WWSTT                          STATUS
034700000000     C                   Z-ADD     WWPNL         WWPNL                          CURRENT PNL
034800000000     C                   Z-ADD     WWPNLN        WWPNLN                         NBR OF PNLS
034900000000     C                   Z-ADD     WWFKS         WWFKS                          FNC KEY SET
035000000000     C                   Z-ADD     WW            WW                             WORK INDEX
035100000000     C                   MOVE      WWFIL         WWFIL                          FILE NAME-NOTES
035200000000     C                   MOVE      WWFLK         WWFLK                          FILE KEY - NOTES
035300000000     C                   MOVE      WWTXT         WWTXT                          TEXT - NOTES
035400000000     C                   ENDSR                                                  END DEFN
035500000000      *___________________________________________________________________
035600000000      * Program error handler
035700000000      *___________________________________________________________________
035800000000     C     *PSSR         BEGSR                                                  PROGRAM ERROR
035900000000     C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
036000000000     C                   PARM                    WQPGMN                         PROGRAM NAME
036100000000     C                   PARM                    WQSTSC                         STATUS CODE
036200000000     C                   PARM                    WQRPGS                         RPG STATEMENT
036300000000     C                   PARM                    WQMSG                          MESSAGE ID
036400000000     C                   ENDSR     '*CANCL'                                     END PGM ERROR
036500000000      *___________________________________________________________________
036600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03670000000003EXIT    F3=Exit
03680000000012CANCEL  F12=Cancel
03690000000025ROLLUP
03700000000026ROLLDOWN
037100000000** WTM
03720017120700UHC History File record not found.
