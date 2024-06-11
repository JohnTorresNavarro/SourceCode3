0001000101200002  ******************************************************************
0002000508040003  * rp081      GROUP BENEFIT SERVICES SOFTWARE                     *
0003000101200004  *                                                                *
0003010508040005  *            WRITTEN BY - DAVID KETTERMAN                        *
0003020508040006  *            DATE - 08/04/05                                     *
0003030508040007  *                                                                *
0007000508050013  *            COBRA Admin fee rate vs commission report           *
000701071120      * 11/20/07 dlk - add new com schedule                            *
000702090105      * 01/05/09 dlk - find brkrcom rec by date range                  *
000703130222      * 02/22/13 dlk - change cobra admin fee search to look for plan  *
0054001302220035  *                category PCA instead of carrier GBS.            *
0054011302220035  *                                                                *
0055000101200036  ******************************************************************
0056000101200037  *
0057000006230038 FCmct14    IP   e           k DISK
0058000006190039 FCRAT13    IF   e           k DISK
0059000508040040 Fmcov14    IF   e           k DISK
0060000006190043 FPLNMST    IF   e           k DISK
0064000006190014 FSMAN      IF   e           k DISK
0064020508050014 Faccmst    IF   e           k DISK
0064040508050014 Fgrate     IF   e           k DISK
0064050711200046 Fcarmst    IF   e           k DISK
0064060711200014 Fmktcara1  IF   e           k DISK
0064070711200014 Fbrkrcom1  IF   e           k DISK
0064080508050017 Frp081xl   o  a e             DISK
0064090508040037 D workdt          S               d   datfmt(*iso)
0064100508050037 D workdtnum       S              8  0
0064110508050037 D mcovcnt         S              6  0
0064120508050037 D h_bilrte        S                   like(bilrte)
0064130711200037 D h_comtyp        S             20
0064140508050037 D h_comrte        S                   like(comrte)
0064150508050037 D firstrate       S              1
0064160508050037 D multrates       S              1
0064170508050037 D smanname        S             35
0064180508050037 D acnamout        S                   like(acnam1)
0064190711200037 D h_comsch        S                   like(comsch)
0064200711200037 D h_prem          S                   like(bilrte)
006421071120     d w9mksz          s                   like(maszcd)
0064220711200133 D  wkpct          s              7  6
0089000508040171 D                 DS
0090000508040172 D  wkacc#                 1     10  0
0090010508040172 D  cmtrst                 1      3  0
0090020508050172 D  csubdv                 4      6  0
0090030508040172 D  cmacct                 7     10  0
0090040508040171 D                UDS
0090050508040172 D  RUNDAT                 1      8  0
009006050804
009007050805     c                   if        (cmcan <> 0 and cmcan <= runymd) or
009008050805     c                             (effdat > runymd)
009009050804     c                   goto      #end
009010050804     c                   end
009011050804
0105000508040266 C     KEYPLN        CHAIN     PLNMST
010600130222     c                   if        not %found(plnmst) or plncat <> 'PCA'
0107000508040305 C                   goto      #end
011401050804     c                   end
011402050805
011403071120     c                   clear                   h_comsch
0114040711200311 C     PCARR         CHAIN     CARMST
011405071120     c                   if        %found(carmst)
011406071120     c                   move      comsch        h_comsch
011407071120     c                   else
0114080711200305 C                   goto      #end
011409071120     c                   end
011410071120
013914050804      * count coverages
013915050805     c                   clear                   mcovcnt
0139160508050252 C                   clear                   h_bilrte
0139170508050252 C                   clear                   multrates
0139180508050252 C                   clear                   firstrate
013921050804
0169000508040213 C     mckey         setll     mcov14
017100050804     c                   dou       %eof(mcov14)
0173000508040216 C     mckey         reade     mcov14
017301050804
0173020508040133 c                   if        %eof(mcov14) or (enrldt = candt) or
017303050804     c**do not skip future enroll  (enrldt > runymd) or
017304050804     c                             (candt <> 0 and candt <= runymd)
017305050804     c                   iter
017306050804     c                   end
017307050804
017308050804     c                   add       1             mcovcnt
017309050804     c                   exsr      #grate
017310050804     c                   enddo
017311050804
0173120711200272  * calc commission based on old (1) or new (2) schedule
017313071120
017314071120     c                   if        h_comsch = '1'
017315071120     c                   exsr      #oldcom
017316071120     c                   else
017317071120     c                   exsr      #newcom
017318071120     c                   end
017319071120
017320050805      * write spredsheet if there are active members in the plan
017321050805
017322050805     c                   if        mcovcnt <> 0
017323050805     c                   exsr      writexldet
017324050805     c                   end
019901050804
019902050804     c     #end          tag
019903050804
019904050804      ******************************************
019905050804      * old commission schedule
019906050804      *
019907050804      ******************************************
019908050804     c     #oldcom       begsr
020000050804
0200010508050252 C                   clear                   h_comrte
0200020508050252 C                   clear                   h_comtyp
020003050804
020004050804      * GET SALESMAN MASTER FILE FOR STYPE IN CRATE SEARCH
0200050508040266 C     SLSMAN        CHAIN     SMAN
020006050804     c                   if        not %found(sman)
020007050804     C                   leavesr
020008050804     c                   end
020009050805
020010050805     c                   clear                   smanname
020011050805     c                   movel     smancd        smanname
020012050805     c                   cat       '-':1         smanname
020013050805     c                   cat       sfname:1      smanname
020014050805     c                   cat       slname:1      smanname
020017050804
0201000508040237  * get crate
0205000006190245 C     CRATKY        SETLL     CRAT13
0206000508040247 C                   dou       %eof(crat13)
0207000508040248 C     CRATKY        READE     CRAT13
020800050804
020900050804     C                   if        (not %eof(crat13)) and
020901050804     C                             (crdltd <> 'D') and
021000050804     C                             (effdat >= frdate and effdat <= todate)
0210010508040275  *  IS THE COMMISSION EXPIRED?
0210020508040285 C                   if        comprd <> 0
0210030508040273 C                   move      effdat        workdt
021004050804     c                   adddur    comprd:*m     workdt
0210050508050273 C                   move      workdt        workdtnum
0210060508050293 C                   if        workdtnum <= runymd
021007050804     c                   iter
0210080508040299 C                   end
0210090508040299 C                   end
021010050804
0211000508040252 C                   move      comrte        h_comrte
0211010508040252 C                   move      comtyp        h_comtyp
0212000006230252 C                   leave
0213009102150253 C                   END
021301050804
021400000619     c                   enddo
021500000619
0447000508040416 C                   endsr
044701050804
044702071120      ******************************************
044703071120      * new commission schedule
044704071120      ******************************************
044705071120     c     #newcom       begsr
044706071120
0447070711200252 C                   clear                   h_comrte
0447100711200252 C                   clear                   h_comtyp
044711071120
044712071120      * GET SALESMAN NAME
0447130711200266 C     SLSMAN        CHAIN     SMAN
044714071120     c                   if        not %found(sman)
044715071120     C                   leavesr
044716071120     c                   end
044717071120     c                   clear                   smanname
044718071120     c                   movel     smancd        smanname
044719071120     c                   cat       '-':1         smanname
044720071120     c                   cat       sfname:1      smanname
044721071120     c                   cat       slname:1      smanname
044722071120
044727071120
0447280711200104  * Only execute body if Pay Commission flag is not 'N'
044729071120      * 5/29/03 new definition of ccpnc : N = no com, no prem, no mem cnt
044730071120      *                                   P = no com, yes prem, yes mem cnt
044731071120
044732071120     c                   if        ccpnc = 'N' or ccpnc = 'P'
0447330711200252 C                   clear                   h_comtyp
0447340711200252 C                   eval      h_comtyp = 'PAY NO COMM'
044735071120     c                   leavesr
044736071120     c                   end
0447370711200104  *
0447380711200456  * Get Acct Mkt size - default to 50 if not found
044739071120
044740071120     c                   clear                   w9mksz
044741071120     c     mkcaky        setll     mktcara1
044742071120     C                   dou       %eof(mktcara1)
044743071120     c     mkcaky        reade     mktcara1
0447440711200133 C                   if        (not %eof(mktcara1)) and
044745071120     c                             (mafrdt <> matodt) and
044746071120     c                             ((mafrdt <= runymd and matodt >= runymd) or
044747071120     c                             (mafrdt <= runymd and matodt = 0 ))
044748071120     c                   movel     maszcd        w9mksz
044749071120     c                   leave
044750071120     c                   endif
044751071120     c                   enddo
0447520711200456  *
044753071120     c                   if        w9mksz = *blanks
044754071120     c                   movel     '50'          w9mksz
044755071120     c                   endif
044756071120
044757090105
044758090105      * get global broker commision rec
044759071120     c                   clear                   rbrkrcom
044760090105     c                   clear                   foundbrkrc        1
044763071120
044764090105     c     brcmky        setll     brkrcom1
044765090105     c                   dou       %eof(brkrcom1)
044766090105     c     brcmky        reade     brkrcom1
044767090105     C                   if        (not %eof(brkrcom1)) and
044768090105     C                             (bcfromdt <> bctodate) and
044769090105     c                             ((bcfromdt <= runymd and bctodate >= runymd)
044770090105     c                               or (bcfromdt <= runymd and bctodate = 0))
044771090105     c                   eval      foundbrkrc = 'Y'
044772090105     c                   leave
044773090105     c                   end
044774090105     c                   enddo
044775090105
044776090105     c                   if        foundbrkrc = 'Y'
044777071120      * global fee per member - default method
044778071120     c                   z-add     bcamnt        h_comrte
0447790711200252 C                   clear                   h_comtyp
0447800711200252 C                   eval      h_comtyp = 'GLOBAL FLAT FEE'
044781071120
044782071120      * global % of prem
044783071120     c                   if        bcpop <> 0
044784071120     c                   clear                   wkpct
044785071120     c     bcpop         div       100           wkpct
044786071120     c     wkpct         mult      h_prem        h_comrte
0447870711200252 C                   clear                   h_comtyp
0447880711200252 C                   eval      h_comtyp = 'GLOBAL % OF PREM'
044789071120     c                   end
044790071120
044791071120     c                   endif
044792071120
044793071120      ********
0447940711200456  * process overrides to global commission
044795071120      ********
0447960711200456
0447970711200456  * flat fee per member override
044798071120     c                   if        ccovra <> *zero
044799071120     c                   z-add     ccovra        h_comrte
0448000711200252 C                   clear                   h_comtyp
0448010711200252 C                   eval      h_comtyp = 'OVERRIDE FLAT FEE'
044802071120
044803071120     c                   else
044804071120
0448050711200456  * % of commission override
044806071120     c                   if        ccovpc <> *zero
044807071120     c     ccovpc        div       100           wkpct
044808071120     c                   mult      wkpct         h_comrte
0448090711200252 C                   clear                   h_comtyp
0448100711200252 C                   eval      h_comtyp = 'OVERRIDE % OF COMM'
044811071120
044812071120     c                   else
044813071120
0448140711200456  * % of premium override
044815071120
044816071120     c                   if        ccovpp <> *zero
044817071120     c     ccovpp        div       100           wkpct
044818071120     c     wkpct         mult      h_prem        h_comrte
0448190711200252 C                   clear                   h_comtyp
0448200711200252 C                   eval      h_comtyp = 'OVERRIDE % OF PREM'
044821071120     c                   end
044822071120
044823071120     c                   endif
044824071120     c                   endif
044825071120
0448260711200416 C                   endsr
044827071120
044828050804      ******************************************
044829050804      * get grate
044830050804      ******************************************
044831050804     c     #grate        begsr
044832050804
0448330508040245 C     gratkey       SETLL     grate
0448340508040247 C                   dou       %eof(grate)
0448350508040248 C     gratkey       READE     grate
044836050804     c                   if        not %eof(grate) and (runymd >= frmdat) and
044837050804     C                             (runymd <= todat)
044838050804
044839050804      * if there are different rates, set flag
044840050804
044841050804     c                   if        firstrate <> ' ' and
044842050804     c                             h_bilrte <> bilrte
044843050805     c                   eval      multrates = 'Y'
044844050804     c                   else
0448450508040252 C                   move      bilrte        h_bilrte
0448460711200252 C                   move      bilrte        h_prem
044847050804     c                   end
044848050804
044849050804     c                   eval      firstrate = 'N'
0448500508040252 C                   leave
0448510508040253 C                   END
044852050804     c                   enddo
044853050804
0448540508040416 C                   endsr
0448550101200456  *
0448560508040107 C*
044857050804     C*************************************************************
044858050804     C*                                                           *
044859050804     C* Write Spreadsheet heading                                 *
044860050804     C*                                                           *
044861050804     C*************************************************************
044862050804     C     Writexlhead   BEGSR
044863050804
044864050805     c                   clear                   rp081fld
044865050805     C                   Eval      rp081fld  =   '"' + 'Account #'     + '","' +
044866050804     C                                                 'Acc Name'      + '","' +
044867050804     C                                                 'Plan'          + '","' +
044868050804     C                                                 'Plan Desc'     + '","' +
044869050805     C                                                 '> 1 Rate'      + '","' +
044870050804     C                                                 'Bill Rate'     + '","' +
044871050805     C                                                 'Comm Rate'     + '","' +
044872050805     C                                                 'Comm Type'     + '","' +
044873050805     C                                                 'Broker '       + '","' +
044874050804     C                                                 'Mem Count'     + '",'
044875050805     C                   Write     rp081xr
044876050804     C*
0448770508040320 C                   ENDSR
0448780508040164 C*************************************************************
0448790508040164 C*                                                           *
0448800508040164 C* Write Spreadsheet Detail                                  *
0448810508040164 C*                                                           *
0448820508040164 C*************************************************************
044883050804     C     Writexldet    BEGSR
044884050804
044885050805     c                   clear                   acnamout
044886050805     c     acckey        chain     accmst
044887050805     c                   if        %found(accmst)
044888050805     c                   eval      acnamout = acnam1
044889050805     c                   end
044890050805
044891050805     c                   clear                   rp081fld
044892050805     C                   Eval      rp081fld  =   '"' +
044893050804     C                             %trim(%editw(wkacc#:'0   -   -    '))
044894050804     C                             + '","' +
044895050805     C                             %trim(acnamout)                     + '","' +
044896050805     C                             cmplan                              + '","' +
044897050805     C                             %trim(pdescr)                       + '","' +
044898050805     C                             multrates                           + '","' +
044899050805     C                             %Trim(%Editc(h_bilrte:'L'))         + '","' +
044900050805     C                             %Trim(%Editc(h_comrte:'L'))         + '","' +
044901050805     C                             h_comtyp                            + '","' +
044902050805     C                             %trim(smanname)                     + '","' +
044903050805     C                             %Trim(%Editc(mcovcnt:'L'))          + '",'
044904050804     C*
044905050805     C                   Write     rp081xr
0449060508040320 C                   ENDSR
044907050804     C*
044908050804
0669000006190455 C     *inzsr        begsr
067000000619
0671000006190183 C                   TIME                    HTIME             6 0
067200000619     C                   MOVEL     RUNDAT        RUNMD             4 0
067300000619     C                   MOVE      RUNDAT        RUNCY             4 0
067400000619     C                   MOVEL     RUNCY         runymd            8 0
067500000619     C                   MOVE      RUNMD         runymd
068100000619
068600000619     c     cratky        klist
068700000619     c                   kfld                    cmtrst
068800000619     c                   kfld                    csubdv
068900000619     c                   kfld                    cmplan
069000000619     c                   kfld                    stype
069100000619
069200050804     c     mckey         klist
069300000619     c                   kfld                    cmtrst
069400000619     c                   kfld                    csubdv
069500000619     c                   kfld                    cmacct
069600000619     c                   kfld                    cmplan
069700000619
069701050805     c     acckey        klist
069702050805     c                   kfld                    cmtrst
069703050805     c                   kfld                    csubdv
069704050805     c                   kfld                    cmacct
069705050805
069800000619     c     keypln        klist
069900000619     c                   kfld                    cmtrst
070000000619     c                   kfld                    csubdv
070100000619     c                   kfld                    cmplan
070200010120
070300050804     c     gratkey       klist
070400050804     c                   kfld                    mctrst
070500050804     c                   kfld                    mcsub#
070600050804     c                   kfld                    mcplan
070700050804     c                   kfld                    mcageb
070701050804     c                   kfld                    mcovtp
071200000619
071201071120     c     mkcaky        klist
071202071120     c                   kfld                    actrst
071203071120     c                   kfld                    acsub#
071204071120     c                   kfld                    acacct
071205071120     c                   kfld                    pcarr
071206071120
071207071120     c     brcmky        klist
071208071120     c                   kfld                    pcarr
071209071120     c                   kfld                    w9mksz
071210071120
071211050804     C                   Exsr      Writexlhead
0713000006190455 C                   ENDSR
