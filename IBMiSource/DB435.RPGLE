000100060524     H  OPTION(*NODEBUGIO : *SRCSTMT)
0002000503030002 F******************************************************************
0003000605230003 F* db435      GROUP BENEFIT SERVICES, INC.                        *
0004000503030004 F*                                                                *
0005000503030005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006000605230006 F*            DATE - 05/23/06                                     *
0007000503030007 F*                                                                *
0008000605230011 F* THIS PROGRAM WILL LIST THE ACTIVE ELIGIBLE MEMBERS IN          *
0009000605300011 F* COBRA ACCOUNTS with the prem and the commission info           *
0010000503030011 F*                                                                *
001100060602      * 06/02/06 dlk - add new com schedule for future use             *
001200060602      *              - add global % of prem                            *
001300070927      * 09/27/07 dlk - change bilrte to 6 decimal                      *
001400090105      * 01/05/09 dlk - find brkrcom rec by date range                  *
0015001102040011 F* 02/04/11 dlk - per Shelly and Dave A - Exclude plans OPTM & OPTD
0016001312060011 F*                even though they are a cat type "M". - Per Dave A and Shelly
0017001103170011 F* 03/17/11 dlk - add cobra fed / state flag
0018001206180011 F* 06/18/12 dlk - add FSA plan category type "F" to list of plans
0019001206180011 F*                eligible for admin fee
0020001312060011  * DLK 12/06/13 - Hard coded exclusion of plans WAVM, WAVD, WAVV due
0021001312060011  *                to a design flaw in OLE. - Per Dave A.
0022001510230011  * DLK 10/23/15 - Hard coded exclusion of plans DECD, DECM and DECV
0023001510230011  *                since no other soultion has been accepted yet
0024001809250011  * 09/24/18 dlk - add EAP plan category type "C" (fed cobra only)
0025001809250011 F*                as eligible for admin fee
0026001812100011  * DLK 12/10/18 - Hard code Humana med and den carriers in md state
0027001812100011  *                accts as ineligible. Humana does not allow state
0028001812100011  *                extension.
0029001812100011 F*                                                                *
0030000503030013 F******************************************************************
003100050228      *
0032000111260005 Faccmst    ip   e           k disk
0033000502280005 Fmemac#    if   e           k disk
0034000502280005 Fmcov      if   e           k disk
0035000506270005 Fmcovx     if   e           k disk    rename(mcovr:mcovxr)
0036000111260005 Fsman      if   e           k disk
0037000605230005 Fcmct14    if   e           k disk
0038000605230039 FCRAT13    IF   e           k DISK
0039000502280018 FPLNMST    IF   e           k DISK
004000050228     Fcodesl1   IF   E           K DISK
0041000605230019 FGRATE     IF   e           k DISK
0042000606020046 Fcarmst    IF   e           k DISK
0043000606020014 Fmktcara1  IF   e           k DISK
0044000606020014 Fbrkrcom1  IF   e           k DISK
0045000605230017 Fdb435xl   o  a e             DISK
004600060524
0047000605240037 D workdt          S               d   datfmt(*iso)
0048000605240037 D workdtnum       S              8  0
0049000503040125 Dcsv              c                   const('","')
0050000503030125 Dmedflg           s              1
0051000503030125 Dyesfee           s              1
0052000605230125 Dxlmname          s             20
0053000605230125 Dxlacname         s             30
0054000605240125 Dxlacsrv          s                   like(acobsrv)
0055001103170125 Dxlfcstfl         s                   like(fcstfl)
0056000605240125 Dxlacfee          s                   like(cobadm)
0057000605240037 Dxlmemcnt         S              6  0
005800060523
0059000605230037 D h_comrte        S                   like(comrte)
0060000605240037 D h_prem          S                   like(bilrte)
0061000605240037 D h_smancd        S              3
0062000605240037 D h_smanname      S             20
0063000606020037 D h_comsch        S                   like(comsch)
0064000606020037 D h_pcarr         S                   like(pcarr)
006500060602     d w9mksz          s                   like(maszcd)
0066000606020133 D  wkpct          s              7  6
006700060523
0068000605230037 D xlplan          S              4
0069000709270037 D xlbilrat        S                   like(bilrte)
0070000709270037 D xltotprm        S             +1    like(bilrte)
0071000605260037 D xltotcom        S              8  2
0072000605240037 D xlsm1           S              3
0073000605240125 D xlsmnam1        s             20
0074000605230037 D xlrel1          S              8
0075000709270037 D xlrat1          S                   like(bilrte)
0076000605240037 D xlsm2           S              3
0077000605240125 D xlsmnam2        s             20
0078000605230037 D xlrel2          S              8
0079000709270037 D xlrat2          S                   like(bilrte)
0080000605240037 D xlsm3           S              3
0081000605240125 D xlsmnam3        s             20
0082000605230037 D xlrel3          S              8
0083000709270037 D xlrat3          S                   like(bilrte)
0084000605260037 D*xlsm4           S              3
0085000605260125 D*xlsmnam4        s             20
0086000605260037 D*xlrel4          S              8
0087000709270037 D*xlrat4          S                   like(bilrte)
008800060523      *
008900050302     D                 dS
0090000710110055 D h_tspabct               1     15
0091000710110055 D h_trust                 1      3  0
0092000710110055 D h_sub                   4      6  0
0093000710110055 D h_plan                  7     10
0094000710110055 D h_ageb                 11     12  0
0095000710110055 D h_covtyp               13     15
009600071011     D                 dS
0097000503020125 D  tsa                    1     10  0
0098000503010125 D  actrst                 1      3  0
0099000503010125 D  acsub#                 4      6  0
0100000503010125 D  acacct                 7     10  0
010100050302     D                udS
0102000605240054 D  ldors                  1      1
0103000605240054 D  CONAME               201    240
0104000503030055 D  TIME                 242    247  0
0105000503030157 D  UD8YMD               248    255  0
010600050627
010700060523     c                   movel     acnam1        xlacname
010800060524     c                   move      acobsrv       xlacsrv
010900110317     c                   move      fcstfl        xlfcstfl
011000060524     c                   move      cobadm        xlacfee
011100060524     c                   clear                   xlmemcnt
011200060524
011300060524     c                   clear                   xlsm1
011400060524     c                   clear                   xlsmnam1
011500060524     c                   clear                   xlrel1
011600060524     c                   clear                   xlrat1
011700060524     c                   clear                   xlsm2
011800060524     c                   clear                   xlsmnam2
011900060524     c                   clear                   xlrel2
012000060524     c                   clear                   xlrat2
012100060524     c                   clear                   xlsm3
012200060524     c                   clear                   xlsmnam3
012300060524     c                   clear                   xlrel3
012400060524     c                   clear                   xlrat3
012500060526     c*                  clear                   xlsm4
012600060526     c*                  clear                   xlsmnam4
012700060526     c*                  clear                   xlrel4
012800060526     c*                  clear                   xlrat4
012900060524
013000060524      * clear plan info here if summary run
013100060524     c                   if        ldors = 'S'
013200060524     c                   clear                   xlplan
013300060524     c                   clear                   xlbilrat
013400060525     c                   clear                   xltotprm
013500060526     c                   clear                   xltotcom
013600060524     c                   end
013700060524
013800050302
013900050630      * read members in acct, skip cobra memebrs and non-employees
014000060525      * and retirees
014100050228     c     acckey        setll     memac#
0142000502280131 C                   dou       %eof(memac#)
0143000502280132 C     acckey        READE     memac#
0144000503040133 C                   if        %eof(memac#) or cexpdt <> 0 or
014500050630     c                             termdt <> 0 or empst = 'C' or
014600060525     c                             empst = 'R' or nonemp = 'Y'
014700050304     c                   iter
014800050304     c                   end
014900050228
015000050303     c                   clear                   medflg
015100050228     c                   clear                   yesfee
015200060523     c                   clear                   xlmname
015300060524
015400060524      * clear plan info here if detail run
015500060524     c                   if        ldors = 'D'
015600060524     c                   clear                   xlplan
015700060524     c                   clear                   xlbilrat
015800060524     c                   clear                   xlsm1
015900060524     c                   clear                   xlsmnam1
016000060524     c                   clear                   xlrel1
016100060524     c                   clear                   xlrat1
016200060524     c                   clear                   xlsm2
016300060524     c                   clear                   xlsmnam2
016400060524     c                   clear                   xlrel2
016500060524     c                   clear                   xlrat2
016600060524     c                   clear                   xlsm3
016700060524     c                   clear                   xlsmnam3
016800060524     c                   clear                   xlrel3
016900060524     c                   clear                   xlrat3
017000060526     c*                  clear                   xlsm4
017100060526     c*                  clear                   xlsmnam4
017200060526     c*                  clear                   xlrel4
017300060526     c*                  clear                   xlrat4
017400060524     c                   end
017500060524
017600060523     c     mfname        cat       mlname:1      xlmname
017700060524
017800050303      * find active mcov
017900050228     c     mbssno        setll     mcov
0180000605250131 C                   dou       %eof(mcov)
0181000502280132 C     mbssno        READE     mcov
0182000503040133 c                   if        %eof(mcov) or (enrldt = candt) or
018300060524      * skip future enroll plans
018400060524     c                             (enrldt > runymd) or
018500110204     c                             (candt <> 0 and candt <= runymd) or
018600110204      * 2/4/11 exclude opt out payroll plans
018700131206      * 12/06/13 exclude opt out waiver plans per Dave A
018800151023      * 10/23/15 exclude decline plans
018900131206     c                             (mcplan = 'OPTM' or mcplan = 'OPTD' or
019000131206     c                              mcplan = 'WAVM' or mcplan = 'WAVD' or
019100151023     c                              mcplan = 'WAVV' or
019200151023     c                              mcplan = 'DECM' or mcplan = 'DECD' or
019300151023     c                              mcplan = 'DECV')
019400050304     c                   iter
019500050304     c                   end
019600050228
019700060524      * check plan
0198000502280171 C     PLNKEY        CHAIN     PLNMST
019900050228     c                   if        %found(plnmst)
020000181210
020100181210      * 12/10/18 - Skip Humana med & den in state accounts since they are
020200181210      *            not elig for state extension
020300181210     c                   if        (pcarr = 'HUM' or pcarr = 'HUD')
020400181210     c                             and fcstfl = 'S'
020500181210     c                   iter
020600181210     c                   end
020700181210
020800181210      * only medical, dental, vision, rx, FSA and EAP (Fed cobra only)
020900181210      * are elig for cobra admin fee
021000050303     c     plncat        chain     codesl1
021100050228     c                   if        %found(codesl1) and
021200050228     c                             (action = 'M' or action = 'D' or
021300120618     c                             action = 'V' or action = 'R' or
021400180925     c                             action = 'F' or
021500180925     c                             (action = 'C' and fcstfl = 'F'))
021600050228     c                   eval      medflg = 'Y'
0217000502280184 c                   end
021800050301
021900050301      * plan cat "PCA" = cobra admin fee
022000050301     c                   if        plncat = 'PCA'
022100050303     c                   move      'Y'           yesfee
022200060525     c                   move      mcplan        xlplan
022300060525     c                   move      mctrst        h_trust
022400060525     c                   move      mcsub#        h_sub
022500060525     c                   move      mcplan        h_plan
022600060525     c                   move      mcageb        h_ageb
022700060525     c                   move      mcovtp        h_covtyp
022800060602     c                   move      pcarr         h_pcarr
022900060602
023000060602     c                   clear                   h_comsch
0231000606020311 C     PCARR         CHAIN     CARMST
023200060602     c                   if        %found(carmst)
023300060602     c                   move      comsch        h_comsch
023400060602     c                   end
023500060602
023600000928     c                   end
0237000606020184 c                   end
023800060602
023900050304     c                   enddo
024000981229
024100060523      * if mem is elig for cobra (medflg = Y), include in spreadsheet
024200060524      * if an admin fee plan is active, use it to find the commission info
024300060524      *    else - show the account master sman code
024400060523
024500060523     c                   if        medflg = 'Y'
024600060523     c                   if        yesfee = 'Y'
024700060524     c                   exsr      #getrate
024800060602
024900060602     c                   exsr      #getcom
025000060602
025100060524     c                   else
025200060524     c                   move      smancd        xlsm1
025300060524     c                   clear                   xlsmnam1
0254000605240266 C     smancd        CHAIN     SMAN
025500060524     c                   if        %found(sman)
025600060524     c                   movel     sfname        xlsmnam1
025700060524     c                   cat       slname:1      xlsmnam1
025800060524     c                   end
025900060523     c                   end
026000060524
026100060524     c                   add       1             xlmemcnt
026200060524      * print line here if detail selected
026300060524     c                   if        ldors = 'D'
026400060523     C                   exsr      writexldet
026500011126     c                   end
026600060524     c                   end
026700011126
026800050228     c                   enddo
026900060524
027000060524      * print line if summary selected and at least one member in acct
027100060524     c                   if        ldors = 'S' and xlmemcnt <> 0
027200060524     C                   exsr      writexldet
027300060524     c                   end
027400050301
027500050302     c     #end          tag
027600060523
027700060524      **********************************
027800060602      * get commission info
027900060523      **********************************
028000060602     c     #getcom       begsr
028100060523
028200060524     c                   clear                   xlsm1
028300060524     c                   clear                   xlsmnam1
028400060524     c                   clear                   xlrel1
028500060524     c                   clear                   xlrat1
028600060524     c                   clear                   xlsm2
028700060524     c                   clear                   xlsmnam2
028800060524     c                   clear                   xlrel2
028900060524     c                   clear                   xlrat2
029000060524     c                   clear                   xlsm3
029100060524     c                   clear                   xlsmnam3
029200060524     c                   clear                   xlrel3
029300060524     c                   clear                   xlrat3
029400060526     c*                  clear                   xlsm4
029500060526     c*                  clear                   xlsmnam4
029600060526     c*                  clear                   xlrel4
029700060526     c*                  clear                   xlrat4
0298000605230086 C                   clear                   comcnt            2 0
029900060524
030000060523     C     comkey        SETLL     CMCT14
0301000605230078 C                   dou       %eof(cmct14)
0302000605230080 C     comkey        READE     CMCT14
030300060523     c                   if        %eof(cmct14) or
030400060523     c                             (runymd < effdat) or (cmcan <> 0 and
030500060523     c                             runymd > cmcan) or (effdat = cmcan) or
030600060523     c                             (cmdltd = 'D')
030700060523     c                   iter
030800060523     c                   end
030900060523
0310000605230075 C* a valid comctx has been found
0311000605230086 C                   ADD       1             comcnt
031200060602
0313000606020272  * calc commission based on old (1) or new (2) schedule
031400060602     c                   if        h_comsch = '1'
031500060602     c                   exsr      #oldcom
031600060602     c                   else
031700060602     c                   exsr      #newcom
031800060602     c                   end
031900060602
032000060524      * store comm info for later print
032100060524     c                   exsr      #storecom
032200060523     c                   enddo
032300060523
032400060523     c                   endsr
032500060523
032600060523      ******************************************
032700060523      * old commission schedule
032800060523      ******************************************
032900060523     c     #oldcom       begsr
033000060523
0331000605230252 C                   clear                   h_comrte
0332000605240252 C                   clear                   h_smanname
0333000605240252 C                   clear                   h_smancd
033400060523
033500060523      * GET SALESMAN MASTER FILE FOR STYPE IN CRATE SEARCH
0336000605230266 C     SLSMAN        CHAIN     SMAN
033700060523     c                   if        not %found(sman)
033800060523     C                   leavesr
033900060523     c                   end
034000060523
034100060524     c                   movel     smancd        h_smancd
034200060524     c                   movel     sfname        h_smanname
034300060524     c                   cat       slname:1      h_smanname
034400060523
0345000605230237  * get crate
0346000605230245 C     CRATKY        SETLL     CRAT13
0347000605230247 C                   dou       %eof(crat13)
0348000605230248 C     CRATKY        READE     CRAT13
034900060523
035000060523     C                   if        (not %eof(crat13)) and
035100060523     C                             (crdltd <> 'D') and
035200060523     C                             (effdat >= frdate and effdat <= todate)
0353000605230275  *  IS THE COMMISSION EXPIRED?
0354000605230285 C                   if        comprd <> 0
0355000605230273 C                   move      effdat        workdt
035600060523     c                   adddur    comprd:*m     workdt
0357000605230273 C                   move      workdt        workdtnum
0358000605230293 C                   if        workdtnum <= runymd
035900060523     c                   iter
0360000605230299 C                   end
0361000605230299 C                   end
036200060523
036300060602      * calc com
036400060602     c                   select
036500060602     c                   when      comtyp = 'HFF'
036600060602     c                   move      comrte        h_comrte
036700060602     c                   when      comtyp = 'HPP'
036800060602     c     h_prem        mult(h)   comrte        workrate          9 2
036900060602     c     workrate      div(h)    100           workrate
037000060602     c                   move      workrate      h_comrte
037100060602     c                   endsl
037200060602
0373000605230252 C                   leave
0374000605230253 C                   END
037500060523
037600060523     c                   enddo
037700060523
0378000605230416 C                   endsr
037900060524
038000060602      ******************************************
038100060602      * new commission schedule
038200060602      ******************************************
038300060602     c     #newcom       begsr
038400060602
0385000606020252 C                   clear                   h_comrte
0386000606020252 C                   clear                   h_smanname
0387000606020252 C                   clear                   h_smancd
038800060602
038900060602      * GET SALESMAN NAME
0390000606020266 C     SLSMAN        CHAIN     SMAN
039100060602     c                   if        not %found(sman)
039200060602     C                   leavesr
039300060602     c                   end
039400060602
039500060602     c                   movel     smancd        h_smancd
039600060602     c                   movel     sfname        h_smanname
039700060602     c                   cat       slname:1      h_smanname
039800060602
0399000606020104  * Only execute body if Pay Commission flag is not 'N'
040000060602      * 5/29/03 new definition of ccpnc : N = no com, no prem, no mem cnt
040100060602      *                                   P = no com, yes prem, yes mem cnt
040200060602
040300060602     c                   if        ccpnc = 'N' or ccpnc = 'P'
040400060602     c                   leavesr
040500060602     c                   end
0406000606020104  *
0407000606020456  * Get Acct Mkt size - default to 50 if not found
040800060602
040900060602     c                   clear                   w9mksz
041000060602     c     mkcaky        setll     mktcara1
041100060602     C                   dou       %eof(mktcara1)
041200060602     c     mkcaky        reade     mktcara1
0413000606020133 C                   if        (not %eof(mktcara1)) and
041400060602     c                             (mafrdt <> matodt) and
041500060602     c                             ((mafrdt <= runymd and matodt >= runymd) or
041600060602     c                             (mafrdt <= runymd and matodt = 0 ))
041700060602     c                   movel     maszcd        w9mksz
041800060602     c                   leave
041900060602     c                   endif
042000060602     c                   enddo
0421000606020456  *
042200060602     c                   if        w9mksz = *blanks
042300060602     c                   movel     '50'          w9mksz
042400060602     c                   endif
042500060602
042600090105      * get global broker commision rec
042700060602     c                   clear                   rbrkrcom
042800090105     c                   clear                   foundbrkrc        1
042900090105     c     brcmky        setll     brkrcom1
043000090105     c                   dou       %eof(brkrcom1)
043100090105     c     brcmky        reade     brkrcom1
043200090105     C                   if        (not %eof(brkrcom1)) and
043300090105     C                             (bcfromdt <> bctodate) and
043400090105     c                             ((bcfromdt <= runymd and bctodate >= runymd)
043500090105     c                               or (bcfromdt <= runymd and bctodate = 0))
043600090105     c                   eval      foundbrkrc = 'Y'
043700090105     c                   leave
043800090105     c                   end
043900090105     c                   enddo
044000090105
044100090105     c                   if        foundbrkrc = 'Y'
044200060602      * global fee per member - default method
044300060602     c                   z-add     bcamnt        h_comrte
044400060602
044500060602      * global % of prem
044600060602     c                   if        bcpop <> 0
044700060602     c                   clear                   wkpct
044800060602     c     bcpop         div       100           wkpct
044900070927     c     wkpct         mult      h_prem        h_comrte
045000060602     c                   end
045100060602
045200060602     c                   endif
045300060602
045400060602      ********
0455000606020456  * process overrides to global commission
045600060602      ********
0457000606020456
0458000606020456  * flat fee per member override
045900060602     c                   if        ccovra <> *zero
046000060602     c                   z-add     ccovra        h_comrte
046100060602
046200060602     c                   else
046300060602
0464000606020456  * % of commission override
046500060602     c                   if        ccovpc <> *zero
046600060602     c     ccovpc        div       100           wkpct
046700060602     c                   mult      wkpct         h_comrte
046800060602
046900060602     c                   else
047000060602
0471000606020456  * % of premium override
047200060602
047300060602     c                   if        ccovpp <> *zero
047400060602     c     ccovpp        div       100           wkpct
047500070927     c     wkpct         mult      h_prem        h_comrte
047600060602     c                   end
047700060602
047800060602     c                   endif
047900060602     c                   endif
048000060602
0481000606020416 C                   endsr
048200060602
048300060524      ************************************************
048400060524      * store commision info for later print
048500060524      ************************************************
048600060524     c     #storecom     begsr
048700060524
048800060524      * 1st commission
048900060524     c                   if        comcnt = 1
049000060524     c                   move      h_smancd      xlsm1
049100060524     c                   move      h_smanname    xlsmnam1
049200060524     c                   move      cmrelid       xlrel1
049300070927     c                   z-add     h_comrte      xlrat1
049400060526     c                   add       xlrat1        xltotcom
049500060524     c                   end
0496000605240075
049700060524      * 2nd commission
049800060524     c                   if        comcnt = 2
049900060524     c                   move      h_smancd      xlsm2
050000060524     c                   move      h_smanname    xlsmnam2
050100060524     c                   move      cmrelid       xlrel2
050200070927     c                   z-add     h_comrte      xlrat2
050300060526     c                   add       xlrat2        xltotcom
050400060524     c                   end
0505000605240075
050600060524      * 3rd commission
050700060524     c                   if        comcnt = 3
050800060524     c                   move      h_smancd      xlsm3
050900060524     c                   move      h_smanname    xlsmnam3
051000060524     c                   move      cmrelid       xlrel3
051100070927     c                   z-add     h_comrte      xlrat3
051200060526     c                   add       xlrat3        xltotcom
051300060524     c                   end
0514000605240075
051500060524      * 4th commission
051600060526     c*                  if        comcnt = 4
051700060526     c*                  move      h_smancd      xlsm4
051800060526     c*                  move      h_smanname    xlsmnam4
051900060526     c*                  move      cmrelid       xlrel4
052000070927     c*                  z-add     h_comrte      xlrat4
052100060526     c*                  add       xlrat4        xltotcom
052200060526     c*                  end
052300060526
052400060524     c                   endsr
0525000605240075
052600060523      ******************************
052700060523      * get grate
052800060523      ******************************
052900060523     c     #getrate      begsr
053000060524     c                   clear                   xlbilrat
0531000605240086 C                   clear                   h_prem
053200071011
053300071011     c     grplist       plist
053400071011     c                   parm                    parmkey          15
053500140106     C                   PARM                    PARMSSN           9
053600140106     C                   PARM                    PARMSEQ           2
053700071011     c                   parm                    parmeffymd        8
053800071011     c                   parm                    parmbenamt        7
053900071011     c                   parm                    parmgroup        15
054000071011     c                   parm                    parmbilrte       11
054100071011     c                   parm                    parmnetrte       11
054200071011     c                   parm                    parmbilprem       7
054300071011     c                   parm                    parmnetprem       7
054400071011     c                   parm                    parmfound         1
054500140106    *
054600140106     C                   EVAL      PARMSSN = *BLANKS
054700140106     C                   EVAL      PARMSEQ = *BLANKS
054800071011
054900071011     c                   move      h_tspabct     parmkey
055000071011     c                   move      runymd        parmeffymd
055100071011     c                   move      *zeros        parmbenamt
055200071011     c                   clear                   parmgroup
055300071011     c                   clear                   parmbilrte
055400071011     c                   clear                   parmnetrte
055500071011     c                   clear                   parmbilprem
055600071011     c                   clear                   parmnetprem
055700071011     c                   clear                   parmfound
055800071011
055900071011     c                   call      'GETRATE'     grplist
056000071011      * grate returned
0561000710110361 C                   if        parmfound = 'Y'
056200071011     c                   move      parmbilrte    wkbilrte         11 6
056300071011     c                   z-add     wkbilrte      h_prem
056400071011     c                   z-add     wkbilrte      xlbilrat
056500071011     c                   add       wkbilrte      xltotprm
0566000710110089 C                   end
056700060523
0568000605230416 C                   endsr
056900060523     C*
0570000503040164 C*************************************************************
0571000503040164 C*                                                           *
0572000503040164 C* Write Spreadsheet Detail                                  *
0573000503040164 C*                                                           *
0574000503040164 C*************************************************************
057500050304     C     Writexldet    BEGSR
057600050304
057700060523     c                   clear                   db435fld
057800060524
057900060524      * detail version
058000060524     c                   if        ldors = 'D'
058100060523     C                   Eval      db435fld  = '"' +
058200060524     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
058300060524     C                             %trim(xlacname)                      + csv +
058400060524     C                             %trim(xlacsrv)                       + csv +
058500110317     C                             %trim(xlfcstfl)                      + csv +
058600060524     C                             %trim(%editc(xlacfee:'M':*cursym))   + csv +
058700060523     C                             %trim(%editw(MBSSNO:'0   -  -    ')) + csv +
058800060523     C                             %trim(xlmname)                       + csv +
058900060524     C                             xlplan                               + csv +
059000060524     C                             %trim(%editc(xlbilrat:'M':*cursym))  + csv +
059100060524     C                             xlsm1                                + csv +
059200060524     C                             %trim(xlsmnam1)                      + csv +
059300060524     C                             xlrel1                               + csv +
059400060524     C                             %trim(%editc(xlrat1:'M':*cursym))    + csv +
059500060524     C                             xlsm2                                + csv +
059600060524     C                             %trim(xlsmnam2)                      + csv +
059700060524     C                             xlrel2                               + csv +
059800060524     C                             %trim(%editc(xlrat2:'M':*cursym))    + csv +
059900060524     C                             xlsm3                                + csv +
060000060524     C                             %trim(xlsmnam3)                      + csv +
060100060524     C                             xlrel3                               + csv +
060200060524     C                             %trim(%editc(xlrat3:'M':*cursym))    + csv +
060300060526     C*                            xlsm4                                + csv +
060400060526     C*                            %trim(xlsmnam4)                      + csv +
060500060526     C*                            xlrel4                               + csv +
060600060526     C*                            %trim(%editc(xlrat4:'M':*cursym))    + csv +
060700060526     C                                                                    '",'
060800060524
060900060524      * summary version
061000060524     c                   else
061100060524     C                   Eval      db435fld  = '"' +
061200060524     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
061300060524     C                             %trim(xlacname)                      + csv +
061400060524     C                             %trim(xlacsrv)                       + csv +
061500110317     C                             %trim(xlfcstfl)                      + csv +
061600060524     C                             %trim(%editc(xlacfee:'M':*cursym))   + csv +
061700060524     C                             %trim(%editc(xlmemcnt:'M'))          + csv +
061800060524     C                             xlplan                               + csv +
061900060524     C                             %trim(%editc(xlbilrat:'M':*cursym))  + csv +
062000060525     C                             %trim(%editc(xltotprm:'M':*cursym))  + csv +
062100060526     C                             %trim(%editc(xltotcom:'M':*cursym))  + csv +
062200060524     C                             xlsm1                                + csv +
062300060524     C                             %trim(xlsmnam1)                      + csv +
062400060524     C                             xlrel1                               + csv +
062500060524     C                             %trim(%editc(xlrat1:'M':*cursym))    + csv +
062600060524     C                             xlsm2                                + csv +
062700060524     C                             %trim(xlsmnam2)                      + csv +
062800060524     C                             xlrel2                               + csv +
062900060524     C                             %trim(%editc(xlrat2:'M':*cursym))    + csv +
063000060524     C                             xlsm3                                + csv +
063100060524     C                             %trim(xlsmnam3)                      + csv +
063200060524     C                             xlrel3                               + csv +
063300060524     C                             %trim(%editc(xlrat3:'M':*cursym))    + csv +
063400060526     C*                            xlsm4                                + csv +
063500060526     C*                            %trim(xlsmnam4)                      + csv +
063600060526     C*                            xlrel4                               + csv +
063700060526     C*                            %trim(%editc(xlrat4:'M':*cursym))    + csv +
063800060526     C                                                                    '",'
063900060524
064000060524     c                   end
064100050304     C*
064200060523     C                   Write     db435xr
0643000503040320 C                   ENDSR
064400050304     C*
064500050304     C/EJECT
064600050304     C*************************************************************
064700050304     C*                                                           *
064800050304     C* Write Spreadsheet heading                                 *
064900050304     C*                                                           *
065000050304     C*************************************************************
065100050304     C     Writexlhead   BEGSR
065200050304
065300060523     c                   clear                   db435fld
065400060524
065500060524      * detail version
065600060524     c                   if        ldors = 'D'
065700060524     C                   Eval      db435fld = '"' + 'ACC #'         + csv +
065800060524     C                                              'ACC NAME'      + csv +
065900060524     C                                              'COBRA SERV'    + csv +
066000110317     C                                              'FED/ST'        + csv +
066100060524     C                                              'ADM FEE'       + csv +
066200060524     C                                              'SSN'           + csv +
066300060524     C                                              'MEM NAME'      + csv +
066400060523     C                                              'ADMIN PLAN'    + csv +
066500060523     C                                              'BILL RATE'     + csv +
066600060523     C                                              'SMAN 1'        + csv +
066700060524     C                                              'SMAN 1 NAME'   + csv +
066800060523     C                                              'REL 1'         + csv +
066900060524     C                                              'COMM AMT 1'    + csv +
067000060523     C                                              'SMAN 2'        + csv +
067100060524     C                                              'SMAN 2 NAME'   + csv +
067200060523     C                                              'REL 2'         + csv +
067300060524     C                                              'COMM AMT 2'    + csv +
067400060523     C                                              'SMAN 3'        + csv +
067500060524     C                                              'SMAN 3 NAME'   + csv +
067600060523     C                                              'REL 3'         + csv +
067700060524     C                                              'COMM AMT 3'    + csv +
067800060526     C*                                             'SMAN 4'        + csv +
067900060526     C*                                             'SMAN 4 NAME'   + csv +
068000060526     C*                                             'REL 4'         + csv +
068100060526     C*                                             'COMM AMT 4'    + csv +
068200060526     C                                                                '",'
068300060524
068400060524      * summary version
068500060524     c                   else
068600060524
068700060524     C                   Eval      db435fld = '"' + 'ACC #'         + csv +
068800060524     C                                              'ACC NAME'      + csv +
068900060524     C                                              'COBRA SERV'    + csv +
069000110317     C                                              'FED/ST'        + csv +
069100060524     C                                              'ADM FEE'       + csv +
069200060525     C                                              'ELIGIBLE MEM'   + csv +
069300060524     C                                              'ADMIN PLAN'    + csv +
069400060524     C                                              'BILL RATE'     + csv +
069500060526     C                                              'TOTAL PREM'     + csv +
069600060526     C                                              'TOTAL COMM'     + csv +
069700060524     C                                              'SMAN 1'        + csv +
069800060524     C                                              'SMAN 1 NAME'   + csv +
069900060524     C                                              'REL 1'         + csv +
070000060524     C                                              'COMM AMT 1'    + csv +
070100060524     C                                              'SMAN 2'        + csv +
070200060524     C                                              'SMAN 2 NAME'   + csv +
070300060524     C                                              'REL 2'         + csv +
070400060524     C                                              'COMM AMT 2'    + csv +
070500060524     C                                              'SMAN 3'        + csv +
070600060524     C                                              'SMAN 3 NAME'   + csv +
070700060524     C                                              'REL 3'         + csv +
070800060524     C                                              'COMM AMT 3'    + csv +
070900060526     C*                                             'SMAN 4'        + csv +
071000060526     C*                                             'SMAN 4 NAME'   + csv +
071100060526     C*                                             'REL 4'         + csv +
071200060526     C*                                             'COMM AMT 4'    + csv +
071300060526     C                                                                '",'
071400060524
071500060524     c                   end
071600060524
071700060523     C                   Write     db435xr
071800050304     C*
0719000503040320 C                   ENDSR
072000050302      *******************************************
072100011126     c     *inzsr        begsr
072200050302      *******************************************
072300050304
072400050304     C                   Exsr      Writexlhead
072500050302
072600050228     c     plnkey        klist
072700050228     c                   kfld                    mctrst
072800050228     c                   kfld                    mcsub#
072900050228     c                   kfld                    mcplan
073000050228     c     acckey        klist
073100011126     c                   kfld                    actrst
073200011126     c                   kfld                    acsub#
073300011126     c                   kfld                    acacct
073400060523     c     comkey        klist
073500060523     c                   kfld                    actrst
073600060523     c                   kfld                    acsub#
073700060523     c                   kfld                    acacct
073800060526     c                   kfld                    h_plan
073900060524     c     cratky        klist
074000060525     c                   kfld                    h_trust
074100060525     c                   kfld                    h_sub
074200060525     c                   kfld                    h_plan
074300060524     c                   kfld                    stype
074400060602     c     mkcaky        klist
074500060602     c                   kfld                    actrst
074600060602     c                   kfld                    acsub#
074700060602     c                   kfld                    acacct
074800060602     c                   kfld                    h_pcarr
074900060602     c     brcmky        klist
075000060602     c                   kfld                    h_pcarr
075100060602     c                   kfld                    w9mksz
075200060602
075300060524
075400060524      * run date = 1st of current month
075500060524     c                   move      ud8ymd        runymd            8 0
075600060524     c                   move      01            runymd
075700011126     c                   endsr
