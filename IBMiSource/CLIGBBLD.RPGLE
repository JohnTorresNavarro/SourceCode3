0001000204020002  *****************************************************************************
000200050915      * CLIGBBLD   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400050915      *            DATE - 09/2005                                                 *
000500050915      *  DESCRIPTION - Build file of current Clinical Assocs                      *
000600020402      *                Eligibility.                                               *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900060308      *  RLJ  03/08/2006  Don't populate address and phone# for deps  *
0010009102150018 F******************************************************************
001100050916     FMEMAC#1   IF   E           K DISK
001200050916     FMCOV22    IF   E           K DISK
001300050916     FDCOVC     IF   E           K DISK
001400020404     FDEPNDC    IF   E           K DISK
001500050916     FCLIPXL    IF   E           K DISK
0016000509160020 FCLIGBDP   UF A E           K DISK
0017000509160020 FCLIGBPP   UF A E           K DISK
0018000204020025  *
0019009102150250 D                 DS
0020000509160251 D  mcovtp                 1      3
0021000509160251 D   mcovtp2               2      3
0022000509160025  *
0023000509160250 D                 DS
0024000509160251 D  daddr1                 1     30
0025000509160251 D   daddr14               1      4
0026000509160025  *
0027000509160250 D                 DS
0028000510170251 D  dseq                          2S 0 INZ(0)
0029000510170251 D  cutoff                         D   DATFMT(*ISO)
0030000510170251 D  cutofn                        8S 0
0031000510170251 D  updt                          1A
003200051017      *
0033000509160251 D  ktrst                              LIKE(mbtrst)
0034000509160251 D  ksub#                              LIKE(mbsub#)
0035000509160251 D  kacct                              LIKE(mbacct)
003600050916      *
0037000509160251 D  ekmid#                             LIKE(cgmid#)
0038000509160251 D  ekseq#                             LIKE(cgseq#)
003900050916      *
0040000509160251 D  svadr1                             LIKE(cgadr1)
0041000509160251 D  svadr2                             LIKE(cgadr2)
0042000509160251 D  svcity                             LIKE(cgcity)
0043000509160251 D  svst                               LIKE(cgst)
0044000509160251 D  svzip                              LIKE(cgzip)
0045000509160251 D  svphn                              LIKE(cgphn)
004600050916      *
004700060220      *
004800060220     C     memky         klist
004900060220     C                   kfld                    ktrst
005000060220     C                   kfld                    ksub#
005100060220     C                   kfld                    kacct
005200060220      *
005300050916     C     dcvky         klist
005400050916     C                   kfld                    dssno
005500050916     C                   kfld                    dpseq#
005600050916      *
005700050916     C     mcvky         klist
005800050916     C                   kfld                    mbtrst
005900050916     C                   kfld                    mbsub#
006000050916     C                   kfld                    mbacct
006100050916     C                   kfld                    mbssno
006200050916      *
006300060220     C     eckey         klist
006400060220     C                   kfld                    ekmid#
006500060220     C                   kfld                    ekseq#
006600020415      *
0067000602200291  *   Preprocessing
0068000602200297 C                   z-add     590           ktrst
0069000602200297 C                   z-add     8             ksub#
0070000602200297 C                   z-add     1             kacct
007100020402      *
0072000204020291  * Main Line - Loop thru plan master
0073000509160297 C     memky         setll     memac#1                            21
0074000204020296 C                   dou       *in21 = '1'
0075000509160297 C     memky         reade     memac#1                                21
0076000602170296 C                   If        *in21 = '0' and nonemp <> 'Y'
0077000509160296 C                   If        termdt = 0 or termdt > 20050801
0078000204040291  *
0079000509160291 C                   exsr      bldmbr
0080000509160291 C                   exsr      chkdep
0081000509160296 C                   endif
0082000509160296 C                   endif
0083000509160296 C                   enddo
008400050916      *
0085000509160296 C                   move      '1'           *inlr
0086000509160296 C                   return
0087000207230291  *
0088000204020107  ********************************************************************************
0089000204020107  *
0090000204020107  *     BLDMBR - Build Member record
0091000204020107  *
0092000204020107  ********************************************************************************
009300020402     C     bldmbr        begsr
0094000204150107  *      First see if member record exists
009500050916     C                   movel     mbssno        ekmid#
009600050916     C                   movel     '00'          ekseq#
0097000509160291  *
0098000509160297 C     eckey         chain     cligbdp                            62
0099000509160296 C                   If        *in62 = '1'
0100000509160291  *         If member doesn't exist - build record
010100050916     C                   clear                   cligbdr
010200050916     C                   movel     mbssno        cgmid#
010300050916     C                   movel     '00'          cgseq#
010400050916     C                   movel     mfname        cgfnme
010500050916     C                   movel     mlname        cglnme
010600050916     C                   move      mmi           cgmi
010700050916    *C
010800050916    *C                   MOVEL(P)  addr1         cgadr1
010900050916    * *
011000050916     C                   movel     addr2         cgadr2
0111000509160107  *
011200050916     C                   movel     cgadr1        svadr1
011300050916     C                   movel     cgadr2        svadr2
011400050916     C                   movel     city          cgcity
011500050916     C                   movel     cgcity        svcity
011600050916     C                   move      state         cgst
011700050916     C                   move      cgst          svst
011800050916     C                   movel     zip           cgzip
011900050916      *
012000050916     C                   movel     cgzip         svzip
012100050916     C                   movel     area          cgphn
012200050916     C                   move      phone         cgphn
012300050916     C                   movel     cgphn         svphn
012400050916     C                   z-add     birth         cgbrdt
012500050916     C                   move      sex           cggndr
012600050916     C                   z-add     empdt         cgdoh
012700060227     C                   z-add     termdt        cgterm
012800050916      *
012900050916     C                   if        mardt <> 0
013000050916     C                   movel     'M'           cgmarst
013100050916     C                   else
013200050916     C                   movel     'S'           cgmarst
013300050916     C                   endif
013400050916      *
013500050916     C                   if        mcobpn <> *blanks
013600050916     C                   movel     'Y'           cgcobm
013700050916     C                   else
013800050916     C                   movel     'N'           cgcobm
013900050916     C                   endif
014000050916      *
014100050916     C                   movel     'N'           cgcobd
014200050916     C                   movel     'N'           cgcobv
0143000509160291  *
014400050916     C                   write     cligbdr
0145000509160291  *
014600050916     C                   exsr      bldmpl
0147000509160291  *
014800050916     C                   endif                                                  *in62 = '0'
0149000509160107  *
015000050916     C                   endsr
0151000509160107  ********************************************************************************
0152000509160107  *
0153000509160107  *     BLDMPL - Build Member Plan record
0154000509160107  *
0155000509160107  ********************************************************************************
015600050916     C     bldmpl        begsr
0157000509160107  *
0158000509160297 C     mcvky         setll     mcov22                             42
0159000509160296 C                   dou       *in42 = '1'
0160000509160297 C     mcvky         reade     mcov22                                 42
0161000509160296 C                   If        *in42 = '0' and mbssno = mcssno
016200050916      *
016300050916     C                   clear                   cligbpr
016400050916     C                   movel     mcssno        cbmid#
016500050916     C                   eval      cbseq# = '00'
016600050916     C     mcplan        chain     clipxl                             64
016700050916     C                   If        *IN64 = '0'
016800050916     C                   eval      cblmpl = cxlum
016900050916     C                   endif
017000050916     C                   eval      cbgbsm = mcplan
017100050916     C                   eval      cbgbel = mcovtp2
017200050916      *
017300050916     C                   if        cbgbel = 'IN'
0174000509160296 C                   eval      cblmel = 'P00'
0175000509160296 C                   else
017600050916     C                   if        cbgbel = 'PC'
0177000509160296 C                   eval      cblmel = 'P01'
0178000509160296 C                   else
017900050916     C                   if        cbgbel = 'HW'
0180000509160296 C                   eval      cblmel = 'F00'
0181000509160296 C                   else
018200050916     C                   if        cbgbel = 'FA'
0183000509160296 C                   eval      cblmel = 'F99'
0184000509160296 C                   else
018500050916     C                   if        cbgbel = 'P2'
0186000509160296 C                   eval      cblmel = 'P99'
0187000509160296 C                   endif
0188000509160296 C                   endif
0189000509160296 C                   endif
0190000509160296 C                   endif
0191000509160296 C                   endif
019200050916     C                   eval      cbeff = enrldt
019300050916     C                   eval      cbterm = candt
0194000509160296 C                   write     cligbpr
019500050916      *
019600050916      *
0197000509160296 C                   endif
0198000509160107  *
0199000509160296 C                   enddo
0200000509160107  *
020100050916     C                   endsr
0202000204150107  ********************************************************************************
0203000204040107  *
0204000509160107  *     CHKDEP - Build Dependent Record
0205000204040107  *
0206000204040107  ********************************************************************************
020700050916     C     chkdep        begsr
0208000509160291  *        Get Dependent records
0209000509160297 C     mbssno        setll     depndc                             47
0210000509160296 C                   dou       *in47 = '1'
0211000509160297 C     mbssno        reade     depndc                                 47
0212000509160296 C                   If        *in47 = '0' and dssno = mbssno
0213000509160291 C                   exsr      blddep
0214000509160296 C                   endif
0215000509160296 C                   enddo
0216000509160291  *
021700050916     C                   endsr
0218000509160107  ********************************************************************************
0219000509160107  *
0220000509160107  *     BLDDEP - Build Dependant record
0221000509160107  *
0222000509160107  ********************************************************************************
022300050916     C     blddep        begsr
0224000509160107  *      First see if member record exists
022500050916     C                   movel     dssno         ekmid#
022600050916     C                   movel     dpseq#        ekseq#
0227000509160291  *
0228000509160297 C     eckey         chain     cligbdp                            62
0229000509160296 C                   If        *in62 = '1'
0230000509160291  *         If Dep doesn't exist - build record
023100050916     C                   clear                   cligbdr
023200050916     C                   movel     dssno         cgmid#
023300050916     C                   movel     dpseq#        cgseq#
023400050916     C                   movel     dfname        cgfnme
023500050916     C                   movel     dlname        cglnme
023600050916     C                   move      dmi           cgmi
023700050916    * *
023800060308    *C                   movel     *blanks       cgadr1
023900060308     C                   movel     *blanks       cgadr2
024000060308     C                   movel     *blanks       cgcity
024100060308     C                   move      *blanks       cgst
024200060308     C                   movel     *blanks       cgzip
024300060308     C                   movel     *blanks       cgphn
024400060308    * *
0245000603080296 C**************     If        daddr14 = 'SAME'
024600060308    *C****               movel     svadr1        cgadr1
024700060308     C****               movel     svadr2        cgadr2
024800060308     C****               movel     svcity        cgcity
024900060308     C****               move      svst          cgst
025000060308     C****              movel     svzip         cgzip
025100060308     C****               movel     svphn         cgphn
0252000603080296 C****               else
025300060308    *C****               movel     daddr1        cgadr1
025400060308     C****               movel     daddr2        cgadr2
025500060308     C****               movel     dcity         cgcity
025600060308     C****               move      dstate        cgst
025700060308     C****               movel     dzip          cgzip
025800060308     C****               movel     darea         cgphn
025900060308     C****               move      dphone        cgphn
026000060308     C************       endif
026100050916      *
026200050916     C                   z-add     dbirth        cgbrdt
026300050916     C                   move      dsex          cggndr
026400050916      *
0265000509160296 C                   If        drelcd = 'HU' or drelcd = 'WI'
026600050916     C                   movel     'S'           cgdrel
026700050916     C                   else
026800050916     C                   movel     'C'           cgdrel
0269000509160296 C                   endif
027000050916      *
027100050916     C                   movel     dstudn        cgdstf
027200050916     C                   movel     *blanks       cgdscn
027300050916     C                   movel     dhndcp        cgdhan
027400050916     C                   z-add     0             cgdhdt
027500060227     C                   z-add     termdt        cgterm
0276000509160291  *
027700050916     C                   write     cligbdr
0278000509160291  *
027900050916     C                   exsr      blddpl
0280000509160291  *
028100050916     C                   endif                                                  *in62 = '0'
0282000509160107  *
028300050916     C                   endsr
0284000509160107  ********************************************************************************
0285000509160107  *
0286000509160107  *     BLDDPL - Build Dep Plan record
0287000509160107  *
0288000509160107  ********************************************************************************
028900050916     C     blddpl        begsr
0290000509160107  *
0291000509160297 C     dcvky         setll     dcovc                              43
0292000509160296 C                   dou       *in43 = '1'
0293000509160297 C     dcvky         reade     dcovc                                  43
0294000509160296 C                   If        *in43 = '0' and ssno = dssno
029500050916      *
029600050916     C                   clear                   cligbpr
029700050916     C                   movel     ssno          cbmid#
029800050916     C                   movel     dseq#         cbseq#
029900050916     C     dvplan        chain     clipxl                             64
030000050916     C                   If        *IN64 = '0'
030100050916     C                   eval      cblmpl = cxlum
030200050916     C                   endif
030300050916     C                   eval      cbgbsm = dvplan
030400050916     C                   eval      cbeff = denrdt
030500050916     C                   eval      cbterm = ccandt
0306000509160296 C                   write     cligbpr
030700050916      *
0308000509160296 C                   endif
0309000509160107  *
0310000509160296 C                   enddo
0311000509160107  *
031200050916     C                   endsr
