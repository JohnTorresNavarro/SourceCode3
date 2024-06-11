0001009102150002 F******************************************************************
0002000107240003 F* CR210      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009102150004 F*                                                                *
0004000107240004 F*          DLK - 07/24/01                                        *
0005009510040004 F*                                                                *
0006000107240013 F*          Read workfile (CR210WK). Accululate and write CFS     *
0007000107240014 F*          compensation file (CR210OUT).                         *
0008009808120015 F*                                                                *
0009000108280015 F* 08/28/01 dlk - change to work with year 2001+ data (no need to *
0010000108280015 F*                get member count from rpa060wk).                *
0011000301310015 F* 01/30/03 dlk - add DBE. add break by bc/phn/dbe so admin/dbe   *
0012000301310015 F*                can be seperated.                               *
0013000304300015 F* 03/30/03 ssk - salesman relationship project                   *
0014000301310015 F*                                                                *
0015009102150016 F******************************************************************
0016000107240018 FCR210wk   Ip   E           K DISK
0017000304300018 F*gency    If   E           K DISK
0018000107240018 Faccmst    If   E           K DISK
0019000107240027 FCR210out  O  a e             disk
002000010725     Dadmtxt           C                   CONST('ADMINISTRATOR')
002100030131     Ddbetxt           C                   CONST('DBE          ')
0022000108010124 D                UDS
0023000108010125 D  LFYMD                 85     92  0
0024000108010125 D  LTYMD                 93    100  0
002500010724     Icr210wkr
002600030430     I*                                         cagcod        L3
002700030131     I                                          cbpd          L2
002800010724     I                                          ctrust        L1
002900010724     I                                          csub          L1
003000010724     I                                          cacct         L1
003100010724     c* get agency info
003200030430     c*                  if        *inl3
003300030430     C*    cagcod        CHAIN     agency
003400030430     c*                  end
003500010724
003600010725     c* get acct name
003700010724     c                   if        *inl1
003800010724     C     tsa           CHAIN     accmst
003900010724     c                   end
004000010725
004100010801     c* count paid prem by carrier
004200010801     c                   exsr      #carpaid
004300010828
004400010828     c* get contracts paid by carrier
004500010824     c                   exsr      #carcont
004600010801
004700010724     cL1                 exsr      #l1sr
004800010724
004900010724     c***********************************************************
005000010725     c* write to CR210OUT at L1 total (acct change)             *
005100010724     c***********************************************************
005200010724     c     #l1sr         begsr
005300010724
005400030430     c*                  if        %found(agency)
0055000304300202 C*                  movel     agnam1        c2agname                                      SR#NA
0056000304300202 C*                  move      agtxid        c2agtxid                                      SR#NA
005700030430     c*                  else
005800030430     c*                  move      *blanks       c2agname
0059000304300202 C*                  move      *zeros        c2agtxid                                      SR#NA
006000030430     C*                  end
006100030430     c                   movel(p)  cagnam        c2agname
006200030430     c                   move      cagtin        c2agtxid
006300010724
006400010724     c                   if        %found(accmst)
0065000107240202 C                   movel     acnam1        c2accname                                     SR#NA
006600010724     c                   else
006700010724     c                   move      *blanks       c2accname
006800010724     C                   end
006900010724
007000030131     c                   if        cbpd = 'D'
007100030131     c                   movel     dbetxt        c2admin
007200030131     c                   else
007300030131     c                   movel     admtxt        c2admin
007400030131     c                   end
007500030131
007600010725     c                   move      cagcod        c2agcode
007700010725     c                   move      ctrust        c2trust
007800010725     c                   move      csub          c2sub
007900010725     c                   move      cacct         c2acc#
008000010725     c                   move      'N'           c2sfyn
008100010725     c                   move      'N'           c2201yn
008200010801     c                   eval      c2gtprem = c2phnpp + c2dhppp + c2bcbspp +
008300030203     c                                        c2fspp + c2dcipp + c2dchpp
008400010801
008500010724     c                   write     cr210r
008600010725     c                   clear                   cr210r
008700010724
008800010724     c                   endsr
008900010725
009000010725     c***********************************************************
009100010801     c* carrier breakdown - paid prem                           *
009200010725     c***********************************************************
009300010801     c     #carpaid      begsr
009400010801
009500010725     c                   select
009600010725     c* PHN
009700010725     c                   when      ccarcd = 'PHN'
009800010725     c                   add       cpamt         c2phnpp
009900010725     c* Delmarva health plan
010000010725     c                   when      ccarcd = 'DEL'
010100010725     c                   add       cpamt         c2dhppp
010200010725     c* bcbs
010300010725     c                   when      ccarcd = 'BCM' or ccarcd = 'BMS'
010400010725     c                   add       cpamt         c2bcbspp
010500010725     c* freestate
010600010725     c                   when      ccarcd = 'FRE'
010700010725     c                   add       cpamt         c2fspp
010800010725     c* vision
010900010725     c                   when      ccarcd = 'BVS'
011000010725     c                   add       cpamt         c2vispp
011100010725     c* dental
011200010725     c                   when      ccarcd = 'BCS'
011300010725     c                   add       cpamt         c2denpp
011400010725     c* assoc med
011500010725     c                   when      ccarcd = 'BAM' or ccarcd = 'BSS'
011600010725     c                   add       cpamt         c2ampp
011700010725     c* assoc den
011800010725     c                   when      ccarcd = 'BAS' or ccarcd = 'BDA'
011900010725     c                   add       cpamt         c2adpp
012000010725     c* cpha assoc
012100010725     c                   when      ccarcd = 'BCP' or ccarcd = 'CAP' or
012200010725     c                             ccarcd = 'CPH'
012300010725     c                   add       cpamt         c2cpapp
012400030131     c* dbe medical indem
012500030131     c                   when      cbpd = 'D' and cptype = 'MI'
012600030131     c                   add       cpamt         c2dcipp
012700030131     c* dbe medical hmo
012800030131     c                   when      cbpd = 'D' and cptype = 'MH'
012900030131     c                   add       cpamt         c2dchpp
013000030131
013100010725     c                   endsl
013200010725
013300010725     c                   endsr
013400010801     c***********************************************************
013500010801     c* carrier breakdown - contracts paid                      *
013600010801     c***********************************************************
013700010801     c     #carcont      begsr
013800010801
013900010801     c                   select
014000010801     c* PHN
014100030131     c* Delmarva health plan
014200030131     c* freestate
014300030131     c                   when      ccarcd = 'PHN' or ccarcd = 'DEL' or
014400030131     c                             ccarcd = 'BCM' or ccarcd = 'BMS' or
014500030131     c                             ccarcd = 'FRE'
014600010828     c                   add       clives        c2medcp
014700010801     c* vision
014800010828     c                   when      ccarcd = 'BVS'
014900010828     c                   add       clives        c2viscp
015000010801     c* dental
015100010828     c                   when      ccarcd = 'BCS'
015200010828     c                   add       clives        c2dencp
015300010801     c* assoc med
015400010828     c                   when      ccarcd = 'BAM' or ccarcd = 'BSS'
015500010828     c                   add       clives        c2amcp
015600010801     c* assoc den
015700010828     c                   when      ccarcd = 'BAS' or ccarcd = 'BDA'
015800010828     c                   add       clives        c2adcp
015900010801     c* cpha assoc
016000010828     c                   when      ccarcd = 'BCP' or ccarcd = 'CAP' or
016100010828     c                             ccarcd = 'CPH'
016200010828     c                   add       clives        c2cpacp
016300030131     c* dbe medical indem
016400030131     c                   when      cbpd = 'D' and cptype = 'MI'
016500030131     c                   add       clives        c2dcicp
016600030131     c* dbe medical hmo
016700030131     c                   when      cbpd = 'D' and cptype = 'MH'
016800030131     c                   add       clives        c2dchcp
016900030131
017000010801     c                   endsl
017100010801
017200010801     c                   endsr
017300010725
017400010725     c***********************************************************
017500010724     c     *inzsr        begsr
017600010724     c     tsa           klist
017700010724     c                   kfld                    ctrust
017800010724     c                   kfld                    csub
017900010724     c                   kfld                    cacct
018000010724     c                   endsr
