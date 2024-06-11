000100090729     FSPRAGXR1  IF   E           K DISK
000200090729     FSMANRLT3  IF   E           K DISK
000300090729     FCMCTLF    IF   E           K DISK
000400090729     FACCMST    IF   E           K DISK
000500090729     FSMANSP    IF   E           K DISK
000600090731     FCMJ010WLU IF   E           K DISK    RENAME(CMJF:CMJF2) PREFIX(UJ:2)
000700090730     FCMJ010WF  UF A E           K DISK
000800090729   X***X
000900090730     D KF@AGCY         S                   LIKE(SXAGCY) INZ('299')
001000090729   X***X
001100090730     C     KF@AGCY       SETLL     SXF
001200090729     C                   DOU       %EOF(SPRAGXR1)
001300090730     C     KF@AGCY       READE     SXF
001400090729     C                   IF        NOT %EOF(SPRAGXR1) AND
001500090730     C                             SXEFFDTE <> SXTRMDTE AND
001600090730     C                             SXTRMDTE = 0
001700090729      *
001800090729     C                   EXSR      $SRF
001900090729      *
002000090729     C                   ENDIF
002100090729     C                   ENDDO
002200090729      *
002300090729     C                   EVAL      *INLR = *ON
002400090729      *
002500090729   S***S
002600090729     C     $SRF          BEGSR
002700090729      *
002800090729     C     SXASID        CHAIN     SRF
002900090729     C                   IF        NOT %FOUND(SMANRLT3)
003000090729     C                   LEAVESR
003100090729     C                   ENDIF
003200090729      *
003300090729     C     SXASID        SETLL     SRF
003400090729     C                   DOU       %EOF(SMANRLT3)
003500090729     C     SXASID        READE     SRF
003600090730     C                   IF        NOT %EOF(SMANRLT3) AND
003700090730     C                             SREFFDTE <> SRTRMDTE AND
003800090730     C                             SRTRMDTE = 0
003900090729      *
004000090729     C                   EXSR      $CTX
004100090729      *
004200090729     C                   ENDIF
004300090729     C                   ENDDO
004400090729      *
004500090729     C                   ENDSR
004600090729   S***S
004700090729     C     $CTX          BEGSR
004800090729      *
004900090729     C     SRRELID       CHAIN     COMCXR
005000090729     C                   IF        NOT %FOUND(CMCTLF)
005100090729     C                   LEAVESR
005200090729     C                   ENDIF
005300090729      *
005400090729     C     SRRELID       SETLL     COMCXR
005500090729     C                   DOU       %EOF(CMCTLF)
005600090729     C     SRRELID       READE     COMCXR
005700090729     C                   IF        NOT %EOF(CMCTLF) AND
005800090731     C                             EFFDAT <> CMCAN AND
005900090731     C                             CMCAN = 0
006000090729      *
006100090729     C     KL#ACM        CHAIN     ACCMSR
006200090730     C                   IF        NOT %FOUND(ACCMST)
006300090729     C                   ITER
006400090729     C                   ENDIF
006500090729      *
006600090730     C     KL#CMJ        CHAIN     CMJF
006700090730     C                   IF        %FOUND(CMJ010WF)
006800090730     C                   EXSR      $UPDATE
006900090730     C                   ELSE
007000090731     C     KL#ACM        CHAIN     CMJF2
007100090731     C                   IF        NOT %FOUND(CMJ010WLU)
007200090730     C                   EXSR      $CREATE
007300090731     C                   ENDIF
007400090730     C                   ENDIF
007500090729      *
007600090729     C                   ENDIF
007700090729     C                   ENDDO
007800090730      *
007900090730     C     KL#CMJ        KLIST
008000090730     C                   KFLD                    SRRELID
008100090730     C                   KFLD                    CMTRST
008200090730     C                   KFLD                    CSUBDV
008300090730     C                   KFLD                    CMACCT
008400090729      *
008500090729     C     KL#ACM        KLIST
008600090729     C                   KFLD                    CMTRST
008700090729     C                   KFLD                    CSUBDV
008800090729     C                   KFLD                    CMACCT
008900090730      *
009000090730     C                   ENDSR
009100090730   S***S
009200090730     C     $UPDATE       BEGSR
009300090730      *
009400090730     C                   EVAL      CJCUR = MEDEMP
009500090730     C                   EVAL      CJANAME = ACNAM1
009600090730     C                   EVAL      CJADMIN = GBSBDT
009700090730      *
009800090730     C                   IF        ATRMDT = 0
009900090730     C                   EVAL      CJCSTS = 'ACTIVE'
010000090730     C                   ELSE
010100090730     C                   EVAL      CJCSTS = 'TERM'
010200090730     C                   ENDIF
010300090730      *
010400090730     C     SRSMAN        CHAIN     SMANR
010500090730     C                   EXSR      $GETSNAME
010600090730     C                   EVAL      CJBNAME = A@40
010700090730      *
010800090730     C                   UPDATE    CMJF
010900090730      *
011000090730     C                   ENDSR
011100090730   S***S
011200090730     C     $CREATE       BEGSR
011300090730      *
011400090730     C                   CLEAR                   CMJF
011500090730      *
011600090730     C                   EVAL      CJTRS = ACTRST
011700090730     C                   EVAL      CJSUB = ACSUB#
011800090730     C                   EVAL      CJACC = ACACCT
011900090730      *
012000090730     C                   IF        ATRMDT = 0
012100090730     C                   EVAL      CJCSTS = 'ACTIVE'
012200090730     C                   ELSE
012300090730     C                   EVAL      CJCSTS = 'TERM'
012400090730     C                   EVAL      CJPSTS = 'TERM'
012500090730     C                   EVAL      CJPRV = MEDEMP
012600090730     C                   ENDIF
012700090730      *
012800090730     C                   EVAL      CJCUR = MEDEMP
012900090730     C                   EVAL      CJADMIN = GBSBDT
013000090730     C                   EVAL      CJANAME = ACNAM1
013100090730      *
013200090730     C     SRSMAN        CHAIN     SMANR
013300090730     C                   EXSR      $GETSNAME
013400090730     C                   EVAL      CJBNAME = A@40
013500090730      *
013600090730     C                   EVAL      CJGROUP = SGRP
013700090730     C                   EVAL      CJRELID = SRRELID
013800090730      *
013900090730     C                   WRITE     CMJF
014000090729      *
014100090729     C                   ENDSR
014200090729   S***S
014300090729     C     $GETSNAME     BEGSR
014400090729    ***
014500090729     C                   CLEAR                   A@20             20
014600090729     C                   CLEAR                   A@40             40
014700090729    ***
014800090729     C                   IF        SFNAME <> *BLANKS
014900090729     C                   MOVEL     SFNAME        A@20
015000090729     C                   EXSR      $LDADDR
015100090729     C                   ENDIF
015200090729    ***
015300090729     C                   IF        SMI <> *BLANKS
015400090729     C                   MOVEL     SMI           A@20
015500090729     C                   EXSR      $LDADDR
015600090729     C                   ENDIF
015700090729    ***
015800090729     C                   IF        SLNAME <> *BLANKS
015900090729     C                   MOVEL     SLNAME        A@20
016000090729     C                   EXSR      $LDADDR
016100090729     C                   ENDIF
016200090729    ***
016300090729     C                   ENDSR
016400090729   S***S
016500090729     C     $LDADDR       BEGSR
016600090729    ***
016700090729     C                   EVAL      A@20 = %TRIM(A@20)
016800090729     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
016900090729     C                   CLEAR                   A@20
017000090729    ***
017100090729     C                   ENDSR
017200090729   S***S
