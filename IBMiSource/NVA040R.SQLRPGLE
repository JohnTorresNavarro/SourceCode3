000100151216     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200141211    ? *-------------------------------------------------------------------------
000300000000    ? *
000400170727    ? *  Description:  NVA File Transfer Driver
000500141210    ? *  Programmer.:  Brian Rees
000600170727    ? *  Date.......:  07/27/2017
000700141210    ? *
000800170727    ? *  Notes:
000900170727    ? *    This will read through the CARACCP file for NVA Records
001000170727    ? *    (Uniq ID = '0000000115') and Active Records.
001100170727    ? *
001200170727    ? *    This will pass the file name to NVA040C to create the text
001300170727    ? *    file in the i:\ Drive.
001400170727    ? *
001500141211    ? *-------------------------------------------------------------------------
001600170727     D sqCid1          s             30
001700170727
001800170727
001900170727      *?Send FTP Data
002000170727     D FTP_Data        pr                  extpgm('NVA040CL')
002100170727     D   iFileName                   10
002200170727     D iFileName       s             10
002300170118
002400170727
002500141211    ? *-------------------------------------------------------------------------
002600151216      *?Mainline Program
002700141211    ? *-------------------------------------------------------------------------
002800151216
002900160804       Exec Sql  Set Option Commit=*NONE, Naming=*SYS;
003000160804
003100170727
003200170727
003300170727          Exec Sql   Declare C1 Cursor For
003400170727           Select distinct caCid1 FROM caraccp Where
003500170727           caUniq = '0000000115' and caStatus = 'Y'
003600180507           and cacid1 <> ''
003700170727           order by caCid1 ;
003800170727
003900170727
004000170727
004100170727          Exec Sql    Open C1;
004200170727
004300170727          Dou SqlCod <> *Zero;
004400170727
004500170727             Exec Sql  Fetch Next From C1 Into :sqCid1 ;
004600170727
004700170727             if SqlCod <> *Zero;
004800170727                leave;
004900170727             endif;
005000170727
005100170727             iFileName = %Subst(sqCid1:1:10) ;
005200170727             FTP_Data( iFileName );
005300170727
005400170727          enddo;
005500170727
005600170727          Exec Sql   Close C1;
005700170727
005800170727
005900170727          *inlr = *on;
