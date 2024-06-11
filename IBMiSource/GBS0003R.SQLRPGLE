000100150319     H option(*noDebugIo)
000200150226      *-------------------------------------------------------------------------
000300150226      *
000400150313      *  Description:  Kaiser Permanente EDT
000500150226      *  Programmer.:  Brian Rees
000600150313      *  Date.......:   3/13/2015
000700150226      *
000800150313      *  (c)Copyright 2015 by GBS, Inc.
000900150226      *
001000150313      *   Calculation to convert yyyymmdd to mmddyyyy
001100150313      *   xxx = %Char( %dec(%char(%date(@numC:*iso):*usa0):8:0));
001200150603      *-------------------------------------------------------------------------
001300150603      * Modifications
001400150603      *
001500150603      * Date         Programmer    Mod      Description
001600150603      *-------------------------------------------------------------------------
001700150603      * 06/03/2015   B.Rees        br01
001800150603      *    Kaiser, requested that we create a unique Member ID and
001900150603      *    Subscriber ID.  The NEXT Unique Value will be stored in
002000150603      *    a dataarea.
002100150603      *    New Data Area:  KaiserSEQ
002200150806      * 08/06/2015   B.Rees        br02
002300150806      *    Need to write to DEPALT for the Dependents ALT ID
002400160114      * 01/14/2016   B.Rees
002500160114      *    Fixed Issue where there were more than 1 of the same plans.
002600160114      *    1 cancelled and 1 current
002700150226      *-------------------------------------------------------------------------
002800150714     FMemAC#1   if   e           k disk    ExtDesc('F.MEMAC#1')
002900150302     F                                     ExtFile(*extdesc)
003000150302     FMemCovage if   e           k disk    ExtDesc('F.MCOVC16')
003100150302     F                                     ExtFile(*extdesc)
003200150309     FSmoke     if   e           k disk
003300150714     FDependent if   e           k disk    ExtDesc('F.DEPNDC') ExtFile(*extdesc)
003400150714     FDCOVB     if   e           k disk    ExtDesc('F.DCOVB')  ExtFile(*extdesc)
003500150312     FCarPlnx   if   e           k disk
003600150312     FCarAccx   if   e           k disk
003700150714     FPCPL1     if   e           k disk    ExtDesc('F.PCPL1')  ExtFile(*extdesc)
003800150714     FGrat24    if   e           k disk    ExtDesc('F.GRAT24') ExtFile(*extdesc)
003900150312     FPcpMstp   if   e           k disk
004000150603     FMemAlt    uf a e           k disk
004100150806br02 FDepAlt    uf a e           k disk
004200150317
004300150317     Fkaiedtd   uf a e           k disk                                         ?Detail Record
004400150317     Fkaiedtf   uf a e           k disk                                         ?Footer Record
004500150317     Fkaiedth   uf a e           k disk                                         ?Header Record
004600150302
004700150226      *-------------------------------------------------------------------------
004800150226
004900150302     D @Data           ds
005000150302     D  sqCarCode                     3
005100150302     D  sqCarName                    40
005200150302     D  sqTrust                       3  0
005300150302     D  sqSub#                        3  0
005400150302     D  sqPlan                        4
005500150302     D  sqAccount                     4  0
005600150302     D  sqPDesc                      40
005700150309     D  sqPlnCat                      3
005800150309     D  sqSDESCR                     10
005900150312     D  sqAction                      1
006000150302
006100150302     d DepNumber       s              2s 0
006200150313     d SpecCode        s                   Like(pcSpcd)
006300150317     d RcdCount        s              5s 0
006400150325     d HldDate         s              8
006500150603     d MemberID        s              9s 0
006600150603     D KaiserSeq       s              8p 0 dtaara
006700150714     D Pos             s              3s 0 inz
006800160114     D
006900160114     D WriteRcd        s              1a   inz
007000160114     D SavCandt        s                   like(Candt)
007100150226      *-------------------------------------------------------------------------
007200150302
007300150714    ? *-------------------------------------------------------------------------
007400150714      *?Mainline Program
007500150714    ? *-------------------------------------------------------------------------
007600150714     C     *entry        plist
007700150714     C                   parm                    SendReport        1
007800150714
007900150714
008000150714
008100150311         //?Run the SQL Commamnd and get all plans assigned to Aetna
008200150302         exsr $OpenC1;
008300150302         Dou SqlCod <> *Zero;
008400150302
008500150414            Exec Sql  Fetch Next From C1 Into :@data  ;
008600150302
008700150302            if SqlCod <> *Zero;
008800150302               leave;
008900150302            endif;
009000150319
009100150311            //?Get the Members of the Account
009200150302            Setll (sqTrust : sqSub# : sqAccount)  MemAC#1;
009300150302            dou %eof(MemAC#1);
009400150302               Reade (sqTrust : sqSub# : sqAccount)  MemAC#1;
009500150302
009600150302               if %eof(MemAC#1);
009700150302                  leave;
009800150302               EndIf;
009900150302
010000150714               //?Skip Any Member that has an 888-xx-xxxx SSN.
010100150714               if %Subst( %Char(mbssno) : 1 :3) = '888';
010200150714                  iter;
010300150714               endif;
010400150714
010500150714
010600160114br03           //?Check Member Coverage
010700160114               WriteRcd = '';
010800160114               SavCandt = *Zeros;
010900160114
011000160114               Setll (sqTrust : sqSub# : sqAccount : mbssno : sqPlan) MemCovage;
011100160114               dou %eof(MemCovage);
011200160114                  reade (sqTrust : sqSub# : sqAccount :
011300160114                         mbssno : sqPlan) MemCovage;
011400160114
011500160114                  if %Eof(MemCovage);
011600160114                     leave;
011700160114                  endif;
011800160114
011900160114
012000160114                  if %Found(MemCovage);
012100160114                     if Candt = *Zeros      or
012200160114                        Candt < SavCandt    or         // Newer Canc Date than Prev Rcd
012300160114                        WriteRcd = '';                 // First time Rcd
012400160114
012500160114                        exsr MemberData;
012600160114                        SavCandt = Candt;
012700160114                        WriteRcd = 'Y';
012800160114                     endif;
012900160114                  endif;
013000160114               enddo;
013100160114
013200160114
013300160114               if WriteRcd = 'Y';
013400150317                  RcdCount = RcdCount + 1;
013500150317                  write kaiedtd_r;
013600150309
013700150311                  //?Check for Dependents
013800150309                  exsr DependData;
013900150302
014000150302               EndIf;
014100150302
014200150302            EndDo;
014300150302
014400150302         enddo;
014500150302
014600150302         Exec Sql  Close C1;
014700150302
014800150317         // Write Header and Footer
014900150317         exsr WriteHeader;
015000150317
015100150714
015200150714         SendReport = 'N';
015300150714         if RcdCount > 0;
015400150714            SendReport = 'Y';
015500150714         endif;
015600150317
015700150302         *inlr = *on;
015800150302      // ----------------------------------------------------------------
015900150302       begsr MemberData;
016000150302
016100150313          kdRecId = 'M';
016200150313          kdLName = mLName;
016300150313          kdFName = mFName;
016400150313          kdMName = mmi;
016500150313          kdMbrSSN = %editC(mbssno : 'X');
016600150603
016700150603
016800150603          //?Get Alternate ID
016900150603          MemberID = mbssno;
017000150603          exsr GetAltID;
017100150603
017200150603          kdMbrID = %trim(maAltId);
017300150603          kdSubID = %trim(maAltId);
017400150313
017500150313
017600160810          setll (sqTrust : sqSub# : sqPlan) Grat24;
017700160810          dou %eof(Grat24);
017800160810
017900160810             reade (sqTrust : sqSub# : sqPlan) Grat24;
018000160810             if %eof(Grat24);
018100160810                leave;
018200160810             endif;
018300160810
018400160810             if todat > %Dec(%Date);
018500160810                pos = %Scan('-' : Group#);
018600160810                kdGrpId = %Subst(Group# : 1 : Pos - 1);
018700160810                kdSubGrpId = %Subst(Group# : Pos + 1);
018800160810                leave;
018900160810             endif;
019000160810          enddo;
019100160810
019200160810
019300150313          kdRegCde = 'TMS';
019400150313          kdRshpCde = 'SUB';
019500150416          kdEnrCde = *Blanks;
019600150313
019700150313          kdhphne = %Char(area) + %Char(phone);
019800150313          kdrdadr1 = Addr1;
019900150313          kdrdadr2 = Addr2;
020000150313          kdrdCity = City;
020100150313          kdrdState = State;
020200150313          kdrdZip  = %Subst( %Char(Zip) : 1 : 5);
020300150313          kdrdZip4 = %Subst( %Char(Zip) : 6 );
020400150313
020500150325
020600150325          hldDate = %Char(Birth);
020700150325          kddob = %Subst(HldDate:5:2) +
020800150325                  %Subst(HldDate:7:2) +
020900150325                  %Subst(HldDate:1:4);
021000150325
021100150313          kdSex = Sex;
021200150313
021300150313          //?Check Married Status
021400150313          kdMarried = 'MARRIED';
021500150313          if mardt = 0;
021600150416             kdMarried = 'NOT MARRIED';
021700150313          endif;
021800150313
021900150313          //?Smoker Calc
022000150313          DepNumber = 0;
022100150313          exsr CheckSmoker;
022200150313
022300150313
022400150313          //?Get Primary Care Physician
022500150313          DepNumber = 0;
022600150313          exsr Get_PCP;
022700150313
022800150313
022900150313          //?Enrollment Dates
023000150428          kdBenfStr = *Blanks;
023100150428          if EnrlDt > 0;
023200150325          hldDate = %Char(EnrlDt);
023300150325          kdBenfStr = %Subst(HldDate:5:2) +
023400150325                      %Subst(HldDate:7:2) +
023500150325                      %Subst(HldDate:1:4);
023600150428          endif;
023700150428
023800150428
023900150428          kdBenfEnd = *Blanks;
024000150313          if Candt > 0;
024100150325             hldDate = %Char(CanDt);
024200150325             kdBenfEnd = %Subst(HldDate:5:2) +
024300150325                         %Subst(HldDate:7:2) +
024400150325                         %Subst(HldDate:1:4);
024500150313          endif;
024600150313
024700150313
024800150313          //?Employee ID
024900150421          kdEmpId = %editc(mbssno  : 'X') ;
025000150311
025100150325          hldDate = %Char(EmpDt);
025200150325          kdHireDt = %Subst(HldDate:5:2) +
025300150325                     %Subst(HldDate:7:2) +
025400150325                     %Subst(HldDate:1:4);
025500150313
025600150317          kdExchtp = 'SHOP';
025700150317          kdDepSsn = *Blanks;
025800150302
025900150302       endsr;
026000150312      // ----------------------------------------------------------------
026100150312       begsr Get_PCP;
026200150312
026300150313          SpecCode = 'MED';
026400150319          kdPcpNpi = *Blanks;
026500150319          kdPcpDate = *Blanks;
026600150313
026700150313          setll (mbssno :  DepNumber : SpecCode) PCPL1;
026800150313          dou %Eof(PCPL1);
026900150313             reade (mbssno :  DepNumber : SpecCode) PCPL1;
027000150313             if %eof(PCPL1);
027100150313                leave;
027200150313             EndIf;
027300150313
027400150313             if pcCan > *zero;
027500150313                iter;
027600150313             EndIf;
027700150313
027800150313             kdPcpNpi = pcId#;
027900150325             hldDate = %Char(pcEff);
028000150325             kdPcpDate = %Subst(HldDate:5:2) +
028100150325                         %Subst(HldDate:7:2) +
028200150325                         %Subst(HldDate:1:4);
028300150313
028400150313          EndDo;
028500150312
028600150312       Endsr;
028700150302      // ----------------------------------------------------------------
028800150302       begsr CheckSmoker;
028900150302
029000150313          kdSmoke = 'N';
029100150302
029200150309          chain ( mbssno : DepNumber )  Smoke;
029300150309          if not %Found(Smoke);
029400150309             leaveSr;
029500150302          EndIf;
029600150302
029700150309          Setll ( mbssno : DepNumber )  Smoke;
029800150309          dou %Eof(Smoke);
029900150309             Reade ( mbssno : DepNumber )  Smoke;
030000150302             if skRateTo = 0 and skRateFr <= %Dec(%Date);
030100150313                kdSmoke = 'Y';
030200150302                leavesr;
030300150302             EndIf;
030400150302
030500150302             if skRateFr <= %Dec(%Date) and skRateTo >= %Dec(%Date);
030600150313                kdSmoke = 'Y';
030700150302                leavesr;
030800150302             EndIf;
030900150302
031000150302          EndDo;
031100150302
031200150302       EndSr;
031300150309
031400150309      // ----------------------------------------------------------------
031500150309       begsr DependData;
031600150309
031700150309          setll mbssno Dependent;
031800150309          dou %eof(Dependent);
031900150309             reade mbssno Dependent;
032000150309
032100150309             if %eof(Dependent);
032200150309                leave;
032300150309             EndIf;
032400150309
032500150317             chain (mbssno : dpSeq# : sqTrust : sqSub# :sqPlan ) dcovb;
032600150317
032700150313             kdlname = dLName;
032800150313             kdfname = dFName;
032900150313             kdmname = dmi;
033000150313
033100150317             kdDepSSN = %editc(depss#  : 'X');
033200150603
033300150603             //?Get Alternate ID
033400150603             MemberID = depss#;
033500150806             exsr GetDepAltID;
033600150806             kdMbrID = %trim(daAltId);
033700150603
033800150313
033900150313             //?Dependents
034000150309             Select;
034100150309                When dRelCd = 'RHU';
034200150313                   kdRshpCde = 'SP';
034300150309                When dRelCd = 'RWI';
034400150313                   kdRshpCde = 'SP';
034500150313                When dRelCd = 'RPA';
034600150313                   kdRshpCde = 'SP';
034700150313                Other;
034800150313                   kdRshpCde = 'DEP';
034900150309             EndSl;
035000150309
035100150319             // Per Email from Dan McDonald@ Kp.org  6/15/2015 9:54
035200150319             // Populate the Replationship Code with the value "WRD"
035300150319             // if the dependent is Disabled. (Handicapped??)
035400150319
035500150319             if dhndcp = 'Y';
035600150319                kdRshpCde = 'WRD';
035700150319             EndIf;
035800150319
035900150319
036000150313             kdrdadr1 = dAddr1;
036100150313             kdrdadr2 = dAddr2;
036200150313             kdrdCity = dCity;
036300150313             kdrdState = dState;
036400150313             kdrdZip  = %Subst( %Char(dZip) : 1 : 5);
036500150313
036600150325             hldDate = %Char(dBirth);
036700150325             kddob = %Subst(HldDate:5:2) +
036800150325                     %Subst(HldDate:7:2) +
036900150325                     %Subst(HldDate:1:4);
037000150313             kdSex = dSex;
037100150309
037200150313             kdMarried = *Blanks;
037300150309
037400150313             //?Smoker Calc
037500150313             DepNumber = dpSeq#;
037600150313             exsr CheckSmoker;
037700150309
037800150309
037900150313             //?Get Primary Care Physician
038000150312             DepNumber = dpSeq#;
038100150312             exsr Get_PCP;
038200150312
038300150428
038400150428             //?Enrollment Dates
038500150428             kdBenfStr = *Blanks;
038600150428             if DenrDt > 0;
038700150428             hldDate = %Char(DenrDt);
038800150428             kdBenfStr = %Subst(HldDate:5:2) +
038900150428                         %Subst(HldDate:7:2) +
039000150428                         %Subst(HldDate:1:4);
039100150428             endif;
039200150428
039300150428
039400150428             kdBenfEnd = *Blanks;
039500150428             if CCandt > 0;
039600150428                hldDate = %Char(CCanDt);
039700150428                kdBenfEnd = %Subst(HldDate:5:2) +
039800150428                            %Subst(HldDate:7:2) +
039900150428                            %Subst(HldDate:1:4);
040000150428             endif;
040100150428
040200150427
040300150317             RcdCount = RcdCount + 1;
040400150317             write kaiedtd_r;
040500150309
040600150309          EndDo;
040700150309
040800150309
040900150309       Endsr;
041000150311
041100150317
041200150317      // ----------------------------------------------------------------
041300150317       begsr WriteHeader;
041400150317
041500150317          // Header
041600150317          khRecId = 'H';
041700150414          khExchTp = 'SHOP';
041800150317          khGrpName = 'Group Benefit Services';
041900150317          khFileDate = %char( %date : *usa0);
042000150317          khFileTyp = 'F';
042100150317          khRcdCnt = %Char(RcdCount);
042200150317          Write kaiEdth_r;
042300150317
042400150317
042500150317          // Footer
042600150317          kfRecId = 'F';
042700150414          kfExchTp = 'SHOP';
042800150317          kfGrpName = 'Group Benefit Services';
042900150317          kfFileDate = %Char(%Date : *usa0);
043000150317          kfFileTyp = 'F';
043100150317          kfRcdCnt = %Char(RcdCount);
043200150317          Write kaiEdtf_r;
043300150317
043400150317       Endsr;
043500150603      // ----------------------------------------------------------------
043600150603       begsr GetAltID;
043700150603
043800150603
043900150603          chain (MemberID : 'KAI') Memalt;
044000150603          if not %Found(Memalt);
044100150603
044200150603             in *lock KaiserSeq;
044300150603             KaiserSeq = KaiserSeq + 1;
044400150603             Out KaiserSeq;
044500150603
044600150603
044700150603             //?Add Record to the MemAlt File.
044800150603             maMemId = MemberID;
044900150603             maAltTp = 'KAI';
045000150603             maAltID = 'G' + %editc(KaiserSeq : 'X');
045100150603             maLName = kdLName;
045200150603             maFName = kdFName;
045300150603             maCrtDt = %Dec(%Date);
045400150603             write MemAltr;
045500150603          Endif;
045600150603
045700150603       Endsr;
045800150806      // ----------------------------------------------------------------
045900150806       begsr GetDepAltID;
046000150806
046100150806          chain (mbssno : dpSeq#: 'KAI') DepAlt;
046200150806          if not %Found(DepAlt);
046300150806
046400150806             in *lock KaiserSeq;
046500150806             KaiserSeq = KaiserSeq + 1;
046600150806             Out KaiserSeq;
046700150806
046800150806
046900150806             //?Add Record to the MemAlt File.
047000150806             daMemId = mbssno;
047100150806             daDepSq = dpSeq#;
047200150806             daAltTp = 'KAI';
047300150806             daAltID = 'G' + %editc(KaiserSeq : 'X');
047400150806             daLName = kdLName;
047500150806             daFName = kdFName;
047600150806             daCrtDt = %Dec(%Date);
047700150806             write DepAltr;
047800150806          Endif;
047900150806
048000150806       Endsr;
048100150309      // ----------------------------------------------------------------
048200150309
048300150302       begsr $OpenC1;
048400150302
048500150311          //----------------------------------------------------------------
048600150311          //?Get all of the plans the belong to Aetna
048700150311          //----------------------------------------------------------------
048800150414          Exec Sql
048900150414             Declare C1 Cursor For
049000150414
049100150414             Select Distinct
049200150414               Carrcd, Cname,
049300150414               Pltrst, Plsub#, Plplan, Cmacct,
049400150414               Pdescr, Plncat, Sdescr, "ACTION"
049500150414
049600150414             From Carunique
049700150414             Join Hypercarr  On Hccode = Cgrpcd
049800150414             Join Carmst2p   On C2carcd = Carrcd
049900150414             Join "F.PLNMST" On Pcarr = Carrcd
050000150414             Join Plnauxp    On Pltrst = Pxtrst And Plsub# = Pxsub#
050100150414                            And Plplan = Pxplan
050200150414             Join Cmctplan   On Pltrst = Cmtrst And Plsub# = Csubdv
050300150414                            And Plplan = Cmplan
050400150414             Join "F.CODES"   On Type = Substring(Plncat, 1, 1) And
050500150414                                 Code = Substring(Plncat, 2, 2)
050600150414
050700150714             Where Hccode in ('SK') and Cadltd = 'A'
050800150414               And C2acart = 'Y' And Pxacar = 'Y'
050900150414               And Pxexchg = 'Y'
051000150505                And Pxgroup <> 'PENDING'
051100150714                And PlTrst <> '888'
051200150611             -- and pxPlan in ('AAAE', 'AAAG', 'AAAB')
051300150414
051400150414             Order By Pltrst, Plsub#, Cmacct;
051500150317
051600150317          Exec Sql    Open C1;
051700150317
051800150302
051900150302       endsr;
