000001090202      *? ***************************************************************
000002090202      *
000003090202      *             GROUP BENIFIT SERVICES SOFTWARE           2009     *
000004090202      *                                                                *
000005090202      *  Written by:    S. King                                        *
000006090202      *  Program Name:  LSTDAY                                         *
000007090202      *  Date Written:   1/30/09                                       *
000008090202      *  Description:   Determine last day of month.                   *
000009090202      *                                                                *
000010090202      *                                                                *
000011090202      *                R E V I S I O N    H I S T O R Y                *
000012090202      *  Date                                                          *
000013090202      *  Revised   Initials    Revision                                *
000014090202      *  --------  --------    --------------------------------------  *
000015090202      *                                                                *
000016090202      *                                                                *
000017090202      *? ***************************************************************
000100090130     D @8              S              8A
000200090130     D @LASTDAY        S              8A
000300090130     D @YR             S              4A
000400090130     D #YR             S              4S 0
000500090130     D @MTH            S              2A
000600090130     D #MTH            S              2S 0
000700090130     D #DATE           S              8S 0
000800090130     D #ISODTE         S               D   DATFMT(*ISO)
000900090202     ***********
001000090130     C                   MOVE      CANDT         @8
001100090202     ***********
001200090202     C                   IF        %SUBST(@8:7:2) <> '01'
001300090130     C                   EVAL      @MTH = %SUBST(@8:5:2)
001400090130     C                   MOVE      @MTH          #MTH
001500090130     C                   EVAL      @YR = %SUBST(@8:1:4)
001600090130     C                   MOVE      @YR           #YR
001700090130     C                   ADD       1             #MTH
001800090130     C                   IF        #MTH > 12
001900090130     C                   EVAL      #MTH = 1
002000090130     C                   ADD       1             #YR
002100090130     C                   ENDIF
002200090130     C                   MOVE      #YR           @YR
002300090130     C                   MOVE      #MTH          @MTH
002400090130     C                   EVAL      @LASTDAY = @YR + @MTH + '01'
002500090130     C                   MOVE      @LASTDAY      #DATE
002501090202     C                   ELSE
002502090202     C                   MOVE      CANDT         #DATE
002600090202     C                   ENDIF
002700090130     ***********
002800090130     C                   MOVE      #DATE         #ISODTE
002900090130     C                   SUBDUR    1:*D          #ISODTE
003000090130     C                   MOVE      #ISODTE       #DATE
003001090202     C                   Move      #DATE         LastDate
003002090202     C                   RETURN
003100090202      *
003200090202     C     *Entry        Plist
003600090202     C                   Parm                    CANDT             8
003700090202     C                   Parm                    LastDate          8
003800090202     C                   Parm                    Error            20
004000090202      *
