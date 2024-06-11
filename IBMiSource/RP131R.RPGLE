000100201113      *
000200201113      * 11/12/20 dlk - add carrier
000300211230      * 12/30/21 dlk - add transaction time
000400230717      * 01/27/22 dlk - add plan description and user name
000500230717      * 07/17/23 jva - if secure name is blanks, user HOPER
000600201113      *
000700201113      *
000800140109     FRP13WKP   IF   E           K DISK
000900220127     Fgbsecure  IF   E           K DISK
001000140109     FRP13CSVP  O  A F 2000        DISK
001100050823   X***X
001200060315     D @OUTPUT         S           2000A   INZ
001300220127     D csv             C                   CONST('","')
001400220127     D unameout        s                   like(scname)
001500051108    ***
0016001401140025  *
001700140109     C     wkkey         klist
001800140109     C                   kfld                    to                8
001900140109     C                   kfld                    fr                8
002000140114     C                   kfld                    trs               3
002100140114     C                   kfld                    sub               3
002200140114     C                   kfld                    acc               4
002300140109     C                   kfld                    ssn              11
002400081114   X* *
002500140109     C     *ENTRY        PLIST
002600140109     C                   PARM                    TO
002700140109     C                   PARM                    FR
002800140109     C                   PARM                    TRS
002900140109     C                   PARM                    SUB
003000140109     C                   PARM                    ACC
003100140109     C                   PARM                    SSN
003200140109      ******************************************************************
003300140114   X* *        Build Header Row
003400140114     C                   CLEAR                   @OUTPUT
003500220127
003600220127       @output   = '"' +
003700220127         'ACCT #'                               + csv +
003800220127         'ACCOUNT NAME'                         + csv +
003900220127         'SSN #'                                + csv +
004000220127         'LAST NAME'                            + csv +
004100220127         'TR DATE'                              + csv +
004200220127         'TR TIME'                              + csv +
004300220127         'TRANSACTION'                          + csv +
004400220127         'TRANS. AMOUNT'                        + csv +
004500220127         'ACCOUNT BALANCE'                      + csv +
004600220127         'EFF. DATE'                            + csv +
004700220127         'REC. DATE'                            + csv +
004800220127         'NOTE 1'                               + csv +
004900220127         'NOTE 2'                               + csv +
005000220127         'ACA'                                  + csv +
005100220127         'PLAN'                                 + csv +
005200220127         'CARRIER'                              + csv +
005300220127         'USER'                                 + csv +
005400220127         ' '                                    +
005500220127    *    '"';
005600140114    * *
005700140114     C                   EXCEPT    OUTFA
005800140114   X* *
005900140109     C     wkkey         setll     rp13wkp                            21
006000140109     C                   dou       *in21 = '1'
006100110419      *
006200140109     C     wkkey         reade     rp13wkp                                21
006300220127
006400140109     C                   if        *in21 = '0'
006500220127
006600220127      *
006700220127      * get user name
006800220127      *
006900220127        clear unameout;
007000220127        chain rwuser gbsecure;
007100220127        if %found(gbsecure);
007200230717        if %trim(scname) <> *blanks;
007300230717         unameout = %trim(scname);
007400230717        else;
007500230717         unameout = %trim(rwuser);
007600230717        endif;
007700220127        else;
007800220127         unameout = rwuser;
007900220127        endif;
008000220127
008100080313     C                   CLEAR                   @OUTPUT
008200220127
008300220127       @output   = '"' +
008400220127         %TRIM(rwpacc)                          + csv +
008500220127         %TRIM(rwacnm)                          + csv +
008600220127         %TRIM(rwssno)                          + csv +
008700220127         %TRIM(rwlnam)                          + csv +
008800220127         %TRIM(rwtrdt)                          + csv +
008900220127         %TRIM(rwtrtime)                        + csv +
009000220127         %TRIM(rwtran)                          + csv +
009100220127         %TRIM(rwtram)                          + csv +
009200220127         %TRIM(rwabal)                          + csv +
009300220127         %TRIM(rwefdt)                          + csv +
009400220127         %TRIM(rwrecd)                          + csv +
009500220127         %TRIM(rwck#n)                          + csv +
009600220127         %TRIM(rwck#2)                          + csv +
009700220127         %TRIM(rwacaf)                          + csv +
009800220127         %TRIM(rwpdescr)                        + csv +
009900220127         %TRIM(rwcarr)                          + csv +
010000220127         %TRIM(unameout)                        + csv +
010100220127         ' '                                    +
010200220127    *    '"';
010300220127     c                   EXCEPT    OUTFA
010400140109    * *
010500140109     C                   endif
010600140109    * *
010700140109     C                   enddo
010800140109     C                   eval      *inlr = '1'
010900140109     C                   return
011000060315    ***
011100140109     ORP13CSVP  EADD         OUTFA
011200060315     O                       @OUTPUT           2000
