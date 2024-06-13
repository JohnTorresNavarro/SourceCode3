      *? ***************************************************************
      *             GROUP BENIFIT SERVICES SOFTWARE           2000     *
      *                                                                *
      *  Written by:    S. Zien                                        *
      *  Date Written:  11/6/00                                        *
      *  Description:   Account Invoice Audit                          *
      *                                                                *
      *                                                                *
      *                R E V I S I O N    H I S T O R Y                *
      *  Date                                                          *
      *  Revised   Initials    Revision                                *
      *  --------  --------    --------------------------------------  *
      *  12/11/00    SZZ       Print one page even if no errors.       *
      *   1/17/01    szz       Retrieve company name from data area    *
      *   3/21/01    szz       If the account had been transferred,    *
      *                         use the HIST covered-through date      *
      *                         instead of the GBS Begin Admin Date.   *
100s  *   7/18/01    szz       Do not show any errors prior to two     *
      *                         years ago per Dave K.                  *
100s  *   4/04/10    szz       If there has never been an invoice,     *
      *                         print an error message.                *
100s  *  10/13/11    dlk       add csv output                          *
100s  *  10/17/11    dlk       add exclusion file                      *
100s  *  09/21/12    dlk       allow cancelled accts to show for       *
      *                        "acct not yet inv" msg                  *
100s  *  11/29/12    dlk       fix a few lines that were stopping      *
      *                        errors from showing under cancelled accts.
100s  *  08/12/14    dlk       change histak to histaa and fix some    *
      *                        code that was not working and remove    *
      *                        printer file.                           *
      *                                                                *
      *? ***************************************************************

     FAccmst    IF   E           K disk
     Fhistaa    IF   E           K disk
     FInvsum    IF   E           K disk
     FContrl    IF   E           K disk
     FInvexc    IF   E           K disk
     Fabr01ex   IF   E           K disk
0017 Fabr010xl  o  a e             DISK

     D                UDS
     D  CONAME               201    250
    ? * Program status data structure
    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
     D                 DS
     DKeyflI                         14
     D  kccyy                         4    Overlay(KeyflI)
     D  kmm                           2    Overlay(KeyflI:5)
     D  ktrst                         3    Overlay(KeyflI:7)

     D                 DS
     D tsa                     1     10  0
     D  Actrst                 1      3  0
     D  Acsub#                 4      6  0
     D  Acacct                 7     10  0
     D                 DS
     D ptsa                    1     10  0
     D  ptrst                  1      3  0
     D  psub#                  4      6  0
     D  pacct                  7     10  0
     DDSindt           DS
     D  inccyy                        4  0
     D  inmm                          2  0
     DDSNever          DS
     D  Nyy                           2  0
     D  Nmm                           2  0
     D                 DS
     D TIME_DATE                     12  0
     D  TIME                          6  0 OVERLAY(TIME_DATE)
     D  DATE                          6  0 OVERLAY(TIME_DATE:7)
     D ErrCtr          S              9S 0 Inz(0)
     D  B              S              1    Inz('B')
     D USA_Date        S               D   Datfmt(*USA)
     D workdt          S               D   DATFMT(*ISO)
     D ISO_DATE2       S               D   DATFMT(*ISO)
     D Gdtp1           S               D   Datfmt(*ISO)
     D Gbsb1           S               D   Datfmt(*ISO)
     D cymd1           S               D   Datfmt(*ISO)
    ?D Wddate1         S               D   datfmt(*ISO)
     D begindt_wk      S              8  0
    ?D Wwdate          S              8  0
     D CYMD            S              8  0
     D CYM             S              6  0
     D gdtp1f8         S              8  0
     D gdtp1f6         S              6  0
     D invcdt_hold     S              8  0
     D errmsg          S             30
0125 Dcsv              c                   const('","')
    ?D mismsg          C                   'Invoice Missing'
    ?D DupMsg          C                   'Duplicate Invoice'
    ?D bamsg           C                   'Before/after valid period'
    ?D NotMsg          C                   'Account not yet invoiced'

      *---
      *? Main.
      *---
      * process all active accounts and
      * cancelled accounts within the last 3 years
    ?C                   Dou       %EOF(Accmst)
     c                   Read      Accmst
     C                   If        not %eof(Accmst) and
     C                             (Atrmdt = 0 or atrmdt >= cymd3y)
      * check for acct transfer
     C                   Exsr      GetHis
     C                   Move      begindt_wk    gdtp1f
     c                   exsr      process
     c                   endif
    ?C                   Enddo

      * end
     C                   EVAL      *INLR = *ON

      **********************************************************
      * Check for errors:
      * there should be one invoice per month from the begin admin date
      * up to the current month of invoicing for the trust
      **********************************************************
     C     process       BEGSR
     C                   Move      'N'           KEBFLAG           1
     C                   move      begindt01_wk  dateexpected

      * read all KEB (invoice ending balance) records
     C     tsakey        Setll     Invsum
     C                   DOU       %eof(Invsum)
     C     tsakey        Reade     Invsum
     C                   If        not %eof(Invsum) and inrc = 'KEB'
     C                   Move      'Y'           KEBFLAG

     c     #loop1        tag
      *
      * invoice before begin admin or after covered through date is
      * an error
     C                   If        (invcdt < begindt01_wk or invcdt > acvtdt)
     C                             and Invcdt >= 19941201
     C                   Movel     bamsg         errmsg
     C     *ISO          Move      Invcdt        USA_Date
     C                   Exsr      ErrRtn
     c                   iter
     C                   Endif
      *
      * this invoice is the one expected - NO error
     c                   if        invcdt = dateexpected
     C                   exsr      #nextmonth
     c                   iter
     C                   endif
      *
      * more than one invoice per month - error
     c                   if        invcdt < dateexpected
     C                   Movel     DupMsg        errmsg
     C     *ISO          Move      Invcdt        USA_Date
     C                   exsr      ErrRtn
     c                   iter
     C                   endif

      *
      * missing invoice - error. add 1 month and do this logic again
      * without reading another invsum record
     c                   if        invcdt > dateexpected
     C                   Movel     mismsg        errmsg
     C     *ISO          Move      dateexpected  USA_Date
      * do not show this error past the account cancel date because
      * final invoices can have gaps in time
     c                   if        atrmdt = 0 or
     c                             atrmdt > dateexpected
     C                   Exsr      ErrRtn
     c                   end
     C                   exsr      #nextmonth
     c                   goto      #loop1
     c                   end



     C                   Endif
     C                   Enddo



      * Print the account-not-yet-invoiced error message for each month
      * 9/21/12 - remove check for active acct to show cancelled accts
      *           as long as the acct was active at least 1 month
      *
     C                   If        KEBFLAG   =   'N'         And
     C                             gbsbdt <> Atrmdt
     C*****                        Atrmdt = 0
     c                   move      gdtp1f        gdtp1
      *
     c                   movel     gdtp1         gdtp1f8
     c                   movel     gdtp1f8       gdtp1f6
     C                   movel     CYMD          CYM
     C                   movel     atrmdt        atrmdtym          6 0
     C                   Z-add     *Zero         LoopCtr           2 0

     C                   Dow       gdtp1f6  <    CYM       And
     C                             LoopCtr  <    30

      * stop showing msg at acct cancel date
     c                   if        atrmdtym <> 0 and gdtp1f6 >= atrmdtym
     c                   leave
     c                   end

     C                   Add       1             LoopCtr
     C                   Movel     NotMsg        errmsg
     C     *ISO          Move      gdtp1f8       USA_DATE
     C                   Exsr      ErrRtn
     C                   move      gdtp1f        Wwdate
     c     *ISO          move      Wwdate        Wddate1
     c     Wddate1       adddur    1:*m          gdtp1
     c                   move      gdtp1         gdtp1f
     c                   move      gdtp1         gdtp1f8
     c                   movel     gdtp1f8       gdtp1f6
     C                   EndDo

     C                   End

     C                   ENDSR
      * ? _____________________________________________________________
      *? *                                                             *
      *? *  Process and write errors to a report.                      *
      *? *_____________________________________________________________*
     C     ErrRtn        BEGSR

     C                   Move      'Y'           Errsw
     C                   Eval      ErrCtr = ErrCtr + 1
     C                   Move      Actrst        Ptrst
     C                   Move      Acsub#        Psub#
     C                   Move      Acacct        Pacct
     C                   Move      USA_Date      Peffdt            8 0
     C                   Move      Actrst        Ietrus
     C                   Move      Acsub#        Iesub
     C                   Move      Acacct        Ieacc

     C     *ISO          Move      acvtdt        USA_Date
     C                   Move      USA_Date      acvtdtmdy         8 0

     C     Ex_Key        Chain     Invexc
     C                   If        %Found(Invexc)
     C     *ISO          Move      Ieeff         USA_Date
     C                   Move      USA_Date      Pexcdt
     C                   Endif

     C     Atrmdt        Ifne      *zeros
     C     *ISO          Move      Atrmdt        USA_Date
     C                   Move      USA_Date      Pcandt
     C                   Endif

     C     *ISO          Move      begindt_wk    USA_Date
     C                   Move      USA_Date      Pgbsdt            8 0
     c     Peffdt        mult      10000.0001    Peffdtymd         8 0
100s C     Peffdtymd     Ifge      DOM_OH_ONE

      * check for exclusion, if not found then print error
     c     abr01exkey    chain     abr01ex
     c                   if        not %found(abr01ex)
     C                   exsr      writexldet
100s C                   End

100s C                   End
     C                   Move      *blanks       errmsg
     C                   Clear                   Pexcdt            8 0
     C                   Clear                   Pcandt            8 0

     C                   ENDSR
      * ? _____________________________________________________________
      *? *                                                             *
      *? *  Determine whether trust has been invoiced for the month.   *
      *? *                                                             *
      *? *  Retrieve the control file using the invoice year/month &   *
      *? *  trust.  If the trust has not yet been invoiced for the     *
      *? *  month, there shouldn't be an invoice (if there is, it's an *
      *? *  error).                                                    *
      *? *                                                             *
      *? *_____________________________________________________________*
     C     CtrlSr        BEGSR

     C                   Move      B             Ctype
     C                   Move      Inccyy        Kccyy
     C                   Move      Inmm          Kmm
     C                   Move      Intrst        Ktrst
     C     C_key         Chain     Contrl

     C                   ENDSR
      * ? _____________________________________________________________
      *? *                                                             *
      *? *        Calculate month following GBS begin admin date.      *
      *? *                                                             *
      *? *        A range of dates are required starting from the      *
      *? *        GBS begin admin date and ending with the date that   *
      *? *        was invoiced for the trust.                          *
      *? *_____________________________________________________________*
     C     CalgSr        BEGSR

     C                   move      gdtp1f        Wwdate
     c     *ISO          move      Wwdate        Wddate1
     c     Wddate1       adddur    1:*m          gdtp1
     c                   move      gdtp1         gdtp1f            8 0

     C                   ENDSR

      *****************************************************************
      * * Retrieve History record to determine if a transfer took     *
      * * place.  If so, use the transfer date and show a "T" on the  *
      * * report                                                      *
      *****************************************************************
     C     GetHis        BEGSR

     C                   Movel     *blanks       PT                1
     C                   Movel     tsa           Hkey
     C                   Move      'GTA'         key_trcode        3

     C     histaakey     Setll     histaa
     c                   dou       %eof(histaa)
     C     histaakey     Reade     histaa
     C                   if        not %eof(histaa)
     C                   eval      begindt_wk = Covtdt
     C                   movel     'T'           PT
     c                   leave
     C                   end
     c                   enddo

      * if no transfer then use begin admin date
     c                   if        pt = *blanks
     C                   Eval      begindt_wk = Gbsbdt
     C                   end

      * make seperate field that always has 1st of the month
     C                   move      begindt_wk    begindt01_wk
     C                   move      01            begindt01_wk      8 0

     C                   ENDSR

      *****************************************************************
      * determine next invoice date expected
      *****************************************************************
     c     #nextmonth    begsr
     c                   if        dateexpected <> 0 and
     c                             dateexpected < acvtdt
     c                   move      dateexpected  workdt
     c                   adddur    1:*m          workdt
     c                   move      workdt        dateexpected      8 0
     c                   else
      * no invoice expected after the covered through date
     c                   clear                   dateexpected
     c                   end
     C                   endsr

0313 C*
0164 C*************************************************************
0164 C*                                                           *
0164 C* Write Spreadsheet Detail                                  *
0164 C*                                                           *
0164 C*************************************************************
     C     Writexldet    BEGSR

     c                   clear                   abr010fld
     C                   Eval      abr010fld  = '"' +
     C                             %trim(%editw(PTSA:'0   -   -    '))  + csv +
     C                             %trim(acnam1)                        + csv +
     C                             %trim(pt)                            + csv +
     C                             %trim(%editw(pgbsdt:'  /  /    '))   + csv +
     C                             %trim(%editw(pcandt:'  /  /    '))   + csv +
     C                             %trim(%editw(acvtdtmdy:'  /  /    ')) + csv +
     C                             %Trim(errmsg)                        + csv +
     C                             %trim(%editw(peffdt:'  /  /    '))   + csv +
     C                             %trim(%editw(pexcdt:'  /  /    '))   + csv +
     C                             %trim(%editc(noempl:'Z'))            + csv +
     C                             %trim(%editc(apremi:'O':*cursym))    + csv +
     C                             ' '                                  + '" ,'
     C*
     C                   Write     abr010xr
0320 C                   ENDSR
     C*
     C/EJECT
     C*************************************************************
     C*                                                           *
     C* Write Spreadsheet heading                                 *
     C*                                                           *
     C*************************************************************
     C     Writexlhead   BEGSR

     c                   clear                   abr010fld
     C                   Eval      abr010fld = '"' + 'ACCOUNT #'    + csv +
     C                                              'ACCOUNT NAME'  + csv +
     C                                              'TRANSFER'      + csv +
     C                                              'BEGIN ADMIN'   + csv +
     C                                              'CANCELLED'     + csv +
     C                                              'INVOICE THROUGH' +csv +
     C                                              'ERROR'         + csv +
     C                                              'ERROR DATE'    + csv +
     C                                              'EXCLUSION'     + csv +
     C                                              'ACTIVE MEM'    + csv +
     C                                              'LAST INV AMT'  + csv +
     C                                              ' '              + '",'
     C                   Write     abr010xr
     C*
0320 C                   ENDSR
      *******************************************
      * ? _____________________________________________________________
      *? *                                                             *
      *? *        Initialize.                                          *
      *? *_____________________________________________________________*
     C     *INZSR        BEGSR

     C                   TIME                    TIME_DATE
     C     *MDY          MOVE      DATE          ISO_DATE2
     C                   MOVE      ISO_DATE2     CYMD
     C                   Move      'N'           Errsw             1
     C                   Movel     *blanks       PT

     C                   move      CYMD          Wwdate
     c     *ISO          move      Wwdate        Wddate1
     c     Wddate1       subdur    3:*y          cymd1
     c                   move      cymd1         cymd3y            8 0

100s c     Wddate1       subdur    2:*y          cymd1
     c                   move      cymd1         DScymd2           8 0
     c                   Move      00000001      DOM_OH_ONE        8 0
     c                   Movel     DScymd2       DOM6              6 0
     c                   Movel     DOM6          DOM_OH_ONE

     c     histaakey     Klist
     c                   Kfld                    Hkey
     c                   Kfld                    key_trcode

     C     tsakey        KLIST
     C                   KFLD                    actrst
     C                   KFLD                    acsub#
     C                   KFLD                    acacct

     C     C_KEY         KLIST
     C                   KFLD                    Ctype
     C                   KFLD                    Keyfli

     C     Ex_Key        KLIST
     C                   KFLD                    Ietrus
     C                   KFLD                    Iesub
     C                   KFLD                    Ieacc

     C     abr01exkey    KLIST
     C                   KFLD                    ptrst
     C                   KFLD                    psub#
     C                   KFLD                    pacct
     C                   KFLD                    peffdtymd

     C                   Exsr      Writexlhead
     C                   ENDSR
