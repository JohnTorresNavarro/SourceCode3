000100140107     Hoption(*nodebugio) debug dftactgrp(*no) actgrp(*caller)
000200140625     Hbnddir('ALLSRVPGMN')
000300140107
000400000000      *_________________________________________________________________________
000500000000      *
000600100419      *  Description:  Up-date Flags with best guess
000700000000      *
000800100419      *  (c)Copyright 2010 by GBS, Inc.
000900000000      *
001000000000      *    Created by:  JALLEN - April 19, 2010
001100140107      *
001200140107      *   01-07-2014  JVA  check for ACA Plan
001300000000      *_________________________________________________________________________
001400100419     FDW311FLGLFUF   E           K DISK
001500100423     FTRNMITL4  UF A E           K DISK
001600111115     FWEBTRNMIT IF   E           K DISK
001700100419     FPLNMST    IF   E           K DISK
001800100422     FDEPEND    IF   E           K DISK
001900100422     FDEPNDC    IF   E           K DISK    RENAME(DEPENR:DEPDT)
002000100422     FDCOVC     IF   E           K DISK
002100100422     FHIST      IF   E           K DISK
002200100422     FCLASS     IF   E           K DISK
002300100420     FDW311FLGLHUF A E           K DISK
002400140107
002500140107      /define copy_all_protos_and_fields
002600140107      /copy qcpysrc,hcrsrvpgmp
002700140107      /undefine copy_all_protos_and_fields
002800140107
0029001401070152 D                 DS
0030001401070153 D  pkey                   1     15
0031001401070154 D  Ptrust                 1      3  0
0032001401070154 D  Psub                   4      6  0
0033001401070154 D  Pplan                  7     10
0034001401070155 D  pab                   11     12  0
0035001401070156 D  pct                   13     15
003600140107
003700140107     D prem_aca        s              7  2
003800140107     D prem_count      s              3  0
003900140107     D idx             s              2  0
004000140107     D pssn            s              9  0
004100100419
004200100419     D x               s              2S 0 inz
004300100420     D pos             s              2S 0 inz
004400100420     D pos1            s              2S 0 inz
004500100420     D pos2            s              2S 0 inz
004600100608     D cod             s              3S 0 inz
004700100419     D cdc             s              2S 0 inz
004800100419     D wflg            s              1A   inz
004900100419     D wwseq           s              2A   inz
005000100422     D NEWADD          s              1A   inz
005100100419     D OLDFLD          s              1A   inz
005200100521     D MBRFLG          s              1A   inz
005300100521     D GRPCHG          s              1A   inz
005400100420     D MBRM            s              1A   inz
005500100420     D MBRR            s              1A   inz
005600100420     D MBRV            s              1A   inz
005700100423     D MBRD            s              1A   inz
005800140625     D CRTDT           s              1A   inz
005900140625     D IS_ACA          s              1A   inz
006000100420
006100111116     D S_TRS           S              3S 0
006200111116     D S_SUB           S              3S 0
006300111116     D S_ACC           S              4S 0
006400111116     D S_SSN           S              9S 0
006500111116     D S_SEQ           S              2S 0
006600111116
006700100420     D W_SSN           S             10A
006800100420     D W_EFF           S              8S 0
006900100420     D W_FLG           S              1A
007000100420     D W_FAC           S             10A
007100100420     D W_TAC           S             10A
007200100419
007300100419     D W_CODES         DS                  OCCURS(4)
007400100608     D ACOD                    1    100A   DIM(50)
007500100420
007600100420     D W_GROUP         DS                  OCCURS(4)
007700100608     D AGRP                    1    200A   DIM(50)
007800100421
007900100422     D W_CLASS         DS                  OCCURS(4)
008000100608     D ACLS                    1    200A   DIM(50)
008100100422
008200100514     D W_COVTY         DS                  OCCURS(4)
008300100608     D ATYP                    1    150A   DIM(50)
008400100514
008500100421     D W_PLANS         DS                  OCCURS(4)
008600100608     D APLN                    1    200A   DIM(50)
008700140107
008800140107     D W_ACA           DS                  OCCURS(4)
008900140107     D AACA                    1     50A   DIM(50)
009000100420
009100100420     D W_EFFDT         DS                  OCCURS(4)
009200100608     D AEFF                    1    400S 0 DIM(50)
009300100421
009400100421     D W_TRMDT         DS                  OCCURS(4)
009500100608     D ATRM                    1    400S 0 DIM(50)
009600100422
009700100422     D W_SDT           DS                  OCCURS(4)
009800100608     D ASDT                    1     50A   DIM(50)
009900100420    ?
010000100420    ? * Program status data structure
010100100420    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
010200100419
010300100419     C     *ENTRY        PLIST
010400100419     C                   Parm                    WISSN             9
010500100419     C                   Parm                    WISEQ             2
010600100419
010700100419     C                   Move      WISSN         DFSSN
010800100419     C                   Move      WISEQ         DFSEQ
010900100521     C                   Eval      GRPCHG = *BLANKS
011000100419     C                   Eval      MBRFLG = *BLANKS
011100100420     C                   Eval      MBRM   = *BLANKS
011200100420     C                   Eval      MBRR   = *BLANKS
011300100420     C                   Eval      MBRV   = *BLANKS
011400100420     C                   Eval      MBRD   = *BLANKS
011500100422     C                   Eval      NEWADD = *BLANKS
011600100423     C                   Eval      OLDFLD = *BLANKS
011700100423     C                   Eval      CRTDT  = *BLANKS
011800100419
011900100419     C     FLGKEY        Chain     DW311FLGLF
012000100419     C                   If        %found(DW311FLGLF)
012100100420     C                   If        DFLG = 'Y'
012200100419     C                   EXSR      PROCESS
012300100420     C                   End
012400100419     C                   End
012500100419
012600100419      * Dependents
012700100419     C     DFSSN         Setll     DEPEND
012800100419     C     DFSSN         Reade     DEPEND
012900100419     C                   Dow       not %eof(DEPEND)
013000100419     C                   Eval      DFSEQ = DPSEQ#
013100100422     C                   Eval      NEWADD = *BLANKS
013200100419     C                   Eval      OLDFLD = *BLANKS
013300100419     C     FLGKEY        Chain     DW311FLGLF
013400100419     C                   If        %found(DW311FLGLF)
013500100420     C                   If        DFLG = 'Y'
013600100419     C                   EXSR      PROCESS
013700100420     C                   End
013800100419     C                   End
013900100419     C     DFSSN         Reade     DEPEND
014000100419     C                   Enddo
014100100419
014200100423      * Clean up Temp DT records
014300100423     C                   If        CRTDT = 'Y'
014400100504     C                   EXSR      REMOVETEMP
014500100423     C                   End
014600100423
014700100420     C                   Eval      *INLR = *ON
014800100419     C                   Return
014900100419      *- ------------------------------------------------------------------*
015000100419     C     PROCESS       BEGSR
015100100419      *--------------------------------------------------------------------*
015200100423     C                   Exsr      RESETARRAYS
015300100419
015400100419     C                   If        DFSEQ = *zeros
015500100419     C                   Move      *Blanks       WWSEQ
015600100419     C                   Else
015700100419     C                   Move      DFSEQ         WWSEQ
015800100419     C                   End
015900111116
016000111116     C                   Eval      S_TRS = 0
016100111116     C                   Eval      S_SUB = 0
016200111116     C                   Eval      S_ACC = 0
016300111116     C                   Eval      S_SSN = 0
016400111116     C                   Eval      S_SEQ = 0
016500100419
016600100422     C                   Eval      cod    = *Zeros
016700100419     C     TRNKEY        Setll     TRNMITL4
016800100419     C     TRNKEY        Reade     TRNMITL4
016900100419     C                   Dow       not %eof(TRNMITL4)
017000111116     C                   Eval      S_TRS = TRUST
017100111116     C                   Eval      S_SUB = SUBNO
017200111116     C                   Eval      S_ACC = ACCNO
017300111116     C                   Eval      S_SSN = SOCSOC
017400111116     C     ' ':'0'       xlate     DEPSEQ        DEPSEQ
017500111116     C                   Move      DEPSEQ        S_SEQ
017600100419     C                   Exsr      CHECKPLAN
017700100419     C     TRNKEY        Reade     TRNMITL4
017800100419     C                   Enddo
017900100419     C                   Exsr      SETFLAGS
018000100419
018100100419     C                   ENDSR
018200100419      *--------------------------------------------------------------------*
018300100419     C     CHECKPLAN     BEGSR
018400100419
018500100419     C     PLNKEY        Chain     PLNMST
018600100419     C                   If        %found(PLNMST)
018700100419
018800100419     C                   Select
018900121023     C                   When      PLNCAT = 'PMM' or
019000121023     C                             PLNCAT = 'PCM'
019100100419     C                   Eval      x = 1
019200100420     C     X             occur     W_CODES
019300100422     C     X             occur     W_GROUP
019400100514     C     X             occur     W_CLASS
019500100514     C     X             occur     W_COVTY
019600140107     C     X             occur     W_PLANS
019700140107     C     X             occur     W_ACA
019800100421     C     X             occur     W_EFFDT
019900100422     C     X             occur     W_TRMDT
020000100422     C     X             occur     W_SDT
020100100419     C                   Exsr      TRAPCODES
020200100419     C                   When      PLNCAT = 'PRX'
020300100419     C                   Eval      x = 2
020400100420     C     X             occur     W_CODES
020500100420     C     X             occur     W_GROUP
020600100514     C     X             occur     W_CLASS
020700100514     C     X             occur     W_COVTY
020800100421     C     X             occur     W_PLANS
020900100420     C     X             occur     W_EFFDT
021000100421     C     X             occur     W_TRMDT
021100100422     C     X             occur     W_SDT
021200100419     C                   Exsr      TRAPCODES
021300110922     C                   When      PLNCAT = 'PVR' or
021400130725     C                             PLNCAT = 'PVS' or
021500130725     C                             PLNCAT = 'PCV'
021600100419     C                   Eval      x = 3
021700100419     C     X             occur     W_CODES
021800100420     C     X             occur     W_GROUP
021900100514     C     X             occur     W_CLASS
022000100514     C     X             occur     W_COVTY
022100100421     C     X             occur     W_PLANS
022200100420     C     X             occur     W_EFFDT
022300100421     C     X             occur     W_TRMDT
022400100422     C     X             occur     W_SDT
022500100419     C                   Exsr      TRAPCODES
022600110922     C                   When      PLNCAT = 'PDR' or
022700140917     C                             PLNCAT = 'PDN' or
022800140917     C                             PLNCAT = 'PCD' or
022900130118     C                             PLNCAT = 'PDE'
023000100419     C                   Eval      x = 4
023100100419     C     X             occur     W_CODES
023200100420     C     X             occur     W_GROUP
023300100514     C     X             occur     W_CLASS
023400100514     C     X             occur     W_COVTY
023500100421     C     X             occur     W_PLANS
023600100420     C     X             occur     W_EFFDT
023700100421     C     X             occur     W_TRMDT
023800100422     C     X             occur     W_SDT
023900100419     C                   Exsr      TRAPCODES
024000100419     C                   Endsl
024100100419     C                   End
024200100419
024300100419     C                   ENDSR
024400100419      *--------------------------------------------------------------------*
024500100419     C     TRAPCODES     BEGSR
024600100419      *--------------------------------------------------------------------*
024700100419
024800100419      * If FM075 the always ADD MEMBER
024900100419     C                   If        %trim(TRNSRC) = 'FM075'
025000100419     C                   Eval      ACTCOD = 'MA'
025100100419     C                   End
025200100422
025300100422      * If MA with blanks, then first time add
025400100422     C                   If        ACTCOD =  'MA' and
025500100422     C                             OLNAME =  *BLANKS
025600100422     C                   Eval      NEWADD = 'Y'
025700100525     C                   Eval      ASDT(1) = ' '
025800100422     C                   End
025900100419
026000100419      * Pre-Codes change to ADD COVG - MEMBER
026100100419     C                   If        ACTCOD =  'MA' and
026200100422     C                             OLNAME <> *BLANKS
026300100419     C                   Eval      ACTCOD =  'AC'
026400100419     C                   Eval      OLDFLD = 'Y'
026500100604     C                   Eval      ASDT(1) = ' '
026600100419     C                   End
026700100419
026800100419      * TR050 Bug change to ADD COVG - MEMBER
026900100419     C                   If        ACTCOD =  'MA' and
027000100419     C                             %trim(TRNSRC) = 'TR050'
027100100419     C                   Eval      ACTCOD =  'AC'
027200100419     C                   Eval      OLDFLD = 'Y'
027300100419     C                   End
027400100422
027500100611      * If DA with blanks, then first time add
027600100422     C                   If        ACTCOD =  'DA' and
027700100422     C                             ODLNAM =  *BLANKS
027800100422     C                   Eval      NEWADD = 'Y'
027900100422     C                   End
028000100419
028100100419      * Pre-Codes change to ADD COVG - DEPENDENT
028200100419     C                   If        ACTCOD =  'DA' and
028300100422     C                             ODLNAM <> *BLANKS
028400100611     C                   Eval      ACTCOD =  'DC'
028500100419     C                   Eval      OLDFLD = 'Y'
028600100611     C                   Eval      ASDT(1) = ' '
028700100419     C                   End
028800100419
028900100419      * Pre-Codes change to CHG COVG - DEPENDENT
029000100419      * KMAN FM-70 change
029100100419     C                   If        ACTCOD =  'DT' and
029200100419     C                             %trim(OLDT93) = 'C'
029300100419     C                   Eval      ACTCOD =  'DC'
029400100419     C                   End
029500100419
029600100419      * TR050 Bug change to ADD COVG - DEPENDENT
029700100419     C                   If        ACTCOD =  'DA' and
029800100419     C                             %trim(TRNSRC) = 'TR050'
029900100419     C                   Eval      OLDFLD = 'Y'
030000100419     C                   Eval      ACTCOD =  'AC'
030100100419     C                   End
030200100419
030300100419      * Ignore MD Plan Info
030400100419     C                   If        ACTCOD =  'MD'  and
030500100419     C                             %trim(TRNSRC) <> 'TR050'
030600100419     C                   Eval      ACTCOD = *blanks
030700100419     C                   End
030800100419
030900100419      * Ignore DD Plan Info
031000100419     C                   If        ACTCOD =  'DD'  and
031100100419     C                             %trim(TRNSRC) <> 'TR050'
031200100419     C                   Eval      ACTCOD = *blanks
031300100419     C                   End
031400100419
031500100419      * Ignore PC Plan Info
031600100419     C                   If        ACTCOD =  'PC'
031700100419     C                   Eval      ACTCOD = *blanks
031800100419     C                   End
031900100421
032000100421      * Check for Same Day Terms - washout
032100100421     C                   If        %trim(ACTCOD) = 'MT' and
032200100421     C                             ENRLDT = CANCDT
032300100421     C                   Eval      pos = %lookup('AC':ACOD)
032400100421     C                   If        pos > 0
032500100421     C                   If        PLAN# = APLN(pos) and
032600100421     C                             CANCDT = AEFF(pos)
032700100421     C                   Eval      ACTCOD = *blanks
032800100421     C                   Eval      ACOD(pos) = *blanks
032900140107     C                   Eval      APLN(pos) = *blanks
033000140107     C                   Eval      AACA(pos) = *blanks
033100100421     C                   Eval      AGRP(pos) = *blanks
033200100421     C                   Eval      AEFF(pos) = *zeros
033300100422     C                   Eval      ATRM(pos) = *zeros
033400100514     C                   Eval      ACLS(pos) = *blanks
033500100514     C                   Eval      ATYP(pos) = *blanks
033600100422     C                   Eval      ASDT(1) = 'Y'
033700100607     C                   If        %trim(TRNSRC) = 'FM070' or
033800100607     C                             %trim(TRNSRC) = 'TR050'
033900100607     C                   Exsr      CreateDT
034000100607     C                   End
034100100421     C                   End
034200100421     C                   End
034300100421     C                   End
034400100422
034500100422      * Check for Same Day Terms - washout
034600100422     C                   If        %trim(ACTCOD) = 'MT' and
034700100422     C                             ENRLDT = CANCDT
034800100422     C                   Eval      pos = %lookup('MA':ACOD)
034900100422     C                   If        pos > 0
035000100422     C                   If        PLAN# = APLN(pos) and
035100100422     C                             CANCDT = AEFF(pos)
035200100422     C                   Eval      ACTCOD = *blanks
035300100422     C                   Eval      ACOD(pos) = *blanks
035400140107     C                   Eval      APLN(pos) = *blanks
035500140107     C                   Eval      AACA(pos) = *blanks
035600100422     C                   Eval      AGRP(pos) = *blanks
035700100422     C                   Eval      AEFF(pos) = *zeros
035800100422     C                   Eval      ATRM(pos) = *zeros
035900100514     C                   Eval      ACLS(pos) = *blanks
036000100514     C                   Eval      ATYP(pos) = *blanks
036100100422     C                   Eval      ASDT(1) = 'Y'
036200100607     C                   If        %trim(TRNSRC) = 'FM070' or
036300100607     C                             %trim(TRNSRC) = 'TR050'
036400100607     C                   Exsr      CreateDT
036500100607     C                   End
036600100422     C                   End
036700100422     C                   End
036800100422     C                   End
036900100423
037000100423      * Check for Same Day Terms - washout
037100100423     C                   If        %trim(ACTCOD) = 'MT' and
037200100423     C                             ENRLDT = CANCDT
037300100423     C                   Eval      pos = %lookup('MR':ACOD)
037400100423     C                   If        pos > 0
037500100423     C                   If        PLAN# = APLN(pos) and
037600100423     C                             CANCDT = AEFF(pos)
037700100423     C                   Eval      ACTCOD = *blanks
037800100423     C                   Eval      ACOD(pos) = *blanks
037900140107     C                   Eval      APLN(pos) = *blanks
038000140107     C                   Eval      AACA(pos) = *blanks
038100100423     C                   Eval      AGRP(pos) = *blanks
038200100423     C                   Eval      AEFF(pos) = *zeros
038300100423     C                   Eval      ATRM(pos) = *zeros
038400100514     C                   Eval      ACLS(pos) = *blanks
038500100514     C                   Eval      ATYP(pos) = *blanks
038600100423     C                   Eval      ASDT(1) = 'Y'
038700100607     C                   If        %trim(TRNSRC) = 'FM070' or
038800100607     C                             %trim(TRNSRC) = 'TR050'
038900100607     C                   Exsr      CreateDT
039000100607     C                   End
039100100423     C                   End
039200100423     C                   End
039300100423     C                   End
039400100421
039500100421      * Check for Same Day Terms - washout
039600100422     C                   If        %trim(ACTCOD) = 'DT' and
039700100422     C                             DENRLD = DCANDT
039800100421     C                   Eval      pos = %lookup('DC':ACOD)
039900100421     C                   If        pos > 0
040000100421     C                   If        PLAN# = APLN(pos) and
040100100421     C                             DCANDT = AEFF(pos)
040200100421     C                   Eval      ACTCOD = *blanks
040300100421     C                   Eval      ACOD(pos) = *blanks
040400140107     C                   Eval      APLN(pos) = *blanks
040500140107     C                   Eval      AACA(pos) = *blanks
040600100421     C                   Eval      AGRP(pos) = *blanks
040700100421     C                   Eval      AEFF(pos) = *zeros
040800100421     C                   Eval      ATRM(pos) = *zeros
040900100514     C                   Eval      ACLS(pos) = *blanks
041000100514     C                   Eval      ATYP(pos) = *blanks
041100100422     C                   Eval      ASDT(1) = 'Y'
041200100421     C                   End
041300100421     C                   End
041400100421     C                   End
041500100422
041600100422      * Check for Same Day Terms - washout
041700100422     C                   If        %trim(ACTCOD) = 'DT' and
041800100422     C                             DENRLD = DCANDT
041900100422     C                   Eval      pos = %lookup('DA':ACOD)
042000100422     C                   If        pos > 0
042100100422     C                   If        PLAN# = APLN(pos) and
042200100422     C                             DCANDT = AEFF(pos)
042300100422     C                   Eval      ACTCOD = *blanks
042400100422     C                   Eval      ACOD(pos) = *blanks
042500140107     C                   Eval      APLN(pos) = *blanks
042600140107     C                   Eval      AACA(pos) = *blanks
042700100422     C                   Eval      AGRP(pos) = *blanks
042800100422     C                   Eval      AEFF(pos) = *zeros
042900100422     C                   Eval      ATRM(pos) = *zeros
043000100514     C                   Eval      ACLS(pos) = *blanks
043100100514     C                   Eval      ATYP(pos) = *blanks
043200100422     C                   Eval      ASDT(1) = 'Y'
043300100422     C                   End
043400100422     C                   End
043500100422     C                   End
043600100423
043700100423      * Check for Same Day Terms - washout
043800100423     C                   If        %trim(ACTCOD) = 'DT' and
043900100423     C                             DENRLD = DCANDT
044000100423     C                   Eval      pos = %lookup('DR':ACOD)
044100100423     C                   If        pos > 0
044200100423     C                   If        PLAN# = APLN(pos) and
044300100423     C                             DCANDT = AEFF(pos)
044400100423     C                   Eval      ACTCOD = *blanks
044500100423     C                   Eval      ACOD(pos) = *blanks
044600140107     C                   Eval      APLN(pos) = *blanks
044700140107     C                   Eval      AACA(pos) = *blanks
044800100423     C                   Eval      AGRP(pos) = *blanks
044900100423     C                   Eval      AEFF(pos) = *zeros
045000100423     C                   Eval      ATRM(pos) = *zeros
045100100514     C                   Eval      ACLS(pos) = *blanks
045200100514     C                   Eval      ATYP(pos) = *blanks
045300100423     C                   Eval      ASDT(1) = 'Y'
045400100423     C                   End
045500100423     C                   End
045600100423     C                   End
045700100422
045800100423      * If its a term, then remove all previous codes
045900100423     C                   If        ACTCOD =  'MT'  or
046000100423     C                             ACTCOD =  'DT'
046100100423     C                   Exsr      RESETARRAY
046200100423     C                   End
046300100423
046400100422      * If FM070 and MT, the add DT records
046500100504     C                   If        %trim(TRNSRC) = 'FM070' and
046600100504     C                             ACTCOD =  'MT'          or
046700100504     C                             %trim(TRNSRC) = 'TR050' and
046800100422     C                             ACTCOD =  'MT'
046900100422     C                   Exsr      CreateDT
047000100422     C                   End
047100100419
047200100419      * Trap Codes
047300100419     C                   If        %trim(ACTCOD) <> *BLANKS
047400100419     C                   Eval      pos = %lookup(ACTCOD:ACOD)
047500100419     C                   If        pos = 0
047600100419     C                   Eval      cod = cod + 1
047700100420     C                   Eval      ACOD(cod) = ACTCOD
047800100420     C                   Eval      AGRP(cod) = GROUP#
047900100421     C                   Eval      AEFF(cod) = ENRLDT
048000100421     C                   Eval      ATRM(cod) = CANCDT
048100100514     C                   Eval      APLN(cod) = PLAN#
048200100514     C                   Eval      ATYP(cod) = MCVTYP
048300140107     C                   Exsr      GetClass
048400140107     C                   Exsr      Check_ACA
048500100419     C                   End
048600100419     C                   End
048700100419
048800100419     C                   ENDSR
048900100419      *--------------------------------------------------------------------*
049000100419     C     SETFLAGS      BEGSR
049100100419
049200100419      * Medical
049300100419     C                   If        DFLGM = 'Y'
049400100420     C                   Eval      x = 1
049500100420     C     X             occur     W_CODES
049600100422     C     X             occur     W_GROUP
049700100514     C     X             occur     W_CLASS
049800100514     C     X             occur     W_COVTY
049900140107     C     X             occur     W_PLANS
050000140107     C     X             occur     W_ACA
050100100421     C     X             occur     W_EFFDT
050200100422     C     X             occur     W_TRMDT
050300100422     C     X             occur     W_SDT
050400100419     C                   Exsr      FINDFLAG
050500100419     C                   Eval      DFLGM = WFLG
050600140127     C                   Exsr      Check_MEDACA
050700100419     C                   End
050800100419
050900100419      * Rxd
051000100419     C                   If        DFLGR = 'Y'
051100100420     C                   Eval      x = 2
051200100420     C     X             occur     W_CODES
051300100420     C     X             occur     W_GROUP
051400100514     C     X             occur     W_CLASS
051500100514     C     X             occur     W_COVTY
051600100421     C     X             occur     W_PLANS
051700100420     C     X             occur     W_EFFDT
051800100421     C     X             occur     W_TRMDT
051900100422     C     X             occur     W_SDT
052000100419     C                   Exsr      FINDFLAG
052100100419     C                   Eval      DFLGR = WFLG
052200100419     C                   End
052300100419
052400100419      * Vision
052500100419     C                   If        DFLGV = 'Y'
052600100420     C                   Eval      x = 3
052700100420     C     X             occur     W_CODES
052800100420     C     X             occur     W_GROUP
052900100514     C     X             occur     W_CLASS
053000100514     C     X             occur     W_COVTY
053100100421     C     X             occur     W_PLANS
053200100420     C     X             occur     W_EFFDT
053300100421     C     X             occur     W_TRMDT
053400100422     C     X             occur     W_SDT
053500100419     C                   Exsr      FINDFLAG
053600100419     C                   Eval      DFLGV = WFLG
053700100419     C                   End
053800100419
053900100419      * Dental
054000100419     C                   If        DFLGD = 'Y'
054100100420     C                   Eval      x = 4
054200100420     C     X             occur     W_CODES
054300100420     C     X             occur     W_GROUP
054400100514     C     X             occur     W_CLASS
054500100514     C     X             occur     W_COVTY
054600100421     C     X             occur     W_PLANS
054700100420     C     X             occur     W_EFFDT
054800100421     C     X             occur     W_TRMDT
054900100422     C     X             occur     W_SDT
055000100419     C                   Exsr      FINDFLAG
055100100419     C                   Eval      DFLGD = WFLG
055200100419     C                   End
055300100419
055400100419      * Set Global Flag
055500100419     C                   If        DFLG = 'Y'
055600100519
055700100519      * Same Day Term Rule - if SDT = "Y", then drop the coverage
055800100519     C                   Eval      X = 1
055900100519     C     X             occur     W_SDT
056000100519     C                   If        ASDT(1) = 'Y'
056100100519     C                   Eval      DFLGM   = ' '
056200100519     C                   End
056300100519     C                   Eval      X = 2
056400100519     C     X             occur     W_SDT
056500100519     C                   If        ASDT(1) = 'Y'
056600100519     C                   Eval      DFLGR   = ' '
056700100519     C                   End
056800100519     C                   Eval      X = 3
056900100519     C     X             occur     W_SDT
057000100519     C                   If        ASDT(1) = 'Y'
057100100519     C                   Eval      DFLGV   = ' '
057200100519     C                   End
057300100519     C                   Eval      X = 4
057400100519     C     X             occur     W_SDT
057500100519     C                   If        ASDT(1) = 'Y'
057600100519     C                   Eval      DFLGD   = ' '
057700100519     C                   End
057800100519
057900100419     C                   Select
058000100419     C                   When      (DFLGM = 'A' or
058100100419     C                             DFLGM = ' ') and
058200100419     C                             (DFLGR = 'A' or
058300100419     C                             DFLGR = ' ') and
058400100419     C                             (DFLGV = 'A' or
058500100419     C                             DFLGV = ' ') and
058600100419     C                             (DFLGD = 'A' or
058700100419     C                             DFLGD = ' ')
058800100422     C                   If        OLDFLD = 'Y' and
058900100422     C                             NEWADD = *Blanks
059000100420     C                   Exsr      CHKERE
059100100420     C                   Exsr      CHKUTM
059200100419     C                   Else
059300100419     C                   Eval      DFLG = 'A'
059400100419     C                   End
059500100419     C                   When      (DFLGM = 'T' or
059600100419     C                             DFLGM = ' ') and
059700100419     C                             (DFLGR = 'T' or
059800100419     C                             DFLGR = ' ') and
059900100419     C                             (DFLGV = 'T' or
060000100419     C                             DFLGV = ' ') and
060100100419     C                             (DFLGD = 'T' or
060200100419     C                             DFLGD = ' ')
060300100419     C                   Eval      DFLG = 'T'
060400100419     C                   When      (DFLGM = 'R' or
060500100419     C                             DFLGM = ' ') and
060600100419     C                             (DFLGR = 'R' or
060700100419     C                             DFLGR = ' ') and
060800100419     C                             (DFLGV = 'R' or
060900100419     C                             DFLGV = ' ') and
061000100419     C                             (DFLGD = 'R' or
061100100419     C                             DFLGD = ' ')
061200100419     C                   Eval      DFLG = 'R'
061300100420     C                   Exsr      CHKUTM
061400100419     C                   When      (DFLGM = 'N' or
061500100419     C                             DFLGM = ' ') and
061600100419     C                             (DFLGR = 'N' or
061700100419     C                             DFLGR = ' ') and
061800100419     C                             (DFLGV = 'N' or
061900100419     C                             DFLGV = ' ') and
062000100419     C                             (DFLGD = 'N' or
062100100419     C                             DFLGD = ' ')
062200100419     C                   If        DFSEQ = 0
062300100419     C                   Eval      DFLG = 'C'
062400100419     C                   Else
062500100420     C                   Eval      DFLG = 'C'
062600100420     C***                Eval      DFLG = 'N'
062700100419     C                   End
062800100419     C                   Other
062900100419     C                   Eval      DFLG = 'C'
063000100419     C                   Endsl
063100100521     C                   End
063200111115
063300111115     C     WEBKEY        Klist
063400111116     C                   Kfld                    S_TRS
063500111116     C                   Kfld                    S_SUB
063600111116     C                   Kfld                    S_ACC
063700111116     C                   Kfld                    S_SSN
063800111116     C                   Kfld                    S_SEQ
063900111115
064000111115      * If end result is "C" Check added from WEBTRAN
064100111115     C                   If        DFLG = 'C'
064200111115     C     WEBKEY        Chain     WEBTRNMIT
064300111115     C                   If        %found(WEBTRNMIT)
064400111115     C                   If        TMSNDT = 0
064500111115     C                   Eval      DFLG = 'A'
064600111116     C                   If        DFLGM  <> ' '
064700111116     C                   Eval      DFLGM = 'A'
064800111116     C                   End
064900111116     C                   If        DFLGR  <> ' '
065000111116     C                   Eval      DFLGR = 'A'
065100111116     C                   End
065200111116     C                   If        DFLGV  <> ' '
065300111116     C                   Eval      DFLGV = 'A'
065400111116     C                   End
065500111116     C                   If        DFLGD  <> ' '
065600111116     C                   Eval      DFLGD = 'A'
065700111116     C                   End
065800111115     C                   End
065900111115     C                   End
066000111115     C                   End
066100100521
066200100521      * Group Change then must be all add - everyone
066300100521     C                   If        GRPCHG = 'Y'
066400100521     C                   Eval      DFLG  = 'A'
066500100521     C                   If        DFLGM  <> ' '
066600100521     C                   Eval      DFLGM = 'A'
066700100521     C                   End
066800100521     C                   If        DFLGR  <> ' '
066900100521     C                   Eval      DFLGR = 'A'
067000100521     C                   End
067100100521     C                   If        DFLGV  <> ' '
067200100521     C                   Eval      DFLGV = 'A'
067300100521     C                   End
067400100521     C                   If        DFLGD  <> ' '
067500100521     C                   Eval      DFLGD = 'A'
067600100521     C                   End
067700100521     C                   End
067800100521
067900100419
068000100419      * If the member's flag is...then the dependents must be...
068100100419     C                   If        DFSEQ = 0
068200100420     C                   Eval      MBRFLG = DFLG
068300100420     C                   Eval      MBRM   = DFLGM
068400100420     C                   Eval      MBRR   = DFLGR
068500100420     C                   Eval      MBRV   = DFLGV
068600100420     C                   Eval      MBRD   = DFLGD
068700100419     C                   Else
068800100419     C                   Select
068900100419      * Member Add
069000100419     C                   When      MBRFLG = 'A'
069100100419     C                   Eval      DFLG  = 'A'
069200100419     C                   If        DFLGM  <> ' '
069300100419     C                   Eval      DFLGM = 'A'
069400100419     C                   End
069500100419     C                   If        DFLGR  <> ' '
069600100419     C                   Eval      DFLGR = 'A'
069700100419     C                   End
069800100419     C                   If        DFLGV  <> ' '
069900100419     C                   Eval      DFLGV = 'A'
070000100419     C                   End
070100100419     C                   If        DFLGD  <> ' '
070200100419     C                   Eval      DFLGD = 'A'
070300100419     C                   End
070400100513      * Member Term - we do not send dep when member terms
070500100419     C                   When      MBRFLG = 'T'
070600100513     C                   Eval      DFLG  = ' '
070700100513     C                   Eval      DFLGM = ' '
070800100513     C                   Eval      DFLGR = ' '
070900100513     C                   Eval      DFLGV = ' '
071000100513     C                   Eval      DFLGD = ' '
071100100419      * Member Reinstate
071200100419     C                   When      MBRFLG = 'R'
071300100419     C                   Eval      DFLG  = 'R'
071400100419     C                   If        DFLGM  <> ' '
071500100419     C                   Eval      DFLGM = 'R'
071600100419     C                   End
071700100419     C                   If        DFLGR  <> ' '
071800100419     C                   Eval      DFLGR = 'R'
071900100419     C                   End
072000100419     C                   If        DFLGV  <> ' '
072100100419     C                   Eval      DFLGV = 'R'
072200100419     C                   End
072300100419     C                   If        DFLGD  <> ' '
072400100419     C                   Eval      DFLGD = 'R'
072500100419     C                   End
072600100419     C                   Endsl
072700100420      *Plan Level
072800100420      * Member Add
072900100420     C                   If        MBRM  = 'A'
073000100420     C                   If        DFLGM  <> ' '
073100100420     C                   Eval      DFLGM = 'A'
073200100420     C                   End
073300100420     C                   End
073400100420     C                   If        MBRR  = 'A'
073500100420     C                   If        DFLGR  <> ' '
073600100420     C                   Eval      DFLGR = 'A'
073700100420     C                   End
073800100420     C                   End
073900100420     C                   If        MBRV  = 'A'
074000100420     C                   If        DFLGV  <> ' '
074100100420     C                   Eval      DFLGV = 'A'
074200100420     C                   End
074300100420     C                   End
074400100420     C                   If        MBRD  = 'A'
074500100420     C                   If        DFLGD  <> ' '
074600100420     C                   Eval      DFLGD = 'A'
074700100420     C                   End
074800100420     C                   End
074900100420      * Member Term
075000100420     C                   If        MBRM  = 'T'
075100100420     C                   If        DFLGM  <> ' '
075200100420     C                   Eval      DFLGM = 'T'
075300100420     C                   End
075400100420     C                   End
075500100420     C                   If        MBRR  = 'T'
075600100420     C                   If        DFLGR  <> ' '
075700100420     C                   Eval      DFLGR = 'T'
075800100420     C                   End
075900100420     C                   End
076000100420     C                   If        MBRV  = 'T'
076100100420     C                   If        DFLGV  <> ' '
076200100420     C                   Eval      DFLGV = 'T'
076300100420     C                   End
076400100420     C                   End
076500100420     C                   If        MBRD  = 'T'
076600100420     C                   If        DFLGD  <> ' '
076700100420     C                   Eval      DFLGD = 'T'
076800100420     C                   End
076900100420     C                   End
077000100419     C                   End
077100100525
077200100525      * Resync Coverage Types
077300100525     C                   If        DFLGM = *BLANKS
077400100525     C                   Eval      DTYPM = *BLANKS
077500100525     C                   End
077600100525     C                   If        DFLGR = *BLANKS
077700100525     C                   Eval      DTYPR = *BLANKS
077800100525     C                   End
077900100525     C                   If        DFLGV = *BLANKS
078000100525     C                   Eval      DTYPV = *BLANKS
078100100525     C                   End
078200100525     C                   If        DFLGD = *BLANKS
078300100525     C                   Eval      DTYPD = *BLANKS
078400100525     C                   End
078500100422
078600100527      * If Group Changed, set DFORGEF flag = today, then
078700100527      * Then in DW311FLGW if not zero update orgef with first plan date.
078800100527     C                   If        GRPCHG = 'Y'
078900100527     C     *DATE         Mult      10000.0001    DFORGEF
079000100527     C                   Else
079100100527     C                   Eval      DFORGEF = *Zeros
079200100527     C                   End
079300100527
079400100422      * If no coverages, then blank out the global flag
079500100422     C                   If        DFLGM = ' ' and
079600100422     C                             DFLGR = ' ' and
079700100422     C                             DFLGV = ' ' and
079800100422     C                             DFLGD = ' '
079900100422     C                   Eval      DFLG  = ' '
080000100422     C                   Delete    DW311FLGR
080100100422     C                   Else
080200100419     C                   Update    DW311FLGR
080300100420     C                   Eval      GFLG = DFLG
080400100420     C                   Eval      GFLGM = DFLGM
080500100420     C                   Eval      GFLGR = DFLGR
080600100420     C                   Eval      GFLGV = DFLGV
080700100420     C                   Eval      GFLGD = DFLGD
080800100420     C                   Eval      GFRVW = WQUSRN
080900100420     C     *DATE         Mult      10000.0001    GFDAT
081000100420     C                   Write     DW311FLGHR
081100100422     C                   End
081200100420
081300100419     C                   ENDSR
081400100419      *--------------------------------------------------------------------*
081500100419     C     FINDFLAG      BEGSR
081600100419      *
081700100419      * Count codes
081800100419     C                   eval      cdc = 0
081900100419     C     1             do        20            x
082000100419     C                   If        ACOD(x) <> *blanks
082100100419     C                   eval      cdc = cdc + 1
082200100419     C                   end
082300100419     C                   enddo
082400100419      *
082500100419     C                   Select
082600100419     C                   When      cdc = 0
082700100419     C                   Eval      WFLG = 'N'
082800100419     C                   When      cdc = 1
082900100419     C                   Exsr      FINDCODE1
083000100419     C                   Other
083100100419     C                   Exsr      FINDCODES
083200100419     C                   Endsl
083300100419      *
083400100419     C                   ENDSR
083500100419      *--------------------------------------------------------------------*
083600100419     C     FINDCODES     BEGSR
083700100419      *--------------------------------------------------------------------*
083800100419      * Default
083900100419     C                   Eval      WFLG = 'C'
084000100419      * Add
084100100419     C                   Eval      pos = %lookup('MA':ACOD)
084200100419     C                   If        pos > 0
084300100419     C                   Eval      WFLG = 'A'
084400100514     C                   Eval      ASDT(1) = ' '
084500100419     C                   LeaveSR
084600100419     C                   End
084700100420
084800100420      * Add/Term is nochange, but term, then add with different group is Add
084900100420     C                   Eval      pos1 = %lookup('AC':ACOD)
085000100420     C                   If        pos1 > 0
085100100420     C                   Eval      pos2 = %lookup('MT':ACOD)
085200100420     C                   If        pos2 > 0
085300100420     C                   If        AGRP(pos1) <> AGRP(pos2)
085400100521     C                   Eval      WFLG = 'A'
085500100521     C                   Eval      GRPCHG = 'Y'
085600100420     C                   Else
085700100422     C                   If        ACLS(pos1) <> ACLS(pos2)
085800100422     C                   Eval      WFLG = 'C'
085900100422     C                   Else
086000100514     C                   If        ATYP(pos1) <> ATYP(pos2)
086100100514     C                   Eval      WFLG = 'C'
086200100514     C                   Else
086300100419     C                   Eval      WFLG = 'N'
086400100514     C                   End
086500100422     C                   End
086600100420     C                   End
086700100514     C                   Eval      ASDT(1) = ' '
086800100419     C                   LeaveSR
086900100419     C                   End
087000100419     C                   End
087100100419
087200100419      * Rei/Term
087300100419     C                   Eval      pos = %lookup('MR':ACOD)
087400100419     C                   If        pos > 0
087500100419     C                   Eval      pos = %lookup('MT':ACOD)
087600100419     C                   If        pos > 0
087700100419     C                   Eval      WFLG = 'N'
087800100514     C                   Eval      ASDT(1) = ' '
087900100419     C                   LeaveSR
088000100419     C                   End
088100100419     C                   End
088200100419      * Dep Add
088300100419     C                   Eval      pos = %lookup('DA':ACOD)
088400100419     C                   If        pos > 0
088500100419     C                   Eval      WFLG = 'A'
088600100514     C                   Eval      ASDT(1) = ' '
088700100419     C                   LeaveSR
088800100419     C                   End
088900100419      * Dep Add/Term
089000100420     C                   Eval      pos1 = %lookup('DC':ACOD)
089100100420     C                   If        pos1 > 0
089200100420     C                   Eval      pos2 = %lookup('DT':ACOD)
089300100420     C                   If        pos2 > 0
089400100420     C                   If        AGRP(pos1) <> AGRP(pos2)
089500100420     C                   Eval      WFLG = 'A'
089600100420     C                   Else
089700100422     C                   If        ACLS(pos1) <> ACLS(pos2)
089800100422     C                   Eval      WFLG = 'C'
089900100422     C                   Else
090000100420     C                   Eval      WFLG = 'N'
090100100422     C                   End
090200100420     C                   End
090300100514     C                   Eval      ASDT(1) = ' '
090400100419     C                   LeaveSR
090500100419     C                   End
090600100419     C                   End
090700100419
090800100608      * Dep Add/Term
090900100608     C                   Eval      pos1 = %lookup('DA':ACOD)
091000100608     C                   If        pos1 > 0
091100100608     C                   Eval      pos2 = %lookup('DT':ACOD)
091200100608     C                   If        pos2 > 0
091300100608     C                   If        AGRP(pos1) <> AGRP(pos2)
091400100608     C                   Eval      WFLG = 'A'
091500100608     C                   Else
091600100608     C                   If        ACLS(pos1) <> ACLS(pos2)
091700100608     C                   Eval      WFLG = 'C'
091800100608     C                   Else
091900100608     C                   Eval      WFLG = 'N'
092000100608     C                   End
092100100608     C                   End
092200100608     C                   Eval      ASDT(1) = ' '
092300100608     C                   LeaveSR
092400100608     C                   End
092500100608     C                   End
092600100608
092700100419      * Dep Rei/Term
092800100419     C                   Eval      pos = %lookup('DR':ACOD)
092900100419     C                   If        pos > 0
093000100419     C                   Eval      pos = %lookup('DT':ACOD)
093100100419     C                   If        pos > 0
093200100419     C                   Eval      WFLG = 'N'
093300100514     C                   Eval      ASDT(1) = ' '
093400100419     C                   LeaveSR
093500100419     C                   End
093600100419     C                   End
093700100419
093800100419     C                   ENDSR
093900100419      *--------------------------------------------------------------------*
094000100419     C     FINDCODE1     BEGSR
094100100419      *--------------------------------------------------------------------*
094200100419      * Default
094300100624     C                   Eval      WFLG = 'C'
094400100419      * Add
094500100419     C                   Eval      pos = %lookup('MA':ACOD)
094600100419     C                   If        pos > 0
094700100419     C                   Eval      WFLG = 'A'
094800100419     C                   LeaveSR
094900100419     C                   End
095000100419      * Change
095100100419     C                   Eval      pos = %lookup('MC':ACOD)
095200100419     C                   If        pos > 0
095300100419     C                   Eval      WFLG = 'C'
095400100419     C                   LeaveSR
095500100419     C                   End
095600100624      * Enrl Date Change
095700100624     C                   Eval      pos = %lookup('ME':ACOD)
095800100624     C                   If        pos > 0
095900100624     C                   Eval      WFLG = 'C'
096000100624     C                   LeaveSR
096100100624     C                   End
096200100419      * Change
096300100419     C                   Eval      pos = %lookup('AC':ACOD)
096400100419     C                   If        pos > 0
096500100419     C                   Eval      WFLG = 'A'
096600100419     C                   LeaveSR
096700100419     C                   End
096800100419      * Term
096900100419     C                   Eval      pos = %lookup('MT':ACOD)
097000100419     C                   If        pos > 0
097100100419     C                   Eval      WFLG = 'T'
097200100419     C                   LeaveSR
097300100419     C                   End
097400100419      * Reinstate
097500100419     C                   Eval      pos = %lookup('MR':ACOD)
097600100419     C                   If        pos > 0
097700100419     C                   Eval      WFLG = 'R'
097800100419     C                   LeaveSR
097900100419     C                   End
098000100419      * Dep Add
098100100419     C                   Eval      pos = %lookup('DA':ACOD)
098200100419     C                   If        pos > 0
098300100419     C                   Eval      WFLG = 'A'
098400100419     C                   LeaveSR
098500100419     C                   End
098600100419      * Dep Change
098700100419     C                   Eval      pos = %lookup('DC':ACOD)
098800100419     C                   If        pos > 0
098900100419     C                   Eval      WFLG = 'C'
099000100419     C                   LeaveSR
099100100419     C                   End
099200100419      * Dep Term
099300100419     C                   Eval      pos = %lookup('DT':ACOD)
099400100419     C                   If        pos > 0
099500100419     C                   Eval      WFLG = 'T'
099600100419     C                   LeaveSR
099700100419     C                   End
099800100419      * Dep Reinstate
099900100419     C                   Eval      pos = %lookup('DR':ACOD)
100000100419     C                   If        pos > 0
100100100419     C                   Eval      WFLG = 'R'
100200100419     C                   LeaveSR
100300100419     C                   End
100400100419
100500100419     C                   ENDSR
100600100419      *--------------------------------------------------------------------*
100700100419     C     KEYS          BEGSR
100800100419      *--------------------------------------------------------------------*
100900100419     C     FLGKEY        KLIST
101000100419     C                   KFLD                    DFSSN
101100100419     C                   KFLD                    DFSEQ
101200100419     C     TRNKEY        KLIST
101300100419     C                   KFLD                    DFSSN
101400100419     C                   KFLD                    WWSEQ
101500100419     C     PLNKEY        KLIST
101600100419     C                   KFLD                    TRUST
101700100419     C                   KFLD                    SUBNO
101800100419     C                   KFLD                    PLAN#
101900100420
102000100419     C                   ENDSR
102100100420      *--------------------------------------------------------------------*
102200100420     C     CHKERE        BEGSR
102300100420      *--------------------------------------------------------------------*
102400100420     C                   EVAL      W_FLG = *BLANKS
102500100420     C                   MOVE      WISSN         W_SSN
102600100420
102700100420     C                   Select
102800100420     C                   When      DFLGM = 'A'
102900100420     C     1             occur     W_CODES
103000100420     C     1             occur     W_EFFDT
103100100420     C                   Eval      pos = %lookup('AC':ACOD)
103200100420     C                   If        pos > 0
103300100420     C                   Eval      W_EFF = AEFF(pos)
103400100420     C                   End
103500100420     C                   When      DFLGR = 'A'
103600100420     C     2             occur     W_CODES
103700100420     C     2             occur     W_EFFDT
103800100420     C                   Eval      pos = %lookup('AC':ACOD)
103900100420     C                   If        pos > 0
104000100420     C                   Eval      W_EFF = AEFF(pos)
104100100420     C                   End
104200100420     C                   When      DFLGV = 'A'
104300100420     C     3             occur     W_CODES
104400100420     C     3             occur     W_EFFDT
104500100420     C                   Eval      pos = %lookup('AC':ACOD)
104600100420     C                   If        pos > 0
104700100420     C                   Eval      W_EFF = AEFF(pos)
104800100420     C                   End
104900100420     C                   When      DFLGD = 'A'
105000100420     C     4             occur     W_CODES
105100100420     C     4             occur     W_EFFDT
105200100420     C                   Eval      pos = %lookup('AC':ACOD)
105300100420     C                   If        pos > 0
105400100420     C                   Eval      W_EFF = AEFF(pos)
105500100420     C                   End
105600100420     C                   Endsl
105700100420
105800100420     C                   If        W_EFF > *ZEROS
105900100420     C     W_SSN         SETGT     HIST
106000100420     C     W_SSN         READPE    HIST
106100100420     C                   DOW       not %eof(HIST)
106200100420     C                   IF        HDSEQ# = 0
106300100420     C                   IF        TRCODE = 'ERE' AND
106400100420     C                             COVTDT = W_EFF
106500100420     C                   Eval      DFLG = 'R'
106600100420     C                   Leave
106700100420     C                   End
106800100420     C                   End
106900100420     C     W_SSN         READPE    HIST
107000100420     C                   Enddo
107100100420     C                   End
107200100420
107300100420     C                   If        DFLG = 'R'
107400100420     C                   If        DFLGM = 'A'
107500100420     C                   Eval      DFLGM = 'R'
107600100420     C                   End
107700100420     C                   If        DFLGR = 'A'
107800100420     C                   Eval      DFLGR = 'R'
107900100420     C                   End
108000100420     C                   If        DFLGV = 'A'
108100100420     C                   Eval      DFLGV = 'R'
108200100420     C                   End
108300100420     C                   If        DFLGD = 'A'
108400100420     C                   Eval      DFLGD = 'R'
108500100420     C                   End
108600100420     C                   Else
108700100420     C                   Eval      DFLG = 'C'
108800100420     C                   End
108900100420
109000100420     C                   ENDSR
109100100420      *--------------------------------------------------------------------*
109200100420     C     CHKUTM        BEGSR
109300100420      *--------------------------------------------------------------------*
109400100420     C                   EVAL      W_FLG = *BLANKS
109500100420     C                   MOVE      WISSN         W_SSN
109600100420
109700100420     C                   Select
109800100420     C                   When      DFLGM <> ' '
109900100420     C     1             occur     W_CODES
110000100420     C     1             occur     W_EFFDT
110100100420     C                   Eval      pos = %lookup('AC':ACOD)
110200100420     C                   If        pos > 0
110300100420     C                   Eval      W_EFF = AEFF(pos)
110400100420     C                   End
110500100420     C                   When      DFLGR <> ' '
110600100420     C     2             occur     W_CODES
110700100420     C     2             occur     W_EFFDT
110800100420     C                   Eval      pos = %lookup('AC':ACOD)
110900100420     C                   If        pos > 0
111000100420     C                   Eval      W_EFF = AEFF(pos)
111100100420     C                   End
111200100420     C                   When      DFLGV <> ' '
111300100420     C     3             occur     W_CODES
111400100420     C     3             occur     W_EFFDT
111500100420     C                   Eval      pos = %lookup('AC':ACOD)
111600100420     C                   If        pos > 0
111700100420     C                   Eval      W_EFF = AEFF(pos)
111800100420     C                   End
111900100420     C                   When      DFLGD <> ' '
112000100420     C     4             occur     W_CODES
112100100420     C     4             occur     W_EFFDT
112200100420     C                   Eval      pos = %lookup('AC':ACOD)
112300100420     C                   If        pos > 0
112400100420     C                   Eval      W_EFF = AEFF(pos)
112500100420     C                   End
112600100420     C                   Endsl
112700100420
112800100420     C                   If        W_EFF > *ZEROS
112900100420     C     W_SSN         SETGT     HIST
113000100420     C     W_SSN         READPE    HIST
113100100420     C                   DOW       not %eof(HIST)
113200100420     C                   IF        HDSEQ# = 0
113300100420     C                   IF        TRCODE = 'UTM' AND
113400100420     C                             COVTDT = W_EFF
113500100420
113600100420     C                   EVAL      W_FAC = %SUBST(CK#NOT:20:10)
113700100420     C                   EVAL      W_TAC = %SUBST(NOTE2:4:10)
113800100420
113900100420     C                   IF        W_FAC = W_TAC
114000100420     C                   EVAL      DFLG = 'R'
114100100420     C                   Leave
114200100420     C                   ELSE
114300100420     C                   EVAL      DFLG = 'A'
114400100420     C                   Leave
114500100420     C                   END
114600100420     C                   END
114700100420     C                   End
114800100420     C     W_SSN         READPE    HIST
114900100420     C                   Enddo
115000100420     C                   End
115100100420
115200100420     C                   Select
115300100420     C                   When      DFLG = 'R'
115400100420     C                   If        DFLGM = 'A'
115500100420     C                   Eval      DFLGM = 'R'
115600100420     C                   End
115700100420     C                   If        DFLGR = 'A'
115800100420     C                   Eval      DFLGR = 'R'
115900100420     C                   End
116000100420     C                   If        DFLGV = 'A'
116100100420     C                   Eval      DFLGV = 'R'
116200100420     C                   End
116300100420     C                   If        DFLGD = 'A'
116400100420     C                   Eval      DFLGD = 'R'
116500100420     C                   End
116600100420     C                   When      DFLG = 'A'
116700100420     C                   If        DFLGM = 'R'
116800100420     C                   Eval      DFLGM = 'A'
116900100420     C                   End
117000100420     C                   If        DFLGR = 'R'
117100100420     C                   Eval      DFLGR = 'A'
117200100420     C                   End
117300100420     C                   If        DFLGV = 'R'
117400100420     C                   Eval      DFLGV = 'A'
117500100420     C                   End
117600100420     C                   If        DFLGD = 'R'
117700100420     C                   Eval      DFLGD = 'A'
117800100420     C                   End
117900100420     C                   Other
118000100420     C                   Eval      DFLG = 'C'
118100100420     C                   Endsl
118200100420
118300100420     C                   ENDSR
118400100422      *--------------------------------------------------------------------*
118500100422     C     GetClass      BEGSR
118600100422      *--------------------------------------------------------------------*
118700100422     C     ClassKey      KLIST
118800100422     C                   KFLD                    TRUST
118900100422     C                   KFLD                    SUBNO
119000100422     C                   KFLD                    PLAN#
119100100422     C*********          KFLD                    MCVTYP
119200100422     C     ClassKey      Chain     CLASS
119300100422     C                   If        %found(CLASS)
119400100422     C                   Eval      ACLS(cod) = CLCLASS
119500100422     C                   End
119600100422     C                   ENDSR
119700140107      *--------------------------------------------------------------------*
119800140107     C     Check_ACA     BEGSR
119900140107      *--------------------------------------------------------------------*
120000140107      /free
120100140625               IS_ACA = ' ' ;
120200140107         if #chk_aca_plan(trust:subno:plan#) = 'Y' ;
120300140625               IS_ACA = 'Y' ;
120400140107         endif;
120500140107      /end-free
120600140107     C                   ENDSR
120700140107      *--------------------------------------------------------------------*
120800140107     C     Check_MEDACA  BEGSR
120900140107      *--------------------------------------------------------------------*
121000140107      *  If the medical plan is ACA the default RX flag = MED flag
121100140625     C                   If        IS_ACA = 'Y'
121200140128     C                   Eval      DFLGR = DFLGM
121300140128     C                   Eval      DTYPR = DTYPM
121400140107     C                   End
121500140107     C                   ENDSR
121600100422      *--------------------------------------------------------------------*
121700100422     C     CreateDT      BEGSR
121800100422      *--------------------------------------------------------------------*
121900100423     C                   Eval      CRTDT  = 'Y'
122000100422      *
122100100422     C     SOCSOC        SETLL     DEPNDC
122200100422     C     SOCSOC        READE     DEPNDC
122300100422     C                   DOW       not %eof(DEPNDC)
122400100422      *
122500100422     C     KEYDEP        SETGT     DCOVC
122600100422     C     KEYDEP        READPE    DCOVC
122700100422     C                   DOW       not %eof(DCOVC)
122800100422     C                   IF        (CANCDT = CCANDT)  OR
122900100422     C                             (CANCDT = DENRDT  AND
123000100422     C                             CCANDT = *ZEROS)
123100100422     C     KEYDEPD       CHAIN     DEPNDC
123200100422     C                   Eval      ACTCOD = 'DT'
123300100422     C                   Move      DPSEQ#        DEPSEQ
123400100422     C                   Eval      DENRLD = DENRDT
123500100422     C                   Eval      DCANDT = CCANDT
123600100422     C                   Eval      DPLAN# = DVPLAN
123700100422     C                   Eval      QQPGNM = 'DW311FLGU'
123800100422     C                   Eval      TRNSRC = 'DW311'
123900100504     C                   Eval      QQTIME = QQTIME - 1
124000100422     C                   Write     TRNMIR
124100100504     C                   Eval      QQTIME = QQTIME + 1
124200100423     C                   Eval      ACTCOD = 'MT'
124300100423     C                   Eval      DEPSEQ = *BLANKS
124400100422     C                   Leave
124500100422     C                   END
124600100422     C     KEYDEP        READPE    DCOVC
124700100422     C                   ENDDO
124800100422      *
124900100422     C     SOCSOC        READE     DEPNDC
125000100422     C                   ENDDO
125100100422      *
125200100422     C     KEYDEP        KLIST
125300100422     C                   KFLD                    DSSNO
125400100422     C                   KFLD                    DPSEQ#
125500100422     C                   KFLD                    TRUST
125600100422     C                   KFLD                    SUBNO
125700100422     C                   KFLD                    PLAN#
125800100422     C     KEYDEPD       KLIST
125900100422     C                   KFLD                    DSSNO
126000100422     C                   KFLD                    DPSEQ#
126100100422      *
126200100423     C                   ENDSR
126300100423      *--------------------------------------------------------------------*
126400100423     C     RESETARRAY    BEGSR
126500100423      *--------------------------------------------------------------------*
126600100423     C                   Clear                   ACOD
126700100423     C                   Clear                   AGRP
126800100514     C                   Clear                   ACLS
126900100514     C                   Clear                   ATYP
127000100423     C                   Clear                   APLN
127100100423     C                   Clear                   AEFF
127200100423     C                   Clear                   ATRM
127300100423     C                   Clear                   ASDT
127400100422     C                   ENDSR
127500100423      *--------------------------------------------------------------------*
127600100423     C     RESETARRAYS   BEGSR
127700100423      *--------------------------------------------------------------------*
127800100423     C                   Eval      x   = 0
127900100423     C     1             do        4             x
128000100423     C     x             occur     W_CODES
128100100423     C                   Clear                   ACOD
128200100423     C     x             occur     W_GROUP
128300100423     C                   Clear                   AGRP
128400100423     C     x             occur     W_CLASS
128500100423     C                   Clear                   ACLS
128600100514     C     x             occur     W_COVTY
128700100514     C                   Clear                   ATYP
128800100423     C     x             occur     W_PLANS
128900100423     C                   Clear                   APLN
129000140107     C     x             occur     W_ACA
129100140107     C                   Clear                   AACA
129200100423     C     x             occur     W_EFFDT
129300100423     C                   Clear                   AEFF
129400100423     C     x             occur     W_TRMDT
129500100423     C                   Clear                   ATRM
129600100423     C     x             occur     W_SDT
129700100423     C                   Clear                   ASDT
129800100423     C                   enddo
129900100423     C                   ENDSR
130000100423      *--------------------------------------------------------------------*
130100100423     C     REMOVETEMP    BEGSR
130200100423      *--------------------------------------------------------------------*
130300100423     C     DFSSN         Setll     TRNMITL4
130400100423     C     DFSSN         Reade     TRNMITL4
130500100423     C                   Dow       not %eof(TRNMITL4)
130600100423     C                   If        QQPGNM = 'DW311FLGU'
130700100423     C                   Delete    TRNMIR
130800100423     C                   End
130900100423     C     DFSSN         Reade     TRNMITL4
131000100423     C                   Enddo
131100100423     C                   ENDSR
