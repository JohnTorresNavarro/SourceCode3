000100160930     H option(*noDebugIo)  DftActGrp(*no) BndDir('GBSBDIR')
000200150226      *-------------------------------------------------------------------------
000300150226      *
000400160804      *  Description:  WebTran Accounts missing employement Information
000500150226      *  Programmer.:  Brian Rees
000600160804      *  Date.......:   8/04/2016
000700150226      *
000800150603      *-------------------------------------------------------------------------
000900150603      * Modifications
001000150603      *
001100150603      * Date         Programmer    Mod      Description
001200150603      *-------------------------------------------------------------------------
001300150824      *
001400150824      *
001500150226      *-------------------------------------------------------------------------
001600160804     FMemAc#1   if   e           k disk    ExtDesc('F.MEMAC#1')
001700160804     F                                     ExtFile(*extdesc)
001800160804     FWebPayrollif   e           k disk
001900160804     Fgbs0010p  o    e           k disk
002000160930     Fgbs0010p1 o    e           k disk
002100150824
002200150824
002300150226      *-------------------------------------------------------------------------
002400150226
002500150302     D @Data           ds
002600150302     D  sqTrust                       3  0
002700150302     D  sqSub#                        3  0
002800150302     D  sqAccount                     4  0
002900160804     D  sqPayr                        4
003000150824     D  sqAccName                    40
003100150825
003200160930     D PayChoice       s              1a   inz
003300161004     D inTrs           s              3  0
003400161004     D inSub           s              3  0
003500161004     D inAcct          s              4  0
003600160930
003700150824      *-------------------------
003800150824      *?Procedure(s)
003900150824      *-------------------------
004000150824     D/COPY rpgspbeta/QMODSRC,#WebCodPR
004100160930     D/COPY rpgspbeta/QMODSRC,#PayChoPR
004200150824
004300150824
004400150714    ? *-------------------------------------------------------------------------
004500150714      *?Mainline Program
004600150714    ? *-------------------------------------------------------------------------
004700161003     C     *entry        plist
004800161004     C                   parm                    RptType           5
004900161004     C                   parm                    inTrs
005000161004     C                   parm                    inSub
005100161004     C                   parm                    inAcct
005200150825
005300150825      /Free
005400150825
005500150828         //?Run the SQL Commamnd and Loop through the results
005600150302         exsr $OpenC1;
005700150302         Dou SqlCod <> *Zero;
005800150302
005900150414            Exec Sql  Fetch Next From C1 Into :@data  ;
006000150302
006100150302            if SqlCod <> *Zero;
006200150302               leave;
006300160804            endif;
006400160804
006500160804            //?Get the Members...
006600160804            setll (sqTrust : sqSub# : sqAccount ) MemAc#1;
006700160804            dou %eof(MemAc#1);
006800160804               reade (sqTrust : sqSub# : sqAccount ) MemAc#1;
006900160804
007000160804               if %eof(MemAc#1);
007100160804                  leave;
007200160804               endif;
007300160804
007400160804               if termDt > 0 ;
007500160804                  iter;
007600160804               endif;
007700160804
007800160804               Clear WebRept_r;
007900160804
008000160804               chain (sqTrust : sqSub# : sqAccount : mbssno ) WebPayroll;
008100160804               if not %Found(WebPayroll);
008200160930
008300160930                  //?Load WebPayroll Data with F.Member
008400160930                  pyssn = mbssno ;
008500160930                  pyfst = mfname;
008600160930                  pylst = mlname;
008700160930                  pyad1 = addr1;
008800160930                  pycty = city;
008900160930                  pystt = state;
009000160930                  pyZp5 = %Char(Zip);
009100160930                  pyGen = sex;
009200160930                  pyBth = birth;
009300160930
009400161011                  // Load Defaults
009500161011                  pymgs = 'N';
009600161011                  pyrac = 'N';
009700161011                  pyeeo = *Blanks;
009800161019                  pySmk = 'N';
009900161019                  pyOtf = 'N';
010000161019
010100160804               endif;
010200160804
010300160930
010400161003               if RptType = 'Small';
010500161003                   Exsr SmallRpt;
010600160930                   iter;
010700160930               endif;
010800160930
010900161003               if RptType = 'Large';
011000161003                   Exsr LargeRpt;
011100161003                   iter;
011200161003               endif;
011300161003
011400160804            enddo;
011500160804
011600150824         enddo;
011700150824
011800150302         Exec Sql  Close C1;
011900150302
012000150302         *inlr = *on;
012100150309      // ----------------------------------------------------------------
012200150309
012300150302       begsr $OpenC1;
012400150302
012500150311          //----------------------------------------------------------------
012600150828          //?Collect all of the WebTran Records
012700150828          // Where the amPayr is not Blank and Not 'NPAY' and the
012800150828          // Dates was Yesterday.
012900150311          //----------------------------------------------------------------
013000150414          Exec Sql
013100150414             Declare C1 Cursor For
013200150414
013300150824             Select
013400160804               aotrst, aoSub#, aoAcct, amPayr, acnam1
013500160804             From accosp
013600160804             Join AccMsp on amTrst = aoTrst and amSub# = aoSub#
013700160804                        and amAcct = aoAcct
013800160804             Join "F.ACCMST" on acTrst = aoTrst and acSub# = aoSub#
013900160804                            and acAcct = aoAcct
014000160804             where aoCode in (8,9)  and aoendt = 0
014100160930                 and aotrst = :inTrs
014200160930                 and aoSub# = :inSub
014300160930                 and aoAcct = :inAcct
014400160930
014500160804             Order by aoTrst, aoSub#, aoacct;
014600150824
014700150317          Exec Sql    Open C1;
014800150317
014900150302
015000150302       endsr;
015100150825
015200160930      *-----------------------------------------------------------------
015300161003       begsr SmallRpt;
015400160930
015500160930
015600160930            //?If any of the Mandatory fields are blank, write a
015700160930            //?record.
015800160930            if pyssn = *Zero     or  pyfst = *Blanks   or
015900160930               pylst = *Blanks   or  pyad1 = *Blanks   or
016000160930               pyCty = *Blanks   or  pyStt = *Blanks   or
016100160930               pyZp5 = *Blanks   or  pyGen = *Blanks   or
016200161019               pyBth = *Zero
016300161004               or pyHdt = *zero                  // Hire Date
016400161004               or pybpc = *blanks ;              // Benefit Class
016500160930
016600160930               rpTrst = sqTrust;
016700160930               rpSub# = sqSub#;
016800160930               rpAcct = sqAccount;
016900160930               rpAcName = sqAccName;
017000160930               rpMember = mbssno;
017100160930
017200160930               rplname = pyLst;
017300160930               rpfname = pyFst;
017400161003
017500161003               rpmgs = pymgs ;
017600161003               if pymgs = 'N';
017700161003                  rpmgs = 'NOT REPORTED';
017800161011               endif;
017900161011
018000161003               rprac = pyrac ;
018100161003               if pyrac = 'N';
018200161003                  rprac = 'NOT REPORTED';
018300161003               endif;
018400160930
018500160930               Write WebRept_r1;
018600160930
018700160930            endif;
018800160930
018900160930
019000160930       Endsr;
019100161003      *-----------------------------------------------------------------
019200161003       begsr LargeRpt;
019300161003
019400161003
019500161003            //?If any of the Mandatory fields are blank, write a
019600161003            //?record.
019700161003            if pyssn = *Zero     or  pyfst = *Blanks   or
019800161003               pylst = *Blanks   or  pyad1 = *Blanks   or
019900161003               pyCty = *Blanks   or  pyStt = *Blanks   or
020000161003               pyZp5 = *Blanks   or  pyGen = *Blanks   or
020100161019               pyBth = *Zero     or
020200161003               pyBPC = *Blanks
020300161003
020400161003               // Screen 2 - Employement Information
020500161003               or pypst = *blanks                // Payroll Status
020600161003               or pysts = *blanks                // Employment Status
020700161003               or pyHdt = *zero                  // Hire Date
020800161003               or pyDiv = *blanks                // Division
020900161003               or pyDpt = *blanks                // Department
021000161003               or pyLoc = *blanks                // Location
021100161003               or pybpc = *blanks                // Benefit Class
021200161003               or pymstf = *Blanks               // Maritial Withholding - Federal
021300161003               or pymst  = *Blanks               // Maritial Withholding - State
021400161003               or pyfex  = *blanks               // Federal Exceptions
021500161003               or pysex  = *blanks  ;            // State Exceptions
021600161003
021700161003               rpTrst = sqTrust;
021800161003               rpSub# = sqSub#;
021900161003               rpAcct = sqAccount;
022000161003               rpAcName = sqAccName;
022100161003               rpMember = mbssno;
022200161003
022300161003               rplname = pyLst;
022400161003               rpfname = pyFst;
022500161003
022600161003               rpmgs = pymgs ;
022700161011               if pymgs = 'N';
022800161003                  rpmgs = 'NOT REPORTED';
022900161003               endif;
023000161003
023100161003               rpeeo = pyeeo ;
023200161003               if pyeeo = *Blanks;
023300161003                  rpeeo = 'NOT REPORTED';
023400161003               endif;
023500161003
023600161003               rprac = pyrac ;
023700161003               if pyrac = 'N';
023800161003                  rprac = 'NOT REPORTED';
023900161003               endif;
024000161003
024100161003
024200161003               Write WebRept_r;
024300161003
024400161003            endif;
024500161003
024600161003
024700161003       Endsr;
024800161004      *-----------------------------------------------------------------
024900161004       begsr *inzsr;
025000161004
025100161004
025200161004          // inTrs = 888;
025300161004          // inSub = 9;
025400161004          // inAcct = 3;
025500161004
025600161004          // inTrs = 888;
025700161004          // inSub = 1;
025800161004          // inAcct = 5;
025900161004
026000161004
026100161004          //?Determine payroll integration Status.
026200161004          PayChoice = #Paycho( inTrs : inSub : inAcct );
026300161004
026400161004          if PayChoice = 'Y';
026500161004             RptType = 'Large';
026600161004          else;
026700161004             RptType = 'Small';
026800161004          endif;
026900161004
027000161004       Endsr;
