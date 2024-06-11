000100001107     H Indent ('| ')
000200990630      *? ***************************************************************
000300050509      *             GROUP BENIFIT SERVICES SOFTWARE           2005     *
000400010322      *                                                                *
000500000118      *  Written by:    S. Zien                                        *
000600050517      *  Date Written:  5/17/05                                        *
000700050517      *  Description:   Load Commission Paid Date if Update Mode       *
000800000118      *                                                                *
000900000118      *                                                                *
001000000118      *                R E V I S I O N    H I S T O R Y                *
001100000118      *  Date                                                          *
001200000118      *  Revised   Initials    Revision                                *
001300000118      *  --------  --------    --------------------------------------  *
001400050517      *   5/17/05    szz       Initial version.                        *
001500110526      *   4/19/11    dlk       change parm length                      *
001600110526      *   5/26/11    dlk       change the way the date is pulled from  *
001700110526      *                        the passed parm to fix error.           *
001800220901      *  09/01/22    dlk       add selection to only include bill files*
001900220901      *                        effective up to and including the       *
002000220901      *                        commission paid date so future bill file*
002100220902      *                        data is excluded.                       *
002200220901      *                                                                *
002300990630      *? ***************************************************************
002400010322
002500220906     FRPA060WK  UF   E           K Disk
002600050518      *
002700110526     Ddspmt            DS
002800110526     D wsdatechar              1      8
002900110526     D                UDS
003000010118     D  CONAME               201    250
003100991230    ? * Program status data structure
003200991230    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003300050517      *
003400050516     C                   Read      RPA060WK
003500050516     C                   Dou       %Eof(RPA060WK)
003600220906
003700220906     C                   If        Not %Eof(RPA060WK) and rpcpddt = 0
003800220901      * transaction effective date as YYYYMM only
003900220901     C                   Movel     RPEFDT        rpefdtym          6 0
004000220901      * update unpaid rec that meet the date selection
004100220906     C                   If        rpefdtym <= WSYYMM and
004200220901     c                             rpcdat <= wsdatelast
004300050517     C                   Eval      RPCPDDT   =   WSDATE
004400050516     C                   Update    RPA60R
004500050516     C                   Reset                   RPA60R
004600050516     C                   End
004700050516     C                   End
004800220906
004900050516     C                   Read      RPA060WK
005000050505     C                   Enddo
005100050516      *
005200050505     C                   Eval      *InLR = *On
005300050516
005400050517    ?C     PLIST         Begsr                                                  PARM LISTS
005500050517    ?C     *ENTRY        Plist                                                  *ENTRY LIST
005600110419    ?C                   Parm                    DSPMT            27            PMT - OUT   R
005700050517    ?C                   Endsr                                                  END PLIST
005800050517
005900050517    ?C     *INZSR        Begsr                                                  INITIALIZE
006000110526     C                   Movel     WSDATECHAR    WSdate            8 0
006100110526     C                   Movel     WSDATE        WSYYMM            6 0
006200220901
006300220906      * comm effdt selection on prompt screen as last day of month
006400220901     C                   Movel     WSDATECHAR    WSdatelast        8 0
006500220901     C                   Move      31            WSdatelast
006600050517    ?C                   Endsr                                                  END *INZSR
