000100030521     H DATEDIT(*YMD)
0002009707230002 F******************************************************************
0003000902020003 F* fm430      GROUP BENEFIT SERVICES SOFTWARE                     *
0004009707230004 F*                                                                *
0005009707230005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006000902020006 F*            DATE - 02/02/09                                     *
0007009707230007 F*                                                                *
0008000902020008 F*  DESCRIPTION - THIS PROGRAM ALLOWS MAINTENANCE OF THE DEBIT    *
0009000902020009 F*                CARD FILE.                                      *
003300100527SK   F* 05/27/10 dlk - add a "No card" code per admin request.         *
003301110316SK   F* 03/16/11 dlk - update user, trdate and trtime on reissue request
003302110505SK   F* 05/05/11 dlk - Note - FM430CL is now called in IQ010 also
003303100527SK   F*                                                                *
0034009811190013 F******************************************************************
003500090202     Ffm430D    CF   E             WORKSTN
003600970812     F                                     SFILE(S02SFL:RR2)
003800090202     Fdebcard   UF A E           K DISK
004000970813     FDEPNDC    IF   E           K DISK
004100970813     F                                     RENAME(DEPENR:DEPENCR)
004300970812     FMEMBER    IF   E           K DISK
004301090203     Fmcov      IF   E           K DISK
004302090203     Fdcovc     IF   E           K DISK
004303090203     Fplnmst    IF   E           K DISK
005801090203     D kssn            S                   like(dbssn)
005802090203     D kseq            S                   like(dbseq)
005803090203SSK1 D debcov          S              3
005804090203SSK1 D #HOLDSSN        S              9S 0
006000001127SSK1 D #ISO            S               D   DATFMT(*ISO)
006100001127SSK1 D #USA            S               D   DATFMT(*USA)
006101090203     D errmsg1         C                   CONST('ADD NOT ALLOWED, MEMBER +
006102090203     D                                     ALREADY EXISTS')
006103090203     D errmsg2         C                   CONST('CANCEL NOT ALLOWED, CARD HAS +
006104090203     D                                     NOT BEEN REQUESTED FOR THIS MEMBER')
006105090203     D errmsg3         C                   CONST('CANCEL NOT ALLOWED, CARD HAS +
006106090203     D                                     ALREADY BEEN PROCESSED')
006107090203     D errmsg4         C                   CONST('REACTIVATE NOT ALLOWED, +
006108090203     D                                     MEMBER DOES NOT EXIST')
0061090902030600 D                 DS
0061100902030601 D  mtsa                   1     10  0
0061110902030601 D  mbtrst                 1      3  0
0061120902030601 D  mbsub#                 4      6  0
0061130902030601 D  mbacct                 7     10  0
0061170902030600 D                UDS
0061180902030601 D  luser                  1     10
0061190902020601 D  CONAME               201    240
010700090203
010800970812     C* DISPLAY FIRST SCREEN
011100090202SSK1 C                   Z-ADD     #HOLDSSN      s1ssn
011101090202     c                   dou       *inkg
011102090202
011200970813     C                   EXFMT     S01
011201090203
011202090203      * F7 - end
011203090203     c                   if        *inkg
011204090203     c                   leave
011205090203     c                   end
011206090203
011300090202     C                   MOVE      s1ssn         OSSN
011401090203
012000970813     C* VALIDATE SSN
012200090202     C     s1ssn         CHAIN     MEMBER
012300090202     C                   if        not %found(member)
012301090202     c                   eval      *in21 = *on
012302090202     c                   iter
012303090202     c                   else
012304090202     c                   eval      *in21 = *off
012305090202     c                   move      s1ssn         ossn
012306090203     c                   move      mtsa          oacc
012307090202     c     mfname        cat       mlname:1      oname
012308090202     c                   end
012400090203
012500090203      * DSPLAY SCREEN 2
012800090202     C                   EXSR      #DSP02
012801090203
014200090202     C                   enddo
014201090202
014300090202     C* end program
014500970812     C                   MOVE      *ON           *INLR
014600970812     C*
014700970813     C*******************************************************
014800090203     C* SCREEN 2 SUBROUTINE                                 *
014900970813     C*******************************************************
015000970812     C*
015100970812     C     #DSP02        BEGSR
015101090203
015102090203      * stay in this SR until F1 is pressed
015103090203     c                   dou       *inka
015104090203
015300090203      * CLEAR SUBFILE
015700970813     C                   MOVEA     '0010'        *IN(60)
015800090203     C                   MOVE      ' '           s2sel
015900970812     C                   WRITE     S02CTL
016000970723     C                   MOVE      '0'           *IN62
016100090203
016200090203      * BUILD SUBFILE - LOAD ALL FOR THIS SSN
016400970723     C                   Z-ADD     1             SFREC#
016500970812     C                   MOVE      *ZEROS        RR2               5 0
016602090203     C                   CLEAR                   S02SFL
016603090203
016604090203      * add member first as seq 0
016605090203     C     s1ssn         CHAIN     MEMBER
016606090203     C                   if        %found(member)
016607090203     C     mfname        cat       mlname:1      S2NAME
016608090203     C                   move      00            S2DSEQ
016609090203     c                   end
016610090203
016611090203      * show info in debcard file
016612090203     c                   move      s1ssn         kssn
016613090203     c                   move      00            kseq
016614090203     c                   exsr      #getdeb
016615090203      * get debit card coverage
016618090203     c                   exsr      #getcov
016619090203     c                   move      debcov        s2elig
016627090203
016628090203     C                   ADD       1             RR2
016629090203     C                   WRITE     S02SFL
016630090203     c                   eval      *in91 = *off
016631090203
016632090203      * dependents
016633090203     C                   clear                   *in64
016700090203     C     s1ssn         SETLL     depndc
016901090203     c                   dou       *in64
017000090203     C     s1ssn         reade     depndc                                 64
017001090203
017200090203    1C                   if        *in64 = *off
017400090203     C                   CLEAR                   S02SFL
017800090203     C     dfname        cat       dlname:1      S2NAME
017801090203     C                   move      dpseq#        S2DSEQ
017802090205     C                   move      drelcd        S2rel
017803090203      * show info in debcard file
017804090203     c                   move      dssno         kssn
017805090203     c                   move      dpseq#        kseq
017806090203     c                   exsr      #getdeb
017807090203      * get debit card coverage
017808090203     c                   exsr      #getcov
017809090203     c                   move      debcov        s2elig
017821090203
019700970812     C                   ADD       1             RR2
019900970812     C                   WRITE     S02SFL
019901090203     c                   eval      *in91 = *off
020100090203    1C                   end
020101090203    1C                   enddo
020200970723     C*
020300970723     C* DISPLAY SUBFILE
020400970723     C*
020500970723     C     #T0120        TAG
020600090203     C                   if        rr2 > 0
020700090203     C                   eval      *IN60 = *on
020800970813     C                   END
020900090203     C                   eval      *IN61 = *on
021000970813     C*
021100090203     C                   WRITE     S02FKY
021200970813     C                   EXFMT     S02CTL
021201090203     c                   clear                   s2err
021202090203     c                   clear                   *in90
021300090203
021400090203     C* F1 RETURN
021600090203     C                   if        *inka
021601090203     c                   leavesr
021602090203     c                   end
021603090216
021604090216     C* F2 display delivery codes
021605090216     C                   if        *inkb
021606090216     C                   MOVEL(P)  'a'           parm3             3
021607090216     C                   CALL      'FM001CL'
021608090216     C                   PARM                    parm3
021611090216     c                   iter
021612090216     c                   end
021700090203
021800090203     C* READ SUBFILE FOR SELECTION
022000090203     C                   if        *in60
022001090203     c                   dou       %eof(fm430d)
022200090203     C                   READC     S02SFL
022201090203     c                   if        not %eof(fm430d)
022202090203
022203090203      * process Add, Cancel or Reactivate
022204090203     c                   select
022400090203     C                   when      s2sel = 'A'
022402090203     c                   exsr      #add
022904090203     C                   when      s2sel = 'C'
022905090203     c                   exsr      #cancel
022935090203     C                   when      s2sel = 'R'
022936090203     c                   exsr      #react
022940090203     C                   endsl
022941090203
022958090203     C                   END
023002090203     C                   enddo
023003090203     C                   END
023004090203
023006090203     c                   enddo                                                  end F1
023500090203
023700970812     C                   ENDSR
023701090203
023702090203      **************************************************
023703090203      * get debit card record and move info to screen  *
023704090203      **************************************************
023705090203     C     #getdeb       begsr
023706090203
023707090203     C     debkey        chain(n)  debcard
023708090203
023709090203     c                   if        %found(debcard)
023710090203     C                   MOVE      dbtrdat       #usa
023711090203     C                   MOVE      #usa          S2addt
023712090203     c                   exsr      #status
023713090203     c                   if        dbprdat <> d'0001-01-01'
023714090203     C                   move      dbprdat       #usa
023715090203     C                   move      #usa          s2prdt
023716090203     c                   end
023717090213     c                   move      dbdeliv       s2deliv
023718090203     c                   end
023719090203
023720090203     C                   endsr
023721090203
023722090203      **********************************
023723090203      * add rec
023724090203      **********************************
023725090203     C     #add          begsr
023726090203
023727090203     c                   move      ossn          kssn
023728090203     c                   move      s2dseq        kseq
023729090203     C     debkey        chain(n)  debcard
023730090203     c                   if        %found(debcard)
023731090203     c                   eval      *in90 = *on
023732090203     c                   eval      s2err = errmsg1
023733090203     c                   leavesr
023734090203     c                   else
023735090203      * add debcard rec
023736090203     c                   clear                   debcardr
023737090203     c                   move      ossn          dbssn
023738090203     c                   move      s2dseq        dbseq
023739090216     c                   move      s2delivh      dbdeliv
023740090203     c                   move      *date         dbtrdat
023741090203     c                   time                    dbtrtim
023742090203     c                   movel     luser         dbuser
023743090203     c                   write     debcardr
023744090203     c                   clear                   s2sel
023745090203     c                   end
023746090203
023747090203     C                   ENDSR
023748090203
023749090203      **********************************
023750090203      * cancel request
023751090203      **********************************
023752090203     C     #cancel       begsr
023753090203
023754090203     c                   move      ossn          kssn
023755090203     c                   move      s2dseq        kseq
023756090203     C     debkey        chain     debcard
023757090203     c                   if        not %found(debcard)
023758090203     c                   eval      *in90 = *on
023759090203     c                   eval      s2err = errmsg2
023760090203     c                   leavesr
023761090203     c                   end
023762090203
023763090203      * card alread processed
023764090203     c                   if        dbprdat <> d'0001-01-01'
023765090203     c                   eval      *in90 = *on
023766090203     c                   eval      s2err = errmsg3
023767090203     c                   leavesr
023768090203     c                   end
023769090203
023770090203      * update record status
023771090203     c                   move      'C'           dbprsta
023775090203     c                   update    debcardr
023777090203     c                   clear                   s2sel
023778090203
023779090203     C                   ENDSR
023780090203
023781090203      **********************************
023782090203      * reactive request
023783090203      **********************************
023784090203     C     #react        begsr
023785090203
023786090203     c                   move      ossn          kssn
023787090203     c                   move      s2dseq        kseq
023788090203     C     debkey        chain     debcard
023789090203     c                   if        not %found(debcard)
023790090203     c                   eval      *in90 = *on
023791090203     c                   eval      s2err = errmsg4
023792090203     c                   leavesr
023793090203     c                   end
023794090203
023795090203      * update record status
023796090203     c                   move      ' '           dbprsta
023797090203     c                   clear                   dbprdat
023798090203     c                   clear                   dbprtim
023799090216     c                   move      s2delivh      dbdeliv
023800110316     c                   move      *date         dbtrdat
023801110316     c                   time                    dbtrtim
023802110316     c                   movel     luser         dbuser
023803090203     c                   update    debcardr
023804090203     c                   clear                   s2sel
023805090203
023806090203     C                   ENDSR
023807090203
023808090203      **********************************
023809090203      * get record status
023810090204      **********************************
023811090204      * Blank = new record, ready to process
023812090204      * C     = card request has been cancelled by user, do not send to MBI
023813090204      * P     = card request has been processed / sent to MBI
023814090204      *
023815090203     C     #status       begsr
023816090203
023817090203     c                   clear                   s2stat
023818090203     c                   select
023819090203     c                   when      dbprsta = ' '
023820090216     c                   eval      s2stat = 'READY TO PROCESS '
023821090203     c                   when      dbprsta = 'C'
023822090213     c                   eval      s2stat = 'REQUEST CANCELLED'
023823090213     c                   when      dbprsta = 'P'
023824090216     c                   eval      s2stat = 'PROCESS COMPLETE '
023825090203     c                   endsl
023826090203
023827090203     C                   ENDSR
064700030521
064701090203      **********************************
064702090203      * get debit card coverage
064703090203      **********************************
064704090203     C     #getcov       begsr
064705090203
064706090203      * does the member / depend have active debit card coverage?
064707090203      * *in91 *on protects the select field
064708090203      * no active debit coverage means no access to the debit card
064709090203
064710090203     c                   eval      *in91 = *on
064711090203     c                   eval      debcov = 'No '
064712090203      * member
064713090203     c                   if        kseq = 0
064714090203     C     kssn          setll     mcov
064715090203     C                   dou       %eof(mcov)
064716090203     C     kssn          READE     mcov
064717090204     C                   if        not %eof(mcov) and candt = 0
064718090203     c     plnkey        chain     plnmst
064719090213     C                   if        %found(plnmst) and pdebit <> ' '
064720100527     C                             and pdebit <> 'N'
064721090213     c                   eval      debcov = 'Yes'
064722090216     c                   eval      s2delivh = pdebit
064723090203     c                   eval      *in91 = *off
064724090203     c                   leavesr
064725090203     c                   end
064726090203     C                   end
064727090203     C                   enddo
064728090203
064729090203     c                   else
064730090203      * depend
064731090203     C     debkey        setll     dcovc
064732090203     C                   dou       %eof(dcovc)
064733090203     C     debkey        READE     dcovc
064734090204     C                   if        not %eof(dcovc) and ccandt = 0
064735090203     c     dcplnkey      chain     plnmst
064736090213     C                   if        %found(plnmst) and pdebit <> ' '
064737100527     C                             and pdebit <> 'N'
064738090213     c                   eval      debcov = 'Yes'
064739090216     c                   eval      s2delivh = pdebit
064740090203     c                   eval      *in91 = *off
064741090203     c                   leavesr
064742090203     c                   end
064743090203     C                   end
064744090203     C                   enddo
064745090203
064746090203     C                   end
064747090203
064748090203     C                   ENDSR
064749090203
064750090203
064800030521     C     *inzsr        begsr
064801090203
064802090203     C     *ENTRY        PLIST
064803090203     C                   PARM                    SSNIN             9
064804090203SSK1 C                   MOVE      SSNIN         #HOLDSSN
064805090203
064806090203     C     DEBKEY        KLIST
064807090203     C                   KFLD                    kssn
064808090203     C                   KFLD                    kseq
064809090203
064810090203     C     plnkey        KLIST
064811090203     C                   KFLD                    mctrst
064812090203     C                   KFLD                    mcsub#
064813090203     C                   KFLD                    mcplan
064814090203
064815090203     C     dcplnkey      KLIST
064816090203     C                   KFLD                    dvtrst
064817090203     C                   KFLD                    dvsub#
064818090203     C                   KFLD                    dvplan
064819090203
0649000305210621 C                   MOVE      *DATE         UDATE8            8 0
065000030521     C                   ENDSR
