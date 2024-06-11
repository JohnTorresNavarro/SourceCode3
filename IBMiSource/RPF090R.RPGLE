0001000303100002  *?****************************************************************
0002000307020003  *?RPF090R    GROUP BENEFIT SERVICES SOFTWARE                     *
0003000307020004  *                                                                *
0004000303100005  *?         REWRITTEN BY - TERRY POWERS                           *
0005000305060006  *?           DATE - 05/06/2003                                   *
0006000307020007  *                                                                *
0007000303100008  *? DESCRIPTION - PRINT ACCOUNT CANCELLATION LETTERS              *
000800030702I 10  *                                                                *
000900030702I 10  *                                                                *
001000030702I 10  *  Cancellation letters converted from Output Specs to DDS.      *
001100030702I 10  *  Letter wording changed per Jane Summerfield.                  *
001200030702I 10  *                                                                *
001300030702I 10  *  7/2/2003 KSJ Completed modifications                          *
001400030708I 10  *  7/8/2003 szz Remove member-level diary note.  Add effective   *
001500030708I 10  *                month and day to group-level note per Shelly.   *
001600030808      *               Each time a letter is generated, enter its data  *
001700030808      *                to a new file, CANLET, which will be used for
001800030808      *                reprinting account letters later if requested.
001900050817I 10  *  8/12/2005 szz Add Benegap letters.                            *
002000140501I 10  * 10/10/2013 sbt Hist file expansion project                     *
002100140501I 10  * 05/01/2014 JVA Merged printer files                            *
002200140501I 10  * 05/01/2014 JVA Added prompt for Collection letter printing     *
002300140922I 10  * 06/19/2014 JVA Print group# on account letter                  *
002400140922I 10  * 09/22/2014 JVA Fix group# on account letter                    *
002500150226I 10  * 02/26/2015 dlk add subtract 1 day for letter effdt parm. This  *
002600150227I 10  *                is for Care First groups. Remove Benegap letters*
002700150304I 10  *                since they are no longer needed (ok by Cindy W),*
002800150304I 10  *                also other changes to make new letters work.    *
002900190211I 10  * 02/11/2019 dlk Add new letter for Care First accounts that are *
003000190211I 10  *                subject to the PSF rules. Page segment is       *
003100190211I 10  *                CANAC_PS and letterhead overlay is RPF090OL     *
003200190211I 10  *                new rec formats in dds are APSCFPSF and AVRCFPSF *
003300211201I 10  * 12/01/2021 dlk change aa email to be seperate longer field
003400190211I 10  *                                                                *
0035001902110012  * Page segment for withhold care letter:
0036001503100012  * I:\MIS\AS400PageSegments\GBS Letters\Cancel letters - RPF090\
0037001503100012  * 3-2-15 letter\CANACC.prn and CANMEM.prn
003800190211I 10  *
0039001902110012  * 2/11/19 - Page segment and letterhead overly for Care First
0040001902110012  *           psf cancel letter
0041001902110012  * I:\MIS\AS400PageSegments\GBS Letters\Cancel letters - RPF090\
0042001902110012  * 2-8-19 letter for CF PSF
004300190211I 10  *
0044000303100012  *?****************************************************************
0045000303100013 FACCMST    IF   E           K DISK
0046000303100014 FMEMAC#    IF   E           K DISK
0047001503030016 Fmcovc     IF   E           K DISK
0048000303100021 FGRATE     IF   E           K DISK
0049000303100021 FSMAN      IF   E           K DISK
005000030313     FAACODE    IF   E           K DISK
0051000307020017 FHIST      O    E           K DISK
005200030808     FCANLET    UF A E           K Disk
0053001404290027 FRPF090P   O    E             PRINTER
005400030311
005500030311     D ISO_DATE        S               D   DATFMT(*ISO)
005600030313     D USA_DATE        S               D   DATFMT(*USA)
005700030310
0058000303130020 D ONCE            S               N   INZ('0')
0059000303140020 D ONCE2           S               N   INZ('0')
0060000303140020 D ONCE3           S               N   INZ('0')
0061000303140020 D ONCE4           S               N   INZ('0')
0062000303140020 D PRTACCLET       S               N   INZ('0')
0063000303140020 D PRTMBRLET       S               N   INZ('0')
0064000303130020 D GAR             S             15    DIM(8)
0065009702270020 D MAR             S             15    DIM(8)
0066009702270022 D DL2             S              1    DIM(19)
0067009702190030 D AL              S              1    DIM(30)
0068009702190013 D AL2             S              1    DIM(30)
0069000303110032 D N_A             S              1    DIM(31)
0070000303140021 D MNA             S              9    DIM(12) CTDATA PERRCD(1)
0071000303110036 D ZERO9           S              9  0 INZ(*ZEROS)
0072000303110036 D ZERO7           S              7  0 INZ(*ZEROS)
0073000303110036 D GCOUNT          S              2  0 INZ(*ZEROS)
0074000303110036 D INDEX           S              3  0 INZ(*ZEROS)
0075000303110036 D N#              S              2  0 INZ(*ZEROS)
0076000303140036 D GRP_E           S              3  0 INZ(*ZEROS)
0077000303110051 D GRPNBRS         S             14
0078000303130051 D LCYMD           S              8  0 INZ(*ZEROS)
007900140514     D Group_Ctr       S              1  0 Inz(*Zeros)
008000140514     D acc_prt         S              1  0 Inz(*Zeros)
008100190211     D note_wk         S                   like(ck#not)
008200190212     D cflet_wk        S                   like(clcflet)
0083001503030055 D                 DS
0084001503030056 D  BAL                    1    108  2
008500150303     D                                     DIM(12)
0086001503030056 D  BAL1                   1      9  2
0087001503030056 D  BAL2                  10     18  2
0088001503030056 D  BAL3                  19     27  2
0089001503030056 D  BAL4                  28     36  2
0090001503030056 D  BAL5                  37     45  2
0091001503030056 D  BAL6                  46     54  2
0092001503030056 D  BAL7                  55     63  2
0093001503030056 D  BAL8                  64     72  2
0094001503030056 D  BAL9                  73     81  2
0095001503030056 D  BAL10                 82     90  2
0096001503030056 D  BAL11                 91     99  2
0097001503030056 D  BAL12                100    108  2
009800030708     D                 DS
009900030708     D CK_Note                       30    Inz(*Blanks)
010000030708     D CK_Msg                        23    Overlay(CK_Note)
010100030708     D CK_M                           2    Overlay(CK_Note:*Next)
010200030708     D CK_Sl                          1    Overlay(CK_Note:*Next)
010300030708     D CK_C                           4    Overlay(CK_Note:*Next)
010400030708     D                 DS
010500030708     D D_Date                         8  0 Inz(*Zeros)
0106000307080051 D D_CCYY                         4    OVERLAY(D_Date)
0107000307080051 D D_MM                           2  0 OVERLAY(D_Date:*Next)
0108000307080051 D D_DD                           2    OVERLAY(D_Date:*Next)
0109000303110046 D                 DS
0110000303110051 D CUR_DATE                       8  0 INZ(*ZEROS)
0111000303120051 D CUR_YYYY                       4    OVERLAY(CUR_DATE)
0112000303110051 D CUR_MM                         2  0 OVERLAY(CUR_DATE:*NEXT)
0113000303120051 D CUR_DD                         2    OVERLAY(CUR_DATE:*NEXT)
011400030310
0115009102120046 D                 DS
0116000303110047 D AZIP                                INZ(*ZEROS)
0117000303120048 D  AZIP5                         5    OVERLAY(AZIP)
0118000303120049 D  AZIP4                         4    OVERLAY(AZIP:*NEXT)
011900030312
0120000303120046 D                 DS
0121000303120047 D ZIP                                 INZ(*ZEROS)
0122000303120048 D  ZIP5                          5    OVERLAY(ZIP)
0123000303120049 D  ZIP4                          4    OVERLAY(ZIP:*NEXT)
012400030313
0125000303130046 D                 DS
0126000303130048 D KEYACC
012700030313     D  ACTRST                             OVERLAY(KEYACC)
012800030313     D  ACSUB#                             OVERLAY(KEYACC:*NEXT)
012900030313     D  ACACCT                             OVERLAY(KEYACC:*NEXT)
013000030310
013100030702     D                 DS
013200030702     D HACC#                   1     10
013300030702     D HTRST                   1      3
013400030702     D HSUB#                   4      6
013500030702     D HACCT                   7     10
013600030702
013700030311     D                 DS
013800030311     D TIME_DATE                     12  0
013900030311     D  TIME                          6  0 OVERLAY(TIME_DATE)
014000030311     D  DATE                          6  0 OVERLAY(TIME_DATE:7)
014100030310
0142000307020055 D                 DS
0143000307020056 D  TODAY                  1      8  0
0144000307020056 D  TYY                    1      4  0
0145000307020056 D  TMM                    5      6  0
0146000307020056 D  TDD                    7      8  0
014700030903    ?D                 DS
014800030903    ?D  WDRCVL                 1      4B 0 INZ(86)
014900030702
0150009102120055 D                UDS
0151009812010056 D  LMDY                   1      8  0
0152000303130056 D  LMM                    1      2  0
0153000303130056 D  LDD                    3      4
0154000303130056 D  LCY                    5      8
0155000303120056 D  LTRST                  9     11  0
0156000303120056 D  LSUB#                 12     14  0
0157000303120056 D  LACCT                 15     18  0
015800030314     D MBRLET_YN             140    140
0159000306250056 D  LUCMM                141    142  0
0160001405010056 D  LUCYY                143    146
0161001405010056 D  LCOL                 147    147
0162001502260056 D  Lsub1day             148    148
0163000303140056 D  LGRP                  20    139    DIM(8)
0164001310140094 D  USERID               190    199
0165009102120057 D  CONAME               201    240
016600030903    ? * RETREIVE JOB ATTRIBUTES API DATA STRUCTURE
016700030903    ?D WDJOBA          DS                  INZ
016800030903    ?D  WDBYTR                 1      4B 0
016900030903    ?D  WDBYTA                 5      8B 0
017000030903    ?D  WDJNAM                 9     18
017100030903    ?D  WDJUSR                19     28
017200030903    ?D  WDJNBR                29     34
017300030903    ?D  WDINJI                35     50
017400030903    ?D  WDJSTS                51     60
017500030903    ?D  WDJBTP                61     61
017600030903    ?D  WDJBST                62     62
017700030903    ?D  WDRVSD                63     64
017800030903    ?D  WDRNPY                65     68B 0
017900030903    ?D  WDTMSL                69     72B 0
018000030903    ?D  WDDFWT                73     76B 0
018100030903    ?D  WDPRGE                77     86
0182000303130060
018300030313     IACCMSR
018400030313     I              AACODE                      AACODE_I
0185000303100060
018600150313     c                   clear                   contactout
018700211201     c                   clear                   aemlaout
018800150421     c                   clear                   smanout
018900030313     C     *NOKEY        CLEAR     *ALL          ACCMSR
019000030313     C     ACCMST_KEY    CHAIN     ACCMSR
019100030314     C                   IF        %FOUND(ACCMST)
019200030314     C                   IF        ONCE  = *OFF
019300030314     C                   EVAL      ONCE  = *ON
019400030314
019500030314     C     *NOKEY        CLEAR     *ALL          AACODR
019600030314     C     AACODE_KEY    CHAIN     AACODR
019700030314     C                   EVAL      ADDIALC = %EDITW(ADDIAL:'   -   -    ')
019800030320     C                   MOVEL     AFNAM         NAME_32
019900030320     C                   CAT       ALNAM:1       NAME_32
020000150313
020100211201      * AA email
020200211201     c                   eval      aemlaout = %trim(aemla)
020300030310
020400150421      * salesman name
020500030311     C     *NOKEY        CLEAR     *ALL          SMANR
0206000303110234 C     SMANCD        CHAIN     SMAN
020700150421     C                   if        %found(sman)
020800150421     c     sfname        cat       slname:1      smanout
020900150421     C                   end
021000150421
021100150421     C                   END
021200140514
021300150303      * outstanding balance for acct letter
0214001503030144 C                   XFOOT     BAL           outbal
021500150313      * contact name on letter
021600150313     c                   if        ecntac <> *blanks
021700150313     c                   movel     ecntac        contactout
021800150313     c                   else
021900150313     c                   movel     contac        contactout
022000150313     c                   end
022100140514
0222000303100308  *?PRINT LETTER FOR ALL MEMBERS IN ACCOUNT WITH GROUP#'S SELECTED
022300030312     C     MEMBR_KEY     SETLL     MEMBR
022400030314     C                   DOU       %EOF(MEMAC#)
022500030312     C     MEMBR_KEY     READE     MEMBR
022600030314     C                   IF        NOT %EOF(MEMAC#)
022700970227     C                   MOVE      *BLANKS       MAR
0228000303140066 C                   MOVE      *BLANKS       GROUPSM
022900030310      *?READ COVERAGES
023000030314     C                   EVAL      ONCE3 = *OFF
023100030314     C                   EVAL      ONCE4 = *OFF
023200030314     C                   EVAL      PRTMBRLET = *OFF
023300150303     C     MBSSNO        SETLL     mcovc
023400150303     C                   DOU       %EOF(mcovc)
023500150303     C     MBSSNO        READE     mcovc
023600150303     C                   IF        NOT %EOF(mcovc) AND
023700030311     C                             CANDT = LCYMD
023800030313
023900030310      *?ONLY SELECT COVERAGES W/CANDT = DATE SELECTED
024000030310      *?GET GROUP#'S
0241009702270446 C                   Z-ADD     *ZEROS        GCOUNT
0242000303120447 C     GRATE_KEY     SETLL     GRATER
0243000303140449 C                   DOU       %EOF(GRATE)
024400030311     C     *NOKEY        CLEAR     *ALL          GRATER
0245000303120451 C     GRATE_KEY     READE     GRATER
024600030314     C                   IF        NOT %EOF(GRATE)
0247001409220454
0248001409220465  *?SKIP when plan = group#
0249001409220454 C                   If        %trim(GRPLAN) <> %trim(GROUP#)
0250000303100454
025100030314     C                   IF        LCYMD >= FRMDAT AND
025200030311     C                             LCYMD <= TODAT
0253000303110457 C                   ADD       1             GCOUNT
025400030314     C                   EVAL      PRTACCLET = *ON
025500140514     C                   Exsr      Print_acc
0256000303110458 C                   LEAVE
0257000303140459 C                   END
0258001409220460 C                   END
0259000303140460 C                   END
0260000303140462 C                   ENDDO
0261000303100465  *?IF GOOD RATE AND GROUP# IS SELECTED - STORE
026200030314     C                   IF        GCOUNT <> *ZEROS
026300030311     C     GROUP#        LOOKUP    LGRP                                   61
0264000303140466 C                   IF        %EQUAL
026500030314     C                   EVAL      PRTMBRLET = *ON
026600030312     C                   EXSR      STORG_SR
026700030314     C                   IF        MBRLET_YN = 'Y'
026800030314     C                   IF        ONCE3 = *OFF
026900030314     C                   EVAL      ONCE3 = *ON
027000030317     C                   EVAL      GRPNBRS = 'Group Numbers:'
027100030310
0272000303120147 C                   EXSR      MBRNAME_SR
0273000303140467 C                   END
027400030314     C                   END
027500030314
027600030314     C                   END
027700030314     C                   END
027800030314     C                   END
027900030314     C                   ENDDO
028000140514
028100140514
028200030314     C                   IF        MBRLET_YN = 'Y' AND
028300030314     C                             PRTMBRLET = *ON
028400150227
028500150323      * Care First member letter
028600150320     c                   if        lsub1day = 'Y'
028700150320     C                   WRITE     MBRvr_cf
028800150320     C                   WRITE     MBRPS_CF
028900150323      * Non Care First member letter
029000150320     c                   else
029100150320     C                   WRITE     MBRvr
029200150320     C                   WRITE     MBRPS
029300150320     c                   end
029400150227
029500030314     C                   IF        ONCE4 = *OFF
029600030314     C                   EVAL      ONCE4 = *ON
029700030314     C                   END
029800030314     C                   END
029900030314     C                   END
0300000303140317 C                   ENDDO
030100030314     C                   END
030200140514
030300030310
030400030312     C                   EVAL      *INLR = *ON
030500140514      *?**************************************************************
030600140514     C     print_acc     Begsr
030700140514
0308001405140308  *?IF ACCOUNT LETTER ALREADY PRINTED LEAVE
030900140514     C                   if        acc_prt > 0
031000140514     C                   LeaveSR
031100140514     C                   end
031200140618
031300140514
0314001405140308  *?ACCOUNT LETTER
0315001405140308  *?IF ACCT DID NOT HAVE ANY GROUP#'S THAT WERE SELECTED - ERROR
031600140514     C                   IF        PRTACCLET = *ON
031700140514     C                   eval      acc_prt = acc_prt + 1
031800140514     C                   EVAL      GRPNBRS = 'Group Numbers:'
0319001405140144 C                   EXSR      ACCADDR_SR
032000140514     C                   Eval      CK_Msg = 'ACCT CANCEL LETTER FOR '
032100140514     C                   Eval      D_Date = LCYMD
032200140514     C                   Move      D_CCYY        CK_C
032300140514     C                   Move      D_MM          CK_M
0324001405140286 C                   EVAL      CK#NOT = CK_Note
032500150227
032600150303
032700190211     c                   clear                   note_wk
032800190212     c                   eval      cflet_wk = lsub1day
032900190212
033000190211      * Care First account letter (Subtract 1 day prompt entered as "Y")
033100150313     c                   if        lsub1day = 'Y'
033200190213      * If this acct is subject to the Care First PSF rules and there is
033300190213      * a PSF or BSF set up, print the PSF letter and show "P" in letter
033400190213      * file, else print the non-psf letter
033500190211     c                   exsr      #getpsf
033600190211     c                   if        psfyn = 'Y'
033700190211      * PSF letter
033800190211     C                   WRITE     AVRCFPSF
033900190211     C                   WRITE     APSCFPSF
034000190211     c                   eval      note_wk = 'CF PSF LETTER'
034100190212     c                   eval      cflet_wk = 'P'
034200190211     c                   else
034300190211      * Non PSF letter
034400150313     C                   WRITE     ACCvr_cf
034500150313     C                   WRITE     ACCPS_Cf
034600190211     c                   end
034700190211
034800150323      * Non Care First account letter
034900150313     c                   else
035000150313     C                   WRITE     ACCvr
035100150313     C                   WRITE     ACCPS
035200150313     c                   end
035300150227
035400140514     C                   EXSR      HIST_SR
035500140514     C                   EXSR      SaveLetterData
035600140514     C                   END
035700140514     C                   Endsr
035800030808      *?**************************************************************
035900030808     C     SaveLetterDataBEGSR
036000030808      *
036100030808     C
036200030808     C     1             DO        8             Group_Ctr
036300030808      *
036400030808     C                   If        LGRP(Group_Ctr)  =  *Blanks
036500030808     C                   Leave
036600030808     C                   End
036700030808      *
036800030808     C                   Eval      CLTRST     =  ACTRST
036900030808     C                   Eval      CLSUB#     =  ACSUB#
037000030808     C                   Eval      CLACCT     =  ACACCT
037100030808     C     LMDY          Mult      10000.0001    CLCNDT
037200150303     c                   move      carcanymd     clletefdt
037300150303     c                   move      outbal        cloutbal
037400190212     C                   Move      cflet_wk      clcflet
037500030808     C                   Movel     LUCYY         CLUNMY
037600030808     C                   Move      LUCMM         CLUNMY
037700030922     C                   Eval      CLMLYN     =  MBRLET_YN
037800030808     C                   Eval      CLOLDT     =  TODAY
037900030808     C                   Eval      CLGRP#     =  LGRP(Group_Ctr)
038000030903     C     *DATE         Mult      10000.0001    CLADDT
038100030903     C                   Movel     WDJUSR        CLADBY
038200030903     C                   TIME                    CLADTI
038300030808     C                   Write     CANLETR
038400030808     C                   Enddo
038500030808      *
038600030808     C                   ENDSR
0387000303140351  *?**************************************************************
038800030314     C     HIST_SR       BEGSR
0389000303140318  *?WRITE HIST REC ONLY IF REQUEST TO PRINT CLIENT/SUBSCRIBER (Y)
0390001310140284 C                   clear                   histr
0391001503030284 C                   EVAL      TRCODE =  'U83'
039200150303     C                   EVAL      HPRGNM  = 'RPF090R'
039300190211     C                   EVAL      ck#not  = note_wk
039400030702     C                   MOVEL     ACTRST        HTRST
039500030702     C                   MOVEL     ACSUB#        HSUB#
039600030702     C                   MOVEL     ACACCT        HACCT
039700030702     C                   EVAL      HKEY = HACC#
039800030314     C                   EVAL      HSTRST  = ACTRST
039900030314     C                   EVAL      HSSUB#  = ACSUB#
040000030314     C                   EVAL      HSACCT  = ACACCT
040100030702     C                   EVAL      HOPER   = USERID
040200030314     C                   EVAL      COVTDT  = LCYMD
040300030314     C                   EVAL      RECVDT  = *ZEROS
040400030314     C                   EVAL      TRAMT   = *ZEROS
040500030702     C                   EVAL      TRDATE  = TODAY
040600030314     C                   EVAL      HSDLTD  = 'A'
040700131010     c                   eval      hstrtime = %time
040800030410     C                   WRITE     HISTR
040900030314     C                   ENDSR
0410000303120351  *?**************************************************************
0411000303120650 C     MBRNAME_SR    BEGSR
0412000303120654 C                   MOVE      *BLANKS       MBRNAME
0413000303120656 C                   MOVEL     MFNAME        MBRNAME
041400030312     C                   IF        MMI <> *BLANKS
041500030313     C                   CAT       MMI:1         MBRNAME
0416000303130670 C                   CAT       '.':0         MBRNAME
041700030312     C                   END
041800030312     C                   CAT       MLNAME:1      MBRNAME
0419000303140654 C                   MOVE      *BLANKS       ADDR3
0420000303140656 C                   MOVEL     CITY          ADDR3
042100030314     C                   CAT       STATE:1       ADDR3
0422000303140386 C                   CAT       ZIP5:2        ADDR3
042300030314     C                   IF        ZIP4 <> '0000'
0424000303140390 C                   CAT       '-':0         ADDR3
0425000303140391 C                   CAT       ZIP4:0        ADDR3
0426000303140392 C                   END
042700030314     C                   IF        ADDR2  = *BLANKS
042800030314     C                   EVAL      ADDR2  = ADDR3
042900030314     C                   EVAL      ADDR3  = *BLANKS
043000030314     C                   END
043100030312     C                   ENDSR
0432000303130352  *?**************************************************************
043300030312     C     STORG_SR      BEGSR
043400030310      *?STORE GROUP# FOR MEMBER
043500030314     C                   DO        GRP_E         INDEX
043600030314     C                   IF        MAR(INDEX) = *BLANKS
043700030314     C                   MOVE      GROUP#        MAR(INDEX)
043800030314     C                   IF        INDEX = 1
0439000303140066 C                   MOVEL     GROUP#        GROUPSM
044000030314     C                   ELSE
044100030314     C                   CAT       ',':0         GROUPSM
044200150303     C                   CAT       GROUP#:1      GROUPSM
044300030314     C                   END
044400030311     C                   LEAVE
044500970227     C                   ELSE
044600030310
044700030311     C                   IF        MAR(INDEX) = GROUP#
044800030311     C                   LEAVE
044900030310
045000970227     C                   END
045100970227     C                   END
045200030311     C                   ENDDO
045300030311     C                   ENDSR
0454000303100355  *?ACCT ADDR
0455000303120356 C     ACCADDR_SR    BEGSR
0456000303120654 C                   MOVE      *BLANKS       AADDR3
0457000303120656 C                   MOVEL     ACITY         AADDR3
045800030312     C                   CAT       ASTATE:1      AADDR3
0459000303120386 C                   CAT       AZIP5:2       AADDR3
046000030312     C                   IF        AZIP4 <> '0000'
0461000303120390 C                   CAT       '-':0         AADDR3
0462000303120391 C                   CAT       AZIP4:0       AADDR3
0463009702200392 C                   END
046400030313     C                   IF        AADDR2  = *BLANKS
046500030313     C                   EVAL      AADDR2  = AADDR3
046600030313     C                   EVAL      AADDR3  = *BLANKS
046700030313     C                   END
0468000303110394 C                   ENDSR
046900190211
0470001902110103 C*******************************************************************
0471001902130104 C* call getpsf to see if this acct is subject to the PSF and if they
0472001902130104 C* have a PSF or BSF active
0473001902110103 C*******************************************************************
047400190211     c     #getpsf       begsr
047500190211     c                   movel     keyacc        parmpsftsa
047600190211     c                   move      lcymd         parmpsfeff
047700190211     c                   clear                   psfyn             1
047800190213     c                   clear                   parmpsfelig
047900190213     c                   clear                   parmpsftype
048000190211
048100190211     c                   call      'GETPSFCL'
048200190211     c                   parm                    parmpsftsa       10
048300190211     c                   parm                    parmpsfeff        8
048400190213     c                   parm                    parmpsfelig       1
048500190213     c                   parm                    parmpsftype       1
048600190211
048700190213      * if eligible and there is a psf/bsf fee active
048800190213     c                   if        parmpsfelig = 'Y' and parmpsftype <> ' '
048900190213     c                   move      'Y'           psfyn
049000190213     c                   end
049100190213
049200190211     c                   endsr
049300190211
0494000303100672  *?***************************************************************
049500981201     C     *INZSR        BEGSR
049600030312     C     MEMBR_KEY     KLIST
049700030312     C                   KFLD                    ACTRST
049800030312     C                   KFLD                    ACSUB#
049900030312     C                   KFLD                    ACACCT
050000030312     C     ACCMST_KEY    KLIST
050100030312     C                   KFLD                    ACTRST
050200030312     C                   KFLD                    ACSUB#
050300030312     C                   KFLD                    ACACCT
050400030311     C     GRATE_KEY     KLIST
050500030312     C                   KFLD                    ACTRST
050600030312     C                   KFLD                    ACSUB#
050700030312     C                   KFLD                    MCPLAN
050800030312     C                   KFLD                    MCAGEB
050900030313     C                   KFLD                    MCOVTP
051000030313     C     AACODE_KEY    KLIST
051100030313     C                   KFLD                    AACODE_I
051200030313     C                   KFLD                    AAREC#
051300030903    ? * Open file - Override MSBCEEF1 for all usage, no sharing, forcedwrite
051400030903    ? *
051500030903    ? * RETRIEVE JOB ATTRIBUTES
051600030903    ?C                   Call      'QUSRJOBI'
051700030903    ?C                   Parm                    WDJOBA
051800030903    ?C                   Parm                    WDRCVL
051900030903    ?C                   Parm      'JOBI0100'    WWFMTN            8
052000030903    ?C                   Parm      '*'           WWQJN            26
052100030903    ?C                   Parm                    WWIJI            16
0522000303130062 C                   EVAL      AAREC# = *ZEROS
052300030312
052400030702     C                   EVAL      TYY = *YEAR
052500030702     C                   EVAL      TMM = *MONTH
052600030702     C                   EVAL      TDD = *DAY
052700030702
052800150227
052900150227      * Carrier cancel date:
053000150227      * if subtract 1 day parm is "Y" (for Care First groups) then subtract
053100150227      * 1 day from cancel effdt, else use actual cancel effdt (alternate
053200150227      * carriers)
053300150227     C     *USA          MOVE      LMDY          ISO_DATE
053400150227     C                   MOVE      ISO_DATE      LCYMD
053500150323      * effdt (mdy) for non-cf letter
053600150323     C                   MOVE      iso_date      USA_DATE
053700150323     C                   MOVE      USA_DATE      EFFCANDT
053800150227
053900150302     c                   move      iso_date      carcanymd         8 0
054000150227     c                   if        lsub1day = 'Y'
054100150302     c                   subdur    1:*d          iso_date
054200150302     c                   move      iso_date      carcanymd
054300150227     c                   end
054400150302     c     *iso          move      carcanymd     usa_date
054500150302     c                   move      usa_date      carcanmdy         8 0
054600030311
054700030311     C                   TIME                    TIME_DATE
054800030311     C     *MDY          MOVE      DATE          ISO_DATE
054900030311     C                   MOVEL     ISO_DATE      CUR_DATE
055000030312     C                   MOVE      LTRST         ACTRST
055100030312     C                   MOVE      LSUB#         ACSUB#
055200140501     C                   MOVE      LACCT         ACACCT
0553000303140066 C                   MOVEL     MNA(CUR_MM)   MONTHYY
055400030314     C                   CAT       CUR_DD:1      MONTHYY
055500030314     C                   CAT       ',':0         MONTHYY
055600030314     C                   CAT       CUR_YYYY:1    MONTHYY
055700030314      *?M/D/Y DATE LINE
0558000306250066 C                   MOVEL     MNA(LUCMM)    MONTHCOV
055900030625     C                   CAT       LUCYY:1       MONTHCOV
056000030314     C                   EVAL      GRP_E = 1
056100030314     C     *BLANKS       LOOKUP    LGRP(GRP_E)                            26
056200030314     C                   EVAL      GRP_E = GRP_E - 1
056300150303
056400150303      * move all group #'s from prompt screen to field for use in acct
056500150303      * letter
056600150303
056700150303     c                   do        8             xx                2 0
056800150303     c                   if        lgrp(xx) <> *blanks
056900150303
057000150303     C                   if        xx = 1
0571001503030066 C                   MOVEL     lgrp(xx)      GRP#out1         70
057200150303     c                   iter
057300150303     c                   end
057400150303     C                   if        xx = 5
0575001503030066 C                   MOVEL     lgrp(xx)      GRP#out2         70
057600150303     c                   iter
057700150303     c                   end
057800150303      * add another group #
057900150303     C                   if        xx <= 4
058000150303     C                   CAT       ',':0         GRP#out1
058100150303     C                   CAT       lgrp(xx):1    GRP#out1
058200150303     C                   else
058300150303     C                   CAT       ',':0         GRP#out2
058400150303     C                   CAT       lgrp(xx):1    GRP#out2
058500150303     C                   end
058600150303
058700150303     C                   end
058800150303
058900150303     C                   enddo
059000150303
0591009812010675 C                   ENDSR
0592000303100672  *?***************************************************************
059300970806**
059400970227JANUARY
059500970227FEBRUARY
059600970227MARCH
059700970227APRIL
059800970227MAY
059900970227JUNE
060000970227JULY
060100970227AUGUST
060200970227SEPTEMBER
060300970227OCTOBER
060400970227NOVEMBER
060500970227DECEMBER
