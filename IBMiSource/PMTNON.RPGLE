000100090323    ? *_________________________________________________________________________
000200130429    ? *  (c)Copyright 2013 by GBS, Inc.
000300000000    ? *_________________________________________________________________________
000400140521    ?FACCMST    IF   E           K DISK
000500140521    ?FWEBPAYROLLIF   E           K DISK
000600140521    ?FPMTNOND   CF   E             WORKSTN
000700130429    ?F                                     INFDS(DSPD)
000800000000    ? *_________________________________________________________________________
000900000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001000000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001100080215    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)              PANEL MESSAGES
001200000000    ? *_________________________________________________________________________
001300140521    ?D WOPMT         e DS                  extname(webpaynonp)
001400080218    ?
001500080808      * Account key
001600080808     D                 DS
001700080808     D  WDACC                  1     10
001800080808     D  WDtrst                 1      3s 0 inz
001900080808     D  WDsub#                 4      6s 0 inz
002000080808     D  WDacct                 7     10s 0 inz
002100080215    ? *
002200000000    ? * Program status data structure
002300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002400000000    ? *
002500000000    ? * Display file data structure
002600991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002700991116    ? *
002800991116    ? * Date data structure
002900991116    ?D DATD          E DS                  EXTNAME(IODATD)
003000000000    ? *
003100080808    ?D WDACCTx       E DS                  EXTNAME(ACCMST)
003200980311    ? *
003300980311    ? * CURSOR LOCATION
003400980311    ?D                 DS
003500980311    ?D  WWCRSL                 1      2
003600980311    ?D  WWCRSN                 1      2B 0
003700000000    ? *_________________________________________________________________________
003800000000    ? * Process display panel
003900120104     C                   Clear                   WOPMT
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
005500000000E001?C                   Enddo                                                  END DOWHILE
005600120104 001? *
005700120104 001 C     WKACC         Chain     ACCMST
005800120104     C                   If        not %found(ACCMST)
005900120104     C                   Eval      WORTN = 'CANCEL'
006000120104     C                   End
006100120104 001? *
006200980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
006300000000    ? *___________________________________________________________________
006400000000    ? * Prepare display panel
006500000000    ? *___________________________________________________________________
006600000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
006700000000    ? *
006800000000    ? * Initialize variables
006900000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
007000000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
007100000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007200000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007300000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
007400000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
007500000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
007600000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
007700980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
007800010524    ? *
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
013100080218     C                   Movel     WAD(WW)       WSFKD2
013200000000    ?C                   Sub       1             WW                             BUMP IDX
013300080218     C                   Movel     WAD(WW)       WSFKD1
013400980312    ? *
013500000000    ?C                   Endsr                                                  END BLD FKY
013600000000    ? *___________________________________________________________________
013700000000    ? * Process function keys
013800000000    ? *___________________________________________________________________
013900000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
014000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
014100991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
014200000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
014300000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
014400000000    ?C                   Parm                    WAD                            FNC DESC
014500991108    ?C                   Parm                    WWIN                           *IN
014600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
014700000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
014800000000    ?C                   Endsr                                                  END PRCFKY
014900000000    ? *___________________________________________________________________
015000000000    ? * Process KEYS function
015100000000    ? *___________________________________________________________________
015200000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
015300000000    ?C                   Z-add     1             WW                             KEY DSC IDX
015400000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
015500000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
015600000000 001? *
015700000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
015800000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
015900000000 002?C                   Z-add     1             WWFKS                          SET TO 1
016000000000E002?C                   Endif                                                  END IF OVER 3
016100000000 001? *
016200000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
016300000000 001?C                   Sub       1             WW                             KEY DESCR IDX
016400000000E001?C                   Enddo                                                  END DO KEYS
016500000000    ? *
016600000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
016700000000    ?C                   Sub       1             WW                             BUMP IDX
016800080218      *
016900080218     C                   Movel     WAD(WW)       WSFKD1
017000080218     C                   Add       1             WW
017100080218     C                   Movel     WAD(WW)       WSFKD2
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
018500980311    ? *
018600980311    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
018700980311    ? *
018800991108    ? * PROMPT MEMBER
018900080215B001?C     WSFLD         Ifeq      'WSXXXXX'                                    WHERE FIELD NAME
019000991116X001?C                   Else                                                               NAME
019100991108 001?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
019200991108 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
019300991116E001?C                   Endif
019400980403    ? *
019500980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
019600980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
019700980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
019800980311    ?C                   Mvr                     WSLIN                          CURSOR COL
019900980311    ?C                   Seton                                        37        SET ON CRSLOC
020000980311    ? *
020100980311    ?C                   Endsr                                                  END PRCPMT
020200000000    ? *___________________________________________________________________
020300000000    ? * Process CANCEL function
020400000000    ? *___________________________________________________________________
020500000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
020600000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
020700000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
020800000000    ?C                   Endsr                                                  END PRCCNL
020900000000    ? *___________________________________________________________________
021000000000    ? * Process ROLLUP function
021100000000    ? *___________________________________________________________________
021200000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
021300000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
021400000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
021500000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
021600000000E001?C                   Endif                                                  END IF GT LST PNL
021700000000    ?C                   Endsr                                                  END PRCRUP
021800000000    ? *___________________________________________________________________
021900000000    ? * Process ROLLDOWN function
022000000000    ? *___________________________________________________________________
022100000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
022200000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
022300000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
022400000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
022500000000E001?C                   Endif                                                  END IF LT FST PNL
022600000000    ?C                   Endsr                                                  END PRCRDN
022700000000    ? *___________________________________________________________________
022800000000    ? * Process ENTER function
022900000000    ? *___________________________________________________________________
023000000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
023100980323    ? *
023200980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
023300980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
023400980415    ? *
023500980415    ? * SET RETURN PARMS
023600980402B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
023700980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
023800980323 001?C                   Move      'END'         WWSTT                          END PROMPT
023900980430E001?C                   Endif                                                  END RAM
024000980430    ? *
024100000000    ?C                   Endsr                                                  END PRCENT
024200980402    ? *___________________________________________________________________
024300980402    ? * Check data
024400980402    ? *___________________________________________________________________
024500980402    ?C     CHKDTA        Begsr                                                  Check data
024600980402    ? *
024700980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
024800980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
024900120104    ? *
025000080808     C                   Z-add     WsTrst        wdTrst
025100080808     C                   Z-add     WsSub#        wdSub#
025200080808     C                   Z-add     WsAcct        wdAcct
025300120104    ? *
025400120104     C                   Clear                   WOPMT
025500140521     C                   Z-add     WsTrst        pytrs
025600140521     C                   Z-add     WsSub#        pySub
025700140521     C                   Z-add     WsAcct        pyact
025800080811    ? *
025900990329    ? *
026000080808 001 C     wkacc         Klist
026100140521 001 C                   Kfld                    pyTrs
026200140521 001 C                   Kfld                    pySub
026300140521 001 C                   Kfld                    pyAct
026400080808      *
026500080905    ? * Must be valid account.
026600080808 001 C     WKACC         Chain     ACCMST                             50
026700080808B002 C     *IN50         Ifeq      *ON
026800120104 002 C                   Movel     WTM(2)        WWMSG
026900080808 002 C                   Exsr      SNDMSG
027000080808 002 C                   Move      'ERROR   '    WWRTN
027100080808X002 C                   Else
027200080808 002 C                   Clear                   WSNAME
027300080808 002 C                   Movel     ACNAM1        WSNAME
027400080910E002 C                   Endif
027500140521      *
027600140521    ? * Must be valid non-payroll account
027700140521 001 C     WKACC         Chain     WEBPAYROLL
027800140521B002 C                   If        %found(WEBPAYROLL)
027900140521 002 C                   Movel     WTM(3)        WWMSG
028000140521 002 C                   Exsr      SNDMSG
028100140521 002 C                   Move      'ERROR   '    WWRTN
028200140521E002 C                   End
028300010131    ? *
028400980415    ? * WWCNT is for Enter Key control (x2)
028500010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
028600010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
028700010131    ?C                   Add       1             WWCNT                          INC COUNT
028800010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
028900010131    ?C                   Else                                                   ELSE
029000010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
029100010131    ?C                   Endif                                                  ENDIF
029200080910    ? * NEVER CONTINUE ON ENTER!!!
029300080910    ?C                   Move      'XXXXXXX'     WWRTN                          RETURN ERROR
029400980402    ? *
029500980402    ?C                   Endsr                                                  END SND MSG
029600000000    ? *___________________________________________________________________
029700000000    ? * Send message
029800000000    ? *___________________________________________________________________
029900000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
030000000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
030100000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
030200000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
030300000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
030400000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
030500000000    ?C                   Endsr                                                  END SND MSG
030600000000    ? *___________________________________________________________________
030700000000    ? * Parameter lists
030800000000    ? *___________________________________________________________________
030900000000    ?C     PLIST         Begsr                                                  PARM LISTS
031000000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
031100000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
031200000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
031300000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
031400000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
031500080215    ?C                   Parm                    WOPMT                          PMT - OUT   R
031600000000    ?C                   Endsr                                                  END PLIST
031700000000    ? *___________________________________________________________________
031800000000    ? * Initialize routine
031900000000    ? *___________________________________________________________________
032000000000    ?C     *INZSR        Begsr                                                  INITIALIZE
032100080905     C     *DATE         Mult      10000.0001    Today             8 0
032200000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
032300080215    ?C                   Movel     'ACCMST  '    WWFIL                          FILE NAME-NOTES
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
03670008090510EXIT    F10=Continue
03680000000012CANCEL  F12=Cancel
03690098032425ROLLUP
03700098032426ROLLDOWN
037100980312** WTM
03720008080800The cursor is not in a prompt area.
03730014052161Account Number must be valid.
03740014052162Non-Payroll Accounts only.
