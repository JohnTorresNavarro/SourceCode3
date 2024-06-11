000100161014      *=========================================================================
000200160226     H option(*noDebugIo)
000300161014      *=========================================================================
000400161014
000500161014      * Description:  Metlife EDT
000600161014
000700161014      * (c)Copyright 2007 by GBS, Inc.
000800161014      * This document contains restricted materials of GBS, Inc.
000900161014
001000161014      * Original Creation by: S. Zien
001100161014      * Date Written: 02/27/07
001200161014
001300161014      *=========================================================================
001400161014      * Date        Int  Description
001500161014      * ==========  ===  =======================================================
001600161014      * 07/29/2016  JT   Cloned from original program. This version is for EDT
001700161014      *                  carrier
001800170320
001900170320      * 03/20/2017  JT   Recompiled for DB change.
002000170320
002100190530      * 05/30/2019  JT   Added Vision.
002200190530
002300161014      *=========================================================================
002400161014
002500190530     FPLNMSTN1  IF   E           K Disk    extfile('F.PLNMSTN1')
002600161014      * Plan Master...
002700161014
002800190530     FMCOV39    IF   E           K Disk    extfile('F.MCOV39')
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
004600160729     Fcaraccp   if   e           k disk
004700161014      * Carrier export control...
004800161014
004900140616     FMETRANSOFFIF   E           K Disk
005000161014      * Transmission off for Metlife groups...
005100161014
005200160729     FMETLIFEWFTO  A E           K DISK
005300161014      * Metlife export...
005400161014
005500160729     FMETLIFEWTLUF   E           K DISK    rename(proexpr:proupdr)
005600161014      * Metlife export logical...
005700161014
005800070924     FMETLIFTRM IF A E           K DISK
005900161014      * Metlife terms...
006000161014
006100160831     FMETLIFERCVIF   E           K DISK    rename(metlifr:tempFile)
006200161014      * Processing groups...
006300161014
006400161014      *=========================================================================
006500161014
006600161014     D PlanCat         DS             3
006700161014     D  Typ                           1
006800161014     D  Cod                           2
006900161014
007000160826     D TrSuAc          ds            12
007100160826     D  Trust                         3
007200160826     D  Dash1                         1    inz('-')
007300160817     D  Sub                           3
007400160826     D  Dash2                         1    inz('-')
007500160817     D  acct                          4
007600161014
007700161014     D                 DS
007800161014     D GroupFmt                1     15A
007900161014     D GroupGroup              1      7A
008000161014     D GroupSubDiv             8     11A
008100161014     D GroupBranch            12     15A
008200161014
008300140616     D #ISO            S               D   DATFMT(*ISO)
008400090313     D Data            S              1A
008500070227     D No              S              1A   Inz('N')
008600070227     D Yes             S              1A   Inz('Y')
008700160826     D TrSuAc12        s             12
008800160816     D Trust5          S              3A   Inz('EDT')
008900190530     D Trust5v         S              3A   Inz('ED2')
009000070227     D Dental          S              3A   Inz('PDN')
009100100420     D DentalDC        S              3A   Inz('PDR')
009200160623     D DentalCobra     S              3A   Inz('PCD')
009300190530     D vision          S              3A   Inz('PVS')
009400190530     D visioncobra     S              3A   Inz('PV2')
009500080923     D Life            S              3A   Inz('PLF')
009600080923     D AD_D            S              3A   Inz('PAC')
009700080923     D LTD             S              3A   Inz('PLT')
009800080923     D STD             S              3A   Inz('PWD')
009900160908     D dbirthc         S              8
010000160817     D*unique          S             10A   Inz('0000000166')
010100160729
010200161014      //========================================================================
010300161014      // Mainline
010400161014      //========================================================================
010500161014
010600161014       exsr init;
010700161014       exsr main;
010800161014       exsr exit;
010900161014
011000161014      //========================================================================
011100161014      // Main
011200161014      //========================================================================
011300161014
011400161014       begsr main;
011500160623
011600090313      * Check for MEL - Life Products
011700160816     C     Trust5        SETLL     PLNMSR
011800160816     C     Trust5        ReadE     PLNMSR
011900161014
012000090313     C                   DOW       not %EOF(PLNMSTN1)
012100161014
012200090313     C                   If         PLNCAT    =   Life      Or
012300090313     C                              PLNCAT    =   AD_D      Or
012400090313     C                              PLNCAT    =   LTD       Or
012500090313     C                              PLNCAT    =   STD
012600161014
012700090313     C                   EXSR      LOADRCD
012800161014
012900160623     C                   Endif
013000161014
013100160816     C     Trust5        ReadE     PLNMSR
013200090313     C                   Enddo
013300160623
013400100401      * Check for MED - Metlife Dental - DAILY Proration
013500160816     C     Trust5        SETLL     PLNMSR
013600160816     C     Trust5        ReadE     PLNMSR
013700161014
013800100401     C                   DOW       not %EOF(PLNMSTN1)
013900161014
014000100421     C                   Movel     PLNCAT        PlanCat
014100161014
014200100421     C     CodKey        Chain     CODES
014300100420     C                   If         PLNCAT    =   Dental  Or
014400160623     C                              PLNCAT    =   DentalDC or
014500160623     C                              PLNCAT    =   DentalCobra
014600160301     C****                          PLNCAT    =   DentalDC  Or
014700160301     C****                          ACTION    =   'D'
014800161014
014900100401     C                   EXSR      LOADRCD
015000161014
015100160623     C                   Endif
015200160623
015300160816     C     Trust5        ReadE     PLNMSR
015400100401     C                   Enddo
015500160623
015600190530      // Check for VIS - Metlife Vision - DAILY Proration
015700190530        setll trust5v plnmsr;
015800190530        reade trust5v plnmsr;
015900190530
016000190530        dow not %eof;
016100190530
016200190530         plancat = plncat;
016300190530
016400190530         chain codkey codes;
016500190530         if plncat = vision or
016600190530          plncat = visioncobra;
017000190530          exsr loadRcd;
017300190530         endif;
017400190530
017401190530        reade trust5v plnmsr;
017600190530        enddo;
017700190530
017800161014       endsr;
017900160623
018000160623      *=========================================================================
018100160623      * Load records
018200160623      *=========================================================================
018300160623
018400090313     C     LOADRCD       BEGSR
018500160623
018600160817     C     PlnKey        chain     MCOV39
018700161014
018800161014       //exsr moveFields;
018900160817
019000161014       //chain (TrSuAc12) tempfile;
019100161014       //if %found;
019200161014       // if prc = 'OK';
019300160817
019400070228     C     PlnKey        Setll     MCOV39
019500090313     C                   DOW       not %Eof(MCOV39)
019600090313     C     PlnKey        Reade     MCOV39
019700160817
019800160817     C                   MOVE      *ZEROS        H@SSN             9 0
019900160622     C                   if        not %eof
020000160622
020100160909     C                   IF        ENRLDT <> CANDT
020200160816     C****                         and ENRLDT <= Today
020300160623
020400160623      * OLD TERMED ACCOUNT
020500140616     C     KL#TSA        CHAIN     MTOF
020600140616     C                   IF        %FOUND(METRANSOFF) AND TODAY > MTOLASDTE
020700140616     C                             AND MTOLASDTE <> 0
020800140616     C                   ITER
020900140616     C                   ENDIF
021000160623
021100070921     C                   IF        CANDT = 0
021200070921     C                   EVAL      CANDT = 99999999
021300070921     C                   ENDIF
021400160623
021500070921     C                   IF        MCSSNO <> H@SSN
021600090313     C                   Exsr      PrepRecord
021700070227     C                   Exsr      Process
021800070924     C                   EVAL      H@SSN = MCSSNO
021900070921     C                   ENDIF
022000160623
022100160622     C                   endif
022200160909     C                   ENDIF
022300070921     C                   ENDDO
022400160623
022500161014        //endif;
022600161014       //endif;
022700160729
022800090313     C                   ENDSR
022900160729
023000160817       //==============================================================
023100160817       // move fields
023200160817       //==============================================================
023300160817
023400160817       begsr moveFields;
023500160817
023600160826        //trust = %char(mctrst);
023700160826        trust = %editc(mctrst:'X');
023800160817        sub = %editc(mcsub#:'X');
023900160817        acct = %editc(acc#:'X');
024000160817
024100160826        TrSuAc12 = TrSuAc;
024200160817
024300160817       endsr;
024400160817
024500160623      *================================================================
024600160623      * Process
024700160623      *================================================================
024800160623
024900070227     C     Process       Begsr
025000160623
025100070228     C     MCSSNO        Chain     MEMBER
025200160623
025300070924     C                   IF        CANDT <> 99999999
025400070924     C     CNLMBR        CHAIN     METLIFR
025500070924     C                   IF        %FOUND(METLIFTRM)
025600070924     C                   LEAVESR
025700070924     C                   ELSE
025800120430     C                   If        CANDT <= Today
025900070924     C                   CLEAR                   METLIFR
026000070924     C                   EVAL      NTSSNO = MCSSNO
026100070925     C                   EVAL      NTDEPNO = 00
026200070924     C                   EVAL      NTTERMDT = CANDT
026300070924     C                   EVAL      NTPLAN = MCPLAN
026400070924     C                   EVAL      NTCOVTP  = MCOVTP
026500070924     C                   EVAL      NTTRST   = MCTRST
026600070924     C                   EVAL      NTSUB#   = MCSUB#
026700070924     C                   EVAL      NTACCT   = ACC#
026800090527     C                   Eval      NTTRANSDT = Today
026900070924     C                   WRITE     METLIFR
027000160623     C                   Endif
027100070924     C                   ENDIF
027200070924     C                   ENDIF
027300160623
027400070227     C                   Eval      PTRANCD   =   'E'
027500070227     C                   Movel     '00'          PEMPSSN
027600070227     C                   Move      MCSSNO        PEMPSSN
027700070228     C                   Move      MCSSNO        PMEMSSN
027800070227     C                   Eval      PMEMLNA   =   MLNAME                         Member Last Name
027900070227     C                   Eval      PMEMFNA   =   MFNAME                         Member First Name
028000070227     C                   Eval      PMEMMID   =   MMI                            Member First Name
028100070228     C                   Eval      PMEMSEX   =   SEX                            Member Gender
028200160623
028300070227     C                   If        SEX       <>  'M'    And
028400070227     C                             SEX       <>  'F'
028500070228     C                   Eval      PMEMSEX   =   'U'                            Unknown
028600160623     C                   Endif
028700160623
028800070228     C                   If        MARDT     =   *Zeros
028900070228     C                   Eval      PMEMMST   =   'S'
029000070227     C                   Else
029100070228     C                   Eval      PMEMMST   =   'M'
029200160623     C                   Endif
029300160623
029400070227     C     BIRTH         Mult      10000.0001    DOB               8 0
029500070228     C                   Movel     DOB           PMEMBDT
029600070227     C     EMPDT         Mult      10000.0001    HIREDT            8 0
029700070228     C                   Movel     HIREDT        PEMPHDT
029800070227     C                   Eval      PEMPPIN   =   *Blanks
029900070227     C                   Eval      PSURIND   =   *Blanks
030000070227     C                   Eval      PSURSSN   =   *Blanks
030100070227     C                   Eval      PSURLNA   =   *Blanks
030200070227     C                   Eval      PSURFNA   =   *Blanks
030300070227     C                   Eval      PFADDIN   =   'D'
030400070227     C                   Eval      PSTRADD   =   ADDR1
030500070227     C                   Eval      PADDLI2   =   ADDR2
030600070227     C                   Eval      PCITY     =   CITY
030700070227     C                   Eval      PSTATE    =   STATE
030800090225     C                   Movel     ZIP           PZIPCOD
030900090225     C                   Movel     '00'          PRELACD
031000160623
031100090225      * Determine which coverage and load the appropriate format block
031200100423     C                   If        PLNCAT    =   Dental   OR
031300160623     C                             PLNCAT    =   DentalDC or
031400160623     C                             PLNCAT    =   DentalCobra
031500160301     C****                         PLNCAT    =   DentalDC OR
031600160301     C****                         Action    =   'D'
031700090225     C                   Exsr      DentalSr
031800160623     C                   Endif
031900160623
032000090312     C                   If        PLNCAT    =   Life
032100090225     C                   Exsr      LifeSr
032200160623     C                   Endif
032300160623
032400090312     C                   If        PLNCAT    =   AD_D
032500090225     C                   Exsr      AD_DSr
032600160623     C                   Endif
032700160623
032800090312     C                   If        PLNCAT    =   LTD
032900090225     C                   Exsr      LTDSr
033000160623     C                   Endif
033100160623
033200090312     C                   If        PLNCAT    =   STD
033300090225     C                   Exsr      STDSr
033400160623     C                   Endif
033401190530
033402190530        if plncat = vision or
033403190530         plncat = visioncobra;
033407190530         exsr visionSR;
033408190530        endif;
033409190530
033500160623
033600090313      * Process Dependents
033700100521     C                   If        PLNCAT    =   Dental   Or
033800160623     C                             PLNCAT    =   DentalDC or
033900160623     C                             PLNCAT    =   DentalCobra
034000160301     C****                         PLNCAT    =   DentalDC or
034100160301     C****                         Action    =   'D'
034200070925     C     MCSSNO        CHAIN     DEPENR
034300070925     C                   IF        %FOUND(DEPNDC)
034400160623     C                   EXSR      DEPEND
034500070925     C                   ENDIF
034600160623
034700160623     C                   Endif
034800160623
034801190530        if plncat = vision or
034802190530         plncat = visioncobra;
034803190530
034806190530          chain mcssno depenr;
034807190530          if %found;
034808190530           exsr depend;
034809190530          endif;
034810190530
034811190530        endif;
034812190530
034900190530       endsr;
035000160623
035100160623      *================================================================
035200160623      * Dependents
035300160623      *================================================================
035400160623
035500160623     C     DEPEND        BEGSR
035600160623
035700070925     C     MCSSNO        Setll     DEPENR
035800070925     C                   DOU       %Eof(DEPNDC)
035900070925     C     MCSSNO        Reade     DEPENR
036000070925     C                   IF        NOT %EOF(DEPNDC)
036100160623
036200070925     C     DepKey        CHAIN     DCOVR
036300070925     C                   IF        %FOUND(DCOV22)
036400160623
036500090313     C                   Exsr      PrepRecordD
036600160623     C                   EXSR      DCOV
036700160623
036800070925     C                   ENDIF
036900160623
037000070925     C                   ENDIF
037100070925     C                   Enddo
037200160623
037300070925     C                   ENDSR
037400160623
037500160623      *================================================================
037600160623      * Dependent coverage
037700160623      *================================================================
037800160623   S*
037900160623     C     DCOV          BEGSR
038000160623
038100070925     C     DepKey        SETGT     DCOVR
038200070925     C                   DOU       %Eof(DCOV22)
038300070925     C     DepKey        READPE    DCOVR
038400070925     C                   IF        NOT %Eof(DCOV22) AND DENRDT <> CCANDT
038500160623
038600070925     C                   IF        CCANDT = 0
038700070925     C                   EVAL      CCANDT = 99999999
038800070925     C                   ENDIF
038900160623
039000090313     C                   Exsr      BuildDepRec
039100070925     C                   LEAVESR
039200160623
039300070925     C                   ENDIF
039400070925     C                   ENDDO
039500160623
039600070925     C                   ENDSR
039700160623
039800160623      *================================================================
039900160623      * Build dependent record
040000160623      *================================================================
040100160623
040200160623     C     BuildDepRec   Begsr
040300160623
040400070924     C                   IF        CCANDT <> 99999999
040500070924     C     CNLDEP        CHAIN     METLIFR
040600070924     C                   IF        %FOUND(METLIFTRM)
040700070924     C                   LEAVESR
040800070924     C                   ELSE
040900070924     C                   CLEAR                   METLIFR
041000070924     C                   EVAL      NTSSNO = SSNO
041100070925     C                   EVAL      NTDEPNO = DSEQ#
041200070924     C                   EVAL      NTTERMDT = CCANDT
041300070924     C                   EVAL      NTPLAN = DVPLAN
041400070924     C                   EVAL      NTCOVTP  = MCOVTP
041500070924     C                   EVAL      NTTRST   = MCTRST
041600070924     C                   EVAL      NTSUB#   = MCSUB#
041700070924     C                   EVAL      NTACCT   = ACC#
041800070924     C                   WRITE     METLIFR
041900070924     C                   ENDIF
042000070924     C                   ENDIF
042100160623
042200070227     C                   Eval      PTRANCD   =   'D'
042300070227     C                   Movel     '00'          PEMPSSN
042400070227     C                   Move      MCSSNO        PEMPSSN
042500070228     C                   Move      DEPSS#        PMEMSSN
042600070227     C                   Eval      PMEMLNA   =   DLNAME                         Member Last Name
042700070227     C                   Eval      PMEMFNA   =   DFNAME                         Member First Name
042800070227     C                   Eval      PMEMMID   =   DMI                            Member First Name
042900070228     C                   Eval      PMEMSEX   =   DSEX                           Member Gender
043000160623
043100070227     C                   If        DSEX       <>  'M'    And
043200070227     C                             DSEX       <>  'F'
043300070228     C                   Eval      PMEMSEX   =   'U'                            Unknown
043400160623     C                   Endif
043500160623
043600070227     C                   If        DRELCD    <>  'RHU'   And
043700070227     C                             DRELCD    <>  'RWI'
043800070228     C                   Eval      PMEMMST   =   'S'
043900070227     C                   Else
044000070228     C                   Eval      PMEMMST   =   'M'
044100160623     C                   Endif
044200160623
044300070227     C     DBIRTH        Mult      10000.0001    DOB               8 0
044400070228     C                   Movel     DOB           PMEMBDT
044500160623     C                   Eval      PCOVTYP   =   'D '
044600160623
044700070925     C                   Movel     DENRDT        PCOVBDT
044800080117     C                   Movel     DENRDT        PCOVBDTN
044900160623
045000160623      *DEPENDENT OVERRIDE
045100071106     C                   IF        DENRDT < ENRLDT
045200071106     C                   MOVE      ENRLDT        PCOVBDT
045300080117     C                   MOVE      ENRLDT        PCOVBDTN
045400071106     C                   ENDIF
045500160623
045600070925     C                   IF        CCANDT = 99999999 OR CCANDT = 0
045700070925     C                   MOVE      '00000000'    PCOVEDT
045800070925     C                   ELSE
045900070925     C                   Movel     CCANDT        PCOVEDT
046000070925     C                   ENDIF
046100160623
046200070227     C                   Eval      PEMPPIN   =   *Blanks
046300070227     C                   Eval      PSURIND   =   *Blanks
046400070227     C                   Eval      PSURSSN   =   *Blanks
046500070227     C                   Eval      PSURLNA   =   *Blanks
046600070227     C                   Eval      PSURFNA   =   *Blanks
046700070227     C                   Eval      PFADDIN   =   'D'
046800110808     C                   Exsr      GetGrp
046900110808     C                   Eval      PSUBDIV   =   GroupSubDiv
047000120216     C                   Eval      PBRANCH   =   GroupBranch
047100090313     C                   Eval      PGROUP#   =   PCUSTNO
047200070228     C                   Eval      PPLANCD   =   *Blanks
047300160623
047400070227     C                   If        CEXPDT    <>  *Zeros
047500070228     C                   Eval      PCOBRAI   =   'CE'
047600090527     C                   Move      CEXPDT        PCOVEDT
047700160623     C                   Endif
047800160623
047900070227     C                   Select
048000070228     C                   When      CEXPDT   <>   *Zeros
048100070313     C                   When      CEXPDT    =   *Zeros
048200100226     C                   EndSl
048300160623
048400070227     C                   Select
048500160623
048600070227     C                   When      EMPST     =   'J'
048700070228     C                   Eval      PSTATCD   =   'R'
048800160623
048900070227     C                   When      HDCPDT    <>  *Zero
049000070228     C                   Eval      PSTATCD   =   'D'
049100160623
049200070227     C                   Other
049300070228     C                   Eval      PSTATCD   =   'A'
049400160623
049500070227     C                   EndSl
049600160623
049700070227     C                   Select
049800070227     C                   When      DRELCD    =   'RHU'  Or
049900070227     C                             DRELCD    =   'RWI'
050000070228     C                   Movel     '01'          PRELACD
050100160623
050200070227     C                   When      DRELCD    =   'RSO'  Or
050300090921     C                             DRELCD    =   'RDA'  Or
050400090921     C                             DRELCD    =   'RA '  Or
050500090921     C                             DRELCD    =   'RB '
050600070228     C                   Movel     '02'          PRELACD
050700160623
050800130625     C                   When      DRELCD    =   'RPA'
050900130625     C                   Movel     '03'          PRELACD
051000160623
051100070227     C                   EndSl
051200160623
051300041220     C                   Select
051400070228     C                   When      MCOVTP    =   'TPC'  Or
051500070228     C                             MCOVTP    =   'TP2'
051600070228     C                   Eval      PMEMCCD   =   '2'
051700160623
051800070228     C                   When      MCOVTP    =   'THW'
051900070228     C                   Eval      PMEMCCD   =   '3'
052000160623
052100070228     C                   When      MCOVTP    =   'TFA'
052200070228     C                   Eval      PMEMCCD   =   '4'
052300160623
052400041220     C                   Endsl
052500160623
052600090313     C                   Exsr      WriteRec
052700160623
052800021007     C                   Endsr
052900160623
053000160623      *================================================================
053100090225      * Fill DENTAL Block of Record Format
053200160623      *================================================================
053300160623
053400090225     C     DentalSr      BEGSR
053500160623
053600090225     C                   Eval      PCOVTYP   =   'D '
053700090225     C                   Move      ENRLDT        PCOVBDT
053800090225     C                   Move      ENRLDT        PCOVBDTN          8 0
053900160623
054000160623      * COBRA OVERRIDE
054100090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
054200090225     C                   MOVE      GBSCDT        PCOVBDT
054300090225     C                   Move      GBSCDT        PCOVBDTN
054400090225     C                   ENDIF
054500160623
054600160623     C                   if        plncat = DentalCobra
054700160623     C                   eval      pcobrai = 'CE'
054800160623     c                   endif
054900160623
055000090225     C                   IF        CANDT = 99999999 OR CANDT = 0
055100090225     C                   MOVE      '00000000'    PCOVEDT
055200090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
055300090225     C                   ELSE
055400090225     C                   Move      CANDT         PCOVEDT
055500090225     C                   MOVE      CANDT         PCOVEDTN
055600090225     C                   ENDIF
055700160623
055800090225     C                   Exsr      GetGrp
055900090527     C                   Eval      PGROUP#   =   PCUSTNO
056000110808     C                   Eval      PSUBDIV   =   GroupSubDiv
056100120216     C                   Eval      PBRANCH   =   GroupBranch
056200160623
056300090225     C                   Eval      PPLANCD   =   *Blanks
056400160623
056500090225     C                   If        CEXPDT    <>  *Zeros
056600090225     C                   Eval      PCOBRAI   =   'CE'
056700090527     C                   Move      CEXPDT        PCOVEDT
056800160623     C                   Endif
056900160623
057000090227     C                   Select
057100090225     C                   When      EMPST     =   'J'
057200090225     C                   Eval      PSTATCD   =   'R'
057300160623
057400090225     C                   When      HDCPDT    <>  *Zero
057500090225     C                   Eval      PSTATCD   =   'D'
057600160623
057700090225     C                   Other
057800090225     C                   Eval      PSTATCD   =   'A'
057900160623
058000090225     C                   EndSl
058100160623
058200090225     C                   Select
058300090225     C                   When      MCOVTP    =   'TIN'
058400160623
058500090225     C                   Eval      PMEMCCD   =   '1'
058600090225     C                   When      MCOVTP    =   'TPC'  Or
058700090225     C                             MCOVTP    =   'TP2'
058800160623
058900090225     C                   Eval      PMEMCCD   =   '2'
059000090225     C                   When      MCOVTP    =   'THW'
059100160623
059200090225     C                   Eval      PMEMCCD   =   '3'
059300090225     C                   When      MCOVTP    =   'TFA'
059400160623
059500090225     C                   Eval      PMEMCCD   =   '4'
059600090225     C                   Endsl
059700160623
059800090227     C                   Eval      PDEPCLS   =   *Blanks
059900160623
060000090312     C                   Exsr      WriteRec
060100160623
060200090225     C                   Endsr
060300160623
060301190530      //===============================================================
060302190530      // Fill vision Block of Record Format
060303190530      //===============================================================
060304190530
060305190530       begsr visionSR;
060306190530
060307190530        ptypco6 = 'VV';
060308190530        pcostd6 = %char(enrldt);
060309190530        pcovbdtn = enrldt;
060310190530
060312190530        if empst = 'C' and gbscdt > enrldt;
060313190530         pcostd6 = %char(enrldt);
060314190530         pcovbdtn = gbscdt;
060315190530        endif;
060316190530
060317190530        if plncat = visioncobra;
060318190530         pcobra6 = 'CE';
060319190530        endif;
060320190530
060321190530        if candt = 99999999 or candt = 0;
060322190530         pcoend6 = '00000000';
060323190530         pcovedtn = 0;
060324190530        else;
060325190530         pcoend6 = %char(candt);
060326190530         pcovedtn = candt;
060327190530        endif;
060328190530
060329190530        exsr getGrp;
060330190530
060331190530        pgroup6 = pcustno;
060332190530        psubdi6 = GroupSubDiv;
060333190530        pbranc6 = GroupBranch;
060335190530        pplanc6 = ' ';
060336190530
060337190530        if cexpdt <> 0;
060338190530         pcobra6 = 'CE';
060339190530         pcostd6 = %char(cexpdt);
060340190530        endif;
060341190530
060342190530        select;
060343190530         when empst = 'J';
060344190530          pstatc6 ='R';
060345190530
060346190530         when hdcpdt <> 0;
060347190530          pstatc6 = 'D';
060348190530
060349190530         other;
060350190530          pstatc6 = 'A';
060352190530        endsl;
060353190530
060354190530        select;
060355190530         when mcovtp = 'TIN';
060357190530          pmemcc6 = '1';
060358190530
060359190530         when mcovtp = 'TPC'  or mcovtp = 'TP2';
060362190530          pmemcc6 = '2';
060363190530
060364190530         when mcovtp = 'THW';
060366190530          pmemcc6 = '3';
060367190530
060368190530         when mcovtp = 'TFA';
060370190530          pmemcc6 = '4';
060371190530        endsl;
060372190530
060373190530        //PDEPCLS   =   *Blanks
060374190530
060375190530        exsr writeRec;
060376190530
060377190530       endsr;
060378190530
060400160623      *================================================================
060500090225      * Fill LIFE Block of Record Format
060600160623      *================================================================
060700160623
060800090225     C     LifeSr        BEGSR
060900160623
061000090227     C                   Eval      PTYPCO2   =   'CP'
061100090304     C                   Move      ENRLDT        PCOSTD2
061200090225     C                   Move      ENRLDT        PCOVBDTN          8 0
061300160623
061400160623      * COBRA OVERRIDE
061500090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
061600090304     C                   MOVE      GBSCDT        PCOSTD2
061700090225     C                   Move      GBSCDT        PCOVBDTN
061800090225     C                   ENDIF
061900161014
062000090225     C                   IF        CANDT = 99999999 OR CANDT = 0
062100090304     C                   MOVE      '00000000'    PCOEND2
062200090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
062300090225     C                   ELSE
062400090304     C                   Move      CANDT         PCOEND2
062500090225     C                   MOVE      CANDT         PCOVEDTN
062600090225     C                   ENDIF
062700160623
062800090225     C                   Exsr      GetGrp
062900090227     C                   Eval      PPLANC2   =   *Blanks
063000160623
063100090225     C                   If        CEXPDT    <>  *Zeros
063200090227     C                   Eval      PCOBRA2   =   'CE'
063300090527     C                   Move      CEXPDT        PCOEND2
063400160623     C                   Endif
063500160623
063600090227     C                   Select
063700160623
063800090225     C                   When      EMPST     =   'J'
063900090227     C                   Eval      PSTATC2   =   'R'
064000160623
064100090225     C                   When      HDCPDT    <>  *Zero
064200090227     C                   Eval      PSTATC2   =   'D'
064300160623
064400090225     C                   Other
064500090227     C                   Eval      PSTATC2   =   'A'
064600160623
064700090225     C                   EndSl
064800160623
064900090225     C                   Select
065000160623
065100090225     C                   When      MCOVTP    =   'TIN'
065200090227     C                   Eval      PMEMCC2   =   '1'
065300160623
065400090225     C                   When      MCOVTP    =   'TPC'  Or
065500090225     C                             MCOVTP    =   'TP2'
065600090227     C                   Eval      PMEMCC2   =   '2'
065700160623
065800090225     C                   When      MCOVTP    =   'THW'
065900090227     C                   Eval      PMEMCC2   =   '3'
066000160623
066100090225     C                   When      MCOVTP    =   'TFA'
066200090227     C                   Eval      PMEMCC2   =   '4'
066300160623
066400090225     C                   Endsl
066500160623
066600090227     C                   Eval      PDEPCL2   =   *Blanks
066700090304     C                   Move      BENAMT        PINSAM2
066800090320     C                   Movel     '0'           PINSAM2
066900160623
067000090312     C                   Movel     'A'           PSAMOD2
067100090312     C                   Move      SALARY        PSALAR2
067200160623
067300090312     C                   Exsr      WriteRec
067400160623
067500090225     C                   Endsr
067600160623
067700160623      *================================================================
067800090225      * Fill AD&D Block of Record Format
067900160623      *================================================================
068000160623
068100090225     C     AD_DSr        BEGSR
068200160623
068300090227     C                   Eval      PTYPCO3   =   'AD'
068400090304     C                   Move      ENRLDT        PCOSTD3
068500090225     C                   Move      ENRLDT        PCOVBDTN          8 0
068600160623
068700160623      * COBRA OVERRIDE
068800090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
068900090304     C                   MOVE      GBSCDT        PCOSTD3
069000090225     C                   Move      GBSCDT        PCOVBDTN
069100090225     C                   ENDIF
069200161014
069300090225     C                   IF        CANDT = 99999999 OR CANDT = 0
069400090304     C                   MOVE      '00000000'    PCOEND3
069500090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
069600090225     C                   ELSE
069700090304     C                   Move      CANDT         PCOEND3
069800090225     C                   MOVE      CANDT         PCOVEDTN
069900090225     C                   ENDIF
070000160623
070100090225     C                   Exsr      GetGrp
070200160623
070300090227     C                   Eval      PPLANC3   =   *Blanks
070400160623
070500090225     C                   If        CEXPDT    <>  *Zeros
070600090227     C                   Eval      PCOBRA3   =   'CE'
070700090527     C                   Move      CEXPDT        PCOEND3
070800160623     C                   Endif
070900160623
071000090227     C                   Select
071100160623
071200090225     C                   When      EMPST     =   'J'
071300090227     C                   Eval      PSTATC3   =   'R'
071400160623
071500090225     C                   When      HDCPDT    <>  *Zero
071600090227     C                   Eval      PSTATC3   =   'D'
071700160623
071800090225     C                   Other
071900090227     C                   Eval      PSTATC3   =   'A'
072000160623
072100090225     C                   EndSl
072200090225      *
072300090225     C                   Select
072400090225     C                   When      MCOVTP    =   'TIN'
072500090227     C                   Eval      PMEMCC3   =   '1'
072600160623
072700090225     C                   When      MCOVTP    =   'TPC'  Or
072800090225     C                             MCOVTP    =   'TP2'
072900090227     C                   Eval      PMEMCC3   =   '2'
073000160623
073100090225     C                   When      MCOVTP    =   'THW'
073200090227     C                   Eval      PMEMCC3   =   '3'
073300160623
073400090225     C                   When      MCOVTP    =   'TFA'
073500090227     C                   Eval      PMEMCC3   =   '4'
073600160623
073700090225     C                   Endsl
073800160623
073900090227     C                   Eval      PDEPCL3   =   *Blanks
074000090304     C                   Move      BENAMT        PINSAM3
074100090320     C                   Movel     '0'           PINSAM3
074200160623
074300090312     C                   Movel     'A'           PSAMOD3
074400090312     C                   Move      SALARY        PSALAR3
074500160623
074600090312     C                   Exsr      WriteRec
074700160623
074800090225     C                   Endsr
074900160623
075000160623      *================================================================
075100090225      * Fill LTD Block of Record Format
075200160623      *================================================================
075300160623
075400090225     C     LTDSr         BEGSR
075500160623
075600090312     C                   Eval      PTYPCO5   =   'LT'
075700090313     C                   Move      ENRLDT        PCOSTD5
075800090225     C                   Move      ENRLDT        PCOVBDTN          8 0
075900160623
076000160623      * COBRA OVERRIDE
076100090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
076200090312     C                   MOVE      GBSCDT        PCOSTD5
076300090225     C                   Move      GBSCDT        PCOVBDTN
076400090225     C                   ENDIF
076500161014
076600090225     C                   IF        CANDT = 99999999 OR CANDT = 0
076700090312     C                   MOVE      '00000000'    PCOEND5
076800090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
076900090225     C                   ELSE
077000090312     C                   Move      CANDT         PCOEND5
077100090225     C                   MOVE      CANDT         PCOVEDTN
077200090225     C                   ENDIF
077300160623
077400090225     C                   Exsr      GetGrp
077500090312     C                   Eval      PPLANC5   =   *Blanks
077600160623
077700090225     C                   If        CEXPDT    <>  *Zeros
077800090312     C                   Eval      PCOBRA5   =   'CE'
077900090527     C                   Move      CEXPDT        PCOEND5
078000160623     C                   Endif
078100160623
078200090227     C                   Select
078300160623
078400090225     C                   When      EMPST     =   'J'
078500090312     C                   Eval      PSTATC5   =   'R'
078600160623
078700090225     C                   When      HDCPDT    <>  *Zero
078800090312     C                   Eval      PSTATC5   =   'D'
078900160623
079000090225     C                   Other
079100090312     C                   Eval      PSTATC5   =   'A'
079200160623
079300090225     C                   EndSl
079400160623
079500090225     C                   Select
079600160623
079700090225     C                   When      MCOVTP    =   'TIN'
079800090312     C                   Eval      PMEMCC5   =   '1'
079900160623
080000090225     C                   When      MCOVTP    =   'TPC'  Or
080100090225     C                             MCOVTP    =   'TP2'
080200090312     C                   Eval      PMEMCC5   =   '2'
080300160623
080400090225     C                   When      MCOVTP    =   'THW'
080500090312     C                   Eval      PMEMCC5   =   '3'
080600160623
080700090225     C                   When      MCOVTP    =   'TFA'
080800090312     C                   Eval      PMEMCC5   =   '4'
080900160623
081000090225     C                   Endsl
081100160623
081200090312     C                   Eval      PDEPCL5   =   *Blanks
081300090313     C                   Move      BENAMT        PINSAM5
081400090320     C                   Movel     '0'           PINSAM5
081500160623
081600090312     C                   Movel     'A'           PMOSAL5
081700090312     C                   Move      SALARY        PSALAM5
081800160623
081900090312     C                   Exsr      WriteRec
082000160623
082100090225     C                   Endsr
082200160623
082300160623      *===================================================================
082400090225      * Fill STD Block of Record Format
082500160623      *===================================================================
082600160623
082700090225     C     STDSr         BEGSR
082800160623
082900090312     C                   Eval      PTYPCO4   =   'AS'
083000090312     C                   Move      ENRLDT        PCOSTD4
083100090225     C                   Move      ENRLDT        PCOVBDTN          8 0
083200160623
083300160623      * COBRA OVERRIDE
083400090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
083500090312     C                   MOVE      GBSCDT        PCOSTD4
083600090225     C                   Move      GBSCDT        PCOVBDTN
083700090225     C                   ENDIF
083800160623
083900090225     C                   IF        CANDT = 99999999 OR CANDT = 0
084000090312     C                   MOVE      '00000000'    PCOEND4
084100090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
084200090225     C                   ELSE
084300090312     C                   Move      CANDT         PCOEND4
084400090225     C                   MOVE      CANDT         PCOVEDTN
084500090225     C                   ENDIF
084600160623
084700090225     C                   Exsr      GetGrp
084800090312     C                   Eval      PPLANC4   =   *Blanks
084900160623
085000090225     C                   If        CEXPDT    <>  *Zeros
085100090312     C                   Eval      PCOBRA4   =   'CE'
085200090527     C                   Move      CEXPDT        PCOEND4
085300160623     C                   Endif
085400160623
085500090227     C                   Select
085600160623
085700090225     C                   When      EMPST     =   'J'
085800090312     C                   Eval      PSTATC4   =   'R'
085900160623
086000090225     C                   When      HDCPDT    <>  *Zero
086100090312     C                   Eval      PSTATC4   =   'D'
086200160623
086300090225     C                   Other
086400090312     C                   Eval      PSTATC4   =   'A'
086500160623
086600090225     C                   EndSl
086700160623
086800090225     C                   Select
086900160623
087000090225     C                   When      MCOVTP    =   'TIN'
087100090312     C                   Eval      PMEMCC4   =   '1'
087200160623
087300090227     C                   When      MCOVTP    =   'TPC'  Or
087400090225     C                             MCOVTP    =   'TP2'
087500090312     C                   Eval      PMEMCC4   =   '2'
087600160623
087700090225     C                   When      MCOVTP    =   'THW'
087800090312     C                   Eval      PMEMCC4   =   '3'
087900160623
088000090225     C                   When      MCOVTP    =   'TFA'
088100090312     C                   Eval      PMEMCC4   =   '4'
088200160623
088300090225     C                   Endsl
088400160623
088500090312     C                   Eval      PDEPCL4   =   *Blanks
088600090312     C                   Move      BENAMT        PINSAM4
088700090320     C                   Movel     '0'           PINSAM4
088800160623
088900090312     C                   Movel     'A'           PMOSAL4
089000090312     C                   Move      SALARY        PSALAM4
089100160623
089200090312     C                   Exsr      WriteRec
089300160623
089400090225     C                   Endsr
089500160623
089600160816      //===================================================================
089700160816      // Get group number
089800160816      //===================================================================
089900160816
090000160816       begsr getgrp;
090100160816
090200160816        setll (mctrst : mcsub# : mcplan : mcageb : mcovtp) grater;
090300160816        reade (mctrst : mcsub# : mcplan : mcageb : mcovtp) grater;
090400160816
090500160816        dow not %eof;
090600160816
090700160816         if today >= frmdat;
090800160816          if today <= todat;
090900160816           exsr FmtGrp;
091000160816            leavesr;
091100160816          else;
091200160816           group# = ' ';
091300160816          endif;
091400160816         endif;
091500160816
091600160816        reade (mctrst : mcsub# : mcplan : mcageb : mcovtp) grater;
091700160816        enddo;
091800160816
091900160816        // When coverage is termed, there may be no current rate, still need grp#
092000160816        if pcustno = ' ';
092100160816         exsr FmtGrp;
092200160816        endif;
092300160816
092400190530       endsr;
092500160816
092600160623      *===================================================================
092700080117      * Retrieve the group number from the GRATE file.
092800160623      *===================================================================
092900160623
093000160816     C     Getgrp2       BEGSR
093100160623
093200080117     c     RatKey        Setll     GRATE
093300080903     c     RatKey        Reade     GRATE
093400080903     c                   Dow       not %eof(GRATE)
093500080117     C                   If        (PCOVBDTN >=  FRMDAT) and
093600110818     C                             (PCOVEDTN <=  TODAT)
093700110818      **** TEST ****
093800160623     C                             Or
093900110818      * Member's coverage is Active
094000110818     C                             (PCOVEDTN  =  *Zeros  Or
094100110818     C                              PCOVEDTN >=  Today)  And
094200110818      * Rate may begin after member's coverage but is still active.
094300110818     C                             (Today    <=  TODAT)
094400110818      **** TEST ****
094500160623
094600090312     C                   Exsr      FmtGrp
094700160623     C                   Endif
094800160623
094900080903     c     RatKey        Reade     GRATE
095000080117     C                   EndDo
095100160623
095200160623      * When coverage is termed, there may be no current rate; still need grp
095300110808     C                   If        PCUSTNO    =  *Blanks
095400090312     C                   Exsr      FmtGrp
095500160623     C                   Endif
095600160623
095700080117     C                   Endsr
095800160623
095900160623      *===================================================================
096000090312      * Format the group number.
096100160623      *===================================================================
096200160623
096300090312     C     Fmtgrp        BEGSR
096400160623
096500160623      * The 1st 7 digits of group# are moved into group, next 4 subd, next 4 branch
096600110808     C                   Clear                   GroupFmt
096700110808     C                   Eval      GroupFmt   =  GROUP#
096800160623
096900110815     C                   Select
097000160623
097100160623     C                   When       PLNCAT    =   Dental Or
097200160623     C                              PLNCAT    =   DentalDC or
097300160623     C                              PLNCAT    =   DentalCobra
097400160623     C****                          PLNCAT    =   DentalDC Or
097500160301     C****                          ACTION    =   'D'
097600110815     C                   Eval      PCUSTNO    =  GroupGroup
097700110808     C                   Eval      PSUBDIV    =  GroupSubDiv
097800110808     C                   Eval      PBRANCH    =  GroupBranch
097900160623
098000110815     C                   When      PLNCAT     =  Life
098100110818     C                   Eval      PCUSTNO    =  GroupGroup
098200110815     C                   Eval      PGROUP2    =  GroupGroup
098300110815     C                   Eval      PSUBDI2    =  GroupSubDiv
098400110815     C                   Eval      PBRANC2    =  GroupBranch
098500160623
098600110815     C                   When      PLNCAT    =   AD_D
098700110818     C                   Eval      PCUSTNO    =  GroupGroup
098800110815     C                   Eval      PGROUP3    =  GroupGroup
098900110815     C                   Eval      PSUBDI3    =  GroupSubDiv
099000110815     C                   Eval      PBRANC3    =  GroupBranch
099100160623
099200110815     C                   When      PLNCAT    =   LTD
099300110818     C                   Eval      PCUSTNO    =  GroupGroup
099400110815     C                   Eval      PGROUP5    =  GroupGroup
099500110815     C                   Eval      PSUBDI5    =  GroupSubDiv
099600110815     C                   Eval      PBRANC5    =  GroupBranch
099700160623
099800110815     C                   When      PLNCAT    =   STD
099900110818     C                   Eval      PCUSTNO    =  GroupGroup
100000110815     C                   Eval      PGROUP4    =  GroupGroup
100100110815     C                   Eval      PSUBDI4    =  GroupSubDiv
100200110815     C                   Eval      PBRANC4    =  GroupBranch
100201190530
100202190530     C                   When      PLNCAT =  vision or
100203190530     C                             PLNCAT =  visioncobra
100207190530     C                   Eval      PCUSTNO    =  GroupGroup
100208190530     C                   Eval      PGROUP6    =  GroupGroup
100209190530     C                   Eval      PSUBDI6    =  GroupSubDiv
100210190530     C                   Eval      PBRANC6    =  GroupBranch
100212190530
100300110815     C                   EndSl
100400160623
100500140616     C                   Endsr
100600160623
100700160623      *===================================================================
100800090313      * Prepare Dependent Record for Update
100900160623      *===================================================================
101000160623
101100090313     C     PrepRecordD   BEGSR
101200160623
101300090312     C                   Move      MCSSNO        Kssno            11
101400090312     C                   Movel     '00'          Kssno
101500090313     C                   Move      DEPSS#        Mssno             9
101600160908
101700160908     C     BIRTH         Mult      10000.0001    dob
101800160908
101900160908       dbirthc = %editc(dob:'X');
102000160623
102100160908     C     PKey2         chain     METLIFEWTL
102200160729     C                   If        Not %found(METLIFEWTL)
102300090313     C                   Clear                   PROEXPR
102400090313     C                   Clear                   PROUPDR
102500090313     C                   Eval      Data = 'A'
102600090313     C                   Else
102700160623
102800090901     C                   If        DFNAME   =    PMEMFNA     And
102900090901     C                             DMI      =    PMEMMID
103000160301     C                   Eval      Data = 'U'
103100090901     C                   Else
103200090901     C                   Clear                   PROEXPR
103300090901     C                   Clear                   PROUPDR
103400090901     C                   Eval      Data = 'A'
103500160623     C                   Endif
103600160623
103700160623     C                   Endif
103800160623
103900140616     C                   Endsr
104000160623
104100160623      *===================================================================
104200090313      * Prepare Record for Update
104300160623      *===================================================================
104400160623
104500090313     C     PrepRecord    BEGSR
104600160623
104700090313     C                   Move      MCSSNO        Kssno            11
104800090313     C                   Movel     '00'          Kssno
104900090313     C                   Move      MCSSNO        Mssno             9
105000160908     C     BIRTH         Mult      10000.0001    dob
105100160908
105200160908       dbirthc = %editc(dob:'X');
105300160908
105400160908     C     PKey2         chain     METLIFEWTL
105500160729     C                   If        Not %found(METLIFEWTL)
105600090313     C                   Clear                   PROEXPR
105700090313     C                   Clear                   PROUPDR
105800090313     C                   Eval      Data = 'A'
105900090313     C                   Else
106000160301     C                   Eval      Data = 'U'
106100160623     C                   Endif
106200160623
106300140616     C                   Endsr
106400160623
106500160623      *===================================================================
106600090313      * Write or update a record
106700160623      *===================================================================
106800160623
106900090313     C     WriteRec      BEGSR
107000160623
107100160818       if pcustno <> 'IN PROC';
107200160818
107300090313     C                   Select
107400160623
107500090313     C                   When      Data = 'A'
107600090313     C                   Write     PROEXPR
107700160623
107800160301     C                   When      Data = 'U'
107900160301     C                   Update    PROUPDR
108000160623
108100090313     C                   Endsl
108200160623
108300090313     C                   Clear                   Data
108400090313     C                   Clear                   PROEXPR
108500090313     C                   Clear                   PROUPDR
108600160818
108700160818       endif;
108800160623
108900140616     C                   Endsr
109000160623
109100161014      //==================================================================
109200161014
109300161014       begsr exit;
109400161014
109500161014        *inlr = '1';
109600161014        return;
109700161014
109800161014       endsr;
109900161014
110000160623      *================================================================
110100161014      * Init
110200160623      *================================================================
110300160623
110400161014     C     init          Begsr
110500160623
110600161014     C     CodKey        Klist
110700161014     C                   Kfld                    Typ
110800161014     C                   Kfld                    Cod
110900161014
111000161014     C     PlnKey        Klist
111100161014     C                   Kfld                    PLTRST
111200161014     C                   Kfld                    PLSUB#
111300161014     C                   Kfld                    PLPLAN
111400161014
111500161014     C     CNLMBR        Klist
111600161014     C                   Kfld                    MCSSNO
111700161014     C                   Kfld                    MDSEQ#
111800161014     C                   Kfld                    CANDT
111900161014     C                   Kfld                    MCPLAN
112000161014     C                   Kfld                    MCOVTP
112100161014     C                   Kfld                    MCTRST
112200161014     C                   Kfld                    MCSUB#
112300161014     C                   Kfld                    ACC#
112400161014
112500161014     C     DepKey        Klist
112600161014     C                   Kfld                    MCTRST
112700161014     C                   Kfld                    MCSUB#
112800161014     C                   Kfld                    MCPLAN
112900161014     C                   Kfld                    DSSNO
113000161014     C                   Kfld                    DPSEQ#
113100161014
113200161014     C     CNLDEP        Klist
113300161014     C                   Kfld                    SSNO
113400161014     C                   Kfld                    DSEQ#
113500161014     C                   Kfld                    CCANDT
113600161014     C                   Kfld                    DVPLAN
113700161014     C                   Kfld                    MCOVTP
113800161014     C                   Kfld                    MCTRST
113900161014     C                   Kfld                    MCSUB#
114000161014     C                   Kfld                    ACC#
114100161014
114200161014     C     RATKEY        KLIST
114300161014     C                   KFLD                    MCTRST
114400161014     C                   KFLD                    MCSUB#
114500161014     C                   KFLD                    MCPLAN
114600161014     C                   KFLD                    MCAGEB
114700161014     C                   KFLD                    MCOVTP
114800161014
114900161014     C     PKey          Klist
115000161014     C                   Kfld                    Kssno
115100161014     C                   Kfld                    Mssno
115200161014
115300161014     C     PKey2         Klist
115400161014     C                   Kfld                    Kssno
115500161014     C                   Kfld                    Mssno
115600161014     C                   Kfld                    dbirthc
115700161014     C                   Kfld                    dfname
115800161014
115900161014     C     KL#TSA        KLIST
116000161014     C                   KFLD                    MCTRST
116100161014     C                   KFLD                    MCSUB#
116200161014     C                   KFLD                    ACC#
116300161014
116400140616     C                   EVAL      #ISO = %DATE
116500140616     C                   MOVE      #ISO          TODAY             8 0
116600041220     C                   Eval      FILLER1    =  *Blanks
116700041220     C                   Eval      FILLER2    =  *Blanks
116800160729
116900160817       // chain unique caraccr;
117000160729
117100140616     C                   Endsr
117200160623
117300160623      *================================================================
