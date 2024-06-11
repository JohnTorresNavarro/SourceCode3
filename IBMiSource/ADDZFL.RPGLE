000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Add PAYDED records for new coverage types
000400000000      *
000500000000      *  (c)Copyright 2011 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - April 28, 2011
000800000000      *_________________________________________________________________________
000900130808     FACCMST5   IF   E           K Disk
001000130808     FACCOSP    IF   E           K Disk
001100130808     FOEUSER    IF A E           K Disk
001200130808
001300130808     D WZFL            S              3
001400130808     D W80date         S              8S 0
001500110428
001600130808     C                   Eval      WZFL = 'ZFL'
001700130808     C     *date         Mult      10000.0001    W80date
001800110428
001900130808     C     WZFL          Setll     ACCMST5
002000130808     C     WZFL          Reade     ACCMST5
002100130808     C                   Dow       not %eof(ACCMST5)
002200130808     C                   Exsr      SROSP
002300130808     C     WZFL          Reade     ACCMST5
002400110428     C                   Enddo
002500130808
002600130808     C                   Eval      *inlr = *on
002700130808     C                   Return
002800130808
002900130808     C     SROSP         Begsr
003000130808
003100130808     C     WOSP          Klist
003200130808     C                   Kfld                    ACTRST
003300130808     C                   Kfld                    ACSUB#
003400130808     C                   Kfld                    ACACCT
003500130808
003600130808     C     WOSP          Setll     ACCOSP
003700130808     C     WOSP          Reade     ACCOSP
003800130808     C                   Dow       not %eof(ACCOSP)
003900130808     C                   If        AOENDT = 0
004000130808     C                   Exsr      SRUSR
004100130808     C                   End
004200130808     C     WOSP          Reade     ACCOSP
004300130808     C                   Enddo
004400130808
004500130808     C                   Endsr
004600130808
004700130808     C     SRUSR         Begsr
004800130808
004900130808     C     WUSR          Klist
005000130808     C                   Kfld                    ACTRST
005100130808     C                   Kfld                    ACSUB#
005200130808     C                   Kfld                    ACACCT
005300130808     C                   Kfld                    OUUSER
005400130808
005500130808     C                   Eval      OUUSER = 'twayman'
005600130808
005700130808     C     WUSR          Chain     OEUSER
005800130808     C                   If        not %found(OEUSER)
005900130808     C                   Eval      OUTRST = ACTRST
006000130808     C                   Eval      OUSUB# = ACSUB#
006100130808     C                   Eval      OUACCT = ACACCT
006200130808     C                   Eval      OUUSER = 'twayman'
006300130808     C                   Eval      OUEMAL = 'twayman@fnlinc.com'
006400130808     C                   Eval      OUESNT = w80date
006500130808     C                   Eval      OULNAM = 'Wayman'
006600130808     C                   Eval      OUFNAM = 'Terry'
006700130808     C                   Eval      OUBEDT = w80date
006800130808     C                   Eval      OUEMEX = 'A'
006900130808     C                   Eval      OUENDT = *zeros
007000130808     C                   Eval      OUADDT = w80date
007100130808     C                   Eval      OUADGU = 'ADDZFL'
007200130808     C                   Eval      OUCHDT = *zeros
007300130808     C                   Eval      OUCHGU = *blanks
007400130808     C                   Eval      OUUSPW = 'fnlinc'
007500130808
007600130808     C                   Write     OEUSERR
007700130808     C                   End
007800130808
007900130808     C                   Endsr
