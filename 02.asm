INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
Get_frequences PROTO,temp:DWORD,Str2:DWORD,Table:DWORD
.data
	 out1		           BYTE    "要建表之字串：", 0
	 out2		           BYTE    "第", 0
	 out3		           BYTE    "個字_數量為：", 0
	 Str1                  BYTE    1000 DUP(?)
	 frequenTable          DWORD   256  DUP(0)
	 which_char            DWORD    0

.code
main PROC
	call Clrscr ;清除螢幕
;----------------------------------------------------------------第一次輸入字串
	mov edx , OFFSET out1			;告知輸入字串
	call WriteString
	call Crlf
	mov edx  , OFFSET Str1				;指定緩衝區 
	mov ecx  , ( SIZEOF Str1 ) - 1     ;扣掉null，指定最大讀取字串長度
	call ReadString				    ;輸入字串
	call crlf

	INVOKE Get_frequences,ADDR Str1,ADDR frequenTable,eax   ;由於這樣寫第一個參數會傳到第二個位置，以此類推，故將其改為此

	mov ecx,256
	mov esi,0
L1:
	mov edx , OFFSET out2			;第幾個
	call WriteString
	mov eax,which_char
	call WriteDec
	mov edx , OFFSET out3			;數量為
	call WriteString
	mov eax,0
	mov eax,frequenTable[esi]
	call WriteDec
	call crlf
	add esi,4
	add which_char,1
	loop L1
	
EXITTT:
call WaitMsg
	INVOKE ExitProcess , 0
main ENDP
Get_frequences PROC,temp:DWORD,Str2:DWORD,Table:DWORD
	enter 0,0
	mov esi,Str2			 ;放Str1的起始位址
	mov edi,0
	mov edi,Table			 ;放frequenTable的起始位址

	mov ecx,1
	.While(ecx>0)
		.if(al==0)
			jmp Outttt
		.endif
		mov ebx,4            ;Table 是DWORD		
		mov edx,0
		mov eax,0
		mov al,[esi]      
		;call writeint       ;A輸出會是65
		mul ebx
		;call writeint
		mov ebx,edi
		add ebx,eax          ;加上起始位址
		
		mov edx,[ebx]
		add edx,1
		mov [ebx],edx

		;call writechar
		add esi,1
	.endw
	;call crlf

Outttt:

	leave
	ret
Get_frequences ENDP
END main