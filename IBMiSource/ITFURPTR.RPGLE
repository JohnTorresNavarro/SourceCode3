000100991124     F*-------------------------------------------------------------------------
000200150728     F* ITFURPTR   GBS SOFTWARE 2015
000300141024     F*            WRITTEN BY - RLJ
000400150728     F*            AATE - 07/2015
000500150728     F*  DESCRIPTION - Create IT Follow Up Date Report File
000600141024     F*
000700991124     F*-------------------------------------------------------------------------
000800991209     ** MODIFICATION HISTORY                                              **
000900140925     ** xxx mm/dd/yyyy -
001000141024     **                                                                   **
001100140925     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001200150728     FITISSP    IP   E             DISK
001300150902     FITSTAFP   IF   E           K DISK
001400150728     FITFUDP    O    E             DISK
001500140804      *
001600131231    *** TIMESTAMP FIELDS DATA STRUCTURE
001700140804      *
001800140911     D @TIMESTAMP      DS
001900140911     D  #TSCYMD                1      8S 0
002000140911     D  #TSTIME                9     14S 0
002100140911     D  @TSJOB                15     24
002200140911     D  @TSUSER               25     34
002300140911     D  #TSNBR                35     40S 0
002400140123    * *
002500130424     D                 DS
0026001408150037 D wktime          S               T   timfmt(*hms:)
0027001408150037 D wkdate          S               D   datfmt(*iso)
0028001408040037 D sysZateymd      S               D   datfmt(*iso)
002900150728     D today           S              8S 0
003000150728     D @TS40           S             40A
003100150902     D kinit           S             10A
003200150514    * *
003300131231    * *
003400150728     C                   if        itsts = 'O' and today >= itfudt
003500140926      *
003600150728     C                   clear                   itfudr
003700140926      *
003800150728     C                   eval      ifinit = itinit
003900150728     C                   eval      iftrst = ittrst
004000150728     C                   eval      ifsub# = itsub#
004100150728     C                   eval      ifacct = itacct
004200150728     C                   eval      ifmssn = itmssn
004300150728     C                   eval      ifiss# = itiss#
004400150728     C                   eval      iffudt = itfudt
004500150728     C                   eval      iftypc = ittypc
004600150728     C                   eval      ifdato = itdato
004700150728     C                   eval      ifsbjt = itsbjt
004800150728     C                   eval      ifrefr = itrefr
004900150728     C                   eval      ifrefd = itrefd
005000140926      *
005100150902     C                   movel(P)  itinit        kinit
005200150902     C     kinit         chain     itstafp                            21
005300150902     C                   if        *in21 = '0'
005400150902     C                   eval      ifieml = isemad
005500150902     C                   eval      ifsupv = issupv
005600150902     C                   eval      ifseml = isseml
005700150902     C                   eval      ifmgr  = ismgr
005800150902     C                   eval      ifmeml = ismeml
005900150902     C                   endif
006000150902      *
006100150728     C                   write     itfudr
006200150728    * *
006300150728     C                   Endif
0064001507280107  ********************************************************************************
0065001507280107  *
0066001507280107  *     INZSR - Preprocessing
0067001507280107  *
0068001507280107  ********************************************************************************
006900150728     C     *Inzsr        Begsr
007000150728    * *   Pre-processing
007100150728    * *
007200150728     C                   CLEAR                   @TIMESTAMP
007300150728     C                   MOVE      *BLANKS       @TS40
007400150728     C                   CALL      'TIMESTMP'
007500150728     C                   PARM                    @TS40
007600150728     C                   MOVEL     @TS40         @TIMESTAMP
007700150728     C                   MOVE      #TSCYMD       today
007800150728    * *
007900150728     C                   Endsr
