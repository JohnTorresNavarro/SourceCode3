0001000204020002  *****************************************************************************
000200230502      * MBRFBDR    Amwins                                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400230501      *            DATE - 05/2023                                                 *
000500230501      *  DESCRIPTION - Build file of duplictes in Member                          *
0006000204020002  *****************************************************************************
0007000809080015  *  Change Log:                                                              *
000800230501      *  mm/dd/yyyy xxx
0009009102150018 F******************************************************************
001300100113     FMEMBER    IF   E           K DISK
001301230502     FHISTAA    IF   E           K DISK
001500230502     FMBRLSTP   O    E             DISK
0021000809160025  *
002901230501      *
0029022305010250 D                 DS
0029032305010251 D  mlname                 1     18
0029042305010251 D   lnam3                 1      3
002905230501      *
0029062305010250 D                 DS
0029072305010251 D  xmlname                1     18
0029082305010251 D    xlnam3               1      3
002909230501      *
0029102305010250 D                 DS
0029112305010251 D  wkacct                 1     22
0029122305010251 D    gtrst                1      3
0029132305010251 D    gd1                  4      4    INZ('-')
0029142305010251 D    gsub                 5      7
0029152305010251 D    gd2                  8      8    INZ('-')
0029162305010251 D    gacct                9     12
002917230501      *
0030000809160250 D                 DS
003001230501     D wkdatn          S              8  0
003002230501     D wkdat           S               D
003003230501     D usadt           S               D   DATFMT(*USA/)
003004230502     D trc             S              3    INZ('MMA')
003005230501     D mbrp            S              1A
003900091012      *
005402230501      *
005403230502     C     hisky         klist
005404230502     C                   kfld                    ss10             10
005405230502     C                   kfld                    trc
009800091002      *
0099002305010291  * Main Line - Loop MEMBER by SSN
0100002305010297 C     *loval        setll     member                             21
0101001001130296 C                   dou       *in21 = '1'
0102002305010297 C                   read      member                                 21
0103002305010296 C                   If        *in21 = '0'
0103012305010291  *
010302230502     C                   if        mbenrl = termdt
0103052305010296 C                   iter
0103062305010296 C                   endif
0103072305020291  *
010308230502     C                   if        mbssno = 219766877 or mbssno = 358748174
0103092305020296 C                   iter
0103102305020296 C                   endif
0103112305020291  *
010312230502     C                   if        mbssno = 273350374
0103132305020296 C                   iter
0103142305020296 C                   endif
0103152305010291  *
0103362305010291  *         Populate MBRDUP with MEMBER data
010337230502     C                   clear                   mbrlstr
010338230501     C                   eval      mdssn = mbssno
010339230501     C                   movel     mlname        mdlnam
010340230501     C                   movel     mfname        mdfnam
0103492305010107  *
010350230501     C                   move      mmi           mdmi
010351230501     C                   move      sex           mdsex
010352230501      *  Format Emp's TSA
010353230501    4C                   movel     mbtrst        gtrst
010354230501    4C                   movel     mbsub#        gsub
010355230501    4C                   movel     mbacct        gacct
010356230501    4C                   movel     wkacct        mdacct
010357230501      *  Format DOB
010358230501     C                   if        birth <> 0
010359230501     C                   eval      wkdatn = birth
010360230501     C                   movel     wkdatn        wkdat
010361230501     C                   eval      usadt = wkdat
010362230501     C                   movel     usadt         mddob
010363230501     C                   endif
010364230501      *  Format Enroll Dt
010365230501     C                   if        mbenrl <> 0
010366230501     C                   eval      wkdatn = mbenrl
010367230501     C                   movel     wkdatn        wkdat
010368230501     C                   eval      usadt = wkdat
010369230501     C                   movel     usadt         mdenrl
010370230501     C                   endif
010371230501      *  Format Term Dt
010372230501     C                   if        termdt <> 0
010373230501     C                   eval      wkdatn = termdt
010374230501     C                   movel     wkdatn        wkdat
010375230501     C                   eval      usadt = wkdat
010376230501     C                   movel     usadt         mdterm
010377230501     C                   endif
0103782305010107  *
010379230502     C                   movel     addr1         mdaddr1
010380230502     C                   movel     addr2         mdaddr2
010381230502     C                   movel     city          mdcity
010382230502     C                   movel     state         mdst
010383230502     C                   movel     zip           mdzip
0103852305020291  *        Chk for HIST
010387230502     C                   move      mbssno        ss10
0103882305020297 C     hisky         chain     histaa                             25
0103892305020296 C                   If        *in25 = '0'
010390230502     C                   movel     hoper         mdoper
0103922305020296 C                   endif
0103932305020107  *
010394230502     C                   write     mbrlstr
0103952305010296 C                   eval      mbrp = 'Y'
0103962305010291  *
0103972305010296 C                   endif
0103982305020291  *
0103992305020296 C                   enddo
0104002305020291  *
0171000808040291  *
0172000808040297 C                   movel     '1'           *inlr
0173000808040297 C                   return
