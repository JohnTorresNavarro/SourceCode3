000100170925     H DftActGrp(*NO) bnddir('GBSBIND')
000200160428     H Option(*SRCSTMT: *NODEBUGIO: *NOSHOWCPY)
000300160428      *-------------------------------------------------------------------------
000400160428      *
000500170922      *  Description: Load F.Member
000600160428      *  Programmer.: Brian Rees
000700170922      *  Date.......: 9/22/2017
000800170313      *
000900170927      *  Notes: This program will read through the ADP Input file and populate
001000170927      *         a data structure which will be used to update F.Member and F.Depend
001100170927      *
001200160428      *-------------------------------------------------------------------------
001300160428      * Modifications
001400160428      *
001500170427      * Date         Programmer    Mod      Description
001600160428      *-------------------------------------------------------------------------
001700190729      * 07/29/2019   B.Rees        br01     Added Check with Relat Code
001800200106      * 01/06/2020   B.Rees        br02     removal of commas in the name and addr
001900210428      * 04/29/2021   B.Rees                 removal of Special Characters
002000210428      *                                     in the name and addr
002100210428      *
002200160428      *
002300160428      *-------------------------------------------------------------------------
002400170925     fADPInputp if   E           K Disk
002500160428      *-------------------------------------------------------------------------
002600170315
002700170925     d Member_data   e ds                  extName('F.MEMBER')
002800170925     d Depend_data   e ds                  extName('F.DEPEND')
002900170925     d xFill03       e                     extfld(FILL03)
003000170925
003100170925
003200170925     d SavSSN          s              9s 0
003300170925     d Sav_LName       s             30    inz
003400170925     d Sav_Dssn        s              9s 0 inz
003500170925     d Sav_DFName      s             20    inz
003600190729     d SavRelat        s             20    inz
003700170925
003800170925     d wSSN            s              9s 0
003900170925     d wArea           s              3a
004000170925     d wPhone          s              7a
004100171003     d wDate10         s             10a
004200171003     d wDate           s              8a
004300170929     d wDay            s              2a
004400170929     d wMonth          s              2a
004500170929     d wYear           s              4a
004600170925
004700180806       dcl-s @EmpSt Char(1);
004800180806       dcl-s @Status Char(2);
004900190814       dcl-c digits  '0123456789';
005000180806
005100180806
005200170925      *--------------------------------------------
005300170925      *?Procedures
005400170925      *--------------------------------------------
005500170929     D/include *LIBL/QMODSRC,PR0001RPR            // Case Functions
005600170929     D/include *LIBL/QMODSRC,#GettokPR         // Get Token (Split)
005700210505     D/include *LIBL/QMODSRC,#EdtStngPR         // Edit String
005800170925
005900170925     d WriteMember     pr                  ExtPgm('GBS0024R')
006000170925     d   @Member_Data               648
006100170925
006200170925     d WriteDepend     pr                  ExtPgm('GBS0024R1')
006300170925     d   @Depend_Data               360
006400170925
006500170929     D zFill           PR           100
006600170929     D  Len                           3s 0 value
006700170929     D  text                        100    value
006800170929
006900170929
007000170929
007100170929      *?For Split Function
007200170929     D pos             S              4s 0
007300170929     D x               S             10i 0
007400170929     D y               S             10i 0
007500170929     D tokens          s            100A   varying dim(50)
007600170929     D
007700160127      *------------------------------------------------------------------
007800160127      *?Main Program
007900160127      *------------------------------------------------------------------
008000170926     C     *entry        plist
008100170926     C                   parm                    i_TSA            10
008200170427
008300170925
008400200106       Setll *loval AdpInputp;
008500200106       dow not %Eof( AdpInputp );
008600200106         read AdpInputp;
008700170925
008800200106         if %Eof( AdpInputp );
008900200106           leave;
009000200106         endif;
009100170925
009200180322
009300200106         if cpssn = '';
009400200106           iter;
009500200106         endif;
009600180322
009700200106
009800210426br03     cpfname = EdtString(cpfname:'NAME');
009900210426br03     cplname = EdtString(cplname:'NAME');
010000210426br03     cpaddr1 = EdtString(cpaddr1:'ADDR');
010100210426br03     cpaddr2 = EdtString(cpaddr2:'ADDR');
010200210427
010300210427        // Using NAME so we dont get "#"
010400210427         cpCity = EdtString(cpCity:'NAME');
010500210427         cpState = EdtString(cpState:'NAME');
010600210427         cpZip = EdtString(cpZip:'NAME');
010700200106
010800210428
010900210428
011000210428br03     cpdfname = EdtString(cpdfname:'NAME');
011100210428br03     cpdlname = EdtString(cpdlname:'NAME');
011200210428br03     cpdaddr1 = EdtString(cpdaddr1:'ADDR');
011300210428br03     cpdaddr2 = EdtString(cpdaddr2:'ADDR');
011400210428
011500210428        // Using NAME so we dont get "#"
011600210428         cpdCity = EdtString(cpdCity:'NAME');
011700210428         cpdState = EdtString(cpdState:'NAME');
011800210428         cpdZip = EdtString(cpdZip:'NAME');
011900210428
012000210428
012100210428
012200210428
012300210428
012400210428
012500200106         cpssn = %ScanRpl( '-' : '' : cpssn );
012600200106         wSsn = %Dec( cpssn : 9 : 0 );
012700170925
012800200106         //?If we processed the Member.. Skip
012900200106         if wSsn = savSSN and sav_LName = cplname and
013000200106              cplname > *Blanks;
013100200106           iter;
013200200106         endif;
013300170925
013400200106         //?If we processed the Dependent... Skip
013500200106         if wSsn = savSSN and sav_DFName = cpdfname and
013600200106              cpdfname > '' and savRelat <> ucase(cpRelat);
013700200106           iter;
013800200106         endif;
013900170925
014000170925
014100170925
014200200106         Clear Member_Data;
014300200106         Clear Depend_Data;
014400170925
014500170925
014600200106         SavSSn = wSSN;
014700170925
014800200106         //?Load the Member
014900200106         if cplname > *Blanks;
015000200106           sav_LName = cplname;
015100170925
015200200106           Exsr Load_Member;
015300200106           if cpTermDt > '';
015400200106             iter;
015500200106           endif;
015600180614
015700200106           WriteMember( Member_data );
015800180614
015900200106         endif;
016000170925
016100170925
016200170925
016300200106         //?Load the Dependent
016400200106         if cpdfname > *Blanks;
016500200106           sav_DFName = cpdfname;
016600200106           savRelat = ucase(cpRelat);
016700200106           cpDepSsn = %ScanRpl( '-' : '' : cpDepssn );
016800200106           Exsr Load_Depend;
016900200106           WriteDepend( Depend_data );
017000200106         endif;
017100170925
017200200106       enddo;
017300170925
017400200106       *inlr = *on;
017500170925      *------------------------------------------------------------------
017600170925      *?Load Member
017700170925      *------------------------------------------------------------------
017800200106       Begsr Load_Member;
017900170925
018000170926
018100200106         //?Defaults
018200200106         mbTrst = %Dec( %Subst( i_TSA : 1 : 3) : 3 : 0 );
018300200106         mbSub# = %Dec( %Subst( i_TSA : 4 : 3) : 3 : 0 );
018400200106         mbAcct = %Dec( %Subst( i_TSA : 7 : 4) : 4 : 0 );
018500170926
018600200106         Cob = 'N';
018700200106         medicr = 'N';
018800200106         Cobbcf = 'N';
018900170926
019000170925
019100200106         //?Load the Member Record.
019200200106         mbssno = wSsn;
019300200106         mlname = ucase( cplname );
019400200106         mfname = ucase( cpfname );
019500200106         mmi    = ucase( cpmi );
019600200106         addr1  = ucase( cpaddr1 );
019700200106         addr2  = ucase( cpaddr2 );
019800200106         city   = ucase( cpcity );
019900200106         state  = ucase( cpState );
020000170925
020100200106         if cpzip > *Blanks;
020200200106           zip    = %Dec( cpzip : 5 : 0 );
020300200106           zip    = Zip * 10000;
020400200106         endif;
020500170925
020600170925
020700200106         //?Phone Number Logic
020800200106         cpPhone = %ScanRpl( '-' : '' : cpPhone );
020900170925
021000170925
021100200106         if %Len( %Trim( cpPhone )) = 10;
021200200106           wArea = %Subst( cpPhone : 1 : 3 );
021300200106           area  = %Dec( wArea : 3 : 0 );
021400170925
021500200106           wPhone = %Subst( cpPhone : 4 : 7 );
021600200106           Phone  = %Dec( wPhone : 7 : 0 );
021700200106         endif;
021800170925
021900170925
022000200106         Sex = cpGender;
022100170925
022200210512           if cpbDate > *Blanks;
022300210512              wDate10 = cpbDate;
022400210512              exsr $Split;
022500170929
022600210512              Birth = %Dec( wdate : 8 : 0 ) ;
022700210512           endif;
022800170925
022900170925
023000200106         if cphDate > *Blanks;
023100200106           wDate10 = cphDate;
023200200106           exsr $Split;
023300200106           EmpDt = %Dec( wdate : 8 : 0 ) ;
023400200106         endif;
023500170925
023600170925
023700200106         if cpmDate > *Blanks;
023800200106           wDate10 = cpmDate;
023900200106           exsr $Split;
024000200106           MarDt = %Dec( wdate : 8 : 0 ) ;
024100200106         endif;
024200170925
024300170925
024400171004         //if cpSalary > *blanks;
024500171004         //   Salary  = %Dec( cpSalary : 9 : 0 ) ;
024600171004         //endif;
024700170925
024800170925
024900200106         if cpMedicare > *Blanks;
025000200106           Medicr = 'Y';
025100200106           Med# = %Trim(cpMedicare);
025200200106         endif;
025300170925
025400200106         //?if Term Date is blank.. .then this is an active account.
025500200106         if cpTermDt = *Blanks;
025600200106           EmpSt = 'A';
025700200106           Status = 'AA';
025800200106         // Else;
025900200106         //    EmpSt = 'A';
026000200106         //    Status = 'AC';
026100200106         //    TermCd = 'DTE';
026200200106         endif;
026300170926
026400170926
026500200106         //?Check the current record to see if the member
026600200106         //?is Currently Active..
026700200106         //?This should fix the issue where ADP Doesn't
026800200106         //?send a term date, but we have the member termed in the file.
026900210427         Exec Sql
027000210427           Select EmpSt, Status
027100210427             into @EmpSt, @Status
027200210427             from "F.MEMBER"
027300210427             where mbssno = :wSSN;
027400180806
027500210426         if SqlCod = 0;
027600210426           EmpSt = @EmpSt;
027700210426           Status = @Status;
027800210426         endif;
027900180806
028000170926
028100210426       Endsr;
028200170925
028300210426      *------------------------------------------------------------------
028400210426      *?Load Dependent
028500210426      *------------------------------------------------------------------
028600210426       Begsr Load_Depend;
028700170925
028800210426         //?Defaults
028900210426         dCob = 'N';
029000210426         dmedcr = 'N';
029100210426         dCobbc = 'N';
029200210426         dpDltd = 'A';
029300170926
029400170925
029500210426         //?Load the Member Record.
029600210426         dssno = wSsn;
029700210426         dlname = ucase( cpdlname );
029800210426         dfname = ucase( cpdfname );
029900210426         dmi    = ucase( cpdmi );
030000210426         daddr1  = ucase( cpdaddr1 );
030100210426         daddr2  = ucase( cpdaddr2 );
030200210426         dcity   = ucase( cpdcity );
030300210426         dstate  = ucase( cpdState );
030400171003
030500210426         if cpDepssn > *Blanks and
030600210426            %check( digits : %Trim( cpDepssn )) = 0;
030700210426           DepSs# = %Dec( cpDepssn : 9 : 0 );
030800210426         endif;
030900171003
031000210426         if cpdzip > *Blanks;
031100210426           dzip    = %Dec( cpdzip : 5 : 0 );
031200210426           dzip    = dZip * 10000;
031300210426         endif;
031400170925
031500170925
031600210426         //?Phone Number Logic
031700210426         cpdPhone = %ScanRpl( '-' : '' : cpdPhone );
031800170925
031900170925
032000210426         if %Len( %Trim( cpdPhone )) = 10;
032100210426           wArea = %Subst( cpdPhone : 1 : 3 );
032200210426           darea  = %Dec( wArea : 3 : 0 );
032300170925
032400210426           wPhone = %Subst( cpdPhone : 4 : 7 );
032500210426           dPhone  = %Dec( wPhone : 7 : 0 );
032600210426         endif;
032700170925
032800170925
032900210426         dSex = cpdGender;
033000170925
033100210512           if cpdbDate > *Blanks;
033200210512              wDate10 = cpdbDate;
033300210512              exsr $Split;
033400210512              dBirth = %Dec( wdate : 8 : 0 ) ;
033500210512           endif;
033600170925
033700170925
033800210426         dStudn = cpdStudnt;
033900170925
034000210426         if cpMednbr > *Blanks;
034100210426           dMedcr = 'Y';
034200210426           dMed# = %Trim(cpMednbr);
034300210426         endif;
034400170925
034500170925
034600210426         if uCase(cpRelat) = 'CHILD';
034700210426           drelcd = 'RDA';
034800210426           if uCase(cpdGender) = 'M';
034900210426             drelcd = 'RSO';
035000210426           endif;
035100210426         endif;
035200170927
035300210426         if uCase(cpRelat) = 'SPOUSE';
035400210426           drelcd = 'RWI';
035500210426           if uCase(cpdGender) = 'M';
035600210426             drelcd = 'RHU';
035700210426           endif;
035800210426         endif;
035900170925
036000170925
036100210426       Endsr;
036200170929
036300210426       //------------------------------------------------------
036400210426       Begsr $Split;
036500170929
036600210426         // Split out the date...
036700210426         x = 0;
036800210426         tokens(*) = #Gettok( wDate10 : '/' : x );
036900170929
037000210426         wMonth = zFill( 2 : %Trim( Tokens(1) ));
037100210426         wDay = zFill( 2 : %Trim( Tokens(2) ));
037200210426         wYear = zFill( 4 : %Trim( Tokens(3) ));
037300170929
037400210426         wDate = wYear + wMonth + wDay;
037500170929
037600210426       Endsr;
037700170929
037800210426       // ----------------------------------------------------------------
037900210426       dcl-proc RmvComma Export;
038000200106
038100210426         dcl-pi *n Char(100);
038200210426           iText Char(100) value;
038300210426         End-Pi;
038400200106
038500210426         dcl-s oText Char(100);
038600200106
038700210426         oText = %ScanRpl( ',' : ' ' : iText );   // Remove the Comma
038800210426         oText = %ScanRpl( '  ' : ' ' : oText );  // Convert a DBL Space to Single
038900200106
039000210426         Return oText;
039100200106
039200210426       end-proc;
039300200106
039400210426      *----------------------------------------------------------------
039500210426      * zFill Function
039600210426      *----------------------------------------------------------------
039700210426     P zFill           B                   export
039800210426     D Zfill           PI           100
039900210426     D   Len                          3S 0 value
040000210426     D   Text                       100    value
040100170929     D
040200210426     D ReturnText      s            100
040300210426     D Diff            s              3s 0
040400210426     D i               s              3s 0
040500170929     C
040600210426     C                   eval      Diff = Len - %Len(%Trim(Text))
040700210426     C                   for       i = 1 to Diff
040800210426     C                   eval      ReturnText = %Trim(ReturnText) + '0'
040900210426     C                   endfor
041000170929     C
041100210426     C                   eval      ReturnText = %Trim(ReturnText) +
041200210426     C                              %Trim(Text)
041300170929     C
041400210426     C                   Return    ReturnText
041500210426     P zFill           E
041600210426
041700210426
