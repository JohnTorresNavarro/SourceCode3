0001000302260010  *                                                                *
000200130225     FPRFXOUTP  UP   E             DISK
000300130225     FCLASS     UF A E           K DISK
000400120518      *
000500120518     D                 DS
000600120518     D  covtp                  1      3
000700120518     D   ct1                   1      1    INZ('T')
000800120518     D   ruclvl                2      3
000900110408      *
001000110831     D                 DS
001100120517     D  wkdatd                         D   DATFMT(*ISO)
001200120517     D  todate                         D   DATFMT(*ISO)
001300110831     D  todatx                        8  0
001400120517     D  wkdatn                        8  0
001500110819      *
001600130225     C     clasky        klist
001700130225     C                   kfld                    potrst
001800130225     C                   kfld                    posub#
001900130225     C                   kfld                    poplan
002000050601      *
002100021219      ******************************************************************
002200021218      *  Main Line
002300120517      *
0024001208020291  *          Verify Plan and Cov Type
002500120518      *
0026001302250297 C                   if        poplan <> *blanks
002700130225      *
0028001302250297 C     clasky        setll     class                              22
0029001205180297 C                   dou       *in22 = '1'
0030001302250297 C     clasky        reade     class                                  22
0031001208020291  *          Verify Trust and Sub#
003200130225     C                   if        *in22 = '1' or cltrst <> potrst or
003300130225     C                             clsub# <> posub# or clplan <> poplan
0034001208020291 C                   leave
0035001208020291 C                   endif
0036001302250291  *
003700130225     C                   eval      clprefx = poprfx
0038001302250291 C                   update    fclass
0039001302250291  *
0040001302250291 C                   enddo
0041001302250291  *
0042001302250291 C                   endif
