000100201113      *
000200201113      * 11/12/20 dlk - add carrier
000300211230      * 12/30/21 dlk - add transaction time
000400220127      * 01/27/22 dlk - add plan description and user name
000500230717      * 07/17/23 jva - if secure name is blanks, user HOPER
000600201113      *
000700201113      *
000800140110     FRP13WKP   UF   E           K DISK
000900220127     Fgbsecure  IF   E           K DISK
001000140109     FRP13CSXP  O  A F 2000        DISK
001100050823   X***X
001200060315     D @OUTPUT         S           2000A   INZ
001300220127     D csv             C                   CONST('","')
001400220127     D unameout        s                   like(scname)
001500051108    ***
0016000704030025  *
0017000803130250 D                 DS
0018000811140251 D  datymd                 1      8  0
001900140114      *
002000140109     C     wkkey         klist
002100140109     C                   kfld                    to                8
002200140109     C                   kfld                    fr                8
002300140109     C                   kfld                    trs               3
002400140109     C                   kfld                    sub               3
002500140109     C                   kfld                    acc               4
002600140109     C                   kfld                    ssn              11
002700081114   X* *
002800140109     C     *ENTRY        PLIST
002900140109     C                   PARM                    TO
003000140109     C                   PARM                    FR
003100140109     C                   PARM                    TRS
003200140109     C                   PARM                    SUB
003300140109     C                   PARM                    ACC
003400140109     C                   PARM                    SSN
003500140109      ******************************************************************
003600140109   X* *
003700140114   X* *        Build Header Row
003800140114     C                   CLEAR                   @OUTPUT
003900220127
004000220127       @output   = '"' +
004100220127         'ACCT #'                               + csv +
004200220127         'ACCOUNT NAME'                         + csv +
004300220127         'SSN #'                                + csv +
004400220127         'LAST NAME'                            + csv +
004500220127         'TR DATE'                              + csv +
004600220127         'TR TIME'                              + csv +
004700220127         'TRANSACTION'                          + csv +
004800220127         'TRANS. AMOUNT'                        + csv +
004900220127         'ACCOUNT BALANCE'                      + csv +
005000220127         'EFF. DATE'                            + csv +
005100220127         'REC. DATE'                            + csv +
005200220127         'NOTE 1'                               + csv +
005300220127         'NOTE 2'                               + csv +
005400220127         'ACA'                                  + csv +
005500220127         'PLAN'                                 + csv +
005600220127         'CARRIER'                              + csv +
005700220127         'USER'                                 + csv +
005800220127         ' '                                    +
005900220127    *    '"';
006000140114    * *
006100140114     C                   EXCEPT    OUTFA
006200140114    * *
006300140109     C     wkkey         setll     rp13wkp                            21
006400140109     C                   dou       *in21 = '1'
006500110419      *
006600140109     C     wkkey         reade     rp13wkp                                21
006700140109      *
006800140109     C                   if        *in21 = '0' and rwacaf = 'Y'
006900220127
007000220127      *
007100220127      * get user name
007200220127      *
007300220127        clear unameout;
007400220127        chain rwuser gbsecure;
007500220127        if %found(gbsecure);
007600230717        if %trim(scname) <> *blanks;
007700230717         unameout = %trim(scname);
007800230717        else;
007900230717         unameout = %trim(rwuser);
008000230717        endif;
008100220127        else;
008200220127         unameout = rwuser;
008300220127        endif;
008400220127
008500140109      *
008600080313     C                   CLEAR                   @OUTPUT
008700220127
008800220127       @output   = '"' +
008900220127         %TRIM(rwpacc)                          + csv +
009000220127         %TRIM(rwacnm)                          + csv +
009100220127         %TRIM(rwssno)                          + csv +
009200220127         %TRIM(rwlnam)                          + csv +
009300220127         %TRIM(rwtrdt)                          + csv +
009400220127         %TRIM(rwtrtime)                        + csv +
009500220127         %TRIM(rwtran)                          + csv +
009600220127         %TRIM(rwtram)                          + csv +
009700220127         %TRIM(rwabal)                          + csv +
009800220127         %TRIM(rwefdt)                          + csv +
009900220127         %TRIM(rwrecd)                          + csv +
010000220127         %TRIM(rwck#n)                          + csv +
010100220127         %TRIM(rwck#2)                          + csv +
010200220127         %TRIM(rwacaf)                          + csv +
010300220127         %TRIM(rwpdescr)                        + csv +
010400220127         %TRIM(rwcarr)                          + csv +
010500220127         %TRIM(unameout)                        + csv +
010600220127         ' '                                    +
010700220127    *    '"';
010800140109    * *
010900060315     C                   EXCEPT    OUTFA
011000140109    * *
011100140109     C                   endif
011200140109    * *
011300140110     C                   if        *in21 = '0'
011400140110     C                   delete    rp13wkr
011500140110     C                   endif
011600140110    * *
011700140109     C                   enddo
011800140109    * *
011900140109     C                   eval      *inlr = '1'
012000140109     C                   return
012100220127
012200140109     ORP13CSXP  EADD         OUTFA
012300060315     O                       @OUTPUT           2000
