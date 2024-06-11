000100020621     H*Indent ('| ')
000200990630      *? ***************************************************************
000300020523      *
000400100727      *             GROUP BENIFIT SERVICES SOFTWARE           2010     *
000500060829      *                                                                *
000600000118      *  Written by:    S. Zien                                        *
000700101012      *  Date Written:  10/12/10                                       *
000800100727      *  Description:   Generate work file for Senior Dental Final     *
000900101012      *                   Termination Letters for Deceased (TC= 5 )    *
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
002100131015      * 10/15/13 dlk  hist file expansion project
002200131024      * 10/24/2013   dpb       clear field compdeath before setll      *
002300990630      *? ***************************************************************
002400091029     FACCMST    IF   E           K Disk
002500100727     FHISTL9    IF   E           K Disk
002600100920     F                                     INFDS(IODBFD)
002700101012     FHISTL93   IF   E           K Disk    Rename(HISTR:DACR) Prefix(X_)
002800100920     F                                     INFDS(IODBFDX)
002900100727     FHIST      O  A E           K Disk    Rename(HISTR:HSTR) Prefix(H_)
003000100727     FMCOVX     IF   E           K Disk    Rename(MCOVR:XR) Prefix(X)
003100100727     FODFACP    IF   E           K Disk
003200110803     F****ODOFCP    IF   E           K DISK
003300110803     FODRGNP    IF   E           K Disk
003400100727     FODCNTCP   IF   E           K Disk
003500100728     FSUBMST    IF   E           K Disk
003600100914     FACCMSP    IF   E           K Disk
003700100915     FMEMBER    IF   E           K Disk
003800100915     FCODES     IF   E           K Disk
0039001010120021 FOD130OUT  UF A E           K DISK
004000101012     FOD150OUT  UF A E           K Disk
004100110222     FOD130ARC  O  A E             Disk
004200110222     FOD150ARC  O  A E             Disk
004300010326
004400100917     D IODBFD        E DS                  Extname(IODBFD)
004500100917     D  #RRN                 397    400B 0
004600100920
004700100920     D IODBFDX       E DS                  Extname(IODBFD) Prefix(X)
004800100920     D  #RRNX                397    400B 0
004900100920
0050001007280050 D  FmtTodayIn     DS
0051001007280054 D  YYin                   1      4
0052001007280052 D  MOin                   5      6  0
0053001007280053 D  DDin                   7      8
005400100728
0055001007280050 D  FmtToday       DS
0056001007280052 D  MO##                   1      2  0
0057001007280053 D  DD##                   3      4
0058001007280054 D  YY##                   5      8
0059001010120055 D                 DS
0060001010120056 D  BAL                    1    108  2
006100101012     D                                     DIM(12)
0062001010120056 D  BAL1                   1      9  2
0063001010120056 D  BAL2                  10     18  2
0064001010120056 D  BAL3                  19     27  2
0065001010120056 D  BAL4                  28     36  2
0066001010120056 D  BAL5                  37     45  2
0067001010120056 D  BAL6                  46     54  2
0068001010120056 D  BAL7                  55     63  2
0069001010120056 D  BAL8                  64     72  2
0070001010120056 D  BAL9                  73     81  2
0071001010120056 D  BAL10                 82     90  2
0072001010120056 D  BAL11                 91     99  2
0073001010120056 D  BAL12                100    108  2
007400101012
007500100727     D DAC             S              3    inz('DAC')
007600101012     D Deceased        S              6    inz('TC= 5 ')
007700100727     D BOM             S              3    inz('BOM')
007800100727     D ARP             S              3    inz('ARP')
007900100727     D SAD             S              3    inz('SAD')
008000100727     D Zero4           S              4s 0 inz
008100100915     D TypeD           S              1    inz('D')
008200101012     D CodeDeath       S              2    inz('5 ')
0083001310150037 D sysdateymd      S               d   datfmt(*iso)
008400131015     D thispgmname     S             10a   inz('OD130R    ')
008500061017     D                UDS
008600131015     D LUSER                  10     19
008700061017
008800100727     D ErrorMsg        C                   'Sample Error Message.'
008900060816      *
009000090904     C
009100100727     C     HstKey        Setll     HISTL9
009200100727     C     HstKey        Reade     HISTL9
009300100727     C                   Dow       Not %Eof(HISTL9)
009400100727     C                   If        Not %Eof(HISTL9)
009500100727     C     AccKey        Chain     ACCMST
009600100727     C                   If        %Found(ACCMST)
009700100727     c                   If        ASPHFL = 'F' Or
009800100727     C                             ASPHFL = 'D' or
009900100727     C                             ASPHFL = 'P'
010000100920      * Hold the Hist RRN to compare if there are other DACs for same day.
010100101012     C                   Z-add     #RRN          HoldDeath         8 0
010200100917      *
010300131024     C                   clear                   compdeath
010400101012     C     HsDKey        Setll     HISTL93
010500101012     C     HsDKey        Reade     HISTL93
010600101012     C                   If        Not %Eof(HISTL93)
010700100917      *
010800101012     C*** Compare RRN between Death history record and non-Dath history rec
010900101012     C                   Z-add     #RRNX         CompDeath         8 0
011000100917      *
011100100917     C                   End
011200100920      *
011300101012     C                   If        CompDeath =   *Zero   Or
011400101012     C                             CompDeath <   HoldDeath
011500100805     C                   If        ATRMDT    <>  *Zero
011600100727     C                   Exsr      Process
011700100727     C                   End
011800100920     C                   End
011900100727     C                   End
012000100727     C                   End
012100100727     C                   Reade     HISTL9
012200100727     C                   End
012300061010     C                   EndDo
012400060817     C                   Eval      *InLR     =   *On
012500010403
012600060817      *---------------------------------------------------------------*
012700061010     C     Process       Begsr
012800060817      *---------------------------------------------------------------*
012900100727
013000100727      * Facility Name
013100101207     C                   Clear                   O3SUBD
013200101207     c     SubKey        Chain     SUBMST
013300101207     c                   If        %Found(SUBMST)
013400101207     c                   Eval      O3SUBD  =  %Trim(SUBDSC)
013500101207     c                   End
013600100727
013700100727      * BOM (Business Office Manager)
013800101207     C                   Clear                   O3BOM
013900101207     c     OdKey         Setll     ODCNTCP
014000101207     c                   Dou       %eof(ODCNTCP)
014100101207     c     OdKey         Reade     ODCNTCP
014200101207     c                   If        Not %Eof(ODCNTCP) and Today  >= OCEFF And
014300101207     c                             (OCTRM = 0 or OCTRM > Today)
014400101207     C                   Eval      O3BOM   =  %Trim(OCFNAM) + ' ' +
014500101207     C                                        %Trim(OCLNAM)
014600101207     c                   Eval      O3BOA1  =  %Trim(OCADD1)
014700101207     c                   Eval      O3BOA2  =  %Trim(OCADD2)
014800101207     c                   Eval      O3BOCZ  =  %Trim(OCCITY) + ', ' +
014900101207     C                                        %Trim(OCST)   + '  ' +
015000101207     C                                        %TRim(OCZIP)
015100101207     c                   Leave
015200101207     c                   End
015300101207     c                   EndDo
015400100727
015500100727      *Load the data to the file that will be used in RPG_WORD
015600101012     c                   Eval      O3TRST  =  HSTRST
015700101012     c                   Eval      O3SUB#  =  HSSUB#
015800101012     c                   Eval      O3ACCT  =  HSACCT
015900101012     c                   Eval      O3PYFL  =  ASPHFL
016000101012     C                   Eval      O3CONT  =  CONTAC
016100101012     c                   Eval      O3LTYP  =  'F'
016200101012     C                   Eval      O3ACN1  =  ACNAM1
016300101012     C                   Eval      O3ACN2  =  ACNAM2
016400101012     C                   Eval      O3ADR1  =  AADDR1
016500101012     C                   Eval      O3ADR2  =  AADDR2
016600101012     C                   Movel     AZIP          ZipA              5
016700101012     c                   Eval      O3CSZ   =  %Trim(ACITY) + ', ' +
016800101012     C                                        %Trim(ASTATE)   + '  ' +
016900101012     C                                        %Trim(ZipA)
0170001010121074 C                   XFOOT     BAL           O3TOT
017100100727     C                   Move      HSTRST        wktrsta           3
017200100727     C                   Move      HSSUB#        wksub#a           3
017300100727     C                   Move      HSACCT        wkaccta           4
017400100727     C                   Move      *Blanks       wktsaa           10
017500100727     C                   Eval      wktsaa  =  wktrsta + wksub#a + wkaccta
017600101012     C                   Move      wktsaa        O3TSA
017700100727      *
017800100727      * Get Responsible Party aka Family Representative aka Authorized Rep
017900100727      *
018000101207     C     OdarpKey      Setll     ODCNTCP
018100101207     c                   Dou       %Eof(ODCNTCP)
018200101207     C     OdarpKey      Reade     ODCNTCP
018300101207     C                   If        Not %Eof(ODCNTCP)   And
018400101207     c                                 COVTDT >= OCEFF And
018500101207     c                             (OCTRM = 0 Or OCTRM > COVTDT)
018600101207     c                   Eval      O3RPNM  =  %Trim(OCFNAM) + ' ' +
018700101207     C                                        %Trim(OCLNAM)
018800101207     c                   Eval      O3RPA1  =  %Trim(OCADD1)
018900101207     c                   Eval      O3RPA2  =  %Trim(OCADD2)
019000101207     c                   Eval      O3RCSZ  =  %Trim(OCCITY) + ', ' +
019100101207     C                                        %Trim(OCST)   + '  ' +
019200101207     C                                        %TRim(OCZIP)
019300101207     C                   Leave
019400101207     C                   Else
019500101207     C                   Eval      O3RPNM = 'Attn: Responsible Party'
019600101207     C                   End
019700101207     C                   EndDo
019800101207     C***                Eval      Noacct  =  *Zeros
019900100727      *
020000100727      * Get Nursing Home Administrator
020100100727      *
020200101012     C***  OdsadKey      Setll     ODCNTCP
020300101012     c***                Dou       %Eof(ODCNTCP)
020400101012     C***  OdsadKey      Reade     ODCNTCP
020500101012     C***                If        Not %Eof(ODCNTCP)   And
020600101012     c***                              COVTDT >= OCEFF and
020700101012     c***                          (OCTRM = 0 or OCTRM > COVTDT)
020800101012     c***                Eval      O7NHAD  =  %Trim(OCFNAM) + ' ' +
020900101012     C***                                     %Trim(OCLNAM)
021000101012     c***                Eval      O7NHA1  =  %Trim(OCADD1)
021100101012     c***                Eval      O7NHA2  =  %Trim(OCADD2)
021200101012     c***                Eval      O7NHCZ  =  %Trim(OCCITY) + ', ' +
021300101012     C***                                     %Trim(OCST)   + '  ' +
021400101012     C***                                     %TRim(OCZIP)
021500101012     C***                Eval      O7TITL  =  %Trim(OCTITL)
021600101012     C***                Leave
021700101012      ***  SAD on file
021800101012     C***                Else
021900101012     C***                Eval      O7NHAD  =  'Attn: Nursing Home Administrator'
022000101012     C***  SubKey        Chain     ODFACP
022100101012     C***                If        %Found(ODFACP)
022200101012     C***                Eval      O7NHA1  =  %Trim(S2ADD1)
022300101012     C***                Eval      O7NHA2  =  %Trim(S2ADD2)
022400101012     C***                Eval      O7NHCZ  =  %Trim(S2CITY) + ', ' +
022500101012     C***                                     %Trim(S2ST)   + '  ' +
022600101012     C***                                     %TRim(S2ZIP)
022700101012     C***                End
022800101012     C***                End
022900101012     C***                EndDo
023000101012      ***
023100101012     C                   Eval      O3ACN1  =  %Trim(ACNAM1)
023200101012     C                   Movel     HKEY          O3TSA
023300100728     C     AccKey        Chain     MCOVX
023400100727     C                   If        %Found(MCOVX)
023500101012     C                   Eval      O5SSNO  =  XMCSSNO
023600100727     C                   Else
023700101012     C                   Clear                   O5SSNO
023800101122     C                   Clear                   XMCSSNO
023900100727     C                   End
024000100727      * Format letter date
024100100728     C                   Movel     Today         FmtTodayIn
024200100728     C                   Move      MOin          MO##
024300100728     C                   Move      DDin          DD##
024400100728     C                   Move      YYin          YY##
024500100727     C                   Select
024600100727     C                   When      MO##       =  01
024700101012     C                   Eval      O3DATE     = 'January ' + DD## + ', ' + YY##
024800100727     C                   When      MO##       =  02
024900101012     C                   Eval      O3DATE     = 'February ' + DD## + ', ' + YY##
025000100727     C                   When      MO##       =  03
025100101012     C                   Eval      O3DATE     = 'March ' + DD## + ', ' + YY##
025200100727     C                   When      MO##       =  04
025300101012     C                   Eval      O3DATE     = 'April ' + DD## + ', ' + YY##
025400100727     C                   When      MO##       =  05
025500101012     C                   Eval      O3DATE     = 'May '   + DD## + ', ' + YY##
025600100727     C                   When      MO##       =  06
025700101012     C                   Eval      O3DATE     = 'June '  + DD## + ', ' + YY##
025800100727     C                   When      MO##       =  07
025900101012     C                   Eval      O3DATE     = 'July '  + DD## + ', ' + YY##
026000100727     C                   When      MO##       =  08
026100101012     C                   Eval      O3DATE     = 'August ' + DD## + ', ' + YY##
026200100727     C                   When      MO##       =  09
026300101012     C                   Eval      O3DATE     = 'September ' + DD## + ', ' +
026400100727     C                                                         YY##
026500100727     C                   When      MO##       =  10
026600101012     C                   Eval      O3DATE     = 'October ' + DD## + ', ' + YY##
026700100727     C                   When      MO##       =  11
026800101012     C                   Eval      O3DATE     = 'November ' + DD## + ', ' + YY##
026900100727     C                   When      MO##       =  12
027000101012     C                   Eval      O3DATE     = 'December ' + DD## + ', ' + YY##
027100100727     C                   Endsl
027200100727      * Format Month/Year
027300101012     C***                Move      *Blanks       FmtDate           8
027400101012     C***                Move      COVTDT        FmtDate
027500101012     C***                Movel     FmtDate       lychar            4
027600101012     C***                Move      FmtDate       md                4
027700101012     C***                Movel     md            lmc               2
027800101012      * Effective Date of Termination
027900101012     C     ATRMDT        Mult      10000.0001    AtrmdtForm        8 0
028000101012     C                   Move      AtrmdtForm    FmtToday
028100101012     C                   Movel     MO##          MOa
028200101012     C                   Eval      O3TRDT   =    %Trim(MOa + '/' + DD## +
028300101012     C                                           '/' + YY##)
028400101012      * Check if record already exists
028500101012     C     OD150Key      Chain     OD130OUT
028600101012     C                   If        Not %Found(OD130OUT)
028700101012     C                   Write     OD3R                                 99
028800110222     C                   Exsr      WriteArchive3
028900101012     C                   End
029000100914     C                   Exsr      PrepMed
029100101012     C     OD150Key      Chain     OD150OUT
029200101012     C                   If        Not %Found(OD150OUT)
029300100914     C                   Write     OD5R
029400110222     C                   Exsr      WriteArchive5
029500101012     C                   End
029600100831     C                   If        *In99     =   *Zero
029700100728     C                   Exsr      WriteHis
029800100831     C                   End
029900101012     C                   Clear                   OD3R
030000090909     C                   EndSr
030100070111      *
030200100914    ? *___________________________________________________________________
030300100914    ? * Prepare fields for Medicaid form (OD150OUT)
030400100914    ? *___________________________________________________________________
030500100914    ?C     PrepMed       Begsr
030600100914     C                   Eval      O5TRST  =  HSTRST
030700100914     C                   Eval      O5SUB#  =  HSSUB#
030800100914     C                   Eval      O5ACCT  =  HSACCT
030900100917     C                   Eval      O5LTYP  =  'F'
031000100917     C                   Eval      O5PYFL  =  ASPHFL
031100101105     C************       Eval      O5STAT  =  ASTATE
031200101105      * Per Angie Whitehead State on the Medicaid form should be based on
031300101105      * the Account's Trust:
031400101105     C                   Select
031500101105     C                   When      ACTRST  =  25
031600101216     C                   Eval      O5STAT  =  'FL'
031700101105     C                   When      ACTRST  =  26
031800101216     C                   Eval      O5STAT  =  'MD'
031900101105     C                   When      ACTRST  =  27
032000101216     C                   Eval      O5STAT  =  'GA'
032100101105     C                   When      ACTRST  =  28
032200101216     C                   Eval      O5STAT  =  'NJ'
032300101105     C                   When      ACTRST  =  29
032400101216     C                   Eval      O5STAT  =  'OH'
032500110803     C                   When      ACTRST  =  30
032600110803     C                   Eval      O5STAT  =  'TX'
032700120613     C                   When      ACTRST  =  31
032800120613     C                   Eval      O5STAT  =  'IN'
032900101105     C                   Other
033000101105     C                   Eval      O5STAT  =  '**'
033100101105     C                   EndSl
033200100921     C     SubKey        Chain     ODFACP
033300110803     C     OfcKey        Chain     ODRGNP
033400110803     C                   If        %Found(ODRGNP)
033500100921     C                   Eval      O5REGN  =  MOOLOC
033600100921     C                   Else
033700100921     C                   Eval      O5REGN  =  *Blanks
033800100921     C                   End
033900100914     C                   Eval      O5RENM  =  ACNAM1
034000100914     C                   Eval      O5SSNO  =  XMCSSNO
034100100914     C     AccKey        Chain     ACCMSP
034200100914     C                   If        %Found(ACCMSP)
034300100915     C                   Movel     AMMAID        O5MEDI
034400100914     C                   End
034500100915      * Notice Date
034600100915     C     Today         Mult      10000.0001    Todayform         8 0
034700100916     C                   Move      TodayForm     FmtToday
034800100917     C                   Movel     MO##          MOa
034900100917     C                   Eval      O5NODT   =    %Trim(MOa + '/' + DD## +
035000100917     C                                           '/' + YY##)
035100100914      * Birth Date
035200100915     C     XMCSSNO       Chain     MEMBER
035300100915     C                   If        %Found(MEMBER)
035400100917     C     BIRTH         Mult      10000.0001    BirthForm         8 0
035500100917     C                   Move      BirthForm     FmtToday
035600100917     C                   Movel     MO##          MOa               2
035700100917     C                   Eval      O5DOB    =    %Trim(MOa + '/' + DD## +
035800100917     C                                           '/' + YY##)
035900101122     C                   Else
036000101122     C                   Eval      O5DOB    =    *Blanks
036100100915     C                   End
036200100914      * Effective Date of Termination
036300100917     C     ATRMDT        Mult      10000.0001    AtrmdtForm        8 0
036400100917     C                   Move      AtrmdtForm    FmtToday
036500100917     C                   Movel     MO##          MOa
036600100917     C                   Eval      O5TRDT   =    %Trim(MOa + '/' + DD## +
036700100917     C                                           '/' + YY##)
036800100914     C                   Move      wktsaa        O5TSA
036900100914     C                   EndSr
037000090904    ? *___________________________________________________________________
037100100727    ? * Write a Final Termination Letter History Record
037200090904    ? *___________________________________________________________________
037300090904    ?C     WriteHis      Begsr
037400100727     C                   Movel     HKEY          H_HKEY
037500100728     C                   Eval      H_TRCODE  =   'U70'
037600100727     C                   Eval      H_HSTRST  =   HSTRST
037700100728     C                   Eval      H_HSSUB#  =   HSSUB#
037800100727     C                   Eval      H_HSACCT  =   HSACCT
037900131015     c                   eval      h_hprgnm = thispgmname
038000100727     C                   Eval      H_HSDLTD  =   'A'
038100100728     C                   Eval      H_HOPER   =   %Trim('ROBOT')
038200100727     C                   Eval      H_COVTDT  =   COVTDT
038300131015     C                   eval      sysdateymd = %date
038400131015     C                   MOVE      sysdateymd    h_trdate
038500131015     c                   eval      h_hstrtime = %time
038600110223     C****************** If        *InU1     =   *On
038700100727     C                   Write     HSTR
038800101202     C                   Clear                   HSTR
038900110223     C****************** End
039000090904    ?C                   Endsr
039100110222      * ? _____________________________________________________________
039200110222      *? *                                                             *
039300110222      *? * Write all data fields to the Final Term OTHER letter archive*
039400110222      *? *_____________________________________________________________*
039500110222     C     WriteArchive3 BEGSR
039600110222      *
039700110222     C                   Eval      A3TRST   =    O3TRST
039800110222     C                   Eval      A3SUB#   =    O3SUB#
039900110222     C                   Eval      A3ACCT   =    O3ACCT
040000110222     C                   Eval      A3LTYP   =    O3LTYP
040100110222     C                   Eval      A3PYFL   =    O3PYFL
040200110222     C                   Eval      A3CONT   =    O3CONT
040300110222     C                   Eval      A3ACN1   =    O3ACN1
040400110222     C                   Eval      A3ACN2   =    O3ACN2
040500110222     C                   Eval      A3ADR1   =    O3ADR1
040600110222     C                   Eval      A3ADR2   =    O3ADR2
040700110222     C                   Eval      A3CSZ    =    O3CSZ
040800110222     C                   Eval      A3TERE   =    O3TERE
040900110222     C                   Eval      A3TRDT   =    O3TRDT
041000110222     C                   Eval      A3DATE   =    O3DATE
041100110222     C                   Eval      A3TOT    =    O3TOT
041200110222     C                   Eval      A3TSA    =    O3TSA
041300110222     C                   Eval      A3BOM    =    O3BOM
041400110222     C                   Eval      A3BOA1   =    O3BOA1
041500110222     C                   Eval      A3BOA2   =    O3BOA2
041600110222     C                   Eval      A3BOCZ   =    O3BOCZ
041700110222     C                   Eval      A3RPNM   =    O3RPNM
041800110222     C                   Eval      A3RPA1    =   O3RPA1
041900110222     C                   Eval      A3RPA2    =   O3RPA2
042000110222     C                   Eval      A3RCSZ    =   O3RCSZ
042100110222     C                   Eval      A3SUBD    =   O3SUBD
042200110222     C                   Eval      A3DESC    =   %Trim('Final Term +
042300110222     C                                                   DECEASED Letter')
042400110222     C     *Date         Mult      10000.0001    A3LDT
042500110222     C                   Write     OD3RA
042600110222     C                   Clear                   OD3RA
042700110222      *
042800110222     C                   EndSr
042900110222      * ? _____________________________________________________________
043000110222      *? *                                                             *
043100110222      *? * Write all data fields to the Medicaid Form archive          *
043200110222      *? *_____________________________________________________________*
043300110222     C     WriteArchive5 BEGSR
043400110222      *
043500110222     C                   Eval      A5TRST    =   O5TRST
043600110222     C                   Eval      A5SUB#    =   O5SUB#
043700110222     C                   Eval      A5ACCT    =   O5ACCT
043800110222     C                   Eval      A5LTYP    =   O5LTYP
043900110222     C                   Eval      A5PYFL    =   O5PYFL
044000110222     C                   Eval      A5STAT    =   O5STAT
044100110222     C                   Eval      A5REGN    =   O5REGN
044200110222     C                   Eval      A5RENM    =   O5RENM
044300110222     C                   Eval      A5SSNO    =   O5SSNO
044400110222     C                   Eval      A5MEDI    =   O5MEDI
044500110222     C                   Eval      A5DOB     =   O5DOB
044600110222     C                   Eval      A5TERE    =   O5TERE
044700110222     C                   Eval      A5TRDT    =   O5TRDT
044800110222     C                   Eval      A5NODT    =   O5NODT
044900110222     C                   Eval      A5TSA     =   O5TSA
045000110222     C                   Eval      A5DESC    =   %Trim('Medicaid Form')
045100110222     C     *Date         Mult      10000.0001    A5LDT
045200110222     C                   Write     OD5RA
045300110222     C                   Clear                   OD5RA
045400110222      *
045500110222     C                   EndSr
045600110222
045700090903    ? *___________________________________________________________________
045800090903    ? * Klists
045900090903    ? *___________________________________________________________________
046000090904    ?C     KList         Begsr
046100090909    ? *
046200090909     C     HstKey        Klist
046300100728     C                   Kfld                    Today
046400100727     C                   Kfld                    DAC
046500101012     C                   Kfld                    Deceased
046600100917    ? *
046700100917     C     HsDKey        Klist
046800100917     C                   Kfld                    HKEY
046900100917     C                   Kfld                    Today
047000100727    ? *
047100100727     C     AccKey        Klist
047200100727     C                   Kfld                    HSTRST
047300100727     C                   Kfld                    HSSUB#
047400100727     C                   Kfld                    HSACCT
047500090903      *
047600100727     C     SubKey        Klist
047700100727     C                   Kfld                    HSTRST
047800100727     C                   Kfld                    HSSUB#
047900100727     C*
048000100727     C     OdKey         Klist
048100100727     C                   Kfld                    HSTRST
048200100727     C                   Kfld                    HSSUB#
048300100727     C                   Kfld                    Zero4
048400100727     C                   Kfld                    BOM
048500100727     C*
048600100727     C     OdarpKey      Klist
048700100727     C                   Kfld                    HSTRST
048800100727     C                   Kfld                    HSSUB#
048900100727     C                   Kfld                    HSACCT
049000100727     C                   Kfld                    ARP
049100100727     C*
049200100727     C     OdsadKey      Klist
049300100727     C                   Kfld                    HSTRST
049400100727     C                   Kfld                    HSSUB#
049500100727     C                   Kfld                    Noacct            4 0
049600100727     C                   Kfld                    SAD
049700100915     C*
049800100915     C     CodKey        Klist
049900100915     C                   Kfld                    TypeD             1
050000101012     C                   Kfld                    CodeDeath         2
050100100921      *
050200100921     C     OfcKey        klist
050300100921     C                   kfld                    S2TRST
050400100921     C                   kfld                    S2OFC#
050500100921      *
050600101012     C     OD150Key      Klist
050700101012     C                   Kfld                    Final
050800101012     C                   Kfld                    ASPHFL
050900101012     C                   Kfld                    HSTRST
051000101012     C                   Kfld                    HSSUB#
051100101012     C                   Kfld                    HSACCT
051200100727     C*
051300090903    ?C                   Endsr
051400090903    ? *___________________________________________________________________
051500090903     C     *Inzsr        BEGSR
051600090903    ? *___________________________________________________________________
051700100727     C     *Date         Mult      10000.0001    Today             8 0
051800140512     C*************      z-add     20140509      Today
051900101012     C                   Move      'F'           Final             1
052000100915     C     CodKey        Chain     CODES
052100100915     C                   If        %Found(CODES)
052200101015     C                   Eval      O3TERE      = LDESCR
052300101015     C                   Eval      O5TERE      = LDESCR
052400100915     C                   End
052500100727     C                   EndSr
052600010412
052700010403     C/EJECT
