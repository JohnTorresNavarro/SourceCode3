000100140404     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ACAAUDITR')
000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  debug ACA_MBR_AUD
000500000000      *
000600140404      *  (c)Copyright 2014 by GBS, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - April 04, 2014
000900000000      *_________________________________________________________________________
001000140404
001100141229      /define aca_mbr_audit_pr
001200141229      /define aca_mbr_audit_fields
001300141229      /define aca_mbr_audit_return
001400140404      /copy qcpysrc,acambraudp
001500141229      /undefine aca_mbr_audit_pr
001600141229      /undefine aca_mbr_audit_fields
001700141229      /undefine aca_mbr_audit_return
001800141229
001900141229      /define copy_all_protos_and_fields
002000141229      /copy qcpysrc,acasrvpgmp
002100141229      /undefine copy_all_protos_and_fields
002200141229
002300140404
002400140404     D Afield          S              1    INZ('A')
002500140404     D parmcount       S              3  0 inz
002600141229     D prem_count      s              3  0
002700141229     D prem_error      s             50
002800140404
002900140404     D workds        e ds                  extname(MCOV) inz
003000141229     D mtrans          s                   like(acc#)
003100140404
003200220107     C                   eval      mctrst = 003
003300220107     C                   eval      mcsub# = 001
003400220107     C                   eval      acc#   = 1145
003500220107     C                   eval      mcssno = 217843599
003600220107     C                   eval      mcplan = 'TLGB'
003700220107     C                   eval      enrldt = 20220107
003800140404
003900140404     C                   eval      p_audit = #aca_mbr_audit(mctrst:mcsub#:
004000140404     C                                       acc#:mcssno:mcplan:enrldt:
004100140404     C                                       afield:parmcount)
004200140404
004300141230     C                   eval      parmcount = parmcount
004400141230
004500141230     C***                eval      mtrans    = 0003
004600141230
004700141230      /free
004800141230
004900141230         p_audit = #aca_mbr_audit(mctrst:mcsub#:acc#:mcssno:
005000141230                   mcplan:enrldt:'A':prem_count:mtrans) ;
005100141229
005200141230         if prem_count = *zeros ; // no ACA prem found - error!!
005300141230         endif ;
005400141229
005500141229
005600141229         p_mbrdeparry = #get_ACA_premiums(mctrst:mcsub#:mcplan:mcssno:
005700141229                        enrldt:prem_error:prem_count:mtrans) ;
005800141229
005900141229         if prem_count = *zeros ; // no ACA prem found - error!!
006000141229         endif ;
006100141229
006200141229      /end-free
006300141229
006400140404     C                   return
006500140404
