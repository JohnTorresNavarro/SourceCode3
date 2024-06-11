000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check Menu Option Security
000400000000      *
000500000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - March 07, 2002
000800000000      *_________________________________________________________________________
000900020325     FPWVHDR    IF   E           K DISK
001000020307     FPWVDTL    IF   E           K DISK
001100020307     D WDOPTN          S                   LIKE(PDOPTN)
001200000000      * Program status data structure
001300000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001400020307      *
001500020307     C     *ENTRY        PLIST
001600020307     C                   PARM                    WIMENU           10
001700020307     C                   PARM                    WIOPTION          2
001800020307     C                   PARM                    WOPASS            1
001900020325      *
002000020325      * Skip Security Officers - Department = blank.
002100020325     C     WQUSRN        CHAIN     PWVHDR
002200020325     C                   IF        %FOUND      and
002300020325     C                             PHDEPT  =  *BLANKS
002400020325     C                   EVAL      *INLR    =     *On
002500020325     C                   RETURN
002600020325     C                   END
002700020307      *
002800020307      * Transalte to numeric
002900020307     C     ' ':'0'       XLATE     WIOPTION      WIOPTION
003000020307     C                   MOVE      WIOPTION      WDOPTN
003100020307      *
003200020307      * Validate User/Menu Option
003300020307     C     WKPASS        SETLL     PWVDTL
003400020307     C                   IF        NOT %EQUAL
003500020307     C                   EVAL      WOPASS   =    'N'
003600020307     C                   END
003700020307      *
003800020325     C                   EVAL      *INLR    =     *On
003900020307      *-----------------------------------------------------------------*
004000020307      * Program Key List
004100020307      *-----------------------------------------------------------------*
004200020307     C     KLIST         BEGSR
004300020307     C     WKPASS        KLIST
004400020307     C                   KFLD                    WQUSRN
004500020307     C                   KFLD                    WIMENU
004600020307     C                   KFLD                    WDOPTN
004700020307     C                   ENDSR
