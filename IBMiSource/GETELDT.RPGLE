000001110603     H option(*SRCSTMT: *NODEBUGIO)
0001009908180002 F******************************************************************
0002001307120003 F* geteldt    GROUP BENEFIT SERVICES SOFTWARE                     *
0003009908180004 F*                                                                *
0003019908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0003021307120006 F*            DATE - 07/12/13                                     *
0003039908190007 F*                                                                *
0004001307120013 F*  DESCRIPTION - Get the date a member would be initially        *
0005051307120007 F*                eligible for coverage considering the waiting   *
0005081307120007 F*                period of the plan.                             *
0005091307120007 F*                                                                *
0009040011070004 F*                parameters to pass:                             *
0009050011070007 F*                -------------------                             *
0009061307110004 F*                1. Trust/sub/plan (10)                          *
0009081307120004 F*                2. Date of hire - YYYYMMDD (8)                  *
0009141307120004 F*                3. Return - date eligible - YYYYMMDD (8)        *
0009151307120004 F*                4. Return - error indicator (1)                 *
0009180011070004 F*                                                                *
0009231002180004 F*                                                                *
0010009908180016 F******************************************************************
001001130711     Fplnauxp   if   e           k Disk
0010021307120037 D workdt          S               d   datfmt(*iso)
0010031307120037 D workday         S              2  0
0010041307120037 D datymdnum       S              8  0
0010051307120037 D pdoh            S              8  0
001006130711     d tsp             ds
0010071307110153 D  t                      1      3  0
0010081307110153 D  s                      4      6  0
0010091307110153 D  p                      7     10
002011001107     c     *entry        plist
002012130711     c                   parm                    parmtsp          10
002015130712     c                   parm                    parmdoh           8
002016130712     c                   parm                    parmdatelout      8
002017130712     c                   parm                    parmerror         1
002024001107
025618130712     c                   move      parmtsp       tsp
025619130712     c                   move      parmdoh       pdoh
025620130712     c                   clear                   parmerror
025621130712
025622130712      * valid date of hire?
025698130712     c     *iso          test(de)                pdoh
025699130712     c                   if        %error
025700130712     c                   move      'E'           parmerror
025701130712     C                   goto      #end
025702130712     c                   end
025703130712
025704130712      * defalut to zero waiting period so DOH is the date eligible in case
025705130712      * no waiting period is available
025706130712     c                   move      pdoh          parmdatelout
025707130712
025709130712      *********************************************************************
025710130712      * waiting period codes:
025711130712      *
025712130712      *  WDH = DOH + X days
025713130712      *        example: 7/15 + 10 days = 7/25
025714130712      *  WFF = DOH + (X days -1)
025715130712      *        example: 7/15 + (10 days - 1) = 7/24
025716130712      *  WFM = First of month following DOH + X days
025717130712      *        example: 7/15 + 10 days = 7/25 then advance to 8/1
025718130712      *                 7/2  + 30 days = 8/1 but 8/1 is still the result
025719130712      *
025720130712      *********************************************************************
025721130712      *
025722130712     c     tspkey        chain     plnauxp
025723130712     c                   if        %found(plnauxp) and pxwtpd <> *blanks
025724130712
025725130712     c                   move      pdoh          workdt
025726130712
025727130712     c                   select
025728130712      *************
025729130712      *  WDH = DOH + X days
025730130712      *************
025731130712     c                   when      pxwtpd = 'WDH'
025732130712     C                   adddur    pxwtdy:*d     workdt
025734130712      *************
025735130712      *  WFF = DOH + (X days -1)
025736130712      *************
025737130712     c                   when      pxwtpd = 'WFF'
025741130712     C                   adddur    pxwtdy:*d     workdt
025742130712      * days must be > 0
025743130712     c                   if        pxwtdy > 0
025744130712     C                   subdur    1:*d          workdt
025745130712     c                   end
025746130712      *************
025747130712      *  WFM = First of month following DOH + X days
025748130712      *************
025749130712     c                   when      pxwtpd = 'WFM'
025750130712     C                   adddur    pxwtdy:*d     workdt
025751130712     c                   extrct    workdt:*d     workday
025752130712     c                   if        workday <> 01
025754130712     c                   adddur    1:*m          workdt
025755130712     c                   move      workdt        datymdnum
025756130712     c                   move      01            datymdnum
025757130712     c                   move      datymdnum     workdt
025758130712     c                   end
025759130712
025760130712      * error - missing code
025761130712     c                   other
025762130712     c                   move      'E'           parmerror
025763130712     c                   endsl
025764130712
025765130712     c                   if        parmerror <> 'E'
025767130712     c                   eval      parmdatelout = %char(%dec(workdt:*ISO))
025768130712     c                   end
025769130712
025770130712     c                   end
025771130712
025772130712     c     #end          tag
025773130712   9 C**                 return
025774130712   9 C                   eval      *inlr = *on
025800071001
025898110603      *
025900071001     c     *inzsr        begsr
025901130712     C     tspkey        Klist
025902130711     C                   Kfld                    t
025903130711     C                   Kfld                    s
025904130711     C                   Kfld                    p
0259080710010215
026000071001   9 C                   ENDSR
