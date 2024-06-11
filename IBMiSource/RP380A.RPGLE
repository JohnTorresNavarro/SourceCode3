000100001107     H Indent ('| ')
000200990630      *? ***************************************************************
000300050509      *             GROUP BENIFIT SERVICES SOFTWARE           2005     *
000400010322      *                                                                *
000500000118      *  Written by:    S. Zien                                        *
000600050509      *  Date Written:   5/9/05                                        *
000700050616      *  Description:   Payment Posting Audit Spreadsheet Phase II     *
000800000118      *                                                                *
000900000118      *                                                                *
001000000118      *                R E V I S I O N    H I S T O R Y                *
001100000118      *  Date                                                          *
001200000118      *  Revised   Initials    Revision                                *
001300000118      *  --------  --------    --------------------------------------  *
001400050509      *   5/09/05    szz       Initial version.                        *
001401070420      *  04/20/07    dlk       increase rec len of rp380csv            *
001402090805      *  08/05/09    dlk       add trust category code                 *
001500001211      *                                                                *
001600001106      *                                                                *
001700990630      *? ***************************************************************
001800010322
001801050509     FRP380WK   IF   E           K Disk
002000050505     FINVSUML2  IF   E           K Disk
002001050617     FINVCOB    IF   E           K Disk
002002090805     Ftrsmst    IF   E           K Disk
002003050509     FRP380CSV  O  A E             Disk
002004090805     D  tcat           s              1
002401010117     D                UDS
002402010118     D  CONAME               201    250
002500991230    ? * Program status data structure
002600991230    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003137050509      *
003138050509     D No              S              1    Inz('N')
003139050509     D Yes             S              1    Inz('Y')
003140050615     D KEB             S              3    Inz('KEB')
005700050506    ?D Inv_Msg         C                   'Invoice# not found.'
005701050506    ?D Amt_Msg         C                   'Amounts not equal.'
005702050509     D TSA             C                   'Trust-Sub-Account'
005800991229
005900000118      *---
006000050509      *? Phase II:  Compare workfile (history) payments to invoice summary
006100000118      *---
006104050509     C                   Read      RP380WK
006105050509     C                   Dou       %Eof(RP380WK)
006111050505     C                   Exsr      Process
006116050509     C                   Read      RP380WK
006117050505     C                   Enddo
006118050505
009200050505     C                   Eval      *InLR = *On
009202050506      * ? _____________________________________________________________
009203050506      *? *                                                             *
010501050509      *? *        Process:  Compare check amounts with invoice amounts *
010502050506      *? *_____________________________________________________________*
010503050506     C     Process       BEGSR
010504050617      *
010505050617     C                   Movel     No            Error             1
010506050617      *
010507050617     C                   Select
010508050620     C                   When      WKCOBRA   <>  *Blanks
010509050617     C                   Exsr      ProcCOBRA
010510050617     C                   Other
010511050617     C                   Exsr      ProcAccounts
010512050617     C                   EndSl
024858050505
024859090805     c                   clear                   tcat
024860090805     c     wktrst        chain     trsmst
024861090805     c                   if        %found(trsmst)
024862090805     c                   move      tscode        tcat
024863090805     c                   end
024864090805
024865050509     C                   Eval      WKRECORD  =   '"' +
024866050509     C                                                 WKACSTS  + '","' +
024867050621test C                                                 WKTRDAT  + '","' +
024868050621test C                                                 WKRCVDT  + '","' +
024869090805test C                                                 tcat     + '","' +
024870050509     C                                                 WKTSA    + '","' +
024871050617     C                                                 WKCOBRA  + '","' +
024872050509     C                                                 WKACNAM  + '","' +
024873050509     C                                                 WKAA     + '","' +
024874050509     C                              %Trim(%Editc(WKCHK#:'P'))   + '","' +
024875050509     C                              %Trim(%Editc(WKCHKAM:'P'))  + '","' +
024876050509     C                              %Trim(%Editc(WKINV#:'P'))   + '","' +
024877050616     C                                                 WKSOURC  + '","' +
024878050616     C                                                 WKBATCH  + '","' +
024879050509     C                              %Trim(%Editc(WKINVAM:'P'))  + '","' +
024880050509     C                                                 WKERROR  + '",'
024881050509     C                   Write     RP380CSR
024882050509     C*
024883050505     C                   ENDSR
024884050617      * ? _____________________________________________________________
024885050617      *? *                                                             *
024886050617      *? *        Process Accounts (compare amounts)                   *
024887050617      *? *_____________________________________________________________*
024888050617     C     ProcAccounts  BEGSR
024889050617      *? *---
024890050617      *? *  Add the Current Enrollment (KCE) & Trans Totals (KMA)      *
024891050617      *? *---
024892050617     C     InvKey        Setll     INVSUML2
024893050617     C     InvKey        Reade     INVSUML2
024894050617     C                   If        %Eof(INVSUML2)
024895050617     C                   Eval      Error     =    Yes
024896050617     C                   End
024897050617     C                   Dou       %Eof(INVSUML2)
024898050617     C                   If        Error     =    Yes
024899050617     C                   Eval      WKERROR   =    Inv_Msg
024900050617     C                   Leave
024901050617     C                   Else
024902050617     C                   Eval      WKERROR   =    *Blanks
024903050617     C                   End
024904050617     C                   If        INRC      =   KEB    And
024905050617     C                             INTRST    =   WKTRST And
024906050617     C                             INSUBD    =   WKSUB# And
024907050617     C                             INACCT    =   WKACCT And
024908050617     C                             ININV#    =   WKINV#
024909050617     C                   Z-add     INENDB        EndBal
024910050617     C                   End
024911050617     C                   If        (INRC     =    'KCE'  Or  INRC = 'KMA')
024912050617     C                                 AND  INTRCD   <>   'BMP'
024913050617     C                   Add       INTOT         WKINVAM           8 2
024914050617     C                   End
024915050617     C     InvKey        Reade     INVSUML2
024916050617     C                   EndDo
024917050617     C                   If        WKINVAM  <>   WKCHKAM
024918050617     C                   If        WKERROR  =    *Blanks
024919050617      *---
024920050617      *? *  If check amount same as end balance, it's not an error     *
024921050617      *---
024922050617     C                   If        WKCHKAM  <> EndBal
024923050617     C                   Eval      WKERROR  =  Amt_Msg
024924050617     C                   End
024925050617      *
024926050617     C                   End
024927050617     C                   End
024928050617     C                   ENDSR
024929050617      * ? _____________________________________________________________
024930050617      *? *                                                             *
024931050617      *? *        Process Cobra (compare amounts)                      *
024932050617      *? *_____________________________________________________________*
024933050617     C     ProcCOBRA     BEGSR
024934050617     C     WKINV#        Chain     INVCOB
024935050617     C                   If        Not %Found(INVCOB)
024936050617     C                   Eval      Error     =    Yes
024937050617     C                   Eval      WKERROR   =    Inv_Msg
024938050617     C                   Else
024939050617     C                   Z-add     ICTRAMT       WKINVAM
024940050617     C                   If        WKINVAM  <>   WKCHKAM
024941050617     C                   If        WKERROR  =    *Blanks
024942050617     C                   Eval      WKERROR  =  Amt_Msg
024943050617     C                   End
024944050617     C                   End
024945050617     C                   End
024946050617     C                   ENDSR
024947050509      * ? _____________________________________________________________
024948050509      *? *                                                             *
024949050509      *? *        Write Excel Spreadsheet Title to CSV File            *
024950050509      *? *_____________________________________________________________*
024951050509     C     WriteSpTitle  BEGSR
024952050509     C*
024953050509     C                   Eval      WKRECORD  =   '"' +   'Status'  + '","' +
024954050509     C                                                'Tran Date'  + '","' +
024955050526     C                                                 'Received'  + '","' +
024956090805     C                                                'Trust Cat'  + '","' +
024957050509     C                                                       TSA   + '","' +
024958050617     C                                                    'Cobra'  + '","' +
024959050617     C                                             'Account Name'  + '","' +
024960050510     C                                                       'AA'  + '","' +
024961050509     C                                                   'Check#'  + '","' +
024962050509     C                                             'Check Amount'  + '","' +
024963050509     C                                                 'Invoice#'  + '","' +
024964050616     C                                                   'Source'  + '","' +
024965050616     C                                                   'Batch#'  + '","' +
024966050509     C                                           'Invoice Amount'  + '","' +
024967050509     C                                                    'Error'  + '",'
024968050509     C                   Write     RP380CSR
024969050509     C*
0249700505090320 C                   ENDSR
029600000118      * ? _____________________________________________________________
029700000118      *? *                                                             *
029800000118      *? *        Initialize.                                          *
029900000118      *? *_____________________________________________________________*
030000991116     C     *INZSR        BEGSR
030100001012
030101050616    ?C     *LIKE         Define    INENDB        EndBal                         RECORD DS
030105050616      *
030106050505     C     *DATE         Mult      10000.0001    Today             8 0
031106010718
031111050505     C     InvKey        Klist
031112050509     C                   Kfld                    WKTRST
031113050509     C                   Kfld                    WKSUB#
031114050509     C                   Kfld                    WKACCT
031115050506     C                   Kfld                    WKINV#
031123050509     C                   Exsr      WriteSpTitle
032000991229
032800991020     C                   ENDSR
