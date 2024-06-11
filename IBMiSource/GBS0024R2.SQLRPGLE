000100210803
000200210803       Ctl-opt option(*nodebugio:*srcstmt:*nounref : *NoShowCpy)
000300210803       DftActGrp(*no);
000400210803
000500160428      *-------------------------------------------------------------------------
000600160428      *
000700210803      *  Description: Load Member Extension File.
000800160428      *  Programmer.: Brian Rees
000900210803      *  Date.......: 8/03/2021
001000170313      *
001100170925      *  Notes: The idea of this program is that it would be called from
001200170925      *         many separate programs.  The input parameter is a Data Structure
001300210803      *         defined by MEMEXTP.  If a record exists, we will update the
001400170925      *         F.HIST record and update file file.  Otherwise, we will write
001500210803      *         a new MEMEXTP file.
001600170925      *
001700160428      *-------------------------------------------------------------------------
001800160428      * Modifications
001900160428      *
002000170427      * Date         Programmer    Mod      Description
002100160428      *-------------------------------------------------------------------------
002200220311      * 3/11/2022    B.Rees                 Added 2 new fields
002300220311      *                                     MEEMPTRDT, MEQUALEVDT
002400220311      *
002500160428      *-------------------------------------------------------------------------
002600210803       Dcl-f Hist keyed ExtDesc('F.HIST') ExtFile(*extdesc)
002700210803         usage(*output);
002800210803
002900210803       dcl-f Memextp keyed usage( *Update : *output ) ;
003000210803       Dcl-f Member keyed ExtDesc('F.MEMBER') ExtFile(*extdesc);
003100210803
003200210803
003300210803      *-------------------------------------------------------------------------
003400210803      *
003500210803      * Global Variables
003600210803      *
003700210803      *-------------------------------------------------------------------------
003800210810       dcl-ds pgmd
003900210810         ExtName('IOPGMD') PSDS;
004000210810         @pgmq *proc;
004100210803       end-ds;
004200210803
004300210803
004400210803       dcl-ds Input_data ExtName('MEMEXTP')
004500210803         prefix(i_)
004600210803       End-Ds;
004700170315
004800210803       dcl-s today Zoned(8);
004900210803       dcl-s DataChanged Char(1);
005000210803
005100210803      *-------------------------------------------------------------------------
005200210803      *
005300210803      * *Entry Procedure
005400210803      *
005500210803      *-------------------------------------------------------------------------
005600210803       Dcl-pr Main ExtPgm;
005700220311         *N  Char(466);
005800210810       End-Pr;
005900210803
006000210803       dcl-pi Main;
006100220311         pinput_data char(466);
006200210803       End-Pi;
006300210803
006400210803
006500210803
006600210803      *-------------------------------------------------------------------------
006700210803      *
006800210803      * Main Program
006900210803      *
007000210803      *-------------------------------------------------------------------------
007100210803       Input_data = pInput_Data;
007200170926
007300210803       // Check to see if the passed in SSN is in the system...
007400210803       chain i_messno MemExtp;
007500170922
007600170922
007700210803       // If the Data wasn't found, Add to F.Depend
007800210803       if not %found( MemExtp );
007900210810         Write_NewRcd();
008000210803       endif;
008100170922
008200170922
008300210803       // If the account was found; check to see if any
008400210803       // data needs to be changed.
008500210810       Check_DataChange();
008600171024
008700171024
008800210810       // If a record was found, only update what was changed..
008900210803       if %found( MemExtp ) and dataChanged = 'Y';
009000210810         Update_Hst();
009100210803         Update_Rcd();
009200210810       endif;
009300170922
009400171020
009500210810       *inlr = *on;
009600170922
009700170922       //----------------------------------------------------------------
009800210803       //  Write New F.Depend Record.
009900170922       //----------------------------------------------------------------
010000210803       dcl-proc  Write_NewRcd;
010100170922
010200210803
010300210810         messno = i_messno;
010400210803
010500210803         meocc    =  i_meocc;
010600210803         memgs    =  i_memgs ;
010700210803         merace   =  i_merace ;
010800210803         mesmoke  =  i_mesmoke;
010900210803         meempnbr =  i_meempnbr;
011000210803         mediv    =  i_mediv ;
011100210803         medept   =  i_medept;
011200210803         meloc    =  i_meloc ;
011300210803         meljc    =  i_meljc ;
011400210803         meclock  =  i_meclock;
011500210803         meclass  =  i_meclass ;
011600210803         merule   =  i_merule ;
011700210803         meruleff   =  i_meruleff;
011800210803         merulchgd  =  i_merulchgd;
011900210803         merulchgu  =  i_merulchgu;
012000210803         meeeo   =  i_meeeo ;
012100210803         mepfq   =  i_mepfq ;
012200210803         mehrs   =  i_mehrs ;
012300210803         merat   =  i_merat ;
012400210803         means   =  i_means ;
012500210803         mesaldt   =  i_mesaldt ;
012600210803         mebonus   =  i_mebonus ;
012700210803         mecstctr  =  i_mecstctr ;
012800210803         meccefdt    =  i_meccefdt ;
012900210803         meretire    =  i_meretire ;
013000210803         mecobeffdt  =  i_mecobeffdt ;
013100210803         mecobtrmdt  =  i_mecobtrmdt ;
013200210803         mecobcarnm  =  i_mecobcarnm ;
013300210803         mesmkeffdt  =  i_mesmkeffdt ;
013400210803         mecommsal   =  i_mecommsal ;
013500220311         meEmpTrdt   =  i_meEmpTrdt;
013600220311         meQualEvdt  =  i_meQualEvdt;
013700220311
013800220311
013900210803         Write r_Memextp;
014000170922
014100170925
014200210810       // Write History Record
014300210810       // ----------------------
014400210803       //  Not writing a history record here.
014500210803       //  The history record was added in GBS0024R
014600210803       //
014700170922
014800170922
014900210803       end-proc ;
015000170922
015100170427       //----------------------------------------------------------------
015200170922       //
015300210803       //  Write to the History File.
015400170922       //
015500170427       //----------------------------------------------------------------
015600210803       dcl-proc  Update_Hst;
015700170925
015800210810         chain i_messno Member;
015900170925
016000210810         // Setup Defaults
016100210803         hkey = ' ' + %editc(i_messno  : 'X') ;
016200210803         hPrgnm = 'GBS0024R2';
016300201206         trDate = %Dec(%Date);
016400201206         hsTrst = mbtrst;
016500201206         hsSub# = mbSub#;
016600201206         hsAcct = mbAcct;
016700201206         hsDltd = 'A';
016800201206         hstrTime = %Time;
016900201206         hOper =  'AUTOGEN';
017000201206         covtdt = %Dec(%Date);
017100170427
017200170427
017300210803         // Job Title
017400220311         if MEOCC  <> i_MEOCC and i_meocc > '';
017500210810           trCode = 'MAS';
017600210810           ck#Not = MEOCC;
017700210810           note2 = i_MEOCC;
017800210803           write histr;
017900210810         EndIf;
018000210803
018100201221
018200210810         // Marital Status
018300220311         if meMgs <> i_meMgs and i_meMgs > '';
018400210810           trCode = 'M86';
018500210810           ck#Not = meMgs;
018600210810           note2 = i_meMgs;
018700210803           write histr;
018800210810         EndIf;
018900210803
019000210803
019100210810         // Smoker
019200220311         if MESMOKE <> i_MESMOKE and i_meSmoke > '';
019300210803           trCode = 'MSF';
019400210810           ck#Not = MESMOKE;
019500210810           note2 = i_MESMOKE;
019600210810           write histr;
019700210810         EndIf;
019800210803
019900210803
020000210810         // Race
020100220311         if MERace <> i_MERace and i_meRace > '';
020200210803           trCode = 'M90';
020300210810           ck#Not = meRace;
020400210810           note2 = i_MERace;
020500210810           write histr;
020600210810         EndIf;
020700210803
020800210803
020900210810         // Employee Number
021000220311         if MEEMPNBR <> i_MEEMPNBR and i_meEmpNbr > '';
021100210803           trCode = 'MAP';
021200210810           ck#Not = MEEMPNBR;
021300210810           note2 = i_MEEMPNBR;
021400210803           write histr;
021500210810         EndIf;
021600210803
021700210803
021800210810         // Division
021900220311         if MEDIV <> i_MEDIV and i_meDiv > '';
022000210810           trCode = 'MAT';
022100210810           ck#Not = MEDIV;
022200210810           note2 = i_MEDIV;
022300210810           write histr;
022400210810         EndIf;
022500210803
022600210803
022700210810         // Department
022800220311         if MEDEPT <> i_MEDEPT and i_meDept > '';
022900210803           trCode = 'M89';
023000210810           ck#Not = MEDEPT;
023100210810           note2 = i_MEDEPT;
023200210810           write histr;
023300210810         EndIf;
023400210803
023500210803
023600210810         // Location
023700220311         if MELOC  <> i_MELOC and i_meLoc > '';
023800210803           trCode = 'MAQ';
023900210810           ck#Not = MELOC ;
024000210810           note2 = i_MELOC ;
024100210810           write histr;
024200210810         EndIf;
024300210803
024400210803
024500210810         // Labor/ Job Code
024600220311         if MELJC <> i_MELJC and i_meljc > '';
024700210803           trCode = 'M87';
024800210810           ck#Not = MELJC;
024900210810           note2 = i_MELJC;
025000210810           write histr;
025100210810         EndIf;
025200210803
025300210810         // Clock Number
025400210810         // Employee Class
025500210803
025600210803
025700210810         // Rule
025800220311         if MERULE <> i_MERULE and i_meRule > '';
025900210810           trCode = 'M88';
026000210810           ck#Not = MERULE;
026100210803           note2 = i_MERULE;
026200210803           write histr;
026300210810         EndIf;
026400210803
026500210803
026600210810         // Rule Change Date
026700220311         if MERULEFF <> i_MERULEFF and i_meRulEff > 0;
026800210810           trCode = 'MAR';
026900210810           ck#Not = %Char(MERULEFF);
027000210803           note2 = %char(i_MERULEFF);
027100210803           write histr;
027200210810         EndIf;
027300210803
027400210803
027500210810         // Rule Change Date
027600210803         // Rule Change By
027700210803
027800210803
027900210803         // EEO Code
028000220311         if MEEEO <> i_MEEEO and i_meeeo > '';
028100210803           trCode = 'MAJ';
028200210803           ck#Not = MEEEO;
028300210803           note2 = i_MEEEO;
028400210810           write histr;
028500210803         EndIf;
028600210803
028700210803
028800210803         // Pay Frequently
028900210803
029000210803
029100210810         // Hours
029200220311         if MEHRS <> i_MEHRS and i_meHrs > 0;
029300210803           trCode = 'MAL';
029400210803           ck#Not = %char(MEHRS);
029500210810           note2 = %Char(i_MEHRS);
029600210810           write histr;
029700210803         EndIf;
029800210803
029900210803
030000210810         // Smoker Effective Date
030100220311         if MESMKEFFDT  <> I_MESMKEFFDT and i_meSmkEffDt > 0;
030200210803           trCode = 'MSD';
030300210810           ck#Not = %Char(MESMKEFFDT) ;
030400210810           note2 = %Char(i_MESMKEFFDT) ;
030500210810           write histr;
030600210810         EndIf;
030700210803
030800210803
030900210810         // Commission / Salary
031000220311         if MECOMMSAL <> i_MECOMMSAL and i_meCommSal > '';
031100210810           trCode = 'MAU';
031200210810           ck#Not = MECOMMSAL;
031300210810           note2 = i_MECOMMSAL;
031400210810           write histr;
031500210803         EndIf;
031600210803
031700220311         if meEmpTrdt <> i_meEmpTrdt and i_meEmpTrdt > 0;
031800220311           trCode = 'M78';
031900220311           ck#Not = %Char(meEmpTrdt);
032000220311           note2 = %Char(i_meEmpTrdt);
032100220311           write histr;
032200220311         EndIf;
032300220311
032400220311
032500220311         if meQualEvdt <> i_meQualEvdt and i_meQualEvdt > 0;
032600220311           trCode = 'M79';
032700220311           ck#Not = %Char(meQualEvdt);
032800220311           note2 = %Char(i_meQualEvdt);
032900220311           write histr;
033000220311         EndIf;
033100220311
033200170925
033300210810       end-proc ;
033400170427
033500170925
033600210810       //----------------------------------------------------------------
033700210810       //
033800210810       //  Update Member Record.
033900170925       //
034000170925       //----------------------------------------------------------------
034100210803       dcl-proc  Update_Rcd;
034200170925
034300170925
034400210810         // Job Title
034500210810         if i_meocc > *blanks;
034600210810           meocc = i_meocc;
034700210810         EndIf;
034800170925
034900210803
035000210810         // Marriage Status
035100210803         if i_memgs > *blanks;
035200210810           memgs = i_memgs;
035300210803         EndIf;
035400210803
035500210803         // Race
035600210810         if i_merace > *blanks;
035700210803           merace = i_merace;
035800210803         EndIf;
035900210803
036000210810         // Smoker
036100210810         if i_mesmoke > *blanks;
036200210810           mesmoke = i_mesmoke;
036300210810         EndIf;
036400210803
036500210810         // Employee Number
036600210810         if i_meempnbr > *blanks;
036700210810           meempnbr = i_meempnbr;
036800210810         EndIf;
036900210803
037000170925
037100210803
037200210810         //  Division
037300210810         if i_mediv > *blanks;
037400210810           mediv = i_mediv;
037500210810         EndIf;
037600210803
037700210803
037800210810         // Department
037900210810         if i_medept > *blanks;
038000210810           medept = i_medept;
038100210810         EndIf;
038200210803
038300210803
038400210810         //  Location
038500210810         if i_meloc > *blanks;
038600210810           meloc = i_meloc;
038700210810         EndIf;
038800210803
038900210803
039000210810         // Labor Job Code
039100210810         if i_meljc > *blanks;
039200210810           meljc = i_meljc;
039300210810         EndIf;
039400210803
039500210803
039600210810         // Clock
039700210810         if i_meclock > *blanks;
039800210810           meclock = i_meclock;
039900210810         EndIf;
040000210803
040100210803
040200210810         // Class
040300210810         if i_meclass > *blanks;
040400210810           meclass = i_meclass;
040500210810         EndIf;
040600210803
040700210810         // Rule
040800210810         if i_merule > *blanks;
040900210810           merule = i_merule;
041000210810         EndIf;
041100210803
041200210810         // Rule Effective Date
041300210810         if i_meruleff > 0;
041400210810           meruleff = i_meruleff;
041500210810         EndIf;
041600210803
041700210810         // eeo
041800210810         if i_meeeo > *blanks;
041900210810           meeeo = i_meeeo;
042000210810         EndIf;
042100210803
042200210810         // Pay Frequently
042300210810         if i_mepfq > *blanks;
042400210810           mepfq = i_mepfq;
042500210810         EndIf;
042600210803
042700210803
042800210810         //  Hours
042900210810         if i_mehrs > 0;
043000210810           mehrs = i_mehrs;
043100210810         EndIf;
043200210803
043300210803
043400210810         // Salary
043500210810         if i_means > 0;
043600210810           means = i_means;
043700210810         EndIf;
043800210803
043900210810         // Salary Change Date
044000210810         if i_mesaldt > 0;
044100210810           mesaldt = i_mesaldt;
044200210810         EndIf;
044300210803
044400210810         // Smoker Effective Date
044500210810         if i_mesmkeffdt > 0;
044600210810           mesmkeffdt = i_mesmkeffdt;
044700210810         EndIf;
044800210803
044900210810         // CommSal
045000220311         if i_mecommsal > '';
045100210810           mecommsal = i_mecommsal;
045200210810         EndIf;
045300210803
045400220311         // Qualified Event Date
045500220311         if i_meQualEvdt > 0;
045600220311           meQualEvdt = i_meQualEvdt;
045700220311         EndIf;
045800220311
045900220311         // Employee Term Date
046000220311         if i_meEmpTrdt > 0;
046100220311           meEmpTrdt = i_meEmpTrdt;
046200220311         EndIf;
046300220311
046400210810         update r_MemExtp;
046500170925
046600210803       end-proc ;
046700170925
046800171024
046900171024       //----------------------------------------------------------------
047000171024       //
047100210803       //  Check to see if any data needs to be modified.
047200171024       //
047300171024       //----------------------------------------------------------------
047400210803       dcl-proc  Check_DataChange;
047500171024
047600210810         DataChanged = 'N';
047700171024
047800210810         // Job Title
047900210810         if i_meocc > *blanks and i_meocc <> meocc;
048000210810           DataChanged = 'Y';
048100210810         EndIf;
048200210803
048300210803
048400210810         // Marriage Status
048500210810         if i_memgs > *blanks and memgs <> i_memgs;
048600210810           DataChanged = 'Y';
048700210810         EndIf;
048800210803
048900210810         // Race
049000210810         if i_merace > *blanks and merace <> i_merace;
049100210810           DataChanged = 'Y';
049200210810         EndIf;
049300210803
049400210810         // Smoker
049500210810         if i_mesmoke > *blanks and
049600210810         mesmoke <> i_mesmoke;
049700210810           DataChanged = 'Y';
049800210803
049900210810         EndIf;
050000210803
050100210810         // Employee Number
050200210810         if i_meempnbr > *blanks and
050300210810         meempnbr <> i_meempnbr;
050400210810           DataChanged = 'Y';
050500210810         EndIf;
050600210803
050700210803
050800210810         //  Division
050900210810         if i_mediv > *blanks and
051000210810         mediv <> i_mediv;
051100210810           DataChanged = 'Y';
051200210810         EndIf;
051300210803
051400210803
051500210810         // Department
051600210810         if i_medept > *blanks and
051700210810         medept <> i_medept;
051800210810           DataChanged = 'Y';
051900210810         EndIf;
052000210803
052100210803
052200210810         //  Location
052300210810         if i_meloc > *blanks and
052400210810         meloc <> i_meloc;
052500210810           DataChanged = 'Y';
052600210810         EndIf;
052700210803
052800210803
052900210810         // Labor Job Code
053000210810         if i_meljc > *blanks and
053100210810         meljc <> i_meljc;
053200210810           DataChanged = 'Y';
053300210810         EndIf;
053400210803
053500210803
053600210810         // Clock
053700210810         if i_meclock > *blanks and
053800210810         meclock <> i_meclock;
053900210810           DataChanged = 'Y';
054000210810         EndIf;
054100210803
054200210803
054300210810         // Class
054400210810         if i_meclass > *blanks and
054500210810         meclass <> i_meclass;
054600210810           DataChanged = 'Y';
054700210810         EndIf;
054800210803
054900210810         // Rule
055000210810         if i_merule > *blanks and
055100210810         merule <> i_merule;
055200210810           DataChanged = 'Y';
055300210810         EndIf;
055400210803
055500210810         // Rule Effective Date
055600210810         if i_meruleff > 0 and
055700210810         meruleff <> i_meruleff;
055800210810           DataChanged = 'Y';
055900210810         EndIf;
056000210803
056100210810         // eeo
056200210810         if i_meeeo > *blanks and
056300210810         meeeo <> i_meeeo;
056400210810           DataChanged = 'Y';
056500210810         EndIf;
056600210803
056700210810         // Pay Frequently
056800210810         if i_mepfq > *blanks and
056900210810         mepfq <> i_mepfq;
057000210810           DataChanged = 'Y';
057100210810         EndIf;
057200210803
057300210803
057400210810         //  Hours
057500210810         if i_mehrs > 0 and
057600210810         mehrs <> i_mehrs;
057700210810           DataChanged = 'Y';
057800210810         EndIf;
057900210803
058000210803
058100210810         // Salary
058200210810         if i_means > 0 and
058300210810         means <> i_means;
058400210810           DataChanged = 'Y';
058500210810         EndIf;
058600210803
058700210810         // Salary Change Date
058800210810         if i_mesaldt > 0 and
058900210810         mesaldt <> i_mesaldt;
059000210810           DataChanged = 'Y';
059100210810         EndIf;
059200210803
059300210810         // Smoker Effective Date
059400210810         if i_mesmkeffdt > 0 and
059500210810         mesmkeffdt <> i_mesmkeffdt;
059600210810           DataChanged = 'Y';
059700210810         EndIf;
059800210803
059900210810         // CommSal
060000210810         if i_mecommsal > *blanks and
060100210810         mecommsal <> i_mecommsal;
060200210810           DataChanged = 'Y';
060300210810         EndIf;
060400210803
060500220311
060600220311         // Employee Term Date
060700220311         if i_meEmpTrdt > 0 and
060800220311         meEmpTrdt <> i_meEmpTrdt;
060900220311           DataChanged = 'Y';
061000220311         EndIf;
061100220311
061200220311
061300220311         // Qualified Event Date
061400220311         if i_meEmpTrdt > 0 and
061500220311         meQualEvdt <> i_meQualEvdt;
061600220311           DataChanged = 'Y';
061700220311         EndIf;
061800220311
061900210803
062000210803
062100210803       end-proc ;
062200171024
