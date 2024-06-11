000100020621     H*Indent ('| ')
000200990630      *? ***************************************************************
000600020523      *
000700080718      *             GROUP BENIFIT SERVICES SOFTWARE           2008     *
000800060829      *                                                                *
000900000118      *  Written by:    S. Zien                                        *
001000080801      *  Date Written:   8/01/08                                       *
001100080815      *  Description:   Accumulate most recent coverages for a TSA.    *
001101080813      *  Called by:     AWOFILC                                        *
001200000118      *                                                                *
001300000118      *                                                                *
001400000118      *                R E V I S I O N    H I S T O R Y                *
001500000118      *  Date                                                          *
001600000118      *  Revised   Initials    Revision                                *
001601061016      *  ________  ________    ______________________________________  *
001602080718      *                                                                *
002900020621      *                                                                *
003000990630      *? ***************************************************************
003001080804     FINVDETL6  IF   E           K Disk
003003080718     FCARMST    IF   E           K Disk
003004080723     FPLNMST    IF   E           K Disk
003005080723     FCODES     IF   E           K Disk
003007080813     FAWOFILP   UF A E           K Disk
071405060816      *
071409080815     C                   Move      WOTRST        TRST
071410080815     C                   Move      WOSUB#        SUB#
071411080815     C                   Move      WOACCT        ACCT
071412080820     C
071421080820     C                   Move      WODATE        DateNum           8 0
071422080820     C     DateNum       Mult      10000.0001    UserDate
071423080806     C     InvKey        Setll     INVDETL6
071424080905     C     InvKey        Reade     INVDETL6
071425080804     C                   Dow       Not %Eof(INVDETL6)
071426080826     C                   If        IDVOID    <>  'Y'    And
071427080826     C                             IDTRAMB   <>  *Zero
071428080718     C                   Exsr      Process
071429080804     C                   End
071430080905     C     InvKey        Reade     INVDETL6
071431061010     C                   EndDo
071501060817     C                   Eval      *InLR     =   *On
080000010403
080001060817      *---------------------------------------------------------------*
080002061010     C     Process       Begsr
080003060817      *---------------------------------------------------------------*
080012080721     C     PlnKey        Chain     PLNMST
080013080721     C                   If        %Found(PLNMST)
080014080804    ?C                   Eval      COPCAT    =   PLNCAT
080016080804     C                   Movel     PLNCAT        Typ
080017080804     C                   Move      PLNCAT        Cod
080018080804     C                   Eval      COPCAT    =   PLNCAT
080019080804     C     CodKey        Chain     CODES
080020080804     C                   If        %Found(CODES)
080021080804     C                   Eval      COCDES    =   LDESCR
080022080804     C                   End
080023080721     C                   End
080024080813     C     TstKey        Chain     AWOFILP
080025080813     C                   If        Not %Found(AWOFILP)
080026080804    ?C                   Eval      COTRST   =    IDTRST
080027080804    ?C                   Eval      COSUB#   =    IDSUBD
080028080718    ?C                   Eval      COACCT   =    ACCT
080029080820     C                   Eval      COCVDT    =   IDCVDT
080030080718     C                   Exsr      LoadData
080031080813     C                   Write     AWOFILR
080032080718     C                   Else
080033080718     C                   Exsr      LoadData
080034080813     C                   Update    AWOFILR
080035080718     C                   End
080037080718     C                   Endsr
080038080718      *---------------------------------------------------------------*
080039080718     C     LoadData      Begsr
080040080718      *---------------------------------------------------------------*
080041080718      *
080042080806     C                   Eval      COBRTE    =   IDTRAMB
080045080815     C                   Eval      COPCAR    =   IDCAR
080046080718     C     PCARR         Chain     CARMST
080047080718     C                   If        %Found(CARMST)
080048080718     C                   Eval      COCNAM    =   CNAME
080049080718     C                   End
080059080718     C                   Endsr
080060080815      *___________________________________________________________________
080061080815      * Parameter lists
080062080815      *___________________________________________________________________
080063080815     C     PLIST         Begsr                                                  PARM LISTS
080064080815     C     *ENTRY        Plist                                                  *ENTRY LIST
080071080815     C                   Parm                    WOTRST            3
080072080815     C                   Parm                    WOSUB#            3
080073080815     C                   Parm                    WOACCT            4
080074080815     C                   Parm                    WOAMT             9
080075080815     C                   Parm                    WODATE            8
080077080815     C                   Endsr
080156060817      *---------------------------------------------------------------*
080157060815     C     Klist         Begsr
080158060817      *---------------------------------------------------------------*
080426060829      *
080427080723    ?C     InvKey        Klist
080428080723    ?C                   Kfld                    TRST              3 0
080429080723    ?C                   Kfld                    SUB#              3 0
080430080723    ?C                   Kfld                    ACCT              4 0
080431080723     C                   Kfld                    UserDate          8 0
080432070213      *
080433080806    ?C     InvPKey       Klist
080434080806    ?C                   Kfld                    TRST
080435080806    ?C                   Kfld                    SUB#
080436080806    ?C                   Kfld                    ACCT
080438080806      *
080439080718    ?C     PlnKey        Klist
080440080804    ?C                   Kfld                    IDTRST
080441080804    ?C                   Kfld                    IDSUBD
080442080804    ?C                   Kfld                    IDPLAN
080443080718      *
080444080718    ?C     TstKey        Klist
080445080723    ?C                   Kfld                    IDTRST
080446080723    ?C                   Kfld                    IDSUBD
080447080723    ?C                   Kfld                    IDACCT
080448080806     C                   Kfld                    IDCAR
080449080805    ?C                   Kfld                    PLNCAT
080450080721      *
080451080723    ?C     CarKey        Klist
080452080723    ?C                   Kfld                    IDCAR
080453080723      *
080454080723    ?C     CodKey        Klist
080455080723    ?C                   Kfld                    Typ               1
080456080723    ?C                   Kfld                    Cod               2
080465060817     C                   Endsr
080466060817
080467060817      *---------------------------------------------------------------*
080468060817     C     *INZSR        BEGSR
080469060817      *---------------------------------------------------------------*
080470060817     C     *DATE         Mult      10000.0001    Today             8 0
080478060817     C                   ENDSR
080500010412
081900010403     C/EJECT
