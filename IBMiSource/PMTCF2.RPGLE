000100000000    ? *_________________________________________________________________________
000200100106    ? *
000300100106    ? *  Date Range Prompt
000400010220    ? *
000500100106    ? *  (c)Copyright 2010 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700100106    ?FPMTCF2D   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900000000    ? *_________________________________________________________________________
001000000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001100000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001200100106    ?D WTM             S             80    DIM(2) CTDATA PERRCD(1)              PANEL MESSAGES
001300051219    ?D WAG             S              4    DIM(999)                             PANEL MESSAGES
001400000000    ? *_________________________________________________________________________
001500000000    ? * Program status data structure
001600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001700000000    ? *
001800000000    ? * Display file data structure
001900991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002000980311    ? *
002100991116    ? * Screen Date
002200991116    ?D                 DS                  INZ
002300100106    ?D  WSDAT1                 1      8  0
002400100106    ?D                 DS                  INZ
002500100106    ?D  WSDAT2                 1      8  0
002600991116    ? *
002700991116    ? * Output Date
002800991116    ?D                 DS                  INZ
002900100106    ?D  WXDAT1                 1      8  0
003000100106    ?D                 DS                  INZ
003100100106    ?D  WXDAT2                 1      8  0
003200980311    ? *
003300980311    ? * CURSOR LOCATION
003400980311    ?D                 DS
003500980311    ?D  WWCRSL                 1      2
003600980311    ?D  WWCRSN                 1      2B 0
003700000000    ? *_________________________________________________________________________
003800000000    ? * Process display panel
003900000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004000000000    ? *
004100000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004200000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004300000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
004400000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004500000000 001? *
004600000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
004700000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
004800980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
004900000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
005000980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
005100980312 001? *
005200000000 001?C                   Endcs                                                  END CASE
005300000000 001? *
005400000000E001?C                   Enddo                                                  END DOWHILE
005500100106
005600100106     C     WSDAT1        Mult      10000.0001    WXDAT1
005700100106     C                   Move      WXDAT1        WODAT1
005800100106     C     WSDAT2        Mult      10000.0001    WXDAT2
005900100106     C                   Move      WXDAT2        WODAT2
006000100106
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
007700010223     C                   Move      *On           *IN38
007800010223    ? *
007900000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
008000991108    ? *
008100000000    ?C                   Endsr                                                  END PRPPNL
008200000000    ? *___________________________________________________________________
008300000000    ? * Receive messages
008400000000    ? *___________________________________________________________________
008500000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
008600000000    ?C                   Movea     *IN           WWIN                           INDICATORS
008700000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
008800980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
008900000000    ?C                   Parm                    WWIN                           INDICATORS
009000000000    ?C                   Parm                    WWRTN             8            RETURN CODE
009100000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
009200000000    ?C                   Endsr                                                  END RCV MSG
009300000000    ? *___________________________________________________________________
009400000000    ? * Display the display panel
009500000000    ? *___________________________________________________________________
009600000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
009700000000    ? *
009800000000    ? * Set OVERLAY based on last display file processed
009900000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
010000000000 001?C                   Setoff                                       35        OVERLAY OFF
010100000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
010200000000X001?C                   Else                                                   SAME PGM
010300000000 001?C                   Seton                                        35        OVERLAY ON
010400000000E001?C                   Endif                                                  END IF NEW PGM
010500000000    ? *
010600000000    ? * Write message subfile
010700000000    ?C                   Seton                                        30        SFLMSG DISPLAY
010800980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
010900000000    ? *
011000000000    ? * Write display panels
011100980218    ? *
011200980323B001?C     WWDSP         Ifeq      1
011300980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
011400980323E001?C                   Endif
011500980323    ? *
011600000000    ?C                   Endsr                                                  END DSP DSP
011700000000    ? *___________________________________________________________________
011800000000    ? * Build function key information
011900000000    ? *___________________________________________________________________
012000000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
012100991108    ?C                   Movea     *IN           WWIN                           INDICATORS
012200991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
012300000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
012400000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
012500000000    ?C                   Parm                    WAD                            FNC DESC
012600991108    ?C                   Parm                    WWIN                           *IN
012700000000    ?C                   Parm                    WAF                            FNC KEY TABLE
012800000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
012900000000    ? *
013000000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
013100000000    ?C                   Sub       1             WW                             BUMP IDX
013200980312    ? *
013300000000    ?C                   Endsr                                                  END BLD FKY
013400000000    ? *___________________________________________________________________
013500000000    ? * Process function keys
013600000000    ? *___________________________________________________________________
013700000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
013800991108    ?C                   Movea     *IN           WWIN                           INDICATORS
013900991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
014000000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
014100000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
014200000000    ?C                   Parm                    WAD                            FNC DESC
014300991108    ?C                   Parm                    WWIN                           *IN
014400000000    ?C                   Parm                    WAF                            FNC KEY TABLE
014500000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
014600000000    ?C                   Endsr                                                  END PRCFKY
014700000000    ? *___________________________________________________________________
014800000000    ? * Process KEYS function
014900000000    ? *___________________________________________________________________
015000000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
015100000000    ?C                   Z-add     1             WW                             KEY DSC IDX
015200000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
015300000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
015400000000 001? *
015500000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
015600000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
015700000000 002?C                   Z-add     1             WWFKS                          SET TO 1
015800000000E002?C                   Endif                                                  END IF OVER 3
015900000000 001? *
016000000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
016100000000 001?C                   Sub       1             WW                             KEY DESCR IDX
016200000000E001?C                   Enddo                                                  END DO KEYS
016300000000    ? *
016400000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
016500000000    ?C                   Sub       1             WW                             BUMP IDX
016600000000    ? *
016700000000    ?C                   Endsr                                                  END PRCDKY
016800000000    ? *___________________________________________________________________
016900000000    ? * Process RETURN function
017000000000    ? *___________________________________________________________________
017100000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
017200000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
017300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
017400000000    ?C                   Endsr                                                  END RETURN
017500980311    ? *___________________________________________________________________
017600980311    ? * Process PROMPT function
017700980311    ? *___________________________________________________________________
017800980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
017900980403    ? *
018000980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
018100980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
018200980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
018300980311    ?C                   Mvr                     WSLIN                          CURSOR COL
018400980311    ?C                   Seton                                        37        SET ON CRSLOC
018500980311    ? *
018600980311    ?C                   Endsr                                                  END PRCPMT
018700000000    ? *___________________________________________________________________
018800000000    ? * Process CANCEL function
018900000000    ? *___________________________________________________________________
019000000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
019100000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
019200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
019300000000    ?C                   Endsr                                                  END PRCCNL
019400000000    ? *___________________________________________________________________
019500000000    ? * Process ROLLUP function
019600000000    ? *___________________________________________________________________
019700000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
019800000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
019900000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
020000000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
020100000000E001?C                   Endif                                                  END IF GT LST PNL
020200000000    ?C                   Endsr                                                  END PRCRUP
020300000000    ? *___________________________________________________________________
020400000000    ? * Process ROLLDOWN function
020500000000    ? *___________________________________________________________________
020600000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
020700000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
020800000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
020900000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
021000000000E001?C                   Endif                                                  END IF LT FST PNL
021100000000    ?C                   Endsr                                                  END PRCRDN
021200000000    ? *___________________________________________________________________
021300000000    ? * Process ENTER function
021400000000    ? *___________________________________________________________________
021500000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
021600980323    ? *
021700980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
021800980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
021900980415    ? *
022000980415    ? * SET RETURN PARMS
022100010221B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
022200980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
022300980323 001?C                   Move      'END'         WWSTT                          END PROMPT
022400980430E001?C                   Endif                                                  END RAM
022500980430    ? *
022600000000    ?C                   Endsr                                                  END PRCENT
022700980402    ? *___________________________________________________________________
022800980402    ? * Check data
022900980402    ? *___________________________________________________________________
023000980402    ?C     CHKDTA        Begsr                                                  Check data
023100980402    ? *
023200980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
023300980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
023400990329    ? *
023500100106    ? * From Date Must be valid.
023600100106     C                   movel     WSDAT1        Input_Date
023700010220     C                   Exsr      EDTDAT
023800010220     C                   If        Output_Error <> *Blanks
023900100106    ?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
024000010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
024100010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
024200010221    ?C                   Else                                                   END ERROR
024300100106    ? * To Date Must be valid.
024400100106     C                   movel     WSDAT2        Input_Date
024500100106     C                   Exsr      EDTDAT
024600100106     C                   If        Output_Error <> *Blanks
024700100106    ?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
024800100106    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
024900100106    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
025000100106    ?C                   End                                                    END ERROR
025100010223    ?C                   End                                                    END ERROR
025200010131    ? *
025300980415    ? * WWCNT is for Enter Key control (x2)
025400010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
025500010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
025600010131    ?C                   Add       1             WWCNT                          INC COUNT
025700010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
025800010131    ?C                   Else                                                   ELSE
025900010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
026000010131    ?C                   Endif                                                  ENDIF
026100980402    ? *
026200980402    ?C                   Endsr                                                  END SND MSG
026300010220    ? *___________________________________________________________________
026400010220    ? * format Date edit
026500010220    ? *___________________________________________________________________
026600010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
026700010220     C                   movel     'MMDDYYYY'    Input_Format
026800010220     C                   Call      'FMTDATE'
026900010220     C                   Parm                    Input_Date       32
027000010220     C                   Parm                    Input_Format     32
027100010220     C                   Parm                    Output_Format    32
027200010220     C                   Parm                    Output_Date      32
027300010220     C                   Parm                    Output_Error     10
027400010220    ?C                   Endsr                                                  END DLT RQST
027500000000    ? *___________________________________________________________________
027600000000    ? * Send message
027700000000    ? *___________________________________________________________________
027800000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
027900000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
028000000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
028100000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
028200000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
028300000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
028400000000    ?C                   Endsr                                                  END SND MSG
028500000000    ? *___________________________________________________________________
028600000000    ? * Parameter lists
028700000000    ? *___________________________________________________________________
028800000000    ?C     PLIST         Begsr                                                  PARM LISTS
028900000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
029000000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
029100000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
029200000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
029300000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
029400100106    ?C                   Parm                    WODAT1            8            PMT - OUT   R
029500100106    ?C                   Parm                    WODAT2            8            PMT - OUT   R
029600000000    ?C                   Endsr                                                  END PLIST
029700000000    ? *___________________________________________________________________
029800000000    ? * Initialize routine
029900000000    ? *___________________________________________________________________
030000000000    ?C     *INZSR        Begsr                                                  INITIALIZE
030100000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
030200100106    ?C                   Movel     'TRNMIT  '    WWFIL                          FILE NAME-NOTES
030300000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
030400000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
030500000000    ?C                   Endsr                                                  END *INZSR
030600000000    ? *___________________________________________________________________
030700000000    ? * Define  routine
030800000000    ? *___________________________________________________________________
030900000000    ?C     DEFN          Begsr                                                  Define Fields
031000980311    ? *
031100980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
031200980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
031300980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
031400980311    ? *
031500000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
031600000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
031700000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
031800000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
031900000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
032000000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
032100000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
032200000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
032300000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
032400000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
032500000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
032600000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
032700000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
032800000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
032900000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
033000980312    ? *
033100980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
033200980312    ? *
033300000000    ?C                   Endsr                                                  END DEFN
033400000000    ? *___________________________________________________________________
033500000000    ? * Program error handler
033600000000    ? *___________________________________________________________________
033700000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
033800000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
033900000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
034000000000    ?C                   Parm                    WQSTSC                         STATUS CODE
034100000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
034200000000    ?C                   Parm                    WQMSG                          MESSAGE ID
034300000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
034400980312    ? *
034500991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03460000000012CANCEL  F12=Cancel
03470098032425ROLLUP
03480098032426ROLLDOWN
034900980312** WTM
03500010010661From Date is invalid.
03510010010662To Date is invalid.
