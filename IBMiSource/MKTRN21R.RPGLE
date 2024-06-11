000100020621     H*Indent ('| ')
000200990630      *? ***************************************************************
000600020523      *
000700060829      *             GROUP BENIFIT SERVICES SOFTWARE           2006     *
000800060829      *                                                                *
000900000118      *  Written by:    S. Zien                                        *
001000061012      *  Date Written:  10/12/06                                       *
001100061012      *  Description:   Report market size/number w/med cov discrepancy*
001101080912      *  Called by:     MKTTRN21C                                      *
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
001804080409      *  04.09.08    szz       Add spreadsheet file.                   *
002900020621      *                                                                *
002901080912      *  09.12.08    szz       Use the Carrier Market Size Master to   *
002902080912      *                        determine whether the number of medical *
002903080912      *                        employees falls within the from-size/   *
002904080912      *                        to-size range.                          *
002905080912      *                        Per Cindy W. drop off report if parity  *
002906080912      *                        is Yes AND Marketsize is 50 AND MEDEMP  *
002907080912      *                        less than 200.                          *
002908081106      *  11.06.08    szz       Per Dave K, Carol has requested that the*
002909081106      *                        range be added to the report & email.   *
002911080912      *                                                                *
003000990630      *? ***************************************************************
003001061010     FTRKRNWLP  IF   E           K Disk
003002061012     FACCMST    IF   E           K Disk
003003070213     FAC2MST    IF   E           K Disk
003004070213     FMKTRNE    IF   E           K Disk
003005080912     FCARMKSZ1  IF   E           K Disk
003007081008     FCODES     IF   E           K Disk
003008080912     FMKTRN20P  O    E             Printer Oflind(*In91)
003009080409     FMKT21CSV  O  A E             Disk
024701061017     D                UDS
024702061017
024703061017     D LUSER                  25     32
024706070213     D FI              S              1A   Inz('F')
024707081008     D PlanCategoryCd  S              1A   Inz('P')
071405060816      *
071406061010     C                   Read      TRKRNWLP
071407061010     C                   Dow       Not %Eof(TRKRNWLP)
071408061010     C                   If        TRNONRN   <>  'XXX'
071409061016     C                   If        TRTRST    <>  559   And
071410061016     C                             TRTRST    <>  560   And
071411061016     C                             TRTRST    <>  561   And
071412061016     C                             TRTRST    <>  562
071413081008     C     CKey          Chain     CODES
071414081008     C                   If        %Found(CODES)       And
071415081008     C                             ACTION    =   'M'
071416061010     C                   Exsr      Process
071417081008     C                   End
071418061010     C                   End
071419061016     C                   End
071420061010     C                   Read      TRKRNWLP
071421061010     C                   EndDo
071422061010     C                   If        PRTCTR    =   *Zeros
071423061010     C                   Write     NOREC
071424061010     C                   End
071425061010     C                   Write     EOR
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
080008080912     C     TRNRNDT       Mult      10000.0001    RenDate           8 0
080010061012     C     Akey          Chain     ACCMST
080014080912      *---
080015080912      * Determine whether MEDEMP falls within range
080016080912      *---
080017080912     C                   Exsr      DetRange
080042070213      *
080043070213     C                   End
080044070213      *
080094060817     C                   ENDSR
080095080912      *---------------------------------------------------------------*
080096080912     C     DetRange      Begsr
080097080912      *---------------------------------------------------------------*
080098080912      *
080100080912     C     TRPCARR       Setll     CARMKSZ1
080101080912    1C                   DOU       %Eof(CARMKSZ1)
080102080912     C     TRPCARR       Reade     CARMKSZ1
080104080912     C                   If        TRMKTSIZE  =  CZSZCD
080105080912     C                   If        MEDEMP     <  CZFRSZ  OR
080106080912     C                             MEDEMP     >  CZTOSZ
080107080912     C                   Exsr      GetParity
080108080912     C                   Select
080109080912     C                   When      PARITY     =  'N'     OR
080110080912     C                             PARITY     =  'Blank'
080111080912     C                   Exsr      PrintDetail
080112080912     C                   Add       1             PrtCtr            5 0
080113080912     C                   Leave
080114080912     C                   When      PARITY     =  'YES'   AND
080115080912     C                             TRMKTSIZE  <> '50   '
080116080912     C                   Exsr      PrintDetail
080117080912     C                   Add       1             PrtCtr            5 0
080118080912     C                   Leave
080119080912     C                   When      PARITY     =  'YES'   AND
080120080912     C                             TRMKTSIZE  =  '50   ' AND
080121080912     C                             (MEDEMP     < CZFRSZ   OR
080122080912     C                             MEDEMP     >  200)
080123080912     C                   Exsr      PrintDetail
080124080912     C                   Add       1             PrtCtr            5 0
080125080912     C                   Leave
080126080912     C                   EndSl
080127080912     C                   End
080128080912     C                   End
080129080912     C                   EndDo
080130080912     C                   EndSr
080131060817
080132080409      *---------------------------------------------------------------*
080133080409     C     PrintDetail   Begsr
080134080409      *---------------------------------------------------------------*
080135080409      *
080136080912     C                   If        *In91     =   *On
080137080912     C                   Write     PRTHDR
080138080912     C                   Eval      *In91     =   *Off
080139080912     C                   End
080140080409     C                   Write     PRTDTL
080141080409     C                   Eval      WKRECORD  =   '"' +
080142080409     C                              %Trim(%Editc(TRTRST:'P'))   + '","' +
080143080409     C                              %Trim(%Editc(TRSUB#:'P'))   + '","' +
080144080409     C                              %Trim(%Editc(TRACCT:'P'))   + '","' +
080145080409     C                                           TRNAME         + '","' +
080146080409     C                                           TRPLAN         + '","' +
080147080409     C                                           TRPCARR        + '","' +
080148080409     C                                           TRMKTSIZE      + '","' +
080149081106     C                              %Trim(%Editc(CZFRSZ:'P'))   + '","' +
080150081106     C                              %Trim(%Editc(CZTOSZ:'P'))   + '","' +
080151080409     C                               %Trim(%Editc(MEDEMP:'P'))  + '","' +
080152080409     C                              %Trim(%Editc(RENDATE:'P'))  + '","' +
080153080409     C                                           PARITY         + '",'
080154080409     C                   Write     MKT21CSR
080155080409     C                   EndSr
080156070213      *---------------------------------------------------------------*
080157070213     C     GetParity     Begsr
080158070213      *---------------------------------------------------------------*
080159070213     C     A2Key         Chain     AC2MST
080160070213     C                   If        %Found(AC2MST)
080161070213     C                   Select
080162080912     C                   When      A2PAR  =   'Y'
080163080912     C                   Eval      PARITY =   'YES'
080164080912     C                   When      A2PAR  =   'N'
080165080912     C                   Eval      PARITY =   'N'
080166070213     C                   Other
080167070213     C                   Eval      PARITY =   %Trim('Blank')
080168070213     C                   EndSl
080169070213     C                   Else
080170070213     C                   Eval      PARITY =   %Trim('Blank')
080171070213     C                   End
080172070213      *
080173070213     C                   EndSr
080174080409      * ? _____________________________________________________________
080175080409      *? *                                                             *
080176080409      *? *        Write Excel Spreadsheet Title to CSV File            *
080177080409      *? *_____________________________________________________________*
080178080409     C     WriteSpTitle  BEGSR
080179080409     C*
080180080409     C                   Eval      WKRECORD  =   '"'  +   'Trust'  + '","' +
080181080409     C                                                     'Sub#'  + '","' +
080182080409     C                                                     'Acct'  + '","' +
080183080409     C                                                     'Name'  + '","' +
080184080409     C                                                     'Plan'  + '","' +
080185080409     C                                                  'Carrier'  + '","' +
080186080409     C                                              'Market Size'  + '","' +
080187081106     C                                                'From Size'  + '","' +
080188081106     C                                                  'To Size'  + '","' +
080189080409     C                                                'Emp w/Med'  + '","' +
080190080409     C                                             'Renewal Date'  + '","' +
080191080409     C                                                   'Parity'  + '",'
080192080409     C                   Write     MKT21CSR
080193080409     C*
0801940804090320 C                   ENDSR
080195060817      *---------------------------------------------------------------*
080196060815     C     Klist         Begsr
080197060817      *---------------------------------------------------------------*
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
080438081008      *
080439081008    ?C     CKey          Klist
080440081008    ?C                   Kfld                    PlanCategoryCd
080441081008    ?C                   Kfld                    TRPLNCAT
080443060817
080444060817      *---------------------------------------------------------------*
080445060817     C     *INZSR        BEGSR
080446060817      *---------------------------------------------------------------*
080447060817     C     *DATE         Mult      10000.0001    Today             8 0
080448061010     C     Today         Mult      10000.0001    TodayFmt          8 0
080449061010     C                   Movel     TodayFmt      TodayM            2 0
080450061010     C                   Select
080451061010     C                   When      TodayM   =    1
080452061010     C                   Eval      RMNAME   =    %Trim('January')
080453061010     C                   When      TodayM   =    2
080454061010     C                   Eval      RMNAME   =    %Trim('February')
080455061010     C                   When      TodayM   =    3
080456061010     C                   Eval      RMNAME   =    %Trim('March')
080457061010     C                   When      TodayM   =    4
080458061010     C                   Eval      RMNAME   =    %Trim('April')
080459061010     C                   When      TodayM   =    5
080460061010     C                   Eval      RMNAME   =    %Trim('May')
080461061010     C                   When      TodayM   =    6
080462061010     C                   Eval      RMNAME   =    %Trim('June')
080463061010     C                   When      TodayM   =    7
080464061010     C                   Eval      RMNAME   =    %Trim('July')
080465061010     C                   When      TodayM   =    8
080466061010     C                   Eval      RMNAME   =    %Trim('August')
080467061010     C                   When      TodayM   =    9
080468061010     C                   Eval      RMNAME   =    %Trim('September')
080469061010     C                   When      TodayM   =    10
080470061010     C                   Eval      RMNAME   =    %Trim('October')
080471061010     C                   When      TodayM   =    11
080472061010     C                   Eval      RMNAME   =    %Trim('November')
080473061010     C                   When      TodayM   =    12
080474061010     C                   Eval      RMNAME   =    %Trim('December')
080475061010     C                   EndSl
080476061010     C                   Write     PRTHDR
080477080409     C                   Exsr      WriteSpTitle
080478060817     C                   ENDSR
080500010412
081900010403     C/EJECT
