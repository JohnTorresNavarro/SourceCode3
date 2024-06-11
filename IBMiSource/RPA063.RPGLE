0001009408170002 F******************************************************************
0002000008150003 F* RPA063     GROUP BENEFIT SERVICES SOFTWARE           2000      *
0003009408170004 F*                                                                *
0004000008150005 F*            WRITTEN BY - Rick Jones                             *
0005000011090006 F*            DATE - 11/09/2000                                   *
0006009408170007 F*                                                                *
0007000008150008 F*  DESCRIPTION - Allows Lookup for T/S/A for Invoice Summary#    *
0007010706220007 F* 06/22/07 dlk - allow 7 digit invoice #'s                       *
0008009408170011 F******************************************************************
0009009408170012 F*                                                                *
0010000008150013 FRPA063FM  CF   E             WORKSTN
0011000011090015 FHISTTCD   IF   E           K DISK
0012000008150015 FACCMST    IF   E           K DISK
0013000011100015 FMEMBER    IF   E           K DISK
001400000815      *
001500981118     D                 DS
001600981118     D  EFIDT                  1      8  0
001700981118     D  EFICY                  1      4  0
001800981118     D  EFIMM                  5      6  0
001900981118     D  EFIDD                  7      8  0
002000001109      *
002100001109     D                 DS
002200001109     D  KHIST                  1     30
002300070622     D   KHIST1                1      5    INZ('INV#-')
002400070622     D   KHIST2                6     12
002500001109     D   KHIST3               13     30    INZ(*BLANKS)
002600001110      *
002700001110     D                 DS
002800001110     D  HKEY                   1     10
002900001110     D   HKEY1                 1      1
003000001110     D   HKEY2N                2     10  0
003100001109      *
003200001109     D                 DS
003300001109     D  IINVNM                 1      7  0 INZ(*ZERO)
003400070622     D** INVNM6                2      7  0
003500000815      *
003600950126     D COMPAN          DS
003700000815      *  DATA AREA - COMPANY NAME
003800940921     D  COMP                   1     55
003900000815      *
004000000815     C     *DTAARA       DEFINE                  COMPAN
004100000815     C                   IN        COMPAN
004200000815     C                   MOVEL     COMP          COMPNY
004300000815    ? *___________________________________________________________________
004400000815    ? * Key lists
004500000815    ? *___________________________________________________________________
004600000815    ?C     AKEY          Klist
004700000815    ?C                   Kfld                    KTRST
004800000815    ?C                   Kfld                    KSUB#
004900000815    ?C                   Kfld                    KACCT
005000000815    ? *
005100000815    ?C     *LIKE         Define    ACTRST        KTRST
005200000815    ?C     *LIKE         Define    ACSUB#        KSUB#
005300000815    ?C     *LIKE         Define    ACACCT        KACCT
005400000815    ? *
005500000815     C     SCN001        TAG
005600000815      *
005700940817     C                   EXFMT     SCRN01
005800950127     C                   SETOFF                                       88
0059000008150076  *
0060000008150077  *  ON CMD 7 END
0061000008150078  *
0062009409210079 C     *IN07         IFEQ      '1'
0063009409210080 C                   SETON                                        LR
0064000008150080 C                   RETURN
006500940921     C                   END
0066000008150076  *
006700001109     C                   MOVEL     *BLANKS       KHIST
006800070622     C                   MOVEL     'INV#-'       KHIST1
006900070622     C                   EVALr     KHIST2 = %EDITC(IINVNM : 'Z')
007000000815      *
007100001109     C     KHIST         CHAIN     HISTTCD                            88
007200000815     C   88              GOTO      SCN001
0073000011100078  *
0074000011100079 C     HKEY1         IFEQ      ' '
0075000011100080 C                   SETOFF                                       21
007600001110     C     HKEY2N        CHAIN     MEMBER                             88
007700001110     C   88              GOTO      SCN001
007800001110     C                   ELSE
007900000815      *
0080000011100080 C                   SETON                                        21
008100001109     C                   z-add     HSTRST        KTRST
008200001109     C                   z-add     HSSUB#        KSUB#
008300001109     C                   z-add     HSACCT        KACCT
008400000815      *
008500000815     C     AKEY          CHAIN     ACCMST                             88
008600000815     C   88              GOTO      SCN001
0087000011100150  *
008800001110     C                   ENDIF
008900000815      *
009000940817     C                   EXFMT     SCRN02
0091000008150150  *
0092000008150150  * CMD1 RETURN
0093000008150150  *
009400940921     C     *IN01         IFEQ      '1'
0095000011100152 C                   MOVEL     *ZEROS        IINVNM
0096000011100152 C                   GOTO      SCN001
009700940921     C                   END
0098000008150076  *
0099000008150077  *  ON CMD 7 END
0100000008150078  *
0101000008150079 C     *IN07         IFEQ      '1'
0102000008150080 C                   SETON                                        LR
0103000008150080 C                   RETURN
010400000815     C                   END
0105000008150076  *
