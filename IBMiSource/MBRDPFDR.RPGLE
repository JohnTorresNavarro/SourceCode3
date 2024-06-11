0001000204020002  *****************************************************************************
000200230501      * MBRDPFDR   Amwins                                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400230501      *            DATE - 05/2023                                                 *
000500230501      *  DESCRIPTION - Build file of duplictes in Member                          *
0006000204020002  *****************************************************************************
0007000809080015  *  Change Log:                                                              *
000800230501      *  mm/dd/yyyy xxx
0009009102150018 F******************************************************************
001300100113     FMEMBER    IF   E           K DISK
001301230501     FMEMNAM    IF   E           K DISK    PREFIX(N) RENAME(MEMBR:MEMNR)
001400230501     FCFS100P   IF   E           K DISK
001500230501     FMBRDUPP   O    E             DISK
001600230501     FMBRDUPL   IF   E           K DISK    PREFIX(X) RENAME(MBRDUPR:MBRDUPX)
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
003004230501     D mbrp            S              1A
003900091012      *
005200100413      *
005300230501     C     namkey        klist
005400230501     C                   kfld                    mlname
005401230501     C                   kfld                    mfname
005402230501      *
005403230501     C     cf1ky         klist
005404230501     C                   kfld                    cf1ss             9 0
005405230501     C                   kfld                    cf1sq             2 0
009800091002      *
0099002305010291  * Main Line - Loop MEMBER by SSN
0100002305010297 C     *loval        setll     member                             21
0101001001130296 C                   dou       *in21 = '1'
0102002305010297 C                   read      member                                 21
0103002305010296 C                   If        *in21 = '0'
0103012305010291  *
0103022305010296 C                   If        mfname = 'TEST        ' and
0103032305010296 C                             lnam3 = 'EMP'
0103042305010296 C                   iter
0103052305010296 C                   endif
0103062305010291  *
0103072305010296 C                   If        mbtrst = 005 or
0103082305010296 C                             (mbtrst > 25 and mbtrst < 85)
0103092305010296 C                   iter
0103102305010296 C                   endif
0103112305010291  *        Chk to see if already flagged as a dupe
0103122305010297 C     mbssno        chain     mbrdupl                            22
0103132305010296 C                   If        *in22 = '1'
0103142305010291  *            Not alrady in dupe file
0103152305010296 C                   eval      mbrp = 'N'
0103162305010297 C     namkey        setll     memnam                             23
0103172305010296 C                   dou       *in23 = '1'
0103182305010297 C     namkey        reade     memnam                                 23
0103192305010296 C                   If        *in23 = '0'
0103202305010291  *
0103212305010296 C                   If        mbssno = nmbssno
0103222305010296 C                   iter
0103232305010296 C                   endif
0103242305010291  *
0103252305010296 C                   If        nmbtrst = 005 or
0103262305010296 C                             (nmbtrst > 25 and nmbtrst < 85)
0103272305010296 C                   iter
0103282305010296 C                   endif
0103292305010291  *
0103302305010291  *        Chk to see if other data pts match
0103312305010296 C                   If        birth = nbirth and
0103322305010296 C                             sex = nsex
0103332305010291  *
0103342305010296 C                   if        mbrp = 'N'
0103352305010291  *         Populate MBRDUP with MEMBER data
010336230501     C                   clear                   mbrdupr
010337230501     C                   eval      mdssn = mbssno
010338230501     C                   movel     mlname        mdlnam
010339230501     C                   movel     mfname        mdfnam
0103402305010291  *        Chk to see if lomg name
010341230501     C                   eval      cf1ss = mbssno
010342230501     C                   z-add     0             cf1sq
0103432305010297 C     cf1ky         chain     cfs100p                            25
0103442305010296 C                   If        *in25 = '0'
010345230501     C                   movel     cfslst        mdlnam
010346230501     C                   movel     cfsfst        mdfnam
0103472305010296 C                   endif
0103482305010107  *
010349230501     C                   move      mmi           mdmi
010350230501     C                   move      sex           mdsex
010351230501      *  Format Emp's TSA
010352230501    4C                   movel     mbtrst        gtrst
010353230501    4C                   movel     mbsub#        gsub
010354230501    4C                   movel     mbacct        gacct
010355230501    4C                   movel     wkacct        mdacct
010356230501      *  Format DOB
010357230501     C                   if        birth <> 0
010358230501     C                   eval      wkdatn = birth
010359230501     C                   movel     wkdatn        wkdat
010360230501     C                   eval      usadt = wkdat
010361230501     C                   movel     usadt         mddob
010362230501     C                   endif
010363230501      *  Format Enroll Dt
010364230501     C                   if        mbenrl <> 0
010365230501     C                   eval      wkdatn = mbenrl
010366230501     C                   movel     wkdatn        wkdat
010367230501     C                   eval      usadt = wkdat
010368230501     C                   movel     usadt         mdenrl
010369230501     C                   endif
010370230501      *  Format Term Dt
010371230501     C                   if        termdt <> 0
010372230501     C                   eval      wkdatn = termdt
010373230501     C                   movel     wkdatn        wkdat
010374230501     C                   eval      usadt = wkdat
010375230501     C                   movel     usadt         mdterm
010376230501     C                   endif
0103772305010107  *
010378230501     C                   movel     zip           mdzip
0103792305010291  *
010380230501     C                   write     mbrdupr
0103812305010296 C                   eval      mbrp = 'Y'
0103822305010291  *
0103832305010296 C                   endif
0105012305010291  *         Populate MBRDUP with MEMNAM data
0105022305010291  *
010503230501     C                   clear                   mbrdupr
010504230501     C                   eval      mdssn = nmbssno
010505230501     C                   movel     nmlname       mdlnam
010506230501     C                   movel     nmfname       mdfnam
0105072305010291  *        Chk to see if lomg name
010508230501     C                   eval      cf1ss = nmbssno
010509230501     C                   z-add     0             cf1sq
0105102305010297 C     cf1ky         chain     cfs100p                            25
0105112305010296 C                   If        *in25 = '0'
010512230501     C                   movel     cfslst        mdlnam
010513230501     C                   movel     cfsfst        mdfnam
0105142305010296 C                   endif
0105152305010107  *
010516230501     C                   move      nmmi          mdmi
010517230501     C                   move      nsex          mdsex
010518230501      *  Format Emp's TSA
010519230501    4C                   movel     nmbtrst       gtrst
010520230501    4C                   movel     nmbsub#       gsub
010521230501    4C                   movel     nmbacct       gacct
010522230501    4C                   movel     wkacct        mdacct
010523230501      *  Format DOB
010524230501     C                   if        nbirth <> 0
010525230501     C                   eval      wkdatn = nbirth
010526230501     C                   movel     wkdatn        wkdat
010527230501     C                   eval      usadt = wkdat
010528230501     C                   movel     usadt         mddob
010529230501     C                   endif
010530230501      *  Format Enroll Dt
010531230501     C                   if        nmbenrl <> 0
010532230501     C                   eval      wkdatn = nmbenrl
010533230501     C                   movel     wkdatn        wkdat
010534230501     C                   eval      usadt = wkdat
010535230501     C                   movel     usadt         mdenrl
010536230501     C                   endif
010537230501      *  Format Term Dt
010538230501     C                   if        ntermdt <> 0
010539230501     C                   eval      wkdatn = ntermdt
010540230501     C                   movel     wkdatn        wkdat
010541230501     C                   eval      usadt = wkdat
010542230501     C                   movel     usadt         mdterm
010543230501     C                   endif
0105442305010107  *
010545230501     C                   movel     nzip          mdzip
0105462305010291  *
010547230501     C                   write     mbrdupr
0105482305010291  *
0105492305010296 C                   endif
0105502305010291  *
0105512305010296 C                   endif
0105522305010291  *
0105532305010296 C                   enddo
0105542305010107  *
0105552305010296 C                   endif
0105562305010107  *
0105572305010296 C                   endif
0105582305010107  *
0105592305010296 C                   enddo
0105602305010107  *
0171000808040291  *
0172000808040297 C                   movel     '1'           *inlr
0173000808040297 C                   return
