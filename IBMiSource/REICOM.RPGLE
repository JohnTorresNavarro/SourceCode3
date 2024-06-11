000001070720      ********************************************************************
000002070720      *              Group Benefit Services, Inc.
000003070720      *
000004070720      *      Written by - David Ketterman
000005070723      *      Date       - 07/23/2007
000006070720      *
000007070723      * This program will reinstate all cancelled comctx in the acc#
000008070723      * passed as a parameter that were cancelled when the acct was
000009070723      * cancelled.
000010070723      * parameters passed : ACCOUNT # (10), USER ID (10)
000011070720      *
000012070723      * Called from : TR110
000013081124      *
000014081124      * 11/24/08 dlk - add new commmission history file
000015130924      * 09/24/13 dlk - history expansion project
000016070720      *
000017070720      ********************************************************************
0001010707200005 Fcmct14    uf   e           k disk
0001020707230005 Fhist      o  a e           k disk
000103081124     Fcomhst    O  A E             DISK
0001041309240037 D sysdateymd      S               d   datfmt(*iso)
0001130009250055 D                 DS
0001140707200056 D  tsa                    1     10
0001150707200056 D  t                      1      3  0
0001160707200056 D  s                      4      6  0
0001170707200056 D  a                      7     10  0
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
000135070723     D  n2effdat              12     19
000136070720
000149070723      * read all cancelled comctx for the acct that were cancelled when the
000150070723      * acct cancelled (cseq# = 99)
000151070720
000152070720     c     acckey        setll     cmct14
000153070720     c                   dou       %eof(cmct14)
000154070720     c     acckey        reade     cmct14
000155070723     c                   if        not %eof(cmct14) and cseq# = 99
000156070723     c                             and cmcan <> 0
000160070723      * reinstate the comctx
000161081124     c                   move      cmcan         cmcanhold         8 0
000304070723     c                   clear                   cmcan
000305070723     c                   clear                   cseq#
000401070723     c                   move      'A'           cmdltd
000405070720     c                   update    comcxr
000407070723     C                   exsr      #writehist
000410070720     c                   end
000411070720     c                   enddo
000415070720
000416070720      * end program
000417070720     c                   eval      *inlr = *on
000433070723     c***************************************************************
000434070723     c* write history record                                        *
000435070723     c***************************************************************
000436070723     c     #writehist    begsr
000437070723
000438070723     c                   clear                   histr
000439070723
000440070723      * set up note fields
000441070723
000442070723     C                   MOVE      cmplan        n1cmplan
000443070723     C                   MOVE      slsman        n1slsman
000444070723     C                   MOVE      effdat        n2effdat
000445070723
000446070723     C                   MOVE      tsa           HKEY
000447070723     C                   MOVE      'LRC'         TRCODE
000448070723     C                   MOVE      note1out      ck#not
000449070723     C                   MOVE      note2out      note2
000450070723     C                   MOVE      'X'           TRMFLG
000451070723     C                   MOVE      'X'           TRLFLG
000452070723     C                   MOVE      'N'           DTRFLG
000454130924     C                   MOVEl     thispgmname   HPRGNM
000455070723     C                   MOVE      t             HSTRST
000456070723     C                   MOVE      s             HSSUB#
000457070723     C                   MOVE      a             HSACCT
000458070723     C                   MOVEl     parmuser      HOPER
000459070723     C                   MOVE      'A'           HSDLTD
000461070723     C                   MOVE      effdat        COVTDT
000462130924     C                   eval      sysdateymd = %date
000463130924     C                   MOVE      sysdateymd    trdate
000464130924     c                   eval      hstrtime = %time
000465070723     C                   WRITE     HISTR
000466070723
000467081124      * write new commission history rec
000468081124
000469081124      * common fields in commission history file
000470081124     c                   clear                   comhstr
000471081124     C                   move      t             chtrust
000472081124     C                   move      s             chsub
000473081124     C                   move      a             chacc
000474081124     C                   MOVEL     cmplan        chplan
000476130924     c                   move      sysdateymd    chtrdat
000477081124     c                   time                    chtrtim
000478081124     C                   MOVEL     parmuser      chuser
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
000493081124      * before fields
000494081124     c                   move      effdat        chbeff
000495081124     c                   move      cmcanhold     chbcan
000496081124     c                   move      cmrelid       chbrel
000497081124     c                   move      ccovpp        chbpop
000498081124     c                   move      ccovra        chbff
000499081124     c                   move      ccovpc        chbpoc
000500081124     c                   move      ccpnc         chbpnc
000501081124     c                   move      cccmsp        chbcmsp
000502090416     c                   movel     free5         chbpri
000503081124
000504081124      * set transaction code
000505081124     C                   eval      chtrcod = 'LCC'
000506081124
000507081124      * add rec with before and after fields
000508081124     c                   write     comhstr
000509081124
000510070723     C                   endsr
000511070723
0005120707230103 C***************************************************
0005130707230104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0005140707230105 C***************************************************
0005150707230107 C*
0005160707230107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0005170707230107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0005180707230107 C*
0005190707230106 C     #DATYM        BEGSR
000520070723     C                   MOVEL     @DATIN        @Y                4 0
000521070723     C                   MOVE      @DATIN        @MD               4 0
000522070723     C                   MOVE      @Y            @DATOU            8 0
000523070723     C                   MOVEL     @MD           @DATOU
000524070723     C                   MOVE      *ZEROS        @DATIN            8 0
0005250707230120 C                   ENDSR
000526070723
000527070720      *********************
000528070720      * first cycle
000529070720      *********************
000530070611     c     *inzsr        begsr
000531070720     c     *entry        plist
000532070720     c                   parm                    parmtsa          10
000533070723     c                   parm                    parmuser         10
000534070720
000535070720     c                   move      parmtsa       tsa
000536070720
000537070611     c     acckey        klist
000538070720     c                   kfld                    t
000539070720     c                   kfld                    s
000540070720     c                   kfld                    a
000545130924
000546130924     c                   movel     'REICOM'      thispgmname      10
000547070611     c                   endsr
