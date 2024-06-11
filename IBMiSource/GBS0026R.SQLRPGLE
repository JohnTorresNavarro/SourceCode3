000100170925     H DftActGrp(*NO) bnddir('GBSBIND')
000200160428     H Option(*SRCSTMT: *NODEBUGIO: *NOSHOWCPY)
000300160428      *-------------------------------------------------------------------------
000400160428      *
000500170922      *  Description: Load F.Member
000600160428      *  Programmer.: Brian Rees
000700170927      *  Date.......: 9/27/2017
000800170313      *
000900170927      *  Notes: This program will read through the GBS Input file and populate
001000170927      *         a data structure which will be used to update F.Member and F.Depend
001100170925      *
001200160428      *-------------------------------------------------------------------------
001300160428      * Modifications
001400160428      *
001500170427      * Date         Programmer    Mod      Description
001600160428      *-------------------------------------------------------------------------
001700190204      * 02/04/2019   B.Rees        br01     Added Domestic Parter to relation Code.
001800200106      * 01/06/2020   B.Rees        br02     removal of commas in the name and addr
001900210429      * 04/29/2021   B.Rees                 removal of Special Characters
002000210429      *                                     in the name and addr
002100210818      * 08/18/2021   B.Rees                 Allowed Birth Date to update.
002200210818      *                                     GBS0024R will only update if new.
002300160428      *
002400210908      * 09/08/2021   B.Rees                 Sending Dependent Birth
002500160428      *-------------------------------------------------------------------------
002600191205     fUltiSoftl1if   E           K Disk    usropn
002700191205     fUltiSoftl3if   E           K Disk    Rename(UltiSoftR : Rcd_3) usropn
002800160428      *-------------------------------------------------------------------------
002900170315
003000170925     d Member_data   e ds                  extName('F.MEMBER')
003100170925     d Depend_data   e ds                  extName('F.DEPEND')
003200170927     d xFill03       e                     extfld(FILL03)
003300170925
003400170925
003500170925
003600170925     d wSSN            s              9s 0
003700170925     d wArea           s              3a
003800170925     d wPhone          s              7a
003900170925     d wDate           s              8a
004000170925
004100170925      *--------------------------------------------
004200170925      *?Procedures
004300170925      *--------------------------------------------
004400170925     D/COPY *LIBL/QMODSRC,PR0001RPR            // Case Functions
004500210504     D/COPY *LIBL/QMODSRC,#EDTSTNGPR            // Case Functions
004600170925
004700170925     d WriteMember     pr                  ExtPgm('GBS0024R')
004800170925     d   @Member_Data               648
004900170925
005000170925     d WriteDepend     pr                  ExtPgm('GBS0024R1')
005100170925     d   @Depend_Data               360
005200170925
005300160127      *------------------------------------------------------------------
005400160127      *?Main Program
005500160127      *------------------------------------------------------------------
005600170926     C     *entry        plist
005700170926     C                   parm                    i_TSA            10
005800170427
005900200106       open UltiSoftl1;
006000200106       open UltiSoftl3;
006100191205
006200200106       //?Process Members & Dependents
006300200106       exsr Proc_Members;
006400200106       exsr Proc_Depends;
006500170925
006600200106       Close UltiSoftl1;
006700200106       Close UltiSoftl3;
006800170927
006900200106       *inlr = *on;
007000170927
007100170927      *------------------------------------------------------------------
007200170927      *?Process Members
007300170927      *------------------------------------------------------------------
007400200106       Begsr Proc_Members;
007500170927
007600200106         Setll *loval UltiSoftl1;
007700200106         dow not %Eof( UltiSoftl1 );
007800200106           read UltiSoftl1;
007900170927
008000200106           if %Eof( UltiSoftl1 );
008100200106             leave;
008200200106           endif;
008300170927
008400200106
008500200106           wSsn = %Dec( l1_ssn : 9 : 0 );
008600170925
008700200106           Clear Member_Data;
008800200106
008900210429br02       l1_FName = EdtString(l1_FName:'NAME');
009000210429br02       l1_LName = EdtString(l1_LName:'NAME');
009100210429br02       l1_Addr1 = EdtString(l1_Addr1:'ADDR');
009200210429br02       l1_Addr2 = EdtString(l1_Addr2:'ADDR');
009300210429           l1_City  = EdtString(l1_City:'NAME');
009400210429           l1_State = EdtString(l1_State:'NAME');
009500170925
009600200106           Exsr Load_Member;
009700200106           if l1_Termdt > '';
009800200106             iter;
009900200106           endif;
010000200106           WriteMember( Member_data );
010100170925
010200200106         enddo;
010300170925
010400200106       Endsr;
010500170927
010600170927      *------------------------------------------------------------------
010700170927      *?Process Dependents
010800170927      *------------------------------------------------------------------
010900200106       Begsr Proc_Depends;
011000170927
011100200106         Setll *loval UltiSoftl3;
011200200106         dow not %Eof( UltiSoftl3 );
011300200106           read UltiSoftl3;
011400170927
011500200106           if %Eof( UltiSoftl3 );
011600200106             leave;
011700200106           endif;
011800170927
011900200106           wSsn = %Dec( l3_PartSSN : 9 : 0 );
012000170927
012100200106           Clear Depend_Data;
012200200106
012300210429br02       l3_FName = EdtString(l3_FName:'NAME');
012400210429br02       l3_LName = EdtString(l3_LName:'NAME');
012500210429br02       l3_Addr1 = EdtString(l3_Addr1:'ADDR');
012600210429br02       l3_Addr2 = EdtString(l3_Addr2:'ADDR');
012700210429           l3_City  = EdtString(l3_City:'NAME');
012800210429           l3_State = EdtString(l3_State:'NAME');
012900210429
013000170927           //?Load the Dependent
013100200106           Exsr Load_Depend;
013200200106           WriteDepend( Depend_data );
013300170927
013400200106         enddo;
013500170927
013600200106       Endsr;
013700170925      *------------------------------------------------------------------
013800170925      *?Load Member
013900170925      *------------------------------------------------------------------
014000200106       Begsr Load_Member;
014100170925
014200170926
014300200106         //?Defaults
014400200106         mbTrst = %Dec( %Subst( i_TSA : 1 : 3) : 3 : 0 );
014500200106         mbSub# = %Dec( %Subst( i_TSA : 4 : 3) : 3 : 0 );
014600200106         mbAcct = %Dec( %Subst( i_TSA : 7 : 4) : 4 : 0 );
014700170926
014800200106         Cob = 'N';
014900200106         medicr = 'N';
015000200106         Cobbcf = 'N';
015100170926
015200170925
015300200106         //?Load the Member Record.
015400200106         mbssno = wSsn;
015500200106         mlname = ucase( l1_lName );
015600200106         mfname = ucase( l1_fName );
015700200106         mmi    = ucase( l1_mi );
015800200106         addr1  = ucase( l1_addr1 );
015900200106         addr2  = ucase( l1_addr2 );
016000200106         city   = ucase( l1_city );
016100200106         state  = ucase( l1_state );
016200170925
016300200106         if l1_zip > *Blanks;
016400200106           zip    = %Dec( l1_Zip : 5 : 0 );
016500200106           zip    = Zip * 10000;
016600200106         endif;
016700170925
016800170925
016900200106         //?Phone Number Logic
017000200106         l1_Phone = %ScanRpl( '-' : '' : l1_Phone );
017100200106         if %Len( %Trim( l1_phone )) = 10;
017200200106           wArea = %Subst( l1_phone : 1 : 3 );
017300200106           area  = %Dec( wArea : 3 : 0 );
017400170925
017500200106           wPhone = %Subst( l1_Phone : 4 : 7 );
017600200106           Phone  = %Dec( wPhone : 7 : 0 );
017700200106         endif;
017800170925
017900170925
018000200106         Sex = l1_Gender;
018100170925
018200210818          if l1_dob > *Blanks;
018300210818             wdate = l1_dob ;
018400210818             Birth = %Dec( wdate : 8 : 0 ) ;
018500210818          endif;
018600170925
018700170925
018800200106         if l1_doh > *Blanks;
018900200106           wdate = l1_doh;
019000200106           EmpDt = %Dec( wdate : 8 : 0 ) ;
019100200106         endif;
019200170925
019300200106         // if l1_Sal > *blanks;
019400200106         //    Salary  = %Dec( l1_Sal : 9 : 0 ) ;
019500171004         //endif;
019600170925
019700200106         //?if Term Date is blank.. .then this is an active account.
019800200106         if l1_Termdt = *Blanks;
019900200106           EmpSt = 'A';
020000200106           Status = 'AA';
020100200106         Else;
020200200106         //  EmpSt = 'A';
020300180530         //   Status = 'AC';
020400200106         //    TermCd = 'DTE';
020500200106         endif;
020600170926
020700170926
020800170926
020900200106       Endsr;
021000170925
021100170925      *------------------------------------------------------------------
021200170925      *?Load Dependent
021300170925      *------------------------------------------------------------------
021400200106       Begsr Load_Depend;
021500170925
021600200106         //?Defaults
021700200106         dCob = 'N';
021800200106         dmedcr = 'N';
021900200106         dCobbc = 'N';
022000200106         dpDltd = 'A';
022100170926
022200170925
022300200106         //?Load the Member Record.
022400200106         dssno = wSsn;
022500200106         dlname = ucase( l3_lname );
022600200106         dfname = ucase( l3_fname );
022700200106         dmi    = ucase( l3_mi );
022800200106         daddr1  = ucase( l3_addr1 );
022900200106         daddr2  = ucase( l3_addr2 );
023000200106         dcity   = ucase( l3_city );
023100200106         dstate  = ucase( l3_state );
023200170927
023300200106         Depss# = 0;
023400200514
023500200514         // This is for BlackHorse. Paylocity.
023600200514         if l3_depssn = 'xxxxxxxxx';
023700200514           l3_depssn = '';
023800200514         EndIf;
023900200514
024000200106         if l3_depssn > *Blanks;
024100200106           DepSs# = %Dec( l3_depssn : 9 : 0 );
024200200106         endif;
024300170927
024400200106         if l3_zip > *Blanks;
024500200106           dzip    = %Dec( l3_zip : 5 : 0 );
024600200106           dzip    = dZip * 10000;
024700200106         endif;
024800170925
024900170925
025000200106         dSex = l3_Gender;
025100170925
025200210908           if l3_dob > *Blanks;
025300210908              wdate = l3_dob;
025400210908              dBirth = %Dec( wdate : 8 : 0 ) ;
025500210908           endif;
025600170925
025700200106         if uCase(l3_RelCod) = 'C';
025800200106           drelcd = 'RDA';
025900200106           if uCase(l3_Gender) = 'M';
026000200106             drelcd = 'RSO';
026100200106           endif;
026200200106         endif;
026300170925
026400200106         if uCase(l3_RelCod) = 'S';
026500200106           drelcd = 'RWI';
026600200106           if uCase(l3_Gender) = 'M';
026700200106             drelcd = 'RHU';
026800200106           endif;
026900200106         endif;
027000170927
027100200106         // Domestic Parter
027200200106br01     if uCase(l3_RelCod) = 'D';
027300200106 |         drelcd = 'RPA';
027400200106br01     endif;
027500190204
027600170925
027700200106       Endsr;
027800200106
027900200106       // ----------------------------------------------------------------
028000200106       dcl-proc RmvComma Export;
028100200106
028200200106         dcl-pi *n Char(100);
028300200106           iText Char(100) value;
028400200106         End-Pi;
028500200106
028600200106         dcl-s oText Char(100);
028700200106
028800200106         oText = %ScanRpl( ',' : ' ' : iText );   // Remove the Comma
028900200106         oText = %ScanRpl( '  ' : ' ' : oText );  // Convert a DBL Space to Single
029000200106
029100200106         Return oText;
029200200106
029300200106       end-proc;
029400210429
029500210429
