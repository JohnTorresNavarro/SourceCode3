000100161020      *============================================================================
000200151111     H option(*noDebugIo)
000300161020      *============================================================================
000400160107
000500161024     Fadvxref   o    e             disk    rename(advxrefr:xrefFile)
000600160107
000700161020     Fgrate     if   e           k disk    rename(grater:rateFile)
000800161024     F                                     extfile('QS36F/F.GRATE')
000900151111
001000161024     Fgratehold uf a e           k disk    rename(gratehr:holdFile) usropn
001100161020
001200161020      *============================================================================
001300161020
001400161021     d trust           s              3  0
001500161021     d sub#            s              3  0
001600161021     d acct            s              4  0
001700161021     d plan            s              4
001800161021     d today           s              8  0
001900161021     d count           s              1  0
002000161024     d command         s            512
002100161024     d x               s              1  0
002200161122     d foundRecord     s              1
002300161024
002400161021     d covtype         ds             6
002500161021     d  covtype1                      3
002600161021     d  covtype2                      3
002700160107
002800161024     d cmd             Pr                  ExtPgm('QCMDEXC')
002900161024     d   command                    200a   Const
003000161024     d   length                      15p 5 Const
003100161024
003200161020      //===========================================================================
003300161020      // mainline
003400161020      //===========================================================================
003500161020
003600161020       exsr init;
003700161020       exsr main;
003800161020       exsr exit;
003900161020
004000161020      //===========================================================================
004100161020      // main
004200161020      //===========================================================================
004300161020
004400161020       begsr main;
004500161020
004600161021        exsr first_secondPass;
004700161021        exsr countRecords;
004800161021        exsr tiers;
004900161024        exsr create_xRef;
005000161021
005100161020       endsr;
005200161020
005300161021      //===========================================================================
005400161021      // First and Second passes
005500161021      //===========================================================================
005600161021
005700161021       begsr first_secondPass;
005800161021
005900161122        foundRecord = 'N';
006000161122
006100161024        for x = 1 to 2;
006200161024
006300161021        setll (trust : sub# : plan) rateFile;
006400161021        reade (trust : sub# : plan) rateFile;
006500161021
006600161021        dow not %eof;
006700161021
006800161021         if (today >= frmdat) and (today <= todat);
006900161021          chain (trust : sub# : acct: plan : bilrte) holdFile;
007000161021
007100161021          if not %found;
007200161122           foundRecord = 'Y';
007300161122            trst = trust;
007400161122             sub = sub#;
007500161122              plan = plan;
007600161122               covtype1 = typecd;
007700161021             type = covtype;
007800161021            rate = bilrte;
007900161021           write holdFile;
008000161021          else;
008100161122           foundRecord = 'Y';
008200161021            %subst(type:4:3) = typecd;
008300161021           update holdFile;
008400161021          endif;
008500161021
008600161021         endif;
008700161021
008800161021        reade (trust : sub# : plan) rateFile;
008900161021        enddo;
009000161122
009100161122        if foundRecord = 'N';
009200161122
009300161122        setll (trust : sub# : plan) rateFile;
009400161122        reade (trust : sub# : plan) rateFile;
009500161122
009600161122        dow not %eof;
009700161122         if frmdat > today;
009800161122          chain (trust : sub# : acct: plan : bilrte) holdFile;
009900161122
010000161122          if not %found;
010100161122            trst = trust;
010200161122             sub = sub#;
010300161122              plan = plan;
010400161122               covtype1 = typecd;
010500161122             type = covtype;
010600161122            rate = bilrte;
010700161122           write holdFile;
010800161122          else;
010900161122            %subst(type:4:3) = typecd;
011000161122           update holdFile;
011100161122          endif;
011200161122
011300161122         endif;
011400161122
011500161122        reade (trust : sub# : plan) rateFile;
011600161122        enddo;
011700161122
011800161122        endif;
011900161122
012000161024        endfor;
012100161021
012200161021       endsr;
012300161021
012400161021      //===========================================================================
012500161021      // Count Records
012600161021      //===========================================================================
012700161021
012800161021       begsr countRecords;
012900161021
013000161021        setll *loval holdFile;
013100161021        read holdFile;
013200161021
013300161021        dow not %eof;
013400161021
013500161021        count = count + 1;
013600161021
013700161021        read holdFile;
013800161021        enddo;
013900161021
014000161021       endsr;
014100161021
014200161021      //===========================================================================
014300161021      // tiers
014400161021      //===========================================================================
014500161021
014600161021       begsr tiers;
014700161021
014800170510        if count = 2;
014900170510        setll *loval holdFile;
015000170510        read holdFile;
015100170510
015200170510        dow not %eof;
015300170510
015400170510        covtype = type;
015500170510
015600170510        select;
015700170510         when covtype1 = 'TIN' or covtype2 = 'TIN';
015800170510         typecr = 'EMP';
015900170510
016000170510         other;
016100170510         typecr = 'FAM';
016200170510
016300170510        endsl;
016400170510
016500170510        update holdfile;
016600170510
016700170510        read holdFile;
016800170510        enddo;
016900170510        endif;
017000170510
017100161021        if count = 3;
017200161021        setll *loval holdFile;
017300161021        read holdFile;
017400161021
017500161021        dow not %eof;
017600161021
017700161021        covtype = type;
017800161021
017900161021        select;
018000161021         when covtype1 = 'TIN' or covtype2 = 'TIN';
018100161021         typecr = 'EMP';
018200161021
018300161021         when covtype1 = 'TFA' or covtype2 = 'TFA';
018400161021         typecr = 'FAM';
018500161021
018600161021         other;
018700161021         typecr = 'E1D';
018800161021
018900161021        endsl;
019000161021
019100161021        update holdfile;
019200161021
019300161021        read holdFile;
019400161021        enddo;
019500161021        endif;
019600161021
019700161021        if count = 4;
019800161021        setll *loval holdFile;
019900161021        read holdFile;
020000161021
020100161021        dow not %eof;
020200161021
020300161021        covtype = type;
020400161021
020500161021        select;
020600161021         when covtype1 = 'TIN' or covtype2 = 'TIN';
020700161021         typecr = 'EMP';
020800161021
020900161021         when covtype1 = 'TFA' or covtype2 = 'TFA';
021000161021         typecr = 'FAM';
021100161021
021200161021         when covtype1 = 'THW' or covtype2 = 'THW';
021300161021         typecr = 'ESP';
021400161021
021500161021         other;
021600161021         typecr = 'ECH';
021700161021
021800161021        endsl;
021900161021
022000161021        update holdfile;
022100161021
022200161021        read holdFile;
022300161021        enddo;
022400161021        endif;
022500161021
022600161021       endsr;
022700161021
022800161024      //===========================================================================
022900161024      // create_xRef
023000161024      //===========================================================================
023100161024
023200161024       begsr create_xRef;
023300161024
023400170510        if count = 2;
023500170510
023600170510        setll *loval holdFile;
023700170510        read holdFile;
023800170510
023900170510        dow not %eof;
024000170510
024100170510        advtier = '2TIER';
024200170510
024300170510        advtrust = trust;
024400170510        advsub# = sub#;
024500170510        advacct = acct;
024600170510        advplan = plan;
024700170510
024800170510        if type = 'TINTIN';
024900170510         advcode1a = 'TIN';
025000170510          advcode1b = 'EMP';
025100170510         write xrefFile;
025200170510        endif;
025300170510
025400170510        if type = 'THWTPC';
025500170510         advcode1a = 'THW';
025600170510          advcode1b = 'FAM';
025700170510         write xrefFile;
025800170510         advcode1a = 'TPC';
025900170510          advcode1b = 'FAM';
026000170510         write xrefFile;
026100170510        endif;
026200170510
026300170510        if type = 'TFATP2';
026400170510         advcode1a = 'TFA';
026500170510          advcode1b = 'FAM';
026600170510         write xrefFile;
026700170510         advcode1a = 'TP2';
026800170510          advcode1b = 'FAM';
026900170510         write xrefFile;
027000170510        endif;
027100170510
027200170510        if type = 'TPCTP2';
027300170510         advcode1a = 'TPC';
027400170510          advcode1b = 'FAM';
027500170510         write xrefFile;
027600170510        endif;
027700170510
027800170510        if type = 'TP2TPC';
027900170510         advcode1a = 'TP2';
028000170510          advcode1b = 'FAM';
028100170510         write xrefFile;
028200170510        endif;
028300170510
028400170510        read holdFile;
028500170510        enddo;
028600170510
028700170510       endif;
028800170510
028900161024        if count = 3;
029000161024
029100161024        setll *loval holdFile;
029200161024        read holdFile;
029300161024
029400161024        dow not %eof;
029500161024
029600161024        advtier = '3TIER';
029700161024
029800161024        advtrust = trust;
029900161024        advsub# = sub#;
030000161024        advacct = acct;
030100161024        advplan = plan;
030200161024
030300161024        if type = 'TINTIN';
030400161024         advcode1a = 'TIN';
030500161024          advcode1b = 'EMP';
030600161024         write xrefFile;
030700161024        endif;
030800161024
030900161024        if type = 'THWTPC';
031000161024         advcode1a = 'THW';
031100161024          advcode1b = 'E1D';
031200161024         write xrefFile;
031300161024         advcode1a = 'TPC';
031400161024          advcode1b = 'E1D';
031500161024         write xrefFile;
031600161024        endif;
031700161024
031800161024        if type = 'TFATP2';
031900161024         advcode1a = 'TFA';
032000161024          advcode1b = 'FAM';
032100161024         write xrefFile;
032200161024         advcode1a = 'TP2';
032300161024          advcode1b = 'FAM';
032400161024         write xrefFile;
032500161024        endif;
032600161024
032700161024        if type = 'TPCTP2';
032800161024         advcode1a = 'TPC';
032900161024          advcode1b = 'E1D';
033000161024         write xrefFile;
033100161024        endif;
033200161024
033300161024        if type = 'TP2TPC';
033400161024         advcode1a = 'TP2';
033500161024          advcode1b = 'E1D';
033600161024         write xrefFile;
033700161024        endif;
033800161024
033900161024        read holdFile;
034000161024        enddo;
034100161024
034200161024       endif;
034300161024
034400161024        if count = 4;
034500161024
034600161024        setll *loval holdFile;
034700161024        read holdFile;
034800161024
034900161024        dow not %eof;
035000161024
035100161024        advtier = '4TIER';
035200161024
035300161024        advtrust = trust;
035400161024        advsub# = sub#;
035500161024        advacct = acct;
035600161024        advplan = plan;
035700161024
035800161024        if type = 'TINTIN';
035900161024         advcode1a = 'TIN';
036000161024          advcode1b = 'EMP';
036100161024         write xrefFile;
036200161024        endif;
036300161024
036400161024        if type = 'THWTHW';
036500161024         advcode1a = 'THW';
036600161024          advcode1b = 'ESP';
036700161024         write xrefFile;
036800161024        endif;
036900161024
037000161024        if type = 'TFATFA';
037100161024         advcode1a = 'TFA';
037200161024          advcode1b = 'FAM';
037300161024         write xrefFile;
037400161024        endif;
037500161024
037600161024        if type = 'TPCTP2';
037700161024         advcode1a = 'TPC';
037800161024          advcode1b = 'ECH';
037900161024         write xrefFile;
038000161024         advcode1a = 'TP2';
038100161024          advcode1b = 'ECH';
038200161024         write xrefFile;
038300161024        endif;
038400161024
038500161024        if type = 'TP2TPC';
038600161024         advcode1a = 'TP2';
038700161024          advcode1b = 'ECH';
038800161024         write xrefFile;
038900161024         advcode1a = 'TPC';
039000161024          advcode1b = 'ECH';
039100161024         write xrefFile;
039200161024        endif;
039300161024
039400161024        read holdFile;
039500161024        enddo;
039600161024
039700161024       endif;
039800161024       endsr;
039900161024
040000161020      //===========================================================================
040100161020      // exit
040200161020      //===========================================================================
040300161020
040400161020       begsr exit;
040500161020
040600161024        if %open(gratehold);
040700161024         close gratehold;
040800161024        endif;
040900161024
041000161024        *inlr = '1';
041100161020        return;
041200161020
041300161020       endsr;
041400161020
041500161020      //===========================================================================
041600161020      // init
041700161020      //===========================================================================
041800161020
041900161020       begsr init;
042000161020
042100161020     C     *entry        plist
042200161020     C                   parm                    trust
042300161020     c                   parm                    sub#
042400161021     c                   parm                    acct
042500161020     c                   parm                    plan
042600161020
042700161021        today = %dec(%date);
042800161021        count = 0;
042900161021
043000161024        command = 'clrpfm gratehold';
043100161024        cmd(%trim(command): %len(%trim(command)));
043200161024
043300161024        if not %open(gratehold);
043400161024         open gratehold;
043500161024        endif;
043600161024
043700161020       endsr;
043800151111
043900161020      //===========================================================================
