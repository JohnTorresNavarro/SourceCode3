000101191210      *=========================================================================
000200160226     H option(*noDebugIo)
000300191210      *=========================================================================
000301191210      * PRI010R - Export to Principal
000302191210      *=========================================================================
001400161014      * Date        Int  Description
001500161014      * ==========  ===  =======================================================
001600191210      * 07/29/2016  JT   Original Creation
002200190530
002300161014      *=========================================================================
002400161014
002500191210     fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
002501191210     f                                     rename(plnmsr:planFile)
002600161014      * Plan Master...
002700161014
002800190603     FMCOV42    IF   E           K Disk    extfile('F.MCOV42')
002900161014      * Member coverage...
003000161014
003100190530     FMEMBER    IF   E           K Disk    extfile('F.MEMBER')
003200161014      * Member master...
003300161014
003400190530     FDEPNDC    IF   E           K Disk    extfile('F.DEPNDC')
003500161014      * Dependent coverage...
003600161014
003700190530     FDCOV22    IF   E           K Disk    extfile('F.DCOV22')
003800161014      * Dependent coverage...
003900161014
004000190530     FGRATE     IF   E           K Disk    extfile('F.GRATE')
004100161014      * Group rate...
004200161014
004300190530     FCODES     IF   E           K Disk    extfile('F.CODES')
004400161014      * Codes
004500161014
004501191210     fpridetail uf a e           k disk    rename(prhr:priFile)
004502191210      * Metlife exoort...
004503191210
004600140616     FMETRANSOFFIF   E           K Disk
004700161014      * Transmission off for Metlife groups...
004800161014
004900160729     FMETLIFEWFTO  A E           K DISK
005000161014      * Metlife export...
005100161014
005500070924     FMETLIFTRM IF A E           K DISK
005600161014      * Metlife terms...
005700161014
005800161014      *=========================================================================
005900161014
006000161014     D PlanCat         DS             3
006100161014     D  Typ                           1
006200161014     D  Cod                           2
006300161014
006400161014     D                 DS
006500161014     D GroupFmt                1     15A
006600161014     D GroupGroup              1      7A
006700161014     D GroupSubDiv             8     11A
006800161014     D GroupBranch            12     15A
006801191210
006900191210     d carrierCode     s              3
006901191210     d carrierCode1    s              3
006902191210     d carrierCode2    s              3
006903191210     d carrierCode3    s              3
007000190530     d today           s              8  0
007100190603     d data            s              1
007101191210
007400191210     d dentalCat       s              3    Inz('PDN')
007600191210     d dentalCobraCat  s              3    Inz('PCD')
007601191210     d
007700191210     d visionCat       s              3    Inz('PVS')
007800191210     d visioncobraCat  s              3    Inz('PV2')
007801191210     d
007900191210     d lifeCat         s              3    Inz('PLF')
008000191210     d ad_dCat         s              3    Inz('PAC')
008100191210     d ltdCat          s              3    Inz('PLT')
008200191210     d stdCat          s              3    Inz('PWD')
008201191210     d vlifeCat        s              3    Inz('PSL')
008202191210     d vad_dCat        s              3    Inz('POA')
008203191210     d vlifeSCat       s              3    Inz('PSP')
008205191210     d vad_dSCat       s              3    Inz('PSA')
008206191210     d vlifeDCat       s              3    Inz('PSD')
008207191210
008300191210     d dbirthc         S              8
008400190530     d kssno           s             11
008402190603     d skip            s              1
008403190603     d h@ssn           s              9  0
008500160729
008600161014      //========================================================================
008700161014      // Mainline
008800161014      //========================================================================
008900161014
009000161014       exsr init;
009100161014       exsr main;
009200161014       exsr exit;
009300161014
009400161014      //========================================================================
009500161014      // Main
009600161014      //========================================================================
009700161014
009701191210       begsr main;
009702191210
009703191210        carrierCode = carrierCode1;
009704191210        exsr main2;
009705191210
009706191210        carrierCode = carrierCode2;
009707191210        exsr main2;
009708191210
009709191210        carrierCode = carrierCode3;
009710191210        exsr main2;
009711191210
009712191210       endsr;
009713191210
009714191210      //========================================================================
009715191210      // Main
009716191210      //========================================================================
009717191210
009800191210       begsr main2;
009900160623
011800191210        // Check for Dental
011801191210        setll carrierCode planFile;
011802191210        reade carrierCode planFile;
012100161014
012200190603        dow not %eof;
012300161014
012700191210         if plncat = dentalCat or
012900191210           plncat = dentalCobraCat;
013100190603          exsr loadRcd;
013300190603         endif;
013400160623
013401191210        reade carrierCode planFile;
013600190603        enddo;
013700160623
013800191210        // Check for Vision
013801191210        setll carrierCode planFile;
013802191210        reade carrierCode planFile;
014100190530
014200190530        dow not %eof;
014300190530
014600190530         chain codkey codes;
014700190530         if plncat = vision or
014800190530          plncat = visioncobra;
014900190530          exsr loadRcd;
015000190530         endif;
015100190530
015101191210        reade carrierCode planFile;
015300190530        enddo;
015400190530
015500161014       endsr;
015600160623
015700190530      //==================================================================
015800190530      // Load records
015900190530      //==================================================================
016000160623
016100190530       begsr loadRcd;
016101190603
016400161014
016500190603        setll (pltrst : plsub# : plplan) mcov42;
016501190603        reade (pltrst : plsub# : plplan) mcov42;
016502190603        dow not %eof;
016800160817
016900190603        h@ssn = 0;
017100160622
017200191210         if ENRLDT <> CANDT;
017400160623
017500191210          // old termed account;
017600191210          chain (mctrst: mcsub# : acc#) mtof;
017700191210          if %found and today > mtolasdte and mtolasdte <> 0;
017701191210           skip = 'Y';
017801191210          else;
017802191210           skip = 'N';
017900191210          endif;
018000160623
018001191210          if skip = 'N';
018002191210
018100191210           if candt = 0;
018200191210            candt = 99999999;
018300191210           endif;
018400160623
018500191210           if mcssno <> h@ssn;
018600191210            exsr prepRecord;
018700191210             exsr process;
018800191210            h@ssn = mcssno;
018900191210           endif;
018901191210
019000191210          endif;
019001190603
019100191210         endif;
019200190530
019301190603        reade (pltrst : plsub# : plplan) mcov42;
019400190530        enddo;
019500160623
019600190530       endsr;
019700160729
019800190530      //==================================================================
019900190530      // Process
020000190530      //==================================================================
020100160623
020200190530       begsr process;
020300160623
020400190530        chain mcssno member;
020500160623
020600070924     C                   IF        CANDT <> 99999999
020700190530        chain (mcssno:mdseq#:candt:mcplan:mcovtp:mctrst:mcsub#:acc#) metlifr;
020800070924     C                   IF        %FOUND(METLIFTRM)
020900070924     C                   LEAVESR
021000070924     C                   ELSE
021100120430     C                   If        CANDT <= Today
021200070924     C                   CLEAR                   METLIFR
021300070924     C                   EVAL      NTSSNO = MCSSNO
021400070925     C                   EVAL      NTDEPNO = 00
021500070924     C                   EVAL      NTTERMDT = CANDT
021600070924     C                   EVAL      NTPLAN = MCPLAN
021700070924     C                   EVAL      NTCOVTP  = MCOVTP
021800070924     C                   EVAL      NTTRST   = MCTRST
021900070924     C                   EVAL      NTSUB#   = MCSUB#
022000070924     C                   EVAL      NTACCT   = ACC#
022100090527     C                   Eval      NTTRANSDT = Today
022200190603     C                   WRITE     METLIFR
022300160623     C                   Endif
022400070924     C                   ENDIF
022500070924     C                   ENDIF
022600160623
022700070227     C                   Eval      PTRANCD   =   'E'
022800070227     C                   Movel     '00'          PEMPSSN
022900070227     C                   Move      MCSSNO        PEMPSSN
023000070228     C                   Move      MCSSNO        PMEMSSN
023100070227     C                   Eval      PMEMLNA   =   MLNAME                         Member Last Name
023200070227     C                   Eval      PMEMFNA   =   MFNAME                         Member First Name
023300070227     C                   Eval      PMEMMID   =   MMI                            Member First Name
023400070228     C                   Eval      PMEMSEX   =   SEX                            Member Gender
023500160623
023600070227     C                   If        SEX       <>  'M'    And
023700070227     C                             SEX       <>  'F'
023800070228     C                   Eval      PMEMSEX   =   'U'                            Unknown
023900160623     C                   Endif
024000160623
024100070228     C                   If        MARDT     =   *Zeros
024200070228     C                   Eval      PMEMMST   =   'S'
024300070227     C                   Else
024400070228     C                   Eval      PMEMMST   =   'M'
024500160623     C                   Endif
024600160623
024601190603        clear pmembdt;
024802190603        if birth > 0;
024803190603         pmembdt = %editc( %dec(%char(%date(birth:*iso):*usa0):8:0):'X');
024804190603        endif;
024805190603
025002190603        clear pemphdt;
025003190603        if empdt > 0;
025004190603         pemphdt = %editc( %dec(%char(%date(empdt:*iso):*usa0):8:0):'X');
025005190603        endif;
025100070227     C                   Eval      PEMPPIN   =   *Blanks
025200070227     C                   Eval      PSURIND   =   *Blanks
025300070227     C                   Eval      PSURSSN   =   *Blanks
025400070227     C                   Eval      PSURLNA   =   *Blanks
025500070227     C                   Eval      PSURFNA   =   *Blanks
025600070227     C                   Eval      PFADDIN   =   'D'
025700070227     C                   Eval      PSTRADD   =   ADDR1
025800070227     C                   Eval      PADDLI2   =   ADDR2
025900070227     C                   Eval      PCITY     =   CITY
026000070227     C                   Eval      PSTATE    =   STATE
026100090225     C                   Movel     ZIP           PZIPCOD
026200090225     C                   Movel     '00'          PRELACD
026300160623
026500190603        if plncat =  dental or
026600190603         plncat = dentalDC or
026700190603          plncat = dentalCobra;
026800190603         exsr dentalSr;
026900190603        endif;
027000160623
027100190603        if plncat = life;
027200190603         exsr lifeSr;
027300190603        endif;
027400160623
027500190603        if plncat = ad_d;
027600190603         exsr ad_dSr ;
027700190603        endif;
027800160623
027900190603        if plncat = ltd;
028000190603         exsr ltdSr;
028100190603        endif;
028200160623
028300190603        if plncat = std;
028400190603         exsr stdSr;
028500190603        endif;
028600190530
028700190530        if plncat = vision or
028800190530         plncat = visioncobra;
028900190530         exsr visionSR;
029000190530        endif;
029100190530
029200160623
029300190603      // Process Dependents
029400190603        if plncat = dental or
029500190603         plncat = dentalDC or
029600190603          plancat = dentalCobra;
029601190603
029700190603          chain mcssno depenr;
029800190603          if %found;
029900190603           exsr depend;
030000190603          endif;
030100160623
030200190603        endif;
030300160623
030400190530        if plncat = vision or
030500190530         plncat = visioncobra;
030600190530
030700190530          chain mcssno depenr;
030800190530          if %found;
030900190530           exsr dependVision;
031000190530          endif;
031100190530
031200190530        endif;
031300190530
031400190530       endsr;
031500160623
031600160623      *================================================================
031700160623      * Dependents
031800160623      *================================================================
031900160623
032000190603       begsr depend;
032100160623
032200190603        setll mcssno depenr;
032400190603        reade mcssno depenr;
032401190603        dow not %eof;
032500190603         //if not %eof;
032700190530
032800190603          chain (mctrst : mcsub# : mcplan : dssno : dpseq#) dcovr;
032900190603          if %found;
033100190603           exsr prepRecordD;
033200190603           exsr dcov;
033400190603          endif;
033500160623
033600190603         //endif;
033601190603
033602190603        reade mcssno depenr;
033700190603        enddo;
033800160623
033900190603       endsr;
034000160623
034100190530      *================================================================
034200190530      * Dependents
034300190530      *================================================================
034400190530
034500190603       begsr dependVision;
034600190530
034700190530     C     MCSSNO        Setll     DEPENR
034800190530     C                   DOU       %Eof(DEPNDC)
034900190530     C     MCSSNO        Reade     DEPENR
035000190530     C                   IF        NOT %EOF(DEPNDC)
035100190530
035200190530        chain (mctrst : mcsub# : mcplan : dssno : dpseq#) dcovr;
035300190530     C                   IF        %FOUND(DCOV22)
035400190530
035500190530     C                   Exsr      PrepRecordD
035600190530     C                   EXSR      DCOV2
035700190530
035800190603          endif;
035900190530
036000190603         endif;
036100190603        enddo;
036200190530
036300190603       endsr;
036400190530
036500190530      *================================================================
036600160623      * Dependent coverage
036700160623      *================================================================
036800190530
036900190603       begsr dcov;
037000160623
037100190530        setgt (mctrst : mcsub# : mcplan : dssno : dpseq#) dcovr;
037200070925     C                   DOU       %Eof(DCOV22)
037300190530        readpe (mctrst : mcsub# : mcplan : dssno : dpseq#) dcovr;
037400190603         if not %eof and denrdt <> ccandt;
037500160623
037600190603          if ccandt = 0;
037700190603           ccandt = 99999999;
037800190603          endif;
037900160623
038000190603          exsr buildDepRec;
038100190603          leavesr;
038200160623
038300190603         endif;
038301190603
038400190603        enddo;
038500160623
038600190603       endsr;
038700160623
038800190530      *================================================================
038900190530      * Dependent coverage
039000190530      *================================================================
039100190530
039200190603       begsr dcov2;
039300190530
039400190530        setgt (mctrst : mcsub# : mcplan : dssno : dpseq#) dcovr;
039500190530     C                   DOU       %Eof(DCOV22)
039600190530        readpe (mctrst : mcsub# : mcplan : dssno : dpseq#) dcovr;
039700190603        if not %eof and denrdt <> ccandt;
039800190530
039900190603         if ccandt = 0;
040000190603          ccandt = 99999999;
040100190603         endif;
040200190530
040300190603         exsr buildDepRec2;
040400190603         leavesr;
040501190603        endif;
040502190603
040700190603        enddo;
040800190530
040900190603       endsr;
040901190603
041000160623      *================================================================
041100160623      * Build dependent record
041200160623      *================================================================
041300160623
041400160623     C     BuildDepRec   Begsr
041500160623
041600070924     C                   IF        CCANDT <> 99999999
041700190530        chain (ssno:dseq#:ccandt:dvplan:mcovtp:mctrst:mcsub#:acc#) metlifr;
041800070924     C                   IF        %FOUND(METLIFTRM)
041900070924     C                   LEAVESR
042000070924     C                   ELSE
042100070924     C                   CLEAR                   METLIFR
042200070924     C                   EVAL      NTSSNO = SSNO
042300070925     C                   EVAL      NTDEPNO = DSEQ#
042400070924     C                   EVAL      NTTERMDT = CCANDT
042500070924     C                   EVAL      NTPLAN = DVPLAN
042600070924     C                   EVAL      NTCOVTP  = MCOVTP
042700070924     C                   EVAL      NTTRST   = MCTRST
042800070924     C                   EVAL      NTSUB#   = MCSUB#
042900070924     C                   EVAL      NTACCT   = ACC#
042901190603     C                   Eval      NTTRANSDT = Today
043000190603     C                   WRITE     METLIFR
043100070924     C                   ENDIF
043200070924     C                   ENDIF
043300160623
043400070227     C                   Eval      PTRANCD   =   'D'
043500070227     C                   Movel     '00'          PEMPSSN
043600070227     C                   Move      MCSSNO        PEMPSSN
043700070228     C                   Move      DEPSS#        PMEMSSN
043800070227     C                   Eval      PMEMLNA   =   DLNAME                         Member Last Name
043900070227     C                   Eval      PMEMFNA   =   DFNAME                         Member First Name
044000070227     C                   Eval      PMEMMID   =   DMI                            Member First Name
044100070228     C                   Eval      PMEMSEX   =   DSEX                           Member Gender
044200160623
044300070227     C                   If        DSEX       <>  'M'    And
044400070227     C                             DSEX       <>  'F'
044500070228     C                   Eval      PMEMSEX   =   'U'                            Unknown
044600160623     C                   Endif
044700160623
044800070227     C                   If        DRELCD    <>  'RHU'   And
044900070227     C                             DRELCD    <>  'RWI'
045000070228     C                   Eval      PMEMMST   =   'S'
045100070227     C                   Else
045200070228     C                   Eval      PMEMMST   =   'M'
045300160623     C                   Endif
045400160623
045601190603        clear pmembdt;
045602190603        if dbirth > 0;
045603190603         pmembdt = %editc( %dec(%char(%date(dbirth:*iso):*usa0):8:0):'X');
045604190603        endif;
045605190603
045700190603        pcovtyp = 'D ';
045800160623
045900070925     C                   Movel     DENRDT        PCOVBDT
046000080117     C                   Movel     DENRDT        PCOVBDTN
046100160623
046200160623      *DEPENDENT OVERRIDE
046300071106     C                   IF        DENRDT < ENRLDT
046400071106     C                   MOVE      ENRLDT        PCOVBDT
046500080117     C                   MOVE      ENRLDT        PCOVBDTN
046600071106     C                   ENDIF
046700160623
046800070925     C                   IF        CCANDT = 99999999 OR CCANDT = 0
046900070925     C                   MOVE      '00000000'    PCOVEDT
047000070925     C                   ELSE
047100070925     C                   Movel     CCANDT        PCOVEDT
047200070925     C                   ENDIF
047300160623
047400070227     C                   Eval      PEMPPIN   =   *Blanks
047500070227     C                   Eval      PSURIND   =   *Blanks
047600070227     C                   Eval      PSURSSN   =   *Blanks
047700070227     C                   Eval      PSURLNA   =   *Blanks
047800070227     C                   Eval      PSURFNA   =   *Blanks
047900070227     C                   Eval      PFADDIN   =   'D'
048000110808     C                   Exsr      GetGrp
048100110808     C                   Eval      PSUBDIV   =   GroupSubDiv
048200120216     C                   Eval      PBRANCH   =   GroupBranch
048300090313     C                   Eval      PGROUP#   =   PCUSTNO
048400070228     C                   Eval      PPLANCD   =   *Blanks
048500160623
048600070227     C                   If        CEXPDT    <>  *Zeros
048700070228     C                   Eval      PCOBRAI   =   'CE'
048800090527     C                   Move      CEXPDT        PCOVEDT
048900160623     C                   Endif
049000160623
049100070227     C                   Select
049200070228     C                   When      CEXPDT   <>   *Zeros
049300070313     C                   When      CEXPDT    =   *Zeros
049400100226     C                   EndSl
049500160623
049600070227     C                   Select
049700160623
049800070227     C                   When      EMPST     =   'J'
049900070228     C                   Eval      PSTATCD   =   'R'
050000160623
050100070227     C                   When      HDCPDT    <>  *Zero
050200070228     C                   Eval      PSTATCD   =   'D'
050300160623
050400070227     C                   Other
050500070228     C                   Eval      PSTATCD   =   'A'
050600160623
050700070227     C                   EndSl
050800160623
050900070227     C                   Select
051000070227     C                   When      DRELCD    =   'RHU'  Or
051100070227     C                             DRELCD    =   'RWI'
051200070228     C                   Movel     '01'          PRELACD
051300160623
051400070227     C                   When      DRELCD    =   'RSO'  Or
051500090921     C                             DRELCD    =   'RDA'  Or
051600090921     C                             DRELCD    =   'RA '  Or
051700090921     C                             DRELCD    =   'RB '
051800070228     C                   Movel     '02'          PRELACD
051900160623
052000130625     C                   When      DRELCD    =   'RPA'
052100130625     C                   Movel     '03'          PRELACD
052200160623
052300070227     C                   EndSl
052400160623
052500041220     C                   Select
052600070228     C                   When      MCOVTP    =   'TPC'  Or
052700070228     C                             MCOVTP    =   'TP2'
052800070228     C                   Eval      PMEMCCD   =   '2'
052900160623
053000070228     C                   When      MCOVTP    =   'THW'
053100070228     C                   Eval      PMEMCCD   =   '3'
053200160623
053300070228     C                   When      MCOVTP    =   'TFA'
053400070228     C                   Eval      PMEMCCD   =   '4'
053500160623
053600041220     C                   Endsl
053700160623
053800090313     C                   Exsr      WriteRec
053900160623
054000021007     C                   Endsr
054100160623
054200190530      *================================================================
054300190530      * Build dependent record
054400190530      *================================================================
054500190530
054600190530     C     BuildDepRec2  Begsr
054700190530
054800190530     C                   IF        CCANDT <> 99999999
054900190530        chain (ssno:dseq#:ccandt:dvplan:mcovtp:mctrst:mcsub#:acc#) metlifr;
055000190530     C                   IF        %FOUND(METLIFTRM)
055100190530     C                   LEAVESR
055200190530     C                   ELSE
055300190530     C                   CLEAR                   METLIFR
055400190530     C                   EVAL      NTSSNO = SSNO
055500190530     C                   EVAL      NTDEPNO = DSEQ#
055600190530     C                   EVAL      NTTERMDT = CCANDT
055700190530     C                   EVAL      NTPLAN = DVPLAN
055800190530     C                   EVAL      NTCOVTP  = MCOVTP
055900190530     C                   EVAL      NTTRST   = MCTRST
056000190530     C                   EVAL      NTSUB#   = MCSUB#
056100190530     C                   EVAL      NTACCT   = ACC#
056101190603     C                   Eval      NTTRANSDT = Today
056200190603     C                   WRITE     METLIFR
056300190530     C                   ENDIF
056400190530     C                   ENDIF
056500190530
056600190530     C                   Eval      PTRANCD   =   'D'
056700190530     C                   Movel     '00'          PEMPSSN
056800190530     C                   Move      MCSSNO        PEMPSSN
056900190530     C                   Move      DEPSS#        PMEMSSN
057000190530     C                   Eval      PMEMLNA   =   DLNAME                         Member Last Name
057100190530     C                   Eval      PMEMFNA   =   DFNAME                         Member First Name
057200190530     C                   Eval      PMEMMID   =   DMI                            Member First Name
057300190530     C                   Eval      PMEMSEX   =   DSEX                           Member Gender
057400190530
057500190530     C                   If        DSEX       <>  'M'    And
057600190530     C                             DSEX       <>  'F'
057700190530     C                   Eval      PMEMSEX   =   'U'                            Unknown
057800190530     C                   Endif
057900190530
058000190530     C                   If        DRELCD    <>  'RHU'   And
058100190530     C                             DRELCD    <>  'RWI'
058200190530     C                   Eval      PMEMMST   =   'S'
058300190530     C                   Else
058400190530     C                   Eval      PMEMMST   =   'M'
058500190530     C                   Endif
058600190530
058801190603        clear pmembdt;
058802190603        if dbirth > 0;
058803190603         pmembdt = %editc( %dec(%char(%date(dbirth:*iso):*usa0):8:0):'X');
058804190603        endif;
058805190603
058900190603        ptypco6 = 'VV';
059000190530
059100190530     C                   Movel     DENRDT        PCOSTD6
059200190530     C                   Movel     DENRDT        PCOVBDTN
059300190530
059400190530      *DEPENDENT OVERRIDE
059500190530     C                   IF        DENRDT < ENRLDT
059600190530     C                   MOVE      ENRLDT        PCOSTD6
059700190530     C                   MOVE      ENRLDT        PCOVBDTN
059800190530     C                   ENDIF
059900190530
060000190530     C                   IF        CCANDT = 99999999 OR CCANDT = 0
060100190530     C                   MOVE      '00000000'    PCOEND6
060200190530     C                   ELSE
060300190530     C                   Movel     CCANDT        PCOEND6
060400190530     C                   ENDIF
060500190530
060600190530     C                   Eval      PEMPPIN   =   *Blanks
060700190530     C                   Eval      PSURIND   =   *Blanks
060800190530     C                   Eval      PSURSSN   =   *Blanks
060900190530     C                   Eval      PSURLNA   =   *Blanks
061000190530     C                   Eval      PSURFNA   =   *Blanks
061100190530     C                   Eval      PFADDIN   =   'D'
061200190530     C                   Exsr      GetGrp
061300190530     C                   Eval      PSUBDI6   =   GroupSubDiv
061400190530     C                   Eval      PBRANC6   =   GroupBranch
061500190530     C                   Eval      PGROUP6   =   PCUSTNO
061600190530     C                   Eval      PPLANC6   =   *Blanks
061700190530
061800190530     C                   If        CEXPDT    <>  *Zeros
061900190530     C                   Eval      PCOBRA6   =   'CE'
062000190530     C                   Move      CEXPDT        PCOEND6
062100190530     C                   Endif
062200190530
062300190530     C                   Select
062400190530     C                   When      CEXPDT   <>   *Zeros
062500190530     C                   When      CEXPDT    =   *Zeros
062600190530     C                   EndSl
062700190530
062800190530     C                   Select
062900190530
063000190530     C                   When      EMPST     =   'J'
063100190530     C                   Eval      PSTATC6   =   'R'
063200190530
063300190530     C                   When      HDCPDT    <>  *Zero
063400190530     C                   Eval      PSTATC6   =   'D'
063500190530
063600190530     C                   Other
063700190530     C                   Eval      PSTATC6   =   'A'
063800190530
063900190530     C                   EndSl
064000190530
064100190530     C                   Select
064200190530     C                   When      DRELCD    =   'RHU'  Or
064300190530     C                             DRELCD    =   'RWI'
064400190530     C                   Movel     '01'          PRELACD
064500190530
064600190530     C                   When      DRELCD    =   'RSO'  Or
064700190530     C                             DRELCD    =   'RDA'  Or
064800190530     C                             DRELCD    =   'RA '  Or
064900190530     C                             DRELCD    =   'RB '
065000190530     C                   Movel     '02'          PRELACD
065100190530
065200190530     C                   When      DRELCD    =   'RPA'
065300190530     C                   Movel     '03'          PRELACD
065400190530
065500190530     C                   EndSl
065600190530
065700190530     C                   Select
065800190530     C                   When      MCOVTP    =   'TPC'  Or
065900190530     C                             MCOVTP    =   'TP2'
066000190530     C                   Eval      PMEMCC6   =   '2'
066100190530
066200190530     C                   When      MCOVTP    =   'THW'
066300190530     C                   Eval      PMEMCC6   =   '3'
066400190530
066500190530     C                   When      MCOVTP    =   'TFA'
066600190530     C                   Eval      PMEMCC6   =   '4'
066700190530
066800190530     C                   Endsl
066900190530
067000190530     C                   Exsr      WriteRec
067100190530
067200190530     C                   Endsr
067300190530
067400190530      *================================================================
067500090225      * Fill DENTAL Block of Record Format
067600160623      *================================================================
067700160623
067800090225     C     DentalSr      BEGSR
067900160623
068000090225     C                   Eval      PCOVTYP   =   'D '
068100090225     C                   Move      ENRLDT        PCOVBDT
068200090225     C                   Move      ENRLDT        PCOVBDTN          8 0
068300160623
068400160623      * COBRA OVERRIDE
068500090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
068600090225     C                   MOVE      GBSCDT        PCOVBDT
068700090225     C                   Move      GBSCDT        PCOVBDTN
068800090225     C                   ENDIF
068900160623
069000160623     C                   if        plncat = DentalCobra
069100160623     C                   eval      pcobrai = 'CE'
069200160623     c                   endif
069300160623
069400090225     C                   IF        CANDT = 99999999 OR CANDT = 0
069500090225     C                   MOVE      '00000000'    PCOVEDT
069600090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
069700090225     C                   ELSE
069800090225     C                   Move      CANDT         PCOVEDT
069900090225     C                   MOVE      CANDT         PCOVEDTN
070000090225     C                   ENDIF
070100160623
070200090225     C                   Exsr      GetGrp
070300090527     C                   Eval      PGROUP#   =   PCUSTNO
070400110808     C                   Eval      PSUBDIV   =   GroupSubDiv
070500120216     C                   Eval      PBRANCH   =   GroupBranch
070600160623
070700090225     C                   Eval      PPLANCD   =   *Blanks
070800160623
070900090225     C                   If        CEXPDT    <>  *Zeros
071000090225     C                   Eval      PCOBRAI   =   'CE'
071100090527     C                   Move      CEXPDT        PCOVEDT
071200160623     C                   Endif
071300160623
071400090227     C                   Select
071500090225     C                   When      EMPST     =   'J'
071600090225     C                   Eval      PSTATCD   =   'R'
071700160623
071800090225     C                   When      HDCPDT    <>  *Zero
071900090225     C                   Eval      PSTATCD   =   'D'
072000160623
072100090225     C                   Other
072200090225     C                   Eval      PSTATCD   =   'A'
072300160623
072400090225     C                   EndSl
072500160623
072600090225     C                   Select
072700090225     C                   When      MCOVTP    =   'TIN'
072800160623
072900090225     C                   Eval      PMEMCCD   =   '1'
073000090225     C                   When      MCOVTP    =   'TPC'  Or
073100090225     C                             MCOVTP    =   'TP2'
073200160623
073300090225     C                   Eval      PMEMCCD   =   '2'
073400090225     C                   When      MCOVTP    =   'THW'
073500160623
073600090225     C                   Eval      PMEMCCD   =   '3'
073700090225     C                   When      MCOVTP    =   'TFA'
073800160623
073900090225     C                   Eval      PMEMCCD   =   '4'
074000090225     C                   Endsl
074100160623
074200090227     C                   Eval      PDEPCLS   =   *Blanks
074300160623
074400090312     C                   Exsr      WriteRec
074500160623
074600090225     C                   Endsr
074700160623
074800190530      //===============================================================
074900190530      // Fill vision Block of Record Format
075000190530      //===============================================================
075100190530
075200190530       begsr visionSR;
075300190530
075400190530        ptypco6 = 'VV';
075500190530        pcostd6 = %char(enrldt);
075600190530        pcovbdtn = enrldt;
075700190530
075800190530        if empst = 'C' and gbscdt > enrldt;
075900190530         pcostd6 = %char(enrldt);
076000190530         pcovbdtn = gbscdt;
076100190530        endif;
076200190530
076300190530        if plncat = visioncobra;
076400190530         pcobra6 = 'CE';
076500190530        endif;
076600190530
076700190530        if candt = 99999999 or candt = 0;
076800190530         pcoend6 = '00000000';
076900190530         pcovedtn = 0;
077000190530        else;
077100190530         pcoend6 = %char(candt);
077200190530         pcovedtn = candt;
077300190530        endif;
077400190530
077500190530        exsr getGrp;
077600190530
077700190530        pgroup6 = pcustno;
077800190530        psubdi6 = GroupSubDiv;
077900190530        pbranc6 = GroupBranch;
078000190530        pplanc6 = ' ';
078100190530
078200190530        if cexpdt <> 0;
078300190530         pcobra6 = 'CE';
078400190530         pcostd6 = %char(cexpdt);
078500190530        endif;
078600190530
078700190530        select;
078800190530         when empst = 'J';
078900190530          pstatc6 ='R';
079000190530
079100190530         when hdcpdt <> 0;
079200190530          pstatc6 = 'D';
079300190530
079400190530         other;
079500190530          pstatc6 = 'A';
079600190530        endsl;
079700190530
079800190530        select;
079900190530         when mcovtp = 'TIN';
080000190530          pmemcc6 = '1';
080100190530
080200190530         when mcovtp = 'TPC'  or mcovtp = 'TP2';
080300190530          pmemcc6 = '2';
080400190530
080500190530         when mcovtp = 'THW';
080600190530          pmemcc6 = '3';
080700190530
080800190530         when mcovtp = 'TFA';
080900190530          pmemcc6 = '4';
081000190530        endsl;
081100190530
081200190530        //PDEPCLS   =   *Blanks
081300190530
081400190530        exsr writeRec;
081500190530
081600190530       endsr;
081700190530
081800160623      *================================================================
081900090225      * Fill LIFE Block of Record Format
082000160623      *================================================================
082100160623
082200090225     C     LifeSr        BEGSR
082300160623
082400090227     C                   Eval      PTYPCO2   =   'CP'
082500090304     C                   Move      ENRLDT        PCOSTD2
082600090225     C                   Move      ENRLDT        PCOVBDTN          8 0
082700160623
082800160623      * COBRA OVERRIDE
082900090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
083000090304     C                   MOVE      GBSCDT        PCOSTD2
083100090225     C                   Move      GBSCDT        PCOVBDTN
083200090225     C                   ENDIF
083300161014
083400090225     C                   IF        CANDT = 99999999 OR CANDT = 0
083500090304     C                   MOVE      '00000000'    PCOEND2
083600090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
083700090225     C                   ELSE
083800090304     C                   Move      CANDT         PCOEND2
083900090225     C                   MOVE      CANDT         PCOVEDTN
084000090225     C                   ENDIF
084100160623
084200090225     C                   Exsr      GetGrp
084300090227     C                   Eval      PPLANC2   =   *Blanks
084400160623
084500090225     C                   If        CEXPDT    <>  *Zeros
084600090227     C                   Eval      PCOBRA2   =   'CE'
084700090527     C                   Move      CEXPDT        PCOEND2
084800160623     C                   Endif
084900160623
085000090227     C                   Select
085100160623
085200090225     C                   When      EMPST     =   'J'
085300090227     C                   Eval      PSTATC2   =   'R'
085400160623
085500090225     C                   When      HDCPDT    <>  *Zero
085600090227     C                   Eval      PSTATC2   =   'D'
085700160623
085800090225     C                   Other
085900090227     C                   Eval      PSTATC2   =   'A'
086000160623
086100090225     C                   EndSl
086200160623
086300090225     C                   Select
086400160623
086500090225     C                   When      MCOVTP    =   'TIN'
086600090227     C                   Eval      PMEMCC2   =   '1'
086700160623
086800090225     C                   When      MCOVTP    =   'TPC'  Or
086900090225     C                             MCOVTP    =   'TP2'
087000090227     C                   Eval      PMEMCC2   =   '2'
087100160623
087200090225     C                   When      MCOVTP    =   'THW'
087300090227     C                   Eval      PMEMCC2   =   '3'
087400160623
087500090225     C                   When      MCOVTP    =   'TFA'
087600090227     C                   Eval      PMEMCC2   =   '4'
087700160623
087800090225     C                   Endsl
087900160623
088000090227     C                   Eval      PDEPCL2   =   *Blanks
088100090304     C                   Move      BENAMT        PINSAM2
088200090320     C                   Movel     '0'           PINSAM2
088300160623
088400090312     C                   Movel     'A'           PSAMOD2
088500090312     C                   Move      SALARY        PSALAR2
088600160623
088700090312     C                   Exsr      WriteRec
088800160623
088900090225     C                   Endsr
089000160623
089100160623      *================================================================
089200090225      * Fill AD&D Block of Record Format
089300160623      *================================================================
089400160623
089500090225     C     AD_DSr        BEGSR
089600160623
089700090227     C                   Eval      PTYPCO3   =   'AD'
089800090304     C                   Move      ENRLDT        PCOSTD3
089900090225     C                   Move      ENRLDT        PCOVBDTN          8 0
090000160623
090100160623      * COBRA OVERRIDE
090200090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
090300090304     C                   MOVE      GBSCDT        PCOSTD3
090400090225     C                   Move      GBSCDT        PCOVBDTN
090500090225     C                   ENDIF
090600161014
090700090225     C                   IF        CANDT = 99999999 OR CANDT = 0
090800090304     C                   MOVE      '00000000'    PCOEND3
090900090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
091000090225     C                   ELSE
091100090304     C                   Move      CANDT         PCOEND3
091200090225     C                   MOVE      CANDT         PCOVEDTN
091300090225     C                   ENDIF
091400160623
091500090225     C                   Exsr      GetGrp
091600160623
091700090227     C                   Eval      PPLANC3   =   *Blanks
091800160623
091900090225     C                   If        CEXPDT    <>  *Zeros
092000090227     C                   Eval      PCOBRA3   =   'CE'
092100090527     C                   Move      CEXPDT        PCOEND3
092200160623     C                   Endif
092300160623
092400090227     C                   Select
092500160623
092600090225     C                   When      EMPST     =   'J'
092700090227     C                   Eval      PSTATC3   =   'R'
092800160623
092900090225     C                   When      HDCPDT    <>  *Zero
093000090227     C                   Eval      PSTATC3   =   'D'
093100160623
093200090225     C                   Other
093300090227     C                   Eval      PSTATC3   =   'A'
093400160623
093500090225     C                   EndSl
093600090225      *
093700090225     C                   Select
093800090225     C                   When      MCOVTP    =   'TIN'
093900090227     C                   Eval      PMEMCC3   =   '1'
094000160623
094100090225     C                   When      MCOVTP    =   'TPC'  Or
094200090225     C                             MCOVTP    =   'TP2'
094300090227     C                   Eval      PMEMCC3   =   '2'
094400160623
094500090225     C                   When      MCOVTP    =   'THW'
094600090227     C                   Eval      PMEMCC3   =   '3'
094700160623
094800090225     C                   When      MCOVTP    =   'TFA'
094900090227     C                   Eval      PMEMCC3   =   '4'
095000160623
095100090225     C                   Endsl
095200160623
095300090227     C                   Eval      PDEPCL3   =   *Blanks
095400090304     C                   Move      BENAMT        PINSAM3
095500090320     C                   Movel     '0'           PINSAM3
095600160623
095700090312     C                   Movel     'A'           PSAMOD3
095800090312     C                   Move      SALARY        PSALAR3
095900160623
096000090312     C                   Exsr      WriteRec
096100160623
096200090225     C                   Endsr
096300160623
096400160623      *================================================================
096500090225      * Fill LTD Block of Record Format
096600160623      *================================================================
096700160623
096800090225     C     LTDSr         BEGSR
096900160623
097000090312     C                   Eval      PTYPCO5   =   'LT'
097100090313     C                   Move      ENRLDT        PCOSTD5
097200090225     C                   Move      ENRLDT        PCOVBDTN          8 0
097300160623
097400160623      * COBRA OVERRIDE
097500090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
097600090312     C                   MOVE      GBSCDT        PCOSTD5
097700090225     C                   Move      GBSCDT        PCOVBDTN
097800090225     C                   ENDIF
097900161014
098000090225     C                   IF        CANDT = 99999999 OR CANDT = 0
098100090312     C                   MOVE      '00000000'    PCOEND5
098200090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
098300090225     C                   ELSE
098400090312     C                   Move      CANDT         PCOEND5
098500090225     C                   MOVE      CANDT         PCOVEDTN
098600090225     C                   ENDIF
098700160623
098800090225     C                   Exsr      GetGrp
098900090312     C                   Eval      PPLANC5   =   *Blanks
099000160623
099100090225     C                   If        CEXPDT    <>  *Zeros
099200090312     C                   Eval      PCOBRA5   =   'CE'
099300090527     C                   Move      CEXPDT        PCOEND5
099400160623     C                   Endif
099500160623
099600090227     C                   Select
099700160623
099800090225     C                   When      EMPST     =   'J'
099900090312     C                   Eval      PSTATC5   =   'R'
100000160623
100100090225     C                   When      HDCPDT    <>  *Zero
100200090312     C                   Eval      PSTATC5   =   'D'
100300160623
100400090225     C                   Other
100500090312     C                   Eval      PSTATC5   =   'A'
100600160623
100700090225     C                   EndSl
100800160623
100900090225     C                   Select
101000160623
101100090225     C                   When      MCOVTP    =   'TIN'
101200090312     C                   Eval      PMEMCC5   =   '1'
101300160623
101400090225     C                   When      MCOVTP    =   'TPC'  Or
101500090225     C                             MCOVTP    =   'TP2'
101600090312     C                   Eval      PMEMCC5   =   '2'
101700160623
101800090225     C                   When      MCOVTP    =   'THW'
101900090312     C                   Eval      PMEMCC5   =   '3'
102000160623
102100090225     C                   When      MCOVTP    =   'TFA'
102200090312     C                   Eval      PMEMCC5   =   '4'
102300160623
102400090225     C                   Endsl
102500160623
102600090312     C                   Eval      PDEPCL5   =   *Blanks
102700090313     C                   Move      BENAMT        PINSAM5
102800090320     C                   Movel     '0'           PINSAM5
102900160623
103000090312     C                   Movel     'A'           PMOSAL5
103100090312     C                   Move      SALARY        PSALAM5
103200160623
103300090312     C                   Exsr      WriteRec
103400160623
103500090225     C                   Endsr
103600160623
103700160623      *===================================================================
103800090225      * Fill STD Block of Record Format
103900160623      *===================================================================
104000160623
104100090225     C     STDSr         BEGSR
104200160623
104300090312     C                   Eval      PTYPCO4   =   'AS'
104400090312     C                   Move      ENRLDT        PCOSTD4
104500090225     C                   Move      ENRLDT        PCOVBDTN          8 0
104600160623
104700160623      * COBRA OVERRIDE
104800090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
104900090312     C                   MOVE      GBSCDT        PCOSTD4
105000090225     C                   Move      GBSCDT        PCOVBDTN
105100090225     C                   ENDIF
105200160623
105300090225     C                   IF        CANDT = 99999999 OR CANDT = 0
105400090312     C                   MOVE      '00000000'    PCOEND4
105500090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
105600090225     C                   ELSE
105700090312     C                   Move      CANDT         PCOEND4
105800090225     C                   MOVE      CANDT         PCOVEDTN
105900090225     C                   ENDIF
106000160623
106100090225     C                   Exsr      GetGrp
106200090312     C                   Eval      PPLANC4   =   *Blanks
106300160623
106400090225     C                   If        CEXPDT    <>  *Zeros
106500090312     C                   Eval      PCOBRA4   =   'CE'
106600090527     C                   Move      CEXPDT        PCOEND4
106700160623     C                   Endif
106800160623
106900090227     C                   Select
107000160623
107100090225     C                   When      EMPST     =   'J'
107200090312     C                   Eval      PSTATC4   =   'R'
107300160623
107400090225     C                   When      HDCPDT    <>  *Zero
107500090312     C                   Eval      PSTATC4   =   'D'
107600160623
107700090225     C                   Other
107800090312     C                   Eval      PSTATC4   =   'A'
107900160623
108000090225     C                   EndSl
108100160623
108200090225     C                   Select
108300160623
108400090225     C                   When      MCOVTP    =   'TIN'
108500090312     C                   Eval      PMEMCC4   =   '1'
108600160623
108700090227     C                   When      MCOVTP    =   'TPC'  Or
108800090225     C                             MCOVTP    =   'TP2'
108900090312     C                   Eval      PMEMCC4   =   '2'
109000160623
109100090225     C                   When      MCOVTP    =   'THW'
109200090312     C                   Eval      PMEMCC4   =   '3'
109300160623
109400090225     C                   When      MCOVTP    =   'TFA'
109500090312     C                   Eval      PMEMCC4   =   '4'
109600160623
109700090225     C                   Endsl
109800160623
109900090312     C                   Eval      PDEPCL4   =   *Blanks
110000090312     C                   Move      BENAMT        PINSAM4
110100090320     C                   Movel     '0'           PINSAM4
110200160623
110300090312     C                   Movel     'A'           PMOSAL4
110400090312     C                   Move      SALARY        PSALAM4
110500160623
110600090312     C                   Exsr      WriteRec
110700160623
110800090225     C                   Endsr
110900160623
111000160816      //===================================================================
111100160816      // Get group number
111200160816      //===================================================================
111300160816
111400190603       begsr getGrp;
111500160816
111600160816        setll (mctrst : mcsub# : mcplan : mcageb : mcovtp) grater;
111700160816        reade (mctrst : mcsub# : mcplan : mcageb : mcovtp) grater;
111800160816
111900160816        dow not %eof;
112000160816
112100160816         if today >= frmdat;
112200160816          if today <= todat;
112300190603           exsr fmtGrp;
112400190530           leavesr;
112500160816          else;
112600160816           group# = ' ';
112700160816          endif;
112800160816         endif;
112900160816
113000160816        reade (mctrst : mcsub# : mcplan : mcageb : mcovtp) grater;
113100160816        enddo;
113200160816
113300160816        // When coverage is termed, there may be no current rate, still need grp#
113400160816        if pcustno = ' ';
113500190603         exsr fmtGrp;
113600160816        endif;
113700160816
113800190530       endsr;
113900160816
113901190603      //===================================================================
114100190603      // Format the group number.
114101190603      //===================================================================
114300160623
114400190603       begsr fmtGrp;
114500160623
114600190603        // The 1st 7 digits of group# are moved into group, next 4 subd, next 4 branch
114700190603        clear groupfmt;
114800190603        groupfmt = group#;
114900160623
115000190603        select;
115200190603         when plncat = dental or
115300190603          plncat = dentalDC or
115400190603          plncat = dentalCobra;
115500190603           pcustno = GroupGroup;
115600190603           psubdiv = GroupSubDiv;
115700190603           pbranch = GroupBranch;
115800160623
115900190603         when plncat = life;
116000190603          pcustno = GroupGroup;
116100190603          pgroup2 = GroupGroup;
116200190603          psubdi2 = GroupSubDiv;
116300190603          pbranc2 = GroupBranch;
116400160623
116500190603         when plncat = ad_d;
116600190603          pcustno = GroupGroup;
116700190603          pgroup3 = GroupGroup;
116800190603          psubdi3 = GroupSubDiv;
116900190603          pbranc3 = GroupBranch;
117000160623
117700190603         when plncat = std;
117800190603          pcustno = GroupGroup;
117900190603          pgroup4 = GroupGroup;
118000190603          psubdi4 = GroupSubDiv;
118100190603          pbranc4 = GroupBranch;
118200190530
118201190603         when plncat = ltd;
118202190603          pcustno = GroupGroup;
118203190603          pgroup5 = GroupGroup;
118204190603          psubdi5 = GroupSubDiv;
118205190603          pbranc5 = GroupBranch;
118206190603
118300190603         when plncat = vision or
118400190603          plncat = visioncobra;
118500190603           pcustno = GroupGroup;
118600190603           pgroup6 = GroupGroup;
118700190603           psubdi6 = GroupSubDiv;
118800190603           pbranc6 = GroupBranch;
119000190603        endsl;
119100160623
119200190603       endsr;
119300160623
119400160623      *===================================================================
119500090313      * Prepare Dependent Record for Update
119600160623      *===================================================================
119700160623
119800190530       begsr prepRecordD;
119900160623
120701190603        if dbirth > 0;
120800190603         dbirthc = %editc( %dec(%char(%date(dbirth:*iso):*usa0):8:0):'X');
120801190603        endif;
120802190603
120900191210        chain (%editc(mcssno:'X') : %editc(mssno:'X'):dbirthc:dfname) priFile;
121000190603        if not %found;
121100191210         clear prifile;
121300190603         data = 'A';
121400190603        else;
121500190530
121600190603         if dfname = pmemfna and
121700190603          dmi = pmemmid;
121800190603          data = 'U';
121900190603         else;
122000191210          clear priFile;
122200190603          data = 'A';
122300190603         endif;
122400190530
122500190530        endif;
122600160623
122700190530       endsr;
122800160623
122801190603      //==================================================================
123000190603      // Prepare Record for Update
123001190603      //==================================================================
123200160623
123300190530       begsr prepRecord;
123400160623
124300191210        chain (%editc(mcssno:'X')) priFile;
124400190530        if not %found;
124500191210         clear priFile;
124700190530         data = 'A';
124800190530        else;
124900190530         data = 'U';
125000190530        endif;
125100160623
125200190530       endsr;
125300160623
125400190530      //==================================================================
125500190530      // Write or update a record
125600190530      //==================================================================
125700160623
125800190530       begsr writeRec;
125900160623
126000190530        if pcustno <> 'IN PROC';
126100160818
126200190530         select;
126300190530          when data = 'A';
126400190530           write proexpr;
126500160623
126600190530          when data = 'U';
126700190530           update proupdr;
126800190530          endsl;
126900160623
127000190530         clear data;
127100190530         clear proexpr;
127200190530         clear proupdr;
127300160818
127400190530        endif;
127500160623
127600190530       endsr;
127700160623
127800190530      //==================================================================
127900190530      // exit
128000161014      //==================================================================
128100161014
128200161014       begsr exit;
128300161014
128400161014        *inlr = '1';
128500161014        return;
128600161014
128700161014       endsr;
128800161014
128900190530      //==================================================================
129000190530      // Init
129100190530      //==================================================================
129200160623
129300190530       begsr init;
129301191210
129302191210        carrierCode1 = 'PFL';
129303191210        carrierCode2 = 'PFR';
129304191210        carrierCode3 = 'PRD';
129400160623
129500161014     C     CodKey        Klist
129600161014     C                   Kfld                    Typ
129700161014     C                   Kfld                    Cod
129900190530        today = %dec(%date);
130000190530        filler1 = ' ';
130100190530        filler2 = ' ';
130200160729
130300190530       endsr;
130400160623
130500190530      //==================================================================
