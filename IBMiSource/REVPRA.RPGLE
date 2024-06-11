000100000000      *_________________________________________________________________________
000200000000      *
000300080731      *  Description:  Check Payment Reversal for Account/Cobra
000400000000      *
000500080731      *  (C)COPYRIGHT 2008 BY GROUP BENEFIT SERVICES, INC.
000600000000      *
000601131004      *
000602131004      * dlk 10/04/13 - hist file expansion project - recompile only
000603131004      *
000700000000      *___________________________________________________________________
000901081119     FHISTL7    IF   E           K Disk
000902090106     FHISTL8    IF   E           K Disk    Rename(HISTR:HIST8) Prefix(H8)
001800000000      *___________________________________________________________________
001801080625     D RADATE          S              8S 0
001802081112     D COVTDT          S              8S 0
001803080625     D TRAMT2          S              9P 2
002001080625
002100080625     C     *ENTRY        PLIST
002101080625     C                   PARM                    HKEY
002102080625     C                   PARM                    CHECK#
002103080625     C                   PARM                    TRAMT
002104080625     C                   PARM                    RADATE
002200080625     C                   PARM                    WOFLG             1
002201081112     C                   Parm                    COVTDT
002202080625      *
002203080625     C     TRAMT         Mult      -1            TRAMT2
002204080625      *
002205080625     C                   Select
002206080625     C                   When      RADATE  = 0
002207090106     C     HistKey       Chain     HISTL8
002209080625     C                   If        %found
002210080625     C                   Eval      WOFLG = 'R'
002211080625     C                   Else
002212080625     C                   Eval      WOFLG = ' '
002213080625     C                   End
002214080625     C                   When      RADATE <> 0
002215081119     C     HistKey2      Chain     HISTL7
002217080625     C                   If        %found
002218080625     C                   Eval      WOFLG = 'R'
002219080625     C                   Else
002220080625     C                   Eval      WOFLG = ' '
002221080625     C                   End
002222080625     C                   Endsl
002223080625      *
002224080625     C                   Return
002400080625      *
002500080625    ?C     HistKey       Klist
002600080625    ?C                   Kfld                    HKey
002601080625    ?C                   Kfld                    CHECK#
002700080625    ?C                   Kfld                    TRAMT2
002701090106     C                   Kfld                    COVTDT
002800080625      *
002900080625    ?C     HistKey2      Klist
003000080625    ?C                   Kfld                    HKey
003100080625    ?C                   Kfld                    CHECK#
003101080625    ?C                   Kfld                    TRAMT2
003200080625     C                   Kfld                    RADATE
003201081112     C                   Kfld                    COVTDT
003300080625      *
