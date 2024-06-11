000100090904      *
000200090904      * 09/04/09 dlk - change the way the current date is retrieved so
000300090904      *                the system date is placed in the lda every time.
000400130924      * 09/24/13 dlk - add program status data structure to put full
000500130924      *                10 byte user id in lda for s/36 jobs to use.
000600131018      * 10/18/13 dlk - move user to lda 258 - 267 due to pos 256 and 257
000700131018      *                being used in other applications
000800210331      * 03/31/21 dlk - Change company name from:
000900210331      *                ***   GROUP BENEFIT SERVICES, INC.   ***
001000210331      *                TO:
001100210331      *                ***  AMWINS CONNECT ADMINISTRATORS   ***
001200210331      *
001300090904     H DATEDIT(*YMD)
0014009102150002 D NAM             S             40    DIM(1) CTDATA PERRCD(1)
0015000909040002 D systemdate      S               d   datfmt(*ISO)
001600130924      * Program status data strusture
001700130924      /copy gbspgm/qrpglesrc,psds
001800130924
0019009102150004 D                UDS
0020009102150005 D  NAME                 201    240
0021009102150006 D  PREFIX               241    241
0022009102150007 D  TIME                 242    247  0
0023009901170008 D  UD8YMD               248    255  0
0024001310180008 D**** RESERVED ******** 256    256    ** DO NOT USE - ASKMAILCL USE **
0025001310180008 D**** RESERVED ******** 257    257    ** DO NOT USE - CHKABRCL  USE **
0026001310180008 D  luser                258    267
002700990118     C*
0028009102150013 C                   TIME                    STIME            12 0
0029009102150014 C                   MOVEL     STIME         TIME              6 0
0030001309240014 C                   MOVEL     pgmuser       luser
003100990117     C*
003200990117     C* DATE TO LDA AS YYYYMMDD
003300990117     C*
003400090904      * put system date in systemdate field (*ISO = YYYYMMDD)
003500090904      /free
003600090904       systemdate = %date();
003700090904      /end-free
003800090904     C                   MOVE      systemdate    UD8YMD            8 0
003900090904
004000090904     C******             MOVE      *DATE         UD8YMD            8 0
0041009102150016 C                   MOVE      NAM(1)        NAME
004200990118     C*
004300990118     C* COMPANY PREFIX
004400990118     C*
0045009905010016 C                   MOVE      'F'           PREFIX
004600990118     C*
0047009102150019 C                   SETON                                        LR
004800990501** NAM - COMPANY NAME
004900210331***  AMWINS CONNECT ADMINISTRATORS   ***
