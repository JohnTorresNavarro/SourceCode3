000100220510      //===================================================================
000200200904     h option(*noDebugIo)
000300210623      //===================================================================
000400200909      * RP182B - Cancelled accounts by trans date range
000500210623      //===================================================================
000600200904      * Date         Int  Description
000700200904      * ----------   ---  -----------------------------------------------------
000800200909      * 09/09/2020   jt   Original Creation (re-write)
000900210623      * 06/23/2021   jt   Eliminated Sr. Dental/Adv. Mobile/CMSi checks.
001000210629      * 06/29/2021   jt   Added check for open/close of files.
001100210701      * 07/01/2021   dk   Add additional check for div by zero
001200210902      * 10/04/2021   jt   Stopped report from emailing twice
001300220415      * 12/06/2021   dk   new field changes and additions per Finance
001301220415      * 04/19/2022   jt   Added ne parm to identify if running from Robot
001302220510      * 05/10/2022   jt   Fixed selection of Trust only/Term Code only
001400210623      //===================================================================
001500200904
001600200904     fhistl96   if   e           k disk    rename(histr:histFile)
001700200904
001800210623     faccmst    if   e           k disk    extfile('F.ACCMST')
001900200904
002000100608     faccmsp    if   e           k disk
002100200904
002200100608     fodfacp    if   e           k disk
002300200904
002400100722     fodrgnp    if   e           k disk
002500200904
002600200909     ftrsmst    if   e           k disk    extfile('F.TRSMST')
002700200904
002800210623     fMEMAC#    IF   E           K DISK    extfile('F.MEMAC#')
002900210623
003000200909     fcodesl1   if   e           k disk    extfile('F.CODESL1')
003100200904
003200210623     fcmct14    if   e           k disk    extfile('F.CMCT14')
003300200904
003400150709     fplnauxp   if   e           k disk
003500200904
003600200909     finvsum    if   e           k disk    extfile('F.INVSUM')
003700200904
003800210623     fSMAN      IF   E           K DISK    extfile('F.SMAN')
003900211206     faacode    if   e           k disk
004000211206     fhypercarr if   e           k disk
004100211206     fplnmst    if   e           k disk    extfile('F.PLNMST')
004200211206     fcarmst    if   e           k disk    extfile('F.CARMST')
004300200904
004400210623     fRP180xl   uf a e             disk    usropn
004500200904
004600210623     fRP180bxl  o  a e             disk    usropn
004700200904
004701220415     frp180xr2  uf a e             disk
004800210623      //===================================================================
004900200904
005000210623     D workdt          S               d   datfmt(*iso)
005100200904     D covmdy          s              8  0
005200200904     D trdmdy          s              8  0
005300211206     D gbsbdmdy        s              8  0
005400210623     D hldofc          S              3  0
005500210623     D hldmaid         S             15
005600210623     D hldofcdes       S             50
005700200904     D acmem           S              6  0
005800200904     D aavage          S              3  0
005900200904     D atotr           S             11  2
006000200904     D ud8y            s              4  0
006100200904     D byr             s              4  0
006200200904     D bmo             s              2  0
006300200904     D AGE             S              3  0
006400200904     D ATOTAG          S              5  0
006500210623     D linvprm         S              9  2
006600180129     d SrDenAdvMob     S              3
006700200904     d pos             s              3  0
006800200904     d termdesout      s             30
006900200904     d holddate        s               d
007000210730     d fromRobot       s               d
007100200904     d scanTermCode    s              4
007200200904     d smanout         s             30
007300200909     d command         s            512
007400211206     d aaname          s             43
0075002112060020 D car             S             30    DIM(10)
007600220415     d actcnt          s              4  0
007700211207     d hkey_hold       s             10
007701220415
007702220415     d ctrust          s              3
007703220415     d csub#           s              3
007704220415     d cacct           s              4
007705220415
007706220415     d cmm             s              2
007707220415     d cdd             s              2
007708220415     d cyy             s              4
007709220415     d mmddyy          s              8
007710220415
007711220415     d cmm2            s              2
007712220415     d cdd2            s              2
007713220415     d cyy2            s              4
007714220415     d mmddyy2         s              8
007715220415
007716220415     d cmm3            s              2
007717220415     d cdd3            s              2
007718220415     d cyy3            s              4
007719220415     d mmddyy3         s              8
007800200904
007900200904     D csv             c                   const('","')
008000200904     d csvQuote        c                   const('"')
008100200904
008200100608     D                 DS
008300100608     D  TSA#                   1     10  0 inz
008400100608     D  actrst                 1      3  0
008500100608     D  acsub#                 4      6  0
008600100608     D  acacct                 7     10  0
008700200904
008800100609     D                 DS
008900100609     D  ck#not                 1     30
009000100609     D  note24                 1     24
009100200904     D  termcode              29     30
009200200904
009300200904     D                 DS
009400200904     D  BAL                    1    108  2 DIM(12)
009500200904     D  BAL1                   1      9  2
009600200904     D  BAL2                  10     18  2
009700200904     D  BAL3                  19     27  2
009800200904     D  BAL4                  28     36  2
009900200904     D  BAL5                  37     45  2
010000200904     D  BAL6                  46     54  2
010100200904     D  BAL7                  55     63  2
010200200904     D  BAL8                  64     72  2
010300200904     D  BAL9                  73     81  2
010400200904     D  BAL10                 82     90  2
010500200904     D  BAL11                 91     99  2
010600200904     D  BAL12                100    108  2
010700200904
010800990526     D                UDS
010900200904     d  fromDate               1      8  0
011000200904     d  toDate                 9     16  0
011100990527     D  LTRUST                17     19
011200020118     D  Lterm                 20     21
011300100608     D  lsdyn                 22     22
011400200904
011500200909     d cmd             pr                  ExtPgm('QCMDEXC')
011600200909     d  command                     200    const
011700200909     d  length                       15  5 const
011800200909
011900200909     d rp182b          pi
012000200909     d  fromDateI                      d
012100200909     d  toDateI                        d
012200200909     d  trustI                        3
012300200909     d  termCodeI                     2
012301220415     d  Robot                         1
012400200909
012500210623      //===================================================================
012600200904
012700200904     IACCMSR
012800211206     I              aacode                      AACODE_a
012900200904     I                                          ACTRST
013000200904
013100200904      //===================================================================
013200200904      // mainline
013300200904      //===================================================================
013400200904
013500200904       exsr init;
013600200904       exsr main;
013700200904       exsr exit;
013800200904
013900200904      //===================================================================
014000200904      // main
014100200904      //===================================================================
014200200904
014300200904       begsr main;
014400200904
014500200904        setll ('DAC') histFile;
014600200904        reade ('DAC') histFile;
014700200904
014800200904        dow not %eof;
014900200904         if %subst(hkey:1:1) > ' ';
015000200904          if trdate >= fromDate;
015100200904           if trdate <= toDate;
015200200904            pos = %scan('TC=':ck#not:1);
015300200904            if pos > 0;
015400200904             chain (hstrst : hssub# : hsacct) accmst;
015500200904             if %found and atrmdt > 0;
015600010702
015700211206* beg * clear carrier array
015800211206        clear car;
015900211206
016000211206* beg * begin admin date
016100211206        holddate = %date(gbsbdt:*iso);
016200211206        gbsbdmdy = %dec( %char( holddate : *usa0) : 8 : 0);
016300211206
016400211206      * get aa name
016500211206        clear aaname;
016600211206        chain aacode_a aacode;
016700211206        if %found(aacode);
016800211206        aaname = %trim(afnam) + ' ' + %trim(alnam);
016900211206        endif;
017000211206
017100211206
017200200904              atotr = %xfoot(bal);
017300200904
017400200904              holddate = %date(trdate:*iso);
017500200904              trdmdy = %dec( %char( holddate : *usa0) : 8 : 0);
017600010702
017700200904              holddate = %date(covtdt:*iso);
017800200904              covmdy = %dec( %char( holddate : *usa0) : 8 : 0);
017900140630
018000140630      * get term code description
018100140630     c                   move      ck#not        termcodewk2       2
018200140630     c                   move      ck#not        termcodewk        3
018300140630     c                   movel     'D'           termcodewk
018400200904
018500200904              termdesout = ' ';
018600200904              chain termcodewk codesl1;
018700200904              if %found;
018800200904               termdesout = ldescr;
018900200904              endif;
019000140630
019100211206
019200150709      * is this an exchange acct?
019300211207      * exchange no longer used
019400211207     c**                 clear                   exchange          1
019500211207     c**                 clear                   comctxfound       1
019600211207     c**                 z-add     atrmdt        searchdt          8 0
019700211207     c**                 exsr      #chkexch
019800150709      * if not found, try again with 1 day less, some comctx are cancelled
019900150709      * 1 day less than the acct cancel date
020000211207     c**                 if        comctxfound = *blank
020100211207     c**                 move      atrmdt        workdt
020200211207     C**                 subdur    1:*d          workdt
020300211207     C**                 move      workdt        searchdt
020400211207     c**                 exsr      #chkexch
020500211207     c**                 end
020600160531
020700211206      * find all medical carriers
020800211206     c                   clear                   comctxfound       1
020900211206     c                   z-add     atrmdt        searchdt          8 0
021000211206     c                   exsr      #getcar
021100211206      * if not found, try again with 1 day less, some comctx are cancelled
021200211206      * 1 day less than the acct cancel date
021300211206     c                   if        comctxfound = *blank
021400211206     c                   move      atrmdt        workdt
021500211206     C                   subdur    1:*d          workdt
021600211206     C                   move      workdt        searchdt
021700211206     c                   exsr      #getcar
021800211206     c                   end
021900211206
022000211206
022100160531      * Get last amount invoiced. If the amount in ACCMST is not zero
022200160531      * then use it, else get the last amount from invsum.
022300160531      * Invsum is keyed in acct/effdt/rec code order
022400160531      * so set limits past the acct and read backwards month by
022500160531      * month all current enrollment records for the first record
022600160531      * found with a non zero amount
022700160531     c                   z-add     apremi        linvprm
022800160531     c                   if        linvprm = 0
022900200904           setgt (hstrst : hssub# : hsacct) invsum;
023000160531     c                   dou       %eof(invsum)
023100200904           readpe (hstrst : hssub# : hsacct) invsum;
023200160531     c                   if        not %eof(invsum) and inrc = 'KCE'
023300160531     c                             and intot <> 0
023400160531      * prior month found
023500160531     C                   Z-ADD     intot         linvprm
023600160531     c                   leave
023700160531     C                   end
023800160531     C                   enddo
023900160531     C                   end
024000160531
024100150713      * write excel file
024200210623              exsr writexldet;
024300100608
024400200904             endif;
024500200904            endif;
024600200904           endif;
024700200904          endif;
024800200904         endif;
024900200904
025000200904        reade ('DAC') histFile;
025100200904        enddo;
025200200904
025300200904        exsr checkSelections;
025400220415        //exsr eFile;
025500200904
025600200904       endsr;
025700200904
025800210623      //===================================================================
025900210623      // Check for Exchang Plans
026000210623      //===================================================================
026100210623
026200211207      ** begsr #chkexch;
026300150709
026400211207      **  //find all comctx for the acct cancel date
026500211207      **  setll (hstrst : hssub# : hsacct) cmct14;
026600211207      **  dou  %eof(cmct14);
026700211207      **  reade (hstrst : hssub# : hsacct) cmct14;
026800210623
026900211207      **   if (not %eof(cmct14)) and (searchdt >= effdat)
027000211207      **    and (cmcan = 0 or cmcan >= searchdt)  and (cmcan <> effdat);
027100211207      **    comctxfound = 'Y';
027200210623
027300211207      **    //is this an exchange plan?
027400211207      **    chain (cmtrst : csubdv : cmplan) plnauxp;
027500211207      **    if %found(plnauxp) and pxexchg = 'Y';
027600211207      **    exchange = 'Y';
027700211207      **     leave;
027800211207      **    endif;
027900150709
028000211207      **  endif;
028100210623
028200211207      **  enddo;
028300150709
028400211207      ** endsr;
028500211206
0286002112060069 C**************************************************************
028700211206JGE01C* get carriers
0288002112060069 C**************************************************************
028900211206JGE01   begsr #getcar;
029000211206
029100211206      * find all comctx for the acct cancel date
029200211206           setll (hstrst : hssub# : hsacct) cmct14;
029300211206           dou %eof(cmct14);
029400211206           reade (hstrst : hssub# : hsacct) cmct14;
029500211206           if (not %eof(cmct14)) and (searchdt >= effdat)
029600211206               and (cmcan = 0 or cmcan >= searchdt)
029700211206               and (cmcan <> effdat);
029800211206              comctxfound = 'Y';
029900211206
030000211206      * get plan and carrier, only show medical
030100211206           chain (cmtrst : csubdv : cmplan) plnmst;
030200211206           if %found(plnmst);
030300211206            chain (plncat) codesl1;
030400211206            if %found(codesl1) and action = 'M';
030500211206             chain (pcarr) carmst;
030600211206             if %found(carmst);
030700211206              chain (cgrpcd) hypercarr;
030800211206              exsr #storcar;
030900211206             endif;
031000211206            endif;
031100211206           endif;
031200211206
031300211206           endif;
031400211206           enddo;
031500211206
031600211206           endsr;
031700211206
0318002112060351 C****************************************************************
0319002112060352 C*    STORE carrier group name                                  *
0320002112060354 C****************************************************************
032100211206     C     #storcar      BEGSR
032200211206
032300211206     C                   Z-ADD     1             X                 2 0
032400211206     C     #T0080        TAG
032500211206
032600211206     C                   IF        car(x) = *BLANKS
032700211206     C                   MOVE      hcname        car(X)
032800211206     C                   leavesr
032900211206     C                   ELSE
033000211206     c                   if        car(x) = hcname
033100211206     C                   leavesr
033200211206     C                   ELSE
033300211206     C                   ADD       1             X
033400211206     C*
033500211206     C     X             IFLE      10
033600211206     C                   GOTO      #T0080
033700211206     C                   END
033800211206
033900211206     C                   END
034000211206     C                   END
034100211206
034200211206     C                   ENDSR
034300211206
034400100608
034500210623      //===================================================================
034600210623      // Write Spreadsheet Heading
034700210623      //===================================================================
034800210623
034900210623       begsr WriteXlhead;
035000150713
035100210623        clear rp180fld;
035200100608
035300180129      * senior dental xls/Advance Mobile...
035400200109       if lsdyn = 'A' or lsdyn = 'D' or lsdyn = 'C';
035500100608     c                   clear                   rp180bfld
035600100608     C                   Eval      rp180bfld =   '"' + 'ACCOUNT #'     + '","' +
035700100608     C                                           'ACCOUNT NAME'        + '","' +
035800100609     C                                           'LAST INV $'          + '","' +
035900100608     C                                           'SSN'                 + '","' +
036000100608     C                                           'EFFECTIVE'           + '","' +
036100100608     C                                           'TRANS DATE'          + '","' +
036200100609     C                                           'CANCEL CODE'         + '","' +
036300100608     C                                           'CANCEL REASON'       + '","' +
036400140630     C                                         'TERM CODE DESCRIPTION' + '","' +
036500100608     C                                           'DOB'                 + '","' +
036600100608     C                                           'MEDICAID#'           + '","' +
036700100608     C                                           'REGION / OFFICE'     + '","' +
036800100608     C                                                 ' '             + '",'
036900100608     C                   Write     rp180bxr
037000210623        endif;
037100150713
037200210623       endsr;
037300210623
037400210623      //===================================================================
037500210623      // Write Spreadsheet Detail
037600210623      //===================================================================
037700210623
037800210623       begsr WriteXldet;
037900100608
038000200904     c                   clear                   hldssn
038100200904     c                   clear                   hldbir
038200200904     c                   eval      acmem = 0
038300200904     c                   eval      aavage = 0
038400200904
038500200904        setll (hstrst : hssub# : hsacct) memac#;
038600200904        dou %eof(memac#);
038700200904        reade (hstrst : hssub# : hsacct) memac#;
038800200904
038900200904        if not %eof(memac#) and termdt = atrmdt;
039000200904         acmem = acmem + 1;
039100200904
039200200904         ud8y = %subdt(%date:*years);
039300200904
039400200904         monitor;
039500200904          byr = %dec(%subst(%char(birth):1:4):4:0);
039600200904         on-error;
039700200904          byr = 0;
039800200904         endmon;
039900200904
040000200904         monitor;
040100200904          bmo = %dec(%subst(%char(birth):5:2):2:0);
040200200904         on-error;
040300200904          bmo = 0;
040400200904         endmon;
040500200904
040600200904         if byr > 0;
040700200904     C                   EVAL      AGE = UD8Y - BYR
040800200904     C                   IF        UMONTH <> 12
040900200904     C                   IF        UMONTH < BMO
041000200904     C                   EVAL      AGE = AGE - 1
041100200904     C                   ENDIF
041200200904     C                   ENDIF
041300200904
041400200904     C                   EVAL      ATOTAG = ATOTAG + AGE
041500210623          age = 0;
041600200904         endif;
041700200904
041800200904     c                   move      mbssno        hldssn            9 0
041900200904     c                   move      birth         hldbir            8 0
042000200904
042100200904     C                   ENDIF
042200200904     C                   enddo
042300200904
042400200904         if acmem > 0;
042500200904     C                   EVAL(H)   AAVAGE = ATOTAG/ACMEM
042600200904         endif;
042700200904     C                   EVAL      ATOTAG = 0
042800200904
042900200904         smanout = ' ';
043000200904         chain smancd sman;
043100200904         if %found;
043200211206          smanout = %trim(sfname) + ' ' + %trim(slname);
043300200904         endif;
043400200904
043500211207      * count number of unique accounts
043600211207       if hkey_hold <> hkey;
043700211207        hkey_hold = hkey;
043800211207        actcnt = 1;
043900211207       else;
044000211207        actcnt += 1;
044100211207       endif;
044200200904
044300150713     c                   clear                   rp180fld
044400200904
044500150713     C                   Eval      rp180fld  =   '"' +
044600150713     C                             %trim(%editw(tsa#:'0   -   -    ')) + '","' +
044700150713     C                             acnam1                              + '","' +
044800200904     C                             contac                              + '","' +
044900211206     C                             %editw(gbsbdmdy:'0  /  /    ')      + '","' +
045000211206     C                             %trim(%editw(trdmdy:'0  /  /    ')) + '","' +
045100211207     C                             %Trim(%Editc(actcnt:'3'))           + '","' +
045200200904     C                             %trim(%editw(covmdy:'0  /  /    ')) + '","' +
045300150713     C                             %trim(ck#not)                       + '","' +
045400200904     C                             %trim(termcodewk2)                  + '","' +
045500150713     C                             %trim(termdesout)                   + '","' +
045600200904     C                             %Trim(%Editc(aavage:'3'))           + '","' +
045700200904     C                             %Trim(%Editc(acmem:'3'))            + '","' +
045800160531     C                             %Trim(%Editc(linvprm:'N'))          + '","' +
045900220415     C                             %Trim(%Editc(atotr:'N'))            + '","' +
046000211206     C                             aaname                              + '","' +
046100200904     C                             smanout                             + '","' +
046200211206     C                             %trim((car(1)))                     + '","' +
046300211206     C                             %trim((car(2)))                     + '","' +
046400211206     C                             %trim((car(3)))                     + '","' +
046500211206     C                             %trim((car(4)))                     + '","' +
046600211206     C                             %trim((car(5)))                     + '","' +
046700211206     C                             %trim((car(6)))                     + '","' +
046800211206     C                             %trim((car(7)))                     + '","' +
046900211206     C                             %trim((car(8)))                     + '","' +
047000211206     C                             %trim((car(9)))                     + '","' +
047100211206     C                             %trim((car(10)))                    + '","' +
047200150713     C                             ' '                          + '",'
047300150713     C*
047400150713     C                   Write     rp180xr
047401220415
047402220415        ctrust = %editc(actrst:'X');
047403220415        csub# = %editc(acsub#:'X');
047404220415        cacct = %editc(acacct:'X');
047408220415        tsa## = %trim(ctrust) + '-' + %trim(csub#) + '-' + %trim(cacct);
047411220415
047413220415        mmddyy = %editc(gbsbdmdy:'X');
047416220415        cmm = %subst(mmddyy:1:2);
047417220415        cdd = %subst(mmddyy:3:2);
047418220415        cyy = %subst(mmddyy:5:4);
047419220415        gbsbmdyy = %trim(cmm) + '/' + %trim(cdd) + '/' + %trim(cyy);
047420220415
047421220415        mmddyy2 = %editc(trdmdy:'X');
047422220415        cmm2 = %subst(mmddyy2:1:2);
047423220415        cdd2 = %subst(mmddyy2:3:2);
047424220415        cyy2 = %subst(mmddyy2:5:4);
047425220415        trdmdyy = %trim(cmm2) + '/' + %trim(cdd2) + '/' + %trim(cyy2);
047428220415
047429220415        mmddyy3= %editc(covmdy:'X');
047430220415        cmm3 = %subst(mmddyy3:1:2);
047431220415        cdd3 = %subst(mmddyy3:3:2);
047432220415        cyy3 = %subst(mmddyy3:5:4);
047433220415        covmdyy = %trim(cmm3) + '/' + %trim(cdd3) + '/' + %trim(cyy3);
047434220415
047435220415        termcodewx = %char(termcodewk2);
047436220415        write rp180xB2;
047500150713
047600180129      * senior dental xls/Advance Mobile...
047700180129     c****               if        lsdyn = 'Y'
047800210623       //if lsdyn = 'D' or lsdyn = 'A' or lsdyn = 'C';
047900210623        //select;
048000210623        // when lsdyn = 'D';
048100210623        //  SrDenAdvMob = 'O N';
048200210623        // when lsdyn = 'A';
048300210623        //  SrDenAdvMob = 'O M';
048400210623        // when lsdyn = 'C';
048500210623        //  SrDenAdvMob = 'O D';
048600210623        //endsl;
048700180129
048800180129     C     actrst        Chain     trsmst
048900210623     C****               if        not %found or tscode <> SrDenAdvMob
049000210623     C                   if        not %found
049100180129     c                   leavesr
049200180129     c                   endif
049300180129
049400210623       //if tscode = 'O N' or tscode  = 'O M' or tscode = 'O D';
049500180129     C**** actrst        Chain     trsmst
049600180129     C****               If        not %Found(trsmst) or (tscode <> 'O N')
049700180129     c****               leavesr
049800180129     c****               end
049900150713
050000100608      * GET MEMBER IN ACCOUNT
050100100608     c                   clear                   hldssn
050200100608     c                   clear                   hldbir
050300200904     c                   eval      acmem = 0
050400200904           setll (hstrst : hssub# : hsacct) memac#;
050500100608     C                   dou       %eof(memac#)
050600200904           reade (hstrst : hssub# : hsacct) memac#;
050700100608     C                   if        not %eof(memac#) and termdt = atrmdt
050800200904     C                   EVAL      ACMEM = ACMEM + 1
050900200904
051000200904      * CALCULATE AGE FOR MEMBER
051100200904       ud8y = %subdt(%date : *years);
051200200904       byr = %dec(%subst(%char(birth):1:4):4:0);
051300200904       bmo = %dec(%subst(%char(birth):5:2):2:0);
051400200904
051500210623       age = ud8y - BYR;
051600210623       if umonth <> 12;
051700210623        if umonth < BMO;
051800210623         age = age - 1;
051900210623        endif;
052000210623       endif;
052100200904
052200210623       atotag = atotag + age;
052300210623       age = 0;
052400200904
052500100608     c                   move      mbssno        hldssn            9 0
052600100608     c                   move      birth         hldbir            8 0
052700100608     C                   ENDIF
052800100608     C                   enddo
052900200904
053000200904              if birth > 0;
053100200904              holddate = %date(birth:*iso);
053200200904              hldbir = %dec( %char( holddate : *usa0) : 8 : 0);
053300200904              endif;
053400100608
053500210623              clear hldofc;
053600210623              clear hldmaid;
053700210623              clear hldofcdes;
053800100608
053900200904           chain (hstrst : hssub# : hsacct) accmsp;
054000210623           if %found(accmsp);
054100100608     C                   move      ammaid        hldmaid
054200200904
054300200904           chain (actrst : acsub#) odfacp;
054400210623           if %found(ODFACP);
054500100608     C                   move      S2OFC#        hldofc
054600200904
054700200904           chain (actrst : hldofc) odrgnp;
054800210623           if %found(ODrgnp);
054900100608     C                   move      mooloc        hldofcdes
055000210623           endif;
055100210623           endif;
055200210623           endif;
055300100608
055400210701     C                   if        ACMEM > 0
055500210701     C                   EVAL(H)   AAVAGE = ATOTAG/ACMEM
055600210701     C                   end
055700210623           atotag = 0;
055800200904
055900210623           clear rp180bfld;
056000210623           rp180bfld = '"' + %trim(%editw(tsa#:'0   -   -    ')) + csv +
056100210623                       acnam1 + csv + %trim(%editc(linvprm:'J'))  + csv +
056200210623                       %trim(%editw(hldssn:'0   -  -    ')) + csv +
056300210623                       %trim(%editw(covmdy:'0  /  /    ')) + csv +
056400210623                       %trim(%editw(trdmdy:'0  /  /    ')) + csv +
056500210623                       termcode + csv + note24 + csv + termdesout + '","' +
056600210623                       %trim(%editw(hldbir:'0  /  /    ')) + csv + hldmaid +
056700210623                       csv + hldofcdes + '",';
056800210623            write rp180bxr;
056900210623         //endif;
057000150713
057100210623       endsr;
057200100608
057300200904      //===================================================================
057400200904      // check selections
057500200904      //===================================================================
057600200904
057700200904       begsr checkSelections;
057800200904
057900200904        if lterm > ' ';
058000200904
058100200904         scanTermCode = csvQuote + lterm + csvQuote;
058200200904
058300200904         setll 2 rp180xr;
058400200904         read rp180xr;
058500200904
058600200904         dow not %eof;
058700200904          pos = %scan(scanTermCode:rp180fld:1);
058800200904          if pos = 0;
058900200904           delete rp180xr;
059000200904          endif;
059100200904
059200200904         read rp180xr;
059300200904         enddo;
059400200904
059500200904        endif;
059600200904
059700200904        if ltrust > ' ';
059800200904
059900200904         setll 2 rp180xr;
060000200904         read rp180xr;
060100200904
060200200904         dow not %eof;
060300200904
060400200904          if %subst(rp180fld:2:3) <> ltrust;
060500200904           delete rp180xr;
060600200904          endif;
060700200904
060800200904         read rp180xr;
060900200904         enddo;
061000200904
061100200904        endif;
061200200904
061201220510        if  termCodeI > ' ';
061202220510
061205220510         setll 1 rp180xr2;
061206220510         read rp180xr2;
061207220510
061208220510         dow not %eof;
061210220510          if termcodewx <> lterm;
061211220510           delete rp180xr2;
061212220510          endif;
061213220510
061214220510         read rp180xr2;
061215220510         enddo;
061216220510
061217220510        endif;
061218220510
061219220510        if ltrust > ' ';
061220220510
061221220510         setll 1 rp180xr2;
061222220510         read rp180xr2;
061223220510
061224220510         dow not %eof;
061225220510
061226220510          if %subst(tsa##:1:3) <> ltrust;
061227220510           delete rp180xr2;
061228220510          endif;
061229220510
061230220510         read rp180xr2;
061231220510         enddo;
061232220510
061233220510        endif;
061234220510
061300200904       endsr;
061400200904
061500200909      //===================================================================
061600200909      // eFile
061700200909      //===================================================================
061800200909
061900210730       begsr eFile;
062000210730
062100220415        if Robot = 'Y';
062200210730
062300220415         command = 'eFile File(rp180xl) Lib(Qtemp) eMail(gbs.csmi@' +
062400210803           'amwins.com)' + ' ' +  'ToFile(RP180) Ext(''.csv'')' +
062500210803           ' ' + 'Subject(''Canceled Accounts RP180'') MsgTxt(''RP180.CSV'')';
062600210730         cmd(%trim(command): %len(%trim(command)));
062700210730
062800210730
062900210730        else;
063000210730
063100211206         command = 'eFile File(rp180xl) Lib(Qtemp) eMail(*current)' + ' ' +
063200210803           'ToFile(RP180) Ext(''.csv'')' + ' ' +
063300210803           'Subject(''Canceled Accounts RP180'') MsgTxt(''RP180.CSV'')';
063400210803         cmd(%trim(command): %len(%trim(command)));
063500210730
063600211207         //command = 'eFile File(rp180xl) Lib(qtemp) eMail(*current)' + ' ' +
063700210902         //  'ToFile(RP180) Ext(''.csv'')' + ' ' +
063800210902         //   'Subject(''Canceled Accounts RP180'') MsgTxt(''RP180.CSV'')';
063900210902         //cmd(%trim(command): %len(%trim(command)));
064000210730        endif;
064100200909
064200220415        //if %open(rp180xl);
064300220415        // close rp180xl;
064400220415        //endif;
064500210629
064600220415        //if %open(rp180bxl);
064700220415        // close rp180bxl;
064800220415        //endif;
064900200909
065000220415        //command = 'dltf qtemp/rp180xl';
065100220415        //cmd(%trim(command): %len(%trim(command)));
065200200909
065300220415        //command = 'dltf qtemp/rp180bxl';
065400220415        //cmd(%trim(command): %len(%trim(command)));
065500200909
065600200909       endsr;
065700200909
065800200904      //===================================================================
065900200904      // exit
066000200904      //===================================================================
066100200904
066200200904       begsr exit;
066300200904
066400200904        *inlr = '1';
066500200904        return;
066600200904
066700200904       endsr;
066800200904
066900200904      //===================================================================
067000200904      // init
067100200904      //===================================================================
067200200904
067300200904       begsr init;
067400200909
067500210730        if fromDateI = d'0001-01-01';
067600210730         fromRobot = fromDateI;
067700210730         fromDateI = %date() - %days(1);
067800210730         toDateI = %date() - %days(1);
067900210803        else;
068000210803         fromRobot = fromDateI;
068100210730        endif;
068200210730
068300210629        if not %open(rp180xl);
068400210629         open rp180xl;
068500210629        endif;
068600210629
068700210629        if not %open(rp180bxl);
068800210629         open rp180bxl;
068900210629        endif;
069000200904
069100200909        fromDate = %dec(fromDateI);
069200200909        toDate = %dec(toDateI);
069300200909        ltrust = trustI;
069400211206
069500211206        rp180fld = '"' +
069600211206                   'ACCOUNT #'         + csv +
069700211206                   'ACCOUNT NAME'      + csv +
069800211206                   'CONTACT'           + csv +
069900211206                   'BEGIN ADMIN DATE'  + csv +
070000211207                   'DATE PROCESSED'    + csv +
070100211207                   'COUNT'             + csv +
070200211207                   'CANCEL DATE'       + csv +
070300211206                   'CANCEL REASON'     + csv +
070400211206                   'TC'                + csv +
070500211206                   'TERM CODE DESCRIPTION' + csv +
070600211206                   'AVG. AGE'          + csv +
070700211206                   '# OF MEM'          + csv +
070800211206                   'LAST INV $'        + csv +
070900211206                   'RECEIVABLE $'      + csv +
071000211206                   'AA NAME'           + csv +
071100211206                   'SMAN NAME'         + csv +
071200211206                   'CARRIER 1'         + csv +
071300211206                   'CARRIER 2'         + csv +
071400211206                   'CARRIER 3'         + csv +
071500211206                   'CARRIER 4'         + csv +
071600211206                   'CARRIER 5'         + csv +
071700211206                   'CARRIER 6'         + csv +
071800211206                   'CARRIER 7'         + csv +
071900211206                   'CARRIER 8'         + csv +
072000211206                   'CARRIER 9'         + csv +
072100211206                   'CARRIER 10'        + csv +
072200211206                     '",';
072300211206
072400200904        write rp180xr;
072500200904
072600200904        if ltrust = 'ALL';
072700200904         ltrust = ' ';
072800200904        endif;
072900200904
073000200904       endsr;
073100200904
073200210623      //===================================================================
