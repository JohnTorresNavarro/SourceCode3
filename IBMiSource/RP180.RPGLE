000100910215     H DFTNAME(RP180)
000200001010      ******************************************************************
000300001010      * RP180      GROUP BENEFIT SERVICES SOFTWARE           1990      *
000400001010      *                                                                *
000500001010      *            WRITTEN BY - DAVID KETTERMAN                        *
000600001010      *            DATE - 01/31/91                                     *
000700001010      *                                                                *
000800001010      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE A CANCELLED ACCOUNTS  *
000900001010      *            REPORT.                                             *
001000001010      *                                                                *
001100001010      *                                                                *
001200001010      *  Y2K CONVERT - 1998                                            *
001300001010      *                                                                *
001400001019      *    KSJ 10/2000 - Modified to include selection                 *
001500001019      *                      by Renewal Month                          *
001600001019      *                  Converted from QS36SRC                        *
001700001010      *                                                                *
001800060314      * 03/14/06 dlk - add agency selection                            *
001900080819      * 08/19/08 dlk - add super agency selection                      *
002000090528      * 05/28/09 dlk - add xls output                                  *
002100100608      * 06/04/10 dlk - add senior dental xls and date range selection  *
002200140523      * 05/23/14 dlk - add term code description to spreadsheet        *
002300150709      * 07/09/15 dlk - add exchange field to xls and remove printed    *
002400150709      *                report (ok by Cindy W)                          *
002500160531      * 05/31/16 dlk - change to show last non-zero billed amount in   *
002600160531      *                last inv column (Cindy W request)               *
002700180109      * 01/09/17 jt  - Added changes for Advanced Mobile
002800180530      * 05/30/18 dlk - remove benegap column and exchange column
002900200110      * 01/10/20 jt  - Added changes for CMS
003000210512      * 05/12/21 dlk - look out for bad birthdate
003100211207      * 12/07/21 dlk - few field changes and additions per Finance
003200160531      *                                                                *
003300001010      ******************************************************************
003400001010     FACCMST    IP   E           K DISK
003500001010     FMEMAC#    IF   E           K DISK
003600001010     FCANLOG    IF   E           K DISK
003700001010     FHISTAA    IF   E           K DISK
003800001010     FSMAN      IF   E           K DISK
0039000603140005 Fcmct14    if   e           k disk
004000060314     fspragxr2  if   e           k disk
004100060314     fsmanrlt   if   e           k disk
004200100604     faccmsp    if   e           k disk
004300100604     fodfacp    if   e           k disk
004400100722     fodrgnp    if   e           k disk
004500100608     ftrsmst    if   e           k disk
004600140523     fcodesl1   if   e           k disk
004700160531     finvsum    if   e           k disk
004800211207     faacode    if   e           k disk
004900211207     fhypercarr if   e           k disk
005000211207     fplnmst    if   e           k disk
005100211207     fcarmst    if   e           k disk
005200090528     FRP180xl   o  a e             disk
005300100604     FRP180bxl  o  a e             disk
005400060314     fqsysprt   o    f  132        printer oflind(*inof)
005500000929
005600100604     Dcsv              c                   const('","')
005700001010     D @DATIN          S              8  0
005800001010     D @DATOU          S              8  0
005900001010     D @MD             S              4  0
006000001010     D @Y              S              4  0
006100001010     D AGE             S              3  0
006200001010     D ATOTAG          S              5  0
006300001010     D CODE            S              3    INZ('DAC')
006400001010     D N               S              1    DIM(31)
006500001010     D N#              S              2  0
006600001010     D TRDMDY          S              8  0
006700150709     D acmem           S              6  0
006800150709     D atotr           S             11  2
006900150709     D aavage          S              3  0
007000090528     D atrMDY          S              8  0
007100001010     D TTOTAC          S              4  0
007200001010     D TTOTAG          S              6  0
007300080819     D saagfound       S              1
0074000603140020 D ag              S              3    DIM(10)
0075000808190020 D sa              S              3    DIM(5)
0076000603140037 D holdrel         S                   like(cmrelid)
0077000603140037 D holdag          S                   like(sxagcy)
0078000808190037 D holdsa          S                   like(sxsuper)
0079001006040037 D hldofc          S                   like(s2ofc#)
0080001006040037 D hldmaid         S                   like(ammaid)
0081001006040037 D hldofcdes       S                   like(mooloc)
0082000808150037 D workdt          S               d   datfmt(*iso)
0083001605310037 D linvprm         S                   like(apremi)
008400180129     d SrDenAdvMob     S              3
008500211207     D gbsbdmdy        s              8  0
008600211207     d aaname          s             43
0087002112070020 D car             S             30    DIM(10)
008800211207     d actcnt          s              4  0
008900211207     d tsa_hold        s             10
009000001010
009100001010     D                UDS
009200001010     D  LTRUST                 1      3
009300001010     D  LMDY                   4     11  0
009400001010     D  LMD                    4      7  0
009500001010     D  LY                     8     11  0
009600001010     D  LRNMM                 12     13  0
009700001010     D  LSORT                 22     22
009800060314     D  Lagency               31     60
009900060314     D  Lag1                  31     33
010000060314     D  Lag2                  34     36
010100060314     D  Lag3                  37     39
010200060314     D  Lag4                  40     42
010300060314     D  Lag5                  43     45
010400060314     D  Lag6                  46     48
010500060314     D  Lag7                  49     51
010600060314     D  Lag8                  52     54
010700060314     D  Lag9                  55     57
010800060314     D  Lag10                 58     60
010900080819     D  LSA                   61     75
011000080819     D  Lsa1                  61     63
011100080819     D  Lsa2                  64     66
011200080819     D  Lsa3                  67     69
011300080819     D  Lsa4                  70     72
011400080819     D  Lsa5                  73     75
011500100604     D  lsdyn                 76     76
011600100608     D  Ltomdy                77     84  0
011700001010     D  CONAME               201    240
011800001016
011900100608     D                 DS
012000100608     D LYMD                    1      8  0
012100100608     D LYY                     1      4  0
012200100608     D LMMDD                   5      8  0
012300100608
012400001010      *  ACCMST
012500001010     D                 DS
012600001010     D  BAL                    1    108  2 DIM(12)
012700001010     D  BAL1                   1      9  2
012800001010     D  BAL2                  10     18  2
012900001010     D  BAL3                  19     27  2
013000001010     D  BAL4                  28     36  2
013100001010     D  BAL5                  37     45  2
013200001010     D  BAL6                  46     54  2
013300001010     D  BAL7                  55     63  2
013400001010     D  BAL8                  64     72  2
013500001010     D  BAL9                  73     81  2
013600001010     D  BAL10                 82     90  2
013700001010     D  BAL11                 91     99  2
013800001010     D  BAL12                100    108  2
013900001010
014000001010     D                 DS
014100001010     D  UD8YMD                 1      8  0
014200001010     D  UD8Y                   1      4  0
014300001010
014400001010      *  MEMAC#
014500001010     D                 DS
014600001010     D  BIRTH                  1      8  0
014700001010     D  BYR                    1      4  0
014800001010     D  BMO                    5      6  0
014900001010     D                 DS
015000001010     D  STATUS                 9     10
015100001010     D  STAT2                 10     10
015200001010
015300001010      *  CANLOG
015400001010     D                 DS
015500001010     D  CCREAS                 1      3
015600001010     D  CCRES2                 2      3
015700001010
015800001016     D                 DS
015900001016     D  TSA#                   1     10  0 INZ
016000001010     D  TSA                    1     10
016100001010     D  TRST                   1      3
016200001010     D  SUB#                   4      6
016300001010     D  ACCT                   7     10
016400100609     D                 DS
016500100609     D  ck#not                 1     30
016600100609     D  termcode              29     30
016700001010
016800001010     IACCMSR
016900211207     I              aacode                      AACODE_a
017000001010
017100080819      * select super agency or agency
017200080819     c                   if        lsa <> *blanks or
017300080819     c                             lagency <> *blanks
017400080819     c                   exsr      #saagchk
017500080819     c                   if        saagfound <> 'Y'
017600080819     c                   goto      #t0020
017700080819     c                   end
017800080819     c                   end
017900060314
018000001016     C                   MOVE      ACTRST        TRST
018100001016     C                   MOVE      ACSUB#        SUB#
018200001016     C                   MOVE      ACACCT        ACCT
018300001016
018400001010      * ACCUMULATE RECEIVABLE AMOUNT FOR ACCOUNT
018500001010
018600001010     C                   XFOOT     BAL           ATOTR
018700001010
018800001010      ***************************************************************
018900001010      * READ MEMBERS IN ACCOUNT                                     *
019000001010      ***************************************************************
019100001010
019200100604     c                   clear                   hldssn
019300100604     c                   clear                   hldbir
019400001010     C                   EVAL      ACMEM = 0
019500001010     C     KEYACC        SETLL     MEMAC#
019600150709     c                   dou       %eof(memac#)
019700150709     C     KEYACC        READE     MEMAC#
019800001010
019900150709     C                   IF        not %eof(memac#)
020000001010
020100100608     C                   IF        TERMDT = atrmdt
020200001010     C                   EVAL      ACMEM = ACMEM + 1
020300001010      * CALCULATE AGE FOR MEMBER
020400210512      * avoid bad birth dates loaded from import programs
020500210512     C                   clear                   AGE
020600210512     c                   if        byr > 1900
020700210512     C                   EVAL      AGE = UD8Y - BYR
020800210512     C                   IF        UMONTH <> 12 and
020900210512     C                             UMONTH < BMO
021000001010     C                   EVAL      AGE = AGE - 1
021100001010     C                   ENDIF
021200210512     c                   end
021300001010
021400001010     C                   EVAL      ATOTAG = ATOTAG + AGE
021500001010     C                   EVAL      AGE = 0
021600001010
021700100604      * hold data for senior dental
021800100604     c                   move      mbssno        hldssn            9 0
021900100604     c                   move      birth         hldbir            8 0
022000100604     C                   ENDIF
022100150709
022200150709     c                   end
022300150709     c                   enddo
022400001010
022500001010     C     #END          TAG
022600150709
022700150709     C                   clear                   smanout          30
022800150709     C     SMANCD        CHAIN     SMAN
022900150709     c                   if        %found(sman)
023000150709     C     SFNAME        CAT       SLNAME:1      smanout
023100150709     c                   end
023200001010
023300001010      * CHECK FOR NO MEMBERS IN ACCOUNT, (TRANSFER)
023400001010
023500001010     C                   IF        ACMEM = 0
023600001010     C     KEYACC        SETLL     CANLOG
023700930804     C     #BACK         TAG
023800001010     C     KEYACC        READE     CANLOG                                 66
023900930810     C   66              GOTO      SKPCA1
024000100608     C                   IF        CTERMD <> atrmdt
024100930804     C                   GOTO      #BACK
024200001010     C                   ENDIF
024300001009
024400930810     C     SKPCA1        TAG
024500001016
024600001010     C                   GOTO      #T0020
024700001010     C                   ENDIF
024800001010
024900150709
025000150709     C                   EVAL(H)   AAVAGE = ATOTAG/ACMEM
025100150709     C                   EVAL      ATOTAG = 0
025200150709
025300001010     C     KEYACC        SETLL     CANLOG
025400930804     C     #BACK2        TAG
025500001010     C     KEYACC        READE     CANLOG                                 66
025600930810     C   66              GOTO      SKPCA2
025700100608     C                   IF        CTERMD <> atrmdt
025800930804     C                   GOTO      #BACK2
025900001010     C                   ENDIF
026000001009
026100930810     C     SKPCA2        TAG
026200001009
026300001009      * READ HIST FOR TRANS DATE OF ACCOUNT CANCELLATION
026400001009
026500950522     C                   SETOFF                                           68
026600001010     C     HSTKEY        SETLL     HISTAA
026700950522     C     #T0015        TAG
026800001010     C     HSTKEY        READE     HISTAA                                 68
026900100608     C  N68              IF        COVTDT <> atrmdt
027000950522     C                   GOTO      #T0015
027100001010     C                   ENDIF
027200001009
027300140523      * get term code description
027400140523     c                   move      ck#not        termcodewk2       2
027500140523     c                   move      ck#not        termcodewk        3
027600140523     c                   movel     'D'           termcodewk
027700140523     c                   clear                   termdesout       30
027800140523     c     termcodewk    chain     codesl1
027900140523     c                   if        %found(codesl1)
028000140523     c                   movel     ldescr        termdesout
028100140523     c                   end
028200140523
028300140523
028400001017     C  N68              EVAL      @DATIN = TRDATE
028500001017     C  N68              EXSR      #DATYM
028600001017     C  N68              EVAL      TRDMDY = @DATOU
028700001010
028800090528     C  N68              EVAL      @DATIN = covtdt
028900090528     C  N68              EXSR      #DATYM
029000090528     C  N68              EVAL      atrMDY = @DATOU
029100100604
029200150709
029300160531      * Get last amount invoiced. If the amount in ACCMST is not zero
029400160531      * then use it, else get the last amount from invsum.
029500160531      * Invsum is keyed in acct/effdt/rec code order
029600160531      * so set limits past the acct and read backwards month by
029700160531      * month all current enrollment records for the first record
029800160531      * found with a non zero amount
029900160531     c                   z-add     apremi        linvprm
030000160531     c                   if        linvprm = 0
030100160531     c     keyacc        setgt     invsum
030200160531     c                   dou       %eof(invsum)
030300160531     c     keyacc        readpe    invsum
030400160531     c                   if        not %eof(invsum) and inrc = 'KCE'
030500160531     c                             and intot <> 0
030600160531      * prior month found
030700160531     C                   Z-ADD     intot         linvprm
030800160531     c                   leave
030900160531     C                   end
031000160531     C                   enddo
031100160531     C                   end
031200150709
031300211207* beg * clear carrier array
031400211207        clear car;
031500211207
031600211207        @datin = gbsbdt;
031700211207        exsr #datym;
031800211207        gbsbdmdy = @datou;
031900211207
032000211207      * get aa name
032100211207        clear aaname;
032200211207        chain aacode_a aacode;
032300211207        if %found(aacode);
032400211207        aaname = %trim(afnam) + ' ' + %trim(alnam);
032500211207        endif;
032600211207
032700211207      * find all medical carriers
032800211207     c                   clear                   comctxfound       1
032900211207     c                   z-add     atrmdt        searchdt          8 0
033000211207     c                   exsr      #getcar
033100211207      * if not found, try again with 1 day less, some comctx are cancelled
033200211207      * 1 day less than the acct cancel date
033300211207     c                   if        comctxfound = *blank
033400211207     c                   move      atrmdt        workdt
033500211207     C                   subdur    1:*d          workdt
033600211207     C                   move      workdt        searchdt
033700211207     c                   exsr      #getcar
033800211207     c                   end
033900211207
034000211207      * count number of unique accounts. Not really needed here since this
034100211207      * program reads accmst but I will include it to match the format of
034200211207      * RP182B.
034300211207
034400211207       if tsa_hold <> tsa;
034500211207        tsa_hold = tsa;
034600211207        actcnt = 1;
034700211207       else;
034800211207        actcnt += 1;
034900211207       endif;
035000211207
035100090528      * write excel file
035200090528     c                   exsr      writexldet
035300090528
035400910321     C     #T0020        TAG
035500160531
035600001010      ***************************************************
035700001010      * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
035800001010      ***************************************************
035900001010
036000001010      * DATE IN  = @DATIN (8.0) YYYYMMDD
036100001010      * DATE OUT = @DATOU (8.0) MMDDYYYY
036200001010
036300001010     C     #DATYM        BEGSR
036400001010     C                   MOVE      @DATIN        @MD
036500001010     C                   MOVEL     @DATIN        @Y
036600001010     C                   MOVEL     @MD           @DATOU
036700981123     C                   MOVE      @Y            @DATOU
036800001010     C                   EVAL      @DATIN = *ZEROS
036900001010     C                   ENDSR
037000001010
037100001010      ***************************************************
037200001010      * CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
037300001010      ***************************************************
037400001010
037500001010      * DATE IN  = @DATIN (8.0) MMDDYYYY
037600001010      * DATE OUT = @DATOU (8.0) YYYYMMDD
037700001010
037800001010     C     #DATMY        BEGSR
037900001010     C                   MOVE      @DATIN        @Y
038000001010     C                   MOVEL     @DATIN        @MD
038100001010     C                   MOVEL     @Y            @DATOU
038200001010     C                   MOVE      @MD           @DATOU
038300001010     C                   EVAL      @DATIN = *ZEROS
038400001010     C                   ENDSR
038500060314
0386000603140069 C**************************************************************
038700080819JGE01C* Super agency / agency check                                *
0388000603140069 C**************************************************************
038900080819JGE01C     #saagchk      BEGSR
039000060314
039100060314     c                   clear                   holdrel
039200060314     c                   clear                   holdag
039300080819     c                   clear                   holdsa
039400080819     c                   clear                   saagfound
039500060314
039600060314      * find all comctx for the acct cancel date
039700060314     c     keyacc        setll     cmct14
039800060314     c                   dou       %eof(cmct14)
039900060314     c     keyacc        reade     cmct14
040000100608     c                   if        (not %eof(cmct14)) and (atrmdt >= effdat)
040100100608     c                             and (cmcan = 0 or cmcan >= atrmdt)
040200060314     c                             and (cmcan <> effdat)
040300060314     c                   move      cmrelid       holdrel
040400060314     c                   exsr      #chkrel
040500080819     c                   if        saagfound = 'Y'
040600060314     c                   leavesr
040700060314     c                   end
040800060314     c                   end
040900060314     c                   enddo
041000060314
041100080815      * missing commission - try again for previous month
041200080815     c                   if        holdrel = *blanks
041300100608     C                   move      atrmdt        workdt
041400080815     C                   subdur    1:*m          workdt
041500100608     C                   move      workdt        atrmdt2           8 0
041600080815     c     keyacc        setll     cmct14
041700080815     c                   dou       %eof(cmct14)
041800080815     c     keyacc        reade     cmct14
041900100608     c                   if        (not %eof(cmct14)) and (atrmdt >= effdat)
042000100608     c                             and (cmcan = 0 or cmcan >= atrmdt2)
042100080815     c                             and (cmcan <> effdat)
042200080815     c                   move      cmrelid       holdrel
042300080815     c                   exsr      #chkrel
042400080819     c                   if        saagfound = 'Y'
042500080815     c                   leavesr
042600080815     c                   end
042700080815     c                   end
042800080815     c                   enddo
042900080815     c                   end
043000080815
043100080815      * missing commission after 2nd try - error
043200060314     c                   if        holdrel = *blanks
043300060315     c                   if        firste <> 'N'
043400060315     c                   move      'N'           firste            1
043500060315     c                   except    errhed
043600060315     c                   end
043700060315     c   of              except    errhed
043800060315     c                   except    errcom
043900060314     c                   end
044000060314
044100060314     c                   endsr
044200060314
044300060314      **************************************************************
044400080819      * check this relation for a match to the selected super agency
044500080819      * or agency
044600060314      **************************************************************
044700060314     c     #chkrel       begsr
044800060314
0449000603140063 C     holdrel       CHAIN     smanrlt
045000060314     c                   if        not %found(smanrlt)
045100060314     c                   leavesr
045200060314     c                   else
045300060314    * * the relation is not active for the run date
045400060314     c                   if        (sreffdte = srtrmdte) or
045500100608     c                             (sreffdte > atrmdt) or (srtrmdte <> 0
045600100608     c                             and srtrmdte <= atrmdt)
045700060314     c                   leavesr
045800060314     c                   end
045900060314     c                   end
046000060314      * get SA xref
046100060314     c     srasid        chain     spragxr2
046200060314     c                   if        %found(spragxr2)
046300060314     c                   eval      holdag = sxagcy
046400080819     c                   eval      holdsa = sxsuper
0465000603140309 C                   Z-ADD     1             X                 2 0
046600060314     c     holdag        lookup    ag(x)                                  88
046700060314     c                   if        %found
046800080819     c                   eval      saagfound = 'Y'
046900060314     c                   end
0470000808190309 C                   Z-ADD     1             X                 2 0
047100080819     c     holdsa        lookup    sa(x)                                  88
047200080819     c                   if        %found
047300080819     c                   eval      saagfound = 'Y'
047400080819     c                   end
047500060314     c                   end
047600060314
047700060314JGE01C                   ENDSR
0478002112070069 C**************************************************************
047900211207JGE01C* get carriers
0480002112070069 C**************************************************************
048100211207JGE01   begsr #getcar;
048200211207
048300211207      * find all comctx for the acct cancel date
048400211207           setll (hstrst : hssub# : hsacct) cmct14;
048500211207           dou %eof(cmct14);
048600211207           reade (hstrst : hssub# : hsacct) cmct14;
048700211207           if (not %eof(cmct14)) and (searchdt >= effdat)
048800211207               and (cmcan = 0 or cmcan >= searchdt)
048900211207               and (cmcan <> effdat);
049000211207              comctxfound = 'Y';
049100211207
049200211207      * get plan and carrier, only show medical
049300211207           chain (cmtrst : csubdv : cmplan) plnmst;
049400211207           if %found(plnmst);
049500211207            chain (plncat) codesl1;
049600211207            if %found(codesl1) and action = 'M';
049700211207             chain (pcarr) carmst;
049800211207             if %found(carmst);
049900211207              chain (cgrpcd) hypercarr;
050000211207              exsr #storcar;
050100211207             endif;
050200211207            endif;
050300211207           endif;
050400211207
050500211207           endif;
050600211207           enddo;
050700211207
050800211207           endsr;
050900211207
0510002112070351 C****************************************************************
0511002112070352 C*    STORE carrier group name                                  *
0512002112070354 C****************************************************************
051300211207     C     #storcar      BEGSR
051400211207
051500211207     C                   Z-ADD     1             X                 2 0
051600211207     C     #T0080        TAG
051700211207
051800211207     C                   IF        car(x) = *BLANKS
051900211207     C                   MOVE      hcname        car(X)
052000211207     C                   leavesr
052100211207     C                   ELSE
052200211207     c                   if        car(x) = hcname
052300211207     C                   leavesr
052400211207     C                   ELSE
052500211207     C                   ADD       1             X
052600211207     C*
052700211207     C     X             IFLE      10
052800211207     C                   GOTO      #T0080
052900211207     C                   END
053000211207
053100211207     C                   END
053200211207     C                   END
053300211207
053400211207     C                   ENDSR
053500211207
053600060314
053700090528     C*************************************************************
053800090528     C*                                                           *
053900090528     C* Write Spreadsheet heading                                 *
054000090528     C*                                                           *
054100090528     C*************************************************************
054200090528     C     Writexlhead   BEGSR
054300090528
054400090528     c                   clear                   rp180fld
054500090528     C                   Eval      rp180fld  =   '"' + 'ACCOUNT #'     + '","' +
054600090528     C                                           'ACCOUNT NAME'        + '","' +
054700090528     C                                           'CONTACT'             + '","' +
054800211207     C                                           'BEGIN ADMIN DATE'    + '","' +
054900211207     C                                           'DATE PROCESSED'      + '","' +
055000211207     C                                           'COUNT'               + '","' +
055100211207     C                                           'CANCEL DATE'         + '","' +
055200090528     C                                           'CANCEL REASON'       + '","' +
055300140523     C                                           'TC'                  + '","' +
055400140523     C                                         'TERM CODE DESCRIPTION' + '","' +
055500090528     C                                           'AVG AGE'             + '","' +
055600090528     C                                           '# OF MEM'            + '","' +
055700090528     C                                           'LAST INV $'          + '","' +
055800090528     C                                           'RECEIVABLE $'        + '","' +
055900211207     C                                           'AA NAME'             + '","' +
056000090528     C                                           'SMAN NAME'           + '","' +
056100211207     C                                           'CARRIER 1'           + '","' +
056200211207     C                                           'CARRIER 2'           + '","' +
056300211207     C                                           'CARRIER 3'           + '","' +
056400211207     C                                           'CARRIER 4'           + '","' +
056500211207     C                                           'CARRIER 5'           + '","' +
056600211207     C                                           'CARRIER 6'           + '","' +
056700211207     C                                           'CARRIER 7'           + '","' +
056800211207     C                                           'CARRIER 8'           + '","' +
056900211207     C                                           'CARRIER 9'           + '","' +
057000211207     C                                           'CARRIER 10'          + '","' +
057100090528     C                                                 ' '             + '",'
057200090528     C                   Write     rp180xr
057300090528     C*
057400180129      * senior dental xls/Advance Mobile...
057500180129     c****               if        lsdyn = 'Y'
057600200110     c                   if        lsdyn = 'A' or lsdyn = 'D' or lsdyn = 'C'
057700100604     c                   clear                   rp180bfld
057800100604     C                   Eval      rp180bfld =   '"' + 'ACCOUNT #'     + '","' +
057900100604     C                                           'ACCOUNT NAME'        + '","' +
058000100609     C                                           'LAST INV $'          + '","' +
058100100604     C                                           'SSN'                 + '","' +
058200100604     C                                           'EFFECTIVE'           + '","' +
058300100609     C                                           'CANCEL CODE'         + '","' +
058400100604     C                                           'CANCEL REASON'       + '","' +
058500140630     C                                         'TERM CODE DESCRIPTION' + '","' +
058600100604     C                                           'DOB'                 + '","' +
058700100604     C                                           'MEDICAID#'           + '","' +
058800100608     C                                           'REGION / OFFICE'     + '","' +
058900100604     C                                                 ' '             + '",'
059000100604     C                   Write     rp180bxr
059100100604     c                   end
059200100604
0593000905280320 C                   ENDSR
0594000905280164 C*************************************************************
0595000905280164 C*                                                           *
0596000905280164 C* Write Spreadsheet Detail                                  *
0597000905280164 C*                                                           *
0598000905280164 C*************************************************************
059900090528     C     Writexldet    BEGSR
060000090528
060100090528     c                   clear                   rp180fld
060200090528     C                   Eval      rp180fld  =   '"' +
060300090528     C                             %trim(%editw(tsa#:'0   -   -    ')) + '","' +
060400090528     C                             acnam1                              + '","' +
060500090528     C                             contac                              + '","' +
060600211207     C                             %editw(gbsbdmdy:'0  /  /    ')      + '","' +
060700090528     C                             %trim(%editw(trdmdy:'0  /  /    ')) + '","' +
060800211207     C                             %Trim(%Editc(actcnt:'3'))           + '","' +
060900090528     C                             %trim(%editw(atrmdy:'0  /  /    ')) + '","' +
061000100609     C                             creasn                              + '","' +
061100140630     C                             termcodewk2                         + '","' +
061200140523     C                             termdesout                          + '","' +
061300090528     C                             %Trim(%Editc(aavage:'3'))           + '","' +
061400090528     C                             %Trim(%Editc(acmem:'3'))            + '","' +
061500160531     C                             %Trim(%Editc(linvprm:'N'))          + '","' +
061600150709     C                             %Trim(%Editc(atotr:'N'))            + '","' +
061700211207     C                             aaname                              + '","' +
061800090528     C                             smanout                             + '","' +
061900211207     C                             %trim((car(1)))                     + '","' +
062000211207     C                             %trim((car(2)))                     + '","' +
062100211207     C                             %trim((car(3)))                     + '","' +
062200211207     C                             %trim((car(4)))                     + '","' +
062300211207     C                             %trim((car(5)))                     + '","' +
062400211207     C                             %trim((car(6)))                     + '","' +
062500211207     C                             %trim((car(7)))                     + '","' +
062600211207     C                             %trim((car(8)))                     + '","' +
062700211207     C                             %trim((car(9)))                     + '","' +
062800211207     C                             %trim((car(10)))                    + '","' +
062900090528     C                             ' '                          + '",'
063000090528     C*
063100090528     C                   Write     rp180xr
063200100604
063300180129      * senior dental xls/Advance Mobile...
063400180129     c****               if        lsdyn = 'Y'
063500200110       if lsdyn = 'D' or lsdyn = 'A' or lsdyn = 'C';
063600100604
063700200110        select;
063800200110         when lsdyn = 'D';
063900200110          SrDenAdvMob = 'O N';
064000200110         when lsdyn = 'A';
064100200110          SrDenAdvMob = 'O M';
064200200110         when lsdyn = 'C';
064300200110          SrDenAdvMob = 'O D';
064400200110        endsl;
064500180129
064600100604     C                   EVAL      @DATIN = hldbir
064700100604     C                   EXSR      #DATYM
064800100604     C                   EVAL      hldbir = @DATOU
064900100604
065000100604
065100100604     C                   clear                   hldofc
065200100604     C                   clear                   hldmaid
065300100604     C                   clear                   hldofcdes
065400100608
065500180129      * senior dental/Advanced Mobile only
065600180129     C     actrst        Chain     trsmst
065700180129     C                   if        not %found or tscode <> SrDenAdvMob
065800180129     c                   leavesr
065900180129     c                   endif
066000180129
066100100608      * senior dental only
066200180129     C**** actrst        Chain     trsmst
066300180109     C****               If        not %Found(trsmst) or tscode <> 'O N'
066400180129     c****               leavesr
066500180129     c****               end
066600100608
066700180129     C     actrst        Chain     trsmst
066800180129     C                   if        not %found or tscode <> SrDenAdvMob
066900180129     c                   leavesr
067000180129     c                   endif
067100100604     C     KEYACC        Chain     ACCMSP
067200100604     C                   If        %Found(accmsp)
067300100604     C                   move      ammaid        hldmaid
067400100604     C     FacKey        Chain     ODFACP
067500100604     C                   If        %Found(ODFACP)
067600100604     C                   move      S2OFC#        hldofc
067700100722     C     ofckey        Chain     ODrgnp
067800100722     C                   If        %Found(ODrgnp)
067900100604     C                   move      mooloc        hldofcdes
068000100604     C                   End
068100100604     C                   End
068200100604     C                   End
068300100604
068400100604
068500100604     c                   clear                   rp180bfld
068600100604     C                   Eval      rp180bfld  =   '"' +
068700100604     C                             %trim(%editw(tsa#:'0   -   -    ')) + csv +
068800100604     C                             acnam1                              + csv +
068900160531     C                             %Trim(%Editc(linvprm:'N'))          + csv +
069000100604     C                             %Trim(%Editw(hldssn:'0   -  -    ')) + csv +
069100100604     C                             %trim(%editw(atrmdy:'0  /  /    ')) + csv +
069200100609     C                             termcode                            + csv +
069300100604     C                             creasn                              + csv +
069400140630     C                             termdesout                          + '","' +
069500100604     C                             %trim(%editw(hldbir:'0  /  /    ')) + csv +
069600100604     C                             hldmaid                             + csv +
069700100608     C                             hldofcdes                           + '",'
069800100604     C*
069900100604     C                   Write     rp180bxr
070000100604     c                   end
070100100604
0702000905280320 C                   ENDSR
070300090528
070400060314     C     *inzsr        BEGSR
070500060314     C     KEYACC        KLIST
070600060314     C                   KFLD                    ACTRST
070700060314     C                   KFLD                    ACSUB#
070800060314     C                   KFLD                    ACACCT
070900060314
071000150709     C     cmctxplnky    KLIST
071100150709     C                   KFLD                    CMTRST
071200150709     C                   KFLD                    CSUBDV
071300150709     C                   KFLD                    CMPLAN
071400150709
071500060314     C     HSTKEY        KLIST
071600060314     C                   KFLD                    TSA
071700060314     C                   KFLD                    CODE
071800060314
071900100604     C     FacKey        KLIST
072000100604     C                   KFLD                    ACTRST
072100100604     C                   KFLD                    ACSUB#
072200100604
072300100604     C     ofckey        KLIST
072400100604     C                   KFLD                    ACTRST
072500100604     C                   KFLD                    hldofc
072600100604
072700060314     C                   EVAL      LYY = LY
072800060314     C                   EVAL      LMMDD = LMD
072900060314     C                   EVAL      *IN80 = *ON
073000060314     C                   EVAL      @DATIN = *DATE
073100060314     C                   EXSR      #DATMY
073200060314     C                   EVAL      UD8YMD = @DATOU
073300060314
073400060314     C                   movea     lagency       ag
073500080819     C                   movea     lsa           sa
073600060314
073700090528     C                   Exsr      Writexlhead
073800060314     C                   ENDSR
073900060315     oqsysprt   e            errhed         2  2
0740000603170142 O                                           14 'RUN DATE:'
0741000603170143 O                       UDATE         Y     25
074200060317     O                                           70 'RP180 (CANCELLED ACCOUNTS'
074300060317     O                                           +1 'REPORT) - ERRORS'
0744000603170134 O                       LMDY               105 '  /  /    '
074500060314     o          e            errcom         1
074600060314     O                       actrst              20
074700060314     O                       acsub#              24
074800060314     O                       acacct              29
074900060317     O                                           80 'NO COMMISSION FOUND - AC'
075000060317     O                                           +0 'COUNT WILL NOT BE SELECTED'
