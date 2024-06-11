000100090323    ? *_________________________________________________________________________
000200130429    ? *  (c)Copyright 2013 by GBS, Inc.
000300000000    ? *_________________________________________________________________________
000400080215    ?FACCMST    IF   E           K DISK
000500130429    ?FPMTCCCD   CF   E             WORKSTN
000600130429    ?F                                     INFDS(DSPD)
000700000000    ? *_________________________________________________________________________
000800000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
000900000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001000080215    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)              PANEL MESSAGES
001100000000    ? *_________________________________________________________________________
001200120104    ?D WOPMT         e DS                  extname(inqccflgp)
001300080218    ?
001400080808      * Account key
001500080808     D                 DS
001600080808     D  WDACC                  1     10
001700080808     D  WDtrst                 1      3s 0 inz
001800080808     D  WDsub#                 4      6s 0 inz
001900080808     D  WDacct                 7     10s 0 inz
002000080215    ? *
002100000000    ? * Program status data structure
002200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000    ? *
002400000000    ? * Display file data structure
002500991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002600991116    ? *
002700991116    ? * Date data structure
002800991116    ?D DATD          E DS                  EXTNAME(IODATD)
002900000000    ? *
003000080808    ?D WDACCTx       E DS                  EXTNAME(ACCMST)
003100980311    ? *
003200980311    ? * CURSOR LOCATION
003300980311    ?D                 DS
003400980311    ?D  WWCRSL                 1      2
003500980311    ?D  WWCRSN                 1      2B 0
003600000000    ? *_________________________________________________________________________
003700000000    ? * Process display panel
003800120104     C                   Clear                   WOPMT
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
005500120104 001? *
005600120104 001 C     WKACC         Chain     ACCMST
005700120104     C                   If        not %found(ACCMST)
005800120104     C                   Eval      WORTN = 'CANCEL'
005900120104     C                   End
006000120104 001? *
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
007700010524    ? *
007800000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
007900991108    ? *
008000000000    ?C                   Endsr                                                  END PRPPNL
008100000000    ? *___________________________________________________________________
008200000000    ? * Receive messages
008300000000    ? *___________________________________________________________________
008400000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
008500000000    ?C                   Movea     *IN           WWIN                           INDICATORS
008600000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
008700980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
008800000000    ?C                   Parm                    WWIN                           INDICATORS
008900000000    ?C                   Parm                    WWRTN             8            RETURN CODE
009000000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
009100000000    ?C                   Endsr                                                  END RCV MSG
009200000000    ? *___________________________________________________________________
009300000000    ? * Display the display panel
009400000000    ? *___________________________________________________________________
009500000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
009600000000    ? *
009700000000    ? * Set OVERLAY based on last display file processed
009800000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
009900000000 001?C                   Setoff                                       35        OVERLAY OFF
010000000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
010100000000X001?C                   Else                                                   SAME PGM
010200000000 001?C                   Seton                                        35        OVERLAY ON
010300000000E001?C                   Endif                                                  END IF NEW PGM
010400000000    ? *
010500000000    ? * Write message subfile
010600000000    ?C                   Seton                                        30        SFLMSG DISPLAY
010700980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
010800000000    ? *
010900000000    ? * Write display panels
011000980218    ? *
011100980323B001?C     WWDSP         Ifeq      1
011200980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
011300980323E001?C                   Endif
011400980323    ? *
011500000000    ?C                   Endsr                                                  END DSP DSP
011600000000    ? *___________________________________________________________________
011700000000    ? * Build function key information
011800000000    ? *___________________________________________________________________
011900000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
012000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
012100991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
012200000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
012300000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
012400000000    ?C                   Parm                    WAD                            FNC DESC
012500991108    ?C                   Parm                    WWIN                           *IN
012600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
012700000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
012800000000    ? *
012900000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
013000080218     C                   Movel     WAD(WW)       WSFKD2
013100000000    ?C                   Sub       1             WW                             BUMP IDX
013200080218     C                   Movel     WAD(WW)       WSFKD1
013300980312    ? *
013400000000    ?C                   Endsr                                                  END BLD FKY
013500000000    ? *___________________________________________________________________
013600000000    ? * Process function keys
013700000000    ? *___________________________________________________________________
013800000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
013900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
014000991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
014100000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
014200000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
014300000000    ?C                   Parm                    WAD                            FNC DESC
014400991108    ?C                   Parm                    WWIN                           *IN
014500000000    ?C                   Parm                    WAF                            FNC KEY TABLE
014600000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
014700000000    ?C                   Endsr                                                  END PRCFKY
014800000000    ? *___________________________________________________________________
014900000000    ? * Process KEYS function
015000000000    ? *___________________________________________________________________
015100000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
015200000000    ?C                   Z-add     1             WW                             KEY DSC IDX
015300000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
015400000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
015500000000 001? *
015600000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
015700000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
015800000000 002?C                   Z-add     1             WWFKS                          SET TO 1
015900000000E002?C                   Endif                                                  END IF OVER 3
016000000000 001? *
016100000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
016200000000 001?C                   Sub       1             WW                             KEY DESCR IDX
016300000000E001?C                   Enddo                                                  END DO KEYS
016400000000    ? *
016500000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
016600000000    ?C                   Sub       1             WW                             BUMP IDX
016700080218      *
016800080218     C                   Movel     WAD(WW)       WSFKD1
016900080218     C                   Add       1             WW
017000080218     C                   Movel     WAD(WW)       WSFKD2
017100000000    ? *
017200000000    ?C                   Endsr                                                  END PRCDKY
017300000000    ? *___________________________________________________________________
017400000000    ? * Process RETURN function
017500000000    ? *___________________________________________________________________
017600000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
017700000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
017800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
017900000000    ?C                   Endsr                                                  END RETURN
018000980311    ? *___________________________________________________________________
018100980311    ? * Process PROMPT function
018200980311    ? *___________________________________________________________________
018300980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
018400980311    ? *
018500980311    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
018600980311    ? *
018700991108    ? * PROMPT MEMBER
018800080215B001?C     WSFLD         Ifeq      'WSXXXXX'                                    WHERE FIELD NAME
018900991116X001?C                   Else                                                               NAME
019000991108 001?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
019100991108 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
019200991116E001?C                   Endif
019300980403    ? *
019400980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
019500980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
019600980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
019700980311    ?C                   Mvr                     WSLIN                          CURSOR COL
019800980311    ?C                   Seton                                        37        SET ON CRSLOC
019900980311    ? *
020000980311    ?C                   Endsr                                                  END PRCPMT
020100000000    ? *___________________________________________________________________
020200000000    ? * Process CANCEL function
020300000000    ? *___________________________________________________________________
020400000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
020500000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
020600000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
020700000000    ?C                   Endsr                                                  END PRCCNL
020800000000    ? *___________________________________________________________________
020900000000    ? * Process ROLLUP function
021000000000    ? *___________________________________________________________________
021100000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
021200000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
021300000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
021400000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
021500000000E001?C                   Endif                                                  END IF GT LST PNL
021600000000    ?C                   Endsr                                                  END PRCRUP
021700000000    ? *___________________________________________________________________
021800000000    ? * Process ROLLDOWN function
021900000000    ? *___________________________________________________________________
022000000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
022100000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
022200000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
022300000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
022400000000E001?C                   Endif                                                  END IF LT FST PNL
022500000000    ?C                   Endsr                                                  END PRCRDN
022600000000    ? *___________________________________________________________________
022700000000    ? * Process ENTER function
022800000000    ? *___________________________________________________________________
022900000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
023000980323    ? *
023100980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
023200980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
023300980415    ? *
023400980415    ? * SET RETURN PARMS
023500980402B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
023600980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
023700980323 001?C                   Move      'END'         WWSTT                          END PROMPT
023800980430E001?C                   Endif                                                  END RAM
023900980430    ? *
024000000000    ?C                   Endsr                                                  END PRCENT
024100980402    ? *___________________________________________________________________
024200980402    ? * Check data
024300980402    ? *___________________________________________________________________
024400980402    ?C     CHKDTA        Begsr                                                  Check data
024500980402    ? *
024600980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
024700980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
024800120104    ? *
024900080808     C                   Z-add     WsTrst        wdTrst
025000080808     C                   Z-add     WsSub#        wdSub#
025100080808     C                   Z-add     WsAcct        wdAcct
025200120104    ? *
025300120104     C                   Clear                   WOPMT
025400120104     C                   Z-add     WsTrst        pcTrst
025500120104     C                   Z-add     WsSub#        pcSub#
025600120104     C                   Z-add     WsAcct        pcAcct
025700080811    ? *
025800990329    ? *
025900080808 001 C     wkacc         Klist
026000120104 001 C                   Kfld                    pcTrst
026100120104 001 C                   Kfld                    pcSub#
026200120104 001 C                   Kfld                    pcAcct
026300080808      *
026400080905    ? * Must be valid account.
026500080808 001 C     WKACC         Chain     ACCMST                             50
026600080808B002 C     *IN50         Ifeq      *ON
026700120104 002 C                   Movel     WTM(2)        WWMSG
026800080808 002 C                   Exsr      SNDMSG
026900080808 002 C                   Move      'ERROR   '    WWRTN
027000080808X002 C                   Else
027100080808 002 C                   Clear                   WSNAME
027200080808 002 C                   Movel     ACNAM1        WSNAME
027300080910E002 C                   Endif
027400010131    ? *
027500980415    ? * WWCNT is for Enter Key control (x2)
027600010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
027700010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
027800010131    ?C                   Add       1             WWCNT                          INC COUNT
027900010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
028000010131    ?C                   Else                                                   ELSE
028100010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
028200010131    ?C                   Endif                                                  ENDIF
028300080910    ? * NEVER CONTINUE ON ENTER!!!
028400080910    ?C                   Move      'XXXXXXX'     WWRTN                          RETURN ERROR
028500980402    ? *
028600980402    ?C                   Endsr                                                  END SND MSG
028700000000    ? *___________________________________________________________________
028800000000    ? * Send message
028900000000    ? *___________________________________________________________________
029000000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
029100000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
029200000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
029300000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
029400000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
029500000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
029600000000    ?C                   Endsr                                                  END SND MSG
029700000000    ? *___________________________________________________________________
029800000000    ? * Parameter lists
029900000000    ? *___________________________________________________________________
030000000000    ?C     PLIST         Begsr                                                  PARM LISTS
030100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
030200000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
030300000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
030400000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
030500000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
030600080215    ?C                   Parm                    WOPMT                          PMT - OUT   R
030700000000    ?C                   Endsr                                                  END PLIST
030800000000    ? *___________________________________________________________________
030900000000    ? * Initialize routine
031000000000    ? *___________________________________________________________________
031100000000    ?C     *INZSR        Begsr                                                  INITIALIZE
031200080905     C     *DATE         Mult      10000.0001    Today             8 0
031300000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
031400080215    ?C                   Movel     'ACCMST  '    WWFIL                          FILE NAME-NOTES
031500000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
031600000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
031700000000    ?C                   Endsr                                                  END *INZSR
031800000000    ? *___________________________________________________________________
031900000000    ? * Define  routine
032000000000    ? *___________________________________________________________________
032100000000    ?C     DEFN          Begsr                                                  Define Fields
032200980311    ? *
032300980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
032400980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
032500980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
032600980311    ? *
032700000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
032800000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
032900000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
033000000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
033100000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
033200000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
033300000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
033400000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
033500000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
033600000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
033700000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
033800000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
033900000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
034000000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
034100000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
034200980312    ? *
034300980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
034400980312    ? *
034500000000    ?C                   Endsr                                                  END DEFN
034600000000    ? *___________________________________________________________________
034700000000    ? * Program error handler
034800000000    ? *___________________________________________________________________
034900000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
035000000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
035100000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
035200000000    ?C                   Parm                    WQSTSC                         STATUS CODE
035300000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
035400000000    ?C                   Parm                    WQMSG                          MESSAGE ID
035500000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
035600980312    ? *
035700991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03580008090510EXIT    F10=Continue
03590000000012CANCEL  F12=Cancel
03600098032425ROLLUP
03610098032426ROLLDOWN
036200980312** WTM
03630008080800The cursor is not in a prompt area.
03640012010461Account Number must be valid.
