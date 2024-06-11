000100001107     H Indent ('| ')
000200990630      *? ***************************************************************
000300050509      *             GROUP BENIFIT SERVICES SOFTWARE           2005     *
000400010322      *                                                                *
000500000118      *  Written by:    S. Zien                                        *
000600050505      *  Date Written:   5/5/05                                        *
000700050509      *  Description:   Payment Posting Audit Spreadsheet - Phase I    *
000800000118      *                                                                *
000900000118      *                                                                *
001000000118      *                R E V I S I O N    H I S T O R Y                *
001100000118      *  Date                                                          *
001200000118      *  Revised   Initials    Revision                                *
001300000118      *  --------  --------    --------------------------------------  *
001400050505      *   5/05/05    szz       Initial version.                        *
001401050616      *   6/15/05    szz       Still initial version but specs have    *
001402050616      *                         changed.  Need to use a different way  *
001403050616      *                         to determine manual posts.             *
001404050620      *   6/20/05              New specs, cont. COBRA is included.     *
001405050621      *                        Blank out account name p/Carol F.       *
001406050621      *                        Format dates p/Dave K.                  *
001407070808      *   8/08/07    szz       Define invoice number as 7 instead of 6.*
001408131003      * 10/03/13 dlk - hist file expansion project
001500001211      *                                                                *
001600001106      *                                                                *
001700990630      *? ***************************************************************
001800010322
001901050506     FHIST      IF   E           K Disk
001902050506     FACCMST    IF   E           K Disk
001903050620     FMEMBER    IF   E           K Disk
001904050616     FGBSECURE  IF   E           K Disk
002300050506     FRP380WK   UF A E           K Disk
002400991020
002401010117     D                UDS
002402010118     D  CONAME               201    250
002500991230    ? * Program status data structure
002600991230    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003101010322
003102010322     D                 DS
003103050506     D TSA                     1     10  0
003104050505     D  HSTRST                 1      3  0
003105050505     D  HSSUB#                 4      6  0
003106050505     D  HSACCT                 7     10  0
003107050505     D                 DS
003108050505     D Note                                Inz(*Blanks)
003109050506     D  Chk#                         10    Overlay(Note:1)
003110050506     D  Chk$                         10    Overlay(Note:20)
003111050505     D                 DS
003112050509     D NOTE2                               Inz(*Blanks)
003113070808     D  Inv#                          7    Overlay(NOTE2:17)
003114050616     D  Batch                         3    Overlay(NOTE2:28)
003115050506
003116050506     D                 DS
003117050506     D  CheckNote              1     30
003118050506     D  DollarSign            20     30
003119050509     D   OHTs                 21     26
003120050509     D   TTs                  22     26
003121050509     D   OTs                  23     26
003122050509     D   OHs                  24     26
003123050509     D   Tens                 25     26
003124050509     D   Ones                 26     26
003125050509     D   DecimalP             27     27
003126050509     D   Cents                28     29
003127050509     D   BlankSpace           30     30
003128050509      *
003129050509     D                 DS
003130050509     D  NumFormat              1      8
003131050509     D   N_OHTs                1      8
003132050509     D   N_TTs                 2      8
003133050509     D   N_OTs                 3      8
003134050509     D   N_OHs                 4      8
003135050509     D   N_Tens                5      8
003136050509     D   N_Ones                6      8
003137050509     D   N_Cents               7      8
003138050509      *
003144050509     D Pos             S              3S 0
003145050509     D End             S              3S 0
003146050509     D Siz             S              3S 0
003147050620     D TrdateN         S              8S 0
003148050620     D RecvdtN         S              8S 0
003149050509     D ManualPost      S              1    Inz('N')
003150050509     D No              S              1    Inz('N')
003151050509     D Yes             S              1    Inz('Y')
003152050511     D Active          S             10    Inz('ACTIVE')
003153050511     D Cancelled       S             10    Inz('CANCELLED')
005702050509     D NotOnFile       C                   'Account not on file.'
005800991229
005900000118      *---
006000050506      *? Phase I:  Build workfile by invoice#
006100000118      *---
006104050505     C                   Read      HIST
006105050623     C                   Dow       Not %Eof(HIST)
006109050509     C                   Exsr      ScanForMan
006110050616     C                   If        ManualPost =  No
006112050505     C                   Exsr      Process
006113050616     C                   End
006114050509     C                   Reset                   CheckNote
006115050509     C                   Reset                   NumFormat
006116050509     C                   Reset                   Note
006117050505     C                   Read      HIST
006119050505     C                   Enddo
006120050505
009200050505     C                   Eval      *InLR = *On
009202050506      * ? _____________________________________________________________
009203050506      *? *                                                             *
010501050506      *? *        Process:  Compress history records by invoice#.      *
010502050506      *? *_____________________________________________________________*
010503050506     C     Process       BEGSR
010504050509     C                   Z-Add     *Zeros        Pos
010505050506     C                   Eval      Note      =   CK#NOT
010506050505     C                   Clear                   WKERROR
010507070808     C     ' ':'0'       Xlate     Inv#          WKINV#A           7
010508050506     C     ' ':'0'       Xlate     Chk#          WKCHK#A          10
010510050616     C                   Movel     Batch         WKBATCH
010511050506     C                   Move      WKINV#A       WKINV#
010512050506     C                   Move      WKCHK#A       WKCHK#
010513050506     C     Wk_Key        Chain     RP380WK
010514050506      *---
020600050506      * Move HIST fields to workfile fields
020601050506      *---
020603050509     C                   Eval      WKTRST   =    HSTRST
020604050509     C                   Eval      WKSUB#   =    HSSUB#
020605050509     C                   Eval      WKACCT   =    HSACCT
020607050620     C     TRDATE        Mult      10000.0001    TrdateN
020609050620     C                   Eval      WKTRDAT  =    %Editw(TrdateN:'  /  /    ')
020611050620     C     RECVDT        Mult      10000.0001    RecvdtN
020613050620     C                   Eval      WKRCVDT  =    %Editw(RecvdtN:'  /  /    ')
020616050620     C                   If        WKACSTS  =    *Blanks
020617050621     C                   If        WKCOBRA  =    *Blanks
020618050621     C                   Eval      WKTSA    =    %Editw(TSA:'   -   -    ')
020619050509     C     AccKey        Chain     ACCMST
020620050509     C                   If        %Found(ACCMST)
020621050511     C                   If        ATRMDT   =    *Zeros    Or
020622050511     C                             ATRMDT   >    Today
020623050511     C                   Eval      WKACSTS  =    Active
020624050511     C                   Else
020625050511     C                   Eval      WKACSTS  =    Cancelled
020626050511     C                   End
020627050509     C                   Eval      WKACNAM  =    ACNAM1
020628050509     C                   Else
020629050509     C                   Eval      WKACNAM  =    NotOnFile
020630050509     C                   End
020631050620     C                   Else
020632050620     C                   Eval      WKACNAM  =    *Blanks
020633050621     C                   End
020634050620     C                   End
020635050509     C                   Eval      WKAA     =    AACODE
020636050616      *---
020637050616      * Find "operator" in the GBSECURE file for source field
020638050616      *---
020639050616     C                   Movel     HOPER         SecKey           10
020640050616     C     SecKey        Chain     GBSECURE
020641050616     C                   If        %Found(GBSECURE)
020642050616     C                   Eval      WKSOURC   =   SCNAME
020643050616     C                   Else
020644050616     C                   Eval      WKSOURC   =   'NotOnFile'
020645050616     C                   End
020646050506      *---
020647050506      * Isolate invoice amount from the CK#NOT field
020648050506      *---
020649050506     C                   Move      CK#NOT        CheckNote
020650050506     C                   Eval      Pos = %Scan('$':CK#NOT)
020651050509     C                   Move      Cents         N_Cents
020652050506     C                   Select
020653050506     C                   When      Pos = 20
020654050509     C                   Movel     OHTs          N_OHTs
020655050506     C                   When      Pos = 21
020656050509     C                   Movel     TTs           N_TTs
020657050506     C                   When      Pos = 22
020658050509     C                   Movel     OTs           N_OTs
020659050506     C                   When      Pos = 23
020660050509     C                   Movel     OHs           N_OHs
020661050506     C                   When      Pos = 24
020662050509     C                   Movel     Tens          N_Tens
020663050506     C                   When      Pos = 25
020664050509     C                   Movel     Ones          N_Ones
020665050506     C                   Other
020666050509     C                   Move      *Zeros        NumFormat
020667050506     C                   Eval      WKERROR   =   'Warning: No Check Amount.'
020668050506     C                   EndSl
020669050509     C                   Z-Add     *Zeros        TmpChkAm         10 2
020670050509     C                   Move      NumFormat     TmpChkAm
020671050509     C                   Add       TmpChkAm      WKCHKAM
020672050506      *
020673050509     C                   Eval      WKINVAM   =   *Zeros
020674050506     C                   Eval      WKERROR   =   *Blanks
020675050506      *---
020676050617      * Determine if Invoice#/Check# combination is already in the file
020677050506      *---
020678050506     C                   If        %Found(RP380WK)
020679050506     C                   Update    RP380WKR
020680050506     C                   Else
020681050506     C                   Move      WKINV#A       WKINV#
020682050506     C                   Move      WKCHK#A       WKCHK#
020684050506     C                   Write     RP380WKR
020686050506     C                   End
020687050509     C                   Reset                   RP380WKR
020700050505     C                   EndSr
024819050509      * ? _____________________________________________________________
024820050509      *? *                                                             *
024821050617      *? *  Scan for manual postings and whether it's COBRA.           *
024822050509      *? *_____________________________________________________________*
024823050509     C     ScanForMan    BEGSR
024824050509     C                   Eval      ManualPost =  No
024825050616      *
024826131003     C                   If        HPRGNM     =  'TR30      '    Or
024827131003     C                             HPRGNM     =  'TR15      '
024828050616     C                   Eval      ManualPost =  Yes
024829050616     C                   End
024830050623     C                   If        ManualPost =  No
024831050509      *---
024832050509      * If HKEY is the same as account, it's an account otherwise a member.
024833050509      *---
024834050617     C     ' ':'0'       Xlate     HKEY          HKeyN            10
024835050617     C                   Move      HKeyN         HKeyCmp          10 0
024836050620     C                   Move      HKeyCmp       SS#               9 0
024837050617     C                   If        HKeyCmp    <> TSA
024838050620     C                   Eval      WKCOBRA    =  %Editw(SS#:'   -  -    ')
024839050620     C     SS#           Chain     MEMBER
024840050620     C                   If        %Found(MEMBER)
024841050622     C                   Eval      WKACNAM    =  %Trim(MFNAME) + ' ' +
024842050622     C                                           %Trim(MMI) + '.' + ' ' +
024843050622     C                                           %Trim(MLNAME)
024844050620     C                   If        TERMDT     =  *Zeros   Or
024845050620     C                             TERMDT     >  Today
024846050620     C                   Eval      WKACSTS    =  Active
024847050620     C                   Else
024848050620     C                   Eval      WKACSTS    =  Cancelled
024849050620     C                   End
024850050620     C                   Else
024851050620     C                   Eval      WKACSTS    =  'UNKNOWN'
024852050620     C                   End
024853050617     C                   Else
024854050617     C                   Eval      WKCOBRA    =  *Blanks
024855050617     C                   End
024856050623     C                   End
024857050509      *
024862050509     C                   Eval      Pos = %Scan('APPLY':CK#NOT)
024863050509     C                   If        Pos <> *Zeros
024864050509     C                   Eval      ManualPost = Yes
024865050509     C                   End
024866050509      *
024867050509     C                   Eval      Pos = %Scan('#':CK#NOT)
024868050509     C                   If        Pos <> *Zeros
024869050509     C                   Eval      ManualPost = Yes
024870050509     C                   End
024871050509
024872050509     C                   ENDSR
029600000118      * ? _____________________________________________________________
029700000118      *? *                                                             *
029800000118      *? *        Initialize.                                          *
029900000118      *? *_____________________________________________________________*
030000991116     C     *INZSR        BEGSR
030100001012
030101050505     C     *DATE         Mult      10000.0001    Today             8 0
031106010718
031111050505     C     InvKey        Klist
031112050505     C                   Kfld                    HSTRST
031113050505     C                   Kfld                    HSSUB#
031114050505     C                   Kfld                    HSACCT
031115050506     C                   Kfld                    WKINV#
031116050506     C     Wk_Key        Klist
031117050506     C                   Kfld                    WKINV#
031118050506     C                   Kfld                    WKCHK#
031119050509     C     AccKey        Klist
031120050509     C                   Kfld                    HSTRST
031121050509     C                   Kfld                    HSSUB#
031122050509     C                   Kfld                    HSACCT
032000991229
032800991020     C                   ENDSR
