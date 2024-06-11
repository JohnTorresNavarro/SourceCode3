000100000000      *_________________________________________________________________________
000200000000      *
000300100209      *  Description:  Member Added from Conversion
000400000000      *
000500100209      *  (c)Copyright 2010 by GBS, Inc.
000600000000      *
000700100209      *    Created by:  JALLEN - Feb 09, 2010
000800000000      *_________________________________________________________________________
000900091222     FHISTAK    IF   E           K DISK
001000090618
001100090824     D P_SSN           S              9A
001200090729     D P_FLG           S              1A
001300090729     D W_FLG           S              1A
001400091222     D KEYHST          S             10A
001500090618
001600090618     C     *ENTRY        PLIST
001700090618     C                   PARM                    P_SSN
001800091203     C                   PARM                    P_FLG
001900090729
002000090729     C                   Eval      P_FLG = *BLANKS
002100091203     C                   Eval      W_FLG = *BLANKS
002200090618
002300100209     C                   EXSR      CHKHIST
002400090618
002500090729     C                   MOVE      W_FLG         P_FLG
002600090618     C                   Eval      *INLR = *ON
002700090618     C                   Return
002800090618
002900091222      ***
003000091222     C     CHKHIST       BEGSR
003100091222      ***
003200091222     C                   MOVE      P_SSN         KEYHST
003300091222     C     KEYHST        Setgt     HISTAK
003400091222     C     KEYHST        Readpe    HISTAK
003500091222     C                   Dow       not %eof(HISTAK)
003600100209     C                   If        TRCODE = 'MMA' and
003700100209     C                             %trim(CK#NOT) =
003800100209     C                             'Member Add From DB Conversion'
003900100209     C                   Eval      W_FLG = 'Y'
004000091222     C                   LeaveSR
004100091222     C                   End
004200091222     C
004300091222     C     KEYHST        Readpe    HISTAK
004400091222     C                   Enddo
004500091222      ***
004600091222     C                   ENDSR
