000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300111019    ? *  Description:  Prompt account invoice audit or exclusion maintenance
000400000000    ? *
000500111019    ? *  (c)Copyright 2011 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700111019    ?FPMTABRD   CF   E             WORKSTN
001200000000    ?F                                     INFDS(DSPD)
001300000000    ? *_________________________________________________________________________
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001600111019    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              PANEL MESSAGES
001700000000    ? *_________________________________________________________________________
001800000000    ? * Program status data structure
001900991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002000000000    ? *
002100000000    ? * Display file data structure
002200991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003200980311    ? * CURSOR LOCATION
003300980311    ?D                 DS
003400980311    ?D  WWCRSL                 1      2
003500980311    ?D  WWCRSN                 1      2B 0
003501111019     D  WOPMT          DS
003505111019     D  AUDITREPT              1      1
003506111019     D  EXCLUSION              2      2
004700000000    ? *_________________________________________________________________________
004800000000    ? * Process display panel
004900000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005000000000    ? *
005100000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005200000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005300000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
005400000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005500000000 001? *
005600000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
005700000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
005800980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
005900000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
006000980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
006100980312 001? *
006200000000 001?C                   Endcs                                                  END CASE
006300000000 001? *
006400000000E001?C                   Enddo                                                  END DOWHILE
006500070907    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
006600000000    ? *___________________________________________________________________
006700000000    ? * Prepare display panel
006800000000    ? *___________________________________________________________________
006900000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007000000000    ? *
007100000000    ? * Initialize variables
007200000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
007300000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007400000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007500000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
007600000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
007700000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
007800000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
007900980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
008000991108    ? *
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
018100980311    ? *
018200980311    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
019000980403    ? *
019100980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
019200980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
019300980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
019400980311    ?C                   Mvr                     WSLIN                          CURSOR COL
019500980311    ?C                   Seton                                        37        SET ON CRSLOC
019600980311    ? *
019700980311    ?C                   Endsr                                                  END PRCPMT
019800000000    ? *___________________________________________________________________
019900000000    ? * Process CANCEL function
020000000000    ? *___________________________________________________________________
020100000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
020200000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
020300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
020400000000    ?C                   Endsr                                                  END PRCCNL
020500000000    ? *___________________________________________________________________
020600000000    ? * Process ROLLUP function
020700000000    ? *___________________________________________________________________
020800000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
020900000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
021000000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
021100000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
021200000000E001?C                   Endif                                                  END IF GT LST PNL
021300000000    ?C                   Endsr                                                  END PRCRUP
021400000000    ? *___________________________________________________________________
021500000000    ? * Process ROLLDOWN function
021600000000    ? *___________________________________________________________________
021700000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
021800000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
021900000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
022000000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
022100000000E001?C                   Endif                                                  END IF LT FST PNL
022200000000    ?C                   Endsr                                                  END PRCRDN
022300000000    ? *___________________________________________________________________
022400000000    ? * Process ENTER function
022500000000    ? *___________________________________________________________________
022600000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
022700980323    ? *
022800980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
022900980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
023001081215    ? *
023002111019     C                   If        WWRTN      =  *Blanks
023003111019     C                   If        AUDITREPT  <> *Blanks
023004111019     C                   Return
023005111019     C                   Else
023006111019     C                   Call      'WRKABECL'
023007111019     C                   End
023008111019     C                   End
023009111019     C                   Clear                   WOPMT
023010081215    ? * SET RETURN PARMS
023011081215B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
023012081215 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
023013081215 001?C                   Move      'END'         WWSTT                          END PROMPT
023014081215E001?C                   Endif                                                  END RAM
024200980430    ? *
024300000000    ?C                   Endsr                                                  END PRCENT
024400980402    ? *___________________________________________________________________
024500980402    ? * Check data
024600980402    ? *___________________________________________________________________
024700980402    ?C     CHKDTA        Begsr                                                  Check data
024800980402    ? *
024900980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
025000980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
028500070906
028600111019    ?C                   If        AUDITREPT =   *Blank   And                   END ENTERED
028601111019     C                             EXCLUSION =   *Blank
029000111019    ?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
029100111019    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
029200111019    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
029300111019    ?C                   Endif                                                  END ENTERED
029301111019    ?C                   If        AUDITREPT <>  *Blank   And                   END ENTERED
029302111019     C                             EXCLUSION <>  *Blank
029303111019    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
029304111019    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
029305111019    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
029306111019    ?C                   Endif                                                  END ENTERED
040500991116 001? *
040600980415    ? * WWCNT is for Enter Key control (x2)
040700991108B001?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
040800980403 001?C     WWRTN         Andeq     *BLANKS                                      and no error
040900980403 001?C                   Add       1             WWCNT                          INC COUNT
041000111019 001?C************       Move      'WARNING '    WWRTN                          RETURN ERROR
041100980403X001?C                   Else                                                   ELSE
041200980403 001?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
041300980403E001?C                   Endif                                                  ENDIF
041400980402    ? *
041500980402    ?C                   Endsr                                                  END SND MSG
041600000000    ? *___________________________________________________________________
041700000000    ? * Send message
041800000000    ? *___________________________________________________________________
041900000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
042000000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
042100000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
042200000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
042300000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
042400000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
042500000000    ?C                   Endsr                                                  END SND MSG
042600000000    ? *___________________________________________________________________
042700000000    ? * Parameter lists
042800000000    ? *___________________________________________________________________
042900000000    ?C     PLIST         Begsr                                                  PARM LISTS
043000000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
043100000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
043200000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
043300000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
043400000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
043401111019     C                   Parm                    WOPMT
043800000000    ?C                   Endsr                                                  END PLIST
043900070906      *___________________________________________________________________
044000070906      * Key lists
044100070906      *___________________________________________________________________
044200070906     C     KLIST         Begsr                                                  KEY LISTS
045000070906     C                   Endsr                                                  END KLIST
045100000000    ? *___________________________________________________________________
045200000000    ? * Initialize routine
045300000000    ? *___________________________________________________________________
045400000000    ?C     *INZSR        Begsr                                                  INITIALIZE
045500000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
045600030926    ?C                   Movel     'XXXXXXXX'    WWFIL                          FILE NAME-NOTES
045700000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
045800000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
045900000000    ?C                   Endsr                                                  END *INZSR
046000000000    ? *___________________________________________________________________
046100000000    ? * Define  routine
046200000000    ? *___________________________________________________________________
046300000000    ?C     DEFN          Begsr                                                  Define Fields
046400980311    ? *
046500980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
046600980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
046700980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
046800980311    ? *
046900000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
047000000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
047100000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
047200000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
047300000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
047400000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
047500000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
047600000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
047700000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
047800000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
047900000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
048000000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
048100000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
048200000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
048300980312    ? *
048400980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
048500980312    ? *
048600000000    ?C                   Endsr                                                  END DEFN
048700000000    ? *___________________________________________________________________
048800000000    ? * Program error handler
048900000000    ? *___________________________________________________________________
049000000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
049100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
049200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
049300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
049400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
049500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
049600000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
049700980312    ? *
049800991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
04990000000012CANCEL  F12=Cancel
05000098032425ROLLUP
05010098032426ROLLDOWN
050200980312** WTM
05030098031200The cursor is not in a prompt area.
05040011101901Please make a selection with an X and press Enter.
05050011101902You may only select one option.
