000100000000      *_________________________________________________________________________
000200000000      *
000300050307      *  Description:  FTP AS/400 ESI file to C:\FTPFOLDER
000400000000      *
000500000000      *  (c)Copyright 2000 by Innovative Outsourcing, Inc.
000600000000      *
000700001107      *   This program will create the FTP INPUT file FTP statements
000800050307      *   and build the result file name as ESI*RXT.txt
000900001107      *
001000010424      *   Here's how it works...  ftpsherman is a virtual directory that
001100010323      *     is located on the 10.1.0.4 server, IS has set up a pointer
001200010424      *      from ftpsherman to the C:\ftpfolder that way, when
001300010424      *      a file is put into ftpsherman the file is actually placed
001400010424      *      in the C:\ftpfolder directory on Darlene's PC.
001500010323      *
001600010424      *    Created by:  JALLEN - April 24, 2001
001700000000      *_________________________________________________________________________
001800010424     FFTPINPUT  O  A E             DISK
001900050307     D @CMD            S             40A   DIM(3) CTDATA
002000001107     D @STD            S             40A   DIM(4) CTDATA
002100050307     D @STDA           S             40A   DIM(2) CTDATA
002200050307     D @FILE           S             20A
002300050307
002400050307    ?D  DateISO        S               D   datfmt(*ISO)                         Input Request
002500050307     D WDS             ds
002600050307     D WDATE                   1      8S 0
002700050307     D WCC                     1      2A
002800050307     D WYY                     3      4A
002900050307     D WMM                     5      6A
003000050307     D WDD                     7      8A
003100001107
003200010424     C     *Entry        Plist
003300010424     C                   Parm                    Counter          10 0
003400050307
003500050307     C     *Date         Mult      10000.0001    wdate
003600050307     C     *ISO          Move      wdate         DateISO
003700050420     C                   subdur    1:*d          DateISO
003800050408     C****** 7:00PM RFR  subdur    1:*d          DateISO
003900050307     C     *YMD          Move      DateISO       wdate
004000050307
004100001107      * Build FTP Open statements.
004200010424     C                   Select
004300010424     C                   When      Counter = 0
004400001107     C                   DO        2             X                 2 0
004500010424     C                   MOVEL(P)  @STD(X)       FLD80
004600010424     C                   WRITE     FTPINR
004700001107     C                   ENDDO
004800010424     C                   When      Counter = 1
004900010424     C                   DO        2             X                 2 0
005000010424     C                   MOVEL(P)  @STDA(X)      FLD80
005100010424     C                   WRITE     FTPINR
005200010424     C                   ENDDO
005300010424     C                   Endsl
005400001107
005500001107      * Build PUT statement
005600050307     C                   DO        3             X
005700010424     C                   MOVEL(P)  @CMD(X)       FLD80
005800050307     C                   EVAL      FLD80 = %trim(FLD80) +
005900050307     C                                     wmm + wdd + wyy + '.txt'
006000010424     C                   WRITE     FTPINR
006100001107     C                   ENDDO
006200001107
006300001107      * Build QUIT statement
006400001107     C                   Z-ADD     2             X
006500001107     C                   DO        2
006600001107     C                   ADD       1             X
006700010424     C                   MOVEL(P)  @STD(X)       FLD80
006800010424     C                   WRITE     FTPINR
006900001107     C                   ENDDO
007000001107      *
007100001107     C                   MOVE      *ON           *INLR
007200001107** CTDATA @CMD
007300050307put qs36f/esitrxt sg
007400050307put qs36f/ezitrxt dz
007500050307put qs36f/egitrxt se
007600001107** CTDATA @STD
007700001107anonymous anonymous@gbsio.net
007800010424cd ftpsherman
007900001107close
008000001107quit
008100010424** CTDATA @STDA
008200010424anonymous anonymous@gbsio.net
008300030403cd ftpananton
