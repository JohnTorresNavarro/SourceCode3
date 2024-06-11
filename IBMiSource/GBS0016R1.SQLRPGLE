000100170313     H DftActGrp(*NO)
000200160428     H Option(*SRCSTMT: *NODEBUGIO: *NOSHOWCPY)
000300160428     H Thread(*SERIALIZE)
000400160428     H BndDir('HSSF')
000500160428      *-------------------------------------------------------------------------
000600160428      *
000700160909      *  Description: Process the Payroll Census Update.
000800160428      *  Programmer.: Brian Rees
000900160909      *  Date.......: 9/09/2016
001000160428      *
001100160909      *   Make sure the headings are in the correct order...
001200160909      *
001300161004      * ?Note:?To Compile, Add POI to the Library List
001400160428      *-------------------------------------------------------------------------
001500160428      * Modifications
001600160428      *
001700160428      * Date         Programmer    Mod      Description
001800160428      *-------------------------------------------------------------------------
001900160428      *
002000160428      *
002100160428      *-------------------------------------------------------------------------
002200170310     Fgbs0016P  o    e             disk
002300170313     FCensusP   o    e             disk
002400170807     FCensusAP  o    e             disk
002500170810     FWebPayrollif   e           k disk
002600170811     fMember    if   e           k Disk    ExtDesc('F.MEMBER') ExtFile(*extdesc)
002700170807      *? Audit File
002800160428      *-------------------------------------------------------------------------
002900160428
003000160428
003100160428      *-------------------------------------------------------------------------
003200160912      /include hssf_h
003300160428
003400160926     D IFSDIR          C                   '/FileUpload'
003500160428
003600160428     D book            s                   like(SSWorkbook)
003700160428     D sheet           s                   like(SSSheet)
003800160428     D row             s                   like(SSRow)
003900160428     D cell            s                   like(SSCell)
004000160509     D TempStr         s                   like(jString)
004100160428     D StrVal          s            100A   varying
004200160428     D NumVal          s              8F
004300160428     D type            s             10I 0
004400161010     d ssn             s              9s 0 inz
004500170316     d HeaderError     s              1
004600161010     d dataError       s              1
004700170313     d Continue        s              1
004800160428
004900160509     d myRow           s             10i 0
005000160428     d myCol           s             10i 0
005100160428     d q               c                   const('''')
005200161010
005300160919     d Column_A        s             30    inz
005400160919     d Column_B        s             30    inz
005500160919     d Column_C        s             30    inz
005600160919     d Column_D        s             30    inz
005700160919     d Column_E        s             30    inz
005800160919     d Column_F        s             30    inz
005900160919     d Column_G        s             30    inz
006000160919     d Column_H        s             30    inz
006100160919     d Column_I        s             30    inz
006200160919     d Column_J        s             30    inz
006300160919     d Column_K        s             30    inz
006400160919     d Column_L        s             30    inz
006500160919     d Column_M        s             30    inz
006600160919     d Column_N        s             30    inz
006700160919     d Column_O        s             30    inz
006800160919     d Column_P        s             30    inz
006900160919     d Column_Q        s             30    inz
007000160919     d Column_R        s             30    inz
007100160919     d Column_S        s             30    inz
007200160919     d Column_T        s             30    inz
007300160919     d Column_U        s             30    inz
007400160919     d Column_V        s             30    inz
007500160919     d Column_W        s             30    inz
007600160919     d Column_X        s             30    inz
007700160919     d Column_Y        s             30    inz
007800160919     d Column_Z        s             30    inz
007900160919     d Column_AA       s             30    inz
008000160919     d Column_AB       s             30    inz
008100160919     d Column_AC       s             30    inz
008200160919     d Column_AD       s             30    inz
008300160919     d Column_AE       s             30    inz
008400160919     d Column_AF       s             30    inz
008500160919     d Column_AG       s             30    inz
008600160919     d Column_AH       s             30    inz
008700160919     d Column_AI       s             30    inz
008800160913
008900160913     d RecordCount     s              5s 0 inz
009000170313     d HoldDate        s             10
009100170313
009200170313     d pCatg           ds
009300170313     d chkName                        1
009400170313     d chkAddr                        1
009500170313     d chkEmail                       1
009600170313     d chkSalary                      1
009700170313     d chkJobt                        1
009800170815
009900170815     d digits          c                   '0123456789.'
010000170313
010100170313
010200160126      *-------------------------------------------------------------------------
010300160428     D/include *LIBL/QMODSRC,#COMMANDPR        //?Command
010400160126
010500160428
010600160126     d #ClnNbr         pr           100a
010700160126     d  inString                    100a   value
010800160126
010900170815     d #hasNumber      pr             1a
011000170815     d  inString                    100a   value
011100170815
011200160509     D uCase           PR          6000
011300160509     D  text                       6000    value
011400170315     D lCase           PR          6000
011500170315     D  text                       6000    value
011600160127
011700170427     D zFill           PR           100
011800170427     D  Len                           3s 0 value
011900170427     D  text                        100    value
012000170427
012100160127     D complain        PR
012200160127     D   msg                        256a   varying const
012300160126
012400160126     D String_getBytes...
012500160126     D                 pr          1024A   varying
012600160126     D                                     extproc(*JAVA:
012700160126     D                                     'java.lang.String':
012800160126     D                                     'getBytes')
012900160509      *-------------------------------------------------------------------------
013000160909
013100160718     d i               s              5i 0
013200160509     d hasMbrDta       s              1a   inz
013300160926     d pFileName       s            128a
013400160127      *------------------------------------------------------------------
013500160127      *?Main Program
013600160127      *------------------------------------------------------------------
013700160505     C     *entry        plist
013800161010     C                   parm                    pTrust            3 0
013900161010     C                   parm                    pSub              3 0
014000161010     C                   parm                    pAcct             4 0
014100170313     C                   parm                    pCatg            20
014200170316     C                   parm                    HeaderError
014300170816     C                   parm                    DataError
014400160126
014500160127
014600160127
014700160126      /free
014800160126
014900170313       Exec Sql  Set Option Commit=*None, Naming=*Sys;
015000170313       Exec Sql  Delete from gbs0016p;
015100170313       Exec Sql  Delete from Censusp;
015200160912
015300170313       pFileName = 'CensusData.xlsx';
015400170313       Continue = 'Y';
015500170313
015600170313       ss_begin_object_group(100);
015700160126
015800170313       //---------------------------------------------------------
015900170313       //?Load an existing spreadsheet into memory
016000170313       //---------------------------------------------------------
016100170313       //  book = ss_open('/home/brees/Luminx Import.xlsx');
016200170313       book = ss_open(IFSDIR + '/' + %Trim(pFileName));
016300170313       if (book = *null);
016400170313          ErrMsg = 'Unable to open ' + %Trim(pFileName);
016500170313          ErrSeq = ErrSeq + 1;
016600170313          Write Error_Rcd;
016700170313          Continue = 'N';
016800170313          *inlr = *on;
016900170313       endif;
017000160126
017100170313       //---------------------------------------------------------
017200170313       //?Open the Correct Sheet
017300170313       //---------------------------------------------------------
017400170313       if Continue = 'Y';
017500170313          sheet = ss_getSheet(book: 'Census');
017600170313          if (sheet = *null);
017700170313             ErrMsg = 'There is no "Census" Tab in the workbook.';
017800170313             ErrSeq = ErrSeq + 1;
017900170313             Write Error_Rcd;
018000170313             Continue = 'N';
018100170313          endif;
018200170313       endif;
018300160126
018400170313       if Continue = 'Y';
018500170313          myRow = 1;
018600160429
018700170313          //---------------------------------------------------------
018800170313          //?We are only reading the top row.
018900170313          //---------------------------------------------------------
019000160909
019100170313          exsr GetRowData;
019200170313          exsr Validate;
019300160909
019400170316          if HeaderError = '';
019500170313          //?Check for Data Errors...
019600170313          ErrMsg = '             --- Data Errors ---  ';
019700170313          ErrSeq = ErrSeq + 1;
019800170313          Write Error_Rcd;
019900160913
020000170313          ErrMsg = *Blanks;
020100170313          RecordCount = 0;
020200170313          dataError = *Blanks;
020300160913
020400170313          Dou myRow = 10000;       //?Large Number. We will leave the loop
020500170313             myRow = myRow + 1;
020600170313             exsr GetRowData;
020700160913
020800170313             if Column_U = *blanks;
020900170313                leave;
021000170313             endif;
021100160913
021200170313             RecordCount = RecordCount + 1;
021300170313             exsr Val_Record;
021400170313             exsr Load_Census;
021500170810             exsr Get_iSeries;
021600170313          Enddo;
021700160913
021800170816          if HeaderError = *Blanks and dataError = *Blanks;
021900170313             ErrMsg = 'No Errors Found';
022000170313             ErrSeq = ErrSeq + 1;
022100170815             Write Error_Rcd;
022200170815          endif;
022300170316          endif;
022400170313       endif;
022500160919
022600170816        // if HeaderError = 'Y' or DataError = 'Y';
022700170816        //   pError = 'Y';
022800170816        // endif;
022900170815
023000170313       //?Close Spread Sheet.
023100170313       ss_end_object_group();
023200160127
023300170313       *inlr = *on;
023400170313       //---------------------------------------------------------
023500170313       Begsr GetRowData;
023600160428
023700170313          //?Get SSN
023800170313          Column_A     = #GetCellValue( Sheet : 1 : myRow );
023900170313          Column_B     = #GetCellValue( Sheet : 2 : myRow );
024000170313          Column_C     = #GetCellValue( Sheet : 3 : myRow );
024100170313          Column_D     = #GetCellValue( Sheet : 4 : myRow );
024200170313          Column_E     = #GetCellValue( Sheet : 5 : myRow );
024300170313          Column_F     = #GetCellValue( Sheet : 6 : myRow );
024400170313          Column_G     = #GetCellValue( Sheet : 7 : myRow );
024500170313          Column_H     = #GetCellValue( Sheet : 8 : myRow );
024600170313          Column_I     = #GetCellValue( Sheet : 9 : myRow );
024700170313          Column_J     = #GetCellValue( Sheet : 10 : myRow );
024800170313          Column_K     = #GetCellValue( Sheet : 11 : myRow );
024900170313          Column_L     = #GetCellValue( Sheet : 12 : myRow );
025000170313          Column_M     = #GetCellValue( Sheet : 13 : myRow );
025100170313          Column_N     = #GetCellValue( Sheet : 14 : myRow );
025200170313          Column_O     = #GetCellValue( Sheet : 15 : myRow );
025300170313          Column_P     = #GetCellValue( Sheet : 16 : myRow );
025400170313          Column_Q     = #GetCellValue( Sheet : 17 : myRow );
025500170313          Column_R     = #GetCellValue( Sheet : 18 : myRow );
025600170313          Column_S     = #GetCellValue( Sheet : 19 : myRow );
025700160428
025800170313          Column_T     = #GetCellValue( Sheet : 20 : myRow );
025900170313          Column_U     = #GetCellValue( Sheet : 21 : myRow );
026000170313          Column_V     = #GetCellValue( Sheet : 22 : myRow );
026100170313          Column_W     = #GetCellValue( Sheet : 23 : myRow );
026200170313          Column_X     = #GetCellValue( Sheet : 24 : myRow );
026300170313          Column_Y     = #GetCellValue( Sheet : 25 : myRow );
026400170313          Column_Z     = #GetCellValue( Sheet : 26 : myRow );
026500170313          Column_AA    = #GetCellValue( Sheet : 27 : myRow );
026600170313          Column_AB    = #GetCellValue( Sheet : 28 : myRow );
026700170313          Column_AC    = #GetCellValue( Sheet : 29 : myRow );
026800160715
026900170313          Column_AD    = #GetCellValue( Sheet : 30 : myRow );
027000170313          Column_AE    = #GetCellValue( Sheet : 31 : myRow );
027100170313          Column_AF    = #GetCellValue( Sheet : 32 : myRow );
027200170313          Column_AG    = #GetCellValue( Sheet : 33 : myRow );
027300170313          Column_AH    = #GetCellValue( Sheet : 34 : myRow );
027400170313          Column_AI    = #GetCellValue( Sheet : 35 : myRow );
027500160909
027600170313       Endsr;
027700170313       //---------------------------------------------------------
027800170313       Begsr Load_Census;
027900170313
028000170313          cuTrst = pTrust;
028100170313          cuSub# = pSub  ;
028200170313          cuAcct = pAcct ;
028300170313          cuSeq  = RecordCount;
028400170807          cFrom  = 'EXCEL';
028500170807
028600170315          cDept#     =  uCase(Column_A);
028700170315          cDeptName  =  uCase(Column_B);
028800170315          cEmpNumber =  uCase(Column_C);
028900170315          cEmpStatus =  uCase(Column_D);
029000170315          cJobTitle  =  uCase(Column_F);
029100170315          cBeneRule# =  uCase(Column_G);
029200170315          cBeneRule  =  uCase(Column_H);
029300170315          cLocCode   =  uCase(Column_I);
029400170315          cLocation  =  uCase(Column_J);
029500170315          cPayStatus =  uCase(Column_K);
029600170315          cPayFreq   =  uCase(Column_L);
029700170315          cLName     =  uCase(Column_M);
029800170315          cFName     =  uCase(Column_N);
029900170315          cMiddleI   =  uCase(Column_O);
030000170315          cAddr1     =  uCase(Column_P);
030100170315          cAddr2     =  uCase(Column_Q);
030200170315          csCity     =  uCase(Column_R);
030300170315          csState    =  uCase(Column_S);
030400170427
030500170815          Column_T   = %ScanRpl('.00':'':Column_T);
030600170315          csZip      =  uCase(Column_T);
030700170427
030800170815          Column_U   = %ScanRpl('.00':'':Column_U);
030900170815          Column_U   = #ClnNbr(Column_U);
031000170427          cSocSec    =  zFill(9: %Trim(Column_U));
031100170427
031200170815          Column_W   = %ScanRpl('.00':'':Column_W);
031300170315          cHours     =  uCase(Column_W);
031400170427
031500170815          Column_X   = %ScanRpl('.00':'':Column_X);
031600170315          cHourRate  =  uCase(Column_X);
031700170427
031800170427            Column_Y = %ScanRpl('.00':'':Column_Y);
031900170315          cSalPerPay =  uCase(Column_Y);
032000170427
032100170427            Column_Z = %ScanRpl('.00':'':Column_Z);
032200170315          cAnnSalary =  uCase(Column_Z);
032300170315          cSalChgDt  =  uCase(Column_AA);
032400170315          cMaritalSt = uCase(Column_AB);
032500170315          cGender    =  uCase(Column_AC);
032600170315          cRace      =  uCase(Column_AD);
032700170315          cEEOC      =  uCase(Column_AE);
032800170315          csPhone    =  uCase(Column_AF);
032900170315          cEmail     =  lCase(Column_AG);
033000170315          cSmoker    =  uCase(Column_AH);
033100170315          cCostCntr  =  uCase(Column_AI);
033200170313
033300170313          //----------------------------------------
033400170313          //?Hire Date
033500170313          //----------------------------------------
033600170315          cHireDate  =  Column_E;
033700170313
033800170315          if %Scan('/' : cHireDate) = 0;
033900170315             cHireDate     = #GetDateValue( Sheet : 5 : myRow );
034000170313          else;
034100170315             HoldDate = %Trim(cHireDate);
034200170313             Test(de) *Usa HoldDate;
034300170313             if not %Error;
034400170315                cHireDate = %Char(%Dec( %Date( HoldDate:*usa)));
034500170313             endif;
034600170313          endif;
034700170313
034800170810          if cHireDate = '18991231';
034900170810             cHireDate = *Blanks;
035000170810          endif;
035100170810
035200170313          //----------------------------------------
035300170313          //?Birth Date
035400170313          //----------------------------------------
035500170315          cBDate     =  Column_V;
035600170315          if %Scan('/' : cbDate) = 0;
035700170315             cbDate     = #GetDateValue( Sheet : 22 : myRow );
035800170313          else;
035900170315             HoldDate = %Trim(cbDate);
036000170313             Test(de) *Usa holdDate;
036100170313             if not %Error;
036200170315                cbDate  = %Char(%Dec( %Date( HoldDate:*usa)));
036300170313             endif;
036400170313          endif;
036500170313
036600170810
036700170810          if cbDate = '18991231';
036800170810             cbDate = *Blanks;
036900170810          endif;
037000170313
037100170313          //----------------------------------------
037200170313          //?Salary Change Date
037300170313          //----------------------------------------
037400170315          cSalChgDt  =  Column_AA;
037500170315          if %Scan('/' : cSalChgDt) = 0;
037600170315             cSalChgDt     = #GetDateValue( Sheet : 27 : myRow );
037700170313          else;
037800170315             HoldDate = %Trim(cSalChgDt);
037900170313             Test(de) *Usa HoldDate;
038000170313             if not %Error;
038100170315                cSalChgDt  = %Char(%Dec( %Date( HoldDate:*usa)));
038200170313             endif;
038300170313          endif;
038400170810
038500170810          if cSalChgDt = '18991231';
038600170810             cSalChgDt = *Blanks;
038700170810          endif;
038800170313
038900170807
039000170313
039100170313          Write Census_r;
039200170807          Write Audit_r;
039300170313
039400170810
039500170313       Endsr;
039600170313       //---------------------------------------------------------
039700170313       Begsr Val_record;
039800160913
039900170313
040000170313          //?SSN
040100170313          if Column_U = *Blanks;
040200170313             ErrMsg = 'Row: ' + %Char( myRow) +
040300170313                  ': Social Security Number is Missing.';
040400170313             ErrSeq = ErrSeq + 1;
040500170313             Write Error_Rcd;
040600170313          else;
040700170313             Column_U = %ScanRpl('-':'':Column_U);
040800170313             ssn      = %Dec(Column_U : 9 : 0);
040900170313          endif;
041000170313
041100170313
041200170313          //?Validate based on Categories...
041300170313          //?---------  Name  -------------
041400170313          if chkName = 'Y';
041500170313             //?Last Name
041600170313             if Column_M = *Blanks;
041700170313                ErrMsg = 'Row: ' + %Char( myRow) +
041800170313                     ': Last Name is Missing.';
041900170313                ErrSeq = ErrSeq + 1;
042000170313                Write Error_Rcd;
042100170815             else;
042200170815
042300170815                if #hasNumber( Column_M ) = 'Y';
042400170815                   ErrMsg = 'Row: ' + %Char( myRow) +
042500170816                        ': Numeric values have been found in the Last Name';
042600170815                   ErrSeq = ErrSeq + 1;
042700170815                   Write Error_Rcd;
042800170815                Endif;
042900170815             endif;
043000170815
043100170815
043200170313
043300170313             //?First Name
043400170313             if Column_N = *Blanks;
043500170313                ErrMsg = 'Row: ' + %Char( myRow) +
043600170313                     ': First Name is Missing.';
043700170313                ErrSeq = ErrSeq + 1;
043800170313                Write Error_Rcd;
043900170815             else;
044000170815                if #hasNumber( Column_N ) = 'Y';
044100170815                   ErrMsg = 'Row: ' + %Char( myRow) +
044200170816                        ': Numeric values have been found in the First Name';
044300170815                   ErrSeq = ErrSeq + 1;
044400170815                   Write Error_Rcd;
044500170815                Endif;
044600170815             endif;
044700170313
044800170815
044900170815             //?Middle Initial
045000170815             if #hasNumber( Column_O ) = 'Y';
045100170815                ErrMsg = 'Row: ' + %Char( myRow) +
045200170816                        ': Numeric values have been found in the Middle Name';
045300170815                ErrSeq = ErrSeq + 1;
045400170815                Write Error_Rcd;
045500170815             Endif;
045600170815          endif;
045700170313
045800170313          //?--------- Address ------------
045900170313          if chkAddr = 'Y';
046000170815
046100170815             //?City
046200170816             if #hasNumber( Column_R ) = 'Y';
046300170815                ErrMsg = 'Row: ' + %Char( myRow) +
046400170816                        ': Numeric values have been found in the City';
046500170815                ErrSeq = ErrSeq + 1;
046600170815                Write Error_Rcd;
046700170815             Endif;
046800170815
046900170815             //?State
047000170816             if #hasNumber( Column_S ) = 'Y';
047100170815                ErrMsg = 'Row: ' + %Char( myRow) +
047200170816                        ': Numeric values have been found in the State';
047300170815                ErrSeq = ErrSeq + 1;
047400170815                Write Error_Rcd;
047500170815             Endif;
047600170313          endif;
047700170313
047800170313
047900170313
048000170313          //?---------  Email  ------------
048100170313          if chkEmail = 'Y';
048200170313
048300170313
048400170313
048500170313          endif;
048600170313
048700170313
048800170313          //?--------- Salary  ------------
048900170313          if chkSalary = 'Y';
049000170313
049100170313             //?Salary..
049200170313             if Column_Z = *Blanks;
049300170313                ErrMsg = 'Row: ' + %Char( myRow) +
049400170313                     ': Salary is Missing.';
049500170313                ErrSeq = ErrSeq + 1;
049600170313                Write Error_Rcd;
049700170313             endif;
049800170313
049900170313          endif;
050000170313
050100170313
050200170313
050300170313          //?--------- Job Title ----------
050400170313          if chkJobt = 'Y';
050500170313
050600170313             //?Salary..
050700170313             if Column_F = *Blanks;
050800170313                ErrMsg = 'Row: ' + %Char( myRow) +
050900170313                     ': Job Title is missing.';
051000170313                ErrSeq = ErrSeq + 1;
051100170313                Write Error_Rcd;
051200170313             endif;
051300170313
051400170313          endif;
051500170313
051600160919
051700170313          if ErrMsg > *Blanks;
051800170313             dataError = 'Y';
051900170313          endif;
052000161010
052100170313       Endsr;
052200170313       //---------------------------------------------------------
052300170313       Begsr Validate;
052400160912
052500170313          ErrMsg = *blanks;
052600170313          ErrSeq = 0;
052700170316          HeaderError = *blanks;
052800160912
052900170313          if %Scan('Department' : Column_A) = 0;
053000170313             ErrMsg = 'Department # was not found in Column A';
053100170313             ErrSeq = ErrSeq + 1;
053200170313             Write Error_Rcd;
053300170313          endif;
053400160909
053500170313          if %Scan('Department Name' : Column_B) = 0;
053600170313             ErrMsg = 'Department Name was not found in Column B';
053700170313             ErrSeq = ErrSeq + 1;
053800170313             Write Error_Rcd;
053900170313          endif;
054000160912
054100170313          if %Scan('Employee No' : Column_C) = 0;
054200170313             ErrMsg = 'Employee No was not found in Column C';
054300170313             ErrSeq = ErrSeq + 1;
054400170313             Write Error_Rcd;
054500170313          endif;
054600160912
054700170313          if %Scan('Employee Status' : Column_D) = 0;
054800170313             ErrMsg = 'Employee Status was not found in Column D';
054900170313             ErrSeq = ErrSeq + 1;
055000170313             Write Error_Rcd;
055100170313          endif;
055200160912
055300170313          if %Scan('Hire Date' : Column_E) = 0;
055400170313             ErrMsg = 'Hire Date was not found in Column E';
055500170313             ErrSeq = ErrSeq + 1;
055600170313             Write Error_Rcd;
055700170313          endif;
055800160912
055900170313          if %Scan('Job Title/Occupation' : Column_F) = 0;
056000170313             ErrMsg = 'Job Title/Occupation was not found in Column F';
056100170313             ErrSeq = ErrSeq + 1;
056200170313             Write Error_Rcd;
056300170313          endif;
056400160912
056500170313          if %Scan('Benefit Package Rule' : Column_G) = 0;
056600170313             ErrMsg = 'Benefit Package Rule # was not found in Column G';
056700170313             ErrSeq = ErrSeq + 1;
056800170313             Write Error_Rcd;
056900170313          endif;
057000160912
057100170313          if %Scan('Benefit Package Rule' : Column_H) = 0;
057200170313             ErrMsg = 'Benefit Package Rule was not found in Column H';
057300170313             ErrSeq = ErrSeq + 1;
057400170313             Write Error_Rcd;
057500170313          endif;
057600160912
057700170313          if %Scan('Location Code' : Column_I) = 0;
057800170313             ErrMsg = 'Location Code was not found in Column I';
057900170313             ErrSeq = ErrSeq + 1;
058000170313             Write Error_Rcd;
058100170313          endif;
058200160912
058300170313          if %Scan('Location (Complete' : Column_J) = 0;
058400170313             ErrMsg = 'Location was not found in Column J';
058500170313             ErrSeq = ErrSeq + 1;
058600170313             Write Error_Rcd;
058700170313          endif;
058800160912
058900170313          if %Scan('Payroll Status' : Column_K) = 0;
059000170313             ErrMsg = 'Payroll Status was not found in Column K';
059100170313             ErrSeq = ErrSeq + 1;
059200170313             Write Error_Rcd;
059300170313          endif;
059400160912
059500170313          if %Scan('Pay Frequency' : Column_L) = 0;
059600170313             ErrMsg = 'Pay Frequency was not found in Column L';
059700170313             ErrSeq = ErrSeq + 1;
059800170313             Write Error_Rcd;
059900170313          endif;
060000160912
060100170313          if %Scan('Last Name' : Column_M) = 0;
060200170313             ErrMsg = 'Last Name was not found in Column M';
060300170313             ErrSeq = ErrSeq + 1;
060400170313             Write Error_Rcd;
060500170313          endif;
060600160912
060700170313          if %Scan('First Name' : Column_N) = 0;
060800170313             ErrMsg = 'First Name was not found in Column N';
060900170313             ErrSeq = ErrSeq + 1;
061000170313             Write Error_Rcd;
061100170313          endif;
061200160912
061300170313          if %Scan('Middle Initial' : Column_O) = 0;
061400170313             ErrMsg = 'Middle Initial was not found in Column O';
061500170313             ErrSeq = ErrSeq + 1;
061600170313             Write Error_Rcd;
061700170313          endif;
061800160912
061900170313          if %Scan('PrimaryAddress' : Column_P) = 0;
062000170313             ErrMsg = 'PrimaryAddress was not found in Column P';
062100170313             ErrSeq = ErrSeq + 1;
062200170313             Write Error_Rcd;
062300170313          endif;
062400160912
062500170313          if %Scan('SecondaryAddress'  : Column_Q) = 0;
062600170313             ErrMsg = 'SecondaryAddress was not found in Column Q';
062700170313             ErrSeq = ErrSeq + 1;
062800170313             Write Error_Rcd;
062900170313          endif;
063000160912
063100170313          if %Scan('City'  : Column_R) = 0;
063200170313             ErrMsg = 'City was not found in Column R';
063300170313             ErrSeq = ErrSeq + 1;
063400170313             Write Error_Rcd;
063500170313          endif;
063600160912
063700170313          if %Scan('State'  : Column_S) = 0;
063800170313             ErrMsg = 'State was not found in Column S';
063900170313             ErrSeq = ErrSeq + 1;
064000170313             Write Error_Rcd;
064100170313          endif;
064200160912
064300170313          if %Scan('Zip Code'  : Column_T) = 0;
064400170313             ErrMsg = 'Zip Code was not found in Column T';
064500170313             ErrSeq = ErrSeq + 1;
064600170313             Write Error_Rcd;
064700170313          endif;
064800160912
064900170313          if %Scan('Social Security'  : Column_U) = 0;
065000170313             ErrMsg = 'Social Security was not found in Column U';
065100170313             ErrSeq = ErrSeq + 1;
065200170313             Write Error_Rcd;
065300170313          endif;
065400160912
065500170313          if %Scan('Birth Date'  : Column_V) = 0;
065600170313             ErrMsg = 'Birth Date was not found in Column V';
065700170313             ErrSeq = ErrSeq + 1;
065800170313             Write Error_Rcd;
065900170313          endif;
066000160912
066100170313          if %Scan('Hours Worked'  : Column_W) = 0;
066200170313             ErrMsg = 'Hours Worked was not found in Column W';
066300170313             ErrSeq = ErrSeq + 1;
066400170313             Write Error_Rcd;
066500170313          endif;
066600160912
066700170313          if %Scan('Hourly Rate'  : Column_X) = 0;
066800170313             ErrMsg = 'Hourly Rate was not found in Column X';
066900170313             ErrSeq = ErrSeq + 1;
067000170313             Write Error_Rcd;
067100170313          endif;
067200160912
067300170313          if %Scan('Salary Per Pay'  : Column_Y) = 0;
067400170313             ErrMsg = 'Salary Per Pay was not found in Column Y';
067500170313             ErrSeq = ErrSeq + 1;
067600170313             Write Error_Rcd;
067700170313          endif;
067800160912
067900170313          if %Scan('Annual Salary'  : Column_Z) = 0;
068000170313             ErrMsg = 'Annual Salary was not found in Column Z';
068100170313             ErrSeq = ErrSeq + 1;
068200170313             Write Error_Rcd;
068300170313          endif;
068400160912
068500170313          if %Scan('Salary Change Date'  : Column_AA) = 0;
068600170313             ErrMsg = 'Salary Change Date was not found in Column AA';
068700170313             ErrSeq = ErrSeq + 1;
068800170313             Write Error_Rcd;
068900170313          endif;
069000160912
069100170313          if %Scan('Marital Status'  : Column_AB) = 0;
069200170313             ErrMsg = 'Marital Status was not found in Column AB';
069300170313             ErrSeq = ErrSeq + 1;
069400170313             Write Error_Rcd;
069500170313          endif;
069600160912
069700170313          if %Scan('Gender'  : Column_AC) = 0;
069800170313             ErrMsg = 'Gender was not found in Column AC';
069900170313             ErrSeq = ErrSeq + 1;
070000170313             Write Error_Rcd;
070100170313          endif;
070200160912
070300170313          if %Scan('Race'  : Column_AD) = 0;
070400170313             ErrMsg = 'Race was not found in Column AD';
070500170313             ErrSeq = ErrSeq + 1;
070600170313             Write Error_Rcd;
070700170313          endif;
070800160912
070900170313          if %Scan('EEOC Code'  : Column_AE) = 0;
071000170313             ErrMsg = 'EEOC Code was not found in Column AE';
071100170313             ErrSeq = ErrSeq + 1;
071200170313             Write Error_Rcd;
071300170313          endif;
071400160912
071500170313          if %Scan('Area Code'  : Column_AF) = 0;
071600170313             ErrMsg = 'Area Code and Phone Number was not found in Column AF';
071700170313             ErrSeq = ErrSeq + 1;
071800170313             Write Error_Rcd;
071900170313          endif;
072000160912
072100170313          if %Scan('Email Address'  : Column_AG) = 0;
072200170313             ErrMsg = 'Email Address was not found in Column AG';
072300170313             ErrSeq = ErrSeq + 1;
072400170313             Write Error_Rcd;
072500170313          endif;
072600160912
072700170313          if %Scan('Smoker'  : Column_AH) = 0;
072800170313             ErrMsg = 'Smoker was not found in Column AH';
072900170313             ErrSeq = ErrSeq + 1;
073000170313             Write Error_Rcd;
073100170313          endif;
073200160912
073300170313          if %Scan('Cost Center'  : Column_AI) = 0;
073400170313             ErrMsg = 'Cost Center was not found in Column AI';
073500170313             ErrSeq = ErrSeq + 1;
073600170313             Write Error_Rcd;
073700170313          endif;
073800160912
073900170313          if ErrMsg > *Blanks;
074000170316             HeaderError = 'Y';
074100170313          endif;
074200160912
074300160912
074400170313       Endsr;
074500170810
074600170810       //---------------------------------------------------------
074700170810       Begsr Get_iSeries;
074800170810
074900170811          chain ssn Member;
075000170810
075100170810          cFrom = 'iSeries';
075200170810          cSocSec = %Char(ssn);
075300170810
075400170811          if not %Found(Member);
075500170810             cDept# = 'SSN Not Found on iSeries';
075600170810             Write Audit_r;
075700170810             leavesr;
075800170810          endif;
075900170810
076000170810          // Write the data...
076100170811          cLName = mlname;
076200170811          cFName = mfname;
076300170811          cMiddlei = mmi;
076400170811          cAddr1 = addr1;
076500170811          cAddr2 = addr2;
076600170811          csCity = city;
076700170811          csState = state;
076800170811          csZip = %Char(zip);
076900170811          cbDate = %Char(Birth);
077000170811          cAnnSalary = %Char(Salary);
077100170811          cGender = sex;
077200170811          csPhone = %Char(phone);
077300170811          cemail = Fill66;
077400170810
077500170810          write Audit_r;
077600170810
077700170810
077800170810       Endsr;
077900170810
078000160126      *-----------------------------------------------------------
078100160126     p #ClnNbr         b                   export
078200160126
078300160126     d #ClnNbr         pi           100a
078400160126     d  inString                    100a   value
078500160126
078600160126     d i               s              3s 0
078700160126     d digits          c                   '0123456789.'
078800160126     d TestChar        s              1
078900160126     d StringOut       s            100
079000160126
079100160126
079200160126
079300170313       for i = 1 to %Len(%Trim(inString));
079400170313          testChar = %SubSt(inString : i : 1);
079500170313          if %Check(Digits : testChar) = 0;
079600170313             StringOut = %Trim(StringOut) + testChar;
079700170313          endif;
079800170313       endfor;
079900160126
080000170313       Return StringOut;
080100160126
080200160126
080300160126     p #ClnNbr         e
080400160126
080500170815      *-----------------------------------------------------------
080600170815     p #HasNumber      b                   export
080700170815
080800170815     d #HasNumber      pi             1a
080900170815     d  inString                    100a   value
081000170815
081100170815     d i               s              3s 0
081200170815     d digits          c                   '0123456789.'
081300170815     d TestChar        s              1
081400170815     d StringOut       s              1
081500170815     d pos             s              3s 0
081600170815
081700170815
081800170815
081900170815       for i = 1 to %Len(%Trim(inString));
082000170815          testChar = %SubSt(inString : i : 1);
082100170815
082200170815          //?if pos = 0 then a number was found..
082300170815          pos = %Check(Digits : testChar);
082400170815
082500170815          if Pos = 0;
082600170815             StringOut = 'Y';
082700170815          endif;
082800170815       endfor;
082900170815
083000170815       Return StringOut;
083100170815
083200170815
083300170815     p #HasNumber      e
083400170815
083500160126      *----------------------------------------------------------------
083600160126      * Upper Case Function
083700160126      *----------------------------------------------------------------
083800160126     P uCase           B                   export
083900160509     D uCase           PI          6000
084000160509     D   Text                      6000    value
084100160126     D up              c                   CONST('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
084200160126     D lo              c                   CONST('abcdefghijklmnopqrstuvwxyz')
084300160509     D ReturnText      s           6000
084400160126     C                   eval      ReturnText = %xlate(lo:up:Text)
084500160126     C                   Return    ReturnText
084600160126     P                 E
084700160126
084800170315      *----------------------------------------------------------------
084900170315      * Lower Case Function
085000170315      *----------------------------------------------------------------
085100170315     P lCase           B                   export
085200170315     D lCase           PI          6000
085300170315     D   Text                      6000    value
085400170315     D up              c                   CONST('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
085500170315     D lo              c                   CONST('abcdefghijklmnopqrstuvwxyz')
085600170315     D ReturnText      s           6000
085700170315     C                   eval      ReturnText = %xlate(up:lo:Text)
085800170315     C                   Return    ReturnText
085900170315     P                 E
086000170315
086100160126      *----------------------------------------------------------------
086200160126      * Excell -> Date
086300160126      *----------------------------------------------------------------
086400160126     P xls2date        B                   export
086500160126     D xls2date        PI            50
086600160126     D   peXls                        8F   value
086700160126     D
086800160126     D wwStrDate       s               d   inz(d'1900-01-01')
086900160126     D wwDate          s               d
087000160126     d CDate           s             10
087100160126
087200160126      /free
087300170313       wwDate = wwStrDate + %days(%int(peXls) - 1);
087400160126
087500170313       //?Excel incorrectly thinks that 1900-02-29 is
087600170313       //?a valid date.
087700170313       if (wwDate > d'1900-02-28');
087800160126          wwDate = wwDate - %days(1);
087900170313       endif;
088000160126
088100170313       cDate = %Char(wwDate:*iso);
088200170313       cDate = %ScanRpl('-' : '' : cDate);
088300170313       return cDate;
088400160126      /end-free
088500160126     P                 E
088600160126
088700160127
088800160127     P complain        B
088900160127     D complain        PI
089000160127     D   msg                        256a   varying const
089100160127
089200160127     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
089300160127     D   MessageID                    7A   Const
089400160127     D   QualMsgF                    20A   Const
089500160127     D   MsgData                    256A   Const options(*varsize)
089600160127     D   MsgDtaLen                   10I 0 Const
089700160127     D   MsgType                     10A   Const
089800160127     D   CallStkEnt                  10A   Const
089900160127     D   CallStkCnt                  10I 0 Const
090000160127     D   MessageKey                   4A
090100160127     D   ErrorCode                 8192A   options(*varsize)
090200160127
090300160127     D ErrorCode       DS                  qualified
090400160127     D  BytesProv                    10I 0 inz(0)
090500160127     D  BytesAvail                   10I 0 inz(0)
090600160127
090700160127     D MsgKey          S              4A
090800160127
090900160127      /free
091000160127
091100170313       QMHSNDPM( 'CPF9897'
091200170313               : 'QCPFMSG   *LIBL'
091300170313               : msg
091400170313               : %len(msg)
091500170313               : '*ESCAPE'
091600170313               : '*PGMBDY'
091700170313               : 1
091800170313               : MsgKey
091900170313               : ErrorCode         );
092000160127
092100160127      /end-free
092200160127     P                 E
092300160429      *-----------------------------------------------------------
092400160429     p #GetCellValue   b                   export
092500160429
092600160429     d #GetCellValue   pi           100a
092700160429     d  inSheet                            like(SSSheet)
092800160429     d  inCol                        10i 0 value
092900160429     d  inRow                        10i 0 value
093000160429
093100160429     D book            s                   like(SSWorkbook)
093200160429     D sheet           s                   like(SSSheet)
093300160429     D row             s                   like(SSRow)
093400160429     D cell            s                   like(SSCell)
093500160429     D TempStr         s                   like(jString)
093600160429     D hasError        s              1a
093700160509     D NumVal          s              8F
093800160429
093900160912      /include hssf_h
094000160429
094100170313       hasError = 'N';
094200170313       strVal = *Blanks;
094300160429
094400170313       row = SSSheet_getRow(inSheet: inRow - 1);
094500170313       if (row = *null);
094600170313          strVal = *Blanks;
094700170313          hasError = 'Y';
094800170313       endif;
094900160505
095000160505
095100170313       if hasError = 'N';
095200170313          cell = SSRow_GetCell(row: inCol - 1);
095300170313       endif;
095400160505
095500160505
095600170313       if (cell = *null);
095700170313          strVal = *Blanks;
095800170313          hasError = 'Y';
095900170313       endif;
096000160429
096100160429
096200170313       if hasError = 'N';
096300170313          type = SSCell_getCellType(cell);
096400160429
096500170313          select;
096600170313          when type = CELL_TYPE_STRING;
096700170313             StrVal = String_getBytes(SSCell_getStringCellValue(cell));
096800170313          when type = CELL_TYPE_FORMULA;
096900170313             StrVal = String_getBytes(SSCell_getCellFormula(cell));
097000170313          when type = CELL_TYPE_NUMERIC;
097100170313             NumVal = SSCell_getNumericCellValue(cell);
097200170313             StrVal = %char(%dech(NumVal:15:2));
097300170313          endsl;
097400170313       endif;
097500160429
097600170313       StrVal = %ScanRpl('#' : '' : StrVal);
097700170313       Return StrVal;
097800160429
097900160429     p #GetCellValue   e
098000160429
098100160429
098200160509      *-----------------------------------------------------------
098300160509     p #GetDateValue   b                   export
098400160509
098500160509     d #GetDateValue   pi           100a
098600160509     d  inSheet                            like(SSSheet)
098700160509     d  inCol                        10i 0 value
098800160509     d  inRow                        10i 0 value
098900160509
099000160509     D book            s                   like(SSWorkbook)
099100160509     D sheet           s                   like(SSSheet)
099200160509     D row             s                   like(SSRow)
099300160509     D cell            s                   like(SSCell)
099400160509     D TempStr         s                   like(jString)
099500160509     D hasError        s              1a
099600160509     D NumVal          s              8F
099700160509
099800160912      /include hssf_h
099900160509
100000170313       hasError = 'N';
100100170313       strVal = *Blanks;
100200160509
100300170313       row = SSSheet_getRow(inSheet: inRow - 1);
100400170313       if (row = *null);
100500170313          strVal = *Blanks;
100600170313          hasError = 'Y';
100700170313       endif;
100800160509
100900160509
101000170313       if hasError = 'N';
101100170313          cell = SSRow_GetCell(row: inCol - 1);
101200170313       endif;
101300160509
101400160509
101500170313       if (cell = *null);
101600170313          strVal = *Blanks;
101700170313          hasError = 'Y';
101800170313       endif;
101900160509
102000160509
102100170313       if hasError = 'N';
102200170313          NumVal = SSCell_getNumericCellValue(cell);
102300170313          StrVal = xls2Date(NumVal);
102400170313       endif;
102500160509
102600170313       Return StrVal;
102700160509
102800160509     p #GetDateValue   e
102900160509
103000170427
103100170427
103200170427      *----------------------------------------------------------------
103300170427      * zFill Function
103400170427      *----------------------------------------------------------------
103500170427     P zFill           B                   export
103600170427     D Zfill           PI           100
103700170427     D   Len                          3S 0 value
103800170427     D   Text                       100    value
103900170427     D
104000170427     D ReturnText      s            100
104100170427     D Diff            s              3s 0
104200170427     D i               s              3s 0
104300170427     C
104400170427     C                   eval      Diff = Len - %Len(%Trim(Text))
104500170427     C                   for       i = 1 to Diff
104600170427     C                   eval      ReturnText = %Trim(ReturnText) + '0'
104700170427     C                   endfor
104800170427     C
104900170427     C                   eval      ReturnText = %Trim(ReturnText) +
105000170427     C                              %Trim(Text)
105100170427     C
105200170427     C                   Return    ReturnText
105300170427     P zFill           E
105400170427
105500170427
