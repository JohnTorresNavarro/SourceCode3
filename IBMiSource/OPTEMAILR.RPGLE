000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Opt-Out Credit email to GBSPAYROLLPLUS
000500000000      *
000600000000      *  (c)Copyright 2010 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - December 10, 2010
000900000000      *_________________________________________________________________________
000902101210     FWEBPAYDED IP   E           K DISK
000903101210     FWEBPAYROLLIF   E           K DISK
000904101210     FACCMST    IF   E           K DISK
000905101210     FACCMSP    IF   E           K DISK
000906101210
000907101210     D WNAME           s             40a   inz
000908101210     D WACCT           s             40a   inz
000909101210
000910101210     D MSGTXT          s            300a   inz
000911101210
001000000000      * Program status data structure
001100000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001200000000      *
001201101210
001203101210     IWEBPAYDDR     01
001204101210
001205101210     C   01              EXSR      CHECKOPT
001206101210
001300101210     C     CHECKOPT      Begsr
001301101210
001302101210     C                   Clear                   MSGTXT
001303101210     C                   Select
001333101210      * OPT-MED START
001334101210     C                   When      %trim(PQPLN) = 'OPTM' and
001335101210     C                             PQSTART     <> *Zeros
001336101210     C                   Exsr      GETNAME
001337101210     C                   Exsr      GETACCT
001338101210     C     PQSTART       Mult      10000.0001    PQSTART
001339101210     C                   Eval      MSGTXT = 'Medical Opt-Out Waiver ' +
001340101210     C                                      'was selected for ' +
001341101210     C                                      %trim(WNAME)+
001342101210     C                                      ' in Account: ' + %trim(WACCT)+
001343101210     C                                      ' for an amount of: ' +
001344101210     C                                      %trim(%editc(PQDAMT:'P')) +
001345101210     C                                      ' with a start date of: ' +
001346101210     C                                      %editc(PQSTART:'Y')
001347120305     C                   Call      'OPTEMAIL2C'
001348120305     C                   Parm                    MSGTXT
001349101210
001350101210      * OPT-MED STOP
001351101210     C                   When      %trim(PQPLN) = 'OPTM' and
001352101210     C                             PQSTOP      <> *Zeros
001353101210     C                   Exsr      GETNAME
001354101210     C                   Exsr      GETACCT
001355101210     C     PQSTOP        Mult      10000.0001    PQSTOP
001356101210     C                   Eval      MSGTXT = 'Medical Opt-Out Waiver ' +
001357101210     C                                      'was terminated for ' +
001358101210     C                                      %trim(WNAME)+
001359101210     C                                      ' in Account: ' + %trim(WACCT)+
001360101210     C                                      ' for an amount of: ' +
001361101210     C                                      %trim(%editc(PQDAMT:'P')) +
001362101210     C                                      ' with a stop date of: ' +
001363101210     C                                      %editc(PQSTOP:'Y')
001364120305     C                   Call      'OPTEMAIL2C'
001365120305     C                   Parm                    MSGTXT
001366101210
001367101210      * OPT-MED START
001368101210     C                   When      %trim(PQPLN) = 'OPTD'  and
001369101210     C                             PQSTART     <> *Zeros
001370101210     C                   Exsr      GETNAME
001371101210     C                   Exsr      GETACCT
001372101210     C     PQSTART       Mult      10000.0001    PQSTART
001373101210     C                   Eval      MSGTXT = 'Dental Opt-Out Waiver ' +
001374101210     C                                      'was selected for ' +
001375101210     C                                      %trim(WNAME)+
001376101210     C                                      ' in Account: ' + %trim(WACCT)+
001377101210     C                                      ' for an amount of: ' +
001378101210     C                                      %trim(%editc(PQDAMT:'P')) +
001379101210     C                                      ' with a start date of: ' +
001380101210     C                                      %editc(PQSTART:'Y')
001381120305     C                   Call      'OPTEMAIL2C'
001382120305     C                   Parm                    MSGTXT
001383101210
001384101210      * OPT-MED STOP
001385101210     C                   When      %trim(PQPLN) = 'OPTD'  and
001386101210     C                             PQSTOP      <> *Zeros
001387101210     C                   Exsr      GETNAME
001388101210     C                   Exsr      GETACCT
001389101210     C     PQSTOP        Mult      10000.0001    PQSTOP
001390101210     C                   Eval      MSGTXT = 'Dental Opt-Out Waiver ' +
001391101210     C                                      'was terminated for ' +
001392101210     C                                      %trim(WNAME)+
001393101210     C                                      ' in Account: ' + %trim(WACCT)+
001394101210     C                                      ' for an amount of: ' +
001395101210     C                                      %trim(%editc(PQDAMT:'P')) +
001396101210     C                                      ' with a stop date of: ' +
001397101210     C                                      %editc(PQSTOP:'Y')
001398120305     C                   Call      'OPTEMAIL2C'
001399120305     C                   Parm                    MSGTXT
001400120305
001401120305      * PARTIAL DIRECT DEPOSIT
001402120305     C                   When      %trim(PQPDCD) = '4N'  and
001403120305     C                             PQSTART     <> *Zeros
001404120305     C                   Exsr      GETNAME
001405120305     C                   Exsr      GETACCT
001406120305     C     PQSTART       Mult      10000.0001    PQSTART
001407120305     C                   Eval      MSGTXT = 'Deduction 4N is tied to a ' +
001408120305     C                                      'partial direct deposit ' +
001409120305     C                                      %trim(WNAME)+
001410120305     C                                      ' in Account: ' + %trim(WACCT)+
001411120305     C                                      ' for an amount of: ' +
001412120305     C                                      %trim(%editc(PQDAMT:'P')) +
001413120305     C                                      ' with a start date of: ' +
001414120305     C                                      %editc(PQSTART:'Y')
001415120305     C                   Call      'OPTEMAIL3C'
001416120305     C                   Parm                    MSGTXT
001417120305
001418120305      * PARTIAL DIRECT DEPOSIT
001419120305     C                   When      %trim(PQPDCD) = '4N'  and
001420120305     C                             PQSTOP     <> *Zeros
001421120305     C                   Exsr      GETNAME
001422120305     C                   Exsr      GETACCT
001423120305     C     PQSTOP        Mult      10000.0001    PQSTOP
001424120305     C                   Eval      MSGTXT = 'Deduction 4N is tied to a ' +
001425120305     C                                      'partial direct deposit ' +
001426120305     C                                      %trim(WNAME)+
001427120305     C                                      ' in Account: ' + %trim(WACCT)+
001428120305     C                                      ' for an amount of: ' +
001429120305     C                                      %trim(%editc(PQDAMT:'P')) +
001430120305     C                                      ' with a stop date of: ' +
001431120305     C                                      %editc(PQSTOP:'Y')
001432120305     C                   Call      'OPTEMAIL3C'
001433120305     C                   Parm                    MSGTXT
001434101210     C                   Other
001435101210     C                   LeaveSR
001436101210     C                   Endsl
001439101210
001440101210     C                   Endsr
001441101210
001500101210     C     GETNAME       Begsr
001501101210     C     NAMKEY        KLIST
001502101210     C                   KFLD                    PQTRS
001503101210     C                   KFLD                    PQSUB
001504101210     C                   KFLD                    PQACT
001505101210     C                   KFLD                    PQSSN
001506101210     C     NAMKEY        Chain     WEBPAYROLL
001507101210     C                   If        %found(WEBPAYROLL)
001508101210     C                   Eval      WNAME = %trim(PYLST) + ', ' +
001509101210     C                                     %trim(PYFST)
001510101210     C                   Else
001511101210     C                   Eval      WNAME = *blanks
001512101210     C                   End
002300101210     C                   Endsr
002400101210
002500101210     C     GETACCT       Begsr
002600101210     C     ACCKEY        KLIST
002700101210     C                   KFLD                    PQTRS
002800101210     C                   KFLD                    PQSUB
002900101210     C                   KFLD                    PQACT
003100101210     C     ACCKEY        Chain     ACCMST
003200101210     C                   If        %found(ACCMST)
003300101210     C                   Eval      WACCT = %trim(ACNAM1)
003500101210     C                   Else
003600101210     C                   Eval      WACCT = *blanks
003700101210     C                   End
003701101210     C     ACCKEY        Chain     ACCMSP
003702101210     C                   If        %found(ACCMSP)
003703101210     C                   Eval      WACCT = %trim(WACCT) + ' (' +
003704101210     C                                     %trim(AMPAYR) + ')'
003707101210     C                   End
003800101210     C                   Endsr
