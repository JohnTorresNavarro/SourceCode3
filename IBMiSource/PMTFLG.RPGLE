000100000000    ? *_________________________________________________________________________
000200100106    ? *
000300010220    ? *
000400121016    ? *  (c)Copyright 2012 by GBS, Inc.
000500000000    ? *_________________________________________________________________________
000600130108    ?FPMTFLGD   CF   E             WORKSTN
000700000000    ?F                                     INFDS(DSPD)
000800130122     FMEMBER    If   e           k Disk
000900130122     FDEPNDC    If   e           k Disk
001000000000    ? *_________________________________________________________________________
001100000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001300130122    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
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
005700130108     C                   Move      WSSSN         WOSSN
005800130108     C                   Move      WSSEQ         WOSEQ
005900100106     C     WSDAT1        Mult      10000.0001    WXDAT1
006000100106     C                   Move      WXDAT1        WODAT1
006100100106
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
007800010223     C                   Move      *On           *IN38
007900130122     C                   Eval      WSSGRP = '0001'
008000010223    ? *
008100000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
008200991108    ? *
008300000000    ?C                   Endsr                                                  END PRPPNL
008400000000    ? *___________________________________________________________________
008500000000    ? * Receive messages
008600000000    ? *___________________________________________________________________
008700000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
008800000000    ?C                   Movea     *IN           WWIN                           INDICATORS
008900000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
009000980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
009100000000    ?C                   Parm                    WWIN                           INDICATORS
009200000000    ?C                   Parm                    WWRTN             8            RETURN CODE
009300000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
009400000000    ?C                   Endsr                                                  END RCV MSG
009500000000    ? *___________________________________________________________________
009600000000    ? * Display the display panel
009700000000    ? *___________________________________________________________________
009800000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
009900000000    ? *
010000000000    ? * Set OVERLAY based on last display file processed
010100000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
010200000000 001?C                   Setoff                                       35        OVERLAY OFF
010300000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
010400000000X001?C                   Else                                                   SAME PGM
010500000000 001?C                   Seton                                        35        OVERLAY ON
010600000000E001?C                   Endif                                                  END IF NEW PGM
010700000000    ? *
010800000000    ? * Write message subfile
010900000000    ?C                   Seton                                        30        SFLMSG DISPLAY
011000980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
011100000000    ? *
011200000000    ? * Write display panels
011300980218    ? *
011400980323B001?C     WWDSP         Ifeq      1
011500980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
011600980323E001?C                   Endif
011700980323    ? *
011800000000    ?C                   Endsr                                                  END DSP DSP
011900000000    ? *___________________________________________________________________
012000000000    ? * Build function key information
012100000000    ? *___________________________________________________________________
012200000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
012300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
012400991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
012500000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
012600000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
012700000000    ?C                   Parm                    WAD                            FNC DESC
012800991108    ?C                   Parm                    WWIN                           *IN
012900000000    ?C                   Parm                    WAF                            FNC KEY TABLE
013000000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
013100000000    ? *
013200000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
013300000000    ?C                   Sub       1             WW                             BUMP IDX
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
016800000000    ? *
016900000000    ?C                   Endsr                                                  END PRCDKY
017000000000    ? *___________________________________________________________________
017100000000    ? * Process RETURN function
017200000000    ? *___________________________________________________________________
017300000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
017400000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
017500000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
017600000000    ?C                   Endsr                                                  END RETURN
017700980311    ? *___________________________________________________________________
017800980311    ? * Process PROMPT function
017900980311    ? *___________________________________________________________________
018000980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
018100980403    ? *
018200980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
018300980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
018400980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
018500980311    ?C                   Mvr                     WSLIN                          CURSOR COL
018600980311    ?C                   Seton                                        37        SET ON CRSLOC
018700980311    ? *
018800980311    ?C                   Endsr                                                  END PRCPMT
018900000000    ? *___________________________________________________________________
019000000000    ? * Process CANCEL function
019100000000    ? *___________________________________________________________________
019200000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
019300000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
019400000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
019500000000    ?C                   Endsr                                                  END PRCCNL
019600000000    ? *___________________________________________________________________
019700000000    ? * Process ROLLUP function
019800000000    ? *___________________________________________________________________
019900000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
020000000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
020100000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
020200000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
020300000000E001?C                   Endif                                                  END IF GT LST PNL
020400000000    ?C                   Endsr                                                  END PRCRUP
020500000000    ? *___________________________________________________________________
020600000000    ? * Process ROLLDOWN function
020700000000    ? *___________________________________________________________________
020800000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
020900000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
021000000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
021100000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
021200000000E001?C                   Endif                                                  END IF LT FST PNL
021300000000    ?C                   Endsr                                                  END PRCRDN
021400000000    ? *___________________________________________________________________
021500000000    ? * Process ENTER function
021600000000    ? *___________________________________________________________________
021700000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
021800980323    ? *
021900980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
022000980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
022100980415    ? *
022200980415    ? * SET RETURN PARMS
022300130122    ?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
022400130122    ?C***                Move      *BLANKS       WORTN                          RETURN CODE
022500130122    ?C***                Move      'END'         WWSTT                          END PROMPT
022600130122     C                   Move      WSSSN         WOSSN
022700130122     C                   Move      WSSEQ         WOSEQ
022800130122     C     WSDAT1        Mult      10000.0001    WXDAT1
022900130122     C                   Move      WXDAT1        WODAT1
023000130122     C                   Call      'DW311FLUG'
023100130122     C                   Parm                    WOSSN
023200130122     C                   Parm                    WOSEQ
023300130122     C                   Parm                    WSFLG
023400130122     C                   Parm                    WSFLGM
023500130122     C                   Parm                    WSTYPM
023600130122     C                   Parm                    WSFLGR
023700130122     C                   Parm                    WSTYPR
023800130122     C                   Parm                    WSFLGD
023900130122     C                   Parm                    WSTYPD
024000130122     C                   Parm                    WSFLGV
024100130122     C                   Parm                    WSTYPV
024200130122     C                   Parm                    WODAT1
024300130122     C                   Parm                    WSGRP#
024400130122     C                   Parm                    WSSGRP
024500130122    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
024600130122    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
024700130122    ?C                   Endif                                                  END RAM
024800980430    ? *
024900000000    ?C                   Endsr                                                  END PRCENT
025000980402    ? *___________________________________________________________________
025100980402    ? * Check data
025200980402    ? *___________________________________________________________________
025300980402    ?C     CHKDTA        Begsr                                                  Check data
025400980402    ? *
025500980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
025600980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
025700121016    ? *
025800121016    ? * Validate TSA.
025900130122     C     DEPKEY        Klist
026000130122     C                   Kfld                    MBSSNO
026100130122     C                   Kfld                    dpseq#
026200130108     C     MEMKEY        Klist
026300130108     C                   Kfld                    MBSSNO
026400130122     C                   move      wsssn         mbssno
026500130122     C                   move      wsseq         dpseq#
026600130122     C                   eval      wsdesc = *blanks
026700130122     C                   If        dpseq# = 0
026800130108     C     MEMKEY        Chain     MEMBER
026900130108     C                   If        not %found(MEMBER)
027000130108    ?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
027100121016    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
027200121016    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
027300121016     C                   Else
027400130108     C                   Eval      WSDESC = %trim(MFNAME) + ' ' +
027500130108     C                                      %trim(MLNAME)
027600130122     C                   End
027700130122     C                   End
027800130122
027900130122     C                   If        dpseq# <> 0
028000130122     C     DEPKEY        Chain     DEPNDC
028100130122     C                   If        not %found(DEPNDC)
028200130122    ?C                   Movel     WTM(4)        WWMSG                          PASS MESSAGE
028300130122    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
028400130122    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
028500130122     C                   Else
028600130122     C                   Eval      WSDESC = %trim(DFNAME) + ' ' +
028700130122     C                                      %trim(DLNAME)
028800130122     C                   End
028900130122     C                   End
029000990329    ? *
029100100106    ? * From Date Must be valid.
029200130122     C                   If        %trim(WSDESC) <> *blanks
029300100106     C                   movel     WSDAT1        Input_Date
029400010220     C                   Exsr      EDTDAT
029500010220     C                   If        Output_Error <> *Blanks
029600130108    ?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
029700010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
029800010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
029900130108     C                   End
030000121016     C                   End
030100010131    ? *
030200980415    ? * WWCNT is for Enter Key control (x2)
030300010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
030400010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
030500010131    ?C                   Add       1             WWCNT                          INC COUNT
030600010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
030700010131    ?C                   Else                                                   ELSE
030800010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
030900010131    ?C                   Endif                                                  ENDIF
031000980402    ? *
031100980402    ?C                   Endsr                                                  END SND MSG
031200010220    ? *___________________________________________________________________
031300010220    ? * format Date edit
031400010220    ? *___________________________________________________________________
031500010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
031600010220     C                   movel     'MMDDYYYY'    Input_Format
031700010220     C                   Call      'FMTDATE'
031800010220     C                   Parm                    Input_Date       32
031900010220     C                   Parm                    Input_Format     32
032000010220     C                   Parm                    Output_Format    32
032100010220     C                   Parm                    Output_Date      32
032200010220     C                   Parm                    Output_Error     10
032300010220    ?C                   Endsr                                                  END DLT RQST
032400000000    ? *___________________________________________________________________
032500000000    ? * Send message
032600000000    ? *___________________________________________________________________
032700000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
032800000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
032900000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
033000000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
033100000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
033200000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
033300000000    ?C                   Endsr                                                  END SND MSG
033400000000    ? *___________________________________________________________________
033500000000    ? * Parameter lists
033600000000    ? *___________________________________________________________________
033700000000    ?C     PLIST         Begsr                                                  PARM LISTS
033800000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
033900000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
034000000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
034100000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
034200000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
034300130108    ?C                   Parm                    WOSSN             9            PMT - OUT   R
034400130108    ?C                   Parm                    WOSEQ             2            PMT - OUT   R
034500130108    ?C                   Parm                    WSFLG                          PMT - OUT   R
034600130108    ?C                   Parm                    WSFLGM                         PMT - OUT   R
034700130108    ?C                   Parm                    WSTYPM                         PMT - OUT   R
034800130108    ?C                   Parm                    WSFLGR                         PMT - OUT   R
034900130108    ?C                   Parm                    WSTYPR                         PMT - OUT   R
035000130108    ?C                   Parm                    WSFLGD                         PMT - OUT   R
035100130108    ?C                   Parm                    WSTYPD                         PMT - OUT   R
035200130108    ?C                   Parm                    WSFLGV                         PMT - OUT   R
035300130108    ?C                   Parm                    WSTYPV                         PMT - OUT   R
035400100106    ?C                   Parm                    WODAT1            8            PMT - OUT   R
035500130108    ?C                   Parm                    WSGRP#                         PMT - OUT   R
035600130108    ?C                   Parm                    WSSGRP                         PMT - OUT   R
035700000000    ?C                   Endsr                                                  END PLIST
035800000000    ? *___________________________________________________________________
035900000000    ? * Initialize routine
036000000000    ? *___________________________________________________________________
036100000000    ?C     *INZSR        Begsr                                                  INITIALIZE
036200000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
036300121016    ?C                   Movel     '        '    WWFIL                          FILE NAME-NOTES
036400000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
036500000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
036600000000    ?C                   Endsr                                                  END *INZSR
036700000000    ? *___________________________________________________________________
036800000000    ? * Define  routine
036900000000    ? *___________________________________________________________________
037000000000    ?C     DEFN          Begsr                                                  Define Fields
037100980311    ? *
037200980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
037300980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
037400980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
037500980311    ? *
037600000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
037700000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
037800000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
037900000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
038000000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
038100000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
038200000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
038300000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
038400000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
038500000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
038600000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
038700000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
038800000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
038900000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
039000000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
039100980312    ? *
039200980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
039300980312    ? *
039400000000    ?C                   Endsr                                                  END DEFN
039500000000    ? *___________________________________________________________________
039600000000    ? * Program error handler
039700000000    ? *___________________________________________________________________
039800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
039900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
040000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
040100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
040200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
040300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
040400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
040500980312    ? *
040600991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
04070000000012CANCEL  F12=Cancel
04080098032425ROLLUP
04090098032426ROLLDOWN
041000980312** WTM
04110013010861Member not found.
04120013012262Date is invalid.
04130013012200Flag record has been added.
04140013012261Dependent not found.
