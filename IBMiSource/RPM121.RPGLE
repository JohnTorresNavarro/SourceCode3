000100970916     F*---------------------------------------------------------------*
000200970916     F** YTD BROKER ACTIVITY SUMMARY FILE BUILD.  9/97 MARY L. FONTI
000300981209     F* DLW 12.98 RECOMPILE FOR Y2K PROJECT
000400970916     F*---------------------------------------------------------------*
000500970909     FRPM120WK  IP   E             DISK
000600970909     FRPM121WK  O  A E             DISK
000700970909     F*
000800970909     IRP120R
000900970909     I                                          RPDATE        L1
001000970909     I*
001100970909     C     *INL1         IFEQ      *ON
001200970909     C     *IN49         IFEQ      *OFF
001300970909     C                   MOVE      '1'           *IN49
001400970909     C                   Z-ADD     0             L1PREM
001500970909     C                   END
001600970909     C                   END
001700970909     C*
001800970909     C                   ADD       RPPREM        L1PREM            9 2
001900970909     C*
002000970909     CL1                 MOVE      RPMAN         SPMAN
002100970909     CL1                 MOVE      RPNAME        SPNAME
002200970909     CL1                 MOVE      RPTYPE        SPTYPE
002300970909     CL1                 MOVE      RPDATE        SPDATE
002400970909     CL1                 MOVE      L1PREM        SPPREM
002500970909     C*
002600970909     CL1                 WRITE     RP121R
002700970909     C*
002800970909     CL1                 CLEAR                   SPMAN
002900970909     CL1                 CLEAR                   SPNAME
003000970909     CL1                 CLEAR                   SPTYPE
003100970909     CL1                 CLEAR                   SPDATE
003200970909     CL1                 CLEAR                   SPPREM
003300970909     CL1                 CLEAR                   L1PREM
