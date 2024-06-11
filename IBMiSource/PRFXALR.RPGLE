0001001205240002  ******************************************************************
0002001302130003  * PRFXALR    GROUP BENEFIT SERVICES SOFTWARE           2013      *
0003001209270007  *                                                                *
0004001209270005  *            WRITTEN BY - R.L.J.                                 *
0005001302130006  *            DATE - Feb 2013                                     *
0006001209270007  *                                                                *
000700120524      *  CHANGES: xxx mm/dd/yyyy                                       *
000800120524      *  xxx mm/dd/yyyy
0009001205240009  ******************************************************************
0010001109090010  *                                                                *
001100130213     FPRFXINP   IP   E             DISK
001200120529     FGRATEL1   IF   E           K DISK
001300130221     FCMCTPLDT  IF   E           K DISK
001400120529     FPLNMST    IF   E           K DISK
001500120529     FCLASS     IF   E           K DISK
001600130213     FPRFXOUTP  O    E             DISK
001700110831      *
001800110831     D                 DS
001900110831     D  group#                 1     15
002000110831     D   grp4                  1      4
002100120524      *
002200120524     D                 DS
002300120524     D  kgrp#                        15
002400120914     D  kggrp#                       20
002500120524     D  kignam                       48
002600130214     D  htrst                              LIKE(GRTRST)
002700130214     D  hsub#                              LIKE(GRSUB#)
002800130214     D  hplan                              LIKE(GRPLAN)
002900110819      *
003000110831     C     plnkey        klist
003100110831     C                   kfld                    grtrst
003200110831     C                   kfld                    grsub#
003300110831     C                   kfld                    grplan
003400130221      *
003500130221     C     cmtkey        klist
003600130221     C                   kfld                    grtrst
003700130221     C                   kfld                    grsub#
003800130221     C                   kfld                    grplan
003900110831      *
004000050601      *
004100021219      ******************************************************************
004200021218      *  Main Line
004300110831      *
004400130213     C                   clear                   prfxoutr
004500110831      *
004600130213     C                   eval      pogrp = pxgrp
004700130213     C                   eval      poclas = pxclas
004800130213     C                   eval      poprfx = pxprfx
004900130214      *
005000130214     C                   eval      htrst = 0
005100130214     C                   eval      hsub# = 0
005200130214     C                   eval      hplan = *blanks
005300110831      *
005400130213      *     Use GRATE to key on Grp#, find correct pln cat and date range
005500120524      *
005600130213     C                   eval      poclfl = 'N'
0057001302130296 C                   movel(P)  pxgrp         kgrp#
0058001108310297 C     kgrp#         setll     gratel1                            22
0059001302130296 C                   dou       *in22 = '1' or poclfl = 'Y'
0060001108310297 C                   read      gratel1                                22
0061001302130291  *            No Match?
006200130213     C                   if        *in22 = '1' or grp4 <> pxgrp
006300130213     C                   eval      portfl = 'X'
006400130213     C                   leave
006500130213     C                   endif
0066001302130291  *
006700130219     C                   if        todat < 20130201
006800130213     C                   iter
006900130213     C                   endif
0070001302130291  *
007100130221      *
0072001108310297 C     plnkey        chain     plnmst                             23
007300130213     C                   if        *in23 = '1' or plncat <> 'PMM'
007400130213     C                   iter
007500130213     C                   endif
0076001302130291  *
0077001302220297 C     cmtkey        chain     cmctpldt                           34
007800130222     C                   if        *in34 = '1'
007900130222     C                   iter
008000130222     C                   endif
008100130222      ********           if        cmcan <> 0 and cmcan < 20130201
008200130222     C                   if        cmcan <> 0
008300130222     C                   iter
008400130222     C                   endif
008500130222      *
008600130213     C                   eval      portfl = 'Y'
008700110831      *
008800110831      *     Use CLASS file to verify correct Class
008900110831      *
009000130213     C                   eval      poclfl = 'X'
009100130213     C     plnkey        chain     class                              24
009200130213     C                   if        *in24 = '0' and clclass = pxclas
009300130213     C                   eval      poclfl = 'Y'
009400130213     C                   eval      potrst = grtrst
009500130213     C                   eval      posub# = grsub#
009600130213     C                   eval      poplan = grplan
009700130213     C                   leave
009800130213     C                   endif
009900130213     C                   enddo
0100001302130291  *
010100130213     C                   write     prfxoutr
010200130213      *****
