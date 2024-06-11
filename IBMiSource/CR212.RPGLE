0001009102150002 F******************************************************************
0002000201100003 F* cr212      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009102150004 F*                                                                *
0004000201100004 F*          David Ketterman                                       *
0005000201100004 F*          01/10/02                                              *
0006009510040004 F*                                                                *
0007000201110004 F*          Create CFS Persistency Bonus Draw file.               *
0008000201110013 F*          Read workfile (CR210WK). Accululate and break by      *
0009000201110014 F*          agency/group creating CR212OUT.                       *
0010009808120015 F*                                                                *
0011000108280015 F*                                                                *
0012009102150016 F******************************************************************
0013000304300015 F* 03/30/03 ssk - salesman relationship project                   *
0014000304300015 F*                                                                *
0015000304300016 F******************************************************************
0016000201110018 FCR210wk   Ip   E             DISK
0017000304300018 F*gency    If   E           K DISK
0018000201100027 Fcr212out  O  a e             disk
001900020111     Dgbs              C                   CONST('GROUP BENEFIT SERVICES, INC.')
0020000108010124 D                UDS
0021000108010125 D  LFYMD                 85     92  0
0022000108010125 D  LTYMD                 93    100  0
002300010724     Icr210wkr
002400030430     I*                                         cagcod        L2
002500020110     I                                          cgroup        L1
002600010724     c* get agency info
002700030430     c*                  if        *inl2
002800030430     C*    cagcod        CHAIN     agency
002900030430     c*                  end
003000010724
003100020111     c* paid prem total (all months selected)
003200020111     c                   add       cpamt         c2premtot
003300020111
003400020111     c* commision total (all months selected)
003500020111     c                   add       ccome         c2comtot
003600020111
003700020111     c* contract count (only for last month of selection)
003800020111     c                   if        ceffdt = ltymd
003900020111     c                   add       clives        c2conttot
004000020111     c                   end
004100010801
004200010724     cL1                 exsr      #l1sr
004300010724
004400010724     c***********************************************************
004500020110     c* write to cr212OUT at L1 total (group change)            *
004600010724     c***********************************************************
004700010724     c     #l1sr         begsr
004800010724
004900030430     c*                  if        %found(agency)
0050000304300202 C*                  movel     agnam1        c2agname                                      SR#NA
0051000304300202 C*                  move      agtxid        c2agtxid                                      SR#NA
005200030430     c*                  else
005300030430     c*                  clear                   c2agname
0054000304300202 C*                  clear                   c2agtxid                                      SR#NA
005500030430     C*                  end
0056000304300202 C                   movel(p)  cagnam        c2agname                                      SR#NA
0057000304300202 C                   move      cagtin        c2agtxid                                      SR#NA
005800010724
005900020111     c                   move      '296'         c2admin
006000020111     c                   movel     gbs           c2adminnam
006100010725     c                   move      cagcod        c2agcode
006200020111     c                   move      cgroup        c2group
006300020111
006400020110     c                   write     cr212r
006500020110     c                   clear                   cr212r
006600010724
006700010724     c                   endsr
