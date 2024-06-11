000001090804     **** Program Name:  ECOVDT2R
000002090804     **** Find the earliest depend coverage date w/no lapse and the end date.
000200090804     **** T/S/P/SS/ENROLLMENT DATE IN ASCENDING ORDER--->  ON THE MCOV
000300090804
000302090804     FDCOV22    IF   E           K Disk
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
001206090804     C                   Movel     Seq           KSeq
001300090805     **** READ DCOV LOOP
001301090804     C     CovKey        Setll     DCOV22
001303090804     C                   Dou       %Eof(DCOV22)
001304090804     C     CovKey        Reade     DCOV22
001305090804     c                   If        Not %Eof(DCOV22)     And
001306090804     c                             DENRDT <> CCANDT
001307090804
001400090804     C                   IF        HOLD#SSN <> SSNO
001900090804
002000090804     C                   CLEAR                   #ENRDT
002100090804     C                   CLEAR                   #CANDT
002200090804     C                   EVAL      #ENTRIES = 0
002300090804     C                   EVAL      HOLD#SSN = SSNO
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
003501091123      *---
003502091123sz    * Same-day term; prevent subscript out of range.  SZ
003503091123      *---
003504091123sz   C                   If        #ENTRIES    =   *Zeros
003505091123sz   C                   Eval      #ENTRIES    =   1
003506091123sz   C                   End
003507091123      *
003508090804     C                   Eval      BeginDateN  =   #ENRDT(#ENTRIES)
003509090804     C                   Eval      EndDateN    =   #CANDT(#ENTRIES)
003510090804     C                   Movel     BeginDateN    BeginDate
003511090804     C                   Movel     EndDateN      EndDate
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
004500090804     C                   MOVE      #DTE          #ISO
004600090804     C                   ADDDUR    1:*D          #ISO
004700090804     C                   MOVE      #ISO          #LTR
004800090804      *
004900090804     C                   IF        DENRDT = #DTE OR DENRDT = #LTR
005000090804     C                   EVAL      #CANDT(Y) = CCANDT
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
006500090804     C                   EVAL      #ENRDT(#ENTRIES) = DENRDT
006600090804     C                   EVAL      #CANDT(#ENTRIES) = CCANDT
006700090804      *
006800090804     C                   ENDSR
007000090804
007001090804    ?C     Plist         Begsr                                                  PARM LISTS
007002090804     C     *Entry        Plist
007003090804     C                   Parm                    Trust             3
007004090804     C                   Parm                    Sub               3
007005090804     C                   Parm                    Plan              4
007006090804     C                   Parm                    Social            9
007007090804     C                   Parm                    Seq               2
007008090804     C                   Parm                    BeginDate         8
007009090804     C                   Parm                    EndDate           8
007010090804     C                   Parm                    Err               8
007011090804      *
007012090804    ?C                   Endsr                                                  END PLIST
007013090804      *
007014090804    ?C     Klist         Begsr                                                  PARM LISTS
007015090804     C     CovKey        Klist
007016090804     C                   Kfld                    KTrst             3 0
007017090804     C                   Kfld                    KSub              3 0
007018090804     C                   Kfld                    Plan
007019090804     C                   Kfld                    KSocial           9 0
007020090804     C                   Kfld                    KSeq              2 0
007021090804      *
007022090804    ?C                   Endsr                                                  END PLIST
007300090804
