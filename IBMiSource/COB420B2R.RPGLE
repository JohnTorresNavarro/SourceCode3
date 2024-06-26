000100180326      *=========================================================================
000200180326     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300180326      *=========================================================================
000400200720      * COB420B2R - COBRA Member link to orig mem file maint
000500180326      *========================================================================
000600180326      * Date         Int  Description
000700180326      * ---------    ---  -----------------------------------------------------
000800200720      * 07/20/2020   jt   Original Creation
001700180326      *========================================================================
001800100520
001900200720     fcob420b2d cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
002000200720     f                                     SFile(SFL1 : RRN)
002100180320
002401200720     fmember    if   e           k disk    ExtFile('F.MEMBER')
002402200720     f                                     rename(membr:memberFile)
002403200720
003100200720     fmemmem    uf a e           k disk    rename(memmemr:linkFile)
003200180322
003300170829      *=========================================================================
003400170829
003500170907     d psds           sds
003600170907     d proc_name         *proc
003700180404     d user                  254    263
003800170907
003900170829     d rrn             s              5i 0
004000180320     d addEdit         s              1
004400180410     d valid           s              1
004600180705     d option          s              1
005200191218     d dsperrMsg       s              1
005301200720     d ssn             s              9s 0
005700200319
005800200720     d cob420b2r       pi
005900200720     d  p_ssn                         9    const
005901200722     d  optSelect                     1    const
006100180629
007800200720     d showSSN         pr                  ExtPgm('INQ002R')
007801200720     d  ssn                           9s 0 const
007802200720
009200170829      //========================================================================
009300180320      // mainline
009400180320      //========================================================================
009500170829
009600170829       exsr init;
009700170829       exsr main;
009800170829       exsr exit;
009900170829
010000170829      //========================================================================
010100170829      // main
010200170829      //========================================================================
010300170829
010400170829       begsr main;
010500170829
010600170829        dow btnEXIT = '0';
010700100520
010800180326         // Clear the subfile...
010900170829         sflclr = '1';
011000170829
011100170829         write sflctl1;
011200170829         sflclr = '0';
011300170829         rrn = 0;
011400100520
011500170829         // Load the subfile...
011600170831         exsr loadSubfile;
011700100520
011800170829         // Display the subfile.
011900170829         sfldsp = '1';
012000170829         exfmt sflctl1;
012100180323
012200170831         exsr checkButton;
012300170829
012400170829         sfldsp = '1';
012500170829
012600180326        // Check for icon click.
012700170829        readc sfl1;
012800170829        if not %eof;
012900170829
013000170829         //Lock record for update, if in change mode.
013100191218         if addEdit = 'Y';
013200191218          if buttonEdit ='1';
013300191218           exsr editRecord;
013400191218          endif;
013500170829
013600191218          if buttonDlt ='1';
013700191218           exsr dltRcd;
013800191218          endif;
013900180622
014000200720          if selssn = '1';
014100200720           exsr displaySSN;
014101200720           selssn = '0';
014200191218          endif;
014300191218         endif;
014400180913
014500170829        endif;
014600170829       enddo;
014700170829
014800170829       endsr;
014900170829
015000170831      //========================================================================
015100170831      // load subfile
015200170831      //========================================================================
015300170831
015400170831       begsr loadSubfile;
015500170831
017000200720        setll (%dec(p_ssn:9:0)) linkFile;
017001200720        reade (%dec(p_ssn:9:0)) linkFile;
017600180320
017700180409        dow not %eof;
017800170831
017801200722         exsr checkLoad;
017802200722
017900200722         //rrn += 1;
018000180320
018100200722         //exsr moveFields;
018200180322
018300200722         //write sfl1;
018400180322
018401200720        reade (%dec(p_ssn:9:0)) linkFile;
018600180320        enddo;
018700170831
019000170831       endsr;
019100170831
019101200722      //========================================================================
019102200722      // check what to load
019103200722      //========================================================================
019104200722
019105200722       begsr checkLoad;
019106200722
019107200722        chain mmssn memberFile;
019108200722
019109200722        if optSelect = 'N';
019111200722
019112200722         if %subst(fill66:66:1) = 'Y';
019113200722          rrn += 1;
019114200722           exsr moveFields;
019115200722          write sfl1;
019116200722         endif;
019117200722
019118200722        endif;
019119200722
019120200722        if optSelect = 'C';
019121200722
019124200722         if %subst(fill66:66:1) = ' ';
019125200722          rrn += 1;
019126200722           exsr moveFields;
019127200722          write sfl1;
019128200722         endif;
019129200722
019130200722        endif;
019131200722
019132200722       endsr;
019133200722
019200180322      //========================================================================
019300180322      // move fields
019400180322      //========================================================================
019500180322
019600180322       begsr moveFields;
019700180322
020303200720        ssn# = %editc(mmorssn:'X');
020304200720
020305200720        chain mmorssn memberFile;
020306200720
020307200720        if mmi > ' ';
020308200720         memname = %trim(mlname) + ' ' + %trim(mmi) + '., ' + %trim(mfname);
020309200720        else;
020310200720         memname = %trim(mlname) + ' ' + ', ' + %trim(mfname);
020311200720        endif;
020900180323
022000200720        fdate = %date(mmfrdt:*iso);
022001200720
022002200720        tdate = d'0001-01-01';
022003200720        if mmtodt > 0;
022004200720         tdate = %date(mmtodt:*iso);
022005200720        endif;
022200180703
022201200722        errorRcd = ' ';
022202200722        actterm = 'ACTIVE';
022203200722        if termdt <= %dec(%date) and termdt <> 0;
022204200722         actterm = 'TERMED';
022205200722         errorRcd = '#FF0000';
022206200722        endif;
022207200722
022300180322       endsr;
022400180322
022500180410      //========================================================================
022600180410      // checkButton
022700180410      //========================================================================
022800180410
022900180410       begsr checkButton;
023000180410
023100191218        if addEdit = 'Y';
023200191218         if buttonEdit = '1';
023300191218          exsr editRecord;
023400191218         endif;
023500180410
023600191218         if buttonAdd  = '1';
023700191218          exsr addRcd;
023800191218         endif;
023900191218        endif;
024000180622
024100200130         if btnRefresh = '1';
024200200130          exsr refresh;
024300200130         endif;
024400200319
024401200720          if selssn2 = '1';
024402200720           exsr displaySSN2;
024403200720           selssn2 = '0';
024404200720          endif;
024405200720
024500180410       endsr;
024600180410
024700170830      //========================================================================
024800180410      // add record
024900170830      //========================================================================
025000170830
025100180410       begsr addRcd;
025200170831
025201200720        clear adddtl;
025202200720
025300180410        addRecord = '0';
025400180410        btnExtAdd = '0';
025800180705
026100180410        dow btnExtAdd = '0';
026200180409
026300180410         exfmt adddtl;
026400180410
026500180410         if btnExtAdd = '1';
026600180410          leavesr;
026700180410         endif;
026800180410
026900180410         exsr validAdd;
027000180410
027100180410         btnExtAdd = '1';
027200180409
027300180410        enddo;
027400180409
027500170830       endsr;
027600170830
027700200130      //========================================================================
027800200130      // refresh
027900200130      //========================================================================
028000200130
028100200130       begsr refresh;
028200200319
028400200130        btnRefresh = '0';
028500200130
028600200130       endsr;
028700200130
028800180912      //========================================================================
028900180912      // show account
029000180912      //========================================================================
029100180912
029200200720       begsr displaySSN;
029300180912
029700200720        ssn = %dec(ssn#:9:0);
029701200720
029800200720        showSSN(ssn);
029900180912
030000180912       endsr;
030100180912
030101200720      //========================================================================
030102200720      // show account
030103200720      //========================================================================
030104200720
030105200720       begsr displaySSN2;
030106200720
030107200720        ssn = %dec(nonssn:9:0);
030108200720
030109200720        showSSN(ssn);
030110200720
030111200720       endsr;
030112200720
030200180912      //========================================================================
030300180622      // delete record
030400180622      //========================================================================
030500180622
030600180622       begsr dltRcd;
030700180622
030701200720        clear dltdtl;
030702200720
030800180622        dltRecord = '0';
030900180622        btnExtDlt = '0';
031500180622
031501200720        prssn = ssn#;
031502200720        fromdate = fdate;
031503200720        todate = tdate;
031600180622        dow btnExtDlt = '0';
031700180622
031800180622         exfmt dltdtl;
031900180622
032000180622         if btnExtDlt = '1';
032100180622          leavesr;
032200180622         endif;
032300180622
032400180622         exsr deleteRcd;
032500180622
032600180622         btnExtDlt = '1';
032700180622
032800180622        enddo;
032900180622
033000180622       endsr;
033100180622
033200170829      //========================================================================
033300170829      // valid record
033400170829      //========================================================================
033500170829
033600180410        begsr validAdd;
033700170830
033800180410         valid = '0';
033801200720         errSSN = '0';
033802200720         errDate = '0';
033803200720         errDate2 = '0';
033804200720         errDate3 = '0';
034200170829
035500200720         chain (%dec(prssn:9:0)) memberFile;
035600180410         if not %found;
035700200720          errSSN = '1';
035800200722           valid = '1';
035801200720          leavesr;
035900180410         endif;
035901200722
035902200722        chain mmssn memberFile;
035903200722
035904200722        if optSelect = 'N';
035905200722
035906200722         if %subst(fill66:66:1) = 'Y';
035907200722          rrn += 1;
035908200722           exsr moveFields;
035909200722          write sfl1;
035910200722         endif;
035911200722
035912200722        endif;
036000180410
036001200720         if fromdate = d'0001-01-01';
036002200720          errDate = '1';
036003200720           valid = '1';
036004200720          leavesr;
036005200720         endif;
036006200720
036007200720         if todate = d'0001-01-01';
036008200720          errDate2 = '1';
036009200720           valid = '1';
036010200720          leavesr;
036011200720         endif;
036012200720
036013200720         if todate < fromdate;
036014200720          errDate3 = '1';
036015200720           valid = '1';
036016200720          leavesr;
036017200720         endif;
036018200722
036100180410         if valid = '0';
036200180410          exsr addRecd;
036300170830         endif;
036400170906
036500170829        endsr;
036600170829
036700170906      //========================================================================
036800170906      // valid add
036900170906      //========================================================================
037000170906
037100180410        begsr addRecd;
037500191001
037600200720         clear linkFile;
037700191001
037701200720         mmssn = %dec(p_ssn:9:0);
037703200720         mmorssn = %dec(prssn:9:0);
038600200720         mmfrdt = %dec(fromdate);
038700200720         mmtodt = %dec(todate);
038800180703
038900200720         write linkFile;
039400180410
039500170906        endsr;
039600170830
039700170829      //========================================================================
039800180410      // edit record
039900180410      //========================================================================
040000180410
040100180410       begsr editRecord;
040200180410
040201200720        clear maintdtl;
040202200720
040300180622        btnUpdRcd = '0';
040400180410        btnExtEdt = '0';
040401200720
040402200720        prssn = ssn#;
040403200720        fromdate = fdate;
041000200720        todate = tdate;
041001200720
041100180410        dow btnExtEdt = '0';
041200180410
041300180410         exfmt maintdtl;
041400180410
041500180622         if btnUpdRcd = '1';
041600180622          exsr validEdit;
041700180622         endif;
041800180410
041900180410        enddo;
042000180622
042100180622        buttonEdit = '0';
042200180410
042300180410       endsr;
042400180410
042500180410      //========================================================================
042600180410      // valid record
042700180410      //========================================================================
042800180410
042900180410        begsr validEdit;
043000180410
043001200720         valid = '0';
043002200720         errSSN = '0';
043003200720         errDate = '0';
043004200720         errDate2 = '0';
043005200720         errDate3 = '0';
043006200720
043007200720         chain (%dec(prssn:9:0)) memberFile;
043008200720         if not %found;
043009200720          errSSN = '1';
043010200720           valid = '1';
043011200720          leavesr;
043012200720         endif;
043013200720
043014200720         if fromdate = d'0001-01-01';
043015200720          errDate = '1';
043016200720           valid = '1';
043017200720          leavesr;
043018200720         endif;
043019200720
043020200720         if todate = d'0001-01-01';
043021200720          errDate2 = '1';
043022200720           valid = '1';
043023200720          leavesr;
043024200720         endif;
043025200720
043026200720         if todate < fromdate;
043027200720          errDate3 = '1';
043028200720           valid = '1';
043029200720          leavesr;
043030200720         endif;
043031200720
045400180410         if valid = '0';
045500180410          exsr edtRecord;
045600180622          btnExtEdt = '1';
045700180410         endif;
045800180410
045900180410        endsr;
046000180410
046100180410      //========================================================================
046200200720      // valid edit
046300180410      //========================================================================
046400180410
046500180410        begsr edtRecord;
046600180410
046601200720         mmorssn = %dec(prssn:9:0);
046602200720         mmfrdt = %dec(fromdate);
046603200720         mmtodt = %dec(todate);
047200180410
047300200720         update linkFile;
047400180410
047500180410        endsr;
047600180410
047700180622      //========================================================================
047800180622      // valid add
047900180622      //========================================================================
048000180622
048100180622        begsr deleteRcd;
048200180622
048300200720         chain (%dec(p_ssn:9:0):%dec(prssn:9:0):%dec(fromdate)) linkFile;
048400180622         if %found;
048500200720          delete linkFile;
048800180622         endif;
048900180622
049000180622        endsr;
049100180622
060300180622      //========================================================================
060400170829      // exit
060500170829      //========================================================================
060600170829
060700170829       begsr exit;
060800170829
060900170829        *inlr = '1';
061000170829        return;
061100100520
061200170829       endsr;
061300170829
061400170829      //========================================================================
061500170829      // init
061600170829      //========================================================================
061700170829
061800170829       begsr init;
061900170829
062000170829        btnREFRESH = '0';
062100170829        btnEXIT = '0';
062200180622        btnUpdRcd = '0';
062300180622        buttonDlt = '0';
062400170831        buttonEdit = '0';
062500180404        buttonAdd = '0';
062600180622        buttonDlt = '0';
062900180622
063000180622        sfldsp = '0';
063100180622        sflclr = '0';
063200180622
063300170913        pgmname = proc_name;
063400180322
063401200722        title = 'Member Link to Original Member';
063402200722        if optSelect = 'C';
063403200722         title = 'COBRA Member Link to Original Member';
063404200722        endif;
063405200722
064100191218        dsperrMsg = 'N';
064200191218        addEdit = 'Y';
065000191218
065001200720        chain (%dec(p_ssn:9:0)) memberFile;
065002200720
065003200720        tsa = %editc(mbtrst:'X') + '-' + %editc(mbsub#:'X') + '-' +
065004200720              %editc(mbacct:'X');
065005200720
065006200720        nonssn = p_ssn;
065007200720
065008200720        if mmi > ' ';
065009200720         name = %trim(mlname) + ' ' + %trim(mmi) + '., ' + %trim(mfname);
065010200720        else;
065011200720         name = %trim(mlname) + ' ' + ', ' + %trim(mfname);
065012200720        endif;
065013200720
065100170829       endsr;
065200170829
069200170829      //========================================================================
