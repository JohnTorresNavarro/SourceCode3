000100000000      *_________________________________________________________________________
000200000000      *
000300190508      *  Description:  Met Life Death Match PIPE File
000400000000      *
000500190318      *  (c)Copyright 2019 by GBS, Inc.
000600000000      *
000700190926      *    Created by:  RLJ - 5/8/2019
000800000000      *_________________________________________________________________________
000900190926     FMETLCHGP  IP   E             DISK
001000190926     FMETLDPIPP O  A E             DISK
001100190926
001200190926     D header          s              1a   inz
001300190926     D z               s              2S 0
001400190926     D recno           s              8  0 inz(0)
001500190926     D recna           s              8a
001600190926     D stts            s             10a
001700190627     D role            s             10a
001800190627     D  todate         S               D   DATFMT(*ISO)
001900190627     D  todatx         S              8  0
002000170601
002100170601     C                   if        header = *blanks
002200190508     C                   Eval      METLDTA =
002300190508     C                                     'IN_RECORDNO' + '|' +
002400190508     C                                     'IN_SOURCE_ID_KEY' + '|' +
002500190508     C                                     'IN_ORIGIN_SRC' + '|' +
002600190508     C                                     'IN_CLIENT_UDF1' + '|' +
002700190508     C                                     'IN_PARTYTYPE' + '|' +
002800190508     C                                     'IN_TAXIDTYPE' + '|' +
002900190508     C                                     'IN_TAXIDVALUE' + '|' +
003000190508     C                                     'IN_GENDER' + '|' +
003100190508     C                                     'IN_MARITALSTATUS' + '|' +
003200190508     C                                     'IN_DOB' + '|' +
003300190508     C                                     'IN_FULLNAME' + '|' +
003400190508     C                                     'IN_PREFIXNAME' + '|' +
003500190508     C                                     'IN_FIRSTNAME' + '|' +
003600190508     C                                     'IN_MIDDLENAME' + '|' +
003700190508     C                                     'IN_LASTNAME' + '|' +
003800190508     C                                     'IN_SUFFIXNAME' + '|' +
003900190508     C                                     'IN_ADDRESS_TP' + '|' +
004000190508     C                                     'IN_ADDRESS1' + '|' +
004100190508     C                                     'IN_ADDRESS2' + '|' +
004200190508     C                                     'IN_ADDRESS3' + '|' +
004300190508     C                                     'IN_ADDRESS4' + '|' +
004400190508     C                                     'IN_CITY' + '|' +
004500190508     C                                     'IN_STATE' + '|' +
004600190508     C                                     'IN_ZIP5' + '|' +
004700190508     C                                     'IN_ZIP4' + '|' +
004800190508     C                                     'IN_COUNTRY' + '|' +
004900190508     C                                     'IN_PHONE1_TP' + '|' +
005000190611     C                                     'IN_PHONE1' + '|' +
005100190508     C                                     'IN_PHONE2_TP' + '|' +
005200190611     C                                     'IN_PHONE2' + '|' +
005300190508     C                                     'IN_PHONE3_TP' + '|' +
005400190611     C                                     'IN_PHONE3' + '|' +
005500190508     C                                     'IN_EMAIL_TP' + '|' +
005600190508     C                                     'IN_EMAIL' + '|' +
005700190508     C                                     'IN_ID1_TP' + '|' +
005800190508     C                                     'IN_ID1_VALUE' + '|' +
005900190508     C                                     'IN_ID2_TP' + '|' +
006000190508     C                                     'IN_ID2_VALUE' + '|' +
006100190508     C                                     'IN_DEATH_DT' + '|' +
006200190508     C                                     'IN_ACTION_CD_ROLE' + '|' +
006300190508     C                                     'IN_PREF_TP_PARTY_ADDR' + '|' +
006400190508     C                                     'IN_PREF_VALUE_PARTY_ADDR' + '|' +
006500190508     C                                     'IN_PREF_TP_PARTY_ELEC_ADDR' + '|' +
006600190508     C                                     'IN_PREF_VALUE_PARTY_ELEC_ADDR|' +
006700190508     C                                     'IN_PREF_TP_PARTY_PHONE' + '|' +
006800190508     C                                     'IN_PREF_VALUE_PARTY_PHONE' + '|' +
006900190508     C                                     'IN_PREF_TP_PARTY' + '|' +
007000190508     C                                     'IN_PREF_VALUE_PARTY' + '|' +
007100190508     C                                     'IN_ROLE' + '|' +
007200190508     C                                     'IN_ROLE_SUB_TP' + '|' +
007300190508     C                                     'IN_LEGAL_ENTITY_TP' + '|' +
007400190508     C                                     'IN_LEGAL_STATUS_DESC' + '|' +
007500190508     C                                     'IN_MEMBER_CNT' + '|' +
007600190508     C                                     'IN_GENERATION' + '|' +
007700190508     C                                     'IN_ACTION_CD_AGREEMENT' + '|' +
007800190508     C                                     'IN_AGREEMENT_KEY_ACCT_NBR' + '|' +
007900190508     C                                     'IN_AGREEMENT_KEY_ACCT_SFX' + '|' +
008000190508     C                                     'IN_AGREEMENT_KEY_BRCH_NBR' + '|' +
008100190508     C                                     'IN_AGREEMENT_KEY_CUST_NBR' + '|' +
008200190508     C                                     'IN_AGREEMENT_KEY_EMP_NBR' + '|' +
008300190508     C                                     'IN_AGREEMENT_KEY_FUND_FAM' + '|' +
008400190508     C                                     'IN_AGREEMENT_KEY_GRP_NBR' + '|' +
008500190508     C                                     'IN_AGREEMENT_KEY_LGL_ENTY' + '|' +
008600190508     C                                     'IN_AGREEMENT_KEY_SUB_DIV' + '|' +
008700190508     C                                     'IN_AGREEMENT_KEY_UDF' + '|' +
008800190509     C                                     'IN_AGREEMENT_LOB' + '|' +
008900190625     C                                     'IN_AGREEMENT_DIST_CHNL' + '|' +
009000190508     C                                     'IN_AGREEMENT_STTS' + '|' +
009100190508     C                                     'IN_AGREEMENT_EFF_DT' + '|' +
009200190508     C                                     'IN_AGREEMENT_ISS_DT' + '|' +
009300190508     C                                     'IN_AGREEMENT_TERM_DT' + '|' +
009400190508     C                                     'IN_AGREEMENT_ISS_COMPANY' + '|' +
009500190508     C                                     'IN_AGREEMENT_RISK_JRST_NM' + '|' +
009600190508     C                                     'IN_AGREEMENT_COV_AMT' + '|' +
009700190508     C                                     'IN_AGREEMENT_PROD_GRP_NM' + '|' +
009800190508     C                                     'IN_AGREEMENT_PROD_ID' + '|' +
009900190508     C                                     'IN_AGREEMENT_PROD_NM' + '|' +
010000190508     C                                     'IN_AGREEMENT_PLN_NM' + '|' +
010100190508     C                                     'IN_AGREEMENT_PROD_TYP_CD' + '|' +
010200190508     C                                     'IN_AGREEMENT_PROD_TYP_ABBREV_CD|' +
010300190508     C                                     'IN_AGREEMENT_PROD_TYP_LOWEST|' +
010400190611     C                                     'IN_AGREEMENT_AGREE_DSCR' + '|' +
010500190508     C                                     'IN_AGREEMENT_SRVC_-AGT_ID' + '|' +
010600190508     C                                     'IN_AGREEMENT_SRVC_AGT_NAME' + '|' +
010700190508     C                                     'IN_AGREEMENT_IRS_MRKT_TPCD' + '|' +
010800190508     C                                     'IN_AGREEMENT_RSTRCN_TP' + '|' +
010900190611     C                                     'IN_AGREEMENT_RSTRCN_VALUE'
011000190508      *
011100190508     C                   Write     metldpipr
011200170602     C                   eval      header = 'Y'
011300170601     C                   end
011400190509      *
011500190509     C                   Eval      recno = recno + 1
011600190509     C                   Eval      recna = %EDITC(recno:'3')
011700190627      *
011800190627     C                   Eval      stts = 'ACTIVE    '
011900190731     C                   if        mcptmn <> 0 and mcptmn < todatx
012000190627     C                   Eval      stts = 'CANCELLED '
012100190627     C                   Endif
012200190509      *
012300190627     C                   Eval      role = 'INSURED   '
012400190731    4C                   eval      Z = %scan ('SPOUSE':MCPLTP)
012500190627    4C                   IF        z <> 0
012600190627     C                   Eval      role = 'SPOUSE    '
012700190627     C                   else
012800190731    4C                   eval      Z = %scan ('DEPEND':MCPLTP)
012900190627    4C                   IF        z <> 0
013000190627     C                   Eval      role = 'DEPENDENT '
013100190627     C                   endif
013200190627     C                   endif
013300190627      *
013400190509     C                   Eval      metldta =
013500190625     C                                     %trim(recna) + '|' +
013600190731     C                                     %trim(mcssn) + '-' +
013700190731     C                                     %trim(mcpltp) + '|' +
013800190611     C                                     %trim('TPA_GBS_GL') + '|' + '|' +
013900190509     C                                     %trim('P|S') + '|' +
014000190731     C                                     %trim(mcssn) + '|' +
014100190731     C                                     %trim(mcsex) + '||' +
014200190731     C                                     %trim(mcdob) + '|||' +
014300190731     C                                     %trim(mcfnam) + '||' +
014400190731     C                                     %trim(mclnam) + '||' +
014500190509     C                                     %trim('HOME') + '|' +
014600190731     C                                     %trim(mcadr1) + '|' +
014700190731     C                                     %trim(mcadr2) + '|||' +
014800190731     C                                     %trim(mccity) + '|' +
014900190731     C                                     %trim(mcst) + '|' +
015000190731     C                                     %trim(mczip) + '||||' +
015100190731     C                                     %trim(mcphon) + '||||||||||||' +
015200190522     C                                     %trim('U') + '|' +
015300190627     C******                               '||||||||||||||' +
015400190627     C                                     '||||||||' +
015500190627     C                                     %trim(role) + '|' +
015600190627     C                                     '|||||' +
015700190522     C                                     %trim('U') + '|' +
015800190731     C                                     %trim(mcplan) + '|' +
015900190509     C                                     '|||||||||' +
016000190731     C                                     %trim(mcpltp) + '||' +
016100190627     C                                     %trim(stts) + '|' +
016200190731     C                                     %trim(mcpefd) + '|' +
016300190731     C                                     %trim(mcpefd) + '|' +
016400190731     C                                     %trim(mcptmd) + '|' +
016500190509     C                                     '|||||||' +
016600190731     C                                     %trim(mcpltp) + '||' +
016700190708     C                                     '||||||'
016800190508      *
016900190508     C                   Write     metldpipr
017000190627      ****************************************************
017100190708     C     *INZSR        BEGSR
017200190627      *
017300190627     C                   MOVE      *DATE         todate
017400190627     C                   MOVEL     todate        todatx
017500190627     C                   ENDSR
017600120614
