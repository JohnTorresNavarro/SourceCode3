0001001205240002  ******************************************************************
0002001302260003  * PRFXNOR    GROUP BENEFIT SERVICES SOFTWARE           2013      *
0003001209270007  *                                                                *
0004001209270005  *            WRITTEN BY - R.L.J.                                 *
0005001302130006  *            DATE - Feb 2013                                     *
0006001209270007  *                                                                *
000700120524      *  CHANGES: xxx mm/dd/yyyy                                       *
000800120524      *  xxx mm/dd/yyyy
0009001205240009  ******************************************************************
0010001109090010  *                                                                *
001100130226     FCLASS     IP   E           K DISK
001200130226     FPLNMST    IF   E           K DISK
001300130315     FACCMST    IF   E           K DISK
001400130226     FCODES     IF   E           K DISK
001500130226     FGRAT25    IF   E           K DISK
001600130221     FCMCTPLDT  IF   E           K DISK
001700130226     FPRFXBLKP  O    E             DISK
001800110831      *
001900110831     D                 DS
002000130226     D  plncat                 1      3
002100130226     D   cod1                  1      1
002200130226     D   cod23                 2      3
002300120524      *
002400120524     D                 DS
002500130315     D  todate                         D   DATFMT(*ISO)
002600130315     D  todatx                        8  0
002700120524     D  kgrp#                        15
002800120914     D  kggrp#                       20
002900130226     D  zerfnd                        1
003000130214     D  htrst                              LIKE(GRTRST)
003100130214     D  hsub#                              LIKE(GRSUB#)
003200130214     D  hplan                              LIKE(GRPLAN)
003300110819      *
003400130226     C     tspkey        klist
003500130226     C                   kfld                    cltrst
003600130226     C                   kfld                    clsub#
003700130226     C                   kfld                    clplan
003800130315      *
003900130315     C     acckey        klist
004000130315     C                   kfld                    cmtrst
004100130315     C                   kfld                    csubdv
004200130315     C                   kfld                    cmacct
004300130221      *
004400130226     C     codkey        klist
004500130226     C                   kfld                    cod1
004600130226     C                   kfld                    cod23
004700050601      *
004800021219      ******************************************************************
004900021218      *  Main Line
005000130226      *
005100130226     C                   if        clprefx = *blank
005200110831      *
005300130226      *           Check Rate file for active rate rec
0054001302260297 C     tspkey        chain     grat25                             21
005500130315     C                   if        *in21 = '0' and todat > todatx
005600130226      *
005700130226      *           Check Com Ctl file for non-zero term
0058001302260296 C                   eval      zerfnd = 'N'
0059001302260297 C     tspkey        setll     cmctpldt                           22
0060001302260296 C                   dou       *in22 = '1' or zerfnd = 'Y'
0061001302260297 C                   read      cmctpldt                               22
0062001302260291  *
006300130226     C                   if        *in22 = '1' or cltrst <> cmtrst or
006400130226     C                             clsub# <> csubdv or clplan <> cmplan
006500130226     C                   leave
006600130226     C                   endif
0067001302260291  *
006800130226     C                   if        cmcan = 0
0069001302260296 C                   eval      zerfnd = 'Y'
007000130226     C                   leave
007100130226     C                   endif
0072001302260291  *
007300130226     C                   enddo
0074001302260291  *
0075001302260296 C                   if        zerfnd = 'Y'
007600130226      *
007700130226      *           Check Plnmst file for Plan Cat
007800130226      *
0079001302260297 C     tspkey        chain     plnmst                             23
008000130226     C                   if        *in23 = '0'
008100130226      *
0082001302260297 C     codkey        chain     codes                              24
008300130226     C                   if        *in24 = '0' and action = 'M'
008400130315      *
0085001303150297 C     acckey        chain     accmst                             25
008600130315     C                   if        *in25 = '0' and atrmdt = 0 or
008700130315     C                             *in25 = '0' and atrmdt > todatx
008800130214      *
008900130226      *  Build PRFXBKLP record
009000130226      *
009100130226     C                   clear                   prfxblkr
009200130226      *
009300130226     C                   eval      pbtrst = cltrst
009400130226     C                   eval      pbsub# = clsub#
009500130226     C                   eval      pbplan = clplan
009600130226     C                   eval      pbclass = clclass
009700130226     C                   eval      pbcovtp = clcovtp
009800130917     C                   eval      pbgrp# = group#
0099001302130291  *
010000130226     C                   write     prfxblkr
0101001302260291  *
010200130226     C                   endif
010300130226      *
010400130226     C                   endif
010500130226      *
010600130226     C                   endif
010700130226      *
010800130226     C                   endif
010900130226      *
011000130226     C                   endif
011100130315      *
011200130315     C                   endif
011300130315      ****************************************************
011400130315      *              One time initialization
011500130315      ****************************************************
011600130315     C     *INZSR        BEGSR
011700130315      *
011800130315     C                   MOVE      *DATE         todate
011900130315     C                   MOVEL     todate        todatx
012000130315     C                   ENDSR
