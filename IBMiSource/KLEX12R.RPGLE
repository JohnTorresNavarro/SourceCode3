000100001003    ? *_________________________________________________________________________
000200001003    ? *                                                                *
000300111011    ? *  Description:  KLEX12R                                         *
000400001003    ? *                                                                *
000500111011    ? *  (c)Copyright 2011 by GBS Inc.                                 *
000600041116    ? *  This document contains restricted materials of GBS, Inc.      *
000700001003    ? *                                                                *
000800030121    ? *  Written by:    SZZ                                            *
000900111011    ? *  Date Written: 10/11/11                                        *
001000001003    ? *                                                                *
001100001003    ? *  History:                                                      *
001200041116    ? *            Revised by -                                        *
001300041116    ? *            Date -                                              *
001400041116    ? *            Revision -                                          *
001932030127      *                                                                *
001933021218      *                                                                *
002000991207    ? *_________________________________________________________________________
002002111011     FHISTL9    IF   E           K DISK
002300111011    ?FKLEX12P   O    E           K DISK
003129030121      *
003130111011     D DAC             S              3    Inz('DAC')
003131111011     D TC              S              6    Inz('TC= # ')
003132111011    ?D TodayISO        S               D   datfmt(*ISO)
003133111011     D Friday          S              8S 0 inz
003134111011     D Yesterday       S              8S 0 inz
003135111011      *
004800111011     C     HstKey        Setll     HISTL9
004801111011     C     HstKey        Reade     HISTL9
004900021003      *
005000111011    ?C                   Dow       Not %Eof(HISTL9)
005100030121     C                   Exsr      Process
005201111011     C     HstKey        Reade     HISTL9
005300111011    ?C                   Enddo
005400991208      *
005500030127    ?C                   Move      *On           *InLR
005600021004     C
005700021004    ? *________________________________________________________________
005800030121    ?C     Process       Begsr
005801041116    ? *________________________________________________________________
012000021004    ? *
012001111011     C                   Eval      TCTRST    =   HSTRST
012003111011     C                   Eval      TCSUB#    =   HSSUB#
012005111011     C                   Eval      TCACCT    =   HSACCT
012007111011     C                   Eval      TCTRDT    =   TRDATE
012009111011     C                   Eval      TCCVDT    =   COVTDT
012010111011     C                   Eval      TCPODT    =   Today
012025111011     C                   Write     KLEX12R
012026111011     C                   Clear                   KLEX12R
012100021004    ?C                   Endsr
012200111011    ? *___________________________________________________________________
012300111011    ? * Klists
012400111011    ? *___________________________________________________________________
012500111011    ?C     KList         Begsr
012501111011     C     HstKey        Klist
012502111011     C                   Kfld                    PrevDay           8 0
012503111011     C                   Kfld                    DAC
012504111011     C                   Kfld                    TC
012700111011      *
012800111011    ?C                   Endsr
012900111011    ? *___________________________________________________________________
013000111011     C     *Inzsr        BEGSR
013100111011    ? *___________________________________________________________________
013200111011     C     *DATE         Mult      10000.0001    Today             8 0
013201111011     C     *ISO          Move      Today         TodayISO
013204111011    ?C                   Call      'DAYOFWEEK'
013205111011    ?C                   Parm                    Day               4
013206111011     C                   Select
013207111011     C                   When      Day      =    '*MON'
013209111011     C                   Subdur    3:*D          TodayISO
013210111011     C     *ISO          Move      TodayISO      Friday
013211111011     C                   Move      Friday        PrevDay
013212111011     C                   Other
013213111011     C                   Subdur    1:*D          TodayISO
013214111011     C     *ISO          Move      TodayISO      Yesterday
013215111011     C                   Move      Yesterday     PrevDay
013216111011     C                   End
013217111011      *
013600111011     C                   EndSr
013800111011     C/EJECT
