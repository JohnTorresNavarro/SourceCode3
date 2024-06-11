000100030313      ***************************************************************
000200030313      *              SALESMAN MASTER FILE LISTING              FL100
000300030313      *
000400030313      *     THIS PROGRAM WILL LIST THE SALESMAN MASTER FILE SHOWING
000500030313      *    ALL SALESMAN SORTED BY NAME. TYPE, BEGIN AND TERMINATION
000600030313      *    DATE, COMPANY CODE, AND TERRITORY ARE ALSO LISTED.
000700030313      *
000800030313      *                BY: DAVID KETTERMAN 8/89
000900981001      *       10/01/98 GSP  The following changes are a result of Y2K update.
001000981001      *                     Chaned SMAN recl from 256 to 272 bytes.
001100030313    ***
001200030313    *** 03.13.2003.SSK.SALESMAN RELATIONSHIP PROJECT - CONVERT TO NATIVE
001300030313    ***                REMOVE AGENCY REFERENCE
001400030313    ***                MAKE CHANGES FOR NEW DDS OF SMAN
001500030313    ***
001600030313      ***************************************************************
001700030313     FSMAN      IPE  E           K DISK                                         FL100
001800030313     FCODES     IF   E           K DISK
001900030313     FQSYSPRT   O    F  132        PRINTER OFLIND(*INOF)                        FL100
002000030313   X***X
002100030313    ***
002200030313     D N               S             34A
002300030313     D AL              S             30A
002400030313     D KEY@TYPE        S                   LIKE(TYPE)
002500030313     D KEY@CODE        S                   LIKE(CODE)
002600030313     D #XSX            S              8S 0                                      MEMBER NAME      FL1
002700030313     D #ISO            S               D   DATFMT(*ISO)
002800030313     D #USA            S               D   DATFMT(*USA)
002900030313     D A@20            S             20A
003000030313     D A@40            S             40A
003100030313     D #AREA           S              3A
003200030313    ***
003300910215     D                UDS
003400910215     D  CONAME               201    240
003500910215     D  TIME                 242    247  0
003600030313    ***
003700030313   X***X
003800030313     C                   EXSR      $GETSMAN
003900030313     C                   MOVEL(P)  A@40          N
004000030313    ***
004100030313     C                   EXSR      $GETADDR
004200030313     C                   MOVEL(P)  A@40          AL
004300030313    ***
004400030313     C* EXCLUDE CANCELLED SALES PEOPLE
004500030313     C                   IF        SENDDT = 0
004600030313      *
004700030313     C                   Z-ADD     SBEGDT        #XSX
004800030313     C                   EXSR      $ISOUSA
004900030313     C                   Z-ADD     #XSX          SBEGDT
005000981001      *
005100030313     C                   MOVE      SENDDT        #XSX
005200030313     C                   EXSR      $ISOUSA
005300030313     C                   MOVE      #XSX          SENDDT
005400030313     C                   EVAL      #AREA = %EDITC(SAREA:'X')
005500981001      *
005600030313     C                   EXSR      $GETCODES
005700030313      *
005800030313     C                   IF        *INOF = *ON
005900030313     C                   EXCEPT    HDGF
006000030313     C                   EVAL      *INOF = *OFF
006100030313     C                   ENDIF
006200030313     C                   EXCEPT    DTLF
006300030313      *
006400030313     C                   ENDIF
006500030313    ***
006600030313   S***S
006700030313     C     *INZSR        BEGSR
006800030313    ***
006900030313     C     KEY@CODES     KLIST
007000030313     C                   KFLD                    KEY@TYPE
007100030313     C                   KFLD                    KEY@CODE
007200030313    ***
007300030313     C                   EXCEPT    HDGF
007400030313    ***
007500030313     C                   ENDSR
007600030313   S***S
007700030313     C     $GETCODES     BEGSR
007800030313    ***
007900030313     C                   MOVE      'F'           KEY@TYPE
008000030313     C                   EVAL      KEY@CODE = %SUBST(STYPE:2:2)
008100030313     C     KEY@CODES     CHAIN(N)  CODESR
008200030313    1C                   IF        NOT %FOUND(CODES)
008300030313     C                   EVAL      LDESCR = 'UNDEFINED'
008400030313    1C                   ENDIF
008500030313    ***
008600030313     C                   ENDSR
008700030313   S***S
008800030313     C     $ISOUSA       BEGSR
008900030313    ***
009000030313     C                   IF        #XSX = 0
009100030313     C                   LEAVESR
009200030313     C                   ENDIF
009300030313    ***
009400030313     C     *ISO          TEST (DE)               #XSX
009500030313     C                   IF        %ERROR
009600030313     C                   LEAVESR
009700030313     C                   ENDIF
009800030313    ***
009900030313     C                   MOVE      #XSX          #ISO
010000030313     C                   MOVE      #ISO          #USA
010100030313     C                   MOVE      #USA          #XSX
010200030313    ***
010300030313     C                   ENDSR
010400030313   S***S
010500030313     C     $GETSMAN      BEGSR
010600030313    ***
010700030313     C                   CLEAR                   A@20
010800030313     C                   CLEAR                   A@40
010900030313    ***
011000030313     C                   IF        SLNAME <> *BLANKS
011100030313     C                   EVAL      A@20 = %TRIM(SLNAME) + ','
011200030313     C                   EXSR      $LDADDR
011300030313     C                   ENDIF
011400030313    ***
011500030313     C                   IF        SFNAME <> *BLANKS
011600030313     C                   MOVEL     SFNAME        A@20
011700030313     C                   EXSR      $LDADDR
011800030313     C                   ENDIF
011900030313    ***
012000030313     C                   IF        SMI <> *BLANKS
012100030313     C                   EVAL      A@20 = %TRIM(SMI) + '.'
012200030313     C                   EXSR      $LDADDR
012300030313     C                   ENDIF
012400030313    ***
012500030313     C                   ENDSR
012600030313   S***S
012700030313     C     $LDADDR       BEGSR
012800030313    ***
012900030313     C                   EVAL      A@20 = %TRIM(A@20)
013000030313     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
013100030313     C                   CLEAR                   A@20
013200030313    ***
013300030313     C                   ENDSR
013400030313   S***S
013500030313     C     $GETADDR      BEGSR
013600030313    ***
013700030313     C                   CLEAR                   A@20
013800030313     C                   CLEAR                   A@40
013900030313    ***
014000030313     C                   IF        SCITY <> *BLANKS
014100030313     C                   EVAL      A@20 = %TRIM(SCITY) + ','
014200030313     C                   EXSR      $LDADDR
014300030313     C                   ENDIF
014400030313    ***
014500030313     C                   IF        SSTATE <> *BLANKS
014600030313     C                   MOVEL     SSTATE        A@20
014700030313     C                   EXSR      $LDADDR
014800030313     C                   ENDIF
014900030313    ***
015000030313     C                   IF        SZIPCD <> 0
015100030313     C                   MOVE      SZIPCD        @9A               9
015200030313     C                   IF        %SUBST(@9A:6:4) <> '0000'
015300030313     C                   EVAL      A@20 = %EDITW(SZIPCD:'     -    ')
015400030313     C                   ELSE
015500030313     C                   EVAL      A@20 = %SUBST(@9A:1:5)
015600030313     C                   ENDIF
015700030313     C                   EXSR      $LDADDR
015800030313     C                   ENDIF
015900030313    ***
016000030313     C                   ENDSR
016100030313   S***S
016200030313   X***X
016300981001     OQSYSPRT   E            HDGF           1  1
016400030313     O                                            6 'FL100'
016500030313     O                                           44 '**'
016600910215     O                       CONAME              84
016700030313     O                                           86 '**'
016800981001     OQSYSPRT   E            HDGF           1
016900030313     O                       UDATE         Y      9
017000981001     OQSYSPRT   E            HDGF           2
017100030313     O                       TIME                 9 '  :  :  '
017200910215     O                                           76 'SALESMAN MASTER FILE LIS'
017300910215     O                                           80 'TING'
017400981001     O                                          125 'PAGE:'
017500981001     O                       PAGE          Z    130
017600981001     OQSYSPRT   E            HDGF        1
017700910215     O                                           24 '------------------------'
017800910215     O                                           48 '------------------------'
017900910215     O                                           72 '------------------------'
018000910215     O                                           96 '------------------------'
018100910215     O                                          120 '------------------------'
018200910215     O                                          132 '------------'
018300981001     OQSYSPRT   E            HDGF        1
018400910215     O                                           21 'SALESMAN'
018500910821     O                                           38 'CODE'
018600910215     O                                           43 'TYPE'
018700910215     O                                           58 'DESCRIPTION'
018800910215     O                                           95 'BEGIN'
018900910215     O                                          106 'TERM.'
019000030313     O                                          131 'GROUPER'
019100981001     OQSYSPRT   E            HDGF        1
019200030313     O                                           94 'DATE'
019300030313     O                                          105 'DATE'
019400030313     O                                          130 'CODE'
019500981001     OQSYSPRT   E            HDGF        1  2
019600030313     O                                           24 '------------------------'
019700030313     O                                           48 '------------------------'
019800030313     O                                           72 '------------------------'
019900030313     O                                           96 '------------------------'
020000030313     O                                          120 '------------------------'
020100030313     O                                          132 '------------'
020200910215     OQSYSPRT   E            DTLF           1
020300910215     O                       N                   34
020400910821     O                       SMANCD              38
020500030313     O                       KEY@CODE            42
020600910215     O                       LDESCR              77
020700030313     O                       SBEGDT        Y     96
020800030313     O                       SENDDT        Y    110
020900030313     O                       SGRP               130
021000910215     OQSYSPRT   E            DTLF           1
021100910215     O                       SADDR               30
021200910215     OQSYSPRT   E            DTLF           1
021300910215     O                       AL                  30
021400910215     OQSYSPRT   E            DTLF           2
021500030313     O                                            1 '('
021600030313     O                       #AREA                4
021700030313     O                                            5 ')'
021800910215     O                       SPHONE              14 '0   -    '
