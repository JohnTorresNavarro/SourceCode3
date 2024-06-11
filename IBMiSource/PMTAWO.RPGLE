000100000000    ? *_________________________________________________________________________
000300080215    ? *  (c)Copyright 2008 by GBS, Inc.
000500000000    ? *_________________________________________________________________________
000600080215    ?FACCMST    IF   E           K DISK
000700080808    ?FPMTAWOD   CF   E             WORKSTN
000800000000    ?F                                     INFDS(DSPD)
000900000000    ? *_________________________________________________________________________
001000000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001100000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001200080215    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)              PANEL MESSAGES
001300000000    ? *_________________________________________________________________________
001301080218    ?D  W0DATE         s              8  0 INZ
001302080808    ?
0013030809050055 D                 DS
001319080811    ?D WOPMT           DS
001320080811     D  WSACCP                 1     10
001321080811     D  WSAmtP                11     19
001322080811     D  WSDateP               20     27
001323080811     D  WSfil                 28     28
001324080218    ?
001325080808      * Account key
001326080808     D                 DS
001327080808     D  WDACC                  1     10
001328080808     D  WDtrst                 1      3s 0 inz
001329080808     D  WDsub#                 4      6s 0 inz
001330080808     D  WDacct                 7     10s 0 inz
001331080813     D  WDamt                 11     19s 2 inz
001332080808     D  WDdate                20     28s 0 inz
001333080215    ? *
001400000000    ? * Program status data structure
001500991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001600000000    ? *
001700000000    ? * Display file data structure
001800991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
001900991116    ? *
002000991116    ? * Date data structure
002100991116    ?D DATD          E DS                  EXTNAME(IODATD)
002200000000    ? *
002201080808    ?D WDACCTx       E DS                  EXTNAME(ACCMST)
003800980311    ? *
003900980311    ? * CURSOR LOCATION
004000980311    ?D                 DS
004100980311    ?D  WWCRSL                 1      2
004200980311    ?D  WWCRSN                 1      2B 0
004300000000    ? *_________________________________________________________________________
004400000000    ? * Process display panel
004401080808     C                   eval      wddate = 0
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
024600980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
024700980323 001?C                   Move      'END'         WWSTT                          END PROMPT
024800980430E001?C                   Endif                                                  END RAM
024900980430    ? *
025000000000    ?C                   Endsr                                                  END PRCENT
025100980402    ? *___________________________________________________________________
025200980402    ? * Check data
025300980402    ? *___________________________________________________________________
025400980402    ?C     CHKDTA        Begsr                                                  Check data
025500980402    ? *
025600980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
025700980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
025701080808     C                   Z-add     WsTrst        wdTrst
025702080808     C                   Z-add     WsSub#        wdSub#
025703080808     C                   Z-add     WsAcct        wdAcct
025704080808     C                   Z-add     WsAmt         wdAmt
025705080808     C                   Movel     WsDatea       wdDate
025706080811    ? *
025800990329    ? *
025802080808 001 C     wkacc         Klist
025803080808 001 C                   Kfld                    WsTrst
025804080808 001 C                   Kfld                    WsSub#
025805080808 001 C                   Kfld                    WsAcct
025806080808      *
025808080905    ? * Must be valid account.
025809080808 001 C     WKACC         Chain     ACCMST                             50
025810080808B002 C     *IN50         Ifeq      *ON
025811080808 002 C                   Movel     WTM(4)        WWMSG
025812080808 002 C                   Exsr      SNDMSG
025813080808 002 C                   Move      'ERROR   '    WWRTN
025814080808X002 C                   Else
025819080811     C                   Movel     WDACC         WSACCP
025820080808 002 C                   Clear                   WSNAME
025821080808 002 C                   Movel     ACNAM1        WSNAME
025823080905      *
025825080905    ? * Must be termed account.
025830080905     C                   If        ATRMDT   =    *Zero    Or
025831080905     C                             ATRMDT   >=   Today
025832080905     C                   Movel     WTM(4)        WWMSG
025833080905     C                   Exsr      SNDMSG
025834080905     C                   Move      'ERROR   '    WWRTN
025839080905     C                   Endif
025842080905      *
025843080905    ? * Must be termed account.
025844080905     C                   If        TOTEMP   =    *Zero
025845080905     C                   Movel     WTM(7)        WWMSG
025846080905     C                   Exsr      SNDMSG
025847080905     C                   Move      'ERROR   '    WWRTN
025851080905     C                   Endif
025854080905      *
025855080811    ? * Writeoff Amount cannot be zero.
025856080811    ?C                   If        WSAMT    <=   *Zeros                         IF LT FIRST PNL
025857080811    ?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
025858080811    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
025859080811    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
025860080811     C                   Else
025861080811     C                   Movel     WDamt         WSAmtP
025862080811    ?C                   Endif                                                  END ERROR
025863080811      *
025864080808    ? * Start Date must be valid.
025865080808     C                   If        WSDATEA  <>   *Zeros
025866080808     C                   Movel     WSDATEA       Input_Date
025867080808     C                   Call      'FMTDATE'
025868080808     C                   Parm                    Input_Date       32
025869080808     C                   Parm      'MMDDYYYY'    Input_Format     32
025870080808     C                   Parm                    Output_Format    32
025871080808     C                   Parm                    Output_Date      32
025872080808     C                   Parm                    Output_Error     10
025873080808     C                   If        Output_Error <> *Blanks
025874080808 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
025875080808 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
025876080808 001?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
025877080808E001?C                   Else                                                   END ERROR
025878080811     C                   Movel     WDdate        WSDateP
025879080808E001?C                   Endif                                                  END ERROR
025880080808     C                   End
025881080808      *
025882080905    ? *
025883080905    ? * Writeoff Amount cannot exceed the Account Balance.
025884080905     C                   Z-add     BAL1          TOTBAL           11 2
025885080905     C                   Add       BAL2          TOTBAL
025886080905     C                   Add       BAL3          TOTBAL
025887080905     C                   Add       BAL4          TOTBAL
025888080905     C                   Add       BAL5          TOTBAL
025889080905     C                   Add       BAL6          TOTBAL
025890080905     C                   Add       BAL7          TOTBAL
025891080905     C                   Add       BAL8          TOTBAL
025892080905     C                   Add       BAL9          TOTBAL
025893080905     C                   Add       BAL10         TOTBAL
025894080905     C                   Add       BAL11         TOTBAL
025895080905     C                   Add       BAL12         TOTBAL
025896080905    ?C                   If        WSAMT    >    TOTBAL                         IF LT FIRST PNL
025897080905    ?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
025898080905    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
025899080905    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
025900080905    ?C                   Endif                                                  END ERROR
025901080910      *
025902080910E002 C                   Endif
030600010131    ? *
030700980415    ? * WWCNT is for Enter Key control (x2)
030800010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
030900010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
031000010131    ?C                   Add       1             WWCNT                          INC COUNT
031100010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
031200010131    ?C                   Else                                                   ELSE
031300010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
031400010131    ?C                   Endif                                                  ENDIF
031401080910    ? * NEVER CONTINUE ON ENTER!!!
031402080910    ?C                   Move      'XXXXXXX'     WWRTN                          RETURN ERROR
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
034101080905     C     *DATE         Mult      10000.0001    Today             8 0
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
03860108090510EXIT    F10=Continue
03880000000012CANCEL  F12=Cancel
03890098032425ROLLUP
03900098032426ROLLDOWN
039100980312** WTM
03920008080800The cursor is not in a prompt area.
039300080808Print by Trust
039400080808Print by Trust, Division
03950008090561Account Number must be valid AND termed.
03960008081162Writeoff Amount must be greater than zero.
03970008080863Writeoff Start Date must be a valid date MMDDCCYY.
03980008090561Account must have members.
03990008090562Writeoff Amount cannot exceed the Account Balance.
