000100201110     H FIXNBR(*ZONED)
000200000000      ****************************************************************
000300000000      *                                                              *
000400220426      * RP130AG    GROUP BENEFIT SERVICES SOFTWARE           2020    *
000500000000      *                                                              *
000600201110      *            WRITTEN BY - David Ketterman                      *
000700201110      *            DATE - 11/10/20                                   *
000800000000      *                                                              *
000900220426      *  DESCRIPTION - This program will pass all records to a new   *
001000220426      *                workfile, but only including the agency or    *
001100220426      *                principal carrier when they are selected.     *
001200220426      *                It calls GET1AGCL.                            *
001300201117      *                                                              *
001400220105      * 01/05/22 dlk - add selection for Principal carrier also      *
001500220426      * 04/26/22 dlk - changed from ebs selection to the agency      *
001600220426      *                parm passed selection.                        *
001700220426      *                                                              *
001800220105      *                                                              *
001900000000      ****************************************************************
002000201110     Fwsrp130   ip   F  216        DISK
002100220105     Fplnmst    IF   E           k DISK
002200220105     Fcarmst    IF   E           k DISK
002300201110     Frp130wk   o  a F  216        DISK
002400220426     D parmagyn        S              1
002500220426     D parmagag        S              3
002600220426     D parmagtsa       S             10
002700201110     D skiprec         S              1
002800220105     D pricar          S              1
002900050920     D* LDA
003000000000     D                UDS
003100220426     D  lagency               95     97
003200220426     D  lprionly              98     98
003300201110     Iwsrp130   NS  01
003400220105     I*  TRANSACTION HISTORY FILE record format
003500201110     I                                  1  216  wsrec
003600220105     I                                 17   19  TRCODE
003700220105     I                                 26   29  CK#PLN
003800201110     I                                110  112 0HSTRST
003900201110     I                                113  115 0HSSUB#
004000201110     I                                116  119 0HSACCT
004100201110
004200201110       clear skiprec;
004300201110
0044002201050103  *
0045002204260103  * agency selection
0046002201050103  *
004700220426       if lagency <> *blanks;
004800220426        exsr #chkag;
004900201110       endif;
005000201110
0051002201050103  *
0052002201050103  * Principal Carrier only selection
0053002201050103  *
005400220105       if lprionly = 'Y';
005500220105        exsr #chkpri;
005600220105       endif;
005700220105
005800201110       if skiprec = *blank;
005900201110        except rp130add;
006000201110       endif;
006100201110
0062002011100103  ***************************************************
0063002204260104  * check the account for the agency selected
0064002011100105  ***************************************************
0065002204260106   begsr #chkag;
006600201110
006700220426       parmagtsa = %editc(hstrst:'X') + %editc(hssub#:'X') +
006800220426                   %editc(hsacct:'X');
006900220426       parmagag = lagency;
007000220426       clear parmagyn;
007100201110
007200220426     c                   call      'GET1AGCL'
007300220426     c                   parm                    parmagtsa
007400220426     c                   parm                    parmagag
007500220426     c                   parm                    parmagyn
007600201110
007700220426       if parmagyn <> 'Y';
007800201110       skiprec = 'Y';
007900201110       endif;
008000201110
0081002011100106   endsr;
008200201110
0083002201050103  ***************************************************
0084002201050104  * check for Principal carrier code
0085002201050105  ***************************************************
0086002201050106   begsr #chkpri;
008700220105
0088002201050104  * get carrier
008900220105       exsr #getcar;
009000220105
009100220105       if pricar <> 'Y';
009200220105        skiprec = 'Y';
009300220105       endif;
009400220105
0095002201050106   endsr;
009600220105
0097002201050103  *****************************************************************
0098002201050104  * get carrier if this is a member transaction that uses plan    *
0099002201050103  *****************************************************************
0100002201050107  *
0101002201050106   begsr #getcar;
010200220105      *
010300220105      * get carrier code if this trcode is a member level code that uses
010400220105      * a plan. These codes come from TR260 (auto adj) and are also used
010500220105      * in RP130.
010600220105      *
010700220105       clear pricar;
010800220105       if trcode in %list('MAC':'MDC':'MRC':'MCC':'MCB':'MCA':'MDD':
010900220105                          'MDA':'MDX':'MDR':'MDU':'MCX':'MCE')
011000220105          and ck#pln <> *blanks;
011100220105
011200220105      * is this a principal carrier?
011300220105        chain (hstrst:hssub#:ck#pln) plnmst;
011400220105        if %found(plnmst);
011500220105         chain (pcarr) carmst;
011600220105         if %found(carmst) and cgrpcd = 'PL';
011700220105          pricar = 'Y';
011800220105         endif;
011900220105        endif;
012000220105
012100220105       endif;
012200220105
0123002201050120   endsr;
012400220105
012500201110     Orp130wk   Eadd         rp130add
012600201110     o                       wsrec              216
