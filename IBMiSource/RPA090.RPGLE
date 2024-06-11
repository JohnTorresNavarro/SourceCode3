0000080509130002 F******************************************************************
0000090509130003 F* RPA090     GROUP BENEFIT SERVICES, INC.                        *
0000100509130004 F*                                                                *
0000110509130005 F*            WRITTEN BY - David Ketterman                        *
0000120509130006 F*            DATE - 09/13/05                                     *
0000130509130007 F*                                                                *
000014050913     F*
0000150509130008 F*  DESCRIPTION - THIS PROGRAM WILL COMPARE THE COMMISSION RATE   *
0000160509130009 F*                IN THE COMMISSION TO THE COMMISSION RATE        *
0000170509130015 F*                IN THE REMITTANCE.                              *
0000180802280015 F* 02/28/08 dlk - change to compare all data by run effective     *
0000190802280015 F*                date only.                                      *
0000201306040015 F* 06/04/13 dlk - change to only compare on com rec with rate <> 0*
0000210802280015 F*                                                                *
0000220509130013 F******************************************************************
0001000509120005 Frpa060wk  ip   e             disk
0001010509150005 Frpa091wk  if   e           k disk
0001020509130005 Frpa090xl  o  a e             disk
000103050913
000130050913     d totrpcmrt       s              8  2
000131050913     d cntrpcmrt       s              7  0
000132050913     d totrpmcnt       s             10  2
000133050913     d totrppprm       s             12  2
000134050913     d totrppcom       s             12  2
000135050913     d combase         s              9  2
000136050913     d combaseneg      s              9  2
000137050914     d comratdiv       s              7  3
000138050914     d rpefmy          s              6  0
000139050915     d cr130found      s              1
000140050916     d nffield         s              9    inz('Not Found')
000141050913     D                 DS
000142050913     D  rpefdt                 1      8  0
000143050914     D  rpefy                  1      4  0
000144050913     D  rpefm                  5      6  0
000145050913
000146050913     irpa60r
000147050913     i                                          rptrst        l1
000148050913     i                                          rpsub         l1
000149050913     i                                          rpacc         l1
000150050913     i                                          rpplan        l1
000151050914     i                                          rpedat        l1
000152050914      * RPEDAT (6.0) is filled with the year/month from rpefdt in
000153050914      * the opnqryf so the break will only occur on year/month.
000154050914      * This was necessary to include mid month effective dates
000155050914      * in RPA060WK since there are no mid month dates in CR130HS*.
000156050914      ***
000157050912
000158020319     c                   if        *inl1
000206050912     c                   clear                   totrpcmrt
000207050912     c                   clear                   cntrpcmrt
000208050912     c                   clear                   totrpmcnt
000209050912     c                   clear                   totrppprm
000210050912     c                   clear                   totrppcom
000211050707     c                   end
000405010403
000406050913      * accumulate totals from commission history
000407050913
000408050913     c                   add       rpcmrt        totrpcmrt
000409130604      * 6/4/13 - only count if rate is not zero. some mid month
000410130604      *          adj have zero
000411130604     c                   if        rpcmrt <> 0
000412050913     c                   add       1             cntrpcmrt
000413130604     c                   end
000414130604
000415050913     c                   add       rpmcnt        totrpmcnt
000416050913     c                   add       rppprm        totrppprm
000417050913     c                   add       rppcom        totrppcom
000418050913
000419050914     cl1                 if        cntrpcmrt <> 0
000420050913     cl1                 exsr      #l1tot
000421050914     cl1                 end
000422010403
000423050913      ***********************************************************
000424050914      * At end of commission totals for this t/s/a/p/effYM
000425050913      * get remittance totals for compare
000426050913      ***********************************************************
000500050913     c     #l1tot        begsr
000514050914
000515050914      * total comrate divided by # of records in this L1
000516050913     c                   eval      comratdiv  = totrpcmrt / cntrpcmrt
000517050915     c                   clear                   cr130found
000518050915     c                   clear                   ccome
000519050915     c                   clear                   combase
000520050915     c                   clear                   combaseneg
000522050913
000523050915     c     crkey         setll     rpa091wk
000524050915     c                   dou       %eof(rpa091wk)
000525050915     C     crkey         reade     rpa091wk
000526050913
000528050913      *     if (com rate / # of lines) *ne com base
000529050913      * and (com rate / # of lines) *ne com base negative
000530050913      * and com base *ne 0
000531050913      * then it is an error
000532050914
000533050915     c                   if        (not %eof(rpa091wk))
000534050915     c                   eval      combase    = ccomp * 100
000535050915     c                   eval      combaseneg = combase * -1
000536050915     c                   move      'Y'           cr130found
000537050915
000538050915     c                   if        comratdiv <> combase and
000539050913     c                             comratdiv <> combaseneg and
000540050913     c                             combase   <> 0
000541050913     C                   exsr      writexldet
000542050913     c                   end
000543050915
000544050915     c                   end
000545050913
000546050913     c                   enddo
000547050913
000548050915      * show missing remittance
000549050915     c                   if        cr130found <> 'Y'
000550050915     C                   exsr      writexldet
000551050915     c                   end
000552050915
000600050913     c                   endsr
0007000509130313 C*
0008000509130164 C*************************************************************
0009000509130164 C*                                                           *
0010000509130164 C* Write Spreadsheet Detail                                  *
0011000509130164 C*                                                           *
0012000509130164 C*************************************************************
001300050913     C     Writexldet    BEGSR
001400050913
001500050913     c                   clear                   rpa090fld
001501050914     c                   movel     rpefm         rpefmy
001502050914     c                   move      rpefy         rpefmy
001503050914
001504050915     c                   if        cr130found = 'Y'
001600050913     C                   Eval      rpa090fld  =                            '"' +
001700050913     C                             %char(rptrst)                       + '","' +
001701050913     C                             %char(rpsub)                        + '","' +
001702050913     C                             %char(rpacc)                        + '","' +
001703050913     C                             rpplan                              + '","' +
001704050915     C                             rppcar                              + '","' +
001705050915     C                             %trim(rpgrp)                        + '","' +
001706050914     C                             %trim(%editw(rpefmy:'  /    '))     + '","' +
001707050913     C                             %trim(%editc(totrpcmrt:'L'))        + '","' +
001708050913     C                             %trim(%editc(cntrpcmrt:'L'))        + '","' +
001709050913     C                             %trim(%editc(comratdiv:'L'))        + '","' +
001710050913     C                             %trim(%editc(combase:'L'))          + '","' +
001712050913     C                             %trim(%editc(totrppcom:'L'))        + '","' +
001713050913     C                             %trim(%editc(ccome:'L'))            + '",'
002500050915     c                   else
002501050915     C                   Eval      rpa090fld  =                            '"' +
002502050915     C                             %char(rptrst)                       + '","' +
002503050915     C                             %char(rpsub)                        + '","' +
002504050915     C                             %char(rpacc)                        + '","' +
002505050915     C                             rpplan                              + '","' +
002506050915     C                             rppcar                              + '","' +
002507050915     C                             %trim(rpgrp)                        + '","' +
002508050915     C                             %trim(%editw(rpefmy:'  /    '))     + '","' +
002509050915     C                             %trim(%editc(totrpcmrt:'L'))        + '","' +
002510050915     C                             %trim(%editc(cntrpcmrt:'L'))        + '","' +
002511050915     C                             %trim(%editc(comratdiv:'L'))        + '","' +
002512050916     C                             nffield                             + '","' +
002514050915     C                             %trim(%editc(totrppcom:'L'))        + '","' +
002515050916     C                             nffield                             + '",'
002516050915     c                   end
002517050915
002600050913     C                   Write     rpa090r
0027000509130320 C                   ENDSR
002800050913     C*
003000050913     C*************************************************************
003100050913     C*                                                           *
003200050913     C* Write Spreadsheet heading                                 *
003300050913     C*                                                           *
003400050913     C*************************************************************
003500050913     C     Writexlhead   BEGSR
003600050913
003700050913     c                   clear                   rpa090fld
003800050913     C                   Eval      rpa090fld =                    '"' +
003801050914     C                             'T'                        + '","' +
003900050914     C                             'S'                        + '","' +
004000050914     C                             'A'                        + '","' +
004100050914     C                             'PLAN'                     + '","' +
004200050914     C                             'CARR'                     + '","' +
004300050914     C                             'GROUP'                    + '","' +
004400050914     C                             'EFFECTIVE'                + '","' +
004401050913     C                             'RATE-com'                 + '","' +
004402050913     C                             '# OF REC-com'             + '","' +
004403050913     C                             'RATE / # OF REC-com'      + '","' +
004404050913     C                             'RATE-rem'                 + '","' +
004406050913     C                             'COM TOTAL-com'            + '","' +
004407050913     C                             'COM TOTAL-rem'            + '",'
004600050913     C                   Write     rpa090r
004700050913     C*
0048000509130320 C                   ENDSR
0049000509130103 C***************************************************
0050000509130104 C* FIRST CYCLE                                     *
0051000509130105 C***************************************************
0052000509130106 C     *INZSR        BEGSR
005201050913
005300050913     C                   Exsr      Writexlhead
005301050913
005302050913     c     crkey         klist
005303050913     c                   kfld                    rptrst
005304050913     c                   kfld                    rpsub
005305050913     c                   kfld                    rpacc
005306050913     c                   kfld                    rpplan
005307050913     c                   kfld                    rpefy
005308050913     c                   kfld                    rpefm
005400050913     C                   endsr
