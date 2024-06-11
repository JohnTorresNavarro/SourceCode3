000100010111      ******************************************************************
000200050823      * RPA060N2   GROUP BENEFIT SERVICES, INC.
000300010111      *
000400050823      *            David Ketterman
000500050823      *            08/23/2005
000600010111      *
000700050823      * This program updates BCREC for Commission, Admin Fee and Bonus
000800050826      * draw in the remittance.
001000010111      *
001001061013      * 05/18/06 dlk - Add admin fee & bonus draw override
001002061013      * 10/12/06 DLK - Increase field size of W9CMAM & W9GLOB to 17.8
001003061013      *                (and all fields defined LIKE)
001004080110      * 01/10/08 DLK - change run type to run seq for documentation only
001005081016      * 10/16/08 DLK - change input file to rpa069l1 (lf by dt/seq)
0010060901020015  * 01/02/09 dlk - broker com is now stored by date range, find    *
0010070901020035  *                by effdt of trans. Also enable flat fee on      *
0010080901040035  *                bonus draw and bonus draw override.             *
0010091612150015  * 12/15/16 dlk - add admin fee method and bonus draw method to
0010151612150035  *                bcrec update (new GPR requirement)
0010161701250015  * 01/25/17 dlk - add error report if chain to bcrec fails
0010171705220015  * 05/22/17 dlk - add check for no records in input file so error
0010181705220035  *                report does not go out incorrectly when chain to
0010191705220035  *                bcrec fails with blank dt/seq #.
0010201705220035  *                                                                *
0010211002230035  *  ** any changes to the calculations must also be made in       *
001805100223      *     RPA401 (Unpaid remittance report)                          *
001806090902      *
001807090902      *
001900010111      ******************************************************************
002000010111
002100081016     FRPA069L1  ip   e           k DISK
002200010125     FADMNFEE1  IF   E           K DISK
002300010125     FBONUSDR1  IF   E           K DISK
002400010125     FBCREC1    UF   E           K DISK
0030001701250017 Frpa060n2p O    F  132        PRINTER OFLIND(*INOF)
003001050823
0048010508230133 Dwkfee            s                   like(bcfchg)
0048021612150133 Dwkfeemth         s                   like(bcfmth)
0048030508230133 Dwkbdchg          s                   like(bcdchg)
0048041612150133 Dwkbdmth          s                   like(bcdmth)
0048050509010133 Dtotcom           s                   like(w9cmam)
0048061008090133 Dtotfee           s                   like(BCFCHG)
0048071008090133 Dtotbdchg         s                   like(BCdCHG)
0048080508230133 Dwkpct            s              7  6
0048091008100133 Dwkprem           s             17  8
0048100605180133 Dworkafff         s                   like(affee)
0048110605180133 Dworkafpp         s                   like(affeepp)
0048120605180133 Dworkafpc         s                   like(affeepc)
0048130605180133 Dworkbdff         s                   like(bdovra)
0048140605180133 Dworkbdpp         s                   like(bdovpp)
0048150605180133 Dworkbdpc         s                   like(bdovpc)
0048161008100133 Dwkbcfpct         s                   like(bcfpct)
0048171008100133 Dwkbcdpct         s                   like(bcdpct)
0048181008100133 Dwksplitpct       s              7  6
009400970918     D                UDS
009500980929     D  RUNDAT                 1      8  0
009600980929     D  RUNMM                  1      2  0
009700980929     D  RUNDD                  3      4  0
009800980929     D  RUNYY                  5      8  0
009900080110     D  RUNseq                21     22                                         'L' = Late Pay Run
010000970917     D  CONAME               201    240
010001050823     Irpa069r
010002050823     I                                          w9dtsq        L1
010003050823
010004050823     c                   if        *inl1
010005050823     c                   clear                   totcom
010006100809     c                   clear                   totfee
010008100810     c                   clear                   wkbcfpct
010009100810     c                   clear                   wkfee
010010161215     c                   clear                   wkfeemth
010011100810     c                   clear                   totbdchg
010012100810     c                   clear                   wkbcdpct
010013100810     c                   clear                   wkbdchg
010014161215     c                   clear                   wkbdmth
010015100810     c                   clear                   wkprem
010016050823     c                   end
010017170522
010018170522     c                   move      'Y'           onerec            1
010019050823
010020100810      * calcualte and accumulate comm, Admin Fee & Bonus Draw amts
010021100810      * on every record since there are multiple
010022050823      * rpa069wk records (with the same w9dtsq) for a single BCREC
010023050823      * record due to split commissions.
010024050823
010025100809     C                   exsr      #detail
010026050823
010027170522      * Get BCREC to update amounts for carrier remittance if at least one
010028170522      * record was in the input file
010029170522     cl1                 if        onerec = 'Y'
031700050823     Cl1                 exsr      #l1
031701170522     cl1                 end
032201050819
032202050819      *******************************************
032203100809      * Calc and accumulate commission, Admin fee and bonus draw
032204050819      *******************************************
032205100809     c     #detail       begsr
032206100809
032207100817      * accumulate salesman commission (will be zero for w9ccpnc = 'P')
032208100809     c                   add       w9cmam        totcom
032209100810
032212100810      * create premium work field - reduce total premium by split (if used)
032214100810     c                   z-add     w9prem        wkprem
032215100810     c                   clear                   wksplitpct
032216100810     c                   if        w9pspl <> 0
032217100810     c     w9pspl        div       100           wksplitpct
032218100810     c                   mult      wksplitpct    wkprem
032219100810     c                   end
032220100810      ****
032221100810      * skip the AF & BD calc when pay no comm from comctx = 'N'
032222100817      *  8/17/10 - pay no commission records (N) have been eliminated from
032223100817      *            rpa069wk. But, w9ccpnc = 'P' are still included so they
032224100817      *            can calc the admin fee and bonus draw in the remittance
032225100817      *            and show the premium & mcnt in the sman commission
032226100817      ****
032227100817     c**                 if        w9ccpnc = 'N'
032228100817     c**                 leavesr
032229100817     c**                 end
032230100810      ****
032231100810      * Calc Admin Fee
032232100810      ****
032233100810     c                   clear                   workafff
032234100810     c                   clear                   workafpp
032235100810     c                   clear                   workafpc
032236100810
032237100810      * override
032238100810     c                   if        w9afovff <> 0 or w9afovpp <> 0 or
032239100810     c                             w9afovpc <> 0
032240100810     c                   z-add     w9afovff      workafff
032241100810     c                   z-add     w9afovpp      workafpp
032242100810     c                   z-add     w9afovpc      workafpc
032243100810
032244100810      * 999.99 = override to 0
032245100810     c                   if        workafff = 999.99
032246100810     c                   eval      workafff = *zeros
032247100810     c                   end
032248100810     c                   if        workafpp = 999.9999
032249100810     c                   eval      workafpp = *zeros
032250100810     c                   end
032251100810     c                   if        workafpc = 999.9999
032252100810     c                   eval      workafpc = *zeros
032253100810     c                   end
032254100810
032255100810
032256100810     c                   exsr      #calcaf
032257100810
032258100810      * no override
032259100810     c                   else
032260100810
032261100810     c* 01/02/09 - use effdt of trans to find admin fee
032263161215     c                   clear                   foundadmf         1
032264100810     c     afkey         setll     admnfee1
032265100810     c                   dou       %eof(admnfee1)
032266100810     c     afkey         reade     admnfee1
032267100810     C                   if        (not %eof(admnfee1)) and
032268100810     C                             (affromdt <> aftodate) and
032269100810     c                             ((affromdt <= w9efdt and aftodate >= w9efdt)
032270100810     c                               or (affromdt <= w9efdt and aftodate = 0))
032271100810     c                   eval      foundadmf = 'Y'
032272100810     c                   leave
032273100810     c                   end
032274100810     c                   enddo
032275100810
032276100810     c                   if        foundadmf  = 'Y'
032277100810     c                   z-add     affee         workafff
032278100810     c                   z-add     affeepp       workafpp
032279100810     c                   z-add     affeepc       workafpc
032280100810     c                   exsr      #calcaf
032281100810     c                   else
032282100810      * error - missing admin fee
032283100810     c                   if        firste <> 'Y'
032284100810     c                   except    head
032285100810     c                   move      'Y'           firste            1
032286100810     c                   end
032287100810     c   of              except    head
032288100810     c                   except    error1
032289100810     c                   end
032290100810     c                   end
032291100810
032292100810      ****
032293100810      * Calc Bonus Draw Charge for remittance
032294100810      ****
032295100810     c                   clear                   workbdff
032296100810     c                   clear                   workbdpp
032297100810     c                   clear                   workbdpc
032298100810      * override
032299100810     c                   if        w9bdovpp <> 0 or w9bdovpc <> 0
032300100810     c                             or w9bdovff <> 0
032301100810     c                   z-add     w9bdovff      workbdff
032302100810     c                   z-add     w9bdovpp      workbdpp
032303100810     c                   z-add     w9bdovpc      workbdpc
032304100810
032305100810      * 999.99 = override to 0
032306100810      * flat fee
032307100810     c                   if        workbdff = 999.99
032308100810     c                   eval      workbdff = *zeros
032309100810     c                   end
032310100810     c                   if        workbdpp = 999.9999
032311100810     c                   eval      workbdpp = *zeros
032312100810     c                   end
032313100810     c                   if        workbdpc = 999.9999
032314100810     c                   eval      workbdpc = *zeros
032315100810     c                   end
032316100810
032317100810     c                   exsr      #calcbd
032318100810     c                   else
032319100810
032320100810      * get bonus draw
032321100810     c* 01/02/09 - use effdt of trans to find admin fee
032322100810     c                   clear                   foundbd           1
032323100810     c     afkey         setll     bonusdr1
032324100810     C                   dou       %eof(bonusdr1)
032325100810     c     afkey         reade     bonusdr1
032326100810     C                   if        (not %eof(bonusdr1)) and
032327100810     c                             ((bdfrdt <= w9efdt and bdtodt >= w9efdt) or
032328100810     c                             (bdfrdt <= w9efdt and bdtodt = 0))
032329100810     c                   eval      foundbd = 'Y'
032330100810     c                   leave
032331100810     c                   endif
032332100810     c                   enddo
032333100810
032334100810      *********
032335100810      * error - missing bonus draw
032336100810     c                   if        foundbd <> 'Y'
032337100810     c                   if        firste <> 'Y'
032338100810     c                   except    head
032339100810     c                   move      'Y'           firste            1
032340100810     c                   end
032341100810     c   of              except    head
032342100810     c                   except    error2
032343100810     c                   leavesr
032344100810     c                   end
032345100810
032346100810     c                   z-add     bdovra        workbdff
032347100810     c                   z-add     bdovpp        workbdpp
032348100810     c                   z-add     bdovpc        workbdpc
032349100810     c                   exsr      #calcbd
032350100810
032351100810     c                   end
032352100809     c                   endsr
032353050819
032354100809      *******************************************
032355100810      * update bcrec
032356100809      *******************************************
032357100809     c     #l1           begsr
032358100809
032359050819     C     w9dtsq        CHAIN     bcrec1
032360050823     c                   if        not %found(bcrec1)
032361170125     c   of              except    head
032362170125     c                   except    error3
032363050823     c                   leavesr
032364050819     c                   end
032365100810
032366161215      * update the commission method from the last input record
032367050819     c                   movel     w9mthd        bccmth
032368161215
032369161215      * update the AF and BD method from how it was calculated in this pgm
032370161215     c                   movel     wkfeemth      bcfmth
032371161215     c                   movel     wkbdmth       bcdmth
032372050819
032373100813      * If paid amt = 0 do not fill in commission, admin fee or bonus draw
032374100813      * in BCREC because they are only paid when we pay the carrier
032375050826     c                   if        bcpada = 0
032376050822     c                   goto      #skpremcalc
032377050819     c                   end
032378050819
032379100810      * fill commission pct (for methods using a %) and amount in bcrec rec
032380050819     c                   z-add     w9cmrt        bccpct
032381050823     c                   z-add     totcom        bccchg
032382100809
0323831008100456  * update admin fee and bonus draw fields in bcrec rec
032409100810     c                   z-add     totfee        bcfchg
032410100810     c                   z-add     wkbcfpct      bcfpct
032411100810     c                   z-add     totbdchg      bcdchg
032412100810     c                   z-add     wkbcdpct      bcdpct
032438050823
0324391008100456  * update remittance info in BCREC
032440050823     c     #skpremcalc   tag
032441050819     c                   update    bcrecr
032442050819
032443050819     c                   endsr
032444060518
032445060518      **********************************************
032446060518      * Calc Admin Fee
032447060518      **********************************************
032448060518     c     #calcaf       begsr
032449060518
032450060518     c                   clear                   wkpct
032451060518     c                   clear                   wkfee
032452161215     c                   clear                   wkfeemth
032453100810     c                   clear                   wkbcfpct
032454060518
032455060518     c                   select
032456100810      *****
032457100810      * flat fee per member
032458100810      *****
032459060518     c                   when      workafff <> 0 and w9mcnt <> 0
032460060518     c                   z-add     workafff      wkfee
032461161215     c                   eval      wkfeemth = '$'
032462100810     c                   clear                   wkbcfpct
032463100810      * reduce whole flat fee by split percentage
032464100810     c                   if        wksplitpct <> 0
032465100810     c                   mult      wksplitpct    wkfee
032466100810     c                   end
032467100810      *****
032468060518      * % of prem
032469100810      *****
032470060518     c                   when      workafpp <> 0
032471161215     c                   eval      wkfeemth = '%'
032472060518     c     workafpp      div       100           wkpct
032473100810     c     wkpct         mult      wkprem        wkfee
032474100810     c                   z-add     workafpp      wkbcfpct
032475100810      *****
032476060518      * % of com
032477100810      *****
032478060518     c                   when      workafpc <> 0
032479161215     c                   eval      wkfeemth = '%'
032480060518     c     workafpc      div       100           wkpct
032481100810     c     wkpct         mult      w9cmam        wkfee
032482100810     c                   z-add     workafpc      wkbcfpct
032483060518     c                   endsl
032484060518
032485060518      * set sign of fee to match mem cnt (memcnt will be +1,-1)
032486060518     c                   if        (w9mcnt < 0 and wkfee > 0) or
032487060518     c                             (w9mcnt > 0 and wkfee < 0)
032488060518     c                   mult      -1            wkfee
032489060518     c                   end
032490060518
032491100810      * accumulate admin fee
032492100810     c                   add       wkfee         totfee
032493060518
032494060518     c                   endsr
032495060518
032496060518      **********************************************
032497060518      * Calc bonus draw
032498060518      **********************************************
032499060518     c     #calcbd       begsr
032500060518
032501060518     c                   clear                   wkbdchg
032502161215     c                   clear                   wkbdmth
032503060518     c                   clear                   wkpct
032504100810     c                   clear                   wkbcdpct
032505060518
032506100810     c                   select
032507100810      *****
032508090102      * flat fee
032509100810      *****
032510100810     c                   when      workbdff <> 0 and w9mcnt <> 0
032511161215     c                   eval      wkbdmth = '$'
032512090102     c                   z-add     workbdff      wkbdchg
032513100810     c                   z-add     0             wkbcdpct
032514100810      * reduce whole flat fee by split percentage
032515100810     c                   if        wksplitpct <> 0
032516100813     c                   mult      wksplitpct    wkbdchg
032517100810     c                   end
032518100810      *****
032519060518      * % of prem
032520100810      *****
032521100810     c                   when      workbdpp <> 0
032522161215     c                   eval      wkbdmth = '%'
032523060518     c     workbdpp      div       100           wkpct
032524100810     c     wkpct         mult      wkprem        wkbdchg
032525100810     c                   z-add     workbdpp      wkbcdpct
032526060518
032527100810      *****
032528060518      * % of com = bonus draw % x admin fee
032529100810      *****
032530100810     c                   when      workbdpc <> 0
032531161215     c                   eval      wkbdmth = '%'
032532060518     c     workbdpc      div       100           wkpct
032533100810     c     wkpct         mult      wkfee         wkbdchg
032534100810     c                   z-add     workbdpc      wkbcdpct
032535100810     c                   endsl
032536060518
032537060518      * set sign of fee to match mem cnt (memcnt will be +1,-1)
032538060518     c                   if        (w9mcnt < 0 and wkbdchg > 0) or
032539060518     c                             (w9mcnt > 0 and wkbdchg < 0)
032540060518     c                   mult      -1            wkbdchg
032541060518     c                   end
032542060518
032543100810     c                   add       wkbdchg       totbdchg
032544060518
032545060518     c                   endsr
032546050819
032547060518      *********************************
032548060518      * first cycle
032549060518      *********************************
040700030411     C     *INZSR        BEGSR
0408000304110053 C                   TIME                    HTIME             6 0
040900030411
041000030411     C     AFKEY         KLIST
041100030411     C                   KFLD                    w9carr
041200030411     C                   KFLD                    w9mksz
041701050823
041702050823      *     Set run date to be YYYYMMDD
041703050823     C                   MOVEL     RUNDAT        RUNMD             4 0
041704050823     C                   MOVE      RUNDAT        RUNCY             4 0
041705050823     C                   MOVEL     RUNCY         runymd            8 0
041706050823     C                   MOVE      RUNMD         runymd
041800030411      *
042400030411     c                   endsr
0425001701250091 Orpa060n2p E            HEAD           2 03
0426000304110092 O                       CONAME              87
0427000304110093 O          E            HEAD           1
0428000304110094 O                       UDATE         Y     14
0429000304110095 O                                           70 'ERRORS IN NEW COMMISSION'
0430000304110095 O                                           77 'REPORT'
0431000304110096 O                                          120 'PAGE :'
0432000304110097 O                       PAGE          Z    126
0433000304110098 O          E            HEAD           1
0434000508230099 O                                           20 'PROG: RPA060N2'
043500030411     O                                           59 'EFFECTIVE DATE :'
043600030411     O                       rundat        y     70
0437000304110100 O                                          120 'TIME :'
0438000304110101 O                       HTIME              130 '  :  :  '
0439000304110102 O          E            HEAD           1
0440000304110103 O                                           24 '------------------------'
0441000304110104 O                                           48 '------------------------'
0442000304110105 O                                           72 '------------------------'
0443000304110106 O                                           96 '------------------------'
0444000304110107 O                                          120 '------------------------'
0445000304110108 O                                          132 '------------'
0446000304110109 O          E            HEAD           1
0447000304110110 O                                           12 'ACCOUNT'
0448000304110110 O                                           20 'PLAN'
0449000304110110 O                                           31 'CARRIER'
0450000304110110 O                                           43 'MARKET SZ'
0450010901020110 O                                           55 'EFF DATE'
0451000901020110 O                                           66 'ERROR  '
0452000304110111 O          E            HEAD           2
0453000304110112 O                                           24 '------------------------'
0454000304110113 O                                           48 '------------------------'
0455000304110114 O                                           72 '------------------------'
0456000304110115 O                                           96 '------------------------'
0457000304110116 O                                          120 '------------------------'
0458000304110117 O                                          132 '------------'
0459000304110118 O          E            ERROR1         1
0460000304110518 O                       w9trst               3
0461000304110519 O                                            4 '-'
0462000304110520 O                       w9subd               7
0463000304110521 O                                            8 '-'
0464000304110520 O                       w9acct              12
0465000304110125 O                       w9PLAN              20
0466000304110125 O                       w9carr              31
0467000304110138 O                       w9mksz              43
0467010901020138 O                       w9efdt              55 '    /  /  '
0468000901020137 O                                           85 'NO ADMIN FEE SET UP       '
0469000508230118 O          E            ERROR2         1
0470000508230518 O                       w9trst               3
0471000508230519 O                                            4 '-'
0472000508230520 O                       w9subd               7
0473000508230521 O                                            8 '-'
0474000508230520 O                       w9acct              12
0475000508230125 O                       w9PLAN              20
0476000508230125 O                       w9carr              31
0477000508230138 O                       w9mksz              43
0477010901020138 O                       w9efdt              55 '    /  /  '
0478000901020137 O                                           85 'NO BONUS DRAW SET UP      '
0479001701250118 O          E            ERROR3         1
0479011705020137 O                                            8 'W9DTSEQ:'
0479021705020518 O                       w9dtsq              +2
0480001701250137 O                                           85 'BCREC RECORD NOT FOUND, CO'
0481001705020137 O                                          111 'NTACT PGMR IMMEDIATELY!   '
