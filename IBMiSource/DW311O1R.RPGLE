000100091014     FMCOV      IF   E           K Disk
000200091014     FPLNMST    IF   E           K DISK
000300091014     FCARMST    IF   E           K DISK
000400090804     D #ENRDT          S              8S 0 DIM(20)
000500090804     D #CANDT          S              8S 0 DIM(20)
000600090804     D #ENTRIES        S              3S 0
000700090804     D Y               S              3S 0
000800090804     D #ISO            S               D   DATFMT(*ISO)
000900090804     D #DTE            S              8S 0
001000090804     D #LTR            S              8S 0
001100090804     D HOLD#SSN        S              9S 0 inz(0)
001200090804
001300090804     C                   Z-add     *Zeros        BeginDateN        8 0
001400090804     C                   Z-add     *Zeros        EndDateN          8 0
001500090804     C                   Movel     Social        KSocial
001600091014     C                   CLEAR                   #ENRDT
001700091014     C                   CLEAR                   #CANDT
001800091014     C                   EVAL      #ENTRIES = 0
001900091014
002000090804     **** READ MCOV LOOP
002100091014     C     CovKey        Setll     MCOV
002200091014     C     CovKey        Reade     MCOV
002300091014     C                   Dow       not %Eof(MCOV)
002400091014
002500091014     C     PKEY          CHAIN     PLNMST
002600091014     C                   IF        %found(PLNMST)
002700091014     C                   IF        PLNCAT = PCAT
002800091014     C     PCARR         CHAIN     CARMST
002900091014     C                   IF        %found(CARMST)
003000091014     C                   IF        CARBC = 'D'
003100091014
003200091014     C                   IF        #ENTRIES = 0
003300090804     C                   EXSR      $ADDENT
003400090804     C                   ITER
003500090804     C                   ENDIF
003600090804    ***
003700090804     C                   EXSR      $SEARCH
003800090804    ***
003900091014     C                   END
004000091014     C                   END
004100091014     C                   END
004200091014     C                   END
004300091014    ***
004400091014     C     CovKey        Reade     MCOV
004500090804     C                   EndDo
004600090804
004700090804     C                   Eval      BeginDateN  =   #ENRDT(#ENTRIES)
004800090804     C                   Eval      EndDateN    =   #CANDT(#ENTRIES)
004900090804     C                   Movel     BeginDateN    BeginDate
005000090804     C                   Movel     EndDateN      EndDate
005100090804
005200090804     C                   Return
005300090804
005400090804   S***S
005500090804     C     $SEARCH       BEGSR
005600090804
005700090804     C                   EVAL      Y = 0
005800090804     C     1             DO        #ENTRIES      Y
005900090804      *
006000090804     C                   EVAL      #DTE = #CANDT(Y)
006100090804     C                   MOVE      #DTE          #ISO
006200090804     C                   ADDDUR    1:*D          #ISO
006300090804     C                   MOVE      #ISO          #LTR
006400090804      *
006500090804     C                   IF        ENRLDT = #DTE OR ENRLDT = #LTR
006600090804     C                   EVAL      #CANDT(Y) = CANDT
006700090804     C                   LEAVESR
006800090804     C                   ENDIF
006900090804      *
007000090804     C                   ENDDO
007100090804    ***
007200090804     C                   EXSR      $ADDENT
007300090804
007400090804     C                   ENDSR
007500090804   S***S
007600090804     C     $ADDENT       BEGSR
007700090804      *
007800090804     C                   ADD       1             #ENTRIES
007900090804     C                   EVAL      #ENRDT(#ENTRIES) = ENRLDT
008000090804     C                   EVAL      #CANDT(#ENTRIES) = CANDT
008100090804      *
008200090804     C                   ENDSR
008300090804
008400090804    ?C     Plist         Begsr                                                  PARM LISTS
008500090804     C     *Entry        Plist
008600090804     C                   Parm                    Social            9
008700091014     C                   Parm                    PCat              3
008800090804     C                   Parm                    BeginDate         8
008900090804     C                   Parm                    EndDate           8
009000090804      *
009100090804    ?C                   Endsr                                                  END PLIST
009200090804      *
009300090804    ?C     Klist         Begsr                                                  PARM LISTS
009400090804     C     CovKey        Klist
009500090804     C                   Kfld                    KSocial           9 0
009600090804      *
009700091014     C     PKEY          KLIST
009800091014     C                   KFLD                    MCTRST
009900091014     C                   KFLD                    MCSUB#
010000091014     C                   KFLD                    MCPLAN
010100091014      *
010200090804    ?C                   Endsr                                                  END PLIST
010300090804
