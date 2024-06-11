0002009102150002 F******************************************************************
0003001304110003 F* db025      GROUP BENEFIT SERVICES SOFTWARE                     *
0004009102150004 F*                                                                *
000500110812     F*            WRITTEN BY - DAVID KETTERMAN                        *
000600130411     F*            DATE - 04/11/13                                     *
000700110812     F*                                                                *
0008009102150007 F*                                                                *
000900130412     F*  DESCRIPTION - Benefit audit program. Calcuate the benefit     *
000901130412     F*  amount in all active mcov rec as of the latest invoice, or
003309130412      *  effdt of coverage if there is no invoice, and report those
003310130412      *  that do not match the current benefit amount.
003311130412      *                                                                *
003312130717      * 07/17/13 dlk - add skip if age calc date is before the enroll  *
003313130717      *                date.                                           *
003314131003      * 10/03/13 dlk - hist file expansion project - recompile only
003315130717      *                                                                *
0034001109130012 F******************************************************************
003500110812      *
003600130411     FMCOV      ip   E           k DISK
004000110812     FDECLIF    IF   E           K DISK
004200110812     FPLNMST    IF   E           K DISK
004400110812     FMEMBER    IF   E           K DISK
004401130411     Fwebnotl1  IF   E           K DISK
0044021304110005 Fhistaa    if   e           k disk
0048001304110019 Fdb025xl   O  a e             disk
0049001304110020
005100110812     D DS@DCL        E DS                  EXTNAME(DECLIF)
0052001108120021 D ABF                    11     50P 0 DIM(20)
0053001108120022 D ABT                    71    110P 0 DIM(20)
0054001109210023 D DRT                   131    190P 5 DIM(20)
005500110812     D DROUND                221    221A
005600110812     D DRNDAM                222    224P 0
005700110812     ***
0058009110100024 D*
0059001108120158 D                 DS
006000110812     D RA@                     1      5A
0061001108120025 D $RA                     1      5S 0 DIM(5)
0062001108120158 D                 DS
006300110812     D BA@                     1      9A
0064001108120026 D $BA                     1      9S 0 DIM(9)
0065001108120158 D                 DS
006600110812     D BR@                     1      9A
0067001108120027 D $BR                     1      9S 0 DIM(9)
007400110812     ***
0075009808280158 D                 DS
0076001304110159 D  agecalcdt              1      8  0
0077001304110160 D  agecalcyr              1      4  0
0078001304110161 D  agecalcmo              5      6  0
0078071304110158 D                 DS
0078081304110159 D  tsa                    1     10  0
0078091304110160 D  mctrst                 1      3  0
0078101304110161 D  mcsub#                 4      6  0
0078111304110161 D  acc#                   7     10  0
0080009102150080 D                UDS
0081009102150081 D  CONAME               201    240
008900110812Y2K  D  UD8YMD               248    255  0
009000110812     ***
009100110812     D ADD$R           S              3A
009200110812     D AGE             S              3S 0
009300130411     D BENAMTWK        S                   like(benamt)
009500110812     D BRTEST          S              9S 2
009600110812     D D               S              2S 0
010000110812     D HOLD            S             13S 5
010800110812     D OBENAM          S              7S 0
011000110812     D S               S              2S 0
011600110812     D BENHLD          S              9S 2
011700110812     D $C              S              1S 0
011800110812     D $D              S              1S 0
011801130411
011802130411     D errtxt          S             35
011803130411     D declifout       S             20
0118041304110037 D bmb             S              3    inz('BMB')
011805130411     D declifeused     S              1
011806130411     D declifepct      S              5s 5
0118071304110125 Dcsv              c                   const('","')
011900110812     ***
0120001108120158 D                 DS
0121001108120159 D  BIRTH@                 1      8A
0122001108120067 D  BYR                    1      4S 0
0123001108120066 D  BMO                    5      6S 0
0123011304110030 Imcovr
012303130411     I                                          mctrst        l2
012304130411     I                                          mcsub#        l2
012305130411     I                                          acc#          l2
012306130411     I                                          mcssno        l1
012800130411
012801130411     c                   if        *inl2
012802130411     c                   clear                   firstl2           1
012803130411     c                   end
012804130411
0153001304110122 C* get plan
0155001304110124 C     PLANKY        CHAIN     plnmst
0156001304110126 C                   if        not %found(plnmst)
015601130411     c                   goto      #end
015602130411     c                   end
015603130411
015604130411     c                   clear                   benplan           1
015606130411     c                   if        mult = 0 and maxben = 0
015607130411     c                   eval      benplan = 'N'
015608130411     c                   else
015609130411     c                   eval      benplan = 'Y'
015610130411     c                   end
0157001302130123
015701130411      * invalid benefit
015702130411     c                   if        (benplan = 'Y' and benamt = 0) or
015703130411     c                             (benplan = 'N' and benamt <> 0)
015704130411     C                   clear                   errtxt
015705130411     C                   eval      errtxt = 'BENEFIT <> PLAN SETUP'
015706130411     C                   exsr      writexldet
015707130411     C                   clear                   errtxt
015708130411     c                   goto      #end
015709130411     c                   end
015710130411
015711130411      * not a benefit based plan - skip it
015712130411     c                   if        benamt = 0
015715130411     c                   goto      #end
015716130411     c                   end
015717130411
0157221304110129 C* get member for salary and bday
0157231304110114 C     MCSSNO        CHAIN     member
015724130411     c                   if        not %found(member)
015725130411     c                   goto      #end
015726130411     c                   end
015727130411
015728130411     C                   MOVE      BIRTH         BIRTH@
0157301304110147
015732130411      * get latest invoice date - this will be the date used to calc
015733130411      * the age of declife
015734130411      * if no invoice has been run yet, use effective date of mcov instead
015735130412      * only needed once per acct (l2)
015736130411     c                   if        firstl2 = *blank
015738130411     c                   exsr      #getinv
015739130411     c                   eval      firstl2 = 'N'
015740130411     c                   end
015741130411
015742130411     c                   if        lastinvdt <> 0
015743130411     c                   z-add     lastinvdt     agecalcdt
015744130411     c                   else
015745130411     c                   z-add     enrldt        agecalcdt
015746130411     c                   end
015747130411
0157481307170129  * if date used for age calc is before the coverage starts, skip it
015750130717     c                   if        agecalcdt < enrldt
015751130717     c                   goto      #end
015752130717     c                   end
015756130717
0157571307170129 C* get dec life rec if one exists
015758130411     c                   exsr      #getdeclif
015759130411
015760130411      * check for variable benefit amount plan
015761130411     c                   exsr      #chkvarben
015762130411
0157631304110129 C* calc the benefit
0157641304110145 C                   clear                   fltflg            1
015765130411     c                   z-add     benamt        obenam
0157661304110142 C                   if        mult = 0
0157671304110145 C                   move      'F'           fltflg
0157681304110146 C                   END
0157691304110143 C                   EXSR      #SALRY
015770130411
015771130411      * does mcov benamt match calc benamt?
015772130411     C     OBENAM        IFNE      BENAMTWK
015773130411     C                   clear                   errtxt
015774130411     c                   eval      errtxt = 'BENEFIT DOES NOT MATCH CALC AMT'
015775130411     c                   exsr      writexldet
015776130411     C                   END
015777130411
0234009907160151 C     #END          TAG
023501130411
026000110812     C******************************************************************
0262001304110153 C* get dec life reduction
026201130411     C******************************************************************
0263009102150154 C*
0264001304110155 C     #getdeclif    BEGSR
026401130411
0264021304110139 C                   clear                   declifout
0264031304110139 C                   eval      declifeused = 'N'
0264041304110139 C                   clear                   declifepct
026405130411
0264061304110131 C     PLANKY        CHAIN     DECLIF
026407130411     c                   if        not %found(declif)
026408130411     c                   leavesr
026409130411     c                   end
0265009102150156 C*
0266001304110157 C* CALCULATE AGE as of latest invoice effective date
0267009102150158 C*
0268001304110159 C     agecalcyr     SUB       BYR           AGE
0269001304110160 C     agecalcmo     IFNE      12
0270001304110161 C     agecalcmo     IFLT      BMO
0271009102150162 C                   SUB       1             AGE
0272009102150163 C                   END
0273009102150164 C                   END
0274009102150165 C*
0275009610080166 C* CHECK FOR AGE IN RANGE OF DECLINING LIFE BENEFIT
0276009102150167 C*
0277001304110168 C                   clear                   S
0279001304110170 C                   DO        20            D
027901130411     c                   if        (age >= abf(d)) and
027902130411     c                             (age <= abt(d))
0282001304110173 C                   Z-ADD     D             S
028201130411     c                   leave
0284001304110175 C                   end
0284011304110175 C                   enddo
028402130411
028403130411      * if the age is in one of the ranges then flag it and hold the %
0284041304110138 C                   if        s <> 0
0284051304110139 C                   eval      declifeused = 'Y'
0284061304110139 C                   eval      declifepct = drt(s)
0284071304110140 C                   END
028410130411
0286009102150177 C                   ENDSR
0287009102150178 C*
0288009102150179 C****************************************************************
0289009102150180 C*
0290009908190181 C*------------- SALARY BASED BENEFIT CALCULATION ---------------*
0295009102150186 C*
0296009102150187 C     #SALRY        BEGSR
0297001304110188
0297011304110189 C* flat plans
029702130411     C                   if        fltflg = 'F'
029703130411      * variable benefit amount plans must use the original benefit amt
029704130411      * field in mcov as a starting point for calc since the amt is selected
029705130411      * by the member and not stored anywhere else
029706130411     c                   if        varbenpln = 'Y'
029707130411     C                   Z-ADD     mcorgben      BENAMTwk
029708130411     c                   else
029709130411     C                   Z-ADD     MAXBEN        BENAMTwk
029710130411     c                   end
029711130411     C                   GOTO      #FLAT
029712130411     C                   END
029713130411
0298001304110189 C* MULTIPLY SALARY TIMES MULTIPLIER IN PLAN RECORD
0301001108120192 C     SALARY        MULT      MULT          BENHLD
030200110812     C                   MOVE      BENHLD        BA@
0303009102150194 C*
0304009102150195 C* IF ROUNDING UP, ADD ROUNDING FACTOR FROM PLAN RECORD
0305009102150196 C* TO BENEFIT AMOUNT. IF ROUNDING DOWN, LEAVE BENEFIT AMOUNT
0306009102150197 C* AS IS, AFTER FIRST ASCERTAINING WHETHER THE BENEFIT AMOUNT
0307009102150198 C* IS ALREADY AN EVEN AMOUNT IN THE POSITIONS TO BE ROUNDED.
0308009102150199 C*
0309001108120200 C                   MOVE      'NO '         ADD$R
0310009102150201 C     ROUND         IFGT      0
0311009102150202 C*
0312009102150203 C* FIND $ AMOUNT TO BE ROUNDED
0313009102150204 C*
031400110812     C                   MOVE      ROUND         RA@
0315009102150206 C                   MOVE      *ZEROS        $BR
0316001108120207 C                   Z-ADD     5             $C
0317001108120208 C                   Z-ADD     7             $D
0318009102150209 C                   MOVE      $BA(9)        $BR(9)
0319009102150210 C                   MOVE      $BA(8)        $BR(8)
0320009102150211 C                   DO        5
0321009102150212 C     $RA($C)       IFEQ      0
0322009102150213 C                   MOVE      $BA($D)       $BR($D)
0323009102150214 C                   SUB       1             $C
0324009102150215 C                   SUB       1             $D
0325009102150216 C                   ELSE
0326009102150217 C                   GOTO      #S$T01
0327009102150218 C                   END
0328009102150219 C                   END
0329009102150220 C*
0330009102150221 C     #S$T01        TAG
0331009102150222 C*
0332009102150223 C     $BA           SUB       $BR           $BA
0333009102150224 C*
0334001108120225 C     PRNDFL        IFEQ      'U'
033500110812     C                   MOVE      BR@           BRTEST
0336009102150227 C     BRTEST        IFGT      0
0337009102150228 C                   MOVE      'YES'         ADD$R
0338009102150229 C                   END
0339009102150230 C                   END
0340009102150231 C*
0341009102150232 C                   END
0343009102150234 C*
0344001304110235 C* NOW PLACE RESULT IN FIELD BENAMT
034800110812     C                   MOVEL     BA@           BENAMTWK
0349009102150240 C     ADD$R         IFEQ      'YES'
0350001108120241 C                   ADD       ROUND         BENAMTWK
0351009102150242 C                   END
0352009102150243 C*
0353009102150244 C* IF COMPUTED BENEFIT AMOUNT IS GREATER THAN THE MAXIMUM BENEFIT
0354009102150245 C* ALLOWED, REPLACE COMPUTED BENEFIT WITH MAXIMUM BENEFIT
0355009102150246 C* FROM PLAN RECORD.
0356009102150247 C*
0357001108120248 C     BENAMTWK      IFGT      MAXBEN
0358001108120249 C                   MOVE      MAXBEN        BENAMTWK
0359009102150250 C                   END
036602130411
036603130411     c     #flat         tag
036604130411
036605130411      *****************
036606130411      * dec life calc
036607130411      *****************
036608130411
0367001304110252 C* APPLY DECLINING LIFE if needed
036801130411     c                   if        declifeused <> 'Y'
036802130411     c                   leavesr
036803130411     c                   end
036804130411
0369001304110253 C     BENAMTWK      MULT(H)   declifepct    HOLD
0370009102150254 C                   Z-ADD     HOLD          BENHLD
0371009102150255 C*
037200110812     C                   MOVE      BENHLD        BA@
0373009102150257 C*
0374009102150258 C* IF ROUNDING UP, ADD ROUNDING FACTOR FROM DECLINING LIFE BENEFIT RECORD
0375009102150259 C* TO BENEFIT AMOUNT. IF ROUNDING DOWN, LEAVE BENEFIT AMOUNT
0376009102150260 C* AS IS, AFTER FIRST ASCERTAINING WHETHER THE BENEFIT AMOUNT
0377009102150261 C* IS ALREADY AN EVEN AMOUNT IN THE POSITIONS TO BE ROUNDED.
0378009102150262 C*
0379001108120263 C                   MOVE      'NO '         ADD$R
0380009102150264 C     DRNDAM        IFGT      0
0381009102150265 C*
0382009102150266 C* FIND $ AMOUNT TO BE ROUNDED
0383009102150267 C*
038400110812     C                   MOVE      DRNDAM        RA@
0385009102150269 C                   MOVE      *ZEROS        $BR
0386001108120270 C                   Z-ADD     5             $C
0387001108120271 C                   Z-ADD     7             $D
0388009102150272 C                   MOVE      $BA(9)        $BR(9)
0389009102150273 C                   MOVE      $BA(8)        $BR(8)
0390009102150274 C                   DO        5
0391009102150275 C     $RA($C)       IFEQ      0
0392009102150276 C                   MOVE      $BA($D)       $BR($D)
0393009102150277 C                   SUB       1             $C
0394009102150278 C                   SUB       1             $D
0395009102150279 C                   ELSE
0396009102150280 C                   GOTO      #S$T02
0397009102150281 C                   END
0398009102150282 C                   END
0399009102150283 C*
0400009102150284 C     #S$T02        TAG
0401009102150285 C*
0402009102150286 C     $BA           SUB       $BR           $BA
0403009102150287 C*
0404009102150288 C     DROUND        IFEQ      'U'
040500110812     C                   MOVE      BR@           BRTEST
0406009102150290 C     BRTEST        IFGT      0
0407009102150291 C                   MOVE      'YES'         ADD$R
0408009102150292 C                   END
0409009102150293 C                   END
0410009102150294 C*
0411009102150295 C                   END
0412009102150296 C*
041600110812     C                   MOVEL     BA@           BENAMTWK
0417009102150301 C     ADD$R         IFEQ      'YES'
0418001108120302 C                   ADD       DRNDAM        BENAMTWK
0419009102150303 C                   END
0420009102150304 C*
0447009610080323 C                   ENDSR
044701130411
057301130411      *******************************************
057302130411      * find latest invoice produced
057303130411      *******************************************
057304130411     c     #getinv       begsr
057305130411
057306130411     c                   clear                   lastinvdt         8 0
057307130411     c                   movel     tsa           tsachar          10
057308130411     c     hiskey        setll     histaa
057309130411     c                   dou       %eof(histaa)
057310130411     c     hiskey        reade     histaa
057311130411     c                   if        not %eof(histaa) and covtdt > lastinvdt
057312130411     c                   move      covtdt        lastinvdt
057313130411     c                   end
057314130411     c                   enddo
057315130411
057316130411     c                   endsr
057317130411
057318130411DTAQ  ******************************************************
057319130411      * check for variable benefit
057320130411DTAQ  ******************************************************
057321130411DTAQ c     #chkvarben    begsr
057322130411
057323130411     c     webnotkey     klist
057324130411     c                   kfld                    mctrst
057325130411     c                   kfld                    mcsub#
057326130411     c                   kfld                    acc#
057327130411     c                   kfld                    mcplan
057328130411
057335130411     c                   clear                   varbenpln         1
057336130411     c     webnotkey     setll     webnotl1
057337130411     c                   dou       %eof(webnotl1)
057338130411     c     webnotkey     reade     webnotl1
057339130411     c                   if        not %eof(webnotl1) and agecalcdt >= cnbeg
057340130411     c                             and (cnend = 0 or
057341130411     c                             (cnend <> 0 and agecalcdt <= cnend))
057342130411     c                   eval      varbenpln = 'Y'
057343130411     c                   leave
057344130411     c                   end
057345130411     c                   enddo
057347130411
057380130411DTAQ c                   endsr
057381130411
0574001304110164 C*************************************************************
0576001304110164 C* Write Spreadsheet Detail                                  *
0578001304110164 C*************************************************************
057900130411     C     Writexldet    BEGSR
058000130411
058001130411      * count errors = test with small number of errors
058002130411     c**                 add       1             errcnt           10 0
058003130411     c**                 if        errcnt > 100
058004130411     c**                 eval      *inlr = *on
058005130411     c**                 end
058006130411
058007130411      * format declifout field
058008130411
058009130411     c                   clear                   declifout
058010130411     c                   if        declifeused = 'Y'
058011130411     c                   eval      declifout = %char(abf(s)) + '-' +
058012130411     c                             %char(abt(s)) +
058013130411     c                             '  ' + %editc(declifepct:'1')
058014130411     c                   end
058015130411
058100130411     c                   clear                   db025fld
058200130411     C                   Eval      db025fld  = '"' +
058400130411     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
058401130411     C                             %trim(%editw(mcssno:'0   -  -    ')) + csv +
058500130411     C                             mcplan                               + csv +
058501130411     C                             %trim(pdescr)                        + csv +
058502130411     C                             %editc(mult:'1')                     + csv +
058503130411     C                             %editc(maxben:'1')                   + csv +
058504130411     C                             %trim(%editw(enrldt:'    /  /  '))   + csv +
058505130411     C                             %editc(benamt:'1')                   + csv +
058506130411     C                             %editc(benamtwk:'1')                 + csv +
058507130411     C                             %trim(%editw(birth:'    /  /  '))    + csv +
058508130411     C                             %editc(age:'1')                      + csv +
058509130411     C                             %trim(%editw(agecalcdt:'    /  /  ')) + csv +
058510130411     C                             %trim(declifout)                     + csv +
058511130411     C                             %editc(salary:'1')                   + csv +
058512130411     C                             varbenpln                            + csv +
058513130411     C                             errtxt                               + csv +
058800130411     C                             ' '                                  + '",'
058900130411     C*
059000130411     C                   Write     db025xr
0591001304110320 C                   ENDSR
059200130411     C*
059300130411     C/EJECT
059400130411     C*************************************************************
059600130411     C* Write Spreadsheet heading                                 *
059800130411     C*************************************************************
059900130411     C     Writexlhead   BEGSR
060000130411
060100130411     c                   clear                   db025fld
060200130411     C                   Eval      db025fld = '"' +
060202130411     C                             'ACCOUNT #'                          + csv +
060203130411     C                             'SS #'                               + csv +
060204130411     C                             'PLAN'                               + csv +
060205130411     C                             'PLAN DESCRIPTION'                   + csv +
060206130411     C                             'MULTIPLIER'                         + csv +
060207130411     C                             'MAX BEN'                            + csv +
060208130411     C                             'ENROLL DT'                          + csv +
060209130411     C                             'CURR BEN'                           + csv +
060210130411     C                             'CALC BEN'                           + csv +
060211130411     C                             'BIRTH DATE'                         + csv +
060212130411     C                             'CALC AGE'                           + csv +
060214130411     C                             'CALC AS OF DATE'                    + csv +
060215130411     C                             'BEN REDUCTION'                      + csv +
060216130411     C                             'SALARY'                             + csv +
060217130411     C                             'VAR BEN'                            + csv +
060218130411     C                             'ERROR'                              + csv +
060700130411     C                             ' '                                  + '",'
060800130411     C                   Write     db025xr
060900130411     C*
0610001304110320 C                   ENDSR
061001130411
061100130411     C     *INZSR        BEGSR
061101130411
061506130411     C     PLANKY        KLIST
061507130411     C                   KFLD                    MCTRST
061508130411     C                   KFLD                    MCSUB#
061509130411     C                   KFLD                    MCPLAN
061510130411
061511130411     c     hiskey        klist
061512130411     c                   kfld                    tsachar
061513130411     c                   kfld                    bmb
061514130411
061700130411     C                   Exsr      Writexlhead
061800130411     C                   endsr
