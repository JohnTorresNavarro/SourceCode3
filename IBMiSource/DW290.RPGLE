0001000210290015  ******************************************************************
000200021106      * DW290          Group Benefit Services, Inc.                    *
000300021029      *                                                                *
000400021029      *    WRITTEN BY - DAVID KETTERMAN                                *
000500021029      *    DATE       - 10/29/02                                       *
000600021029      *                                                                *
000700021029      * This program will produce the Delegated Billing GPR file       *
000800021029      * to Care First. DW280 must have completed before this program   *
000900021029      * will work.                                                     *
0010000211180015  * The output file will be created as an text file with "|"       *
0011000211180015  * delimiters and emailed back to the user for import to EXCEL.   *
0012000210290015  *                                                                *
001300030211SSK   * 02.11.2003.SSK BREAK FILL 20 FIELD OUT                         *
0014000307020015  * 07/02/03 dlk - change gpbildt to YYYYMM                        *
0015001508200015  * 08/20/15 dlk - seperate shop/exchange in seperate file from    *
0016001508200015  *                non-shop/exchange - care first request          *
0017001612190015  * 12/19/16 dlk - change to new GPR format beginning 1/1/17 and   *
0018001612190015  *                remove seperate file for SHOP                   *
0019001811130015  * 11/13/18 dlk - add net premium receipt field and PSF (Producer *
0020001811300015  *                Service Fee) payment type.                      *
0021001902040015  * 02/04/19 dlk - add CLASS per email from Chris Culotta @ CF,    *
0022001906260015  *                also fill prem & netprem with $.00 when it      *
0023001902040015  *                used to be blank since CF now does not want     *
0024001902050015  *                any field to be blank. Also, add edit for       *
0025001902050015  *                broker TIN and NPN blank since CF will not pay  *
0026001902050015  *                if both are missing. Also, if CFS Entity date   *
0027001902050015  *                should be used but it is zero, use the begin    *
0028001902050015  *                admin date instead.                             *
0029001903010015  * 03/01/19 dlk - Shelly request - send CFS entity date for all   *
0030001903010015  *                accounts instead of only new accts after 1/17   *
0031001903010015  *                as Care First documents says.                   *
0032001903130015  * 03/13/19 dlk - changes to support NASCO GPR file               *
0033001905220015  * 05/22/19 dlk - remove quotes from file per request from Manish *
0034001905220015  *                at Care First.                                  *
0035001906260015  * 06/26/19 dlk - Care First does not want records with all zeros *
0036001906260015  *                so I will omit those with net prem, prem, net   *
0037001906260015  *                contract and total payment all zeros.           *
0038002007100015  * 07/10/20 dlk - Fix error report headings                       *
0039002102190015  * 02/19/21 dlk - Fix 1 heading error                             *
0040002310310015  * 10/31/23 dlk - add lda parm for error report produced to tell  *
0041002310310015  *                CL when to send it since this pgm is run for    *
0042002310310015  *                small and lg group.                             *
0043002310310015  *                                                                *
0044001901100015  *   * Note - Any change to the PSF logic will need to be made    *
0045001901100015  *            in DW291 also.                                      *
0046001901100015  *                                                                *
0047000302110015  ******************************************************************
004800021029     Fcr130hsd  IP   E             DISK
004900990104     FCARMST    IF   E           K DISK
005000020201     Fagency    IF   E           K DISK
005100021118     Fsman      IF   E           K DISK
005200021209     Faccmst    IF   E           K DISK
005300161220     Fcarmksz1  IF   E           K DISK
005400170131     Fnpn       IF   E           K DISK
005500190204     Fclass     IF   E           K DISK
005600190322     Fcaraccxp  IF   E           K DISK
005700190402     Fplnmst    IF   E           K DISK
005800150820     Fdbgprxl   O  a e             DISK
0059001701240030 Fdw290p    O    F  132        PRINTER OFLIND(*INOg)
006000021106     d GPDBID          s              9
006100170131     d gpbssn          s              9
006200170131     d GPbnpn          s                   like(npnumber)
006300161220     d gpbname         s             40
006400161219     d gpdbname        s             30
006500021118     d f               s              1    inz('F')
006600161219     d GPaid           s              9
006700161220     d GPaname         s             40
006800161219     d GPgpefdt        s             10
006900161219     d GPbilmonth      s             10
007000161219     d GPpaytype       s             10
007100161220     d GPpayamt        s             13
007200161219     d GPcurcon        s             10
007300161219     d GPadjcon        s             10
007400161219     d GPnetcon        s             10
007500021106     d GPGRPNUM        s              8
007600190314     d GPclass         s              7
007700021106     d GPGRPNAM        s             40
007800161219     d GPMKSZ          s             20
007900021118     d GPPRM           s             14
008000181113     d GPNETPRM        s             14
008100161219     d GPPROD          s             10
008200161219     d GPPRODdes       s             40
008300021118     d gpremdt         s             10
008400021106     d ccompwk         s              7  2
008500021118     d cadmpwk         s              7  2
008600161220     d cbonpwk         s              7  2
008700161220     d gprate          s             13
008800161220     d lwiredtmdy      s              8s 0
008900161220     d wkdate          s              8s 0
009000161220     d wkdatemdy       s              8s 0
009100181204     d grosswk         s                   like(cpamt)
009200190322     d platform        s             10
009300231031     d parmerr         s              1
009400150820
009500150820      * pipe seperated variable
0096001905220125 D**psv              c                   const('"|"')
0097001905220125 Dpsv              c                   const('|')
009800150820
0099001612200124 D                 DS                  INZ
0100001612200125 D  CEFINV                 1      8  0
0101001612200125 D  CEFIYY                 1      4  0
0102001612200125 D  CEFIMM                 5      6  0
0103001612200125 D  CEFIDD                 7      8  0
0104000210290055 D                 DS
0105000210290056 D  cgroup                 1     15
0106000210290056 D   groupid               1      8
010700960408     D                UDS
010800021030     D leffyr                  1      4  0
010900021030     D leffmd                  5      8  0
011000021106     D lwiredt                 9     16  0
011100170209     D lseq                   17     18
011200190313     D lplatform              20     20
011300990104     ICARMSR
011400990104     I              CCOMP                       XCOMP
011500990104     I              CBONP                       XBONP
011600021030
011700161221     c* clear output file fields
011800161221     c                   exsr      #clear
011900161221
012000021118     c* get agency name
012100021029     c                   if        cagcod <> *blanks
012200021029     c     cagcod        chain     agency
012300021029     c                   if        %found(agency)
012400161219     c                   movel     agnam1        gpaname
012500161219     c                   movel     agtxid        gpaid
012600021029     c                   end
012700021029     c                   end
012800021029
012900161219     c* get sman (broker) name
013000021118     c                   if        cbcode <> *blanks
013100021118     c     cbcode        chain     sman
013200021118     c                   if        %found(sman)
013300170131SSK  c                   movel     STIN          gpbssn
013400161219     c                   movel     sfname        gpbname
013500021118     c                   if        smi <> ' '
013600161219     c                   cat       smi:1         gpbname
013700161219     c                   cat       '.':0         gpbname
013800021118     c                   end
013900161219     c                   cat       slname:1      gpbname
014000021118     c                   end
014100021118     c                   end
014200170131
014300190205     c* get sman NPN
014400170131     c     cbcode        chain     npn
014500170131     c                   if        %found(npn)
014600170131     c                   movel     npnumber      gpbnpn
014700170131     c                   end
014800190205
014900190205     c* If broker SSN and NPN are both blank, this is an error. One or the
015000190205     c* other is required for CFS to pay compensation.
015100190205     c                   if        gpbssn = *blanks and gpbnpn = *blanks
015200200710     c                   if        *inog or firste = ' '
015300190205     c                   except    head2
015400200710     c                   move      'N'           firste            1
015500190205     c                   end
015600190205     c                   except    err4
015700190205     c                   end
015800190205
015900161219      * Our DBE code is "D05"
016000021105     c                   eval      gpdbid   = 'D05'
016100161219     c                   eval      gpdbname = 'Group Benefit Services Inc'
016200021105
016300190322      * Group # - Nasco gets the acct # from caraccxp
016400190321      *         - Facets uses our full group #
016500190321      *
016600190321       clear gpgrpnum;
016700190321       if cgrpcd = 'NA';
016800190322        chain ('F': ctrust: csub: cacct: ccarcd) caraccxp;
016900190322        if %found(caraccxp);
017000190322         gpgrpnum = %trim(cahandling);
017100190321        endif;
017200190322      * missing NASCO acct # - error
017300190322        If gpgrpnum = *blanks;
017400200710         if *inog or firste = ' ';
017500200710          except head2;
017600200710          firste = 'N';
017700190322         endif;
017800190322         except err6;
017900190322        endif;
018000190321       else;
018100190321        gpgrpnum = groupid;
018200190321       endif;
018300190321
018400190321      * group name
018500021029     c                   eval      gpgrpnam = cacnam
018600161219
018700161219      * group eff dt: if our begin admin date >= 1/17 then send our
018800161219      * cfs entity date, others use our begin admin date
018900190301      * 03/01/19 - send CFS entity date for all accounts (Shelly request)
019000190301     c                   clear                   gpgpefdt
019100161219     c     acckey        chain     accmst
019200161219     c                   if        %found(accmst)
019300190301      * missing entity date - error
019400190301     c                   if        cfsedt = 0
019500200710     c                   if        *inog or firste = ' '
019600200710     c                   except    head2
019700200710     c                   move      'N'           firste
019800190301     c                   end
019900190301     c                   except    err5
020000190301     c                   end
020100190301
020200161219     c                   eval      wkdate = cfsedt
020300161219     C                   MOVE      wkdate        @DATIN
020400161219     C                   EXSR      #DATYM
020500161219     C                   MOVE      @DATOU        wkdatemdy
020600161219       gpgpefdt = %editw(wkdatemdy:'  /  /    ');
020700161219     c                   end
020800161219
020900170131      * get GPR market segment size range based on market size code in
021000170127      * CR130HSD. Must EXACTLY match Care First values
021100170127
021200161220       setll (ccarcd:cmksz) carmksz1;
0213001612200131   dou   %eof(CARMKSZ1);
0214001612200132   reade (ccarcd:cmksz) carmksz1;
0215001612200133   if    not %eof(carmksz1) and
0216001612200133         (cefinv >= czfrdt and (cztodt = 0 or cefinv <= cztodt));
021700161220       gpmksz = 'Group ' + %trim(%char(%editc(czfrsz:'3'))) + '-' +
021800161220                           %trim(%char(%editc(cztosz:'3')));
021900161220       leave;
022000161220       endif;
022100161220       enddo;
022200170124
022300170127      * medchi needs to have market size 200+ and we need to convert our
022400170131      * 201-99999 to the CF preferred format of 200+
022500170127
022600170127       if ccarcd = 'FAS' or gpmksz = 'Group 201-99999     ' ;
022700161220       clear gpmksz;
022800170124       gpmksz = 'Group 200+          ';
022900161220       endif;
023000190313
023100190313      * All of NASCO
023200190313       if cgrpcd = 'NA';
023300190313       clear gpmksz;
023400190313       gpmksz = 'National Control    ';
023500190313       endif;
023600190313
023700161219    *
023800170124      * if market size does not EXACTLY match one of CF values, print error
023900170405      * if the effective date of transaction is >= 1/1/17
024000170405      *
024100170124      * Group 1-50
024200170124      * Group 51-100
024300170124      * Group 101-200
024400170124      * Group 200+
024500170124      * National Control
024600170124    *
024700170124       select;
024800170124       when gpmksz <> 'Group 1-50          ' and
024900170124            gpmksz <> 'Group 51-100        ' and
025000170124            gpmksz <> 'Group 101-200       ' and
025100170124            gpmksz <> 'Group 200+          ' and
025200170405            gpmksz <> 'National Control    ' and
025300170405            cefinv >= 20170101;
025400200710        if *inog or firste = ' ';
025500200710          except head2;
025600200710          firste = 'N';
025700170124        endif;
025800170127        except err1;
025900170124       endsl;
026000170124    *
026100170124    *
026200161219      * bill month
026300161220       gpbilmonth =  %char(cefimm) + '/01/' + %char(cefiyy);
026400161219
026500161219      * premium receipts
026600161219       gpprm  = %editc(cpamt:'N':*cursym);
026700161221
026800190322      * product description from carrier name line 2 for Facets file,
026900190402      * We do not store a NASCO equivalent, Shelly suggested we send our
027000190402      * plan description and they will include as much of the CF prod
027100190402      * description as possible
027200190402
027300190402        chain ccarcd carmst;
027400190402        if not %found(carmst);
027500200710         if *inog or firste = ' ';
027600190402         except head2;
027700200710         firste = 'N';
027800190402         endif;
027900190402         except err2;
028000190402        endif;
028100190402
028200190402      * Facets uses carrier name line 2
028300190322       if cgrpcd <> 'NA';
028400190322         gpproddes = cnamec;
028500190402
028600190402      * NASCO uses plan desc
028700190402       else;
028800190402        chain (ctrust:csub:cplan) plnmst;
028900190402        if %found(plnmst);
029000190402         gpproddes = pdescr;
029100190402        endif;
029200190322       endif;
029300161219
029400190314      * CLASS: Facets uses class
029500190314        clear gpclass;
029600190314       if cgrpcd <> 'NA';
029700190314        chain (ctrust:csub:cplan) class;
029800190314        if not %found(class);
029900200710         if *inog or firste = ' ';
030000190314         except head2;
030100200710         firste = 'N';
030200190314         endif;
030300190314         except err3;
030400190314        else;
030500190314         gpclass = clclass;
030600190314        endif;
030700190314
030800190321      * NASCO uses first 7 of our group # (this is the NASCO Subgroup on
030900190321      * the NASCO GPR
031000190314       else;
031100190314       gpclass = %subst(cgroup:1:7);
031200190314       endif;
031300190204
031400190402      * get product type from carrier master
031500161220       select;
031600161220       WHEN CAPDTY = 'MH' or capdty = 'MI';
031700161220       gpprod = 'Medical';
031800161220       WHEN CAPDTY = 'DH' or capdty = 'DI';
031900161221       gpprod = 'Dental ';
032000161220       WHEN CAPDTY = 'RX';
032100161221       gpprod = 'Drug   ';
032200161220       WHEN CAPDTY = 'VS';
032300161221       gpprod = 'Vision ';
032400161220       OTHER;
032500161221       gpprod = 'Other  ';
032600161220       ENDSL;
032700161219
032800161219      * current, adj and net contracts
032900161219       gpcurcon = %editc(clivesb:'P');
033000161219       gpadjcon = %editc(clivesa:'P');
033100161219       gpnetcon = %editc(clives:'P');
033200021029
033300161220      * wire date as MM/DD/YYYY
033400161220       @datin = lwiredt;
033500161220       EXSR #DATYM;
033600161220       lwiredtmdy = @DATOU;
033700161220       gpremdt = %editw(lwiredtmdy : '  /  /    ');
033800021118
033900161219      * write 3 GPR records for each CR130HSD record
034000181113      * 1. Commission or PSF
034100161219      * 2. Admin fee
034200161219      * 3. Bonus Draw
034300161220
034400181130      *************************************************************
034500181204      * Commission record, or PSF record for 51+ Med / Rx only
034600181130      *************************************************************
034700161220       gppaytype = 'Commission';
034800161220       clear ccompwk;
034900190205       clear gpnetprm;
035000190204      ** 2/4/19 - CF changed the requirements, now no field can be blank so
035100190626      **          fill with $.00
035200190626       gpnetprm = '$.00';
035300190204
035400161220       if ccome <> 0;  // only fill comm rate when comm is paid
035500161220        ccompwk   = ccomp * 100;
035600161220       endif;
035700161220
035800161220       if %trim(ccmeth) = '%';
035900161220        gprate = %trim(%char(%editc(ccompwk:'P'))) + '%';
036000161220        else;
036100161220        gprate = %trim(%char(%editc(ccompwk:'P':'$')));
036200161220       endif;
036300161220
036400161220       gppayamt  = %editc(ccome:'P':'$');
036500181113
036600181113      *
036700181130      * PSF fees - Carrier codes PSM, PSX:
036800181130      * Only used for 51+ groups Med and RX.
036900181130      * Type is PSF instead of commission and the values populated
037000181204      * will be different (net prem field used).
037100181204      *
037200181204      * PSF carriers GRATE holds the billed rate as the prem + PSF and
037300181204      * the net rate holds just the premium (without the PSF).
037400181204      * This is different from most everything else because the PSF
037500181204      * needs to be a percent of the net rate, not the billed.
037600181204      * Since care first still wants us to send the full billed amount,
037700181204      * the commission will have to be ADDED to the paid amt to come up
037800181204      * with the actual billed.
037900181130
038000181130       IF ccarcd = 'PSM' or ccarcd = 'PSX';
038100181130        gppaytype = 'PSF       ';
038200181130        gpnetprm  = %editc(cpamt:'N':*cursym);
038300181204        clear grosswk;
038400181204        grosswk = cpamt + ccome;
038500181204        gpprm = %editc(grosswk:'N':*cursym);
038600181130       endif;
038700181113
038800161220       exsr writexldet;
038900161220
039000161220      ******************
039100161220      * Admin fee record
039200161220      ******************
039300161220       gppaytype = 'Fees      ';
039400190205       clear gpnetprm;
039500190205       clear gpprm;
039600190205      ** 2/4/19 - CF changed the requirements, now no field can be blank so
039700190626      **          fill with $.00
039800190626       gpnetprm = '$.00';
039900190626       gpprm    = '$.00';
040000190204
040100190204       clear cadmpwk;
040200161220       if cadme <> 0;  // only fill af rate when af is paid
040300161220        cadmpwk   = cadmp * 100;
040400161220       endif;
040500161220
040600161220       if %trim(cameth) = '%';
040700161220        gprate = %trim(%char(%editc(cadmpwk:'P'))) + '%';
040800161220        else;
040900161220        gprate = %trim(%char(%editc(cadmpwk:'P':'$')));
041000161220       endif;
041100161220
041200161220       gppayamt  = %editc(cadme:'P':'$');
041300161220       exsr writexldet;
041400161220
041500161221      *******************
041600161220      * Bonus Draw record
041700161220      *******************
041800161220       gppaytype = 'Bonus     ';
041900161220       clear cbonpwk;
042000161220       if cbonp <> 0;  // only fill bd rate when bd is paid
042100161220        cbonpwk   = cbonp * 100;
042200161220       endif;
042300161220
042400161220       if %trim(cbmeth) = '%';
042500161220        gprate = %trim(%char(%editc(cbonpwk:'P'))) + '%';
042600161220        else;
042700161220        gprate = %trim(%char(%editc(cbonpwk:'P':'$')));
042800161220       endif;
042900161220
043000161220       gppayamt  = %editc(cbond:'P':'$');
043100161220       exsr writexldet;
043200021106
043300021106     c     #end          tag
043400231031
043500231031     clr                 exsr      #lr
043600021106
043700161220      ****************************
043800161220      * clear all output fields  *
043900161220      ****************************
044000021106     C     #clear        begsr
044100021106     c                   clear                   GPDBID
044200161219     c                   clear                   GPDBname
044300170131     c                   clear                   gpbssn
044400170131     c                   clear                   GPBNPN
044500161220     c                   clear                   GPBNAME
044600161221     c                   clear                   gpaid
044700161221     c                   clear                   gpaname
044800161221     c                   clear                   GPGRPNUM
044900190204     c                   clear                   GPCLASS
045000161221     c                   clear                   GPGRPNAM
045100161221     c                   clear                   gpgpefdt
045200161221     c                   clear                   GPMKSZ
045300161221     c                   clear                   gpbilmonth
045400181113     c                   clear                   GPNETPRM
045500181113     c                   clear                   GPPRM
045600161221     c                   clear                   GPPRODDES
045700161221     c                   clear                   GPPROD
045800161221     c                   clear                   gppaytype
045900161221     c                   clear                   gpcurcon
046000161221     c                   clear                   gpadjcon
046100161221     c                   clear                   gpnetcon
046200161221     c                   clear                   gprate
046300161221     c                   clear                   gppayamt
046400161221     c                   clear                   gpremdt
046500021106     C                   ENDSR
046600021106
046700150820
0468001508200164 C*************************************************************
0469001508200164 C* Write Spreadsheet Detail                                  *
0470001508200164 C*************************************************************
047100161221       begsr Writexldet;
047200190626      *
047300190626      * 06/29/19 - do not write if the following 4 fields are zero,
047400190626      *            (this is an error to Care First):
047500190626      *            Net prem, prem, net contract cnt, total payment
047600190626      *
047700190626
047800190626       if %trim(gpnetprm) = '$.00' and
047900190626          %trim(gpprm)    = '$.00' and
048000190626          %trim(gpnetcon) =  '.00' and
048100190626          %trim(gppayamt) = '$.00';
048200190626       leavesr;
048300190626       endif;
048400150820
048500161221       clear dbgprfld;
048600190522       dbgprfld  =
048700161221         %trim(gpdbid)             + psv +
048800161221         %trim(gpdbname)           + psv +
048900170131         %trim(gpbssn)             + psv +
049000170131         %trim(gpbnpn)             + psv +
049100161221         %trim(gpbname)            + psv +
049200161221         %trim(gpaid)              + psv +
049300161221         %trim(gpaname)            + psv +
049400161221         %trim(gpgrpnum)           + psv +
049500190204         %trim(gpclass)            + psv +
049600161221         %trim(gpgrpnam)           + psv +
049700161221         %trim(gpgpefdt)           + psv +
049800161221         %trim(gpmksz)             + psv +
049900161221         %trim(gpbilmonth)         + psv +
050000181113         %trim(gpnetprm)           + psv +
050100181113         %trim(gpprm)              + psv +
050200161221         %trim(gpproddes)          + psv +
050300161221         %trim(gpprod)             + psv +
050400161221         %trim(gppaytype)          + psv +
050500161221         %trim(gpcurcon)           + psv +
050600161221         %trim(gpadjcon)           + psv +
050700161221         %trim(gpnetcon)           + psv +
050800161221         %trim(gprate)             + psv +
050900161221         %trim(gppayamt)           + psv +
051000190522         %trim(gpremdt);
051100161221       Write dbgprr;
051200150820
0513001612210320   ENDSR;
051400161221
051500161221      *************************************************************
051600161221      * Write Spreadsheet heading                                 *
051700161221      *************************************************************
051800161221       begsr Writexlhead;
051900150820
052000161221       clear dbgprfld;
052100190522       dbgprfld =
052200161221         'DBE Code'                + psv +
052300161221         'DBE Name'                + psv +
052400170131         'Broker SSN'              + psv +
052500170131         'Broker NPN'              + psv +
052600161221         'Broker'                  + psv +
052700161221         'Agency ID'               + psv +
052800161221         'Agency'                  + psv +
052900161221         'Group #'                 + psv +
053000190509         'Class ID'                + psv +
053100161221         'Group Name'              + psv +
053200161221         'Group Effective Date'    + psv +
053300161221         'Market Segment Size'     + psv +
053400161221         'Bill Month'              + psv +
053500181113         'Net Premium Receipts'    + psv +
053600181113         'Premium Receipts'        + psv +
053700161221         'Product Description'     + psv +
053800161221         'Product Type'            + psv +
053900161221         'Payment Type'            + psv +
054000161221         'Current Contracts'       + psv +
054100161221         'Adjusted Contracts'      + psv +
054200161221         'Net Contracts'           + psv +
054300161221         'Rate'                    + psv +
054400161221         'Payment Amount'          + psv +
054500190522         'Remittance Date';
054600161219
054700161221       Write dbgprr;
054800150820
0549001612210320   ENDSR;
055000150820
0551001612190103 C***************************************************
0552001612190104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0553001612190105 C***************************************************
0554001612190107 C*
0555001612190107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0556001612190107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0557001612190107 C*
0558001612190106 C     #DATYM        BEGSR
055900161219     C                   MOVE      @DATIN        @MD               4 0
056000161219     C                   MOVEL     @DATIN        @Y                4 0
056100161219     C                   MOVEL     @MD           @DATOU            8 0
056200161219     C                   MOVE      @Y            @DATOU
056300161219     C                   MOVE      *ZEROS        @DATIN            8 0
0564001612190120 C                   ENDSR
056500231031
056600231031      *************************************************************
056700231031      * LR time                                                   *
056800231031      *************************************************************
056900231031       begsr #lr;
057000231031
057100231031      * set parm to tell CL an error report was created this run
057200231031       if firste <> *blank;
057300231031        parmerr = 'Y';
057400231031        else;
057500231031        parmerr = *blank;
057600231031       endif;
057700231031
057800231031       endsr;
057900231031
058000231031      *************************************************************
058100231031      * First cycle                                               *
058200231031      *************************************************************
058300021106     C     *inzsr        begsr
058400231031     c     *ENTRY        plist
058500231031     C                   parm                    parmerr
058600231031
058700021106     C                   TIME                    HTIME             6 0
058800231031
058900021209     C     acckey        KLIST
059000021209     C                   KFLD                    ctrust
059100021209     C                   KFLD                    csub
059200021209     C                   KFLD                    cacct
059300021118
059400190322      * for report heading
059500190322       if lplatform = 'N';
059600190322        platform = 'NASCO';
059700190322       else;
059800190322        platform = 'FACETS';
059900190322       endif;
060000150820     C                   Exsr      Writexlhead
060100190322     C****               EXCEPT    HEAD2
060200021106     C                   ENDSR
0603001701240237 Odw290p    E            head2          2 03
0604000210300239 O                                           73 '** GROUP BENEFIT SERVICE'
0605000210300241 O                                           77 'S **'
0606000210300242 O          E            head2          1
0607001903220244 O                                           79 'DB GPR ERROR REPORT - '
0608001903220244 O                       platform            +1
0609000210300242 O          E            head2          1
061000170209 244 O                                           60 'FOR :'
061100170209 244 O                       LEFFmd              66 '  /  '
061200170209 244 O                                           67 '/'
061300170209 244 O                       LEFFyr              71
061400170209 244 O                                           +2 'SEQ :'
061500170209 244 O                       lseq                +1
0616000210300242 O          E            head2          1
0617000211060248 O                                           24 'PROGRAM NAME: DW290'
0618000210300249 O                                          122 'PAGE :'
0619000210300250 O                       PAGE2         Z    131
0620000210300242 O          E            head2          1
0621000210300253 O                                           14 'RUN DATE:'
0622000210300254 O                       UDATE         Y     25
0623000210300255 O                                          122 'TIME :'
0624000210300256 O                       HTIME              131 '  :  :  '
0625000210300242 O          E            head2          1
0626000210300259 O                                           24 '------------------------'
0627000210300260 O                                           48 '------------------------'
0628000210300261 O                                           72 '------------------------'
0629000210300262 O                                           96 '------------------------'
0630000210300263 O                                          120 '------------------------'
0631000210300286 O                                          132 '------------'
0632000210300242 O          E            head2          1
0633000210300267 O                                            9 'ACCOUNT #'
0634000210300268 O                                           21 'DATA'
0635000210300268 O                                          113 'ERROR'
0636000210300242 O          E            head2          2
0637000210300259 O                                           24 '------------------------'
0638000210300260 O                                           48 '------------------------'
0639000210300261 O                                           72 '------------------------'
0640000210300262 O                                           96 '------------------------'
0641000210300263 O                                          120 '------------------------'
0642000210300286 O                                          132 '------------'
0643001701270287 O          E            err1           1
0644000210300288 O                       ctrust               3
0645000210300288 O                                            4 '-'
0646000210300288 O                       csub                 7
0647000210300288 O                                            8 '-'
0648000210300288 O                       cacct               12
0649001701240288 O                                           25 'CARRIER:'
0650001701240288 O                       ccarcd              +1
0651001701240288 O                                           +2 'MKSZ:'
0652001701240288 O                       cmksz               +1
0653001701270288 O                                           +2 'EFF DATE:'
0654001701270288 O                       cefinv              +1 '    /  /  '
0655001701240288 O                                           +2 'Market Segment:'
0656001701240288 O                       gpmksz              +1
0657001704040288 O                                          130 'Mkt Seg not valid after 1/'
0658001704040288 O                                          132 '17'
0659001701240287 O          E            err2           1
0660001701240288 O                       ctrust               3
0661001701240288 O                                            4 '-'
0662001701240288 O                       csub                 7
0663001701240288 O                                            8 '-'
0664001701240288 O                       cacct               12
0665001701240288 O                       ccarcd              20
0666001902040288 O                                          132 'Missing CARMST            '
0667001902040287 O          E            err3           1
0668001902040288 O                       ctrust               3
0669001902040288 O                                            4 '-'
0670001902040288 O                       csub                 7
0671001902040288 O                                            8 '-'
0672001902040288 O                       cacct               12
0673001902040288 O                       cplan               20
0674001902040288 O                                          132 'Missing CLASS             '
0675001902050287 O          E            err4           1
0676001902050288 O                       ctrust               3
0677001902050288 O                                            4 '-'
0678001902050288 O                       csub                 7
0679001902050288 O                                            8 '-'
0680001902050288 O                       cacct               12
0681001902050288 O                                           22 'PLAN:'
0682001902050288 O                       cplan               +1
0683001902050288 O                                           +2 'SMAN:'
0684001902050288 O                       cbcode              +1
0685001902050288 O                       gpbname             +1
0686001902050288 O                                          132 'Broker TIN and NPN missing'
0687001903010287 O          E            err5           1
0688001903010288 O                       ctrust               3
0689001903010288 O                                            4 '-'
0690001903010288 O                       csub                 7
0691001903010288 O                                            8 '-'
0692001903010288 O                       cacct               12
0693001903010288 O                                          132 'CFS Entity date is missing'
0694001903220287 O          E            err6           1
0695001903220288 O                       ctrust               3
0696001903220288 O                                            4 '-'
0697001903220288 O                       csub                 7
0698001903220288 O                                            8 '-'
0699001903220288 O                       cacct               12
0700001903220288 O                                           +2 'CARRIER:'
0701001903220288 O                       ccarcd              +1
0702001903220288 O                                          132 'NASCO Account # is missing'
