0001000204020002  *****************************************************************************
000200050114      * DW251G     Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400050114      *            DATE - 01/2005                                                 *
000500020403      *  DESCRIPTION - Compare Hold file with Current file to produce             *
000600020403      *                Transmission file                                          *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900020402      *                                                                *
0010009102150018 F******************************************************************
0011000509260020 FEGCUR2L   IF   E           K DISK
0012000509260020 FEGITR2D   O  A E             DISK
001300020402      *
0014000204051304  *        Set up the default fields
0015000204050273 C                   MOVE      'E'           ESRTYP
0016000501140274 C                   MOVEL     'A4'          ESMCAR
0017000501140274 C                   MOVEL     'SE'          ESSCAR
001800020405     C                   MOVE      '01'          ESDCOV
001900020405     C                   MOVE      'Y'           ESCN1
002000020405     C                   MOVE      'X'           ESCN2
0021000204050111 C*
0022000204050291  * Main Line - Loop thru current and hold file - comparing the 2
0023000509260297 C     *LOVAL        setll     egcur2l
0024000303310296 C                   dou       *in21 = '1'
002500020403      *
0026000509260297 C                   read      egcur2l                                21
0027000204030296 C                   If        *in21 = '1'
0028000408020296 C                   leave
0029000204030296 C                   endif
003000050818      *
0031000408020296 C                   exsr      puttrn
003200020405      *
0033000204050296 C                   enddo
003400020405      *
0035000204050296 C                   movel     '1'           *inlr
0036000204050296 C                   return
0037000204020107  ********************************************************************************
0038000204020107  *
0039000204050107  *     PUTTRN - Write the Express Scripts Transmittal record
0040000204020107  *
0041000204020107  ********************************************************************************
004200020405     C     puttrn        begsr
004300020405     C                   MOVEL     ecmid#        ESMID#
004400050926     C                   MOVEL     ecaltid       ESALTID
004500020405     C                   Z-ADD     ecsfx#        ESSFX#
004600020405     C                   MOVEL     eclnme        ESLNME
004700020405     C                   MOVEL     ecfnme        ESFNME
004800020405     C                   MOVE      ecmi          ESMI
004900020405     C                   MOVEL     ecadr1        ESADR1
005000020405     C                   MOVEL     ecadr2        ESADR2
005100020405     C                   MOVEL     eccity        ESCITY
005200020405     C                   MOVE      ecst          ESST
005300020405     C                   Z-ADD     eczip         ESZIP
005400020405     C                   Z-ADD     ecbrdt        ESBRDT
005500020405     C                   MOVE      ecgndr        ESGNDR
005600020405     C                   Z-ADD     ecefdt        ESEFDT
005700020405     C                   Z-ADD     ectfdt        ESTFDT
005800020405     C                   MOVEL     ecgrp#        ESGRP#
005900020405     C                   MOVE      ecf002        ESF002
006000050926     C                   WRITE     EGITR2R
006100020405     C                   endsr
