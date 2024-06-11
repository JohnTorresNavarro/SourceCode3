000100990909      ******************************************************************
000200990909      * COB200     GROUP BENEFIT SERVICES SOFTWARE           1999      *
000300990909      *                                                                *
000400990909      *            WRITTEN BY - KIMBERLY S. JOHNSON                    *
000500990909      *            DATE - 08/02/99                                     *
000600990909      *                                                                *
000700990909      *  DESCRIPTION - THIS PROGRAM WILL LIST COBRA MEMBERS            *
000800990909      *                NOT INVOICED.                                   *
000900990909      ******************************************************************
001000990909
001100990804     FMEMACC    IF   E           K DISK
001300990803     FCOB200P   O    E             PRINTER OFLIND(*IN80)
001301990909
001302990909      * LDA
001500990803     D                UDS
001600990803     D  LY                     1      4  0
001700990803     D  LMD                    5      8  0
001800990803     D  LTRUST               100    102
001900990803     D  CONAME               201    240
002000990803     D  TIME                 242    247  0
002001990909
002300990803     C                   READ      MEMBR                                  99
002500990803     C     *IN99         DOWEQ     *OFF
002600990803     C     *IN80         IFEQ      *ON
002700990803     C                   WRITE     HEADER
002800990803     C                   MOVE      *OFF          *IN80
002900990803     C                   ENDIF
003000990803     C                   WRITE     DETAIL
003100990806     C                   ADD       1             TOTREC
003200990803     C                   CLEAR                   DETAIL
003300990803     C                   READ      MEMBR                                  99
003400990803     C                   ENDDO
003500990806     C                   WRITE     TOTAL
003600990803     C                   MOVE      *ON           *INLR
003700990806      ****************************************
003800990806      *        INITIALIZATION SUBROUTINE     *
003900990806      ****************************************
004000990806     C     *INZSR        BEGSR
004100990806     C                   WRITE     HEADER
004200990806     C                   CLEAR                   TOTREC
004300990806     C                   ENDSR
