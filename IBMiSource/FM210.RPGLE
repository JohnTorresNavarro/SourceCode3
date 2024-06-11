0001009408170002 F******************************************************************
0002000711270003 F* FM210      GROUP BENEFIT SERVICES SOFTWARE           1994      *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009409210006 F*            DATE - 09/21/94                                     *
0006009408170007 F*                                                                *
0007009409210008 F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE OF THE      *
0008009409210009 F*            CR130 HISTORY FILE.                                 *
0009009408170010 F*                                                                *
0010009811190010 F*  11/19/98 DLW DATE LENGTH CHANGES ON SCREEN -Y2K COMPLIANT.    *
0011000008030010 F* 08/03/00 DLK - change for plan override                        *
0012000101250010 F* 01/25/00 JVA - New version of CR130HST                         *
0013000103090010 F* 03/08/01 KSJ - Added code to make sure Life Volume has same    *
0014000103090011 F*                sign as Billed Amount                           *
0015000202190010 F* 02/18/02 DLK - change bonus draw calc (admin fee x draw %)     *
0016000202190010 F*                also remove recalc of com exp and admin fee exp *
0017000303210010 F* 03/21/03 DLK - allow change to paid amount (finance request)   *
0019000304010012 F* 04/01/03 SSK - SALESMAN RELATINSHIP PROJECT                    *
0019010711270010 F* 11/27/07 DLK - merge fm190 & fm210. This version will now      *
0019020711270010 F*                maintain all original and late pay records.     *
0019030901120010 F* 01/12/09 DLK - remove bonus draw recalc since we now have 3    *
0019040901120010 F*                methods of calc but no way to know which one is *
0019050901120010 F*                used.                                           *
0019061612120010 F* 12/12/16 DLK - remove BC and PHN                               *
0019072003200010 F* 03/20/20 DLK - add ability to add a new record per request     *
0019082003200010 F*                from Carol S.                                   *
0020000304010011 F******************************************************************
0021000711270013 FFM210FM   CF   E             WORKSTN
0022002003200015 FCR130HSL  UF a E           K DISK
0022012003200015 FCR130HSL2 IF   E           K DISK    prefix(X_) rename(crhstr:crhstxx)
002300030401     FSMANRLT   IF   E           K DISK
002400030401     FSPRAGXR2  IF   E           K DISK
0024012003230015 Ffm210hst  o  a E             DISK
002500030401   X***X
002501200320     D  copyrec        s              1
0025032003230037 D systime         S               t
0025042003230002 D sysdatymd       S               d   datfmt(*iso)
002600981119     D                 DS
002700981119     D  EFRDT                  1      8  0
002800981119     D  EFRCY                  1      4  0
002900981119     D  EFRMM                  5      6  0
003000981119     D  EFRDD                  7      8  0
003100981119     D                 DS
003200981119     D  EFIDT                  1      8  0
003300981119     D  EFICY                  1      4  0
003400981119     D  EFIMM                  5      6  0
003500981119     D  EFIDD                  7      8  0
003600981119     D                 DS
003700030401     D  SCEFRD                 1      8s 0
003800981119     D  SEFRM                  1      2
003900981119     D  SEFRD                  3      4
004000981119     D  SEFRY                  5      8
004100981119     D                 DS
004200030401     D  SCEFID                 1      8s 0
004300981119     D  SEFIM                  1      2
004400981119     D  SEFID                  3      4
004500981119     D  SEFIY                  5      8
004600950126     D COMPAN          DS
004700940921     D*  DATA AREA - COMPANY NAME
004800940921     D  COMP                   1     55
004900980211     D                UDS
005000980211     D  BORP                   1      1
005001200323     D  luser                258    267
005100030401   X***X
005200940817     C     #T0005        TAG
005300940817     C*
005400940817     C                   EXFMT     SCRN01
005500950127     C                   SETOFF                                       88
0056009408170076 C*
0057009408170077 C*  ON CMD 7 END
0058009408170078 C*
0059009409210079 C     *IN07         IFEQ      '1'
0060009409210080 C                   SETON                                        LR
0061009409210080 C                   GOTO      #END
006200940921     C                   END
0062012003200076  *
0062022003200077  * F6 - Copy to new record
0062032003200080 C                   eval      copyrec = *blanks
0062042003200079 C                   if        *in06 = *on
0062062003200080 C                   eval      copyrec = 'Y'
006208200320     C                   end
0063009501260076 C*
006400981119     C                   MOVE      SEFRM         EFRMM
006500981119     C                   MOVE      SEFRD         EFRDD
006600981119     C                   MOVE      SEFRY         EFRCY
006700981119     C                   MOVE      SEFIM         EFIMM
006800981119     C                   MOVE      SEFID         EFIDD
006900981119     C                   MOVE      SEFIY         EFICY
007000981119     C*
007100970303     C     HSTKEY        CHAIN     CRHSTR                             88
007200940817     C   88              GOTO      #T0005
007300950126     C*
007400010308     C                   SETOFF                                       202150
007402200320     c                   eval      *in98 = *off
007500950126     C     #T0010        TAG
007600950126     C*
007700960703     C                   MOVE      CCOMP         CCOMPH
007800960703     C                   MOVE      CADMP         CADMPH
007900960703     C                   MOVE      CBONP         CBONPH
008000020219     C                   MOVE      CCOMe         CCOMeH
008100020219     C                   MOVE      CADMe         CADMeH
008101090112     C                   MOVE      Cbond         Cbondh
008200030401     C*
008300030401     C     CRELID        CHAIN     SRF
008400030401     C     SRASID        CHAIN     SXF
008500030401     C                   EVAL      S_SUPER = SXSUPER
008600200320      *
008601200320      * copy to new rec or change existing rec
008603200320     c                   if        copyrec = 'Y'
008700200320     C                   EXFMT     SCRN03
008701200320     c                   clear                   s03err
008702200320     c                   eval      *in98 = *off
008703200323     c                   movel     sefry         sefrym            6 0
008704200323     c                   move      sefrm         sefrym
008705200320     c                   else
008706200320     C                   EXFMT     SCRN02
008707200320     c                   end
0088009408170150 C*
0089009409210150 C* CMD1 RETURN
0090009409210150 C*
009100940921     C     *IN01         IFEQ      '1'
009200970303     C                   UNLOCK    CR130HSL
0093009409210152 C                   GOTO      #T0005
009400940921     C                   END
0095000103080150 C*
0096000103080150 C* MAKE SURE LIFE VOLUME IS SAME SIGN AS ADJUSTMENT AMT.
0097000103080150 C*
009800010308     C                   IF        CLIFEV <> 0
009900010308     C                   IF        (CBAMT < 0 AND CLIFEV < 0) OR
010000010308     C                             (CBAMT >= 0 AND CLIFEV > 0)
010100010308     C                   SETOFF                                       50
010200010308     C                   ELSE
010300010308     C                   SETON                                        50
0104000103080152 C                   GOTO      #T0010
010500010308     C                   ENDIF
010600010308     C                   ENDIF
0107009501260150 C*
0108000901120150 C* IF ANY expense field change then recalc total
0109009501260150 C*
011000960703     C                   SETOFF                                       20
011400090112     c                   if        (ccome <> ccomeh) or
011401090112     c                             (cadme <> cadmeh) or
011402090112     c                             (cbond <> cbondh)
011500020219     C                   SETON                                        20
011600020219     C                   END
013100020219     C*
013200960703     C*
013300960703     C     *IN20         IFEQ      *ON
0134009607030160 C                   MOVE      *ZEROS        CTOTC
0135009607030160 C     CCOME         ADD       CADME         CTOTC
0136009607030160 C                   ADD       CBOND         CTOTC
0137009607030168 C                   GOTO      #T0010
013800960703     C                   END
0138012003200150 C*
0138022003200150 C* validate remit effdt and seq# when copy to new rec
0138032003200150 C*
013804200320        if copyrec = 'Y';
013806200320         if sefrm < '01' or sefrm > '12' or sefrd <> '01' or
013807200323            sefry < '2020' or sefry > '2050' or
013808200323            (sefrym > udate8ym);
013809200323         eval s03err = 'INVALID REMITTANCE DATE                           ';
013810200320         eval *in98 = *on;
0138112003200168 C                   GOTO      #T0010
013812200320         endif;
013813200320
013814200320         if scseq < 1 or scseq > 99;
013815200320         eval s03err = 'INVALID REMITTANCE SEQUENCE                       ';
013816200320         eval *in98 = *on;
0138172003200168 C                   GOTO      #T0010
013818200320         endif;
013819200320
013820200320      * reformat screen remit date back to ymd for file update
013821200320     C                   MOVE      scefrd        @DATIN
013822200320     C                   EXSR      #DATMY
013823200320     C                   MOVE      @DATOU        scefrdymd         8 0
013824200320
013825200320      * check for duplicate record
013826200320     c                   move      cseq          scseq
013827200320     c                   move      scefrdymd     efrdt
013828200320     C     HSTKEY        CHAIN     cr130hsl2
013829200320     C                   if        %found(cr130hsl2)
013830200320         eval s03err = 'MUST CHANGE REMIT DATE OR SEQ # TO ADD NEW REC    ';
013831200320         eval *in98 = *on;
0138322003200168 C                   GOTO      #T0010
013833200320     c                   end
013834200320
013835200320     C                   MOVE      scefrdymd     ceffdt
013836200320        endif;
013837200320
013900940817     C*
014000200320     C* UPDATE or add CR130HIST
014100940817     C*
014101200320     c                   if        copyrec = 'Y'
014300200320     C                   MOVE      'A'           CSTAT
014600200320     C                   write     CRHSTR
014601200323      * write fm210hst rec to show record was added
014602200323     C                   MOVEl     luser         fm2user
014603200323       sysdatymd = %date();
014604200323     C                   MOVE      sysdatymd     fm2date
014605200323     c                   eval      systime = %time
014606200323     C                   MOVE      systime       fm2time
014607200323     C                   write     fm210hr
014610200320
014611200320     c                   else
014612200320     C* change stat if it was not prevously an add
014613200320     c                   if        cstat <> 'A'
014614200320     C                   MOVE      'C'           CSTAT
014615200320     c                   end
014616200320     C                   UPDATE    CRHSTR
014617200320     c                   end
0147009408170167 C*
0148009408170168 C                   GOTO      #T0005
014900940817     C     #END          TAG
0149152003200107 C*
014916200320     C*
0149172003200103 C***************************************************
0149182003200104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
0149192003200105 C***************************************************
0149202003200107 C*
0149212003200107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
0149222003200107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
0149232003200107 C*
0149242003200106 C     #DATMY        BEGSR
014925200320     C                   MOVEL     @DATIN        @MD               4 0
014926200320     C                   MOVE      @DATIN        @Y                4 0
014927200320     C                   MOVE      @MD           @DATOU            8 0
014928200320     C                   MOVEL     @Y            @DATOU
014929200320     C                   MOVE      *ZEROS        @DATIN            8 0
0149302003200120 C                   ENDSR
015000950126     C*
015100000803     c     *inzsr        begsr
015200000803     C*
015300000803     C*
015400000803     C* GET DATA AREA AND IMMEDIATELY RELEASE
015500000803     C*
015600000803     C     *DTAARA       DEFINE                  COMPAN
015700000803     C                   IN        COMPAN
015800000803     C                   MOVEL     COMP          COMPNY
015900030401    ***
016000030401     C     *LIKE         DEFINE    CCOMP         CCOMPH
016100030401     C     *LIKE         DEFINE    CADMP         CADMPH
016200030401     C     *LIKE         DEFINE    CBONP         CBONPH
016300030401     C     *LIKE         DEFINE    CCOMe         CCOMeH
016400030401     C     *LIKE         DEFINE    CADMe         CADMeH
016401090112     C     *LIKE         DEFINE    Cbond         CbondH
016500030401    ***
016600030401     c                   eval      scefrd = 0
016700030401     c                   eval      scefid = 0
016800030401    ***
016900000803     C     HSTKEY        KLIST
017000000803     C                   KFLD                    EFRDT
017100000803     C                   KFLD                    CCARCD
017200000803     C                   KFLD                    CTRUST
017300000803     C                   KFLD                    CSUB
017400000803     C                   KFLD                    CACCT
017500000803     C                   KFLD                    CGROUP
017600000803     C                   KFLD                    Cplan
017700010125     C                   KFLD                    EFICY
017800010125     C                   KFLD                    EFIMM
017900010125     C                   KFLD                    EFIDD
018000071127     C                   KFLD                    Scseq
018100000803
018200030401     c                   select
018700161212     C                   when      borp = 'D'
018800161212     C                   eval      *in61 = *on
018801161212     C                   when      borp = 'O'
018802161212     C                   eval      *in62 = *on
018900030401     C                   endsl
019000000803
019001200323      * put system date in sysdatymd field
019003200323       sysdatymd = %date();
019005200323     C                   MOVE      sysdatymd     UDATE8            8 0
019006200323     C                   MOVEl     udate8        UDATE8ym          6 0
019009200320
019300000803     c                   endsr
