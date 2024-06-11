0000031610050002  ******************************************************************
000027161005      *  RPA220    GROUP BENEFIT SERVICES SOFTWARE                     *
000028161005      *                                                                *
000030161005      *  Written by  - David Ketterman                                 *
000031161005      *  Date        - 09/30/16                                        *
000032161005      *                                                                *
000033170123      *  Create the Agencyware commission export file for AmWINS       *
000034170123      *                                                                *
000036161026      * 10/26/16 dlk - change premium date to be the effective date    *
000037161026      *                in rpa060wk (coverage effdt). Also change       *
000038161026      *                edit code on numeric fields from L to P so      *
000039161026      *                the negative sign is on the left like excel     *
000040161026      *                wants.                                          *
000041170123      * 01/23/17 dlk - change to use joined query file with carrier    *
000042170123      *                group code so EDT or Lincoln can be selected    *
000043170127      *                (Lincoln uses carrier group code AL, EDT uses   *
000044170127      *                carrier group code ED). Also, add xref for our  *
000045170127      *                carrier group code to the Agencyware carrier    *
000046170127      *                and product values needed in the output file.   *
000047190328      * 03/28/19 dlk - replace Lincoln with EVT (carrier group code ET)*
000048170127      *                                                                *
0000490503030013 F******************************************************************
000050050228      *
0001001701230005 Frpa220j   ip   e           k disk
000107161006     Fagency    IF   E           K DISK
000108161011     Fagency2   IF   E           K DISK
000109160930     Faccmst    IF   E           K DISK
000110160930     Fplnmst    IF   E           K DISK
000111161012     Fbrkrcom1  IF   E           K DISK
0001121610040017 Frpa220xl  o  a e             DISK
000117050303
0001181609300125 Dagentid          s             13
0001191609300125 Dmktrep           s             13
0001201609300125 Dpolicy           s             10
0001211609300125 Ddesc             s             50
0001221609300125 Dissudtmdy        s              8  0
0001231609300125 Dpremdtmdy        s              8  0
0001241610110125 Dtxtpop           c                   const('% of Premium')
0001251610110125 Dtxtff            c                   const('per Member')
0001261610110125 Dtxtpoc           c                   const('% of Commission')
0001281610110125 Dratechar         s             10
0001291610120125 Dsplitchar        s             10
0001301610120125 Dglobal_type      s              1
0001311701270125 Daw_prod_name     s             30
0001321701270125 Daw_carrier       s              3
0001571610110125 Dcsv              c                   const('","')
000158160930     D                 DS
000159160930     D  renmdy                 1      8  0
000160160930     D  renm                   1      2  0
000161160930     D  rend                   3      4  0
000162160930     D  reny                   5      8  0
000163160930     D                UDS
000164160930     D  LYEAR                  1      4  0
000165160930     D  LMONTH                 5      6  0
000166050228
000167170127      * get cross reference values for agencyware output
000168170127       exsr #AWxref;
000169161012      *
000170161006      * our agency's TIN = agent id
000171161012      * include all 9 digits of tin (format with edit code X)
000172161012      *
000173160930       clear agentid;
000174161006       chain rpccde agency;
000175161006       if %found(agency);
000176161006        agentid = %editc(agtxid:'X');
000177160930       endif;
000178160930
000179161012      *
000180161011      * get producer from agency2 file for Market rep
000181161012      *
000182160930       clear mktrep;
000183161011       chain rpccde agency2;
000184161011       if %found(agency2);
000185161011        mktrep = %trim(a2prod);
000186161003       endif;
000187160930
000188161012      *
000189161012      * policy # (keep all digits - edit code x)
000190170127      *
000191160930       clear policy;
000192170127       policy = %trim(aw_carrier) + %trim(%editc(rpacc:'X'));
000193160930
000194161012      *
000195160930      * premium date
000196161012      *
000197160930       clear premdtmdy;
000198161026       @datin = rpefdt;
000199160930       exsr #datym;
000200160930       premdtmdy = @datou;
000201160930
000202161011      *
000203161012      * description - they want to see it like "10% of premium"
000204161012      *
000205160930       clear desc;
000206161011       clear ratechar;
000207161012       clear splitchar;
000208161011
000209161012      * first remove trailing zeros from rate
000210161012      * then remove the decimal if it is the last character (whole number)
000211161012       if rpcmrt <> 0;
000212161012        ratechar = %trimr(%char(rpcmrt):'0');
000213161012        ratechar = %trimr(ratechar:'. ');
000214161012       endif;
000215161012
000216161012      * this was another way to remove the decimal point but I decided
000217161012      * not to use it
000218161011      * *note - %SCANRPL will appear as an error in SEU but it is valid.
000219161012      * ratechar = %scanrpl('.':'': ratechar);
000220161011
000221161012      * commission calculation methods (defined in RPA068)
000222161012      * O = Global % of prem
000223161012      * G = Global flat fee
000224161012      * F = Flat fee override
000225161012      * C = % of commission override
000226161012      * P = % of prem override
000227161012      *
000228161011       select;
000229161012      * % of premium
000230161012        when rpmthd = 'O' or rpmthd = 'P';
000231161011        eval desc = %trim(ratechar) + %trim(txtpop);
000232161011      * flat fee
000233161011        when rpmthd = 'G' or rpmthd = 'F';
000234161011        eval desc = %trim(ratechar) + %trim(txtff);
000235161011      * % of comm
000236161011        when rpmthd = 'C';
000237161012        exsr #chkglob;
000238161012         select;
000239161012          when global_type = 'P';                       // % of prem
000240161012          eval desc = %trim(ratechar) + %trim(txtpop);
000241161012          when global_type = 'F';                       // flat fee
000242161012          eval desc = %trim(ratechar) + %trim(txtff);
000243161012          other;                                 // error, show actual value
000244161012          eval desc = 'Rate = ' + %trim(ratechar);
000245161012         endsl;
000248161011       endsl;
000249161011
000250161012      * add split value and text if needed
000251161012      * first remove trailing zeros from split
000252161012      * then remove the decimal if it is the last character (whole number)
000253161012      * then add final text
000254161010       if rppspl <> 0;
000255161012        splitchar = %trimr(%char(rppspl):'0');
000256161012        splitchar = %trimr(splitchar:'. ');
000257161012        desc = %trim(desc) + ' ' + %trim(splitchar) +
000258161012               %trim(' % Split');
000259161010       endif;
000260161011
000261161012      *
000262161012      * issue date is our acount enrollment date
000263161012      *
000264160930       clear issudtmdy;
000265160930       chain (rptrst:rpsub:rpacc) accmst;
000266160930       if %found(accmst);
000267160930        @datin = enroll;
000268160930        exsr #datym;
000269160930        issudtmdy = @datou;
000270160930       endif;
000271160930
000272161012      *
000273160930      * renewal date from our plan master
000274161012      *
000275160930       clear renmdy;
000276160930       chain (rptrst:rpsub:rpplan) plnmst;
000277160930       if %found(plnmst);
000278160930        renm = prenew;
000279160930        rend = 01;
000280160930        if renm <= lmonth;
000281160930         reny = lyear + 1;
000282160930         else;
000283160930         reny = lyear;
000284160930        endif;
000285160930       endif;
000286160930
000287161005      * write detail row
000711161005       exsr writexldet;
000831050301
0008321610120164  *************************************************************
0008331610120164  * check global broker commission file to see if the % of comm
0008341610120164  * override rate shows the global % of prem or flat fee since
0008351610120164  * the % of comm override only shows the global rate and not
0008361610120164  * what kind of rate it is. The export file needs to know what
0008371610120164  * kind of rate it is to show in the description but we do not
0008381610120164  * store this in rpa060wk.
0008391610120164  *************************************************************
000840161012       begsr #chkglob;
000841161012
000842161012       clear global_type;
000843161012
000844161012       setll (rppcar:rpmaszcd) brkrcom1;
000845161012       dou %eof (brkrcom1);
000846161012       reade (rppcar:rpmaszcd) brkrcom1;
000847161012         if not %eof (brkrcom1) and
000848161012         (bcfromdt <> bctodate) and
000849161012         ((bcfromdt <= rpefdt and bctodate >= rpefdt)
000850161012           or (bcfromdt <= rpefdt and bctodate = 0));
000851161012          select;
000852161012          when rpcmrt = bcpop;
000855161012           global_type = 'P';   // % of prem
000856161012          when rpcmrt = bcamnt;
000857161012           global_type = 'F';   // flat fee
000858161012          other;
000859161012                                // no match?
000860161012          endsl;
000861161012         leave;
000864161012         endif;
000865161012       enddo;
000869161012
000870161012       endsr;
000871161012
000872170127      *************************************************************
000873170127      * cross reference values for agencyware output file         *
000874170127      * ** These carrier group codes MUST MATCH the OPNQRYF       *
000875170127      *    selection in RPA220CL **                               *
000876170127      *************************************************************
000877170127       begsr #awxref;
000878170127       clear aw_prod_name;
000879170127       clear aw_carrier;
000880170127
000881170127       select;
000882170127        when cgrpcd = 'ED';
000883170127        eval aw_prod_name = 'Employers Dental Trust';
000884170127        eval aw_carrier   = 'EDT';
000885190328        when cgrpcd = 'ET';
000886190328        eval aw_prod_name = 'Employers Vision Trust';
000887190328        eval aw_carrier   = 'EVT';
000888170127       endsl;
000889170127
000890170127       endsr;
000891170127
0008921609300103 C***************************************************
0008931609300104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0008941609300105 C***************************************************
0008951609300107 C*
0008961609300107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0008971609300107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0008981609300107 C*
0008991609300106 C     #DATYM        BEGSR
000900160930     C                   MOVE      @DATIN        @MD               4 0
000901160930     C                   MOVEL     @DATIN        @Y                4 0
000902160930     C                   MOVEL     @MD           @DATOU            8 0
000903160930     C                   MOVE      @Y            @DATOU
000904160930     C                   MOVE      *ZEROS        @DATIN            8 0
0009051609300120 C                   ENDSR
000906161005
0009341610050164  *************************************************************
0009361610050164  * Write Spreadsheet Detail                                  *
0009381610050164  *************************************************************
000940161005       begsr writexldet;
000941161005
000942161005       clear rpa220fld;
000961161005       rpa220fld  = '"' +
000962170127         %trim(aw_carrier)                      + csv +
000963170127         %trim(aw_prod_name)                    + csv +
000964161005         %trim(agentid)                         + csv +
000965161005         %trim(policy)                          + csv +
000966161005         %trim(rpanm)                           + csv +
000967161005         %trim(%editw(premdtmdy:'0  /  /    ')) + csv +
000968161005         'Monthly'                              + csv +
000969161026         %trim(%editc(rppprm:'P'))              + csv +
000970161005         %trim(desc)                            + csv +
000971161026         %trim(%editc(rppcom:'P'))              + csv +
000972161005         %trim(%editw(issudtmdy:'0  /  /    ')) + csv +
000973161005         %trim(mktrep)                          + csv +
000974161026         %trim(%editc(rpmcnt:'P'))              + csv +
000975161005         %trim(%editw(renmdy:'0  /  /    '))    +
000976161005         '"';
000977161005
000978161005       Write rpa220xr;
0009791610050320   endsr;
000980161005
000982161005      *************************************************************
000983161005      * Write Spreadsheet heading                                 *
000984161005      *************************************************************
000985161005       begsr Writexlhead;
000986050304
000987161005       clear rpa220fld;
000988161005       rpa220fld = '"' +
000989161005         'CARRIER CODE'          + csv +
000990161005         'PRODUCT NAME'          + csv +
000991161005         'AGENT ID'              + csv +
000992161005         'POLICY NUMBER'         + csv +
000993161005         'GROUP NAME'            + csv +
000994161005         'PREMIUM DATE'          + csv +
000995161005         'MODE'                  + csv +
000996161005         'PREMIUM'               + csv +
000997161005         'DESCRIPTION'           + csv +
000998161005         'COMMISSION AMT'        + csv +
000999161005         'ISSUE DATE'            + csv +
001000161005         'MARKETREP'             + csv +
001001161005         'LIVES'                 + csv +
001002161005         'RENEWAL DATE'          +
001003161005         '"';
001004161005
001005161005       Write rpa220xr;
0010071610050320   endsr;
001008161005
001012161005      *************************************************************
001013161005      * First cycle                                               *
001014161005      *************************************************************
001015161005       begsr *inzsr;
001016161005       Exsr Writexlhead;
001017161005       endsr;
