000100180117    ? *========================================================================
000200180117     h DFTNAME(RP15XDR) option(*nodebugio)
000300180117    ? *========================================================================
000400180117      * RP15XDR - Generate Letters for Dependents attaining age.
000500180117    ? *========================================================================
000600180117      * 3/19/03  SZZ
000700180117      *11/24/03  SZZ   The year reflected as "effective" in the text
000800180117      *                of the letter should not come from the system;
000900180117      *                it should come from the user's entry.
001000180117      * 5/20/04  SZZ   Move zeros to history dep seq#, invoic date and
001100180117      *                 receive date to avoid data decimal errors.
001200180117      * 4/14/05  SZZ   Change distribution notice to submitting user.
001300180117      * 1/03/11  SZZ   Per Shelly Rapski; effective date (COVTDT) for
001400180117      *                 an age-19 letter should show the following year
001500180117      *                 if it is a January birthday.
001600180117      * 4/26/12  szz   Add workfile to be used for RPG_WORD letters.
001700180117      *
001800180117    ? *========================================================================
001900030320     FRP15XWK   IF   E           K Disk
002000180117
002100030320     FACCMST    IF   E           K Disk
002200180117
002300030320     FMEMBER    IF   E           K Disk
002400180117
002500030320     FAACODE    IF   E           K Disk
002600180117
002700030321     FDEPEND    IF   E           K Disk
002800180117
002900050414     FGBSECURE  IF   E           K Disk
003000180117
003100130924     Fsmanuniqueif   e           k disk
003200180117
003300121024     FRP15XDP   O    E             Printer
003400180117
003500120426     FRP15WWK   O    E           K Disk
003600180117
003700131017     FHIST      O    e             DISK
003800180117
0039000303240021 FREPORT    O    F  198        PRINTER
004000030324     F                                     FORMLEN(8)
004100030324     F                                     FORMOFL(8)
004200180117
004300180117    ? *========================================================================
004400131017
0045000311240055 D                UDS
004600131017
0047000311240056 D  TYEAR                 21     24
004800030320     D                 DS
004900030320     D MBSSNO                              Inz(*Zeros)
005000030321     D  SSNO1_DS                      3    Overlay(MBSSNO)
005100030321     D  SSNO2_DS                      2    Overlay(MBSSNO:4)
005200030321     D  SSNO3_DS                      4    Overlay(MBSSNO:6)
005300131017
005400030328     D Hkey            DS
005500030328     D  BlankSpace                    1    Inz(*Blanks)
005600030328     D  MemberNo                      9
005700131017
005800030321     D                 DS
005900030321     D DEPSS#                              Inz(*Zeros)
006000030321     D  DSSNO1_DS                     3    Overlay(DEPSS#)
006100030321     D  DSSNO2_DS                     2    Overlay(DEPSS#:4)
006200030321     D  DSSNO3_DS                     4    Overlay(DEPSS#:6)
006300030320
006400030320     D                 DS
006500030321     D CFSSNO                        11    Inz('   -  -    ')
006600030321     D  SSNO4_DS                      3    Overlay(CFSSNO)
006700030321     D  SSNO5_DS                      2    Overlay(CFSSNO:5)
006800030321     D  SSNO6_DS                      4    Overlay(CFSSNO:8)
006900030321     D                 DS
007000030321     D DFSSNO                        11    Inz('   -  -    ')
007100030321     D  DSSNO4_DS                     3    Overlay(DFSSNO)
007200030321     D  DSSNO5_DS                     2    Overlay(DFSSNO:5)
007300030321     D  DSSNO6_DS                     4    Overlay(DFSSNO:8)
007400030320     D                 DS
007500030321     D DBIRTH                              Inz(*ZEROS)
007600030321     D  DCCYY                         4  0 Overlay(DBIRTH)
007700030321     D  DMMDD                         4  0 Overlay(DBIRTH:5)
007800030321     D  DMM                           2  0 Overlay(DBIRTH:5)
007900030321     D  DDD                           2  0 Overlay(DBIRTH:7)
008000030403     D                 DS
008100030403     D DiaryB                              Inz(*ZEROS)
008200030403     D  DCCYYD                        4  0 Overlay(DiaryB)
008300030403     D  DMMD                          2  0 Overlay(DiaryB:5)
008400030403     D  DDDD                          2  0 Overlay(DiaryB:7)
008500030320     D                 DS
008600030321     D LDDate                              INZ(*ZEROS)
008700030321     D  LCCYY                         4  0 Overlay(LDDate)
008800030321     D  LMM                           2  0 Overlay(LDDate:5)
008900030321     D  LDD                           2  0 Overlay(LDdate:7)
009000030321     D                 DS
009100030321     D CalcDt                              INZ(*ZEROS)
009200030321     D  CMM                           2  0 Overlay(CalcDt)
009300030321     D  CDD                           2  0 Overlay(CalcDt:3)
009400030321     D  CCCYY                         4  0 Overlay(CalcDt:5)
009500030321
009600030320    ?D  WWdate         S              8  0
009700030320    ?D  WDDATE1        S               D   Datfmt(*ISO)
009800030320     D  WDATE8         S              8  0
009900030320     D  ThirtyDays     S               D   Datfmt(*ISO)
010000030321     D  NumDate        S              8  0
010100050414     D  Distrib        S             15
010200180117     D niceDt          s             32
010300180117     d in_date         s             32
010400180117     d in_format       s             32
010500180117     d out_format      s             32
010600180117     d out_date        s             32
010700180117     d out_error       s             10
010800180117     d tyearn          s              4  0
010900180117     d trust           s              3  0
011000180117     d sub             s              3  0
011100180117     d acct            s              4  0
011101211122     d rec#            s              2  0
011200180117
011300030320    ?D  DsDate         DS
011400030320     D   CC                    1      2
011500030320     D   DSyy                  3      4
011600030320     D   DSmm                  5      6
011700030320     D   DSdd                  7      8
011800030321    ?D  DsDate8        DS
011900030321     D   DSmmdd8               1      4  0
012000030321     D   DSmm8                 1      2
012100030321     D   DSdd8                 3      4
012200030321     D   CC8                   5      6
012300030321     D   DSyy8                 7      8
012400030320
012500030320     D RelineFirst     C                   'Re:  Full-Time Student Verification'
012600030320     D Insure          C                   'to insure enrollment of the depend-
012700030320     D                                     ent.'
012800131017
012900131017     D iopgmd        esds
013000131017
013100180117     d fmtDate         pr                  extpgm('FMTDATE')
013200180117     d  in_date                      32    const
013300180117     d  in_format                    32    const
013400180117     d  out_format                   32    const
013500180117     d  out_date                     32    const
013600180117     d  out_error                    10    const
013700180117
013800180117     D rp15xdr         pi
013900180117     d  UserID                       10
014000180117     d  broker_copy                   1
014100180117
014200030325     IACCMSR
014300030320     I              AACODE                      A_AACODE
014400030325     IMEMBR
014500030320     I              CITY                        MCITY
014600030320     I              STATE                       MSTATE
014700030320     I              ZIP                         MZIP
014800180116
014900180116      //========================================================================
015000180116      // mainline
015100180116      //========================================================================
015200180116
015300180116       exsr init;
015400180116       exsr main;
015500180116       exsr exit;
015600180116
015700180116    ? //========================================================================
015800180116    ? // main
015900180116    ? //========================================================================
016000180116
016100180116       begsr main;
016200180116
016300180117        setll *loval rp15xwk;
016400180117        read rp15xwk;
016500180117
016600180116    ?   dow not %eof;
016700180116
016800180116         exsr process;
016900180116
017000180116        read rp15xwk;
017100180116    ?   enddo;
017200180116
017300180116       endsr;
017400180116
017500180116    ? //========================================================================
017600180116    ? // Main Processing
017700180116    ? //========================================================================
017800030320    ?C     Process       Begsr
017900030320    CC                   Exsr      CalcLDMonth
018000030320     C                   Reset                   CFSSNO
018100120426     C                   Move      'XXX'         SSNO4_DS
018200120426     C                   Move      'XX'          SSNO5_DS
018300030320     C                   Move      SSNO3_DS      SSNO6_DS
018400180117
018500180117        chain (%dec(trustc:3:0) : %dec(subc:3:0) : %dec(acctc:4:0)) accmst;
018600030320     C                   If        %Found(ACCMST)
018700030411     C                   Clear                   ACNAME
018800030411     C     ACNAME        Cat(P)    ACNAM1:0      ACNAME
018900030411     C     ACNAME        Cat(P)    ACNAM2:2      ACNAME
019000030403     C     ACITY         Cat(P)    ',':0         CSZ              30
019100030320     C     CSZ           Cat(P)    ASTATE:1      CSZ
019200030320     C                   Movel     AZIP          Zip               5
019300030320     C     CSZ           Cat(P)    ZIP:2         CSZ
019400030403     C                   If        AADDR2  =     *Blanks
019500030403     C                   Eval      VL1     =     CSZ
019600030403     C                   Eval      VL2     =     *Blanks
019700030403     C                   Else
019800030403     C                   Eval      VL1     =     AADDR2
019900030403     C                   Eval      VL2     =     CSZ
020000030403     C                   End
020100180117
020200030320     C                   Clear                   RELIN2
020300030402     C     RELIN2        Cat(P)    'Employee:':7 RELIN2
020400030402     C     RELIN2        Cat(P)    MFNAME:4      RELIN2
020500030320     C                   If        MMI  <> *Blanks
020600030320     C     RELIN2        Cat(P)    MMI:1         RELIN2
020700030320     C     RELIN2        Cat(P)    '.':0         RELIN2
020800030320     C                   End
020900030320     C     RELIN2        Cat(P)    MLNAME:1      RELIN2
021000030320     C     RELIN2        Cat(P)    'SS# ':2      RELIN2
021100030402     C     RELIN2        Cat(P)    CFSSNO:2      RELIN2
021200030320      *
021300030320     C                   Clear                   RELIN3
021400030402     C     RELIN3        Cat(P)    'Dependent:':7RELIN3
021500030402     C     RELIN3        Cat(P)    DFNAME:4      RELIN3
021600030320     C                   If        DMI  <> *Blanks
021700030320     C     RELIN3        Cat(P)    DMI:1         RELIN3
021800030320     C     RELIN3        Cat(P)    '.':0         RELIN3
021900030320     C                   End
022000030407     C                   If        DLNAME    =   'SAME'
022100030407     C     RELIN3        Cat(P)    MLNAME:1      RELIN3
022200030407     C                   Else
022300030320     C     RELIN3        Cat(P)    DLNAME:1      RELIN3
022400030407     C                   End
022500131017     C                   Z-add     DPSEQ#        HDSEQ#
022600030407      *
022700131017     C                   eval      ck#not = dfname
022800030403     C                   If        DMI  <> *Blanks
022900131017     C     ck#not        Cat(P)    DMI:1         ck#not
023000131017     C     ck#not        Cat(P)    '.':0         ck#not
023100030403     C                   End
023200030407     C                   If        DLNAME    =   'SAME'
023300131017     C     ck#not        Cat(P)    MLNAME:1      ck#not
023400030407     C                   Else
023500131017     C     ck#not        Cat(P)    DLNAME:1      ck#not
023600030407     C                   End
023700030320      *
023800030320     C                   Clear                   DEAR
023900120718     C     CONTAC        Cat(P)    ':':0         DEAR
024000030320      *
024100030402     C                   Clear                   CmpDFName        12
024200030402     C                   Clear                   CmpDRelCd         3
024300030402     C                   Eval      CmpDFName  =  DFNAME
024400030402     C                   Eval      CmpDRelCd  =  DRELCD
024500030320     C                   Clear                   DNAME
024600030320     C     DNAME         Cat(P)    DFNAME:43     DNAME
024700030320     C                   If        DMI  <> *Blanks
024800030320     C     DNAME         Cat(P)    DMI:1         DNAME
024900030320     C     DNAME         Cat(P)    '.':0         DNAME
025000030320     C                   End
025100030407     C                   If        DLNAME    =   'SAME'
025200030407     C     DNAME         Cat(P)    MLNAME:1      DNAME
025300030407     C                   Else
025400030320     C     DNAME         Cat(P)    DLNAME:1      DNAME
025500030407     C                   End
025600030407      *
025700030320     C     DNAME         Cat(P)    '.':0         DNAME
025800030321      *
025900180116     C****               Clear                   DNAME2
026000180116     C**** DNAME2        Cat(P)    DFNAME:0      DNAME2
026100030321     C                   If        DMI  <> *Blanks
026200180116     C**** DNAME2        Cat(P)    DMI:1         DNAME2
026300180116     C**** DNAME2        Cat(P)    '.':0         DNAME2
026400030321     C                   End
026500030407     C                   If        DLNAME    =   'SAME'
026600180116     C**** DNAME2        Cat(P)    MLNAME:1      DNAME2
026700030407     C                   Else
026800180116     C**** DNAME2        Cat(P)    DLNAME:1      DNAME2
026900030407     C                   End
027000030320      *
027100030320     C                   Clear                   ENVELOPE
027200030321     C     'envelope by' Cat(P)    NiceDt:1      ENVELOPE
027300030320     C     ENVELOPE      Cat(P)    Insure:1      ENVELOPE
027400030320     C                   End
027500180117       chain mbssno member;
027600180117     c                   If        %Found(MEMBER)
027700030328     C                   Movel     MBSSNO        MemberNo
027800030320     C                   Clear                   MNAME
027900030320     C     MNAME         Cat(P)    MFNAME:1      MNAME
028000030320     C                   If        MMI  <> *Blanks
028100030320     C     MNAME         Cat(P)    MMI:1         MNAME
028200030320     C     MNAME         Cat(P)    '.':0         MNAME
028300030320     C                   End
028400030320     C     MNAME         Cat(P)    MLNAME:1      MNAME
028500030320     C                   Clear                   MCSZ
028600030320     C     MCITY         Cat(P)    ',':0         MCSZ
028700030320     C     MCSZ          Cat(P)    MSTATE:1      MCSZ
028800030320     C                   Movel     MZIP          Zip
028900030320     C     MCSZ          Cat(P)    ZIP:2         MCSZ
029000030320     C                   End
029100030321      *
029200030321     C                   Reset                   DFSSNO
029300180117       chain mbssno depend;
029400030321     C                   If        %Found(DEPEND)
029500030402     C                   If        DFNAME    =   CmpDFName  And
029600030402     C                             DRELCD    =   CmpDRelCd
029700030321     C                   Move      DSSNO1_DS     DSSNO4_DS
029800030321     C                   Move      DSSNO2_DS     DSSNO5_DS
029900030321     C                   Move      DSSNO3_DS     DSSNO6_DS
030000030402     C                   Else
030100030402     C                   Dou       %Eof(DEPEND)
030200180117       reade mbssno depend;
030300030402     C                   If        DFNAME    =   CmpDFName  And
030400030402     C                             DRELCD    =   CmpDRelCd
030500030402     C                   Move      DSSNO1_DS     DSSNO4_DS
030600030402     C                   Move      DSSNO2_DS     DSSNO5_DS
030700030402     C                   Move      DSSNO3_DS     DSSNO6_DS
030800030402     C                   Leave
030900030402     C                   End
031000030402     C                   Enddo
031100030402     C                   End
031200030321     C                   End
031300030320      *
031400180117       chain (a_aacode : rec#) aacode;
031500030320     C                   If        %Found(AACODE)
031600030320     C                   Clear                   ANAME
031700030320     C     AFNAM         Cat(P)    ALNAM:1       ANAME
031800030320     C                   End
031900030320
032000121024     C                   Write     VAR1
032100121024     C                   Write     BOTTOM
032200121024     C                   Write     TPAGE1
032300180116     C****               Write     VAR2
032400180116     C****               Write     TPAGE2
032500180116
032600030324     C                   Exsr      #Label
032700180116
032800120426      *----------------------------------------------------------------
032900120426      *  Write to RPG_WORD workfile
033000120426     C                   Exsr      RPG_WORDwf
033100120426      *----------------------------------------------------------------
033200131017
033300131017     C                   movel     diaryb        covtdt
033400131017     C                   eval      hstrst = mbtrst
033500131017     C                   eval      hssub# = mbsub#
033600131017     C                   eval      hsacct = mbacct
033700131017     C                   write     histr
033800131017
033900030320    ?C                   Endsr
034000120426    ? *___________________________________________________________________
034100120426    ? * Write to RPG_WORD workfile
034200120426    ? *___________________________________________________________________
034300120426    ?C     RPG_WORDwf    Begsr
034400130924
034500130924     C                   exsr      get_broker_rcd
034600120426     C                   Eval      WTRUSTC    =  TRUSTC
034700120426     C                   Eval      WSUBC      =  SUBC
034800120426     C                   Eval      WACCTC     =  ACCTC
034900120426     C                   Eval      WMBSSNO    =  MBSSNO
035000120426     C                   Eval      WMLNAME    =  MLNAME
035100120426     C                   Eval      WMFNAME    =  MFNAME
035200120426     C                   Eval      WMMI       =  MMI
035300120426     C                   Eval      WSEX       =  SEX
035400120426     C                   Eval      WBIRTH     =  BIRTH
035500120426     C                   Eval      WDLNAME    =  DLNAME
035600120426     C                   Eval      WDFNAME    =  DFNAME
035700120426     C                   Eval      WDMI       =  DMI
035800120426     C                   Eval      WDSEX      =  DSEX
035900120426     C                   Eval      WDSTUDN    =  DSTUDN
036000120426     C                   Eval      WDRELCD    =  DRELCD
036100120426     C                   Eval      WMBENRL    =  MBENRL
036200120426     C                   Eval      WDBIRTH    =  DBIRTH
036300120426     C                   Eval      WTDATE     =  TDATE
036400120426     C                   Eval      WACNAME    =  ACNAME
036500120426     C                   Eval      WCONTAC    =  CONTAC
036600120426     C                   Eval      WAADDR1    =  AADDR1
036700120426     C                   Eval      WVL1       =  VL1
036800120426     C                   Eval      WVL2       =  VL2
036900120426     C                   Eval      WRELIN1    =  RELIN1
037000120426     C                   Eval      WRELIN2    =  RELIN2
037100120426     C                   Eval      WRELIN3    =  RELIN3
037200120426     C                   Eval      WDEAR      =  DEAR
037300120501     C                   Eval      WEFFECTIVE =  %Trim(NiceDt)
037400120426     C                   Eval      WANAME     =  ANAME
037500120426     C                   Eval      WMNAME     =  MNAME
037600120426     C                   Eval      WADDR1     =  ADDR1
037700120426     C                   Eval      WMCSZ      =  MCSZ
037800120426     C                   Eval      WACTRST    =  ACTRST
037900120426     C                   Eval      WACSUB#    =  ACSUB#
038000120426     C                   Eval      WACACCT    =  ACACCT
038100120426     C                   Write     RP15WR
038200120426    ?C                   Endsr
038300030320    ? *___________________________________________________________________
038400030320    ? * Calculate last day of month turning 19 or 30 days from today.
038500030320    ? *___________________________________________________________________
038600030320    ?C     CalcLDMonth   Begsr
038700030320
038800030403      *---
038900030403      * Use dependent birthday month for diary effective date
039000030403      *--
039100110103     C                   If        DSMM     <>   '01'
039200031124     C                   Eval      DCCYYD    =   ThisYear
039300030403     C                   Eval      DMMD      =   DMM
039400110103     C                   Else
039500110103     C                   Eval      DCCYYD    =   ThisYear + 1
039600110103     C                   End
039700030403      *
039800030321     C     DBIRTH        Mult      10000.0001    NumDate
039900180116     C****               Eval      DBIRTH2 = %Editw(NumDate:'  /  /    ')
040000030321     C                   If        DMMDD  <= DSmmdd8
040100180117         in_date = %editc(thirty#:'X');
040200180117        fmtDate(in_date:'MMDDYYYY':'Mmmmmmmmmz DD, YYYY':out_date:out_error);
040300180117        niceDt = %trim(out_Date);
040400030320     C                   Else
040500031124     C                   Move      TYear         LCCYY
040600030320     C                   Move      DDD           LDD
040700030321     C                   Move      DMM           LMM
040800030320     C                   Select
040900030320     C                   When      DMM     =     1
041000030320     C                   Move      31            LDD
041100030320     C                   When      DMM     =     2
041200030320     C                   Move      28            LDD
041300030320     C                   When      DMM     =     3
041400030320     C                   Move      31            LDD
041500030320     C                   When      DMM     =     4
041600030320     C                   Move      30            LDD
041700030320     C                   When      DMM     =     5
041800030320     C                   Move      31            LDD
041900030320     C                   When      DMM     =     6
042000030320     C                   Move      30            LDD
042100030320     C                   When      DMM     =     7
042200030320     C                   Move      31            LDD
042300030320     C                   When      DMM     =     8
042400030320     C                   Move      31            LDD
042500030320     C                   When      DMM     =     9
042600030320     C                   Move      30            LDD
042700030320     C                   When      DMM     =    10
042800030320     C                   Move      31            LDD
042900030320     C                   When      DMM     =    11
043000030320     C                   Move      30            LDD
043100030320     C                   When      DMM     =    12
043200030320     C                   Move      31            LDD
043300030320     C                   EndSl
043400030321     C                   Move      LMM           CMM
043500030321     C                   Move      LDD           CDD
043600030321     C                   Move      LCCYY         CCCYY
043700180117         in_date = calcDt;
043800180117        fmtDate(in_date:'MMDDYYYY':'Mmmmmmmmmz DD, YYYY':out_date:out_error);
043900180117        niceDt = %trim(out_Date);
044000030320     C                   End
044100030320
044200030320    ?C                   Endsr
044300030324      ****************************************************************
044400030324      * ROUTINE FOR PRINTING LABELS
044500030324      ****************************************************************
044600030324     C     #LABEL        BEGSR
044700030324
044800030324     C                   EXCEPT    LABtop
044900030325     c                   If        ADDR2    <> *Blanks
045000030324     c                   Except    LAB2
045100030324     c                   End
045200030404     C                   Except    LAB3
045300030324
045400030324     C                   ENDSR
045500180117
045600130924       //-----------------------------------------------------------------*
045700130924       //get_broker_rcd: get broker master record from SMANUNIQUE - we need
045800130924       //                the name and address
045900130924       //-----------------------------------------------------------------*
046000180116
046100130924       begsr get_broker_rcd ;
046200130924
046300130924        if smancd <> *blanks ;
046400130924         chain smancd smanunique ;
046500130924
046600130924         if %found (smanunique) ;
046700130924          wbname = %trim(sfname) + ' ' + %trim(slname) ;
046800130924          wbaddr1 = saddr ;
046900130924          wbcsz = %trim(scity) + ', ' + sstate +
047000130924                  '  ' + %subst(%editc(szipcd:'X'):1:5) ;
047100130924          wsmancd = smancd ;
047200130924         endif ;
047300130924
047400130924        endif ;
047500130924
047600130924       endsr ;
047700180116
047800180116    ? //========================================================================
047900180116      // exit
048000180116    ? //========================================================================
048100180116
048200180116       begsr exit;
048300180116
048400180116        *inlr = '1';
048500180116        return;
048600180116
048700180116       endsr;
048800180116
048900180116    ? //========================================================================
049000180116      // init
049100180116    ? //========================================================================
049200180116
049300180116       begsr init;
049400180116
049500180117        tyearn = 0;
049600180117     C                   Movel     TYear         TYearN
049700180117
049800180117        chain userid gbsecure;
049900180117        if %found;
050000180117         distrib = 'Dis: ' + %Trim(scname);
050100180117        else;
050200180117         distrib = 'Dis: Diane Bauman';
050300180117        endif;
050400180117
050500180117     C                   EXCEPT    HEADER
050600180117     C                   Z-Add     *Zeros        Zero9             9 0
050700180117     C                   z-add     *Date         Wdate8
050800180117     C                   Move      Wdate8        ThisYear          4 0
050900180117
051000180117   75  in_date = %editc(wdate8:'X');
051100180117   75  fmtDate(in_date:'MMDDYYYY':'Mmmmmmmmmz DD, YYYY':out_date:out_error);
051200180117   75  tdate = %trim(out_Date);
051300180117     C     Wdate8        Mult      10000.0001    TRDATE
051400180117     C                   Eval      RELIN1  =     RelineFirst
051500180117     C                   Eval      Rec#    =     *Zeros
051600180117      *
051700180117     C                   Move      WDate8        DsDate8
051800180117     C                   Move      Dsdd8         Dsdd
051900180117     C                   Move      Dsmm8         Dsmm
052000180117     C                   Move      CC8           CC
052100180117     C                   Move      Dsyy8         Dsyy
052200180117     C                   Move      DSdate        Wwdate
052300180117     C     *ISO          Move      Wwdate        Wddate1
052400180117     C     Wddate1       Adddur    30:*D         ThirtyDays
052500180117     C                   Move      ThirtyDays    Thirty#           8 0
052600180117     C     Thirty#       Mult      10000.0001    Thirty#
052700180117     C                   Z-add     1             DDDD
052800180117     C
052900180117     C                   eval      trcode = 'U35'
053000180117     C                   eval      hprgnm = wqpgmn
053100180117     C                   eval      hsdltd = 'A'
053200180117     C                   eval      hoper = userid
053300180117     C                   eval      hstrtime = %time()
053400180117     C
053500180116       endsr;
053600180116
053700180116    ? //========================================================================
053800180116
053900030324     OREPORT    E            HEADER         1 01
0540000303240105 O                                           26 '*'
0541000303240106 O                                           25 '************************'
0542000303240107 O                                           29 '****'
0543000303240108 O          E            HEADER         1
0544000303240109 O                                            3 '**'
0545000303240110 O                                           27 'LABEL-TURN AGE 19 Letter'
0546000303240111 O                                           29 '**'
0547000303240112 O          E            HEADER         1
0548000303240113 O                                            2 '*'
054900050414     O                       Distrib             16
055000050414     O******************************             16 'Dist. Lisa K.'
0551000303240115 O                                           26 'RP15XDR'
0552000303240116 O                                           29 '*'
0553000303240117 O          E            HEADER         1
0554000303240118 O                                           25 '************************'
0555000303240119 O                                           29 '****'
055600030324     O          E            LABtop         1 01
055700030325     O                       MNAME               25
055800030324     O          E            LABtop         1
055900030402     O                       ADDR1               31
056000030324     O          E            LAB2           1
056100030402     O                       ADDR2               36
056200030324     O          E            LAB3           1
056300030402     O                       MCSZ                31
