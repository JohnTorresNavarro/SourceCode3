000001090804     **** Program Name:  ECOVDT1R
000002090804     **** Find the earliest coverage date w/no lapse and the end date.
000200090804     **** T/S/P/SS/ENROLLMENT DATE IN ASCENDING ORDER--->  ON THE MCOV
000300090804
000302090804     FMCOV42    IF   E           K Disk
000400090804     D #ENRDT          S              8S 0 DIM(20)
000500090804     D #CANDT          S              8S 0 DIM(20)
000600090804     D #ENTRIES        S              3S 0
000700090804     D Y               S              3S 0
000800090804     D #ISO            S               D   DATFMT(*ISO)
000900090804     D #DTE            S              8S 0
001000090804     D #LTR            S              8S 0
001100090804     D HOLD#SSN        S              9S 0 inz(0)
001200090804
001201090804     C                   Z-add     *Zeros        BeginDateN        8 0
001202090804     C                   Z-add     *Zeros        EndDateN          8 0
001203090804     C                   Movel     Trust         KTrst
001204090804     C                   Movel     Sub           KSub
001205090804     C                   Movel     Social        KSocial
001300090804     **** READ MCOV LOOP
001301090804     C     CovKey        Setll     MCOV42
001303090804     C                   Dou       %Eof(MCOV42)
001304090804     C     CovKey        Reade     MCOV42
001305090804     c                   If        Not %Eof(MCOV42)     And
001306090804     c                             ENRLDT <> CANDT
001307090804
001400090804     C                   IF        HOLD#SSN <> MCSSNO
001500090804
001600090804     C*                  IF        HOLD#SSN <> 0
001700090804
001701090804     C*                  Eval      BeginDateN  =   #ENRDT(#ENTRIES)
001702090804     C*                  Eval      EndDateN    =   #CANDT(#ENTRIES)
001800090804     C*                  ENDIF
001900090804
002000090804     C                   CLEAR                   #ENRDT
002100090804     C                   CLEAR                   #CANDT
002200090804     C                   EVAL      #ENTRIES = 0
002300090804     C                   EVAL      HOLD#SSN = MCSSNO
002400090804
002500090804     C                   ENDIF
002600090804      *
002700090804     C                   IF        #ENTRIES = 0
002800090804     C                   EXSR      $ADDENT
002900090804     C                   ITER
003000090804     C                   ENDIF
003100090804    ***
003200090804     C                   EXSR      $SEARCH
003300090804    ***
003301090804     C                   Endif
003400090804     C                   EndDo
003500090804
003501090804     C                   Eval      BeginDateN  =   #ENRDT(#ENTRIES)
003502090804     C                   Eval      EndDateN    =   #CANDT(#ENTRIES)
003503090804     C                   Movel     BeginDateN    BeginDate
003504090804     C                   Movel     EndDateN      EndDate
003600090804
003601090804     C                   Seton                                        LR
003602090804     C                   Return
003800090804   S***S
003900090804     C     $SEARCH       BEGSR
004000090804
004100090804     C                   EVAL      Y = 0
004200090804     C     1             DO        #ENTRIES      Y
004300090804      *
004400090804     C                   EVAL      #DTE = #CANDT(Y)
004401110414szz  C                   If        #DTE   <>     *Zeros
004500090804     C                   MOVE      #DTE          #ISO
004600090804     C                   ADDDUR    1:*D          #ISO
004601110414szz  C                   End
004700090804     C                   MOVE      #ISO          #LTR
004800090804      *
004900090804     C                   IF        ENRLDT = #DTE OR ENRLDT = #LTR
005000090804     C                   EVAL      #CANDT(Y) = CANDT
005100090804     C                   LEAVESR
005200090804     C                   ENDIF
005500090804      *
005600090804     C                   ENDDO
005700090804    ***
005800090804     C                   EXSR      $ADDENT
005900090804
006000090804     C                   ENDSR
006100090804   S***S
006200090804     C     $ADDENT       BEGSR
006300090804      *
006400090804     C                   ADD       1             #ENTRIES
006500090804     C                   EVAL      #ENRDT(#ENTRIES) = ENRLDT
006600090804     C                   EVAL      #CANDT(#ENTRIES) = CANDT
006700090804      *
006800090804     C                   ENDSR
007000090804
007001090804    ?C     Plist         Begsr                                                  PARM LISTS
007002090804     C     *Entry        Plist
007003090804     C                   Parm                    Trust             3
007004090804     C                   Parm                    Sub               3
007005090804     C                   Parm                    Plan              4
007006090804     C                   Parm                    Social            9
007007090804     C                   Parm                    BeginDate         8
007008090804     C                   Parm                    EndDate           8
007009090804     C                   Parm                    Err               8
007010090804      *
007011090804    ?C                   Endsr                                                  END PLIST
007012090804      *
007013090804    ?C     Klist         Begsr                                                  PARM LISTS
007014090804     C     CovKey        Klist
007015090804     C                   Kfld                    KTrst             3 0
007016090804     C                   Kfld                    KSub              3 0
007017090804     C                   Kfld                    Plan
007018090804     C                   Kfld                    KSocial           9 0
007019090804      *
007020090804    ?C                   Endsr                                                  END PLIST
007300090804
