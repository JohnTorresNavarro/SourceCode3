000100001003    ? *_________________________________________________________________________
000200001003    ? *                                                                *
000300120423    ? *  Description:  FM060_2AR will either fetch or update the CAFIC *
000400120423    ? *                field in ACCMST depending on the flag in the    *
000500120423    ? *                PLIST.  CAFIC is the PRINT INVOICE field which  *
000600120423    ? *                holds a flag the value of which determines      *
000700120423    ? *                whether a paper or paperless invoice is sent.   *
000800001003    ? *                                                                *
000900120423    ? *  (c)Copyright 2012 by GBS, Inc.                                *
001000051129    ? *  This document contains restricted materials of GBS,Inc.       *
001100001003    ? *                                                                *
001200051129    ? *  Written by:    S. Zien                                        *
001300120423    ? *  Date Written:   4/23/12                                       *
001400090730    ? *                                                                *
001500051212    ? *  History:                                                      *
001600120718    ? *            Revised by -  szz                                   *
001700120718    ? *            Date -        07.18.2012                            *
001800120718    ? *            Revision -    'B' should be the default per Dave A  *
001900120718    ? *                            (only for non-Senior Dental).       *
002000120718    ? *                                                                *
002100120718      *_____________________________________________
002200120718      *From: Dave Abeshouse
002300120718      *Sent: Wednesday, July 18, 2012 10:44 AM
002400120718      *To: Susie Zien; Dave Ketterman; Jon Allen; Claire LaNoue
002500120718      *Subject: RE: before I forget - to think about Monday morning
002600120718      *
002700120718      *Senior Dental does not change.  The new default for all
002800120718      *others will be B
002900130926      *
003000130926      * 09/26/13 dlk - History file expansion
003100160811      *
003200160811      * 8/11/2016 - B.Rees   Adding new field. OLDT06
003300180109      *  01/09/2018 rlj Add logic for Adv Mbl - check TSCODE for Dental.
003400200115      *  01/15/2020 rlj Add logic for CSMi - check TSCODE for Dental.
003500160811      *
003600081017    ? *________________________________________________________________*    ____
003700120425     FACCMST    UF   E           K Disk
003800120425     FTRSMST    IF   E           K Disk
003900120425     FHIST      O  A E           K Disk    Usropn
004000160811      *------------------------------------------------------
004100120425     D                 DS
0042001204250125 D  TSAKEY                 1     10  0
004300120425     D   K_TRST                1      3  0
004400120425     D   K_SUB#                4      6  0
004500120425     D   K_ACCT                7     10  0
004600120425    *** LOCAL DATA AREA
004700120425     D                UDS
004800130926     D  @USER                100    109
004900120425      *
005000120425     D NOTE2S          S                   Like(NOTE2)
005100120425     D CK#NOTS         S                   Like(CK#NOT)
005200120423     D Fetch           S              1    Inz('F')
005300120423     D Update          S              1    Inz('U')
005400120423     D Error           S              1    Inz('E')
0055001309260037 D sysdateymd      S               d   datfmt(*iso)
005600160811br01 D Sav_OLDT06      S              4
005700160811br01 D HistNote_2      S              1
005800160811      *------------------------------------------------------
005900160811
006000120423     C                   Move      W_TRST        K_TRST
006100120423     C                   Move      W_SUB#        K_SUB#
006200120423     C                   Move      W_ACCT        K_ACCT
006300120423     C     AccKey        Chain     ACCMST
006400120423     C                   If        %Found(ACCMST)
006500120427
006600160811br01 C                   eval      Sav_OLDT06 = oldt06
006700160811
006800120427     C                   If        FetchUpdFlag = 'F'
006900120427     C                   Eval      W_CAFIC = CAFIC
007000120427     C                   If        %trim(W_CAFIC) = *blanks
007100120427     C     K_TRST        Chain     TRSMST
007200200115     C                   If        TSCODE <> 'O N' and TSCODE <> 'O_M' and
007300200115     C                             TSCODE <> 'O D'
007400120718     C****************   Eval      W_CAFIC = 'P'
007500120718     C****************   Eval      CAFIC = 'P'
007600120718     C                   Eval      W_CAFIC = 'B'
007700120718     C                   Eval      CAFIC = 'B'
007800120427     C                   Update    ACCMSR
007900120427     C                   Else
008000120718     C                   Eval      W_CAFIC = 'O'
008100120718     C                   Eval      CAFIC = 'O'
008200120427     C                   Update    ACCMSR
008300120427     C                   End
008400120427     C                   End
008500120427    ?C                   Move      *On           *InLR
008600120427     C                   Return
008700120427     C                   End
008800120427
008900120425     C                   If        CAFIC   <>  W_CAFIC
009000120425     C                   Eval      HistNote =  'Y'
009100120425     C                   End
009200160811     C
009300160811br01 C                   eval      HistNote_2 = 'N'
009400160811 |   C                   if        Oldt06 <> W_Oldt06
009500160811 |   C                   eval      HistNote_2 = 'Y'
009600160811br01 C                   endif
009700160811     C
009800120425     C                   Select
009900120425     C                   When      %Trim(CAFIC) = 'N'
010000120507     C                   Eval      CK#NOTS= 'No Print'
010100120425     C                   When      %Trim(CAFIC) = 'P'
010200120507     C                   Eval      CK#NOTS = 'Print'
010300120425     C                   When      %Trim(CAFIC) = 'O'
010400120507     C                   Eval      CK#NOTS = 'Print w/o Fee'
010500120716     C                   When      %Trim(CAFIC) = 'B'
010600120716     C                   Eval      CK#NOTS = 'Print w/o Fee'
010700120425     C                   EndSl
010800120425     C                   Select
010900120425     C                   When      %Trim(W_CAFIC) = 'N'
011000120507     C                   Eval      NOTE2S = 'No Print'
011100120425     C                   When      %Trim(W_CAFIC) = 'P'
011200120507     C                   Eval      NOTE2S = 'Print'
011300120425     C                   When      %Trim(W_CAFIC) = 'O'
011400120507     C                   Eval      NOTE2S = 'Print w/o Fee'
011500120716     C                   When      %Trim(W_CAFIC) = 'B'
011600120716     C                   Eval      NOTE2S = 'Print w/o Fee'
011700120425     C                   Endsl
011800120425     C     K_TRST        Chain     TRSMST
011900200115     C                   If        TSCODE <> 'O N' and TSCODE <> 'O M' and
012000200115     C                             TSCODE <> 'O D'
012100120424     C                   If        W_CAFIC      =   *Blank
012200120718     C***************    Eval      W_CAFIC      =   'P'
012300120718     C***************    Eval      CAFIC        =   'P'
012400120718     C                   Eval      W_CAFIC      =   'B'
012500120718     C                   Eval      CAFIC        =   'B'
012600120425     C                   Update    ACCMSR
012700120425     C                   End
012800120425     C                   Else
012900120718     C                   Eval      W_CAFIC      =   'O'
013000120718     C                   Eval      CAFIC        =   'O'
013100120425     C                   Update    ACCMSR
013200120425     C                   End
013300120424     C     AccKey        Chain     ACCMST
013400120424     C                   If        W_CAFIC      =   'P'     Or
013500120424     C                             W_CAFIC      =   'N'     Or
013600120716     C                             W_CAFIC      =   'O'     Or
013700120716     C                             W_CAFIC      =   'B'
013800120424     C                   Select
013900120423     C                   When      FetchUpdFlag =   Fetch
014000120423     C                   Eval      W_CAFIC      =   CAFIC
014100120423     C                   When      FetchUpdFlag =   Update
014200120423     C                   Eval      CAFIC        =   W_CAFIC
014300160811br01 C                   Eval      OLDT06       =   W_OLDT06
014400120423     C                   Update    ACCMSR
014500160811     C
014600120425     C                   If        HistNote     = 'Y'
014700120425     C                   Exsr      WriteHist
014800120425     C                   Eval      HistNote     = 'N'
014900120425     C                   End
015000160811     C
015100160811br01 C                   If        HistNote_2   = 'Y'
015200160811 |   C                   Exsr      WriteHist2
015300160811 |   C                   Eval      HistNote_2   = ' '
015400160811br01 C                   End
015500160811     C
015600160811     C
015700120423     C                   EndSl
015800120423     C                   Else
015900120423     C                   Eval      FetchUpdFlag = Error
016000120423     C                   End
016100120424     C                   End
016200120425     C                   Close     HIST
016300100323    ?C                   Move      *On           *InLR
016400100902     C                   Return
016500120425      *___________________________________________________________________
016600120425      * Write History Record
016700120425      *___________________________________________________________________
016800120425     C     WriteHist     Begsr
016900120425     C                   Clear                   HISTR
017000120425     C                   Move      TSAKey        HKEY
017100120425     C                   Eval      TRCODE = 'BID'
017200120425     C                   Eval      TRAMT  = *Zeros
017300120425     C                   Eval      HDSEQ# = *Zeros
017400130926     C                   Eval      HPRGNM = 'FM060_2RA'
017500120425     C                   Eval      HSTRST = K_TRST
017600120425     C                   Eval      HSSUB# = K_SUB#
017700120425     C                   Eval      HSACCT = K_ACCT
017800120425     C                   Eval      NOTE2  = NOTE2S
017900120425     C                   Eval      CK#NOT = CK#NOTS
018000130926     C                   Eval      HOPER  = @USER
018100120425     C                   Eval      HSDLTD = 'A'
018200120425     C                   Eval      HINVDT = *Zeros
018300120425     C                   Eval      RECVDT = *Zeros
018400130926     C                   eval      sysdateymd = %date
018500130926     C                   MOVE      sysdateymd    trdate
018600130926     c                   eval      hstrtime = %time
018700120425     C                   Write     HISTR
018800160811     C
018900160811     C
019000120425     C                   Endsr
019100160811      *___________________________________________________________________
019200160811br01 C     WriteHist2    Begsr
019300160811     C
019400160811     C                   Clear                   HISTR
019500160811     C                   Move      TSAKey        HKEY
019600160811     C                   Eval      TRCODE = 'BAF'
019700160811     C                   Eval      TRAMT  = *Zeros
019800160811     C                   Eval      HDSEQ# = *Zeros
019900160811     C                   Eval      HPRGNM = 'FM060_2RA'
020000160811     C                   Eval      HSTRST = K_TRST
020100160811     C                   Eval      HSSUB# = K_SUB#
020200160811     C                   Eval      HSACCT = K_ACCT
020300160811     C                   Eval      CK#NOT = Sav_OLDT06
020400160811     C                   Eval      NOTE2  = W_OLDT06
020500160811     C                   Eval      HOPER  = @USER
020600160811     C                   Eval      HSDLTD = 'A'
020700160811     C                   Eval      HINVDT = *Zeros
020800160811     C                   Eval      RECVDT = *Zeros
020900160811     C                   eval      sysdateymd = %date
021000160811     C                   MOVE      sysdateymd    trdate
021100160811     c                   eval      hstrtime = %time
021200160811     C                   Write     HISTR
021300160811     C                   Endsr
021400160811     C
021500120423    ? *________________________________________________________________
021600051129    ? * Key Lists
021700051129    ? *________________________________________________________________
021800051129    ?C     Klist         Begsr
021900090303    ? *
022000120423     C     AccKey        Klist
022100120423     C                   Kfld                    K_TRST
022200120423     C                   Kfld                    K_SUB#
022300120425     C                   Kfld                    K_ACCT
022400100903    ? *
022500061121    ?C                   Endsr
022600100902    ? *___________________________________________________________________
022700100902    ? * Parameter list
022800100902    ? *___________________________________________________________________
022900100902    ?C     PLIST         Begsr
023000100902    ?C     *ENTRY        Plist
023100120423     C                   Parm                    W_TRST            3
023200120423     C                   Parm                    W_SUB#            3
023300120423     C                   Parm                    W_ACCT            4
023400120423     C                   Parm                    W_CAFIC           1
023500160811br01 C                   Parm                    W_OLDT06          4
023600120423    ?C                   Parm                    FetchUpdFlag      1
023700100902    ?C                   Endsr
023800020726    ? *________________________________________________________________
023900020726    ? * Initialization
024000020726    ? *________________________________________________________________
024100001003    ?C     *INZSR        Begsr
024200120425     C                   Open      HIST
024300021007     C     *DATE         Mult      10000.0001    Today             8 0
024400120425     C                   Move      'N'           HistNote          1
024500001003    ?C                   Endsr
