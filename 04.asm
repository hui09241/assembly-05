INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
SWAP PROTO,pValX:SDWORD,pValy:SDWORD
.data
	 out1		  BYTE    "請輸入字串：", 0
	 out2		  BYTE    "請從第幾個字開始讀：", 0
	 out3		  BYTE    "要讀多少個字：", 0
	 out4		  BYTE    "結果應從：從字串第", 0
	 out5		  BYTE    "開始讀，讀", 0
	 out6		  BYTE    "個字", 0
	 out7		  BYTE    "輸出將超出最一開始輸入字串之長度，故只將字串輸出到最後", 0
	 out8		  BYTE    "結果為以下：", 0
	 out9		  BYTE    "起始位置已超過輸入字串長度，故終止程式", 0
	 Str1          BYTE    1000 DUP(?)
	 howlonhinput SDWORD  0
	 begin_where  SDWORD  0
	 howlong      SDWORD  0
.code
main PROC
	call Clrscr ;清除螢幕

	mov edx , OFFSET out1 ;告知輸入字串
	call WriteString
	call Crlf
	mov edx  , OFFSET Str1				;指定緩衝區 
	mov ecx  , ( SIZEOF Str1 ) - 1     ;扣掉null，指定最大讀取字串長度
	call ReadString				    ;輸入字串

	mov howlonhinput,eax
	;mov eax,howlonhinput
	;call writeint
	;call crlf

	mov edx , OFFSET out2 ;告知從第幾個字開始讀
	call WriteString
	call Crlf
	call readint
	mov begin_where,eax
	
	mov ebx,howlonhinput

	.if(eax>ebx)
		mov edx , OFFSET out9 ;起始位至超過字串長度
		call WriteString
		jmp EXITTT
	.endif

	mov edx , OFFSET out3 ;告知要讀多長
	call WriteString
	call Crlf
	call readint
	mov howlong,eax

	mov edx , OFFSET out4 ;告知從第幾個字開始讀
	call WriteString
	mov eax,begin_where
	call writedec
	mov edx , OFFSET out5 ;告知要讀多長
	call WriteString
	mov eax,howlong
	call writedec
	mov edx , OFFSET out6 
	call WriteString
	call crlf

	mov eax,begin_where
	add eax,howlong
	sub eax,1
	mov ebx,howlonhinput

	.if(eax>ebx)
	  mov edx , OFFSET out7 ;告知將輸出超過輸入，故只輸出到輸入知最後
	  call WriteString
	  call crlf
	  jmp MORE_THAN_INPUT
	.endif

	mov edx , OFFSET out8 ;告知結果
	call WriteString
	call crlf
	
	mov    esi  , OFFSET Str1
	mov    eax,begin_where
	sub    eax,1
	;call writeint
	;call crlf
	add    esi,eax
	;mov    eax,[esi]
	;call  writeChar
	mov    ecx,howlong
LOPFORLESS:
	mov    eax,[esi]
	call writeChar
	add esi,1
	loop LOPFORLESS
	
	jmp EXITTT

MORE_THAN_INPUT:
	mov    esi  , OFFSET Str1
	mov    eax,begin_where
	sub    eax,1
	;call writeint
	;call crlf
	add    esi,eax

	mov eax,begin_where        ;調整輸出數量
	add eax,howlong
	sub eax,1
	sub eax,howlonhinput
	mov ebx,howlong
	sub ebx,eax
	mov eax,ebx
	;call writeint
	mov ecx,eax

LOPFORMORE:
	mov    eax,[esi]
	call writeChar
	add esi,1
	loop LOPFORMORE
	
EXITTT:
	call crlf
call WaitMsg
	INVOKE ExitProcess , 0
main ENDP
END main