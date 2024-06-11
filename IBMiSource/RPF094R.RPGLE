000100001003    ? *_________________________________________________________________________
000200001003    ? *                                                                *
000300030902    ? *  Description:  RPF094R  Load LDA for Account Cancellation      *
000301030902    ? *                              Reprint Letters                   *
000400001003    ? *                                                                *
000500030121    ? *  (c)Copyright 2003 by GBSIO, Inc.                              *
000600020729    ? *  This document contains restricted materials of GBSIO, Inc.    *
000700001003    ? *                                                                *
000800030121    ? *  Written by:    SZZ                                            *
000900030902    ? *  Date Written:  9/2/03                                         *
001000001003    ? *                                                                *
001100001003    ? *  History:                                                      *
001200030721    ? *            Revised by -                                        *
001300030721    ? *            Date -                                              *
001400030721    ? *            Revision -                                          *
001933021218      *                                                                *
002000991207    ? *_________________________________________________________________________
002002030902     FCANLET    IF   E           K DISK
002003030902      *                                                                *
002005030902     D LDAPRM         UDS
0020060309020056 D  LMDY                   1      8  0
0020070309020056 D  LMM                    1      2  0
0020080309020056 D  LDD                    3      4
0020090309020056 D  LCY                    5      8
0020100309020056 D  LTRST                  9     11  0
0020110309020056 D  LSUB#                 12     14  0
0020120309020056 D  LACCT                 15     18  0
002013030902     D MBRLET_YN             140    140
0020140309020056 D  LUCMM                141    142  0
0020150309020056 D  LUCYY                143    146
002016030902     D  LTRMDY               147    154  0
002017150303     D  Lleteffymd           155    162  0
002018150303     D  Loutbal              163    172  2
002019150313     D  Lcflet               173    173
0020200309020056 D  LGRP                  20    139    DIM(8)
003113030121      *
004900021003      *
005002030721     C                   Exsr      Process
005400991208      *
005500020729    ?C                   Move      *On           *inLR
005600021004     C
005700021004    ? *________________________________________________________________
005800030121    ?C     Process       Begsr
005900021004    ? *
005902030902     C     LDA_Key       Setll     CANLET
005903030902     C     1             Do        8             Ctr               1 0
005904030902     C     LDA_Key       Reade     CANLET                                 97
005905030902     C                   If        *In97 = *On
005906030902     C                   Leave
005907030902     C                   End
005909030902     C                   Movel     CLGRP#        LGRP(Ctr)
005910150304
005911150304     c                   if        clletefdt <> 0
005912150303     C                   Move      clletefdt     Lleteffymd
005913150304     c                   else
005914150304     C                   Move      clcndt        Lleteffymd
005915150304     c                   end
005916150304
005917150303     C                   Move      cloutbal      Loutbal
005918150313     C                   Move      clcflet       Lcflet
005919030902     C                   Out       LDAPRM
005931030902     C                   Enddo
012000021004    ? *
012100021004    ?C                   Endsr
012101030902    ? *___________________________________________________________________
012102030902    ? * Key lists
012103030902    ? *___________________________________________________________________
012104030902    ?C     KLIST         Begsr                                                  KEY LISTS
012105030902    ?C     LDA_Key       Klist
012106030902    ?C                   Kfld                    KTRST
012107030902    ?C                   Kfld                    KSUB#
012108030902    ?C                   Kfld                    KACCT
012111030902    ?C                   Kfld                    KCNDT                          RECORD KEY
012112030902    ?C                   Kfld                    KUNMY                          FUNCTIONS VALID
012113030902    ?C                   Kfld                    KMLYN                          FUNCTIONS VALID
012114030902    ?C                   Kfld                    KOLDT                          FUNCTIONS VALID
012116030902    ? *
012117030902    ?C                   Endsr
012118030902    ? *___________________________________________________________________
012119030902    ? * Parameter list
012120030902    ? *___________________________________________________________________
012121030902    ?C     PLIST         Begsr                                                  PARM LISTS
012122030902    ?C     *ENTRY        Plist                                                  *ENTRY LIST
012123030902    ?C                   Parm                    TRST              3            REQUEST
012124030902    ?C                   Parm                    SUB#              3            RETURN CODE
012125030902    ?C                   Parm                    ACCT              4            LAST PGM NAME
012126030902    ?C                   Parm                    CNDT              8            RECORD KEY
012127030902    ?C                   Parm                    UNMY              6            FUNCTIONS VALID
012128030902    ?C                   Parm                    MLYN              1            FUNCTIONS VALID
012129030902    ?C                   Parm                    OLDT              8            FUNCTIONS VALID
012130030902    ?C                   Endsr                                                  END PLIST
030900020726    ? *________________________________________________________________
031000020726    ? * Initialization
031100020726    ? *________________________________________________________________
031200001003    ?C     *INZSR        Begsr
031227030121    ? *
031229030902     C     *DTAARA       DEFINE    *LDA          LDAPRM
031300021007     C     *DATE         Mult      10000.0001    Today             8 0
031301030902    ?C                   Move      TRST          KTRST             3 0          REQUEST
031302030902    ?C                   Move      SUB#          KSUB#             3 0          RETURN CODE
031303030902    ?C                   Move      ACCT          KACCT             4 0          LAST PGM NAME
031304030902    ?C                   Move      CNDT          KCNDT             8 0          RECORD KEY
031305030902    ?C                   Move      UNMY          KUNMY             6 0          FUNCTIONS VALID
031306030902    ?C                   Movel     MLYN          KMLYN             1            FUNCTIONS VALID
031307030902    ?C                   Move      OLDT          KOLDT             8 0          FUNCTIONS VALID
031308030902     C     KCNDT         Mult      10000.0001    KCNDT
031309030902     C     KOLDT         Mult      10000.0001    KOLDT
031310030902     C                   Move      KUNMY         UnCCYY            4 0
031311030902     C                   Movel     KUNMY         UnMM              2 0
031312030902     C                   Move      UnMM          KUNMY
031313030902     C                   Movel     UnCCYY        KUNMY
031400001003    ?C                   Endsr
