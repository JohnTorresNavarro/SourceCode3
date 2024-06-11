000100220321     FDDMGRPWP  IPE  E           K DISK
000200220321     FDDMGCSVP  O  A F 2000        DISK
000300050823   X***X
000400220321     D @OUTPUT         S           2000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008002108050025  *
0009000811140250 D                 DS
0010002108050251 D  ebmid#                 1      9  0
0011002108180251 D   eamid#                1      9
0012002203210025  *
0013002203210250 D                 DS
0014002203210251 D  yprm                   1     12
001500080313      *
001600220321     C                   eval      yprm = *blanks
001700220321     C                   if        dyyprm <> 0
001800220322     C                   eval      yprm = %editc(dyyprm:'3')
001900220321     C                   endif
002000081114      *
002100080313     C                   CLEAR                   @OUTPUT
002200220321     C                   EVAL      @OUTPUT = %TRIM('DDP') + ',' +
002300220321     C                             %TRIM(dyast) + ',' +
002400220321     C                             %TRIM(dyplan) + '-' +
002500220321     C                             %TRIM(dypdsc) + ',' +
002600220321     C                             %TRIM(dyemr#) + ',' +
002700220321     C                             %TRIM(dygrp#) + ',' +
002800220321     C                             %TRIM(dydiv#) + ',' +
002900220321     C                             %TRIM(dyanam) + ',' +
003000220321     C                             %TRIM(dyaphn) + ',,' +
003100220321     C                             %TRIM(dyaad1) + ',' +
003200220321     C                             %TRIM(dyaad2) + ',' +
003300220321     C                             %TRIM(dyacty) + ',' +
003400220321     C                             %TRIM(dyast) + ',' +
003500220321     C                             %TRIM(dyazip5) + ',' +
003600220321     C                             %TRIM(dyazip4) + ',' +
003700220321     C                             %TRIM(dycntc) + ',' +
003800220321     C                             %TRIM(dycnem) + ',' +
003900220321     C                             %TRIM(dytin) + ',' +
004000220321     C                             %TRIM(dyoeff) + ',' +
004100220321     C                             %TRIM(dyceff) + ',' +
004200220321     C                             %TRIM(dyrenew) + ',' +
004300220321     C                             %TRIM(dyetrm) + ',' +
004400220322     C                             %TRIM(dysic) + ',,,,' +
004500220321     C                             %TRIM(dyblst) + ',' +
004600220321     C                             %TRIM(yprm) + ',' +
004700220322     C                             'Amwins Connect Administrators,,,,' +
004800220322     C                             'Brandon Scarfield,,' +
004900220321     C                             'MD,' +
005000220321     C                             '52-1200892,,' +
005100220321     C                             %TRIM(dybkcn) + ',' +
005200220321     C                             %TRIM(dybkln) + ',' +
005300220321     C                             %TRIM(dybkfn) + ',' +
005400220321     C                             %TRIM(dybktn) + ',,' +
005500220321     C                             %TRIM(dybkad) + ',,' +
005600220321     C                             %TRIM(dybkct) + ',' +
005700220321     C                             %TRIM(dybkst) + ',' +
005800220321     C                             %TRIM(dybkzp) + ',' +
005900220321     C                             %TRIM(dybkph) + ',' +
006000220321     C                             %TRIM(dybkem) + ',,,' +
006100220321     C                             %TRIM(dymbad) + ',,' +
006200220321     C                             %TRIM(dymbct) + ',' +
006300220321     C                             %TRIM(dymbst) + ',' +
006400220321     C                             %TRIM(dymbzp) + ',' +
006500220321     C                             %TRIM(dymbph) + ',' +
006600220421     C                             %TRIM(dymbem) + ',,,,,,,,,,,,,,,,' +
006700220421     C                             %TRIM(dybkpt)
006800201006    * *
006900060315     C                   EXCEPT    OUTFA
007000201006   S* *
007100201006     C     *INZSR        BEGSR
007200201006    * *
007300220317     C                   EVAL      @OUTPUT = 'DELTA_CO,' +
007400220317     C                             'CONTRACT_ST,' +
007500220317     C                             'PLAN,' +
007600220317     C                             'EMPLOYER_NO,' +
007700220317     C                             'DELTA_GROUP_NO,' +
007800220317     C                             'DELTA_DIVISION_NO,' +
007900220317     C                             'EMPLOYER_NAME,' +
008000220317     C                             'EMPLOYER_PHONE,' +
008100220317     C                             'EMPLOYER_FAX,' +
008200220317     C                             'ADDRESS_LINE_1,' +
008300220317     C                             'ADDRESS_LINE_2,' +
008400220317     C                             'CITY,' +
008500220317     C                             'STATE,' +
008600220317     C                             'ZIP5,' +
008700220317     C                             'ZIP4,' +
008800220317     C                             'EMPLOYER_CONTACT,' +
008900220317     C                             'EMPLOYER_CONTACT_EMAIL,' +
009000220317     C                             'EMPLOYER_TAX_ID,' +
009100220317     C                             'ORIGINAL_EFF_DATE,' +
009200220317     C                             'EFFECTIVE_DATE,' +
009300220317     C                             'RENEWAL_DATE,' +
009400220317     C                             'TERM_DATE,' +
009500220317     C                             'SIC_CD,' +
009600220317     C                             'NAICS_CD,' +
009700220317     C                             'EMP_EMP_CONTRIB,' +
009800220317     C                             'EMP_DEP_CONTRIB,' +
009900220317     C                             'BILL_STRUCTURE,' +
010000220317     C                             'ANNUALIZED_PREMIUM,' +
010100220317     C                             'GENERAL_AGENT_NAME,' +
010200220317     C                             'GA_NUMBER,' +
010300220317     C                             'GA_CODE,' +
010400220317     C                             'GA_NPN,' +
010500220317     C                             'GA_REPRESENTATIVE,' +
010600220317     C                             'GA_FIELD_REP,' +
010700220317     C                             'GA_STATE,' +
010800220317     C                             'GA_TAX_ID,' +
010900220317     C                             'BROKER_NUMBER,' +
011000220317     C                             'BROKER_COMPANY_NAME,' +
011100220317     C                             'BROKER_LAST_NAME,' +
011200220317     C                             'BROKER_FIRST_NAME,' +
011300220317     C                             'BROKER_TAX_ID,' +
011400220317     C                             'BROKER_NPN,' +
011500220317     C                             'BROKER_ADDR_1,' +
011600220317     C                             'BROKER_ADDR_2,' +
011700220317     C                             'BROKER_CITY,' +
011800220317     C                             'BROKER_STATE,' +
011900220317     C                             'BROKER_ZIP5,' +
012000220317     C                             'BROKER_PHONE,' +
012100220317     C                             'BROKER_EMAIL,' +
012200220317     C                             'MASTER_BROKER_NAME,' +
012300220317     C                             'MASTER_BROKER_TAX_ID,' +
012400220317     C                             'MASTER_BROKER_ADDR_1,' +
012500220317     C                             'MASTER_BROKER_ADDR_2,' +
012600220317     C                             'MASTER_BROKER_CITY,' +
012700220317     C                             'MASTER_BROKER_STATE,' +
012800220317     C                             'MASTER_BROKER_ZIP5,' +
012900220317     C                             'MASTER_BROKER_PHONE,' +
013000220317     C                             'MASTER_BROKER_EMAIL,' +
013100220317     C                             'HAS_ASSOC_GROUPS,' +
013200220317     C                             'PRIOR_CARRIER,' +
013300220317     C                             'WAITING_POLICY,' +
013400220317     C                             'DELTA_REGION,' +
013500220317     C                             'DELTA_RISK_LEVEL,' +
013600220317     C                             'VISION_PRODUCT,' +
013700220317     C                             'VISION_EFF_DATE,' +
013800220317     C                             'VISION_TERM_DATE,' +
013900220317     C                             'VISION_BROKER_PCT,' +
014000220317     C                             'VISION_GA_PCT,' +
014100220317     C                             'VISION_ADMIN_PCT,' +
014200220317     C                             'VISION_CARRIER_PCT,' +
014300220317     C                             'VSP_DELTA_MARKETING_FEE,' +
014400220317     C                             'NEW_CARRIER,' +
014500220317     C                             'TERM_REASON,' +
014600220520     C                             'BROKER_COMM_PAYTO'
014700201006    * *
014800201006     C                   EXCEPT    OUTFA
014900201006    * *
015000201006     C                   ENDSR
015100201006    * *
015200201006     C
015300060315    ***
015400220321     ODDMGCSVP  EADD         OUTFA
015500220321     O                       @OUTPUT           2000
