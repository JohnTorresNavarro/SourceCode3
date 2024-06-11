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
002100161014      *=========================================================================
002200161014
002300070924     FPLNMSTN1  IF   E           K Disk
002400161014      * Plan Master...
002500161014
002600070227     FMCOV39    IF   E           K Disk
002700161014      * Member coverage...
002800161014
002900070228     FMEMBER    IF   E           K Disk
003000161014      * Member master...
003100161014
003200070925     FDEPNDC    IF   E           K Disk
003300161014      * Dependent coverage...
003400161014
003500070227     FDCOV22    IF   E           K Disk
003600161014      * Dependent coverage...
003700161014
003800080117     FGRATE     IF   E           K Disk
003900161014      * Group rate...
004000161014
004100100421     FCODES     IF   E           K Disk
004200161014      * Codes
004300161014
004400160729     Fcaraccp   if   e           k disk
004500161014      * Carrier export control...
004600161014
004700140616     FMETRANSOFFIF   E           K Disk
004800161014      * Transmission off for Metlife groups...
004900161014
005000160729     FMETLIFEWFTO  A E           K DISK
005100161014      * Metlife export...
005200161014
005300160729     FMETLIFEWTLUF   E           K DISK    rename(proexpr:proupdr)
005400161014      * Metlife export logical...
005500161014
005600070924     FMETLIFTRM IF A E           K DISK
005700161014      * Metlife terms...
005800161014
005900160831     FMETLIFERCVIF   E           K DISK    rename(metlifr:tempFile)
006000161014      * Processing groups...
006100161014
006200161014      *=========================================================================
006300161014
006400161014     D PlanCat         DS             3
006500161014     D  Typ                           1
006600161014     D  Cod                           2
006700161014
006800160826     D TrSuAc          ds            12
006900160826     D  Trust                         3
007000160826     D  Dash1                         1    inz('-')
007100160817     D  Sub                           3
007200160826     D  Dash2                         1    inz('-')
007300160817     D  acct                          4
007400161014
007500161014     D                 DS
007600161014     D GroupFmt                1     15A
007700161014     D GroupGroup              1      7A
007800161014     D GroupSubDiv             8     11A
007900161014     D GroupBranch            12     15A
008000161014
008100140616     D #ISO            S               D   DATFMT(*ISO)
008200090313     D Data            S              1A
008300070227     D No              S              1A   Inz('N')
008400070227     D Yes             S              1A   Inz('Y')
008500160826     D TrSuAc12        s             12
008600160816     D Trust5          S              3A   Inz('EDT')
008700070227     D Dental          S              3A   Inz('PDN')
008800100420     D DentalDC        S              3A   Inz('PDR')
008900160623     D DentalCobra     S              3A   Inz('PCD')
009000080923     D Life            S              3A   Inz('PLF')
009100080923     D AD_D            S              3A   Inz('PAC')
009200080923     D LTD             S              3A   Inz('PLT')
009300080923     D STD             S              3A   Inz('PWD')
009400160908     D dbirthc         S              8
009500160817     D*unique          S             10A   Inz('0000000166')
009600160729
009700161014      //========================================================================
009800161014      // Mainline
009900161014      //========================================================================
010000161014
010100161014       exsr init;
010200161014       exsr main;
010300161014       exsr exit;
010400161014
010500161014      //========================================================================
010600161014      // Main
010700161014      //========================================================================
010800161014
010900161014       begsr main;
011000160623
011100090313      * Check for MEL - Life Products
011200160816     C     Trust5        SETLL     PLNMSR
011300160816     C     Trust5        ReadE     PLNMSR
011400161014
011500090313     C                   DOW       not %EOF(PLNMSTN1)
011600161014
011700090313     C                   If         PLNCAT    =   Life      Or
011800090313     C                              PLNCAT    =   AD_D      Or
011900090313     C                              PLNCAT    =   LTD       Or
012000090313     C                              PLNCAT    =   STD
012100161014
012200090313     C                   EXSR      LOADRCD
012300161014
012400160623     C                   Endif
012500161014
012600160816     C     Trust5        ReadE     PLNMSR
012700090313     C                   Enddo
012800160623
012900100401      * Check for MED - Metlife Dental - DAILY Proration
013000160816     C     Trust5        SETLL     PLNMSR
013100160816     C     Trust5        ReadE     PLNMSR
013200161014
013300100401     C                   DOW       not %EOF(PLNMSTN1)
013400161014
013500100421     C                   Movel     PLNCAT        PlanCat
013600161014
013700100421     C     CodKey        Chain     CODES
013800100420     C                   If         PLNCAT    =   Dental  Or
013900160623     C                              PLNCAT    =   DentalDC or
014000160623     C                              PLNCAT    =   DentalCobra
014100160301     C****                          PLNCAT    =   DentalDC  Or
014200160301     C****                          ACTION    =   'D'
014300161014
014400100401     C                   EXSR      LOADRCD
014500161014
014600160623     C                   Endif
014700160623
014800160816     C     Trust5        ReadE     PLNMSR
014900100401     C                   Enddo
015000160623
015100161014       endsr;
015200160623
015300160623      *=========================================================================
015400160623      * Load records
015500160623      *=========================================================================
015600160623
015700090313     C     LOADRCD       BEGSR
015800160623
015900160817     C     PlnKey        chain     MCOV39
016000161014
016100161014       //exsr moveFields;
016200160817
016300161014       //chain (TrSuAc12) tempfile;
016400161014       //if %found;
016500161014       // if prc = 'OK';
016600160817
016700070228     C     PlnKey        Setll     MCOV39
016800090313     C                   DOW       not %Eof(MCOV39)
016900090313     C     PlnKey        Reade     MCOV39
017000160817
017100160817     C                   MOVE      *ZEROS        H@SSN             9 0
017200160622     C                   if        not %eof
017300160622
017400160909     C                   IF        ENRLDT <> CANDT
017500160816     C****                         and ENRLDT <= Today
017600160623
017700160623      * OLD TERMED ACCOUNT
017800140616     C     KL#TSA        CHAIN     MTOF
017900140616     C                   IF        %FOUND(METRANSOFF) AND TODAY > MTOLASDTE
018000140616     C                             AND MTOLASDTE <> 0
018100140616     C                   ITER
018200140616     C                   ENDIF
018300160623
018400070921     C                   IF        CANDT = 0
018500070921     C                   EVAL      CANDT = 99999999
018600070921     C                   ENDIF
018700160623
018800070921     C                   IF        MCSSNO <> H@SSN
018900090313     C                   Exsr      PrepRecord
019000070227     C                   Exsr      Process
019100070924     C                   EVAL      H@SSN = MCSSNO
019200070921     C                   ENDIF
019300160623
019400160622     C                   endif
019500160909     C                   ENDIF
019600070921     C                   ENDDO
019700160623
019800161014        //endif;
019900161014       //endif;
020000160729
020100090313     C                   ENDSR
020200160729
020300160817       //==============================================================
020400160817       // move fields
020500160817       //==============================================================
020600160817
020700160817       begsr moveFields;
020800160817
020900160826        //trust = %char(mctrst);
021000160826        trust = %editc(mctrst:'X');
021100160817        sub = %editc(mcsub#:'X');
021200160817        acct = %editc(acc#:'X');
021300160817
021400160826        TrSuAc12 = TrSuAc;
021500160817
021600160817       endsr;
021700160817
021800160623      *================================================================
021900160623      * Process
022000160623      *================================================================
022100160623
022200070227     C     Process       Begsr
022300160623
022400070228     C     MCSSNO        Chain     MEMBER
022500160623
022600070924     C                   IF        CANDT <> 99999999
022700070924     C     CNLMBR        CHAIN     METLIFR
022800070924     C                   IF        %FOUND(METLIFTRM)
022900070924     C                   LEAVESR
023000070924     C                   ELSE
023100120430     C                   If        CANDT <= Today
023200070924     C                   CLEAR                   METLIFR
023300070924     C                   EVAL      NTSSNO = MCSSNO
023400070925     C                   EVAL      NTDEPNO = 00
023500070924     C                   EVAL      NTTERMDT = CANDT
023600070924     C                   EVAL      NTPLAN = MCPLAN
023700070924     C                   EVAL      NTCOVTP  = MCOVTP
023800070924     C                   EVAL      NTTRST   = MCTRST
023900070924     C                   EVAL      NTSUB#   = MCSUB#
024000070924     C                   EVAL      NTACCT   = ACC#
024100090527     C                   Eval      NTTRANSDT = Today
024200070924     C                   WRITE     METLIFR
024300160623     C                   Endif
024400070924     C                   ENDIF
024500070924     C                   ENDIF
024600160623
024700070227     C                   Eval      PTRANCD   =   'E'
024800070227     C                   Movel     '00'          PEMPSSN
024900070227     C                   Move      MCSSNO        PEMPSSN
025000070228     C                   Move      MCSSNO        PMEMSSN
025100070227     C                   Eval      PMEMLNA   =   MLNAME                         Member Last Name
025200070227     C                   Eval      PMEMFNA   =   MFNAME                         Member First Name
025300070227     C                   Eval      PMEMMID   =   MMI                            Member First Name
025400070228     C                   Eval      PMEMSEX   =   SEX                            Member Gender
025500160623
025600070227     C                   If        SEX       <>  'M'    And
025700070227     C                             SEX       <>  'F'
025800070228     C                   Eval      PMEMSEX   =   'U'                            Unknown
025900160623     C                   Endif
026000160623
026100070228     C                   If        MARDT     =   *Zeros
026200070228     C                   Eval      PMEMMST   =   'S'
026300070227     C                   Else
026400070228     C                   Eval      PMEMMST   =   'M'
026500160623     C                   Endif
026600160623
026700070227     C     BIRTH         Mult      10000.0001    DOB               8 0
026800070228     C                   Movel     DOB           PMEMBDT
026900070227     C     EMPDT         Mult      10000.0001    HIREDT            8 0
027000070228     C                   Movel     HIREDT        PEMPHDT
027100070227     C                   Eval      PEMPPIN   =   *Blanks
027200070227     C                   Eval      PSURIND   =   *Blanks
027300070227     C                   Eval      PSURSSN   =   *Blanks
027400070227     C                   Eval      PSURLNA   =   *Blanks
027500070227     C                   Eval      PSURFNA   =   *Blanks
027600070227     C                   Eval      PFADDIN   =   'D'
027700070227     C                   Eval      PSTRADD   =   ADDR1
027800070227     C                   Eval      PADDLI2   =   ADDR2
027900070227     C                   Eval      PCITY     =   CITY
028000070227     C                   Eval      PSTATE    =   STATE
028100090225     C                   Movel     ZIP           PZIPCOD
028200090225     C                   Movel     '00'          PRELACD
028300160623
028400090225      * Determine which coverage and load the appropriate format block
028500100423     C                   If        PLNCAT    =   Dental   OR
028600160623     C                             PLNCAT    =   DentalDC or
028700160623     C                             PLNCAT    =   DentalCobra
028800160301     C****                         PLNCAT    =   DentalDC OR
028900160301     C****                         Action    =   'D'
029000090225     C                   Exsr      DentalSr
029100160623     C                   Endif
029200160623
029300090312     C                   If        PLNCAT    =   Life
029400090225     C                   Exsr      LifeSr
029500160623     C                   Endif
029600160623
029700090312     C                   If        PLNCAT    =   AD_D
029800090225     C                   Exsr      AD_DSr
029900160623     C                   Endif
030000160623
030100090312     C                   If        PLNCAT    =   LTD
030200090225     C                   Exsr      LTDSr
030300160623     C                   Endif
030400160623
030500090312     C                   If        PLNCAT    =   STD
030600090225     C                   Exsr      STDSr
030700160623     C                   Endif
030800160623
030900090313      * Process Dependents
031000100521     C                   If        PLNCAT    =   Dental   Or
031100160623     C                             PLNCAT    =   DentalDC or
031200160623     C                             PLNCAT    =   DentalCobra
031300160301     C****                         PLNCAT    =   DentalDC or
031400160301     C****                         Action    =   'D'
031500070925     C     MCSSNO        CHAIN     DEPENR
031600070925     C                   IF        %FOUND(DEPNDC)
031700160623     C                   EXSR      DEPEND
031800070925     C                   ENDIF
031900160623
032000160623     C                   Endif
032100160623
032200070227     C                   Endsr
032300160623
032400160623      *================================================================
032500160623      * Dependents
032600160623      *================================================================
032700160623
032800160623     C     DEPEND        BEGSR
032900160623
033000070925     C     MCSSNO        Setll     DEPENR
033100070925     C                   DOU       %Eof(DEPNDC)
033200070925     C     MCSSNO        Reade     DEPENR
033300070925     C                   IF        NOT %EOF(DEPNDC)
033400160623
033500070925     C     DepKey        CHAIN     DCOVR
033600070925     C                   IF        %FOUND(DCOV22)
033700160623
033800090313     C                   Exsr      PrepRecordD
033900160623     C                   EXSR      DCOV
034000160623
034100070925     C                   ENDIF
034200160623
034300070925     C                   ENDIF
034400070925     C                   Enddo
034500160623
034600070925     C                   ENDSR
034700160623
034800160623      *================================================================
034900160623      * Dependent coverage
035000160623      *================================================================
035100160623   S*
035200160623     C     DCOV          BEGSR
035300160623
035400070925     C     DepKey        SETGT     DCOVR
035500070925     C                   DOU       %Eof(DCOV22)
035600070925     C     DepKey        READPE    DCOVR
035700070925     C                   IF        NOT %Eof(DCOV22) AND DENRDT <> CCANDT
035800160623
035900070925     C                   IF        CCANDT = 0
036000070925     C                   EVAL      CCANDT = 99999999
036100070925     C                   ENDIF
036200160623
036300090313     C                   Exsr      BuildDepRec
036400070925     C                   LEAVESR
036500160623
036600070925     C                   ENDIF
036700070925     C                   ENDDO
036800160623
036900070925     C                   ENDSR
037000160623
037100160623      *================================================================
037200160623      * Build dependent record
037300160623      *================================================================
037400160623
037500160623     C     BuildDepRec   Begsr
037600160623
037700070924     C                   IF        CCANDT <> 99999999
037800070924     C     CNLDEP        CHAIN     METLIFR
037900070924     C                   IF        %FOUND(METLIFTRM)
038000070924     C                   LEAVESR
038100070924     C                   ELSE
038200070924     C                   CLEAR                   METLIFR
038300070924     C                   EVAL      NTSSNO = SSNO
038400070925     C                   EVAL      NTDEPNO = DSEQ#
038500070924     C                   EVAL      NTTERMDT = CCANDT
038600070924     C                   EVAL      NTPLAN = DVPLAN
038700070924     C                   EVAL      NTCOVTP  = MCOVTP
038800070924     C                   EVAL      NTTRST   = MCTRST
038900070924     C                   EVAL      NTSUB#   = MCSUB#
039000070924     C                   EVAL      NTACCT   = ACC#
039100070924     C                   WRITE     METLIFR
039200070924     C                   ENDIF
039300070924     C                   ENDIF
039400160623
039500070227     C                   Eval      PTRANCD   =   'D'
039600070227     C                   Movel     '00'          PEMPSSN
039700070227     C                   Move      MCSSNO        PEMPSSN
039800070228     C                   Move      DEPSS#        PMEMSSN
039900070227     C                   Eval      PMEMLNA   =   DLNAME                         Member Last Name
040000070227     C                   Eval      PMEMFNA   =   DFNAME                         Member First Name
040100070227     C                   Eval      PMEMMID   =   DMI                            Member First Name
040200070228     C                   Eval      PMEMSEX   =   DSEX                           Member Gender
040300160623
040400070227     C                   If        DSEX       <>  'M'    And
040500070227     C                             DSEX       <>  'F'
040600070228     C                   Eval      PMEMSEX   =   'U'                            Unknown
040700160623     C                   Endif
040800160623
040900070227     C                   If        DRELCD    <>  'RHU'   And
041000070227     C                             DRELCD    <>  'RWI'
041100070228     C                   Eval      PMEMMST   =   'S'
041200070227     C                   Else
041300070228     C                   Eval      PMEMMST   =   'M'
041400160623     C                   Endif
041500160623
041600070227     C     DBIRTH        Mult      10000.0001    DOB               8 0
041700070228     C                   Movel     DOB           PMEMBDT
041800160623     C                   Eval      PCOVTYP   =   'D '
041900160623
042000070925     C                   Movel     DENRDT        PCOVBDT
042100080117     C                   Movel     DENRDT        PCOVBDTN
042200160623
042300160623      *DEPENDENT OVERRIDE
042400071106     C                   IF        DENRDT < ENRLDT
042500071106     C                   MOVE      ENRLDT        PCOVBDT
042600080117     C                   MOVE      ENRLDT        PCOVBDTN
042700071106     C                   ENDIF
042800160623
042900070925     C                   IF        CCANDT = 99999999 OR CCANDT = 0
043000070925     C                   MOVE      '00000000'    PCOVEDT
043100070925     C                   ELSE
043200070925     C                   Movel     CCANDT        PCOVEDT
043300070925     C                   ENDIF
043400160623
043500070227     C                   Eval      PEMPPIN   =   *Blanks
043600070227     C                   Eval      PSURIND   =   *Blanks
043700070227     C                   Eval      PSURSSN   =   *Blanks
043800070227     C                   Eval      PSURLNA   =   *Blanks
043900070227     C                   Eval      PSURFNA   =   *Blanks
044000070227     C                   Eval      PFADDIN   =   'D'
044100110808     C                   Exsr      GetGrp
044200110808     C                   Eval      PSUBDIV   =   GroupSubDiv
044300120216     C                   Eval      PBRANCH   =   GroupBranch
044400090313     C                   Eval      PGROUP#   =   PCUSTNO
044500070228     C                   Eval      PPLANCD   =   *Blanks
044600160623
044700070227     C                   If        CEXPDT    <>  *Zeros
044800070228     C                   Eval      PCOBRAI   =   'CE'
044900090527     C                   Move      CEXPDT        PCOVEDT
045000160623     C                   Endif
045100160623
045200070227     C                   Select
045300070228     C                   When      CEXPDT   <>   *Zeros
045400070313     C                   When      CEXPDT    =   *Zeros
045500100226     C                   EndSl
045600160623
045700070227     C                   Select
045800160623
045900070227     C                   When      EMPST     =   'J'
046000070228     C                   Eval      PSTATCD   =   'R'
046100160623
046200070227     C                   When      HDCPDT    <>  *Zero
046300070228     C                   Eval      PSTATCD   =   'D'
046400160623
046500070227     C                   Other
046600070228     C                   Eval      PSTATCD   =   'A'
046700160623
046800070227     C                   EndSl
046900160623
047000070227     C                   Select
047100070227     C                   When      DRELCD    =   'RHU'  Or
047200070227     C                             DRELCD    =   'RWI'
047300070228     C                   Movel     '01'          PRELACD
047400160623
047500070227     C                   When      DRELCD    =   'RSO'  Or
047600090921     C                             DRELCD    =   'RDA'  Or
047700090921     C                             DRELCD    =   'RA '  Or
047800090921     C                             DRELCD    =   'RB '
047900070228     C                   Movel     '02'          PRELACD
048000160623
048100130625     C                   When      DRELCD    =   'RPA'
048200130625     C                   Movel     '03'          PRELACD
048300160623
048400070227     C                   EndSl
048500160623
048600041220     C                   Select
048700070228     C                   When      MCOVTP    =   'TPC'  Or
048800070228     C                             MCOVTP    =   'TP2'
048900070228     C                   Eval      PMEMCCD   =   '2'
049000160623
049100070228     C                   When      MCOVTP    =   'THW'
049200070228     C                   Eval      PMEMCCD   =   '3'
049300160623
049400070228     C                   When      MCOVTP    =   'TFA'
049500070228     C                   Eval      PMEMCCD   =   '4'
049600160623
049700041220     C                   Endsl
049800160623
049900090313     C                   Exsr      WriteRec
050000160623
050100021007     C                   Endsr
050200160623
050300160623      *================================================================
050400090225      * Fill DENTAL Block of Record Format
050500160623      *================================================================
050600160623
050700090225     C     DentalSr      BEGSR
050800160623
050900090225     C                   Eval      PCOVTYP   =   'D '
051000090225     C                   Move      ENRLDT        PCOVBDT
051100090225     C                   Move      ENRLDT        PCOVBDTN          8 0
051200160623
051300160623      * COBRA OVERRIDE
051400090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
051500090225     C                   MOVE      GBSCDT        PCOVBDT
051600090225     C                   Move      GBSCDT        PCOVBDTN
051700090225     C                   ENDIF
051800160623
051900160623     C                   if        plncat = DentalCobra
052000160623     C                   eval      pcobrai = 'CE'
052100160623     c                   endif
052200160623
052300090225     C                   IF        CANDT = 99999999 OR CANDT = 0
052400090225     C                   MOVE      '00000000'    PCOVEDT
052500090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
052600090225     C                   ELSE
052700090225     C                   Move      CANDT         PCOVEDT
052800090225     C                   MOVE      CANDT         PCOVEDTN
052900090225     C                   ENDIF
053000160623
053100090225     C                   Exsr      GetGrp
053200090527     C                   Eval      PGROUP#   =   PCUSTNO
053300110808     C                   Eval      PSUBDIV   =   GroupSubDiv
053400120216     C                   Eval      PBRANCH   =   GroupBranch
053500160623
053600090225     C                   Eval      PPLANCD   =   *Blanks
053700160623
053800090225     C                   If        CEXPDT    <>  *Zeros
053900090225     C                   Eval      PCOBRAI   =   'CE'
054000090527     C                   Move      CEXPDT        PCOVEDT
054100160623     C                   Endif
054200160623
054300090227     C                   Select
054400090225     C                   When      EMPST     =   'J'
054500090225     C                   Eval      PSTATCD   =   'R'
054600160623
054700090225     C                   When      HDCPDT    <>  *Zero
054800090225     C                   Eval      PSTATCD   =   'D'
054900160623
055000090225     C                   Other
055100090225     C                   Eval      PSTATCD   =   'A'
055200160623
055300090225     C                   EndSl
055400160623
055500090225     C                   Select
055600090225     C                   When      MCOVTP    =   'TIN'
055700160623
055800090225     C                   Eval      PMEMCCD   =   '1'
055900090225     C                   When      MCOVTP    =   'TPC'  Or
056000090225     C                             MCOVTP    =   'TP2'
056100160623
056200090225     C                   Eval      PMEMCCD   =   '2'
056300090225     C                   When      MCOVTP    =   'THW'
056400160623
056500090225     C                   Eval      PMEMCCD   =   '3'
056600090225     C                   When      MCOVTP    =   'TFA'
056700160623
056800090225     C                   Eval      PMEMCCD   =   '4'
056900090225     C                   Endsl
057000160623
057100090227     C                   Eval      PDEPCLS   =   *Blanks
057200160623
057300090312     C                   Exsr      WriteRec
057400160623
057500090225     C                   Endsr
057600160623
057700160623      *================================================================
057800090225      * Fill LIFE Block of Record Format
057900160623      *================================================================
058000160623
058100090225     C     LifeSr        BEGSR
058200160623
058300090227     C                   Eval      PTYPCO2   =   'CP'
058400090304     C                   Move      ENRLDT        PCOSTD2
058500090225     C                   Move      ENRLDT        PCOVBDTN          8 0
058600160623
058700160623      * COBRA OVERRIDE
058800090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
058900090304     C                   MOVE      GBSCDT        PCOSTD2
059000090225     C                   Move      GBSCDT        PCOVBDTN
059100090225     C                   ENDIF
059200161014
059300090225     C                   IF        CANDT = 99999999 OR CANDT = 0
059400090304     C                   MOVE      '00000000'    PCOEND2
059500090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
059600090225     C                   ELSE
059700090304     C                   Move      CANDT         PCOEND2
059800090225     C                   MOVE      CANDT         PCOVEDTN
059900090225     C                   ENDIF
060000160623
060100090225     C                   Exsr      GetGrp
060200090227     C                   Eval      PPLANC2   =   *Blanks
060300160623
060400090225     C                   If        CEXPDT    <>  *Zeros
060500090227     C                   Eval      PCOBRA2   =   'CE'
060600090527     C                   Move      CEXPDT        PCOEND2
060700160623     C                   Endif
060800160623
060900090227     C                   Select
061000160623
061100090225     C                   When      EMPST     =   'J'
061200090227     C                   Eval      PSTATC2   =   'R'
061300160623
061400090225     C                   When      HDCPDT    <>  *Zero
061500090227     C                   Eval      PSTATC2   =   'D'
061600160623
061700090225     C                   Other
061800090227     C                   Eval      PSTATC2   =   'A'
061900160623
062000090225     C                   EndSl
062100160623
062200090225     C                   Select
062300160623
062400090225     C                   When      MCOVTP    =   'TIN'
062500090227     C                   Eval      PMEMCC2   =   '1'
062600160623
062700090225     C                   When      MCOVTP    =   'TPC'  Or
062800090225     C                             MCOVTP    =   'TP2'
062900090227     C                   Eval      PMEMCC2   =   '2'
063000160623
063100090225     C                   When      MCOVTP    =   'THW'
063200090227     C                   Eval      PMEMCC2   =   '3'
063300160623
063400090225     C                   When      MCOVTP    =   'TFA'
063500090227     C                   Eval      PMEMCC2   =   '4'
063600160623
063700090225     C                   Endsl
063800160623
063900090227     C                   Eval      PDEPCL2   =   *Blanks
064000090304     C                   Move      BENAMT        PINSAM2
064100090320     C                   Movel     '0'           PINSAM2
064200160623
064300090312     C                   Movel     'A'           PSAMOD2
064400090312     C                   Move      SALARY        PSALAR2
064500160623
064600090312     C                   Exsr      WriteRec
064700160623
064800090225     C                   Endsr
064900160623
065000160623      *================================================================
065100090225      * Fill AD&D Block of Record Format
065200160623      *================================================================
065300160623
065400090225     C     AD_DSr        BEGSR
065500160623
065600090227     C                   Eval      PTYPCO3   =   'AD'
065700090304     C                   Move      ENRLDT        PCOSTD3
065800090225     C                   Move      ENRLDT        PCOVBDTN          8 0
065900160623
066000160623      * COBRA OVERRIDE
066100090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
066200090304     C                   MOVE      GBSCDT        PCOSTD3
066300090225     C                   Move      GBSCDT        PCOVBDTN
066400090225     C                   ENDIF
066500161014
066600090225     C                   IF        CANDT = 99999999 OR CANDT = 0
066700090304     C                   MOVE      '00000000'    PCOEND3
066800090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
066900090225     C                   ELSE
067000090304     C                   Move      CANDT         PCOEND3
067100090225     C                   MOVE      CANDT         PCOVEDTN
067200090225     C                   ENDIF
067300160623
067400090225     C                   Exsr      GetGrp
067500160623
067600090227     C                   Eval      PPLANC3   =   *Blanks
067700160623
067800090225     C                   If        CEXPDT    <>  *Zeros
067900090227     C                   Eval      PCOBRA3   =   'CE'
068000090527     C                   Move      CEXPDT        PCOEND3
068100160623     C                   Endif
068200160623
068300090227     C                   Select
068400160623
068500090225     C                   When      EMPST     =   'J'
068600090227     C                   Eval      PSTATC3   =   'R'
068700160623
068800090225     C                   When      HDCPDT    <>  *Zero
068900090227     C                   Eval      PSTATC3   =   'D'
069000160623
069100090225     C                   Other
069200090227     C                   Eval      PSTATC3   =   'A'
069300160623
069400090225     C                   EndSl
069500090225      *
069600090225     C                   Select
069700090225     C                   When      MCOVTP    =   'TIN'
069800090227     C                   Eval      PMEMCC3   =   '1'
069900160623
070000090225     C                   When      MCOVTP    =   'TPC'  Or
070100090225     C                             MCOVTP    =   'TP2'
070200090227     C                   Eval      PMEMCC3   =   '2'
070300160623
070400090225     C                   When      MCOVTP    =   'THW'
070500090227     C                   Eval      PMEMCC3   =   '3'
070600160623
070700090225     C                   When      MCOVTP    =   'TFA'
070800090227     C                   Eval      PMEMCC3   =   '4'
070900160623
071000090225     C                   Endsl
071100160623
071200090227     C                   Eval      PDEPCL3   =   *Blanks
071300090304     C                   Move      BENAMT        PINSAM3
071400090320     C                   Movel     '0'           PINSAM3
071500160623
071600090312     C                   Movel     'A'           PSAMOD3
071700090312     C                   Move      SALARY        PSALAR3
071800160623
071900090312     C                   Exsr      WriteRec
072000160623
072100090225     C                   Endsr
072200160623
072300160623      *================================================================
072400090225      * Fill LTD Block of Record Format
072500160623      *================================================================
072600160623
072700090225     C     LTDSr         BEGSR
072800160623
072900090312     C                   Eval      PTYPCO5   =   'LT'
073000090313     C                   Move      ENRLDT        PCOSTD5
073100090225     C                   Move      ENRLDT        PCOVBDTN          8 0
073200160623
073300160623      * COBRA OVERRIDE
073400090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
073500090312     C                   MOVE      GBSCDT        PCOSTD5
073600090225     C                   Move      GBSCDT        PCOVBDTN
073700090225     C                   ENDIF
073800161014
073900090225     C                   IF        CANDT = 99999999 OR CANDT = 0
074000090312     C                   MOVE      '00000000'    PCOEND5
074100090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
074200090225     C                   ELSE
074300090312     C                   Move      CANDT         PCOEND5
074400090225     C                   MOVE      CANDT         PCOVEDTN
074500090225     C                   ENDIF
074600160623
074700090225     C                   Exsr      GetGrp
074800090312     C                   Eval      PPLANC5   =   *Blanks
074900160623
075000090225     C                   If        CEXPDT    <>  *Zeros
075100090312     C                   Eval      PCOBRA5   =   'CE'
075200090527     C                   Move      CEXPDT        PCOEND5
075300160623     C                   Endif
075400160623
075500090227     C                   Select
075600160623
075700090225     C                   When      EMPST     =   'J'
075800090312     C                   Eval      PSTATC5   =   'R'
075900160623
076000090225     C                   When      HDCPDT    <>  *Zero
076100090312     C                   Eval      PSTATC5   =   'D'
076200160623
076300090225     C                   Other
076400090312     C                   Eval      PSTATC5   =   'A'
076500160623
076600090225     C                   EndSl
076700160623
076800090225     C                   Select
076900160623
077000090225     C                   When      MCOVTP    =   'TIN'
077100090312     C                   Eval      PMEMCC5   =   '1'
077200160623
077300090225     C                   When      MCOVTP    =   'TPC'  Or
077400090225     C                             MCOVTP    =   'TP2'
077500090312     C                   Eval      PMEMCC5   =   '2'
077600160623
077700090225     C                   When      MCOVTP    =   'THW'
077800090312     C                   Eval      PMEMCC5   =   '3'
077900160623
078000090225     C                   When      MCOVTP    =   'TFA'
078100090312     C                   Eval      PMEMCC5   =   '4'
078200160623
078300090225     C                   Endsl
078400160623
078500090312     C                   Eval      PDEPCL5   =   *Blanks
078600090313     C                   Move      BENAMT        PINSAM5
078700090320     C                   Movel     '0'           PINSAM5
078800160623
078900090312     C                   Movel     'A'           PMOSAL5
079000090312     C                   Move      SALARY        PSALAM5
079100160623
079200090312     C                   Exsr      WriteRec
079300160623
079400090225     C                   Endsr
079500160623
079600160623      *===================================================================
079700090225      * Fill STD Block of Record Format
079800160623      *===================================================================
079900160623
080000090225     C     STDSr         BEGSR
080100160623
080200090312     C                   Eval      PTYPCO4   =   'AS'
080300090312     C                   Move      ENRLDT        PCOSTD4
080400090225     C                   Move      ENRLDT        PCOVBDTN          8 0
080500160623
080600160623      * COBRA OVERRIDE
080700090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
080800090312     C                   MOVE      GBSCDT        PCOSTD4
080900090225     C                   Move      GBSCDT        PCOVBDTN
081000090225     C                   ENDIF
081100160623
081200090225     C                   IF        CANDT = 99999999 OR CANDT = 0
081300090312     C                   MOVE      '00000000'    PCOEND4
081400090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
081500090225     C                   ELSE
081600090312     C                   Move      CANDT         PCOEND4
081700090225     C                   MOVE      CANDT         PCOVEDTN
081800090225     C                   ENDIF
081900160623
082000090225     C                   Exsr      GetGrp
082100090312     C                   Eval      PPLANC4   =   *Blanks
082200160623
082300090225     C                   If        CEXPDT    <>  *Zeros
082400090312     C                   Eval      PCOBRA4   =   'CE'
082500090527     C                   Move      CEXPDT        PCOEND4
082600160623     C                   Endif
082700160623
082800090227     C                   Select
082900160623
083000090225     C                   When      EMPST     =   'J'
083100090312     C                   Eval      PSTATC4   =   'R'
083200160623
083300090225     C                   When      HDCPDT    <>  *Zero
083400090312     C                   Eval      PSTATC4   =   'D'
083500160623
083600090225     C                   Other
083700090312     C                   Eval      PSTATC4   =   'A'
083800160623
083900090225     C                   EndSl
084000160623
084100090225     C                   Select
084200160623
084300090225     C                   When      MCOVTP    =   'TIN'
084400090312     C                   Eval      PMEMCC4   =   '1'
084500160623
084600090227     C                   When      MCOVTP    =   'TPC'  Or
084700090225     C                             MCOVTP    =   'TP2'
084800090312     C                   Eval      PMEMCC4   =   '2'
084900160623
085000090225     C                   When      MCOVTP    =   'THW'
085100090312     C                   Eval      PMEMCC4   =   '3'
085200160623
085300090225     C                   When      MCOVTP    =   'TFA'
085400090312     C                   Eval      PMEMCC4   =   '4'
085500160623
085600090225     C                   Endsl
085700160623
085800090312     C                   Eval      PDEPCL4   =   *Blanks
085900090312     C                   Move      BENAMT        PINSAM4
086000090320     C                   Movel     '0'           PINSAM4
086100160623
086200090312     C                   Movel     'A'           PMOSAL4
086300090312     C                   Move      SALARY        PSALAM4
086400160623
086500090312     C                   Exsr      WriteRec
086600160623
086700090225     C                   Endsr
086800160623
086900160816      //===================================================================
087000160816      // Get group number
087100160816      //===================================================================
087200160816
087300160816       begsr getgrp;
087400160816
087500160816        setll (mctrst : mcsub# : mcplan : mcageb : mcovtp) grater;
087600160816        reade (mctrst : mcsub# : mcplan : mcageb : mcovtp) grater;
087700160816
087800160816        dow not %eof;
087900160816
088000160816         if today >= frmdat;
088100160816          if today <= todat;
088200160816           exsr FmtGrp;
088300160816            leavesr;
088400160816          else;
088500160816           group# = ' ';
088600160816          endif;
088700160816         endif;
088800160816
088900160816        reade (mctrst : mcsub# : mcplan : mcageb : mcovtp) grater;
089000160816        enddo;
089100160816
089200160816        // When coverage is termed, there may be no current rate, still need grp#
089300160816        if pcustno = ' ';
089400160816         exsr FmtGrp;
089500160816        endif;
089600160816
089700160816    ?  endsr;
089800160816
089900160623      *===================================================================
090000080117      * Retrieve the group number from the GRATE file.
090100160623      *===================================================================
090200160623
090300160816     C     Getgrp2       BEGSR
090400160623
090500080117     c     RatKey        Setll     GRATE
090600080903     c     RatKey        Reade     GRATE
090700080903     c                   Dow       not %eof(GRATE)
090800080117     C                   If        (PCOVBDTN >=  FRMDAT) and
090900110818     C                             (PCOVEDTN <=  TODAT)
091000110818      **** TEST ****
091100160623     C                             Or
091200110818      * Member's coverage is Active
091300110818     C                             (PCOVEDTN  =  *Zeros  Or
091400110818     C                              PCOVEDTN >=  Today)  And
091500110818      * Rate may begin after member's coverage but is still active.
091600110818     C                             (Today    <=  TODAT)
091700110818      **** TEST ****
091800160623
091900090312     C                   Exsr      FmtGrp
092000160623     C                   Endif
092100160623
092200080903     c     RatKey        Reade     GRATE
092300080117     C                   EndDo
092400160623
092500160623      * When coverage is termed, there may be no current rate; still need grp
092600110808     C                   If        PCUSTNO    =  *Blanks
092700090312     C                   Exsr      FmtGrp
092800160623     C                   Endif
092900160623
093000080117     C                   Endsr
093100160623
093200160623      *===================================================================
093300090312      * Format the group number.
093400160623      *===================================================================
093500160623
093600090312     C     Fmtgrp        BEGSR
093700160623
093800160623      * The 1st 7 digits of group# are moved into group, next 4 subd, next 4 branch
093900110808     C                   Clear                   GroupFmt
094000110808     C                   Eval      GroupFmt   =  GROUP#
094100160623
094200110815     C                   Select
094300160623
094400160623     C                   When       PLNCAT    =   Dental Or
094500160623     C                              PLNCAT    =   DentalDC or
094600160623     C                              PLNCAT    =   DentalCobra
094700160623     C****                          PLNCAT    =   DentalDC Or
094800160301     C****                          ACTION    =   'D'
094900110815     C                   Eval      PCUSTNO    =  GroupGroup
095000110808     C                   Eval      PSUBDIV    =  GroupSubDiv
095100110808     C                   Eval      PBRANCH    =  GroupBranch
095200160623
095300110815     C                   When      PLNCAT     =  Life
095400110818     C                   Eval      PCUSTNO    =  GroupGroup
095500110815     C                   Eval      PGROUP2    =  GroupGroup
095600110815     C                   Eval      PSUBDI2    =  GroupSubDiv
095700110815     C                   Eval      PBRANC2    =  GroupBranch
095800160623
095900110815     C                   When      PLNCAT    =   AD_D
096000110818     C                   Eval      PCUSTNO    =  GroupGroup
096100110815     C                   Eval      PGROUP3    =  GroupGroup
096200110815     C                   Eval      PSUBDI3    =  GroupSubDiv
096300110815     C                   Eval      PBRANC3    =  GroupBranch
096400160623
096500110815     C                   When      PLNCAT    =   LTD
096600110818     C                   Eval      PCUSTNO    =  GroupGroup
096700110815     C                   Eval      PGROUP5    =  GroupGroup
096800110815     C                   Eval      PSUBDI5    =  GroupSubDiv
096900110815     C                   Eval      PBRANC5    =  GroupBranch
097000160623
097100110815     C                   When      PLNCAT    =   STD
097200110818     C                   Eval      PCUSTNO    =  GroupGroup
097300110815     C                   Eval      PGROUP4    =  GroupGroup
097400110815     C                   Eval      PSUBDI4    =  GroupSubDiv
097500110815     C                   Eval      PBRANC4    =  GroupBranch
097600110815     C                   EndSl
097700160623
097800140616     C                   Endsr
097900160623
098000160623      *===================================================================
098100090313      * Prepare Dependent Record for Update
098200160623      *===================================================================
098300160623
098400090313     C     PrepRecordD   BEGSR
098500160623
098600090312     C                   Move      MCSSNO        Kssno            11
098700090312     C                   Movel     '00'          Kssno
098800090313     C                   Move      DEPSS#        Mssno             9
098900160908
099000160908     C     BIRTH         Mult      10000.0001    dob
099100160908
099200160908       dbirthc = %editc(dob:'X');
099300160623
099400160908     C     PKey2         chain     METLIFEWTL
099500160729     C                   If        Not %found(METLIFEWTL)
099600090313     C                   Clear                   PROEXPR
099700090313     C                   Clear                   PROUPDR
099800090313     C                   Eval      Data = 'A'
099900090313     C                   Else
100000160623
100100090901     C                   If        DFNAME   =    PMEMFNA     And
100200090901     C                             DMI      =    PMEMMID
100300160301     C                   Eval      Data = 'U'
100400090901     C                   Else
100500090901     C                   Clear                   PROEXPR
100600090901     C                   Clear                   PROUPDR
100700090901     C                   Eval      Data = 'A'
100800160623     C                   Endif
100900160623
101000160623     C                   Endif
101100160623
101200140616     C                   Endsr
101300160623
101400160623      *===================================================================
101500090313      * Prepare Record for Update
101600160623      *===================================================================
101700160623
101800090313     C     PrepRecord    BEGSR
101900160623
102000090313     C                   Move      MCSSNO        Kssno            11
102100090313     C                   Movel     '00'          Kssno
102200090313     C                   Move      MCSSNO        Mssno             9
102300160908     C     BIRTH         Mult      10000.0001    dob
102400160908
102500160908       dbirthc = %editc(dob:'X');
102600160908
102700160908     C     PKey2         chain     METLIFEWTL
102800160729     C                   If        Not %found(METLIFEWTL)
102900090313     C                   Clear                   PROEXPR
103000090313     C                   Clear                   PROUPDR
103100090313     C                   Eval      Data = 'A'
103200090313     C                   Else
103300160301     C                   Eval      Data = 'U'
103400160623     C                   Endif
103500160623
103600140616     C                   Endsr
103700160623
103800160623      *===================================================================
103900090313      * Write or update a record
104000160623      *===================================================================
104100160623
104200090313     C     WriteRec      BEGSR
104300160623
104400160818       if pcustno <> 'IN PROC';
104500160818
104600090313     C                   Select
104700160623
104800090313     C                   When      Data = 'A'
104900090313     C                   Write     PROEXPR
105000160623
105100160301     C                   When      Data = 'U'
105200160301     C                   Update    PROUPDR
105300160623
105400090313     C                   Endsl
105500160623
105600090313     C                   Clear                   Data
105700090313     C                   Clear                   PROEXPR
105800090313     C                   Clear                   PROUPDR
105900160818
106000160818       endif;
106100160623
106200140616     C                   Endsr
106300160623
106400161014      //==================================================================
106500161014
106600161014       begsr exit;
106700161014
106800161014        *inlr = '1';
106900161014        return;
107000161014
107100161014       endsr;
107200161014
107300160623      *================================================================
107400161014      * Init
107500160623      *================================================================
107600160623
107700161014     C     init          Begsr
107800160623
107900161014     C     CodKey        Klist
108000161014     C                   Kfld                    Typ
108100161014     C                   Kfld                    Cod
108200161014
108300161014     C     PlnKey        Klist
108400161014     C                   Kfld                    PLTRST
108500161014     C                   Kfld                    PLSUB#
108600161014     C                   Kfld                    PLPLAN
108700161014
108800161014     C     CNLMBR        Klist
108900161014     C                   Kfld                    MCSSNO
109000161014     C                   Kfld                    MDSEQ#
109100161014     C                   Kfld                    CANDT
109200161014     C                   Kfld                    MCPLAN
109300161014     C                   Kfld                    MCOVTP
109400161014     C                   Kfld                    MCTRST
109500161014     C                   Kfld                    MCSUB#
109600161014     C                   Kfld                    ACC#
109700161014
109800161014     C     DepKey        Klist
109900161014     C                   Kfld                    MCTRST
110000161014     C                   Kfld                    MCSUB#
110100161014     C                   Kfld                    MCPLAN
110200161014     C                   Kfld                    DSSNO
110300161014     C                   Kfld                    DPSEQ#
110400161014
110500161014     C     CNLDEP        Klist
110600161014     C                   Kfld                    SSNO
110700161014     C                   Kfld                    DSEQ#
110800161014     C                   Kfld                    CCANDT
110900161014     C                   Kfld                    DVPLAN
111000161014     C                   Kfld                    MCOVTP
111100161014     C                   Kfld                    MCTRST
111200161014     C                   Kfld                    MCSUB#
111300161014     C                   Kfld                    ACC#
111400161014
111500161014     C     RATKEY        KLIST
111600161014     C                   KFLD                    MCTRST
111700161014     C                   KFLD                    MCSUB#
111800161014     C                   KFLD                    MCPLAN
111900161014     C                   KFLD                    MCAGEB
112000161014     C                   KFLD                    MCOVTP
112100161014
112200161014     C     PKey          Klist
112300161014     C                   Kfld                    Kssno
112400161014     C                   Kfld                    Mssno
112500161014
112600161014     C     PKey2         Klist
112700161014     C                   Kfld                    Kssno
112800161014     C                   Kfld                    Mssno
112900161014     C                   Kfld                    dbirthc
113000161014     C                   Kfld                    dfname
113100161014
113200161014     C     KL#TSA        KLIST
113300161014     C                   KFLD                    MCTRST
113400161014     C                   KFLD                    MCSUB#
113500161014     C                   KFLD                    ACC#
113600161014
113700140616     C                   EVAL      #ISO = %DATE
113800140616     C                   MOVE      #ISO          TODAY             8 0
113900041220     C                   Eval      FILLER1    =  *Blanks
114000041220     C                   Eval      FILLER2    =  *Blanks
114100160729
114200160817       // chain unique caraccr;
114300160729
114400140616     C                   Endsr
114500160623
114600160623      *================================================================
