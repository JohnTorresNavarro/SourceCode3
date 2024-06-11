000100000000    ? *_________________________________________________________________________
000200100106    ? *
000300130813    ? *  Prompt for OLE Alerts Report
000400010220    ? *
000500130813    ? *  (c)Copyright 2013 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700130813    ?FPMTALERTD CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900121016     FACCMST    If   e           k Disk
001000000000    ? *_________________________________________________________________________
001100000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001300121016    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              PANEL MESSAGES
001400051219    ?D WAG             S              4    DIM(999)                             PANEL MESSAGES
001500000000    ? *_________________________________________________________________________
001600000000    ? * Program status data structure
001700991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001800000000    ? *
001900000000    ? * Display file data structure
002000991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002100980311    ? *
002200991116    ? * Screen Date
002300991116    ?D                 DS                  INZ
002400100106    ?D  WSDAT1                 1      8  0
002500100106    ?D                 DS                  INZ
002600100106    ?D  WSDAT2                 1      8  0
002700991116    ? *
002800991116    ? * Output Date
002900991116    ?D                 DS                  INZ
003000100106    ?D  WXDAT1                 1      8  0
003100100106    ?D                 DS                  INZ
003200100106    ?D  WXDAT2                 1      8  0
003300980311    ? *
003400980311    ? * CURSOR LOCATION
003500980311    ?D                 DS
003600980311    ?D  WWCRSL                 1      2
003700980311    ?D  WWCRSN                 1      2B 0
003800000000    ? *_________________________________________________________________________
003900000000    ? * Process display panel
004000000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004100000000    ? *
004200000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004300000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004400000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
004500000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004600000000 001? *
004700000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
004800000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
004900980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005000000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
005100980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
005200980312 001? *
005300000000 001?C                   Endcs                                                  END CASE
005400000000 001? *
005500121016E001?C                   Enddo                                                  END DOWHILE
005600100106
005700121016     C                   Move      WSTRS         WOTRS
005800121016     C                   Move      WSSUB         WOSUB
005900121016     C                   Move      WSACT         WOACT
006000100106     C     WSDAT1        Mult      10000.0001    WXDAT1
006100121223     C                   Move      WXDAT1        WODAT1            8
006200100106     C     WSDAT2        Mult      10000.0001    WXDAT2
006300121223     C                   Move      WXDAT2        WODAT2            8
006400100106
006500980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
006600000000    ? *___________________________________________________________________
006700000000    ? * Prepare display panel
006800000000    ? *___________________________________________________________________
006900000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007000000000    ? *
007100000000    ? * Initialize variables
007200000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
007300000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
007400000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007500000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007600000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
007700000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
007800000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
007900000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
008000980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
008100010223     C                   Move      *On           *IN38
008200010223    ? *
008300000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
008400991108    ? *
008500000000    ?C                   Endsr                                                  END PRPPNL
008600000000    ? *___________________________________________________________________
008700000000    ? * Receive messages
008800000000    ? *___________________________________________________________________
008900000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
009000000000    ?C                   Movea     *IN           WWIN                           INDICATORS
009100000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
009200980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
009300000000    ?C                   Parm                    WWIN                           INDICATORS
009400000000    ?C                   Parm                    WWRTN             8            RETURN CODE
009500000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
009600000000    ?C                   Endsr                                                  END RCV MSG
009700000000    ? *___________________________________________________________________
009800000000    ? * Display the display panel
009900000000    ? *___________________________________________________________________
010000000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
010100000000    ? *
010200000000    ? * Set OVERLAY based on last display file processed
010300000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
010400000000 001?C                   Setoff                                       35        OVERLAY OFF
010500000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
010600000000X001?C                   Else                                                   SAME PGM
010700000000 001?C                   Seton                                        35        OVERLAY ON
010800000000E001?C                   Endif                                                  END IF NEW PGM
010900000000    ? *
011000000000    ? * Write message subfile
011100000000    ?C                   Seton                                        30        SFLMSG DISPLAY
011200980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
011300000000    ? *
011400000000    ? * Write display panels
011500980218    ? *
011600980323B001?C     WWDSP         Ifeq      1
011700980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
011800980323E001?C                   Endif
011900980323    ? *
012000000000    ?C                   Endsr                                                  END DSP DSP
012100000000    ? *___________________________________________________________________
012200000000    ? * Build function key information
012300000000    ? *___________________________________________________________________
012400000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
012500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
012600991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
012700000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
012800000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
012900000000    ?C                   Parm                    WAD                            FNC DESC
013000991108    ?C                   Parm                    WWIN                           *IN
013100000000    ?C                   Parm                    WAF                            FNC KEY TABLE
013200000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
013300000000    ? *
013400000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
013500000000    ?C                   Sub       1             WW                             BUMP IDX
013600980312    ? *
013700000000    ?C                   Endsr                                                  END BLD FKY
013800000000    ? *___________________________________________________________________
013900000000    ? * Process function keys
014000000000    ? *___________________________________________________________________
014100000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
014200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
014300991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
014400000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
014500000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
014600000000    ?C                   Parm                    WAD                            FNC DESC
014700991108    ?C                   Parm                    WWIN                           *IN
014800000000    ?C                   Parm                    WAF                            FNC KEY TABLE
014900000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
015000000000    ?C                   Endsr                                                  END PRCFKY
015100000000    ? *___________________________________________________________________
015200000000    ? * Process KEYS function
015300000000    ? *___________________________________________________________________
015400000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
015500000000    ?C                   Z-add     1             WW                             KEY DSC IDX
015600000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
015700000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
015800000000 001? *
015900000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
016000000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
016100000000 002?C                   Z-add     1             WWFKS                          SET TO 1
016200000000E002?C                   Endif                                                  END IF OVER 3
016300000000 001? *
016400000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
016500000000 001?C                   Sub       1             WW                             KEY DESCR IDX
016600000000E001?C                   Enddo                                                  END DO KEYS
016700000000    ? *
016800000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
016900000000    ?C                   Sub       1             WW                             BUMP IDX
017000000000    ? *
017100000000    ?C                   Endsr                                                  END PRCDKY
017200000000    ? *___________________________________________________________________
017300000000    ? * Process RETURN function
017400000000    ? *___________________________________________________________________
017500000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
017600000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
017700000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
017800000000    ?C                   Endsr                                                  END RETURN
017900980311    ? *___________________________________________________________________
018000980311    ? * Process PROMPT function
018100980311    ? *___________________________________________________________________
018200980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
018300980403    ? *
018400980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
018500980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
018600980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
018700980311    ?C                   Mvr                     WSLIN                          CURSOR COL
018800980311    ?C                   Seton                                        37        SET ON CRSLOC
018900980311    ? *
019000980311    ?C                   Endsr                                                  END PRCPMT
019100000000    ? *___________________________________________________________________
019200000000    ? * Process CANCEL function
019300000000    ? *___________________________________________________________________
019400000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
019500000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
019600000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
019700000000    ?C                   Endsr                                                  END PRCCNL
019800000000    ? *___________________________________________________________________
019900000000    ? * Process ROLLUP function
020000000000    ? *___________________________________________________________________
020100000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
020200000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
020300000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
020400000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
020500000000E001?C                   Endif                                                  END IF GT LST PNL
020600000000    ?C                   Endsr                                                  END PRCRUP
020700000000    ? *___________________________________________________________________
020800000000    ? * Process ROLLDOWN function
020900000000    ? *___________________________________________________________________
021000000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
021100000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
021200000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
021300000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
021400000000E001?C                   Endif                                                  END IF LT FST PNL
021500000000    ?C                   Endsr                                                  END PRCRDN
021600000000    ? *___________________________________________________________________
021700000000    ? * Process ENTER function
021800000000    ? *___________________________________________________________________
021900000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
022000980323    ? *
022100980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
022200980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
022300980415    ? *
022400980415    ? * SET RETURN PARMS
022500010221B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
022600980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
022700980323 001?C                   Move      'END'         WWSTT                          END PROMPT
022800980430E001?C                   Endif                                                  END RAM
022900980430    ? *
023000000000    ?C                   Endsr                                                  END PRCENT
023100980402    ? *___________________________________________________________________
023200980402    ? * Check data
023300980402    ? *___________________________________________________________________
023400980402    ?C     CHKDTA        Begsr                                                  Check data
023500980402    ? *
023600980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
023700980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
023800121016    ? *
023900121016    ? * Validate TSA.
024000121016     C     ACCKEY        Klist
024100121016     C                   Kfld                    WSTRS
024200121016     C                   Kfld                    WSSUB
024300121016     C                   Kfld                    WSACT
024400121016     C     ACCKEY        Chain     ACCMST
024500121016     C                   If        not %found(ACCMST)
024600121016    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
024700121016    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
024800121016    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
024900121016     C                   Else
025000121016     C                   Eval      WSDESC = %trim(ACNAM1)
025100990329    ? *
025200100106    ? * From Date Must be valid.
025300130814     C**                 movel     WSDAT1        Input_Date
025400130814     C**                 Exsr      EDTDAT
025500130814     C**                 If        Output_Error <> *Blanks
025600130814    ?C**                 Movel     WTM(1)        WWMSG                          PASS MESSAGE
025700130814    ?C**                 Exsr      SNDMSG                                       SEND MESSAGE
025800130814    ?C**                 Move      'ERROR   '    WWRTN                          RETURN ERROR
025900130814    ?C**                 Else                                                   END ERROR
026000100106    ? * To Date Must be valid.
026100130814     C**                 movel     WSDAT2        Input_Date
026200130814     C**                 Exsr      EDTDAT
026300130814     C**                 If        Output_Error <> *Blanks
026400130814    ?C**                 Movel     WTM(2)        WWMSG                          PASS MESSAGE
026500130814    ?C**                 Exsr      SNDMSG                                       SEND MESSAGE
026600130814    ?C**                 Move      'ERROR   '    WWRTN                          RETURN ERROR
026700130814    ?C**                 End                                                    END ERROR
026800130814    ?C**                 End                                                    END ERROR
026900130814     C                   End
027000010131    ? *
027100980415    ? * WWCNT is for Enter Key control (x2)
027200010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
027300010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
027400010131    ?C                   Add       1             WWCNT                          INC COUNT
027500010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
027600010131    ?C                   Else                                                   ELSE
027700010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
027800010131    ?C                   Endif                                                  ENDIF
027900980402    ? *
028000980402    ?C                   Endsr                                                  END SND MSG
028100010220    ? *___________________________________________________________________
028200010220    ? * format Date edit
028300010220    ? *___________________________________________________________________
028400010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
028500010220     C                   movel     'MMDDYYYY'    Input_Format
028600010220     C                   Call      'FMTDATE'
028700010220     C                   Parm                    Input_Date       32
028800010220     C                   Parm                    Input_Format     32
028900010220     C                   Parm                    Output_Format    32
029000010220     C                   Parm                    Output_Date      32
029100010220     C                   Parm                    Output_Error     10
029200010220    ?C                   Endsr                                                  END DLT RQST
029300000000    ? *___________________________________________________________________
029400000000    ? * Send message
029500000000    ? *___________________________________________________________________
029600000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
029700000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
029800000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
029900000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
030000000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
030100000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
030200000000    ?C                   Endsr                                                  END SND MSG
030300000000    ? *___________________________________________________________________
030400000000    ? * Parameter lists
030500000000    ? *___________________________________________________________________
030600000000    ?C     PLIST         Begsr                                                  PARM LISTS
030700000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
030800000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
030900000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
031000000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
031100000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
031200121016    ?C                   Parm                    WOTRS             3            PMT - OUT   R
031300121016    ?C                   Parm                    WOSUB             3            PMT - OUT   R
031400121016    ?C                   Parm                    WOACT             4            PMT - OUT   R
031500130620    ?C                   Parm                    WODAT1            8            PMT - OUT   R
031600130620    ?C                   Parm                    WODAT2            8            PMT - OUT   R
031700000000    ?C                   Endsr                                                  END PLIST
031800000000    ? *___________________________________________________________________
031900000000    ? * Initialize routine
032000000000    ? *___________________________________________________________________
032100000000    ?C     *INZSR        Begsr                                                  INITIALIZE
032200000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
032300121016    ?C                   Movel     '        '    WWFIL                          FILE NAME-NOTES
032400000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
032500000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
032600000000    ?C                   Endsr                                                  END *INZSR
032700000000    ? *___________________________________________________________________
032800000000    ? * Define  routine
032900000000    ? *___________________________________________________________________
033000000000    ?C     DEFN          Begsr                                                  Define Fields
033100980311    ? *
033200980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
033300980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
033400980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
033500980311    ? *
033600000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
033700000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
033800000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
033900000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
034000000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
034100000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
034200000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
034300000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
034400000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
034500000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
034600000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
034700000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
034800000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
034900000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
035000000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
035100980312    ? *
035200980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
035300980312    ? *
035400000000    ?C                   Endsr                                                  END DEFN
035500000000    ? *___________________________________________________________________
035600000000    ? * Program error handler
035700000000    ? *___________________________________________________________________
035800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
035900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
036000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
036100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
036200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
036300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
036400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
036500980312    ? *
036600991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03670000000012CANCEL  F12=Cancel
03680098032425ROLLUP
03690098032426ROLLDOWN
037000980312** WTM
03710010010661From Date is invalid.
03720012101662To Date is invalid.
03730012101663Account is invalid.
