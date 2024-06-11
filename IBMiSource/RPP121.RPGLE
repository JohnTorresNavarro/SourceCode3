000002060309      * 03/08/06 dlk - create sman labels for renewals from RPP120WK
000003060309      *                work file
000004060308      *                               -------------------------
000500060308      *                               | SMAN NAME             |
000501060308      *                               | AGENCY NAME           |
000600060308      *                               | SMAN ADDRESS          |
000700060308      *                               | SMAN CITY ST ZIP      |
000800060308      *                               -------------------------
000900060308     Frpp120wk  IP   E             DISK
001000060308     Freport    O    F  132        PRINTER
001100910215     F                                     FORMLEN(6)
001200030313     F                                     FORMOFL(2)
002000910215     D                UDS
002300060308     D  ldate                  1      8  0
002301060308     D  luser                  9     18
002302060308     irpp120r
002303060308     i                                          rppsmnam      l2
002305060308     i                                          rppagnam      l1
005000060308    *
005001060308     c                   if        *inl1
005002060308     c                   except    label
005003060308     c                   end
005100060308   S*
005200030313     C     *INZSR        BEGSR
005700030313     C                   EXCEPT    HEADER
005900030313     C                   ENDSR
006000060308   S*
015800910215     OREPORT    E            HEADER         1 01
016000060308     O                                           24 '************************'
016100060308     O                                           30 '******'
016200910215     O          E            HEADER         1
016300060308     O                                            1 '*'
016400060308     O                                           27 ' RENEWAL LABELS - RPP121'
016500060308     O                                           30 '**'
016600910215     O          E            HEADER         1
016700060308     O                                            1 '*'
016800060308     O                       luser               12
016801060308     O                                           17 'Eff-'
017000060308     O                       ldate               27 '  /  /    '
017001060308     O                                           30 '*'
017600910215     O          E            HEADER         1
017700060308     O                                           24 '************************'
017800060308     O                                           30 '******'
017900910215     OREPORT    E            LABEL          1 01
018000060308     O                       rppsmnam            33
018100910215     O          E            LABEL          1
018200060308     O                       rppagnam            33
018300910215     O          E            LABEL          1
018400060308     O                       rppsmadr            30
018500060308     O          E            LABEL          1
018600060308     O                       rppsmcsz            33
