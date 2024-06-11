000100990526     F******************************************************************
000300190517     F*  cob380     GROUP BENEFIT SERVICES SOFTWARE                    *
000400990526     F*                                                                *
000500990526     F*            WRITTEN BY - DAVID KETTERMAN                        *
000600190517     F*            DATE - 05/17/19                                     *
000700990526     F*                                                                *
000800190517     F*  DESCRIPTION - Cobra members with activity to HRA BF plans     *
001002041215     F*                                                                *
001100990526     F******************************************************************
001200990526     FHIST      IP   E             DISK
001502041215     Fmember    IF   E           K DISK
001503190517     Fplnmst    IF   E           K DISK
001504190517     Faccmst    IF   E           K DISK
001505190520     Fcodesl1   IF   E           K DISK
001506190522     Fsman      IF   E           K DISK
0015071905170017 Fcob380xl  o  a e             DISK
0015081905200125 D csv             c                   const('","')
001509190520     D word1           s              2S 0 inz
001510190520     D word2           s              2S 0 inz
001511190520     D word3           s              2S 0 inz
001512190520     D acnam1_o        s                   like(acnam1)
001513190520     D acobsrv_o       s                   like(acobsrv)
001514190520     D fcstfl_o        s                   like(fcstfl)
001515190520     D trdes_o         s                   like(ldescr)
001516190522     D sname_o         s             33
001517190520     D                 DS
001518190520     D  tsa                    1     10  0
001519190520     D  HSTRST                 1      3  0
001520190520     D  HSSUB#                 4      6  0
001521190520     D  HSACCT                 7     10  0
001522190520     D                 DS
001523190520     D  ck#not                 1     30
001524190520     D  hplan                  1      4
002000990526     D                UDS
002100990526     D  LFY                    1      4  0
002200990526     D  LFMD                   5      8  0
002300990526     D  LTY                    9     12  0
002400990526     D  LTMD                  13     16  0
002500990527     D  LTRUST                17     19
002600990527     D  LSUB                  20     22
002700990527     D  LACC                  23     26
002800981214     D  CONAME               201    240
002900981214     D  LTIME                242    247  0
003107010320
003108190517     c* only select cobra members
003109190517     c                   move      hkey          memkey            9 0
0031101905170200 C                   clear                   memnam           34
003111190520
0031121905170065 C     memkey        CHAIN     member
003113190517     c                   if        %found(member) and cexpdt <> 0
003114190517      * check for an HRA Blue Fund plan
003115190520     c     plnkey        chain     plnmst
003116190520     c                   if        %found(plnmst)
003117190520       clear word1;
003118190520       clear word2;
003119190520       clear word3;
003120190520       word1 = %scan('HRA':pdescr);
003121190520       word2 = %scan('BF':pdescr);
003122190520       word3 = %scan('BLUE FUND':pdescr);
003123190520       if word1 <> 0 and (word2 <> 0 or word3 <> 0);
003124190520        exsr writexldet;
003126190520       endif;
003127190520     c                   end
003129190517     c                   end
003130190517
0083041905170313 C*
0083051905170164 C*************************************************************
0083061905170164 C*                                                           *
0083071905170164 C* Write Spreadsheet Detail                                  *
0083081905170164 C*                                                           *
0083091905170164 C*************************************************************
008310190517     C     Writexldet    BEGSR
0083111905170202 C                   MOVEl     mfname        memnam
008312190517     c                   if        mmi <> ' '
008313190517     C                   CAT       mmi:1         memnam
008314190517     c                   end
008315190517     C                   CAT       mlname:1      memnam
008316190517
008317190520     c                   clear                   acnam1_o
008318190520     c                   clear                   acobsrv_o
008319190520     c                   clear                   fcstfl_o
008320190520     c                   clear                   atrmmdy
008321190522     c                   clear                   sname_o
008322190520
008323190520     c     acckey        chain     accmst
008324190520     c                   if        %found(accmst)
008325190520     c                   movel     acnam1        acnam1_o
008326190520     c                   movel     acobsrv       acobsrv_o
008327190520     c                   movel     fcstfl        fcstfl_o
008328190520     C                   MOVE      atrmdt        @DATIN
008329190520     C                   EXSR      #DATYM
008330190520     C                   MOVE      @DATOU        atrmmdy           8 0
008331190522     c     smancd        chain     sman
008332190522     c                   if        %found(sman)
0083331905220202 C                   MOVEl     sfname        sname_o
008337190522     C                   CAT       slname:1      sname_o
008338190522     c                   end
008339190520     c                   end
008340190520
008341190520     c                   clear                   trdes_o
008342190520     c     trcode        chain     codesl1
008343190520     c                   if        %found(codesl1)
008344190520     c                   movel     ldescr        trdes_o
008345190520     c                   end
008346190520
008347190520     C                   MOVE      trdate        @DATIN
008348190520     C                   EXSR      #DATYM
008349190520     C                   MOVE      @DATOU        trdatemdy         8 0
008350190520
008351190520     C                   MOVE      covtdt        @DATIN
008352190520     C                   EXSR      #DATYM
008353190520     C                   MOVE      @DATOU        covtdtmdy         8 0
008354190520
008355190520     C                   MOVE      cexpdt        @DATIN
008356190520     C                   EXSR      #DATYM
008357190520     C                   MOVE      @DATOU        cexpdtmdy         8 0
008358190520
008359190520     c                   clear                   cob380fld
008360190520     C                   Eval      cob380fld  = '"' +
008361190520     C                             %trim(%editc(trdatemdy:'Y'))         + csv +
008362190520     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
008363190520     C                             %trim(acnam1_o)                      + csv +
008364190520     C                             %trim(fcstfl_o)                      + csv +
008365190520     C                             %trim(acobsrv_o)                     + csv +
008366190520     C                             %trim(%editw(atrmmdy:'  /  /    '))  + csv +
008367190522     C                             %trim(sname_o)                       + csv +
008368190520     C                             %trim(%editw(memkey:'0   -  -    ')) + csv +
008369190520     C                             %trim(memnam)                        + csv +
008370190520     C                             %trim(%editc(cexpdtmdy:'Y'))         + csv +
008371190520     C                             %trim(trdes_o)                       + csv +
008372190520     C                             %trim(hplan)                         + csv +
008373190520     C                             %trim(pdescr)                        + csv +
008374190520     C                             %trim(ck#not)                        + csv +
008375190520     C                             %trim(note2)                         + csv +
008376190520     C                             %trim(%editc(covtdtmdy:'Y'))         + csv +
008377190520     C                             ' '                          +
008378190520     C                             '",'
008379190517     C*
008380190520     C                   Write     cob380xr
0083811905170320 C                   ENDSR
008382190517     C*
008383190517     C/EJECT
008384190517     C*************************************************************
008385190517     C*                                                           *
008386190517     C* Write Spreadsheet heading                                 *
008387190517     C*                                                           *
008388190517     C*************************************************************
008389190517     C     Writexlhead   BEGSR
008390190517
008391190520     c                   clear                   cob380fld
008392190520     C                   Eval      cob380fld = '"' +
008393190520     C                             'TRANS DATE'                      + csv +
008394190520     C                             'ACCOUNT #'                       + csv +
008395190520     C                             'ACCOUNT NAME'                    + csv +
008396190520     C                             'FED/STATE'                       + csv +
008397190520     C                             'COBRA SERV'                      + csv +
008398190520     C                             'ACCT CANCEL'                     + csv +
008399190522     C                             'BOR SALESMAN'                    + csv +
008400190520     C                             'SSN'                             + csv +
008401190520     C                             'NAME'                            + csv +
008402190520     C                             'COBRA ENDS'                      + csv +
008403190520     C                             'TRANSACTION'                     + csv +
008404190520     C                             'PLAN'                            + csv +
008405190520     C                             'PLAN DESCRIPTION'                + csv +
008406190520     C                             'NOTE 1'                          + csv +
008407190520     C                             'NOTE 2'                          + csv +
008408190520     C                             'EFF DATE'                        + csv +
008409190520     C                             ' '                               +
008410190520     C                             '",'
008411190520     C                   Write     cob380xr
008412190517     C*
0084131905170320 C                   ENDSR
0084140412150103 C***************************************************
0084150412150104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0084160412150105 C***************************************************
0084170412150107 C*
0084180412150107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0084190412150107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0084200412150107 C*
0084210412150106 C     #DATYM        BEGSR
008422041215     C                   MOVE      @DATIN        @MD               4 0
008423041215     C                   MOVEL     @DATIN        @Y                4 0
008424041215     C                   MOVEL     @MD           @DATOU            8 0
008425041215     C                   MOVE      @Y            @DATOU
008426041215     C                   MOVE      *ZEROS        @DATIN            8 0
0084270412150120 C                   ENDSR
0084280412150107 C*
008900990526     C     *INZSR        BEGSR
009000990526     C*
009001190520     c     plnkey        klist
009002190520     c                   kfld                    hstrst
009003190520     c                   kfld                    hssub#
009004190520     c                   kfld                    hplan
009005190520     c     acckey        klist
009006190520     c                   kfld                    hstrst
009007190520     c                   kfld                    hssub#
009008190520     c                   kfld                    hsacct
009009190520
009010190520     C                   exsr      Writexlhead
009011190520
009800990526     C                   ENDSR
