0001000204020002  *****************************************************************************
000200200407      * PAYDFR10R  Group Benefit Services                                         *
000300150924      *            WRITTEN BY - R.L.J.                                            *
000400200407      *            DATE - 04/2020                                                 *
000500200407      *  DESCRIPTION - Build Input File for Pmt Deferral system for CF            *
000600150924      *                                                                           *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900060427      *  xxx mm/dd/yyyy                                                           *
001000150924      *                                                                *
0011001509170018 F******************************************************************
0012002004070019 FPAYDFROP  IP   E           K DISK
0013002004070020 FPAYDFRIP  UF A E           K DISK
001400171212    * *
001500171212     D                 DS
001600200407     D pogtsa                  1     12A
001700200407     D atrst                   1      3A
001800200407     D gbs1                    4      4A
001900200407     D asub#                   5      7A
002000200408     D gbs2                    8      8A
002100200407     D aacct                   9     12A
002200200407    * *
002300200407     D                 DS
002400200407     D odate                   1      8A
002500200407     D ommdd                   1      4A
002600200407     D oyy                     5      8A
002700200407    * *
002800200407     D                 DS
002900200407     D idate                   1      8A
003000200407     D iyy                     1      4A
003100200407     D immdd                   5      8A
0032001712120025  *
0033000604270250 D                 DS
003400200407     D ntrst                          3S 0
003500200407     D nsub#                          3S 0
003600200407     D nacct                          4S 0
003700161028    * *
0038002004070291 C                   clear                   paydfrir
0039002004080291 C                   eval      pigtsa = pogtsa
0040001509220291  *
004100200408     C                   movel     atrst         pitrst
004200200408     C                   movel     asub#         pisub#
004300200408     C                   movel     aacct         piacct
0044002004080291  *
004500200408     C                   movel     pofrmdt       odate
0046002004080291 C                   eval      immdd = ommdd
0047002004080291 C                   eval      iyy = oyy
004800200408     C                   movel     idate         pifrmdt
0049002004080291  *
005000200408     C                   movel     potodt        odate
0051002004080291 C                   eval      immdd = ommdd
0052002004080291 C                   eval      iyy = oyy
005300200408     C                   movel     idate         pitodt
0054001802120291  *
0055002004080291 C                   write     paydfrir
