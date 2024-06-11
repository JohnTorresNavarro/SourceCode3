000100000000    ? *_________________________________________________________________________
000200100106    ? *
000300130628    ? *  Prompt
000400010220    ? *
000500121016    ? *  (c)Copyright 2012 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700130628    ?FPMTVPSD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900121016     FACCMST    If   e           k Disk
001000000000    ? *_________________________________________________________________________
001100000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001300121016    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              PANEL MESSAGES
001400130628    ?D WAG             S              4    DIM(999)                             PANEL MESSAGES
001500130628
001600130628    ?D WSDESC          S             40A                                        PANEL MESSAGES
001700130628    ?D WSTRS           S              3S 0                                      PANEL MESSAGES
001800130628    ?D WSSUB           S              3S 0                                      PANEL MESSAGES
001900130628    ?D WSACT           S              4S 0                                      PANEL MESSAGES
002000000000    ? *_________________________________________________________________________
002100000000    ? * Program status data structure
002200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000    ? *
002400000000    ? * Display file data structure
002500991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002600980311    ? *
002700991116    ? * Screen Date
002800991116    ?D                 DS                  INZ
002900100106    ?D  WSDAT1                 1      8  0
003000100106    ?D                 DS                  INZ
003100100106    ?D  WSDAT2                 1      8  0
003200991116    ? *
003300991116    ? * Output Date
003400991116    ?D                 DS                  INZ
003500100106    ?D  WXDAT1                 1      8  0
003600100106    ?D                 DS                  INZ
003700100106    ?D  WXDAT2                 1      8  0
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
006000121016E001?C                   Enddo                                                  END DOWHILE
006100100106
006200121016     C                   Move      WSTRS         WOTRS
006300121016     C                   Move      WSSUB         WOSUB
006400121016     C                   Move      WSACT         WOACT
006500130708     C     WSDAT1        Mult      10000.0001    WXDAT1
006600121223     C                   Move      WXDAT1        WODAT1            8
006700130708     C     WSDAT2        Mult      10000.0001    WXDAT2
006800121223     C                   Move      WXDAT2        WODAT2            8
006900100106
007000980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
007100000000    ? *___________________________________________________________________
007200000000    ? * Prepare display panel
007300000000    ? *___________________________________________________________________
007400000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007500000000    ? *
007600000000    ? * Initialize variables
007700000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
007800000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
007900000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008000000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
008100000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008200000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
008300000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008400000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
008500980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
008600010223     C                   Move      *On           *IN38
008700010223    ? *
008800000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
008900991108    ? *
009000000000    ?C                   Endsr                                                  END PRPPNL
009100000000    ? *___________________________________________________________________
009200000000    ? * Receive messages
009300000000    ? *___________________________________________________________________
009400000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
009500000000    ?C                   Movea     *IN           WWIN                           INDICATORS
009600000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
009700980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
009800000000    ?C                   Parm                    WWIN                           INDICATORS
009900000000    ?C                   Parm                    WWRTN             8            RETURN CODE
010000000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
010100000000    ?C                   Endsr                                                  END RCV MSG
010200000000    ? *___________________________________________________________________
010300000000    ? * Display the display panel
010400000000    ? *___________________________________________________________________
010500000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
010600000000    ? *
010700000000    ? * Set OVERLAY based on last display file processed
010800000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
010900000000 001?C                   Setoff                                       35        OVERLAY OFF
011000000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
011100000000X001?C                   Else                                                   SAME PGM
011200000000 001?C                   Seton                                        35        OVERLAY ON
011300000000E001?C                   Endif                                                  END IF NEW PGM
011400000000    ? *
011500000000    ? * Write message subfile
011600000000    ?C                   Seton                                        30        SFLMSG DISPLAY
011700980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
011800000000    ? *
011900000000    ? * Write display panels
012000980218    ? *
012100980323B001?C     WWDSP         Ifeq      1
012200980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
012300980323E001?C                   Endif
012400980323    ? *
012500000000    ?C                   Endsr                                                  END DSP DSP
012600000000    ? *___________________________________________________________________
012700000000    ? * Build function key information
012800000000    ? *___________________________________________________________________
012900000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
013000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
013100991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
013200000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
013300000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
013400000000    ?C                   Parm                    WAD                            FNC DESC
013500991108    ?C                   Parm                    WWIN                           *IN
013600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
013700000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
013800000000    ? *
013900000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
014000000000    ?C                   Sub       1             WW                             BUMP IDX
014100980312    ? *
014200000000    ?C                   Endsr                                                  END BLD FKY
014300000000    ? *___________________________________________________________________
014400000000    ? * Process function keys
014500000000    ? *___________________________________________________________________
014600000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
014700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
014800991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
014900000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
015000000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
015100000000    ?C                   Parm                    WAD                            FNC DESC
015200991108    ?C                   Parm                    WWIN                           *IN
015300000000    ?C                   Parm                    WAF                            FNC KEY TABLE
015400000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
015500000000    ?C                   Endsr                                                  END PRCFKY
015600000000    ? *___________________________________________________________________
015700000000    ? * Process KEYS function
015800000000    ? *___________________________________________________________________
015900000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
016000000000    ?C                   Z-add     1             WW                             KEY DSC IDX
016100000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
016200000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
016300000000 001? *
016400000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
016500000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
016600000000 002?C                   Z-add     1             WWFKS                          SET TO 1
016700000000E002?C                   Endif                                                  END IF OVER 3
016800000000 001? *
016900000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
017000000000 001?C                   Sub       1             WW                             KEY DESCR IDX
017100000000E001?C                   Enddo                                                  END DO KEYS
017200000000    ? *
017300000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
017400000000    ?C                   Sub       1             WW                             BUMP IDX
017500000000    ? *
017600000000    ?C                   Endsr                                                  END PRCDKY
017700000000    ? *___________________________________________________________________
017800000000    ? * Process RETURN function
017900000000    ? *___________________________________________________________________
018000000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
018100000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
018200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
018300000000    ?C                   Endsr                                                  END RETURN
018400980311    ? *___________________________________________________________________
018500980311    ? * Process PROMPT function
018600980311    ? *___________________________________________________________________
018700980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
018800980403    ? *
018900980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
019000980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
019100980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
019200980311    ?C                   Mvr                     WSLIN                          CURSOR COL
019300980311    ?C                   Seton                                        37        SET ON CRSLOC
019400980311    ? *
019500980311    ?C                   Endsr                                                  END PRCPMT
019600000000    ? *___________________________________________________________________
019700000000    ? * Process CANCEL function
019800000000    ? *___________________________________________________________________
019900000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
020000000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
020100000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
020200000000    ?C                   Endsr                                                  END PRCCNL
020300000000    ? *___________________________________________________________________
020400000000    ? * Process ROLLUP function
020500000000    ? *___________________________________________________________________
020600000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
020700000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
020800000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
020900000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
021000000000E001?C                   Endif                                                  END IF GT LST PNL
021100000000    ?C                   Endsr                                                  END PRCRUP
021200000000    ? *___________________________________________________________________
021300000000    ? * Process ROLLDOWN function
021400000000    ? *___________________________________________________________________
021500000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
021600000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
021700000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
021800000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
021900000000E001?C                   Endif                                                  END IF LT FST PNL
022000000000    ?C                   Endsr                                                  END PRCRDN
022100000000    ? *___________________________________________________________________
022200000000    ? * Process ENTER function
022300000000    ? *___________________________________________________________________
022400000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
022500980323    ? *
022600980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
022700980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
022800980415    ? *
022900980415    ? * SET RETURN PARMS
023000010221B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
023100980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
023200980323 001?C                   Move      'END'         WWSTT                          END PROMPT
023300980430E001?C                   Endif                                                  END RAM
023400980430    ? *
023500000000    ?C                   Endsr                                                  END PRCENT
023600980402    ? *___________________________________________________________________
023700980402    ? * Check data
023800980402    ? *___________________________________________________________________
023900980402    ?C     CHKDTA        Begsr                                                  Check data
024000980402    ? *
024100980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
024200980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
024300121016    ? *
024400121016    ? * Validate TSA.
024500121016     C     ACCKEY        Klist
024600121016     C                   Kfld                    WSTRS
024700121016     C                   Kfld                    WSSUB
024800121016     C                   Kfld                    WSACT
024900121016     C     ACCKEY        Chain     ACCMST
025000121016     C                   If        not %found(ACCMST)
025100130628    ?C***                Movel     WTM(3)        WWMSG                          PASS MESSAGE
025200130628    ?C***                Exsr      SNDMSG                                       SEND MESSAGE
025300130628    ?C***                Move      'ERROR   '    WWRTN                          RETURN ERROR
025400130628     C                   End
025500121016     C                   Eval      WSDESC = %trim(ACNAM1)
025600990329    ? *
025700100106    ? * From Date Must be valid.
025800100106     C                   movel     WSDAT1        Input_Date
025900010220     C                   Exsr      EDTDAT
026000010220     C                   If        Output_Error <> *Blanks
026100130620    ?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
026200130620    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
026300130620    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
026400010221    ?C                   Else                                                   END ERROR
026500100106    ? * To Date Must be valid.
026600100106     C                   movel     WSDAT2        Input_Date
026700100106     C                   Exsr      EDTDAT
026800100106     C                   If        Output_Error <> *Blanks
026900130620    ?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
027000130620    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
027100130620    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
027200100106    ?C                   End                                                    END ERROR
027300010223    ?C                   End                                                    END ERROR
027400010131    ? *
027500980415    ? * WWCNT is for Enter Key control (x2)
027600010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
027700010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
027800010131    ?C                   Add       1             WWCNT                          INC COUNT
027900010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
028000010131    ?C                   Else                                                   ELSE
028100010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
028200010131    ?C                   Endif                                                  ENDIF
028300980402    ? *
028400980402    ?C                   Endsr                                                  END SND MSG
028500010220    ? *___________________________________________________________________
028600010220    ? * format Date edit
028700010220    ? *___________________________________________________________________
028800010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
028900010220     C                   movel     'MMDDYYYY'    Input_Format
029000010220     C                   Call      'FMTDATE'
029100010220     C                   Parm                    Input_Date       32
029200010220     C                   Parm                    Input_Format     32
029300010220     C                   Parm                    Output_Format    32
029400010220     C                   Parm                    Output_Date      32
029500010220     C                   Parm                    Output_Error     10
029600010220    ?C                   Endsr                                                  END DLT RQST
029700000000    ? *___________________________________________________________________
029800000000    ? * Send message
029900000000    ? *___________________________________________________________________
030000000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
030100000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
030200000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
030300000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
030400000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
030500000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
030600000000    ?C                   Endsr                                                  END SND MSG
030700000000    ? *___________________________________________________________________
030800000000    ? * Parameter lists
030900000000    ? *___________________________________________________________________
031000000000    ?C     PLIST         Begsr                                                  PARM LISTS
031100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
031200000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
031300000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
031400000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
031500000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
031600121016    ?C                   Parm                    WOTRS             3            PMT - OUT   R
031700121016    ?C                   Parm                    WOSUB             3            PMT - OUT   R
031800121016    ?C                   Parm                    WOACT             4            PMT - OUT   R
031900130620    ?C                   Parm                    WODAT1            8            PMT - OUT   R
032000130620    ?C                   Parm                    WODAT2            8            PMT - OUT   R
032100000000    ?C                   Endsr                                                  END PLIST
032200000000    ? *___________________________________________________________________
032300000000    ? * Initialize routine
032400000000    ? *___________________________________________________________________
032500000000    ?C     *INZSR        Begsr                                                  INITIALIZE
032600000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
032700121016    ?C                   Movel     '        '    WWFIL                          FILE NAME-NOTES
032800000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
032900000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
033000000000    ?C                   Endsr                                                  END *INZSR
033100000000    ? *___________________________________________________________________
033200000000    ? * Define  routine
033300000000    ? *___________________________________________________________________
033400000000    ?C     DEFN          Begsr                                                  Define Fields
033500980311    ? *
033600980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
033700980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
033800980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
033900980311    ? *
034000000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
034100000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
034200000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
034300000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
034400000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
034500000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
034600000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
034700000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
034800000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
034900000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
035000000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
035100000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
035200000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
035300000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
035400000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
035500980312    ? *
035600980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
035700980312    ? *
035800000000    ?C                   Endsr                                                  END DEFN
035900000000    ? *___________________________________________________________________
036000000000    ? * Program error handler
036100000000    ? *___________________________________________________________________
036200000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
036300000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
036400000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
036500000000    ?C                   Parm                    WQSTSC                         STATUS CODE
036600000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
036700000000    ?C                   Parm                    WQMSG                          MESSAGE ID
036800000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
036900980312    ? *
037000991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03710000000012CANCEL  F12=Cancel
03720098032425ROLLUP
03730098032426ROLLDOWN
037400980312** WTM
03750010010661From Date is invalid.
03760012101662To Date is invalid.
03770012101663Account is invalid.
