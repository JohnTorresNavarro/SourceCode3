0001009102150002 F******************************************************************
0002000103260003 F* cob370     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009102150004 F*                                                                *
0004009102150005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000103260006 F*            DATE - 03/26/01                                     *
0006009102150007 F*                                                                *
0007000103280008 F*  Member term vs plan term report - show when a member was      *
0008000103260009 F*  cancelled for 1 date but plans were cancelled for a different *
0009000103280010 F*  date. This program is also run in RP430CL to check all        *
0016030103280015 F*  members that are on the RP430 report.                         *
0016040103280015 F*                                                                *
0016050412160015 F* 12/16/04 dlk - exclude cobra lite billing only accts and change*
0016060412160015 F*                hard coded plan category to use new plan cat    *
0016070412160015 F*                type.                                           *
001608131005      * 10/05/13 dlk - history expansion project - recompile only
0016090412160015 F*                                                                *
0017009102150013 F******************************************************************
0018000103260014 Fhist      iP   e             DISK
0020000002280017 FACCMST    IF   e           k DISK
0020010103260017 Fmember    IF   e           k DISK
0020020103270017 Fplnmst    IF   e           k DISK
0020030103260014 Fhistak    if   e           k DISK    rename(histr:histrak) prefix(h)
002004041216     Fcodesl1   IF   E           K DISK
0022000103270019 Fqsysprt   O    F  132        PRINTER OFLIND(*INOF)
0025009102150049 D                 DS
0026009811190050 D  CYMD                   1      8  0
0027009811190051 D  CYY                    1      4  0
0028009811190052 D  CMM                    5      6  0
0028010103270055 D                 DS
0028020103270056 D  hck#not                1     30
0028030103270056 D  hhsplan                1      4
0029009102150053 D                UDS
002901010326     D  LFY                    1      4  0
002902010326     D  LFMD                   5      8  0
002903010326     D  LTY                    9     12  0
002904010326     D  LTMD                  13     16  0
002905010326     D  LTRUST                17     19
002906010326     D  LSUB                  20     22
002907010326     D  LACC                  23     26
002908010326     D  CONAME               201    240
002909010326     D  LTIME                242    247  0
002910010327     c                   eval      *in22 = *off
002911010326     c     hiskey        setll     histak
002912010327
002913010327     c                   dow       *in22 = *off
002914010327     c                   reade     histak                                 22
002915010327     c                   if        *in22 = *off and htrcode = 'MDC' and
002916010327     c                             hcovtdt <> covtdt
002918010326     c                   exsr      #elig
002919010326     c                   end
002921010326     c                   enddo
002922010326
002923010326     c*********************************************************************
002924010326     c* see if member would be eligible for COBRA                         *
002925010326     c*********************************************************************
002926010326     c     #elig         begsr
002927010326
0060000103270065 C     acckey        CHAIN     ACCMST                             20
0069009102150066 C*
0070000103270067 C* check for active cobra eligible acct
0071009102150068 C*
0073000103270071 C                   if        *in20 or atrmdt <> 0 or fcstfl = 'N'
0073010412160071 C                             or acobsrv = 'B'
0076000103260086 C                   leavesr
0078009102150074 C                   END
0089010103260089 C*
0089020103270090 C* IF member has been reinstated or
0089030103270090 C* STATE ACCOUNT AND LIVES OUTSIDE MD - skip
0089040103260091 C*
008905010326     c                   move      hkey          memkey            9 0
0089060103260065 C     memkey        CHAIN     member                             21
008907010327     c                   if        *in21 or termdt = 0 or
008908010327     c                             (fcstfl = 'S' and state <> 'MD')
008909010326     c                   leavesr
008910010326     c                   end
0101009102150101 C*
0102009102150102 C* IF COVERAGE WAS NOT ACTIVE LONG ENOUGH - NOT ELIGABLE
0103009102150103 C*  MIN TIME - FEDERAL 1 MONTH,  STATE 3 MONTHS
0104009102150104 C*
0105009102150105 C*
0106000002280106 C                   Z-ADD     mbenrl        CYMD
0107009102150107 C     FCSTFL        IFEQ      'S'
0108009102150108 C                   ADD       3             CMM
0109009102150109 C                   ELSE
0110009102150110 C                   ADD       1             CMM
0111009102150111 C                   END
0112009102150112 C*
0113009102150113 C     CMM           IFGT      12
0114009102150114 C                   ADD       1             CYY
0115009102150115 C                   SUB       12            CMM
0116009102150116 C                   END
0117009102150120 C*
0118000103260121 C     termdt        IFLT      CYMD
012201010326     c                   leavesr
0123009102150127 C                   END
0124009102150128 C*
0125000103270129 C* plan check
0135040103270175 C*
0135050412160171 C     PLNKEY        CHAIN     PLNMST
013506041216     c                   if        %found(plnmst)
013507041216     c     plncat        chain     codesl1
0135080412160175
013509041216      * only include medical, dental, vision, and rx
013510041216     c                   if        not %found(codesl1) or
013511041216     c                             (action <> 'M' and action <> 'D' and
013512041216     c                             action <> 'V' and action <> 'R')
013520010327     c                   leavesr
0135210103270127 C                   end
0135220412160127 C                   end
013523010326
0136009903300129 C* CHECK TERM CODE. IF DECEASED (D5 ) - NOT ELIG
0136010103260129 C*                  IF transfer (DMT) - NOT ELIG
0136020103260129 C*                  IF invalid ssn (DIS) - NOT ELIG
0137009903300131 C*
0138000103260133 C                   if        termcd = 'D5 ' or termcd = 'DMT' or
0138010103260133 C                             termcd = 'DIS'
013802010326     c                   leavesr
0143009903300139 C                   END
0143100005050131 C*
0144009102150140 C*
0145000103260141 C* IF MEMBER HAS MADE IT PAST ALL ABOVE CHECKS, HE would be eligible
0146000103270142 C* FOR COBRA
0147009102150143 C*
014801010326
014802010326     C                   MOVE      covtdt        @DATIN
014803010326     C                   EXSR      #DATYM
014804010326     C                   MOVE      @DATOU        TERMDY            8 0
014805010326
014806010327     C                   MOVE      trdate        @DATIN
014807010327     C                   EXSR      #DATYM
014808010327     C                   MOVE      @DATOU        Trdmdy            8 0
014809010327
014810010327     C                   MOVE      hcovtdt       @DATIN
014811010327     C                   EXSR      #DATYM
014812010327     C                   MOVE      @DATOU        hcovmdy           8 0
014813010327
014814010327     c* name
0148150103270200 C                   MOVE      *BLANKS       N                32
0148160103270202 C                   MOVEl     mlname        N
014817010327     C                   CAT       ',':0         N
014818010327     C                   CAT       mfname:1      N
014819010326     C*
0148200103270202 C                   MOVEl     pdescr        pdescr28         28
0148210103270145 C                   add       1             tot               6 0
0149009102150145 C                   EXCEPT    LINE
014915000410
0248000002280236 C                   ENDSR
0249009811190107 C*
0250009811190103 C***************************************************
0251009811190104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0252009811190105 C***************************************************
0253009811190107 C*
0254009811190107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0255009811190107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0256009811190107 C*
0257009811190106 C     #DATYM        BEGSR
025800981119     C                   MOVE      @DATIN        @MD               4 0
025900981119     C                   MOVEL     @DATIN        @Y                4 0
026000981119     C                   MOVEL     @MD           @DATOU            8 0
026100981119     C                   MOVE      @Y            @DATOU
026200981119     C                   MOVE      *ZEROS        @DATIN            8 0
0263009811190120 C                   ENDSR
0263010002280107 C*
0263020002280106 C     *inzsr        BEGSR
026303000228     c     acckey        klist
026304010326     c                   kfld                    hstrst
026305010326     c                   kfld                    hssub#
026306010326     c                   kfld                    hsacct
026307010327     c     plnkey        klist
026308010327     c                   kfld                    hstrst
026309010327     c                   kfld                    hssub#
026310010327     c                   kfld                    hhsplan
026311010327     c     hiskey        klist
026312010327     c                   kfld                    hkey
026313010327     c                   kfld                    trdate
0263140002280120 C                   ENDSR
0264000103270237 Oqsysprt   H    1P                     2 03
0265009102150238 O         OR    OF
0267009102150240 O                       CONAME              85
0269009102150242 O          H    1P                     1
0270009102150243 O         OR    OF
0271000103260244 O                                           74 'MEMBER CANCEL vs PLAN CA'
0272000103260245 O                                           78 'NCEL'
0273009102150246 O          H    1P                     1
0274009102150247 O         OR    OF
0275000103270248 O                                           20 'PROGRAM NAME: COB370'
027501010326     O                                           56 'DATE RANGE:'
027502010326   01O                       LFMD                62 '  /  '
027503010326   01O                                           63 '/'
027504010326   01O                       LFY                 67
027505010326     O                                           69 '-'
027506010326   01O                       LTMD                75 '  /  '
027507010326   01O                                           76 '/'
027508010326   01O                       LTY                 80
0276009102150249 O                                          122 'PAGE :'
0277009102150250 O                       PAGE          Z    131
0278009102150251 O          H    1P                     1
0279009102150252 O         OR    OF
0280000103270253 O                                            9 'RUN DATE:'
0281000103270254 O                       UDATE         Y     20
028101010326     O                                           52 'TRUST:'
028102010326     O                       LTRUST              56
028103010326     O                                           62 'SUB:'
028104010326     O                       LSUB                66
028105010326     O                                           72 'ACC:'
028106010326     O                       LACC                77
0282009102150255 O                                          122 'TIME :'
0283000103270256 O                       ltime              131 '  :  :  '
0284009102150257 O          H    1P                     1
0285009102150258 O         OR    OF
0286000103270259 O                                           24 '------------------------'
0287000103270260 O                                           48 '------------------------'
0288000103270261 O                                           72 '------------------------'
0289000103270262 O                                           96 '------------------------'
0290000103270263 O                                          120 '------------------------'
0291000103270264 O                                          132 '------------'
0297009102150270 O          H    1P                     1
0298009102150271 O         OR    OF
0299000103270272 O                                            4 'SSN'
0300000103270273 O                                           18 'NAME'
0301000103270274 O                                           55 'ACCOUNT'
0302010103270267 O                                           72 'TRANS DATE'
0303000103270276 O                                           90 'PLAN DESCRIPTION'
0304000103270277 O                                          120 'MEMBER TERM'
0304010103270277 O                                          132 'PLAN TERM'
0306009102150279 O          H    1P                     2
0307000103270280 O         OR    OF
0313070103270259 O                                           24 '------------------------'
0313080103270260 O                                           48 '------------------------'
0313090103270261 O                                           72 '------------------------'
0313100103270262 O                                           96 '------------------------'
0313110103270263 O                                          120 '------------------------'
0313120103270264 O                                          132 '------------'
0314009102150287 O          E            LINE           1
0315000103270288 O                       memkey              12 '0   -  -    '
0316000103270289 O                       N                   46
0318000103270291 O                       hstrst              51
0318010103270291 O                                           52 '-'
0318020103270291 O                       hssub#              55
0318030103270291 O                                           56 '-'
0318040103270291 O                       hsacct              60
0318050103270290 O                       trdmdy              72 '  /  /    '
0319000103270292 O                       hhsplan             78
0319010103270292 O                       pdescr28           107
0319020103270292 O                       termdy             120 '  /  /    '
0319030103270292 O                       hcovmdy            132 '  /  /    '
0323009102150296 O          T    LR                  2
0324000103270297 O                                            6 'TOTAL:'
0326000103270299 O                       TOT           1     14
