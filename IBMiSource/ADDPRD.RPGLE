000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Add PAYDED records for new coverage types
000500000000      *
000600000000      *  (c)Copyright 2011 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - April 28, 2011
000900000000      *_________________________________________________________________________
000902110428     FPAYDED    IF A E           K Disk
000903110428
001000110428     C     *entry        plist
001100110428     C                   parm                    TRS               3
001200110428     C                   parm                    SUB               3
001300110428     C                   parm                    PLN               4
001400110428     C                   parm                    FRM               3
001500110428     C                   parm                    TOO               3
001501110428
001502110428     C     PAYKEY        Klist
001503110428     C                   Kfld                    PDTRST
001504110428     C                   Kfld                    PDSUB#
001505110428     C                   Kfld                    PDPLAN
001506110428
001507110428     C                   Move      TRS           PDTRST
001508110428     C                   Move      SUB           PDSUB#
001509110428     C                   Move      PLN           PDPLAN
001510110428
001511110428     C     PAYKEY        Setll     PAYDED
001512110428     C     PAYKEY        Reade     PAYDED
001513110428     C                   Dow       not %eof(PAYDED)
001514110428     C                   If        %trim(PDCVTP) = %trim(FRM)
001515110428     C                   Eval      PDCVTP = TOO
001516110428     C                   Write     PAYDEDR
001517110428     C                   End
001518110428     C     PAYKEY        Reade     PAYDED
001519110428     C                   Enddo
001520110428
001521110428     C                   Eval      *inlr = *on
001600110428     C                   Return
