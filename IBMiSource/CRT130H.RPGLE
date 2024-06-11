000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Create CR130HST from BCREC file -
000400000000      *
000500010203      *    This program will summarize the BCREC records and
000600010203      *    write them out to CR130HST.
000700010203      *
000800000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000900000000      *
001000000000      *    Created by:  JALLEN - January 16, 2001
001100020201     F* 02/01/02 DLK - add market size and agency code to cr130hst
0012000303270014 F*  SSK   3/25/03   CHANGE CARMST TO EXTERNAL DEFINE AND MAKE     *
0013000303270017 F*                  ADJUSMENTS FOR RELATIONSHIP ID                *
001301050816     F* 08/16/05 DLK - add % of prem - global
001302060302     F* 03/02/06 DLK - add life volume to cr130hst
001303060621     F* 06/21/06 DLK - change size of bccchg, bcfchg, bcdchg
001304071128     F* 11/28/07 DLK - change late pay field to seq #
001305071129     F*              - add type parm to know when to update abrhist
001306090104     F* 01/04/09 DLK - add logic to handel bonus draw flat fee
001307161215     F* 12/15/16 DLK - process new fields in CR130HST needed from new GPR
0014001612150017 F*                (AF method, BD method, lives fields).
001401170202     F* 02/02/17 DLK - Round final result of total comm amt before writing
001402170202     F*                to CR130HST (this now matches how RPA060N works
001403170202     F*                when it writes to to the commission history).
001405170202     F*
001500030327 016 F******************************************************************
001600010116     FBCREC     ip   e           k Disk
001700010129     FCARMST    if   e           k Disk
001800030327     FSMANRLT   IF   E           K DISK
001900030327     FSPRAGXR2  IF   E           K DISK
001901071129     Fabrhist   uF   E           K DISK
002000010116     FCR130HST  o    e           k Disk
0020010711300030 Fqsysprt   O    F  132        PRINTER OFLIND(*INOg)
0020020606210133 Dwkcom            s                   like(bccchg)
0020030606210133 Dwkfee            s                   like(bcfchg)
0020040606210133 Dwkbd             s                   like(bcdchg)
002100010202
0021010711290055 D                 DS
0021050711290601 D  udymd                  1      8  0
0021060711290601 D  udateyyyy              1      4  0
0021070711290601 D  udatemm                5      6  0
0021080711290601 D  udatedd                7      8  0
0021090711290055 D                uDS
0021100711290601 D  CONAME               201    240
0021110711290601 D  luser               1000   1009
002200010116     IBCRECR        01
002300010117     I                                          BCGN          L3
002400010117     I                                          BCTRST        L1
002500010116     I                                          BCSUB         L1
002600010116     I                                          BCACCT        L1
002700010117     I                                          BCCAR         L4
002800010117     I                                          BCGRPC        L5
002900010117     I                                          BCPLAN        L3
003000010117     I                                          BCEFYY        L2
003100010117     I                                          BCEFMM        L2
003200010129     ICARMSR        02
003300010129     I              CCOMP                       CCOMPX
003400010129     I              CBONP                       CBONPX
003500010117
003600010116     C   L1              Exsr      LoadRecord
003700010116     C   01              Exsr      Accumulate
003800010117
003900010116     CL1                 Exsr      CreateRecord
003901071129      * update ABRHIST file when "POST"
003902071129     cLR                 if        witype = 'P'
003903071129     cLR                 exsr      #upabrhist
003904071129     CLR                 end
003905071129
004000010116      *--------------------------------------------------------------------*
004100010116     C     LoadRecord    Begsr
004200010116      *--------------------------------------------------------------------*
004201060621     c                   clear                   wkcom
004202060621     c                   clear                   wkfee
004203060621     c                   clear                   wkbd
004204161215     c                   clear                   ccmeth
004205161215     c                   clear                   cameth
004206161215     c                   clear                   cbmeth
004300010116     C                   Move      bccar         ccarcd
004400010116     C                   Z-add     bctrst        ctrust
004500010116     C                   Z-add     bcsub         csub
004600010116     C                   Z-add     bcacct        cacct
004700010118     C                   Movel     bcgrpc        cgrpcd
004800010117     C                   Movel     bcanam        cacnam
004900010116     C                   Movel     bcgn          cgroup
005000010116     C                   Movel     bcplan        cplan
005100020201     C                   movel     bcmksz        cmksz
005200010125
005300010130     C     WwDate        mult      10000.0001    ceffdt
005400010130     C     WwDate        mult      10000.0001    cbcrec
005500010125     C                   Z-add     bcefyy        cefiyy
005600010125     C                   Z-add     bcefmm        cefimm
005700010125     C                   Z-add     bcefdd        cefidd
005800010125
008000071128      * Run seq
008400071130     C                   Move      numericseq    cseq
008600010116      *
008700010116     C                   Endsr
008701161215
008800010116      *--------------------------------------------------------------------*
008900010116     C     Accumulate    Begsr
009000010116      *--------------------------------------------------------------------*
009100060621     C                   Add       bccchg        wkcom
009200060621     C                   Add       bcfchg        wkfee
009300060621     C                   Add       bcdchg        wkbd
009400010117     C                   Add       bcbila        cbamt
009500010117     C                   Add       bcadja        caamt
009600010117     C                   Add       bcpada        cpamt
009601161215      * member counts
009700161215     C                   Add       bcBmcnt       clivesB
009701161215     C                   Add       bcAmcnt       clivesA
009702161215     C                   Add       bcmcnt        clives
009703161215      * dependent counts
009704161215     C                   Add       bcBdcnt       cdlivesB
009705161215     C                   Add       bcAdcnt       cdlivesA
009706161215     C                   Add       bcdcnt        cdlives
009707161215
009708060302     C                   Add       bclifev       clifev
009709161215
009710161215     c                   exsr      #setratmeth
009711161215
009800010116     C                   Endsr
009801161215
009802161215      *--------------------------------------------------------------------*
009803161215      * set rate and method - hold first non blank value since some bcrec
009804161215      * records do not have a value
009806161215      *--------------------------------------------------------------------*
009807161215     C     #setratmeth   Begsr
009808161215
009809161215      * Set Commission rate and method
009810161215      * O = % of prem global
009811161215      * P = % of prem override
009812161215      * G = Flat fee global
009813161215      * F = Flat fee override
009814161215      * C = % of comm override
009815161215      *   = pay no comm (P) override
009816161215
009817161215      * hold first non zero commission (all records have the method filled
009818161215      * in but only the ones with commission base are valid)
009819161216     c                   if        ccomp = *zeros
009820161215      * percentage
009821161215     C                   if        bccmth = 'P' or bccmth = 'O' or
009822161215     C                             (bccmth = 'C' and bccpct <> 0)
009823161215     C     bccpct        div       100           ccomp
009824161215     C                   MoveL     '%'           ccmeth
009825161215     C                   else
009826161215      * flat fees
009827161215     C     bccchg        div       100           ccomp
009828161215     C                   MoveL     '$'           ccmeth
009829161215     C                   end
009830161215     C                   end
009831161215
009832161215      *
009833161215      * bonus draw (flat fee or %) in CR130HST.
009834161215      * hold first non blank value
009835161216     c                   if        cbonp = *zeros
009836161215      * percentage
009837161215     c                   if        bcdpct <> 0
009838161215     C     bcdpct        div       100           cbonp
009839161215     c                   else
009840161215      * flat fee
009841161215     C     bcdchg        div       100           cbonp
009842161215     c                   end
009844161215     c                   move      bcdmth        cbmeth
009845161215     c                   end
009846161216
009847161216      * double check to make sure bonus method is filled
009848161216     c                   if        bcdmth <> *blank and cbmeth = *blanks
009849161216     c                   move      bcdmth        cbmeth
009850161216     c                   end
009851161215      *
009852161215      * convert admin fee (flat fee or %) to the format used in CR130HST.
009853161215      * hold first non blank value
009854161216     c                   if        cadmp = *zeros
009855161215      * percentage
009856161215     c                   if        bcfpct <> 0
009857161215     C     bcfpct        div       100           cadmp
009858161215     c                   else
009859161215      * flat fee
009860161215     C     bcfchg        div       100           cadmp
009861161215     c                   end
009862161215
009863161215     c                   move      bcfmth        cameth
009864161215     c                   end
009865161216
009866161216      * double check to make sure admin fee method is filled
009867161216     c                   if        bcfmth <> *blank and cameth = *blank
009868161216     c                   move      bcfmth        cameth
009869161216     c                   end
009870161215
009871161215     c                   endsr
009872161215
009900010116      *--------------------------------------------------------------------*
010000010116     C     CreateRecord  Begsr
010100010116      *--------------------------------------------------------------------*
010200030611
010300030611    * * get sman / agency from relation
010400030611
010500030327     C     BCRELID       CHAIN     SRF
010600030327     C                   EVAL      CBCODE = SRSMAN
010700030327     C                   EVAL      CRELID = BCRELID
010800030327     C     SRASID        CHAIN     SXF
010900030327     C                   EVAL      CAGCOD = SXAGCY
011000030327    ***
011100010129     C     BCCAR         Chain     CARMST
011103170202
011200170202     C                   If        %Found(carmst) and comsch = '2'
011202170202      * 2/2/17 - round commission total so it matches the way RPA060N
011203170202      *          does it before writing it to rpa060wk (comm hist)
011204170202     c                   clear                   ccome
011205170202     c     wkcom         mult(H)   1             ccome
011206170202
011303060621     c                   z-add     wkfee         cadme
011304060621     c                   z-add     wkbd          cbond
011401060622     C                   Eval      ctotc = ccome + cadme + cbond
011500010116     C                   Write     CRHSTR
011602071129     C                   End
011603071129
011700010129     C                   Clear                   CRHSTR
011800010116     C                   Endsr
011801071129
011802071129      * Update ABRHIST file
011803071129
011804071129     C     #upabrhist    Begsr
011805071129
011806071129     C     abrkey        CHAIN     abrhist
011807071129     c                   if        %found(abrhist)
011808071129     c                   move      udymd         abposdate
011809071129     c                   time                    abpostime
011810071129     c                   movel     luser         abposuser
011811071129     c                   update    abrr
011812071129      * error
011813071129     c                   else
011815071130     c                   except    head
011816071130     c                   except    error
011817071129     c                   end
011818071129     C                   Endsr
011819071129
011900010116      *--------------------------------------------------------------------*
012000010126     C     *inzsr        Begsr
012100010116      *--------------------------------------------------------------------*
012200010117     C     *Entry        Plist
012201071129      * widate is passed as MDY but converted to YMD and passed back
012202071129
012300071129     C                   Parm                    Wiabrcode         1
012301071129     C                   Parm                    WiDate            8
012400071128     C                   Parm                    wiseq             2
012401071129     C                   Parm                    witype            1
012402071129
012500010130     C                   If        WiDate   =    *zeros or
012600010130     C                             WiDate   =    *blanks
012700010204     C                   z-add     99999999      WwDate            8 0
012800010130     C                   Else
012801071129      * hold MDY date passed in wwdate
012900010130     C                   Move      WiDate        WwDate
013000010130     C                   End
013001071129      * convert mdy date to ymd
013100010204     C     WwDate        mult      10000.0001    xxdate            8 0
013101071129      * move ymd date back to orig passed field
013200010204     C                   Move      xxdate        WiDate
013201071129
013202071129      * move Alpha parm to numeric field
013203071129     C                   Move      wiseq         numericseq        2 0
013204071129     C                   Move      widate        numericdat        8 0
013205071129      * get current date as YMD
013206071129     c                   move      *year         udateyyyy
013207071129     c                   move      *month        udatemm
013208071129     c                   move      *day          udatedd
013209071130     C                   TIME                    HTIME             6 0
013210071129
013214071129     C     abrkey        KLIST
013215071129     C                   KFLD                    numericdat
013216071129     C                   KFLD                    wiabrcode
013217071129     C                   KFLD                    numericseq
013300010116     C                   Endsr
0134000711300237 Oqsysprt   E            head           2 03
0135000711300239 O                       coname              86
0137000711300242 O          E            head           1
0138000711300244 O                                           66 'ABRHIST ERROR - NOTIFY '
0138010711300244 O                                           88 'PROGRAMMER IMMEDIATELY'
0142000711300242 O          E            head           1
0143000711300248 O                                           24 'PROGRAM NAME: CRT130H'
0146000711300242 O          E            head           1
0147000711300253 O                                           14 'RUN DATE:'
0148000711300254 O                       UDATE         Y     25
0149000711300255 O                                          122 'TIME :'
0150000711300256 O                       HTIME              131 '  :  :  '
0151000711300242 O          E            head           1
0152000711300259 O                                           24 '------------------------'
0153000711300260 O                                           48 '------------------------'
0154000711300261 O                                           72 '------------------------'
0155000711300262 O                                           96 '------------------------'
0156000711300263 O                                          120 '------------------------'
0157000711300286 O                                          132 '------------'
0158000711300242 O          E            head           1
0159000711300267 O                                            5 'EFFDT'
0160000711300268 O                                           17 'CODE'
0160010711300268 O                                           23 'SEQ'
0161000711300242 O          E            head           2
0162000711300259 O                                           24 '------------------------'
0163000711300260 O                                           48 '------------------------'
0164000711300261 O                                           72 '------------------------'
0165000711300262 O                                           96 '------------------------'
0166000711300263 O                                          120 '------------------------'
0167000711300286 O                                          132 '------------'
0168000711300287 O          E            ERROR          1
0169000711300288 O                       numericdat           8
0170000711300288 O                       wiabrcode           17
0171000711300288 O                       numericseq          23
0172000711300288 O                                           +3 '* ABRHIST NOT FOUND *'
