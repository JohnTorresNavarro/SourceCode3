0001001603300002 F******************************************************************
0002001603300003 F* DB013      GROUP BENEFIT SERVICES SOFTWARE                     *
0003001603300004 F*                                                                *
0004001603300005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005001603300006 F*            DATE - 03/30/16                                     *
0006001603300007 F*                                                                *
0007001603300008 F*  DESCRIPTION - Find dependents older than the max age allowed  *
0008001603300009 F*                per plan.                                       *
0009009808200014 F*                                                                *
0010001604140014 F* 04/13/16 dlk - also consider the plnauxp codes for when the    *
0011001604140014 F*                max age should be reached and report errors     *
0012001604140014 F*                up to 60 days ahead.                            *
0013001606130014 F* 06/13/16 dlk - also consider new "max age when student" field  *
0014001606130014 F*                in PLNAUXP.                                     *
0015001610140014 F* 10/14/16 dlk - add new max age date code for end of plan year  *
0016002010280014 F* 10/28/20 dlk - seperate report for EDT/EVT - Tony C request    *
0017001606130014 F*                                                                *
0018001603300011 F******************************************************************
001900160331     Fdb013j    ip   e           k DISK
0020001603300014 Fdcovc     IF   e           k DISK
002100111114     FAACODE    IF   e           k DISK
002200160330     Fcodesl1   IF   e           k DISK
002300160330     Fplnauxp   IF   e           k DISK
002400160330     Fplnmst    IF   e           k DISK
002500201028     Ftrsmst    IF   e           k DISK
0026001603300017 Fdb013bxl  o  a e             DISK
0027002010280017 Fdb013bedxlo  a e             DISK                                         EDT/EVT only
002800160413     D bdayiso         S               D   DATFMT(*ISO)
002900160414     D maxagedateiso   S               D   DATFMT(*ISO)
003000160414     D notifydtiso     S               D   DATFMT(*ISO)
003100160414     D todayiso        S               D   DATFMT(*ISO)
003200160414     D maxageyr        S              4s 0
003300160414     D maxagemm        S              2s 0
003400161014     D renewmm         S              2s 0
0035001201310125 Dcsv              c                   const('","')
003600160330     Ddepage           S              4s 0
003700160330     Daanam            S             30
003800160330     Dreldes           S             30
003900160330     Ddname            S             34
004000160414     Derror            S             35
004100201028     Dedttrust         S              1
004200160330     Dplandes          S                   like(pdescr)
004300160613     Dplanmaxage       S                   like(pxdpmx)
0044001201310055 D                 DS
0045001201310056 D  tsa                    1     10  0
0046001201310056 D  mbtrst                 1      3  0
0047001201310056 D  mbsub#                 4      6  0
0048001201310056 D  mbacct                 7     10  0
0049001604140055 D                 DS
0050001604140056 D  wkdtymd                1      8  0
0051001604140056 D  wkdtyyyy               1      4  0
0052001604140056 D  wkdtmm                 5      6  0
0053001604140056 D  wkdtdd                 7      8  0
0054001603310030 Idb013r
005500111114     I              aacode                      acaacode
005600160330
005700160330      *skip medchi and cancelled members
005800160331     c                   if        (mbtrst >= 559 and mbtrst <= 562) or
005900160330     c                             (termdt <> 0)
006000160330     c                   goto      #end
006100160330     c                   end
006200160330
006300160414      * age as of today
006400160330     c                   if        dbirth = 0
006500160414     c                   move      todayiso      bdayiso
006600160330     c                   else
006700160413     c                   move      dbirth        bdayiso
006800160330     c                   end
006900160330     c                   clear                   depage
007000160414     c                   eval      depage = %diff(todayiso:bdayiso:*years)
007100160330
007200160330      * check age of dependent for all active plans
0073001603300029 C     dcovkey       setll     dcovc
007400111116     c                   dou       %eof(dcovc)
007500111116     c     dcovkey       reade     dcovc
007600111116     c                   if        (not %eof(dcovc)) and (ccandt = 0)
007700160330       chain (dvtrst:dvsub#:dvplan) plnauxp;
007800160414       if %found(plnauxp);
007900160414       exsr #chkage;
008000160414       else;
008100160414       error = 'MISSING PLNAUXP RECORD';
008200160414       clear pxdpmx;
008300160414       clear notifydtiso;
008400160414       clear pxdpcd;
008500160414       exsr writexldet;
008600160414       clear error;
008700160414       endif;
008800111116     c                   end
008900111116     c                   enddo
009000111116
009100160330     c     #end          tag
009200120131
0093001604130164 C*************************************************************
0094001604130164 C* check dependent age                                       *
0095001604130164 C*************************************************************
009600160414       begsr #chkage;
009700160413
009800160414       clear error;
009900160613
010000160613      * default dependent max age in plnauxp record
010100160613       eval planmaxage = pxdpmx;
010200160613
010300160613      * if full time student and the plan has a different max age for
010400160613      * students then use it instead
010500160613       if dstudn = 'Y' and pxstmx <> 0;
010600161014        eval planmaxage = pxstmx;
010700160613       endif;
010800160613
010900160613       maxagedateiso = bdayiso + %years(planmaxage);
011000160413       maxageyr = %subdt(maxagedateiso:*years);
011100160414       maxagemm = %subdt(maxagedateiso:*months);
011200160414
011300160414      * calcuate the date that the dependent is over age (notify date)
011400160414       select;
011500161014
011600161014       when pxdpcd = 'DEY';                     // end of year dep turns age
011700161014        wkdtymd = %dec(maxagedateiso);
011800161014        wkdtmm = 12;
011900161014        wkdtdd = 31;
012000161014        notifydtiso = %date(wkdtymd);
012100160413
012200161014       when pxdpcd = 'DBD' or pxdpcd = *blanks; // exact day dep turns age
012300161014        notifydtiso = maxagedateiso;
012400160414
012500161014       when pxdpcd = 'DEM';                    // end of month dep turns age
012600161014        wkdtymd = %dec(maxagedateiso); // get day he turns age
012700161014        wkdtmm = maxagemm + 1; // add 1 month
012800161014         if wkdtmm > 12;
012900161014          wkdtmm = 1;
013000161014          wkdtyyyy += 1;
013100161014         endif;
013200161014        wkdtdd = 01; // set day to 1
013300161014        notifydtiso = %date(wkdtymd) - %days(1); // subtract 1 day to get last day of month
013400160414
013500161014       when pxdpcd = 'DEP';                // end of plan year dep turns age
013600161014      * find the next renewal after dep turns max age
013700161014        wkdtymd = %dec(maxagedateiso); // day dep turns age
013800161014        chain (dvtrst:dvsub#:dvplan) plnmst; // get renewal month
0139001610140030    if %found(plnmst);
014000161014         eval wkdtmm = prenew; // plan renewal month
014100161014        endif;
014200161014      * if renewal has past, set year to next year
014300161014        if wkdtmm <= maxagemm;
014400161014         wkdtyyyy += 1;
014500161014        endif;
014600161014        wkdtdd = 01; // set day to 1
014700161014        notifydtiso = %date(wkdtymd) - %days(1); // get last day of prior month
014800161014
014900161014       other;                              // error - new code found
015000161014        error = 'UNKNOWN OVER AGE CODE FOUND--> ' + pxdpcd;
015100160414       endsl;
015200160413
015300160414      * print on report if the over age date has past or is up to 60 days
015400160414      * in the future
015500160414       if notifydtiso <= todayiso + %days(60);
015600161014        exsr writexldet;
015700160414       endif;
015800160414
015900160414       endsr;
016000160413
0161001201310164 C*************************************************************
0162001201310164 C*                                                           *
0163001201310164 C* Write Spreadsheet Detail                                  *
0164001201310164 C*                                                           *
0165001201310164 C*************************************************************
016600120131     C     Writexldet    BEGSR
016700160330
016800160330      * get aa info
016900160330       clear AANAM;
017000160330       chain aakey aacode;
0171001603300030   if %found(aacode);
017200160330       eval aanam = %trim(afnam) + ' ' + %trim(alnam);
017300160330       endif;
017400160330
017500160330      * get relation description
017600160330       clear reldes;
017700160330       chain drelcd codesl1;
0178001603300030   if %found(codesl1);
017900160330       eval reldes = ldescr;
018000160330       endif;
018100160330
018200160330      * get plan description
018300160330       clear plandes;
018400160330       chain (dvtrst:dvsub#:dvplan) plnmst;
0185001603300030   if %found(plnmst);
018600160330       eval plandes = pdescr;
018700160330       endif;
018800160330
018900160330      * format dep name
019000160330       clear dname;
019100160331       eval dname = %trim(dfname) + ' ' + %trim(dmi) + ' ' +
019200160331                    %trim(dlname);
019300160330
019400160330     C                   MOVE      dbirth        @DATIN
019500160330     C                   EXSR      #DATYM
019600160330     C                   MOVE      @DATOU        dobmdy            8 0
019700160330
019800201028      * get trust category so EDT/EVT can be separated
019900201028       clear edttrust;
020000201028       chain mbtrst trsmst;
0201002010280030   if %found(trsmst) and tscode = 'O W';
020200201028       eval edttrust = 'Y';
020300201028       endif;
020400201028
020500160330     c                   clear                   db013bfld
020600160330     C                   Eval      db013bfld  = '"' +
020700160331     C                             %trim(aanam)                         + csv +
020800120131     C                             %trim(%editw(dssno:'0   -  -    ')) + csv +
020900120131     C                             %char(dpseq#)                        + csv +
021000160330     C                             %trim(reldes)                        + csv +
021100160330     C                             %trim(dname)                         + csv +
021200160330     C                             %trim(%editw(depss#:'0   -  -    ')) + csv +
021300120131     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
021400160330     C                             %trim(%editw(dobmdy:'0  /  /    ')) + csv +
021500160330     C                             %char(depage)                        + csv +
021600160330     C                             %char(pxdpmx)                        + csv +
021700160613     C                             %editc(pxstmx:'Z')                   + csv +
021800160613     C                             %trim(dstudn)                        + csv +
021900160414     C                             %char(notifydtiso)                   + csv +
022000160613     C                             %trim(pxdpcd)                        + csv +
022100160330     C                             %trim(dvplan)                        + csv +
022200160330     C                             %trim(pdescr)                        + csv +
022300160330     C                             %trim(dhndcp)                        + csv +
022400160613     C                             %trim(error)                         + csv +
022500120131     C                             ' '                                  + '",'
022600120131     C*
022700201028     C* EDT/EVT are on a separate report
022800201028     C*
022900201028     c                   if        edttrust = 'Y'
023000201028     C                   Write     db013bedxr
023100201028     c                   else
023200201028     C                   Write     db013bxr
023300201028     c                   end
023400201028
0235001201310320 C                   ENDSR
023600120131     C*
023700130529
023800120131     C*************************************************************
023900120131     C*                                                           *
024000120131     C* Write Spreadsheet heading                                 *
024100120131     C*                                                           *
024200120131     C*************************************************************
024300120131     C     Writexlhead   BEGSR
024400120131
024500160330     c                   clear                   db013bfld
024600160330     C                   Eval      db013bfld = '"' +
024700160331     C                             'AA NAME'                            + csv +
024800160331     C                             'MEMBER SSN'                         + csv +
024900160330     C                             'DEP #'                              + csv +
025000160330     C                             'RELATION'                           + csv +
025100160331     C                             'DEPENDENT NAME'                     + csv +
025200160330     C                             'DEP SSN'                            + csv +
025300160330     C                             'ACCOUNT #'                          + csv +
025400160330     C                             'BIRTH DATE'                         + csv +
025500160414     C                             'AGE TODAY'                          + csv +
025600160330     C                             'MAX AGE'                            + csv +
025700160613     C                             'STU MAX AGE'                        + csv +
025800160613     C                             'STUDENT'                            + csv +
025900160414     C                             'MAX AGE DATE'                       + csv +
026000160613     C                             'AGE CODE'                           + csv +
026100160330     C                             'PLAN'                               + csv +
026200160330     C                             'PLAN DESCRIPTION'                   + csv +
026300160330     C                             'HANDICAP'                           + csv +
026400160414     C                             'ERROR'                              + csv +
026500160330     C                             '",'
026600160330     C                   Write     db013bxr
026700201028     C                   Write     db013bedxr
026800120131     C*
0269001201310320 C                   ENDSR
027000120131
0271001603300103 C***************************************************
0272001603300104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0273001603300105 C***************************************************
0274001603300107 C*
0275001603300107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0276001603300107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0277001603300107 C*
0278001603300106 C     #DATYM        BEGSR
027900160330     C                   MOVE      @DATIN        @MD               4 0
028000160330     C                   MOVEL     @DATIN        @Y                4 0
028100160330     C                   MOVEL     @MD           @DATOU            8 0
028200160330     C                   MOVE      @Y            @DATOU
028300160330     C                   MOVE      *ZEROS        @DATIN            8 0
0284001603300120 C                   ENDSR
028500160330     C*
028600111114
028700111114     C     *INZSR        BEGSR
028800160414     C                   EVAL      todayiso = %DATE
0289001111140210 C                   MOVE      *ZEROS        ZERO2
029000160330
029100111114     C     aakey         KLIST
029200111114     C                   KFLD                    acaacode
029300111114     C                   KFLD                    ZERO2             2 0
029400111116
029500111116     C     dcovkey       KLIST
029600111116     C                   KFLD                    dssno
029700111116     C                   KFLD                    dpseq#
029800120131
029900120131     C                   Exsr      Writexlhead
030000111114     C                   endsr
