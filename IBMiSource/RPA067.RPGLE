0001009102150002 F******************************************************************
0002000004140003 F* RPA067     GROUP BENEFIT SERVICES SOFTWARE           1988      *
0003009102150004 F*                                                                *
0004009102150005 F*            WRITTEN BY - MICHAEL C. DUNPHY                      *
0005009102150006 F*            DATE - 01/02/91                                     *
0006009102150008 F*                                                                *
0007009511020009 F*  DESCRIPTION - THIS PROGRAM WILL AUDIT FOR COMMISSION          *
0008009511020010 F*            CONTROL RECORDS AND RATES.                          *
0009000006200035 F*                                                                *
001000000620     F* 06/20/00 DLK - CONVERT TO RPGLE, external definitions and      *
0011000006200035 F*                use invdet file instead of mcov for audit.      *
0012000006200035 F*                "IDEDT" will be used for selection and          *
0013000006200035 F*                "IDCVDT" will be used for the effdt of          *
0014000006210035 F*                commission. Exclude all records in              *
0015000006210035 F*                t/s/a/p/effdt when they total 0.                *
0016000006210035 F*                                                                *
0017000006220079 F* 06/22/00 dlk - comctx is now considered valid up to and        *
0018000006220035 F*                including the cancel date                       *
0019000009220079 F* 09/22/00 dlk - add ability for this audit to run for regular   *
0020000009220035 F*                "pre commission" time, or "pre ABR" time which  *
0021000009220035 F*                is needed to ensure accurate data in the ABR    *
002200001012     F* DLK 10/12/00 - change group # to 15 in invdet                  *
002300010314     F* KSJ 03/14/01 - added wrkfile (COMCTXWK12) to be used           *
002400010314     F*                       for RPA067B                              *
002500010330     F* KSJ 03/30/01 - chngd wrkfile (COMCTXWK12) to (COMCTXWK33)      *
002600010424     F* DLK 04/24/01 - over 50 must have 1 of 3 fields filled in.      *
002700020214     F* DLK 02/14/02 - add edit: under 50 must NOT have % prem or      *
0028000202140035 F*                flat fee overrides filled in.                   *
002900030414     F* DLK 04/14/03 - add edit: sman relation from comctx must be     *
0030000304140035 F*                active.                                         *
003100030501     F* DLK 05/01/03 - change edit to allow under 50 override if the   *
0032000305010035 F*                override flag is set to "Y" in the MKTCARA file *
003300060310     F* DLK 03/10/06 - remove edit for under 50 override. Override     *
0034000603100035 F*                will be allowed for all market sizes. Also add  *
0035000603100035 F*                new edit for > 1 override.                      *
003600060615     F* DLK 06/15/06 - remove edit for over 50 override. All carriers  *
0037000606150035 F*                on the new schedule must have a global rate     *
003800070717     F* DLK 07/16/07 - add edit for split comm - total pct of comm     *
0039000707170035 F*                must = 100%                                     *
0040000708280015  * 08/28/07 dlk - change to find market size by transaction       *
0041000708280015  *                effdt instead of run effdt.                     *
0042000804040015  * 04/04/08 dlk - add option to run for only one abr code when    *
0043000804040015  *                the pre commission version is run.              *
0044000901020015  * 01/02/09 dlk - broker com is now stored by date range, find    *
0045000901020035  *                by effdt of trans.                              *
0046000901040015  *              - add edit for admin fee and bonus draw           *
0047001102100015  * 02/09/11 dlk - add edit on premium split field - total on all  *
0048001102100015  *                active records must = 100%                      *
0049001103240015  * 03/24/11 dlk - add carrier code to sort / break because of     *
0050001103240035  *                an incident where there were 2 different carriers
0051001103240035  *                in a plan in INVDET.
0052001105160015  * 05/16/11 dlk - add edit for more than one comctx with "P" ccpnc
0053001105160015  *                per plan/effdt
0054001210160015  * 10/16/12 dlk - add edit - when a commission is active with the
0055001210160015  *                CCPNC = "P", there cannot be any other comctx
0056001210160015  *                active at the same time. Also, stop running
0057001210160015  *                RPA067B since it was reporting as errors things
0058001210240015  *                we now allow. Also edit to ensure when a full global
0059001210190015  *                comm is used there are no other commissions execpt
0060001210190015  *                ccpnc = N. Also do not consider ccpnc = N a
0061001210190015  *                payable commission record, this also added an
0062001210190015  *                error for no other rec besides ccpnc = n.
0063001401240015  * 01/24/14 dlk - fix market size search so it matches rpa068
0063011409050015  * 09/05/14 dlk - change to use idtrmd (rec effdt) for all rate
0063021409050015  *                checks and sort. IDCVDT is still used for
0063031409050015  *                selection in the CL / QRY so it selects records
0063041409050015  *                based on the invoice they were on.
0063051908270015  * 08/26/19 dlk - **************************************************
0063061908270015  *                * NOTE RPA067CL IS NOW CALLED DIRECTLY IN DW040CL
0063071908270015  *                * AND DW260CL SO BE CAREFULL OF ANY LDA CHANGES
0063081908270015  *                * HERE OR THERE THAT COULD EFFECT OTHER PROGRAMS
0063091908270015  *                * THAT RUN AFTER IT IN DW040CL / DW260CL.
0063101908270015  *                **************************************************
0063111908270015  *
0065009102150011 F******************************************************************
0066000006230012 FINVDET    IP   E             DISK
0067000006200015 FACCMST    IF   e           k DISK
0068000006200015 FCMCT14    IF   e           k DISK
0069000006200039 FCRAT13    IF   e           k DISK
0070000006200016 FTRSMST    IF   e           k DISK
0071000006200014 FSMAN      IF   e           k DISK
0072000101260016 Fcarmst    IF   e           k DISK
0073000101260014 Fmktcara1  IF   e           k DISK
0074000101260014 Fbrkrcom1  IF   e           k DISK
007500090104     FADMNFEE1  IF   E           K DISK
007600090104     FBONUSDR1  IF   E           K DISK
0077000304140014 Fsmanrlt   IF   e           k DISK
0078001210180017 FQSYSPRT   O    F  132        PRINTER OFLIND(*INOF)
0079001210160017 **Fcomctxwk33uf a e           k disk    prefix(w)
0080000009220044 Drunfor           s             14
0080011908270015  * ***************************************************
0080021908270015  * * NOTE RPA067CL IS NOW CALLED DIRECTLY IN DW040CL *
0080031908270015  * * AND DW260CL SO BE CAREFULL OF ANY LDA CHANGES   *
0080041908270015  * * HERE OR THERE THAT COULD EFFECT OTHER PROGRAMS  *
0080051908270015  * * THAT RUN AFTER IT IN DW040CL / DW260CL.         *
0080061908270015  * **************************************************
0081000009220044 D                UDS
0082009809250045 D  RUNDAT                 1      8  0
0083000101260045 D  RUNmd                  1      4  0
0084000101260045 D  RUNy                   5      8  0
0085000009220045 D  aorc                  10     10
0086000804040045 D  labrcode              12     12
0087009102150050 D  CONAME               201    240
0088000006200032 IINVDR
0089000006210033 I                                          IDTRST        l3
0090000006210033 I                                          IDSUBD        l2
0091000006210033 I                                          IDACCT        l2
0092000006210033 I                                          IDplan        l1
0093001103240033 I                                          IDcar         l1
0094001409050033 I                                          IDtrmd        L1
009500000621     C*
009600000621     C* SELECT ONLY GBS ACCTS
009700000621     C*
009800000621     c                   if        *inl3
0099000006210063 C                   SETOFF                                       55
0100000006210063 C                   MOVE      'O Z'         TSCODE
0101000006210063 C     IDTRST        CHAIN     TRSMST                             55
010200000623     c                   if        *in55
010300140905     C                   MOVE      idtrmd        @DATIN
010400000623     C                   EXSR      #DATYM
010500000623     C                   MOVE      @DATOU        idcmdy            8 0
0106000006230064 C                   EXCEPT    ERR3
0107000006230065 C                   GOTO      #END
010800000621     c                   end
010900000623     c                   end
0110000006200059 C*
011100970708     C* GET AA CODE
011200970708     C*
011300000621     c                   if        *inl2
0114000006200063 C     acckey        CHAIN     ACCMST                             65
011500000623     c                   if        *in65
011600140905     C                   MOVE      idtrmd        @DATIN
011700000623     C                   EXSR      #DATYM
011800000623     C                   MOVE      @DATOU        idcmdy
0119000006230064 C                   EXCEPT    ERR5
012000000620     c                   end
012100000623     c                   end
012200000620
0123009707080065 C   65              GOTO      #END
012400000620
0125000006210066 C     TSCODE        IFEQ      'O Z'
0126000006210067 C                   GOTO      #END
0127000006210068 C                   END
012800000621
012900000620     c*
013000000621     c* check for comctx at end of t/s/a/p/effdt of transaction
013100000620     c*
013200000621     c                   if        *inl1
013300000621     c                   move      *zeros        l1tot            10 2
013400070716     c                   move      *zeros        l1totpc          10 4
013500110209     c                   move      *zeros        l1totcmsp        10 4
013600110517     c                   clear                   l1totpnc          5 0
013700000621     c                   end
013800000621
013900000621     c*
014000000621     c* add up transaction amounts for this t/s/a/p/effdt
014100000621     c*
014200000621     c                   add       idtram        l1tot
014300000621
0144000006210089 C     #END          TAG
014500000620
014600000621     c*
014700000922     c* if pre ABR run always check for commission because it is needed
014800000922     c* for cr130.
014900000922     c* if pre commission run check for commission only if transactions
015000000922     c* total do not equal 0
015100000621     c*
015200000922     cl1                 if        aorc = 'A'
015300000922     cl1                 exsr      #comck
015400000922     cl1                 else
015500000922
015600000922     cl1                 if        l1tot <> 0
015700000621     cl1                 exsr      #comck
015800000621     cl1                 end
015900000922     cl1                 end
016000000620
0161009511020075 C*
0162009212140075 C* PRINT TOTAL ERRORS, SET ON U1 TO CANCEL RPA060
0163009212140075 C*
016400010126     CLR                 if        comerr <> 0 or craterr <> 0
016500060615     C                             or globerr <> 0 or
016600070717     C                             relerr <> 0 or orerr <> 0 or
016700090104     C                             comovrerr <> 0 or aferr <> 0 or
016800121016     C                             bderr <> 0 or presplerr <> 0 or
016900121018     C                             pncerr <> 0 or pncspliterr <> 0 or
017000121018     C                             ovrnotnerr <> 0
017100921214     CLR                 SETON                                        U1
017200921209     CLR                 END
017300950913     CLR                 EXCEPT    FINERR
017400000621     c/eject
0175000006230069 C**************************************************************
0176000006230069 C* SEARCH FOR ACTIVE COMMISSION CONTROL RECORD then crate     *
0177000006230069 C**************************************************************
0178000006210069 C*
017900000621     c     #comck        begsr
018000000621
018100000623     c* read comctx
018200000623
018300000623     c                   eval      *in60 = *off
0184001210180086 C                   clear                   comcnt            3 0
0185001210180086 C                   clear                   globalcnt         3 0
0186001210180086 C                   clear                   ovrnotncnt        3 0
018700121018
018800000621     C     CCKEY         SETLL     CMCT14
0189000006230078 C                   dow       *in60 = *off
0190000006210080 C     CCKEY         READE     CMCT14                                 60
019100000623
019200070716     c* at end of all comctx: if no valid comctx - print error
019300000623     c                   if        *in60
019400121016     c                   exsr      #endofcomck
0195000006230835 C                   leave
019600000623     c                   end
0197000006220079 C*
019800140905     c                   if        idtrmd < effdat or (cmcan <> 0 and
019900140905     c                             idtrmd > cmcan) or (effdat = cmcan) or
020000030603     c                             (cmdltd = 'D')
020100000623     c                   iter
020200000621     c                   end
020300000622
0204000006230075 C*
0205001210190075 C* a valid payable comctx has been found. count number of rec
020600121019     c                   if        ccpnc <> 'N'
0207001210160086 C                   ADD       1             comcnt
020800121019     c                   end
020900121016
0210001210160075 C* this rec uses the full global rates
021100121016     c                   if        ccovpc = 0 and ccovpp = 0 and
021200121016     c                             ccovra = 0 and ccpnc = ' '
021300121018     c                   add       1             globalcnt
021400121016     c                   end
021500121018
0216001210180075 C* this rec uses an override (except ccpnc = n)
021700121018     c                   if        ccovpc <> 0 or ccovpp <> 0 or
021800121018     c                             ccovra <> 0 or (ccpnc <> 'N'
021900121018     c                             and ccpnc <> ' ')
022000121018     c                   add       1             ovrnotncnt
022100121018     c                   end
022200121016
022300121019      * % of com check, this will also catch multiple global setups.
0224001210190075  * if all override fields are blank then consider the
0225001210190075  * pct of comm as 100% since it will pay the full commission
022600070717     c                   if        ccovpc <> 0
0227000707160086 C                   ADD       ccovpc        l1totpc
022800070717     c                   else
022900070717     c                   if        ccovpp = 0 and ccovra = 0 and ccpnc = ' '
0230000707170086 C                   ADD       100           l1totpc
0231000707170086 C                   end
0232000707170086 C                   end
0233000304140075
023400110209      * premium split - add up all prem splits filled in for this plan
023500110209      * and consider records w/o a split as 100% (except pay no comm)
023600110209     c                   if        cccmsp <> 0
0237001102090086 C                   ADD       cccmsp        l1totcmsp
023800110209     c                   else
023900110517     c                   if        ccpnc = ' '
0240001102090086 C                   ADD       100           l1totcmsp
0241001102090086 C                   end
0242001102090086 C                   end
0243001102090075
0244001105170075 C* track number of pay no commission "P" overrides since only one
0245001105170075 C* is allowed per plan.
024600110517     c                   if        ccpnc = 'P'
0247001105170086 C                   ADD       1             l1totpnc
0248001105170086 C                   end
024900110517
0250000304140075 C* 4/14/03 - verify realtion is active for the effdt of the transaction
0251000304140075
0252000304140063 C     cmrelid       CHAIN     smanrlt
025300030414     c                   if        %found(smanrlt)
025400030414
025500140905     C                   if        sreffdte > idtrmd or (srtrmdte <> 0
025600140905     C                             and srtrmdte <= idtrmd)
025700140905     C                   MOVE      idtrmd        @DATIN
025800030414     C                   EXSR      #DATYM
025900030414     C                   MOVE      @DATOU        idcmdy
0260000304140102 C                   ADD       1             relerr            6 0
0261000304140523 C   OF              EXCEPT    HEAD
0262000304140064 C                   EXCEPT    ERR10
026300030414     c                   end
026400030414
026500030414      * missing relation
026600030414     c                   else
026700030414
026800140905     C                   MOVE      idtrmd        @DATIN
026900030414     C                   EXSR      #DATYM
027000030414     C                   MOVE      @DATOU        idcmdy
0271000304140102 C                   ADD       1             relerr
0272000304140523 C   OF              EXCEPT    HEAD
027300030414     c                   except    err11
027400030414     c                   end
027500030414
0276000006220075 C*
0277000006220075 C* GET SMAN RECORD FOR SLS TYPE CODE
0278000006220075 C*
0279000006220063 C     slsman        CHAIN     SMAN                               65
028000000623     c                   if        *in65
028100140905     C                   MOVE      idtrmd        @DATIN
028200000623     C                   EXSR      #DATYM
028300000623     C                   MOVE      @DATOU        idcmdy
0284000304140523 C   OF              EXCEPT    HEAD
0285000006230064 C                   EXCEPT    ERR4
0286000006230064 C                   iter
028700000623     c                   end
0288000101260075 C*
0289000101260075 C* GET carrier RECORD FOR comm schedule
0290000101260075 C*
0291000101260063 C     idcar         CHAIN     carmst                             66
029200010126     c                   if        *in66
029300140905     C                   MOVE      idtrmd        @DATIN
029400010126     C                   EXSR      #DATYM
029500010126     C                   MOVE      @DATOU        idcmdy
0296000304140523 C   OF              EXCEPT    HEAD
0297000101260064 C                   EXCEPT    ERR6
0298000101260064 C                   iter
029900010126     c                   end
030000010126
030100010126     c                   if        comsch = '2'
030200010126     c                   exsr      #sch2
0303000101260064 C                   iter
030400010126     c                   end
030500010126
030600000623     c*******
0307000006220075 C*
0308000101260075 C* SEARCH FOR VALID RATE if old commission schedule
0309000006220075 C*
0310000006230246 C                   SETOFF                                       51
0311000006220245 C     CRATKY        SETLL     CRAT13
0312000006230247 C                   dow       *in51 = *off
0313000006220248 C     CRATKY        READE     CRAT13                                 51
031400000623     C*
031500000623     C* if no crate - error
031600000623     C*
0317000006230256 C                   if        *in51
031800000623 523 C   OF              EXCEPT    HEAD
031900000623     C                   MOVE      effdat        @DATIN
032000000623     C                   EXSR      #DATYM
032100000623     C                   MOVE      @DATOU        effmdy            8 0
0322000304140523 C   OF              EXCEPT    HEAD
0323000006230267 C                   EXCEPT    ERR2
0324000006230102 C                   ADD       1             craterr           6 0
032500000623     c                   leave
032600000623     c                   end
032700000623
032800000622     c                   if        crdltd = 'D' or
032900000622     c                             effdat < frdate or (todate <> 0 and
033000010129     c                             effdat > todate) or (frdate = todate)
033100000623     c                   iter
033200000623     c                   else
0333000006230075 C*
0334000006230075 C* a valid crate has been found
0335000006230075 C*
033600000623     c                   leave
033700000622     c                   end
033800000623
033900000623     c                   enddo
034000000623     c********
034100000623
034200000623     c                   enddo
034300000621
034400000621     c                   move      *zeros        l1tot
034500000621
034600000621     c                   endsr
034700000621
0348000101260069 C**************************************************************
0349001210160069 C* end of comctx check                                        *
0350000101260069 C**************************************************************
0351000101260069 C*
035200121016     c     #endofcomck   begsr
035300121016
035400121019      * no active payable commission records
035500121016     c                   if        comcnt = 0
035600140905     C                   MOVE      idtrmd        @DATIN
035700121016     C                   EXSR      #DATYM
035800121016     C                   MOVE      @DATOU        idcmdy
0359001210160523 C   OF              EXCEPT    HEAD
036000121016     C                   EXCEPT    ERROR1
0361001210160102 C                   ADD       1             comerr            6 0
036200121016     c                   end
036300121016
036400121016      * override % of comm for splits does not = 100%
036500121016     c                   if        l1totpc <> 100 and l1totpc <> 0 and
036600121016     c                             comsch = '2'
036700140905     C                   MOVE      idtrmd        @DATIN
036800121016     C                   EXSR      #DATYM
036900121016     C                   MOVE      @DATOU        idcmdy
0370001210160523 C   OF              EXCEPT    HEAD
037100121016     C                   EXCEPT    ERROR13
0372001210160102 C                   ADD       1             comovrerr         6 0
037300121016     c                   end
037400121016
037500121016      * premium split does not = 100%
037600121016     c                   if        l1totcmsp <> 100 and l1totcmsp <> 0 and
037700121016     c                             comsch = '2'
037800140905     C                   MOVE      idtrmd        @DATIN
037900121016     C                   EXSR      #DATYM
038000121016     C                   MOVE      @DATOU        idcmdy
0381001210160523 C   OF              EXCEPT    HEAD
038200121016     C                   EXCEPT    ERROR16
0383001210160102 C                   ADD       1             presplerr         6 0
038400121016     c                   end
038500121016
038600121016      * number of ccpnc = "P" > 1
038700121016     c                   if        l1totpnc > 1
038800140905     C                   MOVE      idtrmd        @DATIN
038900121016     C                   EXSR      #DATYM
039000121016     C                   MOVE      @DATOU        idcmdy
0391001210160523 C   OF              EXCEPT    HEAD
039200121016     C                   EXCEPT    ERROR17
0393001210160102 C                   ADD       1             pncerr            6 0
039400121016     c                   end
039500121016
039600121016      * 10/16/12
039700121016      * if there is a ccpnc = "P" then there cannot be any other records
039800121016      * active at the same time
039900121016     c                   if        l1totpnc <> 0 and comcnt > 1
040000140905     C                   MOVE      idtrmd        @DATIN
040100121016     C                   EXSR      #DATYM
040200121016     C                   MOVE      @DATOU        idcmdy
0403001210160523 C   OF              EXCEPT    HEAD
040400121016     C                   EXCEPT    ERROR18
0405001210160102 C                   ADD       1             pncspliterr       6 0
040600121016     c                   end
040700121016
040800121018      * 10/16/12
040900121018      * if any global rate is used, there cannot be other records
041000121018      * at the same time except ccpnc = N
041100121018     c                   if        globalcnt <> 0 and ovrnotncnt <> 0
041200140905     C                   MOVE      idtrmd        @DATIN
041300121018     C                   EXSR      #DATYM
041400121018     C                   MOVE      @DATOU        idcmdy
0415001210180523 C   OF              EXCEPT    HEAD
041600121018     C                   EXCEPT    ERROR19
0417001210180102 C                   ADD       1             ovrnotnerr        6 0
041800121018     c                   end
041900121018
042000121016     c                   endsr
042100121016
0422001210160069 C**************************************************************
0423001210160069 C* verify setup for new commission schedule                   *
0424001210160069 C**************************************************************
0425001210160069 C*
042600121016     c     #sch2         begsr
042700121016
042800010126     c* get market size - defalut to 50
042900010126
043000010126     c                   movel     '50   '       mksz              5
043100010126     c                   eval      *in67 = *off
043200010126     c     mkcaky        setll     mktcara1
043300010126     C                   dow       *in67 = *off
043400010126     c     mkcaky        reade     mktcara1                               67
0435000101260133 C   67              leave
043600140905     c                   if        idtrmd < mafrdt or (matodt <> 0 and
043700140905     c                             idtrmd > matodt) or (mafrdt = matodt)
043800010126     c                   iter
043900010126     c                   endif
044000140124      * mksz found, use it
044100010126     c                   movel     maszcd        mksz
044200140124     c                   leave
044300010126     c                   enddo
044400010126
044500060816     c* 06/15/06 - global comm required for all market sizes
044600090102     c* 01/02/09 - use effdt of trans to find broker com
044700060615     c**                 clear                   mksznum           5 0
044800060615     c**                 eval      mksznum = %Dec(mksz : 5 : 0)
044900020214
045000090102     c                   clear                   foundbrkrc        1
045100090102     c     brcmky        setll     brkrcom1
045200090102     c                   dou       %eof(brkrcom1)
045300090102     c     brcmky        reade     brkrcom1
045400090102     C                   if        (not %eof(brkrcom1)) and
045500090102     C                             (bcfromdt <> bctodate) and
045600140905     c                             ((bcfromdt <= idtrmd and bctodate >= idtrmd)
045700140905     c                               or (bcfromdt <= idtrmd and bctodate = 0))
045800090102     c                   eval      foundbrkrc = 'Y'
045900090102     c                   leave
046000090102     c                   end
046100090102     c                   enddo
046200090102
046300090102     c                   if        foundbrkrc <> 'Y'
046400060615 523 C   OF              EXCEPT    HEAD
046500140905     C                   MOVE      idtrmd        @DATIN
046600060615     C                   EXSR      #DATYM
046700060615     C                   MOVE      @DATOU        effmdy            8 0
0468000606150267 C                   EXCEPT    ERR7
0469000606150102 C                   ADD       1             globerr           6 0
047000060615     c                   end
047100060310
047200090104     c* 01/04/09 - use effdt of trans to find admin fee
047300090104     c                   clear                   foundadmf         1
047400090104     c     brcmky        setll     admnfee1
047500090104     c                   dou       %eof(admnfee1)
047600090104     c     brcmky        reade     admnfee1
047700090104     C                   if        (not %eof(admnfee1)) and
047800090104     C                             (affromdt <> aftodate) and
047900140905     c                             ((affromdt <= idtrmd and aftodate >= idtrmd)
048000140905     c                               or (affromdt <= idtrmd and aftodate = 0))
048100090104     c                   eval      foundadmf = 'Y'
048200090104     c                   leave
048300090104     c                   end
048400090104     c                   enddo
048500090104
048600090104     c                   if        foundadmf <> 'Y'
048700090104 523 C   OF              EXCEPT    HEAD
048800140905     C                   MOVE      idtrmd        @DATIN
048900090104     C                   EXSR      #DATYM
049000090104     C                   MOVE      @DATOU        effmdy
0491000901040267 C                   EXCEPT    ERR14
0492000901040102 C                   ADD       1             aferr             6 0
049300090104     c                   end
049400090104
049500090104
049600090104     c* 01/04/09 - use effdt of trans to find bonus draw
049700090104     c                   clear                   foundbd           1
049800090104     c     brcmky        setll     bonusdr1
049900090104     C                   dou       %eof(bonusdr1)
050000090104     c     brcmky        reade     bonusdr1
050100090104     C                   if        (not %eof(bonusdr1)) and
050200140905     c                             ((bdfrdt <= idtrmd and bdtodt >= idtrmd) or
050300140905     c                             (bdfrdt <= idtrmd and bdtodt = 0))
050400090104     c                   eval      foundbd = 'Y'
050500090104     c                   leave
050600090104     c                   endif
050700090104     c                   enddo
050800090104
050900090104     c                   if        foundbd <> 'Y'
051000090104 523 C   OF              EXCEPT    HEAD
051100140905     C                   MOVE      idtrmd        @DATIN
051200090104     C                   EXSR      #DATYM
051300090104     C                   MOVE      @DATOU        effmdy
0514000901040267 C                   EXCEPT    ERR15
0515000901040102 C                   ADD       1             bderr             6 0
051600090104     c                   end
051700090104
051800090104
051900060310      * 3/10/06 - new edit - maximun number overrides allowed is one
052000060310     c                   clear                   ovrcount          2 0
052100060310     c                   if        ccovpp <> 0
052200060310     c                   add       1             ovrcount
052300060310     c                   end
052400060310     c                   if        ccovpc <> 0
052500060310     c                   add       1             ovrcount
052600060310     c                   end
052700060310     c                   if        ccovra <> 0
052800060310     c                   add       1             ovrcount
052900060310     c                   end
053000060310     c                   if        ccpnc  <> ' '
053100060310     c                   add       1             ovrcount
053200060310     c                   end
053300060310
053400060310     c                   if        ovrcount > 1
053500060310 523 C   OF              EXCEPT    HEAD
053600060310     C                   MOVE      effdat        @DATIN
053700060310     C                   EXSR      #DATYM
053800060310     C                   MOVE      @DATOU        effmdy
0539000603100267 C                   EXCEPT    ERR12
0540000603100102 C                   ADD       1             orerr             6 0
054100060310     c                   end
054200060310
054300060310
054400010314      *  Fill workfile for Split Commission Audit *
054500121016      *  10/16/12 - stop doing this
054600121016     c*                  if        stype <> 'FIM' and stype <> 'FIS'
0547001210160063 C*    cmckey        CHAIN     comctxwk33                         50
054800121016     c*                  if        *in50
054900121016     c*                  move      cmtrst        wcmtrst
055000121016     c*                  move      csubdv        wcsubdv
055100121016     c*                  move      cmacct        wcmacct
055200121016     c*                  move      cmplan        wcmplan
055300121016     c*                  move      ccovpp        wccovpp
055400121016     c*                  move      ccovra        wccovra
055500121016     c*                  move      ccovpc        wccovpc
055600121016     c*                  move      ccpnc         wccpnc
055700121016     c*                  move      slstyp        wslstyp
055800121016     c*                  move      slsman        wslsman
055900121016     c*                  move      effdat        weffdat
056000121016     c*                  move      cmcan         wcmcan
056100121016     c*                  move      slname        wslname
056200121016     c*                  move      aacode        wacode
056300140905     c*                  move      idtrmd        wtranseff
056400121016     c*                  write     comcwk
056500121016     c*                  endif
056600121016     c*                  endif
056700010309
0568000006200051 C*
056900010126     c                   endsr
0570000006230107 C*
0571000006230103 C***************************************************
0572000006230104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0573000006230105 C***************************************************
0574000006230107 C*
0575000006230107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0576000006230107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0577000006230107 C*
0578000006230106 C     #DATYM        BEGSR
057900000623     C                   MOVE      @DATIN        @MD               4 0
058000000623     C                   MOVEL     @DATIN        @Y                4 0
058100000623     C                   MOVEL     @MD           @DATOU            8 0
058200000623     C                   MOVE      @Y            @DATOU
058300000623     C                   MOVE      *ZEROS        @DATIN            8 0
0584000006230120 C                   ENDSR
0585000006230107 C*
058600000620     C     *INZSR        BEGSR
0587000006200053 C                   TIME                    HTIME             6 0
058800000922
058900000922     c                   if        aorc = 'C'
059000000922     c                   eval      runfor = 'PRE COMMISSION'
059100000922     c                   else
059200000922     c                   eval      runfor = 'PRE ABR       '
059300000922     c                   end
059400010126
059500010126     c                   move      runmd         runymd            8 0
059600010126     c                   movel     runy          runymd
059700000922
0598000006200523 C                   EXCEPT    HEAD
059900000620
060000000620     c     cratky        klist
060100000620     c                   kfld                    idtrst
060200000620     c                   kfld                    idsubd
060300000620     c                   kfld                    idplan
060400000620     c                   kfld                    stype
060500070717
060600000620     c     cckey         klist
060700000620     c                   kfld                    idtrst
060800000620     c                   kfld                    idsubd
060900000620     c                   kfld                    idacct
061000000620     c                   kfld                    idplan
061100000620
061200000620     c     acckey        klist
061300000620     c                   kfld                    idtrst
061400000620     c                   kfld                    idsubd
061500000620     c                   kfld                    idacct
061600010126
061700010126     c     mkcaky        klist
061800010126     c                   kfld                    cmtrst
061900010126     c                   kfld                    csubdv
062000010126     c                   kfld                    cmacct
062100010126     c                   kfld                    idcar
062200010126
062300010126     c     brcmky        klist
062400010126     c                   kfld                    idcar
062500010126     c                   kfld                    mksz
062600000620
062700010309     c     cmckey        klist
062800010309     c                   kfld                    cmtrst
062900010309     c                   kfld                    csubdv
063000010309     c                   kfld                    cmacct
063100010330     c                   kfld                    cmplan
063200010330     c                   kfld                    slsman
063300010330     c                   kfld                    effdat
063400010330     c                   kfld                    cmcan
063500010309
0636000006200055 C                   ENDSR
0637009102150091 OQSYSPRT   E            HEAD           2  3
0638009102150092 O                       CONAME              87
0639001210180091 O          E            HEAD           1
0640009102150094 O                       UDATE         Y     14
0641009511020095 O                                           60 'PLANS WITHOUT COMMISSION'
0642009511020095 O                                           84 ' CONTROL RECORDS OR WITH'
0643009511020095 O                                          104 'OUT COMMISSION RATES'
0644009102150096 O                                          120 'PAGE :'
0645009102150097 O                       PAGE          Z    126
0646001210180091 O          E            HEAD           1
0647009102150099 O                                           18 'PROG: RPA067'
064800080404     O                                           48 'EFFECTIVE DATE:'
064900080404     O                       RUNDAT        Y     59
065000080404     O                                           69 'RUN FOR:'
065100080404     O                       RUNFOR              84
0652009102150100 O                                          120 'TIME :'
0653009102150101 O                       HTIME              130 '  :  :  '
065400080404     O                                           95 'ABR CODE:'
065500080404     O                       LABRCODE            97
0656001210180091 O          E            HEAD           1
0657009102150103 O                                           24 '------------------------'
0658009102150104 O                                           48 '------------------------'
0659009102150105 O                                           72 '------------------------'
0660009102150106 O                                           96 '------------------------'
0661009102150107 O                                          120 '------------------------'
0662009102150108 O                                          132 '------------'
0663001210180091 O          E            HEAD           1
0664009212090110 O                                           14 'TRUST-SUB-ACCT'
0665009707080110 O                                           23 'AA CODE'
0666009707080110 O                                           29 'PLAN'
066700110324     O                                           34 'CAR'
066800110324     O                                           41 'ABR'
0669001103240110 O                                           53 'EFF DATE'
0670001103240110 O                                           67 'SAMPLE SSN'
0671001103240110 O                                           75 'ERROR'
0672001210180091 O          E            HEAD           2
0673009102150112 O                                           24 '------------------------'
0674009102150113 O                                           48 '------------------------'
0675009102150114 O                                           72 '------------------------'
0676009102150115 O                                           96 '------------------------'
0677009102150116 O                                          120 '------------------------'
0678009102150117 O                                          132 '------------'
0679001210180118 O          E            ERROR1         1
0680000006200518 O                       IDTRST               3
0681000006200519 O                                            4 '-'
0682000006200520 O                       IDSUBD               7
0683000006200521 O                                            8 '-'
0684000006200522 O                       IDACCT              12
0685009707080125 O                       AACODE              21
0686000006200125 O                       IDPLAN              29
0687001103240125 O                       IDCAR               34
068800110324     O                       IDBCCC              40
0689001103240125 O                       IDCMDY        Y     53
0690001103240138 O                       IDSS#               67 '   -  -    '
0691001210190137 O                                           96 'NO COMMISSION CONTROL (EXC'
0692001210190137 O                                          122 'LUDING PAY NO COMM = N)   '
0693001210180118 O          E            ERR2           1
0694000006230518 O                       IDTRST               3
0695000006230519 O                                            4 '-'
0696000006230520 O                       IDSUBD               7
0697000006230521 O                                            8 '-'
0698000006230522 O                       IDACCT              12
0699000006230125 O                       AACODE              21
0700000006230125 O                       IDPLAN              29
0701001103240125 O                       IDCAR               34
070200110324     O                       IDBCCC              40
0703001103240125 O                       EFFMDY        Y     53
0704001103240138 O                       IDSS#               67 '   -  -    '
0705001103240137 O                                           96 'NO COMMISSION RATE: SMAN ='
0706001103240138 O                       SLSMAN             100
0707001103240137 O                                          108 'TYPE ='
0708001103240138 O                       STYPE              112
0709001210180130 O          E            ERR3           1
0710000006200518 O                       IDTRST               3
0711000006200519 O                                            4 '-'
0712000006200520 O                       IDSUBD               7
0713000006200521 O                                            8 '-'
0714000006200522 O                       IDACCT              12
0715009707080125 O                       AACODE              21
0716000006200125 O                       IDPLAN              29
0717001103240125 O                       IDCAR               34
071800110324     O                       IDBCCC              40
0719001103240125 O                       IDCMDY        Y     53
0720001103240138 O                       IDSS#               67 '   -  -    '
0721001103240137 O                                           83 'INVALID TRUST'
0722001210180130 O          E            ERR4           1
0723000006200518 O                       IDTRST               3
0724000006200519 O                                            4 '-'
0725000006200520 O                       IDSUBD               7
0726000006200521 O                                            8 '-'
0727000006200522 O                       IDACCT              12
0728009707080125 O                       AACODE              21
0729000006200125 O                       IDPLAN              29
0730001103240125 O                       IDCAR               34
073100110324     O                       IDBCCC              40
0732001103240125 O                       IDCMDY        Y     53
0733001103240138 O                       SLSMAN              60
0734001103240137 O                                           82 'INVALID SMAN'
0735001210180130 O          E            ERR5           1
0736000006200518 O                       IDTRST               3
0737000006200519 O                                            4 '-'
0738000006200520 O                       IDSUBD               7
0739000006200521 O                                            8 '-'
0740000006200522 O                       IDACCT              12
0741000006200125 O                       IDPLAN              29
0742001103240125 O                       IDCAR               34
074300110324     O                       IDBCCC              40
0744001103240125 O                       IDCMDY        Y     53
0745001103240137 O                                           82 'INVALID ACCT'
0746001210180130 O          E            ERR6           1
0747000101260518 O                       IDTRST               3
0748000101260519 O                                            4 '-'
0749000101260520 O                       IDSUBD               7
0750000101260521 O                                            8 '-'
0751000101260522 O                       IDACCT              12
0752000101260125 O                       IDPLAN              29
0753001103240125 O                       IDCAR               34
075400110324     O                       IDBCCC              40
0755001103240125 O                       IDCMDY        Y     53
0756001103240138 O                       IDCAR               59
0757001103240137 O                                           85 'INVALID CARRIER'
0758001210180118 O          E            ERR7           1
0759000101260518 O                       IDTRST               3
0760000101260519 O                                            4 '-'
0761000101260520 O                       IDSUBD               7
0762000101260521 O                                            8 '-'
0763000101260522 O                       IDACCT              12
0764000101260125 O                       AACODE              21
0765000101260125 O                       IDPLAN              29
0766001103240125 O                       IDCAR               34
076700110324     O                       IDBCCC              40
0768001103240125 O                       EFFMDY        Y     53
0769001103240138 O                       IDSS#               67 '   -  -    '
0770001103240137 O                                           90 'NO GLOBAL COMMISSION'
0771001103240137 O                                           98 'MKTSZ='
0772001103240138 O                       MKSZ               104
0773001210180118 O          E            ERR10          1
0774000304140518 O                       IDTRST               3
0775000304140519 O                                            4 '-'
0776000304140520 O                       IDSUBD               7
0777000304140521 O                                            8 '-'
0778000304140522 O                       IDACCT              12
0779000304140125 O                       AACODE              21
0780000304140125 O                       IDPLAN              29
0781001103240125 O                       IDCAR               34
078200110324     O                       IDBCCC              40
0783001103240125 O                       IDCMDY        Y     53
0784001103240138 O                       IDSS#               67 '   -  -    '
0785001103240137 O                                           96 'SMAN RELATION NOT ACTIVE F'
078600110324     O                                          111 'OR EFFDT  SMAN='
0787001103240138 O                       SLSMAN             115
0788001103240137 O                                          123 'RELID='
0789001103240138 O                       CMRELID            132
0790001210180118 O          E            ERR11          1
0791000304140518 O                       IDTRST               3
0792000304140519 O                                            4 '-'
0793000304140520 O                       IDSUBD               7
0794000304140521 O                                            8 '-'
0795000304140522 O                       IDACCT              12
0796000304140125 O                       AACODE              21
0797000304140125 O                       IDPLAN              29
0798001103240125 O                       IDCAR               34
079900110324     O                       IDBCCC              40
0800001103240125 O                       IDCMDY        Y     53
0801001103240138 O                       IDSS#               67 '   -  -    '
0802001103240137 O                                           96 'SMAN RELATION DOES NOT EXI'
080300110324     O                                          113 'ST. RELATION ID ='
0804001103240138 O                       CMRELID            122
0805001210180118 O          E            ERR12          1
0806000603100518 O                       IDTRST               3
0807000603100519 O                                            4 '-'
0808000603100520 O                       IDSUBD               7
0809000603100521 O                                            8 '-'
0810000603100522 O                       IDACCT              12
0811000603100125 O                       AACODE              21
0812000603100125 O                       IDPLAN              29
081300080404     O                       IDBCCC              33
0814001103240125 O                       IDCAR               34
0815001103240125 O                       EFFMDY        Y     53
0816001103240138 O                       IDSS#               67 '   -  -    '
0817001103240137 O                                           97 'MORE THAN 1 OVERRIDE:  SMA'
081800110324     O                                           99 'N='
0819001103240138 O                       SLSMAN             103
0820001103240137 O                                          111 'RELID='
0821001103240138 O                       CMRELID            120
0822001210180118 O          E            ERROR13        1
0823000707160518 O                       IDTRST               3
0824000707160519 O                                            4 '-'
0825000707160520 O                       IDSUBD               7
0826000707160521 O                                            8 '-'
0827000707160522 O                       IDACCT              12
0828000707160125 O                       AACODE              21
0829000707160125 O                       IDPLAN              29
0830001103240125 O                       IDCAR               34
083100110324     O                       IDBCCC              40
0832001103240125 O                       IDCMDY        Y     53
0833001103240138 O                       IDSS#               67 '   -  -    '
0834001103240137 O                                           92 '% OF COMM OVR. DOES NO'
083500110324     O                                          116 'T TOTAL 100%. CALC AMT ='
0836001103240125 O                       L1TOTPC       M    130
0837001210180118 O          E            ERR14          1
0838000901040518 O                       IDTRST               3
0839000901040519 O                                            4 '-'
0840000901040520 O                       IDSUBD               7
0841000901040521 O                                            8 '-'
0842000901040522 O                       IDACCT              12
0843000901040125 O                       AACODE              21
0844000901040125 O                       IDPLAN              29
0845001103240125 O                       IDCAR               34
084600110324     O                       IDBCCC              40
0847001103240125 O                       EFFMDY        Y     53
0848001103240138 O                       IDSS#               67 '   -  -    '
0849001103240137 O                                           87 'NO GLOBAL ADM FEE'
0850001103240137 O                                           95 'MKTSZ='
0851001103240138 O                       MKSZ               101
0852001210180118 O          E            ERR15          1
0853000901040518 O                       IDTRST               3
0854000901040519 O                                            4 '-'
0855000901040520 O                       IDSUBD               7
0856000901040521 O                                            8 '-'
0857000901040522 O                       IDACCT              12
0858000901040125 O                       AACODE              21
0859000901040125 O                       IDPLAN              29
0860001103240125 O                       IDCAR               34
086100110324     O                       IDBCCC              40
0862001103240125 O                       EFFMDY        Y     53
0863001103240138 O                       IDSS#               67 '   -  -    '
0864001103240137 O                                           90 'NO GLOBAL BONUS DRAW'
0865001103240137 O                                           98 'MKTSZ='
0866001103240138 O                       MKSZ               104
0867001210180118 O          E            ERROR16        1
0868001102090518 O                       IDTRST               3
0869001102090519 O                                            4 '-'
0870001102090520 O                       IDSUBD               7
0871001102090521 O                                            8 '-'
0872001102090522 O                       IDACCT              12
0873001102090125 O                       AACODE              21
0874001102090125 O                       IDPLAN              29
0875001103240125 O                       IDCAR               34
087600110324     O                       IDBCCC              40
0877001103240125 O                       IDCMDY        Y     53
0878001103240138 O                       IDSS#               67 '   -  -    '
0879001103240137 O                                           96 'PREMIUM SPLIT DOES NOT TOT'
088000110324     O                                          115 'AL 100%. CALC AMT ='
0881001103240125 O                       L1TOTCMSP     M    130
0882001210180118 O          E            ERROR17        1
0883001105170518 O                       IDTRST               3
0884001105170519 O                                            4 '-'
0885001105170520 O                       IDSUBD               7
0886001105170521 O                                            8 '-'
0887001105170522 O                       IDACCT              12
0888001105170125 O                       AACODE              21
0889001105170125 O                       IDPLAN              29
0890001105170125 O                       IDCAR               34
089100110517     O                       IDBCCC              40
0892001105170125 O                       IDCMDY        Y     53
0893001105170138 O                       IDSS#               67 '   -  -    '
0894001105170137 O                                           96 '# OF PAY NO COMM OVERRIDES'
089500110517     O                                          116 ' = P IS > 1. COUNT ='
0896001105170125 O                       L1TOTPNC      M    126
0897001210180118 O          E            ERROR18        1
0898001210160518 O                       IDTRST               3
0899001210160519 O                                            4 '-'
0900001210160520 O                       IDSUBD               7
0901001210160521 O                                            8 '-'
0902001210160522 O                       IDACCT              12
0903001210160125 O                       AACODE              21
0904001210160125 O                       IDPLAN              29
0905001210160125 O                       IDCAR               34
090600121016     O                       IDBCCC              40
0907001210160125 O                       IDCMDY        Y     53
0908001210160138 O                       IDSS#               67 '   -  -    '
0909001210160137 O                                           96 'ONLY 1 COM CAN EXIST WHEN '
091000121016     O                                          122 'PAY NO COM=P IS USED. CNT='
0911001210160125 O                       COMCNT        M    128
0912001210180118 O          E            ERROR19        1
0913001210180518 O                       IDTRST               3
0914001210180519 O                                            4 '-'
0915001210180520 O                       IDSUBD               7
0916001210180521 O                                            8 '-'
0917001210180522 O                       IDACCT              12
0918001210180125 O                       AACODE              21
0919001210180125 O                       IDPLAN              29
0920001210180125 O                       IDCAR               34
092100121018     O                       IDBCCC              40
0922001210180125 O                       IDCMDY        Y     53
0923001210180138 O                       IDSS#               67 '   -  -    '
0924001210180137 O                                           96 'GLOBAL RATE CANNOT EXIST W'
092500121018     O                                          122 '/OVERRIDES (EXCL. PNC=N)  '
0926001210180139 O          E            FINERR      1
0927001210180140 O                                           12 'TOTAL ERRORS'
092800121018     O                                           14 ' '
0929001210180139 O          E            FINERR      1  1
0930001210180140 O                                           19 'COMMISSION CONTROL:'
0931001210180141 O                       COMERR        3     26
0932001210180140 O                                           54 'COMMISSION RATE       :'
0933001210180141 O                       CRATERR       3     61
0934001210180140 O                                           88 'GLOBAL COMM RATE     :'
0935001210180141 O                       GLOBERR       3     95
0936001210180140 O                                          121 'MORE THAN 1 OVERRIDE:'
0937001210180141 O                       ORERR         3    130
0938001210180139 O          E            FINERR         1
0939001210180140 O                                           19 'SALESMAN RELATION :'
0940001210180141 O                       RELERR        3     26
0941001210180140 O                                           54 'PCT OF COM OVR <> 100%:'
0942001210180141 O                       COMOVRERR     3     61
0943001210180140 O                                           88 'GLOBAL ADMIN FEE     :'
0944001210180141 O                       AFERR         3     95
0945001210180140 O                                          121 'GLOBAL BONUS DRAW   :'
0946001210180141 O                       BDERR         3    130
0947001210180139 O          E            FINERR         1
0948001210180140 O                                           19 'PREM SPLIT <> 100%:'
0949001210180141 O                       PRESPLERR     3     26
095000121018     O                                           54 'PAY NO COM OVR = P > 1:'
0951001210180141 O                       PNCERR        3     61
0952001210180140 O                                           88 'PAY NO COM=P W/OTHERS:'
0953001210180141 O                       PNCSPLITERR   3     95
0954001210180140 O                                          121 'GLOBAL W/OVERRIDE   :'
0955001210180141 O                       OVRNOTNERR    3    130
