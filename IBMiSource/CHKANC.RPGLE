000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300100506    ? *  Description:  Check Payroll Deduction Data
000400000000    ? *
000500100506    ? *  (c)Copyright 2010 by GBS,Inc.
000600050318    ? *  This document contains restricted materials of GBS,Inc.
000700070516    ? *
000800050318    ? *___________________________________________________________________
000900101008    ?FPAYDEDANL1IF   E           K DISK
001000101230    ?FCODES     IF   E           K DISK
001100101230    ?FPLNMST    IF   E           K DISK
001200000000    ? *
001300010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001400130913    ?D WTM             S             80    DIM(25) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001500000000    ? *___________________________________________________________________
001600101019     D WSSALY          S             11S 2
001700101019     D WSPFRQ          S              2S 0
001800101019     D WSHIRE          S              8S 0
001900101019     D WSQEVT          S              8S 0
002000101019     D WSBIRTH         S              8S 0
002100101019     D WSAVLD          S              8S 0
002200101019     D WSPRD           S              1S 0
002300101019     D WSCLVL          S             20A
002400101019     D WSGENDER        S              1A
002500101019     D WSSMOKE         S              1A
002600000000    ? *
002700000614    ? * Data structure
002800100818    ?D WUDTA         E DS                  EXTNAME(PAYDEDANP)
002900000810    ? *
003000000000    ? * Program status data structure
003100991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003200000000    ? *___________________________________________________________________
003300000000    ? * Process check request
003400000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003500100818    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
003600100818    ?C     WIRQS         Caseq     'EDIT1'       EDTRCD1                        EDIT RECORD
003700100818    ?C     WIRQS         Caseq     'EDIT2'       EDTRCD2                        EDIT RECORD
003800100819    ?C     WIRQS         Caseq     'EDIT3'       EDTRCD3                        EDIT RECORD
003900100819    ?C     WIRQS         Caseq     'EDIT4'       EDTRCD4                        EDIT RECORD
004000100910    ?C     WIRQS         Caseq     'EDIT5'       EDTRCD5                        EDIT RECORD
004100100920    ?C     WIRQS         Caseq     'EDIT6'       EDTRCD6                        EDIT RECORD
004200100920    ?C     WIRQS         Caseq     'EDIT7'       EDTRCD7                        EDIT RECORD
004300000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
004400000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
004500000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
004600000000    ?C                   Endcs                                                  END CASE
004700000000    ?C                   Return                                                 RETURN
004800000000    ? *___________________________________________________________________
004900000000    ? * Edit record
005000000000    ? *___________________________________________________________________
005100000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
005200000810    ? *
005300000810    ? * Defualt Data
005400000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
005500100818    ? *
005600000000    ?C                   Endsr                                                  END EDIT RECORD
005700100826    ? *___________________________________________________________________
005800100826    ? * Edit record
005900100826    ? *___________________________________________________________________
006000100826    ?C     EDTRCD1       Begsr                                                  EDIT RECORD
006100100826    ? *
006200100826    ? * Defualt Data
006300100826    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
006400100826    ? *
006500100826    ? * Fixed Amount Required
006600100826     C                   If        PAFIXA   =    *Zeros
006700100826    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006800100826    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
006900100826    ?C                   Exsr      SNDMSG                                       SEND MSG
007000100826     C                   Endif
007100100917    ? *
007200100928    ? * Rate Per 1000
007300100928     C                   If        PARP10   <>   10   and
007400100928     C                             PARP10   <>   100  and
007500100928     C                             PARP10   <>   1000
007600100917    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007700100928    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
007800100917    ?C                   Exsr      SNDMSG                                       SEND MSG
007900100917     C                   Endif
008000101008    ? *
008100101008    ? * Plan Cat Dependencies
008200101008     C                   If        PACTDP   <>   ' '
008300101008     C                   Eval      TYPE = 'P'
008400101008     C     WKCODE        Chain     CODES
008500101008     C                   If        not %found(CODES)
008600101008    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008700101008    ?C                   Move      WTM(14)       WWMSG                          PASS MSG
008800101008    ?C                   Exsr      SNDMSG                                       SEND MSG
008900101008     C                   End
009000101008     C                   End
009100101230    ? *
009200101230    ? * Plan Cat Dependencies
009300101230     C                   If        PACTDP2  <>   ' '
009400101230     C                   Eval      TYPE = 'P'
009500101230     C     WKCODE2       Chain     CODES
009600101230     C                   If        not %found(CODES)
009700101230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009800101230    ?C                   Move      WTM(16)       WWMSG                          PASS MSG
009900101230    ?C                   Exsr      SNDMSG                                       SEND MSG
010000101230     C                   End
010100101230     C                   End
010200101230    ? *
010300101230    ? * Plan Cat Dependencies
010400101230     C                   If        PACTDP3  <>   ' '
010500101230     C                   Eval      TYPE = 'P'
010600101230     C     WKCODE3       Chain     CODES
010700101230     C                   If        not %found(CODES)
010800101230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010900101230    ?C                   Move      WTM(17)       WWMSG                          PASS MSG
011000101230    ?C                   Exsr      SNDMSG                                       SEND MSG
011100101230     C                   End
011200101230     C                   End
011300101230    ? *
011400101230    ? * Plan Cat Dependencies
011500101230     C                   If        PACTDP4  <>   ' '
011600101230     C                   Eval      TYPE = 'P'
011700101230     C     WKCODE4       Chain     CODES
011800101230     C                   If        not %found(CODES)
011900101230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012000101230    ?C                   Move      WTM(18)       WWMSG                          PASS MSG
012100101230    ?C                   Exsr      SNDMSG                                       SEND MSG
012200101230     C                   End
012300101230     C                   End
012400130913    ? *
012500130913    ? * Commission Bonus  Y or N.
012600130913     C                   If        PACOBO   <>   'Y'  and
012700130913     C                             PACOBO   <>   'N'
012800130913    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012900130913    ?C                   Move      WTM(23)       WWMSG                          PASS MSG
013000130913    ?C                   Exsr      SNDMSG                                       SEND MSG
013100130913     C                   Endif
013200130913    ? *
013300130913    ? * Smoker/Non-Smoker  Y or N.
013400130913     C                   If        PASMKR   <>   'Y'  and
013500130913     C                             PASMKR   <>   'N'  and
013600130913     C                             PASMKR   <>   'X'
013700130913    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013800130913    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
013900130913    ?C                   Exsr      SNDMSG                                       SEND MSG
014000130913     C                   Endif
014100100921    ? *
014200100921    ? * Gender  M or F.
014300100921     C                   If        PAGNDR   <>   'M'  and
014400100921     C                             PAGNDR   <>   'F'  and
014500100921     C                             PAGNDR   <>   'X'
014600100921    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014700100921    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
014800100921    ?C                   Exsr      SNDMSG                                       SEND MSG
014900100921     C                   Endif
015000100826    ? *
015100100826    ?C                   Endsr                                                  END EDIT RECORD
015200100818    ? *___________________________________________________________________
015300100818    ? * Edit record
015400100818    ? *___________________________________________________________________
015500100818    ?C     EDTRCD2       Begsr                                                  EDIT RECORD
015600100818    ? *
015700100818    ? * Defualt Data
015800100818    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
015900100818    ? *
016000100818    ? * Fixed Amount Required
016100100818     C                   If        PASALM   =    *Zeros
016200100818    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016300100818    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
016400100818    ?C                   Exsr      SNDMSG                                       SEND MSG
016500100818     C                   Endif
016600100928    ? *
016700100928    ? * Rate Per 1000
016800100928     C                   If        PARP10   <>   10   and
016900100928     C                             PARP10   <>   100  and
017000100928     C                             PARP10   <>   1000
017100100928    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
017200100928    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
017300100928    ?C                   Exsr      SNDMSG                                       SEND MSG
017400100928     C                   Endif
017500101008    ? *
017600101008    ? * Plan Cat Dependencies
017700101008     C                   If        PACTDP   <>   ' '
017800101008     C                   Eval      TYPE = 'P'
017900101008     C     WKCODE        Chain     CODES
018000101008     C                   If        not %found(CODES)
018100101008    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
018200101008    ?C                   Move      WTM(15)       WWMSG                          PASS MSG
018300101008    ?C                   Exsr      SNDMSG                                       SEND MSG
018400101008     C                   End
018500101008     C                   End
018600101230    ? *
018700101230    ? * Plan Cat Dependencies
018800101230     C                   If        PACTDP2  <>   ' '
018900101230     C                   Eval      TYPE = 'P'
019000101230     C     WKCODE2       Chain     CODES
019100101230     C                   If        not %found(CODES)
019200101230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
019300101230    ?C                   Move      WTM(18)       WWMSG                          PASS MSG
019400101230    ?C                   Exsr      SNDMSG                                       SEND MSG
019500101230     C                   End
019600101230     C                   End
019700101230    ? *
019800101230    ? * Plan Cat Dependencies
019900101230     C                   If        PACTDP3  <>   ' '
020000101230     C                   Eval      TYPE = 'P'
020100101230     C     WKCODE3       Chain     CODES
020200101230     C                   If        not %found(CODES)
020300101230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
020400101230    ?C                   Move      WTM(19)       WWMSG                          PASS MSG
020500101230    ?C                   Exsr      SNDMSG                                       SEND MSG
020600101230     C                   End
020700101230     C                   End
020800101230    ? *
020900101230    ? * Plan Cat Dependencies
021000101230     C                   If        PACTDP4  <>   ' '
021100101230     C                   Eval      TYPE = 'P'
021200101230     C     WKCODE4       Chain     CODES
021300101230     C                   If        not %found(CODES)
021400101230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
021500101230    ?C                   Move      WTM(20)       WWMSG                          PASS MSG
021600101230    ?C                   Exsr      SNDMSG                                       SEND MSG
021700101230     C                   End
021800101230     C                   End
021900100917    ? *
022000130913    ? * Commission Bonus  Y or N.
022100130913     C                   If        PACOBO   <>   'Y'  and
022200130913     C                             PACOBO   <>   'N'
022300130913    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
022400130913    ?C                   Move      WTM(24)       WWMSG                          PASS MSG
022500130913    ?C                   Exsr      SNDMSG                                       SEND MSG
022600130913     C                   Endif
022700130913    ? *
022800100917    ? * Smoker/Non-Smoker  Y or N.
022900100917     C                   If        PASMKR   <>   'Y'  and
023000100920     C                             PASMKR   <>   'N'  and
023100100920     C                             PASMKR   <>   'X'
023200100917    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
023300100921    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
023400100917    ?C                   Exsr      SNDMSG                                       SEND MSG
023500100917     C                   Endif
023600100921    ? *
023700100921    ? * Gender  M or F.
023800100921     C                   If        PAGNDR   <>   'M'  and
023900100921     C                             PAGNDR   <>   'F'  and
024000100921     C                             PAGNDR   <>   'X'
024100100921    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
024200100921    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
024300100921    ?C                   Exsr      SNDMSG                                       SEND MSG
024400100921     C                   Endif
024500100818    ? *
024600100818    ?C                   Endsr                                                  END EDIT RECORD
024700100818    ? *___________________________________________________________________
024800100818    ? * Edit record
024900100818    ? *___________________________________________________________________
025000100818    ?C     EDTRCD3       Begsr                                                  EDIT RECORD
025100100818    ? *
025200100818    ? * Defualt Data
025300100818    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
025400101001    ? *
025500101001    ? * Age Based
025600101230     C     PLNKEY        KLIST
025700101230     C                   KFLD                    PATRST
025800101230     C                   KFLD                    PASUB#
025900101230     C                   KFLD                    PAPLAN
026000101230     C     PLNKEY        CHAIN     PLNMST
026100101230     C                   If        %found(PLNMST)
026200101001     C                   If        PAEORS   =    ' '   and
026300101230     C                             PABFL    <>   'N'
026400101001    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
026500101001    ?C                   Move      WTM(11)       WWMSG                          PASS MSG
026600101001    ?C                   Exsr      SNDMSG                                       SEND MSG
026700101230     C                   Endif
026800101230     C                   End
026900101001    ? *
027000101001    ? * Age Based
027100101001     C                   If        PAEORS   <>   'E'   and
027200101001     C                             PAEORS   <>   'S'   and
027300101001     C                             PAEORS   <>   ' '
027400101001    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
027500101001    ?C                   Move      WTM(12)       WWMSG                          PASS MSG
027600101001    ?C                   Exsr      SNDMSG                                       SEND MSG
027700101001     C                   Endif
027800100928    ? *
027900100928    ? * Rate Per 1000
028000100928     C                   If        PARP10   <>   10   and
028100100928     C                             PARP10   <>   100  and
028200100928     C                             PARP10   <>   1000
028300100928    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
028400100928    ?C                   Move      WTM(10)       WWMSG                          PASS MSG
028500100928    ?C                   Exsr      SNDMSG                                       SEND MSG
028600100928     C                   Endif
028700100917    ? *
028800130913    ? * Commission Bonus  Y or N.
028900130913     C                   If        PACOBO   <>   'Y'  and
029000130913     C                             PACOBO   <>   'N'
029100130913    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
029200130913    ?C                   Move      WTM(25)       WWMSG                          PASS MSG
029300130913    ?C                   Exsr      SNDMSG                                       SEND MSG
029400130913     C                   Endif
029500130913    ? *
029600100917    ? * Smoker/Non-Smoker  Y or N.
029700100917     C                   If        PASMKR   <>   'Y'  and
029800100920     C                             PASMKR   <>   'N'  and
029900100920     C                             PASMKR   <>   'X'
030000100917    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
030100100921    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
030200100917    ?C                   Exsr      SNDMSG                                       SEND MSG
030300100917     C                   Endif
030400100921    ? *
030500100921    ? * Gender  M or F.
030600100921     C                   If        PAGNDR   <>   'M'  and
030700100921     C                             PAGNDR   <>   'F'  and
030800100921     C                             PAGNDR   <>   'X'
030900100921    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
031000100921    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
031100100921    ?C                   Exsr      SNDMSG                                       SEND MSG
031200101008     C                   End
031300101008    ? *
031400101008    ? * Plan Cat Dependencies
031500101008     C                   If        PACTDP   <>   ' '
031600101008     C                   Eval      TYPE = 'P'
031700101008     C     WKCODE        Chain     CODES
031800101008     C                   If        not %found(CODES)
031900101008    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
032000101008    ?C                   Move      WTM(13)       WWMSG                          PASS MSG
032100101008    ?C                   Exsr      SNDMSG                                       SEND MSG
032200101008     C                   End
032300101008     C                   End
032400101230    ? *
032500101230    ? * Plan Cat Dependencies
032600101230     C                   If        PACTDP2  <>   ' '
032700101230     C                   Eval      TYPE = 'P'
032800101230     C     WKCODE2       Chain     CODES
032900101230     C                   If        not %found(CODES)
033000101230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
033100101230    ?C                   Move      WTM(19)       WWMSG                          PASS MSG
033200101230    ?C                   Exsr      SNDMSG                                       SEND MSG
033300101230     C                   End
033400101230     C                   End
033500101230    ? *
033600101230    ? * Plan Cat Dependencies
033700101230     C                   If        PACTDP3  <>   ' '
033800101230     C                   Eval      TYPE = 'P'
033900101230     C     WKCODE3       Chain     CODES
034000101230     C                   If        not %found(CODES)
034100101230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
034200101230    ?C                   Move      WTM(20)       WWMSG                          PASS MSG
034300101230    ?C                   Exsr      SNDMSG                                       SEND MSG
034400101230     C                   End
034500101230     C                   End
034600101230    ? *
034700101230    ? * Plan Cat Dependencies
034800101230     C                   If        PACTDP4  <>   ' '
034900101230     C                   Eval      TYPE = 'P'
035000101230     C     WKCODE4       Chain     CODES
035100101230     C                   If        not %found(CODES)
035200101230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
035300101230    ?C                   Move      WTM(21)       WWMSG                          PASS MSG
035400101230    ?C                   Exsr      SNDMSG                                       SEND MSG
035500101230     C                   End
035600101230     C                   End
035700100917    ? *
035800101008     C     WKCODE        Klist
035900101008     C                   Kfld                    TYPE
036000101008     C                   Kfld                    PACTDP
036100101230    ? *
036200101230     C     WKCODE2       Klist
036300101230     C                   Kfld                    TYPE
036400101230     C                   Kfld                    PACTDP2
036500101230    ? *
036600101230     C     WKCODE3       Klist
036700101230     C                   Kfld                    TYPE
036800101230     C                   Kfld                    PACTDP3
036900101230    ? *
037000101230     C     WKCODE4       Klist
037100101230     C                   Kfld                    TYPE
037200101230     C                   Kfld                    PACTDP4
037300101008    ? *
037400100818    ?C                   Endsr                                                  END EDIT RECORD
037500100819    ? *___________________________________________________________________
037600130913    ? * Edit record - STD
037700100819    ? *___________________________________________________________________
037800100819    ?C     EDTRCD4       Begsr                                                  EDIT RECORD
037900100819    ? *
038000100819    ? * Defualt Data
038100100819    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
038200100819    ? *
038300100819    ? * % Salary Amount Required
038400100819     C                   If        PAPSAL   =    *Zeros
038500100819    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
038600100819    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
038700100819    ?C                   Exsr      SNDMSG                                       SEND MSG
038800100819     C                   Endif
038900100928    ? *
039000100928    ? * Rate Per 1000
039100100928     C                   If        PARP10   <>   10   and
039200100928     C                             PARP10   <>   100  and
039300100928     C                             PARP10   <>   1000
039400100928    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
039500100928    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
039600100928    ?C                   Exsr      SNDMSG                                       SEND MSG
039700100928     C                   Endif
039800130913    ? *
039900130913    ? * Commission Bonus  Y or N.
040000130913     C                   If        PACOBO   <>   'Y'  and
040100130913     C                             PACOBO   <>   'N'
040200130913    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
040300130913    ?C                   Move      WTM(22)       WWMSG                          PASS MSG
040400130913    ?C                   Exsr      SNDMSG                                       SEND MSG
040500130913     C                   Endif
040600100917    ? *
040700100917    ? * Smoker/Non-Smoker  Y or N.
040800100917     C                   If        PASMKR   <>   'Y'  and
040900100920     C                             PASMKR   <>   'N'  and
041000100920     C                             PASMKR   <>   'X'
041100100917    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
041200100921    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
041300100917    ?C                   Exsr      SNDMSG                                       SEND MSG
041400100917     C                   Endif
041500100921    ? *
041600100921    ? * Gender  M or F.
041700100921     C                   If        PAGNDR   <>   'M'  and
041800100921     C                             PAGNDR   <>   'F'  and
041900100921     C                             PAGNDR   <>   'X'
042000100921    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
042100100921    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
042200100921    ?C                   Exsr      SNDMSG                                       SEND MSG
042300100921     C                   Endif
042400100819    ? *
042500100819    ?C                   Endsr                                                  END EDIT RECORD
042600100819    ? *___________________________________________________________________
042700130913    ? * Edit record - LTD
042800100819    ? *___________________________________________________________________
042900100819    ?C     EDTRCD5       Begsr                                                  EDIT RECORD
043000100819    ? *
043100100819    ? * Defualt Data
043200100819    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
043300100819    ? *
043400100819    ? * % Salary Amount Required
043500100819     C                   If        PAPSAL   =    *Zeros
043600100819    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
043700100819    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
043800100819    ?C                   Exsr      SNDMSG                                       SEND MSG
043900100819     C                   Endif
044000100928    ? *
044100100928    ? * Rate Per 1000
044200100928     C                   If        PARP10   <>   10   and
044300100928     C                             PARP10   <>   100  and
044400100928     C                             PARP10   <>   1000
044500100928    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
044600100928    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
044700100928    ?C                   Exsr      SNDMSG                                       SEND MSG
044800100928     C                   Endif
044900130913    ? *
045000130913    ? * Commission Bonus  Y or N.
045100130913     C                   If        PACOBO   <>   'Y'  and
045200130913     C                             PACOBO   <>   'N'
045300130913    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
045400130913    ?C                   Move      WTM(22)       WWMSG                          PASS MSG
045500130913    ?C                   Exsr      SNDMSG                                       SEND MSG
045600130913     C                   Endif
045700100917    ? *
045800100917    ? * Smoker/Non-Smoker  Y or N.
045900100917     C                   If        PASMKR   <>   'Y'  and
046000100920     C                             PASMKR   <>   'N'  and
046100100920     C                             PASMKR   <>   'X'
046200100917    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
046300100921    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
046400100917    ?C                   Exsr      SNDMSG                                       SEND MSG
046500100917     C                   Endif
046600100819    ? *
046700100921    ? * Gender  M or F.
046800100921     C                   If        PAGNDR   <>   'M'  and
046900100921     C                             PAGNDR   <>   'F'  and
047000100921     C                             PAGNDR   <>   'X'
047100100921    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
047200100921    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
047300100921    ?C                   Exsr      SNDMSG                                       SEND MSG
047400100921     C                   Endif
047500100819    ?C                   Endsr                                                  END EDIT RECORD
047600100910    ? *___________________________________________________________________
047700100910    ? * Edit record
047800100910    ? *___________________________________________________________________
047900100910    ?C     EDTRCD6       Begsr                                                  EDIT RECORD
048000100910    ? *
048100100910    ? * Defualt Data
048200100910    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
048300100910    ? *
048400100910    ? * % Salary Amount Required
048500100910     C                   If        PAPSAL   =    *Zeros
048600100910    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
048700100910    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
048800100910    ?C                   Exsr      SNDMSG                                       SEND MSG
048900100910     C                   Endif
049000130913    ? *
049100130913    ? * Commission Bonus  Y or N.
049200130913     C                   If        PACOBO   <>   'Y'  and
049300130913     C                             PACOBO   <>   'N'
049400130913    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
049500130913    ?C                   Move      WTM(22)       WWMSG                          PASS MSG
049600130913    ?C                   Exsr      SNDMSG                                       SEND MSG
049700130913     C                   Endif
049800130913    ? *
049900100917    ? * Smoker/Non-Smoker  Y or N.
050000100917     C                   If        PASMKR   <>   'Y'  and
050100100920     C                             PASMKR   <>   'N'  and
050200100920     C                             PASMKR   <>   'X'
050300100917    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
050400100921    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
050500100917    ?C                   Exsr      SNDMSG                                       SEND MSG
050600100917     C                   Endif
050700100921    ? *
050800100921    ? * Gender  M or F.
050900100921     C                   If        PAGNDR   <>   'M'  and
051000100921     C                             PAGNDR   <>   'F'  and
051100100921     C                             PAGNDR   <>   'X'
051200100921    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
051300100921    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
051400100921    ?C                   Exsr      SNDMSG                                       SEND MSG
051500100921     C                   Endif
051600100910    ? *
051700100910    ?C                   Endsr                                                  END EDIT RECORD
051800100920    ? *___________________________________________________________________
051900100920    ? * Edit record
052000100920    ? *___________________________________________________________________
052100100920    ?C     EDTRCD7       Begsr                                                  EDIT RECORD
052200100920    ? *
052300100920    ? * Defualt Data
052400100920    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
052500130913    ? *
052600130913    ? * Commission Bonus  Y or N.
052700130913     C                   If        PACOBO   <>   'Y'  and
052800130913     C                             PACOBO   <>   'N'
052900130913    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
053000130913    ?C                   Move      WTM(22)       WWMSG                          PASS MSG
053100130913    ?C                   Exsr      SNDMSG                                       SEND MSG
053200130913     C                   Endif
053300100920    ? *
053400100920    ? * Smoker/Non-Smoker  Y or N.
053500100920     C                   If        PASMKR   <>   'Y'  and
053600100920     C                             PASMKR   <>   'N'  and
053700100920     C                             PASMKR   <>   'X'
053800100920    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
053900100921    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
054000100920    ?C                   Exsr      SNDMSG                                       SEND MSG
054100100920     C                   Endif
054200100921    ? *
054300100921    ? * Gender  M or F.
054400100921     C                   If        PAGNDR   <>   'M'  and
054500100921     C                             PAGNDR   <>   'F'  and
054600100921     C                             PAGNDR   <>   'X'
054700100921    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
054800100921    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
054900100921    ?C                   Exsr      SNDMSG                                       SEND MSG
055000100921     C                   Endif
055100100920    ? *
055200100920    ?C                   Endsr                                                  END EDIT RECORD
055300010301    ? *___________________________________________________________________
055400010301    ? * format Date edit
055500010301    ? *___________________________________________________________________
055600010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
055700010301     C                   movel     'MMDDYYYY'    Input_Format
055800010301     C                   Call      'FMTDATE'
055900010301     C                   Parm                    Input_Date       32
056000010301     C                   Parm                    Input_Format     32
056100010301     C                   Parm                    Output_Format    32
056200010301     C                   Parm                    Output_Date      32
056300010301     C                   Parm                    Output_Error     10
056400010301    ?C                   Endsr                                                  END DLT RQST
056500000000    ? *___________________________________________________________________
056600000000    ? * Edit delete request
056700000000    ? *___________________________________________________________________
056800000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
056900000000    ?C                   Endsr                                                  END DLT RQST
057000000000    ? *___________________________________________________________________
057100000000    ? * Default data
057200000000    ? *___________________________________________________________________
057300000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
057400130913     C                   If        PACOBO = *BLANKS
057500130913     C                   Eval      PACOBO = 'N'
057600130913     C                   End
057700100921     C                   If        PASMKR = *BLANKS
057800100921     C                   Eval      PASMKR = 'X'
057900100921     C                   End
058000100921     C                   If        PAGNDR = *BLANKS
058100100921     C                   Eval      PAGNDR = 'X'
058200100917     C                   End
058300000000    ?C                   Endsr                                                  END DFT DATA
058400000000    ? *___________________________________________________________________
058500000000    ? * Send messages
058600000000    ? *___________________________________________________________________
058700000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
058800000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
058900000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
059000000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
059100000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
059200000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
059300000000    ?C                   Endsr                                                  END SND ERRMSG
059400000000    ? *___________________________________________________________________
059500000000    ? * Process error
059600000000    ? *___________________________________________________________________
059700000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
059800000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
059900000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
060000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
060100000000    ?C                   Endsr                                                  END PRCERR
060200000000    ? *___________________________________________________________________
060300000000    ? * Parameter list
060400000000    ? *___________________________________________________________________
060500000000    ?C     PLIST         Begsr                                                  PARM LISTS
060600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
060700000000    ?C                   Parm                    WIRQS             8            REQUEST
060800000000    ?C                   Parm                    WORTN             8            RETURN CODE
060900000614    ?C                   Parm                    WUDTA                          DATA
061000000000    ?C                   Endsr                                                  END PLIST
061100090520      *
061200090520    ?C     KLIST         Begsr                                                  KEY LISTS
061300090520    ?C                   Endsr                                                  END PLIST
061400000000    ? *___________________________________________________________________
061500000000    ? * Define Variables and Key Lists
061600000000    ? *___________________________________________________________________
061700000000    ?C     DEFN          Begsr                                                  PARM LISTS
061800000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
061900000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
062000000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
062100000000    ?C                   Endsr                                                  END DEFN
062200000000    ? *___________________________________________________________________
062300000000    ? * Program error handler
062400000000    ? *___________________________________________________________________
062500000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
062600000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
062700000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
062800000000    ?C                   Parm                    WQSTSC                         STATUS CODE
062900000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
063000000000    ?C                   Parm                    WQMSG                          MESSAGE ID
063100000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
063200000000    ? *___________________________________________________________________
063300000112** WTMP
06340000000000T-Record is not eligible for deletion.
06350010081800Request not supported by program CHKANC
063600000117** WTM
06370010081861Flat Amount is required.
06380010092863Rate Per must be 10, 100, or 1000
06390010081861Salary Multiplier is required.
06400010092864Rate Per must be 10, 100, or 1000
06410010081861Variable Amount is required.
06420010092865Rate Per must be 10, 100, or 1000
06430010091761% of Salary is required.
06440010092168Gender must be Y or N or X for N/A.
06450010092169Smoker/Non-Smoker must be Y or N or X for N/A.
06460010100166Rate Per must be 10, 100, or 1000
06470010100168Age Based required if SPS Plan
06480010100868Age Based must be E, S, or blank.
06490010100861Plan Category Dependency is invalid.
06500010100864Plan Category Dependency is invalid.
06510010100865Plan Category Dependency is invalid.
06520010123065Plan Category Dependency is invalid.
06530010123066Plan Category Dependency is invalid.
06540010123067Plan Category Dependency is invalid.
06550010123070Plan Category Dependency is invalid.
06560010123071Plan Category Dependency is invalid.
06570010123072Plan Category Dependency is invalid.
06580013091366Commission Bonus must be Y or N.
06590013091368Commission Bonus must be Y or N.
06600013091372Commission Bonus must be Y or N.
06610013091373Commission Bonus must be Y or N.
