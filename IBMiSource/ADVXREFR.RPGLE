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
001400161021     d today           s              8  0
001500161021     d count           s              1  0
001600161024     d command         s            512
001700161024     d x               s              1  0
001800161122     d foundRecord     s              1
001900161024
002000161021     d covtype         ds             6
002100161021     d  covtype1                      3
002200161021     d  covtype2                      3
002300160107
002400161024     d cmd             Pr                  ExtPgm('QCMDEXC')
002500161024     d   command                    200a   Const
002600161024     d   length                      15p 5 Const
002700161024
002800170510     D advxrefr        pi
002900170510     d  trust                         3  0
003000170510     d  sub#                          3  0
003100170510     d  acct                          4  0
003200170510     d  plan                          4
003300170510
003400161020      //===========================================================================
003500161020      // mainline
003600161020      //===========================================================================
003700161020
003800161020       exsr init;
003900161020       exsr main;
004000161020       exsr exit;
004100161020
004200161020      //===========================================================================
004300161020      // main
004400161020      //===========================================================================
004500161020
004600161020       begsr main;
004700161020
004800161021        exsr first_secondPass;
004900161021        exsr countRecords;
005000161021        exsr tiers;
005100161024        exsr create_xRef;
005200161021
005300161020       endsr;
005400161020
005500161021      //===========================================================================
005600161021      // First and Second passes
005700161021      //===========================================================================
005800161021
005900161021       begsr first_secondPass;
006000161021
006100161122        foundRecord = 'N';
006200161122
006300161024        for x = 1 to 2;
006400161024
006500161021        setll (trust : sub# : plan) rateFile;
006600161021        reade (trust : sub# : plan) rateFile;
006700161021
006800161021        dow not %eof;
006900161021
007000161021         if (today >= frmdat) and (today <= todat);
007100161021          chain (trust : sub# : acct: plan : bilrte) holdFile;
007200161021
007300161021          if not %found;
007400161122           foundRecord = 'Y';
007500161122            trst = trust;
007600161122             sub = sub#;
007700161122              plan = plan;
007800161122               covtype1 = typecd;
007900161021             type = covtype;
008000161021            rate = bilrte;
008100161021           write holdFile;
008200161021          else;
008300161122           foundRecord = 'Y';
008400161021            %subst(type:4:3) = typecd;
008500161021           update holdFile;
008600161021          endif;
008700161021
008800161021         endif;
008900161021
009000161021        reade (trust : sub# : plan) rateFile;
009100161021        enddo;
009200161122
009300161122        if foundRecord = 'N';
009400161122
009500161122        setll (trust : sub# : plan) rateFile;
009600161122        reade (trust : sub# : plan) rateFile;
009700161122
009800161122        dow not %eof;
009900161122         if frmdat > today;
010000161122          chain (trust : sub# : acct: plan : bilrte) holdFile;
010100161122
010200161122          if not %found;
010300161122            trst = trust;
010400161122             sub = sub#;
010500161122              plan = plan;
010600161122               covtype1 = typecd;
010700161122             type = covtype;
010800161122            rate = bilrte;
010900161122           write holdFile;
011000161122          else;
011100161122            %subst(type:4:3) = typecd;
011200161122           update holdFile;
011300161122          endif;
011400161122
011500161122         endif;
011600161122
011700161122        reade (trust : sub# : plan) rateFile;
011800161122        enddo;
011900161122
012000161122        endif;
012100161122
012200161024        endfor;
012300161021
012400161021       endsr;
012500161021
012600161021      //===========================================================================
012700161021      // Count Records
012800161021      //===========================================================================
012900161021
013000161021       begsr countRecords;
013100161021
013200161021        setll *loval holdFile;
013300161021        read holdFile;
013400161021
013500161021        dow not %eof;
013600161021
013700161021        count = count + 1;
013800161021
013900161021        read holdFile;
014000161021        enddo;
014100161021
014200161021       endsr;
014300161021
014400161021      //===========================================================================
014500161021      // tiers
014600161021      //===========================================================================
014700161021
014800161021       begsr tiers;
014900161021
015000170510        if count = 2;
015100170510        setll *loval holdFile;
015200170510        read holdFile;
015300170510
015400170510        dow not %eof;
015500170510
015600170510        covtype = type;
015700170510
015800170510        select;
015900170510         when covtype1 = 'TIN' or covtype2 = 'TIN';
016000170510         typecr = 'EMP';
016100170510
016200170510         other;
016300170510         typecr = 'FAM';
016400170510
016500170510        endsl;
016600170510
016700170510        update holdfile;
016800170510
016900170510        read holdFile;
017000170510        enddo;
017100170510        endif;
017200170510
017300161021        if count = 3;
017400161021        setll *loval holdFile;
017500161021        read holdFile;
017600161021
017700161021        dow not %eof;
017800161021
017900161021        covtype = type;
018000161021
018100161021        select;
018200161021         when covtype1 = 'TIN' or covtype2 = 'TIN';
018300161021         typecr = 'EMP';
018400161021
018500161021         when covtype1 = 'TFA' or covtype2 = 'TFA';
018600161021         typecr = 'FAM';
018700161021
018800161021         other;
018900161021         typecr = 'E1D';
019000161021
019100161021        endsl;
019200161021
019300161021        update holdfile;
019400161021
019500161021        read holdFile;
019600161021        enddo;
019700161021        endif;
019800161021
019900161021        if count = 4;
020000161021        setll *loval holdFile;
020100161021        read holdFile;
020200161021
020300161021        dow not %eof;
020400161021
020500161021        covtype = type;
020600161021
020700161021        select;
020800161021         when covtype1 = 'TIN' or covtype2 = 'TIN';
020900161021         typecr = 'EMP';
021000161021
021100161021         when covtype1 = 'TFA' or covtype2 = 'TFA';
021200161021         typecr = 'FAM';
021300161021
021400161021         when covtype1 = 'THW' or covtype2 = 'THW';
021500161021         typecr = 'ESP';
021600161021
021700161021         other;
021800161021         typecr = 'ECH';
021900161021
022000161021        endsl;
022100161021
022200161021        update holdfile;
022300161021
022400161021        read holdFile;
022500161021        enddo;
022600161021        endif;
022700161021
022800161021       endsr;
022900161021
023000161024      //===========================================================================
023100161024      // create_xRef
023200161024      //===========================================================================
023300161024
023400161024       begsr create_xRef;
023500161024
023600170510        if count = 2;
023700170510
023800170510        setll *loval holdFile;
023900170510        read holdFile;
024000170510
024100170510        dow not %eof;
024200170510
024300170510        advtier = '2TIER';
024400170510
024500170510        advtrust = trust;
024600170510        advsub# = sub#;
024700170510        advacct = acct;
024800170510        advplan = plan;
024900170510
025000170510        if type = 'TINTIN';
025100170510         advcode1a = 'TIN';
025200170510          advcode1b = 'EMP';
025300170510         write xrefFile;
025400170510        endif;
025500170510
025600170510        if type = 'THWTPC';
025700170510         advcode1a = 'THW';
025800170510          advcode1b = 'FAM';
025900170510         write xrefFile;
026000170510         advcode1a = 'TPC';
026100170510          advcode1b = 'FAM';
026200170510         write xrefFile;
026300170510        endif;
026400170510
026500170510        if type = 'TFATP2';
026600170510         advcode1a = 'TFA';
026700170510          advcode1b = 'FAM';
026800170510         write xrefFile;
026900170510         advcode1a = 'TP2';
027000170510          advcode1b = 'FAM';
027100170510         write xrefFile;
027200170510        endif;
027300170510
027400170510        if type = 'TPCTP2';
027500170510         advcode1a = 'TPC';
027600170510          advcode1b = 'FAM';
027700170510         write xrefFile;
027800170510        endif;
027900170510
028000170510        if type = 'TP2TPC';
028100170510         advcode1a = 'TP2';
028200170510          advcode1b = 'FAM';
028300170510         write xrefFile;
028400170510        endif;
028500170510
028600170510        read holdFile;
028700170510        enddo;
028800170510
028900170510       endif;
029000170510
029100161024        if count = 3;
029200161024
029300161024        setll *loval holdFile;
029400161024        read holdFile;
029500161024
029600161024        dow not %eof;
029700161024
029800161024        advtier = '3TIER';
029900161024
030000161024        advtrust = trust;
030100161024        advsub# = sub#;
030200161024        advacct = acct;
030300161024        advplan = plan;
030400161024
030500161024        if type = 'TINTIN';
030600161024         advcode1a = 'TIN';
030700161024          advcode1b = 'EMP';
030800161024         write xrefFile;
030900161024        endif;
031000161024
031100161024        if type = 'THWTPC';
031200161024         advcode1a = 'THW';
031300161024          advcode1b = 'E1D';
031400161024         write xrefFile;
031500161024         advcode1a = 'TPC';
031600161024          advcode1b = 'E1D';
031700161024         write xrefFile;
031800161024        endif;
031900161024
032000161024        if type = 'TFATP2';
032100161024         advcode1a = 'TFA';
032200161024          advcode1b = 'FAM';
032300161024         write xrefFile;
032400161024         advcode1a = 'TP2';
032500161024          advcode1b = 'FAM';
032600161024         write xrefFile;
032700161024        endif;
032800161024
032900161024        if type = 'TPCTP2';
033000161024         advcode1a = 'TPC';
033100161024          advcode1b = 'E1D';
033200161024         write xrefFile;
033300161024        endif;
033400161024
033500161024        if type = 'TP2TPC';
033600161024         advcode1a = 'TP2';
033700161024          advcode1b = 'E1D';
033800161024         write xrefFile;
033900161024        endif;
034000161024
034100161024        read holdFile;
034200161024        enddo;
034300161024
034400161024       endif;
034500161024
034600161024        if count = 4;
034700161024
034800161024        setll *loval holdFile;
034900161024        read holdFile;
035000161024
035100161024        dow not %eof;
035200161024
035300161024        advtier = '4TIER';
035400161024
035500161024        advtrust = trust;
035600161024        advsub# = sub#;
035700161024        advacct = acct;
035800161024        advplan = plan;
035900161024
036000161024        if type = 'TINTIN';
036100161024         advcode1a = 'TIN';
036200161024          advcode1b = 'EMP';
036300161024         write xrefFile;
036400161024        endif;
036500161024
036600161024        if type = 'THWTHW';
036700161024         advcode1a = 'THW';
036800161024          advcode1b = 'ESP';
036900161024         write xrefFile;
037000161024        endif;
037100161024
037200161024        if type = 'TFATFA';
037300161024         advcode1a = 'TFA';
037400161024          advcode1b = 'FAM';
037500161024         write xrefFile;
037600161024        endif;
037700161024
037800161024        if type = 'TPCTP2';
037900161024         advcode1a = 'TPC';
038000161024          advcode1b = 'ECH';
038100161024         write xrefFile;
038200161024         advcode1a = 'TP2';
038300161024          advcode1b = 'ECH';
038400161024         write xrefFile;
038500161024        endif;
038600161024
038700161024        if type = 'TP2TPC';
038800161024         advcode1a = 'TP2';
038900161024          advcode1b = 'ECH';
039000161024         write xrefFile;
039100161024         advcode1a = 'TPC';
039200161024          advcode1b = 'ECH';
039300161024         write xrefFile;
039400161024        endif;
039500161024
039600161024        read holdFile;
039700161024        enddo;
039800161024
039900161024       endif;
040000161024       endsr;
040100161024
040200161020      //===========================================================================
040300161020      // exit
040400161020      //===========================================================================
040500161020
040600161020       begsr exit;
040700161020
040800161024        if %open(gratehold);
040900161024         close gratehold;
041000161024        endif;
041100161024
041200161024        *inlr = '1';
041300161020        return;
041400161020
041500161020       endsr;
041600161020
041700161020      //===========================================================================
041800161020      // init
041900161020      //===========================================================================
042000161020
042100161020       begsr init;
042200161020
042300161021        today = %dec(%date);
042400161021        count = 0;
042500161021
042600161024        command = 'clrpfm gratehold';
042700161024        cmd(%trim(command): %len(%trim(command)));
042800161024
042900161024        if not %open(gratehold);
043000161024         open gratehold;
043100161024        endif;
043200161024
043300161020       endsr;
043400151111
043500161020      //===========================================================================
