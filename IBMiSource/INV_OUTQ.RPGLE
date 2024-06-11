000100141103      *-------------------------------------------------------------------------
000200141110      *  Program        : INV_OUTQ
000300141103      *  Description    : House Clean outq QPRINT - for invoices more than
000400141103      *                   one month old.
000500141103      *  Written by     : Debora Bond                11/03/2014
000600141103      *-------------------------------------------------------------------------
000700141103      *  Modifications:
000800141103      *-------------------------------------------------------------------------
000900141103      *?prototypes
001000141103     D qcmdexc         pr                  extpgm('QCMDEXC')
001100141103     D  cmd                         256    const options(*varsize)
001200141103     D  cmdlength                    15  5 const
001300141103
001400141103      *?file layout for SPLF0300 format
001500141103       dcl-ds listds ;
001600141103        job_name char(10) ;
001700141103        user_name char(10) ;
001800141103        job_number char(6) ;
001900141103        splf_name char(10) ;
002000141103        splf_number int(10) ;
002100141103        splf_status int(10) ;
002200141103        date_opened char(7) ;
002300141103        time_opened char(6) ;
002400141103        splf_schedule char(1) ;
002500141103        splf_sys_name char(10) ;
002600141103        user_data char(10) ;
002700141103        form_type char(10) ;
002800141103        outq char(10) ;
002900141103        outq_lib char(10) ;
003000141103        aux_stg_pool int(10) ;
003100141103        splf_size int(10) ;
003200141103        splf_size_mult int(10) ;
003300141103        total_pages int(10) ;
003400141103        copies_to_print int(10) ;
003500141103        priority char(1) ;
003600141103        reserved char(3) ;
003700141103       end-ds ;
003800141103
003900141103      *?DS to retrieve offset
004000141103     D GeneralDS       DS           140    Inz
004100141103     D  InputSize            113    116B 0
004200141103     D  ListOffset           125    128B 0
004300141103     D  NumberOfList         133    136B 0
004400141103     D  EntrySize            137    140B 0
004500141103
004600141103      *?Stand alone fields
004700141103     D cmd             s            100
004800141103     D splf_date       s               d
004900141103     d StartPosit      s              9B 0
005000141103     d StartLen        s              9B 0
005100141103     d FormatName      s              8    inz('SPLF0300')
005200141103     d FormType        s             10    inz('*ALL')
005300141103     d UserData        s             10    inz('*ALL')
005400141103     d UserName        s             10    Inz('*ALL')
005500141103     d Index           s                   Like(NumberOfList) Inz(1)
005600141103     d SpaceSize       s              9B 0 inz(2024)
005700141103     d SpaceAttr       s             10
005800141103     d SpaceValue      s              1
005900141103     d SpaceAuth       s             10    Inz('*CHANGE')
006000141103     d SpaceText       s             50
006100141103     d SpaceReplc      s             10    Inz('*YES')
006200141103     d OutSpool        s             20    inz('QPRINT    QGPL')
006300141103
006400141103      *?API error data structure
006500141103     D ErrorDS         DS           116
006600141103     D  BytesProvd             1      4B 0
006700141103     D  BytesAvail             5      8B 0
006800141103     D  msgid                  9     15A
006900141103     D  Err#                  16     16A
007000141103     D  msgdta                17    116A
007100141103
007200141103     D InputDS         DS                  Inz
007300141103     D  UserSpace                    20
007400141103     D   SpaceName                   10    OverLay(UserSpace:1)
007500141103     D                                     Inz('OIDLT002')
007600141103     D   SpaceLib                    10    OverLay(UserSpace:11)
007700141103     D                                     Inz('QTEMP')
007800141103
007900141103      //--------------------------------------------------------------------
008000141103      // mainline logic
008100141103      //--------------------------------------------------------------------
008200141103       exsr create_user_space ;
008300141103       exsr populate_user_space ;
008400141103       exsr read_user_space ;
008500141103
008600141103       *inlr = *on ;
008700141103       return ;
008800141103
008900141103      //--------------------------------------------------------------------
009000141103      // create_user_space:  Create a user space in qtemp
009100141103      //--------------------------------------------------------------------
009200141103        begsr create_user_space ;
009300141103
009400141103     C                   call      'QUSCRTUS'
009500141103     C                   parm                    UserSpace
009600141103     C                   parm      *blanks       SpaceAttr
009700141103     C                   parm                    SpaceSize
009800141103     C                   parm      *blanks       SpaceValue
009900141103     C                   parm      '*ALL'        SpaceAuth
010000141103     C                   parm      *blanks       SpaceText
010100141103     C                   parm      '*YES'        SpaceReplc
010200141103     C                   parm                    ErrorDS
010300141103
010400141103        endsr ;
010500141103
010600141103      //--------------------------------------------------------------------
010700141103      // populate_user_space: Dump contents of QGPL/QPRINT to user space
010800141103      //--------------------------------------------------------------------
010900141103        begsr populate_user_space ;
011000141103
011100141103     C                   call      'QUSLSPL'
011200141103     C                   parm                    UserSpace
011300141103     C                   parm                    FormatName
011400141103     C                   parm                    UserName
011500141103     C                   parm                    OutSpool
011600141103     C                   parm                    FormType
011700141103     C                   parm                    UserData
011800141103     C                   parm                    ErrorDS
011900141103
012000141110        startposit = 1 ;
012100141110        startlen = 140 ;
012200141103
012300141103      //Get offset to first record in user space.
012400141103     C                   call      'QUSRTVUS'
012500141103     C                   parm                    UserSpace
012600141103     C                   parm                    StartPosit
012700141103     C                   parm                    StartLen
012800141103     C                   parm                    GeneralDS
012900141103     C                   parm                    ErrorDS
013000141103
013100141103         startposit = listoffset + 1 ;
013200141103         startlen = entrysize ;
013300141103
013400141103        endsr ;
013500141103
013600141103      //--------------------------------------------------------------------
013700141103      // read_user_space: Read contents of user space
013800141103      //--------------------------------------------------------------------
013900141103        begsr read_user_space ;
014000141103
014100141103         dow 1 = 1 ;
014200141103
014300141103          if index > numberoflist ;
014400141103           leave ;
014500141103          endif ;
014600141103
014700141103     C                   call      'QUSRTVUS'
014800141103     C                   parm                    UserSpace
014900141103     C                   parm                    StartPosit
015000141103     C                   parm                    StartLen
015100141103     C                   parm                    ListDS
015200141103     C                   parm                    ErrorDS
015300141103
015400141103          if msgid <> *blanks ;
015500141103           leave ;
015600141103          endif ;
015700141103
015800141103          if %subst(splf_name:1:6) = 'TR010P' and user_name <> 'DLK' and
015900141103           user_data = 'FULLYINSRD' ;
016000141103           splf_date = %date(%subst(date_opened:2:6):*ymd0) ;
016100141110           if %diff(%date():splf_date:*m) >= 1 ;
016200141103            cmd = 'dltsplf file(' + %trim(splf_name) + ') job(' +
016300141103            %trim(job_number) + '/' + %trim(user_name) + '/' +
016400141103            %trim(job_name) + ') splnbr(' +
016500141103            %trim(%editc(splf_number:'Z')) + ')' ;
016600141103            qcmdexc(cmd:%len(cmd)) ;
016700141103           endif ;
016800141103          endif ;
016900141103
017000141103          index += 1 ;
017100141103          startposit += entrysize ;
017200141103
017300141103         enddo ;
017400141103
017500141103        endsr ;
017600141103
