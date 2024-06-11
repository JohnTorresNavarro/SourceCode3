000001070720      ********************************************************************
000002070720      *              Group Benefit Services, Inc.
000003070720      *
000004070720      *      Written by - David Ketterman
000005070720      *      Date       - 07/20/2007
000006070720      *
000007070720      * This program will cancel all active comctx in the acc# and plan
000008070720      * (or all plans) passed as parameters using the last day of the
000009070720      * month for the last invoice generated.
000010070723      * parameters passed : ACCOUNT # (10), PLAN or '*all' (4), from (10)
000011070723      * USER ID (10)
000012070720      *
000014070720      * Called from : TR070, TR100, TR050
000015081124      *
000016081124      * 11/24/08 dlk - add new commmission history file
000017130924      * 09/24/13 dlk - history expansion project
000018140829      * 08/29/14 dlk - add effective date parm. Shelly wants to override
000019140829      *                the last inv date with the effdt - 1 day date when
000020140829      *                the effdt - 1 day date is greater than the last
000021140829      *                inv date.
000022140829      *
000023070720      ********************************************************************
0001010707200005 Fcmct14    uf   e           k disk
0001030707230005 Fhistaa    if a e           k disk
000104081124     Fcomhst    O  A E             DISK
0001060009250037 D workdt          S               d   datfmt(*iso)
0001120706110037 D bmb             S              3    inz('BMB')
0001131309240037 D sysdateymd      S               d   datfmt(*iso)
0001141408290037 D effymd          S              8  0
0001151408290037 D effymd_minus1   S              8  0
0001160009250055 D                 DS
0001170707200056 D  tsa                    1     10
0001180707200056 D  t                      1      3  0
0001190707200056 D  s                      4      6  0
0001200707200056 D  a                      7     10  0
0001230706110055 D                 DS
0001240706110056 D  cmcan                  1      8  0
0001250706110056 D  cmcandd                7      8  0
0001260707230055 D                 DS
0001270707230056 D  note1out               1     30
000128070723     D  n1ptxt                 1      8    inz('PLAN# - ')
000129070723     D  n1cmplan               9     12
000130070723     D  n1stxt                15     25    inz('SALESMAN - ')
000131070723     D  n1slsman              26     28
0001320707230055 D                 DS
0001330707230056 D  note2out               1     30
000134070723     D  n2etxt                 1     11    inz('EFF DATE - ')
000135070723     D  n2cmcan               12     19
000136070720
000137140829      * find latest invoice
000138140829     c                   exsr      #getinv
000140140829      * get last day of the month for the latest invoice
000141140829     c                   clear                   newcomcan         8 0
000142140829     c                   if        lastinvdt <> 0
000143140829     c                   move      lastinvdt     workdt
000144140829     c                   adddur    1:*M          workdt
000145140829     c                   subdur    1:*d          workdt
000146140829     c                   move      workdt        newcomcan
000147140829     c                   end
000148140829      * if (effdt - 1 day) is > (the last day of the month for the latest
000149140829      * inv) then use the effdt - 1 day instead. Shelly request 8/29/14
000150140829
000151140829     c                   if        effymd > 0
000152140829     c     *iso          test(de)                effymd
000153140829     c                   if        not %error
000154140829     c                   move      effymd        workdt
000155140829     c                   subdur    1:*d          workdt
000156140829     c                   move      workdt        effymd_minus1
000157140829     c                   end
000158140829     c                   if        effymd_minus1 > newcomcan
000159140829     c                   move      effymd_minus1 newcomcan
000160140829     c                   end
000161140829     c                   end
000163140829
000164070723      * read all active comctx (match plan if selected) for the acct
000166070720     c     acckey        setll     cmct14
000167070720     c                   dou       %eof(cmct14)
000168070720     c     acckey        reade     cmct14
000169070720     c                   if        not %eof(cmct14) and cmcan = 0 and
000170070720     c                             ((parmplan = '*all') or
000171070720     c                             (parmplan <> '*all' and cmplan = parmplan))
000172070720      * update comctx cancel date
000173081124     c                   move      cmcan         cmcanhold         8 0
000174051004     c                   if        effdat <= newcomcan
000201051004     c                   move      newcomcan     cmcan
000302051004     c                   else
000304051004     c                   move      effdat        cmcan
000400000714     c                   end
000401140829
000402070723     c                   move      'C'           cmdltd
000403070723
000404070723      * mark comctx record with a "99" seq # if the cancel was done as
000405070723      * a result of account cancellation so the acct reinstate pgm can
000406070723      * know what records to reinstate.
000407070723
000408070723     c                   if        parmfrom = 'TR070     ' or
000409070723     c                             parmfrom = 'TR100     '
000410070723     c                   move      99            cseq#
000411070723     c                   end
000412051004
000413070720     c                   update    comcxr
000414070723     C                   exsr      #writehist
000415051004
000416070720     c                   end
000417070720     c                   enddo
000418070720
000419070720      * end program
000420070720     c                   eval      *inlr = *on
000421070611      *******************************************
000422070611      * find latest invoice produced
000423070611      *******************************************
000424070611     c     #getinv       begsr
000425070611
000426070611     c                   clear                   lastinvdt         8 0
000427070611     c     hiskey        setll     histaa
000428070611     c                   dou       %eof(histaa)
000429070611     c     hiskey        reade     histaa
000430070611     c                   if        not %eof(histaa) and covtdt > lastinvdt
000431070611     c                   move      covtdt        lastinvdt
000432070611     c                   end
000433070611     c                   enddo
000434051013     c                   endsr
000435070720
000436070723     c***************************************************************
000437070723     c* write history record                                        *
000438070723     c***************************************************************
000439070723     c     #writehist    begsr
000440070723
000441070723     c                   clear                   histr
000442070723
000443070723      * set up note fields
000444070723
000445070723     C                   MOVE      cmplan        n1cmplan
000446070723     C                   MOVE      slsman        n1slsman
000447070723     C                   MOVE      cmcan         n2cmcan
000448070723
000449070723     C                   MOVE      tsa           HKEY
000450070723     C                   MOVE      'LDC'         TRCODE
000451070723     C                   MOVE      note1out      ck#not
000452070723     C                   MOVE      note2out      note2
000453070723     C                   MOVE      'X'           TRMFLG
000454070723     C                   MOVE      'X'           TRLFLG
000455070723     C                   MOVE      'N'           DTRFLG
000456130924     C                   MOVEl     thispgmname   HPRGNM
000457070723     C                   MOVE      t             HSTRST
000458070723     C                   MOVE      s             HSSUB#
000459070723     C                   MOVE      a             HSACCT
000460070723     C                   MOVEl     parmuser      HOPER
000461070723     C                   MOVE      'A'           HSDLTD
000462070723     C                   MOVE      cmcan         COVTDT
000463130924     C                   eval      sysdateymd = %date
000464130924     C                   MOVE      sysdateymd    trdate
000465130924     c                   eval      hstrtime = %time
000467070723     C                   WRITE     HISTR
000468070723
000469081124      * write new commission history rec
000470081124
000471081124      * common fields in commission history file
000472081124     c                   clear                   comhstr
000473081124     C                   move      t             chtrust
000474081124     C                   move      s             chsub
000475081124     C                   move      a             chacc
000476081124     C                   MOVEL     cmplan        chplan
000477130924     c                   move      sysdateymd    chtrdat
000478081124     c                   time                    chtrtim
000479081124     C                   MOVEL     parmuser      chuser
000480130924     C                   MOVEL     thispgmname   chpgm
000481081124
000482081124      * after fields
000483081124     c                   move      effdat        chaeff
000484081124     c                   move      cmcan         chacan
000485081124     c                   move      cmrelid       charel
000486081124     c                   move      ccovpp        chapop
000487081124     c                   move      ccovra        chaff
000488081124     c                   move      ccovpc        chapoc
000489081124     c                   move      ccpnc         chapnc
000490081124     c                   move      cccmsp        chacmsp
000491090416     c                   movel     free5         chapri
000492081124
000496081124      * before fields
000497081124     c                   move      effdat        chbeff
000498081124     c                   move      cmcanhold     chbcan
000499081124     c                   move      cmrelid       chbrel
000500081124     c                   move      ccovpp        chbpop
000501081124     c                   move      ccovra        chbff
000502081124     c                   move      ccovpc        chbpoc
000503081124     c                   move      ccpnc         chbpnc
000504081124     c                   move      cccmsp        chbcmsp
000505090416     c                   movel     free5         chbpri
000506081124
000507081124      * set transaction code
000510081124     C                   eval      chtrcod = 'LDC'
000516081124
000517081124      * add rec with before and after fields
000518081124     c                   write     comhstr
000519081124
000520070723     C                   endsr
000521070723
0005220707230103 C***************************************************
0005230707230104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0005240707230105 C***************************************************
0005250707230107 C*
0005260707230107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0005270707230107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0005280707230107 C*
0005290707230106 C     #DATYM        BEGSR
000530070723     C                   MOVEL     @DATIN        @Y                4 0
000531070723     C                   MOVE      @DATIN        @MD               4 0
000532070723     C                   MOVE      @Y            @DATOU            8 0
000533070723     C                   MOVEL     @MD           @DATOU
000534070723     C                   MOVE      *ZEROS        @DATIN            8 0
0005350707230120 C                   ENDSR
000536070723
000537070720      *********************
000538070720      * first cycle
000539070720      *********************
000540070611     c     *inzsr        begsr
000541070720     c     *entry        plist
000542070720     c                   parm                    parmtsa          10
000543070720     c                   parm                    parmplan          4
000544070723     c                   parm                    parmfrom         10
000545070723     c                   parm                    parmuser         10
000546140829     c                   parm                    parmeffymd        8
000547070720
000548070720     c                   move      parmtsa       tsa
000549140829     c                   move      parmeffymd    effymd
000550070720
000551070611     c     acckey        klist
000552070720     c                   kfld                    t
000553070720     c                   kfld                    s
000554070720     c                   kfld                    a
000555070611
000556070611     c     hiskey        klist
000557070720     c                   kfld                    tsa
000558070611     c                   kfld                    bmb
000559070611
000560070723     C                   MOVE      *DATE         @DATIN
000561070723     C                   EXSR      #DATym
000562070723     C                   MOVE      @DATOU        UD8YMD            8 0
000563130924
000564130924     c                   movel     'CANCOM'      thispgmname      10
000565070611     c                   endsr
