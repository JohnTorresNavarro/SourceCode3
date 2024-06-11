000100090323    ? *_________________________________________________________________________
000200090817    ? *  (c)Copyright 2009 by GBS, Inc.
000300000000    ? *_________________________________________________________________________
000301120703      *                                                                *
000302120703      *                R E V I S I O N    H I S T O R Y                *
000303120703      *  Date                                                          *
000304120703      *  Revised   Initials    Revision                                *
000305120703      *  --------  --------    --------------------------------------  *
000306120703      *  07/03/12    szz       Force the "trusts" parameter to '1'     *
000307120703      *                         meaning Senior Dental trusts only.     *
000308120703    ? *_________________________________________________________________________
000309120703      *                                                                *
000400110911    ?FPMTACPD   CF   E             WORKSTN
000500000000    ?F                                     INFDS(DSPD)
000600000000    ? *_________________________________________________________________________
000700000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
000800000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
000900080215    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)              PANEL MESSAGES
001000000000    ? *_________________________________________________________________________
001100080808    ?
001200000000    ? * Program status data structure
001300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001400000000    ? *
001500000000    ? * Display file data structure
001600991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
001700991116    ? *
001800991116    ? * Date data structure
001900991116    ?D DATD          E DS                  EXTNAME(IODATD)
002000980311    ? *
002100980311    ? * CURSOR LOCATION
002200980311    ?D                 DS
002300980311    ?D  WWCRSL                 1      2
002400980311    ?D  WWCRSN                 1      2B 0
002500090903      *
002600090903     D  WOPMT          DS
002700090903     D   Parmlist              1     25
002800090903     D    WSEDTA               1      8
002900090903     D     EMM                 1      2
003000090903     D     EDD                 3      4
003100090903     D     EYY                 5      8
003200110224     D    WSIMOA               9     10
003201110224     D    WSIYYA              11     14
003202110217     D    WSTRG               17     17
003300000000    ? *_________________________________________________________________________
003400000000    ? * Process display panel
003500090817     C                   Eval      WSEDT  = 0
003600110224     C                   Eval      WSIMO  = 0
003601110224     C                   Eval      WSIYY  = 0
003700000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
003800000000    ? *
003900000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004000000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004100000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
004200000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
004300000000 001? *
004400000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
004500000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
004600980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
004700000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
004800980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
004900980312 001? *
005000000000 001?C                   Endcs                                                  END CASE
005100000000 001? *
005200000000E001?C                   Enddo                                                  END DOWHILE
005300980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
005400000000    ? *___________________________________________________________________
005500000000    ? * Prepare display panel
005600000000    ? *___________________________________________________________________
005700000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
005800000000    ? *
005900000000    ? * Initialize variables
006000000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
006100000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
006200000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
006300000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
006400000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
006500000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
006600000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
006700000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
006800980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
006900010524    ? *
007000000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
007100991108    ? *
007200000000    ?C                   Endsr                                                  END PRPPNL
007300000000    ? *___________________________________________________________________
007400000000    ? * Receive messages
007500000000    ? *___________________________________________________________________
007600000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
007700000000    ?C                   Movea     *IN           WWIN                           INDICATORS
007800000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
007900980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
008000000000    ?C                   Parm                    WWIN                           INDICATORS
008100000000    ?C                   Parm                    WWRTN             8            RETURN CODE
008200000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
008300000000    ?C                   Endsr                                                  END RCV MSG
008400000000    ? *___________________________________________________________________
008500000000    ? * Display the display panel
008600000000    ? *___________________________________________________________________
008700000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
008800000000    ? *
008900000000    ? * Set OVERLAY based on last display file processed
009000000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
009100000000 001?C                   Setoff                                       35        OVERLAY OFF
009200000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
009300000000X001?C                   Else                                                   SAME PGM
009400000000 001?C                   Seton                                        35        OVERLAY ON
009500000000E001?C                   Endif                                                  END IF NEW PGM
009600000000    ? *
009700000000    ? * Write message subfile
009800000000    ?C                   Seton                                        30        SFLMSG DISPLAY
009900980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
010000000000    ? *
010100000000    ? * Write display panels
010200980218    ? *
010300980323B001?C     WWDSP         Ifeq      1
010400980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
010500980323E001?C                   Endif
010600980323    ? *
010700000000    ?C                   Endsr                                                  END DSP DSP
010800000000    ? *___________________________________________________________________
010900000000    ? * Build function key information
011000000000    ? *___________________________________________________________________
011100000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
011200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
011300991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
011400000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
011500000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
011600000000    ?C                   Parm                    WAD                            FNC DESC
011700991108    ?C                   Parm                    WWIN                           *IN
011800000000    ?C                   Parm                    WAF                            FNC KEY TABLE
011900000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
012000000000    ? *
012100000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
012200080218     C                   Movel     WAD(WW)       WSFKD2
012300000000    ?C                   Sub       1             WW                             BUMP IDX
012400080218     C                   Movel     WAD(WW)       WSFKD1
012500980312    ? *
012600000000    ?C                   Endsr                                                  END BLD FKY
012700000000    ? *___________________________________________________________________
012800000000    ? * Process function keys
012900000000    ? *___________________________________________________________________
013000000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
013100991108    ?C                   Movea     *IN           WWIN                           INDICATORS
013200991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
013300000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
013400000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
013500000000    ?C                   Parm                    WAD                            FNC DESC
013600991108    ?C                   Parm                    WWIN                           *IN
013700000000    ?C                   Parm                    WAF                            FNC KEY TABLE
013800000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
013900000000    ?C                   Endsr                                                  END PRCFKY
014000000000    ? *___________________________________________________________________
014100000000    ? * Process KEYS function
014200000000    ? *___________________________________________________________________
014300000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
014400000000    ?C                   Z-add     1             WW                             KEY DSC IDX
014500000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
014600000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
014700000000 001? *
014800000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
014900000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
015000000000 002?C                   Z-add     1             WWFKS                          SET TO 1
015100000000E002?C                   Endif                                                  END IF OVER 3
015200000000 001? *
015300000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
015400000000 001?C                   Sub       1             WW                             KEY DESCR IDX
015500000000E001?C                   Enddo                                                  END DO KEYS
015600000000    ? *
015700000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
015800000000    ?C                   Sub       1             WW                             BUMP IDX
015900080218      *
016000080218     C                   Movel     WAD(WW)       WSFKD1
016100080218     C                   Add       1             WW
016200080218     C                   Movel     WAD(WW)       WSFKD2
016300000000    ? *
016400000000    ?C                   Endsr                                                  END PRCDKY
016500000000    ? *___________________________________________________________________
016600000000    ? * Process RETURN function
016700000000    ? *___________________________________________________________________
016800000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
016900090910     C                   Exsr      CHKDTA
017000090910     C                   IF        WWRTN = *BLANKS
017100000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
017200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
017300090910     C                   End
017400000000    ?C                   Endsr                                                  END RETURN
017500980311    ? *___________________________________________________________________
017600980311    ? * Process PROMPT function
017700980311    ? *___________________________________________________________________
017800980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
017900980311    ? *
018000980311    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
018100980311    ? *
018200991108    ? * PROMPT MEMBER
018300080215B001?C     WSFLD         Ifeq      'WSXXXXX'                                    WHERE FIELD NAME
018400991116X001?C                   Else                                                               NAME
018500991108 001?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
018600991108 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018700991116E001?C                   Endif
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
023000980402B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
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
024300990329    ? *
024400090817    ? * ACH Effective Date must be valid.
024500090817     C                   Movel     WSEDT         Input_Date
024600080808     C                   Call      'FMTDATE'
024700080808     C                   Parm                    Input_Date       32
024800080808     C                   Parm      'MMDDYYYY'    Input_Format     32
024900080808     C                   Parm                    Output_Format    32
025000080808     C                   Parm                    Output_Date      32
025100080808     C                   Parm                    Output_Error     10
025200080808     C                   If        Output_Error <> *Blanks
025300090817 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
025400080808 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
025500080808 001?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
025600080808E001?C                   Else                                                   END ERROR
025700090903     C                   Movel     WSEDT         WSEDTA
025800080808E001?C                   Endif                                                  END ERROR
025900090817    ? *
026000110224    ? * Coverage Month & Year must be valid.
026901110224     C                   If        WSIMO   >     *Zero  And
026902110224     C                             WSIMO   <     13
026903110224     C                   Movel     WSIMO         WSIMOA
026904110224     C                   Movel     WSIYY         WSIYYA
026905110224     C                   Else
026906110224    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
027000110224    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
027100110224    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
027400110224    ?C                   Endif                                                  END ERROR
027401110224
027402110224     C                   If        WSIYY   >     1999   And
027405110224     C                             WSIYY   <     2050
027406110224     C                   Movel     WSIMO         WSIMOA
027407110224     C                   Movel     WSIYY         WSIYYA
027408110224     C                   Else
027409110224    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
027410110224    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
027411110224     C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
027412110224    ?C                   Endif                                                  END ERROR
027413110216    ? *
027414110216    ? * Select 1, 2 or 3 for Trust Group
027415110216     C                   If        WSTRG <> '1' and
027416110216     C                             WSTRG <> '2' and
027417110216     C                             WSTRG <> '3'
027418110216    ?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
027419110216    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
027420110216    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
027421110216    ?C                   Endif                                                  END ERROR
027500010131    ? *
027600090903    ? * Effective (posting) date must be the first of the month.
027700090903    ? *
027800090916     C*****************  If        EDD      <>   '01'
027900090916    ?C****************   Movel     WTM(4)        WWMSG                          PASS MESSAGE
028000090916    ?C****************   Exsr      SNDMSG                                       SEND MESSAGE
028100090916    ?C****************   Move      'ERROR   '    WWRTN                          RETURN ERROR
028200090916    ?C*****************  End                                                    END ERROR
028300090903    ? * WWCNT is for Enter Key control (x2)
028400010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
028500010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
028600010131    ?C                   Add       1             WWCNT                          INC COUNT
028700090910    ?C****               Move      'WARNING '    WWRTN                          RETURN ERROR
028800010131    ?C                   Else                                                   ELSE
028900010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
029000010131    ?C                   Endif                                                  ENDIF
029100080910    ? * NEVER CONTINUE ON ENTER!!!
029200090910    ?C**************     Move      'XXXXXXX'     WWRTN                          RETURN ERROR
029300980402    ? *
029400980402    ?C                   Endsr                                                  END SND MSG
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
031400090903    ?C                   Parm                    WOPMT                          FUNCTIONS VALID
031500000000    ?C                   Endsr                                                  END PLIST
031600090903    ? *___________________________________________________________________
031700090903    ? * Klists
031800090903    ? *___________________________________________________________________
031900090903    ?C     KList         Begsr                                                  INITIALIZE
032000090903    ? *
032100090903      *
032200090903    ?C                   Endsr                                                  END *INZSR
032300000000    ? *___________________________________________________________________
032400000000    ? * Initialize routine
032500000000    ? *___________________________________________________________________
032600000000    ?C     *INZSR        Begsr                                                  INITIALIZE
032601120703     C                   Eval      WSTRG     =   '1'
032700080905     C     *DATE         Mult      10000.0001    Today             8 0
032800000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
032900080215    ?C                   Movel     'ACCMST  '    WWFIL                          FILE NAME-NOTES
033000000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
033100000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
033200000000    ?C                   Endsr                                                  END *INZSR
033300000000    ? *___________________________________________________________________
033400000000    ? * Define  routine
033500000000    ? *___________________________________________________________________
033600000000    ?C     DEFN          Begsr                                                  Define Fields
033700980311    ? *
033800980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
033900980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
034000980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
034100980311    ? *
034200000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
034300000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
034400000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
034500000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
034600000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
034700000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
034800000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
034900000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
035000000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
035100000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
035200000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
035300000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
035400000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
035500000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
035600000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
035700980312    ? *
035800980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
035900980312    ? *
036000000000    ?C                   Endsr                                                  END DEFN
036100000000    ? *___________________________________________________________________
036200000000    ? * Program error handler
036300000000    ? *___________________________________________________________________
036400000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
036500000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
036600000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
036700000000    ?C                   Parm                    WQSTSC                         STATUS CODE
036800000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
036900000000    ?C                   Parm                    WQMSG                          MESSAGE ID
037000000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
037100980312    ? *
037200991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03730008090510EXIT    F10=Continue
03740000000012CANCEL  F12=Cancel
03750098032425ROLLUP
03760098032426ROLLDOWN
037700980312** WTM
03780008080800The cursor is not in a prompt area.
03790009081763ACH Effective Date must be a valid date MMDDCCYY.
03800011022464Coverage Month must be a valid month and year MM CCYY.
03810009090363Effective Date must be the first of the month.
03820011021665Please select 1, 2 or 3 from the list of trust groups.
