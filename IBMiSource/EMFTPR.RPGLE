000100000000      *_________________________________________________________________________
000200000000      *
000300020306      *  Description:  FTP AS/400 export
000400000000      *
000500010906      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *_________________________________________________________________________
000800010907     FHEXPFTPIP O  A E             DISK
000900011005     D @CMD            S             40A   DIM(4) CTDATA
001000010906     D FILE            S             10
001100010906     D INDEX           S              2  0
001200010323      *
001300010907     C     *ENTRY        PLIST
001400010907     C                   PARM                    FILE
001500001107
001600010927      * Build FTP statements.
001700020306     C                   DO        4             INDEX
001800010907     C                   EVAL      INPUT80 = *BLANKS
001900010927     C                   MOVEL(P)  @CMD(INDEX)   INPUT80
002000020306     C                   IF        INDEX = 2
002100010927     C                   CAT       FILE:0        INPUT80
002200010927     C                   END
002300010907     C                   WRITE     INP80
002400001107     C                   ENDDO
002500001107      *
002600010927     C                   EVAL      *INLR = *ON
002700010927** CTDATA @CMD
002800020311statel 3line66state
002900020311put QS36F/EMEXPP
003000001107close
003100001107quit
