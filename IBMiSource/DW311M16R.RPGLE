000100000000      *_________________________________________________________________________
000400000000      *
000500110330      *  (c)Copyright 2011 by GBS, Inc.
000600000000      *
000700110330      *    Created by:  JALLEN - Mar 30, 2011
000800000000      *_________________________________________________________________________
000900091222     FHISTAK    IF   E           K DISK
001000090618
001100090824     D P_SSN           S              9A
001101110330     D P_FLG           S              1A
001200110330     D P_EFF           S              8A
001300090729     D W_FLG           S              1A
001400091222     D KEYHST          S             10A
001401110330     D W_EFF           S              8S 0
001500090618
001600090618     C     *ENTRY        PLIST
001601110330     C                   PARM                    P_SSN
001700110330     C                   PARM                    P_EFF
001800091203     C                   PARM                    P_FLG
001900090729
002000090729     C                   Eval      P_FLG = *BLANKS
002100091203     C                   Eval      W_FLG = *BLANKS
002101110330     C                   Move      P_EFF         W_EFF
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
003600110330     C                   If        TRCODE = 'M16' and
003601110405     C                             TRDATE >= W_EFF
003900100209     C                   Eval      W_FLG = 'Y'
004000091222     C                   LeaveSR
004100091222     C                   End
004200091222     C
004300091222     C     KEYHST        Readpe    HISTAK
004400091222     C                   Enddo
004500091222      ***
004600091222     C                   ENDSR
