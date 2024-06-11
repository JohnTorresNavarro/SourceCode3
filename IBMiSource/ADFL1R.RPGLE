000100001003    ? *_________________________________________________________________________
000200001003    ? *                                                                *
000300130221    ? *  Description:  ADFL1R  Load allow-domestic-partner flag in     *
000301130221    ? *                          ACCADP file one time.                 *
000400001003    ? *                                                                *
000500130221    ? *  (c)Copyright 2013 by GBS Inc.                                 *
000600041116    ? *  This document contains restricted materials of GBS, Inc.      *
000700001003    ? *                                                                *
000800030121    ? *  Written by:    SZZ                                            *
000900130221    ? *  Date Written:  2/21/13                                        *
001000001003    ? *                                                                *
001100001003    ? *  History:                                                      *
001200041116    ? *            Revised by -                                        *
001300041116    ? *            Date -                                              *
001400041116    ? *            Revision -                                          *
001932030127      *                                                                *
001933021218      *                                                                *
002000991207    ? *_________________________________________________________________________
002001130227     FACCMST    IF   E           K Disk
002003130221     FDEPEND    IF   E           K Disk
002004130227     FMEMAC#    IF   E           K Disk
002005130227     FMEMBER    IF   E           K Disk    Rename(MEMBR:MEM) Prefix(M)
002300130221    ?FACCADP    UF A E           K Disk
003137081223      *
003138130227     C                   Exsr      Undecided
003139130227      *
003140130227     C                   Read      DEPEND
003142130227    ?C                   Dow       Not %Eof(DEPEND)
003143130227     C                   If        DRELCD  =   'RPA'
005100030121     C                   Exsr      Process
005101130227     C                   End
005205130227     C                   Read      DEPEND
005300001003    ?C                   Enddo
005400991208      *
005500030127    ?C                   Move      *On           *InLR
005601130227    ? *________________________________________________________________
005602130227    ?C     Undecided     Begsr
005603130227    ? *________________________________________________________________
005606130227     C                   Read      ACCMST
005607130227    ?C                   Dow       Not %Eof(ACCMST)
005608130227     C                   If        ATRMDT    =   *Zeros  Or
005609130227     C                             ATRMDT    >   Today
005610130227     C     AccKey        Chain     MEMAC#
005611130227     C                   If        %Found(MEMAC#)
005612130227     C                   If        MBCAND   =    *Zeros   Or
005613130227     C                             MBCAND   >    Today
005614130227     C     AccKey        Chain     ACCADP
005617130227     C                   Eval      ADADFL   =    'U'
005618130227     C                   Eval      ADTRST   =    MBTRST
005619130227     C                   Eval      ADSUB#   =    MBSUB#
005620130227     C                   Eval      ADACCT   =    MBACCT
005621130227     C                   Eval      ADCHDT   =    Today
005622130227     C                   Time                    ADCHTM
005623130227     C                   Eval      ADCHGU   =    'ADFL1R'
005624130227     C                   If        Not %Found(ACCADP)
005625130227     C                   Write     ACCADPR
005626130227     C                   Else
005627130227     C                   Update    ACCADPR
005629130227     C                   End
005630130227     C                   Clear                   ACCADPR
005631130227     C                   End
005632130227     C                   End
005633130227     C                   End
005634130227     C                   Read      ACCMST
005635130227    ?C                   Enddo
005636130227    ?C                   Endsr
005700021004    ? *________________________________________________________________
005800030121    ?C     Process       Begsr
005801041116    ? *________________________________________________________________
012000021004    ? *
012001130227     C     DSSNO         Chain     MEMBER
012002130227     C                   If        %Found(MEMBER)
012006130227     C     MemKey        Chain     ACCADP
012014130221     C                   Eval      ADADFL   =    'Y'
012024130227     C                   Eval      ADCHDT   =    Today
012025130227     C                   Time                    ADCHTM
012027130227     C                   Eval      ADCHGU   =    'ADFL1R'
012029130227     C                   Eval      ADTRST   =    MMBTRST
012030130227     C                   Eval      ADSUB#   =    MMBSUB#
012031130227     C                   Eval      ADACCT   =    MMBACCT
012032130227     C                   If        Not %Found(ACCADP)
012033130221     C                   Write     ACCADPR
012034130227     C                   Else
012035130227     C                   Update    ACCADPR
012041130227     C                   End
012042130227     C                   End
012044130221
012100021004    ?C                   Endsr
012200130221    ? *___________________________________________________________________
012300130221    ? * Klists
012400130221    ? *___________________________________________________________________
012500130221    ?C     KList         Begsr
012600130221    ? *
012700130221     C     AccKey        Klist
012800130227    ?C                   Kfld                    ACTRST
012900130227    ?C                   Kfld                    ACSUB#
013000130227    ?C                   Kfld                    ACACCT
013001130227      *
013002130227     C     MemKey        Klist
013003130227    ?C                   Kfld                    MMBTRST
013004130227    ?C                   Kfld                    MMBSUB#
013005130227    ?C                   Kfld                    MMBACCT
013006130221    ? *
013007130221     C                   EndSr
016900130221    ? *___________________________________________________________________
017000130221     C     *Inzsr        BegSr
017100130221    ? *___________________________________________________________________
017101130221    ? *
017200130221     C     *DATE         Mult      10000.0001    Today             8 0
017201130221    ? *
017300130221     C                   EndSr
