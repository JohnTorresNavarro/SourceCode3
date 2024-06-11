000100020621     H*Indent ('| ')
000200990630      *? ***************************************************************
000600020523      *
000700060829      *             GROUP BENIFIT SERVICES SOFTWARE           2006     *
000800060829      *                                                                *
000900000118      *  Written by:    S. Zien                                        *
001000061012      *  Date Written:  10/12/06                                       *
001100061012      *  Description:   Report market size/number w/med cov discrepancy*
001101061012      *  Called by:     MKTTRN20C                                      *
001200000118      *                                                                *
001300000118      *                                                                *
001400000118      *                R E V I S I O N    H I S T O R Y                *
001500000118      *  Date                                                          *
001600000118      *  Revised   Initials    Revision                                *
001601061016      *  ________  ________    ______________________________________  *
001602061016      *  10/16/06     szz      Remove Med Chi Assoc. trust 559, 560,   *
001603061016      *                         561 & 562 per Cindy W.                 *
001800060815      *                                                                *
001801070213      *  02.13.07    szz       Add Parity field.                       *
001802070213      *                        Exclude accounts from report if they    *
001803070213      *                        appear in the Excludes file.            *
002900020621      *                                                                *
003000990630      *? ***************************************************************
003001061010     FTRKRNWLP  IF   E           K Disk
003002061012     FACCMST    IF   E           K Disk
003003070213     FAC2MST    IF   E           K Disk
003004070213     FMKTRNE    IF   E           K Disk
003005061012     FMKTRN20P  O    E             Disk
024700010326
024702061012     D NumA            S             12A   Inz('000000000000') Varying
024703070213     D FI              S              1A   Inz('F')
071405060816      *
071406061010     C                   Read      TRKRNWLP
071407061010     C                   Dow       Not %Eof(TRKRNWLP)
071408061010     C                   If        TRNONRN   <>  'XXX'
071409061016     C                   If        TRTRST    <>  559   And
071410061016     C                             TRTRST    <>  560   And
071411061016     C                             TRTRST    <>  561   And
071412061016     C                             TRTRST    <>  562
071413061010     C                   Exsr      Process
071414061010     C                   End
071415061016     C                   End
071416061010     C                   Read      TRKRNWLP
071417061010     C                   EndDo
071418061010     C                   If        PRTCTR    =   *Zeros
071419061010     C                   Write     NOREC
071420061010     C                   End
071421061010     C                   Write     EOR
071501060817     C                   Eval      *InLR     =   *On
071600060815     C                   Return
080000010403
080001060817      *---------------------------------------------------------------*
080002061010     C     Process       Begsr
080003060817      *---------------------------------------------------------------*
080004070213     C     AKey          Chain     MKTRNE
080005070213     C                   If        (%Found(MKTRNE)      And
080006070213     C                             MEEEDT     <= Today)  Or
080007070213     C                             Not %Found(MKTRNE)
080008061010     C     TRNRNDT       Mult      10000.0001    RenDate           8 0
080009061010     C                   Movel     RenDate       MM                2 0
080010061012     C     Akey          Chain     ACCMST
080011061012     C                   Z-add     *Zeros        NumMS             5 0
080012061012     C                   Eval      NumA       =  %Trim(TRMKTSIZE)
080013061012     C                   Move      NumA          NumMS
080014061012     C                   Select
080015061012     C                   When      NumMS      =  50    And
080016061012     C                             MEDEMP     >  50
080017070213     C                   Exsr      GetParity
080018061012     C                   Write     PRTDTL
080019061012     C                   Add       1             PrtCtr            5 0
080020061012     C                   When      NumMS      >  50    And
080021061012     C                             MEDEMP     <  50
080022070213     C                   Exsr      GetParity
080023061012     C                   Write     PRTDTL
080024061012     C                   Add       1             PrtCtr            5 0
080025061012     C                   When      NumMS      =  200   And
080026061012     C                             MEDEMP     >  200
080027070213     C                   Exsr      GetParity
080028061012     C                   Write     PRTDTL
080029061012     C                   Add       1             PrtCtr
080030061012     C                   When      NumMS      >  200   And
080031061012     C                             MEDEMP     <  200
080032070213     C                   Exsr      GetParity
080033061012     C                   Write     PRTDTL
080034061012     C                   Add       1             PrtCtr
080035061012     C                   EndSl
080036070213      *
080037070213     C                   End
080038070213      *
080094060817     C                   ENDSR
080095060817
080096070213      *---------------------------------------------------------------*
080097070213     C     GetParity     Begsr
080098070213      *---------------------------------------------------------------*
080101070213     C     A2Key         Chain     AC2MST
080102070213     C                   If        %Found(AC2MST)
080103070213     C                   Select
080104070213     C                   When      A2PAR  =   'Y'    Or
080105070213     C                             A2PAR  =   'N'
080106070213     C                   Eval      PARITY =   A2PAR
080107070213     C                   Other
080108070213     C                   Eval      PARITY =   %Trim('Blank')
080109070213     C                   EndSl
080110070213     C                   Else
080111070213     C                   Eval      PARITY =   %Trim('Blank')
080112070213     C                   End
080113070213      *
080114070213     C                   EndSr
080115060817      *---------------------------------------------------------------*
080116060815     C     Klist         Begsr
080117060817      *---------------------------------------------------------------*
080426060829      *
080427061012    ?C     AKey          Klist
080428061012    ?C                   Kfld                    TRTRST
080429061012    ?C                   Kfld                    TRSUB#
080430061012    ?C                   Kfld                    TRACCT
080431070213      *
080432070213    ?C     A2Key         Klist
080433070213     C                   Kfld                    FI
080434070213    ?C                   Kfld                    TRTRST
080435070213    ?C                   Kfld                    TRSUB#
080436070213    ?C                   Kfld                    TRACCT
080437060817     C                   Endsr
080438060817
080439061016    ? *___________________________________________________________________
080440061016    ? * Parameter list
080441061016    ? *___________________________________________________________________
080442061016    ?C     PLIST         Begsr
080443061016    ?C     *ENTRY        Plist
080444061016    ?C                   Parm                    UserID           10
080445061016    ?C                   Endsr
080446060817      *---------------------------------------------------------------*
080447060817     C     *INZSR        BEGSR
080448060817      *---------------------------------------------------------------*
080449060817     C     *DATE         Mult      10000.0001    Today             8 0
080450061010     C     Today         Mult      10000.0001    TodayFmt          8 0
080451061010     C                   Movel     TodayFmt      TodayM            2 0
080452061010     C                   Select
080453061010     C                   When      TodayM   =    1
080454061010     C                   Eval      RMNAME   =    %Trim('January')
080455061010     C                   When      TodayM   =    2
080456061010     C                   Eval      RMNAME   =    %Trim('February')
080457061010     C                   When      TodayM   =    3
080458061010     C                   Eval      RMNAME   =    %Trim('March')
080459061010     C                   When      TodayM   =    4
080460061010     C                   Eval      RMNAME   =    %Trim('April')
080461061010     C                   When      TodayM   =    5
080462061010     C                   Eval      RMNAME   =    %Trim('May')
080463061010     C                   When      TodayM   =    6
080464061010     C                   Eval      RMNAME   =    %Trim('June')
080465061010     C                   When      TodayM   =    7
080466061010     C                   Eval      RMNAME   =    %Trim('July')
080467061010     C                   When      TodayM   =    8
080468061010     C                   Eval      RMNAME   =    %Trim('August')
080469061010     C                   When      TodayM   =    9
080470061010     C                   Eval      RMNAME   =    %Trim('September')
080471061010     C                   When      TodayM   =    10
080472061010     C                   Eval      RMNAME   =    %Trim('October')
080473061010     C                   When      TodayM   =    11
080474061010     C                   Eval      RMNAME   =    %Trim('November')
080475061010     C                   When      TodayM   =    12
080476061010     C                   Eval      RMNAME   =    %Trim('December')
080477061010     C                   EndSl
080478061010     C                   Write     PRTHDR
080479060817     C                   ENDSR
080500010412
081900010403     C/EJECT
