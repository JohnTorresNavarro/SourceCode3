000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Write flags to DBEDTL834 at end of process
000400000000      *
000500000000      *  (c)Copyright 2010 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - April 21, 2010
000800000000      *_________________________________________________________________________
000900100421     FDBEDTL834 UP   E             DISK
001000121107     FDBEDTL834DO  a E             DISK
001100100421     FDW311FLGLFUF   E           K DISK
001200100604     FDW311FLGLHUF   E           K DISK
001300120223     FDW311FLGD IF   E           K DISK
001400120223     FPLNMST    IF   E           K DISK
001500131015     FMCOVC15   IF   E           K DISK
001600131015     FDCOVC     IF   E           K DISK
001700120223
001800131223     D W_COVT          s              2A   inz
001900131223     D W_SFAM          s              1A   inz
002000131223     D WCAT            s              3A   inz
002100120223     D W80DATE         s              8S 0 inz
002200120223
002300120223     D                 DS
002400120223     D TSACHAR                       10
002500120223     D W_T                            3S 0 OVERLAY(TSACHAR) inz
002600120223     D W_S                            3S 0 OVERLAY(TSACHAR:4) inz
002700120223     D W_A                            4S 0 OVERLAY(TSACHAR:7) inz
002800100421
002900000000      * Program status data structure
003000000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
003100000000      *
003200100421     C                   Move      D3SUB         DFSSN
003300100421     C                   Z-add     D3BIRSQ       DFSEQ
003400100421     C     FLGKEY        Chain     DW311FLGLF
003500100421     C                   If        %found(DW311FLGLF)
003600100421     C                   If        DFLG <> 'Y'
003700121023     C                   Exsr      CHKD3SCEF1
003800131223     C                   Eval      D3MNTYP = DFLG
003900131223     C                   Eval      W_COVT  = DTYPM
004000131223     C                   Exsr      CLEVEL
004100131223     C                   Eval      D3SFAM1 = W_SFAM
004200100421     C                   Eval      D3FIL41 = DFLGM
004300100611     C                   IF        D3FIL41 = *BLANKS
004400100611     C                   EVAL      D3SCAT1 = *BLANKS
004500100611     C                   EVAL      D3SCEF1 = *BLANKS
004600100611     C                   EVAL      D3SEVT1 = *BLANKS
004700100611     C                   EVAL      D3SFAM1 = *BLANKS
004800100611     C                   END
004900100421     C                   Eval      D3FIL42 = DFLGR
005000131223     C                   Eval      W_COVT  = DTYPR
005100131223     C                   Exsr      CLEVEL
005200131223     C                   Eval      D3SFAM2 = W_SFAM
005300100611     C                   IF        D3FIL42 = *BLANKS
005400100611     C                   EVAL      D3SCAT2 = *BLANKS
005500100611     C                   EVAL      D3SCEF2 = *BLANKS
005600100611     C                   EVAL      D3SEVT2 = *BLANKS
005700100611     C                   EVAL      D3SFAM2 = *BLANKS
005800100611     C                   END
005900100421     C                   Eval      D3FIL43 = DFLGD
006000131223     C                   Eval      W_COVT  = DTYPD
006100131223     C                   Exsr      CLEVEL
006200131223     C                   Eval      D3SFAM3 = W_SFAM
006300100611     C                   IF        D3FIL43 = *BLANKS
006400100611     C                   EVAL      D3SCAT3 = *BLANKS
006500100611     C                   EVAL      D3SCEF3 = *BLANKS
006600100611     C                   EVAL      D3SEVT3 = *BLANKS
006700100611     C                   EVAL      D3SFAM3 = *BLANKS
006800100611     C                   END
006900100421     C                   Eval      D3FIL44 = DFLGV
007000131223     C                   Eval      W_COVT  = DTYPV
007100131223     C                   Exsr      CLEVEL
007200131223     C                   Eval      D3SFAM4 = W_SFAM
007300100611     C                   IF        D3FIL44 = *BLANKS
007400100611     C                   EVAL      D3SCAT4 = *BLANKS
007500100611     C                   EVAL      D3SCEF4 = *BLANKS
007600100611     C                   EVAL      D3SEVT4 = *BLANKS
007700100611     C                   EVAL      D3SFAM4 = *BLANKS
007800100611     C                   END
007900130725
008000130725      * *******************************************************
008100130725      * Medical
008200130725     C                   IF        D3FIL41 = 'A'
008300130725     C                   Eval      WCAT = 'PMM'
008400130725     C                   Exsr      GETEFF
008500130725     C                   IF        W80DATE > 0
008600130725     C                   Movel     W80DATE       Input_Date
008700130725     C                   Eval      Input_Format  = 'YYYYMMDD'
008800130725     C                   Eval      Output_Format = 'MM/DD/YYYY'
008900130725     C                   Exsr      FormatDateSR
009000130725     C                   Eval      D3SCEF1       = %trim(Output_Date)
009100130725     C                   End
009200130725     C                   End
009300120223
009400130725      * RX
009500130725     C                   IF        D3FIL42 = 'A'
009600130725     C                   Eval      WCAT = 'PRX'
009700130725     C                   Exsr      GETEFF
009800130725     C                   IF        W80DATE > 0
009900130725     C                   Movel     W80DATE       Input_Date
010000130725     C                   Eval      Input_Format  = 'YYYYMMDD'
010100130725     C                   Eval      Output_Format = 'MM/DD/YYYY'
010200130725     C                   Exsr      FormatDateSR
010300130725     C                   Eval      D3SCEF2       = %trim(Output_Date)
010400130725     C                   End
010500130725     C                   End
010600130725
010700130725      * Dental
010800130725     C                   IF        D3FIL43 = 'A'
010900130725     C                   Eval      WCAT = 'PDR'
011000130725     C                   Exsr      GETEFF
011100130725     C                   IF        W80DATE = 0
011200130725     C                   Eval      WCAT = 'PDN'
011300130725     C                   Exsr      GETEFF
011400130725     C                   End
011500140917     C                   IF        W80DATE = 0
011600140917     C                   Eval      WCAT = 'PCD'
011700140917     C                   Exsr      GETEFF
011800140917     C                   End
011900130725     C                   IF        W80DATE = 0
012000130725     C                   Eval      WCAT = 'PDE'
012100130725     C                   Exsr      GETEFF
012200130725     C                   End
012300130725     C                   IF        W80DATE > 0
012400130725     C                   Movel     W80DATE       Input_Date
012500130725     C                   Eval      Input_Format  = 'YYYYMMDD'
012600130725     C                   Eval      Output_Format = 'MM/DD/YYYY'
012700130725     C                   Exsr      FormatDateSR
012800130725     C                   Eval      D3SCEF3       = %trim(Output_Date)
012900130725     C                   End
013000130725     C                   End
013100130725
013200130725      * Vision
013300130725     C                   IF        D3FIL44 = 'A'
013400130725     C                   Eval      WCAT = 'PVR'
013500130725     C                   Exsr      GETEFF
013600130725     C                   IF        W80DATE = 0
013700130725     C                   Eval      WCAT = 'PVS'
013800130725     C                   Exsr      GETEFF
013900130725     C                   End
014000130725     C                   IF        W80DATE = 0
014100130725     C                   Eval      WCAT = 'PCV'
014200130725     C                   Exsr      GETEFF
014300130725     C                   End
014400130725     C                   IF        W80DATE > 0
014500130725     C                   Movel     W80DATE       Input_Date
014600130725     C                   Eval      Input_Format  = 'YYYYMMDD'
014700130725     C                   Eval      Output_Format = 'MM/DD/YYYY'
014800130725     C                   Exsr      FormatDateSR
014900130725     C                   Eval      D3SCEF4       = %trim(Output_Date)
015000130725     C                   End
015100130725     C                   End
015200130725
015300130725      * *******************************************************
015400130725      * Medical
015500130725     C                   IF        D3FIL41 = 'C'
015600130725     C                   Eval      WCAT = 'PMM'
015700130725     C                   Exsr      GETEFF
015800130725     C                   IF        W80DATE > 0
015900130725     C                   Movel     W80DATE       Input_Date
016000130725     C                   Eval      Input_Format  = 'YYYYMMDD'
016100130725     C                   Eval      Output_Format = 'MM/DD/YYYY'
016200130725     C                   Exsr      FormatDateSR
016300130725     C                   Eval      D3SCEF1       = %trim(Output_Date)
016400130725     C                   End
016500130725     C                   End
016600130725
016700130725      * RX
016800130725     C                   IF        D3FIL42 = 'C'
016900130725     C                   Eval      WCAT = 'PRX'
017000130725     C                   Exsr      GETEFF
017100130725     C                   IF        W80DATE > 0
017200130725     C                   Movel     W80DATE       Input_Date
017300130725     C                   Eval      Input_Format  = 'YYYYMMDD'
017400130725     C                   Eval      Output_Format = 'MM/DD/YYYY'
017500130725     C                   Exsr      FormatDateSR
017600130725     C                   Eval      D3SCEF2       = %trim(Output_Date)
017700130725     C                   End
017800130725     C                   End
017900130725
018000130725      * Dental
018100130725     C                   IF        D3FIL43 = 'C'
018200130725     C                   Eval      WCAT = 'PDR'
018300130725     C                   Exsr      GETEFF
018400130725     C                   IF        W80DATE = 0
018500130725     C                   Eval      WCAT = 'PDN'
018600130725     C                   Exsr      GETEFF
018700130725     C                   End
018800140917     C                   IF        W80DATE = 0
018900140917     C                   Eval      WCAT = 'PCD'
019000140917     C                   Exsr      GETEFF
019100140917     C                   End
019200130725     C                   IF        W80DATE = 0
019300130725     C                   Eval      WCAT = 'PDE'
019400130725     C                   Exsr      GETEFF
019500130725     C                   End
019600130725     C                   IF        W80DATE > 0
019700130725     C                   Movel     W80DATE       Input_Date
019800130725     C                   Eval      Input_Format  = 'YYYYMMDD'
019900130725     C                   Eval      Output_Format = 'MM/DD/YYYY'
020000130725     C                   Exsr      FormatDateSR
020100130725     C                   Eval      D3SCEF3       = %trim(Output_Date)
020200130725     C                   End
020300130725     C                   End
020400130725
020500130725      * Vision
020600130725     C                   IF        D3FIL44 = 'C'
020700130725     C                   Eval      WCAT = 'PVR'
020800130725     C                   Exsr      GETEFF
020900130725     C                   IF        W80DATE = 0
021000130725     C                   Eval      WCAT = 'PVS'
021100130725     C                   Exsr      GETEFF
021200130725     C                   End
021300130725     C                   IF        W80DATE = 0
021400130725     C                   Eval      WCAT = 'PCV'
021500130725     C                   Exsr      GETEFF
021600130725     C                   End
021700130725     C                   IF        W80DATE > 0
021800130725     C                   Movel     W80DATE       Input_Date
021900130725     C                   Eval      Input_Format  = 'YYYYMMDD'
022000130725     C                   Eval      Output_Format = 'MM/DD/YYYY'
022100130725     C                   Exsr      FormatDateSR
022200130725     C                   Eval      D3SCEF4       = %trim(Output_Date)
022300130725     C                   End
022400130725     C                   End
022500130725
022600130725      * *******************************************************
022700120223      * Dental
022800120223     C                   IF        D3FIL43 = 'C' and
022900120223     C                             D3SEVT3 = 'TM'
023000120223     C                   Eval      D3SEVT3  =   'SL'
023100120223     C                   Eval      D3SCTR3  =   *Blanks
023200120223     C                   Eval      WCAT = 'PDR'
023300120223     C                   Exsr      GETEFF
023400120223     C                   IF        W80DATE = 0
023500120223     C                   Eval      WCAT = 'PDN'
023600120223     C                   Exsr      GETEFF
023700120223     C                   End
023800140917     C                   IF        W80DATE = 0
023900140917     C                   Eval      WCAT = 'PCD'
024000140917     C                   Exsr      GETEFF
024100140917     C                   End
024200130118     C                   IF        W80DATE = 0
024300130118     C                   Eval      WCAT = 'PDE'
024400130118     C                   Exsr      GETEFF
024500130118     C                   End
024600120223     C                   IF        W80DATE > 0
024700120223     C                   Movel     W80DATE       Input_Date
024800120223     C                   Eval      Input_Format  = 'YYYYMMDD'
024900120223     C                   Eval      Output_Format = 'MM/DD/YYYY'
025000120223     C                   Exsr      FormatDateSR
025100120223     C                   Eval      D3SCEF3       = %trim(Output_Date)
025200120223     C                   End
025300120223     C                   End
025400120223
025500120223      * Vision
025600120223     C                   IF        D3FIL44 = 'C' and
025700120223     C                             D3SEVT4 = 'TM'
025800120223     C                   Eval      D3SEVT4  =   'SL'
025900120223     C                   Eval      D3SCTR4  =   *Blanks
026000120223     C                   Eval      WCAT = 'PVR'
026100120223     C                   Exsr      GETEFF
026200120223     C                   IF        W80DATE = 0
026300120223     C                   Eval      WCAT = 'PVS'
026400120223     C                   Exsr      GETEFF
026500120223     C                   End
026600130725     C                   IF        W80DATE = 0
026700130725     C                   Eval      WCAT = 'PCV'
026800130725     C                   Exsr      GETEFF
026900130725     C                   End
027000120223     C                   IF        W80DATE > 0
027100120223     C                   Movel     W80DATE       Input_Date
027200120223     C                   Eval      Input_Format  = 'YYYYMMDD'
027300120223     C                   Eval      Output_Format = 'MM/DD/YYYY'
027400120223     C                   Exsr      FormatDateSR
027500120223     C                   Eval      D3SCEF4       = %trim(Output_Date)
027600120223     C                   End
027700120223     C                   End
027800111209
027900111209      * Override Group#
028000111209     C                   IF        %trim(DFGRP#) <> *BLANKS
028100111209     C                   EVAL      D3GRP =  DFGRP#
028200111209     C                   IF        %trim(D3GRP1) <> *BLANKS
028300111209     C                   EVAL      D3GRP1 = DFGRP#
028400111209     C                   END
028500111209     C                   IF        %trim(D3GRP2) <> *BLANKS
028600111209     C                   EVAL      D3GRP2 = DFGRP#
028700111209     C                   END
028800111209     C                   IF        %trim(D3GRP3) <> *BLANKS
028900111209     C                   EVAL      D3GRP3 = DFGRP#
029000111209     C                   END
029100111209     C                   IF        %trim(D3GRP4) <> *BLANKS
029200111209     C                   EVAL      D3GRP4 = DFGRP#
029300111209     C                   END
029400111209     C                   IF        %trim(D3GRP5) <> *BLANKS
029500111209     C                   EVAL      D3GRP5 = DFGRP#
029600111209     C                   END
029700111209     C                   IF        %trim(D3GRP6) <> *BLANKS
029800111209     C                   EVAL      D3GRP6 = DFGRP#
029900111209     C                   END
030000111209     C                   IF        %trim(D3GRP7) <> *BLANKS
030100111209     C                   EVAL      D3GRP7 = DFGRP#
030200111209     C                   END
030300111209     C                   IF        %trim(D3GRP8) <> *BLANKS
030400111209     C                   EVAL      D3GRP8 = DFGRP#
030500111209     C                   END
030600111209     C                   END
030700111209
030800111209      * Override Sub Group
030900111209     C                   IF        %trim(DFSGRP) <> *BLANKS
031000111209     C                   EVAL      D3SGR =  DFSGRP
031100111209     C                   IF        %trim(D3SGR1) <> *BLANKS
031200111209     C                   EVAL      D3SGR1 = DFSGRP
031300111209     C                   END
031400111209     C                   IF        %trim(D3SGR2) <> *BLANKS
031500111209     C                   EVAL      D3SGR2 = DFSGRP
031600111209     C                   END
031700111209     C                   IF        %trim(D3SGR3) <> *BLANKS
031800111209     C                   EVAL      D3SGR3 = DFSGRP
031900111209     C                   END
032000111209     C                   IF        %trim(D3SGR4) <> *BLANKS
032100111209     C                   EVAL      D3SGR4 = DFSGRP
032200111209     C                   END
032300111209     C                   IF        %trim(D3SGR5) <> *BLANKS
032400111209     C                   EVAL      D3SGR5 = DFSGRP
032500111209     C                   END
032600111209     C                   IF        %trim(D3SGR6) <> *BLANKS
032700111209     C                   EVAL      D3SGR6 = DFSGRP
032800111209     C                   END
032900111209     C                   IF        %trim(D3SGR7) <> *BLANKS
033000111209     C                   EVAL      D3SGR7 = DFSGRP
033100111209     C                   END
033200111209     C                   IF        %trim(D3SGR8) <> *BLANKS
033300111209     C                   EVAL      D3SGR8 = DFSGRP
033400111209     C                   END
033500111209     C                   END
033600111209
033700100527     C                   Exsr      CHKORGEF
033800100421     C                   Update    DBEDTLR
033900100421     C     *Date         Mult      10000.0001    DFSNT
034000100421     C                   Update    DW311FLGR
034100100421     C     FLGKEY        Chain     DW311FLGLH
034200100421     C                   If        %found(DW311FLGLH)
034300100421     C     *Date         Mult      10000.0001    DFSNT
034400100421     C                   Update    DW311FLGHR
034500100421     C                   End
034600100421     C                   End
034700100604     C                   Else
034800100604      * If not in the flag file, check delete file
034900100604     C     FLGKEY        Chain     DW311FLGD
035000100604     C                   If        %found(DW311FLGD)
035100121107     C                   Write     DBEDTLD
035200100604     C                   Delete    DBEDTLR
035300100604     C                   End
035400100421     C                   End
035500120223      *___________________________________________________________________
035600120223      * Get Real Effective Date
035700120223      *___________________________________________________________________
035800120223     C     GETEFF        BEGSR
035900131015     C                   Eval      W80DATE = 0
036000131015
036100131015      * if adding a dependent, use  dependent effective date
036200131015     C                   IF        D3FIL41 = 'A' and
036300131015     C                             DFSEQ   >  0
036400131015     C                   Exsr      GETEFFD
036500131015     C                   If        W80DATE > 0
036600131015     C                   LeaveSR
036700131015     C                   End
036800131015     C                   End
036900131015
037000120223     C                   Move      D3TSA         TSACHAR
037100120223     C     COVKEY        SETGT     MCOVC15
037200120223     C     COVKEY        READPE    MCOVC15
037300120223     C                   Dow       not %eof(MCOVC15)
037400120223     C     PLNKEY        Chain     PLNMST
037500120223     C                   If        %found(PLNMST)
037600120223     C                   If        %trim(PLNCAT) = %trim(WCAT)
037700120223     C                   Eval      W80DATE = ENRLDT
037800120223     C                   LeaveSR
037900120223     C                   End
038000120223     C                   End
038100120223     C     COVKEY        READPE    MCOVC15
038200120223     C                   Enddo
038300120223     C     COVKEY        KLIST
038400120223     C                   KFLD                    W_T
038500120223     C                   KFLD                    W_S
038600120223     C                   KFLD                    W_A
038700120223     C                   KFLD                    DFSSN
038800120223     C     PLNKEY        KLIST
038900120223     C                   KFLD                    W_T
039000120223     C                   KFLD                    W_S
039100120223     C                   KFLD                    MCPLAN
039200120223     C                   ENDSR
039300131015      *___________________________________________________________________
039400131015     C     GETEFFD       BEGSR
039500131015
039600131015     C                   Move      D3TSA         TSACHAR
039700131015     C     DEPKEY        SETGT     DCOVC
039800131015     C     DEPKEY        READPE    DCOVC
039900131015     C                   Dow       not %eof(DCOVC)
040000131015     C                   If        CCANDT = 0
040100131015     C     PLNKEY        Chain     PLNMST
040200131015     C                   If        %found(PLNMST)
040300131015     C                   If        %trim(PLNCAT) = %trim(WCAT)
040400131015     C                   Eval      W80DATE = DENRDT
040500131015     C                   LeaveSR
040600131015     C                   End
040700131015     C                   End
040800131015     C                   End
040900131015     C     DEPKEY        READPE    DCOVC
041000131015     C                   Enddo
041100131015     C                   ENDSR
041200100527      *___________________________________________________________________
041300100527      * Check Original Effective Date
041400100527      *___________________________________________________________________
041500100527     C     CHKORGEF      BEGSR
041600100527      * If Group Changed, DFORGEF <> 0, then
041700100527      * Then update orgef with first Add plan Effective Date.
041800100527
041900100527     C                   If        DFORGEF <> 0
042000100527     C                   Select
042100100527     C                   When      %trim(D3FIL41) = 'A'
042200100527     C                   Move      D3SCEF1       D3ORGEF
042300100527     C                   When      %trim(D3FIL42) = 'A'
042400100527     C                   Move      D3SCEF2       D3ORGEF
042500100527     C                   When      %trim(D3FIL43) = 'A'
042600100527     C                   Move      D3SCEF3       D3ORGEF
042700100527     C                   When      %trim(D3FIL44) = 'A'
042800100527     C                   Move      D3SCEF4       D3ORGEF
042900100527     C                   Endsl
043000100527     C                   End
043100100527
043200100527     C                   ENDSR
043300121023      *___________________________________________________________________
043400121023      * If change from C,NNNN to A,AAAA make sure dates are original eff
043500121023      *___________________________________________________________________
043600121023     C     CHKD3SCEF1    BEGSR
043700121023     C                   If        D3MNTYP = 'C'    and
043800121023     C                             DFLG = 'A'
043900121023      *
044000121023     C                   If        D3FIL41 = 'N'    and
044100121023     C                             DFLGM = 'A'
044200121023     C                   Eval      D3SCEF1 = D3ORGEF
044300121023     C                   End
044400121023     C                   If        D3FIL42 = 'N'    and
044500121023     C                             DFLGR = 'A'
044600121023     C                   Eval      D3SCEF2 = D3ORGEF
044700121023     C                   End
044800121023     C                   If        D3FIL43 = 'N'    and
044900121023     C                             DFLGD = 'A'
045000121023     C                   Eval      D3SCEF3 = D3ORGEF
045100121023     C                   End
045200121023     C                   If        D3FIL43 = 'N'    and
045300121023     C                             DFLGV = 'A'
045400121023     C                   Eval      D3SCEF4 = D3ORGEF
045500121023     C                   End
045600121023      *
045700121023     C                   End
045800121023     C                   ENDSR
045900131223      *___________________________________________________________________
046000131223      * Set Coverage Level
046100131223      *___________________________________________________________________
046200131223     C     CLEVEL        BEGSR
046300131223     C                   If        %trim(W_COVT) <> *blanks
046400131223     C                   Select
046500131223     C                   When      W_COVT = 'FA'
046600131223     C                   Eval      W_SFAM = 'A'
046700131223     C                   When      W_COVT = 'HW'
046800131223     C                   Eval      W_SFAM = 'B'
046900131223     C                   When      W_COVT = 'IN'
047000131223     C                   Eval      W_SFAM = 'C'
047100131223     C                   When      W_COVT = 'MI'
047200131223     C                   Eval      W_SFAM = 'C'
047300131223     C                   When      W_COVT = 'PC'
047400131223     C                   Eval      W_SFAM = 'D'
047500131223     C                   When      W_COVT = 'P2'
047600131223     C                   Eval      W_SFAM = 'A'
047700131223     C                   Other
047800131223     C                   Eval      W_SFAM = 'O'
047900131223     C                   Endsl
048000131223     C                   End
048100131223      *
048200131223     C                   ENDSR
048300000000      *___________________________________________________________________
048400000000      * Key Lists
048500000000      *___________________________________________________________________
048600000000     C     KLIST         BEGSR
048700100421     C     FLGKEY        KLIST
048800100421     C                   KFLD                    DFSSN
048900100421     C                   KFLD                    DFSEQ
049000131015     C     DEPKEY        KLIST
049100131015     C                   KFLD                    DFSSN
049200131015     C                   KFLD                    DFSEQ
049300000000     C                   ENDSR
049400120223      *___________________________________________________________________
049500120223      * Format Date
049600120223      *___________________________________________________________________
049700120223     C     FormatDateSR  BEGSR
049800120223     C                   Call      'FMTDATE'
049900120223     C                   Parm                    Input_Date       32
050000120223     C                   Parm                    Input_Format     32
050100120223     C                   Parm                    Output_Format    32
050200120223     C                   Parm                    Output_Date      32
050300120223     C                   Parm                    Output_Error     10
050400120223     C                   Eval      Input_Date   = *blanks
050500120223     C                   Eval      Input_Format = *blanks
050600120223     C                   Eval      OutPut_Format = *blanks
050700120223     C                   ENDSR
050800000000      *___________________________________________________________________
050900000000      * Program open
051000000000      *___________________________________________________________________
051100000000     C     *INZSR        BEGSR
051200000000     C                   ENDSR
