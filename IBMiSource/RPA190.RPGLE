000100990526     F******************************************************************
000300081216     F*  rpa190     GROUP BENEFIT SERVICES                             *
000400990526     F*                                                                *
000500990526     F*            WRITTEN BY - DAVID KETTERMAN                        *
000600081216     F*            DATE - 12/16/08                                     *
000700990526     F*                                                                *
000800081217     F*  DESCRIPTION - List primary broker errors                      *
001004020118     F*                                                                *
001005110114     F* 01/14/11 dlk - add coventry                                    *
001006130104     F* 01/04/13 dlk - add Aetna                                       *
001007150420     F* 04/20/15 dlk - add new carrier group codes for coventry and    *
001008150420     F*                aetna                                           *
001009150420     F*                                                                *
001100990526     F******************************************************************
001200081216     Fcomctx    IP   E             DISK
001501081216     Fcarmst    IF   E           K DISK
001502081216     Faccmst    IF   E           K DISK
001503081201     Fplnmst    IF   E           K DISK
0015100812160017 Frpa190xl  o  a e             DISK
0015110812010125 Dcsv              c                   const('","')
001606081204     Dacnamout         s             25
001607081204     Dpdesout          s             25
001608081216     Derror            s             30
0016221101140037 D selectit        S              1
0016230812160037 D plncnt          S              8  0
0016240812160037 D pricnt          S              8  0
002000081201     D                 DS
002800081201     D tsaout                  1     10  0
002801081216     D CMTRST                  1      3  0
002802081216     D CSUBDV                  4      6  0
002803081216     D CMACCT                  7     10  0
002805081216      * primary broker field from CMCT14
002806081216     D                 DS
002807081216     D  free5                  1      5
002808081216     D  cmprib                 1      1
002809081216
002810081201     D                UDS
002811081201     D  CONAME               201    240
003107010320
003108081216     icomcxr
003109081216     i                                          CMTRST        l1
003110081216     i                                          CSUBDV        l1
003111081216     i                                          CMACCT        l1
003112081216     i                                          CMPLAN        l1
003113081216      * select care first only
003114110114      * 01/14/11 - add coventry
003115081216     c                   if        *inl1
003116110114     c                   clear                   selectit
003117081216     c                   clear                   pdesout
003118081216     c                   clear                   plncnt
003119081216     c                   clear                   pricnt
003120081216
003121081216     C     plkey         CHAIN     plnmst
003122081216     c                   if        %found(plnmst)
003123081216     c                   movel     pdescr        pdesout
004403081216     C     pcarr         CHAIN     carmst
004404081216     c                   if        %found(carmst) and
004406081216     c                             carbc = '1' or carbc = '2' or
004407110114     c                             carbc = '3' or carbc = '4' or carbc = 'D' or
004408150420     c                             cgrpcd = 'CH' or cgrpcd = 'S2' or
004409150420     c                             cgrpcd = 'AH' or cgrpcd = 'S1'
004410110114     c                   eval      selectit = 'Y'
004411081216     c                   end
004412010702     c                   end
004413081216     c                   end
004414081216
004415081216      * count # of active comctx per plan and # of primary brokers selected
004416081216     c                   add       1             plncnt
004417081216     c                   if        cmprib = 'Y'
004418081216     c                   add       1             pricnt
004419081216     c                   end
004420081216
004421081216
004422110114     cl1                 if        selectit = 'Y'
004423081216     cl1                 exsr      #l1
004424081216     cl1                 end
004425081216
004426081216      * check for error
004427081216   01C     #l1           BEGSR
004431081216
004432081216     c                   clear                   error
004433081216
004434081216      * multiple brokers
004435081216     c                   if        plncnt > 1
004436081216     c                   if        pricnt = 0
004437081216     c                   eval      error = 'NO PRIMARY BROKER'
004438081216     c                   end
004439081216     c                   if        pricnt > 1
004440081216     c                   eval      error = 'MORE THAN 1 PRIMARY BROKER'
004441081216     c                   end
004442081216     c                   end
008341081216
008342081216      * single broker w/primary broker set up
008343081216     c                   if        plncnt = 1 and pricnt <> 0
008348081216     c                   eval      error = 'PRIMARY BROKER W/NO SPLIT'
008350081216     c                   end
008351081216
008352081216     c                   if        error <> *blanks
008353081216      * acct name
008354081216     c                   clear                   acnamout
008355081216     C     ackey         CHAIN     accmst
008356081216     c                   if        %found(accmst)
008357081216     c                   movel     acnam1        acnamout
008358081216     c                   end
008359081216
008360081202     c                   exsr      writexldet
008361081216     c                   end
008437081201
008438081201   01C                   ENDSR
0085130812010313 C*
0085140812010164 C*************************************************************
0085150812010164 C*                                                           *
0085160812010164 C* Write Spreadsheet Detail                                  *
0085170812010164 C*                                                           *
0085180812010164 C*************************************************************
008519081201     C     Writexldet    BEGSR
008520081201
008521081216     c                   clear                   rpa190fld
008522081216     C                   Eval      rpa190fld  = '"' +
008523081201     C                             %trim(%editw(tsaout:'0   -   -    ')) + csv +
008524081201     C                             %trim(acnamout)                      + csv +
008525081216     C                             %trim(cmplan)                        + csv +
008526081201     C                             %trim(pdesout)                       + csv +
008548081216     C                             %trim(error)                      + '",'
008549081201     C*
008550081216     C                   Write     rpa190r
0085510812010320 C                   ENDSR
008552081201     C*
008553081201     C/EJECT
008554081201     C*************************************************************
008555081201     C*                                                           *
008556081201     C* Write Spreadsheet heading                                 *
008557081201     C*                                                           *
008558081201     C*************************************************************
008559081201     C     Writexlhead   BEGSR
008560081201
008561081216     c                   clear                   rpa190fld
008562081216     C                   Eval      rpa190fld = '"' + 'ACCOUNT'      + csv +
008563081201     C                                              'ACC NAME'      + csv +
008564081201     C                                              'PLAN'          + csv +
008565081201     C                                              'PLAN DESC'     + csv +
008587081216     C                                              'ERROR'         + '",'
008588081216     C                   Write     rpa190r
008589081201     C*
0085900812010320 C                   ENDSR
008591081201
008900990526     C     *INZSR        BEGSR
009401010702     c     ackey         klist
009402081216     c                   kfld                    CMTRST
009403081216     c                   kfld                    CSUBDV
009404081216     c                   kfld                    CMACCT
009406081201     c     plkey         klist
009407081216     c                   kfld                    CMTRST
009408081216     c                   kfld                    CSUBDV
009410081216     c                   kfld                    CMPLAN
009411081216
009412081201     C                   Exsr      Writexlhead
009800990526     C                   ENDSR
