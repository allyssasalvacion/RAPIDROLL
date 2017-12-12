;;===========================================;;
;;                                           ;;
;;                                           ;;
;;                RAPID ROLL                 ;;
;;                                           ;;
;;   Allyssa Albores & Icel Ann Rodriguez    ;;
;;                                           ;;
;;                                           ;;
;;                                           ;;
;;===========================================;;

TITLE RAPIDROLL (SIMPLIFIED .EXE )
.MODEL SMALL
;-------------------------------------------------------------------------------------------------------
.STACK 100H
;-------------------------------------------------------------------------------------------------------

.DATA
  ;;----------------------------------------;;
  ;;           GAME TITLE SCREEN            ;;
  ;;               VARIABLES                ;;
  ;;----------------------------------------;;

  TITLE1   DB '  ****************************************************************************', 10, 13
  TITLE2   DB '  ||========================================================================||', 10, 13
  TITLE3   DB '  ||                                                                        ||', 10, 13
  TITLE4   DB '  ||  % % % %      %      % % % % % % % %     % % % %   % %   %      %      ||', 10, 13
  TITLE5   DB '  ||  %     %     % %     %     % % %    %    %     %  %   %  %      %      ||', 10, 13
  TITLE6   DB '  ||  %     %    %   %    %     % % %     %   %     % %     % %      %      ||', 10, 13
  TITLE7   DB '  ||  % % % %   % % % %   % % % % % %     %   % % % % %     % %      %      ||', 10, 13
  TITLE8   DB '  ||  %   %    %       %  %       % %    %    %   %    %   %  %      %      ||', 10, 13
  TITLE9   DB '  ||  %     % %         % %       % % % %     %     %   % %   % % %  % % %  ||', 10, 13
  TITLE10  DB '  ||                                                                        ||', 10, 13
  TITLE11  DB '  ||  --------------------------------------------------------------------  ||', 10, 13
  TITLE12  DB '  ||                                                                        ||', 10, 13
  TITLE13  DB '  ||                         Press Enter to PLAY                            ||', 10, 13
  TITLE14  DB '  ||                                                                        ||', 10, 13
  TITLE15  DB '  ||                     Press TAB for GAME INSTRUCTION                     ||', 10, 13
  TITLE16  DB '  ||                                                                        ||', 10, 13
  TITLE17  DB '  ||                          Press ESC to QUIT                             ||', 10, 13
  TITLE18  DB '  ||                                                                        ||', 10, 13
  TITLE19  DB '  ||========================================================================||', 10, 13
  TITLE20  DB '  ****************************************************************************$', 10, 13

  ;;----------------------------------------;;
  ;;           HOW TO PLAY SCREEN           ;;
  ;;               VARIABLES                ;;
  ;;----------------------------------------;;

  HOWTO1   DB '             The goal of the game is to dodge all moving platforms', 10, 13
  HOWTO2   DB '             Use LEFT KEY to MOVE LEFT', 10, 13
  HOWTO3   DB '             Use RIGHT KEY to MOVE RIGHT', 10, 13
  HOWTO4   DB '             There are 3 lives to lose.', 10, 13
  HOWTO5   DB '             The score will be based on the running time of the game$'

  HOWTO6   DB '             Press BACKSPACE to GO BACK$'

  ;;----------------------------------------;;
  ;;            GAME OVER SCREEN            ;;
  ;;               VARIABLES                ;;
  ;;----------------------------------------;;

  PLAY_AGAIN        DB 'Press Enter to PLAY AGAIN$'
  INSTRUCTION       DB 'Press TAB for GAME INSTRUCTION$'
  QUIT              DB 'Press ESC to QUIT$'
  GAMEOVER_BORDER1  DB '%%  %%% %%% %%% %%% %% %%% %%% %%  %%$'
  GAMEOVER_BORDER2  DB '%%                                 %%$'
  GAMEOVER_WORD     DB '%%  G  A  M  E    *    O  V  E  R  %%$'
  GAMEOVER_WORD_REP DB '%%  !  !  !  !      !  !  !  !  !  %%$'
  BORDER1           DB '****************************************************************************$'
  BORDER2           DB '============================================================================$'
  FLASH DB ?                                     ;flag1
  KEY_INPUT DB ?

  ;;----------------------------------------;;
  ;;               MAIN GAME                ;;
  ;;               VARIABLES                ;;
  ;;----------------------------------------;;

  BORDER1_GAME          DB '*************************************************$'
  TITLE1_SIDE_SCREEN    DB '%      RAPID ROLL     %$'
  TITLE2_SIDE_SCREEN    DB '%         1.0         %$'
  BORDER_SIDE_SCREEN    DB '%%%%%%%%%%%%%%%%%%%%%%%$'
  SCORE_TITLE           DB '  CURRENT SCORE:$'
  LIFE_TITLE            DB '  LIFE:$'
  HIGHEST_SCORE_TITLE   DB '  HIGHEST SCORE:$' 
  ESC_INS_SIDE_SCREEN   DB '  Press Esc to EXIT$'
  PAUSE_INS_SIDE_SCREEN DB '$'
  FINAL_SCORE           DB 0, '$'
  LIFE_LEFT             DB 3, '$'
  HIGHEST_SCORE         DB 0, '$'


  OBSTACLE       DB '*******$'                    ;obstacle/platform
  BALL           DB 153, '$'                      ;ball
  BALL_ROW       DB 04                            ;permanent row of ball
  BALL_COL       DB 34                            ;temporary column of ball

                                                  ;starting rows and cols of obstacles
  TEMP_R1_OBS    DB 5                             ;-----------------------1st row @row 5                    
  TEMP_R1C1_OBS  DB 34                            ;1st obstacle in 1st row starts @col 34
  TEMP_R2_OBS    DB 6                             ;-----------------------2nd row @row 6                     
  TEMP_R2C1_OBS  DB 18                            ;1st obstacle in 2nd row starts @col 18
                                                  ;-----------------------3rd row @row 7 has no obstacles
  TEMP_R4_OBS    DB 8                             ;-----------------------4th row @row 8                    
  TEMP_R4C1_OBS  DB 2                             ;1st obstacle in 4th row starts @col 2
  TEMP_R4C2_OBS  DB 43                            ;2nd obstacle in 4th row starts @col 43
  TEMP_R5_OBS    DB 9                             ;-----------------------5th row @row 9                     
  TEMP_R5C1_OBS  DB 13                            ;1st obstacle in 5th row starts @col 13                         
  TEMP_R6_OBS    DB 10                            ;-----------------------6th row @row 10                      
  TEMP_R6C1_OBS  DB 25                            ;1st obstacle in 6th row starts @col 25
  TEMP_R7_OBS    DB 11                            ;-----------------------7th row @row 11                     
  TEMP_R7C1_OBS  DB 38                            ;1st obstacle in 7th row starts @col 38
                                                  ;-----------------------8th row @row 12 has no obstacles 
  TEMP_R9_OBS    DB 13                            ;-----------------------9th row @row 13                      
  TEMP_R9C1_OBS  DB 9                             ;1st obstacle in 9th row starts @col 9
  TEMP_R10_OBS   DB 14                            ;-----------------------10th row @row 14                        
  TEMP_R10C1_OBS DB 33                            ;1st obstacle in 10th row starts @col 33
                                                  ;-----------------------11th row @row 15 has no obstacles 
  TEMP_R12_OBS   DB 16                            ;-----------------------12th row @row 16                   
  TEMP_R12C1_OBS DB 2                             ;1st obstacle in 12th row starts @col 2
  TEMP_R12C2_OBS DB 23                            ;2nd obstacle in 12th row starts @col 23
                                                  ;-----------------------13th row @row 17 has no obstacles
  TEMP_R14_OBS   DB 18                            ;-----------------------14th row @row 18               
  TEMP_R14C1_OBS DB 36                            ;1st obstacle in 14th row starts @col 36
  TEMP_R15_OBS   DB 19                            ;-----------------------15th row @row 19               
  TEMP_R15C1_OBS DB 10                            ;1st obstacle in 15th row starts @col 10
  TEMP_R16_OBS   DB 20                            ;-----------------------16th row @row 20               
  TEMP_R16C1_OBS DB 7                             ;1st obstacle in 16th row starts @col 7
  TEMP_R17_OBS   DB 21                            ;-----------------------17th row @row 21               
  TEMP_R17C1_OBS DB 21                            ;1st obstacle in 17th row starts @col 21
  TEMP_R17C2_OBS DB 38                            ;2nd obstacle in 17th row starts @col 38

  DELAY2_VAR     DB 20                            ;starting value of DELAY2

  ;;----------------------------------------;;
  ;;               HIGHSCORE                ;;
  ;;               VARIABLES                ;;
  ;;----------------------------------------;;

  SRCFILENAME      DB 'file.txt', 00H
  DESTFILENAME     DB 'file.txt', 00H

  SRCFILEHANDLE    DW ?
  DESTFILEHANDLE   DW ?

  SRCRECORD_STR    DB 5 DUP('$')
  DESTRECORD_STR   DB '$'

  ERROR1_STR       DB 'Error in opening file.$'
  ERROR2_STR       DB 'Error reading from file.$'
  ERROR3_STR       DB 'No record read from file.$'

  ERROR4_STR       DB 'Error in creating file.$'
  ERROR5_STR       DB 'Error writing in file.$'
  ERROR6_STR       DB 'Record not written properly.$'

  NUM              DW ?
  HIGHEST_SCORE_NUM DB ?
  VAR_ONES DB ?
  VAL DB ?
;-------------------------------------------------------------------------------------------------------
.CODE
  MAIN PROC FAR
    ;set DS to address of code segment
        MOV   AX, @DATA
        MOV   DS, AX

        MOV AL, 1
        MOV FLASH, AL
        CALL READ_FILE
        CALL TITLE_SCREEN
  MAIN ENDP
;-------------------------------------------------------------------------------------------------------
  READ_FILE PROC NEAR
        ;open file
        MOV AH, 3DH           ;requst open file
        MOV AL, 00            ;read only; 01 (write only); 10 (read/write)
        LEA DX, SRCFILENAME
        INT 21H
        JC DISPLAY_ERROR1
        MOV SRCFILEHANDLE, AX
        ;-------------------------------------
        ;read file
        MOV AH, 3FH            ;request read record
        MOV BX, SRCFILEHANDLE  ;file handle
        MOV CX, 5              ;record length
        LEA DX, SRCRECORD_STR  ;address of input area
        INT 21H
        JC DISPLAY_ERROR2
        CMP AX, 00             ;zero bytes read?
        JE DISPLAY_ERROR3
        ;-------------------------------------
        ;close file handle
        MOV AH, 3EH             ;request close file
        MOV BX, SRCFILEHANDLE   ;file handle
        INT 21H
  READ_FILE ENDP
;-------------------------------------------------------------------------------------------------------
  WRITE_FILE PROC NEAR
        ;create file
        MOV AH, 3CH            ;request create file
        MOV CX, 00             ;normal attribute
        LEA DX, DESTFILENAME   ;load path and file name
        INT 21H
        JC DISPLAY_ERROR4      ;if there's error in creating file, carry flag = 1, otherwise 0
        MOV DESTFILEHANDLE, AX
        ;-------------------------------------
        ;write file
        MOV AH, 40H            ;request write record
        MOV BX, DESTFILEHANDLE ;file handle
        MOV CX, 5              ;record length
        LEA DX, DESTRECORD_STR  ;address of output area
        INT 21H
        JC DISPLAY_ERROR5      ;if carry flag = 1, there's error in writing (nothing is written)
        CMP AX, 5              ;after writing, set AX to size of chars nga na write
        JNE DISPLAY_ERROR5
        ;-------------------------------------
        ;close file handle
        MOV AH, 3EH             ;request close file
        MOV BX, DESTFILEHANDLE  ;file handle
        INT 21H
        JMP RETURN6

        DISPLAY_ERROR1:
          MOV AH, 09
          LEA DX, ERROR1_STR
          INT 21H

          JMP EXIT

        DISPLAY_ERROR2:
          MOV AH, 09
          LEA DX, ERROR2_STR
          INT 21H

          JMP EXIT

        DISPLAY_ERROR3:
          MOV AH, 09
          LEA DX, ERROR3_STR
          INT 21H

          JMP EXIT

        DISPLAY_ERROR4:
          MOV AH, 09
          LEA DX, ERROR4_STR
          INT 21H

          JMP EXIT

        DISPLAY_ERROR5:
          MOV AH, 09
          LEA DX, ERROR5_STR
          INT 21H

          JMP EXIT

        DISPLAY_ERROR6:
          MOV AH, 09
          LEA DX, ERROR6_STR
          INT 21H

          JMP EXIT

        RETURN6:
          RET
  WRITE_FILE ENDP
;-------------------------------------------------------------------------------------------------------
  TITLE_SCREEN PROC NEAR
        CALL CLEAR_SCREEN
        CALL FORE_SCREEN

        MOV   DL, 00H                                   ;column start
        MOV   DH, 02H                                   ;row start
        CALL  SET_CURSOR

        MOV AH, 09H
        LEA DX, TITLE1
        INT 21H

        CALL DELAY
        CALL GET_KEY
        CALL COMPARE          
        
        JMP TITLE_SCREEN
  TITLE_SCREEN ENDP
;-------------------------------------------------------------------------------------------------------
  HOW_TO_PLAY_SCREEN PROC NEAR
        CALL CLEAR_SCREEN
        CALL FORE_SCREEN

        MOV   DL, 00H                                   ;column start
        MOV   DH, 03H                                   ;row start
        CALL  SET_CURSOR

        MOV AH, 09H
        LEA DX, HOWTO1
        INT 21H

        MOV   DL, 00H                                   ;column start
        MOV   DH, 12H                                     ;row start
        CALL  SET_CURSOR

        MOV AH, 09H
        LEA DX, HOWTO6
        INT 21H        

        CALL DELAY
        CALL GET_KEY
        CALL COMPARE          
        
        JMP HOW_TO_PLAY_SCREEN
  HOW_TO_PLAY_SCREEN ENDP
;-------------------------------------------------------------------------------------------------------
  GAMEOVER_SCREEN PROC NEAR
        CALL CLEAR_SCREEN                               ;call clear screen
        CALL FORE_SCREEN                                ;call forescreen

        CALL DISPLAY_WORDS                              ;display play again, instruction, quit
        CALL DELAY

        CALL GET_KEY
        CALL COMPARE

        MOV BL, HIGHEST_SCORE_NUM
        CMP FINAL_SCORE, BL
        JLE CONTINUE
        JMP RESET_HIGHEST_SCORE
        RESET_HIGHEST_SCORE:

        XOR AX, AX
        MOV AL, FINAL_SCORE
        ADC AH, 0
        MOV VAL, AX 
        MOV AX, VAL 
        CALL DISPLAY_NUM2
          
        CALL WRITE_FILE
        CALL READ_FILE

        CONTINUE:
          MOV AL, 3
          MOV LIFE_LEFT, AL
          MOV AL, 20
          MOV DELAY2_VAR, AL
          MOV AL, 0
          MOV FINAL_SCORE, 0
       
          JMP GAMEOVER_SCREEN

  GAMEOVER_SCREEN ENDP
;-------------------------------------------------------------------------------------------------------
STRING_TO_INT PROC NEAR
  
  RET
STRING_TO_INT ENDP
;-------------------------------------------------------------------------------------------------------
  CONVERT PROC NEAR
          MOV SI, OFFSET SRCRECORD_STR + 1
          MOV CL, [SI]
          MOV CH, 0
          ADD SI, CX

          MOV BX, 0
          MOV BP, 1

          L1: 
            MOV AL, [SI]
            SUB AL, 48
            MOV AH, 0
            MUL BP
            ADD BX, AX

            MOV AX, BP
            MOV BP, 10
            MUL BP
            MOV BP, AX

            DEC SI
            LOOP L1
          
          MOV HIGHEST_SCORE_NUM, BL
          CONTINUE5:
            RET 
  CONVERT ENDP  
;-------------------------------------------------------------------------------------------------------
  BACKGROUND_MAINGAME PROC NEAR
        CALL CLEAR_SCREEN                             ;calling clear screen function
        CALL FORE_SCREEN_GAME                         ;calling forescreen of the main game function
        CALL SIDE_SCREEN_TOP_GAME                     ;calling side screen top game function
        CALL SIDE_SCREEN_BOTTOM_GAME                  ;calling side screen bottom game fuction
        ;------DISPLAY TOP BORDER on the main game-------
        MOV   DL, 02                                  ;column start
        MOV   DH, 02                                  ;row start
        CALL  SET_CURSOR                              ;call set cursor
        MOV AH, 09H                                   ;displaying border on the main game
        LEA DX, BORDER1_GAME                                    
        INT 21H
        ;------DISPLAY BALL-------
        MOV   DL, BALL_COL                            ;column start
        MOV   DH, BALL_ROW                            ;row start
        CALL  SET_CURSOR                              ;call set cursor
        MOV AH, 09H                                   ;displaying the BALL
        LEA DX, BALL
        INT 21H
        ;--------------------------------------1ST ROW--------------------------------
        ;------DISPLAY OBST1 @R1------
        MOV   DL, TEMP_R1C1_OBS                       ;column start
        MOV   DH, TEMP_R1_OBS                         ;row start
        CALL  SET_CURSOR                              ;call set cursor

        CALL DISPLAY_OBS
        ;--------------------------------------2ND ROW--------------------------------                  
        ;------DISPLAY OBST4 @R2------
        MOV   DL, TEMP_R2C1_OBS                        ;column start
        MOV   DH, TEMP_R2_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS
        ;--------------------------------------3RD ROW HAS NO obstacles---------------           
        ;--------------------------------------4TH ROW--------------------------------                       
        ;------DISPLAY OBST6 @R4------
        MOV   DL, TEMP_R4C1_OBS                        ;column start
        MOV   DH, TEMP_R4_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS

        MOV   DL, TEMP_R4C2_OBS                        ;column start
        MOV   DH, TEMP_R4_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS
        ;--------------------------------------5TH ROW--------------------------------    
        MOV   DL, TEMP_R5C1_OBS                        ;column start
        MOV   DH, TEMP_R5_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS                                                                              
        ;--------------------------------------6TH ROW--------------------------------         
        ;------DISPLAY OBST8 @R6------
        MOV   DL, TEMP_R6C1_OBS                        ;column start
        MOV   DH, TEMP_R6_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS
        ;--------------------------------------7TH ROW--------------------------------                  
        ;------DISPLAY OBST9 @R7------
        MOV   DL, TEMP_R7C1_OBS                        ;column start
        MOV   DH, TEMP_R7_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS
        ;--------------------------------------8TH ROW has no obstacles---------------
        ;--------------------------------------9TH ROW--------------------------------
        ;------DISPLAY OBST10 @R9-----
        MOV   DL, TEMP_R9C1_OBS                        ;column start
        MOV   DH, TEMP_R9_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS
        ;--------------------------------------10TH ROW--------------------------
        ;------DISPLAY OBST11 @R10---
        MOV   DL, TEMP_R10C1_OBS                        ;column start
        MOV   DH, TEMP_R10_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS
        ;--------------------------------------11TH ROW has no obstacles---------
        ;--------------------------------------12H ROW---------------------------     
        ;------DISPLAY OBST12 @R12-------
        MOV   DL, TEMP_R12C1_OBS                        ;column start
        MOV   DH, TEMP_R12_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS

        MOV   DL, TEMP_R12C2_OBS                        ;column start
        MOV   DH, TEMP_R12_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS
        ;--------------------------------------13TH ROW has no obstacles-------------------------                                                             
        ;--------------------------------------14TH ROW--------------------------------------                                                             
        ;------DISPLAY OBST12 @R12-------
        MOV   DL, TEMP_R14C1_OBS                        ;column start
        MOV   DH, TEMP_R14_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS
        ;--------------------------------------15TH ROW--------------------------------------                                                             
        ;------DISPLAY OBST12 @R12-------
        MOV   DL, TEMP_R15C1_OBS                        ;column start
        MOV   DH, TEMP_R15_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS
        ;--------------------------------------16TH ROW--------------------------------------                                                             
        ;------DISPLAY OBST12 @R12-------
        MOV   DL, TEMP_R16C1_OBS                        ;column start
        MOV   DH, TEMP_R16_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS
        ;--------------------------------------17TH ROW--------------------------------------                                                             
        ;------DISPLAY OBST12 @R12-------
        MOV   DL, TEMP_R17C1_OBS                        ;column start
        MOV   DH, TEMP_R17_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS

        MOV   DL, TEMP_R17C2_OBS                        ;column start
        MOV   DH, TEMP_R17_OBS                          ;row start
        CALL  SET_CURSOR

        CALL DISPLAY_OBS
        ;---------------------------------------DISPLAY BOTTOM BORDER------------------------
        MOV   DL, 02                                    ;column start
        MOV   DH, 22                                    ;row start
        CALL  SET_CURSOR                                ;call set 

        MOV AH, 09H                                     ;display border1
        LEA DX, BORDER1_GAME                                    
        INT 21H

        CALL DELAY2
        CALL GET_KEY
        CALL MOV_BALL
        CALL DEC_TEMP_ROW
        CALL CHECK_HIT

        INC FINAL_SCORE

        JMP BACKGROUND_MAINGAME
  BACKGROUND_MAINGAME ENDP
;-------------------------------------------------------------------------------------------------------
  DISPLAY_OBS PROC NEAR
        MOV AH, 09H
        MOV BL, 03                                       ; hex value of yellow color
        MOV CX, 7                                        ;7 characaters of *
        INT 10H           
        MOV DX, OFFSET OBSTACLE
        INT 21H
        RET
  DISPLAY_OBS ENDP
;-------------------------------------------------------------------------------------------------------
  CHECK_HIT PROC NEAR
        ;jmp CMP_ROW2
        CMP_ROW1:
          CMP TEMP_R1_OBS, 04                           ;check row
          JNE CMP_ROW2
          JMP CMP_R1C1
        
        CMP_R1C1:
          MOV AL, TEMP_R1C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R1C1
          JMP RETURN_CHECK_HIT
          
          CMP_OBS_BOUND_R1C1:
            MOV BL, TEMP_R1C1_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER1
            JMP RETURN_CHECK_HIT

        GAME_OVER1:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER1_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT1
          
          GAME_OVER1_1:
            JMP GAME_OVER
        
        RETURN_CHECK_HIT1:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW2:
          CMP TEMP_R2_OBS, 04                           ;check row
          JNE CMP_ROW4

          JMP CMP_R2C1

        CMP_R2C1:
          MOV AL, TEMP_R2C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R2C1

          JMP RETURN_CHECK_HIT2

        CMP_OBS_BOUND_R2C1:
          MOV BL, TEMP_R2C1_OBS
          ADD BL, 7
          CMP BALL_COL, BL
          JL GAME_OVER2

          JMP CMP_ROW4

        GAME_OVER2:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER2_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT2

          GAME_OVER2_1:
            JMP GAME_OVER
        
        RETURN_CHECK_HIT2:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW4:
          CMP TEMP_R4_OBS, 04                           ;check row
          JNE CMP_ROW5
          JMP CMP_R4C1

        CMP_R4C1:
          MOV AL, TEMP_R4C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R4C1

          JMP RETURN_CHECK_HIT

          CMP_OBS_BOUND_R4C1:
            MOV BL, TEMP_R4C1_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER4

            JMP CMP_R4C2

        CMP_R4C2:
          MOV AL, TEMP_R4C2_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R4C2

          JMP RETURN_CHECK_HIT

          CMP_OBS_BOUND_R4C2:
            MOV BL, TEMP_R4C2_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER4

            JMP CMP_ROW5

        GAME_OVER4:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER4_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT4
          
          GAME_OVER4_1:
            JMP GAME_OVER

        RETURN_CHECK_HIT4:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW5:
          CMP TEMP_R5_OBS, 04                           ;check row
          JNE CMP_ROW6

          JMP CMP_R5C1

        CMP_R5C1:
          MOV AL, TEMP_R5C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R5C1

          JMP RETURN_CHECK_HIT

          CMP_OBS_BOUND_R5C1:
            MOV BL, TEMP_R5C1_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER5

            JMP RETURN_CHECK_HIT

        GAME_OVER5:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER5_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT5

          GAME_OVER5_1:
            JMP GAME_OVER

        RETURN_CHECK_HIT5:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW6:
          CMP TEMP_R6_OBS, 04                           ;check row
          JNE CMP_ROW7

          JMP CMP_R6C1

        CMP_R6C1:
          MOV AL, TEMP_R6C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R6C1

          JMP RETURN_CHECK_HIT

          CMP_OBS_BOUND_R6C1:
            MOV BL, TEMP_R6C1_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER6

            JMP RETURN_CHECK_HIT

        GAME_OVER6:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER6_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT6

          GAME_OVER6_1:
            JMP GAME_OVER

        RETURN_CHECK_HIT6:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW7:
          CMP TEMP_R7_OBS, 04                           ;check row
          JNE CMP_ROW9

          JMP CMP_R7C1
        
        CMP_R7C1:
          MOV AL, TEMP_R7C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R7C1
        
          JMP RETURN_CHECK_HIT
        
          CMP_OBS_BOUND_R7C1:
            MOV BL, TEMP_R7C1_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER7
            
            JMP RETURN_CHECK_HIT

        GAME_OVER7:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER7_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT7

          GAME_OVER7_1:
            JMP GAME_OVER
        
        RETURN_CHECK_HIT7:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW9:
          CMP TEMP_R9_OBS, 04                           ;check row
          JNE CMP_ROW10

          JMP CMP_R9C1

        CMP_R9C1:
          MOV AL, TEMP_R9C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R9C1

          JMP RETURN_CHECK_HIT9

          CMP_OBS_BOUND_R9C1:
            MOV BL, TEMP_R9C1_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER9

            JMP RETURN_CHECK_HIT  

        GAME_OVER9:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER9_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT9

          GAME_OVER9_1:
            JMP GAME_OVER

        RETURN_CHECK_HIT9:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW10:
          CMP TEMP_R10_OBS, 04                           ;check row
          JNE CMP_ROW12
          JMP CMP_R10C1

        CMP_R10C1:
          MOV AL, TEMP_R10C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R10C1

          JMP RETURN_CHECK_HIT10
          
          CMP_OBS_BOUND_R10C1:
            MOV BL, TEMP_R10C1_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER10

            JMP RETURN_CHECK_HIT10

        GAME_OVER10:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER10_1
          DEC LIFE_LEFT
          JMP RETURN_CHECK_HIT10
          
          GAME_OVER10_1:
            JMP GAME_OVER
        
        RETURN_CHECK_HIT10:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW12:
          CMP TEMP_R12_OBS, 04                           ;check row
          JNE CMP_ROW14

          JMP CMP_R12C1

        CMP_R12C1:
          MOV AL, TEMP_R12C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R12C1

          JMP RETURN_CHECK_HIT12

          CMP_OBS_BOUND_R12C1:
            MOV BL, TEMP_R12C1_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER12

            JMP CMP_R12C2

        CMP_R12C2:
          MOV AL, TEMP_R12C2_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R12C2

          JMP RETURN_CHECK_HIT

          CMP_OBS_BOUND_R12C2:
            MOV BL, TEMP_R12C2_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER12

            JMP RETURN_CHECK_HIT12

        GAME_OVER12:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER12_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT12

          GAME_OVER12_1:
            JMP GAME_OVER

        RETURN_CHECK_HIT12:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW14:
          CMP TEMP_R14_OBS, 04                           ;check row
          JNE CMP_ROW15

          JMP CMP_R14C1

        CMP_R14C1:
          MOV AL, TEMP_R14C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R14C1

          JMP RETURN_CHECK_HIT14

        CMP_OBS_BOUND_R14C1:
          MOV BL, TEMP_R14C1_OBS
          ADD BL, 7
          CMP BALL_COL, BL
          JL GAME_OVER14

          JMP RETURN_CHECK_HIT14

        GAME_OVER14:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER14_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT14

          GAME_OVER14_1:
            JMP GAME_OVER

        RETURN_CHECK_HIT14:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW15:
          CMP TEMP_R15_OBS, 04                           ;check row
          JNE CMP_ROW16
          JMP CMP_R15C1

        CMP_R15C1:
          MOV AL, TEMP_R15C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R15C1

          JMP RETURN_CHECK_HIT15
        
        CMP_OBS_BOUND_R15C1:
          MOV BL, TEMP_R15C1_OBS
          ADD BL, 7
          CMP BALL_COL, BL
          JL GAME_OVER15

          JMP RETURN_CHECK_HIT15

        GAME_OVER15:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER15_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT15

          GAME_OVER15_1:
            JMP GAME_OVER

        RETURN_CHECK_HIT15:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW16:
          CMP TEMP_R16_OBS, 04                           ;check row
          JNE CMP_ROW17

          JMP CMP_R16C1

        CMP_R16C1:
          MOV AL, TEMP_R16C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R16C1

          JMP RETURN_CHECK_HIT16

          CMP_OBS_BOUND_R16C1:
            MOV BL, TEMP_R16C1_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER16

            JMP RETURN_CHECK_HIT16

        GAME_OVER16:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER16_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT16

          GAME_OVER16_1:
            JMP GAME_OVER

        RETURN_CHECK_HIT16:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        CMP_ROW17:
          CMP TEMP_R17_OBS, 04                           ;check row
          JNE RETURN_CHECK_HIT17

          JMP CMP_R17C1

        CMP_R17C1:
          MOV AL, TEMP_R17C1_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R17C1

          JMP RETURN_CHECK_HIT17

          CMP_OBS_BOUND_R17C1:
            MOV BL, TEMP_R17C1_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER17
            JMP CMP_R17C2

        CMP_R17C2:
          MOV AL, TEMP_R17C2_OBS 
          CMP BALL_COL, AL
          JGE CMP_OBS_BOUND_R17C2

          JMP RETURN_CHECK_HIT

          CMP_OBS_BOUND_R17C2:
            MOV BL, TEMP_R17C2_OBS
            ADD BL, 7
            CMP BALL_COL, BL
            JL GAME_OVER17
            JMP RETURN_CHECK_HIT17
      
        GAME_OVER17:
          MOV AL, LIFE_LEFT
          CMP AL, 1
          JE GAME_OVER17_1
          DEC LIFE_LEFT

          JMP RETURN_CHECK_HIT17

          GAME_OVER17_1:
            JMP GAME_OVER

        RETURN_CHECK_HIT17:
          JMP RETURN_CHECK_HIT
        ;---------------------------------------------------------------------------------------------
        GAME_OVER:
          CALL GAMEOVER_SCREEN

        RETURN_CHECK_HIT:
          RET
  CHECK_HIT ENDP
;-------------------------------------------------------------------------------------------------------
  COMPARE PROC NEAR
      CMP KEY_INPUT, 01H
      JE EXIT

      CMP KEY_INPUT, 1CH
      JE BACK

      CMP KEY_INPUT, 0FH
      JE GAME_INSTRUCT

      CMP KEY_INPUT, 0EH
      JE BACK2

      JMP RETURN4

      BACK:
        CALL BACKGROUND_MAINGAME


      GAME_INSTRUCT:
        CALL HOW_TO_PLAY_SCREEN

      BACK2:
        CALL TITLE_SCREEN
      
      RETURN4:
        RET
  COMPARE ENDP
;-------------------------------------------------------------------------------------------------------
  MOV_BALL PROC NEAR
        CMP KEY_INPUT, 1H      ;ESC
        JE EXIT2
        
        CMP KEY_INPUT, 4DH     ;right
        JE BALL_TO_RIGHT
        CMP KEY_INPUT, 4BH     ;left
        JE BALL_TO_LEFT
        JMP RETURN1

      BALL_TO_RIGHT:
        CMP BALL_COL, 50
        JNE INC_BALL_COL
        JMP RETURN1

      INC_BALL_COL:
        INC BALL_COL
        JMP RETURN1

      BALL_TO_LEFT:
        CMP BALL_COL, 2
        JNE DEC_BALL_COL
        JMP RETURN1

      DEC_BALL_COL:
        DEC BALL_COL
        JMP RETURN1

      RETURN1:
        RET
  MOV_BALL ENDP 
;-------------------------------------------------------------------------------------------------------
  EXIT PROC NEAR
          MOV AH, 4CH
          INT 21H
  EXIT ENDP
;-------------------------------------------------------------------------------------------------------
  EXIT2 PROC NEAR
          MOV AH, 4CH
          INT 21H
  EXIT2 ENDP
;-------------------------------------------------------------------------------------------------------
  DEC_TEMP_ROW PROC NEAR                                ;down going up
        ROW1_DEC:                                       ;decrement 1st row
          DEC   TEMP_R1_OBS
          CMP   TEMP_R1_OBS, 02                         ;have reach the top border?
          JNE    ROW2_DEC
          MOV TEMP_R1_OBS, 21
        ROW2_DEC:                                       ;decrement 2nd row
          DEC   TEMP_R2_OBS
          CMP   TEMP_R2_OBS, 02                         ;have reach the top border?
          JNE ROW4_DEC
          MOV TEMP_R2_OBS, 21
        ROW4_DEC:
          DEC   TEMP_R4_OBS
          CMP   TEMP_R4_OBS, 02                         ;have reach the top border?
          JNE    ROW5_DEC
          MOV TEMP_R4_OBS, 21
        ROW5_DEC:
          DEC   TEMP_R5_OBS
          CMP   TEMP_R5_OBS, 02                         ;have reach the top border?
          JNE    ROW6_DEC
          MOV TEMP_R5_OBS, 21
        ROW6_DEC:
          DEC   TEMP_R6_OBS
          CMP   TEMP_R6_OBS, 02                         ;have reach the top border?
          JNE    ROW7_DEC
          MOV TEMP_R6_OBS, 21
        ROW7_DEC:
          DEC   TEMP_R7_OBS
          CMP   TEMP_R7_OBS, 02                         ;have reach the top border?
          JNE    ROW9_DEC
          MOV TEMP_R7_OBS, 21
        ROW9_DEC:
          DEC   TEMP_R9_OBS
          CMP   TEMP_R9_OBS, 02                         ;have reach the top border?
          JNE    ROW10_DEC
          MOV TEMP_R9_OBS, 21
        ROW10_DEC:
          DEC   TEMP_R10_OBS
          CMP   TEMP_R10_OBS, 02                        ;have reach the top border?
          JNE    ROW12_DEC
          MOV TEMP_R10_OBS, 21
        ROW12_DEC:
          DEC   TEMP_R12_OBS
          CMP   TEMP_R12_OBS, 02                        ;have reach the top border?
          JNE    ROW14_DEC
          MOV TEMP_R12_OBS, 21
        ROW14_DEC:
          DEC   TEMP_R14_OBS
          CMP   TEMP_R14_OBS, 02                        ;have reach the top border?
          JNE    ROW15_DEC
          MOV TEMP_R14_OBS, 21
        ROW15_DEC:
          DEC   TEMP_R15_OBS
          CMP   TEMP_R15_OBS, 02                        ;have reach the top border?
          JNE    ROW16_DEC
          MOV TEMP_R15_OBS, 21
        ROW16_DEC:
          DEC   TEMP_R16_OBS
          CMP   TEMP_R16_OBS, 02                        ;have reach the top border?
          JNE    ROW17_DEC
          MOV TEMP_R16_OBS, 21
        ROW17_DEC:
          DEC   TEMP_R17_OBS
          CMP   TEMP_R17_OBS, 02                        ;have reach the top border?
          JE    ROW_DEC
          JMP RETURN
        ROW_DEC:
          MOV TEMP_R17_OBS, 21
          JMP RETURN
        RETURN:
          RET
  DEC_TEMP_ROW ENDP
;-------------------------------------------------------------------------------------------------------
  SIDE_SCREEN_TOP_GAME PROC NEAR
        MOV AX, 0600H                                   ;full screen
        MOV BH, 02H                                     ;BLACK background (4), gray foreground (F)
        MOV CX, 0136H                                   ;upper left row:column (01:54)
        MOV DX, 064EH                                   ;lower right row:column (5:78)
        INT 10H
        ;------BORDER SIDESCREEN TOP-------
        MOV   DL, 55                                    ;column start
        MOV   DH, 02                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 09H                                     ;display BORDER
        LEA DX, BORDER_SIDE_SCREEN
        INT 21H
        ;------TITLE1 SIDESCREEN TOP-------
        MOV   DL, 55                                    ;column start
        MOV   DH, 03                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 09H                                     ;display TITLE1
        LEA DX, TITLE1_SIDE_SCREEN
        INT 21H
        ;------TITLE2 SIDESCREEN TOP-------
        MOV   DL, 55                                    ;column start
        MOV   DH, 04                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 09H                                     ;display TITLE1
        LEA DX, TITLE2_SIDE_SCREEN
        INT 21H
        ;------BORDER SIDESCREEN TOP-------
        MOV   DL, 55                                    ;column start
        MOV   DH, 05                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 09H                                     ;display TITLE1
        LEA DX, BORDER_SIDE_SCREEN
        INT 21H

        RET
  SIDE_SCREEN_TOP_GAME ENDP
;-------------------------------------------------------------------------------------------------------
  SIDE_SCREEN_BOTTOM_GAME PROC NEAR
        MOV AX, 0600H                                   ;full screen
        MOV BH, 07H                                     ;black background (0), gray foreground (F)
        MOV CX, 0836H                                   ;upper left row:column (7:54)
        MOV DX, 174EH                                   ;lower right row:column (23:78)
        INT 10H
        ;------SCORE TITLE-------
        MOV   DL, 54                                    ;column start
        MOV   DH, 09                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 09H                                     ;display SCORE TITLE1
        LEA DX, SCORE_TITLE
        INT 21H
        ;---------SCORE----------
        MOV   DL, 63                                    ;column start
        MOV   DH, 10                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 0
        MOV AL, FINAL_SCORE
        CALL DISPLAY_NUM
        ;-------LIFE TITLE-------
        MOV   DL, 54                                    ;column start
        MOV   DH, 12                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 09H                                     ;display  life left
        LEA DX, LIFE_TITLE
        INT 21H
        ;-------LIFE LEFT--------
        MOV   DL, 63                                    ;column start
        MOV   DH, 13                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 0
        MOV AL, LIFE_LEFT
        CALL DISPLAY_NUM
        ;---HIGHEST SCORE TITLE---
        MOV   DL, 54                                    ;column start
        MOV   DH, 15                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 09H                                     ;display SCORE TITLE1
        LEA DX, HIGHEST_SCORE_TITLE
        INT 21H
        ;---------SCORE----------
        MOV   DL, 63                                    ;column start
        MOV   DH, 16                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 09H
        LEA DX, SRCRECORD_STR
        INT 21H
        ;CALL DISPLAY_NUM
        ;---------INS 1----------
        MOV   DL, 54                                    ;column start
        MOV   DH, 18                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 09H                                     ;display INSTRUCTION1
        LEA DX, ESC_INS_SIDE_SCREEN
        INT 21H
        ;---------INS 2----------
        MOV   DL, 54                                    ;column start
        MOV   DH, 20                                    ;row start
        CALL  SET_CURSOR

        MOV AH, 09H                                     ;display INSTRUCTION2
        LEA DX, PAUSE_INS_SIDE_SCREEN
        INT 21H

        RET
  SIDE_SCREEN_BOTTOM_GAME ENDP
;-------------------------------------------------------------------------------------------------------
  DISPLAY_NUM PROC NEAR                           ;Beginning of procedure 
        MOV BX, 10                                ;Initializes divisor
        MOV DX, 0000H                             ;Clears DX
        MOV CX, 0000H                             ;Clears CX
    
                                                  ;Splitting process starts here
        DLOOP1:  
          MOV DX, 0000H                           ;Clears DX during jump
          DIV BX                                  ;Divides AX by BX
          PUSH DX                                 ;Pushes DX(remainder) to stack
          INC CX                                  ;Increments counter to track the number of digits
          CMP AX, 0                               ;Checks if there is still something in AX to divide
          JNE DLOOP1                              ;Jumps if AX is not zero
    
        DLOOP2:  
          POP DX                                  ;Pops from stack to DX
          ADD DX, 30H                             ;Converts to it's ASCII equivalent
          MOV AH, 02H    
          INT 21H                                 ;calls DOS to display character
          LOOP DLOOP2                             ;Loops till CX equals zero
          RET                                     ;returns control
  DISPLAY_NUM  ENDP
;-------------------------------------------------------------------------------------------------------
  DISPLAY_NUM2 PROC NEAR                           ;Beginning of procedure 
          mov bx, 10              ; divisor
          xor cx, cx              ; CX=0 (number of digits)

          First_Loop:
              xor dx, dx              ; Attention: DIV applies also DX!
              div bx                  ; DX:AX / BX = AX remainder: DX
              push dx                 ; LIFO
              inc cx                  ; increment number of digits
              test  ax, ax            ; AX = 0?
              jnz First_Loop          ; no: once more

              mov di, OFFSET DESTRECORD_STR ; target string SCORE_IN_DEC
          Second_Loop:
              pop ax                  ; get back pushed digit
              or ax, 00110000b        ; to ASCII
              mov byte ptr [di], al   ; save AL
              inc di                  ; DI points to next character in string SCORE_IN_DEC
              loop Second_Loop        ; until there are no digits left

              mov byte ptr [di], '$'  ; End-of-string delimiter for INT 21 / FN 09h
              ret
  DISPLAY_NUM2  ENDP
;-------------------------------------------------------------------------------------------------------
  GET_KEY  PROC  NEAR
        MOV   AH, 01H   ;check for input
        INT   16H
        JZ    LEAVETHIS

        MOV   AH, 00H   ;get input  MOV AH, 10H; INT 16H
        INT   16H

        MOV   KEY_INPUT, AH
      
        LEAVETHIS:
          RET 
  GET_KEY  ENDP
;-------------------------------------------------------------------------------------------------------
  SET_CURSOR PROC  NEAR
        MOV   AH, 02H
        MOV   BH, 00
        INT   10H
        RET
  SET_CURSOR ENDP
;-------------------------------------------------------------------------------------------------------    
  CLEAR_SCREEN PROC NEAR
        MOV AX, 0600H                                   ;full screen
        MOV BH, 30H                                     ;cyan background (3), black foreground (0)
        MOV CX, 0000H                                   ;upper left row:column (0:0)
        MOV DX, 184FH                                   ;lower right row:column (24:79)
        INT 10H
        RET
  CLEAR_SCREEN ENDP
;-------------------------------------------------------------------------------------------------------
  FORE_SCREEN PROC NEAR
        MOV AX, 0600H                                   ;full screen
        MOV BH, 07H                                     ;black background (0), gray foreground (F)
        MOV CX, 0101H                                   ;upper left row:column (01:02)
        MOV DX, 174EH                                   ;lower right row:column (23:78)
        INT 10H
        RET
  FORE_SCREEN ENDP
;-------------------------------------------------------------------------------------------------------
  FORE_SCREEN_GAME PROC NEAR
        MOV AX, 0600H                                   ;full screen
        MOV BH, 07H                                     ;black background (0), gray foreground (F)
        MOV CX, 0101H                                   ;upper left row:column (01:02)
        MOV DX, 1733H                                   ;lower right row:column (23:51)
        INT 10H
        RET
  FORE_SCREEN_GAME ENDP
;-------------------------------------------------------------------------------------------------------
  ;delay for everything except game
  DELAY PROC NEAR
        MOV BP, 10 ;lower value faster
        MOV SI, 10 ;lower value faster

        DELAY3:
          DEC BP
          NOP
          JNZ DELAY3
          DEC SI
          CMP SI, 0
          JNZ DELAY3

          RET
  DELAY ENDP
;-------------------------------------------------------------------------------------------------------
  ;delay for the game
  DELAY2 PROC NEAR
        DEC DELAY2_VAR
        CMP DELAY2_VAR, 05
        JNE NEXT_INS
        MOV DELAY2_VAR, 06

      NEXT_INS:
        MOV AH, 00
        MOV AL, DELAY2_VAR
        mov bp, AX ;lower value faster
        mov si, AX ;lower value faster

      DELAY22:
        DEC BP
        NOP
        JNZ DELAY22
        DEC SI
        CMP SI, 0
        JNZ DELAY22

        RET
  DELAY2 ENDP
;-------------------------------------------------------------------------------------------------------
  DISPLAY_WORDS PROC NEAR
        MOV   DL, 02H                                   ;column start
        MOV   DH, 02H                                   ;row start
        CALL  SET_CURSOR                                ;call set cursor

        MOV AH, 09H                                     ;display border1
        LEA DX, BORDER1                                    
        INT 21H

        MOV   DL, 02H                                   ;column start
        MOV   DH, 03H                                   ;row start
        CALL  SET_CURSOR                                ;call set cursor

        MOV AH, 09H                                     ;display border2
        LEA DX, BORDER2                                    
        INT 21H

        MOV   DL, 22                                    ;column start
        MOV   DH, 08                                    ;row start
        CALL  SET_CURSOR                                ;call set cursor

        MOV AH, 09H                                     ;display upper border gameover word
        LEA DX, GAMEOVER_BORDER1                                    
        INT 21H

        MOV   DL, 22                                    ;column start
        MOV   DH, 09                                    ;row start
        CALL  SET_CURSOR                                ;call set cursor

        MOV AH, 09H                                     ;display upper border2/padding gameover word
        LEA DX, GAMEOVER_BORDER2                                    
        INT 21H

        MOV   DL, 22                                    ;column start
        MOV   DH, 10                                    ;row start
        CALL  SET_CURSOR                                ;call set cursor

        CMP FLASH, 1
        JE FLASH1
        JMP FLASH2

        FLASH1:
          MOV AH, 09H                                    ;display upper border2/padding gameover word
          LEA DX, GAMEOVER_WORD                          ;display game over word     
          INT 21H
          MOV AL, 2
          MOV FLASH, AL
          JMP DISPLAY_LOWER_BORDER

        FLASH2:  
          MOV AH, 09H                                    ;display upper border2/padding gameover word
          LEA DX, GAMEOVER_WORD_REP                      ;display EXLAMATION points     
          INT 21H
          MOV AL, 1
          MOV FLASH, AL
          JMP DISPLAY_LOWER_BORDER

        DISPLAY_LOWER_BORDER:
          MOV   DL, 22                                   ;column start
          MOV   DH, 11                                   ;row start
          CALL  SET_CURSOR                               ;call set cursor

          MOV AH, 09H                                    ;display lower border2/padding gameover word
          LEA DX, GAMEOVER_BORDER2                                    
          INT 21H

          MOV   DL, 22                                   ;column start
          MOV   DH, 12                                   ;row start
          CALL  SET_CURSOR                               ;call set cursor

          MOV AH, 09H                                    ;display lower border gameover word
          LEA DX, GAMEOVER_BORDER1                                    
          INT 21H  

          MOV   DL, 28                                    ;column start
          MOV   DH, 14                                    ;row start
          CALL  SET_CURSOR                                ;call set cursor

          MOV AH, 09H                                     ;display play again
          LEA DX, PLAY_AGAIN                                    
          INT 21H

          MOV   DL, 26                                    ;column start
          MOV   DH, 16
          CALL  SET_CURSOR

          MOV AH, 09H                                     ;display instruction
          LEA DX, INSTRUCTION
          INT 21H

          MOV   DL, 32                                    ;column start
          MOV   DH, 18                                    ;row start
          CALL  SET_CURSOR

          MOV AH, 09H                                     ;display quit
          LEA DX, QUIT
          INT 21H

          MOV   DL, 02h                                   ;column start
          MOV   DH, 21                                    ;row start
          CALL  SET_CURSOR

          MOV AH, 09H                                     ;display quit
          LEA DX, BORDER2
          INT 21H

          MOV   DL, 02h                                   ;column start
          MOV   DH, 22                                    ;row start
          CALL  SET_CURSOR

          MOV AH, 09H                                     ;display quit
          LEA DX, BORDER1
          INT 21H

          RET
  DISPLAY_WORDS ENDP
;-------------------------------------------------------------------------------------------------------
END MAIN