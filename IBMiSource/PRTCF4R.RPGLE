000100000000      *_________________________________________________________________________
000200000000      *
000300130626      *  Description:  Print Verifier Performance Summary Report
000400000000      *
000500130626      *  (c)Copyright 2013 by GBS, Inc.
000600000000      *
000700130626      *    Created by:  JALLEN - Jun 26, 2013
000800000000      *_________________________________________________________________________
000900130626     FTRNSUMPL5 IP   E           K DISK
001000130626     FPRTCF4P   O    E             PRINTER oflind(*in91)
001100081203      *
001200130628     D WPOTH           S              5S 0
001300130628     D WiFrom          S              8S 0
001400130628     D WiTo            S              8S 0
001500130626      *
001600081203     ITRNSUMR       01
001700130626     I                                          SMRVWR        L3
001800081203      *
001900130626    ?C   L3              eval      WPHOLD = 0
002000130626    ?C   L3              eval      WPRELS = 0
002100130626    ?C   L3              eval      WPDNS  = 0
002200130626    ?C   L3              eval      WPOTH  = 0
002300130626    ?C   L3              eval      WPTOTL = 0
002400130626      *
002500081203      *
002600130626    ?C   01              If        %trim(SMRVWR) <> *blanks
002700130626    ?C                   Select
002800130626     C                   When      %trim(SMFLAG) = 'H'
002900130626    ?C                   eval      WPHOLD = WPHOLD + 1
003000130626    ?C                   eval      WTHOLD = WTHOLD + 1
003100130626     C                   When      %trim(SMFLAG) = 'R'
003200130626    ?C                   eval      WPRELS = WPRELS + 1
003300130626    ?C                   eval      WTRELS = WTRELS + 1
003400130626     C                   When      %trim(SMFLAG) = 'D'
003500130626    ?C                   eval      WPDNS  = WPDNS  + 1
003600130626    ?C                   eval      WTDNS  = WTDNS  + 1
003700130626     C                   Other
003800130626    ?C                   eval      WPOTH  = WPOTH  + 1
003900130626     C                   Endsl
004000130626    ?C                   eval      WPTOTL = WPTOTL + 1
004100130626    ?C                   eval      WTTOTL = WTTOTL + 1
004200130626     C                   End
004300130626
004400130627     CL3                 If        SMRVWR <> *BLANKS
004500130627     CL3                 CALL      'RTVAALCL'
004600130627     CL3                 PARM                    SMRVWR
004700130627     CL3                 PARM                    SMTEXT           50
004800130627     CL3                 If        SMTEXT = *BLANKS
004900130627     CL3                 Eval      SMTEXT = %trim(SMRVWR)
005000130627     CL3                 End
005100130627 001?CL3                 Write     PRTSEP
005200130626    ?CL3                 Write     PRTDTL
005300130626    ?CL3                 End
005400081203      *
005500081203     CLR                 Exsr      TOTALS
005600081203    ? *___________________________________________________________________
005700081203      * Totals
005800081203    ? *___________________________________________________________________
005900081203     C     TOTALS        Begsr
006000081203      *
006100081203     C                   Write     PRTTOT
006200081203      *
006300081203     C                   Endsr
006400030422      *___________________________________________________________________
006500030422      * Program initialization
006600030422      *___________________________________________________________________
006700030422     C     *INZSR        BEGSR
006800130628      *
006900130628     C     *Entry        Plist
007000130628     C                   Parm                    wiFrom
007100130628     C                   Parm                    wiTo
007200130628      *
007300130628     C     WiFrom        Mult      10000.0001    WPFROM
007400130628     C     WiTo          Mult      10000.0001    WPTO
007500030422      *
007600130626     C                   Eval      WQPGMN =      'PRTCF4R'
007700130627 001?C                   Time                    WPTIM
007800130627 001?C                   Write     PRTHDR
007900130627 001?C                   Move      *Off          *In91
008000030422      *
008100030422    ?C                   Endsr
