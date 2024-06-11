000100000000      *_________________________________________________________________________
000200000000      *
000300150227      *  Description:
000400000000      *
000500200505      *  (c)Copyright 2020 by GBS, Inc.
000600000000      *
000700200505      *    Created by:  JALLEN - May  5, 2020
000800000000      *_________________________________________________________________________
000900200505     FACCMST    if   E           K Disk    extfile('F.ACCMST')
001000200505     FAC2MSTL2  if   E           K Disk    extfile('AC2MSTL2')
001100200505     FMEMACC    if   E           K Disk    extfile('F.MEMACC')
001200200505     FPLNMST    if   E           K Disk    extfile('F.PLNMST')
001300200505     FMCOVC15   if   E           K Disk    extfile('F.MCOVC15')
001400200505     FCODESL1   if   E           K Disk    extfile('F.CODESL1')
001500200505     FACC005P   o  a E           K Disk
001600101217
001700110408     D Pos             s              3s 0 inz
001800200505     D Trust           s              3s 0 inz(005)
001900200505     D dnt             s              1a
002000170207
002100200505     C     Trust         Setll     accmst
002200200505     C     Trust         Reade     accmst
002300200505     C                   dow       not %eof(accmst)
002400200505     C                   If        ATRMDT = 0
002500200505     C     acKEY         Chain     ac2mstl2
002600200505     C                   if        %found(ac2mstl2)
002700200505     C                   move      actrst        TRST
002800200505     C                   move      acsub#        SUB
002900200505     C                   move      acacct        ACCT
003000200505     C                   eval      NAME = %trim(ACNAM1)
003100200505     C                   eval      CONT1 = %trim(CONTAC)
003200200505     C                   eval      EMAIL1 = %trim(A2EMAIL1)
003300200505     C                   eval      CONT2 = %trim(ECNTAC)
003400200505     C                   eval      EMAIL2 = %trim(A2EMAIL2)
003500200505     C                   exsr      chkdnt
003600200505     C                   if        dnt = 'Y'
003700200505     C                   write     acc5r
003800200505     C                   clear                   acc5r
003900200505     C                   end
004000200505     C                   end
004100151016     C                   end
004200200505     C     Trust         Reade     Accmst
004300151016     C                   enddo
004400151016
004500151016     C                   return
004600200505      *-------------------------------------------------------------------*
004700200505     C     chkdnt        Begsr
004800200505      *-------------------------------------------------------------------*
004900200505     C                   eval      dnt = *blanks
005000200505     C     ACKEY         Setll     memacc
005100200505     C     ACKEY         Reade     memacc
005200200505     C                   dow       not %eof(memacc)
005300200505     C                   if        termdt = 0
005400200505     C                   exsr      chkmcov
005500200505     C                   if        dnt = 'Y'
005600200505     C                   LeaveSR
005700200505     C                   end
005800200505     C                   end
005900200505     C     ACKEY         Reade     memacc
006000200505     C                   enddo
006100200505     C                   endsr
006200200505      *-------------------------------------------------------------------*
006300200505     C     chkmcov       Begsr
006400200505      *-------------------------------------------------------------------*
006500200505     C     MCKEY         Setll     mcovc15
006600200505     C     MCKEY         Reade     mcovc15
006700200505     C                   dow       not %eof(mcovc15)
006800200505     C     plKEY         Chain     plnmst
006900200505     C                   if        %found(plnmst)
007000200505     C     plncat        Chain     codesl1
007100200505     C                   if        %found(codesl1)
007200200505     C                   if        action = 'D'
007300200505     C                   eval      dnt = 'Y'
007400200505     C                   LeaveSR
007500200505     C                   end
007600200505     C                   end
007700200505     C                   end
007800200505     C     MCKEY         Reade     mcovc15
007900200505     C                   enddo
008000200505     C                   endsr
008100151016      *-------------------------------------------------------------------*
008200151016     C     *inzsr        Begsr
008300151016      *-------------------------------------------------------------------*
008400151016
008500200505     C     ACKEY         Klist
008600200505     C                   Kfld                    actrst
008700200505     C                   Kfld                    acsub#
008800200505     C                   Kfld                    acacct
008900200505
009000200505     C     MCKEY         Klist
009100200505     C                   Kfld                    actrst
009200200505     C                   Kfld                    acsub#
009300200505     C                   Kfld                    acacct
009400200505     C                   Kfld                    mbssno
009500151016
009600200505     C     PLKEY         Klist
009700200505     C                   Kfld                    actrst
009800200505     C                   Kfld                    acsub#
009900200505     C                   Kfld                    mcplan
010000151016     C                   Endsr
