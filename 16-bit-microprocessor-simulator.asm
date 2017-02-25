; Author: Adeel Ahmad
; Email: adeelahmad14@hotmail.com
; last-modified: 25-11-2016



.model small
.stack
.data 
binary_style_file db "bin_file.txt",0

str_ax db "ax00","$"
str_bx db "bx01","$"
str_cx db "cx10","$"
str_dx db "dx11","$"    
str_add db "add0000","$"
str_sub db "sub0001","$"
str_and db "and0010","$"
str_or db "or0011","$"
str_xor db "xor0100","$"
str_not db "not0101","$"
str_shl db "shl0110","$"
str_shr db "shr0111","$"
str_mov db "mov1010","$"
str_mul_2 db "mov1011","$"
str_div db "mov1100","$"
str_out_opcode db "opcode : ","$"
str_out_mode db "mode : ","$"
str_out_op1 db "op1 : ","$"
str_out_op2 db "op2 : ","$"

temp_PC db ?
hold_reg_value db 0,0,0,0,0,0
decimal_index db 0


str_mul db "mul","$"

print_AX db " AX :","$"
print_BX db " BX :","$"
print_CX db " CX :","$"
print_DX db " DX :","$"

AX_value db 0
BX_value db 0
CX_value db 0
DX_value db 0

is_AX_op1 db 0 ;this will check which reg was used in the instruction
is_BX_op1 db 0 ;this will check which reg was used in the instruction
is_CX_op1 db 0 ;this will check which reg was used in the instruction
is_DX_op1 db 0 ;this will check which reg was used in the instruction

is_AX_op2 db 0 ;this will check which reg was used in the instruction
is_BX_op2 db 0 ;this will check which reg was used in the instruction
is_CX_op2 db 0 ;this will check which reg was used in the instruction
is_DX_op2 db 0 ;this will check which reg was used in the instruction

temp_bx dw ?
temp_si dw ?
temp_string db 50 dup("$") ;I will use this to convert a 16-bit binary to 8-bit
isReg_op1 db 0 ;0 means 'no'
isReg_op2 db 0 ;0 means 'no'
read_operation db 4 dup("$") ;max length can be 4
read_op1 db 10 dup("$") ;assuming that the max length can be 10
read_op2 db 10 dup("$") ;assuming that the max length can be 10
full_instruction db 50 dup("$")

read_operation_binary db 5 dup("$") ;max length can be 5
read_mode_binary db 5 dup("$") ;will contain the two mode bits
read_op1_binary db 10 dup("$") ;assuming that the max length can be 10
read_op2_binary db 10 dup("$") ;assuming that the max length can be 10

assembly_to_binary db 30 dup("$") ;this will contain the converted assembly code
temp_assembly_to_binary db 30 dup("$") ;this will temporarily hold the binary 16bit instruction
read_variable db 10 dup("$") ;max length 10
read_data_type db 3 dup("$")
read_value db 4 dup("$") ;will hold the value
len_str db 0 ;this will hold length of a string

buffer db 500 dup("$")
buffer_new db 500 dup("$")


buffer_data db 50 dup("$")
buffer_code db 50 dup("$")


file db "file.txt",0
file2 db "file2.txt",0
file3 db "file3.txt",0

;These here, are my variables/strings etc.
;******************************
temp_varInt db 0

dataBuff db 64 dup(8 dup("$"))
codeBuff db 64 dup(8 dup("$"))
binary_str db 17 dup("$")	;if kept 16, prints garbage when 09h is used
some db "0"
binary2 db "0000000000001101$"
hex_str db 4 dup("0"), "$"

var_str db "9$" 		;the str to be converted to decimal
varInt db 0		;converted string comes here. Using dw will require minor 				  changes in the functions and then will print weird values
varSign db 1	;the sign of the variable, helps with sign extension
v2 dw 10		;for the conversion from str to decimal
;NOTE: v2 may be a culprit for the weird numbers when varInt is used as DW
count db 7
count2 db 24
variables db 10 dup(10 dup("$"))	;stores 10 variables each with length 10
;x_coord db 0

;*****************************
str_contents db "The contents are : ","$"
str_syntax_error db "SYNTAX ERROR!!","$"

;PART I
left db "Left Mouse Button Pressed at Coordinates: ","$"
right db "Right Mouse Button Pressed at Coordinates: ","$"
move db "Mouse Moved at Coordinates: ","$"
str_title db "16-Bit Simulator", "$"
str_file db "File Explorer", "$"  
str_register db "   ALU   ", "$"
str_file1 db "File 1", "$"
str_file2 db "File 2", "$"   
str_IR db " IR ", "$"
str_MBR db " MBR ", "$"
str_MAR db " MAR ", "$"
str_PC db " PC ", "$"
str_RAM db " RAM ", "$" 
str_AC db " AC ","$"
str_IBR db " IBR ", "$"
str_MQ db " MQ ","$"    
str_logic_circuits db " Logic Circuits ","$"


str_binary_file db "Read Binary Inst","$"
str_file3 db "File 3", "$" 
str_fetch db "Fetch", "$"
str_decode db "Decode", "$"
str_load db "Load", "$"
str_execute db "Execute", "$"
str_store db "Store", "$"
str_read db "Read","$" 
str_cycle db "Program Cycle", "$"
str_control db "Control Unit", "$" 
str_out db "Output", "$"           
str_control_circuit db "Control Circuit","$"

next_line db 0DH,0AH, "$"
x_coord dw 0
y_coord dw 0
x1_brick db 0
x2_brick db 0
y1_brick db 0
y2_brick db 0 
counter db 0
counter2 db 0
coord dw 0
temp_DX dw ?

;PART II     
ten dw 0
PC_value db 0
str_PC_zero db "000","$"
str_AC_value db "00213101","$"
str_MQ_value db "00102010","$"
str_MBR_value db "00001111","$"
str_IBR_value db "00213101","$"
str_PC_value db 5 dup("$")
str_IR_value db 5 dup("$")
str_MAR_value db 5 dup("$")
    
;WILL ADD PART WHICH READS DIRECTLY FROM BINARY FORMAT
str_read_from_binary db "0001101100000001","$"

.code
start:
main proc

mov ax,@data
mov ds, ax
call clrrg ; Clear Data/General Registers

; Changing Video Mode as Per Requirement
mov ah,00h	; Change Video Mode if Required
mov al,12h	; AL=12h, Video Mode 640*480
int 10h

;Drawing 3 rectangular boxes on
mov ch, 1  ;y1 ; distance from top
mov dh, 28 ;y2 ;stretch top bottom

mov cl, 4  ;distance from left
mov dl, 75 ;x2  ;stretch

mov bh, 15 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the title bar
mov ch, 1  ;y1 ; distance from top
mov dh, 3 ;y2 ;stretch top bottom

mov cl, 4  ;distance from left
mov dl, 75 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the left bar
mov ch, 5  ;y1 ; distance from top
mov dh, 27 ;y2 ;stretch top bottom

mov cl, 5  ;distance from left
mov dl, 25 ;x2  ;stretch

mov bh, 09 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing box to read in binary format
;drawing the box for files
mov ch, 4  ;y1 ; distance from top
mov dh, 6;y2 ;stretch top bottom
            
mov cl, 6 ;distance from left
mov dl, 24 ;x2  ;stretch

mov bh, 11 ;color 
call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the box for files
mov ch, 6  ;y1 ; distance from top
mov dh, 14 ;y2 ;stretch top bottom
            
mov cl, 6 ;distance from left
mov dl, 24 ;x2  ;stretch

mov bh, 11 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the box for registers
mov ch, 16  ;y1 ; distance from top
mov dh, 26  ;y2 ;stretch top bottom
            
mov cl, 6 ;distance from left
mov dl, 24 ;x2  ;stretch

mov bh, 11 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the box output
mov ch, 6  ;y1 ; distance from top
mov dh, 10 ;y2 ;stretch top bottom
            
mov cl, 54 ;distance from left
mov dl, 74 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing a box for inside output
mov ch, 7  ;y1 ; distance from top
mov dh, 9 ;y2 ;stretch top bottom
            
mov cl, 55 ;distance from left
mov dl, 73 ;x2  ;stretch

mov bh, 15 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the box for RAM
mov ch, 10  ;y1 ; distance from top
mov dh, 27 ;y2 ;stretch top bottom
            
mov cl, 54 ;distance from left
mov dl, 74 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the inner outline for RAM
mov ch, 11  ;y1 ; distance from top
mov dh, 26 ;y2 ;stretch top bottom
            
mov cl, 55 ;distance from left
mov dl, 73 ;x2  ;stretch

mov bh, 15 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color


;drawing the box for control unit
mov ch, 19  ;y1 ; distance from top
mov dh, 27 ;y2 ;stretch top bottom
            
mov cl, 28 ;distance from left
mov dl, 50 ;x2  ;stretch

mov bh, 09
 ;color 
call print_shape ;y_top, y_bot, x_left, x_right, color


;drawing the title for control unit
mov ch, 19  ;y1 ; distance from top
mov dh, 20 ;y2 ;stretch top bottom
            
mov cl, 28 ;distance from left
mov dl, 50 ;x2  ;stretch

mov bh, 01 ;color 
call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the inner outline for control unit
mov ch, 20  ;y1 ; distance from top
mov dh, 26 ;y2 ;stretch top bottom
            
mov cl, 29 ;distance from left
mov dl, 49 ;x2  ;stretch

mov bh, 11 ;color 
call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the box for program cycle
mov ch, 6  ;y1 ; distance from top
mov dh, 17 ;y2 ;stretch top bottom
            
mov cl, 28 ;distance from left
mov dl, 50 ;x2  ;stretch

mov bh, 11 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the title for program cycle
mov ch, 16  ;y1 ; distance from top
mov dh, 17 ;y2 ;stretch top bottom
            
mov cl, 28 ;distance from left
mov dl, 50 ;x2  ;stretch

mov bh, 09 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing a box inside program cycle
mov ch, 7  ;y1 ; distance from top
mov dh, 8  ;y2 ;stretch top bottom
            
mov cl, 30 ;distance from left
mov dl, 37 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing a box inside program cycle
mov ch,7  ;y1 ; distance from top
mov dh,8  ;y2 ;stretch top bottom
            
mov cl,40 ;distance from left
mov dl,47 ;x2  ;stretch

mov bh,01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color


;drawing a box inside program cycle
mov ch,10  ;y1 ; distance from top
mov dh,11  ;y2 ;stretch top bottom
            
mov cl,30 ;distance from left
mov dl,37 ;x2  ;stretch

mov bh,01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing a box inside program cycle
mov ch,10  ;y1 ; distance from top
mov dh,11  ;y2 ;stretch top bottom
            
mov cl,40 ;distance from left
mov dl,47 ;x2  ;stretch

mov bh,01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;------------------------------
;drawing a box inside program cycle
mov ch,13  ;y1 ; distance from top
mov dh,14  ;y2 ;stretch top bottom
            
mov cl,30 ;distance from left
mov dl,37 ;x2  ;stretch

mov bh,01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing a box inside program cycle
mov ch,13  ;y1 ; distance from top
mov dh,14  ;y2 ;stretch top bottom
            
mov cl,40 ;distance from left
mov dl,47 ;x2  ;stretch

mov bh,01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the title for files
mov ch, 6  ;y1 ; distance from top
mov dh, 7 ;y2 ;stretch top bottom
            
mov cl, 6 ;distance from left
mov dl, 24 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing the title for registers
mov ch, 16  ;y1 ; distance from top
mov dh, 17 ;y2 ;stretch top bottom
            
mov cl, 6 ;distance from left
mov dl, 24 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing boxes for files ;inside
mov ch, 09  ;y1 ; distance from top
mov dh, 10 ;y2 ;stretch top bottom
            
mov cl, 9 ;distance from left
mov dl, 21 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color
 
;drawing boxes for files ;inside
mov ch, 11  ;y1 ; distance from top
mov dh, 12 ;y2 ;stretch top bottom
            
mov cl, 9 ;distance from left
mov dl, 21 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;drawing boxes for files ;inside
mov ch, 13  ;y1 ; distance from top
mov dh, 14 ;y2 ;stretch top bottom
            
mov cl, 9 ;distance from left
mov dl, 21 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;***********************************
;Drawing connections through pixels*
;***********************************

call clrrg
mov x_coord,102
ALU_UPPER:
mov ah,0ch
mov al,00 ;black
mov cx,x_coord  ;x-axis
mov dx,327 ;y-axis
int 10h

inc x_coord
cmp cx, 140
jne ALU_UPPER

call clrrg
mov y_coord,327
ALU_LOWER_1:
mov ah,0ch
mov al,00 ;black
mov cx,90  ;x-axis
mov dx,y_coord ;y-axis
int 10h

inc y_coord
cmp dx, 370
jne ALU_LOWER_1

call clrrg
mov y_coord,327
ALU_LOWER_2:
mov ah,0ch
mov al,00 ;black
mov cx,150  ;x-axis
mov dx,y_coord ;y-axis
int 10h

inc y_coord
cmp dx, 370
jne ALU_LOWER_2

call clrrg
mov y_coord,380
ALU_LOWER_MBR1:
mov ah,0ch
mov al,00 ;black
mov cx,125  ;x-axis
mov dx,y_coord ;y-axis
int 10h

inc y_coord
cmp dx, 400
jne ALU_LOWER_MBR1

call clrrg
mov y_coord,380
ALU_LOWER_MBR2:
mov ah,0ch
mov al,00 ;black
mov cx,105  ;x-axis
mov dx,y_coord ;y-axis
int 10h

inc y_coord
cmp dx, 400
jne ALU_LOWER_MBR2

call clrrg
mov x_coord,125
ALU_LINK:
mov ah,0ch
mov al,00 ;black
mov cx,x_coord  ;x-axis
mov dx,408 ;y-axis
int 10h

inc x_coord
cmp cx, 235
jne ALU_LINK

call clrrg
mov y_coord,408
ALU_LINK_UP:
mov ah,0ch
mov al,00 ;black
mov cx,235  ;x-axis
mov dx,y_coord ;y-axis
int 10h

dec y_coord
cmp dx, 345
jne ALU_LINK_UP

call clrrg
mov x_coord,235
ALU_LINK_HOR:
mov ah,0ch
mov al,00 ;black
mov cx,x_coord  ;x-axis
mov dx,345 ;y-axis
int 10h

inc x_coord
cmp cx, 280
jne ALU_LINK_HOR

call clrrg
mov y_coord,345
CU_DOWN:
mov ah,0ch
mov al,00 ;black
mov cx,350  ;x-axis
mov dx,y_coord ;y-axis
int 10h

inc y_coord
cmp dx, 380
jne CU_DOWN

call clrrg
mov x_coord,350
CU_HOR:
mov ah,0ch
mov al,00 ;black
mov cx,x_coord  ;x-axis
mov dx,360 ;y-axis
int 10h

dec x_coord
cmp cx, 273
jne CU_HOR

call clrrg
mov y_coord,360
CU_DOWN_2:
mov ah,0ch
mov al,00 ;black
mov cx,273  ;x-axis
mov dx,y_coord ;y-axis
int 10h

inc y_coord
cmp dx, 370
jne CU_DOWN_2

call clrrg
mov y_coord,380
CU_DOWN_3:
mov ah,0ch
mov al,00 ;black
mov cx,273  ;x-axis
mov dx,y_coord ;y-axis
int 10h

inc y_coord
cmp dx, 400
jne CU_DOWN_3

;----------------------------------------------
;printing string
;chaning cursor location
call clrrg
mov dh,2 ;y_axis
mov dl,5 ;x_axis

call gotoxy

lea dx, str_title                   
mov ah,09h
int 21h

;printing string
;chaning cursor location
call clrrg
mov dh,6 ;y_axis
mov dl,9 ;x_axis

call gotoxy

lea dx, str_file
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,16 ;y_axis
mov dl,11 ;x_axis

call gotoxy

lea dx, str_register
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,4 ;y_axis
mov dl,07 ;x_axis

call gotoxy

lea dx, str_binary_file
mov ah,09h
int 21h


;printing string
;changing cursor location
call clrrg
mov dh,10 ;y_axis
mov dl,12 ;x_axis

call gotoxy

lea dx, str_file1
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,12 ;y_axis
mov dl,12 ;x_axis

call gotoxy

lea dx, str_file2
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,12 ;x_axis

call gotoxy

lea dx, str_file3
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,20 ;y_axis
mov dl,09 ;x_axis

call gotoxy

lea dx, str_AC
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,20 ;y_axis
mov dl,17 ;x_axis

call gotoxy

lea dx, str_MQ
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,25 ;y_axis
mov dl,12 ;x_axis

call gotoxy

lea dx, str_MBR
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,23 ;y_axis
mov dl,07 ;x_axis

call gotoxy

lea dx, str_logic_circuits
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,08 ;y_axis
mov dl,31 ;x_axis

call gotoxy

lea dx, str_fetch
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,08 ;y_axis
mov dl,41 ;x_axis

call gotoxy

lea dx, str_decode
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,11 ;y_axis
mov dl,32 ;x_axis

call gotoxy

lea dx, str_read
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,11 ;y_axis
mov dl,41 ;x_axis

call gotoxy

lea dx, str_load
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,30 ;x_axis

call gotoxy

lea dx, str_execute
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,41 ;x_axis

call gotoxy

lea dx, str_store   
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,17 ;y_axis
mov dl,33 ;x_axis

call gotoxy

lea dx, str_cycle
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,19 ;y_axis
mov dl,34 ;x_axis

call gotoxy

lea dx, str_control
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,06 ;y_axis
mov dl,61 ;x_axis

call gotoxy

lea dx, str_out
mov ah,09h
int 21h

;-------------------
;***************
; For Control Unit

;printing string
;changing cursor location
call clrrg
mov dh,21 ;y_axis
mov dl,42 ;x_axis

call gotoxy

lea dx, str_PC
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,21 ;y_axis
mov dl,32 ;x_axis

call gotoxy

lea dx, str_IBR
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,23 ;y_axis
mov dl,32 ;x_axis

call gotoxy

lea dx, str_IR
mov ah,09h
int 21h


;printing string
;changing cursor location
call clrrg
mov dh,23 ;y_axis
mov dl,41 ;x_axis

call gotoxy

lea dx, str_MAR
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,25 ;y_axis
mov dl,32 ;x_axis

call gotoxy

lea dx, str_control_circuit
mov ah,09h
;int 21h

;printing string
;changing cursor location
call clrrg
mov dh,10 ;y_axis
mov dl,61 ;x_axis

call gotoxy

lea dx, str_RAM
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,11 ;y_axis
mov dl,55 ;x_axis

call gotoxy

lea dx, print_AX
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,12 ;y_axis
mov dl,55 ;x_axis

call gotoxy

lea dx, print_BX
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,13 ;y_axis
mov dl,55 ;x_axis

call gotoxy

lea dx, print_CX
mov ah,09h
int 21h

call clrrg
mov dh,21 ;y_axis
mov dl,47 ;x_axis

call gotoxy

;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,55 ;x_axis

call gotoxy

lea dx, print_DX
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,16 ;y_axis
mov dl,55 ;x_axis

call gotoxy

lea dx, str_out_opcode
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,17 ;y_axis
mov dl,55 ;x_axis

call gotoxy

lea dx, str_out_mode
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,18 ;y_axis
mov dl,55 ;x_axis

call gotoxy

lea dx, str_out_op1
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,19 ;y_axis
mov dl,55 ;x_axis

call gotoxy

lea dx, str_out_op1
mov ah,09h
int 21h

call clrrg
mov dh,21 ;y_axis
mov dl,47 ;x_axis

call gotoxy

lea dx,str_PC_zero
mov ah,09h
int 21h


    mov al, PC_VALUE
    call double_digit_output

call clrrg
mov dh,24 ;y_axis
mov dl,41 ;x_axis

call gotoxy

lea dx,str_PC_zero
mov ah,09h
int 21h

;printing string
;changing cursor location
call clrrg
mov dh,11 ;y_axis
mov dl,60 ;x_axis

call gotoxy

mov al, AX_VALUE
call double_digit_output

;printing string
;changing cursor location
call clrrg
mov dh,12 ;y_axis
mov dl,60 ;x_axis

call gotoxy

mov al, BX_VALUE
call double_digit_output

;printing string
;changing cursor location
call clrrg
mov dh,13 ;y_axis
mov dl,60 ;x_axis

call gotoxy

mov al, CX_VALUE
call double_digit_output

;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,60 ;x_axis

call gotoxy

mov al, DX_VALUE
call double_digit_output

; Show Mouse Cursor on Screen
mov	ax,1		; show Mouse Cursor Functionj
int	33h			; Mouse Interrupt
call clrrg		; Clear Registers
; ****************
; **DESCRIPTION***
; ****************
; STEP # 01: For every mouse event we want to detect,
;	         ADJUST Value of CX register
; STEP # 02: Load Address of Function in ES:DX which will be 
; 		     executed when ANY Mouse Event Occurs 
; STEP # 03: AX=000Ch, This Interrupt Setup Interrupt Vector
;	         entry for MOUSE Interrupt
; STEP # 04: Call int 33h

; Set value of CX as below to Set Interrupt Function for Specific Mouse Event
; If CX is set to all one's 11111111b, it will detect all Events
; CX=00000001b, Call Interrupt Handler if mouse moves
; CX=00000010b, Call Interrupt Handler if left button pressed
; CX=00000100b, Call Interrupt Handler if left button released
; CX=00001000b, Call Interrupt Handler if right button pressed
; CX=00010000b, Call Interrupt Handler if right button released
; CX=00100000b, Call Interrupt Handler if middle button pressed
; CX=01000000b, Call Interrupt Handler if middle button released 
; If we want to Detect two events, Take OR of CX values for Both Events.
; Example: To detect Mouse Movement and Left Button Pressed; CX = 00000110b
; Example: To detect Mouse Movement, Left Button Pressed and Right Button Pressed
;		  CX will be 00001011b
; ***********
; *Important*
; ***********

; Whenever Event is Generated and Function is Invoked,
; below registers are updated
; AX = (Specific bit will get high for which Event is Generated)
; Example: If we press Left Mouse button, value of AX will become 00000010b
; BX = button state
; CX = cursor column ; **Useful, to get info about column
;		       where Button was pressed**
; DX = cursor row    ; **Useful, to get info about row
;		       where Button was pressed**
; DI = horizontal mickey count
; SI = vertical mickey count

; Step # 01
mov dx,seg mouse_handler	; Load Segment Address of
;				  Function (mouse_handler)
mov es,dx			; Store contents of dx in es
mov dx,offset mouse_handler	; Load Offset of Function (mouse_handler)
; Step # 02
mov cx,	00001011b ; CX=00001011b tells, we want to generate Interrupt
;				  if Left Mouse Button OR Right Mouse Button is Pressed
; Step # 03
mov ax,000Ch	; Setup Interrupt Vector Entry for Specific Mouse Event
; Step # 04
int 33h			; Call Mouse Interrupt

call clrrg		; Clear Registers

;****************************************************************************
;***Same 4 steps can be followed to Insert Handlers for Other Mouse events***
;****************************************************************************

; To detect mouse events, we want our program NOT to terminate rapidly
; For this an infinite loop is generated
; When you are writing your code, there might not be need for this
loop1:			; Infinite Loop
nop			; No Operation
jmp loop1

call termprg	; Terminate Program

main endp

; ***********************
; Mouse Interrupt Handler
; ***********************

mouse_handler proc far

.if ax==00000010b ; Means Left Mouse Button is Pressed

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
;START OF SECOND PART MAIN PART
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

;FOR BOX 1
mov x_coord, 144 ;242
cmp dx, x_coord
jb next

mov x_coord, 160
cmp dx, x_coord
ja next

mov y_coord, 71 ;80
cmp cx, y_coord
jb next

mov y_coord, 165
cmp cx, y_coord
ja next

;=====================
;CALL ALL FUNCTIONS HERE for box 1
;=====================

call randomNumbersForDataSeg

mov dx,offset file
call open_file
call read_file
  
call read_data
FIND_NL_TOKEN:
mov al,0Ah
cmp [bx],al
je START_ASSEMBLY_CONVERSION
inc bx
jmp FIND_NL_TOKEN

START_ASSEMBLY_CONVERSION:
mov al,"$"
mov temp_bx,bx
add bx,12
cmp [bx],al
je ASSEMBLY_CONVERSION_DONE
mov bx,temp_bx
call tokenize_string
mov temp_bx,bx

call DUM_LOOP
call blink_fetch

call clrrg
mov dh,21 ;y_axis
mov dl,50 ;x_axis

call gotoxy
inc PC_VALUE
    
mov al, PC_VALUE
;call the function
call double_digit_output

;printing string
;changing cursor location
call clrrg
mov dh,24 ;y_axis
mov dl,44 ;x_axis

call gotoxy

mov bl,PC_VALUE
mov temp_PC,bl
dec temp_PC

mov al,temp_PC
call double_digit_output

call clrrg
mov bx,offset assembly_to_binary
mov si,offset temp_assembly_to_binary
call copy_string
;DO NOT MINGLE WITH THIS

call DUM_LOOP
call DUM_LOOP
call blink_decode
call DUM_LOOP
call DUM_LOOP

mov si,offset temp_assembly_to_binary; str_read_from_binary ;
call read_binary_instruction

call clrrg
mov dh,24 ;y_axis
mov dl,30 ;x_axis

call gotoxy

mov bx,offset assembly_to_binary
call split_first_8_bits

lea dx, temp_string
mov ah,09h
int 21h  

call clrrg

mov dh,25 ;y_axis
mov dl,30 ;x_axis

call gotoxy

mov bx,offset assembly_to_binary
call split_last_8_bits

lea dx, temp_string
mov ah,09h
int 21h           


call blink_read
call DUM_LOOP
call blink_load
call DUM_LOOP
call blink_execute
call DUM_LOOP
call DUM_LOOP
call decode_binary_operation




mov bx,temp_bx
jmp START_ASSEMBLY_CONVERSION
ASSEMBLY_CONVERSION_DONE:
call clrrg
;when all the conditions are met
;drawing boxes for files ;inside
mov ch, 09  ;y1 ; distance from top
mov dh, 10 ;y2 ;stretch top bottom
            
mov cl, 9 ;distance from left
mov dl, 21 ;x2  ;stretch

mov bh, 05 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,10 ;y_axis
mov dl,12 ;x_axis

call gotoxy

lea dx, str_file1
mov ah,09h
int 21h
 
; Show Mouse Cursor on Screen
mov	ax,1		; show Mouse Cursor Functionj
int	33h			; Mouse Interrupt


;FOR BOX 2
next:
mov x_coord, 174 ;242
cmp dx, x_coord
jb next2

mov x_coord, 194
cmp dx, x_coord
ja next2

mov y_coord, 72 ;80
cmp cx, y_coord
jb next2

mov y_coord, 167
cmp cx, y_coord
ja next2

;=====================
;CALL ALL FUNCTIONS HERE for box 2
;=====================

call randomNumbersForDataSeg

mov dx,offset file2
call open_file
call read_file
  
call read_data
FIND_NL_TOKEN2:
mov al,0Ah
cmp [bx],al
je START_ASSEMBLY_CONVERSION2
inc bx
jmp FIND_NL_TOKEN2

START_ASSEMBLY_CONVERSION2:
mov al,"$"
mov temp_bx,bx
add bx,12
cmp [bx],al
je ASSEMBLY_CONVERSION_DONE2
mov bx,temp_bx
call tokenize_string
mov temp_bx,bx

call DUM_LOOP
call blink_fetch

call clrrg
mov dh,21 ;y_axis
mov dl,50 ;x_axis

call gotoxy
inc PC_VALUE
    
mov al, PC_VALUE
;call the function
call double_digit_output

;printing string
;changing cursor location
call clrrg
mov dh,24 ;y_axis
mov dl,44 ;x_axis

call gotoxy

mov bl,PC_VALUE
mov temp_PC,bl
dec temp_PC

mov al,temp_PC
call double_digit_output

call clrrg
mov bx,offset assembly_to_binary
mov si,offset temp_assembly_to_binary
call copy_string
;DO NOT MINGLE WITH THIS

call DUM_LOOP
call DUM_LOOP
call blink_decode
call DUM_LOOP
call DUM_LOOP

mov si,offset temp_assembly_to_binary; str_read_from_binary ;
call read_binary_instruction

call clrrg
mov dh,24 ;y_axis
mov dl,30 ;x_axis

call gotoxy

mov bx,offset assembly_to_binary
call split_first_8_bits

lea dx, temp_string
mov ah,09h
int 21h  

call clrrg

mov dh,25 ;y_axis
mov dl,30 ;x_axis

call gotoxy

mov bx,offset assembly_to_binary
call split_last_8_bits

lea dx, temp_string
mov ah,09h
int 21h           


call blink_read
call DUM_LOOP
call blink_load
call DUM_LOOP
call blink_execute
call DUM_LOOP
call DUM_LOOP
call decode_binary_operation




mov bx,temp_bx
jmp START_ASSEMBLY_CONVERSION2
ASSEMBLY_CONVERSION_DONE2:


;redrawing
;drawing boxes for files ;inside
mov ch, 11  ;y1 ; distance from top
mov dh, 12 ;y2 ;stretch top bottom
            
mov cl, 9 ;distance from left
mov dl, 21 ;x2  ;stretch

mov bh, 05 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,12 ;y_axis
mov dl,12 ;x_axis

call gotoxy

lea dx, str_file2
mov ah,09h
int 21h

; Show Mouse Cursor on Screen
mov	ax,1		; show Mouse Cursor Functionj
int	33h			; Mouse Interrupt

call DUM_LOOP

;FOR BOX 3
next2:
mov x_coord, 211 ;242
cmp dx, x_coord
jb next3

mov x_coord, 223
cmp dx, x_coord
ja next3

mov y_coord, 72 ;80
cmp cx, y_coord
jb next3

mov y_coord, 165
cmp cx, y_coord
ja next3

;=====================
;CALL ALL FUNCTIONS HERE for box 3
;=====================

call randomNumbersForDataSeg

mov dx,offset file3
call open_file
call read_file
  
call read_data
FIND_NL_TOKEN3:
mov al,0Ah
cmp [bx],al
je START_ASSEMBLY_CONVERSION3
inc bx
jmp FIND_NL_TOKEN3

START_ASSEMBLY_CONVERSION3:
mov al,"$"
mov temp_bx,bx
add bx,12
cmp [bx],al
je ASSEMBLY_CONVERSION_DONE3
mov bx,temp_bx
call tokenize_string
mov temp_bx,bx

call DUM_LOOP
call blink_fetch

call clrrg
mov dh,21 ;y_axis
mov dl,50 ;x_axis

call gotoxy
inc PC_VALUE
    
mov al, PC_VALUE
;call the function
call double_digit_output

;printing string
;changing cursor location
call clrrg
mov dh,24 ;y_axis
mov dl,44 ;x_axis

call gotoxy

mov bl,PC_VALUE
mov temp_PC,bl
dec temp_PC

mov al,temp_PC
call double_digit_output

call clrrg
mov bx,offset assembly_to_binary
mov si,offset temp_assembly_to_binary
call copy_string
;DO NOT MINGLE WITH THIS

call DUM_LOOP
call DUM_LOOP
call blink_decode
call DUM_LOOP
call DUM_LOOP

mov si,offset temp_assembly_to_binary; str_read_from_binary ;
call read_binary_instruction

call clrrg
mov dh,24 ;y_axis
mov dl,30 ;x_axis

call gotoxy

mov bx,offset assembly_to_binary
call split_first_8_bits

lea dx, temp_string
mov ah,09h
int 21h  

call clrrg

mov dh,25 ;y_axis
mov dl,30 ;x_axis

call gotoxy

mov bx,offset assembly_to_binary
call split_last_8_bits

lea dx, temp_string
mov ah,09h
int 21h           


call blink_read
call DUM_LOOP
call blink_load
call DUM_LOOP
call blink_execute
call DUM_LOOP
call DUM_LOOP
call decode_binary_operation




mov bx,temp_bx
jmp START_ASSEMBLY_CONVERSION3
ASSEMBLY_CONVERSION_DONE3:


;drawing boxes for files ;inside
mov ch, 13  ;y1 ; distance from top
mov dh, 14 ;y2 ;stretch top bottom
            
mov cl, 9 ;distance from left
mov dl, 21 ;x2  ;stretch

mov bh, 05 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,12 ;x_axis

call gotoxy

lea dx, str_file3
mov ah,09h
int 21h

; Show Mouse Cursor on Screen
mov	ax,1		; show Mouse Cursor Functionj
int	33h			; Mouse Interrupt

call DUM_LOOP


next3:
;FOR BOX 4

mov x_coord, 64 ;242
cmp dx, x_coord
jb next4

mov x_coord, 80
cmp dx, x_coord
ja next4

mov y_coord, 48 ;80
cmp cx, y_coord
jb next4

mov y_coord, 190
cmp cx, y_coord
ja next4

call randomNumbersForDataSeg

mov dx,offset binary_style_file
call open_file
call read_file_binary
mov bx,offset buffer_new

START_BINARY_READ:
mov al,"$"
cmp [bx],al
je END_BINARY_READ

mov di,offset str_read_from_binary
call read_from_binary_file
mov temp_bx,bx

;call DUM_LOOP
call blink_fetch
call blink_decode
call clrrg
mov dh,21 ;y_axis
mov dl,50 ;x_axis

;inc bx
call gotoxy
inc PC_VALUE
    
mov al, PC_VALUE
;call the function
call double_digit_output


;printing string
;changing cursor location
call clrrg
mov dh,24 ;y_axis
mov dl,44 ;x_axis

call gotoxy

mov bl,PC_VALUE
mov temp_PC,bl
dec temp_PC

mov al,temp_PC
call double_digit_output




call clrrg
mov dh,24 ;y_axis
mov dl,30 ;x_axis

call gotoxy
;mov temp_bx,bx
mov bx,offset str_read_from_binary
call split_first_8_bits
;mov bx,temp_bx
lea dx, temp_string
mov ah,09h
int 21h  

call clrrg

mov dh,25 ;y_axis
mov dl,30 ;x_axis

call gotoxy
;mov temp_bx,bx
mov bx,offset str_read_from_binary
call split_last_8_bits
;mov bx,temp_bx
lea dx, temp_string
mov ah,09h
int 21h           

call blink_load
call blink_execute

;----------------------------------------------
mov si,offset str_read_from_binary ;temp_assembly_to_binary
call read_binary_instruction

call decode_binary_operation
;---------------------------------------------
mov bx,temp_bx
jmp START_BINARY_READ

END_BINARY_READ:
;drawing box to read in binary format
mov ch, 4  ;y1 ; distance from top
mov dh, 5;y2 ;stretch top bottom
            
mov cl, 6 ;distance from left
mov dl, 24 ;x2  ;stretch

mov bh, 05 ;color 
call print_shape ;y_top, y_bot, x_left, x_right, color

;
;printing string
;changing cursor location
call clrrg
mov dh,4 ;y_axis
mov dl,07 ;x_axis

call gotoxy

lea dx, str_binary_file
mov ah,09h
int 21h

;CALL FUNCS HERE


; Show Mouse Cursor on Screen
mov	ax,1		; show Mouse Cursor Functionj
int	33h			; Mouse Interrupt

call DUM_LOOP

next4:
;back to its original state
;drawing boxes for files ;inside
mov ch, 09  ;y1 ; distance from top
mov dh, 10 ;y2 ;stretch top bottom
            
mov cl, 9 ;distance from left
mov dl, 21 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,10 ;y_axis
mov dl,12 ;x_axis

call gotoxy

lea dx, str_file1
mov ah,09h
int 21h

;drawing boxes for files ;inside
mov ch, 11  ;y1 ; distance from top
mov dh, 12 ;y2 ;stretch top bottom
            
mov cl, 9 ;distance from left
mov dl, 21 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,12 ;y_axis
mov dl,12 ;x_axis

call gotoxy

lea dx, str_file2
mov ah,09h
int 21h

;drawing boxes for files ;inside
mov ch, 13  ;y1 ; distance from top
mov dh, 14 ;y2 ;stretch top bottom
            
mov cl, 9 ;distance from left
mov dl, 21 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,12 ;x_axis

call gotoxy

lea dx, str_file3
mov ah,09h
int 21h

;drawing box to read in binary format
mov ch, 4  ;y1 ; distance from top
mov dh, 5;y2 ;stretch top bottom
            
mov cl, 6 ;distance from left
mov dl, 24 ;x2  ;stretch

mov bh, 11 ;color 
call print_shape ;y_top, y_bot, x_left, x_right, color

;
;printing string
;changing cursor location
call clrrg
mov dh,4 ;y_axis
mov dl,07 ;x_axis

call gotoxy

lea dx, str_binary_file
mov ah,09h
int 21h

; Show Mouse Cursor on Screen
mov	ax,1		; show Mouse Cursor Functionj
int	33h			; Mouse Interrupt

;; You can also call any other function here
;;mov x_coord,dx
;;mov y_coord,cx
;;mov dx,offset left	; Print Message
;;mov ah,09h
;;int 21h
;;mov dx,x_coord
;;mov coord, dx		; Passing as Argument in Variable
;;call print_coord	; Print X Coordinates
;;mov dl,","			; Print Comma
;;mov ah,02h
;;int 21h
;;mov dx,y_coord
;;mov coord, dx		; Passing as Argument in Variable
;;call print_coord	; Print Y Coordinates
;;mov dx,offset next_line	; Print Next Line
;;mov ah,09h
;;int 21h
.endif

.if ax==00001000b ; Means Right Mouse Button is Pressed
mov x_coord,dx
mov y_coord,cx
mov dx,offset right	; Print Message
mov ah,09h
int 21h
mov dx,x_coord
mov coord, dx		; Passing as Argument in Variable
call print_coord	; Print X Coordinates
mov dl,","			; Print Comma
mov ah,02h
int 21h
mov dx,y_coord
mov coord, dx		; Passing as Argument in Variable
call print_coord	; Print Y Coordinates
mov dx,offset next_line	; Print Next Line
mov ah,09h
int 21h
.endif

.if ax==00000001b ; Means Mouse is Moved

;mov x_coord,dx
;mov y_coord,cx
;mov dx,offset move	; Print Message
;mov ah,09h
;int 21h
;mov dx,x_coord
;mov coord, dx		; Passing as Argument in Variable
;call print_coord	; Print X Coordinates
;mov dl,","			; Print Comma
;mov ah,02h
;int 21h
;mov dx,y_coord
;mov coord, dx		; Passing as Argument in Variable
;call print_coord	; Print Y Coordinates
;mov dx,offset next_line	; Print Next Line
;mov ah,09h
;int 21h
.endif
ret
mouse_handler endp

; Terminate Program
termprg proc
mov ah,4ch
int 21h
ret
termprg endp

;*******************************
; Procedure to Print Coordinates
;*******************************
print_coord proc
call clrrg			; Clear Data Registers
mov ax,coord		; Move "coord" in 'ax' (Numerator goes in ax)
mov bx,10			; Move 10 in bx  (Denominator goes in bx)
; If value is ZERO
.if ax==0			
mov dl,al
add dl,48
mov ah,02h
int 21h
jmp return
.endif
; For Values other than ZERO
.while ax !=0
mov dx,0
div bx
push dx
inc cx
.endw
p:
pop dx
add dl,48
mov ah,02h
int 21h
loop p
return:
ret
print_coord endp

; *****************************
; Procedure to Clear Registers
; *****************************
clrrg proc
mov ax,0
mov bx,0
mov cx,0
mov dx,0
ret
clrrg endp

; *****************************
; Procedure to Shapes
; *****************************

print_shape proc 
mov ah, 06h
mov al, 0
int 10h
   
ret
print_shape endp

; *****************************
; Procedure to change co-ordinates
; *****************************

gotoxy proc
mov ah, 02h
int 10h

ret
gotoxy endp
; *****************************
; Procedure for dummy loops
; *****************************

DUM_LOOP proc
mov al,0
AGAIN:
mov cx,65500
LOOP_CX:
mov x_coord,0 ;random instructions
inc x_coord                       
loop LOOP_CX
inc al
cmp al,5
jb AGAIN

ret
DUM_LOOP endp
; *****************************
; Procedure to print MBR value
; *****************************
draw_MBR proc ;bx will contain the string which we have to print
mov temp_DX,dx
mov dh,26 ;y_axis
mov dl,10 ;x_axis
call gotoxy ;now it points to the correct location in the canvas

mov dx,temp_DX
mov ah,09h
int 21h 
    
ret
draw_MBR endp

; *****************************
; Procedure to print AC value
; *****************************

draw_AC proc ;bx will contain the string which we have to print
mov temp_DX,dx
mov dh,18 ;y_axis
mov dl,07 ;x_axis
call gotoxy ;now it points to the correct location in the canvas

mov dx,temp_DX
mov ah,09h
int 21h 
    
ret
draw_AC endp

; *****************************
; Procedure to print MQ value
; *****************************

draw_MQ proc ;bx will contain the string which we have to print
mov temp_DX,dx
mov dh,18 ;y_axis
mov dl,17 ;x_axis
call gotoxy ;now it points to the correct location in the canvas

mov dx,temp_DX
mov ah,09h
int 21h 
    
ret
draw_MQ endp

; *****************************
; Procedure to print Fetch value
; *****************************

draw_Fetch proc ;bx will contain the string which we have to print
mov temp_DX,dx
mov dh,06 ;y_axis
mov dl,31 ;x_axis
call gotoxy ;now it points to the correct location in the canvas

mov dx,temp_DX
mov ah,09h
int 21h 
    
ret
draw_Fetch endp

; *****************************
; Procedure to print Decode value
; *****************************

draw_Decode proc ;bx will contain the string which we have to print
mov temp_DX,dx
mov dh,06 ;y_axis
mov dl,41 ;x_axis
call gotoxy ;now it points to the correct location in the canvas

mov dx,temp_DX
mov ah,09h
int 21h 
    
ret
draw_Decode endp


; *****************************
; Procedure to highlight Fetch value
; *****************************

blink_fetch proc
;mov dh,08 ;y_axis
;mov dl,31 ;x_axis
;call gotoxy
mov ch, 7  ;y1 ; distance from top
mov dh, 8  ;y2 ;stretch top bottom
            
mov cl, 30 ;distance from left
mov dl, 37 ;x2  ;stretch

mov bh, 12 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,08 ;y_axis
mov dl,31 ;x_axis

call gotoxy

lea dx, str_fetch
mov ah,09h
int 21h


call DUM_LOOP
call DUM_LOOP
call DUM_LOOP

;drawing a box inside program cycle
mov ch, 7  ;y1 ; distance from top
mov dh, 8  ;y2 ;stretch top bottom
            
mov cl, 30 ;distance from left
mov dl, 37 ;x2  ;stretch

mov bh, 01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,08 ;y_axis
mov dl,31 ;x_axis

call gotoxy

lea dx, str_fetch
mov ah,09h
int 21h

ret
blink_fetch endp

; *****************************
; Procedure to highlight decode value
; *****************************

blink_decode proc
;drawing a box inside program cycle
mov ch,7  ;y1 ; distance from top
mov dh,8  ;y2 ;stretch top bottom
            
mov cl,40 ;distance from left
mov dl,47 ;x2  ;stretch

mov bh,12 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,08 ;y_axis
mov dl,41 ;x_axis

call gotoxy

lea dx, str_decode
mov ah,09h
int 21h


call DUM_LOOP
call DUM_LOOP
call DUM_LOOP

;drawing a box inside program cycle
mov ch,7  ;y1 ; distance from top
mov dh,8  ;y2 ;stretch top bottom
            
mov cl,40 ;distance from left
mov dl,47 ;x2  ;stretch

mov bh,01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,08 ;y_axis
mov dl,41 ;x_axis

call gotoxy

lea dx, str_decode
mov ah,09h
int 21h

ret
blink_decode endp

; *****************************
; Procedure to highlight read value
; *****************************

blink_read proc
;drawing a box inside program cycle
mov ch,10  ;y1 ; distance from top
mov dh,11  ;y2 ;stretch top bottom
            
mov cl,30 ;distance from left
mov dl,37 ;x2  ;stretch

mov bh,12 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,11 ;y_axis
mov dl,32 ;x_axis

call gotoxy

lea dx, str_read
mov ah,09h
int 21h


call DUM_LOOP
call DUM_LOOP
call DUM_LOOP

;drawing a box inside program cycle
mov ch,10  ;y1 ; distance from top
mov dh,11  ;y2 ;stretch top bottom
            
mov cl,30 ;distance from left
mov dl,37 ;x2  ;stretch

mov bh,01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,11 ;y_axis
mov dl,32 ;x_axis

call gotoxy

lea dx, str_read
mov ah,09h
int 21h

ret
blink_read endp

; *****************************
; Procedure to highlight load value
; *****************************

blink_load proc
;drawing a box inside program cycle
mov ch,10  ;y1 ; distance from top
mov dh,11  ;y2 ;stretch top bottom
            
mov cl,40 ;distance from left
mov dl,47 ;x2  ;stretch

mov bh,12 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,11 ;y_axis
mov dl,41 ;x_axis

call gotoxy

lea dx, str_load
mov ah,09h
int 21h

call DUM_LOOP
call DUM_LOOP
call DUM_LOOP

;drawing a box inside program cycle
mov ch,10  ;y1 ; distance from top
mov dh,11  ;y2 ;stretch top bottom
            
mov cl,40 ;distance from left
mov dl,47 ;x2  ;stretch

mov bh,01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,11 ;y_axis
mov dl,41 ;x_axis

call gotoxy

lea dx, str_load
mov ah,09h
int 21h

ret
blink_load endp

; *****************************
; Procedure to highlight execute value
; *****************************

blink_execute proc
;drawing a box inside program cycle
mov ch,13  ;y1 ; distance from top
mov dh,14  ;y2 ;stretch top bottom
            
mov cl,30 ;distance from left
mov dl,37 ;x2  ;stretch

mov bh,12 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,30 ;x_axis

call gotoxy

lea dx, str_execute
mov ah,09h
int 21h

call DUM_LOOP
call DUM_LOOP
call DUM_LOOP

;drawing a box inside program cycle
mov ch,13  ;y1 ; distance from top
mov dh,14  ;y2 ;stretch top bottom
            
mov cl,30 ;distance from left
mov dl,37 ;x2  ;stretch

mov bh,01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,30 ;x_axis

call gotoxy

lea dx, str_execute
mov ah,09h
int 21h

ret
blink_execute endp

; *****************************
; Procedure to highlight storevalue
; *****************************

blink_store proc
;drawing a box inside program cycle
mov ch,13  ;y1 ; distance from top
mov dh,14  ;y2 ;stretch top bottom
            
mov cl,40 ;distance from left
mov dl,47 ;x2  ;stretch

mov bh,12 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,41 ;x_axis

call gotoxy

lea dx, str_store   
mov ah,09h
int 21h

call DUM_LOOP
call DUM_LOOP

;drawing a box inside program cycle
mov ch,13  ;y1 ; distance from top
mov dh,14  ;y2 ;stretch top bottom
            
mov cl,40 ;distance from left
mov dl,47 ;x2  ;stretch

mov bh,01 ;color 

call print_shape ;y_top, y_bot, x_left, x_right, color

;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,41 ;x_axis

call gotoxy

lea dx, str_store   
mov ah,09h
int 21h

ret
blink_store endp

; *****************************
; Procedure to Open File
; *****************************
open_file proc
;mov dx,offset file
mov al,0
mov ah,3dh
int 21h

ret
open_file endp
; *****************************
; Procedure to Read File
; *****************************
read_file proc ;has to be immediately called after open_file
mov bx,ax ;loading file handler
mov dx,offset buffer
mov ah,3fh ;read file
int 21h

ret
read_file endp
; *****************************
; Procedure to Read bin File
; *****************************
read_file_binary proc ;has to be immediately called after open_file
mov bx,ax ;loading file handler
mov dx,offset buffer_new
mov ah,3fh ;read file
int 21h

ret
read_file_binary endp

; ******************************
; Procedure to Tokenize string *
; ******************************

tokenize_string proc
;mov bx,offset buffer
;mov di,offset full_instruction
;finding operation
;loop will run until a space is encountered
;Traversing to the next line

READ_OPER_INIT:
inc bx
mov si,offset read_operation ;will contain operation

READ_OPER:
mov al,' '
cmp [bx],al
je READ_OP1_INIT   
mov al,[bx]
mov [si],al
;mov [di],al
;inc di
inc si ;inc index
inc bx ;inc operation
jmp READ_OPER

READ_OP1_INIT:
;here I will advance my index to one index so that it will point to the beginning of op1
inc bx
;inc di
;mov al,' '
;mov [di],al ;entering a space
;inc di ;again incrementing
mov si,offset read_op1

READ_OP1_START:
mov al,','
cmp [bx],al
je READ_OP2_INIT
mov al,[bx]
mov [si],al
;mov [di],al
inc bx    
;inc di
inc si
jmp READ_OP1_START

READ_OP2_INIT:
;inc di
;mov al,' '
;mov [di],al ;entering a space
;inc di ;again incrementing
inc bx ;points to space
inc bx ;point to begining of op2
mov si,offset read_op2

READ_OP2_START:
mov al, 0Ah ;newline
cmp [bx], al
je RETURN_STRINGS
mov al,[bx]
mov [si],al        
;mov [di],al
inc si
inc bx
;inc di
jmp READ_OP2_START
 
RETURN_STRINGS:    
mov temp_bx,bx
call clrrg

mov dh,25 ;y_axis
mov dl,30 ;x_axis

call gotoxy

lea dx,read_operation
mov ah,09h
int 21h

lea dx,read_op1
mov ah,09h
int 21h
lea dx,read_op2
mov ah,09h
int 21h


call checkRegister_op1
call checkRegister_op2

call convert_to_binary
mov bx,temp_bx
ret
tokenize_string endp

; *******************************
; Procedure to read data members*
; *******************************
read_data proc
mov bx, offset buffer

;Traversing to the next line
FIND_NL:
mov al,0Ah
cmp [bx],al
je READ_VARIABLE_INIT
inc bx
jmp FIND_NL
                     
READ_VARIABLE_INIT:
mov di, offset read_variable
inc bx ;pointing to start of data member
                     
READ_VARIABLE_START:
mov al,' '
cmp [bx],al
je READ_DATA_TYPE_INIT
mov al,[bx]
mov [di],al
inc di
inc bx
jmp READ_VARIABLE_START

READ_DATA_TYPE_INIT:
inc bx
mov di,offset read_data_type

READ_DATA_TYPE_START:
mov al,' '
cmp [bx],al
je READ_VALUE_INIT
mov al,[bx]
mov [di],al
inc di
inc bx
jmp READ_DATA_TYPE_START

READ_VALUE_INIT:
inc bx
mov di,offset read_value

READ_VALUE_START:
mov al,0Ah
cmp [bx],al
je CHECK_DATA
mov al,[bx]
mov [di],al
inc di
inc bx
jmp READ_VALUE_START

CHECK_DATA:
inc bx
mov al,'.' ;means that .code seg has started
cmp [bx],al
je RETURN_DATA
jmp READ_VARIABLE_START

RETURN_DATA:
ret
read_data endp
; *******************************
; Procedure to check (Memory or register) for OP1
; *******************************

checkRegister_op1 proc
;before calling the function make sure that
;isReg_op has been cleared and the offset
;of op1 or op2 has been placed in di
mov is_AX_op1,0
mov is_BX_op1,0
mov is_CX_op1,0
mov is_DX_op1,0
 
mov isReg_op1,0 ;initially it will be 0
mov di,offset read_op1
mov si,offset str_AX
COMPARE_AX: ;check for ax
mov al,[si]
cmp [di],al
jne COMPARE_BX_INIT
inc di
inc si
;pointing to next character
mov al,[si]
cmp [di],al
jne COMPARE_BX_INIT
mov isReg_op1,1 ;means it is a register
mov is_AX_op1,1
jmp RETURN_REGISTER

COMPARE_BX_INIT:
mov di,offset read_op1
mov si,offset str_BX

COMPARE_BX:
mov al,[si]
cmp [di],al
jne COMPARE_CX_INIT
inc di
inc si
;pointing to next character
mov al,[si]
cmp [di],al
jne COMPARE_CX_INIT
mov isReg_op1,1 ;means it is a register
mov is_BX_op1,1
jmp RETURN_REGISTER

COMPARE_CX_INIT:
mov di,offset read_op1
mov si,offset str_CX

COMPARE_CX:
mov al,[si]
cmp [di],al
jne COMPARE_DX_INIT
inc di
inc si
;pointing to next character
mov al,[si]
cmp [di],al
jne COMPARE_DX_INIT
mov isReg_op1,1 ;means it is a register
mov is_CX_op1,1
jmp RETURN_REGISTER

COMPARE_DX_INIT:
mov di,offset read_op1
mov si,offset str_DX

COMPARE_DX:
mov al,[si]
cmp [di],al
jne RETURN_REGISTER
inc di
inc si
;pointing to next character
mov al,[si]
cmp [di],al
jne RETURN_REGISTER
mov isReg_op1,1 ;means it is a register
mov is_DX_op1,1
jmp RETURN_REGISTER


RETURN_REGISTER:    
ret
checkRegister_op1 endp

; *******************************
; Procedure to check (Memory or register) for OP2
; *******************************

checkRegister_op2 proc
;before calling the function make sure that
;isReg_op has been cleared and the offset
;of op1 or op2 has been placed in di
mov is_AX_op2,0
mov is_BX_op2,0
mov is_CX_op2,0
mov is_DX_op2,0

mov isReg_op2,0
mov di,offset read_op2
mov si,offset str_AX
COMPARE_AX_OP2: ;check for ax
mov al,[si]
cmp [di],al
jne COMPARE_BX_INIT_OP2
inc di
inc si
;pointing to next character
mov al,[si]
cmp [di],al
jne COMPARE_BX_INIT_OP2
mov isReg_op1,1 ;means it is a register
mov is_AX_op2,1
jmp RETURN_REGISTER_OP2

COMPARE_BX_INIT_OP2:
mov di,offset read_op2
mov si,offset str_BX

COMPARE_BX_OP2:
mov al,[si]
cmp [di],al
jne COMPARE_CX_INIT_OP2
inc di
inc si
;pointing to next character
mov al,[si]
cmp [di],al
jne COMPARE_CX_INIT_OP2
mov isReg_op1,1 ;means it is a register
mov is_BX_op2,1
jmp RETURN_REGISTER_OP2

COMPARE_CX_INIT_OP2:
mov di,offset read_op2
mov si,offset str_CX

COMPARE_CX_OP2:
mov al,[si]
cmp [di],al
jne COMPARE_DX_INIT_OP2
inc di
inc si
;pointing to next character
mov al,[si]
cmp [di],al
jne COMPARE_DX_INIT_OP2
mov isReg_op1,1 ;means it is a register
mov is_CX_op2,1
jmp RETURN_REGISTER_OP2

COMPARE_DX_INIT_OP2:
mov di,offset read_op2
mov si,offset str_DX

COMPARE_DX_OP2:
mov al,[si]
cmp [di],al
jne RETURN_REGISTER_OP2
inc di
inc si
;pointing to next character
mov al,[si]
cmp [di],al
jne RETURN_REGISTER_OP2
mov isReg_op1,1 ;means it is a register
mov is_DX_op2,1
jmp RETURN_REGISTER_OP2


RETURN_REGISTER_OP2:    
ret
checkRegister_op2 endp

; *******************************
; Procedure to convert assembly to binary
; *******************************

convert_to_binary proc
;this function will be called from tokenize string
;will convert instructions to binary
COMPARE_ADD_INIT:
mov di,offset str_add
mov si,offset read_operation

COMPARE_ADD:
mov al,[si]
cmp [di],al
jne COMPARE_SUB_INIT
inc di
inc si ;next index
mov al,[si]
cmp [di],al
jne COMPARE_SUB_INIT
inc di 
inc si
mov al,[si]
cmp [di],al
jne COMPARE_SUB_INIT
inc di ;now it points to binary of add
mov si,offset assembly_to_binary
mov cl,1
copy_binary_add:
cmp cl,5 ;if all 4 are copied
je COMPARE_MODE_OP1
mov al,[di]
mov [si],al
inc si
inc di
inc cl
jmp copy_binary_add
;jmp COMPARE_MODE_OP1 ;jump to next operation

COMPARE_SUB_INIT:
mov di,offset str_sub
mov si,offset read_operation
 
COMPARE_SUB:
mov al,[si]
cmp [di],al
jne COMPARE_SHL_INIT
inc di
inc si ;next index
mov al,[si]
cmp [di],al
jne COMPARE_SHL_INIT
inc di 
inc si
mov al,[si]
cmp [di],al
jne COMPARE_SHL_INIT
inc di ;now it points to binary of add
mov si,offset assembly_to_binary
mov cl,1
copy_binary_sub:
cmp cl,5 ;if all 4 are copied
je COMPARE_MODE_OP1
mov al,[di]
mov [si],al
inc si
inc di
inc cl
jmp copy_binary_sub
;jmp COMPARE_MODE_OP1 ;jump to next operation

COMPARE_SHL_INIT:
mov di,offset str_shl
mov si,offset read_operation
 
COMPARE_SHL:
mov al,[si]
cmp [di],al
jne COMPARE_SHR_INIT
inc di
inc si ;next index
mov al,[si]
cmp [di],al
jne COMPARE_SHR_INIT
inc di 
inc si
mov al,[si]
cmp [di],al
jne COMPARE_SHR_INIT
inc di ;now it points to binary of add
mov si,offset assembly_to_binary
mov cl,1
copy_binary_shl:
cmp cl,5 ;if all 4 are copied
je COMPARE_MODE_OP1
mov al,[di]
mov [si],al
inc si
inc di
inc cl
jmp copy_binary_shl
;jmp COMPARE_MODE_OP1 ;jump to next operation

COMPARE_SHR_INIT:
mov di,offset str_shr
mov si,offset read_operation        
 
COMPARE_SHR:
mov al,[si]
cmp [di],al
jne COMPARE_AND_INIT
inc di
inc si ;next index
mov al,[si]
cmp [di],al
jne COMPARE_AND_INIT
inc di 
inc si
mov al,[si]
cmp [di],al
jne COMPARE_AND_INIT
inc di ;now it points to binary of add
mov si,offset assembly_to_binary
mov cl,1
copy_binary_shr:
cmp cl,5 ;if all 4 are copied
je COMPARE_MODE_OP1
mov al,[di]
mov [si],al
inc si
inc di
inc cl
jmp copy_binary_shr
;jmp COMPARE_MODE_OP1 ;jump to next operation

COMPARE_AND_INIT:
mov di,offset str_and
mov si,offset read_operation        
 
COMPARE_AND:
mov al,[si]
cmp [di],al
jne COMPARE_MOV_INIT
inc di
inc si ;next index
mov al,[si]
cmp [di],al
jne COMPARE_MOV_INIT
inc di 
inc si
mov al,[si]
cmp [di],al
jne COMPARE_MOV_INIT
inc di ;now it points to binary of add
mov si,offset assembly_to_binary
mov cl,1
copy_binary_and:
cmp cl,5 ;if all 4 are copied
je COMPARE_MODE_OP1
mov al,[di]
mov [si],al
inc si
inc di
inc cl
jmp copy_binary_and
;jmp COMPARE_MODE_OP1 ;jump to next operation

COMPARE_MOV_INIT:
mov di,offset str_mov
mov si,offset read_operation        
 
COMPARE_MOV:
mov al,[si]
cmp [di],al
jne COMPARE_DIV_INIT
inc di
inc si ;next index
mov al,[si]
cmp [di],al
jne COMPARE_DIV_INIT
inc di 
inc si
mov al,[si]
cmp [di],al
jne COMPARE_DIV_INIT
inc di ;now it points to binary of add
mov si,offset assembly_to_binary
mov cl,1
copy_binary_mov:
cmp cl,5 ;if all 4 are copied
je COMPARE_MODE_OP1
mov al,[di]
mov [si],al
inc si
inc di
inc cl
jmp copy_binary_mov
;jmp COMPARE_MODE_OP1 ;jump to next operation
COMPARE_DIV_INIT:

COMPARE_MODE_OP1:
;mov si,offset assembly_to_binary
;add si,4
mov al,0
cmp isReg_op1,al
jz COPY_ZERO_OP1
mov al,'1'
;inc si ;points to next location
mov [si],al
jmp COMPARE_MODE_OP2
COPY_ZERO_OP1:
mov al,'0'
inc si
mov [si],al

COMPARE_MODE_OP2:
mov al,0
cmp isReg_op2,al
jz COPY_ZERO_OP2
mov al,'1'
inc si ;points to next location
mov [si],al
jmp COMPARE_REG_OP1
COPY_ZERO_OP2:
mov al,'0'
inc si
mov [si],al
   
;**********************
;Will copy registers binary if found
;**********************
COMPARE_REG_OP1:
cmp is_AX_op1,0
jnz COPY_AX_OP1

cmp is_BX_op1,0
jnz COPY_BX_OP1

cmp is_CX_op1,0
jnz COPY_CX_OP1

cmp is_DX_op1,0
jnz COPY_DX_OP1

;MEMORY PART WILL START FROM HERE
COPY_AX_OP1:
;call fill_zero_six
mov di,offset str_AX
add di,2 ;now it points to start of AX binary
inc si   
mov al,[di]
mov [si],al
inc si
inc di   
mov al,[di]
mov [si],al ;binary is now copied
jmp COMPARE_REG_OP2

COPY_BX_OP1:
;call fill_zero_six
mov di,offset str_BX
add di,2 ;now it points to start of BX binary
inc si   
mov al,[di]
mov [si],al
inc si
inc di   
mov al,[di]
mov [si],al ;binary is now copied
jmp COMPARE_REG_OP2

COPY_CX_OP1:
;call fill_zero_six
mov di,offset str_CX
add di,2 ;now it points to start of CX binary
inc si   
mov al,[di]
mov [si],al
inc si
inc di   
mov al,[di]
mov [si],al ;binary is now copied
jmp COMPARE_REG_OP2

COPY_DX_OP1:
;call fill_zero_six
mov di,offset str_DX
add di,2 ;now it points to start of DX binary
inc si   
mov al,[di]
mov [si],al
inc si
inc di   
mov al,[di]
mov [si],al ;binary is now copied
jmp COMPARE_REG_OP2

COMPARE_REG_OP2:
cmp is_AX_op2,0
jnz COPY_AX_OP2

cmp is_BX_op2,0
jnz COPY_BX_OP2

cmp is_CX_op2,0
jnz COPY_CX_OP2

cmp is_DX_op2,0
jnz COPY_DX_OP2 

;=================================
;IF NO CONDITION RUNS THEN CHECK FROM MEMORU
;=================================

;jmp CHECK_MEMORY_OP2
;jmp RETURN_BINARY

;MEMORY PART WILL START FROM HERE
COPY_AX_OP2:
call fill_zero_six
mov di,offset str_AX
add di,2 ;now it points to start of AX binary
inc si   
mov al,[di]
mov [si],al
inc si
inc di   
mov al,[di]
mov [si],al ;binary is now copied
jmp RETURN_BINARY

COPY_BX_OP2:
call fill_zero_six
mov di,offset str_BX
add di,2 ;now it points to start of AX binary
inc si   
mov al,[di]
mov [si],al
inc si
inc di   
mov al,[di]
mov [si],al ;binary is now copied
jmp RETURN_BINARY

COPY_CX_OP2:
call fill_zero_six
mov di,offset str_CX
add di,2 ;now it points to start of AX binary
inc si   
mov al,[di]
mov [si],al
inc si
inc di   
mov al,[di]
mov [si],al ;binary is now copied
jmp RETURN_BINARY

COPY_DX_OP2:
call fill_zero_six
mov di,offset str_DX
add di,2 ;now it points to start of AX binary
inc si   
mov al,[di]
mov [si],al
inc si
inc di   
mov al,[di]
mov [si],al ;binary is now copied
jmp RETURN_BINARY

RETURN_BINARY:
ret
convert_to_binary endp

; *******************************
; Procedure to Append six zeros
; *******************************

fill_zero_six proc ;this function will append six zeros to the string loaded in si
inc si
mov al,'0'
mov [si],al    
inc si
mov al,'0'
mov [si],al    
inc si
mov al,'0'
mov [si],al    
inc si
mov al,'0'
mov [si],al    
inc si
mov al,'0'
mov [si],al    
inc si
mov al,'0'
mov [si],al    

ret
fill_zero_six endp

append_newl proc
;this func will convert append a newline in 16 bit binary
mov si,offset assembly_to_binary
mov temp_si, bx
;add bx,8
FIND_END:
mov al,"$"
cmp [bx],al
je RIGHT_TRAVERSE_INIT
inc bx
inc si
jmp FIND_END

RIGHT_TRAVERSE_INIT:  
mov cl,1
RIGHT_TRAVERSE_STRING:
cmp bl,8
je APPEND_NEWL_NOW
dec si ;now bx points to second last value
mov al, [si]
mov [bx],al
dec bx
dec si
inc cl
jmp RIGHT_TRAVERSE_STRING

APPEND_NEWL_NOW:
mov al, 0Ah
dec bx
mov [bx],al

ret
append_newl endp

; *******************************
; Procedure to split string to 8-bits first
; *******************************
split_first_8_bits proc
mov si,offset temp_string
mov al,0
COPY_FIRST_8:
cmp al,8
je RETURN_STRING_FIRST
mov cl,[bx]
mov [si],cl
inc si
inc bx
inc al
jmp COPY_FIRST_8

RETURN_STRING_FIRST: 
ret
split_first_8_bits endp

; *******************************
; Procedure to split string to 8-bits last
; *******************************
split_last_8_bits proc
add bx,8 ;points to the character to be copied
mov si,offset temp_string
mov al,0
COPY_LAST_8:
cmp al,8
je RETURN_STRING_LAST
mov cl,[bx]
mov [si],cl
inc si
inc bx
inc al
jmp COPY_LAST_8

RETURN_STRING_LAST: 
ret
split_last_8_bits endp

; *******************************
; Procedure to output 2 digits
; *******************************

double_digit_output proc
    mov ch, 0
    mov dh, 0
    mov ah, 0
    mov cl, 0
    l1_rand:
    mov dx,0
    mov ten, 10
    div ten
    push dx
    inc  cx
    cmp ax,0
    ja l1_rand
    
    l2_rand:
    pop dx
    add dx, 48
    mov ah, 02h
    int 21h
    dec cx
    cmp cx,0
    ja l2_rand
    
ret
double_digit_output endp
; *******************************
; Procedure to read instruction in binary
; *******************************

read_binary_instruction proc
;si contains the string which we have to read
;we will read the first four bits which will contain the opcode 
mov di,offset read_operation_binary
mov bl,0
READ_BINARY_OPERATION:
mov al,[si]
mov [di],al
inc di
inc si
mov al,[si]
mov [di],al
inc di
inc si
mov al,[si]
mov [di],al
inc di
inc si
mov al,[si]
mov [di],al
inc di
;inc si

 
READ_MODE_BINARY_INIT:
mov di,offset read_mode_binary
inc si ;pointing to next index
;here I will read the two mode bits corresponding to which 
;I will choose the size of my instruction
mov al,[si]
mov [di],al
inc si
inc di
mov al,[si]
mov [di],al
inc si
;inc di

CHECK_4_OR_10_0:  ;00/01
mov di,offset read_mode_binary ;now we will read from file
;if mode is 01 or 00
;if mode is 10 or 11
mov al,'0'
cmp [di],al
jne CHECK_4_OR_10_1 ;mode starts with 1
;mov [di],al
mov al,'1'
inc di
;inc si
cmp [di],al
je CASE_01_INIT
;check if the second bit was 0
mov al,'0'
;inc di
cmp [di],al
je CASE_00_INIT

CHECK_4_OR_10_1: ;10/11
;mov di,offset read_mode_binary
mov al,'1'
cmp [di],al
jne CASE_01_INIT ;mode starts with 1
;assume first bit of mode is 1
;mov [di],al
;inc si
inc di
mov al,'0'
;inc di
cmp [di],al
je CASE_10_INIT
;check if the second bit was 0
mov al,'1'
;inc di
cmp [di],al
je CASE_11_INIT

TEN_BIT_BINARY:
;here the max size will be 10 bits

CASE_01_INIT:
;0 means memory ;1 means memory
;mov [di],al
;inc si
mov di,offset read_op1_binary
mov bl,0 

CASE_01:
cmp bl,8 ;we need to copy 8 bits
je NEXT_CASE_01
mov al,[si]
mov [di],al
inc si
inc di 
inc bl
jmp CASE_01
 
NEXT_CASE_01:
;now we will copy remaining two bits
mov di,offset read_op2_binary
mov al,[si]
mov [di],al
inc si
inc di
mov al,[si]
mov [di],al
inc si
inc di

jmp RETURN_BINARY_TOKEN

CASE_00_INIT:
;mov [di],al
;in this case we will copy 4 bits
;0 means memory ;1 means memory

mov di,offset read_op1_binary
mov al,[si]
mov [di],al
inc si
inc di
mov al,[si]
mov [di],al
inc si
inc di
mov di,offset read_op2_binary
mov al,[si]
mov [di],al
inc si
inc di
mov al,[si]
mov [di],al
inc si
inc di
jmp RETURN_BINARY_TOKEN

CASE_10_INIT:
;mov [di],al
;
mov di,offset read_op1_binary
mov al,[si]
mov [di],al
inc si
inc di
mov al,[si]
mov [di],al
inc si
inc di

mov bl,0
mov di,offset read_op2_binary

CASE_10:
cmp bl,8 ;we need to copy 8 bits
je RETURN_BINARY_TOKEN
mov al,[si]
mov [di],al
inc si
inc di
inc bl
jmp CASE_10

CASE_11_INIT:
;PRINT AN ERROR MESSAGE HERE


RETURN_BINARY_TOKEN:
call print_opcode
lea dx,read_operation_binary
mov ah,09h
int 21h

call print_mode
lea dx,read_mode_binary
mov ah,09h
int 21h

call print_op1
lea dx,read_op1_binary
mov ah,09h
int 21h

call print_op2
lea dx,read_op2_binary
mov ah,09h
int 21h

ret 
read_binary_instruction endp

; *******************************
; Procedure to read/decode instruction in binary
; *******************************

decode_binary_operation proc
;mov ah,01h
;int 21h
;HAS TO BE CALLED IMMEDIATELY AFTER READING BINARY INS
decode_opcode_add:
mov di,offset read_operation_binary
mov si,offset str_add
add si,3 ;now this points to binary of add
mov al,[di] 
cmp [si],al
jne decode_opcode_sub
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_sub
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_sub
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_sub
jmp PERFORM_ADD

decode_opcode_sub:
mov di,offset read_operation_binary
mov si,offset str_sub
add si,3 ;now this points to binary of add
mov al,[di] 
cmp [si],al
jne decode_opcode_and
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_and
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_and
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_and
jmp PERFORM_SUB ;ANDNADNADNA

decode_opcode_and:
mov di,offset read_operation_binary
mov si,offset str_and
add si,3 ;now this points to binary of add
mov al,[di] 
cmp [si],al
jne decode_opcode_shl
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_shl
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_shl
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_shl
jmp PERFORM_AND ;ANDNADNADNA

decode_opcode_shl:
mov di,offset read_operation_binary
mov si,offset str_shl
add si,3 ;now this points to binary of add
mov al,[di] 
cmp [si],al
jne decode_opcode_shr
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_shr
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_shr
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_shr
jmp PERFORM_shl 

decode_opcode_shr:
mov di,offset read_operation_binary
mov si,offset str_shr
add si,3 ;now this points to binary of add
mov al,[di] 
cmp [si],al
jne decode_opcode_mov
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_mov
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_mov
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_mov
jmp PERFORM_shr 

decode_opcode_mov:
mov di,offset read_operation_binary
mov si,offset str_mov
add si,3 ;now this points to binary of add
mov al,[di] 
cmp [si],al
jne decode_opcode_mul
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_mul
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_mul
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_mul
jmp PERFORM_mov 
 
decode_opcode_mul:
mov di,offset read_operation_binary
mov si,offset str_mul_2
add si,3 ;now this points to binary of add
mov al,[di] 
cmp [si],al
jne decode_opcode_div
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_div
inc si              
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_div
inc si
inc di
mov al,[di] 
cmp [si],al
jne decode_opcode_div
jmp PERFORM_mul 

decode_opcode_div:
mov di,offset read_operation_binary
mov si,offset str_div
add si,3 ;now this points to binary of add
mov al,[di] 
cmp [si],al
jne PRINT_ERROR
inc si
inc di
mov al,[di] 
cmp [si],al
jne PRINT_ERROR
inc si              
inc di
mov al,[di] 
cmp [si],al
jne PRINT_ERROR
inc si
inc di
mov al,[di] 
cmp [si],al
jne PRINT_ERROR
jmp PERFORM_div 

PERFORM_ADD:
call clrrg  ;clearing
mov varInt,0
mov si,offset read_op1_binary 
call convertBinToDecimal_2bit
;will have to call load random
mov di,offset hold_reg_value
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov al,varInt
mov temp_varInt,al
mov bl,[di] ;temp
call clrrg  ;clearing
mov varInt,0
mov si,offset read_op2_binary 
call convertBinToDecimal_8bit
mov di,offset dataBuff
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov cl,[di]
;Now I have both the value
;next step is to perform operation on them
;MAINSTEP
add cl,bl
mov al,cl
cmp temp_varInt,0
je SHOW_IN_AX
cmp temp_varInt,1
je SHOW_IN_BX
cmp temp_varInt,2
je SHOW_IN_CX
cmp temp_varInt,3
je SHOW_IN_DX
jmp SHOW_IN_DX

jmp RETURN_DECODE

PERFORM_SUB:
call clrrg  ;clearing
mov varInt,0
mov si,offset read_op1_binary 
call convertBinToDecimal_2bit
;will have to call load random
mov di,offset hold_reg_value
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov al,varInt
mov temp_varInt,al
mov bl,[di] ;temp
call clrrg  ;clearing
mov varInt,0
mov si,offset read_op2_binary 
call convertBinToDecimal_8bit
mov di,offset dataBuff
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov cl,[di]
;Now I have both the value
;next step is to perform operation on them
;MAINSTEP
sub cl,bl
mov al,cl
cmp temp_varInt,0
je SHOW_IN_AX
cmp temp_varInt,1
je SHOW_IN_BX
cmp temp_varInt,2
je SHOW_IN_CX
cmp temp_varInt,3
je SHOW_IN_DX
jmp SHOW_IN_DX

jmp RETURN_DECODE

;reversed for and
PERFORM_AND:
mov si,offset read_op1_binary 
call convertBinToDecimal_2bit
;will have to call load random
mov di,offset hold_reg_value
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov al,varInt
mov temp_varInt,al
mov bl,[di] ;temp
mov si,offset read_op2_binary 
call convertBinToDecimal_8bit
mov di,offset dataBuff
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov cl,[di]
;Now I have both the value
;next step is to perform operation on them
;MAINSTEP
and cl,bl
mov al,cl
cmp temp_varInt,0
je SHOW_IN_AX
cmp temp_varInt,1
je SHOW_IN_BX
cmp temp_varInt,2
je SHOW_IN_CX
cmp temp_varInt,3
je SHOW_IN_DX
jmp SHOW_IN_DX

jmp RETURN_DECODE


PERFORM_SHL:
mov si,offset read_op1_binary 
call convertBinToDecimal_2bit
;will have to call load random
mov di,offset hold_reg_value
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov al,varInt
mov temp_varInt,al
mov bl,[di] ;temp
mov si,offset read_op2_binary 
call convertBinToDecimal_8bit
mov di,offset dataBuff
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov cl,[di]
;Now I have both the value
;next step is to perform operation on them
;MAINSTEP
;shl cl,bl
mov al,cl
cmp temp_varInt,0
je SHOW_IN_AX
cmp temp_varInt,1
je SHOW_IN_BX
cmp temp_varInt,2
je SHOW_IN_CX
cmp temp_varInt,3
je SHOW_IN_DX
jmp SHOW_IN_DX

jmp RETURN_DECODE

  
PERFORM_SHR:
mov si,offset read_op1_binary 
call convertBinToDecimal_2bit
;will have to call load random
mov di,offset hold_reg_value
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov al,varInt
mov temp_varInt,al
mov bl,[di] ;temp
mov si,offset read_op2_binary 
call convertBinToDecimal_8bit
mov di,offset dataBuff
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov cl,[di]
;Now I have both the value
;next step is to perform operation on them
;MAINSTEP
;shr cl
mov al,cl
cmp temp_varInt,0
je SHOW_IN_AX
cmp temp_varInt,1
je SHOW_IN_BX
cmp temp_varInt,2
je SHOW_IN_CX
cmp temp_varInt,3
je SHOW_IN_DX
jmp SHOW_IN_DX

jmp RETURN_DECODE
 
PERFORM_MUL:
mov si,offset read_op1_binary 
call convertBinToDecimal_2bit
;will have to call load random
mov di,offset hold_reg_value
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov al,varInt
mov temp_varInt,al
mov bl,[di] ;temp
mov si,offset read_op2_binary 
call convertBinToDecimal_8bit
mov di,offset dataBuff
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov cl,[di]
;Now I have both the value
;next step is to perform operation on them
;MAINSTEP
mov al,cl
mul bl
cmp temp_varInt,0
je SHOW_IN_AX
cmp temp_varInt,1
je SHOW_IN_BX
cmp temp_varInt,2
je SHOW_IN_CX
cmp temp_varInt,3
je SHOW_IN_DX
jmp SHOW_IN_DX

jmp RETURN_DECODE

PERFORM_DIV:
mov si,offset read_op1_binary 
call convertBinToDecimal_2bit
;will have to call load random
mov di,offset hold_reg_value
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov al,varInt
mov temp_varInt,al
mov bl,[di] ;temp
mov si,offset read_op2_binary 
call convertBinToDecimal_8bit
mov di,offset dataBuff
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov cl,[di]
;Now I have both the value
;next step is to perform operation on them
;MAINSTEP
mov al,cl
div bl
cmp temp_varInt,0
je SHOW_IN_AX
cmp temp_varInt,1
je SHOW_IN_BX
cmp temp_varInt,2
je SHOW_IN_CX
cmp temp_varInt,3
je SHOW_IN_DX
jmp SHOW_IN_DX

jmp RETURN_DECODE

PERFORM_MOV:
mov si,offset read_op1_binary 
call convertBinToDecimal_2bit
;will have to call load random
mov di,offset hold_reg_value
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov al,varInt
mov temp_varInt,al
mov bl,[di] ;temp
mov si,offset read_op2_binary 
call convertBinToDecimal_8bit
mov di,offset dataBuff
mov ah,0
mov al,varInt
add di,ax ;now it points to correct registers value
mov cl,[di]
;Now I have both the value
;next step is to perform operation on them
;MAINSTEP
mov al,bl
cmp temp_varInt,0
je SHOW_IN_AX
cmp temp_varInt,1
je SHOW_IN_BX
cmp temp_varInt,2
je SHOW_IN_CX
cmp temp_varInt,3
je SHOW_IN_DX
jmp SHOW_IN_DX

jmp RETURN_DECODE

SHOW_IN_AX:
mov temp_varInt,al
;printing string
;changing cursor location
call clrrg
mov dh,11 ;y_axis
mov dl,60 ;x_axis

call gotoxy

mov al,temp_varInt
call double_digit_output

call show_output
mov al,temp_varInt
call double_digit_output

jmp RETURN_DECODE

SHOW_IN_BX:
mov temp_varInt,al
;printing string
;changing cursor location
call clrrg
mov dh,12 ;y_axis
mov dl,60 ;x_axis

call gotoxy

mov al,temp_varInt
call double_digit_output

call show_output
mov al,temp_varInt
call double_digit_output

jmp RETURN_DECODE

SHOW_IN_CX:
mov temp_varInt,al
;printing string
;changing cursor location
call clrrg
mov dh,13 ;y_axis
mov dl,60 ;x_axis

call gotoxy

mov al,temp_varInt
call double_digit_output

call show_output
mov al,temp_varInt
call double_digit_output


;lea dx,str_contents
;mov ah,09h
;int 21h
;mov ah,02h
;mov dl,al
;add dl,48
;int 21h
;
jmp RETURN_DECODE

SHOW_IN_DX:
mov temp_varInt,al
;printing string
;changing cursor location
call clrrg
mov dh,14 ;y_axis
mov dl,60 ;x_axis

call gotoxy

mov al,temp_varInt
call double_digit_output

call show_output
mov al,temp_varInt
call double_digit_output

;lea dx,str_contents
;mov ah,09h
;int 21h
;mov ah,02h
;mov dl,al
;add dl,48
;int 21h
;
jmp RETURN_DECODE
PRINT_ERROR:
call print_syntax_error 
    
RETURN_DECODE:
ret
decode_binary_operation endp

; *******************************************
; Procedure to convert binary str to decimal 2-bits*
; *******************************************

convertBinToDecimal_2bit PROC
    ;si will contrain the bin string to convert
    ;mov si,offset binary_str
    mov count,1
    mov cx, 2 
    conversionLoop: 
	    mov al, 1 
	    mov bl, 2 
	    mov dl, count 
	    mov dh, "1"
	    cmp [si], dh 
	    jne zero 
	    cmp count, 0 
	    je breakOut 
		    power: 
		    mul bl 
		    dec count 
		    cmp count, 0 
		    jne power 
	    add varInt, al 
	    zero: 
	    mov count, dl 
	    dec count 
	    inc si 
    loop conversionLoop 
    
    breakOut:
    mov dh, "1" 
    cmp [si], dh
    jne zero2 
    inc varInt 
    zero2: 
    mov ah, 02h 
    mov dl, varInt 
    add dl, 48 
    ;int 21h

ret
convertBinToDecimal_2bit endp

convertBinToDecimal_8bit PROC
    ;si will contrain the bin string to convert
    ;mov si,offset binary_str
    mov count,7
    mov cx, 8
    conversionLoop2: 
	    mov al, 1 
	    mov bl, 2 
	    mov dl, count 
	    mov dh, "1"
	    cmp [si], dh 
	    jne zero_1 
	    cmp count, 0 
	    je breakOut2 
		    power2: 
		    mul bl 
		    dec count 
		    cmp count, 0 
		    jne power2 
	    add varInt, al 
	    zero_1: 
	    mov count, dl 
	    dec count 
	    inc si 
    loop conversionLoop2 
    
    breakOut2:
    mov dh, "1" 
    cmp [si], dh
    jne zero2_2 
    inc varInt 
    zero2_2: 
    mov ah, 02h 
    mov dl, varInt 
    add dl, 48 
    ;int 21h

ret
convertBinToDecimal_8bit endp

;Generates dummy loop
DUM_LOOP_SMALL proc

;mov al,0
;AGAIN:
mov cx,2500
LOOP_CX:
mov x_coord,0 ;random instructions
inc x_coord                       
loop LOOP_CX
;inc al
;cmp al,1
;jb AGAIN

ret
DUM_LOOP_SMALL endp

; *******************************
; Procedure to copy two strings
; *******************************
copy_string proc
;bx contrains the source
;si contrains the destination

START_COPY:
mov al,"$"
cmp [bx],al
je RETURN_COPY
mov al,[bx]
mov [si],al
inc si
inc bx
jmp START_COPY

RETURN_COPY:   
ret
copy_string endp

; **************************************************
; Procedure to load the random values into data buffer/RAM*
; **************************************************

;WILL LOAD RANDOM VALUES
randomNumbersForDataSeg PROC
	mov temp_bx,0
	call clrrg
	;mov bx, 
	
	mov si, offset dataBuff
    randLoop:
    cmp temp_bx,200
    je RETURN_RANDOM
	
		call DUM_LOOP_SMALL	
		;mov temp_si,cx
		mov ah, 2ch
		int 21h
		;cmp dl, 9 ;if its greater than 64, just start again
		;ja randLoop
		;mov al, dl
		mov [si], dl
		;dec count
		inc si
		;cmp count, 0
		;je break2
        ;mov cx,temp_si
        inc temp_bx
		jmp randLoop
RETURN_RANDOM:
ret
randomNumbersForDataSeg endp

print_syntax_error proc
;printing string
;changing cursor location
call clrrg
mov dh,18 ;y_axis
mov dl,33 ;x_axis

call gotoxy

lea dx, str_syntax_error
mov ah,09h
int 21h
   
ret
print_syntax_error endp

read_from_binary_file proc

START_EXTRACT:
mov al,0Ah
cmp [bx],al
je RETURN_BIN_FILE_DATA
mov al,[bx]
mov [di],al
inc di
inc bx
jmp START_EXTRACT
    
RETURN_BIN_FILE_DATA:
inc bx ;so it points to newline
ret
read_from_binary_file endp

print_opcode proc
;printing string
;changing cursor location
call clrrg
mov dh,16 ;y_axis
mov dl,64 ;x_axis

call gotoxy

    
ret
print_opcode endp

print_mode proc
;printing string
;changing cursor location
call clrrg
mov dh,17 ;y_axis
mov dl,64 ;x_axis

call gotoxy
    
ret
print_mode endp

print_op1 proc
;printing string
;changing cursor location
call clrrg
mov dh,18 ;y_axis
mov dl,64 ;x_axis

call gotoxy
    
ret
print_op1 endp

print_op2 proc
;printing string
;changing cursor location
call clrrg
mov dh,19 ;y_axis
mov dl,64 ;x_axis

call gotoxy
    
ret
print_op2 endp

show_output proc
;printing string
;changing cursor location
call clrrg
mov dh,08 ;y_axis
mov dl,61 ;x_axis

call gotoxy
    
ret
show_output endp


end start
end
