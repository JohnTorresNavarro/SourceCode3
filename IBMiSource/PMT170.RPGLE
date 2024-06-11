000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010131    ? *  (c)Copyright 2001 by Inovative Outsourcing, Inc.
000400000000    ? *  This document contains restricted materials of IO, Inc.
000500030630    ? *
000600030630    ? * 06/30/03 dlk - add super agency selection
000601050516    ? * 05/16/05 szz - Add edit/update mode selection
000602080918    ? * 09/16/08 dlk - add deposit date entry for comm report (N55)
000603110419    ? * 04/19/11 dlk - add select for agencies that get paper copy of the
000700110419    ? *                commission report
000701110419    ? *
000800000000    ? *_________________________________________________________________________
000900991116    ?FAGENCY    IF   E           K DISK
001000030630    ?Fsupragcy  IF   E           K DISK
001100010131    ?FPMT170D   CF   E             WORKSTN
001200000000    ?F                                     INFDS(DSPD)
001300000000    ? *_________________________________________________________________________
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500110419    ?D WAD             S             80    DIM(7)                               FUNCTION DESC
001600110419    ?D WTM             S             80    DIM(12) CTDATA PERRCD(1)             PANEL MESSAGES
001700000000    ? *_________________________________________________________________________
001800000000    ? * Program status data structure
001900991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002000000000    ? *
002100000000    ? * Display file data structure
002200991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002300991116    ? *
002400991116    ? * Date data structure
002500991116    ?D DATD          E DS                  EXTNAME(IODATD)
002600000000    ? *
002700991116    ?D WDAGNY        E DS                  EXTNAME(AGENCY)
002800030630    ?D WDsuper       E DS                  EXTNAME(supragcy)
002900980311    ? *
003000991116    ? * Screen Date
003100991116    ?D                 DS                  INZ
003200991116    ?D  WSDATE                 1      6  0
003300991116    ?D  WDMON                  1      2  0
003400991116    ?D  WDDAY                  3      4  0
003500991116    ?D  WDYER                  5      6  0
003600991116    ? *
003700991116    ? * Output Date
003800991116    ?D                 DS                  INZ
003900991116    ?D  WODATE                 1      8  0
004000991116    ?D  WOMON                  1      2  0
004100991116    ?D  WODAY                  3      4  0
004200991116    ?D  WOYER                  5      8  0
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
006600980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
006700000000    ? *___________________________________________________________________
006800000000    ? * Prepare display panel
006900000000    ? *___________________________________________________________________
007000000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007100000000    ? *
007200000000    ? * Initialize variables
007300000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
007400000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
007500000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
007600000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
007700000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
007800000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
007900000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
008000000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
008100980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
008200991108    ? *
008300010524     C                   If        WIRQS  =     'LOAD170'
008400010524     C                   Move      *ON           *IN55
008500010524     C                   End
008600010524    ? *
008700000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
008800991108    ? *
008900000000    ?C                   Endsr                                                  END PRPPNL
009000000000    ? *___________________________________________________________________
009100000000    ? * Receive messages
009200000000    ? *___________________________________________________________________
009300000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
009400000000    ?C                   Movea     *IN           WWIN                           INDICATORS
009500000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
009600980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
009700000000    ?C                   Parm                    WWIN                           INDICATORS
009800000000    ?C                   Parm                    WWRTN             8            RETURN CODE
009900000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
010000000000    ?C                   Endsr                                                  END RCV MSG
010100000000    ? *___________________________________________________________________
010200000000    ? * Display the display panel
010300000000    ? *___________________________________________________________________
010400000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
010500000000    ? *
010600000000    ? * Set OVERLAY based on last display file processed
010700000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
010800000000 001?C                   Setoff                                       35        OVERLAY OFF
010900000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
011000000000X001?C                   Else                                                   SAME PGM
011100000000 001?C                   Seton                                        35        OVERLAY ON
011200000000E001?C                   Endif                                                  END IF NEW PGM
011300000000    ? *
011400000000    ? * Write message subfile
011500000000    ?C                   Seton                                        30        SFLMSG DISPLAY
011600980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
011700000000    ? *
011800000000    ? * Write display panels
011900980218    ? *
012000980323B001?C     WWDSP         Ifeq      1
012100980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
012200980323E001?C                   Endif
012300980323    ? *
012400000000    ?C                   Endsr                                                  END DSP DSP
012500000000    ? *___________________________________________________________________
012600000000    ? * Build function key information
012700000000    ? *___________________________________________________________________
012800000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
012900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
013000991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
013100000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
013200000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
013300000000    ?C                   Parm                    WAD                            FNC DESC
013400991108    ?C                   Parm                    WWIN                           *IN
013500000000    ?C                   Parm                    WAF                            FNC KEY TABLE
013600000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
013700000000    ? *
013800000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
013900000000    ?C                   Sub       1             WW                             BUMP IDX
014000980312    ? *
014100000000    ?C                   Endsr                                                  END BLD FKY
014200000000    ? *___________________________________________________________________
014300000000    ? * Process function keys
014400000000    ? *___________________________________________________________________
014500000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
014600991108    ?C                   Movea     *IN           WWIN                           INDICATORS
014700991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
014800000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
014900000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
015000000000    ?C                   Parm                    WAD                            FNC DESC
015100991108    ?C                   Parm                    WWIN                           *IN
015200000000    ?C                   Parm                    WAF                            FNC KEY TABLE
015300000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
015400000000    ?C                   Endsr                                                  END PRCFKY
015500000000    ? *___________________________________________________________________
015600000000    ? * Process KEYS function
015700000000    ? *___________________________________________________________________
015800000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
015900000000    ?C                   Z-add     1             WW                             KEY DSC IDX
016000000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
016100000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
016200000000 001? *
016300000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
016400000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
016500000000 002?C                   Z-add     1             WWFKS                          SET TO 1
016600000000E002?C                   Endif                                                  END IF OVER 3
016700000000 001? *
016800000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
016900000000 001?C                   Sub       1             WW                             KEY DESCR IDX
017000000000E001?C                   Enddo                                                  END DO KEYS
017100000000    ? *
017200000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
017300000000    ?C                   Sub       1             WW                             BUMP IDX
017400000000    ? *
017500000000    ?C                   Endsr                                                  END PRCDKY
017600000000    ? *___________________________________________________________________
017700000000    ? * Process RETURN function
017800000000    ? *___________________________________________________________________
017900000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
018000000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
018100000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
018200000000    ?C                   Endsr                                                  END RETURN
018300980311    ? *___________________________________________________________________
018400980311    ? * Process PROMPT function
018500980311    ? *___________________________________________________________________
018600980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
018700980311    ? *
018800980311    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
018900980311    ? *
019000991108    ? * PROMPT MEMBER
019001050526     C                   If        WSFLD    =    'WSSUPER'  Or
019002050526     C                             WSFLD    =    'WSAGNY'
019100010131B001?C     WSFLD         Ifeq      'WSAGNY '                                    WHERE FIELD NAME
019200030630 001?C                   Call      'SLCAGNY '                                   CALL SELECT PROGRAM
019300980403 001?C                   Parm                    WWRQS                          REQUEST
019400980403 001?C                   Parm                    WWRTN                          RETURN CODE
019500980403 001?C                   Parm                    WUPGM                          PROGRAM
019600991116 001?C                   Parm                    WDAGNY                         RECORD DS
019700980403B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
019800030630 003?C                   Movel     AGCODE        WSAGNY                         SET CODE
019900991116E002?C                   Endif
020000030630E001?C                   Endif
020100030630
020200030630B001?C     WSFLD         Ifeq      'WSSUPER'                                    WHERE FIELD NAME
020300030630 001?C                   Call      'SLCSUPER'                                   CALL SELECT PROGRAM
020400030630 001?C                   Parm                    WWRQS                          REQUEST
020500030630 001?C                   Parm                    WWRTN                          RETURN CODE
020600030630 001?C                   Parm                    WUPGM                          PROGRAM
020700030630 001?C                   Parm                    WDSUPER                        RECORD DS
020800030630B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
020900030630 003?C                   Movel     sacode        WSsuper                        SET CODE
021000030630E002?C                   Endif
021001050526susi C                   End
021100991116X001?C                   Else                                                               NAME
021200991108 001?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
021300991108 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
021400991116E001?C                   Endif
021500980403    ? *
021600980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
021700980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
021800980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
021900980311    ?C                   Mvr                     WSLIN                          CURSOR COL
022000980311    ?C                   Seton                                        37        SET ON CRSLOC
022100980311    ? *
022200980311    ?C                   Endsr                                                  END PRCPMT
022300000000    ? *___________________________________________________________________
022400000000    ? * Process CANCEL function
022500000000    ? *___________________________________________________________________
022600000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
022700000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
022800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
022900000000    ?C                   Endsr                                                  END PRCCNL
023000000000    ? *___________________________________________________________________
023100000000    ? * Process ROLLUP function
023200000000    ? *___________________________________________________________________
023300000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
023400000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
023500000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
023600000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
023700000000E001?C                   Endif                                                  END IF GT LST PNL
023800000000    ?C                   Endsr                                                  END PRCRUP
023900000000    ? *___________________________________________________________________
024000000000    ? * Process ROLLDOWN function
024100000000    ? *___________________________________________________________________
024200000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
024300000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
024400000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
024500000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
024600000000E001?C                   Endif                                                  END IF LT FST PNL
024700000000    ?C                   Endsr                                                  END PRCRDN
024800000000    ? *___________________________________________________________________
024900000000    ? * Process ENTER function
025000000000    ? *___________________________________________________________________
025100000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
025200980323    ? *
025300980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
025400980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
025500980415    ? *
025600980415    ? * SET RETURN PARMS
025700980402B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
025800010201     C     WODATE        Mult      10000.0001    WODATE
025900010131 001?C                   Movel     WODATE        WDDATE            8            PMT DATE 1ST
026000030630 001?C                   Eval      WOPMT = WDDATE + WSAGNY + WSSORT + WSDUMM +  PMT AGENCY
026100110419 001?C                             WSSUPER + WSEDUP + WSUNPD + wsdddatechar +   PMT AGENCY
026101110419 001?C                             WSpaper
026200980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
026300980323 001?C                   Move      'END'         WWSTT                          END PROMPT
026400980430E001?C                   Endif                                                  END RAM
026500980430    ? *
026600000000    ?C                   Endsr                                                  END PRCENT
026700980402    ? *___________________________________________________________________
026800980402    ? * Check data
026900980402    ? *___________________________________________________________________
027000980402    ?C     CHKDTA        Begsr                                                  Check data
027100980402    ? *
027200980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
027300980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
027302050516    ? *
027303050520    ? * Edit or Update Mode must be selected.
027304050516    ?C     WSEDUP        Ifne      'E'
027305050516    ?C     WSEDUP        andne     'U'
027306050520     C                   Eval      *In65    =    *On
027307050516    ?C                   Movel     WTM(7)        WWMSG                          PASS MESSAGE
027308050516    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
027309050516    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
027310050516    ?C                   End
027400990329    ? *
027500991116    ? * Date Must be valid.
027600991116    ?C                   Clear                   WODATE                         RESET OUTPUT
027700991116    ?C                   Call      'CHKDAT'                                     CHECK DATE
027800991116    ?C     WOMON         Parm      WDMON         WRM                            6 TO 8
027900991116    ?C     WODAY         Parm      WDDAY         WRD                            6 TO 8
028000991116    ?C     WOYER         Parm      WDYER         WRY                            6 TO 8
028100991116    ?C                   Parm                    WWRTN                          RETURN CODE
028200010131    ?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
028300010131    ?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
028400010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
028500010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
028600010131    ?C                   Endif                                                  END ERROR
028601080917
028602080918    ? * Deposit Date Must be valid when comm report is run (*IN N55)
028603080917     c                   clear                   wsdddatechar      8
028604080918     c                   if        *in55 = *off
028605080917     c                   if        wsdddate = 0
028606080917    ?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
028607080917    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
028608080917    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
028609080917     c                   else
028610080917     c     *usa          test(de)                wsdddate
028611080917     c                   if        %error
028612080917    ?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
028613080917    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
028614080917    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
028615080917     c                   else
028616080917     c                   move      wsdddate      wsdddatechar
028617080917    ?C                   end                                                    END ERROR
028618080917    ?C                   end                                                    END ERROR
028620080918    ?C                   end                                                    END ERROR
028621110419
028700110419    ? * validate select agencies that get a paper copy
028701110419    ? * when comm report is run (*IN N55)
028703110419     c                   if        *in55 = *off
028704110419     c                   if        wspaper <> 'Y' and wspaper <> 'N'
028705110419    ?C                   Movel     WTM(11)       WWMSG                          PASS MESSAGE
028706110419    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
028707110419    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
028717110419    ?C                   end                                                    END ERROR
028718110419    ? * only valid with edit mode
028719110419     c                   if        wspaper = 'Y' and WSEDUP <> 'E'
028720110419    ?C                   Movel     WTM(12)       WWMSG                          PASS MESSAGE
028721110419    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
028722110419    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
028723110419    ?C                   end                                                    END ERROR
028724110419    ?C                   end                                                    END ERROR
028725110419    ? *
028800991116    ? * Atleast one Agency must be selected.
028900010131    ?C     WSAGNY        Ifeq      *BLANKS
029000010131    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
029100010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
029200010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
029300010131    ?C                   Else
029400010131    ? *
029500010131    ? * Must be a valid agency.
029600010131    ?C     WSAGNY        Ifne      '999'                                        IF ENTERED
029700010131    ?C     WSAGNY        Chain     AGENCY                             50        VALIDATE
029800010131    ?C     *IN50         Ifeq      *ON                                          NOT FOUND
029900010131    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
030000010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
030100010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
030200010131    ?C                   Endif                                                  END FOUND
030300010131    ?C                   Endif                                                  END ENTERED
030400010131    ?C                   Endif
030401050520
030402050520    ? * Unpaid or Paid must be selected.
030403050520    ?C     WSUNPD        Ifne      'U'
030404050520    ?C     WSUNPD        andne     'P'
030405050526     C                   Eval      *In66    =    *On
030407050520    ?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
030408050520    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
030409050520    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
030410050520    ?C                   End
030411050520
030412050520    ? * If Update mode is selected, selection must be Unpaid.
030413050520    ?C     WSEDUP        Ifeq      'U'
030414050520    ?C     WSUNPD        andne     'U'
030415050520     C                   Eval      *In66    =    *On
030416050520    ?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
030417050520    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
030418050520    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
030419050520    ?C                   End
030420050526
030421050526    ? * If Update mode is selected, Super Agency & Agency must be 999.
030422050526    ?C     WSEDUP        Ifeq      'U'
030423050526    ?C                   If        WSSUPER  <> '999'   Or
030426050526    ?C                             WSAGNY   <> '999'
030427050526     C                   Eval      *In65    =    *On
030428050526     C                   Eval      *In67    =    *On
030429050526    ?C                   Movel     WTM(9)        WWMSG                          PASS MESSAGE
030430050526    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
030431050526    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
030432050526    ?C                   End
030433050526    ?C                   End
030500030630    ?
030600030630    ? * At least one Super Agency must be selected.
030700030630    ?
030800030630    ?C     WSsuper       Ifeq      *BLANKS
030900030630    ?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
031000030630    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
031100030630    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
031200030630    ?C                   Else
031300030630    ? *
031400030630    ? * Must be a valid super agency.
031500030630    ?C     WSsuper       Ifne      '999'                                        IF ENTERED
031600030630    ?C     WSsuper       Chain     supragcy                           50        VALIDATE
031700030630    ?C     *IN50         Ifeq      *ON                                          NOT FOUND
031800030630    ?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
031900030630    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
032000030630    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
032100030630    ?C                   Endif                                                  END FOUND
032200030630    ?C                   Endif                                                  END ENTERED
032300030630    ?C                   Endif
032400030630
032500010131    ? * Sort Must be A, N, or B.
032600010131    ?C     WSSORT        Ifne      'A'
032700010131    ?C     WSSORT        andne     'N'
032800010131    ?C     WSSORT        andne     'B'
032900010131    ?C                   Movel     WTM(4)        WWMSG                          PASS MESSAGE
033000010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
033100010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
033200010131    ?C                   End
033300010131    ? *
033400010601    ? * Dummy Print must be Y or N. - N55
033500010601    ?C  N55WSDUMM        Ifne      'Y'
033600010131    ?C     WSDUMM        andne     'N'
033700010131    ?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
033800010131    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
033900010131    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
034000010131    ?C                   End
034100010131    ? *
034200980415    ? * WWCNT is for Enter Key control (x2)
034300010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
034400010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
034500010131    ?C                   Add       1             WWCNT                          INC COUNT
034600010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
034700010131    ?C                   Else                                                   ELSE
034800010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
034900010131    ?C                   Endif                                                  ENDIF
035000980402    ? *
035100980402    ?C                   Endsr                                                  END SND MSG
035200000000    ? *___________________________________________________________________
035300000000    ? * Send message
035400000000    ? *___________________________________________________________________
035500000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
035600000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
035700000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
035800000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
035900000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
036000000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
036100000000    ?C                   Endsr                                                  END SND MSG
036200000000    ? *___________________________________________________________________
036300000000    ? * Parameter lists
036400000000    ? *___________________________________________________________________
036500000000    ?C     PLIST         Begsr                                                  PARM LISTS
036600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
036700000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
036800000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
036900000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
037000000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
037100110419    ?C                   Parm                    WOPMT            27            PMT - OUT   R
037200000000    ?C                   Endsr                                                  END PLIST
037300000000    ? *___________________________________________________________________
037400000000    ? * Initialize routine
037500000000    ? *___________________________________________________________________
037600000000    ?C     *INZSR        Begsr                                                  INITIALIZE
037700000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
037800991116    ?C                   Movel     'AGENCY  '    WWFIL                          FILE NAME-NOTES
037900000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
038000000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
038001050526     C                   Eval      WSEDUP    =   'E'
038002050526     C                   Eval      WSSUPER   =   '999'
038003050526     C                   Eval      WSAGNY    =   '999'
038004050526     C                   Eval      WSUNPD    =   'U'
038005050526     C                   Eval      WSDUMM    =   'N'
038006110419     C                   Eval      WSpaper   =   'N'
038100000000    ?C                   Endsr                                                  END *INZSR
038200000000    ? *___________________________________________________________________
038300000000    ? * Define  routine
038400000000    ? *___________________________________________________________________
038500000000    ?C     DEFN          Begsr                                                  Define Fields
038600980311    ? *
038700980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
038800980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
038900980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
039000980311    ? *
039100000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
039200000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
039300000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
039400000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
039500000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
039600000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
039700000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
039800000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
039900000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
040000000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
040100000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
040200000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
040300000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
040400000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
040500000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
040600980312    ? *
040700980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
040800980312    ? *
040900000000    ?C                   Endsr                                                  END DEFN
041000000000    ? *___________________________________________________________________
041100000000    ? * Program error handler
041200000000    ? *___________________________________________________________________
041300000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
041400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
041500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
041600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
041700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
041800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
041900000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
042000980312    ? *
042100991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
04220098031104PROMPT  F4=Prompt
04230000000012CANCEL  F12=Cancel
04240098032425ROLLUP
04250098032426ROLLDOWN
042600980312** WTM
04270098031200The cursor is not in a prompt area.
04280099111660Commission Date must be valid MMDDYY format.
04290099111661Agency Code must be valid.
04300001013162Sort must be A, N, or B.
04310011041963Dummy Print must be Y or N.
04320003063064Super Agency must be valid.
04330005051665Select (E)dit or (U)pdate mode.
04340005052066Select (U)npaid or (P)aid; if Update mode, (U)npaid must be selected.
04350005052667If Update mode is selected, Super Agency & Agency must be 999.
04360008091768Please enter a valid Deposit Date
04370011041969Select Agencies that get a paper copy must be Y or N
04380011041969Select Agencies only valid in EDIT mode
