000100910215     H DFTNAME(FL080)
0002009910220013  **************************************************************************
0003009910220003  *                  CARRIER MASTER FILE                                   *
0004009910220004  *                                                                        *
0005009910220005  *  FILE LABEL - CARMST                ORGANIZATION - INDEXED             *
0006009910220006  *  FILE NAME - C.CARMST               KEY LENGTH - 3                     *
0007009910220007  *  FILE RECORD LENGTH - 256           KEY START POSITION - 1             *
0008009910220008  *                                                                        *
0009009910220009  *  DESCRIPTION - THE CARRIER MASTER FILE CONTAINS NAME,                  *
0010009910220010  *       ADDRESS AND OTHER INFORMATION FOR EACH CARRIER.                  *
0011009910220011  *                                                                        *
001200991022      *       09/28/98 GSP  The following changes are a result of Y2K update.  *
0013009910220012  *                                                                        *
001301991022      *       MODIFIED by Kimberly S. Johnson 10/22/99                          *
001302991022      *               Added Proration Rule Field                                *
0013039910220012  *                                                                        *
0014009910220013  **************************************************************************
0015009910220014 FCARMST    IF   E           K DISK
0015019910220014 FPRRULE    IF   E           K DISK
001601991022     FFL080P    O    E             PRINTER OFLIND(*IN80)
001602991022
0017009102150047 D                UDS                                                       COMPNY
0018009102150048 D  CONAME               201    240                                         COMPNY
002000991022
002001991022     C                   EVAL      *IN80 = *ON
002003991022     C                   READ      CARMSR                                 90
002004991022     C                   DOW       *IN90 = *OFF
002005991022     C                   IF        CADLTD = 'A'
002006991022     C                   IF        *IN80 = *ON
002007991022     C                   WRITE     HDR
002008991022     C                   EVAL      *IN80 = *OFF
002009991022     C                   ENDIF
002010991022     C                   WRITE     DTL1
002011991022     C                   IF        CNAMEC <> *BLANKS
002012991022     C                   WRITE     DTL2
002013991022     C                   ENDIF
002014991022     C                   WRITE     DTL3
002015991022     C                   IF        CADDR2 <> *BLANKS
002016991022     C                   WRITE     DTL4
002017991022     C                   ENDIF
002018991022     C     CPRRUL        CHAIN     PRRULR                             50
002019991022     C                   IF        *IN50
002020991022     C                   CLEAR                   RLNAM
002021991022     C                   ENDIF
002022991022     C                   WRITE     DTL5
002023991022     C                   ENDIF
002024991022     C                   READ      CARMSR                                 90
002025991022     C                   ENDDO
002026991022     C                   EVAL      *INLR = *ON
