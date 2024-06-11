000100140103     Hoption(*nodebugio) debug dftactgrp(*no) actgrp(*caller)
000200140210     Hbnddir('ALLSRVPGMN')
000300140103
0004009908180002 F******************************************************************
0005000711070003 F* getrate    GROUP BENEFIT SERVICES SOFTWARE                     *
0006009908180004 F*                                                                *
0007009908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0008000710010006 F*            DATE - 10/01/07                                     *
0009009908190007 F*                                                                *
0010000710020013 F*  DESCRIPTION - Get grate record and calc full month premium.   *
0011000710030007 F*               Pass the plan, effdt and benefit amount to       *
0012000710030007 F*               this program and it will return the group #,     *
0013000710030007 F*               billed & net rate, billed & net premium          *
0014000710030007 F*               and a found field telling you if the rate was    *
0015000710030007 F*               found. Make sure the files PLNMST and GRATE      *
0016000710030007 F*               are overridden in the CL that calls the initial  *
0017000710030007 F*               program.                                         *
0018000710030007 F*                                                                *
0019000011070004 F*                parameters to pass:                             *
0020000011070007 F*                -------------------                             *
0021000710010004 F*                1. Trust/sub/plan/ab/ct                         *
0022001401060004 F*                2. SSN                                          *
0023001401060004 F*                3. Dep Sequence                                 *
0024001401060004 F*                4. effdt (YYYYMMDD)                             *
0025001401060004 F*                5. benefit amount                               *
0026001401060004 F*                6. return - group #                             *
0027001401060004 F*                7. return - bill rate                           *
0028001401060004 F*                8. return - net rate                            *
0029001401060004 F*                9. return - bill prem                           *
0030001401060004 F*               10. return - net prem                            *
0031001401060004 F*               11. return - found                               *
0032001402060004 F*                                                                *
0033001402060004  * Programmer note:  If the caller passed in a depseq#, load the  *
0034001402060004  *                   age band portion of parm# 1 with that persons*
0035001402060004  *                   calculated age (on ACA plans only)           *
0036000011070004 F*                                                                *
0037001002180004 F* *** WARNING - Since this program does not set on LR, make      *
0038001002180004 F*               sure any program that calls it closes files      *
0039001002180004 F*               plnmst and grate or does a rclrsc to close       *
0040001002180004 F*               everything.                                      *
0041001401030004 F*                                                                *
0042001401060004 F*  JVA  01-03-2014  Check for ACA plan, accumulate totals        *
0043001401060004 F*  JVA  01-06-2014  Add SSN and Dep Sequence parms               *
0044001402060004 F*  dpb  02-06-2014  New ACA premium function...and prorated amts *
0045001403180004 F*  dpb  03-18-2014  Before loading "pab" for ACA member ensure   *
0046001403180004 F*                   age is < 100 since "pab" is only 2 bytes     *
0047001406110004 F*  DPB  06-09-2014  Clear PARMFOUND in ACA logic                 *
0048001002180004 F*                                                                *
0049009908180016 F******************************************************************
005000071001y2k  FPLNMST    IF   e           k DISK
005100071001y2k  FGRATE     IF   e           k DISK
005200140203
0053000710020153 D  prem           s              7  2
0054000710020153 D  nprem          s              7  2
0055000710020153 D  bilamt         s              7  2
0056000710020153 D  nbilam         s              7  2
0057000710020153 D  ratio          s             12 10
0058000710020153 D  nratio         s             12 10
0059000710020153 D  found          s              1
0060000710020153 D  pbenamt        s              7  0
0061001401060153 D  peffymd        s              8  0
0062001401060153 D  wsq            s              2
0063001401060153 D  dsq            s              2  0
006400140206     D  pssn           s              9  0
006500140203
0066000710010152 D                 DS
0067000710010153 D  pkey                   1     15
0068000710010154 D  Ptrust                 1      3  0
0069000710010154 D  Psub                   4      6  0
0070000710010154 D  Pplan                  7     10
0071000710010155 D  pab                   11     12  0
0072000710010156 D  pct                   13     15
007300140103
007400140206     D aca_ds          ds                  inz
007500140206     D  prem_aca                      7  2
007600140206     D  pro_prem_aca                       like(prem_aca)
007700140206     D  prem_count                    3p 0
007800140206     D  idx                           2  0
007900140206     D  p_error                      50
008000140103
008100140203      /define get_ACA_premiums_pr
008200140203      /define get_ACA_premiums_fields
008300140203      /define get_ACA_premiums_return
008400140203      /define chk_ACA_plan_pr
008500140203      /define chk_ACA_plan_fields
008600140203      /copy qcpysrc,acasrvpgmp
008700140203      /undefine chk_ACA_plan_pr
008800140203      /undefine chk_ACA_plan_fields
008900140203      /undefine get_ACA_premiums_pr
009000140203      /undefine get_ACA_premiums_fields
009100140203      /undefine get_ACA_premiums_return
009200140103
009300001107     c     *entry        plist
009400071001     c                   parm                    parmkey          15
009500140106     c                   parm                    parmssn           9
009600140106     c                   parm                    parmseq           2
009700071001     c                   parm                    parmeffymd        8
009800071001     c                   parm                    parmbenamt        7
009900071001     c                   parm                    parmgroup        15
010000071001     c                   parm                    parmbilrte       11
010100071001     c                   parm                    parmnetrte       11
010200071001     c                   parm                    parmbilprem       7
010300071001     c                   parm                    parmnetprem       7
010400071001     c                   parm                    parmfound         1
010500001107
010600071001     c                   move      parmkey       pkey             15
010700140106     c                   move      parmeffymd    peffymd
010800140103
010900140103     C     ' ':'0'       xlate     parmssn       parmssn
011000140103     C                   move      parmssn       pssn
011100140106
011200140106      * For ACA plans
011300140106      * parmseq = *blanks will result in blank return flag
011400140106      * parmseq = 'FA' will accumulate premiums for all
011500140106      * parmseq = '00' will return the members premium
011600140106      * parmseq = '01' will return that dependent seq# premium
011700140106      *
011800140106     C                   If        parmseq <> '  ' and
011900140106     C                             parmseq <> 'FA'
012000140106     C     ' ':'0'       xlate     parmseq       wsq
012100140106     C                   move      wsq           dsq
012200140106     C                   end
012300071002
012400071002     c                   if        parmbenamt >= '0000000' and
012500071002     c                             parmbenamt <= '9999999'
012600071002     c                   move      parmbenamt    pbenamt
012700071002     c                   else
012800071002     c                   clear                   pbenamt
012900071002     c                   end
013000071001
013100071003   7 C                   clear                   parmgroup
013200071003   7 C                   clear                   parmbilrte
013300071003   7 C                   clear                   parmnetrte
013400071003   7 C                   clear                   parmbilprem
013500071003   7 C                   clear                   parmnetprem
013600071003   7 C                   clear                   parmfound
013700071003   7 C                   clear                   PREM
013800071001   7 C                   clear                   NPREM
013900071001   7 C                   clear                   bilamt
014000071001   7 C                   clear                   nbilam
014100071001   7 C                   clear                   ratio
014200071001   7 C                   clear                   nratio
014300140103     C                   clear                   found
014400140206     C                   clear                   aca_ds
014500071001   7 C*
014600071001   2 C* GET RATE RECORD
014700071001   3 C*
014800071001     C     ratekey       SETLL     GRATE
014900071001     C                   DOU       %eof(grate)
015000071001     C     ratekey       READE     GRATE
015100071002     c                   if        not %eof(grate) and grdltd = 'A' and
015200071001     C                             (peffymd >= frmdat) and (peffymd <= todat)
015300071002     C                   move      'Y'           found
015400071001     c                   leave
015500071001     C                   end
015600071001     C                   ENDDO
015700071001
015800071001  55 C* Calc premium
015900071001     c                   if        found = ' '
016000071001     c                   goto      #end
016100071001     c                   end
016200071001
0163000710010400 C     plankey       chain     plnmst
016400071001     c                   if        not %found(plnmst)
016500071002     c                   clear                   found
016600071001     c                   goto      #end
016700071001     c                   end
016800071001
016900071102  55 C* prtype = premium
017000071102  55 C* If round premium = Yes - Round to the penny and truncate to 7.2
017100071102  55 C*                   else - truncate to 7.2
017200071102
017300071001  57 C                   if        prtype = 'P'
017400071102     c                   if        prndprm = 'Y'
017500071102  58 C     bilrte        mult(h)   1             PREM
017600071102  58 C     netrte        mult(h)   1             NPREM
017700071102     c                   else
017800071011  58 C                   z-add     BILRTE        PREM
017900071011  58 C                   z-add     NETRTE        NPREM
018000071102  59 C                   end
018100071102  59 C                   END
018200071001
018300071001  55 C* prtype = ratio - calc amount (rate per 1000)
018400071102  55 C* If round premium = Yes - Round to the penny and truncate to 7.2
018500071102  55 C*                   else - truncate to 7.2
018600071102
018700071001   3 C                   if        prtype = 'R'
018800071002   4 C     BILRTE        DIV       1000          RATIO
018900071002   4 C     NETRTE        DIV       1000          NRATIO
019000071102     c                   if        prndprm = 'Y'
019100071102   5 C     pbenamt       MULT(H)   RATIO         BILAMT
019200071102   5 C     pbenamt       MULT(H)   NRATIO        NBILAM
019300071102     c                   else
019400071011   5 C     pbenamt       MULT      RATIO         BILAMT
019500071011   5 C     pbenamt       MULT      NRATIO        NBILAM
019600071102   7 C                   end
019700071001   6 C                   z-add     BILAMT        PREM
019800071001   6 C                   z-add     NBILAM        NPREM
019900071102   7 C                   end
020000071001   8
020100071001      * set up parms to be passed back
020200071001     c                   move      group#        parmgroup
020300071001     c                   move      bilrte        parmbilrte
020400071001     c                   move      netrte        parmnetrte
020500071001     c                   move      prem          parmbilprem
020600071001     c                   move      nprem         parmnetprem
020700071001     c                   move      found         parmfound
020800071001
020900071001     c     #end          tag
021000140103
021100140103      * Check for ACA Plan and a SSN was passed
021200140103      * Combine family total premium
021300140103      /free
021400140203
021500140206       //?call function to see if plan is an ACA plan
021600140203       if #chk_aca_plan(ptrust:psub:pplan) = 'Y' and pssn <> 0 ;
021700140207
021800140207        //?we know we have an ACA plan...clear parmfound and only set to 'Y'
021900140207        //?if no errors found retrieving ACA rates
022000140207        clear parmfound ;
022100140203
022200140206        //?call function to get ACA premiums for this member/dependents
022300140203        p_mbrdeparry = #get_ACA_premiums(ptrust:psub:pplan:
022400140206                         pssn:peffymd:p_error:prem_count) ;
022500140206
022600140206        if p_error = *blanks and prem_count > *zeros ;
022700140203         parmfound = 'Y' ;
022800140106
022900140203         select ;
023000140106
023100140206          When parmseq = '  ' ; // amts are already zero so do nothing
023200140106
023300140206          When parmseq = 'FA' ; // family - add up all array entries
023400140206           for idx = 1 to prem_count ;
023500140206            prem_aca += p_mbrdeparry(idx).acarate ;
023600140206            pro_prem_aca += p_mbrdeparry(idx).proacarate ;
023700140203           endfor ;
023800140106
023900140206          When parmseq = '00' ; // mbr only - get first occurence
024000140212           prem_aca = p_mbrdeparry(1).acarate ;
024100140212           pro_prem_aca = p_mbrdeparry(1).proacarate ;
024200140318           if p_mbrdeparry(1).age < 100 ;
024300140318            pab = p_mbrdeparry(1).age ;
024400140318           endif ;
024500140106
024600140206          Other; // specific dependent...find that dependent in array
024700140206           idx = %lookup(dsq:p_mbrdeparry(*).depseq) ;
024800140206           if idx > 0 ;
024900140212            prem_aca = p_mbrdeparry(idx).acarate ;
025000140212            pro_prem_aca = p_mbrdeparry(idx).proacarate ;
025100140318            if p_mbrdeparry(idx).age < 100 ;
025200140318             pab = p_mbrdeparry(idx).age ;
025300140318            endif;
025400140206           endif;
025500140106
025600140206         endsl;
025700140106
025800140207         parmkey = pkey ;
025900140206        endif;
026000140206
026100140206        //?now...set return values...full month premium gets moved to "rate"
026200140206        //?fields...prorated premium gets moved to "prem" fields
026300140219        parmbilrte = %editc( prem_aca : 'X' ) ;
026400140219        parmnetrte = %editc( prem_aca : 'X' ) ;
026500140206
026600140219        parmbilprem = %editc( pro_prem_aca : 'X' ) ;
026700140219        parmnetprem = %editc( pro_prem_aca : 'X' ) ;
026800140206
026900140206       endif;
027000140206
027100140103      /end-free
027200071001
027300071001   9 C                   return
027400071001
027500071001     c     *inzsr        begsr
027600071001     C     ratekey       KLIST
027700071001     C                   KFLD                    Ptrust
027800071001     C                   KFLD                    Psub
027900071001     C                   KFLD                    Pplan
028000071001     C                   KFLD                    pab
028100071001     C                   KFLD                    pct
0282000710010215
028300071001     C     plankey       KLIST
028400071001     C                   KFLD                    Ptrust
028500071001     C                   KFLD                    Psub
028600071001     C                   KFLD                    Pplan
0287000710010215
028800071001   9 C                   ENDSR
