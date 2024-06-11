000100170510    *H OPTION(*NODEBUGIO) DFTACTGRP(*NO) ACTGRP(*CALLER)
000200170510    *H BNDDIR('GBSBDIR') ALWNULL(*USRCTL)
000300170510     Hbnddir('ALLSRVPGMN')
0004009102150002 F******************************************************************  DB0121
0005001705230004 F*                                                                *  DB0121
0006001705230004 F*  NOTES:  This program must be COMPILED with this on            *  DB0121
0007001705230004 F*          the libray list.                                      *  DB0121
0008001705230004 F*                                                                *  DB0121
0009001705230004 F*          Production:  RPGSPDASH                                *  DB0121
0010001705230004 F*                                                                *  DB0121
0011001705230004 F*          Test:        RPGSPBETA                                *  DB0121
0012001705230004 F*                                                                *  DB0121
0013001705230004 F*                                                                *  DB0121
0014001705230004 F*                                                                *  DB0121
0015000004140003 F* DB012      GROUP BENEFIT SERVICES SOFTWARE           1989      *  DB0121
0016009102150004 F*                                                                *  DB0121
0017009102150005 F*            WRITTEN BY - DAVID KETTERMAN                        *  DB0121
0018009102150006 F*            DATE - 10/89                                        *  DB0121
0019009102150007 F*                                                                *  DB0121
0020009102150008 F*  DESCRIPTION - THIS PROGRAM WILL FOLLOW DB010 IT CHECKS        *  DB0121
0021009102150009 F*                FOR MEMBER RECORDS WITHOUT COVERAGE.            *  DB0121
0022001110100010 F*  Y2K CONVERT - 1998                                            *
002300980202     F*  DMA 02.02.98  Added Account Administrator name to report
0024000205240010 F*  5/24/02 szz - Recompiled over new AACODE file                 *  DB012
002500111010     F* 10/10/11 dlk - change to sort by aacode - request from Lisha Iacovelli
002600120207     F* 02/07/12 dlk - rewrite and convert to csv output                    li
002700130510     F* 05/10/13 dlk - add cobra indicator                                  li
0028001305300014 F* 05/30/2013 SSK - ADD OLE CHECK AND ADJUST ERROR MESSAGE AS NEEDED
0029001305300015 F*                      PER LISHA REQUEST
003000131015     F* 10/15/13 SSK - QUANTIFY MESSAGE TO NON-SENIOR DENTAL ACCOUNTS
003100140714     F* 07/14/14 dlk - Add acct begin admin date per shelly request         li
003200170512     F* 03/23/17 B.Rees Added Trust 888 to the skip
003300170512     F* 05/12/17 J.Allen ignore declined plans
003400180109     F* 01/09/18 R.Jones Add code for Adv Mbl - trust 076+
003500200115     F* 01/15/20 R.Jones Add code for CSMi - TSCODE = 'O D'
0036009808200015 F*                                                                *
0037009102150011 F******************************************************************  DB0121
003800111010     Fdb012j    ip   e           k DISK
0039001202070014 FMCOV      IF   e           k DISK
004000120207     FAACODE    IF   e           k DISK
004100170510     FACCOSP    IF   E           K DISK
004200180109     FTRSMST    IF   E           K DISK
004300170510     FWEBTRANL1 IF   E           K DISK
0044001202070015 F*EPORT    O    F  132        PRINTER OFLIND(*INOF)
0045001202070017 Fdb012xl   o  a e             DISK
004600170510
00470017051000    * Payroll Prototypes
004800170510      /copy *libl/qmodsrc,#chkdeclpr
004900170510      /copy *libl/qmodsrc,#chkdectpr
005000170510
005100170510     D outdc           S              1A
005200170510     D incat           S              3A
005300170510
0054001202070125 Dcsv              c                   const('","')
005500130530     D @ERROR          S            100A
005600130530     derrorout         s             50A   inz('MEMBER RECORD WITHOUT -
005700120207     d                                     COVERAGE.')
005800130530     d ERROR2          s            100A   inz('MEMBER RECORD WITHOUT -
005900130530     d                                     COVERAGE. OLE ACCOUNT')
0060001202070030 D                 DS
0061001202070031 D  tsa                    1     10  0
0062001202070031 D  t                      1      3  0
0063001202070031 D  s                      4      6  0
0064001202070031 D  a                      7     10  0
0065009102150023 D                UDS                                                       DB012
0066009102150024 D  CONAME               201    240                                         DB012
0067009102150025 D  TIME                 242    247  0                                      DB012
0068001110100030 Idb012r
006900120207     I              aacode                      acaacode
007000120207     C* skip
007100170323     C                   if        mbtrst = 990 or mbtrst = 999 or
007200170323     C                             mbtrst = 888 or
007300120207     C                             empst <> 'A'
007400930209     C                   GOTO      #END
007500930209     C                   END
007600130510
0077009212150026 C* FOR ONLY ACTIVE MEMBER RECORDS
0078009102150027 C* WHEN NO COVERAGE RECORD IS FOUND, WRITE OUT ERROR REPORT
007900120207     C                   if        termdt = 0
0080001202070029 C     mbssno        CHAIN     MCOV                                                        DB012
008100120207     c                   if        not %found(mcov)
008200120207     C                   exsr      writexldet
008300120207     c                   add       1             toterr            7 0
008400921215     C                   END
008500120207     C                   END
008600120207
008700930209     C     #END          TAG
008800120207
0089001202070164 C*************************************************************
0090001202070164 C*                                                           *
0091001202070164 C* Write Spreadsheet Detail                                  *
0092001202070164 C*                                                           *
0093001202070164 C*************************************************************
009400120207     C     Writexldet    BEGSR
009500120207
009600120207     c                   clear                   db012fld
009700120207
0098001202070059 C                   MOVE      mbtrst        T
0099001202070059 C                   MOVE      mbsub#        s
0100001202070059 C                   MOVE      mbacct        A
010100120207
010200120207      * get aa name
010300120207     c                   clear                   aanamout         30
010400120207     C     AAKEY         CHAIN     AACODE
010500120207     c                   if        %found(aacode)
010600120207     C     AFNAM         CAT       ALNAM:1       aanamout
010700120207     c                   end
010800120207
010900120207     C                   MOVE      mbenrl        @DATIN
011000120207     C                   EXSR      #DATYM
011100120207     C                   MOVE      @DATOU        mbenrlmdy         8 0
011200120207
011300120207     C                   MOVE      termdt        @DATIN
011400120207     C                   EXSR      #DATYM
011500120207     C                   MOVE      @DATOU        termdtmdy         8 0
011600130510
011700140714     C                   MOVE      gbsbdt        @DATIN
011800140714     C                   EXSR      #DATYM
011900140714     C                   MOVE      @DATOU        gbsbdtmdy         8 0
012000140714
012100130510     c                   clear                   cobraout          3
012200130510     c                   if        cexpdt <> 0
012300130510     c                   eval      cobraout = 'YES'
012400130510     c                   end
012500120207
012600130530     C     KL#TSA        KLIST
012700130530     C                   KFLD                    MBTRST
012800180109      *   Change logic below to look for dental trusts using TSCODE
012900180109     C************       IF        MBTRST > 24 AND MBTRST < 76
013000180109     C     mbtrst        CHAIN     TRSMST
013100200115     C                   IF        tscode = 'O N' or tscode = 'O M' or
013200200115     C                             tscode = 'O D'
013300131015     C                   EVAL      @ERROR = ERROROUT
013400131015     C                   ELSE
013500130530     C     KL#TSA        CHAIN     ACCOSPR
013600130530     C                   IF        %FOUND(ACCOSP) AND AOBEDT <> 0
013700130530     C                   EVAL      @ERROR = ERROR2
013800130530     C                   ELSE
013900130530     C                   EVAL      @ERROR = ERROROUT
014000131015     C                   ENDIF
014100130530     C                   ENDIF
014200170510
014300170510     C                   exsr      chkdecline
014400170510     C                   if        outdc = *blanks
014500130530
014600120207     C                   Eval      db012fld  = '"' +
014700120207     C                             %trim(%editw(mbssno:'0   -  -    ')) + csv +
014800130510     C                             %trim(cobraout)                      + csv +
014900120207     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
015000140714     C                             %trim(%editw(gbsbdtmdy:'  /  /    ')) + csv +
015100130530     C                             %trim(@ERROR)                        + csv +
015200120207     C                             %trim(%editw(mbenrlmdy:'  /  /    ')) + csv +
015300120207     C                             %trim(%editw(termdtmdy:'  /  /    ')) + csv +
015400120207     C                             %trim(acaacode)                      + csv +
015500120207     C                             %trim(aanamout)                      + csv +
015600120207     C                             ' '                                  + '",'
015700120207     C*
015800120207     C                   Write     db012xr
015900170510     C                   end
0160001202070320 C                   ENDSR
016100170510      *---------------------------------------------------------*
016200170510     C     chkdecline    Begsr
016300170510      *---------------------------------------------------------*
016400170510     C                   eval      outdc = *blanks
016500170510
016600170510     C     webkey        setll     WEBTRANL1
016700170510     C     webkey        reade     WEBTRANL1
016800170510     C                   dow       not %eof(WEBTRANL1)
016900170510
017000170510      * save trn# of declines for later cleanup
017100170510     C                   If        %subst(OEGRPV:1:8) = 'ADD_COVG' and
017200170510     C                             %subst(OEFLDV:1:4) = 'PCAT'
017300170510
017400170510     C                   eval      incat = %trim(oeafter)
017500170510     C                   eval      outdc = #chkdecl(oetrst:oesub#:oeacct:
017600170510     C                                              oessno:incat)
017700170510     C                   If        outdc = 'Y'
017800170510     C                   LeaveSR
017900170510     C                   else
018000170510     C                   eval      outdc = #chkdect(oetrn#)
018100170510     C                   If        outdc = 'Y'
018200170510     C                   LeaveSR
018300170510     C                   end
018400170510     C                   end
018500170510
018600170510     C                   end
018700170510
018800170510     C     webkey        reade     WEBTRANL1
018900170510     C                   enddo
019000170510
019100170510     C     webkey        klist
019200170510     C                   kfld                    mbtrst
019300170510     C                   kfld                    mbsub#
019400170510     C                   kfld                    mbacct
019500170510     C                   kfld                    mbssno
019600170510
019700170510     C                   Endsr
019800120207     C*
019900120207     C/EJECT
020000120207     C*************************************************************
020100120207     C*                                                           *
020200120207     C* Write Spreadsheet heading                                 *
020300120207     C*                                                           *
020400120207     C*************************************************************
020500120207     C     Writexlhead   BEGSR
020600120207
020700120207     c                   clear                   db012fld
020800120207     C                   Eval      db012fld = '"' + 'SS #'              + csv +
020900130510     C                                              'COBRA'             + csv +
021000120207     C                                              'ACCOUNT'           + csv +
021100140714     C                                              'BEGIN ADMIN'       + csv +
021200120207     C                                              'ERROR'             + csv +
021300120207     C                                              'ENROLL DATE'       + csv +
021400120207     C                                              'TERM DATE'         + csv +
021500120207     C                                              'AA CODE'           + csv +
021600120207     C                                              'AA NAME'           + csv +
021700120207     C                                              ' '                 + '",'
021800120207     C                   Write     db012xr
021900120207     C*
0220001202070320 C                   ENDSR
022100120207
022200120207     C     *INZSR        BEGSR
0223001202070210 C                   MOVE      *ZEROS        ZERO2
022400120207     C     aakey         KLIST
022500120207     C                   KFLD                    acaacode
022600120207     C                   KFLD                    ZERO2             2 0
022700120207
022800120207     C                   Exsr      Writexlhead
022900120207     C                   endsr
0230001202070107 C*
0231001202070103 C***************************************************
0232001202070104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0233001202070105 C***************************************************
0234001202070107 C*
0235001202070107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0236001202070107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0237001202070107 C*
0238001202070106 C     #DATYM        BEGSR
023900120207     C                   MOVE      @DATIN        @MD               4 0
024000120207     C                   MOVEL     @DATIN        @Y                4 0
024100120207     C                   MOVEL     @MD           @DATOU            8 0
024200120207     C                   MOVE      @Y            @DATOU
024300120207     C                   MOVE      *ZEROS        @DATIN            8 0
0244001202070120 C                   ENDSR
0245001202070107 C*
0246001202070031 O*EPORT    H    1P                  2    03                                DB012
0247001202070032 O*        OR    OF                                                         DB012
0248001202070033 O*                                          86 '**'                        DB012
0249001202070034 O*                      CONAME              84                             DB012
0250001202070035 O*                                          44 '**'                        DB012
0251001202070036 O*         H    1P                  2                                      DB012
0252001202070037 O*        OR    OF                                                         DB012
0253001202070038 O*                      UDATE         Y     14                             DB012
0254001202070039 O*                                          69 'MCOV/MEMBER AUDIT'         DB012
0255001202070040 O*                                          77 'LISTING'                   DB012
0256001202070041 O*                                         120 'PAGE :'                    DB012
0257001202070042 O*                      PAGE          Z    126                             DB012
0258001202070043 O*         H    1P                  1                                      DB012
0259001202070044 O*        OR    OF                                                         DB012
0260001202070045 O*                                          17 'PROG: DB012'               DB012
0261001202070046 O*                                         120 'TIME :'                    DB012
0262001202070047 O*                      TIME               130 '  :  :  '                  DB012
0263001202070048 O*         H    1P                  1                                      DB012
0264001202070049 O*        OR    OF                                                         DB012
0265001202070050 O*                                          24 '------------------------'  DB012
0266001202070051 O*                                          48 '------------------------'  DB012
0267001202070052 O*                                          72 '------------------------'  DB012
0268001202070053 O*                                          96 '------------------------'  DB012
0269001202070054 O*                                         120 '------------------------'  DB012
0270001202070055 O*                                         132 '------------'              DB012
0271001202070056 O*         H    1P                  1                                      DB012
0272001202070057 O*        OR    OF                                                         DB012
0273001202070058 O*                                           8 'SS #'                      DB012
0274001202070059 O*                                          25 'ACCOUNT'
0275001202070060 O*                                          48 'ERROR'                     DB012
0276001202070060 O*                                          80 'TERMDT'                    DB012
027700120207     O*                                          95 'AA NAME'
0278001202070061 O*         H    1P                  1  1                                   DB012
0279001202070062 O*        OR    OF                                                         DB012
0280001202070063 O*                                          24 '------------------------'  DB012
0281001202070064 O*                                          48 '------------------------'  DB012
0282001202070065 O*                                          72 '------------------------'  DB012
0283001202070066 O*                                          96 '------------------------'  DB012
0284001202070067 O*                                         120 '------------------------'  DB012
0285001202070068 O*                                         132 '------------'              DB012
0286001202070069 O*         D    20                     1                                   DB012
0287001202070070 O*                      mbssno              11 '   -  -    '
0288001202070071 O*                      MBTRST              19
0289001202070071 O*                                          20 '-'
0290001202070071 O*                      MBSUB#              23
0291001202070071 O*                                          24 '-'
0292001202070071 O*                      MBACCT              28
0293001202070072 O*                                          53 'MEMBER RECORD WITHOUT'     DB012
0294001202070073 O*                                          62 'COVERAGE'                  DB012
0295001202070073 O*                      termdt              77 '    /  /  '                DB012
029600120207     O*                      @Acode              91
029700120207     O*                                          93 '-'
029800120207     O*                      AANAME             114
0299001202070074 O*         T    LRN99                  2
0300001202070075 O*                                          17 'ALL RECORDS MATCH'
0301001202070135 O*         T    LR 99               1  1
0302001202070136 O*                                          13 'TOTAL ERRORS:'
030300120207     O*                      toterr        1     +2
