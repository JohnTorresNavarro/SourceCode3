000100020621     H*Indent ('| ')
000200990630      *? ***************************************************************
000300020523      *
000400090521      *             GROUP BENIFIT SERVICES SOFTWARE           2009     *
000500060829      *                                                                *
000600000118      *  Written by:    S. Zien                                        *
000700090521      *  Date Written:   5/21/09                                       *
000800090521      *  Description:   ACH Email Notification                         *
000900000118      *                                                                *
001000000118      *                                                                *
001100000118      *                R E V I S I O N    H I S T O R Y                *
001200000118      *  Date                                                          *
001300000118      *  Revised   Initials    Revision                                *
001400000118      *  --------  --------    --------------------------------------  *
001500060815      *                                                                *
001600100714      *   7.14.10    szz       Add ACH Begin & End Dates to spreadsheet*
001700020621      *                                                                *
001800100727      *   7.27.10    szz       Account Termination Date will also      *
001900100727      *                         trigger the email notification.        *
002000180110
002100180110      *  01/09/18    jt        Added changes for Advanced Mobile
002200100727      *                                                                *
002300200113      *  01/13/20    jt        Added changes for CMS
002400200113      *                                                                *
002500990630      *? ***************************************************************
002600090521     FACCACH    IF   E           K Disk
002700090521     FACCMST    IF   E           K Disk
002800090521     FMEMAC#    IF   E           K Disk
002900100727     FTRSMST    IF   E           K Disk
003000090521     FACHENCSV  O  A E             Disk
003100010326
003200090521     D Yesterday       S               D   datfmt(*ISO)
003300090521    ?D ISOToday        S               D   datfmt(*ISO)                         Input Request
003400060816      *
003500090521     C                   Read      ACCACH
003600090521     C                   Dow       Not %Eof(ACCACH)
003700090521     C                   If        CmpDate   =   AHCHDT
003800061010     C                   Exsr      Process
003900100727     C                   Else
004000100727     C                   Exsr      ChkAcc
004100090521     C                   End
004200090521     C                   Read      ACCACH
004300061010     C                   EndDo
004400060817     C                   Eval      *InLR     =   *On
004500010403
004600060817      *---------------------------------------------------------------*
004700061010     C     Process       Begsr
004800060817      *---------------------------------------------------------------*
004900070111     C                   Exsr      Getfields
005000090521     C
005100080409     C                   Eval      WKRECORD  =   '"' +
005200090521     C                              %Trim(%Editc(AHTRST:'P'))   + '","' +
005300090521     C                              %Trim(%Editc(AHSUB#:'P'))   + '","' +
005400090521     C                              %Trim(%Editc(AHACCT:'P'))   + '","' +
005500090521     C                              %Trim(%Editw(MBSSNO:'0    -   -    ')+
005600090521     C                                                            '","' +
005700090521     C                                           MNAME          + '","' +
005800090521     C                              %Trim(%Editc(ENROLL:'P'))   + '","' +
005900100715     C                              %Trim(%Editc(ATRMDT:'P'))   + '","' +
006000100714     C                              %Trim(%Editc(AHBEDT:'P'))   + '","' +
006100100714     C                              %Trim(%Editc(AHENDT:'P'))   + '","' +
006200090521     C                                           AHCHGU         + '",')
006300090521     C                   Write     ACHENCSR
006400080409     C*
006500060817     C                   ENDSR
006600060817
006700070111      *---------------------------------------------------------------*
006800070111     C     GetFields     Begsr
006900070111      *---------------------------------------------------------------*
007000090521     C     AKey          Chain     MEMAC#
007100090521     C                   If        %Found(MEMAC#)
007200090521     C                   If        MMI    = *Blanks
007300090521     C                   Eval      MNAME  = %Trim(%Trim(MLNAME) + ', ' +
007400090521     C                                      %Trim(MFNAME))
007500090521     C                   Else
007600090521     C                   Eval      MNAME  = %Trim(%Trim(MLNAME) + ', ' +
007700090521     C                                      %Trim(MFNAME) + ' ' + MMI  +
007800090521     C                                      '.')
007900090521     C                   End
008000090521     C                   Else
008100090521     C                   Eval      MNAME  = %Trim('Not on File')
008200090521     C                   Eval      MBSSNO = *Zeros
008300090521     C                   End
008400090521     C     AKey          Chain     ACCMST
008500070111      *
008600070111    ?C                   Endsr
008700100727      *---------------------------------------------------------------*
008800100727     C     ChkAcc        Begsr
008900100727      *---------------------------------------------------------------*
009000100727      *
009100100727     C     AHTRST        Chain     TRSMST
009200100727     C                   If        %Found(TRSMST)
009300200113       if tscode = 'O N'
009400200113        or tscode = 'O M'
009500200113         or tscode = 'O D';
009600100727     C     AKey          Chain     ACCMST
009700100727     C                   If        %Found(ACCMST)
009800100727     C                   If        CmpDate   =   ATRMDT
009900100727     C                   Exsr      Process
010000100727     C                   End
010100100727     C                   End
010200100727     C                   End
010300100727     C                   End
010400100727     C
010500100727    ?C                   Endsr
010600060817      *---------------------------------------------------------------*
010700060815     C     Klist         Begsr
010800060817      *---------------------------------------------------------------*
010900060829      *
011000090521     C     AKey          Klist
011100090521     C                   Kfld                    AHTRST
011200090521     C                   Kfld                    AHSUB#
011300090521     C                   Kfld                    AHACCT
011400100727      *
011500060817     C                   Endsr
011600080409      * ? _____________________________________________________________
011700080409      *? *                                                             *
011800080409      *? *        Write Excel Spreadsheet Title to CSV File            *
011900080409      *? *_____________________________________________________________*
012000080409     C     WriteSpTitle  BEGSR
012100080409     C*
012200080409     C                   Eval      WKRECORD  =   '"' +   'Trust'  + '","' +
012300080409     C                                                    'Sub#'  + '","' +
012400080409     C                                                    'Acct'  + '","' +
012500090521     C                                                  'Member'  + '","' +
012600090521     C                                                    'Name'  + '","' +
012700090521     C                                          'Effective Date'  + '","' +
012800100715     C                                               'Term Date'  + '","' +
012900100714     C                                          'ACH Begin Date'  + '","' +
013000100714     C                                            'ACH End Date'  + '","' +
013100090521     C                                         'Entered by User'  + '",'
013200090521     C                   Write     ACHENCSR
013300080409     C*
0134000804090320 C                   ENDSR
013500060817
013600060817      *---------------------------------------------------------------*
013700060817     C     *INZSR        BEGSR
013800060817      *---------------------------------------------------------------*
013900060817     C     *DATE         Mult      10000.0001    Today             8 0
014000080612     C     *ISO          Move      Today         ISOToday
014100090521     C     ISOToday      Subdur    1:*d          Yesterday
014200090521     C                   Move      Yesterday     CmpDate           8 0
014300140509     C*****************  z-add     20140507      CmpDate
014400090521     C                   Move      *Blanks       MNAME            40
014500090521     C                   Exsr      WriteSpTitle
014600060817     C                   ENDSR
014700010412
014800010403     C/EJECT
