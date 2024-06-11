000100140228     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN')
000200140228     H ALWNULL(*USRCTL)
0003009907140002 F******************************************************************
0004009908030003 F* DB054      GROUP BENEFIT SERVICES SOFTWARE                     *
0005009907140004 F*                                                                *
0006009907140005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0007009908030006 F*            DATE -  8/03/99                                     *
0008009907140007 F*                                                                *
0009009908030013 F*  DESCRIPTION - copy of db052 for tr015 to run - only select    *
0010009908030014 F*            accts in exclusion file for the trusts selected     *
0011009907140015 F*                                                                *
001200011211     f* 12/11/01 dlk - exclude plans billed to cobra members           *
0013000203180015 F*                                                                *
001400020318     F*  3/18/02 szz - Retrieve selected trusts from TRSSEL instead    *
001500020318     F*                 of LDA array.                                  *
001600020524     F*  5/24/02 szz - Recompiled over new AACODE file                 *
001700071010      * 10/10/07 dlk - convert to use external pgm for grate           *
001800140228    ***
001801140625     F* 10/31/13 dlk  remove indicator U8 useage
001900140228    *** 02/28/2014 SSK RE-MOD TO OTF AND KEEP ACA PRT
002000140228    ***
002100140228    ***
002200140228    ***
002300140228    ***
0024000112110015 F*                                                                *
0025009907140016 F******************************************************************
0026009907140018 FMCOV      IP   E             DISK
0027009907140034 FACCMST    IF   E           K DISK
0028009907140034 FAACODE    IF   E           K DISK
002900020318     FTRSSLC    IF   E           k DISK
0030000112110019 Fmember    IF   e           k DISK
0031001402280034 FDEPNDC    IF   e           k DISK
0032001402280034 FDCOVC     IF   e           k DISK
0033000112110019 Fplnmst    IF   e           k DISK
0034009908030019 FINVEXC    uf   E           k DISK
0035009908050019 F**hist      O  A E             DISK
0036009505090021 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
003700140228   X***X
0038009907140049 Dlname            s             10
0039009908040049 Draterr_pln       s              1
0040009908040049 Draterr_act       s              1
0041009908030049 Dokact            s              1
004200140228    ***
0043000710100055 D                 DS
0044000710100055 D tspabct                 1     15
0045000710100055 D mctrst                  1      3  0
0046000710100055 D mcsub#                  4      6  0
0047000710100055 D mcplan                  7     10
0048000710100055 D mcageb                 11     12  0
0049000710100055 D mcovtp                 13     15
005000140228    ***
0051000112110048 D                 DS
0052000112110049 D  enrldt                 1      8  0
0053000112110049 D  enrlym                 1      6  0
005400140228    ***
0055001402280048 D                 DS
0056001402280049 D  DENRDT                 1      8  0
0057001402280049 D  DENRYM                 1      6  0
005800140228    ***
0059009907130048 D                 DS
006000140228     D @LCYMD                  1      8A
0061009907130049 D  LYMD                   1      8  0
0062000112110049 D  LYM                    1      6  0
0063009907130050 D  LYY                    1      4  0
0064009907130051 D  LMM                    5      6  0
0065009907130051 D  LDD                    7      8  0
006600140228    ***
0067001402280054 D* LDA
0068009102150055 D                UDS
0069009907130063 D  LMONTH                 1      2  0
0070009907130064 D  LYEAR                  3      6  0
0071009908020064 D  LUSER                 25     32
0072001402280067 D  TAR                  100    171  0 DIM(24)
0073009505080056 D  CONAME               201    240
007400140228    ***
007500140228     D @ACA            S              1A   INZ
007600140228   X***X
007700140228      /DEFINE CHK_ACA_PLAN_PR
007800140228      /DEFINE CHK_ACA_PLAN_FIELDS
007900140228      /COPY QCPYSRC,ACASRVPGMP
008000140228      /UNDEFINE CHK_ACA_PLAN_PR
008100140228      /UNDEFINE CHK_ACA_PLAN_FIELDS
008200140228   X***X
0083009907140022 IMCOVR
0084009907140027 I                                          MCTRST        L2
0085009907140028 I                                          MCSUB#        L2
0086009907140036 I                                          ACC#          L2
0087009907140029 I                                          MCPLAN        L1
0088009907140030 I                                          MCAGEB        L1
0089009907140031 I                                          MCOVTP        L1
009000140228    ***
0091009907140293 IACCMSR
009200990713     I              AACODE                      ACOD
009300140228   X***X
009400990803     c* on acc change check for hit in invexc file, if there ok to process
009500990803     c* else skip this account
009600990803
009700990803     c                   if        *inL2
009800990803     C                   eval      newacc = 'Y'
009900990804     C                   eval      raterr_act = ' '
010000990803     c     acckey        chain     invexc                             55
010100990803     c                   if        *in55
010200990803     c                   eval      okact = 'N'
010300990803     c                   else
010400990803     c                   if        ieeff = lymd
010500990803     c                   eval      okact = 'Y'
010600990803     c                   endif
010700990803     c                   endif
010800990803     c                   endif
010900990803
011000990804     C   L1              eval      raterr_pln = ' '
011100990803
011200990804     c* skip all members in acct if acct was not in invexc file
011300990803
011400990803     c                   if        okact <> 'Y'
011500990803     c                   goto      #end
011600990803     c                   endif
011700990804
011800990804     c* only check until a rate error is found, skip rest of this
011900990804     c* t/s/a/p/ab/ct
012000990804
012100990804     C                   IF        raterr_pln = ' '
0122009908040060 C*
0123009908040060 C*  DATE SELECT FROM LDA
0124009908040060 C*
012500011211     c                   if        mcdltd = 'D' or enrldt = candt or
012600011211     c                             enrlym > lym or (candt <> 0 and
012700011211     c                             candt <= lymd)
012800941216     C                   GOTO      #END
012900941216     C                   END
013000011211
013100011211     c* skip plans only billed to COBRA members
013200011211
013300011211     c     mcssno        chain     member                             55
013400011211     c   55              goto      #end
013500011211     c                   if        cexpdt <> 0
013600011211     c     plnkey        chain     plnmst                             56
013700011211     c   56              goto      #end
013800011211     c                   if        sfadm <> 'Y' or cexpdt <= lymd
013900011211     c                   goto      #end
014000011211     c                   end
014100011211     c                   end
014200140228    ***
014300140228     C                   SETOFF                                         54
014400140228    ***
014500140228    *** CHECK IF ACA PLAN
014600140228    ***
014700140228     C                   EVAL      @ACA = #CHK_ACA_PLAN(MCTRST:MCSUB#:MCPLAN)
014800140228    ***
014900140228    ***
015000140228     C* VALID RATE NEEDED FOR RUN DATE
015100140228
015200140228     C                   EXSR      #FNDRT
015300140228     C                   IF        @ACA = 'Y'
015400140228     C                   EXSR      #DEPRT
015500140228     C                   ENDIF
015600140228    ***
015700990701     C                   END
015800990701     C*
015900910701     C     #END          TAG
016000990804
016100990804     C* update invexc record to clear ienor flag. account has no rate error
016200990804     C* so select in later programs within TR015cl
016300990804
016400140625     cl2                 if        okact = 'Y' and raterr_act = ' '
016500990804     cl2                 eval      ienor  = ' '
016600990804     Cl2                 update    INVER
016700990804     cl2                 endif
016800140228    ***
016900140228   S***S
0170009907010073 C***********************************************
0171009907010073 C* FIND RATE                                   *
0172009907010073 C***********************************************
017300910701     C     #FNDRT        BEGSR
017400140228    ***
017500140228     C                   IF        @ACA = 'Y'
017600140228     C                   EVAL      *IN55 = *OFF
017700140228     C                   EVAL      *IN54 = *ON
017800140228     C                   EVAL      PARMSSN = %EDITC(MBSSNO:'X')
017900140228     C                   EVAL      PARMSEQ = '00'
018000140228     C                   ELSE
018100140228     C                   EVAL      *IN54 = *OFF
018200140228     C                   EVAL      PARMSSN = *BLANKS
018300140228     C                   EVAL      PARMSEQ = *BLANKS
018400140228     C                   ENDIF
018500140228    ***
018600071010     c                   move      tspabct       parmkey
018700071010     c                   move      lymd          parmeffymd
018800071011     c                   move      benamt        parmbenamt
018900071010     c                   clear                   parmgroup
019000071010     c                   clear                   parmbilrte
019100071010     c                   clear                   parmnetrte
019200071010     c                   clear                   parmbilprem
019300071010     c                   clear                   parmnetprem
019400071010     c                   clear                   parmfound
019500071010
019600071010     c                   call      'GETRATE'     grplist
019700140228    ***
019800140228     C                   EXSR      $RESULT
019900140228    ***
020000140228     C                   ENDSR
020100140228   S***S
020200140228     C     $RESULT       BEGSR
020300071010      * grate not returned
0204000710100361 C                   if        parmfound <> 'Y'
0205009907130102 C                   ADD       1             CNT               5 0
020600971010     C*
020700990714     C                   eval      lname = *blanks
0208009710100144 C     ACCKEY        CHAIN     ACCMST                             87
020900990714     C*
021000990714     c                   if        not *in87
021100990714     C     ACOD          CHAIN     AACODE                             97
021200990714     c                   if        not *in97
021300990714     C                   MOVEL     ALNAM         LNAME
021400990714     c                   end
021500990714     c                   end
021600990713     C*
021700990714     C                   IF        newacc = 'Y'
021900990803
022000990803     C* update invexc record to show this account is still missing
022100990803     C* rates so do not select in later programs within TR015cl
022200990803
022300990803     c                   eval      ienor  = 'Y'
022400990803     C                   update    INVER
022500990805     c*
022600990805     c* no hist rec needed for batch rerun
022700990805     c*
022800990805     c*                  eval      trcode = 'UEI'
022900990805     c*                  eval      hkey   = tsa
023000990805     c*                  eval      tramt  = *zeros
023100990805     c*                  eval      hprgnm = 'DB54'
023200990805     c*                  eval      hstrst = mctrst
023300990805     c*                  eval      hssub# = mcsub#
023400990805     c*                  eval      hsacct = acc#
023500990805     c*                  eval      hoper  = luser
023600990805     c*                  eval      hsdltd = 'A'
023700990805     c*                  eval      trdate = rundat
023800990805     c*                  eval      covtdt = lymd
023900990805     C*                  write     histr
024000990805
024200990713     C                   MOVE      'N'           NEWACC            1
0243009907130097 C                   END
024400990713     C*
024500910701     C                   EXCEPT    ERROR
024600990804     C                   MOVE      'Y'           raterr_pln
024700990804     C                   MOVE      'Y'           raterr_act
0248009102150097 C                   END
0249009102150098 C*
025000910701     C                   ENDSR
025100140228   S***S
025200140228     C***********************************************
025300140228     C* FIND RATE FOR DEPENDENTS                    *
025400140228     C***********************************************
025500140228     C     #DEPRT        BEGSR
025600140228    ***
025700140228     C     MCSSNO        CHAIN     DEPENR
025800140228     C                   IF        NOT %FOUND(DEPNDC)
025900140228     C                   LEAVESR
026000140228     C                   ENDIF
026100140228    ***
026200140228     C     MCSSNO        SETLL     DEPENR
026300140228     C                   DOU       %EOF(DEPNDC)
026400140228     C     MCSSNO        READE     DEPENR
026500140228     C                   IF        NOT %EOF(DEPNDC)
026600140228    ***
026700140228     C     KL#SQTSP      CHAIN     DCOVR
026800140228     C                   IF        NOT %FOUND(DCOVC)
026900140228     C                   ITER
027000140228     C                   ENDIF
027100140228    ***
027200140228     C     KL#SQTSP      SETLL     DCOVR
027300140228     C                   DOU       %EOF(DCOVC)
027400140228     C     KL#SQTSP      READE     DCOVR
027500140228     C                   IF        NOT %EOF(DCOVC) AND DVDLTD <> 'D' AND
027600140228     C                             DENRDT <> CCANDT AND
027700140228     C                             DENRYM <= LYM AND
027800140228     C                             (CCANDT = 0 OR CCANDT > LYMD)
027900140228    ***
028000140228     C                   EVAL      *IN55 = *ON
028100140228     C                   EVAL      *IN54 = *ON
028200140228     C                   EVAL      PARMSSN = %EDITC(DSSNO:'X')
028300140228     C                   EVAL      PARMSEQ = %EDITC(DPSEQ#:'X')
028400140228    ***
028500140228     C                   MOVE      TSPABCT       PARMKEY
028600140228     C                   MOVE      LYMD          PARMEFFYMD
028700140228     C                   MOVE      BENAMT        PARMBENAMT
028800140228     C                   CLEAR                   PARMGROUP
028900140228     C                   CLEAR                   PARMBILRTE
029000140228     C                   CLEAR                   PARMNETRTE
029100140228     C                   CLEAR                   PARMBILPREM
029200140228     C                   CLEAR                   PARMNETPREM
029300140228     C                   CLEAR                   PARMFOUND
029400140228    ***
029500140228     C                   CALL      'GETRATE'     GRPLIST
029600140228    ***
029700140228     C                   EXSR      $RESULT
029800140228    ***
029900140228     C                   ENDIF
030000140228     C                   ENDDO
030100140228    ***
030200140228     C                   ENDIF
030300140228     C                   ENDDO
030400140228    ***
030500140228     C                   ENDSR
030600140228   S***S
030700990713     C     *INZSR        BEGSR
030800140228    ***
030900140228     c     grplist       plist
031000140228     c                   parm                    parmkey          15
031100140228     C                   PARM                    PARMSSN           9
031200140228     C                   PARM                    PARMSEQ           2
031300140228     c                   parm                    parmeffymd        8
031400140228     c                   parm                    parmbenamt        7
031500140228     c                   parm                    parmgroup        15
031600140228     c                   parm                    parmbilrte       11
031700140228     c                   parm                    parmnetrte       11
031800140228     c                   parm                    parmbilprem       7
031900140228     c                   parm                    parmnetprem       7
032000140228     c                   parm                    parmfound         1
032100140228    ***
032200140228     C     KL#SQTSP      KLIST
032300140228     C                   KFLD                    DSSNO
032400140228     C                   KFLD                    DSEQ#
032500140228     C                   KFLD                    MCTRST
032600140228     C                   KFLD                    MCSUB#
032700140228     C                   KFLD                    MCPLAN
032800140228    ***
0329009907130060 C                   Z-ADD     1             LDD
0330009907130065 C                   Z-ADD     LYEAR         LYY
0331009907130066 C                   Z-ADD     LMONTH        LMM
033200990720     c                   time                    htime             6 0
033300990802      *
033400990802     C                   MOVEL     *YEAR         RUNDAT            8 0
033500990802     C                   MOVEL     *MONTH        RUNMD             4 0
033600990802     C                   MOVE      *DAY          RUNMD
033700990802     C                   MOVE      RUNMD         RUNDAT
033800020325      *---
033900020325      * List trusts selected out of TRSSLC file
034000020325      *---
034100020325     C                   Except    TRSTTI
034200020325     C                   Move      *Off          *InOF
034300020325     C                   Read      TRSSLC
034400020325     C                   Dou       %Eof
034500020325     C                   If        Not %Eof
034600020325     C     Trust_Ctr     Doueq     *Zero
034700020325     C                   Add       1             Trust_Ctr         2 0
034800020325     C                   Select
034900020325     C     Trust_Ctr     Wheneq    1
035000020325     C                   Clear                   Tr1               3 0
035100020325     C                   Clear                   Tr2               3 0
035200020325     C                   Clear                   Tr3               3 0
035300020325     C                   Clear                   Tr4               3 0
035400020325     C                   Clear                   Tr5               3 0
035500020325     C                   Clear                   Tr6               3 0
035600020325     C                   Clear                   Tr7               3 0
035700020325     C                   Clear                   Tr8               3 0
035800020325     C                   Clear                   Tr9               3 0
035900020325     C                   Clear                   Tr10              3 0
036000020325     C                   Clear                   Tr11              3 0
036100020325     C                   Clear                   Tr12              3 0
036200020325     C                   Clear                   Tr13              3 0
036300020325     C                   Clear                   Tr14              3 0
036400020325     C                   Clear                   Tr15              3 0
036500020325     C                   Clear                   Tr16              3 0
036600020325     C                   Clear                   Tr17              3 0
036700020325     C                   Clear                   Tr18              3 0
036800020325     C                   Clear                   Tr19              3 0
036900020325     C                   Clear                   Tr20              3 0
037000020325     C                   Clear                   Tr21              3 0
037100020325     C                   Clear                   Tr22              3 0
037200020325     C                   Clear                   Tr23              3 0
037300020325     C                   Clear                   Tr24              3 0
037400020325     C                   Clear                   Tr25              3 0
037500020325     C                   Clear                   Tr26              3 0
037600020325     C                   Movel     TRTRST        Tr1
037700020325     C     Trust_Ctr     Wheneq    2
037800020325     C                   Move      TRTRST        Tr2
037900020325     C     Trust_Ctr     Wheneq    3
038000020325     C                   Move      TRTRST        Tr3
038100020325     C     Trust_Ctr     Wheneq    4
038200020325     C                   Move      TRTRST        Tr4
038300020325     C     Trust_Ctr     Wheneq    5
038400020325     C                   Move      TRTRST        Tr5
038500020325     C     Trust_Ctr     Wheneq    6
038600020325     C                   Move      TRTRST        Tr6
038700020325     C     Trust_Ctr     Wheneq    7
038800020325     C                   Move      TRTRST        Tr7
038900020325     C     Trust_Ctr     Wheneq    8
039000020325     C                   Move      TRTRST        Tr8
039100020325     C     Trust_Ctr     Wheneq    9
039200020325     C                   Move      TRTRST        Tr9
039300020325     C     Trust_Ctr     Wheneq    10
039400020325     C                   Move      TRTRST        Tr10
039500020325     C     Trust_Ctr     Wheneq    11
039600020325     C                   Move      TRTRST        Tr11
039700020325     C     Trust_Ctr     Wheneq    12
039800020325     C                   Move      TRTRST        Tr12
039900020325     C     Trust_Ctr     Wheneq    13
040000020325     C                   Move      TRTRST        Tr13
040100020325     C     Trust_Ctr     Wheneq    14
040200020325     C                   Move      TRTRST        Tr14
040300020325     C     Trust_Ctr     Wheneq    15
040400020325     C                   Move      TRTRST        Tr15
040500020325     C     Trust_Ctr     Wheneq    16
040600020325     C                   Move      TRTRST        Tr16
040700020325     C     Trust_Ctr     Wheneq    17
040800020325     C                   Move      TRTRST        Tr17
040900020325     C     Trust_Ctr     Wheneq    18
041000020325     C                   Move      TRTRST        Tr18
041100020325     C     Trust_Ctr     Wheneq    19
041200020325     C                   Move      TRTRST        Tr19
041300020325     C     Trust_Ctr     Wheneq    20
041400020325     C                   Move      TRTRST        Tr20
041500020325     C     Trust_Ctr     Wheneq    21
041600020325     C                   Move      TRTRST        Tr21
041700020325     C     Trust_Ctr     Wheneq    22
041800020325     C                   Move      TRTRST        Tr22
041900020325     C     Trust_Ctr     Wheneq    23
042000020325     C                   Move      TRTRST        Tr23
042100020325     C     Trust_Ctr     Wheneq    24
042200020325     C                   Move      TRTRST        Tr24
042300020325     C     Trust_Ctr     Wheneq    25
042400020325     C                   Move      TRTRST        Tr25
042500020325     C     Trust_Ctr     Wheneq    26
042600020325     C                   Move      TRTRST        Tr26
042700020325     C     *InOF         Ifeq      *On
042800020325     C                   Move      *Off          *InOF
042900020325     C                   Except    TRSTTI
043000020325     C                   End
043100020325     C                   Except    TRUSTS
043200020325     C                   Z-add     *Zeros        Trust_Ctr
043300020325     C                   Endsl
043400020325     C                   Read      TRSSLC
043500020325     C                   If        %Eof
043600020325     C                   Z-add     *Zeros        Trust_Ctr
043700020325     C     Trust_Ctr     Ifne      26
043800020325     C     *InOF         Ifeq      *On
043900020325     C                   Move      *Off          *InOF
044000020325     C                   Except    TRSTTI
044100020325     C                   End
044200020325     C                   Except    TRUSTS
044300020325     C                   End
044400020325     C                   End
044500020325     C                   Enddo
044600020325     C                   Else
044700020325     C                   Z-add     *Zeros        Trust_Ctr
044800020325     C                   End
044900020325     C                   Enddo
045000140228    ***
045100990713     C     ACCKEY        KLIST
045200990713     C                   KFLD                    MCTRST
045300990713     C                   KFLD                    MCSUB#
045400990713     C                   KFLD                    ACC#
045500140228    ***
045600011211     c     plnkey        klist
045700011211     c                   kfld                    mctrst
045800011211     c                   kfld                    mcsub#
045900011211     c                   kfld                    mcplan
046000140228    ***
046100990713     C                   ENDSR
0462009907130058 C*
0463009102150104 O******************************************************              DB020
0464009102150105 O*  OUTPUT SPECIFICATIONS                             *              DB020
0465009102150106 O******************************************************              DB020
0466009102150107 O*                                                                   DB020
0467009102150108 OREPORT    H    1P                     2 03
0468009102150109 O         OR    OF
0469009102150110 O                       CONAME              87
0470009102150111 O          H    1P                     1
0471009102150112 O         OR    OF
0472009811110113 O                       *DATE         Y     16
0473009907140114 O                                           55 'NO RATES FOR'
047400990714     O                       LMONTH              58
047500990714     O                                           59 '/'
047600990714     O                       LYEAR               63
0477009908030114 O                                           88 'INVOICE - ACCOUNTS STILL'
0478009908030114 O                                           97 ' EXCLUDED'
0479009102150115 O                                          120 'PAGE :'
0480009707110116 O                       PAGE          Z    130
0481009102150117 O          H    1P                     1
0482009102150118 O         OR    OF
0483009908030119 O                                           17 'PROG: DB054 '
0484009102150120 O                                          120 'TIME :'
0485009907200121 O                       htime              130 '  :  :  '
0486009907130122 O          H    1P                     1
0487009907130123 O         OR    OF
0488009102150122 O          H    1P                     1
0489009102150123 O         OR    OF
0490009102150124 O                                           24 '------------------------'
0491009102150125 O                                           48 '------------------------'
0492009102150126 O                                           72 '------------------------'
0493009102150127 O                                           96 '------------------------'
0494009102150128 O                                          120 '------------------------'
0495009102150129 O                                          132 '------------'
0496009102150130 O          H    1P                     1
0497009102150131 O         OR    OF
0498009707150133 O                                           23 'T/S/A'
0499009603140133 O                                           32 'PLAN'
0500009603140134 O                                           43 'AGE BAND'
0501009603140135 O                                           53 'COV TYPE'
050200990701     O                                          119 'CODE'
050300970715     O                                          129 'AA NAME'
0504009102150139 O          H    1P                     1
0505009102150140 O         OR    OF
0506009102150141 O                                           24 '------------------------'
0507009102150142 O                                           48 '------------------------'
0508009102150143 O                                           72 '------------------------'
0509009102150144 O                                           96 '------------------------'
0510009102150145 O                                          120 '------------------------'
0511009102150146 O                                          132 '------------'
0512000203180122 O          H    1P                     1
0513000203180123 O         OR    OF
051400020325      *---
051500020325      * Trusts Selected
051600020325      *---
0517000203250147 O          E            TRSTTI         1
0518000203250110 O                       CONAME              87
0519000203250147 O          E            TRSTTI         1
0520000203250113 O                       *DATE         Y     16
0521000203250114 O                                           55 'NO RATES FOR'
052200020325     O                       LMONTH              58
052300020325     O                                           59 '/'
052400020325     O                       LYEAR               63
0525000203250114 O                                           88 'INVOICE - ACCOUNTS EXCLU'
0526000203250114 O                                           91 'DED'
0527000203250147 O          E            TRSTTI         1
0528000203250115 O                                          120 'PAGE :'
0529000203250116 O                       PAGE          Z    130
0530000203250119 O                                           17 'PROG: DB054 '
0531000203250147 O          E            TRSTTI         2
0532000203250120 O                                          120 'TIME :'
0533000203250121 O                       htime              130 '  :  :  '
0534000203250147 O          E            TRSTTI         1
053500020325     O                                           18 'TRUSTS SELECTED:'
0536000203250147 O          E            TRUSTS         1
053700020325     O                       Tr1           Z      5
053800020325     O                       Tr2           Z     10
053900020325     O                       Tr3           Z     15
054000020325     O                       Tr4           Z     20
054100020325     O                       Tr5           Z     25
054200020325     O                       Tr6           Z     30
054300020325     O                       Tr7           Z     35
054400020325     O                       Tr8           Z     40
054500020325     O                       Tr9           Z     45
054600020325     O                       Tr10          Z     50
054700020325     O                       Tr11          Z     55
054800020325     O                       Tr12          Z     60
054900020325     O                       Tr13          Z     65
055000020325     O                       Tr14          Z     70
055100020325     O                       Tr15          Z     75
055200020325     O                       Tr16          Z     80
055300020325     O                       Tr17          Z     85
055400020325     O                       Tr18          Z     90
055500020325     O                       Tr19          Z     95
055600020325     O                       Tr20          Z    100
055700020325     O                       Tr21          Z    105
055800020325     O                       Tr22          Z    110
055900020325     O                       Tr21          Z    115
056000020325     O                       Tr24          Z    120
056100020325     O                       Tr25          Z    125
056200020325     O                       Tr26          Z    130
0563001402280147 OREPORT    E            ERROR          1
056400140228     O               54                           7 'ACA'
056500140228     O               54N55                       12 'MBR'
056600140228     O               54 55                       12 'DEP'
0567009907130150 O                       MCTRST              17
056800960314     O                                           18 '-'
0569009907140150 O                       MCSUB#              21
057000960314     O                                           22 '-'
0571009603140150 O                       ACC#                26
0572009907140151 O                       MCPLAN              32
0573009907140151 O                       MCAGEB              39
0574009907140152 O                       MCOVTP              49
057500970711     O                       ACOD               118
057600970715     O                       LNAME              132
0577009102150156 O          T    LR                  3
0578009102150157 O                                           29 '*** TOTAL ERRORS:'
0579009102150158 O                       CNT           ZB    38
