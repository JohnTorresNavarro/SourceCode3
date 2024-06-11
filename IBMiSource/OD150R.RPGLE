000100140409     H option(*nodebugio) debug
000200990630      *? ***************************************************************
000300020523      *
000400100727      *             GROUP BENIFIT SERVICES SOFTWARE           2010     *
000500060829      *                                                                *
000600000118      *  Written by:    S. Zien                                        *
000700100727      *  Date Written:   7/27/10                                       *
000800100727      *  Description:   Generate work file for Senior Dental Final     *
000900100727      *                   Termination Letters                          *
001000000118      *                                                                *
001100000118      *                R E V I S I O N    H I S T O R Y                *
001200000118      *  Date                                                          *
001300000118      *  Revised   Initials    Revision                                *
001400000118      *  --------  --------    --------------------------------------  *
001500110222      *  2/22/2011   szz       Add Archive File for reprinting letters.*
001600020621      *                                                                *
001700110803      *  8/03/2011   szz       Add fields for additional Medicaid      *
001800110803      *                         states per Angie W.                    *
001900110803      *                        Replace ODOFCP with ODRGNP per Rick J.  *
002000110803      *                         since ODOFCP is no longer used.        *
002100120424      *  4/24/2012   szz       Add state of Indiana for trust 31.      *
002200130607      *  6/07/2013   szz       MD Regions are hard-coded.              *
002300131015      * 10/15/13 dlk  hist file expansion project
002400140409      * 04/09/2014   dpb       1)  clear field compnp before setll histl91.
002500140409      *                        2)  use setgt/readpe instead of setll/reade
002600140409      *                            for HISTL9 - in the event an acct has
002700140409      *                            been cancelled more than once on the
002800140409      *                            same day we want to use the last
002900140409      *                            cancellation.
003000180208      * 02/08/2018   jva       remove hard coded trusts and            *
003100180208      *                        separate SD/AM with PARM call           *
003200180307      * 03/07/2018   dlk       fix check for chain to trsmst           *
003300180410      * 04/10/2018   jva       use trust name as state                 *
003400990630      *? ***************************************************************
003500091029     FACCMST    IF   E           K Disk
003600180208     FTRSMST    IF   E           K Disk    extfile('F.TRSMST')
003700100727     FHISTL9    IF   E           K Disk
003800100920     F                                     INFDS(IODBFD)
003900100920     FHISTL91   IF   E           K Disk    Rename(HISTR:DACR) Prefix(X_)
004000100920     F                                     INFDS(IODBFDX)
004100100727     FHIST      O  A E           K Disk    Rename(HISTR:HSTR) Prefix(H_)
004200100727     FMCOVX     IF   E           K Disk    Rename(MCOVR:XR) Prefix(X)
004300100727     FODFACP    IF   E           K Disk
004400110803     F****ODOFCP    IF   E           K DISK
004500110803     FODRGNP    IF   E           K Disk
004600100727     FODCNTCP   IF   E           K Disk
004700100728     FSUBMST    IF   E           K Disk
004800100914     FACCMSP    IF   E           K Disk
004900100915     FMEMBER    IF   E           K Disk
005000100915     FCODES     IF   E           K Disk
0051001007270021 FOD170OUT  O  A E             DISK
005200101202     FOD150OUT  UF A E           K Disk
005300110222     FOD170ARC  O  A E             Disk
005400110222     FOD150ARC  O  A E             Disk
005500010326
005600100917     D IODBFD        E DS                  Extname(IODBFD)
005700100917     D  #RRN                 397    400B 0
005800100920
005900100920     D IODBFDX       E DS                  Extname(IODBFD) Prefix(X)
006000100920     D  #RRNX                397    400B 0
006100100920
0062001007280050 D  FmtTodayIn     DS
0063001007280054 D  YYin                   1      4
0064001007280052 D  MOin                   5      6  0
0065001007280053 D  DDin                   7      8
006600100728
0067001007280050 D  FmtToday       DS
0068001007280052 D  MO##                   1      2  0
0069001007280053 D  DD##                   3      4
0070001007280054 D  YY##                   5      8
007100100728
007200100727     D DAC             S              3    inz('DAC')
007300100727     D NonPay          S              6    inz('TC= NP')
007400100727     D BOM             S              3    inz('BOM')
007500100727     D ARP             S              3    inz('ARP')
007600100727     D SAD             S              3    inz('SAD')
007700100727     D Zero4           S              4s 0 inz
007800100915     D TypeD           S              1    inz('D')
007900100915     D CodeNP          S              2    inz('NP')
0080001310150037 D sysdateymd      S               d   datfmt(*iso)
008100131015     D thispgmname     S             10a   inz('OD150R    ')
008200061017     D                UDS
008300131015     D LUSER                  10     19
008400061017
008500100727     D ErrorMsg        C                   'Sample Error Message.'
008600060816      *
008700090904     C
008800140409     C     HstKey        Setgt     HISTL9
008900140409     C     HstKey        readpe    HISTL9
009000100727     C                   Dow       Not %Eof(HISTL9)
009100100727     C                   If        Not %Eof(HISTL9)
009200100727     C     AccKey        Chain     ACCMST
009300100727     C                   If        %Found(ACCMST)
009400100727     c                   If        ASPHFL = 'F' Or
009500100727     C                             ASPHFL = 'D' or
009600100727     C                             ASPHFL = 'P'
009700100920      * Hold the Hist RRN to compare if there are other DACs for same day.
009800100920     C                   Z-add     #RRN          HoldNP            8 0
009900180208
010000180208     C     ACTRST        Chain     TRSMST
010100180307     C                   If        not %Found(TRSMST)
010200180410     C                   clear                   TSCODE
010300180410     C                   clear                   TNAME
010400180208     C                   end
010500180208
010600140409     C                   clear                   compnp
010700100917     C     HsDKey        Setll     HISTL91
010800100917     C     HsDKey        Reade     HISTL91
010900100917     C                   If        Not %Eof(HISTL91)
011000100917      *
011100100917     C*** Compare RRN between NP history record and non-NP history reco
011200100920     C                   Z-add     #RRNX         CompNP            8 0
011300100917      *
011400100917     C                   End
011500100920      *
011600100920     C                   If        CompNP    =   *Zero   Or
011700180425     C                             CompNP    <   HoldNP
011800100805     C                   If        ATRMDT    <>  *Zero
011900100727     C                   Exsr      Process
012000100727     C                   End
012100100920     C                   End
012200100727     C                   End
012300100727     C                   End
012400140409     C                   readpe    HISTL9
012500100727     C                   End
012600061010     C                   EndDo
012700060817     C                   Eval      *InLR     =   *On
012800010403
012900060817      *---------------------------------------------------------------*
013000061010     C     Process       Begsr
013100060817      *---------------------------------------------------------------*
013200180208      * stay if SD run and is SD
013300180208      * stay if AM run and is AM
013400180208      * leave for all others
013500180208     C                   Select
013600180208     C                   when      TSCODE = 'O N' and wiwho = 'SD'
013700180208     C                   when      TSCODE = 'O M' and wiwho = 'AM'
013800180208     C                   Other
013900180208     C                   LeaveSR
014000180208     C                   Endsl
014100100727
014200100727      * Facility Name
014300100727     C                   Clear                   O7NHNM
014400100727     c     SubKey        Chain     SUBMST
014500100727     c                   If        %Found(SUBMST)
014600180417     c                   Eval      O7NHNM  =  %Trim(SUBDSC)
014700100727     c                   End
014800100727
014900100727      * BOM (Business Office Manager)
015000100727     C                   Clear                   O7BOM
015100100727     c     OdKey         Setll     ODCNTCP
015200100727     c                   Dou       %eof(ODCNTCP)
015300100727     c     OdKey         Reade     ODCNTCP
015400100727     c                   If        Not %Eof(ODCNTCP) and Today  >= OCEFF And
015500100727     c                             (OCTRM = 0 or OCTRM > Today)
015600100727     C                   Eval      O7BOM   =  %Trim(OCFNAM) + ' ' +
015700100727     C                                        %Trim(OCLNAM)
015800100727     c                   Eval      O7NHA1  =  %Trim(OCADD1)
015900100727     c                   Eval      O7NHA2  =  %Trim(OCADD2)
016000100727     c                   Eval      O7NHCZ  =  %Trim(OCCITY) + ', ' +
016100100727     C                                        %Trim(OCST)   + '  ' +
016200100727     C                                        %TRim(OCZIP)
016300100727     c                   Leave
016400100727     c                   End
016500100727     c                   EndDo
016600100727
016700100727      *Load the data to the file that will be used in RPG_WORD
016800100727     c                   Eval      O7TRST  =  HSTRST
016900100727     c                   Eval      O7SUB#  =  HSSUB#
017000100727     c                   Eval      O7ACCT  =  HSACCT
017100100727     c                   Eval      O7PYFL  =  ASPHFL
017200100727     c                   Eval      O7LTYP  =  'F'
017300100727     C                   Move      HSTRST        wktrsta           3
017400100727     C                   Move      HSSUB#        wksub#a           3
017500100727     C                   Move      HSACCT        wkaccta           4
017600100727     C                   Move      *Blanks       wktsaa           10
017700100727     C                   Eval      wktsaa  =  wktrsta + wksub#a + wkaccta
017800100727     C                   Move      wktsaa        O7TSA
017900100727      *
018000100727      * Get Responsible Party aka Family Representative aka Authorized Rep
018100100727      *
018200100727     C     OdarpKey      Setll     ODCNTCP
018300100727     c                   Dou       %Eof(ODCNTCP)
018400100727     C     OdarpKey      Reade     ODCNTCP
018500100727     C                   If        Not %Eof(ODCNTCP)   And
018600100727     c                                 COVTDT >= OCEFF And
018700100727     c                             (OCTRM = 0 Or OCTRM > COVTDT)
018800100727     c                   Eval      O7RPNM  =  %Trim(OCFNAM) + ' ' +
018900100727     C                                        %Trim(OCLNAM)
019000100727     c                   Eval      O7ADD1  =  %Trim(OCADD1)
019100100727     c                   Eval      O7ADD2  =  %Trim(OCADD2)
019200100727     c                   Eval      O7CSZ   =  %Trim(OCCITY) + ', ' +
019300100727     C                                        %Trim(OCST)   + '  ' +
019400100727     C                                        %TRim(OCZIP)
019500100727     C                   Leave
019600100727     C                   Else
019700100727     C                   Eval      O7RPNM = 'Attn: Responsible Party'
019800100727     C                   End
019900100727     C                   EndDo
020000100727     C                   Eval      Noacct  =  *Zeros
020100100727      *
020200100727      * Get Nursing Home Administrator
020300100727      *
020400100727     C     OdsadKey      Setll     ODCNTCP
020500100727     c                   Dou       %Eof(ODCNTCP)
020600100727     C     OdsadKey      Reade     ODCNTCP
020700100727     C                   If        Not %Eof(ODCNTCP)   And
020800100727     c                                 COVTDT >= OCEFF and
020900100727     c                             (OCTRM = 0 or OCTRM > COVTDT)
021000100727     c                   Eval      O7NHAD  =  %Trim(OCFNAM) + ' ' +
021100100727     C                                        %Trim(OCLNAM)
021200100727     c                   Eval      O7NHA1  =  %Trim(OCADD1)
021300100727     c                   Eval      O7NHA2  =  %Trim(OCADD2)
021400100727     c                   Eval      O7NHCZ  =  %Trim(OCCITY) + ', ' +
021500100727     C                                        %Trim(OCST)   + '  ' +
021600100727     C                                        %TRim(OCZIP)
021700100727     C                   Eval      O7TITL  =  %Trim(OCTITL)
021800100727     C                   Leave
021900100727      * No SAD on file
022000100727     C                   Else
022100100727     C                   Eval      O7NHAD  =  'Attn: Nursing Home Administrator'
022200100727     C     SubKey        Chain     ODFACP
022300100727     C                   If        %Found(ODFACP)
022400100728     C                   Eval      O7NHA1  =  %Trim(S2ADD1)
022500100728     C                   Eval      O7NHA2  =  %Trim(S2ADD2)
022600100728     C                   Eval      O7NHCZ  =  %Trim(S2CITY) + ', ' +
022700100727     C                                        %Trim(S2ST)   + '  ' +
022800100727     C                                        %TRim(S2ZIP)
022900100727     C                   End
023000100727     C                   End
023100100727     C                   EndDo
023200100727      *
023300100728     C                   Eval      O7RENM  =  %Trim(ACNAM1)
023400100728     C                   Movel     HKEY          O7TSA
023500100728     C     AccKey        Chain     MCOVX
023600100727     C                   If        %Found(MCOVX)
023700100727     C                   Eval      O7SSNO  =  XMCSSNO
023800100727     C                   Else
023900100727     C                   Clear                   O7SSNO
024000100727     C                   End
024100100727      * Format letter date
024200100728     C                   Movel     Today         FmtTodayIn
024300100728     C                   Move      MOin          MO##
024400100728     C                   Move      DDin          DD##
024500100728     C                   Move      YYin          YY##
024600100727     C                   Select
024700100727     C                   When      MO##       =  01
024800100727     C                   Eval      O7DATE     = 'January ' + DD## + ', ' + YY##
024900100727     C                   Eval      O7PDMO     = %Trim('January')
025000100727     C                   When      MO##       =  02
025100100727     C                   Eval      O7DATE     = 'February ' + DD## + ', ' + YY##
025200100727     C                   Eval      O7PDMO     = %Trim('February')
025300100727     C                   When      MO##       =  03
025400100727     C                   Eval      O7DATE     = 'March ' + DD## + ', ' + YY##
025500100727     C                   Eval      O7PDMO     = %Trim('March')
025600100727     C                   When      MO##       =  04
025700100727     C                   Eval      O7DATE     = 'April ' + DD## + ', ' + YY##
025800100727     C                   Eval      O7PDMO     = %Trim('April')
025900100727     C                   When      MO##       =  05
026000100727     C                   Eval      O7DATE     = 'May '   + DD## + ', ' + YY##
026100100727     C                   Eval      O7PDMO     = %Trim('May')
026200100727     C                   When      MO##       =  06
026300100727     C                   Eval      O7DATE     = 'June '  + DD## + ', ' + YY##
026400100727     C                   Eval      O7PDMO     = %Trim('June')
026500100727     C                   When      MO##       =  07
026600100727     C                   Eval      O7DATE     = 'July '  + DD## + ', ' + YY##
026700100727     C                   Eval      O7PDMO     = %Trim('July')
026800100727     C                   When      MO##       =  08
026900100727     C                   Eval      O7DATE     = 'August ' + DD## + ', ' + YY##
027000100727     C                   Eval      O7PDMO     = %Trim('August')
027100100727     C                   When      MO##       =  09
027200100727     C                   Eval      O7DATE     = 'September ' + DD## + ', ' +
027300100727     C                                                         YY##
027400100727     C                   Eval      O7PDMO     = %Trim('September')
027500100727     C                   When      MO##       =  10
027600100727     C                   Eval      O7DATE     = 'October ' + DD## + ', ' + YY##
027700100727     C                   Eval      O7PDMO     = %Trim('October')
027800100727     C                   When      MO##       =  11
027900100727     C                   Eval      O7DATE     = 'November ' + DD## + ', ' + YY##
028000100727     C                   Eval      O7PDMO     = %Trim('November')
028100100727     C                   When      MO##       =  12
028200100727     C                   Eval      O7DATE     = 'December ' + DD## + ', ' + YY##
028300100727     C                   Eval      O7PDMO     = %Trim('December')
028400100727     C                   Endsl
028500100727      * Format Month/Year
028600100727     C                   Move      *Blanks       FmtDate           8
028700100727     C                   Move      COVTDT        FmtDate
028800100727     C                   Movel     FmtDate       lychar            4
028900100727     C                   Move      FmtDate       md                4
029000100727     C                   Movel     md            lmc               2
029100100727     C                   Select
029200100727     C                   When      %trim(lmc) = '01'
029300100727     C                   Eval      O7MMYY     = 'January' + ' ' + lychar
029400100727     C                   Eval      O7PDMO     = %Trim('January')
029500100727     C                   When      %trim(lmc) = '02'
029600100727     C                   Eval      O7MMYY     = 'February' + ' ' + lychar
029700100727     C                   Eval      O7PDMO     = %Trim('February')
029800100727     C                   When      %trim(lmc) = '03'
029900100727     C                   Eval      O7MMYY     = 'March' + ' ' + lychar
030000100727     C                   Eval      O7PDMO     = %Trim('March')
030100100727     C                   When      %trim(lmc) = '04'
030200100727     C                   Eval      O7MMYY     = 'April' + ' ' + lychar
030300100727     C                   Eval      O7PDMO     = %Trim('April')
030400100727     C                   When      %trim(lmc) = '05'
030500100727     C                   Eval      O7MMYY     = 'May'   + ' ' + lychar
030600100727     C                   Eval      O7PDMO     = %Trim('May')
030700100727     C                   When      %trim(lmc) = '06'
030800100727     C                   Eval      O7MMYY     = 'June'  + ' ' + lychar
030900100727     C                   Eval      O7PDMO     = %Trim('June')
031000100727     C                   When      %trim(lmc) = '07'
031100100727     C                   Eval      O7MMYY     = 'July'  + ' ' + lychar
031200100727     C                   Eval      O7PDMO     = %Trim('July')
031300100727     C                   When      %trim(lmc) = '08'
031400100727     C                   Eval      O7MMYY     = 'August' + ' ' + lychar
031500100727     C                   Eval      O7PDMO     = %Trim('August')
031600100727     C                   When      %trim(lmc) = '09'
031700100727     C                   Eval      O7MMYY     = 'September' + ' ' + lychar
031800100727     C                   Eval      O7PDMO     = %Trim('September')
031900100727     C                   When      %trim(lmc) = '10'
032000100727     C                   Eval      O7MMYY     = 'October' + ' ' + lychar
032100100727     C                   Eval      O7PDMO     = %Trim('October')
032200100727     C                   When      %trim(lmc) = '11'
032300100727     C                   Eval      O7MMYY     = 'November' + ' ' + lychar
032400100727     C                   Eval      O7PDMO     = %Trim('November')
032500100727     C                   When      %trim(lmc) = '12'
032600100727     C                   Eval      O7MMYY     = 'December' + ' ' + lychar
032700100727     C                   Eval      O7PDMO     = %Trim('December')
032800100727     C                   Endsl
032900100831     C                   Write     ODR                                  99
033000110222     C                   Exsr      WriteArchive
033100100914     C                   Exsr      PrepMed
033200101202     C     OD5Key        Chain     OD150OUT
033300101202     C                   If        Not %Found(OD150OUT)
033400100914     C                   Write     OD5R
033500110222     C                   Exsr      WriteArchive5
033600100831     C                   If        *In99     =   *Zero
033700100728     C                   Exsr      WriteHis
033800100831     C                   End
033900101202     C                   End
034000100727     C                   Clear                   ODR
034100090909     C                   EndSr
034200070111      *
034300100914    ? *___________________________________________________________________
034400100914    ? * Prepare fields for Medicaid form (OD150OUT)
034500100914    ? *___________________________________________________________________
034600100914    ?C     PrepMed       Begsr
034700100914     C                   Eval      O5TRST  =  HSTRST
034800100914     C                   Eval      O5SUB#  =  HSSUB#
034900100914     C                   Eval      O5ACCT  =  HSACCT
035000100917     C                   Eval      O5LTYP  =  'F'
035100100917     C                   Eval      O5PYFL  =  ASPHFL
035200180410      * Use trust name from the TRSMST file
035300180410     C                   Eval      O5STAT  =  %trim(TNAME)
035400101014      * Per Angie:  Use the Trust for State
035500180410     C***                Select
035600180410     C***                When      HSTRST  =  025
035700180410     C***                Eval      O5STAT  =  'FL'
035800180410     C***                When      HSTRST  =  026
035900180410     C***                Eval      O5STAT  =  'MD'
036000180410     C***                When      HSTRST  =  027
036100180410     C***                Eval      O5STAT  =  'GA'
036200180410     C***                When      HSTRST  =  028
036300180410     C***                Eval      O5STAT  =  'NJ'
036400180410     C***                When      HSTRST  =  029
036500180410     C***                Eval      O5STAT  =  'OH'
036600180410     C***                When      HSTRST  =  030
036700180410     C***                Eval      O5STAT  =  'TX'
036800180410     C***                When      HSTRST  =  031
036900180410     C***                Eval      O5STAT  =  'IN'
037000180410     C***                Other
037100180410     C***                Eval      O5STAT  =  %trim(TNAME)
037200180410     C***                EndSl
037300100921     C     SubKey        Chain     ODFACP
037400110803     C     OfcKey        Chain     ODRGNP
037500110803     C                   If        %Found(ODRGNP)
037600100921     C                   Eval      O5REGN  =  MOOLOC
037700100921     C                   Else
037800100921     C                   Eval      O5REGN  =  *Blanks
037900130607     C                   Exsr      MarylandReg
038000100921     C                   End
038100100914     C                   Eval      O5RENM  =  ACNAM1
038200100914     C                   Eval      O5SSNO  =  XMCSSNO
038300100914     C     AccKey        Chain     ACCMSP
038400100914     C                   If        %Found(ACCMSP)
038500100915     C                   Movel     AMMAID        O5MEDI
038600100914     C                   End
038700100915      * Notice Date
038800100915     C     Today         Mult      10000.0001    Todayform         8 0
038900100916     C                   Move      TodayForm     FmtToday
039000100917     C                   Movel     MO##          MOa
039100100917     C                   Eval      O5NODT   =    %Trim(MOa + '/' + DD## +
039200100917     C                                           '/' + YY##)
039300100914      * Birth Date
039400100915     C     XMCSSNO       Chain     MEMBER
039500100915     C                   If        %Found(MEMBER)
039600100917     C     BIRTH         Mult      10000.0001    BirthForm         8 0
039700100917     C                   Move      BirthForm     FmtToday
039800100917     C                   Movel     MO##          MOa               2
039900100917     C                   Eval      O5DOB    =    %Trim(MOa + '/' + DD## +
040000100917     C                                           '/' + YY##)
040100100915     C                   End
040200100914      * Effective Date of Termination
040300100917     C     ATRMDT        Mult      10000.0001    AtrmdtForm        8 0
040400100917     C                   Move      AtrmdtForm    FmtToday
040500100917     C                   Movel     MO##          MOa
040600100917     C                   Eval      O5TRDT   =    %Trim(MOa + '/' + DD## +
040700100917     C                                           '/' + YY##)
040800100914     C                   Move      wktsaa        O5TSA
040900100914     C                   EndSr
041000090904    ? *___________________________________________________________________
041100100727    ? * Write a Final Termination Letter History Record
041200090904    ? *___________________________________________________________________
041300090904    ?C     WriteHis      Begsr
041400100727     C                   Movel     HKEY          H_HKEY
041500100728     C                   Eval      H_TRCODE  =   'U70'
041600100727     C                   Eval      H_TRDATE  =   Today
041700100727     C                   Eval      H_HSTRST  =   HSTRST
041800100728     C                   Eval      H_HSSUB#  =   HSSUB#
041900100727     C                   Eval      H_HSACCT  =   HSACCT
042000131015     c                   eval      h_hprgnm = thispgmname
042100100727     C                   Eval      H_HSDLTD  =   'A'
042200100728     C                   Eval      H_HOPER   =   %Trim('ROBOT')
042300100727     C                   Eval      H_COVTDT  =   COVTDT
042400131015     C                   eval      sysdateymd = %date
042500131015     C                   MOVE      sysdateymd    h_trdate
042600131015     c                   eval      h_hstrtime = %time
042700101202     C*************      If        *InU1     =   *On
042800100727     C                   Write     HSTR
042900100728     C                   Clear                   HSTR
043000101202     C*************      End
043100090904    ?C                   Endsr
043200110222      * ? _____________________________________________________________
043300110222      *? *                                                             *
043400110222      *? * Write all data fields to the Final Term NONPAYMENT Archive  *
043500110222      *? *_____________________________________________________________*
043600110222     C     WriteArchive  BEGSR
043700110222      *
043800110222     C                   Eval      A7TRST = O7TRST
043900110222     C                   Eval      A7SUB# = O7SUB#
044000110222     C                   Eval      A7ACCT = O7ACCT
044100110222     C                   Eval      A7LTYP = O7LTYP
044200110222     C                   Eval      A7PYFL = O7PYFL
044300110222     C                   Eval      A7RPNM = O7RPNM
044400110222     C                   Eval      A7ADD1 = O7ADD1
044500110222     C                   Eval      A7ADD2 = O7ADD2
044600110222     C                   Eval      A7CSZ  = O7CSZ
044700110222     C                   Eval      A7RENM = O7RENM
044800110222     C                   Eval      A7TSA  = O7TSA
044900110222     C                   Eval      A7BOM  = O7BOM
045000110222     C                   Eval      A7TITL = O7TITL
045100110222     C                   Eval      A7NHNM = O7NHNM
045200110222     C                   Eval      A7NHA1 = O7NHA1
045300110222     C                   Eval      A7NHA2 = O7NHA2
045400110222     C                   Eval      A7NHCZ = O7NHCZ
045500110222     C                   Eval      AUTBAL = OUTBAL
045600110222     C                   Eval      A7DATE = O7DATE
045700110222     C                   Eval      A7MMYY = O7MMYY
045800110222     C                   Eval      A7NHAD = O7NHAD
045900110222     C                   Eval      A7SSNO = O7SSNO
046000110222     C                   Eval      A7PBAL = O7PBAL
046100110222     C                   Eval      A7CDUE = O7CDUE
046200110222     C                   Eval      A7TDUE = O7TDUE
046300110222     C                   Eval      A7PDMO = O7PDMO
046400110222     C                   Eval      A7CUMO = O7CUMO
046500110222     C                   Eval      A7DESC =  %Trim('Final Term +
046600110222     C                                             NONPAYMENT Letter')
046700110222     C     *Date         Mult      10000.0001    A7LDT
046800110222     C                   Write     ODRA
046900110222     C                   Clear                   ODRA
047000110222      *
047100110222     C                   EndSr
047200110222      * ? _____________________________________________________________
047300110222      *? *                                                             *
047400110222      *? *  Write All Data Fields to the Medicaid Form Archive File    *
047500110222      *? *_____________________________________________________________*
047600110222     C     WriteArchive5 BEGSR
047700110222      *
047800110222      *
047900110222      * Medicaid Form Archive File
048000110222     C                   Eval      A5TRST    =   O5TRST
048100110222     C                   Eval      A5SUB#    =   O5SUB#
048200110222     C                   Eval      A5ACCT    =   O5ACCT
048300110222     C                   Eval      A5LTYP    =   O5LTYP
048400110222     C                   Eval      A5PYFL    =   O5PYFL
048500110222     C                   Eval      A5STAT    =   O5STAT
048600110222     C                   Eval      A5REGN    =   O5REGN
048700110222     C                   Eval      A5RENM    =   O5RENM
048800110222     C                   Eval      A5SSNO    =   O5SSNO
048900110222     C                   Eval      A5MEDI    =   O5MEDI
049000110222     C                   Eval      A5DOB     =   O5DOB
049100110222     C                   Eval      A5TERE    =   O5TERE
049200110222     C                   Eval      A5TRDT    =   O5TRDT
049300110222     C                   Eval      A5NODT    =   O5NODT
049400110222     C                   Eval      A5TSA     =   O5TSA
049500110222     C                   Eval      A5DESC    =   %Trim('Medicaid Form')
049600110222     C     *Date         Mult      10000.0001    A5LDT
049700110222     C                   Write     OD5RA
049800110222     C                   Clear                   OD5RA
049900110222      *
050000110222     C                   EndSr
050100130607    ? *___________________________________________________________________
050200130607    ? * Get Maryland County info for Maryland Regions
050300130607    ? *___________________________________________________________________
050400130607    ?C     MarylandReg   Begsr
050500130607    ? *
050600130607      * For MD (026) use County Description for Region District
050700130607     C                   If        O5TRST  = 026
050800130607     C                   Select
050900130607     C                   When      ACONTY  = 'AL'
051000130607     C                   Eval      O5REGN  = %Trim('ALLEGANY COUNTY')
051100130607     C                   When      ACONTY  = 'AA'
051200130607     C                   Eval      O5REGN  = %Trim('ANNE ARUNDEL COUNTY')
051300130607     C                   When      ACONTY  = 'BL'
051400130607     C                   Eval      O5REGN  = %Trim('BALTIMORE COUNTY')
051500130607     C                   When      ACONTY  = 'BC'
051600130607     C                   Eval      O5REGN  = %Trim('BALTIMORE CITY')
051700130607     C                   When      ACONTY  = 'CV'
051800130607     C                   Eval      O5REGN  = %Trim('CALVERT COUNTY')
051900130607     C                   When      ACONTY  = 'CL'
052000130607     C                   Eval      O5REGN  = %Trim('CAROLINE COUNTY')
052100130607     C                   When      ACONTY  = 'CR'
052200130607     C                   Eval      O5REGN  = %Trim('CARROLL COUNTY')
052300130607     C                   When      ACONTY  = 'CC'
052400130607     C                   Eval      O5REGN  = %Trim('CECIL COUNTY')
052500130607     C                   When      ACONTY  = 'CH'
052600130607     C                   Eval      O5REGN  = %Trim('CHARLES COUNTY')
052700130607     C                   When      ACONTY  = 'DR'
052800130607     C                   Eval      O5REGN  = %Trim('DORCHESTER COUNTY')
052900130607     C                   When      ACONTY  = 'FR'
053000130607     C                   Eval      O5REGN  = %Trim('FREDERICK COUNTY')
053100130607     C                   When      ACONTY  = 'GR'
053200130607     C                   Eval      O5REGN  = %Trim('GARRETT COUNTY')
053300130607     C                   When      ACONTY  = 'HR'
053400130607     C                   Eval      O5REGN  = %Trim('HARFORD COUNTY')
053500130607     C                   When      ACONTY  = 'HW'
053600130607     C                   Eval      O5REGN  = %Trim('HOWARD COUNTY')
053700130607     C                   When      ACONTY  = 'KN'
053800130607     C                   Eval      O5REGN  = %Trim('KENT COUNTY')
053900130607     C                   When      ACONTY  = 'MG'
054000130607     C                   Eval      O5REGN  = %Trim('MONTGOMERY COUNTY')
054100130607     C                   When      ACONTY  = 'PG'
054200130607     C                   Eval      O5REGN  = 'PRINCE GEORGE' + '''' + 'S COUNTY'
054300130607     C                   When      ACONTY  = 'QA'
054400130607     C                   Eval      O5REGN  = 'QUEEN ANNE' + '''' + 'S COUNTY'
054500130607     C                   When      ACONTY  = 'SM'
054600130607     C                   Eval      O5REGN  = 'ST. MARY' + '''' + 'S COUNTY'
054700130607     C                   When      ACONTY  = 'SS'
054800130607     C                   Eval      O5REGN  = %Trim('SOMERSET COUNTY')
054900130607     C                   When      ACONTY  = 'SV'
055000130607     C                   Eval      O5REGN  = %Trim('SAVA -BALT, AA, PG COUNTY')
055100130607     C                   When      ACONTY  = 'TB'
055200130607     C                   Eval      O5REGN  = %Trim('TALBOTT COUNTY')
055300130607     C                   When      ACONTY  = 'WH'
055400130607     C                   Eval      O5REGN  = %Trim('WASHINGTON COUNTY')
055500130607     C                   When      ACONTY  = 'WC'
055600130607     C                   Eval      O5REGN  = %Trim('WICOMICO COUNTY')
055700130607     C                   When      ACONTY  = 'WR'
055800130607     C                   Eval      O5REGN  = %Trim('WORCESTER COUNTY')
055900130607     C                   EndSl
056000130607     C                   End
056100130607     C                   EndSr
056200090903    ? *___________________________________________________________________
056300090903    ? * Klists
056400090903    ? *___________________________________________________________________
056500090904    ?C     KList         Begsr
056600090909    ? *
056700090909     C     HstKey        Klist
056800100728     C                   Kfld                    Today
056900100727     C                   Kfld                    DAC
057000100727     C                   Kfld                    NonPay
057100100917    ? *
057200100917     C     HsDKey        Klist
057300100917     C                   Kfld                    HKEY
057400100917     C                   Kfld                    Today
057500100727    ? *
057600100727     C     AccKey        Klist
057700100727     C                   Kfld                    HSTRST
057800100727     C                   Kfld                    HSSUB#
057900100727     C                   Kfld                    HSACCT
058000090903      *
058100100727     C     SubKey        Klist
058200100727     C                   Kfld                    HSTRST
058300100727     C                   Kfld                    HSSUB#
058400100727     C*
058500100727     C     OdKey         Klist
058600100727     C                   Kfld                    HSTRST
058700100727     C                   Kfld                    HSSUB#
058800100727     C                   Kfld                    Zero4
058900100727     C                   Kfld                    BOM
059000100727     C*
059100100727     C     OdarpKey      Klist
059200100727     C                   Kfld                    HSTRST
059300100727     C                   Kfld                    HSSUB#
059400100727     C                   Kfld                    HSACCT
059500100727     C                   Kfld                    ARP
059600100727     C*
059700100727     C     OdsadKey      Klist
059800100727     C                   Kfld                    HSTRST
059900100727     C                   Kfld                    HSSUB#
060000100727     C                   Kfld                    Noacct            4 0
060100100727     C                   Kfld                    SAD
060200100915     C*
060300100915     C     CodKey        Klist
060400100915     C                   Kfld                    TypeD             1
060500100915     C                   Kfld                    CodeNP            2
060600100921      *
060700100921     C     OfcKey        klist
060800100921     C                   kfld                    S2TRST
060900100921     C                   kfld                    S2OFC#
061000101202    ? *
061100101202     C     OD5Key        Klist
061200101202     C                   Kfld                    O7LTYP
061300101202     C                   Kfld                    O7PYFL
061400101202     C                   Kfld                    HSTRST
061500101202     C                   Kfld                    HSSUB#
061600101202     C                   Kfld                    HSACCT
061700100921      *
061800100727     C*
061900090903    ?C                   Endsr
062000090903    ? *___________________________________________________________________
062100090903     C     *Inzsr        BEGSR
062200090903    ? *___________________________________________________________________
062300180208
062400180208     C     *entry        plist
062500180208     C                   parm                    wiwho             2
062600180208
062700130515     C     *Date         Mult      10000.0001    Today             8 0
062800190510     C****               z-add     20190509      Today             8 0
062900100915     C     CodKey        Chain     CODES
063000100915     C                   If        %Found(CODES)
063100100915     C                   Eval      O5TERE      = SDESCR
063200100915     C                   End
063300100727     C                   EndSr
063400010412
063500010403     C/EJECT
