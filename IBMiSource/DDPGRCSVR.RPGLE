000100150408     Fddggrpxp  IF   E             DISK
000200150408     FddgCSVP   O  A F 2000        DISK
000300050823   X***X
000400060315     D @OUTPUT         S           2000A   INZ
000500051108     D @C              C                   CONST('","')
000600200320     D totpr           S             12A   INZ
000700051108    ***
0008000704030025  *
0009000803130250 D                 DS
0010002003200251 D  dxempc1                1      5  0
0011002003200251 D   aempc1                1      5
0012002003200025  *
0013002003200250 D                 DS
0014002003200251 D  dxempc2                1      5  0
0015002003200251 D   aempc2                1      5
0016002003200025  *
0017002003200250 D                 DS
0018002003200251 D  dxempc3                1      5  0
0019002003200251 D   aempc3                1      5
0020002003200025  *
0021002003200250 D                 DS
0022002003200251 D  dxempc4                1      5  0
0023002003200251 D   aempc4                1      5
0024002003200025  *
0025002003200250 D                 DS
0026002003200251 D  dxempt                 1      5  0
0027002003200251 D   aempt                 1      5
0028001504080025  *
0029001504080250 D                 DS
0030001504080251 D  dxtotc                 1      5  0
0031001504080251 D   atotc                 1      5
003200140114      *
003300140109      ******************************************************************
003400140109   X* *
003500140114   X* *        Build Header Row
003600140114     C                   CLEAR                   @OUTPUT
003700200320     C                   EVAL      @OUTPUT = 'Delta_CO,' +
003800200320     C                             'Contract_State,' +
003900200320     C                             'Plan Description,' +
004000200320     C                             'EMPLOYER_NO,' +
004100200320     C                             'GROUP_NO,' +
004200200320     C                             'SUBL,' +
004300200320     C                             'EMPLOYER_NAME,' +
004400200320     C                             'EMPLOYER_Phone,' +
004500200320     C                             'EMPLOYER_Fax,' +
004600200320     C                             'MAILING_ADDRESS_LINE_1,' +
004700200320     C                             'MAILING_ADDRESS_LINE_2,' +
004800200320     C                             'CITY,' +
004900150408     C                             'ST,' +
005000150408     C                             'Zip,' +
005100200320     C                             'EMPLOYER_Contact,' +
005200200320     C                             'EMPLOYER_Contact Email,' +
005300200320     C                             'Employer TIN,' +
005400200320     C                             'Original_Effective_Date,' +
005500200320     C                             'EFFEC_DATE,' +
005600200320     C                             'Next Renewal Date,' +
005700200320     C                             'SIC_CD,' +
005800200320     C                             'BILLING STRUCTURE,' +
005900200320     C                             'ONE_TIER_NO,' +
006000200320     C                             'TWO_TIER_NO,' +
006100200320     C                             'THREE_TIER_NO,' +
006200200320     C                             'FOUR_TIER_NO,' +
006300200320     C                             'TOTAL_COUNT,' +
006400200320     C                             'Total Enrollment,' +
006500200320     C                             'ANNUALIZED_PREMIUM,' +
006600200612      *
006700200612     C                             'GENERAL_AGT_NAME,' +
006800200612     C                             'GA_NO,' +
006900200612     C                             'GA_CODE,' +
007000200612     C                             'GA_REP,' +
007100200612     C                             'GA_FIELD_REP,' +
007200200612     C                             'GA_ST,' +
007300200612     C                             'GA_TIN,' +
007400200612      *
007500200612     C                             'BROKER_COMPANY_NAME,' +
007600200320     C                             'BROKER_LAST_NAME,' +
007700200320     C                             'BROKER_FIRST_NAME,' +
007800200320     C                             'BROKER_NO,' +
007900200320     C                             'BROKER_TIN,' +
008000200320     C                             'BROKER_ADDR_1,' +
008100200320     C                             'BROKER_ADDR_2,' +
008200200320     C                             'BROKER_CITY,' +
008300200320     C                             'BROKER_STATE,' +
008400200320     C                             'BROKER_ZIP,' +
008500200320     C                             'BROKER_PHONE,' +
008600200320     C                             'BROKER_EMAIL,' +
008700200320     C                             'MASTER_BROKER,' +
008800200320     C                             'MASTER_BROKER TIN,' +
008900200320     C                             'MASTER_BROKER_ADDR_1,' +
009000200320     C                             'MASTER_BROKER_ADDR_2,' +
009100200320     C                             'MASTER_BROKER_CITY,' +
009200200320     C                             'MASTER_BROKER_STATE,' +
009300200320     C                             'MASTER_BROKER_ZIP5,' +
009400200320     C                             'MASTER_BROKER_PHONE,' +
009500200320     C                             'MASTER_BROKER EMAIL,' +
009600200612     C                             'ER_EMPLOYEE_CONTR,' +
009700200612      *
009800200612     C                             'VISION_CODE,' +
009900200612     C                             'VISION_EFF_DATE,' +
010000200612     C                             'VISION_TERM_DATE,' +
010100200612      *
010200200320     C                             'HAS_ASSOC_GROUPS,' +
010300200612     C                             'PRIOR_CARRIER'
010400140114    * *
010500140114     C                   EXCEPT    OUTFA
010600140114    * *
010700150408     C****               setll     ddggrpxp                           21
010800140109     C                   dou       *in21 = '1'
010900110419      *
011000150408     C                   read      ddggrpxp                               21
011100150408     C                   if        *in21 = '0'
011200140109      *
011300200320     C                   eval      totpr = %editc(dxtotp:'1')
011400140528      *
011500080313     C                   CLEAR                   @OUTPUT
011600200320     C                   EVAL      @OUTPUT = %TRIM('DDP') + ',' +
011700200320     C                             %TRIM(dxast) + ',' +
011800200320     C                             %TRIM(dxpdsc) + ',' +
011900200320     C                             %TRIM(dxemr#) + ',' +
012000200320     C                             %TRIM(dxgrp#) + ',' +
012100200320     C                             %TRIM(dxdiv#) + ',' + '"' +
012200200320     C                             %TRIM(dxanam) + '"' + ',' +
012300200320     C                             %TRIM(dxaphn) + ',,' + '"' +
012400200320     C                             %TRIM(dxaad1) + '",' + '"' +
012500200320     C                             %TRIM(dxaad2) + '",' +
012600200320     C                             %TRIM(dxacty) + ',' +
012700200320     C                             %TRIM(dxast) + ',' +
012800200320     C                             %TRIM(dxazip) + ',' +
012900230316     C                             %TRIM(dxcntc) + ',' +
012901230316     C                             %TRIM(dxaeml) + ',' +
013000200320     C                             %TRIM(dxtin) + ',' +
013100200320     C                             %TRIM(dxoeff) + ','  +
013200200320     C                             %TRIM(dxceff) + ',' +
013300200320     C                             %TRIM(dxrenew)+ ',' +
013400200320     C                             %TRIM(dxsic) + ',' +
013500200320     C                             %TRIM('4') + ',' +
013600200320     C                             %TRIM(aempc1)+ ',' +
013700200320     C                             %TRIM(aempc2)+ ',' +
013800200320     C                             %TRIM(aempc3)+ ',' +
013900200320     C                             %TRIM(aempc4)+ ',' +
014000200320     C                             %TRIM(aempt)+ ',' +
014100200320     C                             %TRIM(atotc) + ',' + '"' +
014200200612     C                             %TRIM(totpr) + '"' + ',,,,,,,,,' + '"' +
014300200320     C                             %TRIM(dxslnm) + '"' + ',' +
014400200320     C                             %TRIM(dxsfnm) + ',,,' + '"' +
014500200320     C                             %TRIM(dxsadr) + '"' + ',,' +
014600200320     C                             %TRIM(dxscty) + ',' +
014700200320     C                             %TRIM(dxsst) + ',' +
014800200320     C                             %TRIM(dxszip) + ',' +
014900200320     C                             %TRIM(dxsare) +
015000230316     C                             %TRIM(dxsphn) + ',' +
015001230316     C                             %TRIM(dxseml)
015100140109    * *
015200060315     C                   EXCEPT    OUTFA
015300140109    * *
015400140109     C                   endif
015500140110    * *
015600140109     C                   enddo
015700140109    * *
015800140109     C                   eval      *inlr = '1'
015900140109     C                   return
016000070403   S***S
016100070403     C**** *INZSR        BEGSR
016200070403    ***
016300070403     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
016400070403     C****                         '"FIELD D"'
016500070403    ***
016600070403     C****               EXCEPT    OUTFA
016700070403    ***
016800070403     C**************     ENDSR
016900070403   S***S
017000070403   X***X
017100060315    ***
017200150408     ODDGCSVP   EADD         OUTFA
017300060315     O                       @OUTPUT           2000
