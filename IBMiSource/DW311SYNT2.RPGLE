000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Delegated Billing Electronic Enrollment
000400000000      *
000500000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - October 24, 2002
000800000000      *_________________________________________________________________________
000900140402     FDBE834JON UP   E             DISK
001000021024      *
001100140214     FDEPNDC    IF   E           k DISK       extfile('F.DEPNDC')
001200140214     FDCOVC     IF   E           k DISK       extfile('F.DCOVC')
001300140214     FPLNMST    IF   E           k DISK       extfile('F.PLNMST')
001400090320      *
001500120821     D WTODAY          s             10a
001600131213     D W80ADDS         s              8s 0
001700131213     D W80ADD41        s              8s 0
001800131213     D W80ADD42        s              8s 0
001900131213     D W80ADD43        s              8s 0
002000131213     D W80ADD44        s              8s 0
002100130905     D W80DATE         s              8s 0
002200130905     D W81DATE         s              8s 0
002300130905     D W82DATE         s              8s 0
002400131216     D W8ADATE         s             10a
002500131216     D W8XDATE         s              8a
002600140402
002700140402     IDBEDTLR       01
002800121126
002900140402     C   01              Exsr      SyncDEPadd
003000140214      *___________________________________________________________________
003100140214      * Sync DEP Adds
003200140214      *___________________________________________________________________
003300140214     C     SyncDEPadd    BEGSR
003400140214
003500140214     C                   If        D3SFX = '99'   and
003600140214     C                             D3MNTYP = 'A'
003700140214
003800140214     C                   move      D3SUB         DSSNO
003900140214     C     DSSNO         Setgt     DEPNDC
004000140214     C     DSSNO         Readpe    DEPNDC
004100140214     C                   Dow       not %eof(DEPNDC)
004200140214
004300140214      * Find DEP SEQ
004400140214     C                   If        %trim(DLNAME) = %trim(D3LST) and
004500140214     C                             %trim(DFNAME) = %trim(D3FST) and
004600140214     C                             %trim(DMI)    = %trim(D3MID)
004700140214
004800140214      * Find active coverages
004900140214     C     DPNKEY        Setgt     DCOVC
005000140214     C     DPNKEY        Readpe    DCOVC
005100140214     C                   Dow       not %eof(DCOVC)
005200140214
005300140214     C                   If        CCANDT = 0
005400140214     C     PLNKEY        Chain     PLNMST
005500140214     C                   If        %found(PLNMST)
005600140214
005700140214      * Sync effective dates
005800140214     C                   Select
005900140214     C                   When      PLNCAT = 'PMM' or
006000140214     C                             PLNCAT = 'PMC'
006100140214     C                   If        D3SCEF1 <> *blanks
006200140214     C                   Movel     DENRDT        Input_Date
006300140214     C                   Eval      Input_Format = 'YYYYMMDD'
006400140214     C                   Eval      Output_Format  = 'MM/DD/YYYY'
006500140214     C                   Exsr      FormatDateSR
006600140214     C                   Eval      D3SCEF1 = %trim(Output_Date)
006700140214     C                   If        D3SCEF2 <> *blanks
006800140214     C                   Eval      D3SCEF2 = %trim(Output_Date)
006900140214     C                   End
007000140214     C                   End
007100140214     C                   When      PLNCAT = 'PDR' or
007200140917     C                             PLNCAT = 'PDN' or
007300140917     C                             PLNCAT = 'PCD' or
007400140917     C                             PLNCAT = 'PDE'
007500140214     C                   If        D3SCEF3 <> *blanks
007600140214     C                   Movel     DENRDT        Input_Date
007700140214     C                   Eval      Input_Format = 'YYYYMMDD'
007800140214     C                   Eval      Output_Format  = 'MM/DD/YYYY'
007900140214     C                   Exsr      FormatDateSR
008000140214     C                   Eval      D3SCEF3 = %trim(Output_Date)
008100140214     C                   End
008200140214     C                   When      PLNCAT = 'PVR' or
008300140214     C                             PLNCAT = 'PVS'
008400140214     C                   If        D3SCEF4 <> *blanks
008500140214     C                   Movel     DENRDT        Input_Date
008600140214     C                   Eval      Input_Format = 'YYYYMMDD'
008700140214     C                   Eval      Output_Format  = 'MM/DD/YYYY'
008800140214     C                   Exsr      FormatDateSR
008900140214     C                   Eval      D3SCEF4 = %trim(Output_Date)
009000140214     C                   End
009100140214     C                   Endsl
009200140214
009300140214     C                   End
009400140214     C                   End
009500140214
009600140214     C     DPNKEY        Readpe    DCOVC
009700140214     C                   Enddo
009800140214
009900140214     C                   End
010000140214
010100140214     C     DSSNO         Readpe    DEPNDC
010200140214     C                   Enddo
010300140214
010400140214     C                   End
010500140214
010600140214     C     DPNKEY        Klist
010700140214     C                   Kfld                    DSSNO
010800140214     C                   Kfld                    DPSEQ#
010900140214
011000140214     C     PLNKEY        Klist
011100140214     C                   Kfld                    DVTRST
011200140214     C                   Kfld                    DVSUB#
011300140214     C                   Kfld                    DVPLAN
011400140214
011500140214     C                   ENDSR
011600121126      *___________________________________________________________________
011700121126      * Format Date
011800121126      *___________________________________________________________________
011900121126     C     FormatDateSR  BEGSR
012000121126     C                   Call      'FMTDATE'
012100121126     C                   Parm                    Input_Date       32
012200121126     C                   Parm                    Input_Format     32
012300121126     C                   Parm                    Output_Format    32
012400121126     C                   Parm                    Output_Date      32
012500121126     C                   Parm                    Output_Error     10
012600121126     C                   Eval      Input_Date   = *blanks
012700121126     C                   Eval      Input_Format = *blanks
012800121126     C                   Eval      OutPut_Format = *blanks
012900121126     C                   ENDSR
