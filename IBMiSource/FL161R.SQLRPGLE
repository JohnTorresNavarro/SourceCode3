0001000502280020 Ffl160wf   o  a e             DISK
000200050228   X***X
000300050228     d @t              s              3a
000400050228     d @s              s              3a
000500050228     d @p              s              4a
000600050228     d @d              s              8a
000700050228     d #t              s              3s 0
000800050228     d #s              s              3s 0
000900050228     d #d              s              8s 0
001000050228    ***
001100050228     D selecttwo       s            500a
0012000502280040 D selectone       S            500a   inz('SELECT CRTRST, CRSUBD, CRPLAN, -
0013000502280040 D                                     CSLSTP, COMTYP, CRPTYP, COMRTE, -
0014000502280040 D                                     CRPRTE, COMPRD, FRDATE, TODATE -
0015000502280040 D                                     from QS36F/"F.CRATE" WHERE CRDLTD -
0016000502280040 D                                     =')
0017000502280040 D APOST           S              1a   inz('''')
001800050228    ***
001900050228   X***X
002000050228     c                   exsr      $prep
002100050228     c                   exsr      $load
002200050228     c                   exsr      $close
002300050228     c                   eval      *inlr = *on
002400050228   S***S
002500050228     c     $prep         begsr
002600050228    ***
002700050228     C                   eval      selecttwo = %trim(selectone) + ' ' + apost +
002800050228     c                             'A' + apost + ' '
002900050228    ***
003000050228     c                   if        @t <> 'ALL'
003100050228     C                   eval      selecttwo = %trim(selecttwo) +
003200050228     c                                      ' AND CRTRST = ' + @t + ' '
003300050228     c                   endif
003400050228    ***
003500050228     c                   if        @s <> 'ALL'
003600050228     C                   eval      selecttwo = %trim(selecttwo) +
003700050228     c                                      ' AND CRSUBD = ' + @s + ' '
003800050228     c                   endif
003900050228    ***
004000050228     c                   if        @p <> 'ALL '
004100050228     C                   eval      selecttwo = %trim(selecttwo) + ' AND CRPLA' +
004200050228     C                             'N = ' + apost + @p + apost + ' '
004300050228     c                   endif
004400050228    ***
004500050228     c                   if        @d <> '00000000'
004600050228     C                   eval      selecttwo = %trim(selecttwo) + ' FRDATE = ' +
004700050228     c                             %editc(#d:'X') + ' '
004800050228     c                   endif
004900050228    ***
005000050228     c/exec sql
005100050228     c+ prepare sel from :selecttwo
005200050228     c/end-exec
005300050228    ***
005400050228     c/exec sql
005500050228     c+ declare mycsr scroll cursor for sel
005600050228     c/end-exec
005700050228    ***
005800050228     c/exec sql
005900050228     c+ open MYCSR
006000050228     c/end-exec
006100050228    ***
006200050228     c                   endsr
006300050228   S***S
006400050228     c     $load         begsr
006500050228    ***
006600050228     c                   dow       sqlcod = 0
006700050228    ***
006800050228     c                   clear                   f160
006900050228    ***
007000050228     c/exec sql
007100050228     c+ fetch next from MYCSR
007200050228     c+  into :crtrst, :crsubd, :crplan, :cslstp, :comtyp, :crptyp,
007300050228     c+       :comrte, :crprte, :comprd, :frdate, :todate
007400050228     c/end-exec
007500050228    ***
007600050228     c                   if        sqlcod = 0
007700050228     C                   WRITE     f160
007800050228     c                   end
007900050228    ***
008000050228     c                   enddo
008100050228    ***
008200050228     c                   endsr
008300050228     c******************************************
008400050228     c* close SQL cursor                       *
008500050228     c******************************************
008600050228     c     $close        begsr
008700050228    ***
008800050228     c/exec sql
008900050228     c+ close MYCSR
009000050228     c/end-exec
009100050228    ***
009200050228     c                   endsr
009300050228   S***S
009400050228   S***S
009500050228     c     *inzsr        begsr
009600050228     c     *entry        plist
009700050228     c                   parm                    @t
009800050228     c                   parm                    @s
009900050228     c                   parm                    @p
010000050228     c                   parm                    @d
010100050228     c                   if        @t <> 'ALL'
010200050228     c                   move      @t            #t
010300050228     c                   endif
010400050228     c                   if        @s <> 'ALL'
010500050228     c                   move      @s            #s
010600050228     c                   endif
010700050228     c                   if        @d <> '00000000'
010800050228     c                   move      @d            #d
010900050228     c                   endif
011000050228     c                   endsr
011100050228   S***S
