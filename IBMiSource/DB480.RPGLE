0000031301020002  ******************************************************************
0000041912120003  * db480      GROUP BENEFIT SERVICES, INC.                        *
0000051301020004  *                                                                *
0000061301020005  *            WRITTEN BY - DAVID KETTERMAN                        *
0000071912120006  *            DATE - 12/12/19                                     *
0000081301020007  *                                                                *
0000091912120011  * BSF plan audit. All medical members in an account with a BSF   *
0000101912130011  * plan must have the BSF plan. Also check for members with a     *
0000161912130011  * BSF plan but no medical.                                       *
0000321601140011  *                                                                *
0000331301020013  ******************************************************************
000034130102
0001011912120005 Fdb480j    ip   e           k disk
0001021801300005 Fmemac#    if   e           k disk
0001030502280005 Fmcov      if   e           k disk
0001041601140005 Faccmst    if   e           k disk
0001060502280018 FPLNMST    IF   e           k DISK
000107050228     Fcodesl1   IF   E           K DISK
000108191213     Faacode    if   e           k DISK
0001091912120017 Fdb480xl   o  a e             DISK
0001180503040125 Dcsv              c                   const('","')
0001191212310125 Dmemname          s             30
0001201912130125 Daaname           s             30
0001211912130125 Derrortxt         s             30
0001271601140125 Dacnamout         s                   like(acnam1)
0001281912120125 Dmc_planh         s                   like(mcplan)
0001291912120125 Dmc_plandh        s                   like(pdescr)
0001321912120125 Dmcov_cat         s                   like(action)
0001331912120125 Dmcov_car         s                   like(pcarr)
0001411601140125 Deffmdyh          s              8  0
0001421601140125 Dcanmdyh          s              8  0
0001431301020125 Derrfound         s              1
0001441912110125 Dcobra            s              1
0001451912120125 Dhold_bsf         s              1
0001461912120125 Dhold_med         s              1
000148121231     D                 dS
0001491212310125 D  tsa                    1     10  0
0001501912120125 D  CMTRST                 1      3  0
0001511912120125 D  CSUBDV                 4      6  0
0001521912120125 D  CMACCT                 7     10  0
000153050302     D                udS
0001540503030054 D  CONAME               201    240
0001550503030055 D  TIME                 242    247  0
0001560503030157 D  UD8YMD               248    255  0
000157191212
000158191213     Iaccmsr
000159191213     i              aacode                      a_aacode
000162191212     idb480r
000163191212     i                                          CMTRST        l1
000164191212     i                                          CSUBDV        l1
000165191212     i                                          CMACCT        l1
000166191212
000167191213      * only check once per acct (there will be multiple comctx plans)
000168191212     cl1                 exsr      #chkacc
000169191213     clr                 exsr      #lr
000861170403
001062180130      ********************
001063191212      * check all active members in account
001064180130      ********************
001065191212       begsr #chkacc;
001066180130
0010671912130313  * get account name
001068191213       clear acnamout;
0010691912130171   chain (cmtrst:csubdv:cmacct) accmst;
001070191213       if    %found(accmst);
001071191213       eval  acnamout = acnam1;
001072191213       endif;
001073191213
0010741912130313  * get aa name
001075191213       clear aaname;
0010761912130171   chain (a_aacode) aacode;
001077191213       if    %found(aacode);
001078191213       eval  aaname = %trim(afnam) + ' ' + %trim(alnam);
001079191213       endif;
001080191213
001081191213      * check members
001082160114       setll keyacc memac#;
0010831601140131   dou   %eof(memac#);
0010841601140132   reade keyacc memac#;
0010851601140133   if    not %eof(memac#) and termdt = 0;
001086191211
001087191211      * show cobra status
001088191211        clear cobra;
001089191211        if cexpdt <> 0;
001090191211        cobra = 'Y';
001091191211        endif;
001092191213
001093191213      * format memebr name
001094191213        clear memname;
001095191213        memname = %trim(mfname) + ' ' + %trim(mlname);
001097191211
001098160114       exsr  #fndplans;
001099160114       endif;
001100160114       enddo;
001101160114
001102160114       endsr;
001103121231
001104121231      ********************
001105160114      * find active plans
001106121231      ********************
001107160114       begsr #fndplans;
001108191212       clear mc_planh;
001109191212       clear mc_plandh;
001110160114       clear effmdyh;
001111160114       clear canmdyh;
001112191212       clear hold_med;
001113191212       clear hold_bsf;
001114160114
001115160114       setll mbssno mcov;
0011161601140131   dou   %eof(mcov);
0011171601140132   reade mbssno mcov;
0011181601140133   if    %eof(mcov) or (enrldt = candt) or
001119160114             (candt <> 0 and candt <= ud8ymd);
001120160114       iter;
001121160114       endif;
001122160114
001123160114      * get plan
001124191212       clear mcov_car;
001125191212
0011261601140171   chain plnkey plnmst;
001127160114       if    not %found(plnmst);
001128160114       iter;
001129160114       endif;
001130191212       mcov_car = pcarr;
001131160114
001132191212      * get plan category type for this mcov plan
001133191212       clear mcov_cat;
001134191212
001135160114       chain plncat codesl1;
001136160114       if    not %found(codesl1);
001137160114       iter;
001138160114       endif;
001139191212       mcov_cat = action;
001140191212      *
001141191212      * hold medical and BSF plans
001142191212      *
001143160114
001144160118      * hard coded exclusion of plan WAVM which is set up as a medical
001145160118      * plan but it is not a real plan due to a design flaw in OLE
001146191212
001147191212       if mcov_cat = 'M' and mcplan <> 'WAVM'                               ;
001148191212       eval HOLD_MED = 'Y';
001149160114       exsr #savpln1;
001150160114       endif;
001151160114
001152191212       if mcov_car = 'BSF';
001153191212       eval HOLD_BSF = 'Y';
001154191212       endif;
001155191212
001156160114       enddo;
001157160114
001158191213      * errors:
001159191213      * 1. medical plan w/o BSF
001160191213      * 2. BSF w/o medical
001162160114
001163191213       clear errortxt;
001164191213
001165191213       select;
001166191213       when hold_med = 'Y' and hold_bsf <> 'Y';
001167191213        errortxt = 'Medical plan w/o BSF';
001168191213        exsr writexldet;
001169191213       when hold_med <> 'Y' and hold_bsf = 'Y';
001170191213        errortxt = 'BSF plan w/o Medical';
001171191213        exsr writexldet;
001172191213       endsl;
001173160114
001174160114       endsr;
001175160114
001176160114      ********************
001177160114      * save plan 1 fields for report use
001178160114      ********************
001179160114     c     #savpln1      begsr
001180191212     c                   movel     mcplan        mc_planh
001181191212     c                   movel     pdescr        mc_plandh
001182130102     C                   MOVE      enrldt        @DATIN
001183130102     C                   EXSR      #DATYM
001184160114     C                   MOVE      @DATOU        effmdyh
001185130102     C                   MOVE      candt         @DATIN
001186130102     C                   EXSR      #DATYM
001187160114     C                   MOVE      @DATOU        canmdyh
001188160114     c                   endsr
001195160114
001196191213      ********************
001197191213      * end of input file
001198191213      ********************
001199191213       begsr #lr;
001200191213      *
001201191213      * print msg if no errors found
001202191213      *
001204191213       if errfound <> 'Y';
001205191213        clear db480fld;
001206191213        Eval  db480fld  = '"' + '** NO ERRORS FOUND **' + ' ' + '",';
001207191213        Write db480xr;
001208191213       endif;
001211191213
001212191213       endsr;
001213050627
0012140503040313 C*
0012150503040164 C*************************************************************
0012160503040164 C*                                                           *
0012170503040164 C* Write Spreadsheet Detail                                  *
0012180503040164 C*                                                           *
0012190503040164 C*************************************************************
001220050304     C     Writexldet    BEGSR
001221121231
001222130102     c                   move      'Y'           errfound
001223160114
001224191212     c                   clear                   db480fld
001225191212     C                   Eval      db480fld  = '"' +
001226130102     C                             %trim(%editw(TSA:'0   -   -    '))    + csv +
001227160114     C                             %Trim(acnamout)                       + csv +
001228191213     C                             %Trim(aaname)                         + csv +
001229130102     C                             %trim(%editw(mbssno:'0   -  -    '))  + csv +
001230130102     C                             %Trim(memname)                        + csv +
001231191211     C                             %Trim(cobra)                          + csv +
001232191212     C                             %trim(mc_planh)                       + csv +
001233191212     C                             %trim(mc_plandh)                      + csv +
001234130102     C                             %trim(%editw(effmdyh:'  /  /    '))   + csv +
001235130102     C                             %trim(%editw(canmdyh:'  /  /    '))   + csv +
001236191213     C                             %trim(errortxt)                       + csv +
001237130102     C                             ' '                                   + '",'
001238050304     C*
001239191212     C                   Write     db480xr
0012400503040320 C                   ENDSR
001241050304     C*
001242050304     C/EJECT
001243050304     C*************************************************************
001244050304     C*                                                           *
001245050304     C* Write Spreadsheet heading                                 *
001246050304     C*                                                           *
001247050304     C*************************************************************
001248050304     C     Writexlhead   BEGSR
001249050304
001250191212     c                   clear                   db480fld
001251191212     C                   Eval      db480fld = '"' + 'ACCOUNT #'          + csv +
001252160114     C                             'ACCOUNT NAME'                        + csv +
001253191213     C                             'AA NAME'                             + csv +
001258160114     C                             'MEMBER SSN'                          + csv +
001259160114     C                             'MEMBER NAME'                         + csv +
001260191211     C                             'COBRA'                               + csv +
001261191212     C                             'MEDICAL PLAN'                        + csv +
001262191212     C                             'DESCRIPTION'                         + csv +
001263191212     C                             'EFFECTIVE'                           + csv +
001264191212     C                             'CANCEL'                              + csv +
001265191213     C                             'ERROR'                               + csv +
001266160114     C                             ' '                                   + '",'
001267191212     C                   Write     db480xr
001268050304     C*
0012690503040320 C                   ENDSR
0012701201190103 C***************************************************
0012711201190104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0012721201190105 C***************************************************
0012731201190107 C*
0012741201190107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0012751201190107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0012761201190107 C*
0012771201190106 C     #DATYM        BEGSR
001278120119     C                   MOVE      @DATIN        @MD               4 0
001279120119     C                   MOVEL     @DATIN        @Y                4 0
001280120119     C                   MOVEL     @MD           @DATOU            8 0
001281120119     C                   MOVE      @Y            @DATOU
001282120119     C                   MOVE      *ZEROS        @DATIN            8 0
0012831201190120 C                   ENDSR
001284120119     C*
001285050302      *******************************************
001286011126     c     *inzsr        begsr
001287050302      *******************************************
001288050304
001289050304     C                   Exsr      Writexlhead
001290050302
001291121231     c     plnkey        klist
001292121231     c                   kfld                    mctrst
001293121231     c                   kfld                    mcsub#
001294121231     c                   kfld                    mcplan
001295121231
001296121231     c     keyacc        klist
001297191212     c                   kfld                    CMTRST
001298191212     c                   kfld                    CSUBDV
001299191212     c                   kfld                    CMACCT
001300121231
001301011126     c                   endsr
