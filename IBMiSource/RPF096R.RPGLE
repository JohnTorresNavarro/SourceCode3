0001000303100002  *?****************************************************************
0002000308220003  *?RPF096R    GROUP BENEFIT SERVICES SOFTWARE                     *
0003000307070002  *?*                                                              *
0004000308080005  *?*        Copied from RPF096R and modified by S. Zien           *
0005000308080006  *?*        DATE -  8/08/2003                                     *
0006000307070002  *?*                                                              *
0007000307070008  *?*     DESCRIPTION - REPRINT ACCOUNT CANCELLATION LETTERS       *
0008000307070002  *?*                                                              *
0009000308080002  *?* Note:  The only difference between this program and RPF095R  *
0010000308080002  *?*        at the time it was copied is that letters are re-     *
0011000308080002  *?*        printed based on data from CANLET rather than from a  *
0012000308080002  *?*        prompt screen.                                        *
0013000308080002  *?*                                                              *
0014000308080002  *?* HISTORY                                                      *
001500061003    ? * 10/03/06 szz - Remove stipulation that MCOV CANDT match the letter
001600061003    ? *                canel date so that reinstated ones can get reprinted
001700061003    ? *                per Shelly R.
0018001502260002  * 02/26/15 dlk - change printer file to use rpf090p instead
0019001502260002  *                of rpa090pa and rpa090pm since they were merged
0020001502260002  *                into rpf090p last year and this program was
0021001502260002  *                not changed to reflect the new merged dds
0022001503030002  * 03/03/15 dlk - add new fields for new letter format
0023001902120002  * 02/12/19 dlk - print CF PSF letter when the original letter used
0024001902120002  *                the PSF letter (LDA pos 173 shows "P").
002500211201I 10  * 12/01/2021 dlk change aa email to be seperate longer field
0026000308080002  *?*                                                              *
002700030808I 10  *                                                                *
0028000303100012  *?****************************************************************
0029000303100013 FACCMST    IF   E           K DISK
0030000303100014 FMEMAC#    IF   E           K DISK
0031000303100016 FMCOV      IF   E           K DISK
0032000303100021 FGRATE     IF   E           K DISK
0033000303100021 FSMAN      IF   E           K DISK
003400030313     FAACODE    IF   E           K DISK
0035001502260027 FRPF090P   O    E             PRINTER
003600030311
003700030311     D ISO_DATE        S               D   DATFMT(*ISO)
003800030313     D USA_DATE        S               D   DATFMT(*USA)
003900030310
0040000303130020 D ONCE            S               N   INZ('0')
0041000303140020 D ONCE2           S               N   INZ('0')
0042000303140020 D ONCE3           S               N   INZ('0')
0043000303140020 D ONCE4           S               N   INZ('0')
0044000303140020 D PRTACCLET       S               N   INZ('0')
0045000303140020 D PRTMBRLET       S               N   INZ('0')
0046000303130020 D GAR             S             15    DIM(8)
0047009702270020 D MAR             S             15    DIM(8)
0048009702270022 D DL2             S              1    DIM(19)
0049009702190030 D AL              S              1    DIM(30)
0050009702190013 D AL2             S              1    DIM(30)
0051000303110032 D N_A             S              1    DIM(31)
0052000303140021 D MNA             S              9    DIM(12) CTDATA PERRCD(1)
0053000303110036 D ZERO9           S              9  0 INZ(*ZEROS)
0054000303110036 D ZERO7           S              7  0 INZ(*ZEROS)
0055000303110036 D GCOUNT          S              2  0 INZ(*ZEROS)
0056000303110036 D INDEX           S              3  0 INZ(*ZEROS)
0057000303110036 D N#              S              2  0 INZ(*ZEROS)
0058000303140036 D GRP_E           S              3  0 INZ(*ZEROS)
0059000303130051 D LCYMD           S              8  0 INZ(*ZEROS)
006000030725     D WDate8          S              8S 0 Inz(0)
006100030808     D Group_Ctr       S              1  0 Inz(*Zeros)
0062000303110046 D                 DS
0063000303110051 D CUR_DATE                       8  0 INZ(*ZEROS)
0064000303120051 D CUR_YYYY                       4    OVERLAY(CUR_DATE)
0065000303110051 D CUR_MM                         2  0 OVERLAY(CUR_DATE:*NEXT)
0066000303120051 D CUR_DD                         2    OVERLAY(CUR_DATE:*NEXT)
006700030310
0068009102120046 D                 DS
0069000303110047 D AZIP                                INZ(*ZEROS)
0070000303120048 D  AZIP5                         5    OVERLAY(AZIP)
0071000303120049 D  AZIP4                         4    OVERLAY(AZIP:*NEXT)
007200030312
0073000303120046 D                 DS
0074000303120047 D ZIP                                 INZ(*ZEROS)
0075000303120048 D  ZIP5                          5    OVERLAY(ZIP)
0076000303120049 D  ZIP4                          4    OVERLAY(ZIP:*NEXT)
0077000307250046 D                 DS
0078000307250048 D AccKey                  1     10
007900030725     D  ACTRST                             OVERLAY(AccKey)
008000030725     D  ACSUB#                             OVERLAY(AccKey:*NEXT)
008100030725     D  ACACCT                             OVERLAY(AccKey:*NEXT)
008200030702
008300030311     D                 DS
008400030311     D TIME_DATE                     12  0
008500030311     D  TIME                          6  0 OVERLAY(TIME_DATE)
008600030311     D  DATE                          6  0 OVERLAY(TIME_DATE:7)
008700030310
0088000307020055 D                 DS
0089000307020056 D  TODAY                  1      8  0
0090000307020056 D  TYY                    1      4  0
0091000307020056 D  TMM                    5      6  0
0092000307020056 D  TDD                    7      8  0
009300030702
0094009102120055 D                UDS
0095009812010056 D  LMDY                   1      8  0
0096000303130056 D  LMM                    1      2  0
0097000303130056 D  LDD                    3      4
0098000303130056 D  LCY                    5      8
0099000303120056 D  LTRST                  9     11  0
0100000303120056 D  LSUB#                 12     14  0
0101000303120056 D  LACCT                 15     18  0
010200030314     D MBRLET_YN             140    140
0103000306250056 D  LUCMM                141    142  0
0104000306250056 D  LUCYY                143    146
010500030729     D  LTRMDY               147    154  0
010600150303     D  Lleteffymd           155    162  0
010700150303     D  Loutbal              163    172  2
010800150313     D  Lcflet               173    173
0109000303140056 D  LGRP                  20    139    DIM(8)
0110000305060094 D  USERID               190    197
0111009102120057 D  CONAME               201    240
0112000303130060
011300030313     IACCMSR
011400030313     I              AACODE                      AACODE_I
0115000303100060
011600150313     C                   clear                   contactout
011700211201     c                   clear                   aemlaout
011800150421     c                   clear                   smanout
011900030313     C     *NOKEY        CLEAR     *ALL          ACCMSR
012000030313     C     ACCMST_KEY    CHAIN     ACCMSR
012100030314     C                   IF        %FOUND(ACCMST)
012200150313      * contact name on letter
012300150313     c                   if        ecntac <> *blanks
012400150313     c                   movel     ecntac        contactout
012500150313     c                   else
012600150313     c                   movel     contac        contactout
012700150313     c                   end
012800150313
012900030314     C                   IF        ONCE  = *OFF
013000030314     C                   EVAL      ONCE  = *ON
013100150304     C                   Movel     AccKey        KEYACC
013200030314
013300030314     C     *NOKEY        CLEAR     *ALL          AACODR
013400030314     C     AACODE_KEY    CHAIN     AACODR
013500030314     C                   EVAL      ADDIALC = %EDITW(ADDIAL:'   -   -    ')
013600030320     C                   MOVEL     AFNAM         NAME_32
013700030320     C                   CAT       ALNAM:1       NAME_32
013800150313
013900211201      * AA email
014000211201     c                   eval      aemlaout = %trim(aemla)
014100150313
014200030310
014300150421      * salesman name
014400030311     C     *NOKEY        CLEAR     *ALL          SMANR
0145000303110234 C     SMANCD        CHAIN     SMAN
014600150421     C                   if        %found(sman)
014700150421     c     sfname        cat       slname:1      smanout
014800150421     C                   end
014900150421
015000030314     C                   END
015100030725
015200030729      *?Get Parm for original letter date entered by user into LDA.
015300030729     C     LTRMDY        MULT      10000.0001    LTRDATE           8 0
015400030729     C                   Z-add     LTRDATE       Wdate8
015500030729     C                   Exsr      DateFmt
015600030729     C                   Eval      MONTHYY   =   %Trim(Output_Date)
015700030725
0158000303100308  *?PRINT LETTER FOR ALL MEMBERS IN ACCOUNT WITH GROUP#'S SELECTED
015900030312     C     MEMBR_KEY     SETLL     MEMBR
016000030314     C                   DOU       %EOF(MEMAC#)
016100030312     C     MEMBR_KEY     READE     MEMBR
016200030314     C                   IF        NOT %EOF(MEMAC#)
016300970227     C                   MOVE      *BLANKS       MAR
0164000303140066 C                   MOVE      *BLANKS       GROUPSM
016500030310      *?READ COVERAGES
016600030314     C                   EVAL      ONCE3 = *OFF
016700030314     C                   EVAL      ONCE4 = *OFF
016800030314     C                   EVAL      PRTMBRLET = *OFF
016900150304     C     MBSSNO        SETLL     MCOV
017000030314     C                   DOU       %EOF(MCOV)
017100150304     C     MBSSNO        READE     MCOV
017200061003     C************       IF        NOT %EOF(MCOV) AND
017300061003     C************                 CANDT = LCYMD
017400061003     C                   IF        NOT %EOF(MCOV)
017500030313
017600030310      *?ONLY SELECT COVERAGES W/CANDT = DATE SELECTED
017700030310      *?GET GROUP#'S
0178009702270446 C                   Z-ADD     *ZEROS        GCOUNT
0179000303120447 C     GRATE_KEY     SETLL     GRATER
0180000303140449 C                   DOU       %EOF(GRATE)
018100030311     C     *NOKEY        CLEAR     *ALL          GRATER
0182000303120451 C     GRATE_KEY     READE     GRATER
018300030314     C                   IF        NOT %EOF(GRATE)
0184000303100454
018500030314     C                   IF        LCYMD >= FRMDAT AND
018600030311     C                             LCYMD <= TODAT
0187000303110457 C                   ADD       1             GCOUNT
018800030314     C                   EVAL      PRTACCLET = *ON
0189000303110458 C                   LEAVE
0190000303140459 C                   END
0191000303140460 C                   END
0192000303140462 C                   ENDDO
0193000303100465  *?IF GOOD RATE AND GROUP# IS SELECTED - STORE
019400030314     C                   IF        GCOUNT <> *ZEROS
019500030311     C     GROUP#        LOOKUP    LGRP                                   61
0196000303140466 C                   IF        %EQUAL
019700030314     C                   EVAL      PRTMBRLET = *ON
019800030312     C                   EXSR      STORG_SR
019900030314     C                   IF        MBRLET_YN = 'Y'
020000030314     C                   IF        ONCE3 = *OFF
020100030314     C                   EVAL      ONCE3 = *ON
020200030310
0203000303120147 C                   EXSR      MBRNAME_SR
0204000303140467 C                   END
020500030314     C                   END
020600030314
020700030314     C                   END
020800030314     C                   END
020900030314     C                   END
021000030314     C                   ENDDO
021100150304
021200150304      * print member letter
021300030314     C                   IF        MBRLET_YN = 'Y' AND
021400030314     C                             PRTMBRLET = *ON
021500150304
021600150323      * Care First letter
021700190212     c                   if        lcflet = 'Y' or lcflet = 'P'
021800150323     C                   WRITE     MBRvr_cf
021900150323     C                   WRITE     MBRPS_CF
022000150323      * Non Care First letter
022100150323     c                   else
022200150323     C                   WRITE     MBRvr
022300150323     C                   WRITE     MBRPS
022400150323     C                   end
022500150323
022600030314     C                   IF        ONCE4 = *OFF
022700030314     C                   EVAL      ONCE4 = *ON
022800030314     C                   END
022900030314     C                   END
023000030314     C                   END
0231000303140317 C                   ENDDO
023200030314     C                   END
0233000303140308  *?ACCOUNT LETTER
0234000303140308  *?IF ACCT DID NOT HAVE ANY GROUP#'S THAT WERE SELECTED - ERROR
023500030314     C                   IF        PRTACCLET = *ON
0236000303140144 C                   EXSR      ACCADDR_SR
023700150304     c                   exsr      #accgrpout
023800150304
023900190225     c                   select
024000190225      * Care First PSF letter
024100190225     c                   when      lcflet = 'P'
024200190212     C                   WRITE     AVRCFPSF
024300190212     C                   WRITE     APSCFPSF
024400190225      * Care First Non PSF letter
024500190225     c                   when      lcflet = 'Y'
024600150313     C                   WRITE     ACCvr_cf
024700150313     C                   WRITE     ACCPS_CF
024800150313      * Non Care First letter
024900190225     c                   other
025000150313     C                   WRITE     ACCvr
025100150313     C                   WRITE     ACCPS
025200190225     C                   endsl
025300150313
025400030314     C                   END
025500030310
025600030312     C                   EVAL      *INLR = *ON
0257000307250351  *?**************************************************************
025800030725     C     DateFmt       BEGSR
025900030725     C                   Movel     Wdate8        Input_Date
026000030725     C                   Eval      Input_Format  = 'YYYYMMDD'
026100030725     C                   Eval      Output_Format = 'Mmmmmmmmmz DD, YYYY'
026200030725     C                   Call      'FMTDATE'
026300030725     C                   Parm                    Input_Date       32
026400030725     C                   Parm                    Input_Format     32
026500030725     C                   Parm                    Output_Format    32
026600030725     C                   Parm                    Output_Date      32
026700030725     C                   Parm                    Output_Error     10
026800030725
026900030725     C                   ENDSR
0270000307250647  ****************************************************************
0271000303120650 C     MBRNAME_SR    BEGSR
0272000303120654 C                   MOVE      *BLANKS       MBRNAME
0273000303120656 C                   MOVEL     MFNAME        MBRNAME
027400030312     C                   IF        MMI <> *BLANKS
027500030313     C                   CAT       MMI:1         MBRNAME
0276000303130670 C                   CAT       '.':0         MBRNAME
027700030312     C                   END
027800030312     C                   CAT       MLNAME:1      MBRNAME
0279000303140654 C                   MOVE      *BLANKS       ADDR3
0280000303140656 C                   MOVEL     CITY          ADDR3
028100030314     C                   CAT       STATE:1       ADDR3
0282000303140386 C                   CAT       ZIP5:2        ADDR3
028300030314     C                   IF        ZIP4 <> '0000'
0284000303140390 C                   CAT       '-':0         ADDR3
0285000303140391 C                   CAT       ZIP4:0        ADDR3
0286000303140392 C                   END
028700030314     C                   IF        ADDR2  = *BLANKS
028800030314     C                   EVAL      ADDR2  = ADDR3
028900030314     C                   EVAL      ADDR3  = *BLANKS
029000030314     C                   END
029100030312     C                   ENDSR
0292000303130352  *?**************************************************************
029300030312     C     STORG_SR      BEGSR
029400030310      *?STORE GROUP# FOR MEMBER
029500030314     C                   DO        GRP_E         INDEX
029600030314     C                   IF        MAR(INDEX) = *BLANKS
029700030314     C                   MOVE      GROUP#        MAR(INDEX)
029800030314     C                   IF        INDEX = 1
0299000303140066 C                   MOVEL     GROUP#        GROUPSM
030000030314     C                   ELSE
030100030314     C                   CAT       ',':0         GROUPSM
030200030314     C                   CAT       GROUP#:0      GROUPSM
030300030314     C                   END
030400030311     C                   LEAVE
030500970227     C                   ELSE
030600030310
030700030311     C                   IF        MAR(INDEX) = GROUP#
030800030311     C                   LEAVE
030900030310
031000970227     C                   END
031100970227     C                   END
031200030311     C                   ENDDO
031300150303
031400030310      *?STORE GROUP# FOR ACCT
031500150303     C                   DO        GRP_E         INDEX
031600150303     C                   IF        GAR(INDEX) = *BLANKS
031700150303     C                   MOVE      GROUP#        GAR(INDEX)
031800150303     C                   LEAVE
031900150303     C                   ELSE
032000030310
032100150303     C                   IF        GAR(INDEX) = GROUP#
032200150303     C                   LEAVE
032300150303     C                   END
032400030314
032500150303     C                   END
032600150303     C                   ENDDO
032700150303
032800030311     C                   ENDSR
0329000303100354  *?**************************************************************
0330000303100355  *?ACCT ADDR
0331000303120356 C     ACCADDR_SR    BEGSR
0332000303120654 C                   MOVE      *BLANKS       AADDR3
0333000303120656 C                   MOVEL     ACITY         AADDR3
033400030312     C                   CAT       ASTATE:1      AADDR3
0335000303120386 C                   CAT       AZIP5:2       AADDR3
033600030312     C                   IF        AZIP4 <> '0000'
0337000303120390 C                   CAT       '-':0         AADDR3
0338000303120391 C                   CAT       AZIP4:0       AADDR3
0339009702200392 C                   END
034000030313     C                   IF        AADDR2  = *BLANKS
034100030313     C                   EVAL      AADDR2  = AADDR3
034200030313     C                   EVAL      AADDR3  = *BLANKS
034300030313     C                   END
0344000303110394 C                   ENDSR
034500150304
034600150304      ***********************************************
034700150304      * format group # output for acct
034800150304      ***********************************************
034900150304     c     #accgrpout    begsr
035000150304
035100150304     c                   clear                   grp#out1
035200150304     c                   clear                   grp#out2
035300150304
035400150304     c                   do        8             xx                2 0
035500150304     c                   if        gar(xx) <> *blanks
035600150304
035700150304     C                   if        xx = 1
0358001503040066 C                   MOVEL     gar(xx)       GRP#out1         70
035900150304     c                   iter
036000150304     c                   end
036100150304     C                   if        xx = 5
0362001503040066 C                   MOVEL     gar(xx)       GRP#out2         70
036300150304     c                   iter
036400150304     c                   end
036500150304      * add another group #
036600150304     C                   if        xx <= 4
036700150304     C                   CAT       ',':0         GRP#out1
036800150304     C                   CAT       gar(xx):1     GRP#out1
036900150304     C                   else
037000150304     C                   CAT       ',':0         GRP#out2
037100150304     C                   CAT       gar(xx):1     GRP#out2
037200150304     C                   end
037300150304
037400150304     C                   end
037500150304     C                   enddo
037600150304
037700150304     c                   endsr
037800150304
037900150304
0380000303100672  *?***************************************************************
038100981201     C     *INZSR        BEGSR
038200030312     C     MEMBR_KEY     KLIST
038300030312     C                   KFLD                    ACTRST
038400030312     C                   KFLD                    ACSUB#
038500030312     C                   KFLD                    ACACCT
038600030312     C     ACCMST_KEY    KLIST
038700030312     C                   KFLD                    ACTRST
038800030312     C                   KFLD                    ACSUB#
038900030312     C                   KFLD                    ACACCT
039000030311     C     GRATE_KEY     KLIST
039100030312     C                   KFLD                    ACTRST
039200030312     C                   KFLD                    ACSUB#
039300030312     C                   KFLD                    MCPLAN
039400030312     C                   KFLD                    MCAGEB
039500030313     C                   KFLD                    MCOVTP
039600030313     C     AACODE_KEY    KLIST
039700030313     C                   KFLD                    AACODE_I
039800030313     C                   KFLD                    AAREC#
039900030808
0400000303130062 C                   EVAL      AAREC# = *ZEROS
040100030312
040200030702     C                   EVAL      TYY = *YEAR
040300030702     C                   EVAL      TMM = *MONTH
040400030702     C                   EVAL      TDD = *DAY
040500030702
040600030626     C     *USA          MOVE      LMDY          ISO_DATE
040700030313     C                   MOVE      ISO_DATE      LCYMD
040800150325      * effdt (mdy) for non-cf letter
040900150325     C                   MOVE      iso_date      USA_DATE
041000150325     C                   MOVE      USA_DATE      EFFCANDT
041100030311
041200030311     C                   TIME                    TIME_DATE
041300030311     C     *MDY          MOVE      DATE          ISO_DATE
041400030311     C                   MOVEL     ISO_DATE      CUR_DATE
041500150325
041600030312     C                   MOVE      LTRST         ACTRST
041700030312     C                   MOVE      LSUB#         ACSUB#
041800030312     C                   MOVE      LACCT         ACACCT
0419000307240066 C****               MOVEL     MNA(CUR_MM)   MONTHYY
042000030724     C****               CAT       CUR_DD:1      MONTHYY
042100030724     C****               CAT       ',':0         MONTHYY
042200030724     C****               CAT       CUR_YYYY:1    MONTHYY
042300030314      *?M/D/Y DATE LINE
0424000306250066 C                   MOVEL     MNA(LUCMM)    MONTHCOV
042500030625     C                   CAT       LUCYY:1       MONTHCOV
042600030314     C                   EVAL      GRP_E = 1
042700030314     C     *BLANKS       LOOKUP    LGRP(GRP_E)                            26
042800030314     C                   EVAL      GRP_E = GRP_E - 1
042900150304
0430001503040144 C                   z-add     loutbal       outbal
043100150304     C     *ISO          MOVE      lleteffymd    USA_DATE
043200150304     C                   MOVE      USA_DATE      carcanmdy
043300030808
0434009812010675 C                   ENDSR
0435000303100672  *?***************************************************************
043600970806**
043700970227JANUARY
043800970227FEBRUARY
043900970227MARCH
044000970227APRIL
044100970227MAY
044200970227JUNE
044300970227JULY
044400970227AUGUST
044500970227SEPTEMBER
044600970227OCTOBER
044700970227NOVEMBER
044800970227DECEMBER
