0001009211230002 F******************************************************************
0002009909300003 F* RP500      GROUP BENEFIT SERVICES SOFTWARE           1995      *
0003009211230007 F*                                                                *
0004009211230005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009504110006 F*            DATE - 04/11/95                                     *
0006009211230007 F*                                                                *
0007009504110006 F*  DESCRIPTION - THIS PROGRAM WILL LIST ACTIVE ACCOUNTS          *
0008009504110007 F*                THAT GOT MISSED FOR INVOICING.                  *
0009009812140008 F* DLW 12.98 CHANGED DATE LENGTH IN LDA TO 6 POSITIONS INCLUDING  *
0010009812140008 F*           THE CENTURY -Y2L COMPLIANT.                          *
0011000001130007 F* 01/13/00 dlk - add check to invoice exclusion file             *
0012000001190007 F* 01/18/00 dlk - add check to trsmst file and give choice on     *
0013000001190007 F*                RP501 screen to print excluded accounts or not  *
001400020318     F*   3/18/02 szz - Retrieve selected trusts from TRSSEL instead   *
001500020318     F*                 of LDA array.                                  *
001600020524     F*  5/24/02 szz - Recompiled over new AACODE file                 *
0017001006170007 F* 06/17/10 dlk - add begin admin date                            *
001800140310      * 03/10/14 dlk - fix heading trust selection, TR23 was missing
001801140813      * 08/13/14 dlk - convert to XLS
001802140822      * 08/22/14 dlk - add check for voided invoice - Cindy W request
001803180205      * 02/05/18 dlk - add advanced Mobile column to XLS
001804200109      * 01/09/20 dlk - add Care Services Management column to XLS
0019000001130007 F*                                                                *
0020009211230009 F******************************************************************
0021009211230010 F*                                                                *
002200950412     FACCMST    IP   E             DISK
002300950913     FAACODE    IF   E           K DISK
002400020318     FTRSSLC    IF   E           k DISK    Prefix(Q) Rename(TRSMSR:Q_FMT)
002500000113     Finvexc    IF   E           K DISK
002600000118     Ftrsmst    IF   E           K DISK
002601140822     Fhistaa    IF   E           K DISK
0027011408130017 Frp500xl   o  a e             DISK
0028000001180054 Dskiptrust        s              1
0028011408220054 Dk_avi            s              3    inz('AVI')
0028021408220054 Dk_hkey           s                   like(hkey)
0028031408130125 Dcsv              c                   const('","')
0029001408130053 D                 DS
0030001408220054 D covtdt                  1      8  0
0030011408220054 D covtdt_ym               1      6  0
0030021408220053 D                 DS
0030031408220054 D tsa                     1     10  0
0030041408220054 D actrst                  1      3  0
0030051408130054 D acsub#                  4      6  0
0030061408130054 D acacct                  7     10  0
0030071408130053 D                UDS
0030081408130054 D  LMY                    7     12  0
003009140813     D  LMM                    7      8  0
003100140813     D  LYYYY                  9     12  0
003300000119     D  lprtyn                13     13
0034009508150067 D  TAR                  100    171  0
003500950815     D                                     DIM(24)
0036009504110054 D  CONAME               201    240
0037009504280054 D  LTIME                242    247  0
0038009504120053 IACCMSR
003900950411     I                                          ACTRST        L1
004000950913     I              AACODE                      AACOD
0041009509130215 C*
004200000118     c                   if        *inl1
004300140813     c                   clear                   sdacct            1
004301180205     c                   clear                   amacct            1
004302200109     c                   clear                   csacct            1
004303140813     c                   eval      skiptrust = ' '
0044001408180234 C     actrst        CHAIN     trsmst
004500140818     c                   if        not %found(trsmst) or trdltd <> 'A'
004600000118     c                   eval      skiptrust = 'Y'
004700000118     c                   end
004701180205      * set senior dental and advanced mobile indicators
004702180205      * O N = Senior Dental
004703180205      * O M = Advanced Mobile
004704200109      * O D = Care Services Management
004705180205       select;
004706180205        when tscode = 'O N';
004707180205        sdacct = 'Y';
004708180205        when tscode = 'O M';
004709180205        amacct = 'Y';
004710200109        when tscode = 'O D';
004711200109        csacct = 'Y';
004712180205       endsl;
004800000118     c                   end
004900000118
005000000118
005100000118     c                   if        skiptrust = ' '
005200000118
005201140813      * skip accts with future begin admin date
005203140813     c                   movel     gbsbdt        gbsbdtym          6 0
005204140813     c                   if        gbsbdtym > lym
005205140813     c                   goto      #end
005206140813     c                   end
005207140813
0053000001180234 C     AKEY          CHAIN     AACODE                             89
005400000113     C                   MOVE      *BLANKS       AANAM            21
005500950913     C  N89AFNAM         CAT       ALNAM:1       AANAM
005600000113
0057000001130215 C*
0058000001130215 C* check invoice exclusion file
0059000001130215 C*
006000000113     C                   MOVE      *zeros        ieefmdy
0061000001130234 C     invkey        CHAIN     invexc                             88
006200000113     c                   if        *in88 = *off
006400140822      * if requested - do not print
006600000119     c                   if        lprtyn = 'N'
006700000119     c                   goto      #end
006800000119     c                   end
006900000119
007000000113     C                   MOVE      ieeff         CYMD#
007100000113     C                   EXSR      #CYMD8
007200000113     C                   MOVE      MDCY#         ieefmdy           8 0
007300000113     c                   end
007400000113
007402140822      * check for voided inv, find latest transaction date
007403140822     c                   clear                   voiddate          8 0
007404140822     c                   movel     tsa           k_hkey
007405140822     c     histaakey     setll     histaa
007406140822     c                   dou       %eof(histaa)
007407140822     c     histaakey     reade     histaa
007408140822     c                   if        not %eof(histaa) and covtdt_ym = lym
007409140822     c                             and trdate > voiddate
007410140822     c                   move      trdate        voiddate
007411140822     c                   end
007412140822     c                   enddo
007413140822
007414140822     C                   MOVE      voiddate      CYMD#
007415140822     C                   EXSR      #CYMD8
007416140822     C                   MOVE      MDCY#         voidmdy           8 0
007417140822
007700981214     C                   MOVE      ACVTDT        CYMD#             8
007800981214     C                   EXSR      #CYMD8
007900981214     C                   MOVE      MDCY#         ACTDT             8 0
008000100617
008100100617     C                   MOVE      gbsbdt        CYMD#
008200100617     C                   EXSR      #CYMD8
008300100617     C                   MOVE      MDCY#         gbsbdtmdy         8 0
008301140822
008419140822      * write spreadsheet detail line
008501140813     C                   exsr      writexldet
008900950411     C*
009000000118     c                   end
009100000118     C*
009200000119     c     #end          tag
0222011408130313 C*
0222021408130164 C*************************************************************
0222031408130164 C*                                                           *
0222041408130164 C* Write Spreadsheet Detail                                  *
0222051408130164 C*                                                           *
0222061408130164 C*************************************************************
022207140813     C     Writexldet    BEGSR
022208140813
022209140813     c                   clear                   rp500fld
022210140813     C                   Eval      rp500fld  = '"' +
022211140813     C                             %trim(%editw(TSA:'0   -   -    '))  + csv +
022212140813     C                             sdacct                               + csv +
022213180205     C                             amacct                               + csv +
022214200109     C                             csacct                               + csv +
022215140813     C                             %trim(acnam1)                        + csv +
022216140813     C                             %trim(%editw(gbsbdtmdy:'  /  /    ')) + csv +
022217140813     C                             %trim(%editw(actdt:'  /  /    '))   + csv +
022218140813     C                             %trim(%editc(noempl:'3'))            + csv +
022219140813     C                             %trim(%editc(apremi:'J':*cursym))    + csv +
022220140813     C                             %Trim(aanam)                         + csv +
022221140822     C                             %trim(%editw(ieefmdy:'  /  /    '))  + csv +
022222140822     C                             %trim(%editw(voidmdy:'  /  /    '))  + csv +
022223140813     C                             ' '                                  + '" ,'
022224140813     C*
022225140813     C                   Write     rp500xr
0222261408130320 C                   ENDSR
022227140813     C*
022228140813     C/EJECT
022229140813     C*************************************************************
022230140813     C*                                                           *
022231140813     C* Write Spreadsheet heading                                 *
022232140813     C*                                                           *
022233140813     C*************************************************************
022234140813     C     Writexlhead   BEGSR
022235140813
022236140813     c                   clear                   rp500fld
022237140813     C                   Eval      rp500fld = '"' + 'ACCOUNT #'    + csv +
022238140813     C                                              'SEN DEN'       + csv +
022239180205     C                                              'ADV MOB'       + csv +
022240200109     C                                              'CARE SRV'      + csv +
022241140813     C                                              'ACCOUNT NAME'  + csv +
022242140813     C                                              'BEGIN ADMIN'   + csv +
022243200109     C                                              'INV THROUGH'   +csv +
022244140813     C                                              'ACTIVE MEM'    + csv +
022245140813     C                                              'LAST INV AMT'  + csv +
022246140813     C                                              'AA NAME'       + csv +
022247140813     C                                              'EXCLUDED'      + csv +
022248140822     C                                              'VOIDED DATE'   + csv +
022249140813     C                                              ' '              + '",'
022250140813     C                   Write     rp500xr
022251140813     C*
0222521408130320 C                   ENDSR
022253140813
0223000203250098 C*
022400020325    ?C     KLIST         Begsr                                                  KEY LISTS
022500000118     C     AKEY          KLIST
022600000118     C                   KFLD                    AACOD
022700000118     C                   KFLD                    ZERO2             2 0
022701140822
022702140822     C     histaakey     KLIST
022703140822     C                   KFLD                    k_hkey
022704140822     C                   KFLD                    k_avi
022705140822
022800000118     C     invkey        KLIST
022900000118     C                   KFLD                    actrst
023000000118     C                   KFLD                    acsub#
023100000118     C                   KFLD                    acacct
023200000118     C                   ENDSR
023300140813
023400981214     C     #CYMD8        BEGSR
023500981214     C                   MOVE      CYMD#         MMDD#             4
023600981214     C                   MOVEL     CYMD#         CCYY#             4
023700981214     C                   MOVEL     MMDD#         MDCY#             8
023800981214     C                   MOVE      CCYY#         MDCY#
023900981214     C                   ENDSR
0240001408130215 C*
024100140813     C     *inzsr        BEGSR
0242001408130210 C                   MOVE      *ZEROS        ZERO2
024201140813     c                   movel     lyyyy         lym               6 0
024202140813     c                   move      lmm           lym
024300140813
024400140813     C                   Exsr      Writexlhead
024500140813     C                   ENDSR
