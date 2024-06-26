000100171229
000200171229       Ctl-opt option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000300171229          ActGrp(*New);
000400171229
000500160928      *-------------------------------------------------------------------------
000600160928      *
000700171030      *  Description: Primary Care Physician File Maintenance
000800161007      *  Programmer.: Brian Rees
000900171030      *  Date.......: 10/30/2017
001000160928      *
001100171030      * ?This program uses Profound Logic.
001200161007      *
001300171030      *  Description:
001400161007      *
001500170322      *
001600160928      *-------------------------------------------------------------------------
001700160928      * Modifications
001800160928      *
001900160928      * Date         Programmer    Mod      Description
002000160928      *-------------------------------------------------------------------------
002100160928      *
002200200729      *   Any Changes here should be placed in INQ005R ( Orginal Format)
002300160928      *-------------------------------------------------------------------------
002400171229
002500171229
002600171229      *-------------------------------------------------------------------------
002700171229      *
002800171229      * Declare Files
002900171229      *
003000171229      *-------------------------------------------------------------------------
003100200729       Dcl-f Inq005dn WorkStn
003200171229          Handler('PROFOUNDUI(HANDLER)')
003300171229          SFILE( LSTSFL : rrn);
003400171229
003500171229
003600171229       Dcl-f Pcpl2 keyed
003700171229          ExtDesc('F.PCPL2') ExtFile(*extdesc)
003800171229          usage( *update : *output : *Delete )  ;
003900171229
004000171229
004100171229       Dcl-f Depndc keyed
004200171229          ExtDesc('F.DEPNDC') ExtFile(*extdesc);
004300171229
004400171229
004500171229       Dcl-f Member keyed
004600171229          ExtDesc('F.MEMBER') ExtFile(*extDesc);
004700171229
004800171229
004900171229       Dcl-f AccMst Keyed
005000171229          ExtDesc('F.ACCMST') ExtFile(*extdesc) ;
005100171229
005200161005
005300171229      *-------------------------------------------------------------------------
005400171229      *
005500171229      * Global Variables
005600171229      *
005700171229      *-------------------------------------------------------------------------
005800171229
005900171229       dcl-s hasError ind;
006000171229       dcl-s ReLoad Char(1);
006100171229       dcl-s rrn Zoned(5);
006200171229       dcl-s rMode Char(10);
006300171229       dcl-s wDate Zoned(8);
006400171229
006500171229       dcl-s Charssn Char(9);
006600171229
006700171229       dcl-ds Add_Data;
006800171229          s2cssn;
006900171229          s2FulName;
007000171229          s2Id#;
007100171229          s2Spcd;
007200171229          s2eff;
007300171229          s2Can;
007400171229          s2Cur;
007500171229       End-Ds;
007600171229
007700180404
007800180404      *-------------------------------------------------------------------------
007900180404      *
008000180404      * *Entry Procedure
008100180404      *
008200180404      *-------------------------------------------------------------------------
008300180404       Dcl-pr Main ExtPgm;
008400180404          *N  Zoned(9);
008500180404       End-Pr;
008600180404
008700180404       dcl-pi Main;
008800180404          pMember Zoned(9);
008900180404       End-Pi;
009000180404
009100161223
009200161005      *-------------------------------------------------------------------------
009300171229      *
009400171229      * Mainline Program
009500171229      *
009600161005      *-------------------------------------------------------------------------
009700180404
009800171229       LoadHeader();
009900160928
010000161223       dou btnExit = *on;
010100160928
010200171229          ClearS1();
010300171229          LoadS1();
010400160928
010500171229          DisplyS1();
010600160928
010700161223          if btnExit = *on;
010800161223             leave;
010900161223          endif;
011000161223
011100161223
011200161223          Select;
011300161223
011400161223          when  btnAddNew = *on;
011500171031             //?Clear the Screen Data
011600171031             Clear Add_Data;
011700171101             s2Cur = 'N';
011800171031
011900161223             ReLoad = 'Y';
012000171229             $AddRecord();
012100161223
012200161223          other;
012300171229             ReadChanged();
012400161223
012500161223          endsl;
012600161223
012700161223       enddo;
012800160928
012900161223       *inlr = *on;
013000160928
013100160928      *-------------------------------------------------------------------------
013200171229       Dcl-Proc ClearS1;
013300160928
013400161223          //?Clear the Subfile
013500161223          SflClr = *on;
013600161223          Write LstCtl;
013700161223          SflClr = *off;
013800160928
013900161223          rrn = 0;
014000160928
014100171229       End-Proc;
014200160928      *-------------------------------------------------------------------------
014300171229       Dcl-Proc DisplyS1;
014400160928
014500161223          SflDsp = *on  ;
014600161223          exfmt  LstCtl ;
014700161223          SflDsp = *off;
014800160928
014900171229       End-Proc;
015000160928      *-------------------------------------------------------------------------
015100171229       Dcl-Proc LoadS1;
015200160928
015300161005
015400161223          //----------------------------------------------------
015500161223          //?Load the FTP Sites
015600161223          //----------------------------------------------------
015700171031          Setll pMember Pcpl2;
015800171031          dou %Eof(Pcpl2);
015900171031             reade(n) pMember PcpL2;
016000161005
016100171031             if %Eof(PCPL2);
016200161223                leave;
016300161223             endif;
016400161222
016500171030             s1Seq =  pcdseq;
016600171030             s1fulNam = *Blanks;
016700171030             if pcdseq = 0;
016800171030                chain pMember Member;
016900171030                if %Found( Member );
017000171030                   s1FulNam = %Trim(mlName) + ', ' + %Trim(mfName);
017100171030                endif;
017200171030             else;
017300171030
017400171030                chain (pMember : pcdSeq ) Depndc;
017500171030                if %Found( Depndc );
017600171030                   s1FulNam = %Trim(dlName) + ', ' + %Trim(dfName);
017700171030                endif;
017800171030             endif;
017900171030
018000171030
018100171030             s1PcpId = pcid#;
018200171031             s1Spcd = pcspcd;
018300171030
018400171030
018500171030             s1EffDt = *Blanks;
018600171030             if pceff > 0;
018700171030                s1EffDt = %Char(%Date(pceff:*iso):*Usa);
018800171030             endif;
018900171030
019000171030             s1CanDt = *Blanks;
019100171030             if pcCan > 0;
019200171030                s1CanDt = %Char(%Date(pccan:*iso):*Usa);
019300171030             endif;
019400171030
019500171030
019600171030             s1Curr = pccur;
019700171030
019800161222
019900161223             rrn = rrn + 1;
020000161223             write LstSfl;
020100161223
020200161223
020300161223          enddo;
020400161005
020500161005
020600161005
020700161005
020800171229       End-Proc;
020900161223
021000161223      *-------------------------------------------------------------------------
021100171229       Dcl-Proc $AddRecord;
021200161223
021300171031          s2Member = pMember;
021400171031          s2cssn = s1ssn;
021500171031          s2FulName = s1fulname;
021600161223
021700171031
021800161223          dou btnCancel = *on;
021900161223
022000161223             exfmt AddScreen;
022100171031
022200171031             if btnCancel = *on;
022300171031                leave;
022400171031             endif;
022500171031
022600171031
022700171031             rMode = 'Add';
022800171229             Validate();
022900171031
023000161223             if hasError = *on;
023100161223                iter;
023200161223             EndIf;
023300161223
023400171031
023500161223             if btnAccept = *on;
023600171031                pcssn = s2Member;
023700171101                pcdseq = s2dSeq;
023800171031                pcid# = s2id#;
023900171031                pcspcd = s2spcd;
024000171031                pcEff = %dec(%char(%date(s2Eff:*usa/):*iso0):8:0);
024100171031
024200171031                pcCan = 0;
024300171031                if s2Can > *Blanks;
024400171031                   pcCan = %dec(%char(%date(s2Can:*usa/):*iso0):8:0);
024500171031                endif;
024600171031                pcCur = s2Cur;
024700171031
024800171031                write Pcpr;
024900171031
025000161223                leave;
025100171031
025200161223             EndIf;
025300161223
025400161223
025500161223          EndDo;
025600161223
025700161223
025800171229       End-Proc;
025900161223
026000161223      *-------------------------------------------------------------------------
026100171229       Dcl-Proc LoadData;
026200161223
026300161223          clear EditScreen;
026400161223          Clear ViewScreen;
026500161223
026600161223
026700171031          chain(n) ( pMember : s1Seq : s1PcpId : s1spcd : s1effDate ) PcpL2;
026800171031          chain ( pMember : s1Seq ) Depndc;
026900171031          if %Found( Depndc );
027000171031             s2Depend = %Char( s1Seq ) + ' - ' +
027100171229                %Trim(dlName) + ', ' + %Trim(dfName);
027200171031          endif;
027300171031
027400171031
027500171031          s2Member = pMember;
027600171031
027700171031          s2cssn = s1ssn;
027800171031          s2FulName = s1fulname;
027900190621          s2dSeq = s1Seq;
028000171031
028100171031          s2id# = s1pcpid;
028200171031          s2spcd = s1spcd;
028300171031          s2eff = s1effdt;
028400171031          s2can = s1candt;
028500171031          s2Cur = s1curr;
028600171031
028700171030
028800161223
028900171229       End-Proc;
029000161223      *-------------------------------------------------------------------------
029100171229       Dcl-Proc $EditRecord;
029200161223
029300161223
029400171229          LoadData();
029500161223
029600161223          dou btnCancel = *on;
029700161223
029800161223             exfmt EditScreen;
029900161223
030000171031             if btnCancel = *on;
030100171031                leave;
030200171031             endif;
030300171031
030400171031
030500161223             if btnAccept = *on;
030600190624                wDate = 0;
030700190624                if s1Effdt > '';
030800190624                   wDate = %dec(%char(%date(s1EffDt:*usa/):*iso0):8:0);
030900190624                endif;
031000171031                chain ( pMember : s1Seq : s1PcpId : s1spcd : wDate ) PcpL2;
031100161223
031200171031                pcid#  = s2id#;
031300171031                pcspcd = s2spcd;
031400171031                pcEff = %dec(%char(%date(s2Eff:*usa/):*iso0):8:0);
031500171031
031600171031                pcCan = 0;
031700171031                if s2Can > *Blanks;
031800171031                   pcCan = %dec(%char(%date(s2Can:*usa/):*iso0):8:0);
031900171031                endif;
032000171031                pcCur = s2Cur;
032100171031
032200171031                Update Pcpr;
032300171031
032400171031
032500161223                leave;
032600161223
032700161223             EndIf;
032800161223
032900161223
033000161223          EndDo;
033100161223
033200161223
033300171229       End-Proc;
033400161007      *-------------------------------------------------------------------------
033500171229       Dcl-Proc Validate;
033600161007
033700161223          hasError = *off;
033800171031          errExist = *off;
033900180426          errEffDt = *off;
034000180426          errCanDt = *off;
034100180426
034200171031
034300180607          if s2Eff > '';
034400180607          test(DE) *usa s2Eff;
034500180426          if %Error;
034600180426             hasError = *on;
034700180426             errEffDt = *on;
034800180426          EndIf;
034900180607          EndIf;
035000180426
035100180607          if s2Can > '';
035200180607          test(DE) *usa s2Can;
035300180426          if %Error;
035400180426             hasError = *on;
035500180426             errCanDt = *on;
035600180426          EndIf;
035700180607          EndIf;
035800180426
035900171031
036000171031          if rMode = 'Add';
036100180426             if errEffDt = *off;
036200171031             //?Make sure this record doesn't already exist
036300171031             wDate = %dec(%char(%date(s2Eff:*usa/):*iso0):8:0);
036400190618         //  chain(n) ( s2Member : s2dSeq : s2id# : s2spcd : wDate ) PcpL2;
036500190618              chain(n) ( s2Member : s2dSeq : s2id# : s2spcd  ) PcpL2;
036600171031
036700171101             if %Found( PcpL2 );
036800171031                hasError = *on;
036900171031                ErrExist = *on;
037000171101             endif;
037100180426             endif;
037200171031          endif;
037300171031
037400180426
037500171229       End-Proc;
037600161223
037700161223      *-------------------------------------------------------------------------
037800171229       Dcl-Proc ReadChanged;
037900161223
038000161223          Dou *in95 = *ON;
038100161223             READC LstSfl;
038200161223             *in95 = %EOF;
038300161223
038400161223             If *in95 = *OFF;
038500161223
038600161223                If btnEdit = *on;
038700171229                   $EditRecord();
038800161223                endIf;
038900161223
039000161223
039100161223                If btnView = *on;
039200171229                   $ViewRecord();
039300161223                endIf;
039400161223
039500161223
039600161223                If btnDelete= *on;
039700171229                   $DelRecord();
039800161223                endIf;
039900161223
040000161223
040100161223                btnDelete = *off;
040200161223                btnView = *off;
040300161223                btnEdit = *off;
040400161223                update LstSfl;
040500161223
040600161223                Reload = 'Y';
040700161223             endIf;
040800161223
040900161223
041000161223          enddo;
041100171229       End-Proc;
041200161223
041300161223      *-------------------------------------------------------------------------
041400171229       Dcl-Proc $ViewRecord;
041500161223
041600161223
041700171229          LoadData();
041800161223
041900161223          dou btnCancel = *on;
042000161223             exfmt ViewScreen;
042100161223          enddo;
042200161223
042300161223
042400171229       End-Proc;
042500161223
042600161223
042700161223
042800161223      *-------------------------------------------------------------------------
042900171229       Dcl-Proc $DelRecord;
043000161223
043100161223
043200171229          LoadData();
043300161223
043400161223          dou btnCancel = *on;
043500161223             exfmt Confirm;
043600161223
043700161223
043800161223             if btnAccept = *on;
043900171031                wDate = %dec(%char(%date(s1EffDt:*usa/):*iso0):8:0);
044000171031                chain ( pMember : s1Seq : s1PcpId : s1spcd : wDate ) PcpL2;
044100171031                if %Found( PcpL2 );
044200171031                   delete pcpr;
044300171031                endif;
044400171031
044500161223                leave;
044600161223             EndIf;
044700161223
044800161223          enddo;
044900161223
045000161223
045100171229       End-Proc;
045200161223
045300171030
045400171030      *-------------------------------------------------------------------------
045500171229       Dcl-Proc LoadHeader;
045600171030
045700171229          chain pMember Member;
045800171030
045900171030
046000171229          CharSSN = %Editc(pMember : 'X');
046100171229          s1ssn = %Subst(CharSSN:1:3) + '-' +
046200171229             %Subst(CharSSN:4:2) + '-' +
046300171229             %Subst(CharSSN:6:4) ;
046400171030
046500171030
046600171030
046700171229          chain (mbtrst :  mbSub# : mbAcct ) AccMst;
046800171030
046900171229          s1FulName = %Trim(mlname) + ', ' + %Trim(mfname);
047000171229          s1ActNbr = %Editc(mbTrst:'X') + '-' + %Editc(mbSub#:'X') + '-' +
047100171229             %Editc(mbAcct:'X');
047200171229          s1ActName = acNam1;
047300171030
047400171030
047500171030
047600171030
047700171229       End-Proc;
047800171030
