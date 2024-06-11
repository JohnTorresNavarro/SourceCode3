000100000000    ? *_________________________________________________________________________
000200010220    ? *
000300020312    ? *  Prompt for Account Invoicing by Trust
000400010220    ? *
000500010131    ? *  (c)Copyright 2001 by Inovative Outsourcing, Inc.
000600000000    ? *  This document contains restricted materials of IO, Inc.
000700101020    ? * 10/19/10 dlk - prevent invoice < 2/1/2000 because of final invoice
000800101020    ? *                conversion issues.
000900191011    ? * 10/11/19 dlk - add F5-lockout for select users only
001000210607    ? * 06/07/21 dlk - add ERICD to allowed users for F5.
001100000000    ? *_________________________________________________________________________
001200020312    ?FPMTAITD   CF   E             WORKSTN
001300000000    ?F                                     INFDS(DSPD)
001400000000    ? *_________________________________________________________________________
001500000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001600000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001700101020    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              PANEL MESSAGES
001800010221    ?D WAG             S              4    DIM(99)                              PANEL MESSAGES
001900000000    ? *_________________________________________________________________________
002000000000    ? * Program status data structure
002100991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002200000000    ? *
002300000000    ? * Display file data structure
002400991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002500980311    ? *
002600991116    ? * Screen Date
002700991116    ?D                 DS                  INZ
002800991116    ?D  WSDATE                 1      6  0
002900991116    ?D  WDMON                  1      2  0
003000010220    ?D  WDYER                  3      6  0
003100991116    ? *
003200020312    ? * Work Date
003300020312    ?D                 DS
003400020312    ?D  WWDATE                 1      8  0
003500010220    ?D  WwMON                  1      2  0
003600020312    ?D  WwDAY                  3      4  0
003700020312    ?D  WwYER                  5      8  0
003800020312    ? *
003900020312    ? * LDA Date
004000020312    ?D                UDS
004100020312    ?D  WODATE                 1      6  0
004200020312    ?D  WOMON                  1      2  0
004300020312    ?D  WOYER                  3      6  0
0044001910110178 D  Luser                 25     34
004500980311    ? *
004600980311    ? * CURSOR LOCATION
004700980311    ?D                 DS
004800980311    ?D  WWCRSL                 1      2
004900980311    ?D  WWCRSN                 1      2B 0
005000000000    ? *_________________________________________________________________________
005100000000    ? * Process display panel
005200000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005300000000    ? *
005400000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005500000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005600000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
005700000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005800000000 001? *
005900000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
006000000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
006100980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
006200000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
006300980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
006400980312 001? *
006500000000 001?C                   Endcs                                                  END CASE
006600000000 001? *
006700000000E001?C                   Enddo                                                  END DOWHILE
006800980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
006900000000    ? *___________________________________________________________________
007000000000    ? * Prepare display panel
007100000000    ? *___________________________________________________________________
007200000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007300000000    ? *
007400000000    ? * Initialize variables
007500000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
007600000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
007700000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007800000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007900000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008000000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
008100000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008200000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
008300980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
008400010223    ? *
008500191011    ? * only show F5-lockout for select users
008600191011     c                   exsr      #f5users
008700191011
008800000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
008900991108    ? *
009000000000    ?C                   Endsr                                                  END PRPPNL
009100191011    ? ***************************************************
009200191011    ? * Valid F5 users (Access to the lockout program)  *
009300191011    ? ***************************************************
009400191011    ?  begsr #f5users;                                                          RECEIVE MSG
009500191011
009600191011       *in55 = *off;
009700191011       if %trim(luser) = 'BRANDONS' or %trim(luser) = 'SHELLY' or
009800210607          %trim(luser) = 'RONM'     or %trim(luser) = 'DLK'    or
009900210607          %trim(luser) = 'ERICD';
010000191011       *in55 = *on;
010100191011       endif;
010200191011
010300191011    ?  endsr;
010400191011
010500000000    ? *___________________________________________________________________
010600000000    ? * Receive messages
010700000000    ? *___________________________________________________________________
010800000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
010900000000    ?C                   Movea     *IN           WWIN                           INDICATORS
011000000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
011100980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
011200000000    ?C                   Parm                    WWIN                           INDICATORS
011300000000    ?C                   Parm                    WWRTN             8            RETURN CODE
011400000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
011500000000    ?C                   Endsr                                                  END RCV MSG
011600000000    ? *___________________________________________________________________
011700000000    ? * Display the display panel
011800000000    ? *___________________________________________________________________
011900000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
012000000000    ? *
012100000000    ? * Set OVERLAY based on last display file processed
012200000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
012300000000 001?C                   Setoff                                       35        OVERLAY OFF
012400000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
012500000000X001?C                   Else                                                   SAME PGM
012600000000 001?C                   Seton                                        35        OVERLAY ON
012700000000E001?C                   Endif                                                  END IF NEW PGM
012800000000    ? *
012900000000    ? * Write message subfile
013000000000    ?C                   Seton                                        30        SFLMSG DISPLAY
013100980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
013200000000    ? *
013300000000    ? * Write display panels
013400980218    ? *
013500980323B001?C     WWDSP         Ifeq      1
013600980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
013700980323E001?C                   Endif
013800980323    ? *
013900000000    ?C                   Endsr                                                  END DSP DSP
014000000000    ? *___________________________________________________________________
014100000000    ? * Build function key information
014200000000    ? *___________________________________________________________________
014300000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
014400991108    ?C                   Movea     *IN           WWIN                           INDICATORS
014500991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
014600000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
014700000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
014800000000    ?C                   Parm                    WAD                            FNC DESC
014900991108    ?C                   Parm                    WWIN                           *IN
015000000000    ?C                   Parm                    WAF                            FNC KEY TABLE
015100000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
015200000000    ? *
015300000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
015400000000    ?C                   Sub       1             WW                             BUMP IDX
015500980312    ? *
015600000000    ?C                   Endsr                                                  END BLD FKY
015700000000    ? *___________________________________________________________________
015800000000    ? * Process function keys
015900000000    ? *___________________________________________________________________
016000000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
016100991108    ?C                   Movea     *IN           WWIN                           INDICATORS
016200991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
016300000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
016400000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
016500000000    ?C                   Parm                    WAD                            FNC DESC
016600991108    ?C                   Parm                    WWIN                           *IN
016700000000    ?C                   Parm                    WAF                            FNC KEY TABLE
016800000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
016900000000    ?C                   Endsr                                                  END PRCFKY
017000000000    ? *___________________________________________________________________
017100000000    ? * Process KEYS function
017200000000    ? *___________________________________________________________________
017300000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
017400000000    ?C                   Z-add     1             WW                             KEY DSC IDX
017500000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
017600000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
017700000000 001? *
017800000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
017900000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
018000000000 002?C                   Z-add     1             WWFKS                          SET TO 1
018100000000E002?C                   Endif                                                  END IF OVER 3
018200000000 001? *
018300000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
018400000000 001?C                   Sub       1             WW                             KEY DESCR IDX
018500000000E001?C                   Enddo                                                  END DO KEYS
018600000000    ? *
018700000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
018800000000    ?C                   Sub       1             WW                             BUMP IDX
018900000000    ? *
019000000000    ?C                   Endsr                                                  END PRCDKY
019100000000    ? *___________________________________________________________________
019200000000    ? * Process RETURN function
019300000000    ? *___________________________________________________________________
019400000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
019500191011
019600000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
019700000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
019800000000    ?C                   Endsr                                                  END RETURN
019900980311    ? *___________________________________________________________________
020000980311    ? * Process PROMPT function
020100980311    ? *___________________________________________________________________
020200980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
020300980311    ? *
020400980311    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
020500980311    ? *
020600991108    ? * PROMPT MEMBER
020700020312B001?C     WSFLD         Ifeq      'XYZ'                                        WHERE FIELD NAME
020800991116X001?C                   Else                                                               NAME
020900991108 001?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
021000991108 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
021100991116E001?C                   Endif
021200980403    ? *
021300980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
021400980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
021500980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
021600980311    ?C                   Mvr                     WSLIN                          CURSOR COL
021700980311    ?C                   Seton                                        37        SET ON CRSLOC
021800980311    ? *
021900980311    ?C                   Endsr                                                  END PRCPMT
022000000000    ? *___________________________________________________________________
022100000000    ? * Process CANCEL function
022200000000    ? *___________________________________________________________________
022300000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
022400000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
022500000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
022600000000    ?C                   Endsr                                                  END PRCCNL
022700000000    ? *___________________________________________________________________
022800000000    ? * Process ROLLUP function
022900000000    ? *___________________________________________________________________
023000000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
023100000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
023200000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
023300000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
023400000000E001?C                   Endif                                                  END IF GT LST PNL
023500000000    ?C                   Endsr                                                  END PRCRUP
023600000000    ? *___________________________________________________________________
023700000000    ? * Process ROLLDOWN function
023800000000    ? *___________________________________________________________________
023900000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
024000000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
024100000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
024200000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
024300000000E001?C                   Endif                                                  END IF LT FST PNL
024400000000    ?C                   Endsr                                                  END PRCRDN
024500000000    ? *___________________________________________________________________
024600000000    ? * Process ENTER function
024700000000    ? *___________________________________________________________________
024800000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
024900980323    ? *
025000191011
025100191011      * F5 - call lockout pgm for valid users
025200191011     c                   if        *in05 and *in55
025300191011     c                   call      'DW080CL'
025400191011     c                   end
025500191011
025600191011
025700980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
025800980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
025900980415    ? *
026000980415    ? * SET RETURN PARMS
026100980402B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
026200980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
026300980323 001?C                   Move      'END'         WWSTT                          END PROMPT
026400010221E001?C                   Endif                                                  END RAM
026500980430    ? *
026600000000    ?C                   Endsr                                                  END PRCENT
026700980402    ? *___________________________________________________________________
026800980402    ? * Check data
026900980402    ? *___________________________________________________________________
027000980402    ?C     CHKDTA        Begsr                                                  Check data
027100980402    ? *
027200980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
027300980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
027400990329    ? *
027500991116    ? * Date Must be valid.
027600010220     C                   z-add     wdmon         wwmon
027700010220     C                   z-add     01            wwday
027800010220     C                   z-add     wdyer         wwyer
027900101019
028000101019    ? * do not allow < 2/1/00
028100101019     C                   movel     wdyer         yearmon           6 0
028200101019     C                   move      wdmon         yearmon
028300101019     c                   if        yearmon < 200002
028400101019    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
028500101019    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
028600101019    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
028700101019     c                   end
028800101019
028900010220     C                   movel     WwDate        Input_Date
029000010220     C                   Exsr      EDTDAT
029100010220     C                   If        Output_Error <> *Blanks
029200010131    ?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
029300010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
029400010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
029500010221    ?C                   Else                                                   END ERROR
029600020312     C                   Eval      WOMON     =   WWMON
029700020312     C                   Eval      WOYER     =   WWYER
029800010221    ?C                   End                                                    END ERROR
029900010131    ? *
030000980415    ? * WWCNT is for Enter Key control (x2)
030100010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
030200010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
030300010131    ?C                   Add       1             WWCNT                          INC COUNT
030400010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
030500010131    ?C                   Else                                                   ELSE
030600010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
030700010131    ?C                   Endif                                                  ENDIF
030800980402    ? *
030900980402    ?C                   Endsr                                                  END SND MSG
031000010220    ? *___________________________________________________________________
031100010220    ? * format Date edit
031200010220    ? *___________________________________________________________________
031300010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
031400010220     C                   movel     'MMDDYYYY'    Input_Format
031500010220     C                   Call      'FMTDATE'
031600010220     C                   Parm                    Input_Date       32
031700010220     C                   Parm                    Input_Format     32
031800010220     C                   Parm                    Output_Format    32
031900010220     C                   Parm                    Output_Date      32
032000010220     C                   Parm                    Output_Error     10
032100010220    ?C                   Endsr                                                  END DLT RQST
032200000000    ? *___________________________________________________________________
032300000000    ? * Send message
032400000000    ? *___________________________________________________________________
032500000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
032600000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
032700000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
032800000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
032900000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
033000000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
033100000000    ?C                   Endsr                                                  END SND MSG
033200000000    ? *___________________________________________________________________
033300000000    ? * Parameter lists
033400000000    ? *___________________________________________________________________
033500000000    ?C     PLIST         Begsr                                                  PARM LISTS
033600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
033700000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
033800000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
033900000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
034000000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
034100010220    ?C                   Parm                    WOPMT            11            PMT - OUT   R
034200000000    ?C                   Endsr                                                  END PLIST
034300000000    ? *___________________________________________________________________
034400000000    ? * Initialize routine
034500000000    ? *___________________________________________________________________
034600000000    ?C     *INZSR        Begsr                                                  INITIALIZE
034700000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
034800020312    ?C                   Movel     'TRSMST  '    WWFIL                          FILE NAME-NOTES
034900000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
035000000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
035100000000    ?C                   Endsr                                                  END *INZSR
035200000000    ? *___________________________________________________________________
035300000000    ? * Define  routine
035400000000    ? *___________________________________________________________________
035500000000    ?C     DEFN          Begsr                                                  Define Fields
035600980311    ? *
035700980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
035800980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
035900980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
036000980311    ? *
036100000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
036200000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
036300000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
036400000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
036500000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
036600000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
036700000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
036800000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
036900000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
037000000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
037100000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
037200000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
037300000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
037400000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
037500000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
037600980312    ? *
037700980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
037800980312    ? *
037900000000    ?C                   Endsr                                                  END DEFN
038000000000    ? *___________________________________________________________________
038100000000    ? * Program error handler
038200000000    ? *___________________________________________________________________
038300000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
038400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
038500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
038600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
038700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
038800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
038900000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
039000980312    ? *
039100991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03920098031104PROMPT  F4=Prompt
03930019101105ENTER   F5=Lockout
03940000000012CANCEL  F12=Cancel
03950098032425ROLLUP
03960098032426ROLLDOWN
039700980312** WTM
03980098031200The cursor is not in a prompt area.
03990002031260Coverage Date must be valid MMYYYY format.
040000101020  Coverage Date must be after 1/2000
