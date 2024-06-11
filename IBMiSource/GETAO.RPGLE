000001110603     H option(*SRCSTMT: *NODEBUGIO)
0001009908180002 F******************************************************************
0002001106030003 F* getao      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009908180004 F*                                                                *
0003019908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0003021106030006 F*            DATE - 06/03/11                                     *
0003039908190007 F*                                                                *
0004001106030013 F*  DESCRIPTION - Get agency override commission amount.          *
0005051106030007 F*               Make sure the files AGCAROV1, SPRAGXR2, SMANRLT  *
0005060710030007 F*               are overridden in the CL that calls the initial  *
0005070710030007 F*               program.                                         *
0005080710030007 F*                                                                *
0009040011070004 F*                parameters to pass:                             *
0009050011070007 F*                -------------------                             *
0009061106090004 F*                1. Relid (8)                                    *
0009071106090004 F*                2. carrier (3)                                  *
0009081106090004 F*                3. market size (5)                              *
0009091106130004 F*                4. effdt of the transaction (8.0) RPEFDT in RPA060WK
0009101106090004 F*                5. commission amount (9.2)                      *
0009111106090004 F*                6. premium (9.2)                                *
0009121106090004 F*                7. member count (7.2)                           *
0009131106030004 F*                8. return - method (2)                          *
0009141106030004 F*                9. return - rate   (7.4)                        *
0009151106030004 F*               10. return - override amount (9.2)               *
0009161106030004 F*               11. return - found  (1)                          *
0009170011070004 F*                                                                *
0009181002180004 F* *** WARNING - Since this program does not set on LR, make      *
0009191002180004 F*               sure any program that calls it closes files      *
0009201106070004 F*               AGCAROV1, SPRAGXR2, SMANRLT or does a rclrsc     *
0009211106070004 F*               close everything.                                *
0009231002180004 F*                                                                *
0010009908180016 F******************************************************************
001001110603     FAGCAROV1  if   e           k Disk
001002110603     FSPRAGXR2  IF   E           K DISK
001003110603     FSMANRLT   IF   E           K DISK
001004110603     D wkagency        s                   like(ACAGNY)
0010051106030153 D  peffymd        s              8  0
002011001107     c     *entry        plist
002012110603     c                   parm                    parmrel           8
002014110603     c                   parm                    parmcar           3
002015110603     c                   parm                    parmmksz          5
002016110609     c                   parm                    parmeffymd        8 0
002017110603     c                   parm                    parmcomamt        9 2
002018110603     c                   parm                    parmprem          9 2
002019110603     c                   parm                    parmmcnt          7 2
002020110603     c                   parm                    parmmethod        2
002021110603     c                   parm                    parmrate          7 4
002022110603     c                   parm                    parmovramt        9 2
002023071001     c                   parm                    parmfound         1
002024001107
002026071002     c                   move      parmeffymd    peffymd
025601071001
025616110603   7 C                   clear                   parmmethod
025617110603   7 C                   clear                   parmrate
025618110603   7 C                   clear                   parmovramt
025619110603   7 C                   clear                   parmfound
025628110603   7
025629110603   2  * GET agency / super agency from relation
025631110603     c                   exsr      #getrel
025632110603   2  * GET agency override
025633110603     c                   exsr      #getovr
025697071001
025698071001   9 C                   return
025800071001
025801110607      ********************************
025802110607      * get SA from relation
025803110607      ********************************
025804110607     C     #getrel       BEGSR
025805110607     c                   clear                   wkagency
025806110607
025807110607     C     parmrel       CHAIN     smanrlt
025808110607     C                   if        %FOUND(SMANRLT)
025809110607     C     SRASID        CHAIN     spragxr2
025810110607     C                   if        %FOUND(SPRAGXR2)
025811110607
025812110607      * ** TEMPORY FIX TO GET CORRECT RATE - 07/03/03
025813110607      * If SA = *NO, or 959  use the agency code to get the override
025814110607      *    ELSE use the Super agency code to get the override
025815110607      *    (the SA i.e. 307 is set up in the agency field becuase all
025816110607      *    agencies in 307 get the override and they did not want to set up
025817110607      *    every agency)
025818110607
025819110607     c                   if        sxsuper = '*NO' or sxsuper = '959'
025820110607     c                   move      sxagcy        wkagency
025821110607     c                   else
025822110607     c                   move      sxsuper       wkagency
025823110607     c                   end
025824110607
025825110607     C                   end
025826110607     C                   end
025827110607
025828110607     C                   ENDSR
025829110607      *
025830110603      ***************************************
025831110603      * get Agency Override
025832110603      ***************************************
025833110603     C     #getovr       BEGSR
025834110603      *
025835110603     C     aokey         Setll     AGCAROV1
025836110603     c                   dou       %eof(agcarov1)
025837110603     C     aokey         Reade     AGCAROV1
025838110603     c                   if        (not %eof(agcarov1)) and (acefdt <> actrdt)
025839110603     c                             and (acefdt <= peffymd) and
025840110603     c                             ((actrdt >= peffymd) or (actrdt = 0))
025841110603     C                   move      'Y'           parmfound
025842110603     c                   exsr      #calcovr
025843110603     c                   leave
025844110603     C                   end
025845110603     C                   Enddo
025846110603
025847110603     C                   ENDSR
025848110603
025866110603      *___________________________________________________________________
025867110603      * Create RPA170WK File
025868110603      *___________________________________________________________________
025869110603     C     #calcovr      BEGSR
025870110603
025871110603      * calculate 1 of 3 overrides
025872110603      * PP = percent of premium
025873110603      * FF = flat fee per contract
025874110603      * PC = percent of commission
025876110603
025877110603     C                   Select
025878110603      * % of prem
025879110603     C                   When      acovpp  <> 0
025880110603     C     acovpp        div       100           wkovpp            7 4
025881110603     C     wkovpp        Mult      parmprem      parmovramt
025882110603     C                   move      'PP'          parmmethod
025883110603     C                   z-add     acovpp        parmrate
025884110603      * flat fee
025885110603     C                   When      acovra  <> 0
025886110603     C     acovra        mult      parmmcnt      parmovramt
025887110603     C                   move      'FF'          parmmethod
025888110603     C                   z-add     acovra        parmrate
025889110603      * % of comm
025890110603     C                   When      acovpc  <> 0
025891110603     C     acovpc        div       100           wkovpc            7 4
025892110603     C     wkovpc        Mult      parmcomamt    parmovramt
025893110603     C                   move      'PC'          parmmethod
025894110603     C                   z-add     acovpc        parmrate
025895110603     C                   Endsl
025896110603      *
025897110603     C                   ENDSR
025898110603      *
025900071001     c     *inzsr        begsr
025901110603     C     aokey         Klist
025902110603     C                   Kfld                    wkagency
025903110603     C                   Kfld                    parmcar
025904110603     C                   Kfld                    parmmksz
0259080710010215
026000071001   9 C                   ENDSR
