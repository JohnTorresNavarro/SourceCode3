000100030319     H DFTNAME(RP15XDR)
000200991007      ******************************************************************
000300030319      * RP15XDR    GROUP BENEFIT SERVICES SOFTWARE           2003      *
000400991007      *                                                                *
000500030324      *  DESCRIPTION - Generate Letters for Dependents attaining age 23*
000600991007      *                                                                *
000700030311      *                                                                *
000800030324      * 3/24/03  SZZ                                                   *
000900031124      *11/24/03  SZZ   The year reflected as "effective" in the text   *
001000031124      *                of the letter should not come from the system;  *
001100031124      *                it should come from the user's entry.           *
001200040520      * 5/20/04  SZZ   Move zeros to history dep seq#, invoic date and *
001300040520      *                 receive date to avoid data decimal errors.     *
001400050414      * 4/14/05  SZZ   Change distribution notice to submitting user.  *
001500120228      * 2/28/12  szz   Add age to re: line & proper tran code to hist. *
001600120229      * 2/29/12  szz   Add workfile to be used for RPG_WORD letters.   *
001700131008      * 9/29/13  dpb   Added Broker logic                              *
001800991007      *                                                                *
001900991007      ******************************************************************
002000030320     FRP15XWK   IF   E           K Disk
002100030320     FACCMST    IF   E           K Disk
002200030320     FMEMBER    IF   E           K Disk
002300030320     FAACODE    IF   E           K Disk
002400050414     FGBSECURE  IF   E           K Disk
002500130924     Fsmanuniqueif   e           k disk
002600121024     FRP15XTP   O    E             Printer
002700130923     FRP15WWK   O    E             Disk
002800131017     FHIST      O    e             DISK
0029000303240021 FREPORT    O    F  198        PRINTER
003000030324     F                                     FORMLEN(8)
003100030324     F                                     FORMOFL(8)
0032000311240055 D                UDS
0033000311240056 D  TYEAR                 21     24
003400120228     D  LAGE                  25     26
003500030320     D                 DS
003600030320     D MBSSNO                              Inz(*Zeros)
003700030321     D  SSNO1_DS                      3    Overlay(MBSSNO)
003800030321     D  SSNO2_DS                      2    Overlay(MBSSNO:4)
003900030321     D  SSNO3_DS                      4    Overlay(MBSSNO:6)
004000030321     D                 DS
004100030321     D DEPSS#                              Inz(*Zeros)
004200030321     D  DSSNO1_DS                     3    Overlay(DEPSS#)
004300030321     D  DSSNO2_DS                     2    Overlay(DEPSS#:4)
004400030321     D  DSSNO3_DS                     4    Overlay(DEPSS#:6)
004500030328     D Hkey            DS
004600030328     D  BlankSpace                    1    Inz(*Blanks)
004700030328     D  MemberNo                      9
004800030320
004900030320     D                 DS
005000030321     D CFSSNO                        11    Inz('   -  -    ')
005100030321     D  SSNO4_DS                      3    Overlay(CFSSNO)
005200030321     D  SSNO5_DS                      2    Overlay(CFSSNO:5)
005300030321     D  SSNO6_DS                      4    Overlay(CFSSNO:8)
005400030321     D                 DS
005500030321     D DFSSNO                        11    Inz('   -  -    ')
005600030321     D  DSSNO4_DS                     3    Overlay(DFSSNO)
005700030321     D  DSSNO5_DS                     2    Overlay(DFSSNO:5)
005800030321     D  DSSNO6_DS                     4    Overlay(DFSSNO:8)
005900030320     D                 DS
006000030321     D DBIRTH                              Inz(*ZEROS)
006100030321     D  DCCYY                         4  0 Overlay(DBIRTH)
006200030321     D  DMMDD                         4  0 Overlay(DBIRTH:5)
006300030321     D  DMM                           2  0 Overlay(DBIRTH:5)
006400030321     D  DDD                           2  0 Overlay(DBIRTH:7)
006500030403     D                 DS
006600030403     D DiaryB                              Inz(*ZEROS)
006700030403     D  DCCYYD                        4  0 Overlay(DiaryB)
006800030403     D  DMMD                          2  0 Overlay(DiaryB:5)
006900030403     D  DDDD                          2  0 Overlay(DiaryB:7)
007000030320     D                 DS
007100030321     D LDDate                              INZ(*ZEROS)
007200030321     D  LCCYY                         4  0 Overlay(LDDate)
007300030321     D  LMM                           2  0 Overlay(LDDate:5)
007400030321     D  LDD                           2  0 Overlay(LDdate:7)
007500030321     D                 DS
007600030403     D CalcDt                              INZ(*ZEROS)
007700030321     D  CMM                           2  0 Overlay(CalcDt)
007800030321     D  CDD                           2  0 Overlay(CalcDt:3)
007900030321     D  CCCYY                         4  0 Overlay(CalcDt:5)
008000030321
008100030403     D #8              S              8S 0
008200030320    ?D  WWdate         S              8  0
008300030320    ?D  WDDATE1        S               D   Datfmt(*ISO)
008400030320     D  WDATE8         S              8  0
008500030320     D  ThirtyDays     S               D   Datfmt(*ISO)
008600050414     D  Distrib        S             15
008700030320    ?D  DsDate         DS
008800030320     D   CC                    1      2
008900030320     D   DSyy                  3      4
009000030320     D   DSmm                  5      6
009100030320     D   DSdd                  7      8
009200030321    ?D  DsDate8        DS
009300030321     D   DSmmdd8               1      4  0
009400030321     D   DSmm8                 1      2
009500030321     D   DSdd8                 3      4
009600030321     D   CC8                   5      6
009700030321     D   DSyy8                 7      8
009800030320
009900120228     D RelineFirst23   C                   'RE: NOTIFICATION OF DEPENDENT REACH-
010000120228     D                                     ING GROUP MAXIMUM AGE 23'
010100120228     D RelineFirst25   C                   'RE: NOTIFICATION OF DEPENDENT REACH-
010200120228     D                                     ING GROUP MAXIMUM AGE 25'
010300120228     D RelineFirst26   C                   'RE: NOTIFICATION OF DEPENDENT REACH-
010400120228     D                                     ING GROUP MAXIMUM AGE 26'
010500131017
010600131017     D iopgmd        esds
010700131017
010800030325     IACCMSR
010900030320     I              AACODE                      A_AACODE
011000030325     IMEMBR
011100030320     I              CITY                        MCITY
011200030320     I              STATE                       MSTATE
011300030320     I              ZIP                         MZIP
011400030320     C                   Read      RP15XWK
011500030320    ?C                   Dow       Not %Eof(RP15XWK)
011600030320     C                   Exsr      Process
011700030320     C                   Read      RP15XWK
011800030320    ?C                   Enddo
011900030319     C                   Eval      *InLR    =     *On
012000030320    ? *___________________________________________________________________
012100030320    ? * Main Processing
012200030320    ? *___________________________________________________________________
012300030320    ?C     Process       Begsr
012400030320    CC                   Exsr      CalcLDMonth
012500030320     C                   Reset                   CFSSNO
012600120229     C**************     Move      SSNO1_DS      SSNO4_DS
012700120229     C**************     Move      SSNO2_DS      SSNO5_DS
012800120229     C                   Move      'XXX'         SSNO4_DS
012900120229     C                   Move      'XX'          SSNO5_DS
013000030320     C                   Move      SSNO3_DS      SSNO6_DS
013100030320     C                   Move      TRUSTC        Trust
013200030320     C                   Move      SUBC          Sub
013300030320     C                   Move      ACCTC         Acct
013400030320     C     AccKey        Chain     ACCMST
013500030320     C                   If        %Found(ACCMST)
013600030403     C                   Clear                   ACNAME
013700030403     C     ACNAME        Cat(P)    ACNAM1:0      ACNAME
013800030403     C     ACNAME        Cat(P)    ACNAM2:2      ACNAME
013900030403     C     ACITY         Cat(P)    ',':0         CSZ              30
014000030320     C     CSZ           Cat(P)    ASTATE:1      CSZ
014100030320     C                   Movel     AZIP          Zip               5
014200030320     C     CSZ           Cat(P)    ZIP:2         CSZ
014300030403     C                   If        AADDR2  =     *Blanks
014400030403     C                   Eval      VL1     =     CSZ
014500030403     C                   Eval      VL2     =     *Blanks
014600030403     C                   Else
014700030403     C                   Eval      VL1     =     AADDR2
014800030403     C                   Eval      VL2     =     CSZ
014900030403     C                   End
015000030320      *
015100030320     C                   Clear                   RELIN2
015200030324     C     RELIN2        Cat(P)    MFNAME:7      RELIN2
015300030320     C                   If        MMI  <> *Blanks
015400030320     C     RELIN2        Cat(P)    MMI:1         RELIN2
015500030320     C     RELIN2        Cat(P)    '.':0         RELIN2
015600030320     C                   End
015700030320     C     RELIN2        Cat(P)    MLNAME:1      RELIN2
015800030320     C     RELIN2        Cat(P)    'SS# ':2      RELIN2
015900030320     C     RELIN2        Cat(P)    CFSSNO:1      RELIN2
016000030320      *
016100030320     C                   Clear                   RELIN3
016200030324     C     RELIN3        Cat(P)    DFNAME:7      RELIN3
016300030320     C                   If        DMI  <> *Blanks
016400030320     C     RELIN3        Cat(P)    DMI:1         RELIN3
016500030320     C     RELIN3        Cat(P)    '.':0         RELIN3
016600030320     C                   End
016700030320     C     RELIN3        Cat(P)    DLNAME:1      RELIN3
016800131017
016900131017     C                   eval      ck#not = dfname
017000030403     C                   If        DMI  <> *Blanks
017100131017     C     ck#not        Cat(P)    DMI:1         ck#not
017200131017     C     ck#not        Cat(P)    '.':0         ck#not
017300030403     C                   End
017400030320      *
017500030320     C                   Clear                   DEAR
017600120718     C     CONTAC        Cat(P)    ':':0         DEAR
017700030320      *
017800030320     C                   End
017900030320     C     MemKey        Chain     MEMBER
018000030320     C                   If        %Found(MEMBER)
018100030328     C                   Movel     MBSSNO        MemberNo
018200030320     C                   Clear                   MNAME
018300030320     C     MNAME         Cat(P)    MFNAME:1      MNAME
018400030320     C                   If        MMI  <> *Blanks
018500030320     C     MNAME         Cat(P)    MMI:1         MNAME
018600030320     C     MNAME         Cat(P)    '.':0         MNAME
018700030320     C                   End
018800030320     C     MNAME         Cat(P)    MLNAME:1      MNAME
018900030320     C                   Clear                   MCSZ
019000030320     C     MCITY         Cat(P)    ',':0         MCSZ
019100030320     C     MCSZ          Cat(P)    MSTATE:1      MCSZ
019200030320     C                   Movel     MZIP          Zip
019300030320     C     MCSZ          Cat(P)    ZIP:2         MCSZ
019400030320     C                   End
019500030321      *
019600030320     C     AAKey         Chain     AACODE
019700030320     C                   If        %Found(AACODE)
019800030320     C                   Clear                   ANAME
019900030320     C     AFNAM         Cat(P)    ALNAM:1       ANAME
020000030324     C                   Eval      DIRECTDIAL = %Editw(ADDIAL:'0(   )&   -    ')
020100030325     C     DIRECTDIAL    Cat(P)    '.':0         DIRECTDIAL
020200030320     C                   End
020300030320
020400030325     C                   If        AADDR2 = *Blanks
020500030325     C                   Eval      AADDR2 = CSZ
020600030325     C                   Eval      CSZ    = *Blanks
020700030325     C                   End
020800030325
020900030324     C                   Write     VAR1
021000030320     C                   Write     BOTTOM
021100030324     C                   Write     TPAGE1
021200030324     C                   Exsr      #Label
021300120229      *----------------------------------------------------------------
021400120229      *  Write to RPG_WORD workfile
021500120229     C                   Exsr      RPG_WORDwf
021600120229      *----------------------------------------------------------------
021700131017     C                   Z-add     *Zeros        HDSEQ#
021800131017
021900131017     C                   movel     diaryb        covtdt
022000131017     C                   eval      hstrst = mbtrst
022100131017     C                   eval      hssub# = mbsub#
022200131017     C                   eval      hsacct = mbacct
022300131017     C                   write     histr
022400131017
022500030320    ?C                   Endsr
022600030320    ? *___________________________________________________________________
022700030320    ? * Format the date in words
022800030320    ? *___________________________________________________________________
022900030320    ?C     FmtDat        Begsr
023000030320
023100030320     C                   Eval      Input_Format  = 'MMDDYYYY'
023200030320     C                   Eval      Output_Format = 'Mmmmmmmmmz DD, YYYY'
023300030320     C                   Call      'FMTDATE'
023400030320     C                   Parm                    Input_Date       32
023500030320     C                   Parm                    Input_Format     32
023600030320     C                   Parm                    Output_Format    32
023700030320     C                   Parm                    Output_Date      32
023800030320     C                   Parm                    Output_Error     10
023900030320    ?C                   Endsr
024000120229    ? *___________________________________________________________________
024100120229    ? * Write to RPG_WORD workfile
024200120229    ? *___________________________________________________________________
024300120229    ?C     RPG_WORDwf    Begsr
024400130924
024500130924     C                   exsr      get_broker_rcd
024600120229     C                   Eval      WTRUSTC    =  TRUSTC
024700120229     C                   Eval      WSUBC      =  SUBC
024800120229     C                   Eval      WACCTC     =  ACCTC
024900120229     C                   Eval      WMBSSNO    =  MBSSNO
025000120229     C                   Eval      WMLNAME    =  MLNAME
025100120229     C                   Eval      WMFNAME    =  MFNAME
025200120229     C                   Eval      WMMI       =  MMI
025300120229     C                   Eval      WSEX       =  SEX
025400120229     C                   Eval      WBIRTH     =  BIRTH
025500120229     C                   Eval      WDLNAME    =  DLNAME
025600120229     C                   Eval      WDFNAME    =  DFNAME
025700120229     C                   Eval      WDMI       =  DMI
025800120229     C                   Eval      WDSEX      =  DSEX
025900120229     C                   Eval      WDSTUDN    =  DSTUDN
026000120229     C                   Eval      WDRELCD    =  DRELCD
026100120229     C                   Eval      WMBENRL    =  MBENRL
026200120229     C                   Eval      WDBIRTH    =  DBIRTH
026300120229     C                   Eval      WTDATE     =  TDATE
026400120229     C                   Eval      WACNAME    =  ACNAME
026500120229     C                   Eval      WCONTAC    =  CONTAC
026600120229     C                   Eval      WAADDR1    =  AADDR1
026700120229     C                   Eval      WVL1       =  VL1
026800120229     C                   Eval      WVL2       =  VL2
026900120229     C                   Eval      WRELIN1    =  RELIN1
027000120229     C                   Eval      WRELIN2    =  RELIN2
027100120229     C                   Eval      WRELIN3    =  RELIN3
027200120229     C                   Eval      WDEAR      =  DEAR
027300120229     C                   Eval      WEFFECTIVE =  EFFECTIVE
027400120229     C                   Eval      WDIRECTDIA =  DIRECTDIAL
027500120229     C                   Eval      WANAME     =  ANAME
027600120229     C                   Eval      WMNAME     =  MNAME
027700120229     C                   Eval      WADDR1     =  ADDR1
027800120229     C                   Eval      WMCSZ      =  MCSZ
027900120229     C                   Eval      WACTRST    =  ACTRST
028000120229     C                   Eval      WACSUB#    =  ACSUB#
028100120229     C                   Eval      WACACCT    =  ACACCT
028200120229     C                   Write     RP15WR
028300120229    ?C                   Endsr
028400030320    ? *___________________________________________________________________
028500030320    ? * Calculate last day of month turning 19 or 30 days from today.
028600030320    ? *___________________________________________________________________
028700030320    ?C     CalcLDMonth   Begsr
028800030403      *---
028900030403      * Use dependent birthday month for diary effective date
029000030403      *--
029100031124     C                   Eval      DCCYYD    =   ThisYear
029200030403     C                   Eval      DMMD      =   DMM
029300030403      *
029400030403     C***                If        DMMDD  <= DSmmdd8
029500030403     C***  Thirty#       Mult      10000.0001    Thirty#
029600030403     C***                Movel     Thirty#       Input_Date
029700030403     C***                Exsr      FmtDat
029800030403     C***                Eval      NiceDt  =     %trim(Output_Date)
029900030403     C***                Else
030000031124     C***************    Move      ThisYear      LCCYY
030100031124     C                   Move      TYear         LCCYY
030200030320     C                   Move      DDD           LDD
030300030321     C                   Move      DMM           LMM
030400030320     C                   Select
030500030320     C                   When      DMM     =     1
030600030320     C                   Move      31            LDD
030700030320     C                   When      DMM     =     2
030800030320     C                   Move      28            LDD
030900030320     C                   When      DMM     =     3
031000030320     C                   Move      31            LDD
031100030320     C                   When      DMM     =     4
031200030320     C                   Move      30            LDD
031300030320     C                   When      DMM     =     5
031400030320     C                   Move      31            LDD
031500030320     C                   When      DMM     =     6
031600030320     C                   Move      30            LDD
031700030320     C                   When      DMM     =     7
031800030320     C                   Move      31            LDD
031900030320     C                   When      DMM     =     8
032000030320     C                   Move      31            LDD
032100030320     C                   When      DMM     =     9
032200030320     C                   Move      30            LDD
032300030320     C                   When      DMM     =    10
032400030320     C                   Move      31            LDD
032500030320     C                   When      DMM     =    11
032600030320     C                   Move      30            LDD
032700030320     C                   When      DMM     =    12
032800030320     C                   Move      31            LDD
032900030320     C                   EndSl
033000030415     C                   Move      LDD           DDDD
033100030403     C                   Move      LMM           CMM
033200030403     C                   Move      LDD           CDD
033300030403     C                   Move      LCCYY         CCCYY
033400030403     C                   Z-add     *Zero         #8
033500030403     C                   Movel     CalcDt        #8
033600030403     C                   Clear                   EFFECTIVE
033700030408     C                   Eval      EFFECTIVE =   %Editw(#8:'  /  /    ')
033800030408     C     EFFECTIVE     Cat(P)    '.':0         EFFECTIVE
033900030320
034000030320    ?C                   Endsr
034100030324      ****************************************************************
034200030324      * ROUTINE FOR PRINTING LABELS
034300030324      ****************************************************************
034400030324     C     #LABEL        BEGSR
034500030324
034600030324     C                   EXCEPT    LABtop
034700030324     C                   Except    LAB3
034800030325     c                   If        ADDR2   <> *Blanks
034900030324     c                   Except    LAB4
035000030324     c                   End
035100030324     C                   Except    LAB5
035200030324
035300030324     C                   ENDSR
035400030319    ? *___________________________________________________________________
035500030319    ? * Initialization
035600030319    ? *___________________________________________________________________
035700030319    ?C     *INZSR        Begsr
035800030320
035900030328     C     *ENTRY        PLIST
036000030328     C                   PARM                    USERID           10
036100050414      *
036200120228     C                   Select
036300120228     C                   When      LAGE    =     '23'
036400120228     C                   Movel     RelineFirst23 RelineFirst      59
036500131017     C                   Movel     'U36'         trcode
036600120228     C                   When      LAGE    =     '25'
036700120228     C                   Movel     RelineFirst25 RelineFirst
036800131017     C                   Movel     'U77'         trcode
036900120228     C                   When      LAGE    =     '26'
037000120228     C                   Movel     RelineFirst26 RelineFirst
037100131017     C                   Movel     'U76'         trcode
037200120228     C                   EndSl
037300120228      *
037400050414     C     USERID        Chain     GBSECURE
037500050414     C                   If        %Found(GBSECURE)
037600050414     C                   Eval      Distrib = 'Dis: ' + %Trim(SCNAME)
037700050414     C                   Else
037800050414     C                   Eval      Distrib = 'Dis: Diane Bauman'
037900050414     C                   End
038000030328      *
038100031124     C                   Z-add     *Zeros        TYearN            4 0
038200031124     C                   Movel     TYear         TYearN
038300030320     C     AccKey        KLIST
038400030320     C                   Kfld                    TRUST             3 0
038500030320     C                   Kfld                    SUB               3 0
038600030320     C                   Kfld                    ACCT              4 0
038700030320
038800030320     C     MemKey        KLIST
038900030320     C                   Kfld                    MBSSNO
039000030321
039100030321     C     DepKey        KLIST
039200030321     C                   Kfld                    MBSSNO
039300030320
039400030320     C     AAKey         KLIST
039500030320     C                   Kfld                    A_AACODE
039600030320     C                   Kfld                    Rec#              2 0
039700030320
039800030328     C                   EXCEPT    HEADER
039900030328     C                   Z-Add     *Zeros        Zero9             9 0
040000030319     C                   z-add     *Date         Wdate8
040100030320     C                   Move      Wdate8        ThisYear          4 0
040200030319     C                   Movel     Wdate8        Input_Date
040300131017     C     Wdate8        Mult      10000.0001    TRDATE
040400030320     C                   Exsr      FmtDat
040500030319     C                   Eval      TDATE   =     %trim(Output_Date)
040600030320     C                   Eval      RELIN1  =     RelineFirst
040700030320     C                   Eval      Rec#    =     *Zeros
040800030320      *
040900030321     C                   Move      WDate8        DsDate8
041000030321     C                   Move      Dsdd8         Dsdd
041100030321     C                   Move      Dsmm8         Dsmm
041200030321     C                   Move      CC8           CC
041300030321     C                   Move      Dsyy8         Dsyy
041400030321     C                   Move      DSdate        Wwdate
041500030321     C     *ISO          Move      Wwdate        Wddate1
041600030321     C     Wddate1       Adddur    30:*D         ThirtyDays
041700030321     C                   Move      ThirtyDays    Thirty#           8 0
041800030320     C
041900131017     C                   eval      hprgnm = wqpgmn
042000131017     C                   eval      hsdltd = 'A'
042100131017     C                   eval      hoper = userid
042200131017     C                   eval      hstrtime = %time()
042300131017     C
042400030319    ?C                   Endsr
042500130924      /free
042600130924       //-----------------------------------------------------------------*
042700130924       //get_broker_rcd: get broker master record from SMANUNIQUE - we need
042800130924       //                the name and address
042900130924       //-----------------------------------------------------------------*
043000130924       begsr get_broker_rcd ;
043100130924
043200130924        if smancd <> *blanks ;
043300130924         chain smancd smanunique ;
043400130924
043500130924         if %found (smanunique) ;
043600130924          wbname = %trim(sfname) + ' ' + %trim(slname) ;
043700130924          wbaddr1 = saddr ;
043800130924          wbcsz = %trim(scity) + ', ' + sstate +
043900130924                  '  ' + %subst(%editc(szipcd:'X'):1:5) ;
044000130924          wsmancd = smancd ;
044100130924         endif ;
044200130924
044300130924        endif ;
044400130924
044500130924       endsr ;
044600130924      /end-free
044700030324      *****************************************************************
044800030324     OREPORT    E            HEADER         1 01
0449000303240105 O                                           26 '*'
0450000303240106 O                                           25 '************************'
0451000303240107 O                                           29 '****'
0452000303240108 O          E            HEADER         1
0453000303240109 O                                            3 '**'
0454000303240110 O                                           27 'LABEL-TURN AGE 23 Letter'
0455000303240111 O                                           29 '**'
0456000303240112 O          E            HEADER         1
0457000303240113 O                                            2 '*'
045800050414     O                       Distrib             16
045900050414     O************************************       16 'Dist. Lisa K.'
0460000303240115 O                                           26 'RP15XTR'
0461000303240116 O                                           29 '*'
0462000303240117 O          E            HEADER         1
0463000303240118 O                                           25 '************************'
0464000303240119 O                                           29 '****'
046500030324     O          E            LABtop         1 01
046600030324     O                       MNAME               25
046700030324     O          E            LAB3           1
046800030324     O                       ADDR1               30
046900030324     O          E            LAB4           1
047000030324     O                       ADDR2               30
047100030324     O          E            LAB5           1
047200030324     O                       MCSZ                30
