000100030521     H DATEDIT(*YMD)
0002009707230002 F******************************************************************
0003001103230003 F* cob420     GROUP BENEFIT SERVICES SOFTWARE                     *
0004009707230004 F*                                                                *
0005009707230005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006001103230006 F*            DATE - 03/23/11                                     *
0007009707230007 F*                                                                *
0008001103230008 F*  DESCRIPTION - THIS PROGRAM ALLOWS MAINTENANCE OF THE          *
0009001104040009 F*                COBRA Member link to orig mem file. When dependents
0009011104040009 F*                elect COBRA they are set up as members so this
0009021104040009 F*                file will track what member they originally came
0009031104040009 F*                from for reporting purposes.
003302110404SK   F*                It is called from the menu and from TR180.
003304110404SK   F*                                                                *
0034009811190013 F******************************************************************
003500110323     Fcob420d   CF   E             WORKSTN
003600970812     F                                     SFILE(S02SFL:RR2)
003800110323     Fmemmem    UF A E           K DISK
004300970812     FMEMBER    IF   E           K DISK
004301110401     D MSG             S             60A   DIM(6) CTDATA PERRCD(1)
005804090203SSK1 D #HOLDSSN        S              9S 0
006000001127SSK1 D #ISO            S               D   DATFMT(*ISO)
006100001127SSK1 D #USA            S               D   DATFMT(*USA)
006101110401SSK1 D #USAfr          S               D   DATFMT(*USA)
006102110401SSK1 D #USAto          S               D   DATFMT(*USA)
006103110401SSK1 D action          S              3
006104110401SSK1 D RR2             S              5S 0
006105110401SSK1 D keyssn          S              9s 0
006106110401SSK1 D keyorssn        S              9s 0
006107110401SSK1 D keyfrdt         S              8s 0
0061081104010600 D                 DS
0061091104010601 D  mtsa                   1     10  0
0061101104010601 D  mbtrst                 1      3  0
0061111104010601 D  mbsub#                 4      6  0
0061121104010601 D  mbacct                 7     10  0
0061170902030600 D                UDS
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
016611110323      * show info in memmem file
016614110323     c                   exsr      #getmemmem
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
021603110330     C* F6 add
021604110330     C                   if        *inkf
021605110330     c                   exsr      #s03
021606110330     c                   iter
021607110330     c                   end
021700090203
021800090203     C* READ SUBFILE FOR SELECTION
022000090203     C                   if        *in60
022001110323     c                   dou       %eof(cob420d)
022200090203     C                   READC     S02SFL
022201110323     c                   if        not %eof(cob420d)
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
023703110323      * get memmem records and move info to screen  *
023704090203      **************************************************
023705110323     C     #getmemmem    begsr
023708110401
023709110323     C     s1ssn         setll     memmem
023710110323     C                   dou       %eof(memmem)
023711110401     C     s1ssn         READE(n)  memmem
023712110323     C                   if        not %eof(memmem)
023713090203
023714110401     c                   eval      s2prevssn = mmorssn
023715110401     c                   clear                   s2prevnam
023716110323     c     mmorssn       chain     member
023717110323     c                   if        %found(member)
023718110401     c                   movel     mfname        s2prevnam
023719110401     c                   cat       mmi:1         s2prevnam
023720110401     c                   cat       mlname:1      s2prevnam
023721110323     c                   end
023722110323
023723110401     C                   MOVE      mmfrdt        #iso
023724110401     C                   MOVE      #iso          #usa
023725110401     C                   MOVE      #usa          S2frdt
023726110323
023727110401     C                   MOVE      mmtodt        #iso
023728110401     C                   MOVE      #iso          #usa
023729110323     C                   MOVE      #usa          S2todt
023730110323
023731110401     C                   ADD       1             RR2
023735110401
023736110401     C                   WRITE     S02SFL
023737110401     c                   end
023738110401     c                   enddo
023739110401
023740090203     C                   endsr
023741090203
023742090203      **********************************
023743110401      * screen 3 - change or add rec
023744090203      **********************************
023745110330     C     #s03          begsr
023746090203
023747110401     c                   clear                   S3PSSN
023748110401     c                   clear                   S3Pname
023749110401     c                   clear                   S3FRDT
023750110401     c                   clear                   S3TODT
023751110401     c                   clear                   action
023752110401      * add - F6
023753110331     c                   if        *inkf
023754110401     c                   move      ossn          s3ssn
023755110401     c                   move      'ADD'         action
023756110331
023757110401     c                   else
023758110331
023759110331      * change
023760110401     c                   move      'CHG'         action
023761110401     c                   move      ossn          keyssn
023762110401     c                   move      s2prevssn     keyorssn
023763110401     c                   move      s2frdt        #usa
023764110401     c                   move      #usa          #iso
023765110401     c                   move      #iso          keyfrdt
023766110331     C     mmkey         chain     memmem
023767110331     c                   if        not %found(memmem)
023768090203     c                   eval      *in90 = *on
023769110401     c                   eval      s2msg = msg(1)
023770090203     c                   leavesr
023771110401     c                   end
023772110331
023773110331     c                   move      mmssn         s3ssn
023774110401     c                   move      mmorssn       s3pssn
023775110401     c                   clear                   s3pname
023776110401      * get previous member name
023777110401     c     s3pssn        chain     member
023778110401     c                   if        %found(member)
023779110401     c                   movel     mfname        s3pname
023780110401     c                   cat       mmi:1         s3pname
023781110401     c                   cat       mlname:1      s3pname
023782110401     c                   end
023783110401      * ymd to mdy
023784110401     c                   move      mmfrdt        #iso
023785110401     c                   move      #iso          #usa
023786110401     c                   move      #usa          s3frdt
023787110401     c                   move      mmtodt        #iso
023788110401     c                   move      #iso          #usa
023789110401     c                   move      #usa          s3todt
023790110401     c                   end
023791110331
023792110401     c                   dou       s3msg = *blank
023793110331     c                   exfmt     s03
023794110401     c                   clear                   s3msg
023795110401     c                   eval      *in90 = *off
023796110401
023797110401      * F1 return to screen 2
023798110331     c                   if        *inka
023799110401     c                   eval      *inka = *off
023800110401     c                   unlock    memmem
023801110331     c                   leavesr
023802090203     c                   end
023803110331
023804110331      * edit values
023805110331     c     s3ssn         chain     member
023806110331     c                   if        not %found(member)
023807110401     C                   MOVEL(P)  MSG(4)        s3msg
023808110401     c                   eval      *in90 = *on
023809110401     C                   iter
023810110331     c                   end
023811110401
023812110331     c     s3pssn        chain     member
023813110331     c                   if        not %found(member)
023814110401     C                   MOVEL(P)  MSG(5)        s3msg
023815110401     c                   eval      *in90 = *on
023816110401     C                   iter
023817110331     c                   end
023818110401
023819110331     c* date edits
023820110331     C     *USA          TEST (DE)               s3frdt
023821110331    2C                   IF        %ERROR
023822110401     C                   MOVEL(P)  MSG(2)        s3msg
023823110401     c                   eval      *in90 = *on
023824110401     C                   iter
023825110401    2C                   end
023826110401
023827110401     C     *USA          TEST (DE)               s3todt
023828110401    2C                   IF        %ERROR
023829110401     C                   MOVEL(P)  MSG(3)        s3msg
023830110401     c                   eval      *in90 = *on
023831110401     C                   iter
023832110401    2C                   end
023833110331
023834110401      * to date must be after from date
023835110401     c                   move      s3frdt        #usafr
023836110401     c                   move      s3todt        #usato
023837110401     c                   if        #usafr > #usato
023838110401     C                   MOVEL(P)  MSG(6)        s3msg
023839110401     c                   eval      *in90 = *on
023840110401     C                   iter
023841110401     c                   end
023842110331
023843110401      * move screen 3 fields to file fields for output
023844110401     c                   move      s3ssn         MMSSN
023845110401     c                   move      s3pssn        MMORSSN
023846110401      * ymd to mdy
023847110401     c                   move      s3frdt        #usa
023848110401     c                   move      #usa          #iso
023849110401     c                   move      #iso          mmfrdt
023850110401     c                   move      s3todt        #usa
023851110401     c                   move      #usa          #iso
023852110401     c                   move      #iso          mmtodt
023853110401      * update memmem
023854110401     c                   if        action = 'CHG'
023855110401     c                   update    memmemr
023856110401     c                   else
023857110401     c                   write     memmemr
023858110401     c                   end
023859110401
023860110401     c                   enddo
023861090203
023862090203     C                   ENDSR
064750090203
064800030521     C     *inzsr        begsr
064801090203
064802090203     C     *ENTRY        PLIST
064803090203     C                   PARM                    SSNIN             9
064804090203SSK1 C                   MOVE      SSNIN         #HOLDSSN
064805090203
064806110331     C     mmkey         KLIST
064807110401     C                   KFLD                    keyssn
064808110401     C                   KFLD                    keyorssn
064809110401     C                   KFLD                    keyfrdt
064810110401
065000030521     C                   ENDSR
065100110401** MESSAGES
065200110401ERROR - MEMBER NOT FOUND                                     1
065300110401INVALID FROM DATE                                            2
065301110401INVALID TO DATE                                              3
065500110401CURRENT MEMBER SSN NOT FOUND                                 4
065600110401PREVIOUS MEMBER SSN NOT FOUND                                5
065700110401TO DATE MUST BE AFTER FROM DATE                              6
