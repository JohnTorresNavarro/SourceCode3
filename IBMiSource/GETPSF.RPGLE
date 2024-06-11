000001110603     H option(*SRCSTMT: *NODEBUGIO)
0001009908180002 F******************************************************************
0002001902010003 F* GETPSF     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009908180004 F*                                                                *
0003019908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0003021902010006 F*            DATE - 02/01/19                                     *
0003039908190007 F*                                                                *
0004001902010013 F*  DESCRIPTION - Determine if the account is subject to the Care *
0005051902130007 F*                First Producer Service Fee rules for the date   *
0005081902130007 F*                selected and if they have a PSF or BSF active.  *
0005091902130007 F*                PSF = Care First pays the commission,           *
0005101902130007 F*                BSF = GBS pays the commission directly to the   *
0005111902130007 F*                broker                                          *
0005131902130007 F*                                                                *
0009040011070004 F*                parameters to pass:                             *
0009050011070007 F*                -------------------                             *
0009061902010004 F*                1. Trust/sub/acct (10)                          *
0009081902010004 F*                2. Effective date - YYYYMMDD (8)                *
0009151902130004 F*                3. Return - PSF Eligible (Y or N)               *
0009161902130004 F*                4. Return - PSF type: P=PSF, B=BSF              *
0009180011070004 F*                                                                *
0009191902010004  *  * Make sure the files used in this program are overridden to  *
0009201902010004  *    F. in the program that calls it or call GETPSFCL that       *
0009211902010004  *    already has the overrides and reclaim resources in it       *
0009221902070004  *    (calling GETPSFCL is best).                                 *
0009231902010004  *                                                                *
0009241902120035  *  ** This progam is used in RP170, RPF090R, RPF095R,            *
0009261902010004  *                                                                *
0009271902010004  *                                                                *
0010009908180016 F******************************************************************
0010021902010029 Fcmct14    IF   E           K DISK
0010031902010029 Fplnmst    IF   E           K DISK
0010041902010029 Fcodes     IF   E           K DISK
0010051902010029 Fcarmst    IF   E           K DISK
001006190201     Fmktcara1  if   e           k disk
0010071307120037 D workdt          S               d   datfmt(*iso)
0010101902010037 D peffymd         S              8  0
0010111902130037 D psforbsf        S              1
0010121902130037 D psfelig         S              1
0010131902130037 D psftype         S              1
0010161902010037 D keytype         S                   like(type)
0010171902010037 D keycode         S                   like(code)
001018190201     d tsa             ds
0010191307110153 D  t                      1      3  0
0010201307110153 D  s                      4      6  0
0010211902010153 D  a                      7     10  0
002011001107     c     *entry        plist
002012190201     c                   parm                    parmtsa          10
002015190201     c                   parm                    parmeff           8
002017190213     c                   parm                    parmelig          1
002018190213     c                   parm                    parmtype          1
002024001107
025618190201     c                   move      parmtsa       tsa
025619190201     c                   move      parmeff       peffymd
025621130712
025622190201      * valid date? if not skip and return a blank for the Yes/No field
025698190201     c     *iso          test(de)                peffymd
025699130712     c                   if        %error
025700190213     c                   clear                   parmelig
025701190213     c                   clear                   parmtype
025702130712     C                   goto      #end
025703130712     c                   end
025704190201
025705190201     c                   exsr      #chkmksz
025706190213     c                   move      psfelig       parmelig
025707190213     c                   move      psftype       parmtype
025708190201
025709190201     c     #end          tag
025710190201   9 C**                 return
025711190201   9 C                   eval      *inlr = *on
025712130712
025713190201      *********************************************************************
025714190213      * Check this accounts Care First MED or RX market size which
025715190213      * determins who is subject the to psf rules, and if they have a
025716190213      * PSF or BSF set up.
025717190201      *********************************************************************
025718190201   9 c     #chkmksz      begsr
025719190213     c                   eval      psfelig  = 'N'
025720190213     c                   eval      psftype  = *blank
025723190201
025724190201      * get active commission control
025725190201     C     tsakey        setll     cmct14
025726190201     c                   dou       %eof(cmct14)
025727190201     C     tsakey        reade     cmct14
025728190201     c                   if        (not %eof(cmct14)) and (effdat <= peffymd)
025729190201     c                             and (cmcan = 0 or cmcan > peffymd)
025730190201      *
0257311902010400 C     plnkey        CHAIN     PLNMST
0257321902010400 C                   if        %found(plnmst)
025733190213
025734190213      * identify carriers used for psf and bsf
025735190213     c                   select
025736190213     c                   when      pcarr = 'PSM' or pcarr = 'PSX'
025737190213     c                   eval      psftype = 'P'
025738190213     c                   when      pcarr = 'BSF'
025739190213     c                   eval      psftype = 'B'
025740190213     c                   endsl
025741190213
0257421902130402  * Does acct have CF medical and RX category type plans active?
025743190201     c                   movel     plncat        keytype
025744190201     c                   move      plncat        keycode
0257451902010404 C     codkey        chain     codes
025746190201     c                   if        %found(codes) and
025747190201     c                             (action = 'M' or action = 'R')
0257481902010402  * only select Care First carriers
0257491902010400 C     pcarr         CHAIN     carmst
0257501902010400 C                   if        %found(carmst) and carbc = 'D'
025751190201      * get market size, over 50 is subject to the PSF
025752190201     c                   exsr      #mksz
025753190201     c                   if        bcmksz <> '1    ' and bcmksz <> '50   '
025754190213     c                   eval      psfelig    = 'Y'
025755190201     c                   end
025756190201     c                   end
025757190201     c                   end
025758190201     c                   end
025759190201
025760190201     c                   end
025761190201     c                   enddo
025773190201
025774190201   9 c                   endsr
025775130712
025776190201     c*********************************************
025777190201     c* get market size for this account/carrier  *
025778190201     c*********************************************
025779190201     c     #mksz         begsr
025780190201     c* defalut to 50 for comm sched 2, and 1 for comm sched 1
025781190201     c                   if        comsch = '2'
025782190201     c                   movel     '50   '       bcmksz            5
025783190201     c                   else
025784190201     c                   movel     '1    '       bcmksz
025785190201     c                   end
025786190201
025787190201     c     mkcaky        setll     mktcara1
025788190201     C                   dou       %eof(mktcara1)
025789190201     c     mkcaky        reade     mktcara1
025790190201     c                   if        (not %eof(mktcara1)) and (mafrdt <= peffymd)
025791190201     c                             and (matodt = 0 or matodt > peffymd)
025792190201     c                   movel     maszcd        bcmksz
025793190201     c                   leave
025794190201     c                   endif
025795190201     c                   enddo
025796190201
025797190201     c                   endsr
025898110603      *
025900071001     c     *inzsr        begsr
025901190201     C     tsakey        Klist
025902130711     C                   Kfld                    t
025903130711     C                   Kfld                    s
025904190201     C                   Kfld                    a
025913190201
025914190201     c     mkcaky        klist
025915190201     C                   Kfld                    t
025916190201     C                   Kfld                    s
025917190201     C                   Kfld                    a
025921190201     C                   KFLD                    pcarr
025922190201
025923190201     c     plnkey        klist
025924190201     C                   Kfld                    t
025925190201     C                   Kfld                    s
025927190201     C                   KFLD                    cmplan
025928190201
025929190201     c     codkey        klist
025930190201     C                   Kfld                    keytype
025931190201     C                   Kfld                    keycode
025932190201
026000071001   9 C                   ENDSR
