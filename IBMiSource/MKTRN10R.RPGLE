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
001800070111      *  01.11.07    szz       Add files for new columns.              *
002900020621      *                                                                *
003000990630      *? ***************************************************************
003001061010     FTRKRNWLP  IF   E           K Disk
003002070111     FACCMST    IF   E           K Disk
003003070111     FAC2MST    IF   E           K Disk
003004070111     FCMCT14    IF   E           K Disk
003005070111     FSMANRLT   IF   E           K Disk
003006070111     FSPRAGXR2  IF   E           K Disk
003007061010     FMKTRN10P  O    E             Disk
024700010326
024701061017     D NumA            S             12A   Inz('000000000000') Varying
071405060816      *
071406061010     C                   Read      TRKRNWLP
071412061010     C                   Dow       Not %Eof(TRKRNWLP)
071413061017     C                   Z-add     *Zeros        NumMS             5 0
071414061017     C                   Eval      NumA       =  %Trim(TRMKTSIZE)
071415061017     C                   Move      NumA          NumMS
071418061017     C                   If        TRNONRN   <>  'XXX'
071419061017     C                   If        NumMS      >  50
071420061010     C                   Exsr      Process
071421061017     C                   End
071422061017     C                   End
071423061010     C                   Read      TRKRNWLP
071424061010     C                   EndDo
071425061010     C                   If        PRTCTR    =   *Zeros
071426061010     C                   Write     NOREC
071427061010     C                   End
071428061010     C                   Write     EOR
071501060817     C                   Eval      *InLR     =   *On
071600060815     C                   Return
080000010403
080001060817      *---------------------------------------------------------------*
080002061010     C     Process       Begsr
080003060817      *---------------------------------------------------------------*
080004061010     C     TRNRNDT       Mult      10000.0001    RenDate           8 0
080005061010     C                   Movel     RenDate       MM                2 0
080007061010     C                   If        MM         =  TodayM
080008070111     C                   Exsr      Getfields
080009061010     C                   Write     PRTDTL
080010061010     C                   Add       1             PrtCtr            5 0
080011061010     C                   End
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
080144070111    ?C                   Endsr
080145061016    ? *___________________________________________________________________
080146061016    ? * Parameter list
080147061016    ? *___________________________________________________________________
080148061016    ?C     PLIST         Begsr
080149061016    ?C     *ENTRY        Plist
080150061016    ?C                   Parm                    UserID           10
080151061016    ?C                   Endsr
080152060817      *---------------------------------------------------------------*
080153060815     C     Klist         Begsr
080154060817      *---------------------------------------------------------------*
080426060829      *
080427070111     C     TSAPKey       Klist
080428070111     C                   Kfld                    TRTRST
080429070111     C                   Kfld                    TRSUB#
080430070111     C                   Kfld                    TRACCT
080431070111     C                   Kfld                    TRPLAN
080432070111      *
080433070111     C     AccKey        Klist
080434070111     C                   Kfld                    TRTRST
080435070111     C                   Kfld                    TRSUB#
080436070111     C                   Kfld                    TRACCT
080437070111      *
080438070111     C     Ac2Key        Klist
080439070111     C                   Kfld                    F
080440070111     C                   Kfld                    TRTRST
080441070111     C                   Kfld                    TRSUB#
080442070111     C                   Kfld                    TRACCT
080443060817     C                   Endsr
080444060817
080445060817      *---------------------------------------------------------------*
080446060817     C     *INZSR        BEGSR
080447060817      *---------------------------------------------------------------*
080448070111     C                   Movel     'F'           F                 1
080449060817     C     *DATE         Mult      10000.0001    Today             8 0
080450070111     C                   Movel     Today         ThisYear          4 0
080451061010     C     Today         Mult      10000.0001    TodayFmt          8 0
080452061010     C                   Movel     TodayFmt      TodayM            2 0
080453061010     C                   Select
080454061010     C                   When      TodayM   =    1
080455061010     C                   Eval      RMNAME   =    %Trim('January')
080456061010     C                   When      TodayM   =    2
080457061010     C                   Eval      RMNAME   =    %Trim('February')
080458061010     C                   When      TodayM   =    3
080459061010     C                   Eval      RMNAME   =    %Trim('March')
080460061010     C                   When      TodayM   =    4
080461061010     C                   Eval      RMNAME   =    %Trim('April')
080462061010     C                   When      TodayM   =    5
080463061010     C                   Eval      RMNAME   =    %Trim('May')
080464061010     C                   When      TodayM   =    6
080465061010     C                   Eval      RMNAME   =    %Trim('June')
080466061010     C                   When      TodayM   =    7
080467061010     C                   Eval      RMNAME   =    %Trim('July')
080468061010     C                   When      TodayM   =    8
080469061010     C                   Eval      RMNAME   =    %Trim('August')
080470061010     C                   When      TodayM   =    9
080471061010     C                   Eval      RMNAME   =    %Trim('September')
080472061010     C                   When      TodayM   =    10
080473061010     C                   Eval      RMNAME   =    %Trim('October')
080474061010     C                   When      TodayM   =    11
080475061010     C                   Eval      RMNAME   =    %Trim('November')
080476061010     C                   When      TodayM   =    12
080477061010     C                   Eval      RMNAME   =    %Trim('December')
080478061010     C                   EndSl
080479061010     C                   Write     PRTHDR
080480060817     C                   ENDSR
080500010412
081900010403     C/EJECT
