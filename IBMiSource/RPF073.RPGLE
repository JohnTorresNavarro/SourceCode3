0001002106160002  ******************************************************************
0002002106160003  * RPF073     Amwins Connect Administrators                       *
0003002106160004  *                                                                *
0004002106160005  *            WRITTEN BY - DAVID KETTERMAN                        *
0005002106160006  *            DATE - 06/17/21                                     *
0006002106160007  *                                                                *
0007002106160011  *                                                                *
0008002106160011  *  Read the file of urgent letters produced (history records)    *
0009002106160011  *  that was created in qtemp from the query that runs before     *
0010002106160011  *  this and write an output csv file that will be sent back to   *
0011002106160011  *  the user with efile.                                          *
0012002106160011  *                                                                *
0013002106160011  *  In order to compile this the QRPF070WK file needs to be       *
0014002106160011  *  created in a lib available to the compile. It is also needed  *
0015002106170011  *  for testing. I use a copy of the production query that is     *
0016002106170011  *  run in RPF070CL (QRYRPF070D in lib QUERYS) named              *
0017002106170011  *  QRYRPF070K that creates the file in my lib to accomplish      *
0018002106160011  *  compile and testing.                                          *
0019002106160011  *                                                                *
0020002106160011  *                                                                *
002100210616   /* *  ******************************************************        *
002200210617   /* *  *  NOTE - ANY CHANGE TO QRPF070WK THAT IS CREATED IN *        *
002300210617   /* *  *         THE QUERY REQUIRES A RECOMPILE OF THIS     *        *
002400210617   /* *  *         PROGRAM.                                   *        *
002500210616   /* *  ******************************************************        *
0026002106160011  *                                                                *
0027002106160011  *                                                                *
0028002106160013  ******************************************************************
002900050228      *
0030002106160005 Fqrpf070wk ip   e           k disk    rename(qrpf070wk:qrpf070wkr)
0031002106160017 Frpf073xl  o  a e             DISK
003200050303
0033002106160125 Dtrdatemdy        s              8  0
0034002106160125 Dbalnum           s             12  2
0035001609300125 Dcsv              c                   const('","')
003600210616
003700210616     D                 DS
003800210616     D  tsa                    1     10  0
003900210616     D  HSTRST                 1      3  0
004000210616     D  HSSUB#                 4      6  0
004100210616     D  HSACCT                 7     10  0
004200050228
004300210616      * transaction date as mdy
004400210616       clear trdatemdy;
004500210616       @datin = trdate;
004600210616       exsr #datym;
004700210616       trdatemdy = @datou;
004800160930
004900210616      * change balance due character field to numeric
005000210616       balnum = %dec((due) : 12 : 2);
005100210616
005200050304     C                   exsr      writexldet
005300050301
0054001609300103 C***************************************************
0055001609300104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0056001609300105 C***************************************************
0057001609300107 C*
0058001609300107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0059001609300107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0060001609300107 C*
0061001609300106 C     #DATYM        BEGSR
006200160930     C                   MOVE      @DATIN        @MD               4 0
006300160930     C                   MOVEL     @DATIN        @Y                4 0
006400160930     C                   MOVEL     @MD           @DATOU            8 0
006500160930     C                   MOVE      @Y            @DATOU
006600160930     C                   MOVE      *ZEROS        @DATIN            8 0
0067001609300120 C                   ENDSR
006800160930     C*
0069000503040164 C*************************************************************
0070000503040164 C* Write Spreadsheet Detail                                  *
0071000503040164 C*************************************************************
007200050304     C     Writexldet    BEGSR
007300050304
007400210616     c                   clear                   rpf073fld
007500210616     C                   Eval      rpf073fld = '"' +
007600210616     C                             aacode                               + csv +
007700210616     C                             %trim(alnam)                         + csv +
007800210616     C                             %trim(%editc(balnum:'N'))            + csv +
007900210616     C                             %editw(tsa:'0   -   -    ')          + csv +
008000210616     C                             %trim(acnam1)                        + csv +
008100210616     C                             %trim(ck#not)                        + csv +
008200210616     C                             %editw(trdatemdy:'0  /  /    ')      + csv +
008300160930     C                             '",'
008400050304     C*
008500210616     C                   Write     rpf073xr
0086000503040320 C                   ENDSR
008700050304     C*
008800050304     C/EJECT
008900050304     C*************************************************************
009000050304     C* Write Spreadsheet heading                                 *
009100050304     C*************************************************************
009200050304     C     Writexlhead   BEGSR
009300050304
009400210616     c                   clear                   rpf073fld
009500210616     C                   Eval      rpf073fld = '"' +
009600210616     C                             'AA Code'               + csv +
009700210616     C                             'AA Last Name'          + csv +
009800210616     C                             'Outstanding Balance'   + csv +
009900210616     C                             'Account #'             + csv +
010000210616     C                             'Account Name'          + csv +
010100210616     C                             'What Letter'           + csv +
010200210616     C                             'Run Date'              + csv +
010300160930     C                              '",'
010400210616     C                   Write     rpf073xr
010500050304     C*
0106000503040320 C                   ENDSR
010700050302      *******************************************
010800011126     c     *inzsr        begsr
010900050302      *******************************************
011000050304     C                   Exsr      Writexlhead
011100011126     c                   endsr
