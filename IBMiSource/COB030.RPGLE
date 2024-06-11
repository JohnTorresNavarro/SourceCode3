000100991207    ? *_________________________________________________________________________
000200991207    ? *
000300210924    ? *  Description:  Originally the Cobra Pending Cancellation Report
000400211005    ? *                but changed to the COBRA Balance Report
000500210924    ? *
000600210924      * 03/27/00 szz Flag members with a term date that
000700210924      *              have a plan cancel date with a '*'.
000800991217      *
0009000007130020 F* 07/13/00 DLK Change CARBC to look for BC or PHN, not just      *
0010000007130020 F*              "not equal blank". This is needed because other   *
0011000007130020 F*              carriers will be set up that are not BC or PHN.   *
001200010828     F*                                                                *
001300010828     F*  8/28/01 szz Modify the Getprv routine to begin reading the    *
001400010828     F*              history file from the date of the parameter       *
001500010828     F*              passed in, NOT the "previous" date.  This is      *
001600010828     F*              because we don't know what the "previous" month   *
001700010828     F*              is (it's not necessarily the month before the     *
001800010828     F*              date passed as the parameter).                    *
001900011012     F*                                                                *
002000011012     F* 10/12/01 szz Access the previous invoice only if the cobra     *
002100011012     F*              date has not expired.
0022001205170020 F* 05/17/12 DLK exclude test trust 888                            *
0023001610110020 F* 10/11/16 DLK Change CARBC to look for DBE                      *
0024002008200020 F* 08/20/20 dlk - fix inv# text search and add CSV output         *
0025002103020020 F* 03/02/21 dlk - add member address for mail merge               *
0026002109240020 F* 09/23/21 dlk - add COBRA paid through date and fix so many     *
0027002109240020 F*                things wrong that it turned into a redesign as  *
0028002109240020 F*                the COBRA Balance Report                        *
0029002201180020 F* 01/18/22 dlk - add carriers to report                          *
0030002109240020 F*                                                                *
0031002109230020 F******************************************************************
003200210924     FMEMBER    ip   e             DISK
003300210924y2k  Faccmst    IF   E           K DISK
003400220118     fmcov      if   e           k disk
003500220118     fhypercarr if   e           k disk
003600220118     fplnmst    if   e           k disk
003700220118     fcarmst    if   e           k disk
0038002008200017 Fcob030xl  o  a e             DISK
0039002008200125 D csv             c                   const('","')
0040002008200125 D tsa_o           s             12
0041002109240125 D csz_o           s             40
004200210924     D termdtmdy       S              8s 0
004300210924     D termdtusa       S               d   datfmt(*usa)
004400210924     D termdt_o        S             12
004500210924     D cptdtmdy        S              8s 0
004600210924     D cptdtusa        S               d   datfmt(*usa)
004700210924     D cptdt_o         S             12
004800210924     D cexpdtmdy       S              8s 0
004900210924     D cexpdtusa       S               d   datfmt(*usa)
005000210924     D gbscdtmdy       S              8s 0
005100210924     D gbscdtusa       S               d   datfmt(*usa)
005200210924     D citdtmdy        S              8s 0
005300210924     D citdtusa        S               d   datfmt(*usa)
005400210924     D paid_o          S                   like(parmcpay)
005500210924     D bill_o          S                   like(parmcpay)
005600211001     D adj_o           S                   like(parmcpay)
005700210924     D acname_o        S                   like(acnam1)
0058002109240125 D memnam_o        s             35
0059002109240125 D cobbal          s             10  2
0060002110010125 D bapvsb          s             10  2
0061002109240125 D repdat          s             25
006200210924     D sysdatmdy       S               d   datfmt(*usa)
006300220118     D sysdatymd       S               d   datfmt(*iso)
0064002110010037 D workdtymd       S               d   datfmt(*iso)
006500210924     D workd80         S              8s 0
006600210924     D systime         S               t
0067002110010037 D ssn_hkey        S             10
0068002110010037 D gbscdt_less1m   S              8s 0
0069002201180020 D car             S             30    DIM(10)
007000000324     D                UDS
0071002109240054 D* lssn                   9     17
007200000324     D  CONAME               201    240
007300210924
007400210924      * member's current cobra balance
007500210924       cobbal = prvbal + curbal;
007600210924
007700210924      * process all active, and cancelled with a balance
007800211003       if termdt = 0 or cobbal <> 0;
007900210924        exsr #process;
008000210924       endif;
008100210924
008200210924      ************************************************************
008300210924      * process this member
008400210924      ************************************************************
008500210924     c     #process      BEGSR
008600211003
008700211003      * skip test trust 888
008800211003       if mbtrst = 888;
008900211003       leavesr;
009000211003       endif;
009100210924
009200210924      * get account name
009300210924          clear acname_o;
009400210924         chain (mbtrst: mbsub#: mbacct) accmst;
009500210924         if %found(accmst);
009600210924          acname_o = acnam1;
009700210924         endif;
009800210924
009900210924      * format member name for output
010000210924        memnam_o = %trim(mfname) + ' ' + %trim(mlname);
010100210924
010200210924      * format acct for output
010300210924       clear tsa_o;
010400210924       tsa_o = %editc(mbtrst:'X') + '-' + %editc(mbsub#:'X') + '-' +
010500210924               %editc(mbacct:'X');
010600210924
010700210924      * member csz for output
010800210924       exsr #csz;
010900210924
011000210924      * cobra expiration date in mdy
011100210924     C                   MOVE      cexpdt        @DATIN
011200210924     C                   EXSR      #DATYM
011300210924     C                   MOVE      @DATOU        cexpdtmdy
011400210924
011500210924      * term date in mdy
011600210924     C                   MOVE      termdt        @DATIN
011700210924     C                   EXSR      #DATYM
011800210924     C                   MOVE      @DATOU        termdtmdy
011900210924      * only fill output field if not zero so the xls looks better
012000210924        clear termdt_o;
012100210924        if termdtmdy <> 0;
012200210924        termdt_o = %trim(%editc(termdtmdy:'Y'));
012300210924        endif;
012400210924
012500210924      * cobra begin admin
012600210924     C                   MOVE      gbscdt        @DATIN
012700210924     C                   EXSR      #DATYM
012800210924     C                   MOVE      @DATOU        gbscdtmdy
012900210924
013000210924      *
013100210924      * get cobra paid through date
013200210924      *
013300210924       clear cptdtmdy;
013400210924       clear citdtmdy;
013500210924       clear paid_o;
013600210924       parmssn = %editc(mbssno:'X');
013700210924       parmcptdate = *blanks;
013800210924       parmcitdate = *blanks;
013900211001       parmcinv    = *zeros;
014000211001       parmcadj    = *zeros;
014100211001       parmcpay    = *zeros;
014200210924       parmcpayovr = *blanks;
0143002109240694 c                   call      'GETPTCCL'
014400210924     c                   parm                    parmssn           9
014500210924     c                   parm                    parmcptdate       8
014600210924     c                   parm                    parmcitdate       8
014700211001     c                   parm                    parmcinv         11 2
014800211001     c                   parm                    parmcadj         11 2
014900211001     c                   parm                    parmcpay         11 2
015000210924     c                   parm                    parmcpayovr       1
015100210924
015200210924     C                   MOVE      parmcptdate   @DATIN
015300210924     C                   EXSR      #DATYM
015400210924     C                   MOVE      @DATOU        cptdtmdy
015500210924      * only fill output field if not zero so the xls looks better
015600210924        clear cptdt_o;
015700210924        if cptdtmdy <> 0;
015800210924        cptdt_o = %trim(%editc(cptdtmdy:'Y'));
015900210924        endif;
016000210924
016100210924      * invoiced through date in mdy
016200210924     C                   MOVE      parmcitdate   @DATIN
016300210924     C                   EXSR      #DATYM
016400210924     C                   MOVE      @DATOU        citdtmdy
016500211001      * invoiced amt
016600211001     C                   MOVE      parmcinv      bill_o
016700211001      * adj amt
016800211001     C                   MOVE      parmcadj      adj_o
016900211001      * paid amt
017000211001     C                   MOVE      parmcpay      paid_o
017100210924
017200211001      * Billed + Adj + Paid versus current Balance. When not zero
017300211001      * it means something was outside of the search for invoices,
017400211001      * adjustments and payments in the current period.
017500211001
017600211001        bapvsb = (bill_o + adj_o + paid_o) - cobbal;
017700210924
017800220118      *
017900220118      * find all carriers based on MCOV as of today or cancel date
018000220118      *
018100220118        clear car;
018200220118     c                   clear                   mcovfound         1
018300220118     c                   if        termdt = 0
018400220118     c                   move      sysdatymd     searchdt          8 0
018500220118     c                   else
018600220118     c                   move      termdt        searchdt
018700220118     c                   end
018800220118
018900220118     c                   exsr      #getcar
019000220118
019100220118      * if not found, try again with 1 day earlier
019200220118     c                   if        mcovfound = *blank
019300220118     c                   move      searchdt      workdtymd
019400220118     C                   subdur    1:*d          workdtymd
019500220118     C                   move      workdtymd     searchdt
019600220118     c                   exsr      #getcar
019700220118     c                   end
019800220118
019900220118
020000220118      * write spreadsheet detail line
020100210924        exsr writexldet;
020200210924      *
020300210924     C                   ENDSR
020400210924
020500210924     C************************************************************
020600210924     C* Format city state zip. Note USPS format is:
020700210924     C* CITY ST  99999-9999   (USPS prefers 2 spaces after state code)
020800210924     C************************************************************
020900210924     C*
021000210924     C     #csz          BEGSR
021100210302       clear csz_o;
021200210924       csz_o = %trim(city) + '  ' + state;
021300210302
021400210924     C                   MOVEL     zip           ZIP5              5
021500210924     C                   MOVE      zip           ZIP4              4
021600210303     C                   CAT       ZIP5:2        csz_o
021700210302     C                   IF        zip4 <> '0000'
021800210302     C                   CAT       '-':0         csz_o
021900210302     C                   CAT       ZIP4:0        csz_o
022000210302     C                   END
022100210302
022200210302     C                   ENDSR
022300210302
0224002201180069 C**************************************************************
022500220118JGE01C* get carriers
0226002201180069 C**************************************************************
022700220118JGE01   begsr #getcar;
022800220118
022900220118      * find all mcov active for the search date
023000220118           setll (mbssno) mcov;
023100220118           dou %eof(mcov);
023200220118           reade (mbssno) mcov;
023300220118           if (not %eof(mcov)) and (searchdt >= enrldt)
023400220118               and (candt = 0 or candt >= searchdt)
023500220118               and (candt <> enrldt);
023600220118              mcovfound = 'Y';
023700220118
023800220118      * get plan and carrier
023900220118           chain (mctrst : mcsub# : mcplan) plnmst;
024000220118            if %found(plnmst);
024100220118              chain (pcarr) carmst;
024200220118              if %found(carmst);
024300220118               chain (cgrpcd) hypercarr;
024400220118               exsr #storcar;
024500220118              endif;
024600220118            endif;
024700220118
024800220118           endif;
024900220118           enddo;
025000220118
025100220118           endsr;
025200220118
0253002201180351 C****************************************************************
0254002201180352 C*    STORE carrier group name                                  *
0255002201180354 C****************************************************************
025600220118     C     #storcar      BEGSR
025700220118
025800220118     C                   Z-ADD     1             X                 2 0
025900220118     C     #T0080        TAG
026000220118
026100220118     C                   IF        car(x) = *BLANKS
026200220118     C                   MOVE      hcname        car(X)
026300220118     C                   leavesr
026400220118     C                   ELSE
026500220118     c                   if        car(x) = hcname
026600220118     C                   leavesr
026700220118     C                   ELSE
026800220118     C                   ADD       1             X
026900220118     C*
027000220118     C     X             IFLE      10
027100220118     C                   GOTO      #T0080
027200220118     C                   END
027300220118
027400220118     C                   END
027500220118     C                   END
027600220118
027700220118     C                   ENDSR
027800220118
027900220118
0280002008200164 C*************************************************************
0281002008200164 C*                                                           *
0282002008200164 C* Write Spreadsheet Detail                                  *
0283002008200164 C*                                                           *
0284002008200164 C*************************************************************
028500210924       begsr Writexldet;
028600200820
028700210924       clear cob030fld;
028800210924       cob030fld  = '"' +
028900210924       %trim(repdat)                + csv +
029000210924       %trim(tsa_o)                 + csv +
029100210924       %trim(acname_o)              + csv +
029200210924       %trim(%editw(mbssno:'0   -  -    '))  + csv +
029300210924       %trim(memnam_o)              + csv +
029400210924       %trim(addr1)                 + csv +
029500210924       %trim(addr2)                 + csv +
029600210924       %trim(csz_o)                 + csv +
029700210924       %trim(%editc(bill_o:'N'))    + csv +
029800211001       %trim(%editc(adj_o:'N'))     + csv +
029900210924       %trim(%editc(paid_o:'N'))    + csv +
030000210924       %trim(%editc(cobbal:'N'))    + csv +
030100211001       %trim(%editc(bapvsb:'N'))     + csv +
030200210924       %trim(cptdt_o)               + csv +
030300210924       %trim(%editc(citdtmdy:'Y'))  + csv +
030400210924       %trim(%editc(gbscdtmdy:'Y')) + csv +
030500210924       %trim(%editc(cexpdtmdy:'Y')) + csv +
030600210924       %trim(termdt_o)              + csv +
030700220118       %trim((car(1)))              + csv +
030800220118       %trim((car(2)))              + csv +
030900220118       %trim((car(3)))              + csv +
031000220118       %trim((car(4)))              + csv +
031100220118       %trim((car(5)))              + csv +
031200220118       %trim((car(6)))              + csv +
031300220118       %trim((car(7)))              + csv +
031400220118       %trim((car(8)))              + csv +
031500220118       %trim((car(9)))              + csv +
031600220118       %trim((car(10)))             + csv +
031700210924       ' '        +
031800210924       '"';
031900210924
032000210924       Write cob030xr;
032100210924
0322002109240320   ENDSR;
032300210924
032400200820     C*************************************************************
032500200820     C*                                                           *
032600200820     C* Write Spreadsheet heading                                 *
032700200820     C*                                                           *
032800200820     C*************************************************************
032900200820     C     Writexlhead   BEGSR
033000200820
033100200820     c                   clear                   cob030fld
033200200820     C                   Eval      cob030fld = '"' +
033300210924     C                             'REPORT DATE & TIME'              + csv +
033400210924     C                             'ACCOUNT #'                       + csv +
033500210924     C                             'ACCOUNT NAME'                    + csv +
033600200820     C                             'SSN'                             + csv +
033700200820     C                             'NAME'                            + csv +
033800210302     C                             'ADDRESS 1'                       + csv +
033900210302     C                             'ADDRESS 2'                       + csv +
034000210302     C                             'CITY/ST/ZIP'                     + csv +
034100200820     C                             'BILLED'                          + csv +
034200211001     C                             'ADJ'                             + csv +
034300200820     C                             'PAID'                            + csv +
034400210924     C                             'CURR BALANCE'                    + csv +
034500211001     C                             'B+A+P vs BAL'                    + csv +
034600210924     C                             'PAID THROUGH'                    + csv +
034700210923     C                             'INV THROUGH'                     + csv +
034800210924     C                             'COBRA BEGIN'           + csv +
034900200820     C                             'COBRA ENDS'                      + csv +
035000200820     C                             'MEMBER TERM'                     + csv +
035100220118     C                             'CARRIER 1'           + csv +
035200220118     C                             'CARRIER 2'           + csv +
035300220118     C                             'CARRIER 3'           + csv +
035400220118     C                             'CARRIER 4'           + csv +
035500220118     C                             'CARRIER 5'           + csv +
035600220118     C                             'CARRIER 6'           + csv +
035700220118     C                             'CARRIER 7'           + csv +
035800220118     C                             'CARRIER 8'           + csv +
035900220118     C                             'CARRIER 9'           + csv +
036000220118     C                             'CARRIER 10'          + csv +
036100200820     C                             ' '                               +
036200200820     C                             '",'
036300200820     C                   Write     cob030xr
036400200820     C*
0365002008200320 C                   ENDSR
036600200820
0367002008200103 C***************************************************
0368002008200104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0369002008200105 C***************************************************
0370002008200107 C*
0371002008200107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0372002008200107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0373002008200107 C*
0374002008200106 C     #DATYM        BEGSR
037500200820     C                   MOVE      @DATIN        @MD               4 0
037600200820     C                   MOVEL     @DATIN        @Y                4 0
037700200820     C                   MOVEL     @MD           @DATOU            8 0
037800200820     C                   MOVE      @Y            @DATOU
037900200820     C                   MOVE      *ZEROS        @DATIN            8 0
0380002008200120 C                   ENDSR
038100210923
038200991210      *___________________________________________________________________
038300991210      * Program initialization
038400991210      *___________________________________________________________________
038500991210     C     *INZSR        BEGSR
038600000214      *
038700210924      * get system date and time
038800210924        sysdatmdy = %date();
038900220118        sysdatymd = %date();
039000210924        systime   = %time();
039100210924
039200210924       repdat  = %char(sysdatmdy) + ' ' + %char(systime);
039300200820     C                   exsr      Writexlhead
039400991210     C                   ENDSR
