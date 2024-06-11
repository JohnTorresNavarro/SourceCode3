0001009408170002 F******************************************************************
0002000011130003 F* IQ030      GROUP BENEFIT SERVICES SOFTWARE           2000      *
0003009408170004 F*                                                                *
0004000008150005 F*            WRITTEN BY - Rick Jones                             *
0005000011090006 F*            DATE - 11/09/2000                                   *
0006009408170007 F*                                                                *
0007000008150008 F*  DESCRIPTION - Allows Lookup for T/S/A for Invoice Summary#    *
000800070711     F*                                                                *
000900070711     F*  DMA  07.11.07  Adjusted because inv# rolled from 6 to 7       *
001000070711     F*                                                                *
0011009408170011 F******************************************************************
0012009408170012 F*                                                                *
0013000011130013 FIQ030FM   CF   E             WORKSTN
0014000011090015 FHISTTCD   IF   E           K DISK
0015000008150015 FACCMST    IF   E           K DISK
0016000011100015 FMEMBER    IF   E           K DISK
001700000815      *
001800981118     D                 DS
001900981118     D  EFIDT                  1      8  0
002000981118     D  EFICY                  1      4  0
002100981118     D  EFIMM                  5      6  0
002200981118     D  EFIDD                  7      8  0
002300001109      *
002400001109     D                 DS
002500001109     D  KHIST                  1     30
002600070711     D   KHIST1                1      5    INZ('INV#-')
002700070711     D   KHIST2                6     12
002800001109     D   KHIST3               13     30    INZ(*BLANKS)
002900001110      *
003000001110     D                 DS
003100001110     D  HKEY                   1     10
003200001110     D   HKEY1                 1      1
003300001110     D   HKEY2N                2     10  0
003400001109      *
003500001109     D                 DS
003600001109     D  IINVNM                 1      7  0 INZ(*ZERO)
003700070711     D   INVNM6                1      7  0
003800000815      *
003900950126     D COMPAN          DS
004000000815      *  DATA AREA - COMPANY NAME
004100940921     D  COMP                   1     55
004200000815      *
004300000815     C     *DTAARA       DEFINE                  COMPAN
004400000815     C                   IN        COMPAN
004500000815     C                   MOVEL     COMP          COMPNY
004600000815    ? *___________________________________________________________________
004700000815    ? * Key lists
004800000815    ? *___________________________________________________________________
004900000815    ?C     AKEY          Klist
005000000815    ?C                   Kfld                    KTRST
005100000815    ?C                   Kfld                    KSUB#
005200000815    ?C                   Kfld                    KACCT
005300000815    ? *
005400000815    ?C     *LIKE         Define    ACTRST        KTRST
005500000815    ?C     *LIKE         Define    ACSUB#        KSUB#
005600000815    ?C     *LIKE         Define    ACACCT        KACCT
005700000815    ? *
005800000815     C     SCN001        TAG
005900000815      *
006000940817     C                   EXFMT     SCRN01
006100950127     C                   SETOFF                                       88
0062000008150076  *
0063000008150077  *  ON CMD 7 END
0064000008150078  *
0065009409210079 C     *IN07         IFEQ      '1'
0066009409210080 C                   SETON                                        LR
0067000008150080 C                   RETURN
006800940921     C                   END
0069000008150076  *
007000001109     C                   MOVEL     *BLANKS       KHIST
007100001109     C                   MOVEL     'INV#- '      KHIST1
007200001109     C                   EVAL      KHIST2 = %EDITC(INVNM6 : '3')
007300000815      *
007400001109     C     KHIST         CHAIN     HISTTCD                            88
007500000815     C   88              GOTO      SCN001
0076000011100078  *
0077000011100079 C     HKEY1         IFEQ      ' '
0078000011100080 C                   SETOFF                                       21
007900001110     C     HKEY2N        CHAIN     MEMBER                             88
008000001110     C   88              GOTO      SCN001
008100001110     C                   ELSE
008200000815      *
0083000011100080 C                   SETON                                        21
008400001109     C                   z-add     HSTRST        KTRST
008500001109     C                   z-add     HSSUB#        KSUB#
008600001109     C                   z-add     HSACCT        KACCT
008700000815      *
008800000815     C     AKEY          CHAIN     ACCMST                             88
008900000815     C   88              GOTO      SCN001
0090000011100150  *
009100001110     C                   ENDIF
009200000815      *
009300940817     C                   EXFMT     SCRN02
0094000008150150  *
0095000008150150  * CMD1 RETURN
0096000008150150  *
009700940921     C     *IN01         IFEQ      '1'
0098000011100152 C                   MOVEL     *ZEROS        IINVNM
0099000011100152 C                   GOTO      SCN001
010000940921     C                   END
0101000008150076  *
0102000008150077  *  ON CMD 7 END
0103000008150078  *
0104000008150079 C     *IN07         IFEQ      '1'
0105000008150080 C                   SETON                                        LR
0106000008150080 C                   RETURN
010700000815     C                   END
0108000008150076  *
