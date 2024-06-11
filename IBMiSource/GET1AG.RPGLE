000100110603     H option(*SRCSTMT: *NODEBUGIO)
0002009908180002 F******************************************************************
0003002204260003 F* GET1AG     Amwins Connect Administrators Software              *
0004009908180004 F*                                                                *
0005009908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006002204260006 F*            DATE - 04/26/22                                     *
0007009908190007 F*                                                                *
0008002204260013 F*  DESCRIPTION - Determine if the account is the agency in       *
0009002204260007 F*                question.                                       *
0010001902130007 F*                                                                *
0011000011070004 F*                parameters to pass:                             *
0012000011070007 F*                -------------------                             *
0013001902010004 F*                1. Trust/sub/acct (10)                          *
0014002204260004 F*                2. Agency (3)                                   *
0015002204260004 F*                2. Return - Result (Y or N)                     *
0016000011070004 F*                                                                *
0017002204260015  *  Call get1agcl that has the file overrides and clean up tasks  *
0018002002040015  *  do not call this program directly.                            *
0019001902010004  *                                                                *
0020002204260035  *  ** This progam is used in RP130AG                             *
0021001902010004  *                                                                *
0022009908180016 F******************************************************************
0023002002040029 Faccmst    if   e           k DISK
002400200204     Fcmct14    if   e           k DISK
002500200204     Fsmanrlt   if   e           k DISK
002600200204     Fspragxr2  if   e           k DISK
002700220426     D agacct          S              1
002800190201     d tsa             ds
0029001307110153 D  t                      1      3  0
0030001307110153 D  s                      4      6  0
0031001902010153 D  a                      7     10  0
003200001107     c     *entry        plist
003300190201     c                   parm                    parmtsa          10
003400220426     c                   parm                    parmag            3
003500220426     c                   parm                    parmyn            1
003600001107
003700190201     c                   move      parmtsa       tsa
003800130712
003900220426     c                   exsr      #chkag
004000220426     c                   move      agacct        parmyn
004100190201
004200190201     c     #end          tag
004300190201   9 C**                 return
004400190201   9 C                   eval      *inlr = *on
004500130712
0046002002040103  ***************************************************
0047002204260104  * check account for this agency
0048002002040105  ***************************************************
0049002204260106   begsr #chkag;
005000200204
005100200204      * if there is an active comission control for a salesman that
005200220426      * matches the accounts BOR sman and the relation uses the agency
005300220426      * in question then the result is Yes
005400200204
005500220426       clear agacct;
005600200204
005700200204       chain (t:s:a) accmst;
005800200204       if not %found(accmst);
005900220426        agacct  = 'N';
006000200204        leavesr;
006100200204       endif;
006200200204
006300200204       setll (t:s:a) cmct14;
0064002002040131   dou %eof(cmct14);
0065002002040132    reade (t:s:a) cmct14;
0066002002040133     if not %eof(cmct14) and cmcan = 0 and smancd = slsman;
0067002002040171      chain (cmrelid) smanrlt;
0068002002040133      if %found(smanrlt);
0069002002040171       chain (srasid) spragxr2;
0070002204260133       if %found(spragxr2) and sxagcy = parmag;
007100220426            agacct  = 'Y';
007200200204            leave;
007300200204           endif;
007400200204          endif;
007500200204         endif;
007600200204       enddo;
007700200204
0078002002040106   endsr;
