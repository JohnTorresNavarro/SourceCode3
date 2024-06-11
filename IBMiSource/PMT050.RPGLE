000101100721    ? *_________________________________________________________________________
000300080215    ? *  (c)Copyright 2008 by GBS, Inc.
000500100721    ? *                                                                     ____
000501100721    ? * 07/21/10 DLK - add payment type selection                           ____
000502100721    ? *_________________________________________________________________________
000600080215    ?FACCMST    IF   E           K DISK
000700080215    ?FPMT050D   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900000000    ? *_________________________________________________________________________
001000000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001100000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001200080215    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)              PANEL MESSAGES
001300000000    ? *_________________________________________________________________________
001301080218    ?D  W0DATE         s              8  0 INZ
001302080218    ?
001303080215    ? * Screen Date
001309080215    ?D                 DS                  INZ
001310080215    ?D  WSDATE                 1      8  0
001311080215    ?D  WOMON                  1      2  0
001312080215    ?D  WODAY                  3      4  0
001313080215    ?D  WOYER                  5      8  0
001314080215    ? *
001400000000    ? * Program status data structure
001500991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001600000000    ? *
001700000000    ? * Display file data structure
001800991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
001900991116    ? *
002000991116    ? * Date data structure
002100991116    ?D DATD          E DS                  EXTNAME(IODATD)
002200000000    ? *
002201080215    ?D WDACCT        E DS                  EXTNAME(ACCMST)
002300080215    ?D WOPMT         E DS                  EXTNAME(PMT050DS)
002301080218     D  CAT                   27     36A   DIM(10)
003800980311    ? *
003900980311    ? * CURSOR LOCATION
004000980311    ?D                 DS
004100980311    ?D  WWCRSL                 1      2
004200980311    ?D  WWCRSN                 1      2B 0
004300000000    ? *_________________________________________________________________________
004400000000    ? * Process display panel
004500000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004600000000    ? *
004700000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004800000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004900000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
005000000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005100000000 001? *
005200000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
005300000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
005400980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005500000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
005600980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
005700980312 001? *
005800000000 001?C                   Endcs                                                  END CASE
005900000000 001? *
006000000000E001?C                   Enddo                                                  END DOWHILE
006100980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
006200000000    ? *___________________________________________________________________
006300000000    ? * Prepare display panel
006400000000    ? *___________________________________________________________________
006500000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
006600000000    ? *
006700000000    ? * Initialize variables
006800000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
006900000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
007000000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007100000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007200000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
007300000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
007400000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
007500000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
007600980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
008100010524    ? *
008200000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
008300991108    ? *
008400000000    ?C                   Endsr                                                  END PRPPNL
008500000000    ? *___________________________________________________________________
008600000000    ? * Receive messages
008700000000    ? *___________________________________________________________________
008800000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
008900000000    ?C                   Movea     *IN           WWIN                           INDICATORS
009000000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
009100980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
009200000000    ?C                   Parm                    WWIN                           INDICATORS
009300000000    ?C                   Parm                    WWRTN             8            RETURN CODE
009400000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
009500000000    ?C                   Endsr                                                  END RCV MSG
009600000000    ? *___________________________________________________________________
009700000000    ? * Display the display panel
009800000000    ? *___________________________________________________________________
009900000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
010000000000    ? *
010100000000    ? * Set OVERLAY based on last display file processed
010200000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
010300000000 001?C                   Setoff                                       35        OVERLAY OFF
010400000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
010500000000X001?C                   Else                                                   SAME PGM
010600000000 001?C                   Seton                                        35        OVERLAY ON
010700000000E001?C                   Endif                                                  END IF NEW PGM
010800000000    ? *
010900000000    ? * Write message subfile
011000000000    ?C                   Seton                                        30        SFLMSG DISPLAY
011100980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
011200000000    ? *
011300000000    ? * Write display panels
011400980218    ? *
011500980323B001?C     WWDSP         Ifeq      1
011600980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
011700980323E001?C                   Endif
011800980323    ? *
011900000000    ?C                   Endsr                                                  END DSP DSP
012000000000    ? *___________________________________________________________________
012100000000    ? * Build function key information
012200000000    ? *___________________________________________________________________
012300000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
012400991108    ?C                   Movea     *IN           WWIN                           INDICATORS
012500991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
012600000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
012700000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
012800000000    ?C                   Parm                    WAD                            FNC DESC
012900991108    ?C                   Parm                    WWIN                           *IN
013000000000    ?C                   Parm                    WAF                            FNC KEY TABLE
013100000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
013200000000    ? *
013300000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
013301080218     C                   Movel     WAD(WW)       WSFKD2
013400000000    ?C                   Sub       1             WW                             BUMP IDX
013401080218     C                   Movel     WAD(WW)       WSFKD1
013500980312    ? *
013600000000    ?C                   Endsr                                                  END BLD FKY
013700000000    ? *___________________________________________________________________
013800000000    ? * Process function keys
013900000000    ? *___________________________________________________________________
014000000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
014100991108    ?C                   Movea     *IN           WWIN                           INDICATORS
014200991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
014300000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
014400000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
014500000000    ?C                   Parm                    WAD                            FNC DESC
014600991108    ?C                   Parm                    WWIN                           *IN
014700000000    ?C                   Parm                    WAF                            FNC KEY TABLE
014800000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
014900000000    ?C                   Endsr                                                  END PRCFKY
015000000000    ? *___________________________________________________________________
015100000000    ? * Process KEYS function
015200000000    ? *___________________________________________________________________
015300000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
015400000000    ?C                   Z-add     1             WW                             KEY DSC IDX
015500000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
015600000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
015700000000 001? *
015800000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
015900000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
016000000000 002?C                   Z-add     1             WWFKS                          SET TO 1
016100000000E002?C                   Endif                                                  END IF OVER 3
016200000000 001? *
016300000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
016400000000 001?C                   Sub       1             WW                             KEY DESCR IDX
016500000000E001?C                   Enddo                                                  END DO KEYS
016600000000    ? *
016700000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
016800000000    ?C                   Sub       1             WW                             BUMP IDX
016801080218      *
016802080218     C                   Movel     WAD(WW)       WSFKD1
016803080218     C                   Add       1             WW
016804080218     C                   Movel     WAD(WW)       WSFKD2
016900000000    ? *
017000000000    ?C                   Endsr                                                  END PRCDKY
017100000000    ? *___________________________________________________________________
017200000000    ? * Process RETURN function
017300000000    ? *___________________________________________________________________
017400000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
017500000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
017600000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
017700000000    ?C                   Endsr                                                  END RETURN
017800980311    ? *___________________________________________________________________
017900980311    ? * Process PROMPT function
018000980311    ? *___________________________________________________________________
018100980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
018200980311    ? *
018300980311    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
018400980311    ? *
018500991108    ? * PROMPT MEMBER
018600080215B001?C     WSFLD         Ifeq      'WSXXXXX'                                    WHERE FIELD NAME
019600991116X001?C                   Else                                                               NAME
019700991108 001?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
019800991108 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
019900991116E001?C                   Endif
020000980403    ? *
020100980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
020200980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
020300980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
020400980311    ?C                   Mvr                     WSLIN                          CURSOR COL
020500980311    ?C                   Seton                                        37        SET ON CRSLOC
020600980311    ? *
020700980311    ?C                   Endsr                                                  END PRCPMT
020800000000    ? *___________________________________________________________________
020900000000    ? * Process CANCEL function
021000000000    ? *___________________________________________________________________
021100000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
021200000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
021300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
021400000000    ?C                   Endsr                                                  END PRCCNL
021500000000    ? *___________________________________________________________________
021600000000    ? * Process ROLLUP function
021700000000    ? *___________________________________________________________________
021800000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
021900000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
022000000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
022100000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
022200000000E001?C                   Endif                                                  END IF GT LST PNL
022300000000    ?C                   Endsr                                                  END PRCRUP
022400000000    ? *___________________________________________________________________
022500000000    ? * Process ROLLDOWN function
022600000000    ? *___________________________________________________________________
022700000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
022800000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
022900000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
023000000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
023100000000E001?C                   Endif                                                  END IF LT FST PNL
023200000000    ?C                   Endsr                                                  END PRCRDN
023300000000    ? *___________________________________________________________________
023400000000    ? * Process ENTER function
023500000000    ? *___________________________________________________________________
023600000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
023700980323    ? *
023800980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
023900980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
024000980415    ? *
024100980415    ? * SET RETURN PARMS
024200980402B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
024201080218     C     WSDATE0       Mult      10000.0001    W0DATE
024202080218     C                   Move      W0DATE        PMTDT1
024300080218     C     WSDATE1       Mult      10000.0001    W0DATE
024301080218     C                   Move      W0DATE        PMTDT2
024302080218     C                   If        WSTRST = 0
024303080218     C                   Eval      PMTTRS = *BLANKS
024304080218     C                   Else
024305080218     C                   Move      WSTRST        PMTTRS
024306080218     C                   End
024307080218     C                   If        WSDIVN = 0
024308080218     C                   Eval      PMTSUB = *BLANKS
024309080218     C                   Else
024310080218     C                   Move      WSDIVN        PMTSUB
024311080218     C                   End
024312080218     C                   If        WSACCT = 0
024313080218     C                   Eval      PMTACC = *BLANKS
024314080218     C                   Else
024315080218     C                   Move      WSACCT        PMTACC
024316080218     C                   End
024600980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
024700980323 001?C                   Move      'END'         WWSTT                          END PROMPT
024800980430E001?C                   Endif                                                  END RAM
024900980430    ? *
025000000000    ?C                   Endsr                                                  END PRCENT
025100980402    ? *___________________________________________________________________
025200980402    ? * Check data
025300980402    ? *___________________________________________________________________
025400980402    ?C     CHKDTA        Begsr                                                  Check data
025401080218    ? *
025402080218     C                   Eval      PMTC01 = WSCAT01
025403080218     C                   Eval      PMTC02 = WSCAT02
025404080218     C                   Eval      PMTC03 = WSCAT03
025405080218     C                   Eval      PMTC04 = WSCAT04
025406080218     C                   Eval      PMTC05 = WSCAT05
025407080218     C                   Eval      PMTC06 = WSCAT06
025408080218     C                   Eval      PMTC07 = WSCAT07
025409080218     C                   Eval      PMTC08 = WSCAT08
025410080218     C                   Eval      PMTC09 = WSCAT09
025411080218     C                   Eval      PMTC10 = WSCAT10
025500100721    ? * payment type - move to DS fields
025501100721     C                   Eval      PMTt01 = WST1
025502100721     C                   Eval      PMTt02 = WST2
025503100721     C                   Eval      PMTt03 = WST3
025504100721     C                   Eval      PMTt04 = WST4
025505100721     C                   Eval      PMTt05 = WST5
025506100721     C                   Eval      PMTt06 = WST6
025508100721
025600980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
025700980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
025800990329    ? *
025900080215    ? * Date from Must be valid.
026000080215    ?C                   Eval      WSDATE = WSDATE0                             RESET OUTPUT
026100991116    ?C                   Call      'CHKDAT'                                     CHECK DATE
026200080215    ?C                   Parm      WOMON         WRM                            6 TO 8
026300080215    ?C                   Parm      WODAY         WRD                            6 TO 8
026400080215    ?C                   Parm      WOYER         WRY                            6 TO 8
026500991116    ?C                   Parm                    WWRTN                          RETURN CODE
026600010131    ?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
026700080215    ?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
026800010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
026900010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
027000010131    ?C                   Endif                                                  END ERROR
027100991116    ? *
027101080215    ? * Date to Must be valid.
027102080215    ?C                   Eval      WSDATE = WSDATE1                             RESET OUTPUT
027103080215    ?C                   Call      'CHKDAT'                                     CHECK DATE
027104080215    ?C                   Parm      WOMON         WRM                            6 TO 8
027105080215    ?C                   Parm      WODAY         WRD                            6 TO 8
027106080215    ?C                   Parm      WOYER         WRY                            6 TO 8
027107080215    ?C                   Parm                    WWRTN                          RETURN CODE
027108080215    ?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
027109080215    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
027110080215    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
027111080215    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
027112080215    ?C                   Endif                                                  END ERROR
027113080215    ? *
027200080215    ? * Trust 0, then ALL
027300080215    ?C                   IF        WSTRST > 0
027900080218    ? * Must be a valid.
028100080215    ?C     WSTRST        Chain     ACCMST                             50        VALIDATE
028200010131    ?C     *IN50         Ifeq      *ON                                          NOT FOUND
028300080215    ?C                   Movel     WTM(4)        WWMSG                          PASS MESSAGE
028400010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
028500010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
028600010131    ?C                   Endif                                                  END FOUND
028800010131    ?C                   Endif
028801080215    ? *
028802080218    ? * Must enter cat if trst = 0
028803080215    ?C                   IF        WSTRST = 0
028804080218    ?C                   If        %trim(CAT(1)) = *BLANKS
028805080215    ?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
028806080215    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
028807080215    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
028808080215    ?C                   End
028810080215    ?C                   End                                                    END FOUND
028811080215    ? *
028812080215    ?C     W2KEY         KLIST                                                  VALIDATE
028813080215     C                   KFLD                    WSTRST
028814080215     C                   KFLD                    WSDIVN
028815080215    ? * Sub 0, then ALL
028816080215    ?C                   IF        WSDIVN > 0
028817080218    ? * Must be a valid.
028818080215    ?C     W2KEY         Chain     ACCMST                             50        VALIDATE
028819080215    ?C     *IN50         Ifeq      *ON                                          NOT FOUND
028820080215    ?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
028821080215    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
028822080215    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
028823080215    ?C                   Endif                                                  END FOUND
028824080215    ?C                   Endif
028825080215    ? *
028826080215    ? *
028827080215    ?C     W3KEY         KLIST                                                  VALIDATE
028828080215     C                   KFLD                    WSTRST
028829080215     C                   KFLD                    WSDIVN
028830080215     C                   KFLD                    WSACCT
028831080215    ? * Acc 0, then ALL
028832080215    ?C                   IF        WSACCT > 0
028833080218    ? * Must be a valid.
028834080215    ?C     W3KEY         Chain     ACCMST                             50        VALIDATE
028835080215    ?C     *IN50         Ifeq      *ON                                          NOT FOUND
028836080215    ?C                   Movel     WTM(7)        WWMSG                          PASS MESSAGE
028837080215    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
028838080215    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
028839080215    ?C                   Endif                                                  END FOUND
028840080215    ?C                   Endif
028900010131    ? *
029000080215    ? * Sort Must be A, or D.
029100080221    ?C*    WSSORT        Ifne      'A'
029300080221    ?C*    WSSORT        andne     'D'
029400080221    ?C*                  Movel     WTM(8)        WWMSG                          PASS MESSAGE
029500080221    ?C*                  Exsr      SNDMSG                                       SEND MESSAGE
029600080221    ?C*                  Move      'ERROR   '    WWRTN                          RETURN ERROR
029700080221    ?C*                  End
030600010131    ? *
030700980415    ? * WWCNT is for Enter Key control (x2)
030800010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
030900010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
031000010131    ?C                   Add       1             WWCNT                          INC COUNT
031100010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
031200010131    ?C                   Else                                                   ELSE
031300010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
031400010131    ?C                   Endif                                                  ENDIF
031500980402    ? *
031600980402    ?C                   Endsr                                                  END SND MSG
031700000000    ? *___________________________________________________________________
031800000000    ? * Send message
031900000000    ? *___________________________________________________________________
032000000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
032100000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
032200000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
032300000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
032400000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
032500000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
032600000000    ?C                   Endsr                                                  END SND MSG
032700000000    ? *___________________________________________________________________
032800000000    ? * Parameter lists
032900000000    ? *___________________________________________________________________
033000000000    ?C     PLIST         Begsr                                                  PARM LISTS
033100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
033200000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
033300000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
033400000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
033500000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
033600080215    ?C                   Parm                    WOPMT                          PMT - OUT   R
033700000000    ?C                   Endsr                                                  END PLIST
033800000000    ? *___________________________________________________________________
033900000000    ? * Initialize routine
034000000000    ? *___________________________________________________________________
034100000000    ?C     *INZSR        Begsr                                                  INITIALIZE
034200000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
034300080215    ?C                   Movel     'ACCMST  '    WWFIL                          FILE NAME-NOTES
034400000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
034500000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
034600000000    ?C                   Endsr                                                  END *INZSR
034700000000    ? *___________________________________________________________________
034800000000    ? * Define  routine
034900000000    ? *___________________________________________________________________
035000000000    ?C     DEFN          Begsr                                                  Define Fields
035100980311    ? *
035200980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
035300980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
035400980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
035500980311    ? *
035600000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
035700000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
035800000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
035900000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
036000000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
036100000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
036200000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
036300000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
036400000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
036500000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
036600000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
036700000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
036800000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
036900000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
037000000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
037100980312    ? *
037200980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
037300980312    ? *
037400000000    ?C                   Endsr                                                  END DEFN
037500000000    ? *___________________________________________________________________
037600000000    ? * Program error handler
037700000000    ? *___________________________________________________________________
037800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
037900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
038000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
038100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
038200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
038300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
038400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
038500980312    ? *
038600991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03880000000012CANCEL  F12=Cancel
03890098032425ROLLUP
03900098032426ROLLDOWN
039100980312** WTM
03920098031200The cursor is not in a prompt area.
03920108021560From Date be valid MMDDYYYY format.
03930008021561To Date be valid MMDDYYYY format.
03930108021562Trust must be valid.
03940008021563If ALL then enter Trust Category Code(s)
03940108021564Division must be valid.
03960008021565Account must be valid.
03970008021866Sort must be A or N.
