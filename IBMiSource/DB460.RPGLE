0000031012010002 F*********************************************************************
0000041012010003 F* db460      GROUP BENEFIT SERVICES, INC.                           *
0000051012010004 F*                                                                   *
0000061012010005 F*            WRITTEN BY - DAVID KETTERMAN                           *
0000071012010006 F*            DATE - 12/01/10                                        *
0000081012010007 F*                                                                   *
0000121012010011 F* this program will list the cancelled accounts with a balance not  *
0000141012010011 F* zero or non-invoiced transactions so admin can see what invoices  *
0000151012010011 F* will be generated for cancelled accoutns ahead of time.           *
0000261012010011 F*                                                                   *
000027131003     F* 10/03/13 dlk - hist file expansion, recompile only.
0000281310030011 F*                                                                   *
0000301012010013 F*********************************************************************
000032050228      *
0001000111260005 Faccmst    ip   e           k disk
0001011012010005 Fhistinv   if   e           k disk
0001021012010005 Ftrsmst    if   e           k disk
0001081011240017 Fdb460xl   o  a e             DISK
000117050303
0001180503040125 Dcsv              c                   const('","')
0001191012010052 Dtotbal           s              9  2
0001201012010052 Dnoninvyn         s              1
0001211012010052 Datrmdy           s              8  0
0001221012010055 D                 DS
0001231012010056 D  BAL                    1    108  2
000124101201     D                                     DIM(12)
0001251012010056 D  BAL1                   1      9  2
0001261012010056 D  BAL2                  10     18  2
0001271012010056 D  BAL3                  19     27  2
0001281012010056 D  BAL4                  28     36  2
0001291012010056 D  BAL5                  37     45  2
0001301012010056 D  BAL6                  46     54  2
0001311012010056 D  BAL7                  55     63  2
0001321012010056 D  BAL8                  64     72  2
0001331012010056 D  BAL9                  73     81  2
0001341012010056 D  BAL10                 82     90  2
0001351012010056 D  BAL11                 91     99  2
0001361012010056 D  BAL12                100    108  2
000137050302     D                 dS
0001380503020125 D  tsa                    1     10  0
0001390503010125 D  actrst                 1      3  0
0001400503010125 D  acsub#                 4      6  0
0001410503010125 D  acacct                 7     10  0
000142101201
000143101201      * must be active (billable) trust
000144101201     C     ACtrst        CHAIN     trsmst
000145101201     C                   If        %found(trsmst) and trdltd = 'A'
000146101201
0001481012010144 C                   XFOOT     BAL           TOTBAL
000149101201     c                   clear                   noninvyn
000150101201     C     ACCKEY        CHAIN     histinv
000151101201     C                   If        %found(histinv)
000152101201     c                   move      'Y'           noninvyn
000153101201     c                   end
000154101201
000155101201      * if acct bal <> 0 or there are un invoiced transactions in hist
000156101201      * then write this acct to the spredsheet
000157101201     C                   If        noninvyn = 'Y' or totbal <> 0
000158101201     C                   MOVE      atrmdt        @DATIN
000159101201     C                   EXSR      #DATYM
000160101201     C                   MOVE      @DATOU        atrmdy
000161101201     C                   exsr      writexldet
000162101201     c                   end
000163101201
000164101201     c                   end
000831050301
0009340503040164 C*************************************************************
0009350503040164 C*                                                           *
0009360503040164 C* Write Spreadsheet Detail                                  *
0009370503040164 C*                                                           *
0009380503040164 C*************************************************************
000939050304     C     Writexldet    BEGSR
000940050304
000941101124     c                   clear                   db460fld
000942101124     C                   Eval      db460fld  = '"' +
000945050304     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
000946101201     C                             %trim(acnam1)                        + csv +
000947101201     C                             %trim(%editw(ATRMDY:'0  /  /    '))  + csv +
000948101210     C                             %trim(%editc(totbal:'N':*cursym))    + csv +
000949101201     C                             noninvyn                             + csv +
000953101201     C                             %Trim(' ')                   + '",'
000954050304     C*
000955101124     C                   Write     db460xr
0009560503040320 C                   ENDSR
000957050304     C*
000958050304     C/EJECT
000959050304     C*************************************************************
000960050304     C*                                                           *
000961050304     C* Write Spreadsheet heading                                 *
000962050304     C*                                                           *
000963050304     C*************************************************************
000964050304     C     Writexlhead   BEGSR
000965050304
000966101124     c                   clear                   db460fld
000967101201     C                   Eval      db460fld = '"' +
000969101201     C                             'ACCOUNT #'                      + csv +
000970101201     C                             'ACCOUNT NAME'                   + csv +
000971101201     C                             'CANCEL DATE'                    + csv +
000972101201     C                             'BALANCE'                        + csv +
000973101201     C                             'NON-INVOICED ADJ'               + csv +
000976101201     C                             ' '                              + '",'
000977101124     C                   Write     db460xr
000978050304     C*
0009790503040320 C                   ENDSR
0009801012010103 C***************************************************
0009811012010104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0009821012010105 C***************************************************
0009831012010107 C*
0009841012010107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0009851012010107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0009861012010107 C*
0009871012010106 C     #DATYM        BEGSR
000988101201     C                   MOVE      @DATIN        @MD               4 0
000989101201     C                   MOVEL     @DATIN        @Y                4 0
000990101201     C                   MOVEL     @MD           @DATOU            8 0
000991101201     C                   MOVE      @Y            @DATOU
000992101201     C                   MOVE      *ZEROS        @DATIN            8 0
0009931012010120 C                   ENDSR
000994101201     C*
000995050302      *******************************************
000996011126     c     *inzsr        begsr
000997050302      *******************************************
000998050304
000999050304     C                   Exsr      Writexlhead
001000050302
001002050228     c     acckey        klist
001003011126     c                   kfld                    actrst
001004011126     c                   kfld                    acsub#
001005011126     c                   kfld                    acacct
001006011126     c                   endsr
