000100990526     F******************************************************************
000300081201     F*  rpa140     GROUP BENEFIT SERVICES                             *
000400990526     F*                                                                *
000500990526     F*            WRITTEN BY - DAVID KETTERMAN                        *
000600081201     F*            DATE - 12/01/08                                     *
000700990526     F*                                                                *
000800081202     F*  DESCRIPTION - List commission control changes                 *
001004020118     F*                                                                *
001005090929     F* 09/29/09 dlk - add carrier code                                *
001006091012     F* 10/12/09 dlk - add resolve user                                *
001007090929     F*                                                                *
001100990526     F******************************************************************
001200081201     Fcomhst    IP   E             DISK
001501010702     Faccmst    IF   E           K DISK
001502081201     Fplnmst    IF   E           K DISK
001503081202     Fcodesl1   IF   E           K DISK
0015040812020015 Fgbsecure  IF   E           K DISK
001505081202     fspragxr2  if   e           k disk
001506081202     fsmanrlt   if   e           k disk
001507081202     fagency    if   e           k disk
001508081202     fsupragcy  if   e           k disk
001509081202     fsman      if   e           k disk
0015100812010017 Frpa140xl  o  a e             DISK
0015110812010125 Dcsv              c                   const('","')
001602081201     d workdtymd       s               d   datfmt(*iso)
001603081201     d workdtmdy       s               d   datfmt(*usa)
001606081204     Dacnamout         s             25
001607081204     Dpdesout          s             25
001608090929     Dpcarout          s              3
001609081204     Dtrdesout         s             25
001610081204     Duserout          s             25
001611091012     Dresusrout        s             25
001612081201     Dchtrdatmdy       s             10
001613081201     Dwhatout          s             20
001614081201     Dfromout          s             15
001615081201     Dtoout            s             15
001616081204     Dstatout          s             10
001617081204     Dresout           s                   like(ldescr)
0016180812020037 D holdsman        S                   like(srsman)
0016190812020037 D holdag          S                   like(sxagcy)
0016200812020037 D holdsa          S                   like(sxsuper)
0016210812020037 D holdsmname      S             35
0016220812040037 D holdagname      S             30
0016230812040037 D holdsaname      S             30
002000081201     D                 DS
002800081201     D tsaout                  1     10  0
002801081201     D chtrust                 1      3  0
002802081201     D chsub                   4      6  0
002803081201     D chacc                   7     10  0
002804081201     D                UDS
002805081201     D  CONAME               201    240
002900981214     D  LTIME                242    247  0
003107010320
003108081202      * acct name
003109081201     c                   clear                   acnamout
004403010702     C     ackey         CHAIN     accmst
004404081201     c                   if        %found(accmst)
004406081201     c                   movel     acnam1        acnamout
004407010702     c                   end
004410081201
004411090929      * plan desc & carrier code
004412081201     c                   clear                   pdesout
004413090929     c                   clear                   pcarout
004414081201     C     plkey         CHAIN     plnmst
004415081201     c                   if        %found(plnmst)
004416081201     c                   movel     pdescr        pdesout
004417090929     c                   move      pcarr         pcarout
004418081201     c                   end
004419081202
004420081202      * transaction desc
004421081202     c                   clear                   trdesout
004422081202     C     chtrcod       CHAIN     codesl1
004423081202     c                   if        %found(codesl1)
004424081202     c                   movel     ldescr        trdesout
004425081202     c                   end
004426081201
004427081204      * resolution description
004428081204     c                   clear                   resout
004429081204     C     chrscod       CHAIN     codesl1
004430081204     c                   if        %found(codesl1)
004431081204     c                   movel     ldescr        resout
004432081204     c                   end
004433081204
004434091012      * resolution user
004435091012     c                   clear                   resusrout
004436091012     c     chrsusr       chain     gbsecure
004437091012     c                   if        %found(gbsecure)
004438091012     c                   movel     scname        resusrout
004439091012     c                   end
004440091012
004441081202      * user
004442081202     c                   clear                   userout
004443081202     c     chuser        chain     gbsecure
004444081202     c                   if        %found(gbsecure)
004445081202     c                   movel     scname        userout
004446081202     c                   end
004447081202
004448081204      * status
004449081204     c                   clear                   statout
004450081204     c                   select
004451081204     c                   when      chstat = ' '
004452081204     c                   movel     'NEW'         statout
004453081204     c                   when      chstat = 'C'
004454081204     c                   movel     'CLOSED'      statout
004455081204     c                   when      chstat = 'O'
004456081204     c                   movel     'OPEN'        statout
004457081204     c                   endsl
004458081204
004459081201      * convert to mdy
004460081201     C                   move      chtrdat       workdtmdy
004461081201     C                   move      workdtmdy     chtrdatmdy
004462081201
004463081201     c                   exsr      #whatchanged
008303010320
008318010702     c     #end          tag
008319081201
008320081202      *************************************
008321081202      * what changed?                     *
008322081202      *************************************
008324081201   01C     #whatchanged  BEGSR
008325081201   01
008329081202     c                   exsr      #clearwft
008330081202     c                   exsr      #getrel
008331081202
008333081202     C                   MOVE      chaeff        @DATIN
008334081202     C                   EXSR      #DATYM
008335081202     C                   MOVE      @DATOU        chaeffmdy         8 0
008336081202     C                   MOVE      chacan        @DATIN
008337081202     C                   EXSR      #DATYM
008338081202     C                   MOVE      @DATOU        chacanmdy         8 0
008339081202
008340081202      * if add, write rec with after info only
008341081202   01C                   if        chtrcod = 'LAC'
008342081202     c                   exsr      writexldet
008343081202     c                   leavesr
008344081202     c                   end
008345081202   01
008347081202      * effective date change
008348081202     c                   if        chbeff <> chaeff
008349081202     c                   exsr      #clearwft
008352081202     c                   eval      whatout = 'EFFECTIVE DATE'
008353081202     C                   MOVE      chbeff        @DATIN
008354081202     C                   EXSR      #DATYM
008355081202     C                   MOVE      @DATOU        chbeffmdy         8 0
008356081202     c                   eval      fromout = %trim(%editc(chbeffmdy:'Y'))
008357081202     c                   eval      toout   = %trim(%editc(chaeffmdy:'Y'))
008358081202     c                   exsr      writexldet
008359081202     c                   end
008360081202
008361081202      * cancel date change
008362081202     c                   if        chbcan <> chacan
008363081202     c                   exsr      #clearwft
008364081202     c                   eval      whatout = 'CANCEL DATE'
008365081202     C                   MOVE      chbcan        @DATIN
008366081202     C                   EXSR      #DATYM
008367081202     C                   MOVE      @DATOU        chbcanmdy         8 0
008368081202     c                   eval      fromout = %trim(%editc(chbcanmdy:'Y'))
008369081202     c                   eval      toout   = %trim(%editc(chacanmdy:'Y'))
008370081202     c                   exsr      writexldet
008371081202     c                   end
008372081202
008373081202      * relation id change
008374081202     c                   if        chbrel <> charel
008375081202     c                   exsr      #clearwft
008376081202     c                   eval      whatout = 'RELATION ID'
008377081202     c                   eval      fromout = chbrel
008378081202     c                   eval      toout   = charel
008379081202     c                   exsr      writexldet
008380081202     c                   end
008381081202
008382081202      * % of prem change
008383081202     c                   if        chbpop <> chapop
008384081202     c                   exsr      #clearwft
008385081202     c                   eval      whatout = '% OF PREM'
008386081202     c                   eval      fromout = %trim(%editc(chbpop:'L'))
008387081202     c                   eval      toout   = %trim(%editc(chapop:'L'))
008388081202     c                   exsr      writexldet
008389081202     c                   end
008390081202
008391081202      * flat fee change
008392081202     c                   if        chbff  <> chaff
008393081202     c                   exsr      #clearwft
008394081202     c                   eval      whatout = 'FEE'
008395081202     c                   eval      fromout = %trim(%editc(chbff:'L'))
008396081202     c                   eval      toout   = %trim(%editc(chaff:'L'))
008397081202     c                   exsr      writexldet
008398081202     c                   end
008399081202
008400081202      * % of com change
008401081202     c                   if        chbpoc <> chapoc
008402081202     c                   exsr      #clearwft
008403081202     c                   eval      whatout = '% OF COM'
008404081202     c                   eval      fromout = %trim(%editc(chbpoc:'L'))
008405081202     c                   eval      toout   = %trim(%editc(chapoc:'L'))
008406081202     c                   exsr      writexldet
008407081202     c                   end
008408081202
008409081202      * pay no com change
008410081202     c                   if        chbpnc <> chapnc
008411081202     c                   exsr      #clearwft
008412081202     c                   eval      whatout = 'PAY NO COMM'
008413081202     c                   eval      fromout = chbpnc
008414081202     c                   eval      toout   = chapnc
008415081202     c                   exsr      writexldet
008416081202     c                   end
008417081202
008418081202      * split change
008419081202     c                   if        chbcmsp <> chacmsp
008420081202     c                   exsr      #clearwft
008421081202     c                   eval      whatout = 'SPLIT'
008422081202     c                   eval      fromout = %trim(%editc(chbcmsp:'L'))
008423081202     c                   eval      toout   = %trim(%editc(chacmsp:'L'))
008424081202     c                   exsr      writexldet
008425081202     c                   end
008426081202
008427081202      * primary sman change
008428081202     c                   if        chbpri <> chapri
008429081202     c                   exsr      #clearwft
008430081219     c                   eval      whatout = 'PRIMARY BROKER'
008431081202     c                   eval      fromout = chbpri
008432081202     c                   eval      toout   = chapri
008433081202     c                   exsr      writexldet
008434081202     c                   end
008435081202
008437081201
008438081201   01C                   ENDSR
008439081202
008440081202      *************************************
008441081202      * clear what, from & to fields      *
008442081202      *************************************
008443081202   01C     #clearwft     BEGSR
008444081202     c                   clear                   whatout
008445081202     c                   clear                   fromout
008446081202     c                   clear                   toout
008447081202   01C                   ENDSR
008448081201
008449081202      *************************************
008450081202      * get relation info                 *
008451081202      *************************************
008452081202   01C     #getrel       BEGSR
008453081202
008454081202     c                   clear                   holdsman
008455081202     c                   clear                   holdsmname
008456081202     c                   clear                   holdsa
008457081202     c                   clear                   holdag
008458081202     c                   clear                   holdsaname
008459081202     c                   clear                   holdagname
008460081202
0084610812020063 C     charel        CHAIN     smanrlt
008462081202     c                   if        %found(smanrlt)
008467081202    * * sman info from relation
008468081202     c                   eval      holdsman = srsman
008469081202     c     srsman        chain     sman
008470081202     c                   if        %found(sman)
008471081202     c                   eval      holdsmname = %trim(sfname)
008472081202     c                   if        smi <> ' '
008473081202     c                   cat       smi:1         holdsmname
008474081202     c                   end
008475081202     c                   cat       slname:1      holdsmname
008476081202     c                   end
008477081202    *
008478081202      * get SA xref
008479081202     c     srasid        chain     spragxr2
008480081202     c                   if        %found(spragxr2)
008481081202     c                   eval      holdsa = sxsuper
008482081202     c                   eval      holdag = sxagcy
008483081202      * get super agency name
008484081202     c     sxsuper       chain     supragcy
008485081202     c                   if        %found(supragcy)
008486081202     c                   eval      holdsaname = %trim(saname1)
008487081202     c                   end
008488081202      * get agency name
008489081202     c     sxagcy        chain     agency
008490081202     c                   if        %found(agency)
008491081202     c                   eval      holdagname = %trim(agnam1)
008492081202     c                   end
008493081202     c                   end
008494081202
008495081202     c                   end
008496081202
008497081202   01C                   ENDSR
008498010702   01C*****************************************************
008499010702   01C*   CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
008500010702   01C*****************************************************
008501010702   01C*
008502010702   01C*   DATE IN  = @DATIN (8.0) YYYYMMDD
008503010702   01C*   DATE OUT = @DATOU (8.0) MMDDYYYY
008504010702   01C*
008505010702   01C     #DATYM        BEGSR
008506010702   01C                   MOVE      @DATIN        @MD               4 0
008507010702   01C                   MOVEL     @DATIN        @Y                4 0
008508010702   01C                   MOVEL     @MD           @DATOU            8 0
008509010702   01C                   MOVE      @Y            @DATOU
008510010702   01C                   MOVE      *ZEROS        @DATIN            8 0
008511010702   01C                   ENDSR
008512010702
0085130812010313 C*
0085140812010164 C*************************************************************
0085150812010164 C*                                                           *
0085160812010164 C* Write Spreadsheet Detail                                  *
0085170812010164 C*                                                           *
0085180812010164 C*************************************************************
008519081201     C     Writexldet    BEGSR
008520081201
008521081201     c                   clear                   rpa140fld
008522081201     C                   Eval      rpa140fld  = '"' +
008523081201     C                             %trim(%editw(tsaout:'0   -   -    ')) + csv +
008524081201     C                             %trim(acnamout)                      + csv +
008525081201     C                             %trim(chplan)                        + csv +
008526081201     C                             %trim(pdesout)                       + csv +
008527090929     C                             %trim(pcarout)                       + csv +
008528081201     C                             %trim(chtrdatmdy)                    + csv +
008529081201     C                             %char(chtrtim)                       + csv +
008530081202     C                             %trim(userout)                       + csv +
008531081204     C                             %trim(statout)                       + csv +
008532081204     C                             %trim(resout)                        + csv +
008533081204     C                             %trim(chrsnot)                       + csv +
008534091012     C                             %trim(resusrout)                     + csv +
008535081204     C                             %trim(trdesout)                      + csv +
008536081201     C                             %trim(whatout)                       + csv +
008537081201     C                             %trim(fromout)                       + csv +
008538081201     C                             %trim(toout)                         + csv +
008539081202     C                             %trim(%editc(chaeffmdy:'Y'))         + csv +
008540081202     C                             %trim(%editc(chacanmdy:'Y'))         + csv +
008541081201     C                             %trim(CHAREL)                        + csv +
008542081202     C                             %trim(holdsmname)                    + csv +
008543081202     C                             %trim(holdagname)                    + csv +
008544081202     C                             %trim(holdsaname)                    + csv +
008545081202     C                             %trim(%editc(chapop:'M'))            + csv +
008546081201     C                             %trim(%editc(chaff:'M'))             + csv +
008547081201     C                             %trim(%editc(chapoc:'M'))            + csv +
008548081201     C                             %trim(CHAPNC)                        + csv +
008549081201     C                             %trim(%editc(chacmsp:'M'))           + csv +
008550081201     C                             %trim(CHAPRI)                + '",'
008551081201     C*
008552081201     C                   Write     rpa140xr
0085530812010320 C                   ENDSR
008554081201     C*
008555081201     C/EJECT
008556081201     C*************************************************************
008557081201     C*                                                           *
008558081201     C* Write Spreadsheet heading                                 *
008559081201     C*                                                           *
008560081201     C*************************************************************
008561081201     C     Writexlhead   BEGSR
008562081201
008563081201     c                   clear                   rpa140fld
008564081201     C                   Eval      rpa140fld = '"' + 'ACCOUNT'      + csv +
008565081201     C                                              'ACC NAME'      + csv +
008566081201     C                                              'PLAN'          + csv +
008567081201     C                                              'PLAN DESC'     + csv +
008568090929     C                                              'CARRIER'       + csv +
008569081201     C                                              'DATE'          + csv +
008570081201     C                                              'TIME'          + csv +
008571081201     C                                              'USER'          + csv +
008572081204     C                                              'STATUS'        + csv +
008573081204     C                                              'RESOLUTION'    + csv +
008574081204     C                                              'NOTE'          + csv +
008575091012     C                                              'RESOL. USER'   + csv +
008576081201     C                                              'TRANSACTION'   + csv +
008577081201     C                                              'WHAT CHANGED'  + csv +
008578081201     C                                              'FROM'          + csv +
008579081201     C                                              'TO'            + csv +
008580081201     C                                              'EFFECTIVE'     + csv +
008581081201     C                                              'CANCEL'        + csv +
008582081201     C                                              'RELATION'      + csv +
008583081202     C                                              'SALESMAN'      + csv +
008584081202     C                                              'AGENCY'        + csv +
008585081202     C                                              'SUPER AGENCY'  + csv +
008586081201     C                                              '% OF PREM'     + csv +
008587081201     C                                              'FEE'           + csv +
008588081201     C                                              '% OF COM'      + csv +
008589081201     C                                              'NO COM'        + csv +
008590081201     C                                              'SPLIT'         + csv +
008591081201     C                                              'PRIMARY'       + '",'
008592081201     C                   Write     rpa140xr
008593081201     C*
0085940812010320 C                   ENDSR
008595081201
008900990526     C     *INZSR        BEGSR
009401010702     c     ackey         klist
009402081201     c                   kfld                    CHTRUST
009403081201     c                   kfld                    CHSUB
009404081201     c                   kfld                    CHACC
009405081201
009406081201     c     plkey         klist
009407081201     c                   kfld                    CHTRUST
009408081201     c                   kfld                    CHSUB
009409081201     c                   kfld                    CHplan
009410081201
009411081201     C                   Exsr      Writexlhead
009800990526     C                   ENDSR
