000100091015     FDCOVC     IF   E           K Disk
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
001500091015     C                   Movel     Social        KSocial
001600091015     C                   Movel     Seq           KSeq
001700091014     C                   CLEAR                   #ENRDT
001800091014     C                   CLEAR                   #CANDT
001900091014     C                   EVAL      #ENTRIES = 0
002000091014
002100090804     **** READ MCOV LOOP
002200091015     C     CovKey        Setll     DCOVC
002300091015     C     CovKey        Reade     DCOVC
002400091015     C                   Dow       not %Eof(DCOVC)
002500091014
002600091014     C     PKEY          CHAIN     PLNMST
002700091014     C                   IF        %found(PLNMST)
002800091014     C                   IF        PLNCAT = PCAT
002900091014     C     PCARR         CHAIN     CARMST
003000091014     C                   IF        %found(CARMST)
003100091014     C                   IF        CARBC = 'D'
003200091014
003300091014     C                   IF        #ENTRIES = 0
003400090804     C                   EXSR      $ADDENT
003500090804     C                   ITER
003600090804     C                   ENDIF
003700090804    ***
003800090804     C                   EXSR      $SEARCH
003900090804    ***
004000091014     C                   END
004100091014     C                   END
004200091014     C                   END
004300091014     C                   END
004400091014    ***
004500091015     C     CovKey        Reade     DCOVC
004600090804     C                   EndDo
004700090804
004800090804     C                   Eval      BeginDateN  =   #ENRDT(#ENTRIES)
004900090804     C                   Eval      EndDateN    =   #CANDT(#ENTRIES)
005000090804     C                   Movel     BeginDateN    BeginDate
005100090804     C                   Movel     EndDateN      EndDate
005200090804
005300090804     C                   Return
005400090804
005500090804   S***S
005600090804     C     $SEARCH       BEGSR
005700090804
005800090804     C                   EVAL      Y = 0
005900090804     C     1             DO        #ENTRIES      Y
006000090804      *
006100090804     C                   EVAL      #DTE = #CANDT(Y)
006200090804     C                   MOVE      #DTE          #ISO
006300090804     C                   ADDDUR    1:*D          #ISO
006400090804     C                   MOVE      #ISO          #LTR
006500090804      *
006600091015     C                   IF        DENRDT = #DTE OR DENRDT = #LTR
006700091015     C                   EVAL      #CANDT(Y) = CCANDT
006800090804     C                   LEAVESR
006900090804     C                   ENDIF
007000090804      *
007100090804     C                   ENDDO
007200090804    ***
007300090804     C                   EXSR      $ADDENT
007400090804
007500090804     C                   ENDSR
007600090804   S***S
007700090804     C     $ADDENT       BEGSR
007800090804      *
007900090804     C                   ADD       1             #ENTRIES
008000091015     C                   EVAL      #ENRDT(#ENTRIES) = DENRDT
008100091015     C                   EVAL      #CANDT(#ENTRIES) = CCANDT
008200090804      *
008300090804     C                   ENDSR
008400090804
008500090804    ?C     Plist         Begsr                                                  PARM LISTS
008600090804     C     *Entry        Plist
008700091015     C                   Parm                    Social            9
008800091015     C                   Parm                    Seq               2
008900091014     C                   Parm                    PCat              3
009000090804     C                   Parm                    BeginDate         8
009100090804     C                   Parm                    EndDate           8
009200090804      *
009300090804    ?C                   Endsr                                                  END PLIST
009400090804      *
009500090804    ?C     Klist         Begsr                                                  PARM LISTS
009600090804     C     CovKey        Klist
009700091015     C                   Kfld                    KSocial           9 0
009800091015     C                   Kfld                    KSeq              2 0
009900090804      *
010000091014     C     PKEY          KLIST
010100091015     C                   KFLD                    DVTRST
010200091015     C                   KFLD                    DVSUB#
010300091015     C                   KFLD                    DVPLAN
010400091014      *
010500090804    ?C                   Endsr                                                  END PLIST
010600090804
