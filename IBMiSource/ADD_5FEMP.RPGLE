000100060629     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200060629     H option(*SRCSTMT: *NODEBUGIO)
000300060629
000400000000      *_________________________________________________________________________
000500000000      *
000600160328      *  (c)Copyright 2016 by GBS, Inc.
000700000000      *
000800160328      *    Created by:  JALLEN - March 28, 2016
000900000000      *_________________________________________________________________________
001000160328     FACCMST    IF   E           K DISK    extfile('F.ACCMST')
001100060629
001200060629      * Prototypes
001300160328      /COPY *LIBL/QMODSRC,#pchainpr
001400160328      /COPY *LIBL/QMODSRC,#genssidpr
001500160328      /COPY *LIBL/QMODSRC,#webtranpr
001600160328      /COPY *LIBL/QMODSRC,#webtcnfpr
001700060426
001800240509     D intrs           s              3s 0
001900240509     D insub           s              3s 0
002000240509     D inacc           s              4s 0
002100240509     D inssn           s              9s 0
002200240509
002300240509     D Pos             s              3s 0 inz
002400061129     d Today           S               d   datfmt(*iso)
002500060426
002600160427     D webin         e ds                  extname(webtran) prefix(in)
002700160328     D webtrn        e ds                  extname(webtran)
002800160328     D webpay        e ds                  extname(webpayroll)
002900060426
003000060426     C     *entry        plist
003100160427     C                   Parm                    webin
003200160328
003300160427     C                   Eval      webpay = #pchain(inoetrst:inoesub#:
003400160427     C                                              inoeacct:inoessno)
003500160427
003501240509                 pos = %c
003502240509                 Pos = Pos;
003503240509
003600160427     C     pybth         Mult      10000.0001    pybth
003700160427     C     pymar         Mult      10000.0001    pymar
003800160427     C     pybsd         Mult      10000.0001    pybsd
003900160427     C     pyhdt         Mult      10000.0001    pyhdt
004000160427     C     pysaldt       Mult      10000.0001    pysaldt
004100160427     C     pybpcef       Mult      10000.0001    pybpcef
004200160427     C     pybpccd       Mult      10000.0001    pybpccd
004300160427     C     pychgdt       Mult      10000.0001    pychgdt
004400160427     C     pyadddt       Mult      10000.0001    pyadddt
004500160328
004600160427     C                   clear                   webtrn
004700160328     C     acckey        chain     ACCMST
004800160328     C                   If        %found(ACCMST)
004900160328     C                   eval      OEAACOD = AACODE
005000160328     C                   end
005100160328
005200160328     C                   eval      OEGRPV = 'ADD_EMP'
005300160427     C                   eval      OETRST = inoetrst
005400160427     C                   eval      OESUB# = inoesub#
005500160427     C                   eval      OEACCT = inoeacct
005600160427     C                   eval      OESSNO = inoessno
005700160328
005800160427     C                   Eval      OESSID = #genssid(inoetrst:inoesub#:inoeacct:
005900160427     C                                              'E')
006000160328     C                   Eval      OEADDU = PYADDUS
006100160328
006200160328     C                   Eval      OEFLDV = 'MBSSNO_50'
006300160328     C                   Eval      oeafter = %editc(pyssn:'X')
006400160328     C                   Eval      oetrn# = #webtran(webtrn)
006500160328     C                   clear                   OEAFTER
006600160328
006700160328     C                   Eval      OEFLDV = 'MLNAME_50'
006800160328     C                   Eval      oeafter = %trim(pylst)
006900160328     C                   Eval      oetrn# = #webtran(webtrn)
007000160328     C                   clear                   OEAFTER
007100160328
007200160328     C                   Eval      OEFLDV = 'MFNAME_50'
007300160328     C                   Eval      oeafter = %trim(pyfst)
007400160328     C                   Eval      oetrn# = #webtran(webtrn)
007500160328     C                   clear                   OEAFTER
007600160328
007700160328     C                   Eval      OEFLDV = 'ADDR1_50'
007800160328     C                   Eval      oeafter = %trim(pyad1)
007900160328     C                   Eval      oetrn# = #webtran(webtrn)
008000160328     C                   clear                   OEAFTER
008100160328
008200160328     C                   If        %trim(pyad2) <> *blanks
008300160328     C                   Eval      OEFLDV = 'ADDR2_50'
008400160328     C                   Eval      oeafter = %trim(pyad2)
008500160328     C                   Eval      oetrn# = #webtran(webtrn)
008600160328     C                   clear                   OEAFTER
008700160328     C                   End
008800160328
008900160328     C                   Eval      OEFLDV = 'CITY_50'
009000160328     C                   Eval      oeafter = %trim(pycty)
009100160328     C                   Eval      oetrn# = #webtran(webtrn)
009200160328     C                   clear                   OEAFTER
009300160328
009400160328     C                   Eval      OEFLDV = 'STATE_50'
009500160328     C                   Eval      oeafter = %trim(pystt)
009600160328     C                   Eval      oetrn# = #webtran(webtrn)
009700160328     C                   clear                   OEAFTER
009800160328
009900160328     C                   Eval      OEFLDV = 'ZIP_50'
010000160328     C                   Eval      oeafter = %trim(pyzp5) + %trim(pyzp4)
010100160328     C                   Eval      oetrn# = #webtran(webtrn)
010200160328     C                   clear                   OEAFTER
010300160328
010400160328     C                   Eval      OEFLDV = 'AREA_50'
010500160328     C                   Eval      oeafter = %trim(pyph1)
010600160328     C                   Eval      oetrn# = #webtran(webtrn)
010700160328     C                   clear                   OEAFTER
010800160328
010900160328     C                   Eval      OEFLDV = 'PHONE_50'
011000160328     C                   Eval      oeafter = %trim(pyph2) + %trim(pyph3)
011100160328     C                   Eval      oetrn# = #webtran(webtrn)
011200160328     C                   clear                   OEAFTER
011300160328
011400160328     C                   Eval      OEFLDV = 'SEX_50'
011500160328     C                   Eval      oeafter = %trim(pygen)
011600160328     C                   Eval      oetrn# = #webtran(webtrn)
011700160328     C                   clear                   OEAFTER
011800160328
011900160328     C                   Eval      OEFLDV = 'BIRTH_50'
012000160328     C                   movel     pybth         OEAFTER
012100160328     C                   Eval      oetrn# = #webtran(webtrn)
012200160328     C                   clear                   OEAFTER
012300160328
012400160328     C                   Eval      OEFLDV = 'PYRAC_50'
012500160328     C                   Eval      oeafter = %trim(pyrac)
012600160328     C                   Eval      oetrn# = #webtran(webtrn)
012700160328     C                   clear                   OEAFTER
012800160328
012900160328     C                   Eval      OEFLDV = 'PYSMK_50'
013000160328     C                   Eval      oeafter = %trim(pysmk)
013100160328     C                   Eval      oetrn# = #webtran(webtrn)
013200160328     C                   clear                   OEAFTER
013300160328
013400160328     C                   Eval      OEFLDV = 'PYMGS_50'
013500160328     C                   Eval      oeafter = %trim(pymgs)
013600160328     C                   Eval      oetrn# = #webtran(webtrn)
013700160328     C                   clear                   OEAFTER
013800160328
013900160328     C                   Eval      OEFLDV = 'PYHRS_50'
014000160328     C                   Movel     pyhrs         OEAFTER
014100160328     C                   Eval      oetrn# = #webtran(webtrn)
014200160328     C                   clear                   OEAFTER
014300160328
014400160328     C                   Eval      OEFLDV = 'PYEML_50'
014500160328     C                   Eval      oeafter = %trim(pyeml)
014600160328     C                   Eval      oetrn# = #webtran(webtrn)
014700160328     C                   clear                   OEAFTER
014800160328
014900160328     C                   Eval      OEFLDV = 'DEMOGRAPH_ONLY_50'
015000160328     C                   Eval      oeafter = *blanks
015100160328     C                   Eval      oetrn# = #webtran(webtrn)
015200160328     C                   clear                   OEAFTER
015300160328
015400160328      ***
015500160328     C                   eval      OEGRPV = 'EMP_INFO'
015600160328      ***
015700160328
015800160328     C                   Eval      OEFLDV = 'PYSTS'
015900160328     C                   Eval      oeafter = %trim(pysts)
016000160328     C                   Eval      oetrn# = #webtran(webtrn)
016100160328     C                   clear                   OEAFTER
016200160328
016300160328     C                   Eval      OEFLDV = 'PYPST'
016400160328     C                   Eval      oeafter = %trim(pypst)
016500160328     C                   Eval      oetrn# = #webtran(webtrn)
016600160328     C                   clear                   OEAFTER
016700160328
016800160328     C                   Eval      OEFLDV = 'PYOCC'
016900160328     C                   Eval      oeafter = %trim(pyocc)
017000160328     C                   Eval      oetrn# = #webtran(webtrn)
017100160328     C                   clear                   OEAFTER
017200160328
017300160328     C                   Eval      OEFLDV = 'PYHDT'
017400160328     C                   Movel     pyhdt         oeafter
017500160328     C                   Eval      oetrn# = #webtran(webtrn)
017600160328     C                   clear                   OEAFTER
017700160328
017800160328     C                   Eval      OEFLDV = 'PYBPC'
017900160328     C                   Eval      oeafter = %trim(pybpc)
018000160328     C                   Eval      oetrn# = #webtran(webtrn)
018100160328     C                   clear                   OEAFTER
018200160328
018300160328     C                   Eval      OEFLDV = 'PYBPCEF'
018400160328     C                   Movel     pybpcef       oeafter
018500160328     C                   Eval      oetrn# = #webtran(webtrn)
018600160328     C                   clear                   OEAFTER
018700160328
018800160328     C                   Eval      OEFLDV = 'ANNUAL_SALARY'
018900160328     C                   if        pyans > 0
019000160328     C                   Movel     pyans         oeafter
019100160328     C                   else
019200160328     C                   Movel     pysal         oeafter
019300160328     C                   end
019400160328     C                   Eval      oetrn# = #webtran(webtrn)
019500160328     C                   clear                   OEAFTER
019600160328
019700160328     C                   Eval      OEFLDV = 'PYSALDT'
019800160328     C                   Movel     pysaldt       oeafter
019900160328     C                   Eval      oetrn# = #webtran(webtrn)
020000160328     C                   clear                   OEAFTER
020100160328
020200160328     C                   eval      OEGRPV = 'EMP_INFO'
020300160328     C                   Eval      OEFLDV = 'EMP_INFO'
020400160328     C                   Eval      oeafter = *blanks
020500160328     C                   Eval      oetrn# = #webtran(webtrn)
020600160328     C                   clear                   OEAFTER
020700160328
020800160328     C                   Eval      OECNFU = %trim(PYADDUS)
020900160328     C                   Callp     #webtcnf(WEBTRN:'ADD_EMP':'':'')
021000160328
021100160328     C                   Eval      OECNFU = %trim(PYADDUS)
021200160328     C                   Callp     #webtcnf(WEBTRN:'EMP_INFO':'':'')
021300170125
021400170125br09 C                   call      'WEBTSUMR1'
021500170125br09 C                   parm                    oessid
021600160328
021700060501     C                   Eval      *inlr = *on
021800060501     C                   return
021900160328
022000160328     C     ACCKEY        klist
022100160427     C                   kfld                    inoetrst
022200160427     C                   kfld                    inoesub#
022300160427     C                   kfld                    inoeacct
