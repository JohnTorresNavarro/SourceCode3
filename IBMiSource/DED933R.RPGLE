000100180326      *=========================================================================
000200180326     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300180326      *=========================================================================
000400211218      * DED933R - Denta Dental Mapping drill down
000500180326      *========================================================================
000600180326      * Date         Int  Description
000700180326      * ---------    ---  -----------------------------------------------------
000800211218      * 12/18/2021   jt   Original Creation
001000180326      *========================================================================
001100100520
001200211218     Fded933d   cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
001300100520     F                                     SFile(SFL1 : RRN)
001400180906
001500180906     Faccmst    if   e           k disk    ExtFile('F.ACCMST')
001600180906     F                                     rename(accmsr:acctFile)
001700180906
001800180907     fcarplnx   uf a e           k disk    rename(carplnr:mainFile)
001900180410
002000180906     fplnmst    if   e           k disk    extfile('F.PLNMST')
002100180906     f                                     rename(plnmsr:planFile)
002200180322
002201201006     fplnauxl   if   e           k disk    rename(plnauxr:auxFile)
002203201006
002300180907     fcarplnp   uf a e           k disk    rename(carplnr:mainFile2)
002400180907
002500170829      *=========================================================================
002600170829
002700170907     d psds           sds
002800170907     d proc_name         *proc
002900180404     d user                  254    263
003000170907
003100170829     d rrn             s              5i 0
003200180320     d addEdit         s              1
003300180404     d trstk           s              3  0
003400180404     d sub#k           s              3  0
003500180404     d acctk           s              4  0
003600180410     d valid           s              1
003700180629     d carrier         s              2  0
003800180705     d option          s              1
003900180906     d unique          s             10
004000180907     d runique         s             10
004100180910     d hunique         s             10
004200180906     d fndFacets       s              1
004300180906     d fnd_nonFacets   s              1
004400180906     d ptsa            s             11
004500180906
004501200624     d showMembers     pr                  ExtPgm('MEMCOVR')
004502200624     d  ptrst                         3  0 const
004503200624     d  psub#                         3  0 const
004504200624     d  pacct                         4  0 const
004505200624     d  plan                          4    const
004507200624
004600211218     d ded933r         pi
004700180907     d  ptrst                         3  0 const
004800180907     d  psub#                         3  0 const
004900180907     d  pacct                         4  0 const
005000180907
005100170829      //========================================================================
005200180320      // mainline
005300180320      //========================================================================
005400170829
005500170829       exsr init;
005600170829       exsr main;
005700170829       exsr exit;
005800170829
005900170829      //========================================================================
006000170829      // main
006100170829      //========================================================================
006200170829
006300170829       begsr main;
006400170829
006500170829        dow btnEXIT = '0';
006600100520
006700180326         // Clear the subfile...
006800170829         sflclr = '1';
006900170829
007000170829         write sflctl1;
007100170829         sflclr = '0';
007200170829         rrn = 0;
007300100520
007400170829         // Load the subfile...
007500170831         exsr loadSubfile;
007600100520
007700170829         // Display the subfile.
007800170829         sfldsp = '1';
007900170829         exfmt sflctl1;
008000180323
008100170831         exsr checkButton;
008200170829
008300170829         sfldsp = '1';
008400170829
008500180326        // Check for icon click.
008600170829        readc sfl1;
008700170829        if not %eof;
008800170829
008900170829         //Lock record for update, if in change mode.
009000170830         if buttonEdit ='1';
009100180622          exsr editRecord;
009200170829         endif;
009300170829
009400180907         if buttonDsp ='1';
009500180910          exsr displayRcd;
009600180622         endif;
009700180622
009800180914         if ar <> actret2;
009900180910          exsr activeRetire;
010000180910         endif;
010001200624
010100200624         if selplan = '1';
010101200624          exsr showPlan;
010102200624         endif;
010104200624
010200170829        endif;
010300170829       enddo;
010400170829
010500170829       endsr;
010600170829
010700170831      //========================================================================
010800170831      // load subfile
010900170831      //========================================================================
011000170831
011100170831       begsr loadSubfile;
011200180404
011300190903        if posPlan > ' ';
011400190903         setll (ptrst : psub# : pacct : posPlan) mainFile;
011500190903        else;
011600190903         setll (ptrst : psub# : pacct) mainFile;
011700190903        endif;
011800190903
011900210309        reade(n) (ptrst : psub# : pacct) mainFile;
012000180320
012100180409        dow not %eof;
012200180907
012300180907         if cpuniq = unique or cpuniq = runique;
012302210811
012303210811          if activeOnly = 'Y';
012304210811
012305210811           if cpuniq = unique;
012400210811            rrn += 1;
012500210811             exsr moveFields;
012600210811            write sfl1;
012700210811           endif;
012701210811
012702210811          else;
012703210811           rrn += 1;
012704210811            exsr moveFields;
012705210811           write sfl1;
012706210811          endif;
012707210811
012708210811         endif;
012800180322
012900210309        reade(n) (ptrst : psub# : pacct) mainFile;
013000180907        enddo;
013100180404
013200200313        //posPlan = ' ';
013300190903
013400170831       endsr;
013500170831
013600180322      //========================================================================
013700180322      // move fields
013800180322      //========================================================================
013900180322
014000180322       begsr moveFields;
014100180322
014200180907        plan = cpplan;
014400180907
014500180907        chain (ptrst : psub# : cpplan) planFile;
014600180907        if %found;
014700180907         pdesc = pdescr;
014800180907        endif;
014900180907
015000180914        //ar = %subst(cpuniq:1:1);
015100180914
015200180907        actret = 'ACTIVE';
015300180907        actret2 = '1';
015400180914        ar = '1';
015500180907        if %subst(cpuniq:1:1) = '9';
015600180907         actret = 'RETIRE';
015700180914         ar = '0';
015800180907        actret2 = '0';
015900180907        endif;
016000180703
016100180322       endsr;
016200180322
016300180907      //========================================================================
016400180907      // load fields
016500180907      //========================================================================
016600180907
016700180907       begsr loadFields;
016800180907
016900180910        if actret = ('ACTIVE');
017000180910         hunique = unique;
017100180910        else;
017200180910         hunique = runique;
017300180910        endif;
017400180910
017500211218        chain(n) (hunique : ptrst : psub# : pacct :  ' ' : plan) mainfile2;
017600180910
017800180907        splan = cpplan;
018300180907
018400180907        chain (ptrst : psub# : cpplan) planFile;
018500180907        if %found;
018600180907         spdesc = pdescr;
018700180907        endif;
018800180907
018900180907        acctname  = taname;
019000180907
019100180907       endsr;
019200180907
019300180410      //========================================================================
019400180410      // checkButton
019500180410      //========================================================================
019600180410
019700180410       begsr checkButton;
019800180410
019900180410        if buttonEdit = '1';
020000180410         exsr editRecord;
020100180410        endif;
020200180410
020300180410        if buttonAdd  = '1';
020400180410         exsr addRcd;
020500180410        endif;
020600180622
020601200313        if btnRefresh  = '1';
020602200313         posPlan = ' ';
020603200313         btnRefresh = '0';
020604200313        endif;
020605200313
020700180410       endsr;
020800180410
020900170830      //========================================================================
021000180410      // add record
021100170830      //========================================================================
021200170830
021300180410       begsr addRcd;
021400170831
021500180410        addRecord = '0';
021600180410        btnExtAdd = '0';
021700180907        strst = ptrst;
021800180907        ssub# = psub#;
021900180907        sacct = pacct;
022000181018        splan = ' ';
022600181018        spdesc = ' ';
022700180907        errPlan = '0';
022800180910        errInvPlan = '0';
023400180705
023500180410        dow btnExtAdd = '0';
023600180409
023700180410         exfmt adddtl;
023800180410
023900180410         if btnExtAdd = '1';
024000180410          leavesr;
024100180410         endif;
024200180410
024300180410         exsr validAdd;
024400180410
024500180906         if valid  = '1';
024600180906          btnExtAdd = '0';
024700180906         else;
024800180906          btnExtAdd = '1';
024900180906         endif;
025000180409
025100180410        enddo;
025200180409
025300170830       endsr;
025400170830
025500180907      //========================================================================
025600180907      // add record
025700180907      //========================================================================
025800180907
025900180907       begsr activeRetire;
026000180907
026100211218        chain (unique : ptrst : psub# : pacct : ' ' : plan) mainfile2;
026200180907        if %found;
026300180907
026400211218         if cpuniq = '0000000391';
026500211218          cpuniq = '9000000391';
026600180907          update mainfile2;
026700180907         endif;
026800180907
026900180907         leavesr;
027000180907        endif;
027100180907
027200211218        chain (runique : ptrst : psub# : pacct : ' ' : plan) mainfile2;
027300180907        if %found;
027400211218         if cpuniq = '9000000391';
027500211218          cpuniq = '0000000391';
027600180907          update mainfile2;
027700180907         endif;
027800180907
027900180907         leavesr;
028000180907        endif;
028100180907
028200180907       endsr;
028300180907
028400180622      //========================================================================
028500180622      // delete record
028600180622      //========================================================================
028700180622
028800180907       begsr displayRcd;
028900180622
029000180907        btnExtDsp = '0';
029100180907        strst = ptrst;
029200180907        ssub# = psub#;
029300180907        sacct = pacct;
029400180907
029500180907        dow btnExtDsp = '0';
029600180907
029700180907         exsr loadFields;
029800180907
029900180907         exfmt dspdtl;
030000180907
030100180907        enddo;
030200180907
030300180907        buttonDsp = '0';
030400180906
030500180622       endsr;
030600180622
030700170829      //========================================================================
030800170829      // valid record
030900170829      //========================================================================
031000170829
031100180907       begsr validAdd;
031200170830
031300180907        valid = '0';
031400180907        strst = ptrst;
031500180907        ssub# = psub#;
031600180907        sacct = pacct;
031700180907        errPlan = '0';
031800180910        errInvPlan = '0';
032400180410
032500180907        if splan = ' ';
032600180907         errPlan = '1';
032700180907         valid = '1';
032800180907        endif;
032900180906
033000180910        if splan > ' ';
033100201214         chain (strst : ssub# : sacct : splan) auxFile;
033200180910         if not %found;
033300201214          errInvPlan = '1';
033400201214          valid = '1';
033500180910         endif;
033600180910        endif;
035200180907
036300180907        if valid = '0';
036400180907         exsr addRecd;
036500180907        endif;
036600170906
036700180907       endsr;
036800170829
036900170906      //========================================================================
037000170906      // valid add
037100170906      //========================================================================
037200170906
037300180907       begsr addRecd;
037400180907
037500180907        cpuniq = unique;
037600180907        cptrst = ptrst;
037700180907        cpsub# = psub#;
037800180907        cpacct = pacct;
038000180907        cpplan = splan;
038100180907        cpcid1 = 'HMO';
038200180907        cptxt1 = 'LAYOUT CODE';
038400180907        cptxt2 = 'FILE NUMBER';
038600180907        cptxt3 = 'CLASS CODE';
038800180907        cptxt4 = 'PLAN';
039000180907        cptxt5 = 'COVERAGE TYPE';
039100180907
039200180907        write mainFile;
039300180907
039400180907       endsr;
039500170830
039600170829      //========================================================================
039700180410      // edit record
039800180410      //========================================================================
039900180410
040000180410       begsr editRecord;
040100180410
040200180622        btnUpdRcd = '0';
040300180410        btnExtEdt = '0';
040400180907        strst = ptrst;
040500180907        ssub# = psub#;
040600180907        sacct = pacct;
040700180907        errPlan = '0';
040800180910        errInvPlan = '0';
041400180410
041500180410        dow btnExtEdt = '0';
041600180410
041700180907         exsr loadFields;
041800180907
041900180410         exfmt maintdtl;
042000180410
042100180622         if btnUpdRcd = '1';
042200180622          exsr validEdit;
042300180622         endif;
042400180410
042500180410        enddo;
042600180622
042700180622        buttonEdit = '0';
042800180410
042900180410       endsr;
043000180410
043100180410      //========================================================================
043200180410      // valid record
043300180410      //========================================================================
043400180410
043500180907       begsr validEdit;
043600180410
043700180907        valid = '0';
043800180907        errPlan = '0';
043900180910        errInvPlan = '0';
044500180906
044600180907        if splan = ' ';
044700180907         errPlan = '1';
044800180907         valid = '1';
044900180907        endif;
045000180907
045100180910        if splan > ' ';
045200201214         chain (strst : ssub# : sacct : splan) auxFile;
045300180910         if not %found;
045400201214          errInvPlan = '1';
045500201214          valid = '1';
045600180910         endif;
045700180910        endif;
045800180910
048400180907        if valid = '0';
048500180907         exsr edtRecord;
048600180907         btnExtEdt = '1';
048700180907        endif;
048800180410
048900180410        endsr;
049000180410
049001200624      //========================================================================
049002200624      // show members for plan
049003200624      //========================================================================
049004200624
049005200624       begsr showPlan;
049006200624
049007200624        showMembers(ptrst : psub# : pacct : plan);
049008200624
049009200624        selplan = '0';
049010200624
049011200624       endsr;
049012200624
049100180410      //========================================================================
049200180410      // valid add
049300180410      //========================================================================
049400180410
049500180907       begsr edtRecord;
049600180410
049700180910        if actret = ('ACTIVE');
049800180910         hunique = unique;
049900180910        else;
050000180910         hunique = runique;
050100180910        endif;
050200180910
050300211218        chain (hunique : ptrst : psub# : pacct :  ' ' : plan) mainfile2;
050400180410
050600180907        cpplan = splan;
051100180907
051200180907        update mainFile2;
051300180410
051400180907       endsr;
051500180906
051600180622      //========================================================================
051700170829      // exit
051800170829      //========================================================================
051900170829
052000170829       begsr exit;
052100170829
052200170829        *inlr = '1';
052300170829        return;
052400100520
052500170829       endsr;
052600170829
052700170829      //========================================================================
052800170829      // init
052900170829      //========================================================================
053000170829
053100170829       begsr init;
053200170829
053300170829        btnREFRESH = '0';
053400170829        btnEXIT = '0';
053500180622        btnUpdRcd = '0';
053600180907        buttonDsp = '0';
053700170831        buttonEdit = '0';
053800180404        buttonAdd = '0';
053801200624        selplan = '0';
053802210811        activeOnly = 'N';
053900180622
054000180622        sfldsp = '0';
054100180622        sflclr = '0';
054200180622
054300170913        pgmname = proc_name;
054400180706
054500211218        title = 'Delta Dental Account Plan Mapping';
054600180906
054700211218        unique = '0000000391';
054800211218        runique = '9000000391';
054900180710
055000180907        ttrst = %editc(ptrst:'X');
055100180907        tsub# = %editc(psub#:'X');
055200180907        tacct = %editc(pacct:'X');
055300180907
055400180907        chain (ptrst : psub# : pacct) acctFile;
055500180907        if %found;
055600180907         taname = acnam1;
055700180907        endif;
055800180907
055900170829       endsr;
056000170829
056100170829      //========================================================================
