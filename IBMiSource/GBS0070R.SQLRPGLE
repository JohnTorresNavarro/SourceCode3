000100211130
000200210802       Ctl-opt option(*nodebugio:*srcstmt:*nounref : *NoShowCpy)
000300210802       DftActGrp(*no);
000400210802
000500160428      *-------------------------------------------------------------------------
000600160428      *
000700170922      *  Description: Load F.Member
000800160428      *  Programmer.: Brian Rees
000900200113      *  Date.......: 1/13/2020
001000170313      *
001100200113      *  Copied from GBS0026R
001200200113      *
001300210409      *  Notes: This program will read through the GBS 3.0 Input file and populate
001400170927      *         a data structure which will be used to update F.Member and F.Depend
001500170925      *
001600160428      *-------------------------------------------------------------------------
001700160428      * Modifications
001800160428      *
001900170427      * Date         Programmer    Mod      Description
002000210730      * 07/30/2021   B.Rees                 Added MemExtP File.
002100211130      * 11/30/2021   B.Rees                 Added Cost Center
002200211130      *                                     Cost Center Cross Reference
002300211207      * 12/07/2021   B.Rees                 Added Class/Rule Cross Reference
002400160428      *-------------------------------------------------------------------------
002500200120
002600210409       dcl-f GBS30Mbr  keyed usropn;
002700210409       dcl-f GBS30mCov keyed usropn;
002800210409       dcl-f GBS30Dep  keyed usropn;
002900210409       dcl-f GBS30dCov keyed usropn;
003000200120
003100200120       dcl-f cfs100p keyed usage(*Input:*output:*update);
003200211130
003300211130       dcl-f ccntrxrefp keyed;
003400211207       dcl-f EaseClas keyed;
003500211207       dcl-f EaseClasL1 keyed rename(r_EaseClas : ClassL1 );
003600211207
003700200120
003800160428      *-------------------------------------------------------------------------
003900170315
004000210412     d Member_data   e ds                  extName('F.MEMBER')
004100210412     d Depend_data   e ds                  extName('F.DEPEND')
004200210412     d xFill03       e                     extfld(FILL03)
004300210802
004400210802       dcl-ds Extend_Data extname('MEMEXTP') end-ds;
004500210802
004600200120       dcl-s wSSN Zoned(9);
004700200120       dcl-s wArea Char(3);
004800200120       dcl-s wPhone Char(7);
004900200120       dcl-s wDate Char(8);
005000200113
005100200113       dcl-s DepSeq#  Zoned(2);
005200200120       dcl-s wDep_SSN  Zoned(9);
005300170925
005400201216       dcl-s PlanCount Zoned(3);
005500201216
005600170925      *--------------------------------------------
005700200120      * Procedures
005800170925      *--------------------------------------------
005900210412       dcl-pr WriteMember ExtPgm('GBS0024R');
006000210412         @Member_Data   Char(648);
006100210412       End-Pr;
006200210412
006300210803
006400210412       dcl-pr WriteDepend ExtPgm('GBS0024R1');
006500210802         @Depend_Data   Char(360);
006600210412       End-Pr;
006700200120
006800210803
006900210803       dcl-pr WriteExtend ExtPgm('GBS0024R2');
007000220311         @Extend_Data   Char(466);
007100210803       End-Pr;
007200210730
007300210730
007400200120
007500200120      *-------------------------------------------------------------------------
007600200120      *
007700200120      * *Entry Procedure
007800200120      *
007900200120      *-------------------------------------------------------------------------
008000200120       Dcl-pr Main ExtPgm;
008100210802         *N  Char(10);
008200200120       End-Pr;
008300200120
008400200120       dcl-pi Main;
008500210802         i_TSA Char(10);
008600200120       End-Pi;
008700200120
008800200120
008900200120
009000160127      *------------------------------------------------------------------
009100200120      *
009200200120      * Main Program
009300200120      *
009400160127      *------------------------------------------------------------------
009500170427
009600210409       open GBS30Mbr  ;
009700210409       open GBS30mCov ;
009800210409       open GBS30Dep  ;
009900210409       open GBS30DCov ;
010000191205
010100210412       // Process Members & Dependents
010200210412       Proc_Members();
010300210412       Proc_Depends();
010400170925
010500210409       Close GBS30Mbr  ;
010600210409       Close GBS30mCov ;
010700210409       Close GBS30Dep  ;
010800210409       Close GBS30dCov ;
010900170927
011000200106       *inlr = *on;
011100170927
011200170927      *------------------------------------------------------------------
011300210412      *  Process Members
011400170927      *------------------------------------------------------------------
011500210802       dcl-Proc   Proc_Members;
011600170927
011700210802         Setll *loval GBS30Mbr  ;
011800211014         dow not %Eof( GBS30Mbr   );
011900210409           read GBS30Mbr  ;
012000170927
012100211014           if %Eof( GBS30Mbr   );
012200211014             leave;
012300200120           endif;
012400170927
012500200106
012600200120           wSsn = %Dec( l1_ssn : 9 : 0 );
012700170925
012800200120           Clear Member_Data;
012900211130           Clear Extend_Data;
013000200106
013100170925
013200210429br02       l1_FName = EdtString(l1_FName:'NAME');
013300210429br02       l1_LName = EdtString(l1_LName:'NAME');
013400210429br02       l1_Addr1 = EdtString(l1_Addr1:'ADDR');
013500210429br02       l1_Addr2 = EdtString(l1_Addr2:'ADDR');
013600210429           l1_City  = EdtString(l1_City:'NAME');
013700210802           l1_State = EdtString(l1_State:'NAME');
013800210429
013900210429
014000210412           Load_Member();
014100211014           if l1_Termdt > '';
014200211014             iter;
014300200120           endif;
014400201204
014500201204
014600210802           WriteMember( Member_data );
014700210803           WriteExtend( Extend_Data );
014800200113
014900200113
015000210802           // Update Long Name
015100211014           if %len(%trim( l1_Fname )) > 12 or
015200211014           %len(%Trim( l1_lname )) > 18;
015300200113
015400200120             DepSeq# = 0;
015500210802             chain ( wSsn : DepSeq# ) Cfs100p;
015600211014             if %Found( Cfs100p );
015700200120               cfsfst = l1_fname;
015800200120               cfsmid = l1_mi;
015900210802               cfslst = l1_lname;
016000200113
016100211014               Update cfs100r;
016200211014             else;
016300200120               cfssn = wssn;
016400200120               cfseq = DepSeq#;
016500200120               cfsfst = l1_fname;
016600210802               cfsmid = l1_mi;
016700210802               cfslst = l1_lname;
016800200113
016900211014               write cfs100r;
017000211014             EndIf;
017100200113
017200200113
017300211014           EndIf;
017400200113
017500200113
017600200113
017700170925
017800210802         enddo;
017900170925
018000210412       end-Proc  ;
018100170927
018200170927      *------------------------------------------------------------------
018300210412      *  Process Dependents
018400170927      *------------------------------------------------------------------
018500210802       dcl-Proc   Proc_Depends;
018600170927
018700210802         Setll *loval GBS30Dep  ;
018800211014         dow not %Eof( GBS30Dep   );
018900210409           read GBS30Dep  ;
019000170927
019100211014           if %Eof( GBS30Dep   );
019200211014             leave;
019300200120           endif;
019400170927
019500200120           wSsn = %Dec( l3_PartSSN : 9 : 0 );
019600211014           if l3_depssn = '';
019700211014             l3_depssn = '0';
019800200205           EndIf;
019900200205
020000200120           wDep_Ssn = %Dec( L3_DEPSSN : 9 : 0 );
020100170927
020200200120
020300200120           Clear Depend_Data;
020400200106
020500210429br02       l3_FName = EdtString(l3_FName:'NAME');
020600210429br02       l3_LName = EdtString(l3_LName:'NAME');
020700210429br02       l3_Addr1 = EdtString(l3_Addr1:'ADDR');
020800210429br02       l3_Addr2 = EdtString(l3_Addr2:'ADDR');
020900210429           l3_City  = EdtString(l3_City:'NAME');
021000210429           l3_State = EdtString(l3_State:'NAME');
021100210429
021200210429
021300210429
021400210412           //  Load the Dependent
021500210802           Load_Depend();
021600210802           WriteDepend( Depend_data );
021700200113
021800200113
021900210802           // Update Long Name
022000211014           if %len(%trim( l3_Fname )) > 12 or
022100211014           %len(%Trim( l3_lname )) > 18;
022200200113
022300200120             DepSeq# = 0;
022400200113
022500200120             // Get Dependent Sequence Number.
022600211014             if wDep_ssn > 0;
022700211207               Exec Sql
022800211207                 Select dpSeq#
022900211207                   into :DepSeq#
023000211207                   FROM "F.DEPEND"
023100211207                   Where dssno = :wSSN and
023200211207                         Depss# = :wDep_ssn;
023300210802             endif;
023400200113
023500200113
023600210802             // Check by Last Name...
023700211021             if DepSeq# > 0;
023800200113
023900210802               chain ( wSsn : DepSeq# ) Cfs100p;
024000211014               if %Found( Cfs100p );
024100210802                 cfsfst = l3_fname;
024200200120                 cfsmid = l3_mi;
024300200120                 cfslst = l3_lname;
024400200113
024500211014                 Update cfs100r;
024600211014               else;
024700200120                 cfssn = wssn;
024800200120                 cfseq = DepSeq#;
024900210802                 cfsfst = l3_fname;
025000210802                 cfsmid = l3_mi;
025100210802                 cfslst = l3_lname;
025200200113
025300210802                 write cfs100r;
025400210802               endif;
025500210802             endif;
025600210802           endif;
025700210802         enddo;
025800170927
025900210412       end-Proc  ;
026000200120
026100200120
026200170925      *------------------------------------------------------------------
026300200120      *
026400200120      * Load Member
026500200120      *
026600170925      *------------------------------------------------------------------
026700210802       dcl-Proc   Load_Member;
026800170925
026900201216
027000200120         //?Defaults
027100200120         mbTrst = %Dec( %Subst( i_TSA : 1 : 3) : 3 : 0 );
027200200120         mbSub# = %Dec( %Subst( i_TSA : 4 : 3) : 3 : 0 );
027300200120         mbAcct = %Dec( %Subst( i_TSA : 7 : 4) : 4 : 0 );
027400170926
027500200120         Cob = 'N';
027600200120         medicr = 'N';
027700200120         Cobbcf = 'N';
027800170926
027900170925
028000210412         //  Load the Member Record.
028100200120         mbssno = wSsn;
028200210802         mlname = %upper( l1_lName );
028300210802         mfname = %upper( l1_fName );
028400210802         mmi    = %upper( l1_mi );
028500210802         addr1  = %upper( l1_addr1 );
028600210802         addr2  = %upper( l1_addr2 );
028700210802         city   = %upper( l1_city );
028800210802         state  = %upper( l1_state );
028900170925
029000200120         if l1_zip > *Blanks;
029100211213           if %Len( %Trim( l1_Zip ))> 5;
029200211213             l1_zip = %Subst( l1_Zip : 1 : 5);
029300211213           EndIf;
029400210802           zip    = %Dec( l1_Zip : 5 : 0 );
029500210802           zip    = Zip * 10000;
029600210802         endif;
029700170925
029800170925
029900210802         //  Phone Number Logic
030000210802         l1_Phone = %ScanRpl( '-' : '' : l1_Phone );
030100210802         if %Len( %Trim( l1_phone )) = 10;
030200200120           wArea = %Subst( l1_phone : 1 : 3 );
030300210802           area  = %Dec( wArea : 3 : 0 );
030400170925
030500210802           wPhone = %Subst( l1_Phone : 4 : 7 );
030600200120           Phone  = %Dec( wPhone : 7 : 0 );
030700210802         endif;
030800170925
030900170925
031000200120         Sex = l1_Gender;
031100211020         Fill66 = l1_Email;
031200211020
031300211020
031400201204         if l1_dob > *Blanks;
031500201204           wdate = l1_dob ;
031600201204           Birth = %Dec( wdate : 8 : 0 ) ;
031700201204         endif;
031800170925
031900170925
032000200120         if l1_doh > *Blanks;
032100200120           wdate = l1_doh;
032200210802           EmpDt = %Dec( wdate : 8 : 0 ) ;
032300200120         endif;
032400170925
032500201204         if l1_Sal > *blanks;
032600210802           Salary  = %Dec( l1_Sal : 9 : 0 ) ;
032700210802         endif;
032800170925
032900210412         //  if Term Date is blank.. .then this is an active account.
033000200120         if l1_Termdt = *Blanks;
033100210802           EmpSt = 'A';
033200210802           Status = 'AA';
033300200120         Else;
033400200120         //  EmpSt = 'A';
033500200120         //   Status = 'AC';
033600200120         //    TermCd = 'DTE';
033700210802         endif;
033800170926
033900170926
034000211130
034100211130         // Cost Center
034200211130         ccflg = '';
034300211130         chain ( mbTrst : mbSub# : mbAcct : l1_CostCtr) ccntrxrefp;
034400211130         if %Found( ccntrxrefp );
034500211130           ccflg = %Trim( pcAmCntr ) ;
034600211130         EndIf;
034700211130
034800211130
034900201216
035000201216         // Check for All Waived Plans.
035100210802         Count_Plans();
035200210802         if PlanCount = 0;
035300210802           EmpSt = 'W';
035400210802           Status = 'AA';
035500210802         EndIf;
035600201216
035700211014         //-----------------------------------
035800211014         //
035900211014         // Member Extension File Data
036000211014         //
036100211014         //-----------------------------------
036200210802
036300211130         messno = wSsn;
036400211130
036500211014         meOcc = l1_Jobtitl;
036600211014         meRace = l1_Race;
036700211014         meMgs = l1_MarSts;
036800211014         meSmoke = l1_Smoker;
036900211130         meClass = l1_Class;
037000211207
037100211207         // Get the Rule...
037200211207         meRule = '';
037300211207
037400211207         chain ( mbTrst : mbSub#: mbAcct : l1_Class ) EaseClasl1;
037500211207         if %Found( EaseClasL1 ) ;
037600211207           meRule = %trim( c_GbsClas );
037700211207         EndIf;
037800211207
037900211207         // Check using the description.
038000211207         if meRule = '';
038100211207
038200211207           chain ( mbTrst : mbSub#: mbAcct : l1_Class ) EaseClas;
038300211207           if %Found( EaseClas ) ;
038400211207             meRule = %trim( c_GbsClas );
038500211207           EndIf;
038600211207
038700211207         EndIf;
038800211207
038900211130
039000210802
039100210802
039200210412       end-Proc  ;
039300170925
039400170925      *------------------------------------------------------------------
039500210412      *  Load Dependent
039600170925      *------------------------------------------------------------------
039700210802       dcl-Proc   Load_Depend;
039800170925
039900200120         //?Defaults
040000200120         dCob = 'N';
040100200120         dmedcr = 'N';
040200200120         dCobbc = 'N';
040300200120         dpDltd = 'A';
040400170926
040500170925
040600210412         //  Load the Member Record.
040700200120         dssno = wSsn;
040800210802         dlname = %upper( l3_lname );
040900210802         dfname = %upper( l3_fname );
041000210802         dmi    = %upper( l3_mi );
041100210802         daddr1  = %upper( l3_addr1 );
041200210802         daddr2  = %upper( l3_addr2 );
041300210802         dcity   = %upper( l3_city );
041400210802         dstate  = %upper( l3_state );
041500170927
041600210802         Depss# = 0;
041700210802         if l3_depssn > *Blanks;
041800200120           DepSs# = %Dec( l3_depssn : 9 : 0 );
041900200106         endif;
042000170927
042100200120         if l3_zip > *Blanks;
042200211213           if %Len( %Trim( l3_Zip ))> 5;
042300211214             l3_zip = %Subst( l3_Zip : 1 : 5);
042400211213           EndIf;
042500210802           dzip    = %Dec( l3_zip : 5 : 0 );
042600200120           dzip    = dZip * 10000;
042700210802         endif;
042800170925
042900170925
043000200120         dSex = l3_Gender;
043100170925
043200210802         if l3_dob > *Blanks;
043300201204           wdate = l3_dob;
043400201204           dBirth = %Dec( wdate : 8 : 0 ) ;
043500210802         endif;
043600170925
043700210802         if %upper(l3_RelCod) = 'C';
043800210802           drelcd = 'RDA';
043900210802           if %upper(l3_Gender) = 'M';
044000210802             drelcd = 'RSO';
044100210802           endif;
044200210802         endif;
044300170925
044400210802         if %upper(l3_RelCod) = 'S';
044500210802           drelcd = 'RWI';
044600210802           if %upper(l3_Gender) = 'M';
044700210802             drelcd = 'RHU';
044800210802           endif;
044900210802         endif;
045000170927
045100210802         // Domestic Parter
045200210802br01     if %upper(l3_RelCod) = 'D';
045300210802 |         drelcd = 'RPA';
045400210802br01     endif;
045500190204
045600170925
045700210802       end-Proc  ;
045800200106
045900210429
046000210802       // ----------------------------------------------------------------
046100210802       dcl-proc Count_Plans;
046200201216
046300210802         PlanCount = 0;
046400201216
046500210802         // Check the Member Plans
046600210802         Setll l1_ssn gbs30mCov;
046700201216
046800210802         Dou %Eof(gbs30mCov);
046900210802           reade l1_ssn gbs30mCov;
047000210802           if %eof(gbs30mCov);
047100210802             leave;
047200210802           endif;
047300201216
047400210802           PlanCount = PlanCount + 1;
047500201216
047600210802         Enddo;
047700201216
047800201216
047900210802         // Check the dependent
048000210802         Setll l1_ssn gbs30Dep;
048100201216
048200210802         Dou %Eof(gbs30Dep);
048300210412           reade l1_ssn gbs30Dep;
048400210412           if %eof(gbs30Dep);
048500201216             leave;
048600210802           endif;
048700201216
048800201216
048900210802           Setll (L3_PARTSSN : L3_DEPSEQ#)  gbs30dCov;
049000201216
049100210802           Dou %Eof(gbs30dCov);
049200210412             reade (L3_PARTSSN : L3_DEPSEQ#)  gbs30dCov;
049300210802             if %eof(gbs30dCov);
049400210802               leave;
049500210802             endif;
049600201216
049700210802             PlanCount = PlanCount + 1;
049800201216
049900210802           Enddo;
050000201216
050100210802         Enddo;
050200201216
050300201216
050400201216       End-Proc;
050500201216
050600210429
050700210429
050800210429      *----------------------------------------------------------------
050900210429      * edit String
051000210429      *----------------------------------------------------------------
051100210429
051200210802       dcl-proc EdtString export;
051300210429
051400210429         dcl-pi *n Char(100);
051500210802           iString Char(100) value;
051600210429           iType  Char(5) value;
051700210429         End-Pi;
051800210429
051900210429         dcl-s outString Char(100);
052000210429
052100210429         if iType = 'NAME';
052200211207           Exec SQL
052300211207             SET :OutString = REGEXP_REPLACE(
052400211207                   :iString, '[^A-Za-z0-9\''\.\ ]', '');
052500210429         endif;
052600210429
052700210429
052800210429
052900210429         if iType = 'ADDR';
053000211207           Exec SQL
053100211207             SET :OutString = REGEXP_REPLACE(
053200211207                   :iString, '[^A-Za-z0-9\''\#\.\/\ ]', '');
053300210802         endif;
053400210429
053500210429
053600210802         OutString = %ScanRpl('  ' : ' ' : OutString);
053700210802         Return OutString;
053800210429
053900210429
054000211014       end-proc;
054100210429
