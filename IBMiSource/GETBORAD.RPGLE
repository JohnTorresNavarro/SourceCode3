000001110603     H option(*SRCSTMT: *NODEBUGIO)
0001009908180002 F******************************************************************
0002001307150003 F* getborad   GROUP BENEFIT SERVICES SOFTWARE                     *
0003009908180004 F*                                                                *
0003019908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0003021307150006 F*            DATE - 07/15/13                                     *
0003039908190007 F*                                                                *
0004001307150013 F*  DESCRIPTION - Get the date to use in calculating a members    *
0005051307150007 F*                age band when the account is a BOR acct and     *
0005081307150007 F*                the plan is a RENEWAL based plan. This program  *
0005101307150007 F*                must only be called when the plan is a RENEWAL  *
0005111307150007 F*                based plan!                                     *
0005121307170007 F*                This program is called from FM070,TR050,DB020,  *
0005131307170007 F*                UTL170,UTL175.                                  *
0005141307150007 F*                                                                *
0009040011070004 F*                parameters to pass:                             *
0009050011070007 F*                -------------------                             *
0009061307110004 F*                1. Trust/sub/plan (10)                          *
0009081307150004 F*                2. Effective date of coverage - YYYYMMDD (8)    *
0009091307150004 F*                3. Date of hire - YYYYMMDD (8)                  *
0009141307150004 F*                4. Return - age calc date - YYYYMMDD (8)        *
0009151307170004 F*                5. Return - what date was used - (2)            *
0009161307170004 F*                6. Return - error (1)                           *
0009180011070004 F*                                                                *
0009231002180004 F*                                                                *
0010009908180016 F******************************************************************
001001130711     Fplnauxp   if   e           k Disk
0010021307120037 D workdt          S               d   datfmt(*iso)
0010031307120037 D workday         S              2  0
001004130715     D pxborlrd_1yr    S              8s 0
0010051307120037 D datymdnum       S              8  0
0010061307120037 D pdoh            S              8  0
0010071307150037 D peffdt          S              8  0
001008130711     d tsp             ds
0010091307110153 D  t                      1      3  0
0010101307110153 D  s                      4      6  0
0010111307110153 D  p                      7     10
002011001107     c     *entry        plist
002012130711     c                   parm                    parmtsp          10
002015130715     c                   parm                    parmeffdt         8
002016130715     c                   parm                    parmdoh           8
002017130715     c                   parm                    parmdatout        8            age calc date out
002018130717     c                   parm                    parmwhatdatout    2
002019130717     c                   parm                    parmerror         1
002024001107
025618130712     c                   move      parmtsp       tsp
025619130712     c                   move      parmdoh       pdoh
025620130715     c                   move      parmeffdt     peffdt
025622130717     c                   clear                   parmwhatdatout
025623130717     c                   clear                   parmerror
025626130712
025627130712      * valid date of hire?
025698130712     c     *iso          test(de)                pdoh
025699130712     c                   if        %error
025700130712     c                   move      'E'           parmerror
025701130712     C                   goto      #end
025702130712     c                   end
025703130712
025704130715      * valid effdt of coverage?
025705130715     c     *iso          test(de)                peffdt
025706130715     c                   if        %error
025707130715     c                   move      'E'           parmerror
025708130715     C                   goto      #end
025709130715     c                   end
025710130715
025711130715      * the coverage effective date that was passed to this program is
025712130715      * the default date to return back
025713130715     c                   move      peffdt        parmdatout
025714130717     c                   move      'CE'          parmwhatdatout
025715130712
025716130715      * BOR age calc date OVERRIDE for RENEWAL BASED PLANS ONLY!
025717130715      * --------------------------------------------------------
025718130715      * If the plan is a BOR transfer and the effective date of coverage
025719130715      * is within 1 year of last BOR renewal then check the members Initial
025720130715      * Eligibility Date (IED):
025721130715      * -When the IED is < the BOR last renewal date then use the BOR last
025722130715      *  renewal date to calcualte the age instead of the effdt of coverage.
025723130715      * -When the IED is >= the BOR last renewal date and < the BOR
025724130715      *  effective date then use the IED to calcualte the age instead of the
025725130715      *  effdt of coverage.
025726130715      * -When the IED is >= the BOR effective date (all other cases) no
025727130715      *  override is needed since the correct date will be the coveage
025728130715      *  effective date that was passed to this program and already used
025729130715      *  as the default date.
025730130715      *
025731130715     c     tspkey        chain     plnauxp
025732130715     c                   if        %found(plnauxp) and pxborlrd <> 0
025733130715     c                   move      pxborlrd      workdt
025734130715     c                   adddur    1:*y          workdt
025735130715     c                   move      workdt        pxborlrd_1yr
025736130715      * is effdt within 1 year of last renewal?
025737130715     c                   if        (peffdt > pxborlrd) and
025738130715     c                             (peffdt < pxborlrd_1yr)
025739130715
025740130715      * get the Initial Elegibility Date (IED)
025741130715     c                   clear                   geteldt_tsp      10
025742130715     c                   move      parmtsp       geteldt_tsp
025743130715     c                   move      pdoh          geteldt_empdt     8
025744130715     c                   clear                   geteldt_IED       8
025745130715     c                   clear                   geteldt_error     1
025746130715     c                   call      'GETELDT'
025747130717     c                   parm                    geteldt_tsp
025748130715     c                   parm                    geteldt_empdt
025749130715     c                   parm                    geteldt_IED
025750130715     c                   parm                    geteldt_error
025751130715
025752130715      * if no error returned from geteldt then check for override needed
025753130715     c                   if        geteldt_error = *blank
025754130715     c                   move      geteldt_IED   IEDwk             8 0
025755130715     c                   select
025756130715
025757130715      * If IED is < bor last renew then use last renew dt
025758130715     c                   when      IEDwk < pxborlrd
025759130715     c                   move      pxborlrd      parmdatout
025760130717     c                   move      'LR'          parmwhatdatout
025761130715
025762130715      * If IED is >= bor last renew and < bor effdt then use IED
025763130715     c                   when      IEDwk >= pxborlrd and IEDwk < pxborefd
025764130715     c                   move      IEDwk         parmdatout
025765130717     c                   move      'IE'          parmwhatdatout
025766130715
025767130715      * all other cases (IED >= bor effdt) use the coverage effdt so no
025768130715      * override date will be filled here since the coverage effective
025769130715      * date is already the default date to pass back in parmdatout
025770130715     c                   other
025771130715      *
025772130715     c                   endsl
025773130715     c                   end
025774130715
025775130715     c                   end
025776130715     c                   end
025777130715
025778130715
025786130712     c     #end          tag
025787130712   9 C**                 return
025788130712   9 C                   eval      *inlr = *on
025800071001
025898110603      *
025900071001     c     *inzsr        begsr
025901130712     C     tspkey        Klist
025902130711     C                   Kfld                    t
025903130711     C                   Kfld                    s
025904130711     C                   Kfld                    p
0259080710010215
026000071001   9 C                   ENDSR
