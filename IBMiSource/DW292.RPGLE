0001000101310015 F******************************************************************
000200020322     F*                                                                *
000300030804     F* This program will read the FBR work file and create the FBR    *
000400030804     F* file for Delegated Billing.                                    *
000500030804     F*                                                                *
0006000308040014 F* 10/17/02 DLK - new pgm : Read dbpaywk and create summary       *
0007000210190015 F*                FBR file.                                       *
0008000210190015 F*                First run will process all positive amounts     *
0009000210190015 F*                (parm1 = P).                                    *
0010000308040015 F*                Second run will process all negative amounts    *
0011000210190015 F*                (parm1 = N)                                     *
0012000308040014 F* 08/04/03 DLK - Rename of program from dw261 to dw292 to        *
0013000308040015 F*                match it's new function in dw290cl              *
0013011509040014 F* 09/04/15 DLK - add check for no positive records processed     *
0014001509040015 F*                (group # will be blank)                         *
0014011509040015 F*                                                                *
0015000101310015 F******************************************************************
0016000210170017 Fdbfbrwk   iP   E           k DISK
0017000210170030 Fdbfbrh    O  a e             DISK
0018000210170030 Fdbfbrd    O  a e             DISK
0019000210170030 Fdbfbrt    O  a e             DISK
0020000210170030 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
0021000210190056 Dreptype          s             16                                         payment %
0022000203220055 D                UDS
0023000308040056 D  LEFFDT                 1      8  0
0024000308040056 D  lwiredtymd             9     16  0
0025000210170053 Idbfbrwkr
002600021017     I                                          dbwkgrp       L1
002700021017     I                                          dbwksg        L1
002800021019     C                   ADD       dbwkpaid      paid             11 2
002900020322
003000020322     cl1                 exsr      #l1sr
003100020322     clr                 exsr      #lrsr
003200020322
0033000210190103 C***************************************************
003400020322     c* total for group/subgroup
0035000210190103 C***************************************************
003600020322     c     #l1sr         begsr
003700021019
003800021019      * process "P" for all positive amounts
003900021019      * process "N" for all negative amounts
004000021019
004100021019     c                   if        (porn = 'P' and paid < 0) or
004200150904     c                             (porn = 'N' and paid >= 0) or
004201150904     c                             (dbwkgrp = *blanks and dbwksg  = *blanks)
004300021019     c                   clear                   paid
004400021019     c                   leavesr
004500021019     c                   end
004600021019
004700980205     C                   ADD       1             RECNUM            8 0
004800021019     C                   ADD       paid          totpay           13 2
004900020322
005000021017     C                   clear                   dbfbrdr
005100021017     c                   move      '7'           fdrtype
005200021017     c                   movel     dbwkgrp       fdgrp
005300021017     c                   movel     dbwksg        fdsg
005400021017     c                   move      *zeros        fdbid
005500021017     c                   eval      fddpdt = %editc(lwiredt : 'Y')
005600021017     c                   eval      fdamt = %editc(paid : 'P')
005700021017     C                   write     dbfbrdr
005800021017
005900020327     c   of              except    head
006000020322     C                   EXCEPT    DETAIL
006100020322     C                   clear                   PAID
006200021019
006300020322     c                   endsr
006400020322
006500020322     c* final total
006600020322     c     #lrsr         begsr
006700020322
006800021017     c                   add       2             recnum
006900021017
007000021019     C                   clear                   dbfbrtr
007100021017     c                   move      '9'           ftrtype
007200021017     c                   eval      ftdpdt = %editc(lwiredt : 'Y')
007300021017     c                   eval      fttotrec = %editc(recnum : 'P')
007400021017     c                   eval      fttotamt = %editc(totpay : 'P')
007500021017     C                   write     dbfbrtr
007600020322     C                   EXCEPT    total
007700020322     c                   endsr
0078000210190107
0079000210190103 C***************************************************
0080000210190104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
0081000210190105 C***************************************************
0082000210190107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
0083000210190107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
0084000210190106 C     #DATMY        BEGSR
008500021019     C                   MOVEL     @DATIN        @MD               4 0
008600021019     C                   MOVE      @DATIN        @Y                4 0
008700021019     C                   MOVE      @MD           @DATOU            8 0
008800021019     C                   MOVEL     @Y            @DATOU
008900021019     C                   MOVE      *ZEROS        @DATIN            8 0
0090000210190120 C                   ENDSR
009100021019
009200021019
009300020322     c     *inzsr        begsr
009400021019     c     *entry        plist
009500021019     c                   parm                    porn              1
009600021019
009700021019     C                   TIME                    HTIME             6 0
009800021019     C                   MOVE      *DATE         @DATIN
009900021019     C                   EXSR      #DATMY
010000021019     C                   MOVE      @DATOU        UD8YMD            8 0
0101000210190111
010200030804     C                   MOVE      lwiredtymd    @DATIN
010300030804     C                   EXSR      #DATMY
010400030804     C                   MOVE      @DATOU        lwiredt           8 0
010500030805
010600030805     C                   MOVE      leffdt        @DATIN
010700030805     C                   EXSR      #DATMY
010800030805     C                   MOVE      @DATOU        leffdtmdy         8 0
0109000308040111
011000021019     c* create batch id - YYMMDDHHMM
011100021019     C                   movel     htime         HTIMEhm           4 0
011200021019     c                   move      ud8ymd        ud6ymd            6 0
011300021019     c                   movel     ud6ymd        batchid          10
011400021019     c                   move      htimehm       batchid
011500021019
011600021019     c                   if        porn = 'P'
011700021019     c                   eval      reptype = '+++ POSITIVE +++'
011800021019     c                   else
011900021019     c                   eval      reptype = '--- NEGATIVE ---'
012000021019     c                   end
012100021019
012200021019     C                   EXCEPT    HEAD
012300021017
012400021017     C                   clear                   dbfbrhr
012500021019     c                   eval      fhrtype = '1'
012600021019     c                   eval      fhdbid  = '521200892'
012700021019     c                   eval      fhcont  = 'SHELLY RAPSKI'
012800021019     c                   eval      fhcomp  = 'GBS, INC.'
012900021019     c                   eval      fhphone = '410-832-5166'
013000021019     c                   eval      fhemail = 'srapski@gbsio.net'
013100021019     c                   eval      fhdpdt  = %editc(lwiredt : 'Y')
013200021019     c                   eval      fhbatch = batchid
013300021017     C                   write     dbfbrhr
013400020322     c                   endsr
013500010203
0136009606050237 OREPORT    E            HEAD           2 03
0137009606050239 O                                           73 '** GROUP BENEFIT SERVICE'
0138009606050241 O                                           77 'S **'
0139009606050242 O          E            HEAD           1
0140000210190244 O                                           80 'DBFBR TOTALS BY GROUP/SG'
0141009606050242 O          E            HEAD           1
014200960605 244 O                                           65 'FOR :'
014300030805 244 O                       LEFFDTmdy           76 '  /  /    '
0144009606050242 O          E            HEAD           1
0145000308050248 O                                           24 'PROGRAM NAME: DW292'
014600021019 244 O                                           65 'BATCH ID :'
014700021019 244 O                       batchid             76
014800021019 244 O                       reptype             94
0149009606050249 O                                          122 'PAGE :'
0150009606050250 O                       PAGE          Z    131
0151009606050242 O          E            HEAD           1
0152009606050253 O                                           14 'RUN DATE:'
0153009606050254 O                       UDATE         Y     25
0154009606050255 O                                          122 'TIME :'
0155009606050256 O                       HTIME              131 '  :  :  '
0156009606050242 O          E            HEAD           1
0157009606050259 O                                           24 '------------------------'
0158009606050260 O                                           48 '------------------------'
0159009606050261 O                                           72 '------------------------'
0160009606050262 O                                           96 '------------------------'
0161009606050263 O                                          120 '------------------------'
0162009606050286 O                                          132 '------------'
0163009606050242 O          E            HEAD           1
0164000203220267 O                                            8 'GROUP'
0165000203220268 O                                           20 'SUBGROUP'
0166000203260268 O                                           46 'PAID'
0167009606050242 O          E            HEAD           2
0168009606050259 O                                           24 '------------------------'
0169009606050260 O                                           48 '------------------------'
0170009606050261 O                                           72 '------------------------'
0171009606050262 O                                           96 '------------------------'
0172009606050263 O                                          120 '------------------------'
0173009606050286 O                                          132 '------------'
0174009606050287 O          E            DETAIL         1
0175000210170288 O                       dbwkgrp              8
0176000210170288 O                       dbwksg              20
0177000203260288 O                       paid          j     46
0178000203220287 O          e            total       1  1
0179000203220288 O                                            7 'TOTAL :'
0180000203260288 O                       TOTpay        j     46
