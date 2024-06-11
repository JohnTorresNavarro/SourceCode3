000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Get Member Original CFS Effective Date
000400000000      *
000500000000      *  (c)Copyright 2009 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - June 18, 2009
000800000000      *_________________________________________________________________________
000900091123     FHIST      IF   E           K DISK
001000091123     FDW311HST  IF A E           K DISK
001100090618
001200091123     D S_SSN           S              9S 0
001300090812     D P_SSN           S              9A
001400090812     D W_SSN           S             10A
001500090812     D P_EFF           S              8A
001600090812     D W_EFF           S              8S 0
001700090729     D P_FLG           S              1A
001800090729     D W_FLG           S              1A
001900090618
002000090618     C     *ENTRY        PLIST
002100090618     C                   PARM                    P_SSN
002200090812     C                   PARM                    P_EFF
002300090729     C                   PARM                    P_FLG
002400090729
002500091123     C                   MOVE      P_SSN         S_SSN
002600090812     C                   MOVE      P_SSN         W_SSN
002700090812     C                   MOVE      P_EFF         W_EFF
002800090729     C                   Eval      P_FLG = *BLANKS
002900090729     C                   Eval      W_FLG = *BLANKS
003000090618
003100090812     C     W_SSN         SETGT     HIST
003200090812     C     W_SSN         READPE    HIST
003300090812     C                   DOW       not %eof(HIST)
003400091021     C                   IF        HDSEQ# = 0
003500090812     C                   EXSR      CHKERE
003600091021     C                   End
003700090729     C                   IF        W_FLG <> *BLANKS
003800090618     C                   Leave
003900090618     C                   End
004000090812     C     W_SSN         READPE    HIST
004100090618     C                   Enddo
004200091123
004300091123     C                   IF        W_FLG <> *BLANKS
004400091123     C     S_KEY         KLIST
004500091123     C                   KFLD                    S_SSN
004600091123     C                   KFLD                    S_COD             3
004700091123     C                   EVAL      S_COD = 'ERE'
004800091123     C     S_KEY         CHAIN     DW311HST
004900091123     C                   If        %FOUND(DW311HST)
005000091123     C                   EVAL      W_FLG = *BLANKS
005100091123     C                   EVAL      P_FLG = *BLANKS
005200091123     C                   ELSE
005300091123     C                   EVAL      DHSSN = S_SSN
005400091123     C                   EVAL      DHCOD = 'ERE'
005500091123     C     *DATE         MULT      10000.0001    DHDATE
005600091123     C                   WRITE     DW311HR
005700091123     C                   END
005800091123     C                   END
005900090618
006000090729     C                   MOVE      W_FLG         P_FLG
006100090618     C                   Eval      *INLR = *ON
006200090618     C                   Return
006300090618
006400090812     C     CHKERE        BEGSR
006500090618
006600090812     C                   IF        TRCODE = 'ERE' AND
006700090812     C                             COVTDT = W_EFF
006800090729     C                   EVAL      W_FLG = 'Y'
006900090618     C                   END
007000090618
007100090618     C                   ENDSR
