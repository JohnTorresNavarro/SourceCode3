000100121128     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200121128     H option(*SRCSTMT: *NODEBUGIO)
000300121128
000400121128      *----- TRIGGER NOTES -------------------------------------*
000500121128      *
000600130711      *  ADDPFTRG FILE(QS36F/F.MEMBER)
000700121128      *           TRGTIME(*AFTER)
000800121128      *           TRGEVENT(*UPDATE)
000900130711      *           PGM(GBSPGM/MEMTRGR)
001000121128      *           TRGLIB(*FILE)
001100121128      *           TRGUPDCND(*CHANGE)
001200121128      *
001300200904      *
001400200904      * 09.04.2020  FILL66 logic   J.Allen - F065
001500200904      *
001600231218      * 12.12.2023  Fill TSA       J.Allen - T001
001700200904      *
001800121128      *---------------------------------------------------------*
001900130207     FACCOSPL1  if   e           k disk    usropn
002000130311     FACCMSP    if   e           k disk    usropn
002100130311     FHISTAA    if   e           k disk    usropn
002200121128
002300121128      *--- Main procedure interface
002400121128     D Main            PR                  EXTPGM('MEMTRGR')
002500121128
002600121128     D  Trgbuffer                          LIKEDS(Trginfo)
002700121128     D  Trgbufferlen                 10I 0
002800121128
002900121128     D Main            PI
003000121128     D  Trgbuffer                          LIKEDS(Trginfo)
003100121128     D  Trgbufferlen                 10I 0
003200121128
003300121128     D Insert          C                   '1'
003400121128     D Delete          C                   '2'
003500121128     D Update          C                   '3'
003600121128     D Read            C                   '4'
003700121128
003800121128     D After           C                   '1'
003900121128     D Before          C                   '2'
004000121128
004100121128     D Cmtnone         C                   '0'
004200121128     D Cmtchange       C                   '1'
004300121128     D Cmtcs           C                   '2'
004400121128     D Cmtall          C                   '3'
004500130311
004600130311     D cmd             S            200A
004700130311     D length          S             15P 5
004800130311     D #len            S              3P 0
004900130311
005000130311     d F_HST1          c                   'OVRDBF FILE(HISTAA) '
005100130311     d F_HST2          c                   'TOFILE(F.HISTAA)'
005200121128
005300121128     D Trginfo         DS
005400121128     D  File                         10
005500121128     D  Library                      10
005600121128     D  Member                       10
005700121128     D  Event                         1
005800121128     D  Time                          1
005900121128     D  Commitlocklev                 1
006000121128     D                                3
006100121128     D  Ccsid                        10I 0
006200121128     D  Rrn                          10I 0
006300121128     D                                4
006400121128     D  Befrecoffset                 10I 0
006500121128     D  Befreclen                    10I 0
006600121128     D  Befnulloffset                10I 0
006700121128     D  Befnulllen                   10I 0
006800121128     D  Aftrecoffset                 10I 0
006900121128     D  Aftreclen                    10I 0
007000121128     D  Aftnulloffset                10I 0
007100121128     D  Aftnulllen                   10I 0
007200121128
007300121128     D Befrecptr       S               *
007400121128
007500121128     D Beforedta     E DS                  Extname(MEMBER) Prefix(b)
007600121128     D                                     Based(Befrecptr)
007700121128     D                                     Qualified
007800121128
007900121128     D Aftrecptr       S               *
008000121128
008100121128     D Afterdta      E DS                  Extname(MEMBER) Prefix(a)
008200121128     D                                     Based(Aftrecptr)
008300121128     D                                     Qualified
008400121128
008500121128      /copy *libl/qmodsrc,#pchainpr
008600121128      /copy *libl/qmodsrc,#pwritepr
008700121128      /copy *libl/qmodsrc,#nchainpr
008800121128      /copy *libl/qmodsrc,#nwritepr
008900121128
009000121128     D  WEBMEM       e ds                  extname(member) inz
009100121128
009200121128     D  WEBPAY       e ds                  extname(webpayroll) inz
009300121128
009400121128     D  WZIP           ds             9
009500121128     D wzip5                   1      5s 0 inz
009600121128     D wzip4                   6      9s 0 inz
009700121128
009800121128     D  WPHN           ds             7
009900121128     D wphn3                   1      3s 0 inz
010000121128     D wphn4                   4      7s 0 inz
010100121128
010200121130     D salflg          s              1a   inz
010300121129     D payflg          s              1a   inz
010400130311     D whidate         s              8s 0 inz
010500130311     D Today           s              8s 0 inz
010600121128
010700121128      * If trigger fired by OLE update (Ricks program), exit.
010800121128     C                   Exsr      RTVPGM
010900121128     C                   If        %trim(CALLER) = 'WEBTGBSR'
011000121128     C                   Eval      *inLR = *on
011100121128     C                   Return
011200121128     C                   End
011300121128
011400121128      ** Pull QUALIFIED data structure subfields (beforedta. afterdta.)
011500121128
011600121128      /Free
011700121128
011800121128         Befrecptr = %ADDR(Trgbuffer) + Trgbuffer.Befrecoffset;
011900121128         Aftrecptr = %ADDR(Trgbuffer) + Trgbuffer.Aftrecoffset;
012000121128
012100121130         salflg = ' ';
012200121130         if       beforedta.bsalary <> afterdta.asalary;
012300121130         salflg = 'Y';
012400121130         endif;
012500121130
012600121128         select;
012700121128         When     beforedta.bmlname = afterdta.amlname and
012800121128                  beforedta.bmfname = afterdta.amfname and
012900121128                  beforedta.bmmi    = afterdta.ammi    and
013000121128                  beforedta.baddr1  = afterdta.aaddr1  and
013100121128                  beforedta.baddr2  = afterdta.aaddr2  and
013200121128                  beforedta.bcity   = afterdta.acity   and
013300121128                  beforedta.bstate  = afterdta.astate  and
013400121128                  beforedta.bzip    = afterdta.azip    and
013500121128                  beforedta.barea   = afterdta.aarea   and
013600121128                  beforedta.bphone  = afterdta.aphone  and
013700121128                  beforedta.bsex    = afterdta.asex    and
013800121128                  beforedta.bempdt  = afterdta.aempdt  and
013900121129                  beforedta.bmardt  = afterdta.amardt  and
014000121130                  beforedta.bfill66 = afterdta.afill66 and
014100121130                  beforedta.bsalary = afterdta.asalary and
014200121128                  beforedta.bbirth  = afterdta.abirth;
014300121128
014400121128         *inlr = *on;
014500121128         return;
014600121128
014700121128         Other;
014800121128         endsl;
014900121128
015000121128         webmem = afterdta;
015100121128
015200121128      /End-free
015300121129
015400121129      * Check version of OLE
015500121129     C                   Exsr      ChkVersion
015600141006
015700141006      * Shut off trigger for payroll accounts (Cindy W)
015800141006     C                   If        payflg = 'P'
015900141006     C                   Eval      *inLR = *on
016000141006     C                   Return
016100141006     C                   End
016200121128
016300121129     C                   Select
016400121129      * payroll
016500151013     C                   When      payflg = 'D'
016600121128     C                   Eval      WEBPAY = #pchain(mbtrst:mbsub#:mbacct:
016700121129     C                                              mbssno)
016800121130      * If screen 1 missing; fill SSN so write occurs in pwrite
016900121130     C                   If        PYSSN = 0
017000121130     C                   Eval      PYSSN = mbssno
017100121130     C                   End
017200121129     C                   When      payflg = 'N'
017300121129      * non-payroll
017400121128     C                   Eval      WEBPAY = #nchain(mbtrst:mbsub#:mbacct:
017500121128     C                                              mbssno)
017600121130      * If screen 1 missing; fill SSN so write occurs in nwrite
017700121130     C                   If        PYSSN = 0
017800121130     C                   Eval      PYSSN = mbssno
017900121130     C                   End
018000121129     C                   Other
018100121129      * neither
018200121129     C                   Eval      *inLR = *on
018300121129     C                   Return
018400121129     C                   Endsl
018500121128
018600121128      * If found, update the OLE demographics
018700121128     C                   If        PYSSN <> 0
018800231218T001 C                   Eval      PYTRS = mbtrst
018900231218T001 C                   Eval      PYSUB = mbsub#
019000231218T001 C                   Eval      PYACT = mbacct
019100231218T001 C                   Eval      PYADDUS = 'MEMTRGR'
019200121128     C                   Eval      PYFST = %trim(MFNAME)
019300121128     C                   Eval      PYMID = %trim(MMI)
019400121128     C                   Eval      PYLST = %trim(MLNAME)
019500121128     C                   Eval      PYAD1 = %trim(ADDR1)
019600121128     C                   Eval      PYAD2 = %trim(ADDR2)
019700121128     C                   Eval      PYCTY = %trim(CITY)
019800121128     C                   Eval      PYSTT = %trim(STATE)
019900121128
020000121128     C                   Move      ZIP           WZIP
020100121128     C                   Move      wzip5         PYZP5
020200121128     C                   Move      wzip4         PYZP4
020300121128
020400121128     C                   Move      AREA          PYPH1
020500121128     C                   Move      PHONE         WPHN
020600121128     C                   Move      wphn3         PYPH2
020700121128     C                   Move      wphn4         PYPH3
020800121128
020900121128     C                   Eval      pygen = %trim(sex)
021000121128
021100121128      * You have to flip the dates because pwrite flips them back
021200121128     C     empdt         Mult      10000.0001    pyhdt
021300121128     C     birth         Mult      10000.0001    pybth
021400121128     C     mardt         Mult      10000.0001    pymar
021500121129
021600121129      * email, only update if OLE side is blank?
021700200904F065 C                   movel     FILL66        FILL65           65
021800200904F065 C                   If        %trim(PYEML) = *blanks   and
021900200904F065 C                             %trim(FILL65) <> *blanks
022000200904F065 C                   Eval      PYEML = %trim(FILL65)
022100200904F065 C                   End
022200121128
022300121130      * Only update Salary for non-payroll accounts
022400121130     C                   If        payflg = 'N' and
022500121130     C                             salflg = 'Y'
022600121130     C                   Eval      pysal = salary
022700130311     C                   Exsr      SalDate
022800121130     C                   End
022900121128
023000121128     C                   Select
023100151013     C                   When      payflg = 'D'
023200121128     C                   Eval      payflg = #pwrite(WEBPAY)
023300121128     C                   When      payflg = 'N'
023400121128     C                   Eval      payflg = #nwrite(WEBPAY)
023500121128     C                   Endsl
023600121128
023700121128     C                   End
023800121128
023900121128     C                   Eval      *inLR = *on
024000121128     C                   Return
024100130311      *---------------------------------------------------------------*
024200130311     C     SalDate       Begsr
024300130311     C                   eval      Today  = %int(%char(%date : *iso0))
024400130311
024500130311     C                   Eval      CMD = F_HST1 + F_HST2
024600130311     C                   EVAL      #LEN = %LEN(%TRIM(CMD))
024700130311     C                   Z-ADD     #LEN          LENGTH
024800130311     C                   CALL      'QCMDEXC'                                    EXECUTE
024900130311     C                   PARM                    CMD
025000130311     C                   PARM                    LENGTH
025100130311     C                   Open      HISTAA
025200130311
025300130311     C     HSTKEY        Klist
025400130311     C                   Kfld                    HKEY
025500130311     C                   Kfld                    TRCODE
025600130311
025700130311     C                   Move      PYSSN         HKEY
025800130311     C                   Eval      TRCODE = 'M17'
025900130311
026000130311     C     HSTKEY        Setgt     HISTAA
026100130311     C     HSTKEY        Readpe    HISTAA
026200130311     C                   Dow       not %eof(HISTAA)
026300130311     C                   If        Today = TRDATE
026400130311     C     COVTDT        Mult      10000.0001    PYSALDT
026500130311     C                   Leave
026600130311     C                   End
026700130311     C     HSTKEY        Readpe    HISTAA
026800130311     C                   Enddo
026900130311     C                   Close     HISTAA
027000130311
027100130311     C                   Endsr
027200121128      *---------------------------------------------------------------*
027300121128     C     RTVPGM        Begsr
027400121128     C                   Call      'RTVTRGPGM'
027500121128     C                   Parm      'MEMTRGR'     CALLED           10
027600121128     C                   Parm                    CALLER           10
027700121128     C                   Parm                    M1DTA            80
027800121128     C                   Endsr
027900121129      *---------------------------------------------------------------*
028000121129     C     ChkVersion    Begsr
028100130207
028200130207      * Do Not Update PayChoice Accounts
028300130207     C                   open      ACCMSP
028400130207     C     MSPKEY        Chain     ACCMSP
028500130207     C                   If        %found(ACCMSP)
028600130207     C                   If        %trim(AMPAYR) <> *blanks
028700130207     C                   Close     ACCMSP
028800130207     C                   Eval      *inLR = *on
028900130207     C                   Return
029000130207     C                   End
029100130207     C                   End
029200130207     C                   Close     ACCMSP
029300130207
029400121129     C                   Eval      payflg = ' '
029500121129     C                   open      ACCOSPL1
029600121129     C                   eval      whidate = *hival
029700121129     C     ACCKEY        Setgt     ACCOSPL1
029800121129     C     ACCKEYpe      Readpe    ACCOSPL1
029900121129     C                   Dow       not %eof(ACCOSPL1)
030000121129     C                   Select
030100130207     C                   When      aocode = 4 or
030200121129     C                             aocode = 5
030300151013     C                   Eval      payflg = 'P'
030400121129     C                   When      aocode = 6 or
030500121129     C                             aocode = 7
030600121129     C                   Eval      payflg = 'N'
030700151013     C                   When      aocode = 8 or
030800151013     C                             aocode = 9
030900151013     C                   Eval      payflg = 'D'
031000121129     C                   Other
031100121129     C                   Eval      payflg = ' '
031200121129     C                   Endsl
031300121129     C                   close     ACCOSPL1
031400121129     C                   LeaveSR
031500121129     C                   Enddo
031600121129     C                   close     ACCOSPL1
031700121129
031800130207     C     MSPKEY        Klist
031900121129     C                   Kfld                    mbtrst
032000121129     C                   Kfld                    mbsub#
032100121129     C                   Kfld                    mbacct
032200130207
032300130207     C     ACCKEY        Klist
032400130207     C                   Kfld                    mbtrst
032500130207     C                   Kfld                    mbsub#
032600130207     C                   Kfld                    mbacct
032700130207     C                   Kfld                    whidate
032800121129
032900121129     C     ACCKEYpe      Klist
033000121129     C                   Kfld                    mbtrst
033100121129     C                   Kfld                    mbsub#
033200121129     C                   Kfld                    mbacct
033300121129
033400121129     C                   Endsr
