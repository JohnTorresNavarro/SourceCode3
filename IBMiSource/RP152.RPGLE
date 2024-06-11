000001991014     H DFTNAME(RP152)
000002991015      ******************************************************************
000003000414      * RP152      GROUP BENEFIT SERVICES SOFTWARE           1990      *
000004991015      *                                                                *
000005991015      *            BASTARDIZED FROM RP151 08/91                        *
000006991015      *                                                                *
000007991015      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE A FILE FOR SUBSCRIBERS*
000008991015      *                ATTAINING ?? YRS AGE.                           *
000009991015      *                                                                *
000010991015      *                                                                *
000011991015      *  Y2K CONVERT - 1998                                            *
000012991015      *                                                                *
000013991014      *  10/99 - KSJ - COVERTED TO RPGLE                               *
000014100301      * 03/01/10 szz - Exclude On-site Dental (Trust Category Code N)
000015100301      *                 per Shelly R. and Dave A.
000016991015      ******************************************************************
001700991004     FMEMBER    IF   E           K DISK
001800991014     FMCOV      IF   E           K DISK
001900991004     FPLNMST    IF   E           K DISK
001901100301     FTRSMST    IF   E           K DISK
002000991004     FRP15XWK   O    E           K DISK
002001991014
002002991014     D                 DS
002003991014     DDATE                     1      8  0
002004991014     D  YY                     1      4  0
002005991014     D  MM                     5      6  0
002006991014     D  DD                     7      8  0
002100990929
002200990929     D                 DS
002300990930     DDATE2                    1      8  0
002400990929     D  YYDTE                  1      4  0
002500990929     D  MMDTE                  5      6  0
002600990929     D  DDDTE                  7      8  0
003300990929
003301991001     D                 DS
003302991001     D UD8YMD                  1      8  0
003303991006     D   UD8Y                  5      8  0
003304991001
003305991004     D                 DS
003306991014     D MYYMM                   1      6  0
003307991014     D   MYY                   1      4  0
003308991014     D   MMM                   5      6  0
003309991004
003400990929     D                UDS
003401991001     D LTRUST                  3      5
003402991001     D LSUB                    6      8
003403991001     D LACC                    9     12
003500991001     D LFMMYY                 13     18  0
003600991001     D   LFMM                 13     14  0
003700991001     D   LFYY                 15     18  0
003801991001     D LTMMYY                 19     24  0
003802991001     D   LTMM                 19     20  0
003803991001     D   LTYY                 21     24  0
003804991008     D LAGE                   25     26  0
004400990929
004417990930     DDTECMP           S              8  0
004418991014     DFIRST            S              1
004419991014     DMAGE             S              3  0
004420991015     DXAGE             S              4  0
004421991004     DTRUSTC           S              3
004422991004     DSUBC             S              3
004423991004     DACCTC            S              4
004424991006     DVALID            S              1
004425991006     DCHKSS#           S              9  0
007600990929
007602990930     C     PLNKEY        KLIST
007603990930     C                   KFLD                    MBTRST
007604990930     C                   KFLD                    MBSUB#
007605991014     C                   KFLD                    MCPLAN
007610991006
007611991001     C                   EVAL      UD8YMD = *DATE
007612991001
007613991014     C                   IF        LFMMYY <> *ZEROS
007614991014     C                   EVAL      YY = LFYY
007615991014     C                   EVAL      MM = LFMM
007616991014     C                   EVAL      DD = 01
007617991014     C                   ELSE
007618991014     C                   EVAL      DATE = UD8YMD
007619991014     C                   ENDIF
007620991014
007621991014     C                   READ      MEMBR                                  99
007622991001     C                   DOW       *IN99 = *OFF
007700991014     C                   IF        %SUBST(STATUS:1+1) <> 'D'
007701991014
007702991014      *  IF THERE IS A TERMDT DATE MAKE SURE
007703991014      *  THE RUN DATE IS LESS THEN  THE TERMDT DATE
007704991014     C                   IF        TERMDT <> *ZEROS
007705991014     C                   IF        LFMMYY <> *ZEROS
007706991014     C                   EVAL      MMDTE = LFMM
007707991014     C                   EVAL      DDDTE = 01
007708991014     C                   EVAL      YYDTE = LFYY
007709991014     C                   EVAL      DTECMP = DATE2
007710991014     C                   ELSE
007711991014     C                   EVAL      DTECMP = DATE
007712991014     C                   ENDIF
007713991014     C                   ENDIF
007714991014
008600990929      *
008700990929      *  IF THE DATE TYPED IN IS ZERO  AND AGE IS 65 PRINT ALL PEOPLE
008800990929      *  WHO ARE 65 AND OLDER IF IT IS ANY AGE BUT 65 AND DATE IS
008900990929      *  ZERO PRINT ANYONE WHO IS THAT AGE.  IF THE DATE IS NOT ZERO
009000990929      *  PRINT ANYONE TURNING INPUT AGE
009100990929      *
009101991015     C                   MOVEL     BIRTH         MYYMM
009102991015     C                   EVAL      MAGE = *ZEROS
009103991015     C                   EVAL      XAGE = *ZEROS
009200991004     C                   IF        LFMMYY <> *ZEROS
009203991014     C                   IF        MMM >= LFMM AND MMM <= LTMM
009204991015     C                   IF        MYY <> *ZEROS
009205991015     C                   EVAL      XAGE = UD8Y - MYY
009206991015     C                   IF        XAGE > 999
009207991015     C                   EVAL      MAGE = 000
009208991015     C                   ELSE
009209991015     C                   EVAL      MAGE = XAGE
009210991015     C                   ENDIF
009211991015     C                   ENDIF
009300991014     C                   IF        MAGE = LAGE
009301991006     C                   EVAL      VALID = 'Y'
010100990930     C                   ENDIF
010101991006     C                   ENDIF
010200930125     C                   ELSE
010400991008     C                   IF        LAGE = 65
010401991015     C                   IF        MYY <> *ZEROS
010402991015     C                   EVAL      XAGE = UD8Y - MYY
010403991015     C                   IF        XAGE > 999
010404991015     C                   EVAL      MAGE = 000
010405991015     C                   ELSE
010406991015     C                   EVAL      MAGE = XAGE
010407991015     C                   ENDIF
010501991015     C                   ENDIF
010502991014     C                   IF        MAGE >= 65
010503991006     C                   EVAL      VALID = 'Y'
011300990930     C                   ENDIF
011301991006     C                   ELSE
011302991015     C                   IF        MYY <> *ZEROS
011303991015     C                   EVAL      XAGE = UD8Y - MYY
011304991015     C                   IF        XAGE > 999
011305991015     C                   EVAL      MAGE = 000
011306991015     C                   ELSE
011307991015     C                   EVAL      MAGE = XAGE
011308991015     C                   ENDIF
011309991015     C                   ENDIF
011310991014     C                   IF        MAGE = 65
011311991006     C                   EVAL      VALID = 'Y'
011400990930     C                   ENDIF
011401991006     C                   ENDIF
011402991006     C                   ENDIF
011600990929
011601991006     C                   IF        VALID = 'Y'
011900990929
011901991004     C                   MOVE      MBTRST        TRUSTC
011903991004     C                   MOVE      MBSUB#        SUBC
011905991004     C                   MOVE      MBACCT        ACCTC
011907991004
012000991004     C                   IF        (LTRUST = 'ALL' OR LTRUST = TRUSTC) AND
012001991004     C                             (LSUB = 'ALL' OR LSUB = SUBC) AND
012002991004     C                             (LACC = 'ALL ' OR LACC = ACCTC)
012500990929
015100990929      *
015200990929      *  ONLY TAKE PEOPLE WHO HAVE ACTIVE MEDICAL OR DENTAL PLANS
015300990929      *
015301991006     C                   IF        (TERMDT <> *ZEROS AND TERMDT > DTECMP) OR
015302991006     C                              TERMDT = *ZEROS
015400991014     C     MBSSNO        SETLL     MCOVR
015600991014     C     MBSSNO        READE     MCOVR                                  98
015601991006     C                   DOW       *IN98 = *OFF
015800991014     C                   IF        CANDT = *ZEROS
016400991006     C     PLNKEY        CHAIN     PLNMSR                             51
016401991006     C                   IF        *IN51 = *OFF
016500991001     C                   IF        PLNCAT = 'PMM' OR PLNCAT = 'PMS'
016700991001     C                             OR PLNCAT = 'PDN'
017304991014     C                   IF        CHKSS# <> MBSSNO
017305100301     C     MBTRST        Chain     TRSMST
017306100301     C                   If        TSCODE <> 'O N'
018100991001     C                   WRITE     RP15XR
018101100301     C                   End
018102991014     C                   EVAL      CHKSS# = MBSSNO
018103991014     C                   ENDIF
018202991001     C                   ENDIF
018203991001     C                   ENDIF
018204991001     C                   ENDIF
018205991014     C     MBSSNO        READE     MCOVR                                  98
018206991001     C                   ENDDO
018208991001     C                   ENDIF
018209991006     C                   ENDIF
018211991006     C                   EVAL      VALID = 'N'
018212991001     C                   ENDIF
018213991001     C                   ENDIF
018214991014     C                   READ      MEMBR                                  99
018215991001     C                   ENDDO
018300990929
018600991001     C                   EVAL      *INLR = *ON
