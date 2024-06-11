000100000000      *_________________________________________________________________________
000200000000      *
000300081121      *  Description:  Process TRNMIT Flags
000400000000      *
000500081120      *  (c)Copyright 2008 by GBS, Inc.
000600000000      *
000700081120      *    Created by:  JALLEN - Nov 20, 2008
000800131010      *
000900131010      * 10/10/13 sbt - hist file expansion project
001000160208      *
001100160208      * 02/08/16 jva - a hist record was found with a zero TRUST so
001200160208      *                add code to double check TSA is not zero
001300000000      *_________________________________________________________________________
001400021024      *
001500081121     FDW310JF2  IF   E           K DISK    Infds(DBFD)
001600081121     FTRNMIT    UF   E             DISK    Rename(TRNMIR:TRNUPD)
001700090716     FTRNSUMP   UF   E           K DISK
001800091207     FHIST      O  A E           K DISK    prefix(H_)
001900090716     FTRNFXCP   IF   E           K DISK
002000100126    ?FMEMBER    IF   E           K DISK
002100100421    ?FACCMST    IF   E           K DISK
002200100628    ?FWRKFLGP   IF   E           K DISK
002300100628    ?FFRMTRKL6  UF   E           K DISK
002400081120
002500090917     D ORGFLG          s              1    inz
002600091223     D ALLOW           s              1    inz
002700100419     D FLGSSN          s              9    inz
002800100628     D FLGSEQ          s              2    inz
002900100628
003000100628     D Today           s              8s 0 inz
003100100128
003200100419     D Dep             s              2S 0 inz
003300100128     D Pos             s              2S 0 inz
003400100128     D Nxt             s              2S 0 inz
003500100128     D Pxt             s              2S 0 inz
003600100128
003700100128     D WIDEP           s             40A   INZ
003800100128     D WADEP           s              2A   DIM(20)
003900100128
004000100128     D WIPLN           s             80A   INZ
004100100128     D WAPLN           s              4A   DIM(20)
004200090917
004300021106      * File DS
004400090715     D WIDTA         E DS                  EXTNAME(TRNSUMP)
004500091223     D WIFIX         E DS                  EXTNAME(TRNFXCP)
004600091223     D WIFLG         E DS                  EXTNAME(DW311FLG)
004700081120
004800081121      * File DS
004900081121     D DBFD          E DS                  EXTNAME(IODBFD)
005000081121
005100021106      * Program status data structure
005200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
005300081120
005400081120     C     *ENTRY        PLIST
005500081121     C                   PARM                    WIOPT             8
005600090715     C                   PARM                    WIDTA
005700091223     C                   PARM                    WIFIX
005800091223     C                   PARM                    WIRTN
005900081120
006000090917     C                   Movel     SMUSER        WWUSER           10
006100090917     C                   Eval      ORGFLG = SMFLAG
006200090804
006300081121      * Process Option
006400081121     C                   Select
006500081121     C                   When      WIOPT = 'HOLD'
006600081121     C                   Exsr      ProcessHOLD
006700081121     C                   When      WIOPT = 'RELEASE'
006800081121     C                   Exsr      ProcessREL
006900081121     C                   When      WIOPT = 'EXCLUDE'
007000081121     C                   Exsr      ProcessEXC
007100081121     C                   When      WIOPT = 'FIX'
007200081121     C                   Exsr      ProcessFIX
007300081121     C                   When      WIOPT = 'RELALL'
007400081121     C                   Exsr      ProcessALL
007500100604     C                   When      WIOPT = 'SUPER'
007600100604     C                   Exsr      ProcessSUP
007700081121     C                   Endsl
007800081120
007900100128     C                   Return
008000000000      *___________________________________________________________________
008100081121      * Process HOLD
008200000000      *___________________________________________________________________
008300081121     C     ProcessHOLD   BEGSR
008400081120      *
008500081121     C     SMSSNO        Setll     DW310JF2
008600081121     C     SMSSNO        Reade     DW310JF2
008700081121     C                   Dow       not %eof(DW310JF2)
008800090917      *
008900090917      * Only Allow original DONOTSENDS to change DONOTSENDS
009000090917     C                   Select
009100090917     C                   When      ORGFLG = 'D'
009200090917     C                   Eval      ALLOW  = 'Y'
009300090917     C                   When      ORGFLG <> 'D' and
009400090917     C                             QQFLAG <> 'D'
009500090917     C                   Eval      ALLOW  = 'Y'
009600090917     C                   When      ORGFLG <> 'D' and
009700090917     C                             QQFLAG =  'D'
009800090917     C                   Eval      ALLOW  = 'N'
009900090917     C                   Endsl
010000081120      *
010100090917     C                   If        ALLOW = 'Y'
010200081121     C     WQRELR        Chain     TRNMIT
010300081121     C                   If        %found(TRNMIT)
010400081203     C                   Eval      QQFLAG = 'H'
010500081203     C                   Eval      QQRVWR = %trim(WQUSRN)
010600081121     C                   Update    TRNUPD
010700090917     C                   End
010800081121     C                   End
010900081120      *
011000081121     C     SMSSNO        Reade     DW310JF2
011100081120     C                   Enddo
011200081121      *
011300090115     C     SMKEY         KLIST
011400090115     C                   KFLD                    SMSSNO
011500090115     C                   KFLD                    SMFLAG
011600090115      *
011700090115     C     SMKEY         Chain     TRNSUMP
011800081121     C                   If        %found(TRNSUMP)
011900081121     C                   Eval      SMFLAG = 'H'
012000081204     C                   Eval      SMRVWR = %trim(WQUSRN)
012100081121     C                   Update    TRNSUMR
012200081121     C                   End
012300160208      *
012400160208      * Check TSA for zeros
012500160208     C                   exsr      CHKTSA
012600160208      *
012700091209      * Create History Note
012800091209     C                   If        ORGFLG = 'D' and
012900091209     C                             ALLOW = 'Y'
013000091209     C                   Eval      H_CK#NOT = 'DO NOT SEND - CHANGED'
013100091209     C                   Eval      H_NOTE2 = 'BACK TO HOLD'
013200091209     C                   MOVE      SMSSNO        H_HKEY
013300091209     C                   Eval      H_TRCODE = 'U61'
013400091209     C                   Eval      H_HPRGNM = 'PRCAAT'
013500091209     C                   Eval      H_HSTRST = TRUST
013600091209     C                   Eval      H_HSSUB# = SUBNO
013700091209     C                   Eval      H_HSACCT = ACCNO
013800091209     C                   Eval      H_HSDLTD = 'A'
013900091209     C     *Date         Mult      10000.0001    H_TRDATE
014000091209     C     *Date         Mult      10000.0001    H_COVTDT
014100131014     C                   Eval      H_HOPER = WQUSRN
014200131010     c                   eval      h_hstrtime = %time
014300091209     C                   WRITE     HISTR
014400100628     C                   Exsr      RMVDNS
014500091209     C                   End
014600021024      *
014700000000     C                   ENDSR
014800081121      *___________________________________________________________________
014900081121      * Process RELEASE
015000081121      *___________________________________________________________________
015100081121     C     ProcessREL    BEGSR
015200100126      *
015300100126     C     KEYACC        Klist
015400100126     C                   Kfld                    MBTRST
015500100126     C                   Kfld                    MBSUB#
015600100126     C                   Kfld                    MBACCT
015700100126
015800100126      * Only set flags if 834 account
015900100421     C     WQUSRN        Chain     WRKFLGP
016000100421     C                   If        %found(WRKFLGP)
016100100126     C     SMSSNO        Chain     MEMBER
016200100126     C                   If        %found(MEMBER)
016300100126     C     KEYACC        Chain     ACCMST
016400100126     C                   If        %found(ACCMST)
016500100126     C                   If        CFS834 = 'Y'
016600100128      *
016700100128      * Fill Dependent Array
016800100128     C                   Exsr      FILLDEP
016900100126      *
017000091223      * Create 834 Flag Records
017100091223     C                   Move      SMSSNO        FLGSSN
017200091223     C                   Call      'DW311FLGC'
017300100128     C                   Parm                    FLGSSN
017400100128     C                   Parm                    WIDEP
017500100128     C                   Parm                    WIPLN
017600100419      *
017700100419      * Update 834 Flag Records
017800100419     C                   Move      SMSSNO        FLGSSN
017900100419     C                   Move      *Blanks       FLGSEQ
018000100419     C                   Call      'DW311FLGUC'
018100100419     C                   Parm                    FLGSSN
018200100419     C                   Parm                    FLGSEQ
018300091223      *
018400091223      * Update 834 Flag Records
018500091223     C                   Eval      DFSSN = SMSSNO
018600091223     C                   Eval      DFSEQ = 00
018700100604     C                   Call      'WRKFLGCL'
018800091223     C                   Parm                    WIFLG
018900100419     C                   Parm                    WIRTN            10
019000100126      *
019100100126     C                   Else
019200100126     C                   Eval      WIRTN = *BLANKS
019300100126     C                   End
019400100126     C                   End
019500100421     C                   End
019600100126     C                   End
019700091223      *
019800091223     C                   If        WIRTN = *BLANKS
019900081121      *
020000081121     C     SMSSNO        Setll     DW310JF2
020100081121     C     SMSSNO        Reade     DW310JF2
020200081121     C                   Dow       not %eof(DW310JF2)
020300090917      *
020400090917      * Only Allow original DONOTSENDS to change DONOTSENDS
020500090917     C                   Select
020600090917     C                   When      ORGFLG = 'D'
020700090917     C                   Eval      ALLOW  = 'Y'
020800090917     C                   When      ORGFLG <> 'D' and
020900090917     C                             QQFLAG <> 'D'
021000090917     C                   Eval      ALLOW  = 'Y'
021100090917     C                   When      ORGFLG <> 'D' and
021200090917     C                             QQFLAG =  'D'
021300090917     C                   Eval      ALLOW  = 'N'
021400090917     C                   Endsl
021500090917      *
021600090917     C                   If        ALLOW = 'Y'
021700081121     C     WQRELR        Chain     TRNMIT
021800081121     C                   If        %found(TRNMIT)
021900081121     C                   Eval      QQFLAG = 'R'
022000081203     C                   Eval      QQRVWR = %trim(WQUSRN)
022100081121     C                   Update    TRNUPD
022200090917     C                   End
022300081121     C                   End
022400081121      *
022500081121     C     SMSSNO        Reade     DW310JF2
022600081121     C                   Enddo
022700081121      *
022800090115     C     SMKEY         Chain     TRNSUMP
022900081121     C                   If        %found(TRNSUMP)
023000081121     C                   Eval      SMFLAG = 'R'
023100081204     C                   Eval      SMRVWR = %trim(WQUSRN)
023200081121     C                   Update    TRNSUMR
023300081121     C                   End
023400160208      *
023500160208      * Check TSA for zeros
023600160208     C                   exsr      CHKTSA
023700160208      *
023800081121      *
023900091209      * Create History Note
024000091209     C                   If        ORGFLG = 'D' and
024100091209     C                             ALLOW = 'Y'
024200091209     C                   Eval      H_CK#NOT = 'DO NOT SEND - CHANGED'
024300091209     C                   Eval      H_NOTE2 = 'BACK TO RELEASE'
024400091209     C                   MOVE      SMSSNO        H_HKEY
024500091209     C                   Eval      H_TRCODE = 'U61'
024600091209     C                   Eval      H_HOPER = %trim(WQUSRN)
024700091209     C                   Eval      H_HPRGNM = 'PRCAAT'
024800091209     C                   Eval      H_HSTRST = TRUST
024900091209     C                   Eval      H_HSSUB# = SUBNO
025000091209     C                   Eval      H_HSACCT = ACCNO
025100091209     C                   Eval      H_HSDLTD = 'A'
025200091209     C     *Date         Mult      10000.0001    H_TRDATE
025300091209     C     *Date         Mult      10000.0001    H_COVTDT
025400131010     c                   eval      h_hstrtime = %time
025500091209     C                   WRITE     HISTR
025600100628     C                   Exsr      RMVDNS
025700091209     C                   End
025800091223      *
025900091223      * else cancelled
026000091223     C                   Else
026100091223     C                   End
026200091223      *
026300081121     C                   ENDSR
026400100604      *___________________________________________________________________
026500100604      * Process SUPER USER
026600100604      *___________________________________________________________________
026700100604     C     ProcessSUP    BEGSR
026800100604
026900100604      * Only set flags if 834 account
027000100604     C     WQUSRN        Chain     WRKFLGP
027100100604     C                   If        %found(WRKFLGP)
027200100604     C     SMSSNO        Chain     MEMBER
027300100604     C                   If        %found(MEMBER)
027400100604     C     KEYACC        Chain     ACCMST
027500100604     C                   If        %found(ACCMST)
027600100604     C                   If        CFS834 = 'Y'
027700100604      *
027800100604      * Fill Dependent Array
027900100604     C                   Exsr      FILLDEP
028000100604      *
028100100604      * Update 834 Flag Records
028200100604     C                   Eval      DFSSN = SMSSNO
028300100604     C                   Eval      DFSEQ = 00
028400100604     C                   Call      'WRKFLGSUCL'
028500100604     C                   Parm                    WIFLG
028600100604     C                   Parm                    WIRTN            10
028700100604      *
028800100604     C                   Else
028900100604     C                   Eval      WIRTN = *BLANKS
029000100604     C                   End
029100100604     C                   End
029200100604     C                   End
029300100604     C                   End
029400100604      *
029500100604     C                   If        WIRTN = *BLANKS
029600100604      *
029700100604     C     SMSSNO        Setll     DW310JF2
029800100604     C     SMSSNO        Reade     DW310JF2
029900100604     C                   Dow       not %eof(DW310JF2)
030000100604      *
030100100604      * Only Allow original DONOTSENDS to change DONOTSENDS
030200100604     C                   Select
030300100604     C                   When      ORGFLG = 'D'
030400100604     C                   Eval      ALLOW  = 'Y'
030500100604     C                   When      ORGFLG <> 'D' and
030600100604     C                             QQFLAG <> 'D'
030700100604     C                   Eval      ALLOW  = 'Y'
030800100604     C                   When      ORGFLG <> 'D' and
030900100604     C                             QQFLAG =  'D'
031000100604     C                   Eval      ALLOW  = 'N'
031100100604     C                   Endsl
031200100604      *
031300100604     C                   If        ALLOW = 'Y'
031400100604     C     WQRELR        Chain     TRNMIT
031500100604     C                   If        %found(TRNMIT)
031600100604     C                   Eval      QQFLAG = 'R'
031700100604     C                   Eval      QQRVWR = %trim(WQUSRN)
031800100604     C                   Update    TRNUPD
031900100604     C                   End
032000100604     C                   End
032100100604      *
032200100604     C     SMSSNO        Reade     DW310JF2
032300100604     C                   Enddo
032400100604      *
032500100604     C     SMKEY         Chain     TRNSUMP
032600100604     C                   If        %found(TRNSUMP)
032700100604     C                   Eval      SMFLAG = 'R'
032800100604     C                   Eval      SMRVWR = %trim(WQUSRN)
032900100604     C                   Update    TRNSUMR
033000100604     C                   End
033100160208      *
033200160208      * Check TSA for zeros
033300160208     C                   exsr      CHKTSA
033400160208      *
033500100604      *
033600100604      * Create History Note
033700100604     C                   If        ORGFLG = 'D' and
033800100604     C                             ALLOW = 'Y'
033900100604     C                   Eval      H_CK#NOT = 'DO NOT SEND - CHANGED'
034000100604     C                   Eval      H_NOTE2 = 'BACK TO RELEASE'
034100100604     C                   MOVE      SMSSNO        H_HKEY
034200100604     C                   Eval      H_TRCODE = 'U61'
034300100604     C                   Eval      H_HOPER = %trim(WQUSRN)
034400100604     C                   Eval      H_HPRGNM = 'PRCAAT'
034500100604     C                   Eval      H_HSTRST = TRUST
034600100604     C                   Eval      H_HSSUB# = SUBNO
034700100604     C                   Eval      H_HSACCT = ACCNO
034800100604     C                   Eval      H_HSDLTD = 'A'
034900100604     C     *Date         Mult      10000.0001    H_TRDATE
035000100604     C     *Date         Mult      10000.0001    H_COVTDT
035100131010     c                   eval      h_hstrtime = %time
035200100604     C                   WRITE     HISTR
035300100628     C                   Exsr      RMVDNS
035400100604     C                   End
035500100604      *
035600100604      * else cancelled
035700100604     C                   Else
035800100604     C                   End
035900100604      *
036000100604     C                   ENDSR
036100081121      *___________________________________________________________________
036200081121      * Process EXCLUDE
036300081121      *___________________________________________________________________
036400081121     C     ProcessEXC    BEGSR
036500081121      *
036600081121     C     SMSSNO        Setll     DW310JF2
036700081121     C     SMSSNO        Reade     DW310JF2
036800081121     C                   Dow       not %eof(DW310JF2)
036900081121      *
037000081121     C     WQRELR        Chain     TRNMIT
037100081121     C                   If        %found(TRNMIT)
037200081121     C                   Eval      QQFLAG = 'D'
037300081203     C                   Eval      QQRVWR = %trim(WQUSRN)
037400081121     C                   Update    TRNUPD
037500081121     C                   End
037600081121      *
037700081121     C     SMSSNO        Reade     DW310JF2
037800081121     C                   Enddo
037900090115      *
038000090115     C     SMKEY         Chain     TRNSUMP
038100081121     C                   If        %found(TRNSUMP)
038200081121     C                   Eval      SMFLAG = 'D'
038300081204     C                   Eval      SMRVWR = %trim(WQUSRN)
038400081121     C                   Update    TRNSUMR
038500081121     C                   End
038600100628
038700100628      * Close Form Tracking record
038800100628     C                   Eval      FTUNIQUE = *HIVAL
038900100628     C     TRKKEY        Setgt     FRMTRKL6
039000100628     C     SMSSNO        Readpe    FRMTRKL6
039100100628     C                   Dow       not %eof(FRMTRKL6)
039200100628     C                   If        %trim(FTCLSUSR) = *Blanks
039300100628     C                   Eval      Today = %int(%char(%date : *iso0))
039400100628     C                   Move      Today         FTCLSDT
039500100628     C                   Eval      FTCLSUSR = %trim(WQUSRN)
039600100628     C                   Eval      FTCLSCOD = 'DNS'
039700100628     C                   Time                    FTCLSTM
039800100628     C                   Update    FRMTRKR
039900100628     C                   End
040000100628     C                   Leave
040100100628     C                   Enddo
040200160208      *
040300160208      * Check TSA for zeros
040400160208     C                   exsr      CHKTSA
040500160208      *
040600091207
040700091207      * Create History Note
040800091207     C                   Eval      H_CK#NOT = 'DO NOT SEND'
040900091207     C                   MOVE      SMSSNO        H_HKEY
041000091207     C                   Eval      H_TRCODE = 'U61'
041100091207     C                   Eval      H_HOPER = %trim(WQUSRN)
041200091207     C                   Eval      H_HPRGNM = 'PRCAAT'
041300091207     C                   Eval      H_HSTRST = TRUST
041400091207     C                   Eval      H_HSSUB# = SUBNO
041500091207     C                   Eval      H_HSACCT = ACCNO
041600091207     C                   Eval      H_HSDLTD = 'A'
041700091207     C     *Date         Mult      10000.0001    H_TRDATE
041800091207     C     *Date         Mult      10000.0001    H_COVTDT
041900131010     c                   eval      h_hstrtime = %time
042000091207     C                   WRITE     HISTR
042100091207      *
042200081121     C                   ENDSR
042300081121      *___________________________________________________________________
042400081121      * Process FIX
042500081121      *___________________________________________________________________
042600081121     C     ProcessFIX    BEGSR
042700100512      *
042800100512      * Only set flags if 834 account
042900100512     C     WQUSRN        Chain     WRKFLGP
043000100512     C                   If        %found(WRKFLGP)
043100100512     C     SMSSNO        Chain     MEMBER
043200100512     C                   If        %found(MEMBER)
043300100512     C     KEYACC        Chain     ACCMST
043400100512     C                   If        %found(ACCMST)
043500100512     C                   If        CFS834 = 'Y'
043600100128      *
043700100128      * Fill Dependent Array
043800100128     C                   Exsr      FILLDEP
043900091223      *
044000091223      * Create 834 Flag Records
044100091223     C                   Move      SMSSNO        FLGSSN
044200091223     C                   Call      'DW311FLGC'
044300100128     C                   Parm                    FLGSSN
044400100128     C                   Parm                    WIDEP
044500100128     C                   Parm                    WIPLN
044600100419      *
044700100419      * Update 834 Flag Records
044800100419     C                   Move      SMSSNO        FLGSSN
044900100419     C                   Move      *Blanks       FLGSEQ
045000100419     C                   Call      'DW311FLGUC'
045100100419     C                   Parm                    FLGSSN
045200100419     C                   Parm                    FLGSEQ
045300091223      *
045400091223      * Update 834 Flag Records
045500091223     C                   Eval      DFSSN = SMSSNO
045600091223     C                   Eval      DFSEQ = 00
045700100604     C                   Call      'WRKFLGCL'
045800091223     C                   Parm                    WIFLG
045900091223     C                   Parm                    WIRTN            10
046000100512      *
046100100512     C                   Else
046200100512     C                   Eval      WIRTN = *BLANKS
046300100512     C                   End
046400100512     C                   End
046500100512     C                   End
046600100512     C                   End
046700091223      *
046800091223     C                   If        WIRTN = *BLANKS
046900081121      *
047000081121     C     SMSSNO        Setll     DW310JF2
047100081121     C     SMSSNO        Reade     DW310JF2
047200081121     C                   Dow       not %eof(DW310JF2)
047300081121      *
047400090917      * Only Allow original DONOTSENDS to change DONOTSENDS
047500090917     C                   Select
047600090917     C                   When      ORGFLG = 'D'
047700090917     C                   Eval      ALLOW  = 'Y'
047800090917     C                   When      ORGFLG <> 'D' and
047900090917     C                             QQFLAG <> 'D'
048000090917     C                   Eval      ALLOW  = 'Y'
048100090917     C                   When      ORGFLG <> 'D' and
048200090917     C                             QQFLAG =  'D'
048300090917     C                   Eval      ALLOW  = 'N'
048400090917     C                   Endsl
048500090917      *
048600090917     C                   If        ALLOW = 'Y'
048700081121     C     WQRELR        Chain     TRNMIT
048800081121     C                   If        %found(TRNMIT)
048900090910     C                   Eval      QQFLAG = 'R'
049000090716     C                   Eval      QQFIXF = FCCODE
049100081203     C                   Eval      QQRVWR = %trim(WQUSRN)
049200081121     C                   Update    TRNUPD
049300090917     C                   End
049400081121     C                   End
049500081121      *
049600081121     C     SMSSNO        Reade     DW310JF2
049700081121     C                   Enddo
049800081121      *
049900090115     C     SMKEY         Chain     TRNSUMP
050000081121     C                   If        %found(TRNSUMP)
050100090910     C                   Eval      SMFLAG = 'R'
050200081121     C                   Eval      SMFIXF = 'Y'
050300090716     C     FCCODE        Chain     TRNFXCP
050400090716     C                   If        %found(TRNFXCP)
050500090716     C                   Eval      SMFIXR = %trim(FCREAS)
050600090716     C                   Else
050700090716     C                   Eval      SMFIXR = *Blanks
050800090716     C                   End
050900081204     C                   Eval      SMRVWR = %trim(WQUSRN)
051000081121     C                   Update    TRNSUMR
051100081121     C                   End
051200160208      *
051300160208      * Check TSA for zeros
051400160208     C                   exsr      CHKTSA
051500160208      *
051600091209      *
051700091209      * Create History Note
051800091209     C                   If        ORGFLG = 'D' and
051900091209     C                             ALLOW = 'Y'
052000091209     C                   Eval      H_CK#NOT = 'DO NOT SEND - CHANGED'
052100091209     C                   Eval      H_NOTE2 = 'BACK TO RELEASE'
052200091209     C                   MOVE      SMSSNO        H_HKEY
052300091209     C                   Eval      H_TRCODE = 'U61'
052400091209     C                   Eval      H_HOPER = %trim(WQUSRN)
052500091209     C                   Eval      H_HPRGNM = 'PRCAAT'
052600091209     C                   Eval      H_HSTRST = TRUST
052700091209     C                   Eval      H_HSSUB# = SUBNO
052800091209     C                   Eval      H_HSACCT = ACCNO
052900091209     C                   Eval      H_HSDLTD = 'A'
053000091209     C     *Date         Mult      10000.0001    H_TRDATE
053100091209     C     *Date         Mult      10000.0001    H_COVTDT
053200131010     c                   eval      h_hstrtime = %time
053300091209     C                   WRITE     HISTR
053400100628     C                   Exsr      RMVDNS
053500091223     C                   End
053600091209     C                   End
053700081121      *
053800081121     C                   ENDSR
053900081121      *___________________________________________________________________
054000081121      * Process RELEASE ALL
054100081121      *___________________________________________________________________
054200081121     C     ProcessALL    BEGSR
054300081121      *
054400081121     C                   Eval      SMSSNO = 0
054500081121     C     SMSSNO        Setll     DW310JF2
054600081121     C                   Read      DW310JF2
054700081121     C                   Dow       not %eof(DW310JF2)
054800081121      *
054900081121     C     WQRELR        Chain     TRNMIT
055000081202     C                   If        %found(TRNMIT)
055100090804     C                   If        %trim(QQUSER) = %trim(WWUSER)
055200081202     C                   If        %trim(QQFLAG) = 'H'
055300081121     C                   Eval      QQFLAG = 'R'
055400081203     C                   Eval      QQRVWR = %trim(WQUSRN)
055500081121     C                   Update    TRNUPD
055600081121     C                   End
055700090804     C                   End
055800081121     C                   End
055900081121      *
056000081121     C                   Read      DW310JF2
056100081121     C                   Enddo
056200081121      *
056300081121     C     SMSSNO        Setll     TRNSUMP
056400081121     C                   Read      TRNSUMP
056500081121     C                   Dow       not %eof(TRNSUMP)
056600090804     C                   If        %trim(SMUSER) = %trim(WWUSER)
056700081202     C                   If        %trim(SMFLAG) = 'H'
056800081121     C                   Eval      SMFLAG = 'R'
056900081204     C                   Eval      SMRVWR = %trim(WQUSRN)
057000081121     C                   Update    TRNSUMR
057100090804     C                   End
057200081202     C                   End
057300081121     C                   Read      TRNSUMP
057400081121     C                   Enddo
057500081121      *
057600081121     C                   ENDSR
057700100128      *___________________________________________________________________
057800100128      * Fill Dependent Array
057900100128      *___________________________________________________________________
058000100128     C     FILLDEP       BEGSR
058100100128      *
058200100128     C                   Eval      nxt = 0
058300100128     C                   Eval      pxt = 0
058400100128      *
058500100128     C     SMSSNO        Setll     DW310JF2
058600100128     C     SMSSNO        Reade     DW310JF2
058700100128     C                   Dow       not %eof(DW310JF2)
058800100128      *
058900100128      * Dependent Seq
059000100128     C                   Eval      pos = %lookup(DEPSEQ:WADEP)
059100100128     C                   If        pos = 0
059200100128     C                   Eval      nxt = nxt + 1
059300100128     C                   Eval      WADEP(nxt) = DEPSEQ
059400100128     C                   End
059500100128      *
059600100128      * Plan
059700100128     C                   Eval      pos = %lookup(PLAN#:WAPLN)
059800100128     C                   If        pos = 0
059900100128     C                   Eval      pxt = pxt + 1
060000100128     C                   Eval      WAPLN(pxt) = PLAN#
060100100128     C                   End
060200100128      *
060300100128     C     SMSSNO        Reade     DW310JF2
060400100128     C                   Enddo
060500100128      *
060600100128     C                   Movea     WADEP         WIDEP
060700100128     C                   Movea     WAPLN         WIPLN
060800100128      *
060900100128     C                   ENDSR
061000160208      *___________________________________________________________________
061100160208      * double check TSA
061200160208      *___________________________________________________________________
061300160208     C     CHKTSA        BEGSR
061400160208     C                   If        TRUST = 0
061500160208     C     SMSSNO        Chain     MEMBER
061600160208     C                   If        %found(MEMBER)
061700160208     C                   eval      TRUST = MBTRST
061800160208     C                   eval      SUBNO = MBSUB#
061900160208     C                   eval      ACCNO = MBACCT
062000160208     C                   End
062100160208     C                   End
062200160208     C                   ENDSR
062300100628      *___________________________________________________________________
062400100628      * Remove DNS from Tracking Record
062500100628      *___________________________________________________________________
062600100628     C     RMVDNS        BEGSR
062700100628      *
062800100628     C     TRKKEY        Klist
062900100628     C                   Kfld                    SMSSNO
063000100628     C                   Kfld                    FTUNIQUE
063100100628     C                   Eval      FTUNIQUE = *HIVAL
063200100628      *
063300100628     C     TRKKEY        Setgt     FRMTRKL6
063400100628     C     SMSSNO        Readpe    FRMTRKL6
063500100628     C                   Dow       not %eof(FRMTRKL6)
063600100628     C                   If        %trim(FTCLSCOD) = 'DNS'
063700100628     C                   Clear                   FTCLSDT
063800100628     C                   Clear                   FTCLSUSR
063900100628     C                   Clear                   FTCLSCOD
064000100628     C                   Clear                   FTCLSTM
064100100628     C                   Update    FRMTRKR
064200100628     C                   End
064300100628     C                   Leave
064400100628     C                   Enddo
064500100628     C                   ENDSR
