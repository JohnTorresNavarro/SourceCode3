000100000000      *_________________________________________________________________________
000200000000      *
000300140324      *  Description:  Coverage Plan Master File Inquiry
000400000000      *
000500140324      *  (c)Copyright 2014 by GBS, Inc.
000600000000      *
000700000000    ? *_________________________________________________________________________
000800000000    ? *
000900140324    ?FFI030D    CF   E             WORKSTN
001000000000     F                                     INFDS(DSPD)
0011001403240014 FPLNMST    if   e           K disk     extfile('F.PLNMST')
0012001403240015 FTRSMST    if   e           K disk     extfile('F.TRSMST')
0013001403280016 FSUBMST    if   e           K disk     extfile('F.SUBMST')
0014001404100016 FACCMST    if   e           K disk     extfile('F.ACCMST')
0015001404100016 FAC2MST    if   e           K disk     extfile('F.AC2MST')
0016001404010016 FOEPLAN    if   e           K disk
001700000000    ? *_________________________________________________________________________
001800000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001900000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002000010219    ?D WTM             S             80    DIM(1) CTDATA PERRCD(1)              PANEL MESSAGES
002100100618     D WSDESC          S             20A
002200000000    ? *_________________________________________________________________________
002300000000    ? *
002400000406    ? * Data structure
002500140324    ?D WDDTA         E DS                  EXTNAME(PLNMST)
002600140324
002700140324    ? * Data structure
002800140325    ?D WUCARR        E DS                  EXTNAME(CARMST)
002900140325    ?D WUCATS        E DS                  EXTNAME(CODES)
003000000000    ? *
003100000000    ? * Program status data structure
003200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003300000000    ? *
003400000000    ? * Display file data structure
003500991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003600140324
003700140324     D                UDS
003800140324     D  WSYS                 201    240
003900140324
004000000000    ? *_________________________________________________________________________
004100000000    ? * Process display panel
004200000000    ?C                   EXSR      PRPPNL                                       PREPARE PANEL
004300000000    ? *
004400000000B001?C     WWSTT         DOWNE     'END'                                        DOWHILE NOT END
004500000000 001?C                   EXSR      RCVMSG                                       RECEIVE MSGS
004600000000 001?C                   EXSR      DSPPNL                                       DISPLAY PANEL
004700000000 001?C                   EXSR      PRCFKY                                       PROC FNCTN KEYS
004800000000 001? *
004900000000 001?C     WWFNC         CASEQ     'KEYS'        PRCDKY                         DISPLAY KEYS
005000140324 001?C     WWFNC         CASEQ     'CARS'        PRCCAR                         EXIT
005100140324 001?C     WWFNC         CASEQ     'CATS'        PRCCAT                         EXIT
005200000000 001?C     WWFNC         CASEQ     'EXIT'        PRCRTN                         EXIT
005300000000 001?C     WWFNC         CASEQ     'CANCEL'      PRCCNL                         CANCEL
005400000000 001?C     WWFNC         CASEQ     'ROLLUP'      PRCRUP                         ROLL UP
005500000000 001?C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN                         ROLL DOWN
005600000000 001?C     WWFNC         CASEQ     'ENTER '      PRCENT                         ENTER
005700000000 001?C                   ENDCS                                                  END CASE
005800000000 001? *
005900000000E001?C                   ENDDO                                                  END DOWHILE
006000000000    ?C                   RETURN                                                 RETURN
006100000000    ? *___________________________________________________________________
006200000000    ? * Prepare display panel
006300000000    ? *___________________________________________________________________
006400000000    ?C     PRPPNL        BEGSR                                                  PREPARE PANEL
006500000000    ? *
006600000000    ?C                   MOVE      *BLANKS       WWIN                           INDICATOR FIELD
006700000000    ?C                   MOVE      *BLANKS       WWOCD                          OPTION CODE
006800000000    ?C                   MOVE      *BLANKS       WWSTT                          STATUS
006900000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
007000000000    ?C                   Z-ADD     1             WWPNL                          CURRENT PNL
007100010227    ?C                   Z-ADD     1             WWPNLN                         NBR OF PNLS
007200000000    ?C                   Z-ADD     1             WWFKS                          FNC KEY SET
007300000000    ?C                   Z-ADD     *ZEROS        WW                             WORK INDEX
007400000000    ? *
007500000000    ?C                   EXSR      BLDFKY                                       BUILD FNCTNS
007600000000    ?C                   EXSR      GETREC                                       GET RECORD
007700000000B001?C     WWRTN         IFNE      *BLANKS                                      IF GET IN ERR
007800000000 001?C                   MOVE      WTM(1)        WWMSG                          GET MESSAGE
007900000000 001?C                   EXSR      SNDMSG                                       SEND MESSAGE
008000000000 001?C                   MOVE      'ERROR   '    WORTN                          RETURN ERROR
008100000000 001?C                   MOVE      'END'         WWSTT                          END PROGRAM
008200010914E001?C                   ENDIF                                                  END IF ERROR
008300000000    ?C                   ENDSR                                                  END PRPPNL
008400000000    ? *___________________________________________________________________
008500000000    ? * Get record
008600000000    ? *___________________________________________________________________
008700000000    ?C     GETREC        BEGSR                                                  GET RECORD
008800100521
008900140324     C     PLTRST        CHAIN     TRSMST
009000140324
009100140324     C     SUBKEY        KLIST
009200140324     C                   KFLD                    PLTRST
009300140324     C                   KFLD                    PLSUB#
009400140324     C     SUBKEY        CHAIN     SUBMST
009500140324
009600140324     C     PLNKEY        KLIST
009700140324     C                   KFLD                    PLTRST
009800140324     C                   KFLD                    PLSUB#
009900140324     C                   KFLD                    PLPLAN
010000140401     C     PLNKEY        CHAIN     PLNMST
010100140401     C     PLNKEY        CHAIN     OEPLAN
010200140401
010300140401     C                   If        PDEBIT = *blanks
010400140401     C                   eval      *in75 = *on
010500140401     C                   Else
010600140401     C                   eval      *in75 = *off
010700140401     C                   End
010800140328
010900140328     C     ACCKEY        KLIST
011000140328     C                   KFLD                    PLTRST
011100140328     C                   KFLD                    PLSUB#
011200140328     C                   KFLD                    WSACCT
011300140328     C     ACCKEY        CHAIN     ACCMST
011400140410
011500140410     C     AC2KEY        KLIST
011600140410     C                   KFLD                    A2APPL
011700140410     C                   KFLD                    PLTRST
011800140410     C                   KFLD                    PLSUB#
011900140410     C                   KFLD                    WSACCT
012000140410     C                   EVAL      A2APPL = 'F'
012100140410     C     AC2KEY        CHAIN     AC2MST
012200140410
012300140410     C                   eval      plan#1 = A2IH1T + A2IH1B
012400140410     C                   eval      plan#2 = A2IH2T + A2IH2B
012500140410     C                   eval      plan#3 = A2IH3T + A2IH3B
012600140410     C                   eval      plan#4 = A2IH4T + A2IH4B
012700140410     C                   eval      plan#5 = A2IH5T + A2IH5B
012800140410     C                   eval      plan#6 = A2IH6T + A2IH6B
012900140410     C                   eval      plan#7 = A2IH7T + A2IH7B
013000140410     C                   eval      plan#8 = A2IH8T + A2IH8B
013100140410     C                   eval      plan#9 = A2IH9T + A2IH9B
013200140326
013300140326     C                   z-add     prenew        wrmon
013400140326     C                   move      plncat        wpcat
013500100617
013600000000    ?C                   ENDSR                                                  END GETREC
013700140324    ? *___________________________________________________________________
013800140324    ? * Display Cars
013900140324    ? *___________________________________________________________________
014000140324    ?C     PRCCAR        BEGSR                                                  RECEIVE MSG
014100140325    ?C                   Call      'SLCCARCL'                                   *ENTRY LIST
014200140328    ?C                   Parm      'VIEW    '    WIRQS             8            PROGRAM REQUEST
014300140324    ?C                   Parm                    WORTN             8            RETURN CODE
014400140324    ?C                   Parm                    WUPGM            10            LAST PGM NAME
014500140324    ?C                   Parm                    WUCARR                         RECORD DS
014600140324    ?C                   ENDSR                                                  END GETREC
014700140324    ? *___________________________________________________________________
014800140324    ? * Display Cats
014900140324    ? *___________________________________________________________________
015000140324    ?C     PRCCAT        BEGSR                                                  RECEIVE MSG
015100140325    ?C                   Call      'SLCCATCL'                                   *ENTRY LIST
015200140328    ?C                   Parm      'VIEW'        WIRQS             8            PROGRAM REQUEST
015300140325    ?C                   Parm                    WORTN             8            RETURN CODE
015400140325    ?C                   Parm                    WUPGM            10            LAST PGM NAME
015500140325    ?C                   Parm                    WUCATS                         RECORD DS
015600140324    ?C                   ENDSR                                                  END GETREC
015700000000    ? *___________________________________________________________________
015800000000    ? * Receive messages
015900000000    ? *___________________________________________________________________
016000000000    ?C     RCVMSG        BEGSR                                                  RECEIVE MSG
016100000000    ?C                   MOVEA     *IN           WWIN                           INDICATORS
016200000000    ?C                   CALL      'PRCMSG2'                                    CALL MSG PGM
016300140324    ?C                   PARM      'RECEIVE '    WWRQS            10            RECEIVE MESSAGES
016400000000    ?C                   PARM                    WWIN                           INDICATORS
016500000000    ?C                   PARM                    WWRTN             8            RETURN CODE
016600000000    ?C                   MOVEA     WWIN          *IN                            INDICATORS RET
016700000000    ?C                   ENDSR                                                  END RCV MSG
016800000000    ? *___________________________________________________________________
016900000000    ? * Display the display panel
017000000000    ? *___________________________________________________________________
017100000000    ?C     DSPPNL        BEGSR                                                  DISPLAY PANEL
017200000000    ? *
017300000000    ? * Set OVERLAY based on last display file processed
017400000000B001?C     WQPGMN        IFNE      WUPGM                                        IF NEW PROGRAM
017500000000 001?C                   SETOFF                                       35        OVERLAY OFF
017600000000 001?C                   MOVE      WQPGMN        WUPGM                          SAVE CRNT PGM
017700000000X001?C                   ELSE                                                   SAME PGM
017800000000 001?C                   SETON                                        35        OVERLAY ON
017900000000E001?C                   ENDIF                                                  END IF NEW PGM
018000000000    ? *
018100000000    ? * Write message subfile
018200000000    ?C                   SETON                                        30        SFLMSG DISPLAY
018300000000    ?C                   WRITE     MSGSFLC                                      WRITE MSG SFL
018400000000    ? *
018500000000    ? * Write display panels
018600000000B001?C                   SELECT
018700000000 001?C     WWPNL         WHENEQ    1                                            IF PANEL 1
018800000000 001?C                   EXFMT     DSPPNL1                                      DSPLY PNL1
018900000000E001?C                   ENDSL                                                  END SELECT
019000000000    ?C                   ENDSR                                                  END DSP DSP
019100000000    ? *___________________________________________________________________
019200000000    ? * Build function key information
019300000000    ? *___________________________________________________________________
019400000000    ?C     BLDFKY        BEGSR                                                  BLD FNC KEYS
019500991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
019600991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KYS
019700000000    ?C                   PARM      'BUILD   '    WWRQS                          BUILD REQUEST
019800000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
019900000000    ?C                   PARM                    WAD                            FNC DESC
020000991108    ?C                   PARM                    WWIN                           *IN
020100000000    ?C                   PARM                    WAF                            FNC KEY TABLE
020200000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
020300000000    ? *
020400010913    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
020500010913    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
020600010913    ?C                   SUB       1             WW                             BUMP IDX
020700010913    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
020800000000    ?C                   ENDSR                                                  END BLD FKY
020900000000    ? *___________________________________________________________________
021000000000    ? * Process function keys
021100000000    ? *___________________________________________________________________
021200000000    ?C     PRCFKY        BEGSR                                                  PROC FNC KEYS
021300991108    ?C                   MOVEA     *IN           WWIN                           INDICATORS
021400991108    ?C                   CALL      'PRCFKY2'                                    PROC FNC KEY
021500000000    ?C                   PARM      'PROCESS '    WWRQS                          PROCESS REQUEST
021600000000    ?C     WWFNC         PARM                    WWRTN                          RETURN CODE
021700000000    ?C                   PARM                    WAD                            FNC DESC
021800991108    ?C                   PARM                    WWIN                           *IN
021900000000    ?C                   PARM                    WAF                            FNC KEY TABLE
022000000000    ?C                   PARM                    WIFKY                          FNC KYS ALLWD
022100000000    ?C                   ENDSR                                                  END PRCFKY
022200000000    ? *___________________________________________________________________
022300000000    ? * Process KEYS function
022400000000    ? *___________________________________________________________________
022500000000    ?C     PRCDKY        BEGSR                                                  PROCESS KEYS
022600000000    ?C                   Z-ADD     1             WW                             KEY DSC IDX
022700000000B001?C     WWFKS         DOUEQ     1                                            DO UNTIL SET=1
022800000000 001?C     WAD(WW)       ORNE      *BLANKS                                      OR KEYS FOUND
022900000000 001? *
023000000000 001?C     WWFKS         ADD       1             WWFKS                          NEXT KEY SET
023100000000B002?C     WWFKS         IFGT      3                                            IF OVER 3
023200000000 002?C                   Z-ADD     1             WWFKS                          SET TO 1
023300000000E002?C                   ENDIF                                                  END IF OVER 3
023400000000 001? *
023500000000 001?C     WWFKS         MULT      2             WW                             KEY DESCR IDX
023600000000 001?C                   SUB       1             WW                             KEY DESCR IDX
023700000000E001?C                   ENDDO                                                  END DO KEYS
023800000000    ? *
023900000000    ?C     WWFKS         ADD       WWFKS         WW                             KEY DSC IDX
024000000000    ?C                   MOVEL     WAD(WW)       WSFKD2                         LOAD LINE 2
024100000000    ?C                   SUB       1             WW                             BUMP IDX
024200000000    ?C                   MOVEL     WAD(WW)       WSFKD1                         LOAD LINE 1
024300000000    ? *
024400000000    ?C                   ENDSR                                                  END PRCDKY
024500000000    ? *___________________________________________________________________
024600000000    ? * Process RETURN function
024700000000    ? *___________________________________________________________________
024800000000    ?C     PRCRTN        BEGSR                                                  PROCESS RETURN
024900000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
025000000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
025100000000    ?C                   ENDSR                                                  END RETURN
025200000000    ? *___________________________________________________________________
025300000000    ? * Process CANCEL function
025400000000    ? *___________________________________________________________________
025500000000    ?C     PRCCNL        BEGSR                                                  PROCESS CANCEL
025600000000    ?C                   MOVEL     WWFNC         WORTN                          RETURN CODE
025700000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
025800000000    ?C                   ENDSR                                                  END PRCCNL
025900000000    ? *___________________________________________________________________
026000000000    ? * Process ROLLUP function
026100000000    ? *___________________________________________________________________
026200000000    ?C     PRCRUP        BEGSR                                                  PROCESS ROLLUP
026300000000    ?C     WWPNL         ADD       1             WWPNL                          NEXT PANEL
026400000000B001?C     WWPNL         IFGT      WWPNLN                                       IF GT LAST PNL
026500000000 001?C     WWPNL         SUB       1             WWPNL                          LAST PANEL
026600000000E001?C                   ENDIF                                                  END IF GT LST PNL
026700000000    ?C                   ENDSR                                                  END PRCRUP
026800000000    ? *___________________________________________________________________
026900000000    ? * Process ROLLDOWN function
027000000000    ? *___________________________________________________________________
027100000000    ?C     PRCRDN        BEGSR                                                  PROCESS ROLLDOWN
027200000000    ?C     WWPNL         SUB       1             WWPNL                          PRV PANEL
027300000000B001?C     WWPNL         IFLT      1                                            IF LT FIRST PNL
027400000000 001?C     WWPNL         ADD       1             WWPNL                          LAST PANEL
027500000000E001?C                   ENDIF                                                  END IF LT FST PNL
027600000000    ?C                   ENDSR                                                  END PRCRDN
027700000000    ? *___________________________________________________________________
027800000000    ? * Process ENTER function
027900000000    ? *___________________________________________________________________
028000000000    ?C     PRCENT        BEGSR                                                  PROCESS ENTER
028100000000    ?C                   MOVE      *BLANKS       WORTN                          RETURN CODE
028200000000    ?C                   MOVE      'END'         WWSTT                          END INVOCATION
028300000000    ?C                   ENDSR                                                  END PRCENT
028400000000    ? *___________________________________________________________________
028500000000    ? * Send message
028600000000    ? *___________________________________________________________________
028700000000    ?C     SNDMSG        BEGSR                                                  SEND MESSAGE
028800000000    ?C                   CALL      'QSNDDTAQ'                                   SEND MESSAGE
028900000000    ?C                   PARM      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
029000000000    ?C                   PARM      'QTEMP'       WWLIB            10            DATA QUEUE LIB
029100000000    ?C                   PARM      80            WWLNGQ            5 0          MESSAGE LENGTH
029200000000    ?C                   PARM                    WWMSG            80            ERROR MESSAGE
029300000000    ?C                   ENDSR                                                  END SND MSG
029400000000    ? *___________________________________________________________________
029500000000    ? * Parameter lists
029600000000    ? *___________________________________________________________________
029700000000    ?C     PLIST         BEGSR                                                  PARM LISTS
029800000000    ?C     *ENTRY        PLIST                                                  *ENTRY LIST
029900000000    ?C     WWTSK         PARM                    WIRQS             8            EXT MODE
030000000000    ?C                   PARM                    WORTN             8            INTERNAL MODE
030100000000    ?C                   PARM                    WUPGM            10            LAST PGM NAME
030200000614    ?C                   PARM                    WDDTA                          RECORD DS
030300140328     C                   PARM                    WSACCT
030400000000    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
030500000000    ?C                   ENDSR                                                  END PLIST
030600000000    ? *___________________________________________________________________
030700000000    ? * Initialize routine
030800000000    ? *___________________________________________________________________
030900000000    ?C     *INZSR        BEGSR                                                  INITIALIZE
031000000000    ?C                   MOVEL     '*'           MSPGMQ                         SRT JOB'S MSGQ
031100140324    ?C                   MOVEL     'PLNMST   '   WWFIL            10            FILE NAME-NOTES
031200000000    ?C                   MOVE      *BLANKS       WWFLK           128            FILE KEY - NOTES
031300000000    ?C                   MOVE      *BLANKS       WWTXT            60            TEXT - NOTES
031400000000    ?C                   ENDSR                                                  END *INZSR
031500000000    ? *___________________________________________________________________
031600000000    ? * Define  routine
031700000000    ? *___________________________________________________________________
031800000000    ?C     DEFN          BEGSR                                                  Define Fields
031900000000    ?C     *LIKE         DEFINE    WIRQS         WWTSK                          TASK REQUESTED
032000000000    ?C     *LIKE         DEFINE    WORTN         WWFNC                          FUNCTION CODE
032100000000    ?C     *LIKE         DEFINE    WIFKY         WWFKY                          FUNCTIONS VALID
032200000000    ?C     *LIKE         DEFINE    WIFKY         WWFKV                          FUNCTION KEY VALID
032300000000    ?C     *LIKE         DEFINE    WIFKY         WWOPV                          OPTIONS VALID
032400000000    ?C                   MOVE      WWIN          WWIN             99            INDICATOR FIELD
032500000000    ?C                   MOVE      WWOCD         WWOCD             8            OPTION CODE
032600000000    ?C                   MOVE      WWSTT         WWSTT             3            STATUS
032700000000    ?C                   Z-ADD     WWPNL         WWPNL             1 0          CURRENT PNL
032800000000    ?C                   Z-ADD     WWPNLN        WWPNLN            1 0          NBR OF PNLS
032900000000    ?C                   Z-ADD     WWFKS         WWFKS             1 0          FNC KEY SET
033000000000    ?C                   Z-ADD     WW            WW                3 0          WORK INDEX
033100000000    ?C                   MOVE      WWFIL         WWFIL            10            FILE NAME-NOTES
033200000000    ?C                   MOVE      WWFLK         WWFLK           128            FILE KEY - NOTES
033300000000    ?C                   MOVE      WWTXT         WWTXT            60            TEXT - NOTES
033400000000    ?C                   ENDSR                                                  END DEFN
033500000000    ? *___________________________________________________________________
033600000000    ? * Program error handler
033700000000    ? *___________________________________________________________________
033800000000    ?C     *PSSR         BEGSR                                                  PROGRAM ERROR
033900000000    ?C                   CALL      'SNDRPGM'                            50      SEND RPG MSG
034000000000    ?C                   PARM                    WQPGMN                         PROGRAM NAME
034100000000    ?C                   PARM                    WQSTSC                         STATUS CODE
034200000000    ?C                   PARM                    WQRPGS                         RPG STATEMENT
034300000000    ?C                   PARM                    WQMSG                          MESSAGE ID
034400000000    ?C                   ENDSR     '*CANCL'                                     END PGM ERROR
034500000000    ? *___________________________________________________________________
034600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03470014032601EXIT    F1=Return
03480014032409CARS    F9=Carriers
03490014032410CATS    F10=Plan Cat
03500000000025ROLLUP
03510000000026ROLLDOWN
035200000000** WTM
03530014032400
