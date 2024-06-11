000001190826      * dlk 8/26/19 - this program will remove the abrhist rec to allow
000002190826      * the date / seq to be restarted after commission errors were found
000003190826      * at the beginning of the dw040cl / dw260cl run causing it to end.
000004190826      *
0001001908260005 Fabrhist   uf   e           k disk
0001021908260055 D                uds
0001031908260056 D  leffmdy               85     92
0001041908260056 D  lseq                  21     22
0001051908260056 D  labrcode             200    200
000106051018
000107190826      * change mdy to ymd
000112190826     c                   move      leffmdy       @datin
000113190826     c                   exsr      #datym
000114190826     c                   move      @datou        effymd            8 0
000115190826
000116190826     c                   move      lseq          runseq            2 0
000118190826
000119190826      * remove the record
000120190826     C     abrkey        CHAIN     abrhist
000121190826     c                   if        %found(abrhist)
000122190826     c                   delete    abrr
000123190826     c                   end
000124190826
000500051018     c                   eval      *inlr = *on
0006001908260103 C***************************************************
0007001908260104 C* CONVERT FIELD FROM YMD TO MDY or MDY TO YMD
0008001908260105 C***************************************************
0009001908260106 C     #DATYM        BEGSR
001000190826     C                   MOVE      @DATIN        @MD               4 0
001100190826     C                   MOVEL     @DATIN        @Y                4 0
001200190826     C                   MOVEL     @MD           @DATOU            8 0
001300190826     C                   MOVE      @Y            @DATOU
001400190826     C                   MOVE      *ZEROS        @DATIN            8 0
0015001908260120 C                   ENDSR
001501190826
001502190826     C     *inzsr        BEGSR
001503190826     C     abrkey        KLIST
001504190826     C                   KFLD                    effymd
001505190826     C                   KFLD                    labrcode
001506190826     C                   KFLD                    runseq
001509190826     C                   ENDSR
