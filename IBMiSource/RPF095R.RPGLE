0001000303100002  *?****************************************************************
0002000307070003  *?RPF095R    GROUP BENEFIT SERVICES SOFTWARE                     *
0003000307070002  *?*                                                              *
0004000307290005  *?*        Copied from RPF090R and modified by S. Zien           *
0005000307070006  *?*        DATE -  7/07/2003                                     *
0006000307070002  *?*                                                              *
0007000307070008  *?*     DESCRIPTION - REPRINT ACCOUNT CANCELLATION LETTERS       *
0008000307070002  *?*                                                              *
0009000307070002  *?* Note:  The only difference between this program and RPF090R  *
0010000307070002  *?*        at the time it was copied is that no diary note is    *
0011000307290002  *?*        written at Reprint time.                              *
0012001502260002  * 02/26/15 dlk - change printer file to use rpf090p instead
0013001502260002  *                of rpa090pa and rpa090pm since they were merged
0014001502260002  *                into rpf090p last year and this program was
0015001502260002  *                not changed to reflect the new merged dds
001600150303I 10  * 03/03/2015 dlk add subtract 1 day for letter effdt parm. This  *
001700150303I 10  *                is for Care First groups. Remove Benegap letters*
001800150303I 10  *                since they are no longer needed (ok by Cindy W) *
001900190212I 10  * 02/12/2019 dlk Add new letter for Care First accounts that are *
002000190212I 10  *                subject to the PSF rules. Page segment is       *
002100190212I 10  *                CANAC_PS and letterhead overlay is RPF090OL     *
002200190212I 10  *                new rec formats in dds are APSCFPSF and AVRCFPSF *
002300211201I 10  * 12/01/2021 dlk change aa email to be seperate longer field
002400190212I 10  *                                                                *
002500190212I 10  *
0026001902120012  * 2/11/19 - Page segment and letterhead overly for Care First
0027001902120012  *           psf cancel letter
0028001902120012  * I:\MIS\AS400PageSegments\GBS Letters\Cancel letters - RPF090\
0029001902120012  * 2-8-19 letter for CF PSF
003000190212I 10  *
0031001502260002  *
0032001502260002  *
0033000303100012  *?****************************************************************
0034000303100013 FACCMST    IF   E           K DISK
0035000303100014 FMEMAC#    IF   E           K DISK
0036001503030016 Fmcovc     IF   E           K DISK
0037000303100021 FGRATE     IF   E           K DISK
0038000303100021 FSMAN      IF   E           K DISK
003900030313     FAACODE    IF   E           K DISK
0040001502260027 FRPF090P   O    E             PRINTER
004100030311
004200030311     D ISO_DATE        S               D   DATFMT(*ISO)
004300030313     D USA_DATE        S               D   DATFMT(*USA)
004400030310
0045000303130020 D ONCE            S               N   INZ('0')
0046000303140020 D ONCE2           S               N   INZ('0')
0047000303140020 D ONCE3           S               N   INZ('0')
0048000303140020 D ONCE4           S               N   INZ('0')
0049000303140020 D PRTACCLET       S               N   INZ('0')
0050000303140020 D PRTMBRLET       S               N   INZ('0')
0051000303130020 D GAR             S             15    DIM(8)
0052009702270020 D MAR             S             15    DIM(8)
0053009702270022 D DL2             S              1    DIM(19)
0054009702190030 D AL              S              1    DIM(30)
0055009702190013 D AL2             S              1    DIM(30)
0056000303110032 D N_A             S              1    DIM(31)
0057000303140021 D MNA             S              9    DIM(12) CTDATA PERRCD(1)
0058000303110036 D ZERO9           S              9  0 INZ(*ZEROS)
0059000303110036 D ZERO7           S              7  0 INZ(*ZEROS)
0060000303110036 D GCOUNT          S              2  0 INZ(*ZEROS)
0061000303110036 D INDEX           S              3  0 INZ(*ZEROS)
0062000303110036 D N#              S              2  0 INZ(*ZEROS)
0063000303140036 D GRP_E           S              3  0 INZ(*ZEROS)
0064000303110051 D GRPNBRS         S             14
0065000303130051 D LCYMD           S              8  0 INZ(*ZEROS)
006600030725     D WDate8          S              8S 0 Inz(0)
0067001503030055 D                 DS
0068001503030056 D  BAL                    1    108  2
006900150303     D                                     DIM(12)
0070001503030056 D  BAL1                   1      9  2
0071001503030056 D  BAL2                  10     18  2
0072001503030056 D  BAL3                  19     27  2
0073001503030056 D  BAL4                  28     36  2
0074001503030056 D  BAL5                  37     45  2
0075001503030056 D  BAL6                  46     54  2
0076001503030056 D  BAL7                  55     63  2
0077001503030056 D  BAL8                  64     72  2
0078001503030056 D  BAL9                  73     81  2
0079001503030056 D  BAL10                 82     90  2
0080001503030056 D  BAL11                 91     99  2
0081001503030056 D  BAL12                100    108  2
0082000303110046 D                 DS
0083000303110051 D CUR_DATE                       8  0 INZ(*ZEROS)
0084000303120051 D CUR_YYYY                       4    OVERLAY(CUR_DATE)
0085000303110051 D CUR_MM                         2  0 OVERLAY(CUR_DATE:*NEXT)
0086000303120051 D CUR_DD                         2    OVERLAY(CUR_DATE:*NEXT)
008700030310
0088009102120046 D                 DS
0089000303110047 D AZIP                                INZ(*ZEROS)
0090000303120048 D  AZIP5                         5    OVERLAY(AZIP)
0091000303120049 D  AZIP4                         4    OVERLAY(AZIP:*NEXT)
009200030312
0093000303120046 D                 DS
0094000303120047 D ZIP                                 INZ(*ZEROS)
0095000303120048 D  ZIP5                          5    OVERLAY(ZIP)
0096000303120049 D  ZIP4                          4    OVERLAY(ZIP:*NEXT)
0097000307250046 D                 DS
0098000307250048 D AccKey                  1     10
009900030725     D  ACTRST                             OVERLAY(AccKey)
010000030725     D  ACSUB#                             OVERLAY(AccKey:*NEXT)
010100030725     D  ACACCT                             OVERLAY(AccKey:*NEXT)
010200030702
010300030311     D                 DS
010400030311     D TIME_DATE                     12  0
010500030311     D  TIME                          6  0 OVERLAY(TIME_DATE)
010600030311     D  DATE                          6  0 OVERLAY(TIME_DATE:7)
010700030310
0108000307020055 D                 DS
0109000307020056 D  TODAY                  1      8  0
0110000307020056 D  TYY                    1      4  0
0111000307020056 D  TMM                    5      6  0
0112000307020056 D  TDD                    7      8  0
011300030702
0114009102120055 D                UDS
0115009812010056 D  LMDY                   1      8  0
0116000303130056 D  LMM                    1      2  0
0117000303130056 D  LDD                    3      4
0118000303130056 D  LCY                    5      8
0119000303120056 D  LTRST                  9     11  0
0120000303120056 D  LSUB#                 12     14  0
0121000303120056 D  LACCT                 15     18  0
012200030314     D MBRLET_YN             140    140
0123000306250056 D  LUCMM                141    142  0
0124000306250056 D  LUCYY                143    146
012500030729     D  LTRMDY               147    154  0
012600150303     D  Lsub1day             155    155
0127000303140056 D  LGRP                  20    139    DIM(8)
0128000305060094 D  USERID               190    197
0129009102120057 D  CONAME               201    240
0130000303130060
013100030313     IACCMSR
013200030313     I              AACODE                      AACODE_I
0133000303100060
013400150313     c                   clear                   contactout
013500211201     c                   clear                   aemlaout
013600150421     c                   clear                   smanout
013700030313     C     *NOKEY        CLEAR     *ALL          ACCMSR
013800030313     C     ACCMST_KEY    CHAIN     ACCMSR
013900030314     C                   IF        %FOUND(ACCMST)
014000030314     C                   IF        ONCE  = *OFF
014100030314     C                   EVAL      ONCE  = *ON
014200150304     C                   Movel     AccKey        KEYACC
014300030314
014400030314     C     *NOKEY        CLEAR     *ALL          AACODR
014500030314     C     AACODE_KEY    CHAIN     AACODR
014600030314     C                   EVAL      ADDIALC = %EDITW(ADDIAL:'   -   -    ')
014700030320     C                   MOVEL     AFNAM         NAME_32
014800030320     C                   CAT       ALNAM:1       NAME_32
014900150313
015000211201      * AA email
015100211201     c                   eval      aemlaout = %trim(aemla)
015200030310
015300150421      * salesman name
015400030311     C     *NOKEY        CLEAR     *ALL          SMANR
0155000303110234 C     SMANCD        CHAIN     SMAN
015600150421     C                   if        %found(sman)
015700150421     c     sfname        cat       slname:1      smanout
015800150421     C                   end
015900150421
016000030314     C                   END
016100030725
016200150303
016300150303      * outstanding balance for acct letter
0164001503030144 C                   XFOOT     BAL           outbal
016500150313      * contact name on letter
016600150313     c                   if        ecntac <> *blanks
016700150313     c                   movel     ecntac        contactout
016800150313     c                   else
016900150313     c                   movel     contac        contactout
017000150313     c                   end
017100150303
017200030729      *?Get Parm for original letter date entered by user into LDA.
017300030729     C     LTRMDY        MULT      10000.0001    LTRDATE           8 0
017400030729     C                   Z-add     LTRDATE       Wdate8
017500030729     C                   Exsr      DateFmt
017600030729     C                   Eval      MONTHYY   =   %Trim(Output_Date)
017700030725
0178000303100308  *?PRINT LETTER FOR ALL MEMBERS IN ACCOUNT WITH GROUP#'S SELECTED
017900030312     C     MEMBR_KEY     SETLL     MEMBR
018000030314     C                   DOU       %EOF(MEMAC#)
018100030312     C     MEMBR_KEY     READE     MEMBR
018200030314     C                   IF        NOT %EOF(MEMAC#)
018300970227     C                   MOVE      *BLANKS       MAR
0184000303140066 C                   MOVE      *BLANKS       GROUPSM
018500030310      *?READ COVERAGES
018600030314     C                   EVAL      ONCE3 = *OFF
018700030314     C                   EVAL      ONCE4 = *OFF
018800030314     C                   EVAL      PRTMBRLET = *OFF
018900150303     C     MBSSNO        SETLL     MCOVC
019000150303     C                   DOU       %EOF(MCOVc)
019100150303     C     MBSSNO        READE     MCOVC
019200150303     C                   IF        NOT %EOF(MCOVC) AND
019300030311     C                             CANDT = LCYMD
019400030313
019500030310      *?ONLY SELECT COVERAGES W/CANDT = DATE SELECTED
019600030310      *?GET GROUP#'S
0197009702270446 C                   Z-ADD     *ZEROS        GCOUNT
0198000303120447 C     GRATE_KEY     SETLL     GRATER
0199000303140449 C                   DOU       %EOF(GRATE)
020000030311     C     *NOKEY        CLEAR     *ALL          GRATER
0201000303120451 C     GRATE_KEY     READE     GRATER
020200030314     C                   IF        NOT %EOF(GRATE)
0203000303100454
020400030314     C                   IF        LCYMD >= FRMDAT AND
020500030311     C                             LCYMD <= TODAT
0206000303110457 C                   ADD       1             GCOUNT
020700030314     C                   EVAL      PRTACCLET = *ON
0208000303110458 C                   LEAVE
0209000303140459 C                   END
0210000303140460 C                   END
0211000303140462 C                   ENDDO
0212000303100465  *?IF GOOD RATE AND GROUP# IS SELECTED - STORE
021300030314     C                   IF        GCOUNT <> *ZEROS
021400030311     C     GROUP#        LOOKUP    LGRP                                   61
0215000303140466 C                   IF        %EQUAL
021600030314     C                   EVAL      PRTMBRLET = *ON
021700150303     C                   EXSR      STORG_SR
021800030314     C                   IF        MBRLET_YN = 'Y'
021900030314     C                   IF        ONCE3 = *OFF
022000030314     C                   EVAL      ONCE3 = *ON
022100030317     C                   EVAL      GRPNBRS = 'Group Numbers:'
022200030310
0223000303120147 C                   EXSR      MBRNAME_SR
0224000303140467 C                   END
022500030314     C                   END
022600030314
022700030314     C                   END
022800030314     C                   END
022900030314     C                   END
023000030314     C                   ENDDO
023100030314     C                   IF        MBRLET_YN = 'Y' AND
023200030314     C                             PRTMBRLET = *ON
023300150323
023400190212      * Care First account letter (Subtract 1 day prompt entered as "Y")
023500150323     c                   if        lsub1day = 'Y'
023600150323     C                   WRITE     MBRvr_cf
023700150323     C                   WRITE     MBRPS_CF
023800150323      * Non Care First letter
023900150323     c                   else
024000150323     C                   WRITE     MBRvr
024100150323     C                   WRITE     MBRPS
024200150323     C                   end
024300150323
024400030314     C                   IF        ONCE4 = *OFF
024500030314     C                   EVAL      ONCE4 = *ON
024600030314     C                   END
024700030314     C                   END
024800030314     C                   END
0249000303140317 C                   ENDDO
025000030314     C                   END
0251000303140308  *?ACCOUNT LETTER
0252000303140308  *?IF ACCT DID NOT HAVE ANY GROUP#'S THAT WERE SELECTED - ERROR
025300030314     C                   IF        PRTACCLET = *ON
025400030317     C                   EVAL      GRPNBRS = 'Group Numbers:'
0255000303140144 C                   EXSR      ACCADDR_SR
025600190212
025700190212      * Care First account letter (Subtract 1 day prompt entered as "Y")
025800150313     c                   if        lsub1day = 'Y'
025900190213      * If this acct is subject to the Care First PSF rules and there is
026000190213      * a PSF or BSF set up, print the PSF letter and show "P" in letter
026100190213      * file, else print the non-psf letter
026200190212     c                   exsr      #getpsf
026300190212     c                   if        psfyn = 'Y'
026400190212      * PSF letter
026500190212     C                   WRITE     AVRCFPSF
026600190212     C                   WRITE     APSCFPSF
026700190212     c                   else
026800190212      * Non PSF letter
026900150313     C                   WRITE     ACCvr_cf
027000150313     C                   WRITE     ACCPS_CF
027100190212     c                   end
027200190212
027300150313      * Non Care First letter
027400150313     c                   else
027500150313     C                   WRITE     ACCvr
027600150313     C                   WRITE     ACCPS
027700150313     C                   end
027800150313
027900030314     C                   END
028000030310
028100030312     C                   EVAL      *INLR = *ON
0282000307250351  *?**************************************************************
028300030725     C     DateFmt       BEGSR
028400030725     C                   Movel     Wdate8        Input_Date
028500030725     C                   Eval      Input_Format  = 'YYYYMMDD'
028600030725     C                   Eval      Output_Format = 'Mmmmmmmmmz DD, YYYY'
028700030725     C                   Call      'FMTDATE'
028800030725     C                   Parm                    Input_Date       32
028900030725     C                   Parm                    Input_Format     32
029000030725     C                   Parm                    Output_Format    32
029100030725     C                   Parm                    Output_Date      32
029200030725     C                   Parm                    Output_Error     10
029300030725
029400030725     C                   ENDSR
0295000307250647  ****************************************************************
0296000303120650 C     MBRNAME_SR    BEGSR
0297000303120654 C                   MOVE      *BLANKS       MBRNAME
0298000303120656 C                   MOVEL     MFNAME        MBRNAME
029900030312     C                   IF        MMI <> *BLANKS
030000030313     C                   CAT       MMI:1         MBRNAME
0301000303130670 C                   CAT       '.':0         MBRNAME
030200030312     C                   END
030300030312     C                   CAT       MLNAME:1      MBRNAME
0304000303140654 C                   MOVE      *BLANKS       ADDR3
0305000303140656 C                   MOVEL     CITY          ADDR3
030600030314     C                   CAT       STATE:1       ADDR3
0307000303140386 C                   CAT       ZIP5:2        ADDR3
030800030314     C                   IF        ZIP4 <> '0000'
0309000303140390 C                   CAT       '-':0         ADDR3
0310000303140391 C                   CAT       ZIP4:0        ADDR3
0311000303140392 C                   END
031200030314     C                   IF        ADDR2  = *BLANKS
031300030314     C                   EVAL      ADDR2  = ADDR3
031400030314     C                   EVAL      ADDR3  = *BLANKS
031500030314     C                   END
031600030312     C                   ENDSR
0317000303130352  *?**************************************************************
031800150303     C     STORG_SR      BEGSR
031900030310      *?STORE GROUP# FOR MEMBER
032000150303     C                   DO        GRP_E         INDEX
032100150303     C                   IF        MAR(INDEX) = *BLANKS
032200150303     C                   MOVE      GROUP#        MAR(INDEX)
032300150303     C                   IF        INDEX = 1
0324001503030066 C                   MOVEL     GROUP#        GROUPSM
032500150303     C                   ELSE
032600150303     C                   CAT       ',':0         GROUPSM
032700150303     C                   CAT       GROUP#:0      GROUPSM
032800150303     C                   END
032900150303     C                   LEAVE
033000150303     C                   ELSE
033100030310
033200150303     C                   IF        MAR(INDEX) = GROUP#
033300150303     C                   LEAVE
033400030310
033500150303     C                   END
033600150303     C                   END
033700150303     C                   ENDDO
033800150303
033900030310
034000150303     C                   ENDSR
0341000303100354  *?**************************************************************
0342000303100355  *?ACCT ADDR
0343000303120356 C     ACCADDR_SR    BEGSR
0344000303120654 C                   MOVE      *BLANKS       AADDR3
0345000303120656 C                   MOVEL     ACITY         AADDR3
034600030312     C                   CAT       ASTATE:1      AADDR3
0347000303120386 C                   CAT       AZIP5:2       AADDR3
034800030312     C                   IF        AZIP4 <> '0000'
0349000303120390 C                   CAT       '-':0         AADDR3
0350000303120391 C                   CAT       AZIP4:0       AADDR3
0351009702200392 C                   END
035200030313     C                   IF        AADDR2  = *BLANKS
035300030313     C                   EVAL      AADDR2  = AADDR3
035400030313     C                   EVAL      AADDR3  = *BLANKS
035500030313     C                   END
0356000303110394 C                   ENDSR
035700190212
0358001902120103 C*******************************************************************
0359001902130104 C* call getpsf to see if this acct is subject to the PSF and if they
0360001902130104 C* have a PSF or BSF active
0361001902120103 C*******************************************************************
036200190212     c     #getpsf       begsr
036300190212     c                   movel     keyacc        parmpsftsa
036400190212     c                   move      lcymd         parmpsfeff
036500190212     c                   clear                   psfyn             1
036600190213     c                   clear                   parmpsfelig
036700190213     c                   clear                   parmpsftype
036800190212
036900190212     c                   call      'GETPSFCL'
037000190212     c                   parm                    parmpsftsa       10
037100190213     c                   parm                    parmpsfeff        8
037200190213     c                   parm                    parmpsfelig       1
037300190213     c                   parm                    parmpsftype       1
037400190212
037500190213      * if eligible and there is a psf/bsf fee active
037600190213     c                   if        parmpsfelig = 'Y' and parmpsftype <> ' '
037700190213     c                   move      'Y'           psfyn
037800190213     c                   end
037900190213
038000190212     c                   endsr
038100190212
0382000303100672  *?***************************************************************
038300981201     C     *INZSR        BEGSR
038400030312     C     MEMBR_KEY     KLIST
038500030312     C                   KFLD                    ACTRST
038600030312     C                   KFLD                    ACSUB#
038700030312     C                   KFLD                    ACACCT
038800030312     C     ACCMST_KEY    KLIST
038900030312     C                   KFLD                    ACTRST
039000030312     C                   KFLD                    ACSUB#
039100030312     C                   KFLD                    ACACCT
039200030311     C     GRATE_KEY     KLIST
039300030312     C                   KFLD                    ACTRST
039400030312     C                   KFLD                    ACSUB#
039500030312     C                   KFLD                    MCPLAN
039600030312     C                   KFLD                    MCAGEB
039700030313     C                   KFLD                    MCOVTP
039800030313     C     AACODE_KEY    KLIST
039900030313     C                   KFLD                    AACODE_I
040000030313     C                   KFLD                    AAREC#
0401000303130062 C                   EVAL      AAREC# = *ZEROS
040200030312
040300030702     C                   EVAL      TYY = *YEAR
040400030702     C                   EVAL      TMM = *MONTH
040500030702     C                   EVAL      TDD = *DAY
040600030702
040700150303
040800150303      * Carrier cancel date:
040900150303      * if subtract 1 day parm is "Y" (for Care First groups) then subtract
041000150303      * 1 day from cancel effdt, else use actual cancel effdt (alternate
041100150303      * carriers)
041200150303     C     *USA          MOVE      LMDY          ISO_DATE
041300150303     C                   MOVE      ISO_DATE      LCYMD
041400150325      * effdt (mdy) for non-cf letter
041500150325     C                   MOVE      iso_date      USA_DATE
041600150325     C                   MOVE      USA_DATE      EFFCANDT
041700150303
041800150303     c                   move      iso_date      carcanymd         8 0
041900150303     c                   if        lsub1day = 'Y'
042000150303     c                   subdur    1:*d          iso_date
042100150303     c                   move      iso_date      carcanymd
042200150303     c                   end
042300150303     c     *iso          move      carcanymd     usa_date
042400150303     c                   move      usa_date      carcanmdy         8 0
042500150303
042600030626     C     *USA          MOVE      LMDY          ISO_DATE
042700030313     C                   MOVE      ISO_DATE      LCYMD
042800030311
042900030311     C                   TIME                    TIME_DATE
043000030311     C     *MDY          MOVE      DATE          ISO_DATE
043100030311     C                   MOVEL     ISO_DATE      CUR_DATE
043200030312     C                   MOVE      LTRST         ACTRST
043300030312     C                   MOVE      LSUB#         ACSUB#
043400030312     C                   MOVE      LACCT         ACACCT
043500150325
0436000306250066 C                   MOVEL     MNA(LUCMM)    MONTHCOV
043700030625     C                   CAT       LUCYY:1       MONTHCOV
043800030314     C                   EVAL      GRP_E = 1
043900030314     C     *BLANKS       LOOKUP    LGRP(GRP_E)                            26
044000030314     C                   EVAL      GRP_E = GRP_E - 1
044100150303
044200150303
044300150303      * move all group #'s from prompt screen to field for use in acct
044400150303      * letter
044500150303
044600150303     c                   do        8             xx                2 0
044700150303     c                   if        lgrp(xx) <> *blanks
044800150303
044900150303     C                   if        xx = 1
0450001503030066 C                   MOVEL     lgrp(xx)      GRP#out1         70
045100150303     c                   iter
045200150303     c                   end
045300150303     C                   if        xx = 5
0454001503030066 C                   MOVEL     lgrp(xx)      GRP#out2         70
045500150303     c                   iter
045600150303     c                   end
045700150303      * add another group #
045800150303     C                   if        xx <= 4
045900150303     C                   CAT       ',':0         GRP#out1
046000150303     C                   CAT       lgrp(xx):1    GRP#out1
046100150303     C                   else
046200150303     C                   CAT       ',':0         GRP#out2
046300150303     C                   CAT       lgrp(xx):1    GRP#out2
046400150303     C                   end
046500150303
046600150303     C                   end
046700150303
046800150303     C                   enddo
046900150303
0470009812010675 C                   ENDSR
0471000303100672  *?***************************************************************
047200970806**
047300970227JANUARY
047400970227FEBRUARY
047500970227MARCH
047600970227APRIL
047700970227MAY
047800970227JUNE
047900970227JULY
048000970227AUGUST
048100970227SEPTEMBER
048200970227OCTOBER
048300970227NOVEMBER
048400970227DECEMBER
