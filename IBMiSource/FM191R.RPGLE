000100140219     FINVDNP    IF   E           K DISK
000200140219     FGBSECURE  IF   E           K DISK
000300140219     FACCMST    IF   E           K DISK
0004001402190015 Fhistaa    iF A E           K DISK
000500140219     FFM19CSVP  O  A F 2000        DISK
000600050823   X***X
000700060315     D @OUTPUT         S           2000A   INZ
000800051108     D @C              C                   CONST('","')
000900140219    * *
001000140219     D                 DS
001100140219     D  TSA                    1     10  0
001200140219     D  indtrust               1      3  0
001300140219     D  indsub                 4      6  0
001400140219     D  indacc                 7     10  0
001500140219     D   TSAA                  1     10
001600140219      *
001700140219     D                 DS
001800140219     D  KHIST                  1     30
001900140219     D   KHIST1                1      5    INZ('INV#-')
002000140219     D   KHIST2                6     12
002100140219     D   KHIST3               13     30    INZ(*BLANKS)
002200140219    * *
002300140219     D xinv            S              7A
002400140219     D xtrst           S              3A
002500140219     D xsub            S              3A
002600140219     D xacct           S              4A
002700140219     D xdate           S             10A
002800140219     D xtime           S             10A
002900140219     D wkdate          S               D   DATFMT(*USA/)
003000140219     D wktime          S               T   TIMFMT(*HMS:)
003100140219     D voidyn          S              1A
003200140219     dtravi            s              3    inz('AVI')
0033001401140025  *
003400140219     C     acckey        klist
003500140219     C                   kfld                    indtrust
003600140219     C                   kfld                    indsub
003700140219     C                   kfld                    indacc
003800140219      *
003900140219     C     hisaky        KLIST
004000140219     C                   KFLD                    tsaa
004100140219     C                   KFLD                    travi
004200140109      ******************************************************************
004300140114   X* *        Build Header Row
004400140114     C                   CLEAR                   @OUTPUT
004500140219     C                   EVAL      @OUTPUT = 'TRUST' + ',' +
004600140219     C                             'SUB#' + ',' +
004700140219     C                             'ACCT' + ',' +
004800140219     C                             'ACCOUNT NAME,' +
004900140219     C                             'CANCELED,' +
005000140219     C                             'INVOICE,' +
005100140219     C                             'REASON,' +
005200140219     C                             'VOID,' +
005300140219     C                             'USER,' +
005400140219     C                             'DATE,' +
005500140219     C                             'TIME'
005600140114    * *
005700140114     C                   EXCEPT    OUTFA
005800140114   X* *
005900140219     C     *LOVAL        setll     invdnp                             21
006000140109     C                   dou       *in21 = '1'
006100110419      *
006200140219     C                   read      invdnp                                 21
006300140219     C                   if        *in21 = '0'
006400140219   X* *
006500140219     C                   movel     *blanks       acctnm           40
006600140219     C                   movel     *blanks       xdel              1
006700140219     C     acckey        chain     accmst                             23
006800140219     C                   if        *in23 = '0'
006900140219     C                   movel     acnam1        acctnm
007000140219     C                   movel     acdltd        xdel
007100140219     C                   endif
007200140109      *
007300140219     C                   movel     *blanks       usernm           40
007400140219     C     induser       chain     gbsecure                           23
007500140219     C                   if        *in23 = '0'
007600140219     C                   movel     scname        usernm
007700140219     C                   endif
007800140219      *      See in Invoice is Voided
007900140219     C                   EVAL      KHIST2 = %EDITC(indinv# : '3')
008000140219     C                   EVAL      voidyn = 'N'
008100140219     C     hisaky        SETLL     histaa
008200140219     C                   dou       *in61 = '1'
008300140219     C     hisaky        reade     histaa                                 61
008400140219     C                   if        *in61 = *off
008500140219     C                   if        khist = ck#not
008600140219     C                   eval      voidyn = 'Y'
008700140219     C                   leave
008800140219     C                   endif
008900140219     C                   endif
009000140219     C                   enddo
009100140219      *
009200140219     C                   eval      xinv = %EDITC(indinv#:'3')
009300140219     C                   eval      xtrst = %EDITC(indtrust:'3')
009400140219     C                   eval      xsub = %EDITC(indsub:'3')
009500140219     C                   eval      xacct = %EDITC(indacc:'3')
009600140219     C                   eval      wkdate = inddate
009700140219     C                   move      wkdate        xdate
009800140219     C                   eval      wktime = indtime
009900140219     C                   move      wktime        xtime
010000140219      *
010100170719     C                   if        xdel = 'A' and voidyn = 'N'
010200170719      *
010300080313     C                   CLEAR                   @OUTPUT
010400140219     C                   EVAL      @OUTPUT = %TRIM(xtrst) + ',' +
010500140219     C                             %TRIM(xsub) + ',' +
010600140219     C                             %TRIM(xacct) + ',' + '"' +
010700140219     C                             %TRIM(acctnm) + '"' + ',' +
010800140219     C                             %TRIM(xdel) + ',' +
010900140307     C                             %TRIM(xinv) + ',' + '"' +
011000140307     C                             %TRIM(indreas) + '"' + ',' +
011100140307     C                             %TRIM(voidyn) + ',' + '"' +
011200140219     C                             %TRIM(usernm) + '"' + ',' +
011300140219     C                             %TRIM(xdate) + ',' +
011400140219     C                             %TRIM(xtime)
011500140109    * *
011600060315     C                   EXCEPT    OUTFA
011700170719    * *
011800170719     C                   endif
011900140109    * *
012000140109     C                   endif
012100140109    * *
012200140109     C                   enddo
012300140109     C                   eval      *inlr = '1'
012400140109     C                   return
012500070403   S***S
012600070403     C**** *INZSR        BEGSR
012700070403    ***
012800070403     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
012900070403     C****                         '"FIELD D"'
013000070403    ***
013100070403     C****               EXCEPT    OUTFA
013200070403    ***
013300070403     C**************     ENDSR
013400070403   S***S
013500070403   X***X
013600060315    ***
013700140219     OFM19CSVP  EADD         OUTFA
013800060315     O                       @OUTPUT           2000
