000100000000    ? *_________________________________________________________________________
000200010220    ? *
000300010220    ? *  Print Internal Sales Commission Report
000400010220    ? *
000500010131    ? *  (c)Copyright 2001 by Inovative Outsourcing, Inc.
000600000000    ? *  This document contains restricted materials of IO, Inc.
000700000000    ? *_________________________________________________________________________
000800010220    ?FISCSMN    IF   E           K DISK
000900041015    ?FISCRPT    UF   E           K DISK
001000010221    ?FAGENCY    IF   E           K DISK
001100010221    ?FISCAGY    IF   E           K DISK
001200010220    ?FPMTISCD   CF   E             WORKSTN
001300000000    ?F                                     INFDS(DSPD)
001400000000    ? *_________________________________________________________________________
001500000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001600000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001700010223    ?D WTM             S             80    DIM(6) CTDATA PERRCD(1)              PANEL MESSAGES
001800051219    ?D WAG             S              4    DIM(999)                             PANEL MESSAGES
001900000000    ? *_________________________________________________________________________
002000000000    ? * Program status data structure
002100991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002200000000    ? *
002300000000    ? * Display file data structure
002400991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002500000000    ? *
002600010220    ?D WDSMAN        E DS                  EXTNAME(ISCSMN)
002700980311    ? *
002800991116    ? * Screen Date
002900991116    ?D                 DS                  INZ
003000991116    ?D  WSDATE                 1      6  0
003100991116    ?D  WDMON                  1      2  0
003200010220    ?D  WDYER                  3      6  0
003300991116    ? *
003400010220    ? * Work Date
003500010220    ?D                 DS                  INZ
003600010220    ?D  WWDATE                 1      8  0
003700010220    ?D  WwMON                  1      2  0
003800010220    ?D  WwDAY                  3      4  0
003900010220    ?D  WwYER                  5      8  0
004000991116    ? * Output Date
004100991116    ?D                 DS                  INZ
004200991116    ?D  WODATE                 1      8  0
004300980311    ? *
004400980311    ? * CURSOR LOCATION
004500980311    ?D                 DS
004600980311    ?D  WWCRSL                 1      2
004700980311    ?D  WWCRSN                 1      2B 0
004800000000    ? *_________________________________________________________________________
004900000000    ? * Process display panel
005000000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005100000000    ? *
005200000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005300000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
005400000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
005500000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005600000000 001? *
005700000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
005800000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
005900980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
006000000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
006100980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
006200980312 001? *
006300000000 001?C                   Endcs                                                  END CASE
006400000000 001? *
006500000000E001?C                   Enddo                                                  END DOWHILE
006600041015     C                   If        WIRQS = 'GENERATE'  and
006700041015B001?C                             WWRTN = *BLANKS     and                      NO ERRORS
006800041015     C                             WODATE <> 0
006900041015     C     WODATE        Setll     ISCRPT
007000041015     C     WODATE        Reade     ISCRPT
007100041015     C                   Dow       not %eof(ISCRPT)
007200041015     C                   Delete    ISCRPTR
007300041015     C     WODATE        Reade     ISCRPT
007400041015     C                   Enddo
007500041015     C                   End
007600980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
007700000000    ? *___________________________________________________________________
007800000000    ? * Prepare display panel
007900000000    ? *___________________________________________________________________
008000000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008100000000    ? *
008200000000    ? * Initialize variables
008300000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
008400000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
008500000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
008600000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
008700000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
008800000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
008900000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
009000000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
009100980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
009200991108    ? *
009300010226     C                   Select
009400010226     C                   When      WIRQS    =    'SALESMAN'
009500010223     C                   Move      *On           *IN38
009600010226     C                   When      WIRQS    =    'MANAGER '
009700010226     C                   Move      *On           *IN38
009800010226     C                   When      WIRQS    =    'GENERATE'
009900010223     C                   Move      *Off          *IN38
010000090122     C                   Movel     '999'         WSSMAN
010100010223     C                   End
010200010223    ? *
010300000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
010400991108    ? *
010500000000    ?C                   Endsr                                                  END PRPPNL
010600000000    ? *___________________________________________________________________
010700000000    ? * Receive messages
010800000000    ? *___________________________________________________________________
010900000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
011000000000    ?C                   Movea     *IN           WWIN                           INDICATORS
011100000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
011200980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
011300000000    ?C                   Parm                    WWIN                           INDICATORS
011400000000    ?C                   Parm                    WWRTN             8            RETURN CODE
011500000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
011600000000    ?C                   Endsr                                                  END RCV MSG
011700000000    ? *___________________________________________________________________
011800000000    ? * Display the display panel
011900000000    ? *___________________________________________________________________
012000000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
012100000000    ? *
012200000000    ? * Set OVERLAY based on last display file processed
012300000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
012400000000 001?C                   Setoff                                       35        OVERLAY OFF
012500000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
012600000000X001?C                   Else                                                   SAME PGM
012700000000 001?C                   Seton                                        35        OVERLAY ON
012800000000E001?C                   Endif                                                  END IF NEW PGM
012900000000    ? *
013000000000    ? * Write message subfile
013100000000    ?C                   Seton                                        30        SFLMSG DISPLAY
013200980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
013300000000    ? *
013400000000    ? * Write display panels
013500980218    ? *
013600980323B001?C     WWDSP         Ifeq      1
013700980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
013800980323E001?C                   Endif
013900980323    ? *
014000000000    ?C                   Endsr                                                  END DSP DSP
014100000000    ? *___________________________________________________________________
014200000000    ? * Build function key information
014300000000    ? *___________________________________________________________________
014400000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
014500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
014600991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
014700000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
014800000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
014900000000    ?C                   Parm                    WAD                            FNC DESC
015000991108    ?C                   Parm                    WWIN                           *IN
015100000000    ?C                   Parm                    WAF                            FNC KEY TABLE
015200000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
015300000000    ? *
015400000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
015500000000    ?C                   Sub       1             WW                             BUMP IDX
015600980312    ? *
015700000000    ?C                   Endsr                                                  END BLD FKY
015800000000    ? *___________________________________________________________________
015900000000    ? * Process function keys
016000000000    ? *___________________________________________________________________
016100000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
016200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
016300991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
016400000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
016500000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
016600000000    ?C                   Parm                    WAD                            FNC DESC
016700991108    ?C                   Parm                    WWIN                           *IN
016800000000    ?C                   Parm                    WAF                            FNC KEY TABLE
016900000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
017000000000    ?C                   Endsr                                                  END PRCFKY
017100000000    ? *___________________________________________________________________
017200000000    ? * Process KEYS function
017300000000    ? *___________________________________________________________________
017400000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
017500000000    ?C                   Z-add     1             WW                             KEY DSC IDX
017600000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
017700000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
017800000000 001? *
017900000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
018000000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
018100000000 002?C                   Z-add     1             WWFKS                          SET TO 1
018200000000E002?C                   Endif                                                  END IF OVER 3
018300000000 001? *
018400000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
018500000000 001?C                   Sub       1             WW                             KEY DESCR IDX
018600000000E001?C                   Enddo                                                  END DO KEYS
018700000000    ? *
018800000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
018900000000    ?C                   Sub       1             WW                             BUMP IDX
019000000000    ? *
019100000000    ?C                   Endsr                                                  END PRCDKY
019200000000    ? *___________________________________________________________________
019300000000    ? * Process RETURN function
019400000000    ? *___________________________________________________________________
019500000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
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
020700010220B001?C     WSFLD         Ifeq      'WSSMAN '                                    WHERE FIELD NAME
020800010226     C                   If        WIRQS    =    'SALESMAN'
020900010220 001?C                   Call      'SLCSMN  '                                   CALL SELECT PROGRAM
021000980403 001?C                   Parm                    WWRQS                          REQUEST
021100980403 001?C                   Parm                    WWRTN                          RETURN CODE
021200980403 001?C                   Parm                    WUPGM                          PROGRAM
021300010220 001?C                   Parm                    WDSMAN                         RECORD DS
021400010226     C                   Else
021500010226 001?C                   Call      'SLCSMNM '                                   CALL SELECT PROGRAM
021600010226 001?C                   Parm                    WWRQS                          REQUEST
021700010226 001?C                   Parm                    WWRTN                          RETURN CODE
021800010226 001?C                   Parm                    WUPGM                          PROGRAM
021900010226 001?C                   Parm                    WDSMAN                         RECORD DS
022000010226     C                   End
022100980403B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
022200010220 003?C                   Movel     ISSMAN        WSSMAN                         SET CODE
022300991116E002?C                   Endif
022400991108 001? *
022500991116X001?C                   Else                                                               NAME
022600991108 001?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
022700991108 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
022800991116E001?C                   Endif
022900980403    ? *
023000980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
023100980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
023200980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
023300980311    ?C                   Mvr                     WSLIN                          CURSOR COL
023400980311    ?C                   Seton                                        37        SET ON CRSLOC
023500980311    ? *
023600980311    ?C                   Endsr                                                  END PRCPMT
023700000000    ? *___________________________________________________________________
023800000000    ? * Process CANCEL function
023900000000    ? *___________________________________________________________________
024000000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
024100000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
024200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
024300000000    ?C                   Endsr                                                  END PRCCNL
024400000000    ? *___________________________________________________________________
024500000000    ? * Process ROLLUP function
024600000000    ? *___________________________________________________________________
024700000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
024800000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
024900000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
025000000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
025100000000E001?C                   Endif                                                  END IF GT LST PNL
025200000000    ?C                   Endsr                                                  END PRCRUP
025300000000    ? *___________________________________________________________________
025400000000    ? * Process ROLLDOWN function
025500000000    ? *___________________________________________________________________
025600000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
025700000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
025800000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
025900000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
026000000000E001?C                   Endif                                                  END IF LT FST PNL
026100000000    ?C                   Endsr                                                  END PRCRDN
026200000000    ? *___________________________________________________________________
026300000000    ? * Process ENTER function
026400000000    ? *___________________________________________________________________
026500000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
026600980323    ? *
026700980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
026800980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
026900980415    ? *
027000980415    ? * SET RETURN PARMS
027100980402B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
027200010221    ?C                   Exsr      CHKAGY                                       CHECK DATA
027300010221B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
027400010131 001?C                   Movel     WODATE        WDDATE            8            PMT DATE 1ST
027500010220 001?C                   Eval      WOPMT = WDDATE + WSSMAN                      PMT AGENCY
027600980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
027700980323 001?C                   Move      'END'         WWSTT                          END PROMPT
027800980430E001?C                   Endif                                                  END RAM
027900010221E001?C                   Endif                                                  END RAM
028000980430    ? *
028100000000    ?C                   Endsr                                                  END PRCENT
028200980402    ? *___________________________________________________________________
028300980402    ? * Check data
028400980402    ? *___________________________________________________________________
028500980402    ?C     CHKDTA        Begsr                                                  Check data
028600980402    ? *
028700980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
028800980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
028900990329    ? *
029000991116    ? * Date Must be valid.
029100010220     C                   z-add     wdmon         wwmon
029200010220     C                   z-add     01            wwday
029300010220     C                   z-add     wdyer         wwyer
029400010220     C                   movel     WwDate        Input_Date
029500010220     C                   Exsr      EDTDAT
029600010220     C                   If        Output_Error <> *Blanks
029700010131    ?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
029800010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
029900010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
030000010221    ?C                   Else                                                   END ERROR
030100010221     C     WwDATE        Mult      10000.0001    WODATE
030200010221     C     wodate        Chain     iscrpt
030300010223     C                   If        %Found
030400010223     C                   If        Not *in38
030500010221    ?C                   Movel     WTM(4)        WWMSG                          PASS MESSAGE
030600010221    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
030700041015    ?C*******************Move      'ERROR   '    WWRTN                          RETURN ERROR
030800010223    ?C                   End                                                    END ERROR
030900010223    ?C                   Else                                                   END ERROR
031000010223     C                   If        *in38
031100010223    ?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
031200010223    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
031300010223    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
031400010223    ?C                   End                                                    END ERROR
031500010223    ?C                   End                                                    END ERROR
031600010221    ?C                   End                                                    END ERROR
031700991116    ? *
031800010220    ? * Atleast one Salesman must be selected.
031900010220    ?C     WSSMAN        Ifeq      *BLANKS
032000010131    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
032100010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
032200010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
032300010131    ?C                   Else
032400010131    ? *
032500010220    ? * Must be a valid salesman.
032600010220    ?C     WSSMAN        Ifne      '999'                                        IF ENTERED
032700010220    ?C     WSSMAN        Chain     ISCSMN                             50        VALIDATE
032800010131    ?C     *IN50         Ifeq      *ON                                          NOT FOUND
032900010131    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
033000010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
033100010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
033200010131    ?C                   Endif                                                  END FOUND
033300010131    ?C                   Endif                                                  END ENTERED
033400010131    ?C                   Endif
033500010131    ? *
033600980415    ? * WWCNT is for Enter Key control (x2)
033700010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
033800010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
033900010131    ?C                   Add       1             WWCNT                          INC COUNT
034000010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
034100010131    ?C                   Else                                                   ELSE
034200010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
034300010131    ?C                   Endif                                                  ENDIF
034400980402    ? *
034500980402    ?C                   Endsr                                                  END SND MSG
034600010221    ? *___________________________________________________________________
034700010221    ? * Check Agency
034800010221    ? *___________________________________________________________________
034900010221    ?C     CHKAGY        Begsr                                                  Check data
035000010221    ? *
035100010223     C  N38              Do
035200010221    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
035300010221    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
035400051219     C                   Z-add     1             X                 4 0
035500010221     C     *Loval        Setll     Agency
035600010221     C                   Read      Agency                                 50
035700010221     C     *in50         Doweq     *off
035800010221     C                   If        agtmdt > wodate or
035900010221     C                             agtmdt = 0
036000010221     C     agcode        Chain     iscagy
036100010221     C                   If        Not %Found
036200010221     C                   Movel     agcode        wag(x)
036300010221     C                   add       1             X
036400030623    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
036500010221     C                   End
036600010221     C                   End
036700010221     C                   Read      Agency                                 50
036800010221     C                   Enddo
036900010221    ? *
037000010221    ? * Send Error Message
037100010221    ?C     WWRTN         Ifne      *BLANKS                                      NO ERRORS
037200010221    ?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
037300010221    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
037400010221    ?C                   Movea     WAG           Wtxt78           78            PASS MESSAGE
037500010221     C                   Eval      wwmsg = '00' + wtxt78
037600010221    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
037700010221    ?C                   End                                                    END SND MSG
037800010223     C                   Enddo
037900010221    ? *
038000010221    ?C                   Endsr                                                  END SND MSG
038100010220    ? *___________________________________________________________________
038200010220    ? * format Date edit
038300010220    ? *___________________________________________________________________
038400010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
038500010220     C                   movel     'MMDDYYYY'    Input_Format
038600010220     C                   Call      'FMTDATE'
038700010220     C                   Parm                    Input_Date       32
038800010220     C                   Parm                    Input_Format     32
038900010220     C                   Parm                    Output_Format    32
039000010220     C                   Parm                    Output_Date      32
039100010220     C                   Parm                    Output_Error     10
039200010220    ?C                   Endsr                                                  END DLT RQST
039300000000    ? *___________________________________________________________________
039400000000    ? * Send message
039500000000    ? *___________________________________________________________________
039600000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
039700000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
039800000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
039900000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
040000000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
040100000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
040200000000    ?C                   Endsr                                                  END SND MSG
040300000000    ? *___________________________________________________________________
040400000000    ? * Parameter lists
040500000000    ? *___________________________________________________________________
040600000000    ?C     PLIST         Begsr                                                  PARM LISTS
040700000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
040800000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
040900000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
041000000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
041100000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
041200090122    ?C                   Parm                    WOPMT            20            PMT - OUT   R
041300000000    ?C                   Endsr                                                  END PLIST
041400000000    ? *___________________________________________________________________
041500000000    ? * Initialize routine
041600000000    ? *___________________________________________________________________
041700000000    ?C     *INZSR        Begsr                                                  INITIALIZE
041800000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
041900010220    ?C                   Movel     'ISCSMN  '    WWFIL                          FILE NAME-NOTES
042000000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
042100000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
042200000000    ?C                   Endsr                                                  END *INZSR
042300000000    ? *___________________________________________________________________
042400000000    ? * Define  routine
042500000000    ? *___________________________________________________________________
042600000000    ?C     DEFN          Begsr                                                  Define Fields
042700980311    ? *
042800980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
042900980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
043000980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
043100980311    ? *
043200000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
043300000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
043400000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
043500000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
043600000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
043700000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
043800000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
043900000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
044000000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
044100000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
044200000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
044300000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
044400000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
044500000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
044600000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
044700980312    ? *
044800980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
044900980312    ? *
045000000000    ?C                   Endsr                                                  END DEFN
045100000000    ? *___________________________________________________________________
045200000000    ? * Program error handler
045300000000    ? *___________________________________________________________________
045400000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
045500000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
045600000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
045700000000    ?C                   Parm                    WQSTSC                         STATUS CODE
045800000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
045900000000    ?C                   Parm                    WQMSG                          MESSAGE ID
046000000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
046100980312    ? *
046200991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
04630098031104PROMPT  F4=Prompt
04640000000012CANCEL  F12=Cancel
04650098032425ROLLUP
04660098032426ROLLDOWN
046700980312** WTM
04680098031200The cursor is not in a prompt area.
04690001022060Commission Date must be valid MMYYYY format.
04700001022061Internal Salesman must be valid.
04710001022160Commissions have already been run for this date.
04720001022100ERROR - All Agencies have not been set up.  Review following msg.
04730001022360Commissions have not yet been run for this date.
