000100040322      *___________________________________________________________________
000200200507     FSPRAGXRF  IF   E           K DISK    extfile('F.SPRAGXRF')
000300200507     FSMANRLT3  IF   E           K DISK    extfile('F.SMANRLT3')
000400200507     FSMAN      IF   E           K DISK    extfile('F.SMAN')
000500200507     FSMAN2L    IF   E           K DISK    extfile('F.SMAN2L')
000600200507     FAMWEMAILP O  A E           K DISK
000700200507
000800200507     C                   eval      SXSUPER = 'AMW'
000900200507     C     SXSUPER       Setll     SPRAGXRF
001000200507     C     SXSUPER       Reade     SPRAGXRF
001100200507     C                   Dow       not %eof(SPRAGXRF)
001200040322      *
001300040322     C     SXasid        Setll     SMANRLT3
001400040322     C     SXasid        Reade     SMANRLT3
001500200507     C                   Dow       not %eof(SMANRLT3)
001600040322      *
001700200507     C     SRSMAN        Setll     SMAN
001800200507     C     SRSMAN        Reade     SMAN
001900200507     C                   Dow       not %eof(SMAN)
002000040322      *
002100200507     C     SGRP          Setll     SMAN2L
002200200507     C     SGRP          Reade     SMAN2L
002300200507     C                   Dow       not %eof(SMAN2L)
002400200507      *
002500200507     C                   write     amwr
002600200507      *
002700200507     C     SGRP          Reade     SMAN2L
002800200507     C                   Enddo
002900040322      *
003000200507     C     SRSMAN        Reade     SMAN
003100040322     C                   Enddo
003200040322      *
003300040322     C     SXasid        Reade     SMANRLT3
003400040322     C                   Enddo
003500040322      *
003600200507     C     SXSUPER       Reade     SPRAGXRF
003700040322     C                   Enddo
003800200507      *
003900200507     C                   eval      *inlr = *on
004000200507     C                   return
004100200507      *
