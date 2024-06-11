0000031301020002  ******************************************************************
0000041301020003  * db470      GROUP BENEFIT SERVICES, INC.                        *
0000051301020004  *                                                                *
0000061301020005  *            WRITTEN BY - DAVID KETTERMAN                        *
0000071301020006  *            DATE - 12/31/12                                     *
0000081301020007  *                                                                *
0000091601140011  * Plan dependency audit (if primay plan found active, then       *
0000101601140011  * secondary plan must also be active).                           *
0000161301020011  *                                                                *
0000171601140011  * 12/31/12 - look for ASM member who have a medical plan but     *
0000181601140011  *            do not have an HRA plan                             *
0000191601140011  * 01/15/16 - modify design to allow other accounts also with     *
0000201601140011  *            with different plan dependencies.                   *
0000211704030011  * 04/03/17 dlk - add new acct - 590-3-17 CONSOLIDATED WATER PROOFING
0000231704030011  *                and remove ASM.
0000241801300011  * 01/30/18 dlk - convert to use input file db470in instead of hard
0000251801310011  *                coding the accts and plans. Only the exact plan
0000261801310011  *                compare works now, not the plan type which can
0000271801310011  *                be added here later if it is needed again.
0000281912060011  * 12/06/19 dlk - fix lr logic
0000291912120011  * 12/11/19 dlk - add fields and enable plan category type search
0000321601140011  *                                                                *
0000331301020013  ******************************************************************
000034130102
0001011801300005 Fdb470in   ip   e           k disk
0001021801300005 Fmemac#    if   e           k disk
0001030502280005 Fmcov      if   e           k disk
0001041601140005 Faccmst    if   e           k disk
0001060502280018 FPLNMST    IF   e           k DISK
000107050228     Fcodesl1   IF   E           K DISK
000108191211     Fpctmst    IF   E           K DISK
0001091212310017 Fdb470xl   o  a e             DISK
000117050303
0001180503040125 Dcsv              c                   const('","')
0001191212310125 Dmemname          s             30
0001271601140125 Dacnamout         s                   like(acnam1)
0001281912110125 Dpriplnh          s                   like(mcplan)
0001291912110125 DpriplndesM       s                   like(pdescr)
0001301912110125 Dpriplndes        s                   like(pdescr)
0001311912110125 Ddepplndes        s                   like(pdescr)
0001321912120125 Dmcov_cat         s                   like(action)
0001331912110125 Dpritypdes        s             45
0001341912110125 Ddeptypdes        s             45
0001351601140125 Dwkplan1type      s              3
0001361601140125 Dwkplan2type      s              3
0001371601180125 Dfndplan1#        s              1
0001381601140125 Dfndplan2#        s              1
0001391601140125 Dfndplan1type     s              1
0001401601140125 Dfndplan2type     s              1
0001411601140125 Deffmdyh          s              8  0
0001421601140125 Dcanmdyh          s              8  0
0001431301020125 Derrfound         s              1
0001441912110125 Dcobra            s              1
000148121231     D                 dS
0001491212310125 D  tsa                    1     10  0
0001501212310125 D  mbtrst                 1      3  0
0001511212310125 D  mbsub#                 4      6  0
0001521212310125 D  mbacct                 7     10  0
000153050302     D                udS
0001540503030054 D  CONAME               201    240
0001550503030055 D  TIME                 242    247  0
0001560503030157 D  UD8YMD               248    255  0
000162180130
000163180130      * process each active record in the file
000164180130       if d7status = 'A';
000165180130        exsr #main;
000166180130       endif;
000861170403
000862160118      *
000863160118      * after all accounts processed, print msg if no errors found
000864160118      *
000865191206       if *inlr;
000866160114       if     errfound <> 'Y';
000867180130        clear db470fld;
000868180130        Eval  db470fld  = '"' + '** NO ERRORS FOUND **' + ' ' + '",';
000869180130        Write db470xr;
000870160114       endif;
000873191206       endif;
000874121231
000875121231      ********************
000876180130      *main processing
000877121231      ********************
000878180130       begsr #main;
000896180130
000906180130       exsr #clearwkfields;
000907191211
000908191211      * get plan descriptions
000909191211       if    d7pln1# <> *blanks;
0009101912110171   chain (d7trust:d7sub:d7pln1#) plnmst;
000911191211       if    %found(plnmst);
000912191211       priplndes = pdescr;
000913191211       endif;
000914191211       endif;
000915191211
000917191211       if    d7pln2# <> *blanks;
0009181912110171   chain (d7trust:d7sub:d7pln2#) plnmst;
000919191211       if    %found(plnmst);
000920191211       depplndes = pdescr;
000921191211       endif;
000922191211       endif;
000923191211
000924191211      * get category type descriptions
000925191211
000926191211       if    d7pln1type <> *blanks;
0009271912110171   chain (d7pln1type) pctmst;
000928191211       if    %found(plnmst);
000929191211       pritypdes = d7pln1type + ' - ' + pcdes;
000930191211       endif;
000931191211       endif;
000932191211
000933191211       if    d7pln2type <> *blanks;
0009341912110171   chain (d7pln2type) pctmst;
000935191211       if    %found(plnmst);
000936191211       deptypdes = d7pln2type + ' - ' + pcdes;
000937191211       endif;
000938191211       endif;
000942191211
000943180130       exsr #fndmem;
001058180130
001060180130       endsr;
001061121231
001062180130      ********************
001063180130      * find active members
001064180130      ********************
001065180130       begsr #fndmem;
001066180130
001067160114       setll keyacc memac#;
0010681601140131   dou   %eof(memac#);
0010691601140132   reade keyacc memac#;
0010701601140133   if    not %eof(memac#) and termdt = 0;
001071180131      * skip cobra members if include is not 'Y'
001072180131        if    d7incobra <> 'Y' and cexpdt <> 0;
001073160118        iter;
001074160118        endif;
001075191211
001076191211      * show cobra status
001077191211        clear cobra;
001078191211        if cexpdt <> 0;
001079191211        cobra = 'Y';
001080191211        endif;
001081191211
001082160114       exsr  #fndplans;
001083160114       endif;
001084160114       enddo;
001085160114
001086160114       endsr;
001087121231
001088121231      ********************
001089160114      * find active plans
001090121231      ********************
001091160114       begsr #fndplans;
001092191211       clear priplnh;
001093191211       clear priplndesM;
001094160114       clear effmdyh;
001095160114       clear canmdyh;
001096160118       clear fndplan1#;
001097160118       clear fndplan2#;
001098160118       clear fndplan1type;
001099160118       clear fndplan2type;
001100160114
001101160114       setll mbssno mcov;
0011021601140131   dou   %eof(mcov);
0011031601140132   reade mbssno mcov;
0011041601140133   if    %eof(mcov) or (enrldt = candt) or
001105160114             (candt <> 0 and candt <= ud8ymd);
001106160114       iter;
001107160114       endif;
001108160114
001109160114      * get plan
0011101601140171   chain plnkey plnmst;
001111160114       if    not %found(plnmst);
001112160114       iter;
001113160114       endif;
001114160114
001115191212      * get plan category type for this mcov plan
001116191212       clear mcov_cat;
001117160114       chain plncat codesl1;
001118160114       if    not %found(codesl1);
001119160114       iter;
001120160114       endif;
001121191212       mcov_cat = action;
001122121231
001123191212      * select primary plan by plan
001124180130       if   d7pln1#  <> *blanks and d7pln1#  = mcplan;
001125160114       eval fndplan1# = 'Y';
001126160114       exsr #savpln1;
001127160114       endif;
001128160114
001129191212      * select dependency plan by plan
001130180130       if  d7pln2#  <> *blanks and d7pln2#  = mcplan;
001131160114       eval fndplan2# = 'Y';
001132160114       endif;
001133160114
001134191212      * select primary plan by plan category type
001135160118      * hard coded exclusion of plan WAVM which is set up as a medical
001136160118      * plan but it is not a real plan due to a design flaw in OLE
001137191212       if   d7pln1type <> ' ' and mcov_cat = d7pln1type and mcplan <> 'WAVM';
001138160114       eval fndplan1type = 'Y';
001139160114       exsr #savpln1;
001140160114       endif;
001141160114
001142191212      * select dependency plan by plan category type
001143160118      * hard coded exclusion of plan WAVM which is set up as a medical
001144160118      * plan but it is not a real plan due to a design flaw in OLE
001145191212       if   d7pln2type <> ' ' and mcov_cat = d7pln2type and mcplan <> 'WAVM';
001147160114       eval fndplan2type = 'Y';
001148160114       endif;
001149160114
001150160114       enddo;
001151160114
001152160114      * if the primary plan is found (by # or type) but the secondary
001153160114      * plan is not found then write to spreadsheet as error
001154160114
001155160114       if   (fndplan1# = 'Y' or  fndplan1type = 'Y') and
001156160114            (fndplan2# = ' ' and fndplan2type = ' ');
001157160114       exsr writexldet;
001158160114       endif;
001159160114
001160160114       endsr;
001161160114
001162160114      ********************
001163160114      * save plan 1 fields for report use
001164160114      ********************
001165160114     c     #savpln1      begsr
001166191211     c                   movel     mcplan        priplnh
001167191211     c                   movel     pdescr        priplndesM
001168130102     C                   MOVE      enrldt        @DATIN
001169130102     C                   EXSR      #DATYM
001170160114     C                   MOVE      @DATOU        effmdyh
001171130102     C                   MOVE      candt         @DATIN
001172130102     C                   EXSR      #DATYM
001173160114     C                   MOVE      @DATOU        canmdyh
001174160114     c                   endsr
001175050228
001176160114      ********************
001177160114      * clear work fields
001178160114      ********************
001179160114       begsr #clearwkfields;
001180160114
001181160114       clear wkplan1type;
001182160114       clear wkplan2type;
001183160114       clear fndplan1#;
001184160114       clear fndplan2#;
001185160114       clear fndplan1type;
001186160114       clear fndplan2type;
001187191211       clear priplndes;
001188191211       clear depplndes;
001189191211       clear pritypdes;
001190191211       clear deptypdes;
001191160114
001192160114       endsr;
001193160114
001194050627
0011950503040313 C*
0011960503040164 C*************************************************************
0011970503040164 C*                                                           *
0011980503040164 C* Write Spreadsheet Detail                                  *
0011990503040164 C*                                                           *
0012000503040164 C*************************************************************
001201050304     C     Writexldet    BEGSR
001202121231
001203121231     c                   clear                   memname
001204121231     c     mfname        cat       mlname:1      memname
001205130102
001206130102     c                   move      'Y'           errfound
001207160114
0012081601140313  * get account name
001209160114       clear acnamout;
0012101601140171   chain (mbtrst:mbsub#:mbacct) accmst;
001211160114       if    %found(accmst);
001212160114       eval  acnamout = acnam1;
001213160114       endif;
001214050304
001215121231     c                   clear                   db470fld
001216121231     C                   Eval      db470fld  = '"' +
001217130102     C                             %trim(%editw(TSA:'0   -   -    '))    + csv +
001218160114     C                             %Trim(acnamout)                       + csv +
001219180130     C                             %Trim(d7pln1# )                       + csv +
001220191211     C                             %Trim(priplndes)                      + csv +
001221191211     C                             %Trim(pritypdes)                      + csv +
001222180130     C                             %Trim(d7pln2# )                       + csv +
001223191211     C                             %Trim(depplndes)                      + csv +
001224191211     C                             %Trim(deptypdes)                      + csv +
001225191211     C                             %Trim(d7note)                         + csv +
001226130102     C                             %trim(%editw(mbssno:'0   -  -    '))  + csv +
001227130102     C                             %Trim(memname)                        + csv +
001228191211     C                             %Trim(cobra)                          + csv +
001229191211     C                             %trim(priplnh)                        + csv +
001230191211     C                             %trim(priplndesM)                     + csv +
001231130102     C                             %trim(%editw(effmdyh:'  /  /    '))   + csv +
001232130102     C                             %trim(%editw(canmdyh:'  /  /    '))   + csv +
001233130102     C                             ' '                                   + '",'
001234050304     C*
001235121231     C                   Write     db470xr
0012360503040320 C                   ENDSR
001237050304     C*
001238050304     C/EJECT
001239050304     C*************************************************************
001240050304     C*                                                           *
001241050304     C* Write Spreadsheet heading                                 *
001242050304     C*                                                           *
001243050304     C*************************************************************
001244050304     C     Writexlhead   BEGSR
001245050304
001246121231     c                   clear                   db470fld
001247130102     C                   Eval      db470fld = '"' + 'ACCOUNT #'          + csv +
001248160114     C                             'ACCOUNT NAME'                        + csv +
001249191211     C                             'PRIMARY PLAN'                        + csv +
001250191211     C                             'PRIMARY PLAN DESCRIPTION'            + csv +
001251160118     C                             'PRIMARY TYPE'                        + csv +
001252191211     C                             'DEPENDENCY PLAN'                     + csv +
001253191211     C                             'DEPENDENCY PLAN DESCRIPTION'         + csv +
001254160118     C                             'DEPENDENCY TYPE'                     + csv +
001255191211     C                             'NOTE'                                + csv +
001256160114     C                             'MEMBER SSN'                          + csv +
001257160114     C                             'MEMBER NAME'                         + csv +
001258191211     C                             'COBRA'                               + csv +
001259191211     C                             'MEMBER PLAN'                         + csv +
001260160114     C                             'PLAN DESCRIPTION'                    + csv +
001261160114     C                             'EFF DATE'                            + csv +
001262160114     C                             'CANCEL DATE'                         + csv +
001263160114     C                             ' '                                   + '",'
001264121231     C                   Write     db470xr
001265050304     C*
0012660503040320 C                   ENDSR
0012671201190103 C***************************************************
0012681201190104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0012691201190105 C***************************************************
0012701201190107 C*
0012711201190107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0012721201190107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0012731201190107 C*
0012741201190106 C     #DATYM        BEGSR
001275120119     C                   MOVE      @DATIN        @MD               4 0
001276120119     C                   MOVEL     @DATIN        @Y                4 0
001277120119     C                   MOVEL     @MD           @DATOU            8 0
001278120119     C                   MOVE      @Y            @DATOU
001279120119     C                   MOVE      *ZEROS        @DATIN            8 0
0012801201190120 C                   ENDSR
001281120119     C*
001282050302      *******************************************
001283011126     c     *inzsr        begsr
001284050302      *******************************************
001285050304
001286050304     C                   Exsr      Writexlhead
001287050302
001288121231     c     plnkey        klist
001289121231     c                   kfld                    mctrst
001290121231     c                   kfld                    mcsub#
001291121231     c                   kfld                    mcplan
001292121231
001293121231     c     keyacc        klist
001294180130     c                   kfld                    D7TRUST
001295180130     c                   kfld                    D7SUB
001296180130     c                   kfld                    D7ACC
001297121231
001298011126     c                   endsr
