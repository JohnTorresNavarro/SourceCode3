000100190218      *=========================================================================
000101190218     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000102190218      *=========================================================================
000103191101      * MEMALTR2 - Work with NASCO ALT ID XRF
000104190218      *========================================================================
000105190218      * Date         Int  Description
000106190218      * ---------    ---  -----------------------------------------------------
000107191101      * 11/01/2019   jt   Original Creation
000108190218      *========================================================================
000109190218
000110191101     Fmemaltd2  cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
000111190218     F                                     SFile(SFL1 : RRN)
000112190218
000122191023     Fmemalt    uf a e           k disk    rename(memaltr:altidFile)
000123190218
000124191023     Falttyp    if   e           k disk    rename(alttypr:alttypFile)
000125191023
000129191023     Fmember    if   e           k disk    ExtFile('F.MEMBER')
000130191023     F                                     rename(membr:memberFile)
000131190218
000135190218      *=========================================================================
000136190218
000137190218     d psds           sds
000138190218     d proc_name         *proc
000139190218     d user                  254    263
000140190218
000141190218     d rrn             s              5i 0
000142190218     d addEdit         s              1
000146190218     d valid           s              1
000147191023     d saveSSN         s              9  0
000148191023     d saveAltid       s             20
000149191023     d saveAlttyp      s              4
000150191023     d savetopSSN      s              9  0
000151191023     d savetopAltid    s             20
000152191023     d savetopAlttyp   s              4
000153191023     d num             s              2  0
000159190503
000160190503     d lowerCase       c                   'abcdefghijklmnopqrstuvwxyz'
000161190503     d upperCase       c                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
000162190218
000181190218      //========================================================================
000182190218      // mainline
000183190218      //========================================================================
000184190218
000185190218       exsr init;
000186190218       exsr main;
000187190218       exsr exit;
000188190218
000189190218      //========================================================================
000190190218      // main
000191190218      //========================================================================
000192190218
000193190218       begsr main;
000194190218
000195190218        dow btnEXIT = '0';
000196190218
000197190218         // Clear the subfile...
000198190218         sflclr = '1';
000199190218
000200190218         write sflctl1;
000201190218         sflclr = '0';
000202190218         rrn = 0;
000203190218
000204190218         // Load the subfile...
000205190218         exsr loadSubfile;
000206190218
000207190218         // Display the subfile.
000208190218         sfldsp = '1';
000209190218         exfmt sflctl1;
000210190218
000211190218         exsr checkButton;
000212190218
000213190218         sfldsp = '1';
000214190218
000215190218        // Check for icon click.
000216190218        readc sfl1;
000217190218        if not %eof;
000218190218
000219190218         //Lock record for update, if in change mode.
000220190218         if buttonEdit ='1';
000221191023          if scarrier = 'IMD';
000222191023           exfmt msgWindow2;
000223191023          else;
000224191023           exsr editRecord;
000226191023          endif;
000227191023          buttonEdit ='0';
000228190218         endif;
000229190218
000230191023         if buttonDsp ='1';
000231191023          exsr dspRecord;
000232191023          buttonDsp ='0';
000233191023         endif;
000234191023
000235191023         if buttonDlt  = '1';
000236191023          if scarrier = 'IMD';
000237191023           exfmt msgWindow2;
000238191023          else;
000239191023           exsr dltRcd;
000241191023          endif;
000242191023          buttonDlt = '0';
000243191023         endif;
000244191023
000245190218        endif;
000246190218       enddo;
000247190218
000248190218       endsr;
000249190218
000250190218      //========================================================================
000251190218      // load subfile
000252190218      //========================================================================
000253190218
000254190218       begsr loadSubfile;
000255190218
000256191023        if posSSN > 0;
000257191023         setll posSSN altidFile;
000258191023        else;
000259191023         setll *loval altidFile;
000260190218        endif;
000261190218
000262191023        if pageDown = '1';
000263191023         setll (saveSSN : saveAlttyp : saveAltid) altidFile;
000264191023         pageDown = '0';
000265191023        endif;
000266191023
000267191023        if pageUp = '1';
000268191023         exsr readBack;
000269191023        endif;
000270191023
000271191023        read altidFile;
000272190218
000273191023        savetopSSN = mamemid;
000274191023        savetopAlttyp = maalttp;
000275191023        savetopaltid = maaltid;
000276191023
000277191023        dow not %eof;
000278191101         if maalttp = 'MIS';
000280191101          rrn += 1;
000281190218
000282191101          exsr moveFields;
000283190218
000284191101          saveSSN = sssn;
000285191101          saveAltid = saltid;
000286191101          saveAlttyp = scarrier;
000287191101
000288191101          if rrn = 20;
000289191101           rrn = 0;
000290191101           unlock memalt;
000291191101           leave;
000292191101          endif;
000293191023
000294191101          write sfl1;
000295191101         endif;
000296191101
000297191023        read altidFile;
000298190218        enddo;
000299190218
000300191023        posSSN = 0;
000301190218
000302190218       endsr;
000303190218
000304190218      //========================================================================
000305190218      // move fields
000306190218      //========================================================================
000307190218
000308190218       begsr moveFields;
000309190218
000310191023        sssn = mamemid;
000311191023        scarrier = maalttp;
000312191023        saltid = maaltid;
000313191023        name = %trim(malname) + %trim(',') + %trim(mafname);
000314191023        sfname = mafname;
000315191023        slname = malname;
000316191023        sdate = %date(macrtdt:*iso);
000318190218
000319190218       endsr;
000320190218
000321191023      //========================================================================
000322191023      // move to screen
000323191023      //========================================================================
000324191023
000325191023       begsr move_toScreen;
000326191023
000327191023        chain (sssn : scarrier : saltid) altidFile;
000328191023        chain scarrier alttypFile;
000329191023
000330191023        sssn = mamemid;
000331191023        salttype = %trim(maalttp) + '-' + %trim(atdes);
000332191023        saltid = maaltid;
000333191023        name = %trim(malname) + %trim(',') + %trim(mafname);
000334191023        //sfname = mafname;
000335191023        //slname = malname;
000336191023        sdate = %date(macrtdt:*iso);
000337191023
000338191023       endsr;
000339191023
000340190218      //========================================================================
000341190218      // checkButton
000342190218      //========================================================================
000343190218
000344190218       begsr checkButton;
000345190218
000346190218        if buttonEdit = '1';
000347190218         exsr editRecord;
000348190218        endif;
000349190218
000350190218        if buttonAdd  = '1';
000351190218         exsr addRcd;
000352190218        endif;
000353190218
000360190218       endsr;
000361190218
000362190218      //========================================================================
000363190218      // add record
000364190218      //========================================================================
000365190218
000366190218       begsr addRcd;
000367190218
000368190218        addRecord = '0';
000369190218        btnExtAdd = '0';
000370191023        sssn = 0;
000371191023        saltid = ' ';
000372191023        alttype = ' ';
000374190218
000375190218        dow btnExtAdd = '0';
000376190218
000377190218         exfmt adddtl;
000378190218
000379190218         if btnExtAdd = '1';
000380190218          leavesr;
000381190218         endif;
000382190218
000383190218         exsr validAdd;
000384190218
000385191023         if valid = '1';
000386190218          btnExtAdd = '0';
000388190218         else;
000389190218          btnExtAdd = '1';
000390190218         endif;
000391190218
000392190218        enddo;
000393190218
000394190218       endsr;
000395190218
000396190218      //========================================================================
000397190218      // valid record
000398190218      //========================================================================
000399190218
000400191023       begsr validAdd;
000401190218
000402191023        valid = '0';
000403191023        errSSN = '0';
000404191023        errSSN2 = '0';
000405191023        errAltid = '0';
000406190218
000407191023        if sssn = 0;
000408191023         errSSN = '1';
000409191023         valid = '1';
000410191023         leavesr;
000411191023        endif;
000412190218
000413191023        if sssn > 0;
000414191023        chain sssn memberFile;
000415191023         if not %found;
000416191023          errSSN2 = '1';
000417191023          valid = '1';
000418191023          leavesr;
000419191023         endif;
000420191023        endif;
000421190401
000422191023        if saltid = ' ';
000423191023         errAltid = '1';
000424191023         valid = '1';
000425191023         leavesr;
000426191023        endif;
000427190218
000428191023        if valid = '0';
000429191023        chain sssn memberFile;
000431191023        name = %trim(mlname) + %trim(',') + %trim(mfname);
000432191023
000433191023          exfmt msgWindow3;
000434191023
000435191023          if btnCancel = '1';
000436191023           valid = '1';
000437191023            btnCancel = '0';
000438191023            btnAdd = '0';
000439191023           leavesr;
000440191023          endif;
000441191023
000442191023          if btnAdd = '1';
000443191023           exsr addRecd;
000444191023            btnAdd = '0';
000445191023           btnCancel = '0';
000446191023          endif;
000447191023
000448191023        endif;
000449190218
000450191023       endsr;
000451190218
000452191023      //========================================================================
000453191023      // valid add
000454191023      //========================================================================
000455191023
000456191023       begsr edtRecord;
000457191023
000458191023        chain (sssn : scarrier : saltid) altidFile;
000459191023        maaltid = saltid;
000460191023        maalttp = alttype;
000461191023        macrtdt = %dec(%date);
000462191023
000463191023        update altidFile;
000464191023
000465191023       endsr;
000466191023
000467190218      //========================================================================
000468190218      // valid add
000469190218      //========================================================================
000470190218
000471191023       begsr addRecd;
000472190218
000473191023        mamemid = sssn;
000474191023        maaltid = saltid;
000475191023        maalttp = alttype;
000476191023        malname = mlname;
000477191023        mafname = mfname;
000478191023        macrtdt = %dec(%date);
000479190523
000480191023        write altidFile;
000481190218
000482191023       endsr;
000483190218
000484190218      //========================================================================
000485190218      // edit record
000486190218      //========================================================================
000487190218
000488190218       begsr editRecord;
000489190218
000490190218        btnUpdRcd = '0';
000491190218        btnExtEdt = '0';
000492191023        readssn = '1';
000493190218
000494191023        chain scarrier alttypFile;
000495191023        alttype = atcode;
000496191023        name = %trim(slname) + %trim(',') + %trim(sfname);
000497190523
000501191021        dow btnExtEdt = '0';
000502191021
000503190218         exfmt maintdtl;
000504190218
000505190218         if btnUpdRcd = '1';
000506190218          exsr validEdit;
000507190218         endif;
000508190218
000509190218        enddo;
000510190218
000511191023        readssn = '0';
000512190218        buttonEdit = '0';
000513190218
000514190218       endsr;
000515190218
000516190218      //========================================================================
000517190218      // valid record
000518190218      //========================================================================
000519190218
000520191023       begsr validEdit;
000521190218
000522191023        valid = '0';
000523191023        errSSN = '0';
000524191023        errSSN2 = '0';
000525191023        errAltid = '0';
000526190218
000527191023        if sssn = 0;
000528191023         errSSN = '1';
000529191023         valid = '1';
000530191023         leavesr;
000531191023        endif;
000532191023
000533191023        if sssn > 0;
000534191023        chain sssn memberFile;
000535191023         if not %found;
000536191023          errSSN2 = '1';
000537191023          valid = '1';
000538191023          leavesr;
000539191023         endif;
000540191023        endif;
000541191023
000542191023        if saltid = ' ';
000543191023         errAltid = '1';
000544191023         valid = '1';
000545191023         leavesr;
000546191023        endif;
000553190218
000566191023        if valid = '0';
000567191023         exsr edtRecord;
000568191023         btnExtEdt = '1';
000569191023        endif;
000570190218
000571191023       endsr;
000572190218
000573190218      //========================================================================
000574191023      // update record
000575190218      //========================================================================
000576190218
000577191023       begsr dspRecord;
000578190218
000579191023        dow btnExtDsp = '0';
000580191023
000581191023         exsr move_toScreen;
000582191023         exfmt dspdtl;
000583191023
000584191023         if btnExtDsp = '1';
000585191023          btnExtDsp = '0';
000586191023          leavesr;
000587191023         endif;
000588191023
000595191023        enddo;
000596191023
000622191023       endsr;
000623190308
000624191023      //========================================================================
000625191023      // delete record
000626191023      //========================================================================
000627191023
000628191023       begsr dltRcd;
000629191023
000634191023
000635191023        dow btnExtDlt = '0';
000636191023
000637191023         exsr move_toScreen;
000638191023         exfmt dltdtl;
000639191023
000640191023         if dltRecord = '1';
000641191023          chain (sssn : scarrier : saltid) altidFile;
000642191023          if %found;
000643191023           delete altidFile;
000644191023           exfmt msgWindow;
000645191023           dltRecord = '0';
000646191023           leavesr;
000647191023          endif;
000649191023         endif;
000650191023
000651191023        enddo;
000652191023
000653191023       endsr;
000654191023
000655191023      //========================================================================
000656191023      // read back
000657191023      //========================================================================
000658191023
000659191023       begsr readBack;
000660191023
000661191023         num = 0;
000662191023
000663191023         setgt (savetopSSN : savetopAlttyp : savetopAltid) altidFile;
000664191023         readp altidFile;
000665191023         dow num <= 16;
000666191023
000667191023          savetopSSN = mamemid;
000668191023          savetopAlttyp = maalttp;
000669191023          savetopaltid = maaltid;
000670191023          num += 1;
000671191023
000672191023         readp altidFile;
000673191023         enddo;
000674191023
000675191023         setll (savetopSSN : savetopAlttyp : savetopAltid) altidFile;
000676191023         pageUp = '0';
000677191023
000678191023       endsr;
000679191023
000862190218      //========================================================================
000863190218      // exit
000864190218      //========================================================================
000865190218
000866190218       begsr exit;
000867190218
000868190218        *inlr = '1';
000869190218        return;
000870190218
000871190218       endsr;
000872190218
000873190218      //========================================================================
000874190218      // init
000875190218      //========================================================================
000876190218
000877190218       begsr init;
000878190218
000879190218        btnREFRESH = '0';
000880190218        btnEXIT = '0';
000881190218        btnUpdRcd = '0';
000882191023        btnExtDsp = '0';
000883191023        btnExtDlt = '0';
000884190218        buttonEdit = '0';
000885190218        buttonAdd = '0';
000886191023        btnCancel = '0';
000887191023        btnAdd = '0';
000888191023        buttonDlt = '0';
000889191023        pageUp = '0';
000890191023        pageDown = '0';
000891190218
000892190218        sfldsp = '0';
000893190218        sflclr = '0';
000894190218
000895190218        pgmname = proc_name;
000896190218
000897191023        title = 'Work with Member Alternate ID';
000898190218
000899190218       endsr;
000900190218
000901190523      //========================================================================
