000100990825      *---------------------------------------------------------------**
000200990929      * COB340     GROUP BENEFIT SERVICES SOFTWARE           1999      *
000300990825      *                                                                *
000400990825      *            WRITTEN BY - KIMBERLY S. JOHNSON                    *
000500990922      *            DATE - 09/22/99                                     *
000600990825      *                                                                *
000700990922      *  DESCRIPTION - THIS PROGRAM WILL LIST CHANGED MEMBER           *
000800990922      *                TERM DATE BASED UPON DATE.                      *
000900990825      *                                                                *
000901130220      * 02/20/13 dlk - fix name error and change hard coded list of    *
000902130220      *                plan categories to look for the plan category   *
000903130220      *                type the way the letters do.                    *
000904141103      * 11/03/14 dlk - change the way from - to dates are found in hist*
001000990825      *---------------------------------------------------------------**
001100990825     FHIST      IF   E           K DISK
001200971024     FACCMST    IF   E           K DISK
001201990923     FPLNMST    IF   E           K DISK
001202990924     FMEMBER    IF   E           K DISK
001203130220     Fcodesl1   IF   E           K DISK
001300990922     FCOB340P   O    E             PRINTER OFLIND(*IN80)
001400990825
001500990825      * LDA
001600990825     D                UDS
001700130221     D  LFMDATc               11     18
001800130221     D  LTODATc               19     26
001900990825     D  CONAME               201    240
002000990825
002004990923
002005990927     D                 DS
002006990927     DPRVDTE                   1      8
002007130221     DPRVDT                    1      8S 0 inz
002008141103     D                 DS
002009141103     Dnote2                   26     55
002010141103     D note2_frdt             32     39
002011141103     D note2_todt             48     55
002012990927
002013990927     D                 DS
002014990927     DNEWDTE                   1      8
002015130221     DNEWDT                    1      8S 0 inz
002016990927
002017990927     D                 DS
002018130221     DACCTNUM                  1     10S 0 inz
002019130221     DACTRST                   1      3S 0
002020990927     DACSUB#                   4      6S 0
002021990927     DACACCT                   7     10S 0
002022990927
002100990825     DMMDD#            S              4
002200990825     DCCYY#            S              4
002300990825     DMDCY#            S              8
002400990825     DCYMD#            S              8
002500990825     DCOUNT            S              4  0
002600990825     DLFMYMD           S              8  0
002700990825     DLTOYMD           S              8  0
002701990923     DPLAN             S              4
002702990924     DX                S              1  0
002703990927     DY                S              2  0
002800990825
002900990825      *-----------------------------------------------------
003000971024     C     HISKEY        KLIST
003100971024     C                   KFLD                    HSTRST
003200971024     C                   KFLD                    HSSUB#
003300971024     C                   KFLD                    HSACCT
003400990825
003401990923     C     PLNKEY        KLIST
003402990923     C                   KFLD                    HSTRST
003403990923     C                   KFLD                    HSSUB#
003404990923     C                   KFLD                    PLAN
003405990923
003500990825     C                   READ      HISTR                                  99
003600990825     C                   DOW       *IN99 = *OFF
003700990322     C                   IF        TRDATE >= LFMYMD
003800990322     C                             AND TRDATE <= LTOYMD
003900130220     C     HISKEY        CHAIN     ACCMST
003901130220     C                   IF        %found(accmst)
004001990923     C                   IF        FCSTFL = 'S' OR FCSTFL = 'F'
004002990927     C                   EVAL      PLAN = CK#NOT
004003130220
004004130220     C     PLNKEY        CHAIN     PLNMST
004005130220     C                   IF        %found(plnmst)
004006130220     C     plncat        CHAIN     codesl1
004007130220
004008130220      * select all the plan types valid for letters
004009130220
004010130220     C                   IF        %found(codesl1) and
004011130220     c                             (action = 'M' or action = 'D' or
004012130220     c                              action = 'V' or action = 'R' or
004013130220     c                              action = 'B' or action = 'I' or
004014130220     c                              action = 'F')
004017130221     C                   MOVE      HKEY          SS#
004018130220     C                   clear                   NAME
004019130221     C     SS#           CHAIN     member
004020130220     C                   IF        %found(member)
004021990924     C     MFNAME        CAT       MMI:1         NAME
004022990927     C                   IF        MMI <> *BLANKS
004023990924     C                   CAT       '.':0         NAME
004024990927     C                   ENDIF
004025990924     C                   CAT       MLNAME:1      NAME
004026141103      * from & to date
004027141103     C                   MOVE      note2_frdt    CYMD#
004028141103     C                   EXSR      #CYMD8
004029141103     C                   MOVE      MDCY#         PRVDT
004030141103
004031141103     C                   MOVE      note2_todt    CYMD#
004032141103     C                   EXSR      #CYMD8
004033141103     C                   MOVE      MDCY#         NEWDT
004034141103
004035141103     C*    'From-'       SCAN      NOTE2         X
004036141103     C*                  IF        X <> 0
004037141103     C*                  EVAL      Y = X + 5
004038141103     C*    8             SUBST     NOTE2:Y       PRVDTE
004039141103     C*                  MOVE      PRVDT         CYMD#
004040141103     C*                  EXSR      #CYMD8
004041141103     C*                  MOVE      MDCY#         PRVDT
004042141103     C*                  EVAL      Y = Y + 8
004043141103     C*    ' '           CHECK     NOTE2:Y       Y
004044141103     C*    8             SUBST     NOTE2:Y       NEWDTE
004045141103     C*                  MOVE      NEWDT         CYMD#
004046141103     C*                  EXSR      #CYMD8
004047141103     C*                  MOVE      MDCY#         NEWDT
004048141103
005301990924     C                   IF        *IN80 = *ON
005302990924     C                   WRITE     HEAD
005303990924     C                   EVAL      *IN80 = *OFF
005304990924     C                   ENDIF
005400990825     C                   WRITE     DETL
005401990927     C                   CLEAR                   DETL
005402990927     C                   CLEAR                   X
005403990923     C                   EVAL      COUNT = COUNT + 1
005500141103     C*                  ENDIF
005501990927     C                   ENDIF
005600990825     C                   ENDIF
005601990923     C                   ENDIF
005602990923     C                   ENDIF
005603990923     C                   ENDIF
005604990923     C                   ENDIF
005700990825     C                   READ      HISTR                                  99
005800990825     C                   ENDDO
005900990825
006000990826     C                   IF        COUNT > 0
006100990825     C                   IF        *IN80 = *ON
006200990825     C                   WRITE     HEAD
006300990825     C                   EVAL      *IN80 = *OFF
006400990825     C                   ENDIF
006500990825     C                   EVAL      TOTCNT = COUNT
006600990825     C                   WRITE     LRCNT
006700990826     C                   ENDIF
006800990825     C                   EVAL      *INLR = *ON
006900990825      *------------------------------------------------------
007000990825      * Rearrange date / ccyymmdd to mmddccyy
007100990825      *****************************************************
007200981027     C     #CYMD8        BEGSR
007300990825     C                   MOVE      CYMD#         MMDD#
007400990825     C                   MOVEL     CYMD#         CCYY#
007500990825     C                   MOVEL     MMDD#         MDCY#
007600981027     C                   MOVE      CCYY#         MDCY#
007700981027     C                   ENDSR
007800981027      **-------------------------------------------------**
007900981027      * Convert dates from mmddccyy to ccyymmdd
008000981027      **-------------------------------------------------**
008100990825     C     #MDCY8        BEGSR
008200990825     C                   MOVEL     MDCY#         MMDD#
008300990825     C                   MOVE      MDCY#         CCYY#
008400990825     C                   MOVE      MMDD#         CYMD#
008500981027     C                   MOVEL     CCYY#         CYMD#
008600981027     C                   ENDSR
008700981026     C*****************************************************************
008900981026     C     *INZSR        BEGSR
009000990825     C                   Z-ADD     0             COUNT
009100130221     C                   MOVE      LFMDATc       MDCY#
009200981027     C                   EXSR      #MDCY8
009300990825     C                   MOVE      CYMD#         LFMYMD
009400130221     C                   MOVE      LTODATc       MDCY#
009500981027     C                   EXSR      #MDCY8
009600990825     C                   MOVE      CYMD#         LTOYMD
009601130221
009602130221     C                   MOVE      LFMDATc       lfmdat
009603130221     C                   MOVE      LTODATc       ltodat
009604130221
009700141103     C*                  EVAL      *IN80 = *ON
009701130221     C                   WRITE     HEAD
009800981026     C                   ENDSR
009900990825      *****************************************************************
