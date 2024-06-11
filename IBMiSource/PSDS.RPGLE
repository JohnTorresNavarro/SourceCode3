000001100827      * 07/23/10 dlk
000002100827      * This copy member can be copied into any program to define
000003100827      * the program status data structure. It was first created for
000004100827      * use in the automatic adjustment program TR260.
000100100723     Dpsds            sds
000200100723     D pgmname                       10a
000300100723     D pgmsts                         5s 0
000400100723     D pgmprvsts                      5s 0
000500100723     D pgmsrcstmt                     8a
000600100723     D pgmroutine                     8a
000700100723     D pgmparms                       3s 0
000800100723     D pgmmsgid                       7a
000900100723     D pgmmi#                         4a
001000100723     D pgmwork                       30a
001100100723     D pgmlib                        10a
001200100723     D pgmerrdta                     80a
001300100723     D pgmrpgmsg                      4a
001400100723     D Filler_01                     69a
001500100723     D pgmjob                        10a
001600100723     D pgmuser                       10a
001700100723     D pgmjobnum                      5s 0
001800100723     D pgmjobdate                     6s 0
001900100723     D pgmrundate                     6s 0
002000100723     D pgmruntime                     6s 0
