000100110603     H option(*SRCSTMT: *NODEBUGIO)
0002009908180002 F******************************************************************
0003002002040003 F* GETEBS     GROUP BENEFIT SERVICES SOFTWARE                     *
0004009908180004 F*                                                                *
0005009908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006002002040006 F*            DATE - 02/04/20                                     *
0007009908190007 F*                                                                *
0008002002040013 F*  DESCRIPTION - Determine if the account is an EBS account for  *
0009002002040007 F*                purposes of separating EBS members for COBRA    *
0010002002040007 F*                letters and reports.                            *
0011001902130007 F*                                                                *
0012000011070004 F*                parameters to pass:                             *
0013000011070007 F*                -------------------                             *
0014001902010004 F*                1. Trust/sub/acct (10)                          *
0015002002040004 F*                2. Return - This is an EBS account (Y or N)     *
0016000011070004 F*                                                                *
0017002002040015  *  Call getebscl that has the file overrides and clean up tasks  *
0018002002040015  *  do not call this program directly.                            *
0019001902010004  *                                                                *
0020002205120035  *  ** This progam is used in COB210, COB220, RP430, TR172.       *
0021002205120004  *                                                                *
0022001902010004  *                                                                *
0023009908180016 F******************************************************************
0024002002040029 Faccmst    if   e           k DISK
002500200204     Fcmct14    if   e           k DISK
002600200204     Fsmanrlt   if   e           k DISK
002700200204     Fspragxr2  if   e           k DISK
002800200204     D ebsacct         S              1
002900190201     d tsa             ds
0030001307110153 D  t                      1      3  0
0031001307110153 D  s                      4      6  0
0032001902010153 D  a                      7     10  0
003300001107     c     *entry        plist
003400190201     c                   parm                    parmtsa          10
003500200204     c                   parm                    parmyn            1
003600001107
003700190201     c                   move      parmtsa       tsa
003800130712
003900200204     c                   exsr      #chkebs
004000200204     c                   move      ebsacct       parmyn
004100190201
004200190201     c     #end          tag
004300190201   9 C**                 return
004400190201   9 C                   eval      *inlr = *on
004500130712
0046002002040103  ***************************************************
0047002002040104  * check for EBS account.
0048002002040105  ***************************************************
0049002002040106   begsr #chkebs;
005000200204
005100200204      * if there is an active comission control for a salesman that
005200200204      * matches the accounts BOR sman and the relation uses agency
005300200204      * I29 then it is an EBS account
005400200204
005500200204       clear ebsacct;
005600200204
005700200204       chain (t:s:a) accmst;
005800200204       if not %found(accmst);
005900200204        ebsacct = 'N';
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
0070002002040133       if %found(spragxr2) and sxagcy = 'I29';
007100200204            ebsacct = 'Y';
007200200204            leave;
007300200204           endif;
007400200204          endif;
007500200204         endif;
007600200204       enddo;
007700200204
0078002002040106   endsr;
