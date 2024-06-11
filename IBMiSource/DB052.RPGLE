000100140228     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN')
000200140228     H ALWNULL(*USRCTL)
000300140228   X***X
0004009907140002 F******************************************************************
0005009907140003 F* DB052      GROUP BENEFIT SERVICES SOFTWARE                     *
0006009907140004 F*                                                                *
0007009907140005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0008009907140006 F*            DATE -  7/13/99                                     *
0009009907140007 F*                                                                *
0010009907140013 F*  DESCRIPTION - THIS PROGRAM WILL SERVE AS A PRE-INVOICE        *
0011009907140014 F*            AUDIT THAT CHECKS FOR A VALID RATE FOR THE          *
0012009907140015 F*            EFFECTIVE DATE THAT IS PASSED FROM THE INVOICE      *
0013009907140015 F*            PROGRAM TR010. ANY ACCTS WITHOUT RATES WILL         *
0014009907140015 F*            BE ADDED TO THE INVOICE EXCLUSION FILE.             *
0015009907140015 F*                                                                *
001600011211     f*  12/11/01 dlk - exclude plans billed to cobra members          *
001700020318     F*   3/18/02 szz - Retrieve selected trusts from TRSSEL instead   *
001800020325     F*                 of from LDA array.                             *
001900020416     F*   4/15/02 szz - Add letter for premium invoicing delay.        *
002000020524     F*  5/24/02 szz - Recompiled over new AACODE file                 *
002100020806     F*  8/06/02 DLK - fix "pos" field size                            *
002200031010     F* 10/10/03 KSJ - Replace DB052PR w/DB052PR2.  New PRTF           *
0023000310100015 F*                prints two pages: Premium Invoicing Delay       *
0024000310100015 F*                Letter on page 1 and the Client Info            *
0025000310100015 F*                Update Letter & Form on page 2.                 *
002600051108     F* 11/08/05 DLK - remove ac2mst from F spec, not used in pgm      *
002700071010      * 10/10/07 dlk - convert to use external pgm for grate           *
002800081020      * 10/20/08 dlk - stop printing client update ltr / form          *
002900130214      * 02/14/13 dlk - stop printing prem invoice delay ltr - Ron Maas *
003000130214      *                request                                         *
003100130729      * 07/29/13 dlk - start printing prem invoice delay ltr again with *
003200130729      *                different text - Candace request                *
003300131003      * 10/03/13 dlk  hist file expansion project
003400140625      * 10/31/13 dlk  remove indicator U8 useage
003500140228    ***
003600140228    *** 02/28/2014 SSK RE-MOD TO OTF AND KEEP ACA PRT
003700140310      * 03/10/14 dlk - fix heading trust selection, TR23 was missing
003800140512      * 04/24/14 dpb - per Shelly R - for each acct written to INVEXC
003900140512      *                also remove from INVPRI. Also use ACASRVPGM instead
004000140512      *                of HCRSRVPGM.
004100181203      * 12/03/18 dlk - remove the word "premium"
004200220307      * 03/07/22 dlk - added mailing address line 2 and remove invoice
004300220307      *                delay letter that was stopped in 2008
004400220307      *
0045009907140016 F******************************************************************
0046009907140018 FMCOV      IP   E             DISK
0047009907140034 FACCMST    IF   E           K DISK
0048009907140034 FAACODE    IF   E           K DISK
004900020318     FTRSSLC    IF   E           k DISK
0050000112110019 Fmember    IF   e           k DISK
0051001402280034 FDEPNDC    IF   e           k DISK
0052001402280034 FDCOVC     IF   e           k DISK
0053000112110019 Fplnmst    IF   e           k DISK
005400140512     Finvpri    uf   e           k disk
0055009907130019 FINVEXC    O  A E             DISK
0056009908020019 Fhist      O  A E             DISK
0057009505090021 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
005800031007     FDB052PR2  O    E             Printer Oflind(*In91)
005900140228   X***X
0060001310030037 D sysdateymd      S               d   datfmt(*iso)
006100131003     D thispgmname     S             10a   inz('DB052     ')
0062000310070049 Dlname            s             10
0063009907140049 Draterr           s              1
0064001307310049 Dmonth            s             10
0065001307310049 Dretxtout         s             60
0066001812030049 Dretxt            c                   'Invoicing delay for the month of'
0067002203070049 Dcsz              s             40
006800140228    ***
0069000310070037 D workdt          S               d   datfmt(*iso)
0070000310070040 D TAB1            S              2  0 DIM(12) CTDATA PERRCD(1)
0071000310070040 D TAB2            S             10    DIM(12) ALT(TAB1)
007200140228    ***
0073000710100055 D                 DS
0074000710100055 D tspabct                 1     15
0075000710100055 D kt                      1      3  0
0076000710100055 D ks                      4      6  0
0077000710100055 D kp                      7     10
0078000710100055 D kab                    11     12  0
0079000710100055 D kct                    13     15
008000140228    ***
0081001402280048 D                 DS
0082001402280049 D  DENRDT                 1      8  0
0083001402280049 D  DENRYM                 1      6  0
008400140228    ***
0085000112110048 D                 DS
0086000112110049 D  enrldt                 1      8  0
0087000112110049 D  enrlym                 1      6  0
008800140228    ***
0089009907130048 D                 DS
0090009907130049 D  LYMD                   1      8  0
0091000112110049 D  LYM                    1      6  0
0092009907130050 D  LYY                    1      4  0
0093009907130051 D  LMM                    5      6  0
0094009907130051 D  LDD                    7      8  0
009500140228    ***
0096009908020048 D                 DS
0097009908020049 D  tsa                    1     10
0098009908020050 D  mctrst                 1      3  0
0099009908020051 D  mcsub#                 4      6  0
0100009908020051 D  acc#                   7     10  0
010100140228    ***
0102000204170048 D                 DS
0103000204170049 D  CharZip                1     10
0104000204170050 D  CZip5                  1      5
010500020417     D  CDash                  6      6    Inz('-')
0106000204170051 D  CZip4                  7     10
010700140228    ***
0108000204180048 D                 DS
010900020418     D  FmtDat                 1      8  0
0110000204180063 D  FmtMth                 1      2  0
011100020418     D  FmtDay                 3      4  0 Inz(1)
011200020418     D  FmtYr                  5      8  0 Inz(2002)
011300140228    ***
011400140228    *** LDA
0115009102150055 D                UDS
0116009907130063 D  LMONTH                 1      2  0
0117009907130064 D  LYEAR                  3      6  0
0118001310030064 D  LUSER                 25     34
0119001402280067 D  TAR                  100    171  0 DIM(24)
012000020422DTAQ D  PREFIX               241    241
0121009505080056 D  CONAME               201    240
012200140228    ***
012300020416     D  WDATE8         S              8S 0 Inz(0)
012400140228    ***
012500140228     D @ACA            S              1A   INZ
012600140228     D DB05DATE        S              8S 0 INZ
012700140228     D @8              S              8A
012800140228    ***
012900140228   X***X
013000140228      /DEFINE CHK_ACA_PLAN_PR
013100140228      /DEFINE CHK_ACA_PLAN_FIELDS
013200140228      /COPY QCPYSRC,ACASRVPGMP
013300140228      /UNDEFINE CHK_ACA_PLAN_PR
013400140228      /UNDEFINE CHK_ACA_PLAN_FIELDS
013500140228   X***X
0136009907140022 IMCOVR
0137009907140027 I                                          MCTRST        L2
0138009907140028 I                                          MCSUB#        L2
0139009907140036 I                                          ACC#          L2
0140009907140029 I                                          MCPLAN        L1
0141009907140030 I                                          MCAGEB        L1
0142009907140031 I                                          MCOVTP        L1
014300140228    ***
0144009907140293 IACCMSR
014500990713     I              AACODE                      ACOD
014600140228    ***
014700140228   X***X
014800140228    ***
014900071010     c                   move      mctrst        kt
015000071010     c                   move      mcsub#        ks
015100071010     c                   move      mcplan        kp
015200071010     c                   move      mcageb        kab
015300071010     c                   move      mcovtp        kct
015400071010
015500990714     C   L2              eval      newacc = 'Y'
015600990714     C   L1              eval      raterr = ' '
0157009907010060 C*                                                                   UTL001
015800990714     C                   IF        raterr = ' '
0159009907010060 C*                                                                   UTL001
016000990714     C                   eval      *in51 = *off
0161009102150060 C*                                                                   UTL001
0162009505080060 C*  DATE SELECT FROM LDA                                             UTL001
0163009412160060 C*                                                                   UTL001
016400011211     c                   if        mcdltd = 'D' or enrldt = candt or
016500011211     c                             enrlym > lym or (candt <> 0 and
016600011211     c                             candt <= lymd)
016700941216     C                   GOTO      #END
016800941216     C                   END
016900011211
017000011211     c* skip plans only billed to COBRA members
017100011211
017200011211     c     mcssno        chain     member                             55
017300011211     c   55              goto      #end
017400011211     c                   if        cexpdt <> 0
017500011211     c     plnkey        chain     plnmst                             56
017600011211     c   56              goto      #end
017700011211     c                   if        sfadm <> 'Y' or cexpdt <= lymd
017800011211     c                   goto      #end
017900011211     c                   end
018000011211     c                   end
0181000112110073 C*
018200140228    ***
018300140228     C                   SETOFF                                         54
018400140228    ***
018500140228    *** CHECK IF ACA PLAN
018600140228    ***
018700140228     C                   EVAL      @ACA = #CHK_ACA_PLAN(MCTRST:MCSUB#:MCPLAN)
018800140228    ***
018900140228    ***
019000990713     C* VALID RATE NEEDED FOR RUN DATE
019100910701     C*
019200910701     C                   EXSR      #FNDRT
019300140228     C                   IF        @ACA = 'Y'
019400140228     C                   EXSR      #DEPRT
019500140228     C                   ENDIF
019600140228    ***
019700990701     C                   END
019800990701     C*
019900910701     C     #END          TAG
020000140228   S***S
0201009907010073 C***********************************************
0202009907010073 C* FIND RATE                                   *
0203009907010073 C***********************************************
020400910701     C     #FNDRT        BEGSR
020500140228    ***
020600140228     C                   IF        @ACA = 'Y'
020700140228     C                   EVAL      *IN55 = *OFF
020800140228     C                   EVAL      *IN54 = *ON
020900140228     C                   EVAL      PARMSSN = %EDITC(MCSSNO:'X')
021000140228     C                   EVAL      PARMSEQ = '00'
021100140228     C                   ELSE
021200140228     C                   EVAL      *IN54 = *OFF
021300140228     C                   EVAL      PARMSSN = *BLANKS
021400140228     C                   EVAL      PARMSEQ = *BLANKS
021500140228     C                   ENDIF
021600140228    ***
021700071010     c                   move      tspabct       parmkey
021800071010     c                   move      lymd          parmeffymd
021900071011     c                   move      benamt        parmbenamt
022000071010     c                   clear                   parmgroup
022100071010     c                   clear                   parmbilrte
022200071010     c                   clear                   parmnetrte
022300071010     c                   clear                   parmbilprem
022400071010     c                   clear                   parmnetprem
022500071010     c                   clear                   parmfound
022600140228    ***
022700071010     c                   call      'GETRATE'     grplist
022800140228    ***
022900140228     C                   EXSR      $RESULT
023000140228    ***
023100140228    ***
023200140228     C                   ENDSR
023300140228   S***S
023400140228     C     $RESULT       BEGSR
023500140228    ***
023600071010      * grate not returned
0237000710100361 C                   if        parmfound <> 'Y'
0238009907130102 C                   ADD       1             CNT               5 0
023900971010     C*
024000990714     C                   eval      lname = *blanks
0241009710100144 C     ACCKEY        CHAIN     ACCMST                             87
024200990714     C*
024300990714     c                   if        not *in87
024400990714     C     ACOD          CHAIN     AACODE                             97
024500990714     c                   if        not *in97
024600990714     C                   MOVEL     ALNAM         LNAME
024700990714     c                   end
024800990714     c                   end
024900071010     C*********************************
025000990713     C*
025100990802     C* ADD ACCT TO INVOICE EXCLUSION FILE and add history record for
025200990802     C* documentation
025300990802     C*
025400990714     C                   IF        newacc = 'Y'
025500990802
025600031010     C                   MOVE      MCTRST        IETRUS
025700031010     C                   MOVE      MCSUB#        IESUB
025800031010     C                   MOVE      ACC#          IEACC
025900031010     C                   MOVE      LYMD          IEEFF
026000031010     C                   WRITE     INVER
026100140512     C     acckey        delete(e) invprir
026200130214
026300020422     C     prefix        Ifeq      'F'
026400130214      * 02/14/13 - stop printing inv delay letter
026500130729      * 07/29/13 - start printing inv delay letter again
026600130729     C                   Exsr      Invltr
026700130729
026800020422     C                   End
026900130214
027000990802     c                   eval      trcode = 'UEI'
027100990802     c                   eval      hkey   = tsa
027200990802     c                   eval      tramt  = *zeros
027300131003     c                   eval      hprgnm = thispgmname
027400990802     c                   eval      hstrst = mctrst
027500990802     c                   eval      hssub# = mcsub#
027600990802     c                   eval      hsacct = acc#
027700990802     c                   eval      hoper  = luser
027800990802     c                   eval      hsdltd = 'A'
027900990802     c                   eval      covtdt = lymd
028000131003     C                   eval      sysdateymd = %date
028100131003     C                   MOVE      sysdateymd    trdate
028200131003     c                   eval      hstrtime = %time
028300990802     C                   write     histr
028400990802
028500990713     C                   MOVE      'N'           NEWACC            1
0286009907130097 C                   END
028700990713     C*
028800910701     C                   EXCEPT    ERROR
028900990701     C                   MOVE      'Y'           RATERR
0290009102150097 C                   END
0291009102150098 C*
029200910701     C                   ENDSR
0293009907130098 C*
029400140228   S***S
029500140228     C***********************************************
029600140228     C* FIND RATE FOR DEPENDENTS                    *
029700140228     C***********************************************
029800140228     C     #DEPRT        BEGSR
029900140228    ***
030000140228     C     MCSSNO        CHAIN     DEPENR
030100140228     C                   IF        NOT %FOUND(DEPNDC)
030200140228     C                   LEAVESR
030300140228     C                   ENDIF
030400140228    ***
030500140228     C     MCSSNO        SETLL     DEPENR
030600140228     C                   DOU       %EOF(DEPNDC)
030700140228     C     MCSSNO        READE     DEPENR
030800140228     C                   IF        NOT %EOF(DEPNDC)
030900140228    ***
031000140228     C     KL#SQTSP      CHAIN     DCOVR
031100140228     C                   IF        NOT %FOUND(DCOVC)
031200140228     C                   ITER
031300140228     C                   ENDIF
031400140228    ***
031500140228     C     KL#SQTSP      SETLL     DCOVR
031600140228     C                   DOU       %EOF(DCOVC)
031700140228     C     KL#SQTSP      READE     DCOVR
031800140228     C                   IF        NOT %EOF(DCOVC) AND DVDLTD <> 'D' AND
031900140228     C                             DENRDT <> CCANDT AND
032000140228     C                             DENRYM <= LYM AND
032100140228     C                             (CCANDT = 0 OR CCANDT > LYMD)
032200140228    ***
032300140228     C                   EVAL      *IN55 = *ON
032400140228     C                   EVAL      *IN54 = *ON
032500140228     C                   EVAL      PARMSSN = %EDITC(SSNO:'X')
032600140228     C                   EVAL      PARMSEQ = %EDITC(DPSEQ#:'X')
032700140228    ***
032800140228     C                   MOVE      TSPABCT       PARMKEY
032900140228     C                   MOVE      LYMD          PARMEFFYMD
033000140228     C                   MOVE      BENAMT        PARMBENAMT
033100140228     C                   CLEAR                   PARMGROUP
033200140228     C                   CLEAR                   PARMBILRTE
033300140228     C                   CLEAR                   PARMNETRTE
033400140228     C                   CLEAR                   PARMBILPREM
033500140228     C                   CLEAR                   PARMNETPREM
033600140228     C                   CLEAR                   PARMFOUND
033700140228
033800140228     C                   CALL      'GETRATE'     GRPLIST
033900140228
0340001402280074 C                   SETOFF                                       52
0341001402280074 C                   CLEAR                   RATEERROR         1
034200140228    ***
034300140228     C                   EXSR      $RESULT
034400140228    ***
034500140228     C                   ENDIF
034600140228     C                   ENDDO
034700140228    ***
034800140228     C                   ENDIF
034900140228     C                   ENDDO
035000140228    ***
035100140228     C                   ENDSR
035200140228   S***S
0353009907130098 C*
0354000204160098 C*---
035500181203     C* Generate invoice delay letter.
035600020416     C*---
035700020416     C     Invltr        BEGSR
035800140228    ***
035900020418     C                   Z-add     LMONTH        FmtMth
036000020418     C                   Z-add     FmtDat        Wdate8
036100020417     C                   Movel     Wdate8        Input_Date
036200020418     C                   Eval      Input_Format  = 'MMDDYYYY'
036300020418     C                   Eval      Output_Format = 'Mmmmmmmmmz DD, YYYY'
036400020417     C                   Call      'FMTDATE'
036500020417     C                   Parm                    Input_Date       32
036600020417     C                   Parm                    Input_Format     32
036700020417     C                   Parm                    Output_Format    32
036800020417     C                   Parm                    Output_Date      32
036900020417     C                   Parm                    Output_Error     10
037000020806     C                   Z-add     *Zeros        Pos               2 0
037100020418     C                   Eval      Pos           = %Scan(' ':Output_Date)
037200020418     C                   If        Pos           > 0
037300020418     C                   Eval      MONTH         = %Subst(Output_Date:1:Pos)
037400020418     C                   End
037500130731
037600130731     c                   clear                   retxtout
037700130731     c                   movel     retxt         retxtout
037800130731     c                   cat       month:1       retxtout
037900130731
038000130731
038100220307       clear company;
038200220307       clear a1;
038300220307       clear a2;
038400220307       clear a3;
038500220307       clear csz;
038600020416     C                   Eval      COMPANY       = ACNAM1
038700220307     C                   Eval      A1            = AADDR1
038800220307
038900220307      * City St Zip
039000220307     C     ACITY         CAT(P)    ',':0         csz
039100220307     C     csz           CAT(P)    ASTATE:1      csz
039200020417     C                   Movel     AZIP          CZip5
039300020417     C                   Move      AZIP          CZip4
039400020418     C     CZip4         Ifne      '0000'
039500220307     C     csz           CAT(P)    CharZip:2     csz
039600020417     C                   Else
039700220307     C     csz           CAT(P)    CZip5:2       csz
039800020417     C                   End
039900220307
040000220307       if aaddr2 <> *blanks;
040100220307        a2 = aaddr2;
040200220307        a3 = csz;
040300220307       else;
040400220307        a2 = csz;
040500220307        a3 = *blanks;
040600220307       endif;
040700220307
040800031007     C     CONTAC        Cat(P)    ':':0         CONTACT
040900220307
041000020416     C                   Write     RHdr
041100020416     C                   Write     CBody
0412000204160098 C*
041300020416     C                   ENDSR
0414000204160098 C*
0415000204160098 C*
0416000204160098 C*
041700990713     C     *INZSR        BEGSR
041800140228    ***
041900140228     c     grplist       plist
042000140228     c                   parm                    parmkey          15
042100140228     C                   PARM                    PARMSSN           9
042200140228     C                   PARM                    PARMSEQ           2
042300140228     c                   parm                    parmeffymd        8
042400140228     c                   parm                    parmbenamt        7
042500140228     c                   parm                    parmgroup        15
042600140228     c                   parm                    parmbilrte       11
042700140228     c                   parm                    parmnetrte       11
042800140228     c                   parm                    parmbilprem       7
042900140228     c                   parm                    parmnetprem       7
043000140228     c                   parm                    parmfound         1
043100140228    ***
043200140228     C     KL#SQTSP      KLIST
043300140228     C                   KFLD                    DSSNO
043400140228     C                   KFLD                    DSEQ#
043500140228     C                   KFLD                    MCTRST
043600140228     C                   KFLD                    MCSUB#
043700140228     C                   KFLD                    MCPLAN
043800140228    ***
043900020416     C                   Z-add     *Date         Wdate8
044000140228    ***
044100020417     C                   Movel     Wdate8        Input_Date
044200020416     C                   Eval      Input_Format  = 'MMDDYYYY'
044300020416     C                   Eval      Output_Format = 'Mmmmmmmmmz DD, YYYY'
044400140228    ***
044500020417     C                   Call      'FMTDATE'
044600020417     C                   Parm                    Input_Date       32
044700020417     C                   Parm                    Input_Format     32
044800020417     C                   Parm                    Output_Format    32
044900020417     C                   Parm                    Output_Date      32
045000020417     C                   Parm                    Output_Error     10
045100140228    ***
045200020417     C                   Eval      WpDate  =     %trim(Output_Date)
0453009907130060 C                   Z-ADD     1             LDD
0454009907130065 C                   Z-ADD     LYEAR         LYY
0455009907130066 C                   Z-ADD     LMONTH        LMM
045600990720     c                   time                    htime             6 0
045700990802      *
045800990802     C                   MOVEL     *YEAR         RUNDAT            8 0
045900990802     C                   MOVEL     *MONTH        RUNMD             4 0
046000990802     C                   MOVE      *DAY          RUNMD
046100990802     C                   MOVE      RUNMD         RUNDAT
046200020325      *
046300020325     C                   Except    TRSTTI
046400020325     C                   Move      *Off          *InOF
046500020325     C                   Read      TRSSLC
046600020325     C                   Dou       %Eof
046700020325     C                   If        Not %Eof
046800020325     C     Trust_Ctr     Doueq     *Zero
046900020325     C                   Add       1             Trust_Ctr         2 0
047000020325     C                   Select
047100020325     C     Trust_Ctr     Wheneq    1
047200020325     C                   Clear                   Tr1               3 0
047300020325     C                   Clear                   Tr2               3 0
047400020325     C                   Clear                   Tr3               3 0
047500020325     C                   Clear                   Tr4               3 0
047600020325     C                   Clear                   Tr5               3 0
047700020325     C                   Clear                   Tr6               3 0
047800020325     C                   Clear                   Tr7               3 0
047900020325     C                   Clear                   Tr8               3 0
048000020325     C                   Clear                   Tr9               3 0
048100020325     C                   Clear                   Tr10              3 0
048200020325     C                   Clear                   Tr11              3 0
048300020325     C                   Clear                   Tr12              3 0
048400020325     C                   Clear                   Tr13              3 0
048500020325     C                   Clear                   Tr14              3 0
048600020325     C                   Clear                   Tr15              3 0
048700020325     C                   Clear                   Tr16              3 0
048800020325     C                   Clear                   Tr17              3 0
048900020325     C                   Clear                   Tr18              3 0
049000020325     C                   Clear                   Tr19              3 0
049100020325     C                   Clear                   Tr20              3 0
049200020325     C                   Clear                   Tr21              3 0
049300020325     C                   Clear                   Tr22              3 0
049400020325     C                   Clear                   Tr23              3 0
049500020325     C                   Clear                   Tr24              3 0
049600020325     C                   Clear                   Tr25              3 0
049700020325     C                   Clear                   Tr26              3 0
049800020325     C                   Movel     TRTRST        Tr1
049900020325     C     Trust_Ctr     Wheneq    2
050000020325     C                   Move      TRTRST        Tr2
050100020325     C     Trust_Ctr     Wheneq    3
050200020325     C                   Move      TRTRST        Tr3
050300020325     C     Trust_Ctr     Wheneq    4
050400020325     C                   Move      TRTRST        Tr4
050500020325     C     Trust_Ctr     Wheneq    5
050600020325     C                   Move      TRTRST        Tr5
050700020325     C     Trust_Ctr     Wheneq    6
050800020325     C                   Move      TRTRST        Tr6
050900020325     C     Trust_Ctr     Wheneq    7
051000020325     C                   Move      TRTRST        Tr7
051100020325     C     Trust_Ctr     Wheneq    8
051200020325     C                   Move      TRTRST        Tr8
051300020325     C     Trust_Ctr     Wheneq    9
051400020325     C                   Move      TRTRST        Tr9
051500020325     C     Trust_Ctr     Wheneq    10
051600020325     C                   Move      TRTRST        Tr10
051700020325     C     Trust_Ctr     Wheneq    11
051800020325     C                   Move      TRTRST        Tr11
051900020325     C     Trust_Ctr     Wheneq    12
052000020325     C                   Move      TRTRST        Tr12
052100020325     C     Trust_Ctr     Wheneq    13
052200020325     C                   Move      TRTRST        Tr13
052300020325     C     Trust_Ctr     Wheneq    14
052400020325     C                   Move      TRTRST        Tr14
052500020325     C     Trust_Ctr     Wheneq    15
052600020325     C                   Move      TRTRST        Tr15
052700020325     C     Trust_Ctr     Wheneq    16
052800020325     C                   Move      TRTRST        Tr16
052900020325     C     Trust_Ctr     Wheneq    17
053000020325     C                   Move      TRTRST        Tr17
053100020325     C     Trust_Ctr     Wheneq    18
053200020325     C                   Move      TRTRST        Tr18
053300020325     C     Trust_Ctr     Wheneq    19
053400020325     C                   Move      TRTRST        Tr19
053500020325     C     Trust_Ctr     Wheneq    20
053600020325     C                   Move      TRTRST        Tr20
053700020325     C     Trust_Ctr     Wheneq    21
053800020325     C                   Move      TRTRST        Tr21
053900020325     C     Trust_Ctr     Wheneq    22
054000020325     C                   Move      TRTRST        Tr22
054100020325     C     Trust_Ctr     Wheneq    23
054200020325     C                   Move      TRTRST        Tr23
054300020325     C     Trust_Ctr     Wheneq    24
054400020325     C                   Move      TRTRST        Tr24
054500020325     C     Trust_Ctr     Wheneq    25
054600020325     C                   Move      TRTRST        Tr25
054700020325     C     Trust_Ctr     Wheneq    26
054800020325     C                   Move      TRTRST        Tr26
054900020325     C     *InOF         Ifeq      *On
055000020325     C                   Move      *Off          *InOF
055100020325     C                   Except    TRSTTI
055200020325     C                   End
055300020325     C                   Except    TRUSTS
055400020325     C                   Z-add     *Zeros        Trust_Ctr
055500020325     C                   Endsl
055600020325     C                   Read      TRSSLC
055700020325     C                   If        %Eof
055800020325     C                   Z-add     *Zeros        Trust_Ctr
055900020325     C     Trust_Ctr     Ifne      26
056000020325     C     *InOF         Ifeq      *On
056100020325     C                   Move      *Off          *InOF
056200020325     C                   Except    TRSTTI
056300020325     C                   End
056400020325     C                   Except    TRUSTS
056500020325     C                   End
056600020325     C                   End
056700020325     C                   Enddo
056800020325     C                   Else
056900020325     C                   Z-add     *Zeros        Trust_Ctr
057000020325     C                   End
057100020325     C                   Enddo
057200031007
057300031010      * Dates for Client Letter (Page 2 - Front)
057400031007     C                   MOVEL     *MONTH        MO                2 0
057500031007     C                   MOVEL     *DAY          DAYC              2
057600031007     C                   MOVEL     *YEAR         YRC               4
057700031007     C
057800031007     C     MO            LOOKUP    TAB1          TAB2                     10
057900031007
058000031007     c                   move      RUNDAT        workdt
058100031007     c                   ADDDUR    30:*d         workdt
058200031007     c                   move      WORKDT        RUN30DT           8 0
058300031007
058400031007     C                   MOVE      RUN30DT       MODY              4 0
058500031007     C                   MOVEL     MODY          MO
058600031007     C                   MOVE      RUN30DT       DAYC
058700031007     C                   MOVEL     RUN30DT       YRC
058800031007
058900031007     C     MO            LOOKUP    TAB1          TAB2                     10
059000031007     C                   MOVEL     TAB2          RUN30DAT         19
059100031007     c                   cat       DAYC:1        RUN30DAT
059200031007     c                   cat       ',':0         RUN30DAT
059300031007     c                   cat       YRC:1         RUN30DAT
059400031007
059500031007     C                   EVAL      *IN01 = *ON
059600031007
059700020325     C                   ENDSR
0598000203250098 C*
0599000203250098 C*
0600000203250098 C*
060100020325    ?C     KLIST         Begsr
060200990713     C     ACCKEY        KLIST
060300990713     C                   KFLD                    MCTRST
060400990713     C                   KFLD                    MCSUB#
060500990713     C                   KFLD                    ACC#
060600011211     c     plnkey        klist
060700011211     c                   kfld                    mctrst
060800011211     c                   kfld                    mcsub#
060900011211     c                   kfld                    mcplan
061000031007
061100031007     c     AC2KEY        klist
061200031007     C                   KFLD                    PREFIX
061300031007     C                   KFLD                    MCTRST
061400031007     C                   KFLD                    MCSUB#
061500031007     C                   KFLD                    ACC#
061600031007
061700990713     C                   ENDSR
0618000310070058 C*
0619009102150104 O******************************************************              DB020
0620009102150105 O*  OUTPUT SPECIFICATIONS                             *              DB020
0621009102150106 O******************************************************              DB020
0622009102150107 O*                                                                   DB020
0623009102150108 OREPORT    H    1P                     2 03
0624000203250109 O         OR    OF
0625009102150110 O                       CONAME              87
0626009102150111 O          H    1P                     1
0627009102150112 O         OR    OF
0628009811110113 O                       *DATE         Y     16
0629009907140114 O                                           55 'NO RATES FOR'
063000990714     O                       LMONTH              58
063100990714     O                                           59 '/'
063200990714     O                       LYEAR               63
0633009907140114 O                                           88 'INVOICE - ACCOUNTS EXCLU'
0634009907140114 O                                           91 'DED'
0635009102150115 O                                          120 'PAGE :'
0636009707110116 O                       PAGE          Z    130
0637009102150117 O          H    1P                     1
0638009102150118 O         OR    OF
0639009907130119 O                                           17 'PROG: DB052 '
0640009102150120 O                                          120 'TIME :'
0641009907200121 O                       htime              130 '  :  :  '
0642009907130122 O          H    1P                     1
0643009907130123 O         OR    OF
0644009102150122 O          H    1P                     1
0645009102150123 O         OR    OF
0646009102150124 O                                           24 '------------------------'
0647009102150125 O                                           48 '------------------------'
0648009102150126 O                                           72 '------------------------'
0649009102150127 O                                           96 '------------------------'
0650009102150128 O                                          120 '------------------------'
0651009102150129 O                                          132 '------------'
0652009102150130 O          H    1P                     1
0653009102150131 O         OR    OF
0654009707150133 O                                           23 'T/S/A'
0655009603140133 O                                           32 'PLAN'
0656009603140134 O                                           43 'AGE BAND'
0657009603140135 O                                           53 'COV TYPE'
065800990701     O                                          119 'CODE'
065900970715     O                                          129 'AA NAME'
0660009102150139 O          H    1P                     1
0661009102150140 O         OR    OF
0662009102150141 O                                           24 '------------------------'
0663009102150142 O                                           48 '------------------------'
0664009102150143 O                                           72 '------------------------'
0665009102150144 O                                           96 '------------------------'
0666009102150145 O                                          120 '------------------------'
0667009102150146 O                                          132 '------------'
0668000203250147 O          E            TRSTTI         1
0669000203250110 O                       CONAME              87
0670000203250147 O          E            TRSTTI         1
0671000203250113 O                       *DATE         Y     16
0672000203250114 O                                           55 'NO RATES FOR'
067300020325     O                       LMONTH              58
067400020325     O                                           59 '/'
067500020325     O                       LYEAR               63
0676000203250114 O                                           88 'INVOICE - ACCOUNTS EXCLU'
0677000203250114 O                                           91 'DED'
0678000203250147 O          E            TRSTTI         1
0679000203250115 O                                          120 'PAGE :'
0680000203250116 O                       PAGE          Z    130
0681000203250119 O                                           17 'PROG: DB052 '
0682000203250147 O          E            TRSTTI         2
0683000203250120 O                                          120 'TIME :'
0684000203250121 O                       htime              130 '  :  :  '
0685000203250147 O          E            TRSTTI         1
068600020325     O                                           18 'TRUSTS SELECTED:'
0687000203250147 O          E            TRUSTS         1
068800020325     O                       Tr1           Z      5
068900020325     O                       Tr2           Z     10
069000020325     O                       Tr3           Z     15
069100020325     O                       Tr4           Z     20
069200020325     O                       Tr5           Z     25
069300020325     O                       Tr6           Z     30
069400020325     O                       Tr7           Z     35
069500020325     O                       Tr8           Z     40
069600020325     O                       Tr9           Z     45
069700020325     O                       Tr10          Z     50
069800020325     O                       Tr11          Z     55
069900020325     O                       Tr12          Z     60
070000020325     O                       Tr13          Z     65
070100020325     O                       Tr14          Z     70
070200020325     O                       Tr15          Z     75
070300020325     O                       Tr16          Z     80
070400020325     O                       Tr17          Z     85
070500020325     O                       Tr18          Z     90
070600020325     O                       Tr19          Z     95
070700020325     O                       Tr20          Z    100
070800020325     O                       Tr21          Z    105
070900020325     O                       Tr22          Z    110
071000140310     O                       Tr23          Z    115
071100020325     O                       Tr24          Z    120
071200020325     O                       Tr25          Z    125
071300020325     O                       Tr26          Z    130
0714009107010147 O          E            ERROR          1
071500140228     O               54                           7 'ACA'
071600140228     O               54N55                       12 'MBR'
071700140228     O               54 55                       12 'DEP'
0718009907130150 O                       MCTRST              17
071900960314     O                                           18 '-'
0720009907140150 O                       MCSUB#              21
072100960314     O                                           22 '-'
0722009603140150 O                       ACC#                26
0723009907140151 O                       MCPLAN              32
0724009907140151 O                       MCAGEB              39
0725009907140152 O                       MCOVTP              49
072600970711     O                       ACOD               118
072700970715     O                       LNAME              132
0728009102150156 O          T    LR                  3
0729009102150157 O                                           29 '*** TOTAL ERRORS:'
0730009102150158 O                       CNT           ZB    38
073100031007** MONTH NAME TABLE
07320003100701January
07330003100702February
07340003100703March
07350003100704April
07360003100705May
07370003100706June
07380003100707July
07390003100708August
07400003100709September
07410003100710October
07420003100711November
07430003100712December
