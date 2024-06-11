0001009908180002 F******************************************************************
0002002110220003 F* rpf081     Amwins Connect Administrator Software               *
0003009908180004 F*                                                                *
0004009908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005002110130006 F*            DATE - 10/13/21                                     *
0006009908190007 F*                                                                *
0007002110130013 F*  DESCRIPTION - select accounts for collection letters          *
0008009908180004 F*                                                                *
0009009908180016 F******************************************************************
0010002110130018 Frpf081d   cf   E             workstn
0011009908120034 FACCMST    IF   E           K DISK
0012002110140034 Frpf081wk  o    E             DISK
0013002110130129 D  wkname         s                   like(sname1)
0014002110130129 D  wkbal          s                   like(sbal1)
0015002110140129 D  wkcd           s                   like(scd1)
0016002110130055 D                 DS
0017002110130129 D  BAL                  361    420P 2
001800211013     D                                     DIM(12)
0019002110130130 D  BAL1                 361    365P 2
0020002110130131 D  BAL2                 366    370P 2
0021002110130132 D  BAL3                 371    375P 2
0022002110130133 D  BAL4                 376    380P 2
0023002110130134 D  BAL5                 381    385P 2
0024002110130135 D  BAL6                 386    390P 2
0025002110130136 D  BAL7                 391    395P 2
0026002110130137 D  BAL8                 396    400P 2
0027002110130138 D  BAL9                 401    405P 2
0028002110130139 D  BAL10                406    410P 2
0029002110130140 D  BAL11                411    415P 2
0030002110130141 D  BAL12                416    420P 2
0031000902260055 D                 DS
0032002110130056 Dstsa                     1     10  0
0033000902260056 Dstrust                   1      3  0
0034000902260056 Dssub                     4      6  0
0035000902260056 Dsacc                     7     10  0
0036002110140055 D                UDS
0037002110140067 D  USER                  25     34
0038002110140056 D  CONAME               201    240
003900990819
004000990819     c     #t0010        tag
004100211013
004200990819     c                   exfmt     scrn01
004300211013
004400211013     c                   exsr      #clear
004500211013
004600990819     c                   if        *inkg
004700211013     c                   eval      parm07 = 'Y'
004800990819     c                   goto      #end
004900990819     c                   end
005000211013
005100211014      * check for accounts entered
005200211014
005300211013       if  tsa1 <> *blanks;
005400211013       stsa = %Dec(tsa1 : 10 : 0);
005500211013       exsr #getacc;
005600211013        sname1 = wkname;
005700211013        sbal1  = wkbal;
005800211014        scd1   = wkcd;
005900211013       endif;
006000211013
006100211013       if tsa2 <> *blanks;
006200211013       stsa = %Dec(tsa2 : 10 : 0);
006300211013       exsr #getacc;
006400211013        sname2 = wkname;
006500211013        sbal2  = wkbal;
006600211014        scd2   = wkcd;
006700211013       endif;
006800211013
006900211013       if tsa3 <> *blanks;
007000211013       stsa = %Dec(tsa3 : 10 : 0);
007100211013       exsr #getacc;
007200211013        sname3 = wkname;
007300211013        sbal3  = wkbal;
007400211014        scd3   = wkcd;
007500211013       endif;
007600211013
007700211013       if tsa4 <> *blanks;
007800211013       stsa = %Dec(tsa4 : 10 : 0);
007900211013       exsr #getacc;
008000211013        sname4 = wkname;
008100211013        sbal4  = wkbal;
008200211014        scd4   = wkcd;
008300211013       endif;
008400211013
008500211013       if tsa5 <> *blanks;
008600211013       stsa = %Dec(tsa5 : 10 : 0);
008700211013       exsr #getacc;
008800211013        sname5 = wkname;
008900211013        sbal5  = wkbal;
009000211014        scd5   = wkcd;
009100211013       endif;
009200211013
009300211013       if tsa6 <> *blanks;
009400211013       stsa = %Dec(tsa6 : 10 : 0);
009500211013       exsr #getacc;
009600211013        sname6 = wkname;
009700211013        sbal6  = wkbal;
009800211014        scd6   = wkcd;
009900211013       endif;
010000211013
010100211013       if tsa7 <> *blanks;
010200211013       stsa = %Dec(tsa7 : 10 : 0);
010300211013       exsr #getacc;
010400211013        sname7 = wkname;
010500211013        sbal7  = wkbal;
010600211014        scd7   = wkcd;
010700211013       endif;
010800211013
010900211013       if tsa8 <> *blanks;
011000211013       stsa = %Dec(tsa8 : 10 : 0);
011100211013       exsr #getacc;
011200211013        sname8 = wkname;
011300211013        sbal8  = wkbal;
011400211014        scd8   = wkcd;
011500211013       endif;
011600211013
011700211013       if tsa9 <> *blanks;
011800211013       stsa = %Dec(tsa9 : 10 : 0);
011900211013       exsr #getacc;
012000211013        sname9 = wkname;
012100211013        sbal9  = wkbal;
012200211014        scd9   = wkcd;
012300211013       endif;
012400211013
012500211013       if tsa10 <> *blanks;
012600211013       stsa = %Dec(tsa10 : 10 : 0);
012700211013       exsr #getacc;
012800211013        sname10 = wkname;
012900211013        sbal10  = wkbal;
013000211014        scd10   = wkcd;
013100211013       endif;
013200211013
013300211013       if tsa11 <> *blanks;
013400211013       stsa = %Dec(tsa11 : 10 : 0);
013500211013       exsr #getacc;
013600211013        sname11 = wkname;
013700211013        sbal11  = wkbal;
013800211014        scd11   = wkcd;
013900211013       endif;
014000211013
014100211013       if tsa12 <> *blanks;
014200211013       stsa = %Dec(tsa12 : 10 : 0);
014300211013       exsr #getacc;
014400211013        sname12 = wkname;
014500211013        sbal12  = wkbal;
014600211014        scd12   = wkcd;
014700211013       endif;
014800211013
014900211013       if tsa13 <> *blanks;
015000211013       stsa = %Dec(tsa13 : 10 : 0);
015100211013       exsr #getacc;
015200211013        sname13 = wkname;
015300211013        sbal13  = wkbal;
015400211014        scd13   = wkcd;
015500211013       endif;
015600211013
015700211013       if tsa14 <> *blanks;
015800211013       stsa = %Dec(tsa14 : 10 : 0);
015900211013       exsr #getacc;
016000211013        sname14 = wkname;
016100211014        sbal14  = wkbal;
016200211014        scd14   = wkcd;
016300211013       endif;
016400211013
016500211013       if tsa15 <> *blanks;
016600211013       stsa = %Dec(tsa15 : 10 : 0);
016700211013       exsr #getacc;
016800211013        sname15 = wkname;
016900211013        sbal15  = wkbal;
017000211014        scd15   = wkcd;
017100211013       endif;
017200211013
017300211013
0174009908200060
017500211014      * redisplay screen until F5 is pressed to print letters
017600211014     c                   if        not *inke
017700211013     c                   goto      #t0010
017800211013     c                   end
017900990820
018000990819     C     #end          tag
018100990819     c                   eval      *inlr = *on
018200211013
018300211013      *******************************
018400211013      * get account
018500211013      *******************************
018600211013       begsr #getacc;
018700211013
018800211013       clear wkname;
018900211013       clear wkbal;
019000211014       clear wkcd;
019100211013
019200211013       chain (strust : ssub : sacc) accmst;
019300211013        if %found (accmst);
019400211014         wkname = acnam1;
019500211014         wkbal  = %editc(%XFOOT(BAL):'O');
019600211014
019700211014        if atrmdt <> 0;
019800211014         @datin = atrmdt;
019900211014         exsr #datym;
020000211014         wkcd   = %editc(@datou:'Y');
020100211014        endif;
020200211013
020300211014      * write to work file for printing when F5 is pressed
020400211014         if *inke;
020500211014          r81trust = actrst;
020600211014          r81sub   = acsub#;
020700211014          r81acct  = acacct;
020800211014          write rpf081r;
020900211014         endif;
021000211013
021100211013        endif;
021200211013
021300211013       endsr;
021400211013
021500211013     C*******************************
021600211013     C* clear screen fields
021700211013     C*******************************
021800211013         begsr #clear;
021900211013         clear sname1;
022000211013         clear sbal1;
022100211013         clear sname2;
022200211013         clear sbal2;
022300211013         clear sname3;
022400211013         clear sbal3;
022500211013         clear sname4;
022600211013         clear sbal4;
022700211013         clear sname5;
022800211013         clear sbal5;
022900211013         clear sname6;
023000211013         clear sbal6;
023100211013         clear sname7;
023200211013         clear sbal7;
023300211013         clear sname8;
023400211013         clear sbal8;
023500211013         clear sname9;
023600211013         clear sbal9;
023700211013         clear sname10;
023800211013         clear sbal10;
023900211013         clear sname11;
024000211013         clear sbal11;
024100211013         clear sname12;
024200211013         clear sbal12;
024300211013         clear sname13;
024400211013         clear sbal13;
024500211013         clear sname14;
024600211013         clear sbal14;
024700211013         clear sname15;
024800211013         clear sbal15;
024900211013
025000211013         endsr;
0251002110140103 C***************************************************
0252002110140104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0253002110140105 C***************************************************
0254002110140107 C*
0255002110140107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0256002110140107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0257002110140107 C*
0258002110140106 C     #DATYM        BEGSR
025900211014     C                   MOVE      @DATIN        @MD               4 0
026000211014     C                   MOVEL     @DATIN        @Y                4 0
026100211014     C                   MOVEL     @MD           @DATOU            8 0
026200211014     C                   MOVE      @Y            @DATOU
026300211014     C                   MOVE      *ZEROS        @DATIN            8 0
0264002110140120 C                   ENDSR
0265002110140107 C*
026600211013
0267002110130103 C*****************************************************************
026800211013     C     *INZSR        BEGSR
026900211013     C     *entry        plist
027000211013     C                   parm                    parm07            1
027100211013
027200000413     C*
027300981112     C                   ENDSR
