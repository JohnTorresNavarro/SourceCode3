000100030521     H DATEDIT(*YMD)
0002009707230002 F******************************************************************
0003001208020003 F* cob350     GROUP BENEFIT SERVICES SOFTWARE                     *
0004009707230004 F*                                                                *
0005009707230005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006001208020006 F*            DATE - 08/02/12                                     *
0007009707230007 F*                                                                *
0008001103230008 F*  DESCRIPTION - THIS PROGRAM ALLOWS MAINTENANCE OF THE          *
0009001208020009 F*                COBRA letter history file status field that     *
0009011208020009 F*                GBSACCESS uses to show or not show the letter.
003304110404SK   F*                                                                *
0034009811190013 F******************************************************************
003500120802     Fcob350d   CF   E             WORKSTN
003600970812     F                                     SFILE(S02SFL:RR2)
003800120802     Fclethstl1 iF   E           K DISK    infds(cletinfds)
003801120802     F                                     rename(clethstr:clethstrl1)
003802120802     Fclethst   uF   E             DISK
004300970812     FMEMBER    IF   E           K DISK
004301120802     D MSG             S             60A   DIM(2) CTDATA PERRCD(1)
006000120802     D #ISO            S               D   DATFMT(*ISO)
006100120802     D #USA            S               D   DATFMT(*USA)
006104120802     D RR2             S              5S 0
006108120802     D cletinfds     E DS                  EXTNAME(IODBFD)
0061091104010600 D                 DS
0061101104010601 D  mtsa                   1     10  0
0061111104010601 D  mbtrst                 1      3  0
0061121104010601 D  mbsub#                 4      6  0
0061131104010601 D  mbacct                 7     10  0
0061141208020600 D                 DS
0061151208020601 D  cltsa                  1     10  0
0061161208020601 D  CLTRUST                1      3  0
0061171208020601 D  CLSUB                  4      6  0
0061181208020601 D  CLACCT                 7     10  0
0061190902030600 D                UDS
0061200902020601 D  CONAME               201    240
010700090203
010800970812     C* DISPLAY FIRST SCREEN
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
011301110401     c                   clear                   oname
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
016500110401     C                   MOVE      *ZEROS        RR2
016602090203     C                   CLEAR                   S02SFL
016603090203
016611120802      * show info in clethst file
016614120802     c                   exsr      #getclethst
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
021201110401     c                   clear                   s2msg
021202090203     c                   clear                   *in90
021300090203
021400090203     C* F1 RETURN
021600090203     C                   if        *inka
021601090203     c                   leavesr
021602090203     c                   end
021700090203
021800090203     C* READ SUBFILE FOR SELECTION
022000090203     C                   if        *in60
022001120802     c                   dou       %eof(cob350d)
022200090203     C                   READC     S02SFL
022201120802     c                   if        not %eof(cob350d)
022202090203
022203110330      * process Change
022400110401     C                   if        s2sel <> ' '
022402110330     c                   exsr      #s03
022940110401     C                   end
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
023703120802      * get clethst records and move info to screen  *
023704090203      **************************************************
023705120802     C     #getclethst   begsr
023708110401
023709120802     C     s1ssn         setll     clethstl1
023710120802     C                   dou       %eof(clethstl1)
023711120802     C     s1ssn         READE     clethstl1
023712120802     C                   if        not %eof(clethstl1)
023722110323
023723120802     C                   MOVE      cltrdat       #iso
023724110401     C                   MOVE      #iso          #usa
023725120802     C                   MOVE      #usa          S2trdt
023726110323
023727120802     C                   MOVE      cltrmdt       #iso
023728120802     C                   MOVE      #iso          #usa
023729120802     C                   MOVE      #usa          S2termdt
023730120802
023731120802     C                   MOVE      CLDSEQ        s2dseq
023732120802     C                   MOVE      CLTRDES       S2LTYPE
023733120802     C                   MOVE      cltsa         S2ACC#
023734120802     C                   MOVE      clstatus      S2status
023735110401     C                   ADD       1             RR2
023736120802     c                   move      wqrelr        s2rec#
023737110401     C                   WRITE     S02SFL
023738110401     c                   end
023739110401     c                   enddo
023740110401
023741090203     C                   endsr
023742090203
023743090203      **********************************
023744120802      * screen 3 - change
023745090203      **********************************
023746110330     C     #s03          begsr
023747090203
023749120802     c                   clear                   S3status
023750120802     c                   clear                   S3depseq
023751120802     c                   clear                   S3depnam
023752120802     c                   clear                   S3termdt
023759110331      * change
023766120802     C     s2rec#        chain     clethst
023767120802     c                   if        not %found(clethst)
023768090203     c                   eval      *in90 = *on
023769110401     c                   eval      s2msg = msg(1)
023770090203     c                   leavesr
023771110401     c                   end
023772110331
023773120802     c                   move      clstatus      S3status
023774120802     c                   move      cldseq        S3depseq
023775120802     C                   MOVE      cltrmdt       #iso
023776120802     C                   MOVE      #iso          #usa
023777120802     C                   MOVE      #usa          S3termdt
023780120802
023781120802     c                   movel     cldfname      s3depnam
023782120802     c                   if        cldmi <> *blank
023783120802     c                   cat       cldmi:1       s3depnam
023784120802     c                   cat       '.':0         s3depnam
023785120802     c                   end
023786120802     c                   cat       cldlname:1    s3depnam
023787120802
023792110401     c                   dou       s3msg = *blank
023793110331     c                   exfmt     s03
023794110401     c                   clear                   s3msg
023795110401     c                   eval      *in90 = *off
023796110401
023797110401      * F1 return to screen 2
023798110331     c                   if        *inka
023799110401     c                   eval      *inka = *off
023800120802     c                   unlock    clethst
023801110331     c                   leavesr
023802090203     c                   end
023803110331
023804110331      * edit values
023833110331
023837120802     c                   if        s3status <> 'A' and
023838120802     c                             s3status <> 'C' and
023839120802     c                             s3status <> 'D'
023840120802     C                   MOVEL(P)  MSG(2)        s3msg
023841110401     c                   eval      *in90 = *on
023842110401     C                   iter
023843110401     c                   end
023844110331
023845110401      * move screen 3 fields to file fields for output
023846120802     c                   move      s3status      clstatus
023855120802      * update clethst
023857120802     c                   update    clethstr
023861110401
023862110401     c                   enddo
023863090203
023864090203     C                   ENDSR
064750090203
065100110401** MESSAGES
065200110401ERROR - MEMBER NOT FOUND                                     1
065300120802STATUS MUST BE A,C or D                                      2
