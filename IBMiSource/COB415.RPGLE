0001009102150002 F******************************************************************
0002001104070003 F* cob415     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009102150004 F*                                                                *
0004009102150005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005001104050006 F*            DATE - 04/05/11                                     *
0006009102150007 F*                                                                *
0007001104260008 F*  This program will capture the active cobra members in 2 files *
0016041104260015 F*  for use in a report delivered to the clients by gbsaccess.    *
0016061104280015 F*  It will be run on the 1st of every month in ROBOT.            *
0016071104280015 F*                                                                *
0016081111230015 F* 11/23/11 dlk - add carrier code and desc to cactcov file       *
0016091111230015 F*                                                                *
0017009102150013 F******************************************************************
0018001104260014 Fmember    iP   e             DISK
0020011104260017 Fmcov      IF   e           k DISK
0020021104260017 Fplnmst    IF   e           k DISK
0020031104260017 Fpctmst    IF   e           k DISK
0020041104260017 Fsubmem    IF   e           k DISK
0020051104260017 Faccmst    IF   e           k DISK
0020061104260017 Fmemmem    IF   e           k DISK
002007041216     Fcodesl1   IF   E           K DISK
002008110427     Fmemssn    IF   E           K DISK    rename(membr:memssnr) prefix(m_)
002009111123     Fcarmst    IF   E           K DISK
002010110426     Fcactmem   o  a E             DISK
002011110426     Fcactcov   o  a E             DISK
0022011104070002 D systemdate      S               d   datfmt(*ISO)
0022021104270137 D                 DS
0022031104270138 D  smfrdt01               1      8  0
0022041104270139 D  smfrdt01dd             7      8  0
002927010326
002928110427      * select only active cobra members as of today
002929110426     c                   if        cexpdt > today and
002930110426     c                             (termdt = 0 or termdt > today) and
002931110426     c                             enroll <= today and
002932110426     c                             (qedt <> 0 and qedt <= today)
002933110426     c                   exsr      #process
002934110426     c                   end
002935110426
002936110426     c     #process      begsr
002937110426
002938110426     c                   clear                   cactmemr
002939110426     c                   clear                   cactcovr
002940110426
002941110427      * fill member fields
002942110427
002943110427     c                   move      today         CARUNDT
002944110427     c                   move      time          CARUNTM
002945110427     c                   move      mbssno        CAMSSN
002946110427     c                   movel     mlname        CAMLNAME
002947110427     c                   movel     mfname        CAMFNAME
002948110427     c                   movel     mmi           CAMMI
002949110427     c                   move      mbtrst        CATRUST
002950110427     c                   move      mbsub#        CASUB
002951110427     c                   move      mbacct        CAACCT
002952110427     c                   move      gbscdt        CAGBSCDT
002953110427     c                   move      qedt          CAQEDT
002954110427     c                   move      cexpdt        CACEXPDT
002958110427
002959110427      * get acct name
002960110426     c     acckey        chain     accmst
002961110426     c                   if        %found(accmst)
002962110426     c                   movel     acnam1        caacnam1
002963110426     c                   end
002964110426
002965110426      * check for subsidy eligibility - everyone is eligible for the entire
002966110426      * 1st month thru midnight the day before the end date.
002967110426     c     mbssno        setll     submem
002968110426     c                   dou       %eof(submem)
002969110426     c     mbssno        reade     submem
002970110426     c                   if        not %eof(submem) and smfrdt <> smtodt
002971110426     c                   move      smfrdt        smfrdt01
002972110426     c                   move      01            smfrdt01dd
002973110426     c                   if        today >= smfrdt01 and today < smtodt
002975110426     c                   move      SMFRDT        CASUBBEG
002976110426     c                   move      SMTODT        CASUBEND
002977110426     c                   leave
002978110426     c                   end
002979110426     c                   end
002980110426     c                   enddo
002981110426
002982110427      * is this member really a dependent previously under another members
002983110427      * policy at the time of the qualifying event date?
002984110427     c     mbssno        setll     memmem
002985110427     c                   dou       %eof(memmem)
002986110427     c     mbssno        reade     memmem
002987110427     c                   if        not %eof(memmem) and mmfrdt <> mmtodt and
002988110427     c                             (qedt >= mmfrdt and qedt <= mmtodt)
002989110427     c                   move      MMORSSN       CAPSSN
002990110427      * get prev members name
002991110427     c     mmorssn       chain     memssn
002992110427     c                   if        %found(memssn)
002993110427     c                   movel     m_mlname      CAPLNAME
002994110427     c                   movel     m_mfname      CAPFNAME
002995110427     c                   movel     m_mmi         CAPMI
002996110427     c                   end
002997110427     c                   leave
002998110427     c                   end
002999110427     c                   enddo
003000110426
003001110427      * write cactmem (member) rec
0030021104270145 C                   write     CACTMEMR
003004110427
003005110427      * get active coverages billed to the cobra member
003006110427     c     mbssno        setll     mcov
003007110427     c                   dou       %eof(mcov)
003008110427     c     mbssno        reade     mcov
003009110427     c                   if        not %eof(mcov) and (enrldt <> candt) and
003010110427     c                             (today >= enrldt) and
003011110427     c                             ((candt = 0) or (candt > today))
003013110427     c                   exsr      #crtcov
003016110427     c                   end
003017110427     c                   enddo
003018110407
014901110426     c                   endsr
014915000410
014916110427
014917110427      **********************************************
014918110427      * create coverage records for this member
014919110427      **********************************************
014921110427     c     #crtcov       begsr
014922110427
014923110427     c                   clear                   cactcovr
014924110427
014925110427     c                   move      today         CCRUNDT
014926110427     c                   move      time          CCRUNTM
014927110427     c                   move      mbssno        CCMSSN
014928110427     c                   move      mcplan        CCPLAN
014929110427     c                   move      mcovtp        CCCOVT
014930110427     c                   move      enrldt        CCENRLDT
014931110427     c                   move      candt         CCCANDT
014932110427
014933110428      * cov type desc
0149341104280065 C     mcovtp        CHAIN     codesl1
014935110428     c                   if        %found(codesl1)
014936110428     c                   movel     ldescr        CCCOVTD
014937110428     c                   end
014938110427      * plan desc
0149391104270065 C     plnkey        CHAIN     plnmst
014940110427     c                   if        %found(plnmst)
014941110427
014942110427      * skip subsidy plans billed to the account
014943110427     c                   if        sfadm = 'Y'
014944110427     c                   leavesr
014945110427     c                   end
014946110427
014947110427     c                   movel     pdescr        ccpland
014948110427     c                   move      plncat        CCPcat
014949111123     c                   move      pcarr         CCcar
014950111123      * carrier desc
0149511111230065 C     pcarr         CHAIN     carmst
014952111123     c                   if        %found(carmst)
014953111123     c                   movel     cname         CCcard
014954111123     c                   end
014955110427      * plan cat desc
0149561104270065 C     plncat        CHAIN     codesl1
014957110427     c                   if        %found(codesl1)
014958110427     c                   movel     ldescr        CCPCATD
014959110427     c                   movel     action        CCPCT
014960110427      * plan cat type desc
0149611104270065 C     action        CHAIN     pctmst
014962110427     c                   if        %found(pctmst)
014963110427     c                   movel     PCDES         CCPCTD
014964110427     c                   end
014965110427     c                   end
014966110427     c                   end
014967110427
014968110427      * write cactcov (mcov) rec
0149691104270145 C                   write     CACTCOVR
014970110427
014971110427     c                   endsr
014972110427
014973110407      **************************
014974110407      * first cycle only
014975110407      **************************
0263020002280106 C     *inzsr        BEGSR
026307110407
026308110427     c     plnkey        klist
026309110427     c                   kfld                    mctrst
026310110427     c                   kfld                    mcsub#
026311110427     c                   kfld                    mcplan
026313110427
026314110427     c     acckey        klist
026315110427     c                   kfld                    MBTRST
026316110427     c                   kfld                    MBSUB#
026317110427     c                   kfld                    MBACCT
026318110427
0263191104070013 C                   TIME                    STIME            12 0                         COMPN
0263201104070014 C                   MOVEL     STIME         TIME              6 0                         COMPN
026321110407     C*
026322110407     C* current system DATE AS YYYYMMDD
026323110407     C*
026324110407      /free
026325110407       systemdate = %date();
026326110407      /end-free
026327110407
026328110426     c                   move      systemdate    today             8 0
026336110407
0263370002280120 C                   ENDSR
