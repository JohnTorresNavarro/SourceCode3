0001000302260010  *                                                                *
000200130314     FPRFXLDP   UP   E             DISK
000300130225     FCLASS     UF A E           K DISK
000400120518      *
000500120518     D                 DS
000600120518     D  covtp                  1      3
000700120518     D   ct1                   1      1    INZ('T')
000800130314      *
000900130314     D                 DS
001000130314     D  potrst                 1      3
001100130314     D  pntrst                 1      3  0
001200130314      *
001300130314     D                 DS
001400130314     D  posub#                 1      3
001500130314     D  pnsub#                 1      3  0
001600110408      *
001700110831     D                 DS
001800120517     D  wkdatd                         D   DATFMT(*ISO)
001900120517     D  todate                         D   DATFMT(*ISO)
002000110831     D  todatx                        8  0
002100120517     D  wkdatn                        8  0
002200110819      *
002300130225     C     clasky        klist
002400130314     C                   kfld                    pntrst
002500130314     C                   kfld                    pnsub#
002600130225     C                   kfld                    poplan
002700050601      *
002800021219      ******************************************************************
002900021218      *  Main Line
003000120517      *
0031001208020291  *          Verify Plan and Cov Type
003200120518      *
0033001302250297 C                   if        poplan <> *blanks
003400130225      *
0035001302250297 C     clasky        setll     class                              22
0036001205180297 C                   dou       *in22 = '1'
0037001302250297 C     clasky        reade     class                                  22
0038001208020291  *          Verify Trust and Sub#
003900130314     C                   if        *in22 = '1' or cltrst <> pntrst or
004000130314     C                             clsub# <> pnsub# or clplan <> poplan
0041001208020291 C                   leave
0042001208020291 C                   endif
0043001302250291  *
004400130314     C                   if        clclass <> poclas
0045001303140291 C                   iter
0046001303140291 C                   endif
0047001303140291  *
004800130314     C                   if        clprefx <> *blanks
0049001303140291 C                   iter
0050001303140291 C                   endif
0051001303140291  *
005200130225     C                   eval      clprefx = poprfx
0053001302250291 C                   update    fclass
0054001302250291  *
0055001302250291 C                   enddo
0056001302250291  *
0057001302250291 C                   endif
