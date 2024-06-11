000100140228     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN') DATEDIT(*YMD)
000200140228     H ALWNULL(*USRCTL)
000300140228   X***X
0004009907140002 F******************************************************************
0005009907200003 F* DB053      GROUP BENEFIT SERVICES SOFTWARE                     *
0006009907140004 F*                                                                *
0007009907140005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0008009907200006 F*            DATE -  7/20/99                                     *
0009009907140007 F*                                                                *
0010009907200013 F*  THIS PROGRAM WILL SERVE AS A PRE-INVOICE RATE AUDIT FOR TR020.*
0011000001100015 F*                                                                *
0012000001110015 F* 01/10/00 DLK - add output to invexc & hist files.              *
001300011211     f* 12/11/01 dlk - exclude plans billed to cobra members           *
001400071010      * 10/10/07 dlk - convert to use external pgm for grate           *
001500130108      * 01/08/13 dlk - change printer file to unique name              *
001600130930      * 09/30/13 dlk  hist file expansion project
001601140625      * 10/31/13 dlk  remove indicator U8 useage
001700140228    ***
001800140228    *** 02/28/2014 SSK RE-MOD TO OTF AND KEEP ACA PRT
001900140228    ***
002000140228    ***
002100140228    ***
002200140228    ***
0023000001100015 F*                                                                *
0024000001100015 F*                                                                *
0025009907140016 F******************************************************************
0026009907300018 FMCOVx     If   E           k DISK
0027000112110019 Fmember    IF   e           k DISK
0028001402280034 FDEPNDC    IF   e           k DISK
0029001402280034 FDCOVC     IF   e           k DISK
0030000112110019 Fplnmst    IF   e           k DISK
0031000001100019 FINVEXC    if A E           k DISK
0032000001100019 Fhist      O  A E             DISK
0033001301080021 Fdb053p    O    F  132        PRINTER OFLIND(*INOF)
003400140228   X***X
0035001309300037 D sysdateymd      S               d   datfmt(*iso)
003600130930     D thispgmname     S             10a   inz('DB053     ')
003700140228    ***
0038000710100055 D                 DS
0039000710100055 D tspabct                 1     15
0040000710100055 D mctrst                  1      3  0
0041000710100055 D mcsub#                  4      6  0
0042000710100055 D mcplan                  7     10
0043000710100055 D mcageb                 11     12  0
0044000710100055 D mcovtp                 13     15
004500140228    ***
0046000112110048 D                 DS
0047000112110049 D  enrldt                 1      8  0
0048000112110049 D  enrlym                 1      6  0
004900140228    ***
0050001402280048 D                 DS
0051001402280049 D  DENRDT                 1      8  0
0052001402280049 D  DENRYM                 1      6  0
005300140228    ***
0054009907130048 D                 DS
005500140228     D @LCYMD                  1      8A
0056009907130049 D  LYMD                   1      8  0
0057000112110049 D  LYM                    1      6  0
0058009907130050 D  LYY                    1      4  0
0059009907130051 D  LMM                    5      6  0
0060009907130051 D  LDD                    7      8  0
006100140228    ***
0062001402280054 D* LDA
0063009102150055 D                UDS
0064009907200063 D  LMONTH                 1      2  0
0065009907200064 D  LYEAR                  3      6  0
0066000001100065 D  ltsa                   7     16  0
0067000001100065 D  LT                     7      9  0
0068009907200065 D  LS                    10     12  0
0069009907200065 D  LA                    13     16  0
0070001309300064 D  LUSER                 25     34
0071009505080056 D  CONAME               201    240
007200140228    ***
007300140228     D @ACA            S              1A   INZ
007400140228   X***X
007500140228      /DEFINE CHK_ACA_PLAN_PR
007600140228      /DEFINE CHK_ACA_PLAN_FIELDS
007700140228      /COPY QCPYSRC,ACASRVPGMP
007800140228      /UNDEFINE CHK_ACA_PLAN_PR
007900140228      /UNDEFINE CHK_ACA_PLAN_FIELDS
008000140228   X***X
008100140228    ***
008200990730     C                   eval      *in50 = *off
0083009907300094 C     MCKEY         SETLL     MCOVX
008400990730     C                   DOW       NOT *IN50
0085009907300095 C     MCKEY         READE     MCOVX                                  50
0086009907300096 C   50              LEAVE
008700990730
008800011211     c                   if        mcdltd = 'D' or enrldt = candt or
008900011211     c                             enrlym > lym or (candt <> 0 and
009000011211     c                             candt <= lymd)
009100011211     C                   iter
009200941216     C                   END
009300011211
009400011211     c* skip plans only billed to COBRA members
009500011211
009600011211     c     mcssno        chain     member                             55
009700011211     c   55              iter
009800011211     c                   if        cexpdt <> 0
009900011211     c     plnkey        chain     plnmst                             56
010000011211     c   56              iter
010100011211     c                   if        sfadm <> 'Y' or cexpdt <= lymd
010200011211     c                   iter
010300011211     c                   end
010400011211     c                   end
010500140228    ***
010600140228     C                   SETOFF                                         54
010700140228    ***
010800140228    *** CHECK IF ACA PLAN
010900140228    ***
011000140228     C                   EVAL      @ACA = #CHK_ACA_PLAN(MCTRST:MCSUB#:MCPLAN)
011100140228    ***
011200140228    ***
011300990713     C* VALID RATE NEEDED FOR RUN DATE
011400990730
011500910701     C                   EXSR      #FNDRT
011600140228     C                   IF        @ACA = 'Y'
011700140228     C                   EXSR      #DEPRT
011800140228     C                   ENDIF
011900140228    ***
012000990730     C                   ENDDO
012100140228    ***
0122009907300195 C* PRINT TOTALS
012300140228    ***
012400990730     c                   if        fpage = 'N'
012500990720     c                   except    total
012600000110     c*
012700000110     c     mckey         chain     invexc                             51
012800000110     C*
012900000110     C* ADD ACCT TO INVOICE EXCLUSION FILE and add history record for
013000000110     C* documentation
013100000110     C*
013200140625     C                   IF        *in51
013300000110     C                   MOVE      lt            IETRUS
013400000110     C                   MOVE      ls            IESUB
013500000110     C                   MOVE      la            IEACC
013600000110     C                   MOVE      LYMD          IEEFF
013700000110     C                   MOVE      *blank        IENOR
013800000110     C                   WRITE     INVER
013900130930
014000130930     C* add history record
014100000110     c                   eval      trcode = 'UEI'
014200000110     c                   move      ltsa          hkey
014300000110     c                   eval      tramt  = *zeros
014400130930     c                   eval      hprgnm = thispgmname
014500000110     c                   eval      hstrst = lt
014600000110     c                   eval      hssub# = ls
014700000110     c                   eval      hsacct = la
014800000110     c                   eval      hoper  = luser
014900000110     c                   eval      hsdltd = 'A'
015000000110     c                   eval      covtdt = lymd
015100130930     C                   eval      sysdateymd = %date
015200130930     C                   MOVE      sysdateymd    trdate
015300131002     c                   eval      hstrtime = %time
015400000110     C                   write     histr
015500000110     c                   endif
015600000110
015700000110     c*
015800990720     c                   end
015900140228    ***
016000990730     C                   move      *on           *inlr
016100140228    ***
016200140228   S***S
0163009907010073 C***********************************************
0164009907010073 C* FIND RATE                                   *
0165009907010073 C***********************************************
016600910701     C     #FNDRT        BEGSR
016700140228    ***
016800140228     C                   IF        @ACA = 'Y'
016900140228     C                   EVAL      *IN55 = *OFF
017000140228     C                   EVAL      *IN54 = *ON
017100140228     C                   EVAL      PARMSSN = %EDITC(MBSSNO:'X')
017200140228     C                   EVAL      PARMSEQ = '00'
017300140228     C                   ELSE
017400140228     C                   EVAL      *IN54 = *OFF
017500140228     C                   EVAL      PARMSSN = *BLANKS
017600140228     C                   EVAL      PARMSEQ = *BLANKS
017700140228     C                   ENDIF
017800140228    ***
017900071010     c                   move      tspabct       parmkey
018000071010     c                   move      lymd          parmeffymd
018100071011     c                   move      benamt        parmbenamt
018200071010     c                   clear                   parmgroup
018300071010     c                   clear                   parmbilrte
018400071010     c                   clear                   parmnetrte
018500071010     c                   clear                   parmbilprem
018600071010     c                   clear                   parmnetprem
018700071010     c                   clear                   parmfound
018800071010
018900071010     c                   call      'GETRATE'     grplist
019000140228    ***
019100140228     C                   EXSR      $RESULT
019200140228    ***
019300140228     C                   ENDSR
019400140228   S***S
019500140228     C     $RESULT       BEGSR
019600140228      * grate not returned
0197000710100361 C                   if        parmfound <> 'Y'
0198009907130102 C                   ADD       1             CNT               5 0
019900990720     c                   if        fpage = ' ' or *inof = *on
020000990720     c                   except    head
020100990720     c                   move      'N'           fpage             1
020200990720     c                   end
020300990720
020400910701     C                   EXCEPT    ERROR
020500990720     c  nu7              move      *on           *inu7
0206009102150097 C                   END
020700140228    ***
020800910701     C                   ENDSR
020900140228   S***S
021000140228     C***********************************************
021100140228     C* FIND RATE FOR DEPENDENTS                    *
021200140228     C***********************************************
021300140228     C     #DEPRT        BEGSR
021400140228    ***
021500140228     C     MCSSNO        CHAIN     DEPENR
021600140228     C                   IF        NOT %FOUND(DEPNDC)
021700140228     C                   LEAVESR
021800140228     C                   ENDIF
021900140228    ***
022000140228     C     MCSSNO        SETLL     DEPENR
022100140228     C                   DOU       %EOF(DEPNDC)
022200140228     C     MCSSNO        READE     DEPENR
022300140228     C                   IF        NOT %EOF(DEPNDC)
022400140228    ***
022500140228     C     KL#SQTSP      CHAIN     DCOVR
022600140228     C                   IF        NOT %FOUND(DCOVC)
022700140228     C                   ITER
022800140228     C                   ENDIF
022900140228    ***
023000140228     C     KL#SQTSP      SETLL     DCOVR
023100140228     C                   DOU       %EOF(DCOVC)
023200140228     C     KL#SQTSP      READE     DCOVR
023300140228     C                   IF        NOT %EOF(DCOVC) AND DVDLTD <> 'D' AND
023400140228     C                             DENRDT <> CCANDT AND
023500140228     C                             DENRYM <= LYM AND
023600140228     C                             (CCANDT = 0 OR CCANDT > LYMD)
023700140228    ***
023800140228     C                   EVAL      *IN55 = *ON
023900140228     C                   EVAL      *IN54 = *ON
024000140228     C                   EVAL      PARMSSN = %EDITC(SSNO:'X')
024100140228     C                   EVAL      PARMSEQ = %EDITC(DPSEQ#:'X')
024200140228    ***
024300140228     C                   MOVE      TSPABCT       PARMKEY
024400140228     C                   MOVE      LYMD          PARMEFFYMD
024500140228     C                   MOVE      BENAMT        PARMBENAMT
024600140228     C                   CLEAR                   PARMGROUP
024700140228     C                   CLEAR                   PARMBILRTE
024800140228     C                   CLEAR                   PARMNETRTE
024900140228     C                   CLEAR                   PARMBILPREM
025000140228     C                   CLEAR                   PARMNETPREM
025100140228     C                   CLEAR                   PARMFOUND
025200140228    ***
025300140228     C                   CALL      'GETRATE'     GRPLIST
025400140228    ***
025500140228     C                   EXSR      $RESULT
025600140228    ***
025700140228     C                   ENDIF
025800140228     C                   ENDDO
025900140228    ***
026000140228     C                   ENDIF
026100140228     C                   ENDDO
026200140228    ***
026300140228     C                   ENDSR
026400140228   S***S
026500990713     C     *INZSR        BEGSR
026600140228    ***
026700140228     c     grplist       plist
026800140228     c                   parm                    parmkey          15
026900140228     C                   PARM                    PARMSSN           9
027000140228     C                   PARM                    PARMSEQ           2
027100140228     c                   parm                    parmeffymd        8
027200140228     c                   parm                    parmbenamt        7
027300140228     c                   parm                    parmgroup        15
027400140228     c                   parm                    parmbilrte       11
027500140228     c                   parm                    parmnetrte       11
027600140228     c                   parm                    parmbilprem       7
027700140228     c                   parm                    parmnetprem       7
027800140228     c                   parm                    parmfound         1
027900140228    ***
028000140228     C     KL#SQTSP      KLIST
028100140228     C                   KFLD                    DSSNO
028200140228     C                   KFLD                    DSEQ#
028300140228     C                   KFLD                    MCTRST
028400140228     C                   KFLD                    MCSUB#
028500140228     C                   KFLD                    MCPLAN
028600140228    ***
0287009907130060 C                   Z-ADD     1             LDD
0288009907130065 C                   Z-ADD     LYEAR         LYY
0289009907130066 C                   Z-ADD     LMONTH        LMM
029000990720     c                   time                    htime             6 0
029100140228    ***
029200990730     C     mckey         KLIST
029300990730     C                   KFLD                    lt
029400990730     C                   KFLD                    ls
029500990730     C                   KFLD                    la
029600140228    ***
029700011211     c     plnkey        klist
029800011211     c                   kfld                    mctrst
029900011211     c                   kfld                    mcsub#
030000011211     c                   kfld                    mcplan
030100140228    ***
030200990713     C                   ENDSR
0303009907130058 C*
0304009102150104 O******************************************************              DB020
0305009102150105 O*  OUTPUT SPECIFICATIONS                             *              DB020
0306009102150106 O******************************************************              DB020
0307009102150107 O*                                                                   DB020
0308001402280108 ODB053P    E            HEAD           2  3
0309001402280110 O                       CONAME              87
0310001402280108 ODB053P    E            HEAD           1
0311001402280113 O                       *MONTH               8
031200140228     O                                            9 '/'
0313001402280113 O                       *DAY                11
031400140228     O                                           12 '/'
0315001402280113 O                       *YEAR               16
0316001402280114 O                                           55 'NO RATES FOR'
031700140228     O                       LMONTH              58
031800140228     O                                           59 '/'
031900140228     O                       LYEAR               63
0320001402280114 O                                           87 '- INVOICE NOT GENERATED'
0321001402280115 O                                          120 'PAGE :'
0322001402280116 O                       PAGE          Z    130
0323001402280108 ODB053P    E            HEAD           1
0324001402280119 O                                           17 'PROG: DB053 '
032500140228     O                                           49 'ACCOUNT SELECTED:'
032600140228     O                       LT                  53
032700140228     O                                           54 '-'
032800140228     O                       LS                  57
032900140228     O                                           58 '-'
033000140228     O                       LA                  62
0331001402280120 O                                          120 'TIME :'
0332001402280121 O                       HTIME              130 '  :  :  '
0333001402280108 ODB053P    E            HEAD           1
0334001402280124 O                                           24 '------------------------'
0335001402280125 O                                           48 '------------------------'
0336001402280126 O                                           72 '------------------------'
0337001402280127 O                                           96 '------------------------'
0338001402280128 O                                          120 '------------------------'
0339001402280129 O                                          132 '------------'
0340001402280108 ODB053P    E            HEAD           1
0341001402280133 O                                           11 'SSN'
0342001402280133 O                                           23 'T/S/A'
0343001402280133 O                                           32 'PLAN'
0344001402280134 O                                           43 'AGE BAND'
0345001402280135 O                                           53 'COV TYPE'
0346001402280108 ODB053P    E            HEAD           1
0347001402280141 O                                           24 '------------------------'
0348001402280142 O                                           48 '------------------------'
0349001402280143 O                                           72 '------------------------'
0350001402280144 O                                           96 '------------------------'
0351001402280145 O                                          120 '------------------------'
0352001402280146 O                                          132 '------------'
0353001402280147 ODB053P    E            ERROR          1
0354001402280150 O                       MCSSNO              11 '   -  -    '
0355001402280150 O                       MCTRST              17
035600140228     O                                           18 '-'
0357001402280150 O                       MCSUB#              21
035800140228     O                                           22 '-'
0359001402280150 O                       ACC#                26
0360001402280151 O                       MCPLAN              32
0361001402280151 O                       MCAGEB              40
0362001402280152 O                       MCOVTP              50
036300140228     O               54                          59 'ACA'
036400140228     O               54N55                       65 'MBR'
036500140228     O               54 55                       65 'DEP'
0366001402280156 ODB053P    E            TOTAL       3
0367001402280157 O                                           29 '*** TOTAL ERRORS:'
0368001402280158 O                       CNT           ZB    38
