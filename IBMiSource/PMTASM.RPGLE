000100160317     h option(*NoDebugIo)
000200160317
000300000000    ? *_________________________________________________________________________
000400100106    ? *
000500121016    ? *  ASM Payroll Ded Prompt
000600010220    ? *
000700121016    ? *  (c)Copyright 2012 by GBS, Inc.
000800000000    ? *_________________________________________________________________________
000900121016    ?FPMTASMD   CF   E             WORKSTN
001000000000    ?F                                     INFDS(DSPD)
001100121016     FACCMST    If   e           k Disk
001200000000    ? *_________________________________________________________________________
001300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001500121016    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              PANEL MESSAGES
001600051219    ?D WAG             S              4    DIM(999)                             PANEL MESSAGES
001700000000    ? *_________________________________________________________________________
001800000000    ? * Program status data structure
001900991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002000000000    ? *
002100000000    ? * Display file data structure
002200991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002300980311    ? *
002400991116    ? * Screen Date
002500991116    ?D                 DS                  INZ
002600100106    ?D  WSDAT1                 1      8  0
002700100106    ?D                 DS                  INZ
002800100106    ?D  WSDAT2                 1      8  0
002900991116    ? *
003000991116    ? * Output Date
003100991116    ?D                 DS                  INZ
003200100106    ?D  WXDAT1                 1      8  0
003300100106    ?D                 DS                  INZ
003400100106    ?D  WXDAT2                 1      8  0
003500980311    ? *
003600980311    ? * CURSOR LOCATION
003700980311    ?D                 DS
003800980311    ?D  WWCRSL                 1      2
003900980311    ?D  WWCRSN                 1      2B 0
004000000000    ? *_________________________________________________________________________
004100000000    ? * Process display panel
004200000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004300000000    ? *
004400000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004500000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004600000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
004700000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004800000000 001? *
004900000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
005000000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
005100980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005200000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
005300980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
005400980312 001? *
005500000000 001?C                   Endcs                                                  END CASE
005600000000 001? *
005700121016E001?C                   Enddo                                                  END DOWHILE
005800100106
005900121016     C                   Move      WSTRS         WOTRS
006000121016     C                   Move      WSSUB         WOSUB
006100121016     C                   Move      WSACT         WOACT
006200100106     C     WSDAT1        Mult      10000.0001    WXDAT1
006300100106     C                   Move      WXDAT1        WODAT1
006400100106     C     WSDAT2        Mult      10000.0001    WXDAT2
006500100106     C                   Move      WXDAT2        WODAT2
006600100106
006700980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
006800000000    ? *___________________________________________________________________
006900000000    ? * Prepare display panel
007000000000    ? *___________________________________________________________________
007100000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007200000000    ? *
007300000000    ? * Initialize variables
007400000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
007500000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
007600000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007700000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007800000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
007900000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
008000000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008100000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
008200980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
008300010223     C                   Move      *On           *IN38
008400010223    ? *
008500000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
008600991108    ? *
008700000000    ?C                   Endsr                                                  END PRPPNL
008800000000    ? *___________________________________________________________________
008900000000    ? * Receive messages
009000000000    ? *___________________________________________________________________
009100000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
009200000000    ?C                   Movea     *IN           WWIN                           INDICATORS
009300000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
009400980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
009500000000    ?C                   Parm                    WWIN                           INDICATORS
009600000000    ?C                   Parm                    WWRTN             8            RETURN CODE
009700000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
009800000000    ?C                   Endsr                                                  END RCV MSG
009900000000    ? *___________________________________________________________________
010000000000    ? * Display the display panel
010100000000    ? *___________________________________________________________________
010200000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
010300000000    ? *
010400000000    ? * Set OVERLAY based on last display file processed
010500000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
010600000000 001?C                   Setoff                                       35        OVERLAY OFF
010700000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
010800000000X001?C                   Else                                                   SAME PGM
010900000000 001?C                   Seton                                        35        OVERLAY ON
011000000000E001?C                   Endif                                                  END IF NEW PGM
011100000000    ? *
011200000000    ? * Write message subfile
011300000000    ?C                   Seton                                        30        SFLMSG DISPLAY
011400980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
011500000000    ? *
011600000000    ? * Write display panels
011700980218    ? *
011800980323B001?C     WWDSP         Ifeq      1
011900980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
012000980323E001?C                   Endif
012100980323    ? *
012200000000    ?C                   Endsr                                                  END DSP DSP
012300000000    ? *___________________________________________________________________
012400000000    ? * Build function key information
012500000000    ? *___________________________________________________________________
012600000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
012700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
012800991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
012900000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
013000000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
013100000000    ?C                   Parm                    WAD                            FNC DESC
013200991108    ?C                   Parm                    WWIN                           *IN
013300000000    ?C                   Parm                    WAF                            FNC KEY TABLE
013400000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
013500000000    ? *
013600000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
013700000000    ?C                   Sub       1             WW                             BUMP IDX
013800980312    ? *
013900000000    ?C                   Endsr                                                  END BLD FKY
014000000000    ? *___________________________________________________________________
014100000000    ? * Process function keys
014200000000    ? *___________________________________________________________________
014300000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
014400991108    ?C                   Movea     *IN           WWIN                           INDICATORS
014500991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
014600000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
014700000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
014800000000    ?C                   Parm                    WAD                            FNC DESC
014900991108    ?C                   Parm                    WWIN                           *IN
015000000000    ?C                   Parm                    WAF                            FNC KEY TABLE
015100000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
015200000000    ?C                   Endsr                                                  END PRCFKY
015300000000    ? *___________________________________________________________________
015400000000    ? * Process KEYS function
015500000000    ? *___________________________________________________________________
015600000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
015700000000    ?C                   Z-add     1             WW                             KEY DSC IDX
015800000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
015900000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
016000000000 001? *
016100000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
016200000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
016300000000 002?C                   Z-add     1             WWFKS                          SET TO 1
016400000000E002?C                   Endif                                                  END IF OVER 3
016500000000 001? *
016600000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
016700000000 001?C                   Sub       1             WW                             KEY DESCR IDX
016800000000E001?C                   Enddo                                                  END DO KEYS
016900000000    ? *
017000000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
017100000000    ?C                   Sub       1             WW                             BUMP IDX
017200000000    ? *
017300000000    ?C                   Endsr                                                  END PRCDKY
017400000000    ? *___________________________________________________________________
017500000000    ? * Process RETURN function
017600000000    ? *___________________________________________________________________
017700000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
017800000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
017900000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
018000000000    ?C                   Endsr                                                  END RETURN
018100980311    ? *___________________________________________________________________
018200980311    ? * Process PROMPT function
018300980311    ? *___________________________________________________________________
018400980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
018500980403    ? *
018600980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
018700980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
018800980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
018900980311    ?C                   Mvr                     WSLIN                          CURSOR COL
019000980311    ?C                   Seton                                        37        SET ON CRSLOC
019100980311    ? *
019200980311    ?C                   Endsr                                                  END PRCPMT
019300000000    ? *___________________________________________________________________
019400000000    ? * Process CANCEL function
019500000000    ? *___________________________________________________________________
019600000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
019700000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
019800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
019900000000    ?C                   Endsr                                                  END PRCCNL
020000000000    ? *___________________________________________________________________
020100000000    ? * Process ROLLUP function
020200000000    ? *___________________________________________________________________
020300000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
020400000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
020500000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
020600000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
020700000000E001?C                   Endif                                                  END IF GT LST PNL
020800000000    ?C                   Endsr                                                  END PRCRUP
020900000000    ? *___________________________________________________________________
021000000000    ? * Process ROLLDOWN function
021100000000    ? *___________________________________________________________________
021200000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
021300000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
021400000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
021500000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
021600000000E001?C                   Endif                                                  END IF LT FST PNL
021700000000    ?C                   Endsr                                                  END PRCRDN
021800000000    ? *___________________________________________________________________
021900000000    ? * Process ENTER function
022000000000    ? *___________________________________________________________________
022100000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
022200980323    ? *
022300980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
022400980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
022500980415    ? *
022600980415    ? * SET RETURN PARMS
022700010221B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
022800980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
022900980323 001?C                   Move      'END'         WWSTT                          END PROMPT
023000980430E001?C                   Endif                                                  END RAM
023100980430    ? *
023200000000    ?C                   Endsr                                                  END PRCENT
023300980402    ? *___________________________________________________________________
023400980402    ? * Check data
023500980402    ? *___________________________________________________________________
023600980402    ?C     CHKDTA        Begsr                                                  Check data
023700980402    ? *
023800980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
023900980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
024000121016    ? *
024100121016    ? * Validate TSA.
024200121016     C     ACCKEY        Klist
024300121016     C                   Kfld                    WSTRS
024400121016     C                   Kfld                    WSSUB
024500121016     C                   Kfld                    WSACT
024600121016     C     ACCKEY        Chain     ACCMST
024700121016     C                   If        not %found(ACCMST)
024800121016    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
024900121016    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
025000121016    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
025100121016     C                   Else
025200121016     C                   Eval      WSDESC = %trim(ACNAM1)
025300990329    ? *
025400100106    ? * From Date Must be valid.
025500100106     C                   movel     WSDAT1        Input_Date
025600010220     C                   Exsr      EDTDAT
025700010220     C                   If        Output_Error <> *Blanks
025800100106    ?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
025900010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
026000010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
026100010221    ?C                   Else                                                   END ERROR
026200100106    ? * To Date Must be valid.
026300100106     C                   movel     WSDAT2        Input_Date
026400100106     C                   Exsr      EDTDAT
026500100106     C                   If        Output_Error <> *Blanks
026600100106    ?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
026700100106    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
026800100106    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
026900100106    ?C                   End                                                    END ERROR
027000010223    ?C                   End                                                    END ERROR
027100121016     C                   End
027200010131    ? *
027300980415    ? * WWCNT is for Enter Key control (x2)
027400010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
027500010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
027600010131    ?C                   Add       1             WWCNT                          INC COUNT
027700010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
027800010131    ?C                   Else                                                   ELSE
027900010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
028000010131    ?C                   Endif                                                  ENDIF
028100980402    ? *
028200980402    ?C                   Endsr                                                  END SND MSG
028300010220    ? *___________________________________________________________________
028400010220    ? * format Date edit
028500010220    ? *___________________________________________________________________
028600010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
028700010220     C                   movel     'MMDDYYYY'    Input_Format
028800010220     C                   Call      'FMTDATE'
028900010220     C                   Parm                    Input_Date       32
029000010220     C                   Parm                    Input_Format     32
029100010220     C                   Parm                    Output_Format    32
029200010220     C                   Parm                    Output_Date      32
029300010220     C                   Parm                    Output_Error     10
029400010220    ?C                   Endsr                                                  END DLT RQST
029500000000    ? *___________________________________________________________________
029600000000    ? * Send message
029700000000    ? *___________________________________________________________________
029800000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
029900000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
030000000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
030100000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
030200000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
030300000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
030400000000    ?C                   Endsr                                                  END SND MSG
030500000000    ? *___________________________________________________________________
030600000000    ? * Parameter lists
030700000000    ? *___________________________________________________________________
030800000000    ?C     PLIST         Begsr                                                  PARM LISTS
030900000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
031000000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
031100000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
031200000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
031300000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
031400121016    ?C                   Parm                    WOTRS             3            PMT - OUT   R
031500121016    ?C                   Parm                    WOSUB             3            PMT - OUT   R
031600121016    ?C                   Parm                    WOACT             4            PMT - OUT   R
031700100106    ?C                   Parm                    WODAT1            8            PMT - OUT   R
031800100106    ?C                   Parm                    WODAT2            8            PMT - OUT   R
031900000000    ?C                   Endsr                                                  END PLIST
032000000000    ? *___________________________________________________________________
032100000000    ? * Initialize routine
032200000000    ? *___________________________________________________________________
032300000000    ?C     *INZSR        Begsr                                                  INITIALIZE
032400000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
032500121016    ?C                   Movel     '        '    WWFIL                          FILE NAME-NOTES
032600000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
032700000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
032800000000    ?C                   Endsr                                                  END *INZSR
032900000000    ? *___________________________________________________________________
033000000000    ? * Define  routine
033100000000    ? *___________________________________________________________________
033200000000    ?C     DEFN          Begsr                                                  Define Fields
033300980311    ? *
033400980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
033500980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
033600980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
033700980311    ? *
033800000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
033900000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
034000000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
034100000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
034200000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
034300000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
034400000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
034500000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
034600000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
034700000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
034800000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
034900000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
035000000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
035100000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
035200000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
035300980312    ? *
035400980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
035500980312    ? *
035600000000    ?C                   Endsr                                                  END DEFN
035700000000    ? *___________________________________________________________________
035800000000    ? * Program error handler
035900000000    ? *___________________________________________________________________
036000000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
036100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
036200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
036300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
036400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
036500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
036600000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
036700980312    ? *
036800991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03690000000012CANCEL  F12=Cancel
03700098032425ROLLUP
03710098032426ROLLDOWN
037200980312** WTM
03730010010661From Date is invalid.
03740012101662To Date is invalid.
03750012101663Account is invalid.
