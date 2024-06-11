000200990630      *? ***************************************************************
000300010322      *             GROUP BENIFIT SERVICES SOFTWARE           2000     *
000400010322      *                                                                *
000500000118      *  Written by:    S. Zien                                        *
000600001106      *  Date Written:  11/6/00                                        *
000700001106      *  Description:   Account Invoice Audit                          *
000800000118      *                                                                *
000900000118      *                                                                *
001000000118      *                R E V I S I O N    H I S T O R Y                *
001100000118      *  Date                                                          *
001200000118      *  Revised   Initials    Revision                                *
001300000118      *  --------  --------    --------------------------------------  *
001400001211      *  12/11/00    SZZ       Print one page even if no errors.       *
001401010117      *   1/17/01    szz       Retrieve company name from data area    *
001402010321      *   3/21/01    szz       If the account had been transferred,    *
001403010321      *                         use the HIST covered-through date      *
001404010321      *                         instead of the GBS Begin Admin Date.   *
001405010718100s  *   7/18/01    szz       Do not show any errors prior to two     *
001406010718      *                         years ago per Dave K.                  *
001407100408100s  *   4/04/10    szz       If there has never been an invoice,     *
001408100408      *                         print an error message.                *
001409111013100s  *  10/13/11    dlk       add csv output                          *
001410111017100s  *  10/17/11    dlk       add exclusion file                      *
001411120921100s  *  09/21/12    dlk       allow cancelled accts to show for       *
001500120921      *                        "acct not yet inv" msg                  *
001501121130100s  *  11/29/12    dlk       fix a few lines that were stopping      *
001600121130      *                        errors from showing under cancelled accts.
001601140812100s  *  08/12/14    dlk       change histak to histaa and fix some    *
001602140812      *                        code that was not working and remove    *
001604140812      *                        printer file.                           *
001605140812      *                                                                *
001700990630      *? ***************************************************************
001800010322
001900001107     FAccmst    IF   E           K disk
001901140812     Fhistaa    IF   E           K disk
002000001107     FInvsum    IF   E           K disk
002100001107     FContrl    IF   E           K disk
002200001107     FInvexc    IF   E           K disk
002201111017     Fabr01ex   IF   E           K disk
0023011110130017 Fabr010xl  o  a e             DISK
002400991020
002401010117     D                UDS
002402010118     D  CONAME               201    250
002500991230    ? * Program status data structure
002600991230    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002700001107     D                 DS
002800001107     DKeyflI                         14
002900001108     D  kccyy                         4    Overlay(KeyflI)
003000001108     D  kmm                           2    Overlay(KeyflI:5)
003100001108     D  ktrst                         3    Overlay(KeyflI:7)
003101010322
003102010322     D                 DS
003103010322     D tsa                     1     10  0
003104010322     D  Actrst                 1      3  0
003105010322     D  Acsub#                 4      6  0
003106010322     D  Acacct                 7     10  0
003107111013     D                 DS
003108111013     D ptsa                    1     10  0
003109111013     D  ptrst                  1      3  0
003110111013     D  psub#                  4      6  0
003111111013     D  pacct                  7     10  0
003300001107     DDSindt           DS
003400001107     D  inccyy                        4  0
003500001107     D  inmm                          2  0
003501100407     DDSNever          DS
003502100407     D  Nyy                           2  0
003503100407     D  Nmm                           2  0
003600001108     D                 DS
003700001108     D TIME_DATE                     12  0
003800001108     D  TIME                          6  0 OVERLAY(TIME_DATE)
003900001108     D  DATE                          6  0 OVERLAY(TIME_DATE:7)
004100001107     D ErrCtr          S              9S 0 Inz(0)
004200001107     D  B              S              1    Inz('B')
004300001107     D USA_Date        S               D   Datfmt(*USA)
004400140812     D workdt          S               D   DATFMT(*ISO)
004401140812     D ISO_DATE2       S               D   DATFMT(*ISO)
004500001108     D Gdtp1           S               D   Datfmt(*ISO)
004600001110     D Gbsb1           S               D   Datfmt(*ISO)
004700001110     D cymd1           S               D   Datfmt(*ISO)
004900001108    ?D Wddate1         S               D   datfmt(*ISO)
004901140812     D begindt_wk      S              8  0
005000001108    ?D Wwdate          S              8  0
005100001108     D CYMD            S              8  0
005101100407     D CYM             S              6  0
005102100407     D gdtp1f8         S              8  0
005103100407     D gdtp1f6         S              6  0
005200140812     D invcdt_hold     S              8  0
005201140812     D errmsg          S             30
0052021110130125 Dcsv              c                   const('","')
005300140812    ?D mismsg          C                   'Invoice Missing'
005500001107    ?D DupMsg          C                   'Duplicate Invoice'
005600140812    ?D bamsg           C                   'Before/after valid period'
005700001107    ?D NotMsg          C                   'Account not yet invoiced'
005800991229
005900000118      *---
006000000118      *? Main.
006100000118      *---
006101140813      * process all active accounts and
006102140813      * cancelled accounts within the last 3 years
006103140813    ?C                   Dou       %EOF(Accmst)
006200001106     c                   Read      Accmst
006400140813     C                   If        not %eof(Accmst) and
006800140813     C                             (Atrmdt = 0 or atrmdt >= cymd3y)
006802140813      * check for acct transfer
006803140813     C                   Exsr      GetHis
008001140812     C                   Move      begindt_wk    gdtp1f
008100000118     c                   exsr      process
008200001106     c                   endif
008600001109    ?C                   Enddo
008601140812
008602140813      * end
009200000118     C                   EVAL      *INLR = *ON
009201140812
009202140812      **********************************************************
009203140812      * Check for errors:
009204140812      * there should be one invoice per month from the begin admin date
009205140812      * up to the current month of invoicing for the trust
009207140812      **********************************************************
010500000118     C     process       BEGSR
011001140812     C                   Move      'N'           KEBFLAG           1
011003140812     C                   move      begindt01_wk  dateexpected
011004140812
011102140812      * read all KEB (invoice ending balance) records
011500140812     C     tsakey        Setll     Invsum
011600140812     C                   DOU       %eof(Invsum)
011700140812     C     tsakey        Reade     Invsum
012100140812     C                   If        not %eof(Invsum) and inrc = 'KEB'
012301140812     C                   Move      'Y'           KEBFLAG
012302140812
012307140812     c     #loop1        tag
012308140812      *
012309140812      * invoice before begin admin or after covered through date is
012310140812      * an error
012311140812     C                   If        (invcdt < begindt01_wk or invcdt > acvtdt)
012312140812     C                             and Invcdt >= 19941201
012313140812     C                   Movel     bamsg         errmsg
012314140812     C     *ISO          Move      Invcdt        USA_Date
012315140812     C                   Exsr      ErrRtn
012316140812     c                   iter
012317140812     C                   Endif
012318140812      *
012319140812      * this invoice is the one expected - NO error
012320140812     c                   if        invcdt = dateexpected
012323140812     C                   exsr      #nextmonth
012324140812     c                   iter
012325140812     C                   endif
013300140812      *
013400140812      * more than one invoice per month - error
013501140812     c                   if        invcdt < dateexpected
013700140812     C                   Movel     DupMsg        errmsg
013800001113     C     *ISO          Move      Invcdt        USA_Date
013900140812     C                   exsr      ErrRtn
013901140812     c                   iter
014000140812     C                   endif
015010140812
015011140812      *
015012140812      * missing invoice - error. add 1 month and do this logic again
015013140812      * without reading another invsum record
015016140812     c                   if        invcdt > dateexpected
016000140812     C                   Movel     mismsg        errmsg
016100140812     C     *ISO          Move      dateexpected  USA_Date
016102140812      * do not show this error past the account cancel date because
016103140812      * final invoices can have gaps in time
016104140812     c                   if        atrmdt = 0 or
016105140812     c                             atrmdt > dateexpected
016200001113     C                   Exsr      ErrRtn
016201140812     c                   end
016203140812     C                   exsr      #nextmonth
016204140812     c                   goto      #loop1
016205140812     c                   end
018100001109
018101140812
018102140812
018300001109     C                   Endif
018400001107     C                   Enddo
018401100407
018403140812
018404140812
018405100407      * Print the account-not-yet-invoiced error message for each month
018406120921      * 9/21/12 - remove check for active acct to show cancelled accts
018407120921      *           as long as the acct was active at least 1 month
018408120921      *
018409140812     C                   If        KEBFLAG   =   'N'         And
018410120921     C                             gbsbdt <> Atrmdt
018411120921     C*****                        Atrmdt = 0
018412100408     c                   move      gdtp1f        gdtp1
018413100407      *
018414100407     c                   movel     gdtp1         gdtp1f8
018415100407     c                   movel     gdtp1f8       gdtp1f6
018416100407     C                   movel     CYMD          CYM
018417120921     C                   movel     atrmdt        atrmdtym          6 0
018418100408     C                   Z-add     *Zero         LoopCtr           2 0
018419120921
018420100407     C                   Dow       gdtp1f6  <    CYM       And
018421120921     C                             LoopCtr  <    30
018422100407
018423120921      * stop showing msg at acct cancel date
018424120921     c                   if        atrmdtym <> 0 and gdtp1f6 >= atrmdtym
018425120921     c                   leave
018426120921     c                   end
018427120921
018428100407     C                   Add       1             LoopCtr
018429140812     C                   Movel     NotMsg        errmsg
018430100407     C     *ISO          Move      gdtp1f8       USA_DATE
018431100407     C                   Exsr      ErrRtn
018432100407     C                   move      gdtp1f        Wwdate
018433100408     c     *ISO          move      Wwdate        Wddate1
018434100407     c     Wddate1       adddur    1:*m          gdtp1
018435100408     c                   move      gdtp1         gdtp1f
018436100407     c                   move      gdtp1         gdtp1f8
018437100407     c                   movel     gdtp1f8       gdtp1f6
018439100407     C                   EndDo
018440100408
018446100407     C                   End
020600001107
020700000118     C                   ENDSR
020800000118      * ? _____________________________________________________________
020900000118      *? *                                                             *
021000001107      *? *  Process and write errors to a report.                      *
021100000118      *? *_____________________________________________________________*
021200001108     C     ErrRtn        BEGSR
021300000118
021400001211     C                   Move      'Y'           Errsw
021500001107     C                   Eval      ErrCtr = ErrCtr + 1
021600001107     C                   Move      Actrst        Ptrst
021700001107     C                   Move      Acsub#        Psub#
021800001107     C                   Move      Acacct        Pacct
022000140812     C                   Move      USA_Date      Peffdt            8 0
022100001107     C                   Move      Actrst        Ietrus
022200001107     C                   Move      Acsub#        Iesub
022300001107     C                   Move      Acacct        Ieacc
022301140812
022302140812     C     *ISO          Move      acvtdt        USA_Date
022303140812     C                   Move      USA_Date      acvtdtmdy         8 0
022305140812
022400001107     C     Ex_Key        Chain     Invexc
022500001107     C                   If        %Found(Invexc)
022600001110     C     *ISO          Move      Ieeff         USA_Date
022700001110     C                   Move      USA_Date      Pexcdt
022800001107     C                   Endif
022900001113
023000001113     C     Atrmdt        Ifne      *zeros
023100001113     C     *ISO          Move      Atrmdt        USA_Date
023200001113     C                   Move      USA_Date      Pcandt
023300001113     C                   Endif
023400001107
024001140812     C     *ISO          Move      begindt_wk    USA_Date
024100140812     C                   Move      USA_Date      Pgbsdt            8 0
024101010718     c     Peffdt        mult      10000.0001    Peffdtymd         8 0
024102010718100s C     Peffdtymd     Ifge      DOM_OH_ONE
024103111017
024104111017      * check for exclusion, if not found then print error
024105111017     c     abr01exkey    chain     abr01ex
024107111017     c                   if        not %found(abr01ex)
024201111013     C                   exsr      writexldet
024202111017100s C                   End
024203111017
024204010718100s C                   End
024300140812     C                   Move      *blanks       errmsg
024400140812     C                   Clear                   Pexcdt            8 0
024500140812     C                   Clear                   Pcandt            8 0
024700001107
024800000118     C                   ENDSR
024900001107      * ? _____________________________________________________________
025000001107      *? *                                                             *
025100001107      *? *  Determine whether trust has been invoiced for the month.   *
025200001107      *? *                                                             *
025300001107      *? *  Retrieve the control file using the invoice year/month &   *
025400001107      *? *  trust.  If the trust has not yet been invoiced for the     *
025500001107      *? *  month, there shouldn't be an invoice (if there is, it's an *
025600001108      *? *  error).                                                    *
025700001107      *? *                                                             *
025800001107      *? *_____________________________________________________________*
025900001107     C     CtrlSr        BEGSR
026000001107
026100001109     C                   Move      B             Ctype
026200001108     C                   Move      Inccyy        Kccyy
026300001108     C                   Move      Inmm          Kmm
026400001108     C                   Move      Intrst        Ktrst
026500001107     C     C_key         Chain     Contrl
026600001107
026700001107     C                   ENDSR
026800001108      * ? _____________________________________________________________
026900001108      *? *                                                             *
027000001108      *? *        Calculate month following GBS begin admin date.      *
027100001108      *? *                                                             *
027200001108      *? *        A range of dates are required starting from the      *
027300001108      *? *        GBS begin admin date and ending with the date that   *
027400001108      *? *        was invoiced for the trust.                          *
027500001108      *? *_____________________________________________________________*
027600001108     C     CalgSr        BEGSR
027700001108
027800001108     C                   move      gdtp1f        Wwdate
027900001108     c     *ISO          move      Wwdate        Wddate1
028000001108     c     Wddate1       adddur    1:*m          gdtp1
028100001108     c                   move      gdtp1         gdtp1f            8 0
028200001108
028300001108     C                   ENDSR
029501140812
029503140812      *****************************************************************
029504140812      * * Retrieve History record to determine if a transfer took     *
029505140812      * * place.  If so, use the transfer date and show a "T" on the  *
029506140812      * * report                                                      *
029507140812      *****************************************************************
029508010322     C     GetHis        BEGSR
029509010322
029510140812     C                   Movel     *blanks       PT                1
029511010322     C                   Movel     tsa           Hkey
029512140812     C                   Move      'GTA'         key_trcode        3
029513140812
029514140812     C     histaakey     Setll     histaa
029515140812     c                   dou       %eof(histaa)
029516140812     C     histaakey     Reade     histaa
029517140812     C                   if        not %eof(histaa)
029520140812     C                   eval      begindt_wk = Covtdt
029522140812     C                   movel     'T'           PT
029523140812     c                   leave
029525140812     C                   end
029527140812     c                   enddo
029528140812
029529140812      * if no transfer then use begin admin date
029530140812     c                   if        pt = *blanks
029531140812     C                   Eval      begindt_wk = Gbsbdt
029533140812     C                   end
029534140812
029535140812      * make seperate field that always has 1st of the month
029536140812     C                   move      begindt_wk    begindt01_wk
029537140812     C                   move      01            begindt01_wk      8 0
029538010322
029539010322     C                   ENDSR
029540140812
029541140812      *****************************************************************
029542140812      * determine next invoice date expected
029543140812      *****************************************************************
029544140812     c     #nextmonth    begsr
029545140812     c                   if        dateexpected <> 0 and
029546140812     c                             dateexpected < acvtdt
029547140812     c                   move      dateexpected  workdt
029548140812     c                   adddur    1:*m          workdt
029549140812     c                   move      workdt        dateexpected      8 0
029550140812     c                   else
029551140812      * no invoice expected after the covered through date
029552140812     c                   clear                   dateexpected
029553140812     c                   end
029554140812     C                   endsr
029555140812
0295561110130313 C*
0295571110130164 C*************************************************************
0295581110130164 C*                                                           *
0295591110130164 C* Write Spreadsheet Detail                                  *
0295601110130164 C*                                                           *
0295611110130164 C*************************************************************
029562111013     C     Writexldet    BEGSR
029563111013
029564111013     c                   clear                   abr010fld
029565111013     C                   Eval      abr010fld  = '"' +
029566111013     C                             %trim(%editw(PTSA:'0   -   -    '))  + csv +
029567140812     C                             %trim(acnam1)                        + csv +
029568111013     C                             %trim(pt)                            + csv +
029569111013     C                             %trim(%editw(pgbsdt:'  /  /    '))   + csv +
029570140812     C                             %trim(%editw(pcandt:'  /  /    '))   + csv +
029571140812     C                             %trim(%editw(acvtdtmdy:'  /  /    ')) + csv +
029572140812     C                             %Trim(errmsg)                        + csv +
029573111013     C                             %trim(%editw(peffdt:'  /  /    '))   + csv +
029574111013     C                             %trim(%editw(pexcdt:'  /  /    '))   + csv +
029575140813     C                             %trim(%editc(noempl:'Z'))            + csv +
029576140813     C                             %trim(%editc(apremi:'O':*cursym))    + csv +
029577140812     C                             ' '                                  + '" ,'
029578111013     C*
029579111013     C                   Write     abr010xr
0295801110130320 C                   ENDSR
029581111013     C*
029582111013     C/EJECT
029583111013     C*************************************************************
029584111013     C*                                                           *
029585111013     C* Write Spreadsheet heading                                 *
029586111013     C*                                                           *
029587111013     C*************************************************************
029588111013     C     Writexlhead   BEGSR
029589111013
029590111013     c                   clear                   abr010fld
029591111013     C                   Eval      abr010fld = '"' + 'ACCOUNT #'    + csv +
029592111013     C                                              'ACCOUNT NAME'  + csv +
029593111013     C                                              'TRANSFER'      + csv +
029594111013     C                                              'BEGIN ADMIN'   + csv +
029595140812     C                                              'CANCELLED'     + csv +
029596140812     C                                              'INVOICE THROUGH' +csv +
029597111013     C                                              'ERROR'         + csv +
029598140812     C                                              'ERROR DATE'    + csv +
029599111013     C                                              'EXCLUSION'     + csv +
029600140813     C                                              'ACTIVE MEM'    + csv +
029601140813     C                                              'LAST INV AMT'  + csv +
029602140812     C                                              ' '              + '",'
029603111013     C                   Write     abr010xr
029604111013     C*
0296051110130320 C                   ENDSR
029606111013      *******************************************
029607000118      * ? _____________________________________________________________
029700000118      *? *                                                             *
029800000118      *? *        Initialize.                                          *
029900000118      *? *_____________________________________________________________*
030000991116     C     *INZSR        BEGSR
030100001012
030200001108     C                   TIME                    TIME_DATE
030300001108     C     *MDY          MOVE      DATE          ISO_DATE2
030400001108     C                   MOVE      ISO_DATE2     CYMD
030500001211     C                   Move      'N'           Errsw             1
030501010322     C                   Movel     *blanks       PT
030600001108
030700001110     C                   move      CYMD          Wwdate
030800001110     c     *ISO          move      Wwdate        Wddate1
030900001110     c     Wddate1       subdur    3:*y          cymd1
031000001110     c                   move      cymd1         cymd3y            8 0
031100001110
031101010718100s c     Wddate1       subdur    2:*y          cymd1
031102010718     c                   move      cymd1         DScymd2           8 0
031103010718     c                   Move      00000001      DOM_OH_ONE        8 0
031104010718     c                   Movel     DScymd2       DOM6              6 0
031105010718     c                   Movel     DOM6          DOM_OH_ONE
031106010718
031111140812     c     histaakey     Klist
031112010321     c                   Kfld                    Hkey
031113140812     c                   Kfld                    key_trcode
031114010321
031200140812     C     tsakey        KLIST
031300140812     C                   KFLD                    actrst
031400140812     C                   KFLD                    acsub#
031500140812     C                   KFLD                    acacct
031600001106
031700001106     C     C_KEY         KLIST
031800001109     C                   KFLD                    Ctype
031900001106     C                   KFLD                    Keyfli
032000991229
032100001107     C     Ex_Key        KLIST
032200001107     C                   KFLD                    Ietrus
032300001107     C                   KFLD                    Iesub
032400001107     C                   KFLD                    Ieacc
032500001107
032501111017     C     abr01exkey    KLIST
032502111017     C                   KFLD                    ptrst
032503111017     C                   KFLD                    psub#
032504111017     C                   KFLD                    pacct
032505111017     C                   KFLD                    peffdtymd
032700001107
032701111013     C                   Exsr      Writexlhead
032800991020     C                   ENDSR
