000100090323    ? *_________________________________________________________________________
000200090817    ? *  (c)Copyright 2009 by GBS, Inc.
000300000000    ? *_________________________________________________________________________
000400090917    ?FPMTACRD   CF   E             WORKSTN
000500000000    ?F                                     INFDS(DSPD)
000600090917     FACCACHL2  IF   E           K Disk
000700000000    ? *_________________________________________________________________________
000800000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
000900000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001000080215    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)              PANEL MESSAGES
001100000000    ? *_________________________________________________________________________
001200080808    ?
001300000000    ? * Program status data structure
001400991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001500000000    ? *
001600000000    ? * Display file data structure
001700991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
001800991116    ? *
001900991116    ? * Date data structure
002000991116    ?D DATD          E DS                  EXTNAME(IODATD)
002100980311    ? *
002200980311    ? * CURSOR LOCATION
002300980311    ?D                 DS
002400980311    ?D  WWCRSL                 1      2
002500980311    ?D  WWCRSN                 1      2B 0
002600090903      *
002700090903     D  WOPMT          DS
002800090917     D   Parmlist              1     26
002900090917     D    WSOLRTA              1      9
003000090917     D    WSNERTA             10     18
003100090917     D    WSEDTA              19     26
003200000000    ? *_________________________________________________________________________
003300000000    ? * Process display panel
003400090817     C                   Eval      WSEDT  = 0
003500000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
003600000000    ? *
003700000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
003800000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
003900000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
004000000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004100000000 001? *
004200000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
004300000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
004400980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
004500000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
004600980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
004700980312 001? *
004800000000 001?C                   Endcs                                                  END CASE
004900000000 001? *
005000000000E001?C                   Enddo                                                  END DOWHILE
005100980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
005200000000    ? *___________________________________________________________________
005300000000    ? * Prepare display panel
005400000000    ? *___________________________________________________________________
005500000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
005600000000    ? *
005700000000    ? * Initialize variables
005800000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
005900000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
006000000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
006100000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
006200000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
006300000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
006400000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
006500000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
006600980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
006700010524    ? *
006800000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
006900991108    ? *
007000000000    ?C                   Endsr                                                  END PRPPNL
007100000000    ? *___________________________________________________________________
007200000000    ? * Receive messages
007300000000    ? *___________________________________________________________________
007400000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
007500000000    ?C                   Movea     *IN           WWIN                           INDICATORS
007600000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
007700980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
007800000000    ?C                   Parm                    WWIN                           INDICATORS
007900000000    ?C                   Parm                    WWRTN             8            RETURN CODE
008000000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
008100000000    ?C                   Endsr                                                  END RCV MSG
008200000000    ? *___________________________________________________________________
008300000000    ? * Display the display panel
008400000000    ? *___________________________________________________________________
008500000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
008600000000    ? *
008700000000    ? * Set OVERLAY based on last display file processed
008800000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
008900000000 001?C                   Setoff                                       35        OVERLAY OFF
009000000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
009100000000X001?C                   Else                                                   SAME PGM
009200000000 001?C                   Seton                                        35        OVERLAY ON
009300000000E001?C                   Endif                                                  END IF NEW PGM
009400000000    ? *
009500000000    ? * Write message subfile
009600000000    ?C                   Seton                                        30        SFLMSG DISPLAY
009700980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
009800000000    ? *
009900000000    ? * Write display panels
010000980218    ? *
010100980323B001?C     WWDSP         Ifeq      1
010200980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
010300980323E001?C                   Endif
010400980323    ? *
010500000000    ?C                   Endsr                                                  END DSP DSP
010600000000    ? *___________________________________________________________________
010700000000    ? * Build function key information
010800000000    ? *___________________________________________________________________
010900000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
011000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
011100991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
011200000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
011300000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
011400000000    ?C                   Parm                    WAD                            FNC DESC
011500991108    ?C                   Parm                    WWIN                           *IN
011600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
011700000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
011800000000    ? *
011900000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
012000080218     C                   Movel     WAD(WW)       WSFKD2
012100000000    ?C                   Sub       1             WW                             BUMP IDX
012200080218     C                   Movel     WAD(WW)       WSFKD1
012300980312    ? *
012400000000    ?C                   Endsr                                                  END BLD FKY
012500000000    ? *___________________________________________________________________
012600000000    ? * Process function keys
012700000000    ? *___________________________________________________________________
012800000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
012900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
013000991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
013100000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
013200000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
013300000000    ?C                   Parm                    WAD                            FNC DESC
013400991108    ?C                   Parm                    WWIN                           *IN
013500000000    ?C                   Parm                    WAF                            FNC KEY TABLE
013600000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
013700000000    ?C                   Endsr                                                  END PRCFKY
013800000000    ? *___________________________________________________________________
013900000000    ? * Process KEYS function
014000000000    ? *___________________________________________________________________
014100000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
014200000000    ?C                   Z-add     1             WW                             KEY DSC IDX
014300000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
014400000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
014500000000 001? *
014600000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
014700000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
014800000000 002?C                   Z-add     1             WWFKS                          SET TO 1
014900000000E002?C                   Endif                                                  END IF OVER 3
015000000000 001? *
015100000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
015200000000 001?C                   Sub       1             WW                             KEY DESCR IDX
015300000000E001?C                   Enddo                                                  END DO KEYS
015400000000    ? *
015500000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
015600000000    ?C                   Sub       1             WW                             BUMP IDX
015700080218      *
015800080218     C                   Movel     WAD(WW)       WSFKD1
015900080218     C                   Add       1             WW
016000080218     C                   Movel     WAD(WW)       WSFKD2
016100000000    ? *
016200000000    ?C                   Endsr                                                  END PRCDKY
016300000000    ? *___________________________________________________________________
016400000000    ? * Process RETURN function
016500000000    ? *___________________________________________________________________
016600000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
016700090910     C                   Exsr      CHKDTA
016800090910     C                   IF        WWRTN = *BLANKS
016900000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
017000000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
017100090910     C                   End
017200000000    ?C                   Endsr                                                  END RETURN
017300980311    ? *___________________________________________________________________
017400980311    ? * Process PROMPT function
017500980311    ? *___________________________________________________________________
017600980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
017700980311    ? *
017800980311    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
017900980311    ? *
018000991108    ? * PROMPT MEMBER
018100080215B001?C     WSFLD         Ifeq      'WSXXXXX'                                    WHERE FIELD NAME
018200991116X001?C                   Else                                                               NAME
018300991108 001?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
018400991108 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018500991116E001?C                   Endif
018600980403    ? *
018700980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
018800980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
018900980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
019000980311    ?C                   Mvr                     WSLIN                          CURSOR COL
019100980311    ?C                   Seton                                        37        SET ON CRSLOC
019200980311    ? *
019300980311    ?C                   Endsr                                                  END PRCPMT
019400000000    ? *___________________________________________________________________
019500000000    ? * Process CANCEL function
019600000000    ? *___________________________________________________________________
019700000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
019800000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
019900000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
020000000000    ?C                   Endsr                                                  END PRCCNL
020100000000    ? *___________________________________________________________________
020200000000    ? * Process ROLLUP function
020300000000    ? *___________________________________________________________________
020400000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
020500000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
020600000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
020700000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
020800000000E001?C                   Endif                                                  END IF GT LST PNL
020900000000    ?C                   Endsr                                                  END PRCRUP
021000000000    ? *___________________________________________________________________
021100000000    ? * Process ROLLDOWN function
021200000000    ? *___________________________________________________________________
021300000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
021400000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
021500000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
021600000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
021700000000E001?C                   Endif                                                  END IF LT FST PNL
021800000000    ?C                   Endsr                                                  END PRCRDN
021900000000    ? *___________________________________________________________________
022000000000    ? * Process ENTER function
022100000000    ? *___________________________________________________________________
022200000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
022300980323    ? *
022400980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
022500980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
022600980415    ? *
022700980415    ? * SET RETURN PARMS
022800980402B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
022900980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
023000980323 001?C                   Move      'END'         WWSTT                          END PROMPT
023100980430E001?C                   Endif                                                  END RAM
023200980430    ? *
023300000000    ?C                   Endsr                                                  END PRCENT
023400980402    ? *___________________________________________________________________
023500980402    ? * Check data
023600980402    ? *___________________________________________________________________
023700980402    ?C     CHKDTA        Begsr                                                  Check data
023800980402    ? *
023900980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
024000980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
024100090817    ? *
024200090917    ? * Old Routing# must be in the ACCACH file.
024300010131    ? *
024400090917     C     WSOLRT        Chain     ACCACHL2
024500090917     C                   If        Not %Found(ACCACHL2)
024600090917    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
024700090917    ?C                   Exsr      SNDMSG                                       SEND MSG
024800090917    ?C                   Move      'ERROR   '    WWRTN                          REQUEST ERROR
024801090918     C                   Else
024802090918     C                   Movel     WSOLRT        WSOLRTA
024900090917     C                   Endif
025000090917    ? *
025100090917    ? * New Routing# must be numeric.
025200090917    ? *
025300090917     C                   If        WSNERT  =     *Zeros
025400090917    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
025500090917    ?C                   Exsr      SNDMSG                                       SEND MSG
025600090917    ?C                   Move      'ERROR   '    WWRTN                          REQUEST ERROR
025601090918     C                   Else
025602090918     C                   Movel     WSNERT        WSNERTA
025700090917     C                   Endif
025800090917    ? *
025900090917    ? * Routing# Term Date must be valid.
026000090917     C                   Movel     WSEDT         Input_Date
026100090917     C                   Call      'FMTDATE'
026200090917     C                   Parm                    Input_Date       32
026300090917     C                   Parm      'MMDDYYYY'    Input_Format     32
026400090917     C                   Parm                    Output_Format    32
026500090917     C                   Parm                    Output_Date      32
026600090917     C                   Parm                    Output_Error     10
026700090917     C                   If        Output_Error <> *Blanks
026800091030    ?C                   Movel     WTM(4)        WWMSG                          PASS MESSAGE
026900091030    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
027000091030    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
027001090918    ?C                   Else                                                   ELSE
027002090918     C                   Movel     WSEDT         WSEDTA
027100091030    ?C                   Endif                                                  END ERROR
027101091030    ? *
027102091030    ? * Routing# Term Date must be more recent than any active ACH range w/same routing#
027103091030     C     WSOLRT        Setll     ACCACHL2
027104091030     C     WSOLRT        Reade     ACCACHL2
027105091030     C                   Dow       Not %Eof(ACCACHL2)
027106091030     C     WSEDT         Mult      10000.0001    WSEDTCmp          8 0
027108091030     C                   If        WSEDTCmp <    AHBEDT
027109091030     C                   Movel     WTM(5)        WWMSG
027110091030     C                   Exsr      SNDMSG
027111091030     C                   Move      'ERROR  '     WWRTN
027112091030     C                   Leave
027113091030    ?C                   End                                                    END ERROR
027114091030     C     WSOLRT        Reade     ACCACHL2
027115091030     C                   EndDo
027200090917    ? *
027300090903    ? * WWCNT is for Enter Key control (x2)
027400010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
027500010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
027600010131    ?C                   Add       1             WWCNT                          INC COUNT
027700010131    ?C                   Else                                                   ELSE
027800010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
027900010131    ?C                   Endif                                                  ENDIF
028000980402    ? *
028100980402    ?C                   Endsr                                                  END SND MSG
028200000000    ? *___________________________________________________________________
028300000000    ? * Send message
028400000000    ? *___________________________________________________________________
028500000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
028600000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
028700000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
028800000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
028900000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
029000000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
029100000000    ?C                   Endsr                                                  END SND MSG
029200000000    ? *___________________________________________________________________
029300000000    ? * Parameter lists
029400000000    ? *___________________________________________________________________
029500000000    ?C     PLIST         Begsr                                                  PARM LISTS
029600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
029700000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
029800000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
029900000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
030000000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
030100090903    ?C                   Parm                    WOPMT                          FUNCTIONS VALID
030200000000    ?C                   Endsr                                                  END PLIST
030300090903    ? *___________________________________________________________________
030400090903    ? * Klists
030500090903    ? *___________________________________________________________________
030600090903    ?C     KList         Begsr                                                  INITIALIZE
030700090903      *
030800090903    ?C                   Endsr                                                  END *INZSR
030900000000    ? *___________________________________________________________________
031000000000    ? * Initialize routine
031100000000    ? *___________________________________________________________________
031200000000    ?C     *INZSR        Begsr                                                  INITIALIZE
031300080905     C     *DATE         Mult      10000.0001    Today             8 0
031400000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
031500090917    ?C                   Movel     'ACCACH  '    WWFIL                          FILE NAME-NOTES
031600000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
031700000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
031800000000    ?C                   Endsr                                                  END *INZSR
031900000000    ? *___________________________________________________________________
032000000000    ? * Define  routine
032100000000    ? *___________________________________________________________________
032200000000    ?C     DEFN          Begsr                                                  Define Fields
032300980311    ? *
032400980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
032500980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
032600980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
032700980311    ? *
032800000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
032900000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
033000000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
033100000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
033200000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
033300090917     C     *Like         Define    AHROUT        OLDRT
033400000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
033500000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
033600000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
033700000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
033800000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
033900000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
034000000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
034100000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
034200000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
034300000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
034400980312    ? *
034500980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
034600980312    ? *
034700000000    ?C                   Endsr                                                  END DEFN
034800000000    ? *___________________________________________________________________
034900000000    ? * Program error handler
035000000000    ? *___________________________________________________________________
035100000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
035200000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
035300000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
035400000000    ?C                   Parm                    WQSTSC                         STATUS CODE
035500000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
035600000000    ?C                   Parm                    WQMSG                          MESSAGE ID
035700000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
035800980312    ? *
035900991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03600008090510EXIT    F10=Continue
03610000000012CANCEL  F12=Cancel
03620098032425ROLLUP
03630098032426ROLLDOWN
036400980312** WTM
03650008080800The cursor is not in a prompt area.
03660009091762Old Routing# is not found in the ACH file. Please check the number.
03670009091763New Routing# must be all digits. Please check the number.
03680009091764Routing# Term Date must be a valid date MMDDCCYY.
03690009103065An active ACH range exists with a more recent effective date.
