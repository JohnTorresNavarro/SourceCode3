000100150618     h Option(*NoDebugIO)
000200090323    ? *_________________________________________________________________________
000300160321    ? *
000400160321    ? *  ja01 - use the most recent coverage period
000500160321    ? *
000600160408    ? *  ja02 - skip same day terms
000700160803    ? *
000800160803    ? *  ja03 - If term then use end of prior month
000900160321    ? *
001000130429    ? *  (c)Copyright 2013 by GBS, Inc.
001100000000    ? *_________________________________________________________________________
001200140113    ?FMEMBER    IF   E           K DISK    EXTFILE('F.MEMBER') USROPN
001300140120    ?FDEPNDC    IF   E           K DISK    EXTFILE('F.DEPNDC') USROPN
001400140113    ?FMCOVC     IF   E           K DISK    EXTFILE('F.MCOVC') USROPN
001500160509    ?FPLNMST    IF   E           K DISK    EXTFILE('F.PLNMST') USROPN
001600160509    ?FPLNAUXP   IF   E           K DISK    USROPN
001700140120    ?FCARMST2P  IF   E           K DISK    USROPN
001800140120    ?FACCMST    IF   E           K DISK    EXTFILE('F.ACCMST') USROPN
0019001401200030 FCONTRL    UF   F   64    15AIDISK    KEYLOC(1) EXTFILE('F.CONTRL') USROPN
002000140113    ?FPMTRATED  CF   E             WORKSTN
002100130429    ?F                                     INFDS(DSPD)
002200000000    ? *_________________________________________________________________________
002300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002500080215    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)              PANEL MESSAGES
002600000000    ? *_________________________________________________________________________
002700140121    ?D WOSSN           s              9
002800140121    ?D WOSEQ           s              2
002900140120    ?D WOPCT           s              2
003000140113    ?D W80DATE         s              8s 0 inz
003100140115     D WDATE           S              8S 0 INZ
003200140120    ?D WWFLG           s              1
003300140120    ?D WWNOP           s              1
003400140113    ?D WOPLN           s              4
003500140113    ?D WOPLNM          s              4
003600140113    ?D WOPLND          s              4
003700140113    ?D WOPLNV          s              4
003800160321    ?D SMEFFDT         s              8s 0 inz
003900160321    ?D SDEFFDT         s              8s 0 inz
004000160602    ?D SVEFFDT         s              8s 0 inz
004100160602    ?D Today           s              8s 0 inz
004200160803
004300160803ja03 D IsoEff          s               d   datfmt(*iso)
004400160803ja03 D IsoDays         s              3s 0 inz
004500160803ja03?D mydate          s              8s 0 inz
004600080218    ?
004700080808      * Account key
004800080808     D                 DS
004900140113     D  WDSSN                  1      9
005000140113     D  WDssn1                 1      3s 0 inz
005100140113     D  WDssn2                 4      5s 0 inz
005200140113     D  WDssn3                 6      9s 0 inz
005300080215    ? *
005400000000    ? * Program status data structure
005500991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
005600000000    ? *
005700000000    ? * Display file data structure
005800991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
005900991116    ? *
006000991116    ? * Date data structure
006100991116    ?D DATD          E DS                  EXTNAME(IODATD)
006200140113    ? *
006300980311    ? *
006400980311    ? * CURSOR LOCATION
006500980311    ?D                 DS
006600980311    ?D  WWCRSL                 1      2
006700980311    ?D  WWCRSN                 1      2B 0
006800140120
0069001401200116 ICONTRL    NS        1 CI
0070001401200117 I*  INVOICE # CONTROL RECORD
0071001401200118 I                                 16   22 0INV#
0072001401200119 I          NS        1 CC
0073001401200120 I*  COBRA RECORD
0074001401200121 I                                 23   24 2FEDPCT
0075001401200122 I                                 25   26 2STAPCT
007600000000    ? *_________________________________________________________________________
007700000000    ? * Process display panel
007800140121     C                   Clear                   WOSSN
007900140121     C                   Clear                   WOSEQ
008000140113     C                   Clear                   WOPLN
008100000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
008200000000    ? *
008300000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
008400000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
008500000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
008600000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
008700000000 001? *
008800000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
008900140113 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
009000140113 001?C     WWFNC         Caseq     'DSPRATE'     PRCDSP                         EXIT
009100980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
009200000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
009300140115 001?C     WWFNC         Caseq     'CLEAR '      PRCCLR                         ENTER
009400980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
009500980312 001? *
009600000000 001?C                   Endcs                                                  END CASE
009700000000 001? *
009800000000E001?C                   Enddo                                                  END DOWHILE
009900120104 001? *
010000140113 001 C     MBSSNO        Chain     MEMBER
010100140113     C                   If        not %found(MEMBER)
010200120104     C                   Eval      WORTN = 'CANCEL'
010300120104     C                   End
010400140113    ? *
010500140120     C                   Close     MEMBER
010600140120     C                   Close     DEPNDC
010700980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
010800000000    ? *___________________________________________________________________
010900000000    ? * Prepare display panel
011000000000    ? *___________________________________________________________________
011100000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
011200000000    ? *
011300000000    ? * Initialize variables
011400000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
011500000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
011600000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
011700000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
011800000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
011900000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
012000000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
012100000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
012200980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
012300010524    ? *
012400000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
012500991108    ? *
012600000000    ?C                   Endsr                                                  END PRPPNL
012700000000    ? *___________________________________________________________________
012800000000    ? * Receive messages
012900000000    ? *___________________________________________________________________
013000000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
013100000000    ?C                   Movea     *IN           WWIN                           INDICATORS
013200000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
013300980223    ?C                   Parm      'RECEIVE '    WWRQS             8            RECEIVE MESSAGES
013400000000    ?C                   Parm                    WWIN                           INDICATORS
013500000000    ?C                   Parm                    WWRTN             8            RETURN CODE
013600000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
013700000000    ?C                   Endsr                                                  END RCV MSG
013800000000    ? *___________________________________________________________________
013900000000    ? * Display the display panel
014000000000    ? *___________________________________________________________________
014100000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
014200000000    ? *
014300000000    ? * Set OVERLAY based on last display file processed
014400000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
014500000000 001?C                   Setoff                                       35        OVERLAY OFF
014600000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
014700000000X001?C                   Else                                                   SAME PGM
014800000000 001?C                   Seton                                        35        OVERLAY ON
014900000000E001?C                   Endif                                                  END IF NEW PGM
015000000000    ? *
015100000000    ? * Write message subfile
015200000000    ?C                   Seton                                        30        SFLMSG DISPLAY
015300980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
015400000000    ? *
015500000000    ? * Write display panels
015600980218    ? *
015700980323B001?C     WWDSP         Ifeq      1
015800980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
015900980323E001?C                   Endif
016000980323    ? *
016100000000    ?C                   Endsr                                                  END DSP DSP
016200000000    ? *___________________________________________________________________
016300000000    ? * Build function key information
016400000000    ? *___________________________________________________________________
016500000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
016600991108    ?C                   Movea     *IN           WWIN                           INDICATORS
016700991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
016800000000    ?C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
016900000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
017000000000    ?C                   Parm                    WAD                            FNC DESC
017100991108    ?C                   Parm                    WWIN                           *IN
017200000000    ?C                   Parm                    WAF                            FNC KEY TABLE
017300000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
017400000000    ? *
017500000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
017600080218     C                   Movel     WAD(WW)       WSFKD2
017700000000    ?C                   Sub       1             WW                             BUMP IDX
017800080218     C                   Movel     WAD(WW)       WSFKD1
017900980312    ? *
018000000000    ?C                   Endsr                                                  END BLD FKY
018100000000    ? *___________________________________________________________________
018200000000    ? * Process function keys
018300000000    ? *___________________________________________________________________
018400000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
018500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
018600991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
018700000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
018800000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
018900000000    ?C                   Parm                    WAD                            FNC DESC
019000991108    ?C                   Parm                    WWIN                           *IN
019100000000    ?C                   Parm                    WAF                            FNC KEY TABLE
019200000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
019300000000    ?C                   Endsr                                                  END PRCFKY
019400000000    ? *___________________________________________________________________
019500000000    ? * Process KEYS function
019600000000    ? *___________________________________________________________________
019700000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
019800000000    ?C                   Z-add     1             WW                             KEY DSC IDX
019900000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
020000000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
020100000000 001? *
020200000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
020300000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
020400000000 002?C                   Z-add     1             WWFKS                          SET TO 1
020500000000E002?C                   Endif                                                  END IF OVER 3
020600000000 001? *
020700000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
020800000000 001?C                   Sub       1             WW                             KEY DESCR IDX
020900000000E001?C                   Enddo                                                  END DO KEYS
021000000000    ? *
021100000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
021200000000    ?C                   Sub       1             WW                             BUMP IDX
021300080218      *
021400080218     C                   Movel     WAD(WW)       WSFKD1
021500080218     C                   Add       1             WW
021600080218     C                   Movel     WAD(WW)       WSFKD2
021700000000    ? *
021800000000    ?C                   Endsr                                                  END PRCDKY
021900000000    ? *___________________________________________________________________
022000000000    ? * Process RETURN function
022100000000    ? *___________________________________________________________________
022200000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
022300140113     C                   Exsr      CHKDTA2
022400140113     C                   If        WWFLG = 'Y'
022500140113     C                   EXSR      PRCDSP
022600140113     C                   End
022700000000    ?C                   Endsr                                                  END RETURN
022800140113    ? *
022900140113    ? *___________________________________________________________________
023000140113    ? * DISPLAY RATES
023100140113    ? *___________________________________________________________________
023200140113    ?C     PRCDSP        Begsr                                                  PROCESS RETURN
023300140113     C                   Select
023400140113     C                   When      %trim(WOPLNM) <> *blanks
023500140113     C                   eval      wopln = %trim(WOPLNM)
023600140113     C                   When      %trim(WOPLND) <> *blanks
023700140113     C                   eval      wopln = %trim(WOPLND)
023800140113     C                   When      %trim(WOPLNV) <> *blanks
023900140113     C                   eval      wopln = %trim(WOPLNV)
024000140113     C                   Other
024100140113     C                   eval      wopln = *blanks
024200140113     C                   End
024300140120    ? *
024400140120    ? * Get surcharge
024500140120     C                   Exsr      GETSUR
024600160509    ? *
024700160509    ?C     auxkey        klist
024800160509     C                   kfld                    mctrst
024900160509     C                   kfld                    mcsub#
025000160509     C                   kfld                    wopln
025100160509     C                   open      plnauxp
025200160509    ?C     auxkey        chain     plnauxp
025300160509     C                   close     plnauxp
025400140113    ? *
025500140121     C                   move      WSSEQ         WOSEQ
025600140113     C                   If        %trim(wopln) <> *blanks
025700160509    ? *
025800160509     C                   if        pxexchg = 'Y'
025900160803    ? *
026000160803ja03 C                   if        mydate = 0
026100160803ja03 C                   eval      Today   = %Dec(%Date)
026200160803ja03 C                   else
026300160803ja03 C                   eval      Today   = mydate
026400160803     C                   end
026500160803    ? *
026600160509     C                   call      'DSPRATEE'
026700140113     C                   parm                    mctrst
026800140113     C                   parm                    mcsub#
026900140113     C                   parm                    wopln
027000140113     C                   parm                    acc#
027100140121     C                   parm                    wossn
027200140121     C                   parm                    woseq
027300140120     C                   parm                    wopct
027400140113     C                   parm      'RATES'       inqtype           8
027500160602     C                   parm                    wsname
027600160602     C                   parm                    Today
027700160509    ? *
027800160509     C                   else
027900160509    ? *
028000160803ja03 C                   if        mydate = 0
028100160803ja03 C                   eval      Today   = %Dec(%Date)
028200160803ja03 C                   else
028300160803ja03 C                   eval      Today   = mydate
028400160803     C                   end
028500160803    ? *
028600160509     C                   call      'DSPRATE'
028700160509     C                   parm                    mctrst
028800160509     C                   parm                    mcsub#
028900160509     C                   parm                    wopln
029000160509     C                   parm                    acc#
029100160509     C                   parm                    wossn
029200160509     C                   parm                    woseq
029300160509     C                   parm                    wopct
029400160509     C                   parm      'RATES'       inqtype           8
029500160509     C                   parm                    wsname
029600160602     C                   parm                    Today
029700160509    ? *
029800160509     C                   end
029900160509    ? *
030000140114     C                   Eval      *IN65 = *off
030100140114     C                   Eval      *IN64 = *off
030200140114     C                   Eval      *IN63 = *off
030300140114     C                   Eval      *IN62 = *off
030400140114     C                   clear                   WMEDD
030500140114     C                   clear                   WOPLNM
030600140114     C                   clear                   WDEND
030700140114     C                   clear                   WOPLND
030800140114     C                   clear                   WVISD
030900140114     C                   clear                   WOPLNV
031000140115     C                   Exsr      PRCENT
031100140113     C                   Else
031200140113    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
031300140113    ?C                   Move      'END'         WWSTT                          END INVOCATION
031400140113     C                   End
031500140113    ?C                   Endsr                                                  END RETURN
031600140115    ? *___________________________________________________________________
031700140115    ? * CLEAR THE SCREEN
031800140115    ? *___________________________________________________________________
031900140115    ?C     PRCCLR        Begsr                                                  PROCESS RETURN
032000140115     C                   Eval      *IN65 = *off
032100140115     C                   Eval      *IN64 = *off
032200140115     C                   Eval      *IN63 = *off
032300140120     C                   Eval      *IN62 = *off
032400140120     C                   Eval      *IN67 = *off
032500140115     C                   clear                   WSNAME
032600140115     C                   clear                   WMED
032700140115     C                   clear                   WMEDD
032800140115     C                   clear                   WOPLNM
032900140115     C                   clear                   WDEN
033000140115     C                   clear                   WDEND
033100140115     C                   clear                   WOPLND
033200140115     C                   clear                   WVISD
033300140120     C                   clear                   WOPLNV
033400140120     C                   clear                   NOPLANS
033500140120     C                   clear                   WSSEQ
033600140115    ? *
033700140115    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
033800140115    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
033900140115    ? *
034000140121     C                   Clear                   WOSSN
034100140121     C                   Clear                   WOSEQ
034200140115     C                   Clear                   WOPLN
034300140115     C                   Clear                   wssn1
034400140115     C                   Clear                   wdssn1
034500140115     C                   Clear                   wssn2
034600140115     C                   Clear                   wdssn2
034700140115     C                   Clear                   wssn3
034800140115     C                   Clear                   wdssn3
034900140115     C                   Clear                   mbssno
035000140115      *
035100140115    ?C                   Endsr                                                  END RETURN
035200980311    ? *___________________________________________________________________
035300980311    ? * Process PROMPT function
035400980311    ? *___________________________________________________________________
035500980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
035600980311    ? *
035700980311    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
035800980311    ? *
035900991108    ? * PROMPT MEMBER
036000080215B001?C     WSFLD         Ifeq      'WSXXXXX'                                    WHERE FIELD NAME
036100991116X001?C                   Else                                                               NAME
036200991108 001?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
036300991108 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
036400991116E001?C                   Endif
036500980403    ? *
036600980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
036700980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
036800980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
036900980311    ?C                   Mvr                     WSLIN                          CURSOR COL
037000980311    ?C                   Seton                                        37        SET ON CRSLOC
037100980311    ? *
037200980311    ?C                   Endsr                                                  END PRCPMT
037300000000    ? *___________________________________________________________________
037400000000    ? * Process CANCEL function
037500000000    ? *___________________________________________________________________
037600000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
037700000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
037800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
037900000000    ?C                   Endsr                                                  END PRCCNL
038000000000    ? *___________________________________________________________________
038100000000    ? * Process ROLLUP function
038200000000    ? *___________________________________________________________________
038300000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
038400000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
038500000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
038600000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
038700000000E001?C                   Endif                                                  END IF GT LST PNL
038800000000    ?C                   Endsr                                                  END PRCRUP
038900000000    ? *___________________________________________________________________
039000000000    ? * Process ROLLDOWN function
039100000000    ? *___________________________________________________________________
039200000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
039300000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
039400000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
039500000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
039600000000E001?C                   Endif                                                  END IF LT FST PNL
039700000000    ?C                   Endsr                                                  END PRCRDN
039800000000    ? *___________________________________________________________________
039900000000    ? * Process ENTER function
040000000000    ? *___________________________________________________________________
040100000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
040200980323    ? *
040300980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
040400980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
040500980415    ? *
040600980415    ? * SET RETURN PARMS
040700980402B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
040800980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
040900980323 001?C                   Move      'END'         WWSTT                          END PROMPT
041000980430E001?C                   Endif                                                  END RAM
041100980430    ? *
041200000000    ?C                   Endsr                                                  END PRCENT
041300980402    ? *___________________________________________________________________
041400980402    ? * Check data
041500980402    ? *___________________________________________________________________
041600140113    ?C     CHKDTA        Begsr                                                  Check data
041700980402    ? *
041800980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
041900980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
042000120104    ? *
042100140121     C                   Clear                   WOSSN
042200140121     C                   Clear                   WOSEQ
042300140113     C                   Clear                   WOPLN
042400140113     C                   Z-add     Wssn1         wdssn1
042500140113     C                   Z-add     Wssn2         wdssn2
042600140113     C                   Z-add     Wssn3         wdssn3
042700140113     C                   move      WDSSN         mbssno
042800140120      *
042900140120    ? * Must be valid dependent.
043000140120     C                   If        WSSEQ <> 0
043100140120 001 C     DEPKEY        Chain     DEPNDC
043200140120     C                   If        not %found(DEPNDC)
043300140120 002 C                   Movel     WTM(4)        WWMSG
043400140120 002 C                   Exsr      SNDMSG
043500140120 002 C                   Move      'ERROR   '    WWRTN
043600140120     C                   Else
043700140120 002 C                   Clear                   WSNAME
043800140120     C                   If        %trim(DMI) = *blanks
043900140120     C                   Eval      WSNAME = %trim(DFNAME) + ' ' +
044000140120     C                                      %trim(DLNAME)
044100140120E002 C                   Else
044200140120     C                   Eval      WSNAME = %trim(DFNAME) + ' ' +
044300140120     C                                      %trim(DMI)    + ' ' +
044400140120     C                                      %trim(DLNAME)
044500140120E002 C                   End
044600140121     C                   move      WDSSN         WOSSN
044700140121     C                   move      WSSEQ         WOSEQ
044800140121     C                   eval      WSNAME = %trim(WSNAME) + ' - Dep# ' +
044900140121     C                                      %trim(WOSEQ)
045000140120 001 C     MBSSNO        Chain     MEMBER
045100140120     C                   If        %found(MEMBER)
045200140120     C                   Exsr      GETACA
045300140120     C                   End
045400140120     C                   End
045500140120     C                   Else
045600080808      *
045700140120    ? * Must be valid member.
045800140113 001 C     MBSSNO        Chain     MEMBER                             50
045900080808B002 C     *IN50         Ifeq      *ON
046000120104 002 C                   Movel     WTM(2)        WWMSG
046100080808 002 C                   Exsr      SNDMSG
046200080808 002 C                   Move      'ERROR   '    WWRTN
046300080808X002 C                   Else
046400140113     C                   move      WDSSN         WOSSN
046500140121     C                   move      WSSEQ         WOSEQ
046600080808 002 C                   Clear                   WSNAME
046700140113     C                   If        %trim(MMI) = *blanks
046800140113     C                   Eval      WSNAME = %trim(MFNAME) + ' ' +
046900140113     C                                      %trim(MLNAME)
047000140113E002 C                   Else
047100140113     C                   Eval      WSNAME = %trim(MFNAME) + ' ' +
047200140113     C                                      %trim(MMI)    + ' ' +
047300140113     C                                      %trim(MLNAME)
047400140113E002 C                   End
047500140113     C                   Exsr      GETACA
047600080910E002 C                   Endif
047700140120E002 C                   End
047800010131    ? *
047900980415    ? * WWCNT is for Enter Key control (x2)
048000010131    ?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
048100010131    ?C     WWRTN         Andeq     *BLANKS                                      and no error
048200010131    ?C                   Add       1             WWCNT                          INC COUNT
048300010131    ?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
048400010131    ?C                   Else                                                   ELSE
048500010131    ?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
048600010131    ?C                   Endif                                                  ENDIF
048700080910    ? * NEVER CONTINUE ON ENTER!!!
048800080910    ?C                   Move      'XXXXXXX'     WWRTN                          RETURN ERROR
048900980402    ? *
049000140113    ?C                   Endsr                                                  END SND MSG
049100140113    ? *___________________________________________________________________
049200140113    ? * Check data
049300140113    ? *___________________________________________________________________
049400140113    ?C     CHKDTA2       Begsr                                                  Check data
049500140113     C                   Eval      wwflg = 'Y'
049600140113     C                   if        WMED = *blanks  and
049700140113     C                             WDEN = *blanks  and
049800140113     C                             WVIS = *blanks
049900140113     C                   Eval      wwflg = 'E'
050000140113 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
050100140113 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
050200140113     C                   End
050300140113    ?C                   Endsr                                                  END SND MSG
050400140113    ? *___________________________________________________________________
050500140113    ? * Get ACA Plans
050600140113    ? *___________________________________________________________________
050700140113    ?C     GETACA        Begsr                                                  SEND MESSAGE
050800140113     C                   Eval      *IN65 = *off
050900140113     C                   Eval      *IN64 = *off
051000140113     C                   Eval      *IN63 = *off
051100140113     C                   Eval      *IN62 = *off
051200140113     C                   Clear                   WOPLNM
051300140113     C                   Clear                   WOPLND
051400140113     C                   Clear                   WOPLNV
051500160803     C                   Clear                   WWNOP
051600160803ja03 C                   Clear                   mydate
051700140113     C                   Open      MCOVC
051800140113     C                   Open      PLNMST
051900140113     C                   Open      CARMST2P
052000140113     C     COVKEY        Setgt     MCOVC
052100140113     C     COVKEY        Readpe    MCOVC
052200140113     C                   Dow       not %eof(MCOVC)
052300160408ja02 C                   if        ENRLDT <> CANDT
052400140115     C***                If        w80date >= ENRLDT and
052500140115     C***                          CANDT = 0         or
052600140115     C***                          w80date <= CANDT
052700140115      * Show the last ACA plan available active or termed
052800140113     C     PLNKEY        chain     PLNMST
052900140113     C                   If        %found(PLNMST)
053000140113     C     CARKEY        chain     CARMST2P
053100140113     C                   If        %found(CARMST2P)
053200140113     C                   If        %trim(C2ACART) = 'Y'
053300140113     C                   Eval      *IN65 = *on
053400140113     C                   Select
053500160308     C** ja01            When      %trim(PLNCAT) = 'PMM' and
053600160308     C** ja01                      %trim(WOPLNM) = *blanks
053700160308ja01 C                   When      %trim(PLNCAT) = 'PMM'
053800160321ja01 C                   If        ENRLDT > SMEFFDT
053900140113     C                   Eval      WMEDD = %trim(PDESCR)
054000140113     C                   Eval      WOPLNM = %trim(MCPLAN)
054100160321ja01 C                   Eval      SMEFFDT = ENRLDT
054200140115
054300140115     C                   If        ENRLDT <> 0
054400140115     C                   Movel     ENRLDT        Input_Date
054500140115     C                   Exsr      FMTDATE
054600140115     C                   Movel     OutPut_Date   WMEDEF           10
054700140115     C                   Else
054800140115     C                   Clear                   WMEDEF
054900140115     C                   End
055000140115
055100140115     C                   If        CANDT  <> 0
055200140115     C                   Movel     CANDT         Input_Date
055300140115     C                   Exsr      FMTDATE
055400140115     C                   Movel     OutPut_Date   WMEDTR           10
055500160803
055600160803ja03 C                   move      candt         isoEff
055700160803ja03 C                   Extrct    isoEff:*d     isoDays
055800160803ja03 C                   If        isoDays = 1
055900160803ja03 C     isoeff        Subdur    isoDays:*d    isoEff
056000160803ja03 C                   move      IsoEff        mydate
056100160803ja03 C                   End
056200160803ja03 C                   Else
056300160803ja03 C                   Clear                   WMEDTR
056400160803ja03 C                   Clear                   mydate
056500160803ja03 C                   End
056600140115
056700140113     C                   Eval      *IN62 = *on
056800160321ja01 C                   End
056900160308ja01 C                   When      %trim(PLNCAT) = 'PDR'    or
057000160308ja01 C                             %trim(PLNCAT) = 'PDN'
057100160321ja01 C                   If        ENRLDT > SDEFFDT
057200140113     C                   Eval      WDEND = %trim(PDESCR)
057300140113     C                   Eval      WOPLND = %trim(MCPLAN)
057400160321ja01 C                   Eval      SDEFFDT = ENRLDT
057500140115
057600140115     C                   If        ENRLDT <> 0
057700140115     C                   Movel     ENRLDT        Input_Date
057800140115     C                   Exsr      FMTDATE
057900140115     C                   Movel     OutPut_Date   WDENEF           10
058000140115     C                   Else
058100140115     C                   Clear                   WDENEF
058200140115     C                   End
058300140115
058400140115     C                   If        CANDT  <> 0
058500140115     C                   Movel     CANDT         Input_Date
058600140115     C                   Exsr      FMTDATE
058700140115     C                   Movel     OutPut_Date   WDENTR           10
058800140115     C                   Else
058900140115     C                   Clear                   WDENTR
059000140115     C                   End
059100140115
059200140113     C                   Eval      *IN63 = *on
059300160321ja01 C                   End
059400160308ja01 C                   When      %trim(PLNCAT) = 'PVR'    or
059500160308ja01 C                             %trim(PLNCAT) = 'PVS'
059600160321ja01 C                   If        ENRLDT > SVEFFDT
059700140113     C                   Eval      WVISD = %trim(PDESCR)
059800140113     C                   Eval      WOPLNV = %trim(MCPLAN)
059900160321ja01 C                   Eval      SVEFFDT = ENRLDT
060000140115
060100140115     C                   If        ENRLDT <> 0
060200140115     C                   Movel     ENRLDT        Input_Date
060300140115     C                   Exsr      FMTDATE
060400140115     C                   Movel     OutPut_Date   WVISEF           10
060500140115     C                   Else
060600140115     C                   Clear                   WVISEF
060700140115     C                   End
060800140115
060900140115     C                   If        CANDT  <> 0
061000140115     C                   Movel     CANDT         Input_Date
061100140115     C                   Exsr      FMTDATE
061200140115     C                   Movel     OutPut_Date   WVISTR           10
061300140115     C                   Else
061400140115     C                   Clear                   WVISTR
061500140115     C                   End
061600140115
061700140113     C                   Eval      *IN64 = *on
061800160408ja01 C                   End
061900140113    ?C                   Endsl                                                  END SND MSG
062000140113    ?C                   End                                                    END SND MSG
062100140113    ?C                   End                                                    END SND MSG
062200140113    ?C                   End                                                    END SND MSG
062300160408ja02 C                   End
062400140115    ?C***                End                                                    END SND MSG
062500140113     C     COVKEY        Readpe    MCOVC
062600140113    ?C                   Enddo                                                  END SND MSG
062700140113     C                   Close     MCOVC
062800140113     C                   Close     PLNMST
062900140113     C                   Close     CARMST2P
063000140120     C                   If        *in62 = *off and
063100140120     C                             *in63 = *off and
063200140120     C                             *in64 = *off
063300140120     C                   eval      noplans = 'No Plans Found'
063400140120     C                   eval      *in67 = *on
063500140120     C                   Else
063600140120     C                   eval      *in67 = *off
063700140120     C                   eval      noplans = *blanks
063800140120     C                   End
063900980402    ?C                   Endsr                                                  END SND MSG
064000140120    ? *___________________________________________________________________
064100140120    ? * Get Surcharge
064200140120    ? *___________________________________________________________________
064300140120    ?C     GETSUR        Begsr                                                  SEND MESSAGE
0644001401200171 C*
0645001401200383 C                   Z-ADD     *ZEROS        GBSPCT            2 2
0646001401200171 C*
064700140120     C                   Open      ACCMST
0648001401200171 C     ACCKEY        Chain     ACCMST
064900140120     C                   If        %found(ACCMST)
0650001401200171 C*
0651001401200171 C* SKIP IF COBRA MEMBER IS DIVORCED
065200140120     C                   IF        ELECRT <> 'D'
0653001401200171 C*
0654001401200172 C* GET COMMISSION PERCENT FROM CONTRL FILE
0655001401200173 C*
065600140120     C                   Open      CONTRL
0657001401200174 C                   MOVEL     'C'           COBKEY           15
0658001401200175 C     COBKEY        CHAIN     CONTRL
065900140120     C                   If        %found(CONTRL)
0660001401200173 C*
066100140120     C                   Select
0662001401200384 C                   When      FCSTFL = 'F'
0663001401200176 C                   MOVE      FEDPCT        GBSPCT
0664001401200384 C                   When      FCSTFL = 'S'
0665001401200177 C                   MOVE      STAPCT        GBSPCT
066600140120     C                   Endsl
0667001401200173 C*
066800140120     C                   End
066900140120     C                   Close     CONTRL
067000140120     C                   End
067100140120     C                   End
067200140120     C                   Close     ACCMST
0673001401200173 C*
067400140120     C                   move      gbspct        wopct
0675001401200173 C*
067600140120    ?C                   Endsr                                                  END SND MSG
067700140115    ? *___________________________________________________________________
067800140115    ? * FMTDATE
067900140115    ? *___________________________________________________________________
068000140115    ?C     FMTDATE       Begsr                                                  SEND MESSAGE
068100140115     C                   Call      'FMTDATE'
068200140115     C                   Parm                    Input_Date       32
068300140115     C                   Parm      'YYYYMMDD'    Input_Format     32
068400140115     C                   Parm      'MM/DD/YYYY'  Output_Format    32
068500140115     C                   Parm                    Output_Date      32
068600140115     C                   Parm                    Output_Error     10
068700140115    ?C                   Endsr                                                  END SND MSG
068800140113    ? *___________________________________________________________________
068900140113    ? * KLIST
069000140113    ? *___________________________________________________________________
069100140113    ?C     KLIST         Begsr                                                  SEND MESSAGE
069200140120     C     DEPKEY        Klist
069300140120     C                   Kfld                    MBSSNO
069400140120     C                   Kfld                    WSSEQ
069500140120     C     ACCKEY        Klist
069600140120     C                   Kfld                    MBTRST
069700140120     C                   Kfld                    MBSUB#
069800140120     C                   Kfld                    MBACCT
069900140113     C     COVKEY        Klist
070000140113     C                   Kfld                    MBSSNO
070100140113     C                   Kfld                    MDSEQ#
070200140120     C                   Kfld                    MBTRST
070300140113     C                   Kfld                    MBSUB#
070400140113     C     PLNKEY        Klist
070500140113     C                   Kfld                    MCTRST
070600140113     C                   Kfld                    MCSUB#
070700140113     C                   Kfld                    MCPLAN
070800140113     C     CARKEY        Klist
070900140113     C                   Kfld                    PCARR
071000140113    ?C                   Endsr                                                  END SND MSG
071100000000    ? *___________________________________________________________________
071200000000    ? * Send message
071300000000    ? *___________________________________________________________________
071400000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
071500000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
071600000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
071700000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
071800000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
071900000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
072000000000    ?C                   Endsr                                                  END SND MSG
072100000000    ? *___________________________________________________________________
072200000000    ? * Parameter lists
072300000000    ? *___________________________________________________________________
072400000000    ?C     PLIST         Begsr                                                  PARM LISTS
072500000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
072600000000    ?C     WWTSK         Parm                    WIRQS             8            EXT MODE
072700000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
072800000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
072900000000    ?C                   Parm                    WIFKY            60            FUNCTIONS VALID
073000140113    ?C                   Parm                    WOSSN                          PMT - OUT   R
073100140113    ?C                   Parm                    WOPLN                          PMT - OUT   R
073200000000    ?C                   Endsr                                                  END PLIST
073300000000    ? *___________________________________________________________________
073400000000    ? * Initialize routine
073500000000    ? *___________________________________________________________________
073600000000    ?C     *INZSR        Begsr                                                  INITIALIZE
073700140120     C                   Open      MEMBER
073800140120     C                   Open      DEPNDC
073900150618     C**   *DATE         Mult      10000.0001    Today             8 0
074000150618     C**   *DATE         Mult      10000.0001    w80date
074100150618br01 C                   eval      w80Date = %Dec(%Date)
074200000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
074300140113    ?C                   Movel     'MEMBER  '    WWFIL                          FILE NAME-NOTES
074400000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
074500000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
074600000000    ?C                   Endsr                                                  END *INZSR
074700000000    ? *___________________________________________________________________
074800000000    ? * Define  routine
074900000000    ? *___________________________________________________________________
075000000000    ?C     DEFN          Begsr                                                  Define Fields
075100980311    ? *
075200980311    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE R      EQUEST
075300980311    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIO      US PANEL
075400980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
075500980311    ? *
075600000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
075700000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
075800000000    ?C     *LIKE         Define    WIFKY         WWFKY                          FUNCTIONS VALID
075900000000    ?C     *LIKE         Define    WIFKY         WWFKV                          FUNCTION KEY VALID
076000000000    ?C     *LIKE         Define    WIFKY         WWOPV                          OPTIONS VALID
076100000000    ?C                   Move      WWIN          WWIN             99            INDICATOR FIELD
076200000000    ?C                   Move      WWOCD         WWOCD             8            OPTION CODE
076300000000    ?C                   Move      WWSTT         WWSTT             3            STATUS
076400000000    ?C                   Z-add     WWPNL         WWPNL             1 0          CURRENT PNL
076500000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0          NBR OF PNLS
076600000000    ?C                   Z-add     WWFKS         WWFKS             1 0          FNC KEY SET
076700000000    ?C                   Z-add     WW            WW                3 0          WORK INDEX
076800000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
076900000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
077000000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
077100980312    ? *
077200980403    ?C     *LIKE         Define    WW            WWCNT                          WARNING CNT ED
077300980312    ? *
077400000000    ?C                   Endsr                                                  END DEFN
077500000000    ? *___________________________________________________________________
077600000000    ? * Program error handler
077700000000    ? *___________________________________________________________________
077800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
077900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
078000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
078100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
078200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
078300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
078400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
078500980312    ? *
078600991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
07870014011403CANCEL  F3=Exit
07880014011505CLEAR   F5=Clear
07890014011310EXIT    F10=Display Rates
07900098032425ROLLUP
07910098032426ROLLDOWN
079200980312** WTM
07930008080800The cursor is not in a prompt area.
07940014011361Social Security Number must be valid.
07950014012000You must select (X) a plan.
07960014012066Dependent not found.
