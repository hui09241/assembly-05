INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
mFIRout MACRO char
	mov		edx,char
	call	WriteString

ENDM

mADDout MACRO sdword1,sdword2
	mov		eax,sdword1
	add     eax,sdword2
	;call writeint
	;call crlf
	;call WriteDec
	;call crlf
	cmp eax,0
	jl L1
	jge L2
L1:
	call Writeint
	jmp EXITT
L2:
	call WriteDec
EXITT:

ENDM

.data
	out1		    BYTE		"請輸入字串：",0
	out2            BYTE        1000 DUP(?)
	how_long_input  SDWORD      0
	isfirstornot    SDWORD      0

	num1S           BYTE        1000 DUP(?)
	num1            SDWORD      0
	boolnum1        SDWORD      0
	countfornum1    SDWORD      0

	num2S           BYTE       1000 DUP(?)
	num2            SDWORD      0
	boolnum2        SDWORD      0
    countfornum2    SDWORD      0

	count           SDWORD      0
	boolean         SDWORD      0
	ten             SDWORD      10

.code
	

main PROC
	call Clrscr ;清除螢幕
	
	mov	eax,OFFSET out1
	mFIRout eax
	call crlf
	
	mov edx  , OFFSET out2              ; 指定緩衝區 
    mov ecx  , ( SIZEOF out2 ) - 1       ; 扣掉null，指定最大讀取字串長度
    call ReadString                                ; 輸入字串
	mov how_long_input,eax

	;mov eax,0
	;mov eax, how_long_input
	;call writeint    ;++
	;call crlf        ;++

	;mov edx,OFFSET out2 ;++
	;call writestring    ;++
	;call crlf           ;++

	;mov ecx,how_long_input
	;mov esi,OFFSET out2
;fortest:
	;mov eax,0
	;mov al,[esi]
	;call writeint
	;call writechar
	;call crlf
	;add esi,1
	;loop fortest
;----------------------------------------------------------------------找到第一個數字
	mov ecx,how_long_input
	mov esi,OFFSET out2
	mov edi,OFFSET num1S
Findnum1:
	mov al,[esi]
	mov edx,isfirstornot
	.if(al=='-')&&( edx >0)
		mov boolnum2,1
		jmp Find2
	.endif
	.if (al=='-')
		mov boolnum1,1
	.endif
	.if (al >='0') &&( al<='9')
		mov isfirstornot,1
		mov [edi],al
		add edi,1
		add countfornum1,1
	.endif
    .if(al=='+')&&( edx >0)
		jmp Find2
	.endif
	
	add count,1
	add esi,1
	loop Findnum1
;-----------------------------------------------------------------找到第二個數字
Find2:
	mov ecx,how_long_input
	sub ecx,count
	mov esi,OFFSET out2
	mov edi,OFFSET num2S
	add esi,count
Findnum2:
	mov al,[esi]
	mov edx,isfirstornot
	.if (al=='-')
		mov boolnum2,1
	.endif
	.if (al >='0') &&( al<='9')
		mov [edi],al
		add edi,1
		add countfornum2,1
	.endif
	add esi,1
	loop Findnum2
;--------------------------------------------------------------------------------前為放入String，現在要放入SDWORD中
	mov ecx,countfornum1
	mov esi,offset num1S
	mov boolean,0
addnum1intoSDWORD:
	mov edx,boolean
	.if(edx>0)
	   mov eax,num1
	   imul eax,10
	   mov num1,eax
	 .endif
	 mov eax,0
	 mov al,[esi]
	 sub al,30h
	 mov ebx,num1
	 add ebx,eax
	 mov num1,ebx
	 add boolean,1
	 add esi,1
	 loop addnum1intoSDWORD

	 mov ecx,boolnum1
	 .if(ecx>0)
	   mov eax,num1
	   mov ebx,-1
	   imul ebx
	   mov num1,eax
	 .endif

    mov ecx,countfornum2
	mov esi,offset num2S
	mov boolean,0
addnum2intoSDWORD:
	mov edx,boolean
	.if(edx>0)
	   mov eax,num2
	   imul eax,10
	   mov num2,eax
	 .endif
	 mov eax,0
	 mov al,[esi]
	 sub al,30h
	 mov ebx,num2
	 add ebx,eax
	 mov num2,ebx
	 add boolean,1
	 add esi,1
	 loop addnum2intoSDWORD

	 mov ecx,boolnum2
	 .if(ecx>0)
	   mov eax,num2
	   mov ebx,-1
	   imul ebx
	   mov num2,eax
	 .endif	
;-------------------------------------------------------------------------------------------------引用巨集
EXITTT:
    ;mov eax,isfirstornot
	;call writeint
	;call crlf
	;mov edx,OFFSET num1S
	;call writeString
	;call crlf
	;mov eax,boolnum1
	;call writeint
	;call crlf
	;mov eax,countfornum1
	;call writeint
	;call crlf

	;mov edx,OFFSET num2S
	;call writeString
	;call crlf
	;mov eax,boolnum2
	;call writeint
	;call crlf
	;mov eax,countfornum2
	;call writeint
	;call crlf

	 ;mov eax,num1
	 ;call writeint
	 ;call crlf
	 ;mov eax,num2
	 ;call writeint
	 ;call crlf
	 ;call crlf

	 mov	eax,OFFSET out2
	 mFIRout eax
	 mov	eax,num1
	 mov ebx,num2
	 mADDout eax,ebx

	call 	crlf
	call 	WaitMsg
	INVOKE ExitProcess , 0
main ENDP
END main
