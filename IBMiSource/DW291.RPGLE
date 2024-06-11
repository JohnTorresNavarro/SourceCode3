0001000210290015  ******************************************************************
000200030702      * DW291          Group Benefit Services, Inc.                    *
000300021029      *                                                                *
000400021029      *    WRITTEN BY - DAVID KETTERMAN                                *
000500021029      *    DATE       - 10/29/02                                       *
000600021029      *                                                                *
000700030804      * This program will produce the DB FBR work file from CR130HSD   *
0008000309260015  * ** it is called from dw291cl & dw262cl **                      *
0009000307020015  *                                                                *
0009011509030015  * 09/03/15 - create 2 seperate files, one for non-shop and one   *
0009021509030015  *            for shop. Care First request.                       *
0009031612210015  * 12/21/16 - stop creating seperate file for shop                *
0009041901100015  * 01/10/19 dlk - replicate PSF logic here to add the commission  *
0009051901100015  *                amount to the paid amount so the FBR matches    *
0009061901100015  *                the GPR.                                        *
0009071901100015  *   * Note - Any change to the PSF logic will need to be made    *
0009081901100015  *            in DW290 also.                                      *
0009091901100015  *                                                                *
0010000302110015  ******************************************************************
001100021029     Fcr130hsd  IP   E             DISK
0012000307020030 Fdbfbrwk   O  A e             DISK
0013000210290055 D                 DS
0014000210290056 D  cgroup                 1     15
0015000210290056 D   groupid               1      8
0016000210290056 D   subgroupid            9     12
001700030702     Icrhstr
001800030702     I                                          cgroup        L1
001801150903
001802150904     c                   if        *inl1
001901161221     C                   clear                   PAID              9 2
001905150904     c                   end
002000030702
002001161221      * accumulate paid amount
002100161221     C                   add       cpamt         PAID
002101190110
002102190110      * PSF carriers -
002103190110      * Since care first still wants us to send the full billed amount,
002104190110      * the commission will have to be ADDED to the paid amt to come up
002105190110      * with the actual billed.
002106190110     c                   if        ccarcd = 'PSM' or ccarcd = 'PSX'
002107190110     C                   add       ccome         PAID
002108190110     C                   end
002200030702
002300030702     cl1                 exsr      #l1tot
002400030702
002500030702     c     #l1tot        begsr
002501161221
002600161221     C                   MOVE      PAID          dbwkpaid
002700030702     C                   MOVEl     groupid       dbwkgrp
002800030702     C                   MOVEl     subgroupid    dbwksg
002900030702     C                   write     dbfbrwkr
002910150903
003000030702     c                   endsr
