000100160613     H option(*noDebugIo)
000200180626      *===========================================================================
000300180628      * PCORINEW - PCORI Annual report
000400180626      *===========================================================================
000500180626      * Date        Int   Description
000600180626      * ----------  ---   --------------------------------------------------------
000700180626      * 06/26/2018  jt    Original creation
000800150529
000900180626      *===========================================================================
001000150529
001100180625     fgrat24    if   e           k disk    ExtFile('F.GRAT24')
001200180625     f                                     rename(grater:rateFile)
001300150529
001400180625     fsmansp    if   e           k disk    rename(smanr:smanFile)
001500150529
001600180625     fplnunique if   e           k disk    rename(plnmsr:planFile)
001700150529
001800180625     facmunique if   e           k disk    rename(accmsr:actmFile)
001900180625
002000180625     fac2mstl2  if   e           k disk    rename(accmsr2:actm2File)
002100180625
002200180625     fmcovxx    if   e           k disk    ExtFile('F.MCOVXX')
002300180625     f                                     rename(mcovr:covFile)
002400150529
002500180625     fmember    if   e           k disk    ExtFile('F.MEMBER')
002600180625     f                                     rename(membr:memberFile)
002700150529
002800180625     fpcoripf   uf a e           k disk    rename(pcorir:pcoriFile)
002900180626
003000180626     fpcoripfsumuf a e           k disk    rename(pcorir:pcorisFile)
003100180626
003200180626     fpcoripfcatuf a e           k disk    rename(pcoricr:pcoricFile)
003300180625
003400180626      //==========================================================================
003500180625
003600180626     d #bgn            s              8  0
003700180626     d #end            s              8  0
003800180626     d #bgnpln         s              8  0
003900180626     d #endpln         s              8  0
004000180626     d holdDate#       s             12  0
004100180627     d holdPlan        s              4
004200180627     d candtHold       s              8  0
004300190123     d paccumHold      s             12  4
004400180626
004500180628     d pcorinew        pi
004600180628     d  intype                        3    const
004601190717     d  inTerms                       1    const
004602190717     d  inFromDate                    8  0
004603190717     d  inToDate                      8  0
004700180628
004800170524      //==========================================================================
004900170524      // mainline
005000170524      //==========================================================================
005100150529
005200170524       exsr init;
005300170524       exsr main;
005400170524       exsr exit;
005500180628
005600180625      //========================================================================
005700180625      // main
005800180625      //========================================================================
005900180625
006000180628       begsr main;
006100180625
006200180625       setll *loval rateFile;
006300180625       read rateFile;
006400180625
006500180625       dow not %eof;
006600180625
006700180625       if todat >= #bgn;
006800180625
006900180625        if frmdat < #bgn;
007000180625         #bgnpln = #bgn;
007100180625        endif;
007200180625
007300180625        if todat > #end;
007400180625         #endpln = #end;
007500180625        else;
007600180625         #endpln = todat;
007700180625        endif;
007800180625
007900180625        exsr checkPlan;
008000180625
008100190123       endif;
008200150610
008300180625       read rateFile;
008400180625       enddo;
008500180625
008600180625       endsr;
008700180625
008800180625      //=======================================================================
008900180625      // check plan
009000180625      //=======================================================================
009100180625
009200180625       begsr checkPlan;
009300180625
009400180625        holdDate# = 0;
009500180625
009600180625        chain (grtrst : grsub# : grplan) planFile;
009700180625        if %found;
009800180626         if plncat <> intype;
009900180625          leavesr;
010000180625         endif;
010100180625        endif;
010200180625
010300180625        exsr writeMembers;
010400180625
010500180625       endsr;
010600180625
010700180625      //=======================================================================
010800180625      // write members
010900180625      //=======================================================================
011000180625
011100180625       begsr writemembers;
011200180625
011300180625        setll (grtrst : grsub# : grplan) covFile;
011400180625        reade (grtrst : grsub# : grplan) covFile;
011500180625        dow not %eof;
011600180625
011700180627         candtHold = candt;
011800180627         if candtHold = 0;
011900180627          candtHold = 99999999;
012000180627         endif;
012100180627
012200180627         //if enrldt <> candt and candtHold > #bgn and candtHold > 0;
012300180627         if candtHold > #bgn and candtHold > 0;
012400180627          if enrldt <> candt;
012500180627
012600180627           if enrldt >= #bgnpln;
012700180627            exsr writeFile;
012800180627           endif;
012900190107
013000190108           if candt = 0;
013100180627            if enrldt <= #endpln;
013200180627             exsr writeFile;
013300180627            endif;
013400180627           endif;
013500180627
013600180627           if candt > 0;
013700180627            if candt > #endpln;
013800180627             exsr writeFile;
013900180627            endif;
014000180627           endif;
014100180625
014200180627          endif;
014300180627         endif;
014400180627
014500180625        reade (grtrst : grsub# : grplan) covFile;
014600180625        enddo;
014700180625
014800180625       endsr;
014900180625
015000180625      //=======================================================================
015100180625      // write file
015200180625      //=======================================================================
015300180625
015400180625       begsr writeFile;
015500180627
015600180625        chain (grtrst : grsub# : acc# : grplan : %editc(mcssno:'X')) pcoriFile;
015700180625        if not %found;
015800180625         ptrst = grtrst;
015900180625          psub# = grsub#;
016000180625           pacct = acc#;
016100180626
016200180627           if grplan <> holdPlan;
016300190123            paccum = 0;
016400190604            paccums = 0;
016500190604            paccumHold = 0;
016600180627           endif;
016700180626
016800180626           pplan = grplan;
016900180626
017000180625          pssn = %editc(mcssno:'X');
017100180625
017200180625         chain (grtrst : grsub# : acc#) actmFile;
017300180625         if %found;
017400180627          pname = acnam1;
017500180627           padd1 = aaddr1;
017600180627            padd2 = addr2;
017700180627             pcity = acity;
017800180626             pst = astate;
017900180626            pzip = %editc(azip:'X');
018000180626           pcontact = contac;
018100180626          pecontact = ecntac;
018200180625         endif;
018300180625
018301190717         If inTerms = ' ';
018302190717          if atrmdt > 0;
018303190717           leavesr;
018304190717          endif;
018305190717         endif;
018306190717
018307190717         If inTerms = 'Y';
018308190717          if atrmdt = 0;
018309190717           leavesr;
018310190717          endif;
018311190717         endif;
018312190717
018400190717         //if atrmdt > 0;
018500190717         // leavesr;
018600190717         //endif;
018700180626
018800180625         chain (grtrst : grsub# : acc#) actm2File;
018900180625         if %found;
019000180625          pemail = a2email1;
019100180625         endif;
019200180625
019300180625         chain smancd smanFile;
019400180625         if %found;
019500180625          if smi > ' ';
019600180625           psman = %trim(sfname) + ' ' + %trim(smi) + ' ' + %trim(slname);
019700180625          else;
019800180625           psman = %trim(sfname) + ' ' + %trim(slname);
019900180625          endif;
020000180625         endif;
020100180625
020200180625         chain mcssno memberFile;
020300180625         if %found;
020400180625          plname = mlname;
020500180625           pfname = mfname;
020600180625          pdob = %char(birth);
020700180625         endif;
020800180625
020900180625         penrldt = %char(enrldt);
021000180625         pstdate = %char(#bgn);
021100180625         pcandt = %char(candt);
021200180626         penddt = %char(#end);
021300180625
021400180628         pnumdays = ' ';
021500180628
021600180628         if enrldt >= #bgn and candt <= #end;
021700180628          if candt > 0;
021800180628           pnumdays = %char(%diff(%date(candt):%date(enrldt):*days));
021900180628          endif;
022000180628         endif;
022100180627
022200180720         if pnumdays = ' ';
022300190107          if enrldt >= #bgn and candt = 0;
022400180720           pnumdays = %char(%diff(%date(#end):%date(enrldt):*days));
022500180720            if pnumdays = '364';
022600180720             pnumdays = '365';
022700180720            endif;
022800180720          endif;
022900180720         endif;
023000180720
023100180628         if pnumdays = ' ';
023200180628          if enrldt > #bgn and candt < #end and candt > 0;
023300180628           pnumdays = %char(%diff(%date(candt):%date(enrldt):*days));
023400180628          endif;
023500180628         endif;
023600180625
023700180627         if pnumdays = ' ';
023800180628          if candt > #end;
023900180628           if enrldt < #bgn;
024000180628            pnumdays = '365';
024100180628           endif;
024200180627          endif;
024300180627         endif;
024400180625
024500180627         if pnumdays = ' ';
024600180628          if candt > 0;
024700180628           if enrldt < #bgn;
024800180628            pnumdays = '365';
024900180628           endif;
025000180628          endif;
025100180627         endif;
025200180625
025300180627         if pnumdays = ' ';
025400180628          if enrldt < #bgn;
025500180628           if candt = 0;
025600180628            pnumdays = '365';
025700180628           endif;
025800180628          endif;
025900180627         endif;
026000180625
026100180627         if pnumdays = ' ';
026200180627          if enrldt > #bgn;
026300180625           pnumdays = %char(%diff(%date(#end):%date(enrldt):*days));
026400180627          endif;
026500180627         endif;
026600180625
026700180626         pavg = 0;
026800180626         if pnumdays > ' ';
026900180626          pavg = %dec(pnumdays:3:0) / 365;
027000180626         endif;
027100180626
027200190123         paccum = paccumHold + pavg;
027300180626
027400180626         if enrldt <= #end;
027500180627          holdPlan = pplan;
027600190123          paccumHold = paccum;
027700180628           write pcoriFile;
027800180628           exsr writeSummary;
027900180628          exsr writeCategory;
028000180626         endif;
028100180626
028200180625        endif;
028300180625
028400180625       endsr;
028500180625
028600180627      //==========================================================================
028700180627      // write summary
028800180627      //==========================================================================
028900180627
029000180627       begsr writeSummary;
029100180627
029200180807        plenddate = %char(todat);
029300180807
029400180628        chain (grtrst : grsub# : acc# : grplan) pcorisFile;
029500180628        if not %found;
029600190604         clear paccums;
029700180628         paccums = paccum;
029800180628         write pcorisFile;
029900190604         clear paccum;
030000180628        else;
030100180628         paccums = paccum;
030200180628         update pcorisFile;
030300180628        endif;
030400180627
030500180627       endsr;
030600180627
030700180628      //==========================================================================
030800180628      // write category
030900180628      //==========================================================================
031000180628
031100180628       begsr writeCategory;
031200180628
031300180628        chain (grtrst : grsub# : acc# : grplan) pcoricFile;
031400180628        if not %found;
031500180628         pcat = intype;
031600180628         write pcoricFile;
031700180628        endif;
031800180628
031900180628       endsr;
032000180628
032100170524      //==========================================================================
032200170524      // exit
032300170524      //==========================================================================
032400170524
032500170629       begsr exit;
032600170524
032700170524        *inlr = '1';
032800170524        return;
032900170524
033000170524       endsr;
033100170524
033200170524      //==========================================================================
033300170524      // init
033400170524      //==========================================================================
033500170524
033600170524       begsr init;
033700170524
033800180627        // Beginning day of last year...
033900180626        #bgn = %dec(%char(%dec(*year - 1)) + %editc(%dec('0101':4:0):'X'):8:0);
034000180626
034100180626        // End day of last year...
034200180626        #end = %dec(%char(%dec(*year - 1)) + %editc(%dec('1231':4:0):'X'):8:0);
034300190122
034301190717        if inFromDate > 0;
034302190717         #bgn = inFromDate;
034303190717        endif;
034304190717
034305190717        if inToDate > 0;
034306190717         #end = inToDate;
034307190717        endif;
034308190717
034400190123       //#bgn = 20150101;
034500190123       //#end = 20151231;
034600190122
034700170524       endsr;
034800170524
034900170524      //==========================================================================
