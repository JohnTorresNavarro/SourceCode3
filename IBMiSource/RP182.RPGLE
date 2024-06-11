000001200904      *========================================================================
000101200904     h option(*noDebugIo)
000102200904      *========================================================================
001802200904      * RP182 - Cancelled accounts by trans date range
001803200904      *========================================================================
001804200904      * Date         Int  Description
001805200904      * ----------   ---  -----------------------------------------------------
001806200904      * 07/02/2001   dlk  Original Creation
001807200904      * 01/18/2002   dlk  add term code selection, last invoice premium column
001808200904      *                   and email option.
001809200904      * 06/04/2010   dlk  add senior dental xls
001810200904      * 06/30/2014   dlk  add term code description
001811200904      * 07/09/2015   dlk  add exchange field, convert to xls
001812200904      * 05/31/2016   dlk  change to show last non-zero billed amount in
001813200904      *                   last inv column (Cindy W request)
001814200904      * 01/09/2017   jt   Added changes for Advanced Mobile
001815200904      * 01/09/2020   jt   Added changes for CMS
001816200904      * 09/09/2020   jt   Added new colums. Cleaned up code.
001817200909      * 09/29/2020   jt   Fixed div by 0;
001818200904
001819200904      *========================================================================
001820200904
001900200904     fhistl96   if   e           k disk    rename(histr:histFile)
001902200904
002000010702     Faccmst    IF   E           K DISK
002001200904
002100100608     faccmsp    if   e           k disk
002101200904
002200100608     fodfacp    if   e           k disk
002201200904
002300100722     fodrgnp    if   e           k disk
002301200904
002400100608     ftrsmst    if   e           k disk
002401200904
002500100608     FMEMAC#    IF   E           K DISK
002501200904
002600140630     fcodesl1   if   e           k disk
002601200904
0027001507090005 Fcmct14    if   e           k disk
002701200904
002800150709     fplnauxp   if   e           k disk
002801200904
002900160531     finvsum    if   e           k disk
002901200904
002902200904     FSMAN      IF   E           K DISK    extfile('F.SMAN')
002903200904
003000200904     FRP180xl   uf a e             disk
003001200904
003100200904     FRP180bxl  o  a e             disk
003101200904
003102200904      *=================================================================
003103200904
0032001507090037 D workdt          S               d   datfmt(*iso)
003300200904     D covmdy          s              8  0
003400200904     D trdmdy          s              8  0
0035002009040037 D hldofc          S              3  0
0036002009040037 D hldmaid         S             15
0037002009040037 D hldofcdes       S             50
003701200904     D acmem           S              6  0
003702200904     D aavage          S              3  0
003703200904     D atotr           S             11  2
003704200904     D ud8y            s              4  0
003705200904     D byr             s              4  0
003706200904     D bmo             s              2  0
003707200904     D AGE             S              3  0
003708200904     D ATOTAG          S              5  0
0037092009040037 D linvprm         S              9  2
003800180129     d SrDenAdvMob     S              3
003802200904     d pos             s              3  0
003803200904     d termdesout      s             30
003804200904     d holddate        s               d
003805200904     d scanTermCode    s              4
003806200904     d smanout         s             30
003807200904
003900200904     D csv             c                   const('","')
003901200904     d csvQuote        c                   const('"')
003902200904
004100100608     D                 DS
004200100608     D  TSA#                   1     10  0 inz
004300100608     D  actrst                 1      3  0
004400100608     D  acsub#                 4      6  0
004500100608     D  acacct                 7     10  0
004501200904
004600100609     D                 DS
004700100609     D  ck#not                 1     30
004800100609     D  note24                 1     24
004900200904     D  termcode              29     30
004901200904
004902200904     D                 DS
004903200904     D  BAL                    1    108  2 DIM(12)
004904200904     D  BAL1                   1      9  2
004905200904     D  BAL2                  10     18  2
004906200904     D  BAL3                  19     27  2
004907200904     D  BAL4                  28     36  2
004908200904     D  BAL5                  37     45  2
004909200904     D  BAL6                  46     54  2
004910200904     D  BAL7                  55     63  2
004911200904     D  BAL8                  64     72  2
004912200904     D  BAL9                  73     81  2
004913200904     D  BAL10                 82     90  2
004914200904     D  BAL11                 91     99  2
004915200904     D  BAL12                100    108  2
004917200904
005000990526     D                UDS
005201200904     d  fromDate               1      8  0
005401200904     d  toDate                 9     16  0
005500990527     D  LTRUST                17     19
005600020118     D  Lterm                 20     21
005700100608     D  lsdyn                 22     22
005901200904
005902200904      *=================================================================
005903200904
006000200904     IACCMSR
006001200904     I                                          AACODE
006002200904     I                                          ACTRST
006003200904
006004200904      //===================================================================
006006200904      // mainline
006008200904      //===================================================================
006009200904
006010200904       exsr init;
006011200904       exsr main;
006012200904       exsr exit;
006013200904
006014200904      //===================================================================
006015200904      // main
006016200904      //===================================================================
006017200904
006018200904       begsr main;
006019200904
006020200904        setll ('DAC') histFile;
006021200904        reade ('DAC') histFile;
006022200904
006023200904        dow not %eof;
006024200904         if %subst(hkey:1:1) > ' ';
006027200904          if trdate >= fromDate;
006028200904           if trdate <= toDate;
006029200904            pos = %scan('TC=':ck#not:1);
006030200904            if pos > 0;
006100200904             chain (hstrst : hssub# : hsacct) accmst;
006201200904             if %found and atrmdt > 0;
006500010702
006501200904              atotr = %xfoot(bal);
006502200904
006503200904              holddate = %date(trdate:*iso);
006504200904              trdmdy = %dec( %char( holddate : *usa0) : 8 : 0);
006900010702
006901200904              holddate = %date(covtdt:*iso);
006902200904              covmdy = %dec( %char( holddate : *usa0) : 8 : 0);
007300140630
007400140630      * get term code description
007500140630     c                   move      ck#not        termcodewk2       2
007600140630     c                   move      ck#not        termcodewk        3
007700140630     c                   movel     'D'           termcodewk
007800200904
007801200904              termdesout = ' ';
007900200904              chain termcodewk codesl1;
008000200904              if %found;
008100200904               termdesout = ldescr;
008200200904              endif;
008300140630
008400150709      * is this an exchange acct?
008500150709     c                   clear                   exchange          1
008600150709     c                   clear                   comctxfound       1
008700150709     c                   z-add     atrmdt        searchdt          8 0
008800150709     c                   exsr      #chkexch
008900150709      * if not found, try again with 1 day less, some comctx are cancelled
009000150709      * 1 day less than the acct cancel date
009100150709     c                   if        comctxfound = *blank
009200150709     c                   move      atrmdt        workdt
009300150709     C                   subdur    1:*d          workdt
009400150709     C                   move      workdt        searchdt
009500150709     c                   exsr      #chkexch
009600150709     c                   end
009700160531
009800160531      * Get last amount invoiced. If the amount in ACCMST is not zero
009900160531      * then use it, else get the last amount from invsum.
010000160531      * Invsum is keyed in acct/effdt/rec code order
010100160531      * so set limits past the acct and read backwards month by
010200160531      * month all current enrollment records for the first record
010300160531      * found with a non zero amount
010400160531     c                   z-add     apremi        linvprm
010500160531     c                   if        linvprm = 0
010501200904           setgt (hstrst : hssub# : hsacct) invsum;
010700160531     c                   dou       %eof(invsum)
010701200904           readpe (hstrst : hssub# : hsacct) invsum;
010900160531     c                   if        not %eof(invsum) and inrc = 'KCE'
011000160531     c                             and intot <> 0
011100160531      * prior month found
011200160531     C                   Z-ADD     intot         linvprm
011300160531     c                   leave
011400160531     C                   end
011500160531     C                   enddo
011600160531     C                   end
011700160531
011800150713      * write excel file
011801200904
011900150713     c                   exsr      writexldet
012000100608
012101200904             endif;
012102200904            endif;
012103200904           endif;
012200200904          endif;
012201200904         endif;
012202200904
012203200904        reade ('DAC') histFile;
012204200904        enddo;
012205200904
012206200904        exsr checkSelections;
012207200904
012208200904       endsr;
012302200904
0124001507090069 C**************************************************************
012500150709JGE01C* check for exchang plans
0126001507090069 C**************************************************************
012700150709JGE01C     #chkexch      BEGSR
012800150709
012900150709      * find all comctx for the acct cancel date
012901200904           setll (hstrst : hssub# : hsacct) cmct14;
013100150709     c                   dou       %eof(cmct14)
013101200904           reade (hstrst : hssub# : hsacct) cmct14;
013300150709     c                   if        (not %eof(cmct14)) and (searchdt >= effdat)
013400150709     c                             and (cmcan = 0 or cmcan >= searchdt)
013500150709     c                             and (cmcan <> effdat)
013600150709     c                   eval      comctxfound = 'Y'
013601200904     c
013700150709      * is this an exchange plan?
013800200904           chain (cmtrst : csubdv : cmplan) plnauxp;
013900150709     C                   if        %found(plnauxp) and pxexchg = 'Y'
014000150709     c                   eval      exchange = 'Y'
014100150709     c                   leave
014200150709     c                   end
014300150709
014400150709     c                   end
014500150709     c                   enddo
014600150709
014700150709     c                   endsr
014800150709
014900100608
0150001006080164 C*************************************************************
0151001006080164 C* Write Spreadsheet heading
0152001006080164 C*************************************************************
015300100608     C     Writexlhead   BEGSR
015400150713
015500150713     c                   clear                   rp180fld
016600100608
016700180129      * senior dental xls/Advance Mobile...
016800180129     c****               if        lsdyn = 'Y'
016900200109       if lsdyn = 'A' or lsdyn = 'D' or lsdyn = 'C';
017000100608     c                   clear                   rp180bfld
017100100608     C                   Eval      rp180bfld =   '"' + 'ACCOUNT #'     + '","' +
017200100608     C                                           'ACCOUNT NAME'        + '","' +
017300100609     C                                           'LAST INV $'          + '","' +
017400100608     C                                           'SSN'                 + '","' +
017500100608     C                                           'EFFECTIVE'           + '","' +
017600100608     C                                           'TRANS DATE'          + '","' +
017700100609     C                                           'CANCEL CODE'         + '","' +
017800100608     C                                           'CANCEL REASON'       + '","' +
017900140630     C                                         'TERM CODE DESCRIPTION' + '","' +
018000100608     C                                           'DOB'                 + '","' +
018100100608     C                                           'MEDICAID#'           + '","' +
018200100608     C                                           'REGION / OFFICE'     + '","' +
018300100608     C                                                 ' '             + '",'
018400100608     C                   Write     rp180bxr
018500200109       endif;
018600150713
0187001006080320 C                   ENDSR
0188001006080164 C*************************************************************
0189001006080164 C* Write Spreadsheet Detail                                  *
0190001006080164 C*************************************************************
019100100608     C     Writexldet    BEGSR
019200100608
019201200904     c                   clear                   hldssn
019202200904     c                   clear                   hldbir
019203200904     c                   eval      acmem = 0
019204200904     c                   eval      aavage = 0
019205200904
019206200904        setll (hstrst : hssub# : hsacct) memac#;
019208200904        dou %eof(memac#);
019209200904        reade (hstrst : hssub# : hsacct) memac#;
019210200904
019211200904        if not %eof(memac#) and termdt = atrmdt;
019212200904         acmem = acmem + 1;
019213200904
019215200904         ud8y = %subdt(%date:*years);
019216200904
019217200904         monitor;
019218200904          byr = %dec(%subst(%char(birth):1:4):4:0);
019219200904         on-error;
019220200904          byr = 0;
019221200904         endmon;
019222200904
019223200904         monitor;
019224200904          bmo = %dec(%subst(%char(birth):5:2):2:0);
019225200904         on-error;
019226200904          bmo = 0;
019227200904         endmon;
019228200904
019229200904         if byr > 0;
019230200904     C                   EVAL      AGE = UD8Y - BYR
019231200904     C                   IF        UMONTH <> 12
019232200904     C                   IF        UMONTH < BMO
019233200904     C                   EVAL      AGE = AGE - 1
019234200904     C                   ENDIF
019235200904     C                   ENDIF
019236200904
019237200904     C                   EVAL      ATOTAG = ATOTAG + AGE
019238200904     C                   EVAL      AGE = 0
019239200904         endif;
019240200904
019241200904     c                   move      mbssno        hldssn            9 0
019242200904     c                   move      birth         hldbir            8 0
019243200904
019248200904     C                   ENDIF
019249200904     C                   enddo
019250200909         aavage = 0;
019251200909         if acmem > 0 and atotag > 0;
019252200904     C                   EVAL(H)   AAVAGE = ATOTAG/ACMEM
019253200904         endif;
019254200904     C                   EVAL      ATOTAG = 0
019255200904
019256200904         smanout = ' ';
019257200904         chain smancd sman;
019258200904         if %found;
019260200904          smanout = sfname + ' ' + slname;
019261200904         endif;
019262200904
019263200904
019300150713     c                   clear                   rp180fld
019301200904
019400150713     C                   Eval      rp180fld  =   '"' +
019500150713     C                             %trim(%editw(tsa#:'0   -   -    ')) + '","' +
019600150713     C                             acnam1                              + '","' +
019601200904     C                             contac                              + '","' +
019602200904     C                             %trim(%editw(trdmdy:'0  /  /    ')) + '","' +
019603200904     C                             %trim(%editw(covmdy:'0  /  /    ')) + '","' +
019700150713     C                             %trim(ck#not)                       + '","' +
019701200904     C                             %trim(termcodewk2)                  + '","' +
019800150713     C                             %trim(termdesout)                   + '","' +
019801200904     C                             %Trim(%Editc(aavage:'3'))           + '","' +
019802200904     C                             %Trim(%Editc(acmem:'3'))            + '","' +
020100160531     C                             %Trim(%Editc(linvprm:'N'))          + '","' +
020101200904     C                             %Trim(%Editc(atotr:'N'))            + '","' +
020102200904     C                             aacode                              + '","' +
020103200904     C                             smancd                              + '","' +
020104200904     C                             smanout                             + '","' +
020200200904     C*                            exchange                            + '","' +
020300150713     C                             ' '                          + '",'
020400150713     C*
020500150713     C                   Write     rp180xr
020600150713
020700180129      * senior dental xls/Advance Mobile...
020800180129     c****               if        lsdyn = 'Y'
020900200109       if lsdyn = 'D' or lsdyn = 'A' or lsdyn = 'C';
021000200109        select;
021100200109         when lsdyn = 'D';
021200200109          SrDenAdvMob = 'O N';
021300200109         when lsdyn = 'A';
021400200109          SrDenAdvMob = 'O M';
021500200109         when lsdyn = 'C';
021600200109          SrDenAdvMob = 'O D';
021700200109        endsl;
021800180129
021900180129     C     actrst        Chain     trsmst
022000180129     C                   if        not %found or tscode <> SrDenAdvMob
022100180129     c                   leavesr
022200180129     c                   endif
022300180129
022400180129     C**** actrst        Chain     trsmst
022500180129     C****               If        not %Found(trsmst) or (tscode <> 'O N')
022600180129     c****               leavesr
022700180129     c****               end
022800150713
022900100608      * GET MEMBER IN ACCOUNT
023000100608     c                   clear                   hldssn
023100100608     c                   clear                   hldbir
023101200904     c                   eval      acmem = 0
023102200904           setll (hstrst : hssub# : hsacct) memac#;
023300100608     C                   dou       %eof(memac#)
023301200904           reade (hstrst : hssub# : hsacct) memac#;
023500100608     C                   if        not %eof(memac#) and termdt = atrmdt
023501200904     C                   EVAL      ACMEM = ACMEM + 1
023502200904
023503200904      * CALCULATE AGE FOR MEMBER
023504200904       ud8y = %subdt(%date : *years);
023505200904       byr = %dec(%subst(%char(birth):1:4):4:0);
023506200904       bmo = %dec(%subst(%char(birth):5:2):2:0);
023507200904
023508200904     C                   EVAL      AGE = UD8Y - BYR
023509200904     C                   IF        UMONTH <> 12
023510200904     C                   IF        UMONTH < BMO
023511200904     C                   EVAL      AGE = AGE - 1
023512200904     C                   ENDIF
023513200904     C                   ENDIF
023514200904
023515200904     C                   EVAL      ATOTAG = ATOTAG + AGE
023516200904     C                   EVAL      AGE = 0
023517200904
023600100608     c                   move      mbssno        hldssn            9 0
023700100608     c                   move      birth         hldbir            8 0
023800100608     C                   ENDIF
023900100608     C                   enddo
023901200904
024000200904              if birth > 0;
024001200904              holddate = %date(birth:*iso);
024002200904              hldbir = %dec( %char( holddate : *usa0) : 8 : 0);
024004200904              endif;
024400100608
024500100608     C                   clear                   hldofc
024600100608     C                   clear                   hldmaid
024700100608     C                   clear                   hldofcdes
024800100608
024801200904           chain (hstrst : hssub# : hsacct) accmsp;
025000100608     C                   If        %Found(accmsp)
025100100608     C                   move      ammaid        hldmaid
025101200904
025200200904           chain (actrst : acsub#) odfacp;
025300100608     C                   If        %Found(ODFACP)
025400100608     C                   move      S2OFC#        hldofc
025401200904
025500200904           chain (actrst : hldofc) odrgnp;
025600100722     C                   If        %Found(ODrgnp)
025700100608     C                   move      mooloc        hldofcdes
025800100608     C                   End
025900100608     C                   End
026000100608     C                   End
026001200909
026002200909       aavage = 0;
026100200909       if acmem > 0 and atotag > 0;
026101200904     C                   EVAL(H)   AAVAGE = ATOTAG/ACMEM
026102200909       endif;
026103200904     C                   EVAL      ATOTAG = 0
026104200904
026200100608     c                   clear                   rp180bfld
026300100608     C                   Eval      rp180bfld  =   '"' +
026400100608     C                             %trim(%editw(tsa#:'0   -   -    ')) + csv +
026500100608     C                             acnam1                              + csv +
026600160531     C                             %Trim(%Editc(linvprm:'J'))          + csv +
026700100608     C                             %Trim(%Editw(hldssn:'0   -  -    ')) + csv +
026800100608     C                             %trim(%editw(covmdy:'0  /  /    ')) + csv +
026900100608     C                             %trim(%editw(trdmdy:'0  /  /    ')) + csv +
027000100609     C                             termcode                            + csv +
027100100609     C                             note24                              + csv +
027200140630     C                             termdesout                          + '","' +
027300100608     C                             %trim(%editw(hldbir:'0  /  /    ')) + csv +
027400100608     C                             hldmaid                             + csv +
027500100608     C                             hldofcdes                           + '",'
027600100608     C*
027700100608     C                   Write     rp180bxr
027800200109       endif;
027900150713
028000150713
0281001006080320 C                   ENDSR
028200100608
028201200904      //===================================================================
028202200904      // check selections
028203200904      //===================================================================
028204200904
028205200904       begsr checkSelections;
028206200904
028207200904        if lterm > ' ';
028208200904
028209200904         scanTermCode = csvQuote + lterm + csvQuote;
028210200904
028211200904         setll 2 rp180xr;
028212200904         read rp180xr;
028214200904
028215200904         dow not %eof;
028216200904          pos = %scan(scanTermCode:rp180fld:1);
028217200904          if pos = 0;
028218200904           delete rp180xr;
028219200904          endif;
028220200904
028221200904         read rp180xr;
028222200904         enddo;
028223200904
028224200904        endif;
028225200904
028226200904        if ltrust > ' ';
028227200904
028230200904         setll 2 rp180xr;
028231200904         read rp180xr;
028233200904
028234200904         dow not %eof;
028235200904
028236200904          if %subst(rp180fld:2:3) <> ltrust;
028237200904           delete rp180xr;
028238200904          endif;
028239200904
028240200904         read rp180xr;
028241200904         enddo;
028242200904
028243200904        endif;
028244200904
028245200904       endsr;
028246200904
031902200904      //===================================================================
031903200904      // exit
031904200904      //===================================================================
031905200904
031906200904       begsr exit;
031907200904
031908200904        *inlr = '1';
031909200904        return;
031910200904
031911200904       endsr;
031912200904
031913200904      //===================================================================
031914200904      // init
031915200904      //===================================================================
031916200904
031917200904       begsr init;
031918200904
031937200904        //exsr writeXlhead;
031938200904     C                   Eval      rp180fld  =   '"' + 'ACCOUNT #'     + '","' +
031939200904     C                                           'ACCOUNT NAME'        + '","' +
031940200904     C                                           'CONTACT'             + '","' +
031941200904     C                                           'TRANS DATE'          + '","' +
031942200904     C                                           'EFFECTIVE DATE'      + '","' +
031943200904     C                                           'CANCEL REASON'       + '","' +
031944200904     C                                           'TC'                  + '","' +
031945200904     C                                         'TERM CODE DESCRIPTION' + '","' +
031946200904     C                                           'AVG. AGE'            + '","' +
031947200904     C                                           '# OF MEM'            + '","' +
031948200904     C                                           'LAST INV $'          + '","' +
031949200904     C                                           'RECEIVABLE $'        + '","' +
031950200904     C                                           'AACODE'              + '","' +
031951200904     C                                           'SMAN CODE'           + '","' +
031952200904     C                                           'SMAN NAME'           + '","' +
031954200904     C                                                 ' '             + '",'
031955200904
031956200904        write rp180xr;
031957200904
031958200904        if ltrust = 'ALL';
031959200904         ltrust = ' ';
031960200904        endif;
031961200904
031962200904       endsr;
031963200904
031964200904       //==============================================================
