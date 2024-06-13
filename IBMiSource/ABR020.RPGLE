     H Indent ('| ')
      *? ***************************************************************
      *             GROUP BENIFIT SERVICES SOFTWARE           2000     *
      *                                                                *
      *  Written by:    S. Zien                                        *
      *  Date Written:  11/17/00                                       *
      *  Description:   Cobra Invoice History Audit                    *
      *                                                                *
      *                                                                *
      *                R E V I S I O N    H I S T O R Y                *
      *  Date                                                          *
      *  Revised   Initials    Revision                                *
      *  --------  --------    --------------------------------------  *
      * 06/18/01 dlk - change search prior to begin date to 3 months   *
      *                and supress print of missing invoices prior     *
      *                to 1/1999 because of hist pruge.                *
      *                                                                *
      * 07/10/01 szz - Modify termination-date condition in order to   *
      *    001s        determine whether active account is in error.   *
      *                                                                *
      * 07/14/04 dlk - skip "inv b/f begin admin" errors b/f 01/02     *
      *                                                                *
      *  4/29/13 szz - Do not show any errors prior to two             *
      *                  years ago and add csv output per Dave K.      *
      * 06/03/15 dlk - skip chesapeake spice account 590-8-4 since it  *
      *                is not a real FI acct (SF acct only)            *
      * 06/13/24 jt  - Compare with iProject                           *
      *                                                                *
      *? ***************************************************************

     FMember    IF   E           K disk
     FHist      IF   E           K disk
     FHistAA    IF   E           K disk    Prefix(A_) Rename(Histr:A_fmt)
     FContrl    IF   E           K disk
     fAbr020p   O    E             Printer Oflind(*in91)
     FABR020XL  o  a e             DISK

     D                UDS
     D  CONAME               201    250
    ? * Program status data structure
    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
     D                 DS

     DDSindt           DS
     D  dsccyymm                      6  0
     D  dsdd                          2  0
     DDScovtdt         S              6  0 Inz(*Zeros)
     DDSgbscd1         S              6  0 Inz(*Zeros)
     DDSgbscdt         S              6  0 Inz(*zeros)
     D                 DS
     D ptsa                    1     10  0
     D  ptrst                  1      3  0
     D  psub#                  4      6  0
     D  pacct                  7     10  0
     D                 DS
     D MB_TSA                  1     10  0
     D  MBTRST                 1      3  0
     D  MBSUB#                 4      6  0
     D  MBACCT                 7     10  0
     D                 DS
     D TIME_DATE                     12  0
     D  TIME                          6  0 OVERLAY(TIME_DATE)
     D  DATE                          6  0 OVERLAY(TIME_DATE:7)
     D                 DS
     DKeyflI                         14
     D  kccyymm                       6    Overlay(KeyflI)
     D  ktrst                         3    Overlay(KeyflI:7)
     D                 DS
     D MBSSNO                              INZ(*ZEROS)
     D  Nsno1_DS                      3    OVERLAY(MBSSNO)
     D  Nsno2_DS                      2    OVERLAY(MBSSNO:4)
     D  Nsno3_DS                      4    OVERLAY(MBSSNO:6)
     D                 DS
     D Assno                         10    INZ('          ')
     D  Asno1_DS                      3    OVERLAY(Assno:2)
     D  Asno2_DS                      2    OVERLAY(Assno:5)
     D  Asno3_DS                      4    OVERLAY(Assno:7)
     D                 DS
     D Ck#not                              INZ(*blanks)
     D  BMBinv                        6    OVERLAY(Ck#not:7)
     D                 DS
     D A_Note2                             INZ(*blanks)
     D  AVIinv                        6    OVERLAY(A_Note2:7)
     D                 DS
     D Dsen1h                         8  0 Inz(*Zeros)
     D  DS1yymm                       6  0 OVERLAY(Dsen1h)
     D DSEN2           S              8  0
     D AVI             S              3    Inz('AVI')
     D B               S              1    Inz('B')
     D DSEN1           S               D   Datfmt(*ISO)
     D USA_Date        S               D   Datfmt(*USA)
     D ISO_DATE2       S               D   Datfmt(*ISO)
     D Gbsc1           S               D   Datfmt(*ISO)
     D cymd1           S               D   Datfmt(*ISO)
    ?D Wddate1         S               D   Datfmt(*ISO)
     D Gdtp1           S               D   Datfmt(*ISO)
    ?D Wwdate          S              8  0
    ?D DsenwN          S              8  0
     D CYMD            S              8  0
     D covhdt          S              8  0
     Dcsv              c                   const('","')
    ?D InsMsg          C                   'Invoice Missing'
    ?D MisMsg          C                   'Missing Before Last Invoice Date'
    ?D DupMsg          C                   'Duplicate Invoice'
    ?D PriMsg          C                   'Prior to Begin Date'
    ?D TerMsg          C                   'Invoice Missing Before Term Date'
      *--
      *? Main.
      *---
     c                   Read      Member
    ?C                   Dou       %EOF(member)

     C                   If        NOT %EOF(member)

      * skip chesapeake spice account
     c                   if        mb_tsa = 5900080004
     c                   read      member
     c                   iter
     c                   end

     C                   if        gbscdt <> *zeros
     C                   Move      'N'           ProcSw            1
     C                   If        (Mbcand = 0) or
     C                             (Mbcand <> 0 and cymd3y <= gbscdt)
     C                   Move      'Y'           ProcSw
     C                   Endif
      *---
      *?Hold Cobra GBS begin date for incrementation to see all invoice months.
      *---
     C     ProcSw        Ifeq      'Y'
     C                   Move      Gbscdt        gbscd1            8 0
     c                   exsr      process
     c                   endif
     c                   Endif

     c                   read      member
     c                   endif
    ?C                   Enddo

     c     Errsw         ifeq      'N'
     C                   Write     Hdr
     C                   Write     NOE
     C                   Endif
     C                   Write     EOR
     C                   EVAL      *INLR = *ON
      * ? _____________________________________________________________
      *? *                                                             *
      *? *        Check each invoice record in HIST.                   *
      *? *_____________________________________________________________*
     C     process       BEGSR
      *---
      *?Initialize invoice hold date; use to compare previous for duplicates.
      *---
     C                   Z-add     *zeros        covhdt
      *---
      *?Determine last date invoiced; place results in DSEN2.
      *---
     C                   Exsr      Contsr

     C                   Move      Nsno1_DS      Asno1_DS
     C                   Move      Nsno2_DS      Asno2_DS
     C                   Move      Nsno3_DS      Asno3_DS
     C                   Move      Assno         Hkey
     C     H_key         Setll     Hist
     C                   DOU       Not %Found(Hist)
     C     H_key         Reade     Hist
     C                   If        %EOF(Hist)
     C                   Leave
     C                   Endif
     C                   If        %Found(Hist)
     C     Trcode        Ifeq      'BMB'

      *---
      *?If there are any voids for the invoice#, bypass the invoice.
      *---
     C                   Move      Hkey          A_Hkey
     C     HA_Key        Setll     Histaa
    ?C                   Dou       %EOF(Histaa)
     C     HA_Key        Reade     Histaa
     C                   If        %Found(Histaa)
     C     BMBinv        Ifeq      AVIinv
     C                   Goto      ELoop
     C                   Endif
     C                   Endif
     C                   Enddo
      *---
      *?Compare covered-thru date to previous record in case of a duplicate.
      *---
     C     Covtdt        Ifeq      covhdt
     C                   Movel     DupMsg        Percon
     C     *ISO          Move      Covtdt        USA_Date
     C                   Exsr      ErrRtn
     C                   Endif

     C                   Z-add     Covtdt        covhdt

      *---
      *?Compare year/month to determine if prior to invoice month.
      *---
     C                   Move      Covtdt        DSindt
     C                   Move      DSccyymm      DScovtdt
     C                   Move      Gbscdt        DSindt
     C                   Move      DSccyymm      DSgbscdt
     C                   Move      Gbscd1        DSindt
     C                   Move      DSccyymm      DSgbscd1
     C     DScovtdt      Iflt      DSgbscd1
     C     DScovtdt      Iflt      DSgbscdt
      *---
      *?If less than three months prior to begindate, write to error report.
      *---
     C                   move      Gbscdt        Wwdate
     c     *ISO          move      Wwdate        Wddate1
     c     Wddate1       subdur    3:*m          gdtp1
     c                   move      gdtp1         gdtp1f            8 0

      * skip errors < 1/1/02
     c                   if        covtdt > gdtp1f and
     c                             covtdt >= 20020101
     C                   Movel     PriMsg        Percon
     C     *ISO          Move      Covtdt        USA_Date
     C                   Exsr      ErrRtn
     C                   Goto      Eloop
     C                   Endif
     C                   Endif
     C                   Endif

      *
     C     Bypass        Tag
     C     Covtdt        Ifgt      Gbscd1
      *---
      *?If the missing invoice date is less than the term date, it's an error.
     c*  ** only print errors after 1/1999 since the history file was
     c*     purged up to 1/1999
      *---
     C     Gbscd1        Iflt      Termdt
001s C     Termdt        oreq      *Zero

     c                   if        gbscd1 > 19990131
     C                   Movel     InsMsg        Percon
     C     *ISO          Move      Gbscd1        USA_Date
     C                   Exsr      ErrRtn
     c                   end

1211 C                   Exsr      Calgsr
1211 C                   Goto      Bypass
     C                   Endif
     C                   Endif

1211 C     Covtdt        Ifle      Gbscd1
     C                   Exsr      Calgsr
1211 C                   Endif

     C                   Endif
     C                   Endif
     C     Eloop         Tag
     C                   Enddo

     C     Covtdt        Iflt      DSEN2
     C     Covtdt        Iflt      Cexpdt
     C     Gbscd1        Iflt      Termdt
     C                   Movel     MisMsg        Percon
     C     *ISO          Move      Gbscd1        USA_Date
     C                   Exsr      Errrtn
     C                   Endif
     C                   Endif
     C     Mbcand        Ifne      *zeros
     C     Covtdt        Iflt      Termdt
     C                   Movel     TerMsg        Percon
     C     *ISO          Move      Gbscd1        USA_Date
     C                   Exsr      ErrRtn
     C                   Endif
     C                   Endif

     C                   Endif
     C                   ENDSR
      * ? _____________________________________________________________
      *? *                                                             *
      *? *  Process and write errors to a report.                      *
      *? *_____________________________________________________________*
     C     ErrRtn        BEGSR

     C                   Move      'Y'           Errsw
     C                   Move      Mbtrst        Ptrst
     C                   Move      Mbsub#        Psub#
     C                   Move      Mbacct        Pacct
     C                   Move      Mbssno        Pmbr
     C     Mfname        CAT(P)    Mlname:1      Pacnam
     C                   Move      USA_Date      Peffdt

     C     Termdt        Ifne      *zeros
     C     *ISO          Move      Termdt        USA_Date
     C                   Move      USA_Date      Pcandt
     C                   Endif

     c     *in91         ifeq      *on
     C                   Write     Hdr
     C                   Write     Sub
     c                   move      *off          *in91
     c                   endif
     C     *ISO          Move      Gbscdt        USA_Date
     C                   Move      USA_Date      Pgbsdt
     c     Peffdt        mult      10000.0001    Peffdtymd         8 0
     C     Peffdtymd     Ifge      DOM_OH_ONE
     C                   Write     Dtl
     C                   exsr      writexldet
     C                   End
     C                   Move      *blanks       Percon
     C                   Clear                   Pexcdt
     C                   Clear                   Pcandt

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

     C                   move      gbscd1        Wwdate
     c     *ISO          move      Wwdate        Wddate1
     c     Wddate1       adddur    1:*m          gbsc1
     c                   move      gbsc1         gbscd1

     C                   ENDSR
      * ? _____________________________________________________________
      *? *                                                             *
      *? * Determine last date invoice & place results in DSEND2       *
      *? *_____________________________________________________________*
     C     ContSR        BEGSR

     C                   Move      B             Ctype
     C                   Move      Gbscd1        DSEN1
     C     Cloop         Tag
     C                   Move      DSEN1         Dsen1h
     C                   Move      Ds1yymm       Kccyymm
     C                   Move      Mbtrst        Ktrst
     C     C_key         Chain     Contrl
     C                   If        %Found(Contrl)
     C     Ciflg         Ifeq      'Y'
     C                   Move      DSEN1         DSEN2
      *---
      *?   Add 1 month to the CONTRL key to find last date invoiced.   *
      *---
     C                   Move      DSEN1         Wwdate
     C     *ISO          Move      Wwdate        Wddate1
     C     Wddate1       Adddur    1:*m          gbsc1
     C                   Move      gbsc1         DSEN1

     C                   Goto      Cloop
     C                   Endif
     C                   Endif

     C                   ENDSR
     C
     C*
     C*************************************************************
     C*                                                           *
     C* Write Spreadsheet Detail                                  *
     C*                                                           *
     C*************************************************************
     C     Writexldet    BegSr

     c                   Clear                   ABR020FLD
     C                   Eval      ABR020FLD  = '"' +
     C                             %Trim(%Editw(MBSSNO:'0   -  -    ')) + csv +
     C                             %Trim(%Editw(PTSA:'0   -   -    '))  + csv +
     C                             %Trim(pacnam)                        + csv +
     C                             %Trim(%Editw(pgbsdt:'  /  /    '))   + csv +
     C                             %Trim(percon)                        + csv +
     C                             %Trim(%Editw(peffdt:'  /  /    '))   + csv +
     C                             %Trim(%Editw(pcandt:'  /  /    '))   + '" ,'
     C*
     C                   Write     ABR020XR
     C                   EndSr
     C*
     C/EJECT
     C*************************************************************
     C*                                                           *
     C* Write Spreadsheet heading                                 *
     C*                                                           *
     C*************************************************************
     C     Writexlhead   BEGSR

     c                   Clear                   ABR020FLD
     C                   Eval      ABR020FLD = '"' + 'MEMBER     '  + csv +
     C                                              'ACCOUNT #   '  + csv +
     C                                              'MEMBER NAME '  + csv +
     C                                              'BEGIN ADMIN'   + csv +
     C                                              'ERROR'         + csv +
     C                                              'EFFECTIVE'     + csv +
     C                                              'CANCELLED'      + '",'
     C                   Write     ABR020XR
     C*
     C                   ENDSR
      * ? _____________________________________________________________
      *? *                                                             *
      *? *        Initialize.                                          *
      *? *_____________________________________________________________*
     C     *INZSR        BEGSR

     C                   TIME                    TIME_DATE
     C     *MDY          MOVE      DATE          ISO_DATE2
     C                   MOVE      ISO_DATE2     CYMD
     C                   Move      'N'           Errsw             1

     C                   move      CYMD          Wwdate
     c     *ISO          move      Wwdate        Wddate1
     c     Wddate1       subdur    3:*y          cymd1
     c                   move      cymd1         cymd3y            8 0

     c     Wddate1       subdur    2:*y          cymd1
     c                   move      cymd1         DScymd2           8 0
     c                   Move      00000001      DOM_OH_ONE        8 0
     c                   Movel     DScymd2       DOM6              6 0
     c                   Movel     DOM6          DOM_OH_ONE


     C     H_KEY         KLIST
     C                   KFLD                    Hkey

     C     HA_KEY        KLIST
     C                   KFLD                    A_Hkey
     C                   KFLD                    AVI

     C     C_KEY         KLIST
     C                   KFLD                    Ctype
     C                   KFLD                    Keyfli

     C                   Move      *On           *In91

     C                   Exsr      Writexlhead
     C                   ENDSR
