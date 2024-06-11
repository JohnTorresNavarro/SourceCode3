000001200812      //===================================================================
000100200814     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000101200812      //===================================================================
001703200814      * RP135CR - History Transaction
001704200814      *====================================================================
001705200814      * Date         Int  Description
001706200814      * ----------   ---  -------------------------------------------------
001707200814      * 08/14/2020   jt   Original Creation
001708210303      * 03/03/2021   jt   Fixed plan missing on certain trans. codes.
001709210624      * 06/24/2021   jt   Capitalized parm value.
001710200814      //===================================================================
001711200814
001901200814     fhistl94   if   e           k disk    rename(histr:histFile)
001902200814     f                                     InfDs(InfDSKey)
001903200812
001904200814     fhistl95   if   e           k disk    rename(histr:histFile2)
001905200814     f                                     InfDs(InfDSKey2)
001906200814
002000200812     fcodes     if   e           k disk    extfile('F.CODES')
002001200812     f                                     rename(codesr:codesFile)
002002200812
002100200812     fmember    if   e           k disk    extfile('F.MEMBER')
002101200812
002200200812     fplnauxp   if   e           k disk    rename(plnauxr:auxFile)
002201200812
002202210224     fplnmst    if   e           k disk    rename(plnmsr:planFile)
002203210224     f                                     extfile('F.PLNMST')
002204210224
002205210224     fcarmst    if   e           k disk    rename(carmsr:carrFile)
002206210224     f                                     extfile('F.CARMST')
002208210224
002300200814     frp135wkp  uf a e             disk    rename(rp135wkr:workFile)
002301200812
002302200814     frp135wkpc if a e             disk    rename(rp135pmr:parmFile)
002303200814
002304200812      //===================================================================
002305200814      // variables and data structures
002306200814      //===================================================================
002307200814
002308200814     dInfDSKey         ds
002309200814     d rrn1                  397    400U 0
002310200814
002311200814     d InfDSKey2       ds
002312200814     d  rrn2                 397    400U 0
002313200814
002500200814     d ssnoout         s             18
002600200814     d ck#notout       s             30
002700200814     d note2out        s             30
002900200814     d acaflg          s              1
002901200814     d selectedCode    s              1
002902200814     d scode1          s              3
002903200812     d htype           s              1
002904200812     d ck#pln          s              4
002907200814     d fromDt          s              8  0
002908200814     d toDt            s              8  0
002909200812     d planx           s              4
002910200814     d trstk           s              3  0
002911200814     d sub#k           s              3  0
002912200814     d acctk           s              4  0
002913200814     d writeTSA        s              1
002914200814     d writeSSN        s              1
002915200814     d trst            s              3
002916200814     d sub             s              3
002917200814     d acct            s              4
002918200814     d codeFound       s              1
002919200819     d selssnd         s              9  0
002920210630     d tsaC            s             10
002921210630     d yesno           s              1
003000050920
003001200819     d runRpt          pr                  ExtPgm('RP135ER')
003002200825     d  orderby                       7    const
003003200814
003004210630     d checkEBS        pr                  ExtPgm('GETEBSCL')
003005210630     d  tsaC                         10    const
003006210630     d  yesno                         1    const
003007210630
005903200814     d rp135cr         pi
005904200814     d  fromDate                       d
005905200814     d  toDate                         d
005906200814     d  strust                        3
005907200814     d  ssub#                         3
005908200814     d  sacct                         4
005909200819     d  selssn                        9
005910200814     d  maskssn                       1
005911200814     d  ssnorlast                     4
005912200814     d  trCode1                       3
005913200814     d  trCode2                       3
005914200814     d  trCode3                       3
005915200814     d  trCode4                       3
005916200814     d  trCode5                       3
005917200814     d  trCode6                       3
005918200814     d  trCode7                       3
005919200814     d  trCode8                       3
005920200814     d  trCode9                       3
005921200814     d  trCode10                      3
005922200814     d  userID                       10
005923200814     d  includes                      9
005924200825     d  orderby                       7
005925210630     d  sebs                          1
005926200814
005927200814      //========================================================================
005928200814      // includes
005929200814      //========================================================================
005930200814
005931200814      /include GBSPGM/QMODSRC,#GettokPR
005932200814      /include GBSPGM/QMODSRC,#zFillpr
005933200814
009500200812      //===================================================================
009501200812      // mainline
009502200812      //===================================================================
009503200812
009504200812       exsr init;
009505200812       exsr main;
009506200812       exsr exit;
009507200812
009508200814      //===================================================================
009509200814      // main 2
009510200814      //===================================================================
009511200814
009512200814       begsr main;
009513200814
009514200814        exsr main2;
009515200814
009516200814        if userID > ' ' and userID <> 'ALL';
009517200814         exsr check_userID;
009518200814        endif;
009519200814
009520200814        if strust <> 'ALL';
009521200814         exsr checkTrust;
009522200814        endif;
009523200814
009524200814        if includes <> 'ALL';
009525200814         exsr checkInclude;
009526200814        endif;
009527200814
009528210630        if sebs = 'Y';
009529210630         exsr check_ifEBS;
009530210630        endif;
009531210630
009532200814       endsr;
009533200814
009534200814      //===================================================================
009535200814      // main 2
009536200814      //===================================================================
009537200814
009538200814       begsr main2;
009539200814
009540200814        if trcode1 = ' ' and trcode2 = ' ' and trcode3 = ' ' and
009541200814         trcode4 = ' ' and trcode5 = ' ' and trcode6 = ' ' and
009542200814          trcode7 = ' ' and trcode8 = ' ' and trcode9 = ' ' and
009543200814           trcode10 = ' ';
009544200814          scode1 = ' ';
009545200814          exsr main3;
009546200814         leavesr;
009547200814        endif;
009548200814
009549200814        if trcode1 > ' ';
009550200814         exsr codesSelected;
009551200814         exsr main3;
009552200814        endif;
009553200814
009554200814        if trcode2 > ' ';
009555200814         exsr codesSelected;
009556200814         exsr main3;
009557200814        endif;
009558200814
009559200814        if trcode3 > ' ';
009560200814         exsr codesSelected;
009561200814         exsr main3;
009562200814        endif;
009563200814
009564200814        if trcode4 > ' ';
009565200814         exsr codesSelected;
009566200814         exsr main3;
009567200814        endif;
009568200814
009569200814        if trcode5 > ' ';
009570200814         exsr codesSelected;
009571200814         exsr main3;
009572200814        endif;
009573200814
009574200814        if trcode6 > ' ';
009575200814         exsr codesSelected;
009576200814         exsr main3;
009577200814        endif;
009578200814
009579200814        if trcode7 > ' ';
009580200814         exsr codesSelected;
009581200814         exsr main3;
009582200814        endif;
009583200814
009584200814        if trcode8 > ' ';
009585200814         exsr codesSelected;
009586200814         exsr main3;
009587200814        endif;
009588200814
009589200814        if trcode9 > ' ';
009590200814         exsr codesSelected;
009591200814         exsr main3;
009592200814        endif;
009593200814
009594200814        if trcode10 > ' ';
009595200814         exsr codesSelected;
009596200814         exsr main3;
009597200814        endif;
009598200814
009599200814        if userID > ' ' and userID <> 'ALL';
009600200814         exsr check_userID;
009601200814        endif;
009602200814
009603200814        if strust <> 'ALL';
009604200814         exsr checkTrust;
009605200814        endif;
009606200814
009607200814        if includes <> 'ALL';
009608200814         exsr checkInclude;
009609200814        endif;
009610200814
009611210630        if sebs = 'Y';
009612210630         exsr check_ifEBS;
009613210630        endif;
009614210630
009615200814       endsr;
009616200814
009617200812      //===================================================================
009618200814      // main 3
009619200812      //===================================================================
009620200812
009621200814       begsr main3;
009622200812
009623200814        if scode1 > ' ';
009801200814         setll (scode1 : fromDt) histfile;
009802200814         reade (scode1) histFile;
009803200814        else;
009804200814         setll (fromDt) histfile2;
009805200814         read histFile2;
009807200814        endif;
009808200812
009809200812        dow not %eof;
009810200812
009811200814         if trdate <= toDt;
009813200814         exsr codeMatch;
009814200814         if codeFound = 'Y';
010500200814          ck#notout = ck#not;
010501200821
010502200821          note2out = note2;
010503200821          if recvdt > 0 and trcode = 'BMP';
010600200821           note2out = 'RD=' + %char(%date(recvdt : *iso):*usa/);
010601200821          endif;
010602200812
010603200814          if %subst(hkey:1:1) = ' ';
010700200814           ssnoout = %subst(hkey:2:3) + '-' + %subst(hkey:5:2) + '-'
010701200814                   + %subst(hkey:7:4);
010702200812
010901200814           ck#pln = %subst(ck#not:1:4);
010902200812
011000200814           if ck#pln <> ' ';
011100200814            chain (hstrst: hssub# : ck#pln) auxFile;
011101200814            acaflg = ' ';
011200200814            if %found and pxacar = 'Y';
011300200814             acaflg = 'Y';
011400200814            endif;
011500200814           endif;
011600200812
011601200814           planx = ' ';
011602200814           if %found;
011604200814            planx = ck#pln;
011605200814           endif;
011606200814
011607200814           if ssnorlast = 'SSN';
011700200814            if maskssn = 'Y';
012100200814             ssnoout = %trim(' XXX-XX-') + %trim(%subst(hkey:7:4));
012200050921
012400200814             if %subst(ck#not:5:1) = '-' and %subst(ck#not:8:1) = '-';
012401200812
012500200814              if %subst(ck#not:9:4) >= '0000' and %subst(ck#not:9:4) <= '9999';
012600200814               ck#notout = %subst(' XXX-XX':1:6);
012700200814              endif;
012701200812
012707200814             else;
012708200814              ck#notout = ' ';
012709200814              ck#notout = %subst(ck#not:6:25);
012710200814              //ck#notout = ck#not;
012800200814             endif;
012802200812
012803200814            endif;
012804200814           endif;
012805200814
013000200814           if trcode = 'M54';
013100200814            ck#notout = %subst('XXXXX':1:5) + %subst(ck#notout:6:25);
013101200814            note2out = %subst('XXXXX':1:5) + %subst(note2out:6:25);
013300200814           endif;
013400050921
013600200814           if trcode = 'UHM';
013700200814            ck#notout = ' ';
013800200814            note2out = ' ';
013900200814           endif;
014000050921
019200200814           htype = %subst(hkey:1:1);
020000200814           if htype = ' ';
020001200814            chain (%dec(%subst(hkey:2:9):9:0)) member;
020002200814            if ssnorlast = 'LAST';
020003200814             ssnoout = mlname;
020004200814            endif;
020006200814           endif;
020007200821
020019200821           note2out = note2;
020020200821           if recvdt > 0 and trcode = 'BMP';
020021200821            note2out = 'RD=' + %char(%date(recvdt : *iso):*usa/);
020022200821           endif;
020023200812
020024200814           exsr writeRP135;
020100200812
022500200814          endif;
022501200812
022502200821          //if scode1 = 'BMP';
022503200821          if %subst(hkey:1:1) <> ' ';
022504200821           ssnoout = %subst(hkey:1:3) + '-' + %subst(hkey:4:3) + '-'
022505200821                   + %subst(hkey:7:4);
022506200814
022507200821           ck#pln = %subst(ck#not:1:4);
022508200814
022509200821           if ck#pln <> ' ';
022510200821            chain (hstrst: hssub# : ck#pln) auxFile;
022511200821            acaflg = ' ';
022512200821            if %found and pxacar = 'Y';
022513200821             acaflg = 'Y';
022514200821            endif;
022515200821           endif;
022516200814
022517200821           planx = ' ';
022518200821           if %found;
022519200821            planx = ck#pln;
022520200821           endif;
022521200814
022522200821           ck#notout = ck#not;
022523200821
022524200821           if ssnorlast = 'SSN';
022526200821            if maskssn = 'Y';
022527200821             ssnoout = ' ';
022528200821             //if %subst(ck#not:5:1) = '-' and %subst(ck#not:8:1) = '-';
022529200814
022530200821              //if %subst(ck#not:9:4) >= '0000' and %subst(ck#not:9:4) <= '9999';
022531200821              // ck#notout = %subst(' XXX-XX':1:6);
022532200821              //endif;
022533200814
022534200821             //else;
022535200821             // ck#notout = ' ';
022536200821             // ck#notout = %subst(ck#not:6:25);
022537200821             // ck#notout = ck#not;
022538200821             //endif;
022539200814
022540200821            endif;
022541200821           endif;
022542200814
022543200821           if trcode = 'M54';
022544200821            ck#notout = %subst('XXXXX':1:5) + %subst(ck#notout:6:25);
022545200821            note2out = %subst('XXXXX':1:5) + %subst(note2out:6:25);
022546200821           endif;
022547200814
022548200821           if trcode = 'UHM';
022549200821            ck#notout = ' ';
022550200821            note2out = ' ';
022551200821           endif;
022552200814
022553200821           htype = %subst(hkey:1:1);
022554200821           if htype = ' ';
022555200821            chain (%dec(%subst(hkey:2:9):9:0)) member;
022556200821            if ssnorlast = 'LAST';
022557200821             ssnoout = mlname;
022558200821            endif;
022559200821           endif;
022560200814
022561210226           htype = %subst(hkey:1:1);
022562210303           if htype > ' ' and (trcode = 'GRC' or trcode = 'GRA'
022563210303                            or trcode = 'GRM');
022565210226            chain ( (%dec(%subst(ck#not:2:3):3:0)) +
022566210226                    (%dec(%subst(ck#not:6:2):2:0)) +
022567210226                    (%dec(%subst(ck#not:9:4):4:0)) )
022568210226              member;
022569210226            if ssnorlast = 'LAST';
022570210226             ssnoout = mlname;
022571210226            endif;
022572210226           endif;
022573210226
022574200821           exsr writeRP135;
022575200814
022576200821          endif;
022577200814
022578200821         //endif;
022579200819         endif;
022580200821         endif;
022581210303
022701200819         if scode1 > ' ';
022703200819          reade (scode1) histFile;
022704200819         else;
022706200819          read histFile2;
022707200819         endif;
022708200814
022709200819        enddo;
022711200812
023301200812       endsr;
023400160818
023401200814      //===================================================================
023402200814      // code match
023403200814      //===================================================================
023404200814
023405200814       begsr codeMatch;
023406200814
023407200814        codeFound = 'N';
023408200814
023409200814        if scode1 > ' ';
023410200814         if scode1 = trcode;
023411200814          codeFound = 'Y';
023412200814         endif;
023413200814        endif;
023414200814
023415200814        if scode1 = ' ';
023416200814         codeFound = 'Y';
023417200814        endif;
023418200814
023419200814       endsr;
023420200814
023421200814      //===================================================================
023422200814      // codes selected
023423200814      //===================================================================
023424200814
023425200814       begsr codesSelected;
023426200814
023427200814        selectedCode = 'N';
023428200814        scode1 = ' ';
023429200814
023430200814         select;
023431200814          when trCode1 > ' ';
023432200814           selectedCode = 'Y';
023433200814           scode1 = TrCode1;
023434200814           trCode1 = ' ';
023435200814
023436200814          when trCode2 > ' ';
023437200814           selectedCode = 'Y';
023438200814           scode1 = TrCode2;
023439200814           trCode2 = ' ';
023440200814
023441200814          when trCode3 > ' ';
023442200814           selectedCode = 'Y';
023443200814           scode1 = TrCode3;
023444200814           trCode3 = ' ';
023445200814
023446200814          when trCode4 > ' ';
023447200814           selectedCode = 'Y';
023448200814           scode1 = TrCode4;
023449200814           trCode4 = ' ';
023450200814
023451200814          when trCode5 > ' ';
023452200814           selectedCode = 'Y';
023453200814           scode1 = TrCode5;
023454200814           trCode5 = ' ';
023455200814
023456200814          when trCode6 > ' ';
023457200814           selectedCode = 'Y';
023458200814           scode1 = TrCode6;
023459200814           trCode6 = ' ';
023460200814
023461200814          when trCode7 > ' ';
023462200814           selectedCode = 'Y';
023463200814           scode1 = TrCode7;
023464200814           trCode7 = ' ';
023465200814
023466200814          when trCode8 > ' ';
023467200814           selectedCode = 'Y';
023468200814           scode1 = TrCode8;
023469200814           trCode8 = ' ';
023470200814
023471200814          when trCode9 > ' ';
023472200814           selectedCode = 'Y';
023473200814           scode1 = TrCode9;
023474200814           trCode9 = ' ';
023475200814
023476200814          when trCode10 > ' ';
023477200814           selectedCode = 'Y';
023478200814           scode1 = TrCode10;
023479200814           trCode10 = ' ';
023480200814         endsl;
023481200814
023482200814       endsr;
023483200814
027101200812      //===================================================================
027102200812      // write file
027103200812      //===================================================================
027200200812
027201200812       begsr writeRP135;
027300161003
027301200812        clear workfile;
027302200812
027400161003        ssnooutx = ssnoout;
027500200812        acc#x = mbssno;
027501200812
027502200821        monitor;
027504200821         ptrdatx = %char(%date(trdate : *iso):*usa/);
027505200821        on-error;
027506200821         ptrdatx = ' ';
027507200821        endmon;
027508200812
027600200812        //ptrdatx = covtdt;
027700161003        tramtx = tramt;
027800161003        cm$flgx = cm$flg;
027900161003        ck#notoutx = ck#notout;
027901200812
027905200812        if trdate > 0;
027906200825         monitor;
027907200821         prcvdtx = %char(%date(covtdt : *iso):*usa/);
027908200825         on-error;
027909200825          prcvdtx = ' ';
027910200825         endmon;
027911200812        endif;
027912200812
028000200812        //prcvdtx = trdate;
028100200821        pcovdtx = covtdt;
028200200812        trust#x = hstrst;
028400210224        sub#x = hssub#;
028500200812        accnonx = hsacct;
028600161003        hoperx = hoper;
028601210224
028602200812        plan = planx;
028603210224        if plan > ' ';
028604210226         //chain (hstrst : hssub# : ck#pln) planFile;
028605210226         chain (hstrst : hssub# : plan) planFile;
028606210224         if %found;
028607210224          chain (pcarr) carrFile;
028608210224           if %found;
028609210224            ccdesc = cname;
028610210224           endif;
028611210224         endif;
028612210224        endif;
028613210224
028614210226        plan = planx;
028615210303        if plan = ' ' and (trcode = 'GRC' or trcode = 'GRA'
028616210303                        or trcode = 'GRM');
028617210226         plan = %subst(ck#not:17:4);
028618210226         chain (hstrst : hssub# : plan) planFile;
028619210226         if %found;
028620210226          chain (pcarr) carrFile;
028621210226           if %found;
028622210226            ccdesc = cname;
028623210226           endif;
028624210226         endif;
028625210226        endif;
028626210226
028700161003        acaflgx = acaflg;
028800161003        note2outx = note2out;
028900210224        tamtx = tramt;
028901200812
028902200812        trcodes = trcode;
028903200812        chain (%subst(trcode:1:1) : %subst(trcode:2:2)) codesFile;
028904200812        if %found;
028905200812         trcodesc = ldescr;
028906200812         //trcodesc = %trim(trcode) + '-' + %trim(ldescr);
028907200812        endif;
029000161003
029001200814        if scode1 > ' ';
029002200814         rec# = rrn1;
029003200814        else;
029004200814         rec# = rrn2;
029005200814        endif;
029006200814
029007200814        if strust <> 'ALL' and ssub# <> 'ALL' and sacct <> 'ALL';
029008200814         exsr checkTSA;
029009200814         if writeTSA = 'Y';
029010200814          write workfile;
029011200814          leavesr;
029012200814         endif;
029013200814        endif;
029200200812
029201200814        if strust = 'ALL' and ssub# = 'ALL' and sacct = 'ALL';
029204200814         write workfile;
029205200814         leavesr;
029207200814        endif;
029208200814
029209200821        if strust = %editc(hstrst:'X') and ssub# = 'ALL' and sacct = 'ALL';
029210200821         write workfile;
029211200821         leavesr;
029212200821        endif;
029213200821
029214200821        if strust = %editc(hstrst:'X') and ssub# = %editc(hssub#:'X')
029215200821         and sacct = 'ALL';
029216200821         write workfile;
029217200821         leavesr;
029218200821        endif;
029219200821
029220200819        if selssnd > 0;
029221200814         exsr checkSSN;
029222200814         if writeSSN = 'Y';
029223200814          write workfile;
029224200814          leavesr;
029225200814         endif;
029226200814        endif;
029227200814
029228200814        //if selssn = 0;
029229200814        // write workfile;
029230200814        // leavesr;
029231200814        //endif;
029232200814
029300161003       endsr;
029301200812
029302200814      //===================================================================
029303200814      // check Trust/Sub/Acct
029304200814      //===================================================================
029305200814
029306200814       begsr checkTSA;
029307200814
029308200814        writeTSA = 'N';
029309200814
029310200814        if hstrst = trstk and hssub# = sub#k and hsacct = acctk;
029311200814         writeTSA = 'Y';
029312200814        endif;
029313200814
029314200814       endsr;
029315200814
029316200814      //===================================================================
029317200814      // check SSN
029318200814      //===================================================================
029319200814
029320200814       begsr checkSSN;
029321200814
029322200814        writeSSN = 'N';
029323200814
029324200819        if selssnd = (%dec(%subst(hkey:2:9):9:0));
029325200814         writeSSN = 'Y';
029326200814        endif;
029327200814
029328200814       endsr;
029329200814
029330200814      //===================================================================
029331200814      // check user ID
029332200814      //===================================================================
029333200814
029334200814       begsr check_userID;
029335200814
029336200814        setll 1 workFile;
029337200814        read workFile;
029338200814
029339200814        dow not %eof;
029340200814
029341200814         if userID <> hoperx;
029342200814          delete workFile;
029343200814         endif;
029344200814
029345200814        read workFile;
029346200814        enddo;
029347200814
029348200814       endsr;
029349200814
029350200814      //===================================================================
029351200814      // check T/S/A
029352200814      //===================================================================
029353200814
029354200814       begsr checkTrust;
029355200814
029356200821        setll 1 workFile;
029357200821        read workFile;
029358200821
029359200821        dow not %eof;
029360200821
029361200821         if %dec(strust:3:0) <> trust#x and %dec(ssub#:3:0) <> sub#x;
029362200821          delete workFile;
029363200821         endif;
029364200821
029365200821        read workFile;
029366200821        enddo;
029367200821
029368200814        setll 1 workFile;
029369200814        read workFile;
029370200814
029371200814        dow not %eof;
029372200814
029373200814         if %dec(strust:3:0) <> trust#x;
029374200814          delete workFile;
029375200814         endif;
029376200814
029377200814        read workFile;
029378200814        enddo;
029379200814
029380200814       endsr;
029381200814
029382200814      //===================================================================
029383200814      // check include
029384200814      //===================================================================
029385200814
029386200814       begsr checkInclude;
029387200814
029388200814        if includes = 'COBRA';
029389200814         setll 1 workFile;
029390200814         read workFile;
029391200814
029392200814         dow not %eof;
029393200814
029394200814         if trcodes <> 'BMB' and trcodes <> 'BMP';
029395200814          delete workFile;
029396200814         endif;
029397200814
029398200814         read workFile;
029399200814         enddo;
029400200814        endif;
029401200814
029402200814        if includes = 'FINANCIAL';
029403200814         setll 1 workFile;
029404200814         read workFile;
029405200814
029406200814         dow not %eof;
029407200814
029408200814         if trcodes <> 'BMB' and trcodes <> 'BMP' and trcodes <> 'GIF' and
029409200814            trcodes <> 'BAC' and trcodes <> 'BCP' and trcodes <> 'GBI' and
029410200814            trcodes <> 'GBD' and trcodes <> 'GRA' and trcodes <> 'GRC';
029411200814          delete workFile;
029412200814         endif;
029413200814
029414200814         read workFile;
029415200814         enddo;
029416200814
029417200814         setll 1 workFile;
029418200814         read workFile;
029419200814
029420200814         dow not %eof;
029421200814
029422200814          ssnooutx = %editc(trust#x:'X') + '-' + %editc(sub#x:'X') + '-' +
029423200814                     %editc(accnonx:'X');
029424200814          update workFile;
029425200814
029426200814         read workFile;
029427200814         enddo;
029428200814
029429200814        endif;
029430200814
029431200814       endsr;
029432200814
029433210630      //===================================================================
029434210630      // check EBS
029435210630      //===================================================================
029436210630
029437210630       begsr check_ifEBS;
029438210630
029439210630        setll 1 workFile;
029440210630        read workFile;
029441210630
029442210630        dow not %eof;
029443210630
029444210630         clear yesno;
029445210630
029447210630          tsaC = %editc(trust#x:'X') + %editc(sub#x:'X') + %editc(accnonx:'X');
029448210630           checkEBS(tsaC : yesno);
029449210630
029450210630          if yesno = 'N' or yesno = ' ';
029451210630           delete workFile;
029452210630          endif;
029455210630
029456210630        read workFile;
029457210630        enddo;
029458210630
029471210630       endsr;
029472210630
029473200814      //===================================================================
029474200814      // criteria page
029475200814      //===================================================================
029476200814
029477200814       begsr criteriaPage;
029478200814
029479200821        rfield = 'Run Date - ' + %char(%date);
029480200814        write parmFile;
029481200821
029482200821        rfield = 'From Date -' +  ' '  + %char(fromDate);
029483200821        write parmFile;
029484200821
029485200814        rfield = 'To Date -' +  ' '  + %char(toDate);
029486200814        write parmFile;
029487200814
029488200814        rfield = 'Trust = ' + %trim(strust);
029489200814        write parmFile;
029490200814
029491200814        rfield = 'Sub# = ' + %trim(ssub#);
029492200814        write parmFile;
029493200814
029494200814        rfield = 'Acct = ' + %trim(sacct);
029495200814        write parmFile;
029496200814
029497200819        if selssnd > 0;
029498200819         rfield = 'SSN = ' + %editc(selssnd:'X');
029499200814        else;
029500200814         rfield = 'SSN = ';
029501200814        endif;
029502200814        write parmFile;
029503200814
029504200814        //select;
029505200814        // when orderby = 'ARRIVAL';
029506200814        // rfield = 'ORDER BY - ARRIVAL';
029507200814        //  write parmFile;
029508200814
029509200814        // when orderby = 'TCODE';
029510200814        //  rfield = 'ORDER BY - TRANSACTION CODE';
029511200814        //  write parmFile;
029512200814
029513200814        // when orderby = 'AUDIT';
029514200814        //  rfield = 'ORDER BY - AUDIT';
029515200814        //  write parmFile;
029516200814        //endsl;
029517200814
029518200814        select;
029519200814         when includes = 'ALL';
029520200814          rfield = 'INCLUDE - ALL';
029521200814          write parmFile;
029522200814
029523200814         when includes = 'FINACIAL';
029524200814          rfield = 'INCLUDE - FINANCIAL';
029525200814          write parmFile;
029526200814
029527200814         when includes = 'MEMBER';
029528200814          rfield = 'INCLUDE - MEMBER';
029529200814          write parmFile;
029530200814
029531200814         when includes = 'COBRA';
029532200814          rfield = 'INCLUDE - COBRA';
029533200814          write parmFile;
029534200814        endsl;
029535200814
029536200814        rfield = 'TRANSACTION CODES - ALL';
029537200814        if trcode1 > ' ' or trcode2 > ' ' or trcode3 > ' ' or
029538200814         trcode4 > ' ' or trcode5 > ' ' or trcode6 > ' ' or
029539200814          trcode7 > ' ' or trcode8 > ' ' or trcode9 > ' ' or
029540200814           trcode10 > ' ';
029541200814           rfield = 'TRANSACTION CODES - ' + %trim(trcode1) + ', ' +
029542200814                     %trim(trcode2) + ', ' + %trim(trcode3) + ', ' +
029543200814                     %trim(trcode4) + ', ' + %trim(trcode5) + ', ' +
029544200814                     %trim(trcode6) + ', ' + %trim(trcode7) + ', ' +
029545200814                     %trim(trcode8) + ', ' + %trim(trcode9) + ', ' +
029546200814                     %trim(trcode10);
029547200814         write parmFile;
029548200814        endif;
029549200814
029550200814        rfield = 'USER ID - ' + %trim(userID);
029551200814        write parmFile;
029552200814
029553200814        rfield = 'PRINT SSN or Last Name? - ' + %trim(ssnorlast);
029554200814        write parmFile;
029555200814
029556200814        rfield = 'Mask SSN? - ' + %trim(maskssn);
029557200814        write parmFile;
029558200814
029559210630        rfield = 'EBS Only? - ' + %trim(sebs);
029560210630        write parmFile;
029561210630
029562200814       endsr;
029563200814
029564200812      //===================================================================
029565200812      // exit
029566200812      //===================================================================
029567200812
029568200812       begsr exit;
029569200812
029570200812        *inlr = '1';
029571200812        return;
029572200812
029573200812       endsr;
029574200812
029575200812      //===================================================================
029576200812      // init
029577200812      //===================================================================
029578200812
029579200812       begsr init;
029580200812
029581210624        if strust = 'all';
029582210624         strust = 'ALL';
029583210624        endif;
029584210624
029585210624        if ssub# = 'all';
029586210624         ssub# = 'ALL';
029587210624        endif;
029588210624
029589210624        if sacct = 'all';
029590210624         sacct = 'ALL';
029591210624        endif;
029592210624
029593210624        fromDt = %dec(fromDate);
029594200814        toDt = %dec(toDate);
029595200819
029596200819        if selssn > ' ';
029597200819         selssnd = %dec(selssn:9:0);
029598200819        endif;
029599200814
029600200814        //if s1ActNbr > ' ' and s1ActNbr <> 'ALL';
029601200814        // split();
029602200814        if strust <> 'ALL';
029603200814         trstk = %dec(strust:3:0);
029604200814        endif;
029605200814
029606200814        if ssub# <> 'ALL';
029607200814         sub#k = %dec(ssub#:3:0);
029608200814        endif;
029609200814
029610200814        if sacct <> 'ALL';
029611200814         acctk = %dec(sacct:4:0);
029612200814        endif;
029613200814
029614200814        exsr criteriaPage;
029615200814
029616200814       endsr;
029617200812
029618200814      //===================================================================
