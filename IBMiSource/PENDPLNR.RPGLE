000100141209     Hoption(*nodebugio)
000200141209     F*------------------------------------------------------------------
000300150210    ? * Find any MAC transactions for today or yesterday
000400150210    ? *   for plans with group ID = PENDING
000500141209     F*------------------------------------------------------------------
000600141209    ?F*  Modifications:
000700150210     F*   12/09/2014 SBT Program written
000800150210     F*   02/10/2015 SBT Mods... now input is HIST record; need to get plan
000900150226     F*   02/26/2015 SBT Mods requested by Shelly
001000150226     F*------------------------------------------------------------------
001100150209     Fpendplnin IP   E             DISK
001200150210     Fmember    IF   E           K DISK    extfile('F.MEMBER')
001300150210     Fplnauxp   IF   E           K DISK
001400150226     Faccmst    IF   E           K DISK    extfile('F.ACCMST')
001500150226     Fplnmst    IF   E           K DISK    extfile('F.PLNMST')
001600150226     Fcarmst    IF   E           K DISK    extfile('F.CARMST')
001700150209     FpendplnoutO  a E             DISK
001800131031     D*------------------------------------------------------------------
001900150210     D ssn             s              9
002000150210     D ssn#            s              9  0
002100150210     D plan#           s              4
002200150409     D @trdate         s              8
002300150409     D @cvdate         s              8
002400141209     C*------------------------------------------------------------------
002500150210     C     PlanKey       klist
002600150210     C                   kfld                    mbtrst
002700150210     C                   kfld                    mbsub#
002800150210     C                   kfld                    plan#
002900150226     C*
003000150226     C     AcctKey       klist
003100150226     C                   kfld                    mbtrst
003200150226     C                   kfld                    mbsub#
003300150226     C                   kfld                    mbacct
003400141210     C*------------------------------------------------------------------
003500150210     C                   eval      ssn = %subst(hkey:2:9)
003600150210     C                   move      ssn           ssn#
003700150210     C                   eval      plan# = %subst(ck#not:1:4)
003800150409     C*
003900150409     C* Format fields for output
004000150409     C                   eval      ssndash = %subst(ssn:1:3) + '-' +
004100150409     C                               %subst(ssn:4:2) + '-' + %subst(ssn:6:4)
004200150409     C                   move      trdate        @trdate
004300150410     C                   eval      trandate = %subst(@trdate:1:4) + '/' +
004400150410     C                               %subst(@trdate:5:2) + '/' +
004500150410     C                               %subst(@trdate:7:2)
004600150409     C                   move      covtdt        @cvdate
004700150410     C                   eval      covdate = %subst(@cvdate:1:4) + '/' +
004800150410     C                               %subst(@cvdate:5:2) + '/' +
004900150410     C                               %subst(@cvdate:7:2)
005000150410     C*
005100150210     C     ssn#          chain     member
005200150210     C                   if        %found(member)
005300150210     C     PlanKey       chain     plnauxp
005400150210     C                   if        %found(plnauxp) and pxgroup = 'PENDING'
005500150226     C     PlanKey       chain     plnmst
005600150226     C                   if        %found(plnmst)
005700150226     C     AcctKey       chain     accmst
005800150226     C                   if        %found(accmst)
005900150226     C     pcarr         chain     carmst
006000150226     C                   if        %found(carmst)
006100150209     C                   write     pendoutr
006200150210     C                   endif
006300150226     C                   endif
006400150226     C                   endif
006500150226     C                   endif
006600150210     C                   endif
006700141209     C*------------------------------------------------------------------
