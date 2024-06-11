000100140312     H option(*nodebugio) alwnull(*usrctl) debug
000200991124     F*-------------------------------------------------------------------------
000300150415     F* REFPLNR    GBS SOFTWARE 2015
000400081111     F*            WRITTEN BY - RLJ
000500150512     F*            DATE - 05/2015
000600150512     F*  DESCRIPTION - Look for HRA/FSA plans in an account and send
000700150512     F*                email to SF group.
000800991124     F*-------------------------------------------------------------------------
000900991209     ** MODIFICATION HISTORY                                              **
001000150304     ** xxx mm/dd/yyyy -
001100991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001200150415     FCOMCTUNIQ IF   E           K DISK
001300150415     FPLNMST    IF   E           K DISK
001400150512     FGRAT25    IF   E           K DISK
001500150512      *
001600150512     D @PARM           DS
001700150512     D  TRSTA                  1      3
001800150512     D   ntrst                 1      3  0
001900150512     D  SUB#A                  4      6
002000150512     D   nsub#                 4      6  0
002100150512     D  ACCTA                  7     10
002200150512     D   nacct                 7     10  0
002300141222   X* *
002400150415     D                 DS
002500150512     D emsg            S            255A
002600150415     D svplan          S                   LIKE(cmplan)
002700150512     D date9           S              8  0 INZ(99999999)
002800150204      *
002900150204     D                 DS
003000150512     D  eacct                  1     12
003100150512     D   eatrst                1      3
003200150512     D   ead1                  4      4    INZ('-')
003300150512     D   easub#                5      7
003400150512     D   ead2                  8      8    INZ('-')
003500150512     D   eaacct                9     12
003600150512      *
003700150512     D                 DS
003800150512     D  eplan                  1     12
003900150512     D   eptrst                1      3
004000150512     D   epd1                  4      4    INZ('-')
004100150512     D   epsub#                5      7
004200150512     D   epd2                  8      8    INZ('-')
004300150512     D   epplan                9     12
004400150107      *
004500081111      *
0046001304230053 D                 DS
0047001505120054 D  hra1           C                   'HRA Plan '
0048001505120054 D  hra2           C                   ' has been reinstated for account '
0049001505120054 D  hra3           C                   '. The GROUP# for the plan is '
005000150512    * *
0051001505120054 D  fsa1           C                   'FSA Plan '
0052001505120054 D  fsa2           C                   ' has been reinstated for account '
0053001505120054 D  fsa3           C                   '. The GROUP# for the plan is '
005400150512    * *
005500150512     C     *ENTRY        PLIST
005600150512     C                   PARM                    @PARM
005700150512    * *
005800130426     C     keytsa        KLIST
005900150512     C                   KFLD                    ntrst
006000150512     C                   KFLD                    nsub#
006100150512     C                   KFLD                    nacct
006200150415    * *
006300150415     C     keypln        KLIST
006400150415     C                   KFLD                    cmtrst
006500150415     C                   KFLD                    csubdv
006600150415     C                   KFLD                    cmplan
006700150512    * *
006800150512     C     keyrat        KLIST
006900150512     C                   KFLD                    cmtrst
007000150512     C                   KFLD                    csubdv
007100150512     C                   KFLD                    cmplan
007200150512     C                   KFLD                    date9
007300130426    * *
007400130423      * MAINLINE
007500130423    * *
007600150512     C                   eval      eatrst = trsta
007700150512     C                   eval      eptrst = trsta
007800150512     C                   eval      easub# = sub#a
007900150512     C                   eval      epsub# = sub#a
008000150512     C                   eval      eaacct = accta
008100150512    * *
008200150512     C     keytsa        setll     comctuniq                          34
008300150415     C     *IN34         DOUEQ     *ON
008400150415     C     keytsa        reade     comctuniq                              34
008500150512     C                   if        *in34 = '1' or nacct <> cmacct
008600150415     C                   leave
008700150415     C                   endif
008800150415      *
008900150415     C                   if        cmplan = svplan
009000150415     C                   iter
009100150415     C                   endif
009200150415      *
009300150415     C                   eval      svplan = cmplan
009400150415      *
009500150415     C     keypln        chain     plnmst                             21
009600150415     C                   if        *in21 = '0'
009700150512      *
009800150512     C                   if        pcarr = 'SAF'
009900150512     C                   exsr      sndfsa
010000150512     C                   endif
010100150512      *
010200150512     C                   if        pcarr = 'MBC' or pcarr = 'MBF'
010300150512     C                   exsr      sndhra
010400150512     C                   endif
010500150415      *
010600150512     C                   endif
010700150512      *
010800150512     C                   enddo
010900150512      *
011000150512     C                   MOVE      *ON           *INLR
011100150512     C                   RETURN
011200150415      ******************************************************************
011300150512      *       SUBROUTINE - SNDFSA                                      *
011400150512      *             Send Reinstate FSA plan email                      *
011500150415      ******************************************************************
011600150512     C     SNDFSA        BEGSR
011700150512    * *
011800150512     C                   eval      epplan = cmplan
011900150512     C                   eval      emsg = *blanks
012000150512      *
012100150512     C     keyrat        setll     grat25
012200150512     C                   read      grat25
012300150512      *
012400150512     C                   eval      emsg = (fsa1 + eplan + fsa2 + eacct + fsa3 +
012500150512     C                             group#)
012600150512    * *
012700150512     C                   Call      'EMALFSAC'
012800150512     C                   Parm                    EMSG
012900150512    * *
013000150415     C                   ENDSR
013100150512      ******************************************************************
013200150512      *       SUBROUTINE - SNDHRA                                      *
013300150512      *             Send Reinstate HRA plan email                      *
013400150512      ******************************************************************
013500150512     C     SNDHRA        BEGSR
013600150512    * *
013700150512     C                   eval      epplan = cmplan
013800150512     C                   eval      emsg = *blanks
013900150512      *
014000150512     C     keyrat        setll     grat25
014100150512     C                   read      grat25
014200150512     C                   eval      emsg = (hra1 + eplan + hra2 + eacct + hra3 +
014300150512     C                             group#)
014400150512    * *
014500150512     C                   Call      'EMALHRAC'
014600150512     C                   Parm                    EMSG
014700150512    * *
014800150512     C                   ENDSR
