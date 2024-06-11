0001001109230005  * 09/22/11 - David Ketterman
0001011109230005  *
0001021109220005  * create file with 1 senior dental member per acct for x4 to use
0001071109230005  * to include the ssn on the cumulative remittance. This program
0001081109230005  * only includes members that have ever been in F.INVDET.
0001091109230005  *
0001101109220005 Fqdsd01j   ip   e           k disk
0001111109220005 Fsdacc     o  a e             disk
000112110922     iinvdr
000113110922     i                                          idtrst        l1
000114110922     i                                          idsubd        l1
000115110922     i                                          idacct        l1
000116110922      * the join file is already ordered by t/s/a/effdt so the latest
000117110922      * effective date record will be at the end resulting in the
000118110922      * ssn being used with the latest activity.
000120110922     cl1                 exsr      #l1
000121110922
000122110922      * create workfile record
000123110922     c     #l1           begsr
000124110922     c                   move      IDTRST        SDATRUST
000125110922     c                   move      IDSUBD        SDASUB
000126110922     c                   move      IDACCT        SDAACCT
000127110922     c                   move      IDSS#         SDASSN
000128110922     c                   write     sdaccr
000200110922     c                   endsr
