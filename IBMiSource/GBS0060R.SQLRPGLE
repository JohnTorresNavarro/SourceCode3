000100170925     H DftActGrp(*NO) bnddir('GBSBIND')
000200160428     H Option(*SRCSTMT: *NODEBUGIO: *NOSHOWCPY)
000300160428      *-------------------------------------------------------------------------
000400160428      *
000500170922      *  Description: Load F.Member
000600160428      *  Programmer.: Brian Rees
000700200113      *  Date.......: 1/13/2020
000800170313      *
000900200113      *  Copied from GBS0026R
001000200113      *
001100200113      *  Notes: This program will read through the GBS 2.0 Input file and populate
001200170927      *         a data structure which will be used to update F.Member and F.Depend
001300170925      *
001400160428      *-------------------------------------------------------------------------
001500160428      * Modifications
001600160428      *
001700170427      * Date         Programmer    Mod      Description
001800210429      * 04/29/2021   B.Rees                 removal of Special Characters
001900210429      *                                     in the name and addr
002000211020      * 10/20/2021   B.Rees                 Added Email to the Auto Upload
002001230814      * 08/14/2023   RLJ                    Added code to determine the GBS
002002230814      *                                     Cost Center.
002100160428      *-------------------------------------------------------------------------
002200200120
002300200120       dcl-f GBS20l1 keyed usropn;
002400201216       dcl-f GBS20l2 keyed usropn Rename(R_GBS20P : Rcd_2);
002500201216       dcl-f GBS20l3 keyed usropn Rename(R_GBS20P : Rcd_3);
002600201216       dcl-f GBS20l4 keyed usropn Rename(R_GBS20P : Rcd_4);
002700200120
002800200120       dcl-f cfs100p keyed usage(*Input:*output:*update);
002801230814       dcl-f ccntrxrefp keyed;
002900200120
003000160428      *-------------------------------------------------------------------------
003100170315
003200200113
003300200120     d Member_data   e ds                  extName('F.MEMBER')
003400200120     d Depend_data   e ds                  extName('F.DEPEND')
003500200120     d xFill03       e                     extfld(FILL03)
003600200120
003700200120       dcl-s wSSN Zoned(9);
003800200120       dcl-s wArea Char(3);
003900200120       dcl-s wPhone Char(7);
004000200120       dcl-s wDate Char(8);
004100200113
004200200113       dcl-s DepSeq#  Zoned(2);
004300200120       dcl-s wDep_SSN  Zoned(9);
004400170925
004500201216       dcl-s PlanCount Zoned(3);
004600201216
004700170925      *--------------------------------------------
004800200120      * Procedures
004900170925      *--------------------------------------------
005000170925     D/COPY *LIBL/QMODSRC,PR0001RPR            // Case Functions
005100210505     D/COPY *LIBL/QMODSRC,#EdtStngPR           // Edit String
005200170925
005300170925     d WriteMember     pr                  ExtPgm('GBS0024R')
005400170925     d   @Member_Data               648
005500170925
005600170925     d WriteDepend     pr                  ExtPgm('GBS0024R1')
005700170925     d   @Depend_Data               360
005800170925
005900200120
006000200120
006100200120      *-------------------------------------------------------------------------
006200200120      *
006300200120      * *Entry Procedure
006400200120      *
006500200120      *-------------------------------------------------------------------------
006600200120       Dcl-pr Main ExtPgm;
006700200120         *N  Char(10);
006800200120       End-Pr;
006900200120
007000200120       dcl-pi Main;
007100200120         i_TSA Char(10);
007200200120       End-Pi;
007300200120
007400200120
007500200120
007600160127      *------------------------------------------------------------------
007700200120      *
007800200120      * Main Program
007900200120      *
008000160127      *------------------------------------------------------------------
008100170427
008200200113       open GBS20l1   ;
008300201216       open GBS20l2   ;
008400200113       open GBS20l3   ;
008500201216       open GBS20l4   ;
008600191205
008700200106       //?Process Members & Dependents
008800200106       exsr Proc_Members;
008900200106       exsr Proc_Depends;
009000170925
009100200113       Close GBS20l1   ;
009200201216       Close GBS20l2   ;
009300201216       Close GBS20l3   ;
009400201216       Close GBS20l4   ;
009500170927
009600200106       *inlr = *on;
009700170927
009800170927      *------------------------------------------------------------------
009900170927      *?Process Members
010000170927      *------------------------------------------------------------------
010100200106       Begsr Proc_Members;
010200170927
010300200120         Setll *loval GBS20l1   ;
010400200120         dow not %Eof( GBS20l1    );
010500200120           read GBS20l1   ;
010600170927
010700200120           if %Eof( GBS20l1    );
010800200120             leave;
010900200120           endif;
011000170927
011100200106
011200200120           wSsn = %Dec( l1_ssn : 9 : 0 );
011300170925
011400200120           Clear Member_Data;
011500200106
011600210429
011700210429br02       l1_FName = EdtString(l1_FName:'NAME');
011800210429br02       l1_LName = EdtString(l1_LName:'NAME');
011900210429br02       l1_Addr1 = EdtString(l1_Addr1:'ADDR');
012000210429br02       l1_Addr2 = EdtString(l1_Addr2:'ADDR');
012100210429           l1_City  = EdtString(l1_City:'NAME');
012200210429           l1_State = EdtString(l1_State:'NAME');
012201211020
012300210429
012400200120           Exsr Load_Member;
012500200120           if l1_Termdt > '';
012600200120             iter;
012700200120           endif;
012800201204
012900201204
013000200120           WriteMember( Member_data );
013100200113
013200200113
013300200120           // Update Long Name
013400200120           if %len(%trim( l1_Fname )) > 12 or
013500200120              %len(%Trim( l1_lname )) > 18;
013600200113
013700200120             DepSeq# = 0;
013800200120             chain ( wSsn : DepSeq# ) Cfs100p;
013900200120             if %Found( Cfs100p );
014000200120               cfsfst = l1_fname;
014100200120               cfsmid = l1_mi;
014200200120               cfslst = l1_lname;
014300200113
014400200120               Update cfs100r;
014500200120             else;
014600200120               cfssn = wssn;
014700200120               cfseq = DepSeq#;
014800200120               cfsfst = l1_fname;
014900200120               cfsmid = l1_mi;
015000200120               cfslst = l1_lname;
015100200113
015200200120               write cfs100r;
015300200120             EndIf;
015400200113
015500200113
015600200120           EndIf;
015700200113
015800200113
015900200113
016000170925
016100200120         enddo;
016200170925
016300200106       Endsr;
016400170927
016500170927      *------------------------------------------------------------------
016600170927      *?Process Dependents
016700170927      *------------------------------------------------------------------
016800200106       Begsr Proc_Depends;
016900170927
017000200120         Setll *loval GBS20l3   ;
017100200120         dow not %Eof( GBS20l3    );
017200200120           read GBS20l3   ;
017300170927
017400200120           if %Eof( GBS20l3    );
017500200120             leave;
017600200120           endif;
017700170927
017800200120           wSsn = %Dec( l3_PartSSN : 9 : 0 );
017900200205           if l3_depssn = '';
018000200205             l3_depssn = '0';
018100200205           EndIf;
018200200205
018300200120           wDep_Ssn = %Dec( L3_DEPSSN : 9 : 0 );
018400170927
018500200120
018600200120           Clear Depend_Data;
018700200106
018800210429br02       l3_FName = EdtString(l3_FName:'NAME');
018900210429br02       l3_LName = EdtString(l3_LName:'NAME');
019000210429br02       l3_Addr1 = EdtString(l3_Addr1:'ADDR');
019100210429br02       l3_Addr2 = EdtString(l3_Addr2:'ADDR');
019200210429           l3_City  = EdtString(l3_City:'NAME');
019300210429           l3_State = EdtString(l3_State:'NAME');
019400210429
019500210429
019600200120           //?Load the Dependent
019700200120           Exsr Load_Depend;
019800200120           WriteDepend( Depend_data );
019900200113
020000200113
020100200120           // Update Long Name
020200200120           if %len(%trim( l3_Fname )) > 12 or
020300200120              %len(%Trim( l3_lname )) > 18;
020400200113
020500200120             DepSeq# = 0;
020600200113
020700200120             // Get Dependent Sequence Number.
020800200120             if wDep_ssn > 0;
020900201216               Exec Sql
021000201216                 Select dpSeq#
021100201216                   into :DepSeq#
021200201216                   FROM "F.DEPEND"
021300201216                   Where dssno = :wSSN and
021400201216                         Depss# = :wDep_ssn;
021500200120             endif;
021600200113
021700200113
021800200120             //?Check by Last Name...
021900211021             if DepSeq# > 0;
022000200113
022100200120               chain ( wSsn : DepSeq# ) Cfs100p;
022200200120               if %Found( Cfs100p );
022300200120                 cfsfst = l3_fname;
022400200120                 cfsmid = l3_mi;
022500200120                 cfslst = l3_lname;
022600200113
022700200120                 Update cfs100r;
022800200120               else;
022900200120                 cfssn = wssn;
023000200120                 cfseq = DepSeq#;
023100200120                 cfsfst = l3_fname;
023200200120                 cfsmid = l3_mi;
023300200120                 cfslst = l3_lname;
023400200113
023500200120                 write cfs100r;
023600200120               endif;
023700200120             endif;
023800200120           endif;
023900200120         enddo;
024000170927
024100200106       Endsr;
024200200120
024300200120
024400170925      *------------------------------------------------------------------
024500200120      *
024600200120      * Load Member
024700200120      *
024800170925      *------------------------------------------------------------------
024900200106       Begsr Load_Member;
025000170925
025100201216
025200200120         //?Defaults
025300200120         mbTrst = %Dec( %Subst( i_TSA : 1 : 3) : 3 : 0 );
025400200120         mbSub# = %Dec( %Subst( i_TSA : 4 : 3) : 3 : 0 );
025500200120         mbAcct = %Dec( %Subst( i_TSA : 7 : 4) : 4 : 0 );
025600170926
025700200120         Cob = 'N';
025800200120         medicr = 'N';
025900200120         Cobbcf = 'N';
026000170926
026100170925
026200200120         //?Load the Member Record.
026300200120         mbssno = wSsn;
026400200120         mlname = ucase( l1_lName );
026500200120         mfname = ucase( l1_fName );
026600200120         mmi    = ucase( l1_mi );
026700200120         addr1  = ucase( l1_addr1 );
026800200120         addr2  = ucase( l1_addr2 );
026900200120         city   = ucase( l1_city );
027000200120         state  = ucase( l1_state );
027100170925
027200200120         if l1_zip > *Blanks;
027300200120           zip    = %Dec( l1_Zip : 5 : 0 );
027400200120           zip    = Zip * 10000;
027500200120         endif;
027600170925
027700170925
027800200120         //?Phone Number Logic
027900200120         l1_Phone = %ScanRpl( '-' : '' : l1_Phone );
028000200120         if %Len( %Trim( l1_phone )) = 10;
028100200120           wArea = %Subst( l1_phone : 1 : 3 );
028200200120           area  = %Dec( wArea : 3 : 0 );
028300170925
028400200120           wPhone = %Subst( l1_Phone : 4 : 7 );
028500200120           Phone  = %Dec( wPhone : 7 : 0 );
028600200120         endif;
028700170925
028800170925
028900200120         Sex = l1_Gender;
029000211020         Fill66 = l1_Email;
029001211020
029002211020
029100201204         if l1_dob > *Blanks;
029200201204           wdate = l1_dob ;
029300201204           Birth = %Dec( wdate : 8 : 0 ) ;
029400201204         endif;
029500170925
029600170925
029700200120         if l1_doh > *Blanks;
029800200120           wdate = l1_doh;
029900200120           EmpDt = %Dec( wdate : 8 : 0 ) ;
030000200120         endif;
030100170925
030200201204         if l1_Sal > *blanks;
030300201204           Salary  = %Dec( l1_Sal : 9 : 0 ) ;
030400201204         endif;
030500170925
030600200120         //?if Term Date is blank.. .then this is an active account.
030700200120         if l1_Termdt = *Blanks;
030800200120           EmpSt = 'A';
030900200120           Status = 'AA';
031000200120         Else;
031100200120         //  EmpSt = 'A';
031200200120         //   Status = 'AC';
031300200120         //    TermCd = 'DTE';
031400200120         endif;
031401230814
031402230814
031403230814
031404230814         // Cost Center
031405230814         ccflg = '';
031406230814         chain ( mbTrst : mbSub# : mbAcct : l1_CostCtr) ccntrxrefp;
031407230814         if %Found( ccntrxrefp );
031408230814           ccflg = %Trim( pcAmCntr ) ;
031409230814         EndIf;
031500170926
031600170926
031700201216
031800201216         // Check for All Waived Plans.
031900201216         Count_Plans();
032000201216         if PlanCount = 0;
032100201216           EmpSt = 'W';
032200201216           Status = 'AA';
032300201216         EndIf;
032400201216
032500201216
032600170926
032700200106       Endsr;
032800170925
032900170925      *------------------------------------------------------------------
033000170925      *?Load Dependent
033100170925      *------------------------------------------------------------------
033200200106       Begsr Load_Depend;
033300170925
033400200120         //?Defaults
033500200120         dCob = 'N';
033600200120         dmedcr = 'N';
033700200120         dCobbc = 'N';
033800200120         dpDltd = 'A';
033900170926
034000170925
034100200120         //?Load the Member Record.
034200200120         dssno = wSsn;
034300200120         dlname = ucase( l3_lname );
034400200120         dfname = ucase( l3_fname );
034500200120         dmi    = ucase( l3_mi );
034600200120         daddr1  = ucase( l3_addr1 );
034700200120         daddr2  = ucase( l3_addr2 );
034800200120         dcity   = ucase( l3_city );
034900200120         dstate  = ucase( l3_state );
035000170927
035100200120         Depss# = 0;
035200200120         if l3_depssn > *Blanks;
035300200120           DepSs# = %Dec( l3_depssn : 9 : 0 );
035400200106         endif;
035500170927
035600200120         if l3_zip > *Blanks;
035700200120           dzip    = %Dec( l3_zip : 5 : 0 );
035800200120           dzip    = dZip * 10000;
035900200120         endif;
036000170925
036100170925
036200200120         dSex = l3_Gender;
036300170925
036400201204         if l3_dob > *Blanks;
036500201204           wdate = l3_dob;
036600201204           dBirth = %Dec( wdate : 8 : 0 ) ;
036700201204         endif;
036800170925
036900200120         if uCase(l3_RelCod) = 'C';
037000200120           drelcd = 'RDA';
037100200120           if uCase(l3_Gender) = 'M';
037200200120             drelcd = 'RSO';
037300200120           endif;
037400200120         endif;
037500170925
037600200120         if uCase(l3_RelCod) = 'S';
037700200120           drelcd = 'RWI';
037800200120           if uCase(l3_Gender) = 'M';
037900200120             drelcd = 'RHU';
038000200120           endif;
038100200120         endif;
038200170927
038300200120         // Domestic Parter
038400200120br01     if uCase(l3_RelCod) = 'D';
038500200120 |         drelcd = 'RPA';
038600200120br01     endif;
038700190204
038800170925
038900200106       Endsr;
039000200106
039100200106       // ----------------------------------------------------------------
039200200106       dcl-proc RmvComma Export;
039300200106
039400200106         dcl-pi *n Char(100);
039500200106           iText Char(100) value;
039600200106         End-Pi;
039700200106
039800200106         dcl-s oText Char(100);
039900200106
040000200106         oText = %ScanRpl( ',' : ' ' : iText );   // Remove the Comma
040100200106         oText = %ScanRpl( '  ' : ' ' : oText );  // Convert a DBL Space to Single
040200200106
040300200106         Return oText;
040400200106
040500200106       end-proc;
040600201216
040700201216       // ----------------------------------------------------------------
040800201216       dcl-proc Count_Plans;
040900201216
041000201216         PlanCount = 0;
041100201216
041200201216         // Check the Member Plans
041300201216         Setll l1_ssn gbs20l2;
041400201216
041500201216         Dou %Eof(gbs20l2);
041600201216           reade l1_ssn gbs20l2;
041700201216           if %eof(gbs20l2);
041800201216             leave;
041900201216           endif;
042000201216
042100201216           PlanCount = PlanCount + 1;
042200201216
042300201216         Enddo;
042400201216
042500201216
042600201216         // Check the dependent
042700201216         Setll l1_ssn gbs20l3;
042800201216
042900201216         Dou %Eof(gbs20l3);
043000201216           reade l1_ssn gbs20l3;
043100201216           if %eof(gbs20l3);
043200201216             leave;
043300201216           endif;
043400201216
043500201216
043600201216           Setll l3_Uniqid gbs20l4;
043700201216
043800201216           Dou %Eof(gbs20l4);
043900201216             reade l3_Uniqid gbs20l4;
044000201216             if %eof(gbs20l4);
044100201216               leave;
044200201216             endif;
044300201216
044400201216             PlanCount = PlanCount + 1;
044500201216
044600201216           Enddo;
044700201216
044800201216         Enddo;
044900201216
045000201216
045100201216       End-Proc;
