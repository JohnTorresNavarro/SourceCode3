000100001107     H Indent ('| ')
000200990630      *? ***************************************************************
000300001128      *             GROUP BENIFIT SERVICES SOFTWARE           2000     *
000400001128      *                                                                *
000500000118      *  Written by:    S. Zien                                        *
000600001117      *  Date Written:  11/17/00                                       *
000700001128      *  Description:   Cobra Invoice History Audit                    *
000800000118      *                                                                *
000900000118      *                                                                *
001000000118      *                R E V I S I O N    H I S T O R Y                *
001100000118      *  Date                                                          *
001200000118      *  Revised   Initials    Revision                                *
001300000118      *  --------  --------    --------------------------------------  *
001400010618      * 06/18/01 dlk - change search prior to begin date to 3 months   *
001500010618      *                and supress print of missing invoices prior     *
001600010618      *                to 1/1999 because of hist pruge.                *
001700010618      *                                                                *
001800010710      * 07/10/01 szz - Modify termination-date condition in order to   *
001900010710      *    001s        determine whether active account is in error.   *
001901130430      *                                                                *
002000040714      * 07/14/04 dlk - skip "inv b/f begin admin" errors b/f 01/02     *
002001130430      *                                                                *
002002130430      *  4/29/13 szz - Do not show any errors prior to two             *
002003130430      *                  years ago and add csv output per Dave K.      *
002004150603      * 06/03/15 dlk - skip chesapeake spice account 590-8-4 since it  *
002100150603      *                is not a real FI acct (SF acct only)            *
002101150603      *                                                                *
002200990630      *? ***************************************************************
002300001128
002400001117     FMember    IF   E           K disk
002500001117     FHist      IF   E           K disk
002600001122     FHistAA    IF   E           K disk    Prefix(A_) Rename(Histr:A_fmt)
002700001107     FContrl    IF   E           K disk
002800001117     fAbr020p   O    E             Printer Oflind(*in91)
002801130429     FABR020XL  o  a e             DISK
002900991020
003000010117     D                UDS
003100010118     D  CONAME               201    250
003200991230    ? * Program status data structure
003300991230    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003400001107     D                 DS
003500001106
003600001107     DDSindt           DS
003700001127     D  dsccyymm                      6  0
003800001127     D  dsdd                          2  0
003900001127     DDScovtdt         S              6  0 Inz(*Zeros)
004000001127     DDSgbscd1         S              6  0 Inz(*Zeros)
004100001127     DDSgbscdt         S              6  0 Inz(*zeros)
004101130429     D                 DS
004102130429     D ptsa                    1     10  0
004103130429     D  ptrst                  1      3  0
004104130429     D  psub#                  4      6  0
004105130429     D  pacct                  7     10  0
004106150603     D                 DS
004107150603     D MB_TSA                  1     10  0
004108150603     D  MBTRST                 1      3  0
004109150603     D  MBSUB#                 4      6  0
004110150603     D  MBACCT                 7     10  0
004200001108     D                 DS
004300001108     D TIME_DATE                     12  0
004400001108     D  TIME                          6  0 OVERLAY(TIME_DATE)
004500001108     D  DATE                          6  0 OVERLAY(TIME_DATE:7)
004600001120     D                 DS
004700001117     DKeyflI                         14
004800001120     D  kccyymm                       6    Overlay(KeyflI)
004900001117     D  ktrst                         3    Overlay(KeyflI:7)
005000001120     D                 DS
005100001117     D MBSSNO                              INZ(*ZEROS)
005200001117     D  Nsno1_DS                      3    OVERLAY(MBSSNO)
005300001117     D  Nsno2_DS                      2    OVERLAY(MBSSNO:4)
005400001117     D  Nsno3_DS                      4    OVERLAY(MBSSNO:6)
005500001120     D                 DS
005600001117     D Assno                         10    INZ('          ')
005700001117     D  Asno1_DS                      3    OVERLAY(Assno:2)
005800001117     D  Asno2_DS                      2    OVERLAY(Assno:5)
005900001117     D  Asno3_DS                      4    OVERLAY(Assno:7)
006000001120     D                 DS
006100001117     D Ck#not                              INZ(*blanks)
006200001117     D  BMBinv                        6    OVERLAY(Ck#not:7)
006300001120     D                 DS
006400001117     D A_Note2                             INZ(*blanks)
006500001117     D  AVIinv                        6    OVERLAY(A_Note2:7)
006600001120     D                 DS
006700001120     D Dsen1h                         8  0 Inz(*Zeros)
006800001120     D  DS1yymm                       6  0 OVERLAY(Dsen1h)
006900001120     D DSEN2           S              8  0
007000001120     D AVI             S              3    Inz('AVI')
007100001120     D B               S              1    Inz('B')
007200001120     D DSEN1           S               D   Datfmt(*ISO)
007300001120     D USA_Date        S               D   Datfmt(*USA)
007400001127     D ISO_DATE2       S               D   Datfmt(*ISO)
007500001120     D Gbsc1           S               D   Datfmt(*ISO)
007600001110     D cymd1           S               D   Datfmt(*ISO)
007700001127    ?D Wddate1         S               D   Datfmt(*ISO)
007800001127     D Gdtp1           S               D   Datfmt(*ISO)
007900001108    ?D Wwdate          S              8  0
008000001120    ?D DsenwN          S              8  0
008100001108     D CYMD            S              8  0
008200001127     D covhdt          S              8  0
008201130430     Dcsv              c                   const('","')
008300001211    ?D InsMsg          C                   'Invoice Missing'
008400001117    ?D MisMsg          C                   'Missing Before Last Invoice Date'
008500001107    ?D DupMsg          C                   'Duplicate Invoice'
008600001108    ?D PriMsg          C                   'Prior to Begin Date'
008700001117    ?D TerMsg          C                   'Invoice Missing Before Term Date'
008800001122      *--
008900000118      *? Main.
009000000118      *---
009100001117     c                   Read      Member
009200001117    ?C                   Dou       %EOF(member)
009201150603
009300001120     C                   If        NOT %EOF(member)
009301150603
009302150603      * skip chesapeake spice account
009303150603     c                   if        mb_tsa = 5900080004
009304150603     c                   read      member
009305150603     c                   iter
009306150603     c                   end
009307150603
009400150603     C                   if        gbscdt <> *zeros
009600001110     C                   Move      'N'           ProcSw            1
009700150603     C                   If        (Mbcand = 0) or
010000150603     C                             (Mbcand <> 0 and cymd3y <= gbscdt)
010200001110     C                   Move      'Y'           ProcSw
010400001110     C                   Endif
010600001109      *---
010700001128      *?Hold Cobra GBS begin date for incrementation to see all invoice months.
010800001109      *---
010801150603     C     ProcSw        Ifeq      'Y'
010900001120     C                   Move      Gbscdt        gbscd1            8 0
011000000118     c                   exsr      process
011100001106     c                   endif
011200001120     c                   Endif
011201150603
011300001117     c                   read      member
011400001106     c                   endif
011500001109    ?C                   Enddo
011501150603
011600001211     c     Errsw         ifeq      'N'
011700001211     C                   Write     Hdr
011800001211     C                   Write     NOE
011900001211     C                   Endif
012000001211     C                   Write     EOR
012100000118     C                   EVAL      *INLR = *ON
012200000118      * ? _____________________________________________________________
012300000118      *? *                                                             *
012400001117      *? *        Check each invoice record in HIST.                   *
012500000118      *? *_____________________________________________________________*
012600000118     C     process       BEGSR
012700001127      *---
012800001128      *?Initialize invoice hold date; use to compare previous for duplicates.
012900001127      *---
013000001127     C                   Z-add     *zeros        covhdt
013100001117      *---
013200001128      *?Determine last date invoiced; place results in DSEN2.
013300001117      *---
013400001117     C                   Exsr      Contsr
013500001117
013600001117     C                   Move      Nsno1_DS      Asno1_DS
013700001117     C                   Move      Nsno2_DS      Asno2_DS
013800001117     C                   Move      Nsno3_DS      Asno3_DS
013900001120     C                   Move      Assno         Hkey
014000001117     C     H_key         Setll     Hist
014100001121     C                   DOU       Not %Found(Hist)
014200001117     C     H_key         Reade     Hist
014300001117     C                   If        %EOF(Hist)
014400001107     C                   Leave
014500001107     C                   Endif
014600001121     C                   If        %Found(Hist)
014700001117     C     Trcode        Ifeq      'BMB'
014800001113
014900001117      *---
015000001128      *?If there are any voids for the invoice#, bypass the invoice.
015100001117      *---
015200001121     C                   Move      Hkey          A_Hkey
015300001117     C     HA_Key        Setll     Histaa
015400001121    ?C                   Dou       %EOF(Histaa)
015500001121     C     HA_Key        Reade     Histaa
015600001117     C                   If        %Found(Histaa)
015700001117     C     BMBinv        Ifeq      AVIinv
015800001117     C                   Goto      ELoop
015900001117     C                   Endif
016000001117     C                   Endif
016100001117     C                   Enddo
016200001127      *---
016300001128      *?Compare covered-thru date to previous record in case of a duplicate.
016400001127      *---
016500001127     C     Covtdt        Ifeq      covhdt
016600001127     C                   Movel     DupMsg        Percon
016700001127     C     *ISO          Move      Covtdt        USA_Date
016800001127     C                   Exsr      ErrRtn
016900001127     C                   Endif
017000001127
017100001127     C                   Z-add     Covtdt        covhdt
017200001127
017300001127      *---
017400001128      *?Compare year/month to determine if prior to invoice month.
017500001127      *---
017600001127     C                   Move      Covtdt        DSindt
017700001127     C                   Move      DSccyymm      DScovtdt
017800001127     C                   Move      Gbscdt        DSindt
017900001127     C                   Move      DSccyymm      DSgbscdt
018000001127     C                   Move      Gbscd1        DSindt
018100001127     C                   Move      DSccyymm      DSgbscd1
018200001127     C     DScovtdt      Iflt      DSgbscd1
018300001127     C     DScovtdt      Iflt      DSgbscdt
018400001127      *---
018500010618      *?If less than three months prior to begindate, write to error report.
018600001127      *---
018700001127     C                   move      Gbscdt        Wwdate
018800001127     c     *ISO          move      Wwdate        Wddate1
018900010618     c     Wddate1       subdur    3:*m          gdtp1
019000001127     c                   move      gdtp1         gdtp1f            8 0
019100040714
019200040714      * skip errors < 1/1/02
019300040714     c                   if        covtdt > gdtp1f and
019400040714     c                             covtdt >= 20020101
019500001117     C                   Movel     PriMsg        Percon
019600001121     C     *ISO          Move      Covtdt        USA_Date
019700001117     C                   Exsr      ErrRtn
019800001121     C                   Goto      Eloop
019900001121     C                   Endif
020000001122     C                   Endif
020100001127     C                   Endif
020200001117
020300001211      *
020400001211     C     Bypass        Tag
020500001117     C     Covtdt        Ifgt      Gbscd1
020600001122      *---
020700010618      *?If the missing invoice date is less than the term date, it's an error.
020800010618     c*  ** only print errors after 1/1999 since the history file was
020900010618     c*     purged up to 1/1999
021000001122      *---
021100010710     C     Gbscd1        Iflt      Termdt
021200010710001s C     Termdt        oreq      *Zero
021300010618
021400010618     c                   if        gbscd1 > 19990131
021500001117     C                   Movel     InsMsg        Percon
021600001117     C     *ISO          Move      Gbscd1        USA_Date
021700001117     C                   Exsr      ErrRtn
021800010618     c                   end
021900010618
0220000012111211 C                   Exsr      Calgsr
0221000012111211 C                   Goto      Bypass
022200001122     C                   Endif
022300010710     C                   Endif
022400001117
0225000012111211 C     Covtdt        Ifle      Gbscd1
022600001117     C                   Exsr      Calgsr
0227000012111211 C                   Endif
022800001113
022900001108     C                   Endif
023000001109     C                   Endif
023100001121     C     Eloop         Tag
023200001107     C                   Enddo
023300001107
023400001120     C     Covtdt        Iflt      DSEN2
023500001117     C     Covtdt        Iflt      Cexpdt
023600001122     C     Gbscd1        Iflt      Termdt
023700001117     C                   Movel     MisMsg        Percon
023800001117     C     *ISO          Move      Gbscd1        USA_Date
023900001117     C                   Exsr      Errrtn
024000001122     C                   Endif
024100001117     C                   Endif
024200001117     C     Mbcand        Ifne      *zeros
024300001117     C     Covtdt        Iflt      Termdt
024400001117     C                   Movel     TerMsg        Percon
024500001117     C     *ISO          Move      Gbscd1        USA_Date
024600001120     C                   Exsr      ErrRtn
024700001117     C                   Endif
024800001117     C                   Endif
024900001117
025000001117     C                   Endif
025100000118     C                   ENDSR
025200000118      * ? _____________________________________________________________
025300000118      *? *                                                             *
025400001107      *? *  Process and write errors to a report.                      *
025500000118      *? *_____________________________________________________________*
025600001108     C     ErrRtn        BEGSR
025700000118
025800001211     C                   Move      'Y'           Errsw
025900001120     C                   Move      Mbtrst        Ptrst
026000001120     C                   Move      Mbsub#        Psub#
026100001120     C                   Move      Mbacct        Pacct
026200001120     C                   Move      Mbssno        Pmbr
026300001120     C     Mfname        CAT(P)    Mlname:1      Pacnam
026400001107     C                   Move      USA_Date      Peffdt
026500001113
026600001120     C     Termdt        Ifne      *zeros
026700001120     C     *ISO          Move      Termdt        USA_Date
026800001113     C                   Move      USA_Date      Pcandt
026900001113     C                   Endif
027000001107
027100001107     c     *in91         ifeq      *on
027200001107     C                   Write     Hdr
027300001107     C                   Write     Sub
027400001107     c                   move      *off          *in91
027500001107     c                   endif
027600001120     C     *ISO          Move      Gbscdt        USA_Date
027700001110     C                   Move      USA_Date      Pgbsdt
027701130429     c     Peffdt        mult      10000.0001    Peffdtymd         8 0
027702130429     C     Peffdtymd     Ifge      DOM_OH_ONE
027800001107     C                   Write     Dtl
027801130429     C                   exsr      writexldet
027802130429     C                   End
027900001109     C                   Move      *blanks       Percon
028000001110     C                   Clear                   Pexcdt
028100001113     C                   Clear                   Pcandt
028200001107
028300000118     C                   ENDSR
028400001108      * ? _____________________________________________________________
028500001108      *? *                                                             *
028600001108      *? *        Calculate month following GBS begin admin date.      *
028700001108      *? *                                                             *
028800001108      *? *        A range of dates are required starting from the      *
028900001108      *? *        GBS begin admin date and ending with the date that   *
029000001108      *? *        was invoiced for the trust.                          *
029100001108      *? *_____________________________________________________________*
029200001108     C     CalgSr        BEGSR
029300001108
029400001117     C                   move      gbscd1        Wwdate
029500001108     c     *ISO          move      Wwdate        Wddate1
029600001117     c     Wddate1       adddur    1:*m          gbsc1
029700001120     c                   move      gbsc1         gbscd1
029800001108
029900001108     C                   ENDSR
030000001117      * ? _____________________________________________________________
030100001117      *? *                                                             *
030200001117      *? * Determine last date invoice & place results in DSEND2       *
030300001117      *? *_____________________________________________________________*
030400001117     C     ContSR        BEGSR
030500001117
030600001117     C                   Move      B             Ctype
030700001117     C                   Move      Gbscd1        DSEN1
030800001120     C     Cloop         Tag
030900001120     C                   Move      DSEN1         Dsen1h
031000001120     C                   Move      Ds1yymm       Kccyymm
031100001120     C                   Move      Mbtrst        Ktrst
031200001117     C     C_key         Chain     Contrl
031300001117     C                   If        %Found(Contrl)
031400001120     C     Ciflg         Ifeq      'Y'
031500001120     C                   Move      DSEN1         DSEN2
031600001120      *---
031700001128      *?   Add 1 month to the CONTRL key to find last date invoiced.   *
031800001120      *---
031900001120     C                   Move      DSEN1         Wwdate
032000001120     C     *ISO          Move      Wwdate        Wddate1
032100001120     C     Wddate1       Adddur    1:*m          gbsc1
032200001120     C                   Move      gbsc1         DSEN1
032300001120
032400001117     C                   Goto      Cloop
032500001117     C                   Endif
032600001117     C                   Endif
032700001117
032800001117     C                   ENDSR
032900001117     C
032901130429     C*
032902130429     C*************************************************************
032903130429     C*                                                           *
032904130429     C* Write Spreadsheet Detail                                  *
032905130429     C*                                                           *
032906130429     C*************************************************************
032907130429     C     Writexldet    BegSr
032908130429
032909130429     c                   Clear                   ABR020FLD
032910130429     C                   Eval      ABR020FLD  = '"' +
032911130429     C                             %Trim(%Editw(MBSSNO:'0   -  -    ')) + csv +
032912130429     C                             %Trim(%Editw(PTSA:'0   -   -    '))  + csv +
032913130429     C                             %Trim(pacnam)                        + csv +
032914130429     C                             %Trim(%Editw(pgbsdt:'  /  /    '))   + csv +
032915130429     C                             %Trim(percon)                        + csv +
032916130429     C                             %Trim(%Editw(peffdt:'  /  /    '))   + csv +
032918130429     C                             %Trim(%Editw(pcandt:'  /  /    '))   + '" ,'
032919130429     C*
032920130429     C                   Write     ABR020XR
032921130429     C                   EndSr
032922130429     C*
032923130429     C/EJECT
032924130429     C*************************************************************
032925130429     C*                                                           *
032926130429     C* Write Spreadsheet heading                                 *
032927130429     C*                                                           *
032928130429     C*************************************************************
032929130429     C     Writexlhead   BEGSR
032930130429
032931130429     c                   Clear                   ABR020FLD
032932130429     C                   Eval      ABR020FLD = '"' + 'MEMBER     '  + csv +
032933130429     C                                              'ACCOUNT #   '  + csv +
032934130429     C                                              'MEMBER NAME '  + csv +
032935130429     C                                              'BEGIN ADMIN'   + csv +
032937130429     C                                              'ERROR'         + csv +
032938130429     C                                              'EFFECTIVE'     + csv +
032940130429     C                                              'CANCELLED'      + '",'
032941130429     C                   Write     ABR020XR
032942130429     C*
032943130429     C                   ENDSR
033000000118      * ? _____________________________________________________________
033100000118      *? *                                                             *
033200000118      *? *        Initialize.                                          *
033300000118      *? *_____________________________________________________________*
033400991116     C     *INZSR        BEGSR
033500001012
033600001108     C                   TIME                    TIME_DATE
033700001108     C     *MDY          MOVE      DATE          ISO_DATE2
033800001108     C                   MOVE      ISO_DATE2     CYMD
033900001211     C                   Move      'N'           Errsw             1
034000001108
034100001110     C                   move      CYMD          Wwdate
034200001110     c     *ISO          move      Wwdate        Wddate1
034300001110     c     Wddate1       subdur    3:*y          cymd1
034400001110     c                   move      cymd1         cymd3y            8 0
034401130429
034402130429     c     Wddate1       subdur    2:*y          cymd1
034403130429     c                   move      cymd1         DScymd2           8 0
034404130429     c                   Move      00000001      DOM_OH_ONE        8 0
034405130429     c                   Movel     DScymd2       DOM6              6 0
034406130429     c                   Movel     DOM6          DOM_OH_ONE
034407130429
034500001110
034600001117     C     H_KEY         KLIST
034700001117     C                   KFLD                    Hkey
034800001106
034900001117     C     HA_KEY        KLIST
035000001117     C                   KFLD                    A_Hkey
035100001117     C                   KFLD                    AVI
035200001117
035300001106     C     C_KEY         KLIST
035400001109     C                   KFLD                    Ctype
035500001106     C                   KFLD                    Keyfli
035600001107
035700001107     C                   Move      *On           *In91
035800001107
035801130429     C                   Exsr      Writexlhead
035900991020     C                   ENDSR
