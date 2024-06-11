000100000000      *_________________________________________________________________________
000200000000      *
000300110330      *  Description:  Member Termed as DECEASED
000400000000      *
000500110330      *  (c)Copyright 2011 by GBS, Inc.
000600000000      *
000700110330      *    Created by:  JALLEN - Mar 30, 2011
000800000000      *_________________________________________________________________________
000900091222     FHISTAK    IF   E           K DISK
001000090618
001100090824     D P_SSN           S              9A
001200110720     D P_SEQ           S              2A
001300110720     D W_SEQ           S              2S 0
001400090729     D P_FLG           S              1A
001500090729     D W_FLG           S              1A
001600091222     D KEYHST          S             10A
001700090618
001800090618     C     *ENTRY        PLIST
001900090618     C                   PARM                    P_SSN
002000110720     C                   PARM                    P_SEQ
002100091203     C                   PARM                    P_FLG
002200090729
002300110720     C     ' ':'0'       Xlate     P_SEQ         P_SEQ
002400110720     C                   Move      P_SEQ         W_SEQ
002500090729     C                   Eval      P_FLG = *BLANKS
002600091203     C                   Eval      W_FLG = *BLANKS
002700090618
002800100209     C                   EXSR      CHKHIST
002900090618
003000090729     C                   MOVE      W_FLG         P_FLG
003100090618     C                   Eval      *INLR = *ON
003200090618     C                   Return
003300090618
003400091222      ***
003500091222     C     CHKHIST       BEGSR
003600091222      ***
003700091222     C                   MOVE      P_SSN         KEYHST
003800091222     C     KEYHST        Setgt     HISTAK
003900091222     C     KEYHST        Readpe    HISTAK
004000091222     C                   Dow       not %eof(HISTAK)
004100160831     C                   If        %trim(TRCODE) = 'D5'  or
004200161102     C                             %trim(TRCODE) = 'DDD' or
004300160909     C                             %trim(TRCODE) = 'DED' or
004400160909     C                             %trim(TRCODE) = 'DEE'
004500110720     C                   If        W_SEQ = HDSEQ#
004600100209     C                   Eval      W_FLG = 'Y'
004700091222     C                   LeaveSR
004800110720     C                   End
004900091222     C                   End
005000091222     C
005100091222     C     KEYHST        Readpe    HISTAK
005200091222     C                   Enddo
005300091222      ***
005400091222     C                   ENDSR
