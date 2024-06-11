000100140625     Hoption(*nodebugio) debug dftactgrp(*no) actgrp(*caller)
000200140625     Hbnddir('ALLSRVPGMN')
000300000000      *_________________________________________________________________________
000400000000      *
000500091222      *  Description:  Create DW311FLG Records
000600000000      *
000700091222      *  (c)Copyright 2009 by GBS, Inc.
000800000000      *
000900091222      *    Created by:  JALLEN - Dec 22, 2009
001000000000      *_________________________________________________________________________
001100090902     FMCOV      IF   E           K DISK
001200090618     FPLNMST    IF   E           K DISK
001300091222     FCARMST    IF   E           K DISK
001400091222     FDEPEND    IF   E           K DISK
001500091222     FDCOVC     IF   E           K DISK
001600100419     FGRAT24    IF   E           K DISK    Prefix(G_)
001700091223     FDW311FLGLFUF A E           K DISK
001800090618
001900140625      /define copy_all_protos_and_fields
002000140625      /copy qcpysrc,hcrsrvpgmp
002100140625      /undefine copy_all_protos_and_fields
002200140625
002300090813     D POS             S              2S 0
002400100128     D POP             S              2S 0
002500100128     D POZ             S              2S 0
002600100128     D P_SSN           S              9A
002700100128     D P_DEP           S             40A
002800100128     D P_PLN           S             80A
002900100128     D A_DEP           S              2A
003000090811     D W_SSN           S              9S 0
003100140625     D CFS             S              1A
003200140625     D ACA             S              1A
003300091222
003400100128     D W_DEP           DS
003500100128     D WADEP                   1     40A   DIM(20)
003600100128
003700100128     D W_PLN           DS
003800100128     D WAPLN                   1     80A   DIM(20)
003900100128
004000100128     D W_CAN           DS
004100100128     D WACAN                   1    160S 0 DIM(20)
004200100128
004300091222      * Program status data structure
004400091222     D PGMD          ESDS                  EXTNAME(IOPGMD)
004500090618
004600090618     C     *ENTRY        PLIST
004700100128     C                   PARM                    P_SSN
004800100128     C                   PARM                    P_DEP
004900100128     C                   PARM                    P_PLN
005000100128
005100100128     C     1             do        20            pos
005200100128     C                   clear                   WACAN(pos)
005300100128     C                   enddo
005400090729
005500090813     C                   MOVE      P_SSN         W_SSN
005600100128     C                   Eval      W_DEP = P_DEP
005700100128     C                   Eval      W_PLN = P_PLN
005800091222
005900091222     C                   Clear                   DW311FLGR
006000091222     C                   Eval      DFSSN = W_SSN
006100091222     C                   Eval      DFSEQ = *ZEROS
006200100419     C                   Eval      DFGRP#  = *blanks
006300091223     C     M_KEY         Chain     DW311FLGLF
006400100112     C                   If        not %found(DW311FLGLF)
006500090813
006600090813     C     W_KEY         KLIST
006700090813     C                   KFLD                    W_SSN
006800090618
006900090902     C     W_KEY         SETLL     MCOV
007000090902     C     W_KEY         READE     MCOV
007100090902     C                   DOW       not %eof(MCOV)
007200100128     C                   If        CANDT = 0
007300090618     C                   EXSR      CHKPLAN
007400100128     C                   Else
007500100128     C                   Eval      pos = %lookup(MCPLAN:WAPLN)
007600100128     C                   If        pos > 0
007700100128     C                   Eval      WACAN(pos) = CANDT
007800100128     C                   Eval      MCPLAN = WAPLN(pos)
007900100128     C                   EXSR      CHKPLAN
008000100128     C                   End
008100100128     C                   End
008200090902     C     W_KEY         READE     MCOV
008300090618     C                   Enddo
008400091222
008500091222     C     M_KEY         Klist
008600091222     C                   Kfld                    DFSSN
008700091222     C                   Kfld                    DFSEQ
008800091222
008900091222      * Load Member
009000091222     C                   Eval      DFRVW = %trim(WQUSRN)
009100091222     C     *DATE         Mult      10000.0001    DFDAT
009200091223     C                   EVAL      DFLG = 'Y'
009300091222
009400091222     C                   Write     DW311FLGR
009500091222     C                   End
009600091222
009700091222      * Load Dependents
009800091222     C     D_KEY         KLIST
009900091222     C                   KFLD                    DSSNO
010000091222     C                   KFLD                    DPSEQ#
010100100128
010200100128      * First check for dependent terms
010300100128     C     W_KEY         SETLL     DEPEND
010400100128     C     W_KEY         READE     DEPEND
010500100128     C                   DOW       not %eof(DEPEND)
010600100128      *
010700100128     C                   Move      DPSEQ#        A_DEP
010800100128     C                   Eval      pos = %lookup(A_DEP:WADEP)
010900100128     C                   If        pos = 0
011000100128     C     D_KEY         SETLL     DCOVC
011100100128     C     D_KEY         READE     DCOVC
011200100128     C                   DOW       not %eof(DCOVC)
011300100128
011400100128     C                   Eval      pop = %lookup(DVPLAN:WAPLN)
011500100128     C                   If        pop > 0
011600100604     C                   If        CCANDT = WACAN(pop) and
011700100604     C                             CCANDT > *ZEROS
011800100128     C                   Eval      poz = %lookup('  ':WADEP)
011900100128     C                   If        poz > 0
012000100128     C                   move      DPSEQ#        WSQ#              2
012100100128     C                   Eval      WADEP(poz) = WSQ#
012200100128     C                   End
012300100128     C                   End
012400100128     C                   End
012500100128
012600100128     C     D_KEY         READE     DCOVC
012700100128     C                   Enddo
012800100128     C                   End
012900100128      *
013000100128     C     W_KEY         READE     DEPEND
013100100128     C                   Enddo
013200091222
013300100128      * Then process dependents
013400091222     C     W_KEY         SETLL     DEPEND
013500091222     C     W_KEY         READE     DEPEND
013600091222     C                   DOW       not %eof(DEPEND)
013700100128      *
013800100128     C                   Move      DPSEQ#        A_DEP
013900100128     C                   Eval      pos = %lookup(A_DEP:WADEP)
014000100128     C                   If        pos > 0
014100100128      *
014200091222     C                   Clear                   DW311FLGR
014300091222     C                   Eval      DFSSN = DSSNO
014400091222     C                   Eval      DFSEQ = DPSEQ#
014500091223     C     M_KEY         Chain     DW311FLGLF
014600100112     C                   If        not %found(DW311FLGLF)
014700100128
014800100128     C                   Eval      CFS = ' '
014900091222     C     D_KEY         SETLL     DCOVC
015000091222     C     D_KEY         READE     DCOVC
015100091222     C                   DOW       not %eof(DCOVC)
015200100128     C                   If        CCANDT = 0
015300100128     C                   EXSR      CHKPLAND
015400100128     C                   Else
015500100128     C                   Eval      pos = %lookup(DVPLAN:WAPLN)
015600100128     C                   If        pos > 0
015700100128     C                   Eval      DVPLAN = WAPLN(pos)
015800100128     C                   EXSR      CHKPLAND
015900100128     C                   End
016000100128     C                   End
016100091222     C     D_KEY         READE     DCOVC
016200091222     C                   Enddo
016300091222
016400091222     C                   Eval      DFRVW = %trim(WQUSRN)
016500091222     C     *DATE         Mult      10000.0001    DFDAT
016600091223     C                   EVAL      DFLG = 'Y'
016700091222
016800100128     C                   If        CFS = 'Y'
016900091222     C                   Write     DW311FLGR
017000100128     C                   End
017100091222     C                   End
017200091222
017300100128     C                   End
017400091222     C     W_KEY         READE     DEPEND
017500091222     C                   Enddo
017600090618
017700090618     C                   Eval      *INLR = *ON
017800090618     C                   Return
017900090618
018000090618     C     CHKPLAN       BEGSR
018100090618     C     PKEY          KLIST
018200090902     C                   KFLD                    MCTRST
018300090902     C                   KFLD                    MCSUB#
018400090902     C                   KFLD                    MCPLAN
018500140625
018600140625      /free
018700140625            ACA = #chk_aca_plan(MCTRST:MCSUB#:MCPLAN) ;
018800140625      /end-free
018900090618
019000090618     C     PKEY          CHAIN     PLNMST
019100090729     C                   IF        %found(PLNMST)
019200090618     C     PCARR         CHAIN     CARMST
019300090618     C                   IF        %found(CARMST)
019400090618     C                   IF        CARBC = 'D'
019500091222     C                   Select
019600121023     C                   When      PLNCAT = 'PMM' or
019700121023     C                             PLNCAT = 'PCM'
019800140625     C                   EVAL      DFLGM = 'Y'
019900140625     C                   If        ACA = 'Y'
020000140625     C                   EVAL      DFLGR = 'Y'
020100140625     C                   End
020200100128     C                   EVAL      DTYPM = %subst(MCOVTP:2:2)
020300091222     C                   When      PLNCAT = 'PRX'
020400091222     C                   EVAL      DFLGR = 'Y'
020500100128     C                   EVAL      DTYPR = %subst(MCOVTP:2:2)
020600110922     C                   When      PLNCAT = 'PVR' or
020700130725     C                             PLNCAT = 'PVS' or
020800130725     C                             PLNCAT = 'PCV'
020900091222     C                   EVAL      DFLGV = 'Y'
021000100128     C                   EVAL      DTYPV = %subst(MCOVTP:2:2)
021100110922     C                   When      PLNCAT = 'PDR' or
021200140917     C                             PLNCAT = 'PCD' or
021300130118     C                             PLNCAT = 'PDN' or
021400130118     C                             PLNCAT = 'PDE'
021500091222     C                   EVAL      DFLGD = 'Y'
021600100128     C                   EVAL      DTYPD = %subst(MCOVTP:2:2)
021700091222     C                   Endsl
021800100419     C                   If        DFGRP# = *Blanks
021900100419     C                   Exsr      GetGroup
022000100419     C                   End
022100090729     C                   END
022200090729     C                   END
022300090618     C                   END
022400090618
022500090618     C                   ENDSR
022600091222
022700091222     C     CHKPLAND      BEGSR
022800091222     C     DKEY          KLIST
022900091222     C                   KFLD                    DVTRST
023000091222     C                   KFLD                    DVSUB#
023100091222     C                   KFLD                    DVPLAN
023200091222
023300140625      /free
023400140625            ACA = #chk_aca_plan(DVTRST:DVSUB#:DVPLAN) ;
023500140625      /end-free
023600140625
023700091222     C     DKEY          CHAIN     PLNMST
023800091222     C                   IF        %found(PLNMST)
023900091222     C     PCARR         CHAIN     CARMST
024000091222     C                   IF        %found(CARMST)
024100091222     C                   IF        CARBC = 'D'
024200091222     C                   Select
024300121023     C                   When      PLNCAT = 'PMM' or
024400121023     C                             PLNCAT = 'PCM'
024500091222     C                   EVAL      DFLGM = 'Y'
024600140625     C                   If        ACA = 'Y'
024700140625     C                   EVAL      DFLGR = 'Y'
024800140625     C                   End
024900100128     C                   Eval      CFS = 'Y'
025000091222     C                   When      PLNCAT = 'PRX'
025100091222     C                   EVAL      DFLGR = 'Y'
025200100128     C                   Eval      CFS = 'Y'
025300110922     C                   When      PLNCAT = 'PVR' or
025400130725     C                             PLNCAT = 'PVS' or
025500130725     C                             PLNCAT = 'PCV'
025600091222     C                   EVAL      DFLGV = 'Y'
025700100128     C                   Eval      CFS = 'Y'
025800110922     C                   When      PLNCAT = 'PDR' or
025900140917     C                             PLNCAT = 'PCD' or
026000130118     C                             PLNCAT = 'PDN' or
026100130118     C                             PLNCAT = 'PDE'
026200091222     C                   EVAL      DFLGD = 'Y'
026300100128     C                   Eval      CFS = 'Y'
026400091222     C                   Endsl
026500091222     C                   END
026600091222     C                   END
026700091222     C                   END
026800091222
026900091222     C                   ENDSR
027000100419      *___________________________________________________________________
027100100419      * Get Group
027200100419      *___________________________________________________________________
027300100419     C     GetGroup      BEGSR
027400100419      *
027500100419     C     GrtKey        Klist
027600100419     C                   Kfld                    MCTRST
027700100419     C                   Kfld                    MCSUB#
027800100419     C                   Kfld                    MCPLAN
027900100419      * Get Plan Group
028000100419     C     GrtKey        Setgt     GRAT24
028100100419     C     GrtKey        Readpe    GRAT24
028200100419     C                   Dow       not %eof(GRAT24)
028300100419      * GBS Date Logic
028400100419     C                   If        G_frmdat <> G_todat
028500100419      *
028600100419     C                   if        ENRLDT >= G_frmdat and
028700100419     C                             ENRLDT <= G_todat
028800100419      *
028900100419      * This is the real group#
029000111213     C                   Eval      DFGRP# = %trim(G_group#)
029100111213     C                   Eval      DFSGRP = %subst(G_group#:9:4)
029200100419      *
029300100419     C                   Leave
029400100419     C                   end
029500100419     C                   end
029600100419     C     GrtKey        Readpe    GRAT24
029700100419     C                   Enddo
029800100419      *
029900100419     C                   ENDSR
