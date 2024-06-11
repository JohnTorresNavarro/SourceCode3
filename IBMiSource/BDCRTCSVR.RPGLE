000100220705     FBDELIGP   IPE  E           K DISK
000200220705     FBDCSVP    O  A F 2500        DISK
000300050823   X***X
000400220705     D @OUTPUT         S           2500A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008002108050025  *
0009000811140250 D                 DS
0010002207050251 Dbdbrdtx          S             10
0011002207050251 Dbddohx           S             10
0012002207050251 Dbdwgefx          S             10
0013002207050251 Dbdefdtx          S             10
0014002207050251 Dbdtmdtx          S             10
0015002207050251 Dbdemptx          S             10
0016002207050251 Dbdqedtx          S             10
0017000704030025  *
001800220705             bdbrdtx = *blanks;
001900220705             if bdbrdt <> 0;
002000220705               bdbrdtx = %Char(%date(bdbrdt) :*usa);
002100220705             endif;
0022002207050025  *
002300220705             bdwgefx = *blanks;
002400220705             if bdwgef <> 0;
002500220705               bdwgefx = %Char(%date(bdwgef) :*usa);
002600220705             endif;
0027002207050025  *
002800220705             bdefdtx = *blanks;
002900220705             if bdefdt <> 0;
003000220705               bdefdtx = %Char(%date(bdefdt) :*usa);
003100220705             endif;
0032002207050025  *
003300220705             bdtmdtx = *blanks;
003400220705             if bdtmdt <> 0 and bdtmdt <> 99999999;
003500220705               bdtmdtx = %Char(%date(bdtmdt) :*usa);
003600220705             endif;
0037002207050025  *
003800220705             bdemptx = *blanks;
003900220705             if bdempt <> 0;
004000220705               bdemptx = %Char(%date(bdempt) :*usa);
004100220705             endif;
0042002207050025  *
004300220705             bdqedtx = *blanks;
004400220705             if bdqedt <> 0;
004500220705               bdqedtx = %Char(%date(bdqedt) :*usa);
004600220705             endif;
0047002207050025  *
004800220705             bddohx = *blanks;
004900220705             if bddoh <> 0;
005000220705               bddohx = %Char(%date(bddoh) :*usa);
005100220705             endif;
005200080313      *
005300081114      *
005400080313     C                   CLEAR                   @OUTPUT
005500220705     C                   EVAL      @OUTPUT = %TRIM(bdgrp#) + ',,' +
005600220705     C                             %TRIM(bdessn) + ',' +
005700220705     C                             %TRIM(bdissn) + ',' +
005800220705     C                             %TRIM(bdrel) + ',' +
005900220705     C                             %TRIM(bdfnme) + ',' +
006000220705     C                             %TRIM(bdmi) + ',' +
006100220705     C                             %TRIM(bdlnme) + ',,,' +
006200220705     C                             %TRIM(bdgndr) + ',' +
006300220705     C                             %TRIM(bdbrdtx) + ',' +
006400220705     C                             %TRIM(bdemal) + ',' +
006500220705     C                             %TRIM(bdhphn) + ',,' +
006600220705     C                             %TRIM(bdadr1) + ',' +
006700220705     C                             %TRIM(bdadr2) + ',' +
006800220705     C                             %TRIM(bdcity) + ',' +
006900220705     C                             %TRIM(bdst) + ',' +
007000220705     C                             %TRIM(%Char(bdzip)) + ',' +
007100220705     C                             %TRIM(bdstud) + ',' +
007200220705     C                             %TRIM(bdhand) + ',' +
007300220705     C                             %TRIM(bdsmok) + ',' +
007400220705     C                             %TRIM(bdtitl) + ',' +
007500220706     C                             %TRIM(bddohx) + ',,,,,' +
007600220705     C                             %TRIM(bdcovt) + ',' +
007700220705     C                             %TRIM(bdpoln) + ',' +
007800220705     C                             %TRIM(bdefdtx) + ',' +
007900220705     C                             %TRIM(bdtmdtx) + ',,,,,' +
008000220707     C                             %TRIM(bdemptx) + ',,,'
008100220707     C*****                        %TRIM('X')
008200201006    * *
008300060315     C                   EXCEPT    OUTFA
008400201006   S* *
008500201006     C     *INZSR        BEGSR
008600201006    * *
008700220614     C                   EVAL      @OUTPUT = 'Group Number,' +
008800220705     C                             'Billing Group,' +
008900220705     C                             'Employee SSN,' +
009000220614     C                             'Member SSN,' +
009100230302     C                             'Member Role,' +
009200230302     C                             'Member First Name,' +
009300230302     C                             'Member Middle Initial,' +
009400230302     C                             'Member Last Name,' +
009500230302     C                             'Name Prefix,' +
009600230302     C                             'Name Suffix,' +
009700230302     C                             'Member Gender,' +
009800230302     C                             'Member Date of Birth,' +
009900230302     C                             'Subscriber Email,' +
010000230302     C                             'Subscriber Home Phone,' +
010100230302     C                             'Subscriber Cell Phone,' +
010200220614     C                             'Address 1,' +
010300220614     C                             'Address 2,' +
010400220614     C                             'City,' +
010500220614     C                             'State,' +
010600220614     C                             'Zip,' +
010700220614     C                             'Student Status,' +
010800220614     C                             'Handicap Status,' +
010900220614     C                             'Tobacco Use,' +
011000220614     C                             'Subscriber Job Title,' +
011100220614     C                             'Subscriber Date Of Hire,' +
011200220614     C                             'Wage,' +
011300220614     C                             'Wage Frequency,' +
011400220706     C                             'Wage Hours,' +
011500220614     C                             'Wage Effective Date,' +
011600220614     C                             'Coverage Type,' +
011700220614     C                             'Policy Name,' +
011800220614     C                             'Policy Start Date,' +
011900220614     C                             'Policy End Date,' +
012000220614     C                             'Coinsurance Rollover,' +
012100220706     C                             'Deductible Rollover,' +
012200220614     C                             'Requested Coverage Amount,' +
012300220706     C                             'Approved Coverage Amount,' +
012400220705     C                             'Certificate Termination Date,' +
012500220614     C                             'Reason,' +
012600220614     C                             'Event Date,' +
012700220614     C                             'Brush Color'
012800201006    * *
012900201006     C                   EXCEPT    OUTFA
013000201006    * *
013100201006     C                   ENDSR
013200201006    * *
013300201006     C
013400060315    ***
013500220705     OBDCSVP    EADD         OUTFA
013600220705     O                       @OUTPUT           2500
