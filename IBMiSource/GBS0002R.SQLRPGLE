000100150226     H option(*noDebugIo)
000200150226      *-------------------------------------------------------------------------
000300150226      *
000400150226      *  Description:  Aetna SHOP 834 Export
000500150226      *  Programmer.:  Brian Rees
000600150226      *  Date.......:   2/25/2015
000700150226      *
000800150226      *  (c)Copyright 2014 by GBS, Inc.
000900150226      *
001000150226      *  ** Copied from EVRGRENRPG
001100150311      *
001200150311      *  Master Sort Sequence: a8GrpSeq
001300150311      *   Pos  1 - 10   Trs / Sub / Acct
001400150311      *   Pos 11 - 21   SSN / Dep Seq
001500150311      *   Pos 22 - 24   PDT  ????
001600150311      *   Pos 25        A/B/C  ????
001700150311      *
001800150226      *-------------------------------------------------------------------------
001900150807      * Modifications
002000150807      *
002100150807      * Date         Programmer    Mod      Description
002200150807      *-------------------------------------------------------------------------
002300150807      * 08/07/2015   B.Rees        br01
002400150807      *   Added a Plan Cross reference file to contain the HD04 Values
002500150807      *-------------------------------------------------------------------------
002600150302     FMemAC#1   if   e           k disk    ExtDesc('F.MEMAC#1')
002700150302     F                                     ExtFile(*extdesc)
002800150302     FMemCovage if   e           k disk    ExtDesc('F.MCOVC16')
002900150302     F                                     ExtFile(*extdesc)
003000150309     FSmoke     if   e           k disk
003100150309     FDependent if   e           k disk    ExtDesc('F.DEPNDC')
003200150309     F                                     ExtFile(*extdesc)
003300150313     FPCPL1     if   e           k disk    ExtDesc('F.PCPL1')
003400150312     F                                     ExtFile(*extdesc)
003500150810     FAccMst    if   e           k disk    ExtDesc('F.ACCMST')
003600150810     F                                     ExtFile(*extdesc)
003700150312     FPcpMstp   if   e           k disk
003800150325     FAc2MstL2  if   e           k disk
003900150807br01 FCarPlnp   if   e           k disk
004000150807
004100150807     Fae8010wf  uf a e           k disk
004200150226      *-------------------------------------------------------------------------
004300150226
004400150302     D @Data           ds
004500150302     D  sqCarCode                     3
004600150302     D  sqCarName                    40
004700150302     D  sqTrust                       3  0
004800150302     D  sqSub#                        3  0
004900150302     D  sqPlan                        4
005000150302     D  sqAccount                     4  0
005100150302     D  sqPDesc                      40
005200150309     D  sqPlnCat                      3
005300150309     D  sqSDESCR                     10
005400150312     D  sqAction                      1
005500150302
005600150302     d DepNumber       s              2s 0
005700150309     d myAge           s              5s 0
005800150313     d SpecCode        s                   Like(pcSpcd)
005900150302
006000150807br01 D Carr#Ctl        S             10A   INZ('XXXXXXX118')
006100150226      *-------------------------------------------------------------------------
006200150302
006300150311         //?Run the SQL Commamnd and get all plans assigned to Aetna
006400150302         exsr $OpenC1;
006500150302         Dou SqlCod <> *Zero;
006600150302
006700150302            Exec Sql  Fetch Next From C1 Into :@data  ;
006800150302
006900150302            if SqlCod <> *Zero;
007000150302               leave;
007100150302            endif;
007200150302
007300150810            //?Get the Account Name
007400150810            chain (sqTrust : sqSub# : sqAccount)  AccMst;
007500150810            a8GrpName = AcNam1;
007600150810
007700150810
007800150311            //?Get the Members of the Account
007900150302            Setll (sqTrust : sqSub# : sqAccount)  MemAC#1;
008000150302            dou %eof(MemAC#1);
008100150302               Reade (sqTrust : sqSub# : sqAccount)  MemAC#1;
008200150302
008300150302               if %eof(MemAC#1);
008400150302                  leave;
008500150302               EndIf;
008600150302
008700150311               //?Check Member Coverage
008800150302               chain (sqTrust : sqSub# : sqAccount : mbssno : sqPlan) MemCovage;
008900150302               if %Found(MemCovage);
009000150302                  exsr MemberData;
009100150309                  write AE801F;
009200150309
009300150311                  //?Check for Dependents
009400150309                  exsr DependData;
009500150302
009600150302               EndIf;
009700150302
009800150302            EndDo;
009900150302
010000150302         enddo;
010100150302
010200150302         Exec Sql  Close C1;
010300150302
010400150302
010500150302         *inlr = *on;
010600150302      // ----------------------------------------------------------------
010700150302       begsr MemberData;
010800150302
010900150311          // Master Sort
011000150311          a8GrpSeq = %editc(sqTrust : 'X') +
011100150311                     %editc(sqSub#  : 'X') +
011200150311                     %editc(sqAccount : 'X') +
011300150311                     %editc(mbssno  : 'X') ;
011400150311
011500150302          a8GrpNbr = '0839889';
011600150302          a8MbrDep = 'Y';
011700150302          a8RelCode = '18';
011800150302
011900150812          //?Plan Type
012000150812        //  Select;
012100150812        //     When sqAction = 'V';
012200150812        //        a8PlnTyp = 'VIS';
012300150812        //     When sqAction = 'D';
012400150812        //        a8PlnTyp = 'DEN';
012500150812        //     When sqAction = 'M';
012600150812        //        a8PlnTyp = 'MM';
012700150812        //  EndSl;
012800150312
012900150312
013000150807          //?Plan Code
013100150807          chain (Carr#Ctl:sqTrust:sqSub#:sqAccount: ' ':sqPlan) CarPlnp;
013200150325          chain (sqTrust : sqSub# : sqAccount ) Ac2MstL2;
013300150807
013400150812          a8PlnTyp = %Trim(cptxt1);
013500150812          a8PlnCod = %Trim(cptxt2);
013600150812          a8CovLvl = %Trim(cptxt3);
013700150812
013800150325          a8TaxID = %Char(a2Tax_ID#);
013900150325
014000150312
014100150312          // Get Primary Care Physician
014200150312          DepNumber = 0;
014300150312          exsr Get_PCP;
014400150312
014500150312
014600150312          // Coverage Level
014700150312          Select;
014800150312             when mCovtp = 'TPC';
014900150312                a8CovLvl = 'E1D';
015000150312
015100150312             when mCovtp = 'TP2';
015200150312                a8CovLvl = 'ECH';
015300150312
015400150312             when mCovtp = 'TIN';
015500150312                a8CovLvl = 'IND';
015600150312
015700150312             when mCovtp = 'THW';
015800150312                a8CovLvl = 'ESP';
015900150312
016000150312             when mCovtp = 'TFA';
016100150312                a8CovLvl = 'FAM';
016200150312          EndSl;
016300150312
016400150312
016500150302          a8EmpSts = 'A';
016600150302          if EmpSt = 'C' ;
016700150302             a8EmpSts = 'C';
016800150302          endif;
016900150302
017000150302
017100150311          //?Medicaid
017200150302          a8MedInd = 'E';
017300150302          if Medicr = 'Y';
017400150302             if MedAdt > 0 and MedBdt = 0;
017500150302                a8MedInd = 'A';
017600150302             EndIf;
017700150302             if MedAdt = 0 and MedBdt > 0;
017800150302                a8MedInd = 'B';
017900150302             EndIf;
018000150302             if MedAdt > 0 and MedBdt > 0;
018100150302                a8MedInd = 'A';
018200150302             EndIf;
018300150302
018400150302             a8Medirsn = '0';
018500150302             if hndicp = 'Y';
018600150302                a8Medirsn = '1';
018700150302             EndIf;
018800150302          EndIf;
018900150302
019000150302
019100150311          //?Employement Status Code
019200150302          if Empst = 'A';
019300150302             a8Acreter = 'AC';
019400150302          endif;
019500150302
019600150302          if Empst = 'A' and termdt > 0;
019700150302             a8Acreter = 'TE';
019800150302          endif;
019900150302          if Empst = 'R';
020000150302             a8Acreter = 'RT';
020100150302          endif;
020200150302          if Empst = 'C';
020300150302             a8Acreter = 'TE';
020400150302          endif;
020500150302
020600150302          a8Stud =  *Blanks;
020700150302
020800150311          //?HandiCap
020900150302          a8Hndcp = hndicp;
021000150309          a8ssnmbr = %editC(mbssno : 'X');
021100150302          a8ssndep = *Blanks;
021200150302
021300150302          a8hire = %Char(empdt);
021400150302          a8term = %Char(TermDt);
021500150302          a8qedt = %Char(qedt);
021600150302          a8cbgndt = %char(Gbscdt);
021700150302
021800150302          a8CtrmDt = %Char(Candt);
021900150302          a8enrl = %char(mbenrl) ;
022000150302
022100150302          a8covend = %Char(Candt);
022200150302
022300150309          a8lnam = mLName;
022400150309          a8fnam = mFName;
022500150302          a8mnam = mmi;
022600150302          a8phone = %Char(area) + %Char(phone);
022700150302          a8addr1 = Addr1;
022800150302          a8addr2 = Addr2;
022900150302          a8city = City;
023000150302          a8state = State;
023100150309          a8zip = %Char(Zip);
023200150302          a8dob = %Char(Birth);
023300150302          a8gendr = Sex;
023400150302
023500150302          a8salry = %editc(Salary: 'X');
023600150309          a8wrkzip = %Char(Zip);
023700150302
023800150311          //?Smoker Calc
023900150302          DepNumber = 0;
024000150302          exsr CheckSmoker;
024100150302
024200150302          a8HnDate = *Blanks;
024300150302
024400150311          //?Dependent Address
024500150302          a8daddr1 = *Blanks;
024600150302          a8daddr2 = *Blanks;
024700150302          a8dcity = *Blanks;
024800150302          a8dstate = *Blanks;
024900150302          a8dzip = *Blanks;
025000150302
025100150302
025200150302       endsr;
025300150312      // ----------------------------------------------------------------
025400150312       begsr Get_PCP;
025500150313
025600150313          SpecCode = 'MED';
025700150313
025800150313          setll (mbssno :  DepNumber : SpecCode) PCPL1;
025900150313          dou %Eof(PCPL1);
026000150313             reade (mbssno :  DepNumber : SpecCode) PCPL1;
026100150313             if %eof(PCPL1);
026200150312                leave;
026300150312             EndIf;
026400150312
026500150313             if pcCan > *zero;
026600150312                iter;
026700150312             EndIf;
026800150312
026900150312             a8Pcid = pcId#;
027000150312
027100150312             a8Exist = '26';            // Non Established Patient
027200150312             if pcCur = 'Y';
027300150312                a8Exist = '25';         // Established Patient
027400150312             endif;
027500150312
027600150312             chain pcid# pcpmstp;
027700150312             a8PLNam = pmLnam;
027800150312             a8PFNam = pmFnam;
027900150312             a8PMNam = pmMi;
028000150313          EndDo;
028100150312
028200150312       Endsr;
028300150302      // ----------------------------------------------------------------
028400150302       begsr CheckSmoker;
028500150302
028600150302          a8Smoke = 'N';
028700150302
028800150309          chain ( mbssno : DepNumber )  Smoke;
028900150309          if not %Found(Smoke);
029000150309             leaveSr;
029100150302          EndIf;
029200150302
029300150309          Setll ( mbssno : DepNumber )  Smoke;
029400150309          dou %Eof(Smoke);
029500150309             Reade ( mbssno : DepNumber )  Smoke;
029600150302             if skRateTo = 0 and skRateFr <= %Dec(%Date);
029700150302                a8Smoke = 'Y';
029800150302                leavesr;
029900150302             EndIf;
030000150302
030100150302             if skRateFr <= %Dec(%Date) and skRateTo >= %Dec(%Date);
030200150302                a8Smoke = 'Y';
030300150302                leavesr;
030400150302             EndIf;
030500150302
030600150302          EndDo;
030700150302
030800150302       EndSr;
030900150309
031000150309      // ----------------------------------------------------------------
031100150309       begsr DependData;
031200150309
031300150309          setll mbssno Dependent;
031400150309          dou %eof(Dependent);
031500150309             reade mbssno Dependent;
031600150309
031700150309             if %eof(Dependent);
031800150309                leave;
031900150309             EndIf;
032000150309
032100150311             // Master Sort
032200150311             a8GrpSeq = %editc(sqTrust : 'X') +
032300150311                        %editc(sqSub#  : 'X') +
032400150311                        %editc(sqAccount : 'X') +
032500150311                        %editc(dssno  : 'X')    +
032600150311                        %editc(dpSeq# : 'X') ;
032700150311
032800150311
032900150309             myAge = %Diff(%Date : %Date(dBirth : *iso) : *Years);
033000150309
033100150309             Select;
033200150309                When dRelCd = 'RHU';
033300150309                   a8RelCode = '01';
033400150309                When dRelCd = 'RWI';
033500150309                   a8RelCode = '01';
033600150309                When dRelCd = 'RSO' and myAge < 19;
033700150309                   a8RelCode = '19';
033800150309                When dRelCd = 'RDA' and myAge < 19;
033900150309                   a8RelCode = '19';
034000150309                When dRelCd = 'RSO' and myAge >= 19;
034100150309                   a8RelCode = '23';
034200150309                When dRelCd = 'RDA' and myAge >= 19;
034300150309                   a8RelCode = '23';
034400150309                When dRelCd = 'RPA';
034500150309                   a8RelCode = '53';
034600150309             EndSl;
034700150309
034800150309
034900150311             //?Medicaid
035000150309             a8MedInd = 'E';
035100150309             if dMedcr = 'Y';
035200150309                if dMedAd > 0 and dMedBd = 0;
035300150309                   a8MedInd = 'A';
035400150309                EndIf;
035500150309                if dMedAd = 0 and dMedBd > 0;
035600150309                   a8MedInd = 'B';
035700150309                EndIf;
035800150309                if dMedAd > 0 and dMedBd > 0;
035900150309                   a8MedInd = 'A';
036000150309                EndIf;
036100150309
036200150309                a8Medirsn = '0';
036300150309                if dHndcp = 'Y';
036400150309                   a8Medirsn = '1';
036500150309                EndIf;
036600150309             EndIf;
036700150309
036800150311             //?Full Time Student
036900150309             if dStudn  = 'Y';
037000150309                a8Stud = 'Y';
037100150309             EndIf;
037200150309
037300150309
037400150311             //?HandiCap
037500150309             a8Hndcp = dHndcp;
037600150309             a8ssndep = %editC(DepSS# : 'X');
037700150309
037800150309             a8lnam = dLName;
037900150309             a8fnam = dFName;
038000150309             a8mnam = dmi;
038100150309             a8phone = %Char(darea) + %Char(dphone);
038200150309
038300150309             a8dob = %Char(dBirth);
038400150309             a8gendr = dSex;
038500150309
038600150312             // Get Primary Care Physician
038700150312             DepNumber = dpSeq#;
038800150312             exsr Get_PCP;
038900150312
039000150309
039100150311             //?Smoker Calc
039200150309             DepNumber = dpSeq#;
039300150309             exsr CheckSmoker;
039400150309
039500150309             if dHndCp = '3';
039600150309                a8HnDate = %Char(dHddt);
039700150309             endif;
039800150309
039900150309
040000150311            //?Dependent Address
040100150309            a8daddr1 = dAddr1;
040200150309            a8daddr2 = dAddr2;
040300150309            a8dcity  = dCity;
040400150309            a8dstate = dState;
040500150309            a8dzip   = %Char(dZip) ;
040600150309
040700150309            write AE801F;
040800150309
040900150309          EndDo;
041000150309
041100150309
041200150309       Endsr;
041300150311
041400150309      // ----------------------------------------------------------------
041500150309
041600150302       begsr $OpenC1;
041700150302
041800150311          //----------------------------------------------------------------
041900150311          //?Get all of the plans the belong to Aetna
042000150311          //----------------------------------------------------------------
042100150312          Exec Sql
042200150312             Declare C1 Cursor For
042300150302
042400150312             Select Distinct
042500150312               Carrcd, Cname,
042600150312               Pltrst, Plsub#, Plplan, Cmacct,
042700150312               Pdescr, Plncat, Sdescr, "ACTION"
042800150302
042900150312             From Carunique
043000150312             Join Hypercarr  On Hccode = Cgrpcd
043100150312             Join Carmst2p   On C2carcd = Carrcd
043200150312             Join "F.PLNMST" On Pcarr = Carrcd
043300150312             Join Plnauxp    On Pltrst = Pxtrst And Plsub# = Pxsub#
043400150312                            And Plplan = Pxplan
043500150312             Join Cmctplan   On Pltrst = Cmtrst And Plsub# = Csubdv
043600150312                            And Plplan = Cmplan
043700150312             Join "F.CODES"   On Type = Substring(Plncat, 1, 1) And
043800150312                                 Code = Substring(Plncat, 2, 2)
043900150302
044000150421             Where Hccode = 'S1' And Cadltd = 'A'
044100150325               And C2acart = 'Y' And Pxacar = 'Y'
044200150325               And Pxgroup <> 'PENDING'
044300150325
044400150312             Order By Pltrst, Plsub#, Cmacct;
044500150302
044600150302          Exec Sql    Open C1;
044700150302
044800150302       endsr;
