000100990526     F******************************************************************
000200160606     F*  rp100      GROUP BENEFIT SERVICES SOFTWARE                    *
000300990526     F*                                                                *
000400990526     F*            WRITTEN BY - DAVID KETTERMAN                        *
000500160606     F*            DATE - 06/06/16                                     *
000600990526     F*                                                                *
000700160606     F*  DESCRIPTION - Diary note listing                              *
000800001106     F*                                                                *
001200020118     F*                                                                *
001300990526     F******************************************************************
001400160606     Fdiaryhd0  IP   e             DISK
001500160606     Fdiarydt1  IF   e           K DISK
001501160606     Faccmst    IF   E           K DISK
001600160606     fmember    if   e           k disk
001601160606     fcodesl1   if   e           k disk
001700160606     fgbsecure  if   e           k disk
002004160606     Frp100xl   o  a e             disk
0023011507090037 D workdt          S               d   datfmt(*iso)
0027011606060037 D cdesout         S                   like(ldescr)
0027021606060037 D userout         S                   like(scname)
0027041606060037 D nameout         S             40
0027051606060037 D keyout          S             13
0027061606060037 D amout           S              1
0027071606060037 D codeout         S              2
0027091606060037 D subout          S                   like(nhsubj)
0027101606060037 D seqout          S                   like(ndseq#)
0027111606060037 D textout         S                   like(ndtext)
0027121606060037 D admdy           S              8s 0
0027131606060037 D onerec          S              1
002800100608     Dcsv              c                   const('","')
002900100608     D                 DS
003000160606     D  nhkey                  1     10
003001160606     D  pos1                   1      1
003100160606     D  kssn                   2     10  0
003101160606     D  ktrust                 1      3  0
003200160606     D  ksub                   4      6  0
003300160606     D  kacc                   7     10  0
003800990526     D                UDS
004600981214     D  CONAME               201    240
004700981214     D  LTIME                242    247  0
004804160606
004805160606     c                   clear                   nameout
004807160606     c                   clear                   codeout
004808160606     c                   clear                   keyout
004809160606     c                   clear                   amout
004811160606     c                   clear                   cdesout
004812160606     c                   clear                   subout
004813160606     c                   clear                   seqout
004814160606     c                   clear                   textout
004816160606     c                   clear                   admdy
004817160606     c                   clear                   userout
004818160606      * acct rec
004819160606     c                   if        pos1 <> *blank
004820160606     c                   eval      keyout = %subst(nhkey:1:3) + '-' +
004821160606     c                             %subst(nhkey:4:3) + '-' +
004822160606     c                             %subst(nhkey:7:4)
004823160606     c                   eval      amout = 'A'
004900010702     C     ackey         CHAIN     accmst
005000160606     c                   if        %found(accmst)
005100160606     c                   eval      nameout = acnam1
005200010702     c                   end
005301160606      * member rec
005302160606     c                   else
005303160606     c                   eval      keyout = %subst(nhkey:2:3) + '-' +
005304160606     c                             %subst(nhkey:5:2) + '-' +
005305160606     c                             %subst(nhkey:7:4)
005306160606     c                   eval      amout = 'M'
005307160606     C     kssn          CHAIN     member
005308160606     c                   if        %found(member)
005309160606     c                   eval      nameout  = %trim(mfname) + ' ' +
005310160606     c                             %trim(mlname)
005311160606     c                   end
005312160606     c                   end
005313160606
005314160606     c                   eval      codeout = %subst(nhcode:2:2)
005315160606     C     nhcode        CHAIN     codesl1
005316160606     c                   if        %found(codesl1)
005317160606     c                   eval      cdesout = ldescr
005318160606     c                   end
005319160606
005320160606     c     nhadus        CHAIN     gbsecure
005321160606     c                   if        %found(gbsecure)
005322160606     c                   eval      userout = scname
005323160606     c                   end
005324160606
005325160606     c                   eval      subout = nhsubj
005326160606
005400160606     C                   eval      @datin = nhaddt
005500010702     C                   exsr      #datym
005600160606     C                   eval      admdy = @datou
005700010702
005701160606     c                   clear                   seqout
005702160606     c                   clear                   textout
005703160606     c                   clear                   onerec
005704160606
005705160606      * get detail records
005706160606     c     detkey        setll     diarydt1
005707160606     c                   dou       %eof(diarydt1)
005708160606     c     detkey        reade     diarydt1
005709160606     c                   if        not %eof(diarydt1)
005710160606     c                   eval      seqout  = ndseq#
005711160606     c                   eval      textout = ndtext
005712160606     c                   eval      onerec = 'Y'
005713160606      * write excel file
005714160606     c                   exsr      writexldet
006400160606     c                   end
006505160606     c                   clear                   seqout
006506160606     c                   clear                   textout
007401160606     c                   enddo
007402160606
007404160606      * if at least one detail record was not written, then write one line
007405160606      * here to show the header data
007406160606     c                   if        onerec <> 'Y'
007407160606     c                   exsr      writexldet
007408160606     c                   end
007700100608
0078001006080164 C*************************************************************
0079001006080164 C* Write Spreadsheet heading
0080001006080164 C*************************************************************
008100100608     C     Writexlhead   BEGSR
008101150713
008129160606     c                   clear                   rp100fld
008130160606     C                   Eval      rp100fld  =   '"' +
008131160606     C                                           'ACCT / MEM'            + csv +
008132160606     C                                           'A/M'                   + csv +
008133160606     C                                           'NAME'                  + csv +
008135160606     C                                           'DATE'                  + csv +
008136160606     C                                           'TIME'                  + csv +
008137160606     C                                           'SEQ'                   + csv +
008138160606     C                                           'CODE'                  + csv +
008139160606     C                                           'DESCRIPTION'           + csv +
008140160606     C                                           'SUBJECT'               + csv +
008141160606     C                                           'TEXT'                  + csv +
008142160606     C                                           'USER'                  + csv +
008149160606     C                                           ' '                     + '",'
008150160606     C                   Write     rp100xr
009701150713
0098001006080320 C                   ENDSR
0099001006080164 C*************************************************************
0100001006080164 C* Write Spreadsheet Detail                                  *
0101001006080164 C*************************************************************
010200100608     C     Writexldet    BEGSR
010300100608
010301160606     c                   clear                   rp100fld
010302160606     C                   Eval      rp100fld  =   '"' +
010303160606     C                             keyout                              + '","' +
010305160606     C                             amout                               + '","' +
010306160606     C                             %trim(nameout)                      + '","' +
010308160606     C                             %trim(%editw(admdy:'0  /  /    '))  + '","' +
010309160606     C                             %trim(%editw(nhadti:'0  :  :  '))   + '","' +
010310160606     C                             %char(seqout)                       + '","' +
010311160606     C                             codeout                             + '","' +
010312160606     C                             %trim(cdesout)                      + '","' +
010313160606     C                             %trim(subout)                       + '","' +
010314160606     C                             %trim(textout)                      + '","' +
010315160606     C                             %trim(userout)                      + '","' +
010322150713     C                             ' '                          + '",'
010323150713     C*
010324160606     C                   Write     rp100xr
015209150713
0153001006080320 C                   ENDSR
015400100608
015500100608   01C*****************************************************
015600100608   01C*   CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
015700100608   01C*****************************************************
015800100608   01C*
015900100608   01C*   DATE IN  = @DATIN (8.0) YYYYMMDD
016000100608   01C*   DATE OUT = @DATOU (8.0) MMDDYYYY
016100100608   01C*
016200100608   01C     #DATYM        BEGSR
016300100608   01C                   MOVE      @DATIN        @MD               4 0
016400100608   01C                   MOVEL     @DATIN        @Y                4 0
016500100608   01C                   MOVEL     @MD           @DATOU            8 0
016600100608   01C                   MOVE      @Y            @DATOU
016700100608   01C                   MOVE      *ZEROS        @DATIN            8 0
016800100608   01C                   ENDSR
016900100608
017000100608     C     *INZSR        BEGSR
017100100608     c     ackey         klist
017200160606     c                   kfld                    ktrust
017300160606     c                   kfld                    ksub
017400160606     c                   kfld                    kacc
017500100608
017501160606     c     detkey        klist
017502160606     c                   kfld                    NHKEY
017505160606     c                   kfld                    NHADDT
017506160606     c                   kfld                    NHADTI
017507160606
018500100608     c                   exsr      writexlhead
018700100608
018800100608     C                   ENDSR
