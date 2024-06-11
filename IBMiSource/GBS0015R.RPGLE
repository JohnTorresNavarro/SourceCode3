000100160708     H option(*noDebugIo) DftActGrp(*no)
000200160708    ? *-------------------------------------------------------------------------
000300160708    ? *
000400170322    ? *  Description: Format the Offit Data File.
000500160708      *
000600170322    ? *  Programmer.: Brian Rees
000700170322    ? *  Date.......: 07/08/2016
000800160708    ? *
000900160708    ? *
001000160708    ? *-------------------------------------------------------------------------
001100170112    ?FGbs0015D  CF   E             WORKSTN
001200160926     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001300170113     F                                     SFILE(LSTSFL:rrn)
001400170112
001500170112     FUltiSoftL1if   e           k disk    rename(ultisoftr:Rec1) UsrOpn
001600170112     FUltiSoftL2if   e           k disk    rename(ultisoftr:Rec2) UsrOpn
001700170112     FUltiSoftL3if   e           k disk    rename(ultisoftr:Rec3) UsrOpn
001800170112     FUltiSoftL4if   e           k disk    rename(ultisoftr:Rec4) UsrOpn
001900170112     F*?Ultimate Software Import File.
002000170112
002100160708    ? *-------------------------------------------------------------------------
002200160708
002300160708     D pgmsts         sDS
002400160708     D  Parms                         3s 0 Overlay( PgmSts: 37 )
002500160708     D  Jobname                      10    Overlay( PgmSts: 244 )
002600160708     D  Jobnum                        6s 0 Overlay( PgmSts: 264 )
002700160708     D CurrentUser                   10    Overlay( PgmSts: 358 )
002800160708
002900160926     D UploadFile      DS                  Qualified
003000160926     D  NumFiles                      3S 0
003100160926     D  Directory                   256A
003200160926     D  Files                       256A
003300160926
003400160711     d hasError        s               n   inz
003500160926     d Reload          s              1    inz
003600170113     d Rrn             s              5s 0 inz
003700170112
003800170112     d PlanArry        s             20a   dim(16)
003900170112     d EnrlArry        s              3a   dim(16)
004000170124     d EffDtArry       s              8a   dim(16)
004100170124     d TermDtArry      s              8a   dim(16)
004200170112     d PlnCnt          s              3s 0
004300170112     D Depno           s              2s 0
004400170130     d i               s              2s 0 inz
004500170130
004600170112     D q               c                   Const('''')
004700170201     D Office          s             30    inz
004800170112
004900170112      *-------------------------------------------------------------------------
005000170112     D/include *LIBL/QMODSRC,#COMMANDPR        //?Command
005100170112
005200170112
005300160926    ? *-------------------------------------------------------------------------
005400160926      * Mainline Program
005500160926      *-------------------------------------------------------------------------
005600170112     C*    *entry        plist
005700170112     C*                  parm                    pOvrWrt           1
005800160926
005900160926
006000160708      /Free
006100160708
006200170112          //?Get Offit Text File
006300160708          Dou btnExit = *on;
006400160926             Exfmt Screen1;
006500160922
006600160926             if btnExit = *on;
006700160926                leave;
006800160926             endif;
006900160926
007000160926             //?Check for Errors
007100170116             exsr Validate;
007200161004
007300160926             if hasError = *on;
007400160926                iter;
007500160926             endif;
007600160922
007700170116             exsr ViewData;
007800170116
007900160926             leave;
008000160922          enddo;
008100160922
008200170112
008300160922       *inlr = *on;
008400170116      *-------------------------------------------------------------------------
008500170116       Begsr ViewData;
008600170116
008700170116          //--------------------------------------------------
008800170116          //?Copy the Text file to the Physical File
008900170116          //--------------------------------------------------
009000170116          CmdString = 'CpyFrmImpf ' +
009100170116                      'FromStmf(' + q + '/tmp/Offit.txt' + q + ') ' +
009200170116                      'ToFile(UltiSoftp) MbrOpt(*Replace) RcdDlm(*All) ' +
009300170116                      'STRESCCHR(*NONE) FLDDLM(' + q + '|' + q + ')';
009400170116
009500170116           #Command(CmdString:%len(%Trim(CmdString)));
009600170116
009700170116
009800170116          //--------------------------------------------------
009900170116          //?Open the Files
010000170116          //--------------------------------------------------
010100170116           open UltiSoftL1 ;
010200170116           open UltiSoftL2 ;
010300170116           open UltiSoftL3 ;
010400170116           open UltiSoftL4 ;
010500170116
010600170116
010700170116          //--------------------------------------------------
010800170116          //?Create the SubFile.
010900170116          //--------------------------------------------------
011000170116          btnExit  = *off;
011100170116          Reload = 'Y';
011200170116            dou btnExit = *on;
011300170116
011400170116             if Reload = 'Y';
011500170116                exsr ClearS2;
011600170116                exsr ProcessData;
011700170116                Reload = 'N';
011800170116             endif;
011900170116
012000170116             exsr DisplyS2;
012100170116
012200170116
012300170116          enddo;
012400170116
012500170116
012600170116          //--------------------------------------------------
012700170116          //?Close the Files
012800170116          //--------------------------------------------------
012900170116           Close UltiSoftL1 ;
013000170116           Close UltiSoftL2 ;
013100170116           Close UltiSoftL3 ;
013200170116           Close UltiSoftL4 ;
013300170116
013400170116
013500170116       Endsr;
013600160926      *-------------------------------------------------------------------------
013700160926       Begsr Validate;
013800160926
013900170116          errFile = *off;
014000160926          hasError = *off;
014100170112
014200160926          if uploadFile.Files = *Blanks;
014300160926             hasError = *on;
014400160926             errFile = *on;
014500160926          endif;
014600160926
014700160926       Endsr;
014800170112      *-------------------------------------------------------------------------
014900170112       Begsr ProcessData;
015000170112
015100170112           setll *loval UltiSoftl1;
015200170112           dou %Eof(UltiSoftL1);
015300170112              read UltiSoftL1;
015400170112
015500170112              if %eof(UltiSoftL1);
015600170112                 leave;
015700170112              endif;
015800170112
015900170124              //?Get the Member Plans then Write Record.
016000170112              Exsr GetMbrPlans;
016100170112              Exsr WriteMbrRcd;
016200170112
016300170124              //?Get the Dependents...
016400170112              setll l1_ssn ultisoftl3;
016500170112              dou %eof(ultisoftl3);
016600170112                 reade l1_ssn ultisoftl3;
016700170112
016800170112                 if %eof(ultisoftl3);
016900170112                    leave;
017000170112                 endif;
017100170112
017200170112                 Exsr GetDepnPlans;
017300170112                 Exsr WriteDepnRcd;
017400170112
017500170112              enddo;
017600170112
017700170113          s1Type = *Blanks;
017800170113          s1Info = *Blanks;
017900170113          rrn = rrn + 1;
018000170113          write LstSfl;
018100170112           enddo;
018200170112
018300170112        endsr;
018400170112       //-----------------------------------------------------------
018500170112        begsr GetMbrPlans;
018600170112
018700170112           PlnCnt = 0;
018800170112
018900170112           setll l1_ssn ultisoftl2;
019000170112           dou %eof(ultisoftl2);
019100170112              reade l1_ssn ultisoftl2;
019200170112
019300170112              if %eof(ultisoftl2);
019400170112                 leave;
019500170112              endif;
019600170112
019700170112              PlnCnt = PlnCnt + 1;
019800170112              PlanArry(PlnCnt) = l2_plan;
019900170112              EnrlArry(PlnCnt) = l2_enrl;
020000170124              EffDtArry(PlnCnt) = %Char(L2_effdt);
020100170124              TermDtArry(PlnCnt) = %Char(L2_termdt);
020200170124
020300170112           enddo;
020400170112
020500170112
020600170112        endsr;
020700170112        //---------------------------------------------------------
020800170112        Begsr WriteMbrRcd;
020900170112
021000170113
021100170113          s1Type = 'Member:';
021200170113          s1Info = l1_ssn;
021300170113          rrn = rrn + 1;
021400170113          write LstSfl;
021500170113
021600170113          s1Type = *Blanks;
021700170113          s1Info = %trim(l1_lname) + ', ' + %trim(l1_fname);
021800170113          rrn = rrn + 1;
021900170113          write LstSfl;
022000170113
022100170113          s1Info = %trim(l1_Addr1);
022200170113          rrn = rrn + 1;
022300170113          write LstSfl;
022400170113
022500170113          if l1_addr2 > *Blanks;
022600170113             s1Info = %trim(l1_Addr2);
022700170113             rrn = rrn + 1;
022800170113             write LstSfl;
022900170113          endif;
023000170113
023100170113          s1Info = %trim(l1_City) + ', ' + %trim(l1_State) + '  ' +
023200170113                   %trim(l1_Zip);
023300170113          rrn = rrn + 1;
023400170113          write LstSfl;
023500170113
023600170201          if l1_loc > *Blanks;
023700170201             Office = l1_loc;
023800170201             Select;
023900170201               When l1_loc = '00  ';
024000170201                  Office = 'Home Office';
024100170201               When l1_loc = '01  ';
024200170201                  Office = 'Maple Lawn, MD';
024300170201               When l1_loc = '03  ';
024400170201                  Office = 'Bethesda, MD';
024500170201               When l1_loc = '04  ';
024600170201                  Office = 'Philadelphia, PA';
024700170201               When l1_loc = '05  ';
024800170201                  Office = 'Wilmington, DE';
024900170201               When l1_loc = '06  ';
025000170201                  Office = 'Baltimore, MD';
025100170201               When l1_loc = '07  ';
025200170201                  Office = 'Tysons Corner, VA';
025300170201               When l1_loc = '08  ';
025400170201                  Office = 'Frederick, MD';
025500170201               When l1_loc = '09  ';
025600170201                  Office = 'Woodbridge, NJ';
025700170201               When l1_loc = '10  ';
025800170201                  Office = 'New York, NY';
025900170201               When l1_loc = '11  ';
026000170201                  Office = 'Harrisburg, PA';
026100170201               When l1_loc = '14  ';
026200170201                  Office = 'Woodbridge, NJ';
026300170201               When l1_loc = '17  ';
026400170201                  Office = 'Plymouth Meeting, PA';
026500170201               When l1_loc = 'ALLE';
026600170201                  Office = 'Allentown';
026700170201               When l1_loc = 'CA   ';
026800170201                  Office = 'California';
026900170201               When l1_loc = 'NJJS ';
027000170201                  Office = 'NJ Sofield';
027100170201               When l1_loc = 'NJSP ';
027200170201                  Office = 'Shelley Prado';
027300170201               When l1_loc = 'NYLB ';
027400170201                  Office = 'NY Benjamin';
027500170201               When l1_loc = 'NJMJ ';
027600170201                  Office = 'Monique Jean';
027700170201               When l1_loc = 'UTJP ';
027800170201                  Office = 'Utah';
027900170201               When l1_loc = 'UTSL ';
028000170201                  Office = 'Utah Lindsay';
028100170201               When l1_loc = 'VA   ';
028200170201                  Office = 'VA';
028300170201               EndSl;
028400170201
028500170201              s1Info = 'Office: ' + %trim(l1_loc)  + ' - ' +  Office;
028600170201              rrn = rrn + 1;
028700170201              write LstSfl;
028800170201          endif;
028900170201
029000170501          if l1_termdt > *Blanks;
029100170501             s1Info = 'Member Termed Date: ' + l1_termdt;
029200170501             rrn = rrn + 1;
029300170501             write LstSfl;
029400170501          endif;
029500170501
029600170501          s1Info = 'Gender: ' + l1_gender;
029700170501          rrn = rrn + 1;
029800170501          write LstSfl;
029900170501
030000170501
030100170501          if l1_marSts > *Blanks;
030200170501             Select;
030300170501             when l1_Marsts = 'D';
030400170501               s1Info = 'Marital Status: Divorced';
030500170501             when l1_Marsts = 'I';
030600170501               s1Info = 'Marital Status: Single';
030700170501             when l1_Marsts = 'M';
030800170501               s1Info = 'Marital Status: Married';
030900170501             when l1_Marsts = 'S';
031000170501               s1Info = 'Marital Status: Separated';
031100170501             when l1_Marsts = 'W';
031200170501               s1Info = 'Marital Status: Widowed';
031300170501             endsl;
031400170501             rrn = rrn + 1;
031500170501             write LstSfl;
031600170501          endif;
031700170501
031800170501
031900170501          if l1_sal > *Blanks;
032000170501             s1Info = 'Salary: ' + l1_Sal;
032100170501             rrn = rrn + 1;
032200170501             write LstSfl;
032300170501          endif;
032400170501
032500170501
032600170501
032700170501
032800170113          s1Info = 'DOB: ' + l1_dob;
032900170113          rrn = rrn + 1;
033000170113          write LstSfl;
033100170113
033200170113          s1Info = 'DOH: ' + l1_doh;
033300170113          rrn = rrn + 1;
033400170113          write LstSfl;
033500170113
033600170113          s1Info = 'Phone: ' + l1_Phone;
033700170113          rrn = rrn + 1;
033800170113          write LstSfl;
033900170113
034000170130
034100170130          for i = 1 to 16;
034200170130
034300170130             if PlanArry(i) = *Blanks;
034400170130                leave;
034500170130             endif;
034600170130
034700170130
034800170130             s1Info = 'Plan: ' + %trim(PlanArry(i)) +
034900170130                  '   Effective Date: ' + %trim(EffDtArry(i)) +
035000170130                  '   Enrollment Lvl: ' + EnrlArry(i);
035100170130             rrn = rrn + 1;
035200170130             write LstSfl;
035300170124
035400170113
035500170130             if TermDtArry(i) > *Blanks;
035600170130                s1Info = 'Term Date: ' + %trim(TermDtArry(i)) ;
035700170130                rrn = rrn + 1;
035800170130                write LstSfl;
035900170130             endif;
036000170130          endfor;
036100170130
036200170124
036300170130          Clear PlanArry;
036400170130          Clear EnrlArry;
036500170130          Clear EffDtArry;
036600170130          Clear TermDtArry;
036700170112
036800170112        Endsr;
036900170112       //-----------------------------------------------------------
037000170112        begsr GetDepnPlans;
037100170112
037200170112           PlnCnt = 0;
037300170112
037400170112           setll l3_uniqid ultisoftl4;
037500170112           dou %eof(ultisoftl4);
037600170112              reade l3_uniqid ultisoftl4;
037700170112
037800170112              if %eof(ultisoftl4);
037900170112                 leave;
038000170112              endif;
038100170112
038200170112              PlnCnt = PlnCnt + 1;
038300170112              PlanArry(PlnCnt) = l4_plan;
038400170130              EffDtArry(PlnCnt) = %Char(L4_effdt);
038500170112           enddo;
038600170112
038700170112
038800170112        endsr;
038900170112        //---------------------------------------------------------
039000170112        Begsr WriteDepnRcd;
039100170112
039200170113          s1Type = 'Dependent:';
039300170113          s1Info = l3_Depssn;
039400170113          rrn = rrn + 1;
039500170113          write LstSfl;
039600170113
039700170113          s1Type = *Blanks;
039800170113          s1Info = %trim(l3_lname) + ', ' + %trim(l3_fname);
039900170113          rrn = rrn + 1;
040000170113          write LstSfl;
040100170113
040200170113          s1Info = %trim(l3_Addr1);
040300170113          rrn = rrn + 1;
040400170113          write LstSfl;
040500170113
040600170113          if l3_addr2 > *Blanks;
040700170113             s1Info = %trim(l3_Addr2);
040800170113             rrn = rrn + 1;
040900170113             write LstSfl;
041000170113          endif;
041100170113
041200170113          s1Info = %trim(l3_City) + ', ' + %trim(l3_State) + '  ' +
041300170113                   %trim(l3_Zip);
041400170113          rrn = rrn + 1;
041500170113          write LstSfl;
041600170113
041700170113          s1Info = 'Gender: ' + l3_gender;
041800170113          rrn = rrn + 1;
041900170113          write LstSfl;
042000170113
042100170130          Select;
042200170130            When L3_relcod = 'S';
042300170130               s1Info = 'Relationship: Spouse';
042400170130            When L3_relcod = 'C';
042500170130               s1Info = 'Relationship: Child';
042600170130            Other;
042700170130               s1Info = 'Relationship: ' + L3_relcod;
042800170130          Endsl;
042900170130          rrn = rrn + 1;
043000170130          write LstSfl;
043100170130
043200170130
043300170113          s1Info = 'DOB: ' + l3_Dob;
043400170113          rrn = rrn + 1;
043500170113          write LstSfl;
043600170113
043700170130
043800170130          for i = 1 to 16;
043900170130
044000170130             if PlanArry(i) = *Blanks;
044100170130                leave;
044200170130             endif;
044300170130
044400170130
044500170130             s1Info = 'Plan: ' + %trim(PlanArry(i)) +
044600170130                  '   Effective Date: ' + %trim(EffDtArry(i)) ;
044700170130             rrn = rrn + 1;
044800170130             write LstSfl;
044900170130          endfor;
045000170130
045100170130
045200170112           Clear PlanArry;
045300170112           Clear EnrlArry;
045400170112
045500170112        Endsr;
045600170112
045700170112
045800170113      *-------------------------------------------------------------------------
045900170113       Begsr ClearS2;
046000170113
046100170113          // Clear the Subfile
046200170113          SflClr = *on;
046300170113          Write LstCtl;
046400170113          SflClr = *off;
046500170113
046600170113          rrn = 0;
046700170113
046800170113       Endsr;
046900170113      *-------------------------------------------------------------------------
047000170113       Begsr DisplyS2;
047100170113
047200170113          SflDsp = *on  ;
047300170113          exfmt  LstCtl ;
047400170113          SflDsp = *off;
047500170113
047600170113       Endsr;
