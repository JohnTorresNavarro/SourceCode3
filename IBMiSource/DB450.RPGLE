000100001107     H Indent ('| ')
000200990630      *? ***************************************************************
000300050302      *             GROUP BENIFIT SERVICES SOFTWARE           2005     *
000400010322      *                                                                *
000500000118      *  Written by:    S. Zien                                        *
000600050624      *  Date Written:  6/24/05                                        *
000700050624      *  Description:   AD&D Plan Audit                                *
000800000118      *                                                                *
000900000118      *                                                                *
001000000118      *                R E V I S I O N    H I S T O R Y                *
001100000118      *  Date                                                          *
001200000118      *  Revised   Initials    Revision                                *
001300000118      *  --------  --------    --------------------------------------  *
001301050705      *   7/5/05   szz         Don't show on the audit report if the   *
001302050705      *                         NONEMP field is Y. Per Dave K.         *
001400050302      *                                                                *
001401050802      *   8/02/05  szz         Exclude Cobra per Lisa K.               *
001402050802      *                                                                *
001403051003      *  10/03/05  szz         Exclude Ineligible-for-AD&D from report.*
001404051003      *                                                                *
001500001211      *                                                                *
001600001106      *                                                                *
001700990630      *? ***************************************************************
001800010322
001900050302     FACCMST    IF   E           K Disk
001901050302     FMEMAC#    IF   E           K Disk
002000050302     FMCOV      IF   E           K Disk
002100050302     FPLNMST    IF   E           K Disk
002101050310     FDECLIF    IF   E           K Disk
002102050311     FAACODE    IF   E           K Disk
002103050624     FDB450XL   O  A E             DISK
002300050624     FDB450P    O    E             Printer Oflind(*In91)
002400991020
002401010117     D                UDS
002402050310     D  LDet                   1      1
002403050310     D  LAcctot                2      2
002404050310     D  LSmantot               3      3
002405050310     D  LAdminonly             4      4
002406050310     D  LAA                    5      7
002407050310     D  LXL                    8      8
002408010118     D  CONAME               201    250
002500991230    ? * Program status data structure
002600991230    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002601050310     D AgeBand       E DS                  Extname(DECLIF)
002603050310     D  A@FROM                11     50P 0 Dim(20)
002604050310     D  A@TO                  71    110P 0 Dim(20)
002605050310     D                 DS
002606050310     D BIRTH                   1      8  0
002607050310     D  BYR                    1      4  0
002608050310     D  BMO                    5      6  0
002609050624     D Pos             S              3S 0
002610050624     D ADDCtr          S              1  0 Inz
002701050302     D MemLifeCtr      S              1  0 Inz
002705050302     D YesLifCtr       S              7  0 Inz
002706050418     D YesLifAcc       S              7  0 Inz
002707050302     D NoLifCtr        S              7  0 Inz
002708050307     DCSV              C                   Const('","')
002709050311     IACCMSR
002710050311     I              AACODE                      A_AACODE
002711050302
006200050302     C                   Read      ACCMST
006300050302    ?C                   Dou       %Eof(ACCMST)
006400050302     C                   If        Not %Eof(ACCMST)
006401050302     C                   If        ATRMDT = *Zeros  Or
006402050302     C                             ATRMDT > Today
006403050308     C                   If        LAdminonly = 'Y'
006404050308     C                   Move      ACTRST        Trust
006405050308     C                   Move      ACSUB#        Sub#
006406050308     C                   Move      ACACCT        Account
006407050310     C                   Clear                   Plan
006408050309     C                   Call      'DB440U'
006409050308     C                   Parm                    Trust             3
006410050308     C                   Parm                    Sub#              3
006411050308     C                   Parm                    Account           4
006412050308     C                   Parm                    HaveLife          1
006413050310     C                   Parm                    Plan              4
006414050617     C     PKey          Chain     PLNMST
006415050617     C                   If        %Found(PLNMST)
006416050617     C                   Eval      PLAND    =    PDESCR
006417050617     C                   End
006418050617     C                   Else
006419050617     C                   Eval      PLAND       = *Blanks
006420050308     C                   End
006421050308     C                   If        (LAdminonly =  'Y'      And
006422050308     C                             HaveLife    =  'Y')      Or
006423050308     C                             LAdminonly  =  'N'
006424050302     C                   If        LIFPCT = 100
006425050303     C     KMem          Setll     MEMAC#
006426050302     C                   Dou       %Eof(MEMAC#)
006427050303     C     KMem          Reade     MEMAC#
006428050302     C                   If        Not %Eof(MEMAC#)
006429050302     C                   Eval      MemLifeCtr =  *Zeros
006430050624     C                   Eval      ADDCtr     =  *Zeros
006431051003     C                   Move      INELIG        INADD             1
006432050705     C                   If        NONEMP     =  *Blanks
006433050802     C                   If        EMPST     <> 'C'
006434051003     C                   If        INADD      =  *Blanks
006435050302     C                   Exsr      Process
006436051003     C                   End
006437050802     C                   End
006438050705     C                   End
006439050302     C                   End
006440050302     C                   Enddo
006441050302     C                   End
006442050302     C                   End
008300050302     C                   End
008301050302     C     *In91         Ifeq      *On
008302050302     C                   Write     HDR
008303050302     C                   Write     SUB
008304050302     C                   Eval      *In91      = *Off
008305050302     C                   End
008307050309     C                   If        NoLifCtr   >  *Zeros
008308050307     c                   If        Lacctot = 'Y'
008309050624     C****************** Add       YesLifAcc     YESLIFTOT
008310050302     C                   Write     ACCTOT
008311050307     C                   End
008313050308     C                   End
008314050302     C                   End
008315050418     C                   Eval      YesLifAcc  =  *Zeros
008316050418     C                   Eval      YesLifCtr  =  *Zeros
008317050309     C                   Eval      NoLifCtr   =  *Zeros
008400050302     C                   Read      ACCMST
008600001109    ?C                   Enddo
008601050418     C                   Write     RTOT
009100001211     C                   Write     EOR
009200050302     C                   Eval      *InLR = *On
009202050302      * ? _____________________________________________________________
009203050302      *? *                                                             *
009204050302      *? *        Process                                              *
009206050302      *? *_____________________________________________________________*
010500050302     C     Process       BEGSR
010601050302    ? *
010602050303     C                   If        (TERMDT  =  *Zeros Or
010603050303     C                             TERMDT   >  Today) And
010604050303     C                             CEXPDT   =  *Zeros                           Not Cobra
010605050303     C     MBSSNO        Setll     MCOV
010606050303     C                   Dou       %Eof(MCOV)
010607050303     C     MBSSNO        Reade     MCOV
010608050303     C                   If        Not %Eof(MCOV)
010609050624     C                   If        CANDT     =   *Zeros Or
010610050624     C                             CANDT     >   Today
010611050624     C                   Z-add     *Zeros        Pos
010612050302     C     KPln          Chain     PLNMST
010613050302     C                   If        %Found(PLNMST)
010614050624     C                   If        PLNCAT    =   'PLF'
010615050624     C                   Add       1             MemLifeCtr
010616050624     C                   Eval      Pos       =   %Scan('AD&D':PDESCR)
010617050624      *---
010618050624      * If it is LF but includes AD&D, don't need to show it on report.
010619050624      *---
010620050624     C                   If        Pos       <>  *Zeros
010621050624     C                   Add       1             ADDCtr
010622050624     C                   Leave
010623050624     C                   End
010624050624      *
010625050302     C                   End
010626050624      *
010627050624     C                   If        PLNCAT  =  'PAC'
010628050624     C                   Add       1             ADDCtr
010629050624     C                   End
010630050302     C                   End
010631050302     C                   End
010632050302     C                   End
010633050624      *---
010634050624      * Once a member has been found to have Life & ADD, leave.
010635050624      *---
010636050624     C                   If        MemLifeCtr <> *Zeros    And
010637050624     C                             ADDCtr     <> *Zeros
010638050624     C                   Leave
010639050624     C                   End
010640050303     C                   Enddo
010641050311     C                   If        MemLifeCtr <> *Zeros
010642050311     C                   Exsr      DetElgLif
010643050311     C                   End
010644050624     C                   If        MemLifeCtr <> *Zeros     And
010645050624     C                             ADDCtr     =  *Zeros
010646050303     C                   Add       1             NoLifCtr
010647050418     C                   Add       1             NOLIFTOT
010648050307     C                   If        LDet = 'Y'
010649050303     C                   Exsr      WriteDetail
010650050307     C                   End
010651050307      * Write to spreadsheet if requested
010652050307     C                   if        LXL = 'Y'
010653050307     C                   Exsr      WriteXLDet
010654050307     C                   End
010655050303     C                   Else
010656050418     C                   Add       1             YesLifCtr
010657050418     C                   Add       1             YesLifAcc
010658050303     C                   End
010659050302     C                   End
010660050302    ? *
020700050302     C                   Endsr
020701050302      * ? _____________________________________________________________
020702050302      *? *                                                             *
020703050302      *? *        Write Detail Record                                  *
020704050302      *? *_____________________________________________________________*
020705050302     C     WriteDetail   BEGSR
020706050302    ? *
020707050302     C     *In91         Ifeq      *On
020708050302     C                   Write     HDR
020709050302     C                   Write     SUB
020710050302     C                   Eval      *In91      = *Off
020711050302     C                   End
020712050310      *
020713050310     C     *Year         Sub       BYR           AGE
020714050310     C     UMONTH        Ifne      12
020715050310     C     UMONTH        Iflt      BMO
020716050310     C                   Sub       1             AGE
020717050310     C                   End
020718050310     C                   End
020719050310      *
020720050302     C     MLNAME        Cat(P)    ',':0         MNAME
020721050302     C     MNAME         Cat(P)    MFNAME:1      MNAME
020722050302     C     MNAME         Cat(P)    MMI:1         MNAME
020723050302     C     MNAME         Cat(P)    '.':0         MNAME
020724050311      *
020725050311     C     A_AACODE      Chain     AACODE
020726050311     C                   If        %Found(AACODE)
020727050311     C     AFNAM         Cat(P)    ALNAM:1       AANAME
020728050311     C                   Else
020729050311     C                   Eval      AANAME    =   *Blanks
020730050311     C                   End
020731050302     C                   Write     DTL
020732050302    ? *
020733050302     C                   Endsr
020734050307      * ? _____________________________________________________________
020735050307      *? *                                                             *
020736050307      *? *        Spreadsheet Detail                                   *
020737050307      *? *_____________________________________________________________*
020738050307     C     WriteXLDet    BEGSR
020739050307
020740050624     c                   Clear                   DB450FLD
020741050624     C                   Eval      DB450FLD = '"' +
020742050307     C                             %Editw(ACTRST:'0  ')                 + CSV +
020743050307     C                             %Editw(ACSUB#:'0  ')                 + CSV +
020744050307     C                             %Editw(ACACCT:'0    ')               + CSV +
020745050307     C                             %Trim(ACNAM1)                        + CSV +
020746050311     C                             %Trim(AANAME)                        + CSV +
020747050307     C                             %Trim(MNAME)                         + CSV +
020748050307     C                             %Trim(%Editw(MBSSNO:'0   -  -    ')) + CSV +
020749050310     C                             %Trim(Plan)                          + CSV +
020750050624     C                             %Trim(PLAND)                         + CSV +
020751050310     C                             %Editw(AGE:'0  ')                    + CSV +
020752050311     C                             %Trim(NOTELIG)                       + CSV +
020753050307     C                             '",'
020754050307     C*
020755050624     C                   Write     DB450R
020756050310     C                   ENDSR
020757050307     C*
020758050310    ? *
020759050310      * ? _______________________________________________________________
020760050310      *? *                                                               *
020761050310      *? * Determine if Member is Eligible for Life by checking dec life *
020762050310      *? *_______________________________________________________________*
020763050310     C     DetElgLif     BEGSR
020764050310      *
020765050310     C     KPln          Chain     DECLIF
020766050310     C                   If        %Found(DECLIF)
020767050310     C                   Z-add     *Zeros        X                 3 0
020768050310     C                   For       X       =     20 DownTo 1
020770050311     C                   Eval      NOTELIG   =   ' '
020771050310     C                   If        A@FROM(X) <>  *Zero
020772050311     C                   If        A@TO(X)   <   AGE
020773050311     C                   Eval      NOTELIG   =   '*'
020775050311     C                   End
020776050310     C                   Leave
020777050310     C                   End
020778050310     C                   EndFor
020779050311     C                   Else
020781050310     C                   End
020782050310      *
020783050310     C                   Endsr
020784050307     C/EJECT
020785050307      * ? _____________________________________________________________
020786050307      *? *                                                             *
020787050307      *? *        Spreadsheet Heading                                  *
020788050307      *? *_____________________________________________________________*
020789050307     C     WriteXLHead   BEGSR
020790050307
020791050624     c                   Clear                   DB450FLD
020792050624     C                   Eval      DB450FLD = '"' + 'TRUST'         + csv +
020793050311     C                                        'SUB'                 + csv +
020794050311     C                                        'ACCOUNT'             + csv +
020795050311     C                                        'ACCOUNT NAME'        + csv +
020796050311     C                                        'ACCT ADMINISTRATOR'  + csv +
020797050311     C                                        'MEMBER NAME'         + csv +
020798050311     C                                        'MEMBER#'             + csv +
020799050311     C                                        'PLAN'                + csv +
020800050624     C                                        'PLAN DESCRIPTION'    + csv +
020801050311     C                                        'AGE'                 + csv +
020802050311     C                                        'NOT ELIG'            + '",'
020803050624     C                   Write     DB450R
020804050307     C*
020805050310     C                   ENDSR
029600000118      * ? _____________________________________________________________
029700000118      *? *                                                             *
029800000118      *? *        Initialize.                                          *
029900000118      *? *_____________________________________________________________*
030000050302     C     *Inzsr        Begsr
032000050302      *
032100050302     C     KMem          KLIST
032200050303     C                   KFLD                    ACTRST
032300050303     C                   KFLD                    ACSUB#
032400050303     C                   KFLD                    ACACCT
032407050302      *
032408050302     C     KPln          KLIST
032409050302     C                   KFLD                    ACTRST
032410050302     C                   KFLD                    ACSUB#
032411050302     C                   KFLD                    MCPLAN
032412050617     C*
032413050617     C     PKey          KLIST
032414050617     C                   KFLD                    ACTRST
032415050617     C                   KFLD                    ACSUB#
032416050617     C                   KFLD                    Plan
032417050617     C*
032501050302     C     *DATE         Mult      10000.0001    Today             8 0
032502050302     C                   Movel     Today         ThisYear          4
032503050309     C                   Eval      AASLCT    =   %Trim('AA Selection:') + ' ' +
032504050309     C                                            (LAA)
032505050309     C                   Eval      *In91     =   *On
032506050309     C                   If        LXL = 'Y'
032507050307     C                   Exsr      WriteXLHead
032508050307     c                   End
032700050302     C
032800050302     C                   Endsr
