000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  List the members with the old medicare #
000400000000      *
000500000000      *  (c)Copyright 2020 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - February 20, 2020
000800000000      *_________________________________________________________________________
000900200221    ?FMEMBER    If   E           k Disk    extfile('F.MEMBER')
001000200221    ?FACCMST    If   E           k Disk    extfile('F.ACCMST') prefix(x)
001100200221    ?FAACODE    If   E           k Disk
001200200220    ?FMED#P     o  a e           k Disk
001300200220
001400200220     D med1            S              9A
001500200220     D med2            S              9A
001600200220
001700000000      * Program status data structure
001800000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001900000000      *
002000200220
002100200220     C                   clear                   mbssno
002200200220     C     mbssno        setll     member
002300200220     C                   read      member
002400200220     C                   dow       not %eof(member)
002500200220     C                   if        termdt = 0
002600200220     C                   exsr      chkmed#
002700200220     C                   end
002800200220     C                   read      member
002900200220     C                   enddo
003000200220
003100200220     C                   return
003200000000      *___________________________________________________________________
003300200220     C     chkmed#       BEGSR
003400200220     C                   if        %trim(med#) <> *blanks
003500200220     C                   eval      med1 = %editc(mbssno:'X')
003600200220     C                   eval      med2 = %trim(%subst(med#:1:9))
003700200220     C                   if        %trim(med1) = %trim(med2)
003800200221     C     akey          chain     ACCMST
003900200221     C     xaacode       chain     aacode
004000200221     C                   eval      aaname = %trim(AFNAM) + ' ' + %trim(ALNAM)
004100200220     C                   write     med#r
004200200220     C                   end
004300200220     C                   end
004400000000     C                   ENDSR
004500000000      *___________________________________________________________________
004600000000      * Program open
004700000000      *___________________________________________________________________
004800000000     C     *INZSR        BEGSR
004900200221     C     akey          klist
005000200221     C                   kfld                    MBTRST
005100200221     C                   kfld                    MBSUB#
005200200221     C                   kfld                    MBACCT
005300000000     C                   ENDSR
005400000000      *___________________________________________________________________
005500000000      * Program error handler
005600000000      *___________________________________________________________________
005700000000     C     *PSSR         BEGSR
005800000000     C                   CALL      'SNDRPGM'                            50
005900000000     C                   PARM                    WQPGMN
006000000000     C                   PARM                    WQSTSC
006100000000     C                   PARM                    WQRPGS
006200000000     C                   PARM                    WQMSG
006300000000     C                   ENDSR     '*CANCL'
