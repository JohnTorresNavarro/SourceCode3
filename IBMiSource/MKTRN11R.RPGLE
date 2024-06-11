000100020621     H*Indent ('| ')
000200990630      *? ***************************************************************
000600020523      *
000700060829      *             GROUP BENIFIT SERVICES SOFTWARE           2006     *
000800060829      *                                                                *
000900000118      *  Written by:    S. Zien                                        *
001000061010      *  Date Written:  10/10/06                                       *
001100061010      *  Description:   Report market size over 50 for new/renewing.   *
001200000118      *                                                                *
001300000118      *                                                                *
001400000118      *                R E V I S I O N    H I S T O R Y                *
001500000118      *  Date                                                          *
001600000118      *  Revised   Initials    Revision                                *
001700000118      *  --------  --------    --------------------------------------  *
001701070111      *  01.11.07    szz       Add files for new columns.              *
001702080409      *  04.09.08    szz       Add spreadsheet file.                   *
001703080612      *  06.12.08    szz       Change to one month ahead per Shelly    *
001704170515      *  05/15/17    dlk       remove + from market size for compare   *
001705180125      *  01/25/18    dlk       fix date edit in csv                    *
001800060815      *                                                                *
002900020621      *                                                                *
003000990630      *? ***************************************************************
003001061010     FTRKRNWLP  IF   E           K Disk
003002070111     FACCMST    IF   E           K Disk
003003070111     FAC2MST    IF   E           K Disk
003004070111     FCMCT14    IF   E           K Disk
003005070111     FSMANRLT   IF   E           K Disk
003006070111     FSPRAGXR2  IF   E           K Disk
003007061010     FMKTRN10P  O    E             Disk
003008080409     FMKT11CSV  O  A E             Disk
024700010326
024701061017     D                UDS
024702061017     D LUSER                  25     32
024703061017
024704170515     D*NumA            S             12A   Inz('000000000000') Varying
024705080612    ?D CurMonth        S               D   Datfmt(*ISO)                         Input Request
024706080612     D NextM           S               D   datfmt(*ISO)
024707080612    ?D ISOToday        S               D   datfmt(*ISO)                         Input Request
071405060816      *
071406061010     C                   Read      TRKRNWLP
071412061010     C                   Dow       Not %Eof(TRKRNWLP)
071413170515     C                   clear                   NumMS             5 0
071414170515
071415170515      * Convert Alpha Market size field to numeric and remove plus (+) sign
071416170515          if TRMKTSIZE <> *blanks;
071417170515           monitor;
071418170515           NumMS  = %dec(%xlate('+' : ' ' : TRMKTSIZE) : 5 : 0);
071419170515           on-error;
071420170515            NumMS  = *zeros;
071421170515           endmon;
071423170515          else;
071424170515           NumMS  = *zeros;
071425170515          endif;
071427170515
071428170515     C**                 Eval      NumA       =  %Trim(TRMKTSIZE)
071429170515     C**                 Move      NumA          NumMS
071430170515
071431061017     C                   If        TRNONRN   <>  'XXX'
071432061017     C                   If        NumMS      >  50
071433061010     C                   Exsr      Process
071434061017     C                   End
071435061017     C                   End
071436170515
071437061010     C                   Read      TRKRNWLP
071438061010     C                   EndDo
071439170515
071440061010     C                   If        PRTCTR    =   *Zeros
071441061010     C                   Write     NOREC
071442061010     C                   End
071443061010     C                   Write     EOR
071501060817     C                   Eval      *InLR     =   *On
071600060815     C                   Return
080000010403
080001060817      *---------------------------------------------------------------*
080002061010     C     Process       Begsr
080003060817      *---------------------------------------------------------------*
080004061010     C     TRNRNDT       Mult      10000.0001    RenDate           8 0
080005061010     C                   Movel     RenDate       MM                2 0
080007080612     C                   If        MM         =  NextMonth
080008070111     C                   Exsr      Getfields
080009061017     C                   Eval      USERID     =  %Trim(LUSER)
080010061010     C                   Write     PRTDTL
080011061010     C                   Add       1             PrtCtr            5 0
080013080409
080014080409     C                   Eval      WKRECORD  =   '"' +
080015080409     C                              %Trim(%Editc(TRTRST:'P'))   + '","' +
080016080409     C                              %Trim(%Editc(TRSUB#:'P'))   + '","' +
080017080409     C                              %Trim(%Editc(TRACCT:'P'))   + '","' +
080020170515     C                                     %Trim(TRNAME)        + '","' +
080021080409     C                                           TRPLAN         + '","' +
080022080409     C                                           TRPCARR        + '","' +
080023170515     C                                     %Trim(TRMKTSIZE)     + '","' +
080026180125     C                              %Editw(RENDATE:'  /  /    ')  + '","' +
080027170515     C                                     %Trim(NR)            + '","' +
080028170515     C                                     %Trim(PARITY)        + '","' +
080029080409     C                                           SXSUPER        + '","' +
080030080409     C                                           SXAGCY         + '",'
080031080409     C                   Write     MKT11CSR
080032080409     C                   End
080033080409     C*
080094060817     C                   ENDSR
080095060817
080096070111      *---------------------------------------------------------------*
080097070111     C     GetFields     Begsr
080098070111      *---------------------------------------------------------------*
080099070111      * Parity
080100070111      *---
080101070111     C     Ac2Key        Chain     AC2MST
080102070111     C                   If        %Found(AC2MST)
080103070111     C                   Select
080104070111     C                   When      A2PAR  =   'Y'    Or
080105070111     C                             A2PAR  =   'N'
080106070111     C                   Eval      PARITY =   A2PAR
080107070111     C                   Other
080108070111     C                   Eval      PARITY =   %Trim('Blank')
080109070111     C                   EndSl
080110070111     C                   Else
080111070111     C                   Eval      PARITY =   %Trim('Blank')
080112070111     C                   End
080113070111      *---
080114070111      * New/Renewal
080115070111      *---
080116070111     C     AccKey        Chain     ACCMST
080117070111     C                   If        %Found(ACCMST)
080118070111     C                   Movel     GBSBDT        GBSbyr            4 0
080119070111     C                   If        GBSbyr   =    ThisYear
080120070111     C                   Eval      NR       =    'New'
080121070111     C                   Else
080122070111     C                   Eval      NR       =    'Renew'
080123070111     C                   End
080124070111     C                   Else
080125070111     C                   Eval      NR       =    *Blanks
080126070111     C                   End
080127070111      *---
080128070111      * Super Agency/Agency
080129070111      *---
080130070111     C     TSAPKey       Chain     CMCT14
080131070111     C                   If        %Found(CMCT14)
080132070111     C     CMRELID       Chain     SMANRLT
080133070111     C                   If        %Found(SMANRLT)
080134070111     C     SRASID        Chain     SPRAGXR2
080135070111     C                   If        Not %Found(SPRAGXR2)
080136070111     C                   Eval      SXSUPER  =    *Blanks
080137070111     C                   Eval      SXAGCY   =    *Blanks
080138070111     C                   End
080139070111     C                   End
080140070111     C                   Else
080141070111     C                   Eval      SXSUPER  =    %Trim('N/A')
080142070111     C                   End
080143070111      *
080144070111     C     TSAPKey       Klist
080145070111     C                   Kfld                    TRTRST
080146070111     C                   Kfld                    TRSUB#
080147070111     C                   Kfld                    TRACCT
080148070111     C                   Kfld                    TRPLAN
080149070111      *
080150070111     C     AccKey        Klist
080151070111     C                   Kfld                    TRTRST
080152070111     C                   Kfld                    TRSUB#
080153070111     C                   Kfld                    TRACCT
080154070111      *
080155070111     C     Ac2Key        Klist
080156070111     C                   Kfld                    F
080157070111     C                   Kfld                    TRTRST
080158070111     C                   Kfld                    TRSUB#
080159070111     C                   Kfld                    TRACCT
080160070111      *
080161070111    ?C                   Endsr
080162060817      *---------------------------------------------------------------*
080163060815     C     Klist         Begsr
080164060817      *---------------------------------------------------------------*
080426060829      *
080431060817     C                   Endsr
080432080409      * ? _____________________________________________________________
080433080409      *? *                                                             *
080434080409      *? *        Write Excel Spreadsheet Title to CSV File            *
080435080409      *? *_____________________________________________________________*
080436080409     C     WriteSpTitle  BEGSR
080437080409     C*
080438080409     C                   Eval      WKRECORD  =   '"' +   'Trust'  + '","' +
080439080409     C                                                    'Sub#'  + '","' +
080440080409     C                                                    'Acct'  + '","' +
080441080409     C                                                    'Name'  + '","' +
080442080409     C                                                    'Plan'   + '","' +
080443080409     C                                                  'Carrier'  + '","' +
080444080409     C                                              'Market Size'  + '","' +
080445080409     C                                             'Renewal Date'  + '","' +
080446080409     C                                                'New/Renew'  + '","' +
080447080409     C                                                   'Parity'  + '","' +
080448080409     C                                                    'Super'  + '","' +
080451080409     C                                                   'Agency'  + '",'
080452080409     C                   Write     MKT11CSR
080453080409     C*
0804540804090320 C                   ENDSR
080455060817
080456060817      *---------------------------------------------------------------*
080457060817     C     *INZSR        BEGSR
080458060817      *---------------------------------------------------------------*
080459070111     C                   Movel     'F'           F                 1
080460060817     C     *DATE         Mult      10000.0001    Today             8 0
080461070111     C                   Movel     Today         ThisYear          4 0
080462061010     C     Today         Mult      10000.0001    TodayFmt          8 0
080463061010     C                   Movel     TodayFmt      TodayM            2 0
080464080612     C     *ISO          Move      Today         ISOToday
080465080612     C     ISOToday      Adddur    1:*m          NextM
080467080612     C                   Extrct    NextM:*m      NextMonth         2 0
080468061010     C                   Select
080469080612     C                   When      NextMonth =   1
080470061010     C                   Eval      RMNAME   =    %Trim('January')
080471080612     C                   When      NextMonth =   2
080472061010     C                   Eval      RMNAME   =    %Trim('February')
080473080612     C                   When      NextMonth =   3
080474061010     C                   Eval      RMNAME   =    %Trim('March')
080475080612     C                   When      NextMonth =   4
080476061010     C                   Eval      RMNAME   =    %Trim('April')
080477080612     C                   When      NextMonth =   5
080478061010     C                   Eval      RMNAME   =    %Trim('May')
080479080612     C                   When      NextMonth =   6
080480061010     C                   Eval      RMNAME   =    %Trim('June')
080481080612     C                   When      NextMonth =   7
080482061010     C                   Eval      RMNAME   =    %Trim('July')
080483080612     C                   When      NextMonth =   8
080484061010     C                   Eval      RMNAME   =    %Trim('August')
080485080612     C                   When      NextMonth =   9
080486061010     C                   Eval      RMNAME   =    %Trim('September')
080487080612     C                   When      NextMonth =   10
080488061010     C                   Eval      RMNAME   =    %Trim('October')
080489080612     C                   When      NextMonth =   11
080490061010     C                   Eval      RMNAME   =    %Trim('November')
080491080612     C                   When      NextMonth =   12
080492061010     C                   Eval      RMNAME   =    %Trim('December')
080493061010     C                   EndSl
080494061010     C                   Write     PRTHDR
080495080409     C                   Exsr      WriteSpTitle
080496060817     C                   ENDSR
080500010412
081900010403     C/EJECT
