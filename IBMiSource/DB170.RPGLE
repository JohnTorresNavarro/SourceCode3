000100140606     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN')
000200140606     H ALWNULL(*USRCTL)
000300140606   X***X
0004009102150002 F******************************************************************  UTL001
0005000004140003 F* DB170      GROUP BENEFIT SERVICES SOFTWARE           1998      *  UTL001
0006009102150004 F*                                                                *  UTL001
0007009801060013 F*  DESCRIPTION - COBRA MEMBERS RATE AUDIT                        *  UTL001
0008009811120015 F*11/12/98 - DLW CHANGED REC LENGTH AND LDA DATE POSITIONING      *  UTL001
0009009811120015 F*               Y2K COMPLIANT.                                   *  UTL001
0010009909220015 F* 09/22/99 DLK - convert to external file definitions and add    *
0011009909220015 F*                trust summary report                            *
001200020524     F*  5/24/02 szz - Recompiled over new AACODE file                 *
001300071011      * 10/10/07 dlk - convert to use external pgm for grate           *
001400140103   X***X
001500140103   X***X 01.03.2014.SSK.ACA PLAN CHECK
001600140606   X***X 06.06.2014.SSK.REVISED ACA PLAN CHECK
001700140103   X***X
0018009102150016 F******************************************************************  UTL001
0019009909230018 Fmember    IP   e             DISK
0020009909220018 FMCOV      IF   e           k DISK
0021001406060034 FDEPNDC    IF   e           k DISK
0022001406060034 FDCOVC     IF   e           k DISK
0023009909220034 FACCMST    IF   e           k DISK
0024009909220034 FAACODE    IF   e           k DISK
0025009909220020 FPLNMST    IF   e           k DISK
0026001406060021 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
002700140114   X***X
002800140606      /DEFINE CHK_ACA_PLAN_PR
002900140606      /DEFINE CHK_ACA_PLAN_FIELDS
003000140606      /COPY QCPYSRC,ACASRVPGMP
003100140606      /UNDEFINE CHK_ACA_PLAN_PR
003200140606      /UNDEFINE CHK_ACA_PLAN_FIELDS
003300140114   X***X
0034001401140125 D YES             S               N   INZ(*ON)
0035001401140125 D NO              S               N   INZ(*OFF)
0036001401140125 D AM_I_ACA        S               N   INZ(*OFF)
003700140114     D @1              S              1A   INZ
003800140114    ***
0039009909220020 Dtar              S              3  0 DIM(200) inz(0)
0040000710110048 D                 DS
0041000710110055 D tspabct                 1     15
0042000710110055 D mctrst                  1      3  0
0043000710110055 D mcsub#                  4      6  0
0044000710110055 D mcplan                  7     10
0045000710110055 D mcageb                 11     12  0
0046000710110055 D mcovtp                 13     15
004700071011
0048009102150054 D* LDA                                                               DB020
0049009102150055 D                UDS
0050009811120056 D  LMDY                   1      8  0
0051009811120056 D  LMM                    1      2  0
0052009811120056 D  LDD                    3      4  0
0053009811120056 D  LYY                    5      8  0
0054009505080056 D  CONAME               201    240
0055009505090055 D  TIME                 242    247  0
005600140606   X***X
0057009909230293 Imembr
005800990922     I                                          mbtrst        l1
0059009909220293 IACCMSR
006000990922     I              AACODE                      ACOD
006100140606   X***X
006200990922     c                   if        *inl1
006300990922     c                   move      'Y'           newtst            1
006400990922     c                   end
006500140606     C                   EVAL      *IN53 = *OFF
006600990922
006700990817     C     CEXPDT        IFLE      LYMD
006800990817     C                   MOVE      CEXPDT        MDCY#             8
006900990817     C                   EXSR      #MDCY8
007000990817     C                   MOVE      CYMD#         CEXMDY            8 0
0071009908170102 C                   ADD       1             CNT
007200990922     c   of              except    head
007300990817     C                   EXCEPT    ERROR2
007400990817     C                   GOTO      #END
007500990922     C                   END
007600990817     C*
007700990922     C* store trust # for later report
007800990922     C*
007900990923     c                   if        newtst = 'Y'
008000990922     c                   exsr      #storet
008100990922     c                   move      ' '           newtst
008200990922     c                   end
008300990922
0084009801060076 C     MBSSNO        SETLL     MCOV
0085009801060078 C     #T0010        TAG
0086009801060080 C     MBSSNO        READE     MCOV                                   80
008700980106     C     *IN80         CABEQ     *ON           #END
0088009801060060 C*                                                                   UTL001
008900950508     C                   SETOFF                                       5155
0090009102150060 C*                                                                   UTL001
0091009505080060 C*  DATE SELECT FROM LDA                                             UTL001
0092009412160060 C*                                                                   UTL001
009300971009     C     ENRLDT        IFEQ      CANDT
009400980604     C                   GOTO      #T0010
009500971009     C                   END
009600981112     C     ENRLDT        IFGT      LYMD
009700980604     C                   GOTO      #T0010
009800971009     C                   ELSE
009900981112     C     CANDT         IFNE      0
010000981112     C     CANDT         IFLE      LYMD
010100980604     C                   GOTO      #T0010
010200941216     C                   END
010300941216     C                   END
010400941216     C                   END
0105009102150061 C     PLNKEY        CHAIN     PLNMST                             51
010600990922     c                   if        *in51
0107009909220102 C                   ADD       1             CNT               5 0
010800981112     C* REARRANGE DATES FOR PRINTING TO MMDDCCYY FORMAT
010900990922     C                   MOVE      ENRLDT        CYMD#             8
011000990922     C                   EXSR      #CYMD8
011100990922     C                   MOVE      MDCY#         ENRDAT            8 0
011200990922     C                   MOVE      CANDT         CYMD#
011300990922     C                   EXSR      #CYMD8
011400990922     C                   MOVE      MDCY#         CANDAT            8 0
011500990922     c   of              except    head
011600990922     C                   EXCEPT    ERROR
011700990922     C                   GOTO      #T0010
011800990922     c                   end
0119009801060062 C*
012000980604     C     SFADM         CABEQ     'Y'           #T0010
0121009102150062 C*
012200980206     C* VALID RATE NEEDED FOR RUN DATE IF ACTIVE PLAN
012300910701     C*
012400910701     C                   SETON                                        55
012500140606    ***
012600140606    *** CHECK IF ACA PLAN
012700140606    ***
012800140606     C                   MOVE      *BLANKS       @ACA              1
012900140606     C                   EVAL      @ACA = #CHK_ACA_PLAN(MCTRST:MCSUB#:MCPLAN)
013000140606    ***
013100140606    ***
013200981112     C                   EXSR      #FNDRT
013300140606     C                   IF        @ACA = 'Y'
013400140606     C                   EVAL      *IN53 = *ON
013500140606     C                   EXSR      #DEPRT
013600140606     C                   ENDIF
013700910701     C                   SETOFF                                       55
013800980106     C*
013900980106     C                   GOTO      #T0010
014000980106     C*
014100910701     C     #END          TAG
014200990923
014300990923     clr                 except    errorlr
014400990923     clr                 exsr      #printt
014500140606    ***
0146009107010073 C*
0147009107010073 C* FIND RATE
0148009107010073 C*
014900910701     C     #FNDRT        BEGSR
015000140106    ***
015100140106     C     GRPLIST       PLIST
015200140106     C                   PARM                    PARMKEY          15
015300140106     C                   PARM                    PARMSSN           9
015400140106     C                   PARM                    PARMSEQ           2
015500140106     C                   PARM                    PARMEFFYMD        8
015600140106     C                   PARM                    PARMBENAMT        7
015700140106     C                   PARM                    PARMGROUP        15
015800140106     C                   PARM                    PARMBILRTE       11
015900140106     C                   PARM                    PARMNETRTE       11
016000140106     C                   PARM                    PARMBILPREM       7
016100071011     c                   parm                    parmnetprem       7
016200071011     c                   parm                    parmfound         1
016300140606    ***
016400140606     C                   IF        @ACA = 'Y'
016500140606     C                   EVAL      PARMSSN = %EDITC(MBSSNO:'X')
016600140606     C                   EVAL      PARMSEQ = '00'
016700140606     C                   EVAL      *IN53 = *ON
016800140606     C                   ELSE
016900140606     C                   EVAL      *IN53 = *OFF
017000140106     C                   EVAL      PARMSSN = *BLANKS
017100140106     C                   EVAL      PARMSEQ = *BLANKS
017200140606     C                   ENDIF
017300140606     C                   MOVE      *BLANKS       @DSEQ             2
017400140106    ***
017500071011     c                   move      tspabct       parmkey
017600071011     c                   move      lymd          parmeffymd
017700071011     c                   move      benamt        parmbenamt
017800071011     c                   clear                   parmgroup
017900071011     c                   clear                   parmbilrte
018000071011     c                   clear                   parmnetrte
018100071011     c                   clear                   parmbilprem
018200071011     c                   clear                   parmnetprem
018300071011     c                   clear                   parmfound
018400071011
018500071011     c                   call      'GETRATE'     grplist
018600071011
018700140606     C                   EXSR      $RESULT
018800140114    ***
018900140606     C                   ENDSR
019000140606   S***S
019100140606     C     $RESULT       BEGSR
019200140606    ***
0193001406060361 C                   if        parmfound = 'Y'
019400140606     C                   LEAVESR
019500140606     C                   ENDIF
019600140606    ***
019700140606      * grate not returned
019800140606    ***
0199009107010102 C                   ADD       1             CNT
0200009102150096 C                   SETON                                        52
0201009707150143 C*
020200970715     C                   SETOFF                                       87
020300970715     C                   SETOFF                                       97
020400971010     C*
0205009710100144 C     ACCKEY        CHAIN     ACCMST                             87
020600971010     C  N87ACOD          CHAIN     AACODE                             97
020700971010     C  N97              MOVE      *BLANKS       LNAME            10
020800971010     C  N97              MOVEL     ALNAM         LNAME
020900981112     C* REARRANGE DATES FOR PRINTING TO MMDDCCYY FORMAT
021000981112     C                   MOVE      ENRLDT        CYMD#             8
021100981112     C                   EXSR      #CYMD8
021200981112     C                   MOVE      MDCY#         ENRDAT            8 0
021300981112     C                   MOVE      CANDT         CYMD#
021400981112     C                   EXSR      #CYMD8
021500981112     C                   MOVE      MDCY#         CANDAT            8 0
021600990922     c   of              except    head
021700910701     C                   EXCEPT    ERROR
021800140606    ***
021900910701     C                   ENDSR
022000140114   S***S
022100140606     C***********************************************
022200140606     C* FIND RATE FOR DEPENDENTS                    *
022300140606     C***********************************************
022400140606     C     #DEPRT        BEGSR
022500140606    ***
022600140606     C     MBSSNO        CHAIN     DEPENR
022700140606     C                   IF        NOT %FOUND(DEPNDC)
022800140606     C                   LEAVESR
022900140606     C                   ENDIF
023000140606    ***
023100140606     C     KL#SQTSP      KLIST
023200140606     C                   KFLD                    DSSNO
023300140606     C                   KFLD                    DPSEQ#
023400140606     C                   KFLD                    MCTRST
023500140606     C                   KFLD                    MCSUB#
023600140606     C                   KFLD                    MCPLAN
023700140606    ***
023800140606     C     MBSSNO        SETLL     DEPENR
023900140606     C                   DOU       %EOF(DEPNDC)
024000140606     C     MBSSNO        READE     DEPENR
024100140606     C                   IF        NOT %EOF(DEPNDC)
024200140606    ***
024300140606     C     KL#SQTSP      CHAIN     DCOVR
024400140606     C                   IF        NOT %FOUND(DCOVC)
024500140606     C                   ITER
024600140606     C                   ENDIF
024700140606    ***
024800140606     C     KL#SQTSP      SETLL     DCOVR
024900140606     C                   DOU       %EOF(DCOVC)
025000140606     C     KL#SQTSP      READE     DCOVR
025100140606     C                   IF        NOT %EOF(DCOVC) AND
025200140606     C                             DENRDT <= LYMD AND
025300140606     C                             (CCANDT = 0 OR CCANDT > LYMD)
025400140606    ***
025500140606     C                   EVAL      PARMSSN = %EDITC(DSSNO:'X')
025600140606     C                   EVAL      PARMSEQ = %EDITC(DPSEQ#:'X')
025700140606     C                   EVAL      @DSEQ = PARMSEQ
025800140606    ***
025900140606     C                   MOVE      TSPABCT       PARMKEY
026000140606     C                   MOVE      LYMD          PARMEFFYMD
026100140606     C                   MOVE      BENAMT        PARMBENAMT
026200140606     C                   CLEAR                   PARMGROUP
026300140606     C                   CLEAR                   PARMBILRTE
026400140606     C                   CLEAR                   PARMNETRTE
026500140606     C                   CLEAR                   PARMBILPREM
026600140606     C                   CLEAR                   PARMNETPREM
026700140606     C                   CLEAR                   PARMFOUND
026800140606
026900140606     C                   CALL      'GETRATE'     GRPLIST
027000140606
027100140606    ***
027200140606     C                   EXSR      $RESULT
027300140606    ***
027400140606     C                   ENDIF
027500140606     C                   ENDDO
027600140606    ***
027700140606     C                   ENDIF
027800140606     C                   ENDDO
027900140606    ***
028000140606     C                   ENDSR
028100140114   S***S
028200140114   X***X
0283009102150103 C*                                                                   UTL001
028400981112     C*------------------------------------------------------
028500981112     C* Rearrange date / ccyymmdd to mmddccyy
028600981112     C*****************************************************
028700981112     C     #CYMD8        BEGSR
028800981112     C                   MOVE      CYMD#         MMDD#             4
028900981112     C                   MOVEL     CYMD#         CCYY#             4
029000981112     C                   MOVEL     MMDD#         MDCY#             8
029100981112     C                   MOVE      CCYY#         MDCY#
029200981112     C                   ENDSR
029300981112     C*------------------------------------------------------
029400981112     C* Rearrange date / MMDDCCYY to CCYYMMDD
029500981112     C*****************************************************
029600981112     C     #MDCY8        BEGSR
029700981112     C                   MOVEL     MDCY#         MMDD#             4
029800981112     C                   MOVE      MDCY#         CCYY#             4
029900981112     C                   MOVE      MMDD#         CYMD#             8
030000981112     C                   MOVEL     CCYY#         CYMD#
030100981112     C                   ENDSR
0302009909220351 C****************************************************************
0303009909220352 C*    STORE trust #                                             *
0304009909220354 C****************************************************************
030500990922     C*
030600990922     C     #STORET       BEGSR
030700990922     C*
030800990922     C* STORE trust#
030900990922     C*
031000990922     C                   Z-ADD     1             X                 3 0
031100990922     c                   dow       x < 201
031200990922     C     tar(X)        IFEQ      *zeros
031300990922     C                   MOVE      mbtrst        tar(X)
031400990922     C                   leave
031500990922     C                   ELSE
031600990922     C*
031700990922     C     tar(X)        IFEQ      mbtrst
031800990922     C                   leave
031900990922     C                   ELSE
032000990922     C                   ADD       1             X
032100990922     C                   END
032200990923     C                   END
032300990922     C*
032400990922     C                   enddo
032500990922     C*
032600990922     C                   ENDSR
032700990923     C*
0328009909230351 C****************************************************************
0329009909230352 C*    print trust #'s                                           *
0330009909230354 C****************************************************************
033100990923     C*
033200990923     C     #printT       BEGSR
033300990923     C*
033400990923     C* print trust#'s
033500990923     C*
033600990923     C                   Z-ADD     1             X
033700990923     c                   except    head2
033800990923
033900990923     c                   dow       x < 201
034000990923     C     tar(X)        IFne      *zeros
034100990923     C                   MOVE      tar(x)        tst1              3 0
034200990923     C                   add       1             X
034300990923     C                   MOVE      tar(x)        tst2              3 0
034400990923     C                   add       1             X
034500990923     C                   MOVE      tar(x)        tst3              3 0
034600990923     C                   add       1             X
034700990923     C                   MOVE      tar(x)        tst4              3 0
034800990923     C                   add       1             X
034900990923     C                   MOVE      tar(x)        tst5              3 0
035000990923     C                   add       1             X
035100990923     c                   except    line2
035200990923     C                   ELSE
035300990923     C                   leave
035400990923     c                   end
035500990923
035600990923     C                   enddo
035700990923     C*
035800990923     c                   except    line2t
035900990923     C                   ENDSR
0360009811120103 C*****************************************************************   UTL001
036100981112     C     *INZSR        BEGSR
036200981112     C                   MOVE      LMDY          MDCY#             8
036300981112     C                   EXSR      #MDCY8
036400981112     C                   MOVE      CYMD#         LYMD              8 0
036500990922     c     plnkey        klist
036600990922     c                   kfld                    mctrst
036700990922     c                   kfld                    mcsub#
036800990922     c                   kfld                    mcplan
036900990922     c     acckey        klist
037000990922     c                   kfld                    mbtrst
037100990922     c                   kfld                    mbsub#
037200990922     c                   kfld                    mbacct
037300990922
037400990922     c                   except    head
037500981112     C                   ENDSR
0376009102150104 O******************************************************              DB020
0377009102150105 O*  OUTPUT SPECIFICATIONS                             *              DB020
0378009102150106 O******************************************************              DB020
0379009102150107 O*                                                                   DB020
0380001406060108 OREPORT    E            HEAD           2  3
0381001406060110 O                       CONAME              86
0382001406060108 OREPORT    E            HEAD           1
0383009811120113 O                       *DATE         Y     16
0384001406060114 O                                           72 'COBRA PLAN/RATE AUDIT FO'
0385001406060114 O                                           73 'R'
0386001406060114 O                       LMDY          Y     84
0387009102150115 O                                          120 'PAGE :'
0388009707110116 O                       PAGE          Z    130
0389001406060108 OREPORT    E            HEAD           1
0390009801060119 O                                           17 'PROG: DB170 '
0391009102150120 O                                          120 'TIME :'
0392009505090121 O                       TIME               130 '  :  :  '
0393001406060108 OREPORT    E            HEAD           1
0394009102150124 O                                           24 '------------------------'
0395009102150125 O                                           48 '------------------------'
0396009102150126 O                                           72 '------------------------'
0397009102150127 O                                           96 '------------------------'
0398009102150128 O                                          120 '------------------------'
0399009102150129 O                                          132 '------------'
0400001406060108 OREPORT    E            HEAD           1
0401009707150132 O                                            8 'SS#'
040200140606     O                                           16 'SEQ'
0403001406060133 O                                           26 'T/S/A'
0404001406060133 O                                           36 'PLAN'
0405001406060134 O                                           47 'AGE BAND'
0406001406060135 O                                           58 'COV TYPE'
0407001406060136 O                                           71 'PLAN ERROR'
0408001406060137 O                                           84 'RATE ERROR'
040900140606     O                                           98 'ENROLL DATE'
041000140606     O                                          112 'CANCEL DATE'
041100970710     O*
041200140606     O                                          119 'CODE'
041300140606     O                                          129 'AA NAME'
0414001406060108 OREPORT    E            HEAD           1
0415001406060141 O                                           24 '------------------------'
0416001406060142 O                                           48 '------------------------'
0417001406060143 O                                           72 '------------------------'
0418001406060144 O                                           96 '------------------------'
0419001406060145 O                                          120 '------------------------'
0420001406060146 O                                          132 '------------'
0421009909220147 OREPORT    E            ERROR          1
0422009909220149 O                       MBSSNO              12 '0   -  -    '
042300140606     O                       @DSEQ               15
0424001406060150 O                       MCTRST              20
042500140606     O                                           21 '-'
0426001406060150 O                       MCSUB#              24
042700140606     O                                           25 '-'
0428001406060150 O                       ACC#                29
0429001406060151 O                       MCPLAN              36
0430001406060151 O                       MCAGEB              44
0431001406060152 O                       MCOVTP              55
0432001406060153 O               51                          66 'Y'
0433001406060154 O               52                          77 'Y'
0434001406060154 O               53                          82 'ACA'
0435001406060032 O                       ENRDAT        Y     98
0436001406060036 O                       CANDAT        Y    112
043700140606     O                       ACOD               119
043800140606     O                       LNAME              132
043900140606 147 OREPORT    E            ERROR2         1
0440009908170149 O                       MBSSNO              12 '0   -  -    '
0441001406060150 O                       MBTRST              20
044200140606     O                                           21 '-'
0443001406060150 O                       MBSUB#              24
044400140606     O                                           25 '-'
0445001406060150 O                       MBACCT              29
0446001406060150 O                                           48 '* COBRA EXPIRES :'
0447001406060150 O                       CEXMDY        Y     59
044800910215 147 OREPORT    E            ERRORLR        1
0449009102150157 O                                           29 '*** TOTAL ERRORS:'
0450009102150158 O                       CNT           ZB    38
0451001406060108 OREPORT    E            HEAD2          2  3
045200990923
045300990923     o* 2nd report to list all trusts with active cobra members
045400990923
0455001406060110 O                       CONAME              86
0456001406060108 OREPORT    E            HEAD2          1
0457009909220113 O                       *DATE         Y     16
0458001406060114 O                                           72 'TRUSTS WITH COBRA MEMBER'
0459001406060114 O                                           73 'S'
0460001406060114 O                       LMDY          Y     84
0461009909220115 O                                          122 'PAGE : 1'
0462001406060108 OREPORT    E            HEAD2          1
0463009909220119 O                                           17 'PROG: DB170 '
0464009909220120 O                                          120 'TIME :'
0465009909220121 O                       TIME               130 '  :  :  '
0466001406060108 OREPORT    E            HEAD2          1
0467009909220124 O                                           24 '------------------------'
0468009909220125 O                                           48 '------------------------'
0469009909220126 O                                           72 '------------------------'
0470009909220127 O                                           96 '------------------------'
0471009909220128 O                                          120 '------------------------'
0472009909220129 O                                          132 '------------'
0473001406060108 OREPORT    E            HEAD2          1
0474009909230132 O                                            5 'TRUST'
0475009909230132 O                                           13 'TRUST'
0476009909230132 O                                           21 'TRUST'
0477009909230132 O                                           29 'TRUST'
0478009909230132 O                                           37 'TRUST'
0479001406060108 OREPORT    E            HEAD2          2
0480009909220141 O                                           24 '------------------------'
0481009909220142 O                                           48 '------------------------'
0482009909220143 O                                           72 '------------------------'
0483009909220144 O                                           96 '------------------------'
0484009909220145 O                                          120 '------------------------'
0485009909220146 O                                          132 '------------'
0486009909230147 OREPORT    E            LINE2          1
0487009909230149 O                       TST1          4B     5
0488009909230149 O                       TST2          4B    13
0489009909230149 O                       TST3          4B    21
0490009909230149 O                       TST4          4B    29
0491009909230132 O                       TST5          4B    37
0492009909230147 OREPORT    E            LINE2T         1
0493009909230149 O                                           17 '** END OF LIST **'
