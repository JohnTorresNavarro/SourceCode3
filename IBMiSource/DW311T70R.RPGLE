000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Create DT records for TR050 MT records
000400000000      *
000500000000      *  (c)Copyright 2009 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - December 02, 2009
000800000000      *_________________________________________________________________________
000900091202     FDW310JF   IP   E           K DISK    Infds(DBFD)
001000091202     FTRNMIT    O  A E             DISK    Rename(TRNMIR:TRNOUT)
001100091202     FDEPNDC    IF   E           K DISK
001200091202     FDCOVC     IF   E           K DISK
001300091202
001400000000      * Program status data structure
001500091202     D DBFD          E DS                  EXTNAME(IODBFD)
001600000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001700091202
001800091202      *
001900091202     IJOINR         01
002000091202
002100091202      *
002200091202     C   01              EXSR      PROCESS
002300091202      *___________________________________________________________________
002400091202     C     PROCESS       BEGSR
002500091202      *___________________________________________________________________
002600091202      * Driver: If TR050 and "MT" then we need the "DT" records for
002700091202      *         dependents that had coverage cancelled as well.
002800091202      *
002900091202     C     SOCSOC        SETLL     DEPNDC
003000091202     C     SOCSOC        READE     DEPNDC
003100091202     C                   DOW       not %eof(DEPNDC)
003200091202      *
003300091203     C     KEYDEP        SETGT     DCOVC
003400091203     C     KEYDEP        READPE    DCOVC
003500091202     C                   DOW       not %eof(DCOVC)
003600091202     C                   IF        CANCDT = CCANDT
003700091202     C     KEYDEPD       CHAIN     DEPNDC
003800091202     C                   Eval      ACTCOD = 'DT'
003900091202     C                   Move      DPSEQ#        DEPSEQ
004000091202     C                   Eval      DENRLD = DENRDT
004100091202     C                   Eval      DCANDT = CCANDT
004200091202     C                   Eval      DPLAN# = DVPLAN
004300091217     C                   Eval      QQPGNM = 'DW311T70R'
004400091217     C                   Eval      TRNSRC = '1T70R'
004500091202     C                   Write     TRNOUT
004600091203     C                   Leave
004700091202     C                   END
004800091203     C     KEYDEP        READPE    DCOVC
004900091202     C                   ENDDO
005000091202      *
005100091202     C     SOCSOC        READE     DEPNDC
005200091202     C                   ENDDO
005300091202      *
005400091202     C                   ENDSR
005500000000      *___________________________________________________________________
005600000000      * Key Lists
005700000000      *___________________________________________________________________
005800000000     C     KLIST         BEGSR
005900091202     C     KEYDEP        KLIST
006000091202     C                   KFLD                    DSSNO
006100091202     C                   KFLD                    DPSEQ#
006200091202     C                   KFLD                    TRUST
006300091202     C                   KFLD                    SUBNO
006400091202     C                   KFLD                    PLAN#
006500091202     C     KEYDEPD       KLIST
006600091202     C                   KFLD                    DSSNO
006700091202     C                   KFLD                    DPSEQ#
006800000000     C                   ENDSR
006900000000      *___________________________________________________________________
007000000000      * Program open
007100000000      *___________________________________________________________________
007200000000     C     *INZSR        BEGSR
007300000000     C                   ENDSR
