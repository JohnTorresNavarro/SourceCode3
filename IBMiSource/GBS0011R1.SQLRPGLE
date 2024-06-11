000001210305       Ctl-opt option(*nodebugio:*srcstmt:*nounref)   DftActGrp(*no)
000002210305         bnddir('GBSBIND');
000003210303
000004210303      *-------------------------------------------------------------------------
000005210303      *
000006210309      *  Description: VSP Plan Maintenance
000007210303      *  Programmer.: Brian Rees
000008210305      *  Date.......: 09/02/2016
000009210303      *
000010210303      *-------------------------------------------------------------------------
000011210305      * Modifications
000012210305      *
000013210305      *  3/05/2021   B.Rees   Redesigned for PL.
000014210305      *
000015210305      *-------------------------------------------------------------------------
000016210303
000017210305
000018210303      *-------------------------------------------------------------------------
000019210303      *
000020210303      * Declare Files
000021210303      *
000022210303      *-------------------------------------------------------------------------
000023210309       Dcl-f GBS0011d1 WorkStn
000024210303          Handler('PROFOUNDUI(HANDLER)')
000025210303          SFILE(LstSfl:rrn);
000026210303
000027210305       dcl-f CarPlnp keyed usage(*update:*input:*Delete:*output);
000028210305       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
000029210305
000030210303
000032210303
000033210303      *-------------------------------------------------------------------------
000034210303      *
000035210303      * Global Variables
000036210303      *
000037210303      *-------------------------------------------------------------------------
000039210303       dcl-ds pgmd
000040210303          ExtName('IOPGMD') PSDS;
000041210305         @pgmq *proc;
000042210303       end-ds;
000043210303
000053210305       dcl-s CstCntr Char(3) inz;
000056210305       dcl-s wDate Zoned(8);
000057210305       dcl-s sqPlan Char(4);
000059210303       dcl-s rrn Zoned(5);
000060210305
000061210305       dcl-s hasError ind;
000062210305       dcl-s canEdit ind;
000063210305       dcl-s canDelete ind;
000064210305
000065210309       dcl-s Uniqueid Char(10) inz('0000000092');
000066210309       dcl-s hldGroup# Char(15);
000067210309       dcl-s SavSqlCod like( SqlCod );
000068210303
000069210305      *--------------------------------------------
000070210305      *
000071210305      * Procedures
000072210305      *
000073210305      *--------------------------------------------
000074210305      /include *LIBL/QMODSRC,#ChkFncAth        // Check Function Authority
000075210305
000076210303
000077210305      *-------------------------------------------------------------------------
000078210305      *
000079210305      * *Entry Procedure
000080210305      *
000081210305      *-------------------------------------------------------------------------
000082210305       Dcl-pr Main ExtPgm;
000083210305         *N  Zoned(3);
000084210305         *N  Zoned(3);
000085210305         *N  Zoned(4);
000086210305       End-Pr;
000087210305
000088210305       dcl-pi Main;
000089210305         pTrst Zoned(3);
000090210305         pSub# Zoned(3);
000091210305         pAcct Zoned(4);
000092210305       End-Pi;
000093210303
000094210303      *-------------------------------------------------------------------------
000095210303      *
000096210303      * Mainline Program
000097210303      *
000098210303      *-------------------------------------------------------------------------
000099210303
000100210305       init();
000101210305
000102210305       Dou btnExit = *on;
000103210303
000104210305         ClearS1();
000105210305         LoadS1();
000106210303
000107210305         DisplyS1();
000108210303
000109210303
000110210305         //?Process Selections
000111210305         Select;
000112210303
000113210305         When btnAddNew = *on;
000114210305           Add_Acct();
000115210305
000116210305         when btnLoad = *on;
000117210305           LoadPlans();
000118210303
000120210303
000121210305         when btnLoad = *on;
000122210305           LoadPlans();
000124210305
000125210305         other;
000126210305           ReadChangedS1();
000127210303
000128210305         EndSl;
000129210303
000130210303
000131210303       enddo;
000132210303
000133210303       *inlr = *on;
000134210303
000135210303
000136210303
000137210303       // ----------------------------------------------------------------
000138210303       dcl-proc CLEARS1;
000139210303
000140210305         //-------------------------
000141210305         //
000142210305         // Clear the Subfile
000143210305         //
000144210305         //-------------------------
000145210303
000146210305         SflClr = *on;
000147210305         Write LstCtl;
000148210305         SflClr= *off;
000149210305         rrn = 0;
000150210303
000151210303       End-Proc;
000152210303       // ----------------------------------------------------------------
000153210303       Dcl-Proc LoadS1;
000154210303
000155210305         Setll (UniqueId : pTrst : pSub# : pAcct) CarPlnp;
000156210305         Dou %eof(CarPlnp);
000157210303
000158210305           reade(n) (UniqueId : pTrst : pSub# : pAcct) CarPlnp;
000159210305           if %eof(CarPlnp);
000160210305             leave;
000161210305           endif;
000163210305
000164210305           s1Plan = cpPlan;
000165210305           s1Cid1 = cpCid1;
000166210309           s1Cid2 = cpCid2;
000167210305
000179210305           if cpCida > ' ' and cpCida <> 'N/A';
000180210305             wDate = %Dec( %Subst(cpCida: 20 : 8 ) : 8 : 0 );
000181210305             s1CrtDt = %Char(%Date(wDate:*iso):*Usa)  ;
000182210305           endif;
000183210305
000184210305
000185210305           s1ChgDt = '';
000186210305           if cptxta > ' ' and cptxta <> 'N/A';
000187210305             wDate = %Dec( %Subst(cptxta: 20 : 8 ) : 8 : 0 );
000188210305             s1ChgDt = %Char(%Date(wDate:*iso):*Usa)  ;
000189210305           endif;
000190210305
000191210305
000193210305           rrn = rrn + 1;
000194210305           write LstSfl;
000195210303
000196210305         enddo;
000197210303
000198210303       End-Proc;
000199210303
000200210303       // ----------------------------------------------------------------
000201210303       Dcl-Proc DisplyS1;
000202210303
000203210305         SflDsp = *on  ;
000204210305         exfmt LstCtl;
000205210305         SflDsp = *off;
000206210303
000207210303       End-Proc;
000208210303
000209210303       // ----------------------------------------------------------------
000210210303       Dcl-Proc ReadChangedS1;
000211210303
000212210305         Dou *in95 = *ON;
000213210305           READC LstSfl;
000214210305           *in95 = %EOF;
000215210303
000216210305           If *in95 = *OFF;
000218210303
000219210305             // Edit Plan
000220210305             if btnEdit = *on;
000221210305               Load_Data();
000222210305               Edit_Acct();
000223210305             endIf;
000224210303
000225210305
000226210305             // View Plan
000227210305             if btnView = *on;
000228210305               Load_Data();
000229210305               exfmt ViewScreen;
000230210305             endIf;
000231210305
000232210303
000241210305
000242210305             // Delete Plan
000243210305             if btnDelete = *on;
000244210305               chain (UniqueId : pTrst : pSub# :
000245210305                        pAcct : CstCntr : s1Plan ) CarPlnp;
000246210305
000247210305               if %Found(CarPlnp);
000248210305                 delete CarPlnr;
000249210305
000250210305               endif;
000251210305             EndIf;
000252210305
000256210305             btnView = *off;
000258210305             btnDelete = *off;
000259210305             btnEdit = *off;
000260210305             update LstSfl;
000261210303
000262210305           endIf;
000263210303
000264210305         enddo;
000265210303
000266210303       End-Proc;
000267210303
000268210303
000288210305       // ----------------------------------------------------------------
000289210305       dcl-proc init;
000290210305
000295151216         s1Tsa = %editc(pTrst : 'X') + '-' +
000296151216                 %editc(pSub# : 'X') + '-' +
000297151216                 %editc(pAcct : 'X') ;
000298160902
000302151216
000303210305         chain ( ptrst : pSub#: pAcct ) AccMst;
000304210305         if %Found( AccMst ) ;
000305210305           s1GrpName = acNam1;
000306210305         EndIf;
000307210305
000308210305
000309210305         //vUser Allowed to Delete?
000310210305         oFunction = 'DELETE';
000311210305         oDspErrMsg = 'N';
000312210305         canDelete = *off;
000313151223
000314210305         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
000315210305         if oContinue = 'Y';
000316210305           canDelete = *on;
000317210305         endif;
000318151217
000319160729
000320210305         // User Allowed to Edit?
000321210305         canEdit = *off;
000322210305         oFunction = 'EDIT';
000323210305         oDspErrMsg = 'N';
000324160729
000325210305         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
000326210305         if oContinue = 'Y';
000327210305           canEdit = *on;
000328210305         endif;
000329160729
000330210305
000331210305       End-Proc;
000350151216       // ----------------------------------------------------------------
000351151216
000481210305       dcl-Proc Load_data;
000482151216
000483210305         s2tsa = s1tsa;
000484210305         s2GrpName = s1GrpName;
000485210305
000486210305         chain (UniqueId : pTrst : pSub# :
000487210305                pAcct : CstCntr : s1Plan ) CarPlnp;
000488151216
000489210305         if %Found(CarPlnp);
000490210305           s2Plan = cpPlan;
000491210305           s2Cid1 = cpCid1;
000492210309           s2Cid2 = cpCid2;
000493180529
000494210305           if cpCida = 'N/A';
000495210305             cpCida = '';
000496210305           endif;
000497210305           s2CrtDt = cpCida;
000498180529
000499210305           if cptxta = 'N/A';
000500210305             cptxta = '';
000501210305           endif;
000502210305           s2ChgDt = cptxta;
000503210305         endif;
000504151216
000505210305       end-Proc;
000506151216
000507151216       // ----------------------------------------------------------------
000508210305       Dcl-Proc Edit_Acct;
000509210305
000510210305         Dou btnCancel = *on;
000511210305
000512210305           exfmt EditScreen;
000513210305
000514210305           if btnAccept = *on;
000515210305
000516210305             cpCid1 = s2Cid1;
000517210309             cpCid2 = s2Cid2;
000518210309
000519210305             cpTxtA = 'Changed: ' + WQUSRN  + %Char(%Dec(%Date));
000520210305             Update CarPlnr;
000521210305
000523210305             leave;
000524210305           EndIf;
000526210305
000527210305         enddo;
000528210305
000529210305         btnCancel = *off;
000530210305
000531210305       End-Proc;
000532210305
000533210305
000586210305       //------------------------------------------------------
000588210305
000589210305       dcl-proc Add_Acct;
000590210305
000591210305         clear AddScreen;
000592210305         s2Tsa = s1Tsa;
000599210305         s2GrpName = s1GrpName;
000600210305
000601210305         Dou btnCancel = *on;
000602210305
000603210305           exfmt AddScreen;
000604210305           errPlan = *off;
000610210305
000611210305           if btnAccept = *on;
000612210305             Validate();
000613210305             if hasError = *on;
000614210305               iter;
000615210305             EndIf;
000616210305
000625210305
000626210305             //---------------------------------
000627210305             // No Error?
000628210305             // Write to the File.
000631210305             //---------------------------------
000633210305             cpuniq = UniqueID;
000634210305             cpTrst = pTrst;
000635210305             cpSub# = pSub#;
000636210305             cpAcct = pAcct;
000637210305             cpPlan = s2Plan;
000638210309
000639210309             cpTxt1 = 'Division Code';
000640210309             cpTxt2 = 'Division Code - Cobra';
000641210309
000642210309             cpCid1 = s2Cid1;
000643210309             cpCid2 = s2Cid2;
000644210309
000645210305             cpcidA = 'Created: ' + WQUSRN  + %Char(%Dec(%Date));
000646210305             cpTxtA = '';
000647210305
000648210305             Write CarPlnr;
000649210305
000650210305             s2MSg = 'Plan ' + %Trim(cpPlan) + ' has been added.';
000651210305
000652210305           // Dont Leave.. Redisply the page for multiple entries
000653210305
000654210305           endif;
000655210305
000656210305         EndDo;
000657210305
000658210305
000659210305       end-proc;
000660210305
000709210305       //------------------------------------------------------
000710210305       dcl-proc Validate;
000711151223
000712210305         hasError = *off;
000713210305
000714210305         // Check to see if the record exists
000715210305         chain (UniqueID : pTrst : pSub# :
000716210305         pAcct : CstCntr : s2Plan ) CarPlnp;
000717151223
000718210305         if %Found(CarPlnp);
000719210305           errPlan = *on;
000720210305           hasError = *on;
000721210305         EndIf;
000722151223
000723151223
000724210305       end-Proc;
000725210305       //------------------------------------------------------
000726210305       dcl-proc LoadPlans;
000727170727
000728170727
000729210305         // This will automatically load all of the NVA plans
000730210305         // from the Commission control File.
000731170727
000732210309         Exec Sql
000733210309           Declare C1 Cursor For
000734210309             Select Plplan
000735210309               From "F.COMCTX"
000736210309                    Join "F.PLNMST"
000737210309                      On Pltrst = Cmtrst And
000738210309                        Plsub# = Csubdv And
000739210309                        Plplan = Cmplan
000740210309               Where Cmtrst = :Ptrst And
000741210309                     Csubdv = :Psub# And
000742210309                     Cmacct = :Pacct And
000743210309                     Pcarr In ('VSP') and
000744210309                     pldltd = 'A';
000745170727
000746210309         Exec Sql
000747210309           Open C1;
000748170727
000749210305         Dou SqlCod <> *Zero;
000750170727
000751210309           Exec Sql
000752210309             Fetch Next From C1
000753210309               Into :sqPlan;
000754170727
000755210305           if SqlCod <> *Zero;
000756210305             leave;
000757210305           endif;
000758170727
000759210305           chain (UniqueID : pTrst : pSub# : pAcct: ' ' : sqPlan) CarPlnp;
000760210305           if not %Found( CarPlnp ) ;
000761170727
000762210305             // Write the Record
000763210305             cpuniq = UniqueId;
000764210305             cpTrst = pTrst;
000765210305             cpSub# = pSub#;
000766210305             cpAcct = pAcct;
000767210305             cpPlan = sqPlan;
000768170727
000769210309             cpTxt1 = 'Division Code';
000770210309             cpTxt2 = 'Division Code - Cobra';
000771210309
000772210309             //?Get Group Number...
000773210309             savSqlCod = SqlCod;
000774210309             hldGroup# = '';
000775210309             Exec Sql
000776210309               Select Group#
000777210309                 into :hldGroup#
000778210309                 From "F.GRATE"
000779210309                 Where grTrst = :pTrst and
000780210309                       grSub# = :pSub# and
000781210309                       grPlan = :sqPlan and
000782210309                       grdltd = 'A'
000783210309                 Fetch first row only;
000784210309             SqlCod = savSqlCod;
000785210309
000786210309
000787210309
000788210309             cpCid1 = %Trim(hldGroup#) + '-0001-0001';
000789210309             cpCid2 = %Trim(hldGroup#) + '-0002-0002';
000790210309
000791210309
000792210309
000793210305             cpcidA = 'Created: ' + WQUSRN  + %Char(%Dec(%Date));
000794210305             cpTxtA = '';
000795180529
000796210305             Write CarPlnr;
000797170727
000798210305           endif;
000799170727
000800210305         enddo;
000801170727
000802210309         Exec Sql
000803210309           Close C1;
000804170727
000805170727
000806210305       end-proc;
