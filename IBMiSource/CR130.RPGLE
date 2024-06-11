000100910215     F******************************************************************
000200990930     F* CR130      GROUP BENEFIT SERVICES SOFTWARE           1994      *
000300910215     F*                                                                *
000400940824     F*  DESCRIPTION - THIS PROGRAM WILL PRODUCE A REPORT OF HOW       *
000500940824     F*                MUCH CARRIERS WILL REMIT TO GBS                 *
000600910215     F*                                                                *
000700980812     F*                                                                *
000800980812     F*  Y2K CONVERT - 1998                                            *
000900991027     F*  DMA  10.27.99   Changed date level break to CCYYMM            *
001000000801     F*  dlk  08/01/00   add commission override at plan level         *
001100001011     F*  dlk  10/11/00   change group # from invdet to 15              *
001200010124     F*  jva  01/24/01   ext CR130HST file.                            *
001300010212     F*  ksj  02/12/01   Moved last two fields in prtf two positions   *
001400010212     F*                   to the left                                  *
001500010308     F*  dlk   3/08/01   Start filling life volume in CR130HST,        *
001600010308     F*                  it will not be printed on the report          *
001700010726     F*  ksj   7/25/01   Added the following totals for #Mbr fields:   *
001800010726     F*                  Carrier, Group Code and Final Totals          *
001900020206     F*  KSJ   2/04/02   Added Market Size and changed Broker Code to  *
002000020206     F*                  Agency Code                                   *
002100030325     F*  SSK   3/25/03   CHANGE CARMST TO EXTERNAL DEFINE AND MAKE     *
002200030325     F*                  ADJUSMENTS FOR RELATIONSHIP ID                *
0022010711300015 F*  dlk  11/30/2007 change to handel run seq instead of O/L       *
0022020908060015 F*  dlk  08/06/2009 fix page break so it breaks when the carrier  *
0022030908060015 F*                  or the carrier group code changes (l4 or l5)  *
0022041508130015 F*  dlk  08/13/2015 add group code to group code total line       *
0022051612140015 F*  dlk  12/14/16   changes for new member / depend count fields  *
002301161214     F*                                                                *
002400980812     F******************************************************************
002500910215     F*                                                                *
002600161214     FCR132     IP   F  150        DISK
002700030325     FCARMST    IF   E           K DISK
002800000801     Fplnmst    If   e           k DISK
002900020206     FSMAN      If   e           k DISK
003000030326     FSMANRLT   IF   E           K DISK
003100030326     FSPRAGXR2  IF   E           K DISK
003200010124     FCR130HST  o  a e             Disk
003300020205     FCR130P    O    F  236        PRINTER OFLIND(*INOF)
003400030501   X***X
003500030326     Dbonp             S              5P 2
003600030326     Dafp              S              5P 2
003700030326     Dcomp             S              5P 2
003800030501    ***
003900910215     D                UDS
003901071130     D  Lseq                  21     22
004000980812     D  LMDY                  85     92  0
004100980813     D  LMD                   85     88  0
004200980813     D  LY                    89     92  0
004300940826     D  LSORT                  8     19
004400940824     D  CONAME               201    240
004500030501    ***
004600010125     D  edate          DS                  inz
004700010125     D  eyy                    1      4  0
004800010125     D  emm                    5      6  0
004900010125     D  edd                    7      8  0
005000030501   X***X
005100030327     ICARMSR
005200030326     I              CBONP                       CBONPX
005300030326     I              CAFP                        CAFPX
005400030326     I              CCOMP                       CCOMPX
005500030501    ***
005600940824     ICR132     NS  01
005700000801     I                                  1    3  carr          L4
005800960625     I                                  4    6 0TRUST#        L1
005900960625     I                                  7    9 0SUB#          L1
006000960625     I                                 10   13 0ACC#          L1
006100001011     I                                 14   28  GROUP#        L3
006200960625     I                                 30   69  ACNAM1
006300960625     I                                 70   71  GRPCD         L5
006400960625     I                                 72   80 2BILAMT
006500960625     I                                 81   89 2ADJAMT
006600960625     I                                 90   98 2PADAMT
006700960625     I                                 99  101  SMANCD
006800991027     I                                102  109 0EFFINV
006900991027     I                                102  107 0DATEL2        L2
007000000801     I                                110  113  plan          L3
007100010204     I                                114  114 0bcmcnt
007200010308     I                                115  121 0benamt
007300020206     I                                122  126  CMKSZ
007400030326     I                                127  134  RELID
007401161214     I                                135  135 0bcBmcnt
007402161214     I                                136  136 0bcAmcnt
007403161214     I                                137  137 0bcdcnt
007404161214     I                                138  138 0bcBdcnt
007405161214     I                                139  139 0bcAdcnt
007500030501   X***X
007600030501    1C                   IF        FIRST <> 'F'
007700000803     C                   MOVE      'F'           FIRST             1
007800030325     C     carr          CHAIN     CARMSR                             H4
007900000803     C                   EXCEPT    HEAD
008000030501    1C                   END
008100030501    ***
008200030501     c                   eval      cagcod = *blanks
008300030605     c                   eval      crelid = relid
008400030501    1c                   if        relid <> *blanks
008500030501     C     RELID         CHAIN     SRF
008600030501    2c                   if        %found(smanrlt)
008700030501     C     SRASID        CHAIN     SXF
008800030501    3c                   if        %found(spragxr2)
008900030501      *
009000030501     C                   EVAL      CAGCOD = SXAGCY
009100030501      *
009200030501    3c                   endif
009300030501    2c                   endif
009400030501    1c                   endif
009500030501    ***
009501090806
009502090806      * page break on carrier change (L4)
009503090806
009504090806     c                   if        *inl4
009505090806     C     FPAGE         IFEQ      'N'
0095060908060156 C                   EXCEPT    HEAD
0095070908060156 C                   END
0095080908060156 C                   MOVE      'N'           FPAGE             1
009509090806     c                   end
009510090806
009600941214     C   L5              EXCEPT    L5DET
009700030501    ***
009800000801     C* get commission % per carrier
009900000801     C*
010000030501     c   l4              exsr      $commcar
010100030501    ***
010200000801     C* commission override for this plan only.
010300000801     C*
010400030501     c   l3              exsr      $comovrpln
010500030501    ***
010600960625     C* ACCUMULATE AMOUNTS
010700910215     C*
010800960625     C                   ADD       BILAMT        TBAMT             9 2
010900960625     C                   ADD       ADJAMT        TAAMT             9 2
011000960625     C                   ADD       PADAMT        TPAMT             9 2
011100010308     C                   ADD       benamt        Tbenamt           9 0
011200010204     C                   ADD       bcmcnt        CLIVES
011201161214     C                   ADD       bcBmcnt       CLIVESB
011202161214     C                   ADD       bcAmcnt       CLIVESA
011203161214     C                   ADD       bcdcnt        CDLIVES
011204161214     C                   ADD       bcBdcnt       CDLIVESB
011205161214     C                   ADD       bcAdcnt       CDLIVESA
011300030501    ***
011400940909     C* ACCOUNT TOTALS
011500940909     C*
011600030501     cL1                 exsr      $tsabrk
011700030501    ***
011800940909     C* CARRIER TOTALS
011900940909     C*
012000030501     CL4                 exsr      $carbrk
012100030501    ***
012200940909     C* GROUP TOTALS
012300940909     C*
012400030501     cL5                 exsr      $grpbrk
012500030501    ***
012600940906     CLR                 EXCEPT    LRTOT
012700030501    ***
012800030501    ***
012900030501    ***
013000030501   S***S
013100980812     C***************************************************
013200980812     C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
013300980812     C***************************************************
013400980812     C*
013500980812     C* DATE IN  = @DATIN (8.0) YYYYMMDD
013600980812     C* DATE OUT = @DATOU (8.0) MMDDYYYY
013700980812     C*
013800980812     C     #DATYM        BEGSR
013900980812     C                   MOVE      @DATIN        @MD               4 0
014000980812     C                   MOVEL     @DATIN        @Y                4 0
014100980812     C                   MOVEL     @MD           @DATOU            8 0
014200980812     C                   MOVE      @Y            @DATOU
014300980812     C                   MOVE      *ZEROS        @DATIN            8 0
014400980812     C                   ENDSR
014500000801
014600000801     C*
014700010124     C     CRT130H       Begsr
014800010124     C                   MOVE      CARR          CCARCD
014900010124     C                   Z-ADD     TRUST#        CTRUST
015000010124     C                   Z-ADD     SUB#          CSUB
015100010124     C                   Z-ADD     ACC#          CACCT
015200010124     C                   MOVE      GRPCD         CGRPCD
015300010124     C                   MOVE      ACNAM1        CACNAM
015400010124     C                   MOVE      SMANCD        CBCODE
015500010124     C                   MOVE      GROUP#        CGROUP
015600010124     C                   MOVE      PLAN          CPLAN
015700010124     C                   Z-ADD     TBAMT         CBAMT
015800010124     C                   Z-ADD     TAAMT         CAAMT
015900010124     C                   Z-ADD     TPAMT         CPAMT
016000010124     C     COMP          DIV       100           CCOMP
016100010124     C                   Z-ADD     COMEX         CCOME
016200010124     C     AFP           DIV       100           CADMP
016300010124     C                   Z-ADD     ADMEX         CADME
016400010124     C     BONP          DIV       100           CBONP
016500010124     C                   Z-ADD     BONDR         CBOND
016600010124     C                   Z-ADD     TOTCO         CTOTC
016700071130     C                   clear                   CSTAT
016900010124     C     LMDY          MULT      10000.0001    CEFFDT
017000010125     C                   MOVE      EFFINV        EDATE
017100010125     C                   Z-ADD     EYY           CEFIYY
017200010125     C                   Z-ADD     EMM           CEFIMM
017300010125     C                   Z-ADD     EDD           CEFIDD
017400010308     C                   Z-ADD     Tbenamt       Clifev
017401071130     c                   move      lseq          cseq
017500010124     C                   WRITE     CRHSTR
017600010124     C                   Endsr
017700000801     C***************************************************
017800030501   S***S
017900000801     C*
018000000801     C     *inzsr        begsr
018100000801
018200000801     C                   TIME                    HTIME             6 0
018300000801     c     plnkey        klist
018400000801     c                   kfld                    trust#
018500000801     c                   kfld                    sub#
018600000801     c                   kfld                    plan
018700000801     C                   ENDSR
018800030501   S***S
018900030501     c     $commcar      begsr
019000030501    ***
019100030501     C     carr          CHAIN     CARMSR                             H4
019700030501     C                   EXCEPT    L4DET
019800030501     C                   z-add     cbonpX        bonp
019900030501     C                   z-add     cafpX         afp
020000030501     C                   z-add     ccompX        comp
020100030501    ***
020200030501     c                   endsr
020300030501   S***S
020400030501     c     $comovrpln    begsr
020500030501    ***
020600030501     c* restore orig % from carrier
020700030501     c                   eval      bonp = cbonpx
020800030501     c                   eval      afp  = cafpx
020900030501     c                   eval      comp = ccompx
021000030501
021100030501     c     plnkey        chain     PLNMSR
021200030501    1c                   if        %found(plnmst)
021300030501
021400030501     c* 999.99 = override to 0 %
021500030501
021600030501    2c                   if        pbonp <> 0 and pbonp <> 999.99
021700030501     c                   eval      bonp  = pbonp
021800030501    2c                   end
021900030501    2c                   if        pbonp = 999.99
022000030501     c                   eval      bonp  = *zeros
022100030501    2c                   end
022200030501
022300030501    2c                   if        pafp <> 0 and pafp <> 999.99
022400030501     c                   eval      afp  = pafp
022500030501    2c                   end
022600030501    2c                   if        pafp = 999.99
022700030501     c                   eval      afp  = *zeros
022800030501    2c                   end
022900030501
023000030501    2c                   if        pcomp <> 0 and pcomp <> 999.99
023100030501     c                   eval      comp  = pcomp
023200030501    2c                   end
023300030501    2c                   if        pcomp = 999.99
023400030501     c                   eval      comp  = *zeros
023500030501    2c                   end
023600030501
023700030501    1c                   end
023800030501    ***
023900030501     c                   endsr
024000030501   S***S
024100030501     c     $tsabrk       begsr
024200030501    ***
024300030501     C     COMP          DIV       100           CPCT              5 4
024400030501     C     AFP           DIV       100           APCT              5 4
024500030501     C     BONP          DIV       100           BPCT              5 4
024600030501     C     TPAMT         MULT      CPCT          COMEX             9 2
024700030501     C     TPAMT         MULT      APCT          ADMEX             9 2
024800030501     C     TPAMT         MULT      BPCT          BONDR             9 2
024900030501     C                   ADD       CLIVES        CTMBR             8 2
025000030501     C                   ADD       TBAMT         CTBAMT           10 2
025100030501     C                   ADD       TAAMT         CTAAMT           10 2
025200030501     C                   ADD       TPAMT         CTPAMT           10 2
025300030501     C                   ADD       COMEX         CCOMEX           10 2
025400030501     C                   ADD       ADMEX         CADMEX           10 2
025500030501     C                   ADD       BONDR         CBONDR           10 2
025600030501     C     COMEX         ADD       ADMEX         TOTCO            10 2
025700030501     C                   ADD       BONDR         TOTCO
025800030501     C                   ADD       TOTCO         CTOTCO           10 2
025900030501     C*
026000030501     C                   MOVE      EFFINV        @DATIN
026100030501     C                   EXSR      #DATYM
026200030501     C                   MOVE      @DATOU        EFIMDY            8 0
026300030501     C*
026400030501     C     SMANCD        chain     SMANR
026500030501    ***
026600030501     C   U1              EXSR      CRT130H
026700030501     C                   MOVEL     '%'           WCMETH            1
026800030501     C                   MOVEL     ACNAM1        ACNAMX           23
026900030501     C                   EXCEPT    L1OUT
027000030501    ***
027100030501     C                   Clear                   crhstr
027200030501     C                   Clear                   tbenamt
027300030501     C   OF              EXCEPT    HEAD
027400030501    ***
027500030501     c                   endsr
027600030501   S***S
027700030501     c     $carbrk       begsr
027800030501    ***
027900030501     C                   ADD       CTMBR         GTMBR             9 2
028000030501     C                   ADD       CTBAMT        GTBAMT           10 2
028100030501     C                   ADD       CTAAMT        GTAAMT           10 2
028200030501     C                   ADD       CTPAMT        GTPAMT           10 2
028300030501     C                   ADD       CCOMEX        GCOMEX           10 2
028400030501     C                   ADD       CADMEX        GADMEX           10 2
028500030501     C                   ADD       CBONDR        GBONDR           10 2
028600030501     C                   ADD       CTOTCO        GTOTCO           10 2
028700030501     C                   EXCEPT    L4TOT
028800030501     C   OF              EXCEPT    HEAD
028900030501    ***
029000030501     c                   endsr
029100030501   S***S
029200030501     c     $grpbrk       begsr
029300030501    ***
029400030501     C                   ADD       GTMBR         FTMBR            10 2
029500030501     C                   ADD       GTBAMT        FTBAMT           11 2
029600030501     C                   ADD       GTAAMT        FTAAMT           11 2
029700030501     C                   ADD       GTPAMT        FTPAMT           11 2
029800030501     C                   ADD       GCOMEX        FCOMEX           10 2
029900030501     C                   ADD       GADMEX        FADMEX           10 2
030000030501     C                   ADD       GBONDR        FBONDR           10 2
030100030501     C                   ADD       GTOTCO        FTOTCO           10 2
030200030501     C                   EXCEPT    L5TOT
030300030501    ***
030400030501     c                   endsr
030500030501   S***S
030600960627     OCR130P    E            HEAD           2  2
030700960627     O                                           98 '*****'
030800960627     O                       CONAME             139
030900960627     O                                          145 '*****'
031000960627     OCR130P    E            HEAD           1
031100960627     O                                          128 'SUMMARY OF CARRIER PAYME'
031200960627     O                                          131 'NTS'
031300960627     OCR130P    E            HEAD           1
031400950130     O                                           19 'PROGRAM NAME: CR130'
031500000801     O                       CARR                30
031600960202     O                                           32 '-'
031700960202     O                       CNAME               73
031800960627     O                                          120 'FOR THE PERIOD :'
031900980812     O                       LMDY               131 '  /  /    '
032000010209     O                                          224 'PAGE :'
032100010209     O                       PAGE          Z    234
032200960627     OCR130P    E            HEAD           2
032300950130     O                                            9 'RUN DATE:'
032400950130     O                       UDATE         Y     20
032500960627     O                                          111 'SORTED BY:'
032600960627     O                       LSORT              124
032700010209     O                                          224 'TIME :'
032800010209     O                       HTIME              234 '  :  :  '
032900960627     OCR130P    E            HEAD           1
033000020204     O                                           46 'MARKET'
033100020201     O                                           61 'AGENCY'
033200010725     O                                           95 'INVOICE'
033300960627     O                                          111 'BILLED'
033400960627     O                                          128 'ADJUSTMENT'
033500960627     O                                          145 'PAYMENT'
033600960627     O                                          154 'COMM'
033700960627     O                                          168 'COMMISSION'
033800960627     O                                          179 'ADMIN FEE'
033900960627     O                                          193 'ADMIN FEE'
034000960627     O                                          202 'BONUS'
034100010209     O                                          217 'BONUS'
034200010209     O                                          234 'TOTAL'
034300960627     OCR130P    E            HEAD           1
034400020204     O                                           44 'SIZE'
034500940920     O                                            9 'ACCOUNT #'
034600001011     O                                           25 'ACCOUNT NAME'
034700010725     O                                           53 '#MBR'
034800001011     O                                           60 'CODE'
034900001011     O                                           70 'GROUP #'
035000000801     O                                           83 'PLAN'
035100980812     O                                           95 'EFFDT'
035200960627     O                                          111 'AMOUNT'
035300960627     O                                          128 'AMOUNT'
035400960627     O                                          145 'AMOUNT'
035500010129     O                                          154 'BASE'
035600960627     O                                          168 'EXPENSE'
035700960627     O                                          193 'EXPENSE'
035800010206     O                                          202 'DRAW'
035900010209     O                                          217 'DRAW'
036000010209     O                                          234 'COMPENSATION'
036100960627     OCR130P    E            HEAD           2
036200940824     O                                           24 '------------------------'
036300940824     O                                           48 '------------------------'
036400940824     O                                           72 '------------------------'
036500940824     O                                           96 '------------------------'
036600940824     O                                          120 '------------------------'
036700940824     O                                          144 '------------------------'
036800940824     O                                          168 '------------------------'
036900940824     O                                          192 '------------------------'
037000960627     O                                          216 '------------------------'
037100960627     O                                          236 '--------------------'
037200940906     OCR130P    E            L5DET          2
037300940906     O                       GRPCD                2
037400940906     O                                           15 '- GROUP CODE'
037500000801     OCR130P    E            L4DET          2
037600000801     O                       CARR                 5
037700940906     O                                            7 '-'
037800940906     O                       CNAME               48
037900020205     OCR130P    E            L1OUT          1
038000940920     O                       TRUST#               3
038100940920     O                                            4 '-'
038200940920     O                       SUB#                 7
038300940920     O                                            8 '-'
038400940920     O                       ACC#                12
038500020205     O                       ACNAMX              37
038600020204     O                       CMKSZ               45
038700010725     O                       CLIVES        P     55
038800020204     O                       CAGCOD              59
038900000801     O                       GROUP#              78
039000000801     O                       PLAN                83
039100980812     O                       EFIMDY              95 '  /  /    '
039200960625     O                       TBAMT         JB   111
039300960625     O                       TAAMT         JB   128
039400960625     O                       TPAMT         JB   145
039500000801     O                       COMP          3    153
039600010129     O                       WCMETH             154
039700960625     O                       COMEX         JB   168
039800000801     O                       AFP           3    178
039900960625     O                       ADMEX         JB   193
040000000801     O                       BONP          3    201
040100010209     O                       BONDR         JB   217
040200010209     O                       TOTCO         JB   234
040300960625     OCR130P    E            L4TOT          1
040400960625     O                                           96 '-----------'
040500960625     O                                          120 '------------------------'
040600940824     O                                          144 '------------------------'
040700940824     O                                          168 '------------------------'
040800940824     O                                          192 '------------------------'
040900960625     O                                          216 '------------------------'
041000960627     O                                          228 '------------'
041100960627     O                                          236 '--------------------'
041200010725     O                                           63 '--------------------------'
041300010725     O                                           85 '----------------------'
041400960625     OCR130P    E            L4TOT          1
041500010725     O                                           40 'CARRIER TOTALS :'
041600010823     O                       CTMBR         NB    55
041700960625     O                       CTBAMT        JB   111
041800960625     O                       CTAAMT        JB   128
041900960625     O                       CTPAMT        JB   145
042000960625     O                       CCOMEX        JB   168
042100960625     O                       CADMEX        JB   193
042200010209     O                       CBONDR        JB   217
042300010209     O                       CTOTCO        JB   234
042400010725     OCR130P    E            L5TOT          1
042501150813     O                                           28 'GROUP CODE'
042502150813     O                       grpcd               31
042503150813     O                                           40 'TOTALS :'
042600010823     O                       GTMBR         NB    55
042700960625     O                       GTBAMT        JB   111
042800960625     O                       GTAAMT        JB   128
042900960625     O                       GTPAMT        JB   145
043000960625     O                       GCOMEX        JB   168
043100960625     O                       GADMEX        JB   193
043200010209     O                       GBONDR        JB   217
043300010209     O                       GTOTCO        JB   234
043400010725     OCR130P    E            LRTOT          1
043500010725     O                                           40 'FINAL TOTALS :'
043600010823     O                       FTMBR         NB    55
043700960625     O                       FTBAMT        JB   111
043800960625     O                       FTAAMT        JB   128
043900960625     O                       FTPAMT        JB   145
044000960625     O                       FCOMEX        JB   168
044100960625     O                       FADMEX        JB   193
044200010209     O                       FBONDR        JB   217
044300010209     O                       FTOTCO        JB   234
