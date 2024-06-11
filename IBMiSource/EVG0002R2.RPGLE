000100150226     H option(*noDebugIo)
000200150226      *-------------------------------------------------------------------------
000300150226      *
000400151015      *  Description: Evergreen 834 Export. Create Incremential File.
000500151015      *  Programmer.: John Torres (cloned from Brian Rees - GBS0002R1)
000600151015      *  Date.......: 9/01/2015
000700150226      *
000800151015      *  Overview...: Evergreen had requested that we would send a incremential file
000900150812      *    instead of a full file.  A new database was setup to hold the sent
001000150812      *    records.
001100150812      *
001200150812      *
001300150226      *-------------------------------------------------------------------------
001400150807      * Modifications
001500150807      *
001600150807      * Date         Programmer    Mod      Description
001700150807      *-------------------------------------------------------------------------
001800150812      *
001900150812      *
002000150807      *-------------------------------------------------------------------------
002100151020     Fevrgrenxpnuf a e           k disk    rename(evgxptf:actualFile)
002200151020     Fevrgrenxphuf a e           k disk    rename(evgxpth:holdFile)
002300151020     Fevrgrenxpluf a e           k disk    rename(evgxpts:sendFile)
002400151020     F                                     prefix(sn)
002500150226      *-------------------------------------------------------------------------
002600151112
002700151020       setll *loval holdFile;
002800151020       read holdFile;
002900151015
003000151020       dow not %eof;
003100150812
003200151020       chain (evgrpseq) actualFile;
003300151020        if %Found;
003400151020         exsr writeRecord;
003500151020        endif;
003600151015
003700151020         read holdFile;
003800150812         enddo;
003900150812
004000150812         *inlr = *on;
004100150812
004200150812         //-------------------------------------------------------
004300151020
004400151020         Begsr WriteRecord;
004500151020
004600151020         setll (EVSUBSCR) sendFile;
004700151020         reade (EVSUBSCR) sendFile;
004800151020
004900151020         dow not %eof;
005000150812
005100151111         if snEVGRPSEQ <> EVGRPSEQ and
005200151111            snEVTRNCODE <> '021'      ;
005300151111
005400151111            EVGRPSEQ  = snEVGRPSEQ ;
005500151020            EVACCNAME = snEVACCNAME;
005600151020            EVTAXID   = snEVTAXID  ;
005700151020            EVGRPNBR  = snEVGRPNBR ;
005800151020            EVMBRDEP  = snEVMBRDEP ;
005900151020            EVRELCODE = snEVRELCODE;
006000151020            EVMEDIND  = snEVMEDIND ;
006100151020            EVEMPSTS  = snEVEMPSTS ;
006200151020            EVSTUD    = snEVSTUD   ;
006300151020            EVHNDCP   = snEVHNDCP  ;
006400151020            EVSSNMBR  = snEVSSNMBR ;
006500151020            EVSSNDEP  = snEVSSNDEP ;
006600151020            EVHIRE    = snEVHIRE   ;
006700151020            EVENRL    = snEVENRL   ;
006800151020            EVTERM    = snEVTERM   ;
006900151020            EVLNAM    = snEVLNAM   ;
007000151020            EVFNAM    = snEVFNAM   ;
007100151020            EVMNAM    = snEVMNAM   ;
007200151020            EVSUBSCR  = snEVSUBSCR ;
007300151020            EVPHONE   = snEVPHONE  ;
007400151020            EVEMAIL   = snEVEMAIL  ;
007500151020            EVADDR1   = snEVADDR1  ;
007600151020            EVADDR2   = snEVADDR2  ;
007700151020            EVCITY    = snEVCITY   ;
007800151020            EVSTATE   = snEVSTATE  ;
007900151020            EVZIP     = snEVZIP    ;
008000151020            EVDOB     = snEVDOB    ;
008100151020            EVGENDR   = snEVGENDR  ;
008200151020            EVSALRY   = snEVSALRY  ;
008300151020            EVSMOKE   = snEVSMOKE  ;
008400151020            EVPRDCT   = snEVPRDCT  ;
008500151020            EVCOVLVL  = snEVCOVLVL ;
008600151020            EVCOVEFF  = snEVCOVEFF ;
008700151020            EVCOVEND  = snEVCOVEND ;
008800151020            EVDIVISN  = snEVDIVISN ;
008900151020            EVPLANCD  = snEVPLANCD ;
009000151020            EVCOMPST  = snEVCOMPST ;
009100151020            EVTRNCODE = '030'      ;
009200151020            EVREASONCD = ' '       ;
009300151112            evtdate =  %char(%dec(%date: *iso));
009400151020
009500151111            write actualFile;
009600151020
009700151020          endif;
009800150812
009900151020         reade (EVSUBSCR) sendFile;
010000151020         enddo;
010100151020
010200150812         Endsr;
010300151020
