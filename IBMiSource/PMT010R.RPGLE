000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500010202    ? *  Description:  Merged PHREC into CR130HSP
000600000000    ? *
000700010124    ? *  (c)Copyright 2001 by Inovative Outsourcing, Inc.
000800000000    ? *  This document contains restricted materials of IO, Inc.
001100000000    ? *_________________________________________________________________________
001300010202    ?FPMT010RD  CF   E             WORKSTN
001400000000    ?F                                     INFDS(DSPD)
001500000000    ? *_________________________________________________________________________
001600000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001700000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001800991116    ?D WTM             S             80    DIM(13) CTDATA PERRCD(1)             PANEL MESSAGES
001900000000    ? *_________________________________________________________________________
002000000000    ? * Program status data structure
002100991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002200000000    ? *
002300000000    ? * Display file data structure
002400991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002500991116    ? *
002600991116    ? * Date data structure
002700991116    ?D DATD          E DS                  EXTNAME(IODATD)
003000980311    ? *
003100991116    ? * Screen Date
003200991116    ?D                 DS                  INZ
003300010124    ?D  WSDATE                 1      8  0
003400991116    ?D  WDMON                  1      2  0
003500991116    ?D  WDDAY                  3      4  0
003600010124    ?D  WDYER                  5      8  0
003700991116    ? *
003800991116    ? * Output Date
003900991116    ?D                 DS                  INZ
004000991116    ?D  WODATE                 1      8  0
004100991116    ?D  WOMON                  1      2  0
004200991116    ?D  WODAY                  3      4  0
004300991116    ?D  WOYER                  5      8  0
005800980311    ? *
005900980311    ? * CURSOR LOCATION
006000980311    ?D                 DS
006100980311    ?D  WWCRSL                 1      2
006200980311    ?D  WWCRSN                 1      2B 0
006300000000    ? *_________________________________________________________________________
006400000000    ? * Process display panel
006500000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
006600000000    ? *
006700000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
006800000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
006900000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
007000000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
007100000000 001? *
007200000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
007300000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
007400980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
007500000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
007600980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
007700980312 001? *
007800000000 001?C                   Endcs                                                  END CASE
007900000000 001? *
008000000000E001?C                   Enddo                                                  END DOWHILE
008100980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
008200000000    ? *___________________________________________________________________
008300000000    ? * Prepare display panel
008400000000    ? *___________________________________________________________________
008500000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008600000000    ? *
008700000000    ? * Initialize variables
008800000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
009000000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
009100000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
009200000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
009300000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
009400000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
009500000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
009600980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
009601010124     C                   Move      'N'           latepy
009700991108    ? *
009800000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
009900991108    ? *
010000000000    ?C                   Endsr                                                  END PRPPNL
010100000000    ? *___________________________________________________________________
010200000000    ? * Receive messages
010300000000    ? *___________________________________________________________________
010400000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
010500000000    ?C                   Movea     *IN           WWIN                           INDICATORS
010600000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
010700980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
010800000000    ?C                   Parm                    WWIN                           INDICATORS
010900000000    ?C                   Parm                    WWRTN             8            RETURN CODE
011000000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
011100000000    ?C                   Endsr                                                  END RCV MSG
011200000000    ? *___________________________________________________________________
011300000000    ? * Display the display panel
011400000000    ? *___________________________________________________________________
011500000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
011600000000    ? *
011700000000    ? * Set OVERLAY based on last display file processed
011800000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
011900000000 001?C                   Setoff                                       35        OVERLAY OFF
012000000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
012100000000X001?C                   Else                                                   SAME PGM
012200000000 001?C                   Seton                                        35        OVERLAY ON
012300000000E001?C                   Endif                                                  END IF NEW PGM
012400000000    ? *
012500000000    ? * Write message subfile
012600000000    ?C                   Seton                                        30        SFLMSG DISPLAY
012700980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
012800000000    ? *
012900000000    ? * Write display panels
013000980218    ? *
013100980323B001?C     WWDSP         Ifeq      1
013200980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
013300980323E001?C                   Endif
013400980323    ? *
013500000000    ?C                   Endsr                                                  END DSP DSP
013600000000    ? *___________________________________________________________________
013700000000    ? * Build function key information
013800000000    ? *___________________________________________________________________
013900000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
014000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
014100991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
014200000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
014300000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
014400000000    ?C                   Parm                    WAD                            FNC DESC
014500991108    ?C                   Parm                    WWIN                           *IN
014600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
014700000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
014800000000    ? *
014900000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
015000000000    ?C                   Sub       1             WW                             BUMP IDX
015100980312    ? *
015200000000    ?C                   Endsr                                                  END BLD FKY
015300000000    ? *___________________________________________________________________
015400000000    ? * Process function keys
015500000000    ? *___________________________________________________________________
015600000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
015700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
015800991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
015900000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
016000000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
016100000000    ?C                   Parm                    WAD                            FNC DESC
016200991108    ?C                   Parm                    WWIN                           *IN
016300000000    ?C                   Parm                    WAF                            FNC KEY TABLE
016400000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
016500000000    ?C                   Endsr                                                  END PRCFKY
016600000000    ? *___________________________________________________________________
016700000000    ? * Process KEYS function
016800000000    ? *___________________________________________________________________
016900000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
017000000000    ?C                   Z-add     1             WW                             KEY DSC IDX
017100000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
017200000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
017300000000 001? *
017400000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
017500000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
017600000000 002?C                   Z-add     1             WWFKS                          SET TO 1
017700000000E002?C                   Endif                                                  END IF OVER 3
017800000000 001? *
017900000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
018000000000 001?C                   Sub       1             WW                             KEY DESCR IDX
018100000000E001?C                   Enddo                                                  END DO KEYS
018200000000    ? *
018300000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
018400000000    ?C                   Sub       1             WW                             BUMP IDX
018500000000    ? *
018600000000    ?C                   Endsr                                                  END PRCDKY
018700000000    ? *___________________________________________________________________
018800000000    ? * Process RETURN function
018900000000    ? *___________________________________________________________________
019000000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
019100000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
019200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
019300000000    ?C                   Endsr                                                  END RETURN
019400980311    ? *___________________________________________________________________
019500980311    ? * Process PROMPT function
019600980311    ? *___________________________________________________________________
019700980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
019800980311    ? *
019900980311    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
020000980311    ? *
020100991108    ? * PROMPT MEMBER
020200010124B001?C     WSFLD         Ifeq      'XXXXXXX'                                    WHERE FIELD NAME
024200991116X001?C                   Else                                                               NAME
024300991108 001?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
024400991108 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
024500991116E001?C                   Endif
024600980403    ? *
024700980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
024800980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
024900980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
025000980311    ?C                   Mvr                     WSLIN                          CURSOR COL
025100980311    ?C                   Seton                                        37        SET ON CRSLOC
025200980311    ? *
025300980311    ?C                   Endsr                                                  END PRCPMT
025400000000    ? *___________________________________________________________________
025500000000    ? * Process CANCEL function
025600000000    ? *___________________________________________________________________
025700000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
025800000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
025900000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
026000000000    ?C                   Endsr                                                  END PRCCNL
026100000000    ? *___________________________________________________________________
026200000000    ? * Process ROLLUP function
026300000000    ? *___________________________________________________________________
026400000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
026500000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
026600000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
026700000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
026800000000E001?C                   Endif                                                  END IF GT LST PNL
026900000000    ?C                   Endsr                                                  END PRCRUP
027000000000    ? *___________________________________________________________________
027100000000    ? * Process ROLLDOWN function
027200000000    ? *___________________________________________________________________
027300000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
027400000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
027500000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
027600000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
027700000000E001?C                   Endif                                                  END IF LT FST PNL
027800000000    ?C                   Endsr                                                  END PRCRDN
027900000000    ? *___________________________________________________________________
028000000000    ? * Process ENTER function
028100000000    ? *___________________________________________________________________
028200000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
028300980323    ? *
028400980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
028500980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
028600980415    ? *
028700980415    ? * SET RETURN PARMS
028800980402B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
028900991116 001?C                   Movel     WODATE        WOPMT                          PMT DATE 1ST
029000010124 001?C                   Move      LATEPY        WOPMT                          PMT AGENCY
029100980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
029200980323 001?C                   Move      'END'         WWSTT                          END PROMPT
029300980430E001?C                   Endif                                                  END RAM
029400980430    ? *
029500000000    ?C                   Endsr                                                  END PRCENT
029600980402    ? *___________________________________________________________________
029700980402    ? * Check data
029800980402    ? *___________________________________________________________________
029900980402    ?C     CHKDTA        Begsr                                                  Check data
030000980402    ? *
030100980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
030200980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
030300990329    ? *
030400991116    ? * Date Must be valid.
030500991116    ?C                   Clear                   WODATE                         RESET OUTPUT
030600991116    ?C                   Call      'CHKDAT'                                     CHECK DATE
030700991116    ?C     WOMON         Parm      WDMON         WRM                            6 TO 8
030800991116    ?C     WODAY         Parm      WDDAY         WRD                            6 TO 8
030900991116    ?C     WOYER         Parm      WDYER         WRY                            6 TO 8
031000991116    ?C                   Parm                    WWRTN                          RETURN CODE
031100991116B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
031200991116 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
031300991116 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
031400991116 001?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
031500991116E001?C                   Endif                                                  END ERROR
032300991116 001? *
032400010124 001? * Late Pay Flag must be Y or N.
032500991116 001? * 01
032600010124B002?C     LATEPY        Ifeq      'Y'                                          IF ENTERED
032601010124B002?C     LATEPY        oreq      'N'                                          IF ENTERED
032602010124E003?C                   Else                                                   END FOUND
032900010124 003?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
033000991116 003?C                   Exsr      SNDMSG                                       SEND MESSAGE
033100991116 003?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
033300991116E002?C                   Endif                                                  END ENTERED
041500991116 001? *
041700980415    ? * WWCNT is for Enter Key control (x2)
041800991108B001?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
041900980403 001?C     WWRTN         Andeq     *BLANKS                                      and no error
042000980403 001?C                   Add       1             WWCNT                          INC COUNT
042100980403 001?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
042200980403X001?C                   Else                                                   ELSE
042300980403 001?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
042400980403E001?C                   Endif                                                  ENDIF
042500980402    ? *
042600980402    ?C                   Endsr                                                  END SND MSG
042700000000    ? *___________________________________________________________________
042800000000    ? * Send message
042900000000    ? *___________________________________________________________________
043000000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
043100000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
043200000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
043300000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
043400000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
043500000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
043600000000    ?C                   Endsr                                                  END SND MSG
043700000000    ? *___________________________________________________________________
043800000000    ? * Parameter lists
043900000000    ? *___________________________________________________________________
044000000000    ?C     PLIST         Begsr                                                  PARM LISTS
044100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
044200000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
044300000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
044400000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
044500000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
044600010124    ?C                   Parm                    WOPMT             9            PMT - OUT   R
044700000000    ?C                   Endsr                                                  END PLIST
044800000000    ? *___________________________________________________________________
044900000000    ? * Initialize routine
045000000000    ? *___________________________________________________________________
045100000000    ?C     *INZSR        Begsr                                                  INITIALIZE
045200000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
045300010202    ?C                   Movel     'PHREC   '    WWFIL                          FILE NAME-NOTES
045400000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
045500000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
045600000000    ?C                   Endsr                                                  END *INZSR
045700000000    ? *___________________________________________________________________
045800000000    ? * Define  routine
045900000000    ? *___________________________________________________________________
046000000000    ?C     DEFN          Begsr                                                  Define Fields
046100980311    ? *
046200980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
046300980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
046400980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
046500980311    ? *
046600000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
046700000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
046800000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
046900000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
047000000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
047100000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
047300000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
047400000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
047500000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
047600000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
047700000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
047800000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
047900000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
048000000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
048100980312    ? *
048200980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
048300980312    ? *
048400000000    ?C                   Endsr                                                  END DEFN
048500000000    ? *___________________________________________________________________
048600000000    ? * Program error handler
048700000000    ? *___________________________________________________________________
048800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
048900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
049000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
049100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
049200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
049300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
049400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
049500980312    ? *
049600991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
04980000000012CANCEL  F12=Cancel
04990098032425ROLLUP
05000098032426ROLLDOWN
050100980312** WTM
05020098031200The cursor is not in a prompt area.
05030001012460Commission Date must be valid MMDDYYYY format.
05040001012461Late Pay flag must be Y or N.
