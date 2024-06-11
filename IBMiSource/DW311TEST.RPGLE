000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Delegated Billing Electronic Enrollment
000400000000      *
000500000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - October 24, 2002
000800000000      *_________________________________________________________________________
000900021024      *
001000090320      *
001100120821     D WTODAY          s             10a
001200131213     D W80ADDS         s              8s 0
001300131213     D W80ADD41        s              8s 0
001400131213     D W80ADD42        s              8s 0
001500131213     D W80ADD43        s              8s 0
001600131213     D W80ADD44        s              8s 0
001700130905     D W80DATE         s              8s 0
001800130905     D W81DATE         s              8s 0
001900130905     D W82DATE         s              8s 0
002000120821     D W8ADATE         s             10a
002100030513
002200131216     D WDTA          E DS                  EXTNAME(DBEDTL834)
002300131213
002400131213     C                   Eval      w80adds  = 0
002500131213     C                   Eval      w80add41 = 0
002600131213     C                   Eval      w80add42 = 0
002700131213     C                   Eval      w80add43 = 0
002800131213     C                   Eval      w80add44 = 0
002900131216
003000131216     C                   eval      D3FIL41 = 'A'
003100131216     C                   eval      D3SCEF1 = '12/01/2013'
003200131213
003300131213     C                   If        D3FIL41 = 'A'    and
003400131213     C                             D3SCEF1   <> *blanks
003500131213
003600131213     C                   Movel     D3SCEF1       Input_Date
003700131213     C                   Eval      Input_Format = 'MM/DD/YYYY'
003800131213     C                   Eval      Output_Format  = 'YYYYMMDD'
003900131213     C                   Exsr      FormatDateSR
004000131213     C                   Eval      W8ADATE       = %trim(Output_Date)
004100131213     C                   Move      W8ADATE       W80ADD41
004200131213     C                   Move      W8ADATE       W80ADDS
004300131213     C                   End
004400131213
004500131213     C                   If        D3FIL42 = 'A'    and
004600131213     C                             D3SCEF2   <> *blanks
004700131213
004800131213     C                   Movel     D3SCEF2       Input_Date
004900131213     C                   Eval      Input_Format = 'MM/DD/YYYY'
005000131213     C                   Eval      Output_Format  = 'YYYYMMDD'
005100131213     C                   Exsr      FormatDateSR
005200131213     C                   Eval      W8ADATE       = %trim(Output_Date)
005300131213     C                   Move      W8ADATE       W80ADD42
005400131213     C                   If        W80ADD42 > W80ADDS
005500131213     C                   Eval      W80ADDS = W80ADD42
005600131213     C                   End
005700131213     C                   End
005800131213
005900131213     C                   If        D3FIL43 = 'A'    and
006000131213     C                             D3SCEF3   <> *blanks
006100131213
006200131213     C                   Movel     D3SCEF3       Input_Date
006300131213     C                   Eval      Input_Format = 'MM/DD/YYYY'
006400131213     C                   Eval      Output_Format  = 'YYYYMMDD'
006500131213     C                   Exsr      FormatDateSR
006600131213     C                   Eval      W8ADATE       = %trim(Output_Date)
006700131213     C                   Move      W8ADATE       W80ADD43
006800131213     C                   If        W80ADD43 > W80ADDS
006900131213     C                   Eval      W80ADDS = W80ADD43
007000131213     C                   End
007100131213     C                   End
007200131213
007300131213     C                   If        D3FIL44 = 'A'    and
007400131213     C                             D3SCEF4   <> *blanks
007500131213
007600131213     C                   Movel     D3SCEF4       Input_Date
007700131213     C                   Eval      Input_Format = 'MM/DD/YYYY'
007800131213     C                   Eval      Output_Format  = 'YYYYMMDD'
007900131213     C                   Exsr      FormatDateSR
008000131213     C                   Eval      W8ADATE       = %trim(Output_Date)
008100131213     C                   Move      W8ADATE       W80ADD44
008200131213     C                   If        W80ADD44 > W80ADDS
008300131213     C                   Eval      W80ADDS = W80ADD44
008400131213     C                   End
008500131213     C                   End
008600131213
008700131213     C                   If        W80ADDS  > 0
008800131213
008900131213     C                   If        D3FIL41 = 'A'    and
009000131213     C                             D3SCEF1   <> *blanks
009100131213     C                   Movel     W80ADDS       Input_Date
009200131213     C                   Eval      Input_Format  = 'YYYYMMDD'
009300131213     C                   Eval      Output_Format = 'MM/DD/YYYY'
009400131213     C                   Exsr      FormatDateSR
009500131213     C                   Eval      D3SCEF1       = %trim(Output_Date)
009600131213     C                   End
009700131213
009800131213     C                   If        D3FIL42 = 'A'    and
009900131213     C                             D3SCEF2   <> *blanks
010000131213     C                   Movel     W80ADDS       Input_Date
010100131213     C                   Eval      Input_Format  = 'YYYYMMDD'
010200131213     C                   Eval      Output_Format = 'MM/DD/YYYY'
010300131213     C                   Exsr      FormatDateSR
010400131213     C                   Eval      D3SCEF2       = %trim(Output_Date)
010500131213     C                   End
010600131213
010700131213     C                   If        D3FIL43 = 'A'    and
010800131213     C                             D3SCEF3   <> *blanks
010900131213     C                   Movel     W80ADDS       Input_Date
011000131213     C                   Eval      Input_Format  = 'YYYYMMDD'
011100131213     C                   Eval      Output_Format = 'MM/DD/YYYY'
011200131213     C                   Exsr      FormatDateSR
011300131213     C                   Eval      D3SCEF3       = %trim(Output_Date)
011400131213     C                   End
011500131213
011600131213     C                   If        D3FIL44 = 'A'    and
011700131213     C                             D3SCEF4   <> *blanks
011800131213     C                   Movel     W80ADDS       Input_Date
011900131213     C                   Eval      Input_Format  = 'YYYYMMDD'
012000131213     C                   Eval      Output_Format = 'MM/DD/YYYY'
012100131213     C                   Exsr      FormatDateSR
012200131213     C                   Eval      D3SCEF4       = %trim(Output_Date)
012300131213     C                   End
012400131213
012500131213     C                   End
012600131216
012700131216     C                   Return
012800131213
012900121126      *___________________________________________________________________
013000121126      * Format Date
013100121126      *___________________________________________________________________
013200121126     C     FormatDateSR  BEGSR
013300121126     C                   Call      'FMTDATE'
013400121126     C                   Parm                    Input_Date       32
013500121126     C                   Parm                    Input_Format     32
013600121126     C                   Parm                    Output_Format    32
013700121126     C                   Parm                    Output_Date      32
013800121126     C                   Parm                    Output_Error     10
013900121126     C                   Eval      Input_Date   = *blanks
014000121126     C                   Eval      Input_Format = *blanks
014100121126     C                   Eval      OutPut_Format = *blanks
014200121126     C                   ENDSR
