000100210322     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN')
000200140228     H ALWNULL(*USRCTL)
000300140228   X***X
0004009102150002 F******************************************************************  UTL001
0005000004140003 F* DB050      GROUP BENEFIT SERVICES SOFTWARE           1988      *  UTL001
0006009102150004 F*                                                                *  UTL001
0007009102150013 F*  DESCRIPTION - THIS PROGRAM WILL PRINT ANY MCOV RECORDS        *  UTL001
0008009102150014 F*            WITH WITH NO CORRESPONDING PLAN OR RATE RECORD      *  UTL001
0009009102150015 F*                                                                *  UTL001
001000970710     F*  MODIFICATION-ADD AA CODE TO REPORT. MLF 7/97
001100990713     F*  7/01/99 DLK - CHANGED TO PRINT ONLY 1 LINE PER T/S/A/P/AB/CT
001200011211     f* 12/10/01 dlk - exclude plans billed to cobra members           *
001300020524     F*  5/24/02 szz - Recompiled over new AACODE file                 *
001400071010      * 10/10/07 dlk - convert to use external pgm for grate           *
001500120105      * 01/05/12 dlk - add csv output                                  *
001600120306      * 03/06/12 dlk - add Care First indicator to csv output per      *
001700120306      *                request from shelly                             *
001800140228    ***
001900140228    *** 02/28/2014 SSK RE-MOD TO OTF AND KEEP ACA PRT
002000141224      * 12/24/14 dlk - add plan category code per Shelly request
002100180720      * 07/20/18 dlk - add renewal list by plan per Shelly R for Sam F
002200210322      *
002300210322      * 03/22/2021  B.Rees
002400210322      *  Incident# INC0601153
002500210322      * Request that Renewal Month and Market Size be added for each
002600210322      * plan.
002700140228    ***
002800140228    ***
0029009102150016 F******************************************************************  UTL001
0030002103220018 FMCOV      IP   F   88    14AIDISK    KEYLOC(12)
0031001201130034 FACCMST    IF   e           k DISK    prefix(a_)
0032001201130034 Fmember    IF   e           k DISK
0033001402280034 FDEPNDC    IF   e           k DISK
0034001402280034 FDCOVC     IF   e           k DISK
0035001201050034 FAACODE    IF   e           k DISK
0036001201130020 FPLNMST    If   e           k DISK
0037001201060020 Fgrate     If   e           k DISK
0038001201130020 Fcarmst    If   e           k DISK
0039001203060034 Fcmct14    IF   e           k DISK
0040001807200034 Fsman      IF   e           k DISK
0041001807200034 Fcodesl1   IF   e           k DISK
0042001201050017 Fdb050xl   o  a e             DISK
0043001807200017 Fdb05axl   o  a e             DISK
0044001412240021 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
004500210322
004600210322       Dcl-f MktCara1 keyed ExtDesc('F.MKTCARA1') ExtFile(*extdesc);
004700210322       Dcl-f CarMksz1 keyed ExtDesc('F.CARMKSZ1') ExtFile(*extdesc);
004800210322
004900210322
005000140228   X***X
0051001201050125 Dcsv              c                   const('","')
0052001201130125 Dplandout         s                   like(pdescr)
0053001201130125 Dacnamout         s                   like(a_acnam1)
0054001201130125 Dcnameout         s                   like(cname)
0055001412240125 Dplncatout        s              2
0056001807200125 Dprt_pln_rnw      s              1
0057001807200125 Dsmancdout        s                   like(a_smancd)
0058001807200125 Dcnt_mcov_pln     s              7  0
005900140228    ***
0060001201050055 D                 DS
0061001201050056 D  tsa                    1     10  0
0062001201050056 D  trust#                 1      3  0
0063001201050056 D  sub#                   4      6  0
0064001201050056 D  acc#                   7     10  0
006500140228    ***
006600210322
006700210322
006800210322br01   dcl-s wRenMth Zoned(2);
006900210322br01   dcl-s wFromSz Zoned(5);
007000210322br01   dcl-s wToSz   Zoned(5);
007100210322br01   dcl-s wMktSz  Char(15);
007200210322
007300210322
0074001402280054 D* LDA                                                               DB020
0075001201050055 D                UDS
007600140228     D @LCYMD                  1      8A
007700140228     D @LCYM                   1      6A
0078001201050056 D  LCYMD                  1      8  0
0079001201050056 D  LYY                    1      4
0080001201050056 D  LMM                    5      6
0081001201050056 D  LDD                    7      8
0082009505080056 D  CONAME               201    240
0083009505090055 D  TIME                 242    247  0
008400140228    ***
008500140228     D @ACA            S              1A   INZ
008600140228     D DB05DATE        S              8S 0 INZ
008700140228     D @8              S              8A
008800140228   X***X
008900140228      /DEFINE CHK_ACA_PLAN_PR
009000140228      /DEFINE CHK_ACA_PLAN_FIELDS
009100140228      /COPY QCPYSRC,ACASRVPGMP
009200140228      /UNDEFINE CHK_ACA_PLAN_PR
009300140228      /UNDEFINE CHK_ACA_PLAN_FIELDS
009400140228   X***X
0095009907010022 IMCOV      NS  01
0096009102150023 I                                  1    9 0SSNO
0097009505080 24 I                                 10   11 0DSEQ#
009800970715     I                                 12   17  ACCK1
0099000710100026 I                                 12   26  tspabct
0100001807200027 I                                 12   14 0TRUST#        L3
0101001807200028 I                                 15   17 0SUB#          L3
0102001807200029 I                                 18   21  PLAN#         L2
0103009907010030 I                                 22   23 0AGEBND        L1
0104001201050030 I                                 22   23  AGEBNDchar
0105009907010031 I                                 24   26  COVTYP        L1
0106001201050031 I                                 25   26  COVTYP2
0107001807200036 I                                 51   54 0ACC#          L3
0108000710110036 I                             p   44   47 0benamt
010900970715     I                                 51   54  ACCK2
0110009102150041 I                                 64   64  DLTCD
0111009811110032 I                                 65   72 0ENRLDT
0112009811110035 I                                 65   68 0ENRLYY
0113009811110033 I                                 69   70 0ENRLMM
0114009811110034 I                                 71   72 0ENRLDD
0115009811110036 I                                 73   80 0CANDT
0116009811110036 I                                 73   76 0CANYY
0117009811110036 I                                 77   78 0CANMM
0118009811110036 I                                 79   80 0CANDD
011900180720   X* * Account change
012000180720     c                   if        *inl3
012100120306     c                   clear                   cfplans           1
012200120106     c                   end
012300120306
012400180720   X* * Plan change
012500180720       if *inl2;
012600210322         clear prt_pln_rnw;
012700210322         clear cnt_mcov_pln;
012800180720       endif;
012900180720
013000180720   X* * AB / CT change
013100120306     c                   if        *inl1
013200120306     c                   exsr      #l1det
013300120306     c                   end
013400180720
013500180720   X* * count number of active mcov for this plan
013600180720       cnt_mcov_pln += 1;
013700120106
013800180720     C                   IF        raterr = ' ' and invalidplan = ' '
013900011211     c* skip plans only billed to COBRA members
014000120106     c     ssno          chain     member
014100120106     c                   if        not %found(member)
014200120106     c                   goto      #end
014300120106     c                   end
014400011211
014500011211     c                   if        cexpdt <> 0 and (cexpdt <= lcymd or
014600011211     c                             sfadm <> 'Y')
014700011211     c                   goto      #end
014800011211     c                   end
014900140228    ***
015000140228     C                   SETOFF                                         54
015100140228    ***
015200140228    *** CHECK IF ACA PLAN
015300140228    ***
015400140228     C                   EVAL      @ACA = #CHK_ACA_PLAN(TRUST#:SUB#:PLAN#)
015500140228    ***
015600140228    ***
015700990701     C* VALID RATE NEEDED FOR INPUT DATE
015800910701     C                   EXSR      #FNDRT
015900140228     C                   IF        @ACA = 'Y'
016000140228     C                   EXSR      #DEPRT
016100140228     C                   ENDIF
016200140228    ***
016300990701     C                   END
016400140228    ***
016500910701     C     #END          TAG
016600180720
016700180720      * create renewal list if there was a rate missing for this plan
016800180720     cl2                 if        prt_pln_rnw = 'Y'
016900180720     cl2                 exsr      #renewal
017000180720     cl2                 end
017100140228   S***S
0172001201060073 C***********************************************
0173001201060073 C* l1 detail
0174001201060073 C***********************************************
017500120106     c     #l1det        begsr
017600120106
017700120106     C                   MOVE      ' '           RATERR            1
017800120106     C                   SETOFF                                       51
017900180720     C                   clear                   invalidplan       1
018000120113     C                   clear                   plandout
018100120113     C                   clear                   cnameout
018200141224     C                   clear                   plncatout
018300180720     C                   clear                   plncatdesc       30
0184001201060061 C     PLNKEY        CHAIN     PLNMST                             51
018500120113      * not found
018600120113     c                   if        *in51
0187001201130102 C                   ADD       1             CNT               5 0
018800120113     C                   EXCEPT    ERROR
018900180720     C                   eval      invalidplan = 'Y'
019000120113     C                   exsr      writexldet
019100120113     c                   else
019200120113      * plan found
019300120113     c                   movel     pdescr        plandout
019400141224     c                   move      plncat        plncatout
0195001201130061 C     pcarr         CHAIN     carmst                             51
019600120113     c                   if        %found(carmst)
019700120113     c                   movel     cname         cnameout
019800120113     c                   end
0199001807200061 C     plncat        CHAIN     codesl1
020000180720     c                   if        %found(codesl1)
020100180720     c                   movel     ldescr        plncatdesc
020200180720     c                   end
020300120113     c                   end
020400120113
020500120106     c                   endsr
020600120106
0207009907010073 C***********************************************
0208009907010073 C* FIND RATE                                   *
0209009907010073 C***********************************************
021000910701     C     #FNDRT        BEGSR
021100140228    ***
021200140228     C                   IF        @ACA = 'Y'
021300140228     C                   EVAL      *IN55 = *OFF
021400140228     C                   EVAL      *IN54 = *ON
021500140228     C                   EVAL      PARMSSN = %EDITC(SSNO:'X')
021600140228     C                   EVAL      PARMSEQ = '00'
021700140228     C                   ELSE
021800140228     C                   EVAL      *IN54 = *OFF
021900140228     C                   EVAL      PARMSSN = *BLANKS
022000140228     C                   EVAL      PARMSEQ = *BLANKS
022100140228     C                   ENDIF
022200140228    ***
022300071010     c                   move      tspabct       parmkey
022400071010     c                   move      lcymd         parmeffymd
022500071011     c                   move      benamt        parmbenamt
022600071010     c                   clear                   parmgroup
022700071010     c                   clear                   parmbilrte
022800071010     c                   clear                   parmnetrte
022900071010     c                   clear                   parmbilprem
023000071010     c                   clear                   parmnetprem
023100071010     c                   clear                   parmfound
023200140228    ***
023300071010     c                   call      'GETRATE'     grplist
023400140228    ***
0235000710100074 C                   SETOFF                                       52
0236001201050074 C                   clear                   rateerror         1
023700140228    ***
023800140228     C                   EXSR      $RESULT
023900140228    ***
024000140228     C                   ENDSR
024100140228   S***S
024200140228     C     $RESULT       BEGSR
024300140228    ***
024400120106      * rate not found
0245000710100361 C                   if        parmfound <> 'Y'
0246000710100102 C                   ADD       1             CNT
0247009102150096 C                   SETON                                        52
0248001201050074 C                   eval      rateerror = 'Y'
0249001807200074 C                   eval      prt_pln_rnw = 'Y'
025000140228    ***
025100120105     C                   clear                   LNAME            10
025200120106     C                   clear                   aaname
025300120113     C                   clear                   acnamout
025400180720     C                   clear                   smancdout
025500180720     C                   clear                   smannamout       33
025600180720
0257001201050144 C     ACCKEY        CHAIN     ACCMST
025800120105     c                   if        %found(accmst)
025900120113     C                   MOVEL     a_acnam1      acnamout
026000180720     C                   MOVEL     a_smancd      smancdout
026100180720      * aa name
026200120113     C     a_aacode      CHAIN     AACODE
026300120105     c                   if        %found(aacode)
026400120105     C                   MOVEL     ALNAM         LNAME
026500120105     C                   MOVEL     Afnam         aaname           41
026600120105     C                   cat       Alnam:1       aaname
026700120105     c                   end
026800180720      * sman name
026900180720     C     a_smancd      CHAIN     sman
027000180720     c                   if        %found(sman)
027100180720     C                   MOVEL     sfname        smannamout
027200180720     C                   cat       slname:1      smannamout
027300180720     c                   end
027400180720
027500120105     c                   end
027600120105
027700910701     C                   EXCEPT    ERROR
027800120105     C                   exsr      writexldet
027900990701     C                   MOVE      'Y'           RATERR
028000120106
028100120106      * else - rate was found, fill raterr field with N so the program
028200120106      *        stops repeating the rate search after one valid, non-cobra
028300120106      *        members plan has been found to have rates
028400120106     c                   else
028500120106     C                   MOVE      'N'           RATERR
028600120106
0287000710100363 C                   end
0288001201060098
028900910701     C                   ENDSR
029000140228   S***S
029100140228     C***********************************************
029200140228     C* FIND RATE FOR DEPENDENTS                    *
029300140228     C***********************************************
029400140228     C     #DEPRT        BEGSR
029500140228    ***
029600140228     C     SSNO          CHAIN     DEPENR
029700140228     C                   IF        NOT %FOUND(DEPNDC)
029800140228     C                   LEAVESR
029900140228     C                   ENDIF
030000140228    ***
030100140228     C     SSNO          SETLL     DEPENR
030200140228     C                   DOU       %EOF(DEPNDC)
030300140228     C     SSNO          READE     DEPENR
030400140228     C                   IF        NOT %EOF(DEPNDC)
030500140228    ***
030600140228     C     KL#SQTSP      CHAIN     DCOVR
030700140228     C                   IF        NOT %FOUND(DCOVC)
030800140228     C                   ITER
030900140228     C                   ENDIF
031000140228    ***
031100140228     C     KL#SQTSP      SETLL     DCOVR
031200140228     C                   DOU       %EOF(DCOVC)
031300140228     C     KL#SQTSP      READE     DCOVR
031400140228     C                   IF        NOT %EOF(DCOVC) AND
031500140228     C                             DENRDT <= DB05DATE AND
031600140228     C                             (CCANDT = 0 OR CCANDT > LCYMD)
031700140228    ***
031800140228     C                   EVAL      *IN55 = *ON
031900140228     C                   EVAL      *IN54 = *ON
032000140228     C                   EVAL      PARMSSN = %EDITC(SSNO:'X')
032100140228     C                   EVAL      PARMSEQ = %EDITC(DPSEQ#:'X')
032200140228    ***
032300140228     C                   MOVE      TSPABCT       PARMKEY
032400140228     C                   MOVE      LCYMD         PARMEFFYMD
032500140228     C                   MOVE      BENAMT        PARMBENAMT
032600140228     C                   CLEAR                   PARMGROUP
032700140228     C                   CLEAR                   PARMBILRTE
032800140228     C                   CLEAR                   PARMNETRTE
032900140228     C                   CLEAR                   PARMBILPREM
033000140228     C                   CLEAR                   PARMNETPREM
033100140228     C                   CLEAR                   PARMFOUND
033200140228
033300140228     C                   CALL      'GETRATE'     GRPLIST
033400140228
0335001402280074 C                   SETOFF                                       52
0336001402280074 C                   CLEAR                   RATEERROR         1
033700140228    ***
033800140228     C                   EXSR      $RESULT
033900140228    ***
034000140228     C                   ENDIF
034100140228     C                   ENDDO
034200140228    ***
034300140228     C                   ENDIF
034400140228     C                   ENDDO
034500140228    ***
034600140228     C                   ENDSR
034700140228   S***S
0348001201050164 C*************************************************************
0349001201050164 C* Write Spreadsheet Detail                                  *
0350001201050164 C*************************************************************
035100120105     C     Writexldet    BEGSR
035200120105
035300120106      * get latest grate range to show on shreadsheet
035400120106     c                   exsr      #getlastgr
035500120106
035600120306      * find out if there are any Care First plans in the account
035700120306     c                   if        cfplans = *blank
035800120306     c                   exsr      #getcf
035900120306     c                   end
036000120306
036100210322
036200210322       // Retrieve the Renewal Month
036300210322       wRenMth = 0;
036400210322       chain ( trust# : sub# : Plan# ) PlnMst;
036500210322       if %Found( PlnMst );
036600210322         wRenMth = Prenew;
036700210322       endif;
036800210322
036900210322
037000210322       // Get Market Size.
037100210322       wFromSz = 0;
037200210322       wToSz = 0;
037300210322       wMktSz = '';
037400210322
037500210322       //--------------------------------------
037600210322       //
037700210322       // Read through the Market Size by Carrier
037800210322       //
037900210322       //--------------------------------------
038000210322       Setll ( trust# : Sub# : acc# : pCarr ) MktCara1;
038100210322
038200210322       Dou %Eof(MktCara1);
038300210322         reade ( trust# : Sub# : acc# : pCarr ) MktCara1;
038400210322         if %eof(MktCara1);
038500210322           leave;
038600210322         endif;
038700210322
038800210322
038900210322         //--------------------------------------
039000210322         //
039100210322         // Read through the Carrier Market Size
039200210322         //
039300210322         //--------------------------------------
039400210322         Setll ( pCarr : maszcd )  CARMKSZ1;
039500210322
039600210322         Dou %Eof(CARMKSZ1);
039700210322           reade ( pCarr : maszcd )  CARMKSZ1;
039800210322           if %eof(CARMKSZ1);
039900210322             leave;
040000210322           endif;
040100210322
040200210322           wFromSz = czfrsz;
040300210322           wToSz = cztosz;
040400210322
040500210322         Enddo;
040600210322       Enddo;
040700210322
040800210322
040900210322       if wFromSz > 0 or wToSz > 0;
041000210322         wMktSz = %Editc(wFromSz:'J') + '-' +
041100210322                   %Editc(wToSz:'J');
041200210322       EndIf;
041300210322
041400210322
041500210322
041600210322
041700120105     c                   clear                   db050fld
041800120105     C                   Eval      db050fld  = '"' +
041900120106     C                             %trim(lmdychar)                      + csv +
042000120105     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
042100120113     C                             %trim(acnamout)                      + csv +
042200120105     C                             plan#                                + csv +
042300120113     C                             %trim(plandout)                      + csv +
042400141224     C                             plncatout                            + csv +
042500180720     C                             %trim(cnameout)                      + csv +
042600120105     C                             agebndchar                           + csv +
042700120105     C                             covtyp2                              + csv +
042800180720     C                             invalidplan                          + csv +
042900120105     C                             rateerror                            + csv +
043000120106     C                             %trim(raterange)                     + csv +
043100120105     C                             %trim(aaname)                        + csv +
043200140228     C                             %trim(cfplans)                       + csv
043300140228    ***
043400140228     C                   SELECT
043500140228     C                   WHEN      @ACA = 'Y' AND *IN55 = *ON
043600210322     C                   EVAL      DB050FLD = %TRIM(DB050FLD) + 'ACA DEP","'
043700140228     C                   WHEN      @ACA = 'Y' AND *IN55 = *OFF
043800210322     C                   EVAL      DB050FLD = %TRIM(DB050FLD) + 'ACA MBR","'
043900140228     C                   WHEN      @ACA = 'N'
044000210322     C                   EVAL      DB050FLD = %TRIM(DB050FLD) + ' ","'
044100140228     C                   ENDSL
044200140228    ***
044300210322       // Write Renewal Month.
044400210322       DB050FLD = %Trim( DB050FLD ) + %Char( wRenMth ) + csv;
044500210322
044600210322
044700210322       // Write Market Size
044800210322       DB050FLD = %Trim( DB050FLD ) + %Char( wMktSz ) + '",';
044900210322
045000210322
045100210322
045200120105     C                   Write     db050xr
0453001201050320 C                   ENDSR
045400120105     C*
045500120105     C/EJECT
045600120105     C*************************************************************
045700120105     C* Write Spreadsheet heading                                 *
045800120105     C*************************************************************
045900120105     C     Writexlhead   BEGSR
046000120105
046100120105     c                   clear                   db050fld
046200120106     C                   Eval      db050fld = '"' + 'EFFDT OF ERROR'    + csv +
046300120106     C                                              'ACCOUNT #'         + csv +
046400120113     C                                              'ACCOUNT NAME'      + csv +
046500120106     C                                              'PLAN'              + csv +
046600120113     C                                              'PLAN DESCRIPTION'  + csv +
046700141224     C                                              'CATEGORY'          + csv +
046800120113     C                                              'CARRIER NAME'      + csv +
046900120113     C                                              'AGE BAND'          + csv +
047000120106     C                                              'COV TYPE'          + csv +
047100120106     C                                              'PLAN ERROR'        + csv +
047200120106     C                                              'RATE ERROR'        + csv +
047300120106     C                                              'LATEST RATE RANGE' + csv +
047400120106     C                                              'AA NAME'           + csv +
047500120306     C                                              'CF PLANS IN ACCT'  + csv +
047600210322     C                                              ' '                 + csv +
047700210322     C                                              'RENEWAL MONTH'     + csv +
047800210322     C                                              'MARKET SIZE'       + '",'
047900120105     C                   Write     db050xr
048000120105     C*
0481001201050320 C                   ENDSR
048200120105
0483001807200164 C*************************************************************
0484001807200164 C* Write Renewal Spreadsheet Detail
0485001807200164 C*************************************************************
048600180720     C     WritexldetRN  BEGSR
048700180720
048800210322
048900210322       // Retrieve the Renewal Month
049000210322       wRenMth = 0;
049100210322       chain ( trust# : sub# : Plan# ) PlnMst;
049200210322       if %Found( PlnMst );
049300210322         wRenMth = Prenew;
049400210322       endif;
049500210322
049600210322
049700210322       // Get Market Size.
049800210322       wFromSz = 0;
049900210322       wToSz = 0;
050000210322       wMktSz = '';
050100210322
050200210322       //--------------------------------------
050300210322       //
050400210322       // Read through the Market Size by Carrier
050500210322       //
050600210322       //--------------------------------------
050700210322       Setll ( trust# : Sub# : acc# : pCarr ) MktCara1;
050800210322
050900210322       Dou %Eof(MktCara1);
051000210322         reade ( trust# : Sub# : acc# : pCarr ) MktCara1;
051100210322         if %eof(MktCara1);
051200210322           leave;
051300210322         endif;
051400210322
051500210322
051600210322         //--------------------------------------
051700210322         //
051800210322         // Read through the Carrier Market Size
051900210322         //
052000210322         //--------------------------------------
052100210322         Setll ( pCarr : maszcd )  CARMKSZ1;
052200210322
052300210322         Dou %Eof(CARMKSZ1);
052400210322           reade ( pCarr : maszcd )  CARMKSZ1;
052500210322           if %eof(CARMKSZ1);
052600210322             leave;
052700210322           endif;
052800210322
052900210322           wFromSz = czfrsz;
053000210322           wToSz = cztosz;
053100210322         Enddo;
053200210322       Enddo;
053300210322
053400210322
053500210322       if wFromSz > 0 or wToSz > 0;
053600210322         wMktSz = %Editc(wFromSz:'J') + '-' +
053700210322                   %Editc(wToSz:'J');
053800210322       EndIf;
053900210322
054000210322
054100180720     c                   clear                   db05afld
054200180720     C                   Eval      db05afld  = '"' +
054300180720     C                             %trim(lmdychar)                      + csv +
054400180720     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
054500180720     C                             %trim(acnamout)                      + csv +
054600180724     C                             %trim(aaname)                        + csv +
054700180720     C                             smancdout                            + csv +
054800180720     C                             %trim(smannamout)                    + csv +
054900180724     C                             plan#                                + csv +
055000180724     C                             %trim(plandout)                      + csv +
055100180724     C****                         plncatout                            + csv +
055200180724     C                             %trim(plncatdesc)                    + csv +
055300180724     C                             %trim(cnameout)                      + csv +
055400180720     C                             %trim(%editc(cnt_mcov_pln:'Z'))      + csv +
055500180720     C                             %trim(raterange)                     + csv +
055600210322     C                             ' '                                  + csv
055700180720    ***
055800210322       // Write Renewal Month.
055900210322       db05afld = %Trim( db05afld ) + %Char( wRenMth ) + csv;
056000210322
056100210322
056200210322       // Write Market Size
056300210322       db05afld = %Trim( db05afld ) + %Char( wMktSz ) + '",';
056400210322
056500180720     C                   Write     db05axr
0566001807200320 C                   ENDSR
056700180720     C*
056800180720     C*************************************************************
056900180720     C* Write Renewal Spreadsheet heading
057000180720     C*************************************************************
057100180720     C     WritexlheadRN BEGSR
057200180720
057300180720     c                   clear                   db05afld
057400180720     C                   Eval      db05afld = '"' +
057500180724     C                             'DATE W/O RATE'     + csv +
057600180720     C                             'ACCOUNT #'         + csv +
057700180720     C                             'ACCOUNT NAME'      + csv +
057800180724     C                             'AA NAME'           + csv +
057900180720     C                             'BROKER CODE'       + csv +
058000180720     C                             'BROKER NAME'       + csv +
058100180724     C                             'PLAN'              + csv +
058200180724     C                             'PLAN DESCRIPTION'  + csv +
058300180724     C****                         'PLAN CATEGORY'     + csv +
058400180724     C                             'PLAN CATEGORY'     + csv +
058500180724     C                             'CARRIER NAME'      + csv +
058600180720     C                             '# OF EMPLOYEES'    + csv +
058700180720     C                             'LATEST RATE RANGE' + csv +
058800210322     C                             ' '                 + csv +
058900210322     C                             'RENEWAL MONTH'     + csv +
059000210322     C                             'MARKET SIZE'       + '",'
059100210322     C*
059200180720     C                   Write     db05axr
059300180720     C*
0594001807200320 C                   ENDSR
059500180720
059600120106      ********************
059700120106      * find the latest grate range
059800120106      ********************
059900120106     c     #getlastgr    begsr
060000120106
060100120106     c                   clear                   lastfrmdt         8 0
060200120106     c                   clear                   lastenddt         8 0
060300120106     c                   clear                   raterange        24
060400120106     c     gratkey       setll     grate
0605001201060131 C                   dou       %eof(grate)
0606001201060132 C     gratkey       READE     grate
060700120106     c                   if        not %eof(grate) and
060800120106     C                             (todat > lastenddt)
060900120106     c                   move      frmdat        lastfrmdt
061000120106     c                   move      todat         lastenddt
061100120106     c                   end
061200120106     c                   enddo
061300120106
061400120106      * format output field
061500120106     c                   if        lastenddt <> 0
061600120106     C                   MOVE      lastfrmdt     @DATIN
061700120106     C                   EXSR      #DATYM
061800120106     C                   MOVE      @DATOU        lastfrmmdy        8 0
061900120106
062000120106     C                   MOVE      lastenddt     @DATIN
062100120106     C                   EXSR      #DATYM
062200120106     C                   MOVE      @DATOU        lastendmdy        8 0
062300120106
062400120106     c                   eval      raterange = %editc(lastfrmmdy:'Y') +
062500120106     c                             ' - ' + %editc(lastendmdy:'Y')
062600120106     c                   end
062700120106
062800120106     c                   endsr
062900120106
063000120306      **********************************************************
063100120306      * find out of there are any Care First plans in the acct
063200120306      **********************************************************
063300120306     c     #getcf        begsr
063400120306
063500120306     c     acckey        setll     cmct14
0636001203060131 C                   dou       %eof(cmct14)
0637001203060132 C     acckey        READE     cmct14
063800120306     c                   if        not %eof(cmct14) and cmcan = 0
063900120306     c     cmplnkey      chain     plnmst
064000120306     c                   if        %found(plnmst)
064100120306     c     pcarr         chain     carmst
064200120306     c                   if        %found(carmst) and
064300120306     c                             (carbc = '1' or carbc = '2' or carbc = '3'
064400120306     c                             or carbc = '4' or carbc = 'D')
064500120306     c                   move      'Y'           cfplans
064600120306     c                   leave
064700120306     c                   end
064800120306     c                   end
064900120306     c                   end
065000120306     c                   enddo
065100120306
065200120306     c                   endsr
065300120306
0654001201060103 C***************************************************
0655001201060104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0656001201060105 C***************************************************
0657001201060107 C*
0658001201060107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0659001201060107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0660001201060107 C*
0661001201060106 C     #DATYM        BEGSR
066200120106     C                   MOVE      @DATIN        @MD               4 0
066300120106     C                   MOVEL     @DATIN        @Y                4 0
066400120106     C                   MOVEL     @MD           @DATOU            8 0
066500120106     C                   MOVE      @Y            @DATOU
066600120106     C                   MOVE      *ZEROS        @DATIN            8 0
0667001201060120 C                   ENDSR
066800120106     C*
066900180720
067000180720      ********************
067100180720      * create renewal XLS
067200180720      ********************
067300180720     c     #renewal      begsr
067400180720
067500180720     C                   exsr      writexldetRN
067600180720
0677001807200120 C                   ENDSR
067800180720
067900120105      *******************************************
068000120105     c     *inzsr        begsr
068100120105      *******************************************
068200120105
068300120106     c     gratkey       klist
068400120106     c                   kfld                    trust#
068500120106     c                   kfld                    sub#
068600120106     c                   kfld                    plan#
068700120113
068800120113     c     plnkey        klist
068900120113     c                   kfld                    trust#
069000120113     c                   kfld                    sub#
069100120113     c                   kfld                    plan#
069200120113
069300120113     c     acckey        klist
069400120113     c                   kfld                    trust#
069500120113     c                   kfld                    sub#
069600120113     c                   kfld                    acc#
069700120113
069800120306     c     cmplnkey      klist
069900120306     c                   kfld                    CMTRST
070000120306     c                   kfld                    CSUBDV
070100120306     c                   kfld                    CMPLAN
070200140228    ***
070300140228     C     KL#SQTSP      KLIST
070400140228     C                   KFLD                    DSSNO
070500140228     C                   KFLD                    DSEQ#
070600140228     C                   KFLD                    TRUST#
070700140228     C                   KFLD                    SUB#
070800140228     C                   KFLD                    PLAN#
070900140228    ***
071000140228    *** MIMIC CL
071100140228     C                   EVAL      @8 = @LCYM + '32'
071200140228     C                   MOVE      @8            DB05DATE
071300140228    ***
071400140228    ***
071500120105     C                   Exsr      Writexlhead
071600180720     C                   Exsr      WritexlheadRN
071700180720
071800120105     c                   movel     lMM           LMDYchar         10
071900120105     c                   cat       '/':0         LMDYchar
072000120105     c                   cat       ldd:0         LMDYchar
072100120105     c                   cat       '/':0         LMDYchar
072200120105     c                   cat       lyy:0         LMDYchar
072300140228
072400140228     c     grplist       plist
072500140228     c                   parm                    parmkey          15
072600140228     C                   PARM                    PARMSSN           9
072700140228     C                   PARM                    PARMSEQ           2
072800140228     c                   parm                    parmeffymd        8
072900140228     c                   parm                    parmbenamt        7
073000140228     c                   parm                    parmgroup        15
073100140228     c                   parm                    parmbilrte       11
073200140228     c                   parm                    parmnetrte       11
073300140228     c                   parm                    parmbilprem       7
073400140228     c                   parm                    parmnetprem       7
073500140228     c                   parm                    parmfound         1
073600120105
073700120105     c                   endsr
0738009102150104 O******************************************************              DB020
0739009102150105 O*  OUTPUT SPECIFICATIONS                             *              DB020
0740009102150106 O******************************************************              DB020
0741009102150107 O*                                                                   DB020
0742001412240108 OREPORT    H    1P                     2  3
074300141224     O         OR    OF
0744001402280110 O                       CONAME              86
0745001412240108 OREPORT    H    1P                     1
074600141224     O         OR    OF
0747009811110113 O                       *DATE         Y     16
0748001402280114 O                                           73 'MCOV PLAN/RATE AUDIT FOR'
0749001402280114 O                       LMM                 76
0750001402280114 O                                           77 '/'
0751001402280114 O                       LDD                 79
0752001402280114 O                                           80 '/'
0753001402280114 O                       LYY                 84
0754001402280115 O                                          120 'PAGE :'
0755001402280116 O                       PAGE          Z    130
0756001412240108 OREPORT    H    1P                     1
075700141224     O         OR    OF
0758009505080119 O                                           17 'PROG: DB050 '
0759009102150120 O                                          120 'TIME :'
0760009505090121 O                       TIME               130 '  :  :  '
0761001412240108 OREPORT    H    1P                     1
076200141224     O         OR    OF
0763009102150124 O                                           24 '------------------------'
0764009102150125 O                                           48 '------------------------'
0765009102150126 O                                           72 '------------------------'
0766009102150127 O                                           96 '------------------------'
0767009102150128 O                                          120 '------------------------'
0768009102150129 O                                          132 '------------'
0769001412240108 OREPORT    H    1P                     1
077000141224     O         OR    OF
077100141224     O                                           47 'AGE'
077200141224     O                                           53 'COV'
0773001412240136 O                                           60 'PLAN'
0774001402280137 O                                           67 'RATE'
0775001412240108 OREPORT    H    1P                     1
077600141224     O         OR    OF
077700141224     O                                           54 'TYPE'
077800141224     O                                           48 'BAND'
0779009707150133 O                                           23 'T/S/A'
0780009603140133 O                                           32 'PLAN'
0781001412240134 O                                           42 'CATEGORY'
0782001412240136 O                                           61 'ERROR'
0783001402280137 O                                           68 'ERROR'
078400140228     O                                          119 'CODE'
078500970715     O                                          129 'AA NAME'
0786001412240108 OREPORT    H    1P                     1
078700141224     O         OR    OF
0788009102150141 O                                           24 '------------------------'
0789009102150142 O                                           48 '------------------------'
0790009102150143 O                                           72 '------------------------'
0791009102150144 O                                           96 '------------------------'
0792009102150145 O                                          120 '------------------------'
0793009102150146 O                                          132 '------------'
0794001412240147 OREPORT    E            ERROR          1
079500140228     O               54                           7 'ACA'
079600140228     O               54N55                       12 'MBR'
079700140228     O               54 55                       12 'DEP'
0798009603140150 O                       TRUST#              17
079900960314     O                                           18 '-'
0800009603140150 O                       SUB#                21
080100960314     O                                           22 '-'
0802009603140150 O                       ACC#                26
080300141224     O                       PLNCATOUT           38
0804009603140151 O                       PLAN#               32
0805001412240151 O                       AGEBND              46
0806001412240152 O                       COVTYP              53
08070014122401   O               51                          59 'Y'
0808001402280154 O               52                          66 'Y'
080900140228     O                       A_AACODE           118
081000140228     O                       LNAME              132
0811001402280156 OREPORT    T    LR                  3
0812001402280157 O                                           29 '*** TOTAL ERRORS:'
0813001402280158 O                       CNT           ZB    38
