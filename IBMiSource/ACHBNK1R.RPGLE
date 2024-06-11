000100020621     H*Indent ('| ')
000200990630      *? ***************************************************************
000300020523      *
000400110323      *             GROUP BENIFIT SERVICES SOFTWARE           2011     *
000500060829      *                                                                *
000600000118      *  Written by:    S. Zien                                        *
000700110323      *  Date Written:   3/23/09                                       *
000800110323      *  Description:   Load ACCACH with banking info provided by      *
000801110323      *                  Finance in a spreadsheet one time.            *
000900000118      *                                                                *
001000000118      *                                                                *
001100000118      *                R E V I S I O N    H I S T O R Y                *
001200000118      *  Date                                                          *
001300000118      *  Revised   Initials    Revision                                *
001400000118      *  --------  --------    --------------------------------------  *
001500090709      *                                                                *
001600020621      *                                                                *
001700990630      *? ***************************************************************
001701110323     FACHBNK    IF   E             Disk
001800110323     FACCACH    UF   E           K Disk
002200010326
002300090909     D                 DS
0024001103230125 D BNTSA
0025001103230125 D  TRST                   1      3  0
0026001103230125 D  SUB#                   4      6  0
0027001103230125 D  ACCT                   7     10  0
002702090918     D @TRST           S              3A
002703090918     D @SUBD           S              3A
002704090918     D @ACCT           S              4A
002800061017     D                UDS
002900090918     D @USER                  25     32
003000061017
003700060816      *
004300110323     C                   Read      ACHBNK
004400110323     C                   Dow       Not %Eof(ACHBNK)
004600061010     C                   Exsr      Process
004800110323     C                   Read      ACHBNK
004900061010     C                   EndDo
005000060817     C                   Eval      *InLR     =   *On
005200010403
005300060817      *---------------------------------------------------------------*
005400061010     C     Process       Begsr
005500060817      *---------------------------------------------------------------*
005501110323     C     ACHKey        Chain     ACCACH
005502110323     C                   If        %Found(ACCACH)
005503110323      * If last zero overflowed into filler field
005504110323     C                   Clear                   AHACT#
005505110323     C                   Clear                   AHROUT
005506110324     C                   Clear                   AHACT#C
005507110324     C                   Clear                   AHROUTC
005508110323     C                   If        FILL4   <>    '0'
005509110323     C                   Movel     BNACT#        AHACT#
005510110324     C                   Movel     BNACT#        AHACT#C
005511110323     C                   Else
005512110323     C                   Move      *Blanks       HoldAct          14
005513110323     C                   Eval      HoldAct =     BNACT# + '0'
005514110323     C                   Movel     HoldAct       AHACT#
005515110324     C                   Movel     HoldAct       AHACT#C
005516110323     C                   End
005517110323     C                   Movel     BNROUT        AHROUT
005518110324     C                   Movel     BNROUT        AHROUTC
005519110323     C                   Movel     BNCSFL        AHCSFL
005520110323     C                   Update    ACCACHR
005521110323     C                   End
009300090904      *
009301090909     C                   EndSr
018500090903    ? *___________________________________________________________________
018600090903    ? * Klists
018700090903    ? *___________________________________________________________________
018800090904    ?C     KList         Begsr
018900090903    ? *
018901110323     C     ACHKey        Klist
018902110323    ?C                   Kfld                    TRST
018903110323    ?C                   Kfld                    SUB#
018904110323    ?C                   Kfld                    ACCT
018905110323    ? *
019700090903    ?C                   Endsr                                                  END *INZSR
019800090903    ? *___________________________________________________________________
019900090903     C     *Inzsr        BEGSR
020000090903    ? *___________________________________________________________________
020100060817     C     *DATE         Mult      10000.0001    Today             8 0
020800060817     C                   ENDSR
020900010412
021000010403     C/EJECT
