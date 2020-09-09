INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
SWAP PROTO,pValX:SDWORD,pValy:SDWORD
.data
	 out1		           BYTE    "請輸入字串：", 0
	 out2		           BYTE    "請輸入比對字串：", 0
	 out3		           BYTE    "NO found.請繼續輸入串接字串", 0
	 out4		           BYTE    "請輸入要連結之字串：", 0
	 out5		           BYTE    "OK", 0
	 Str1                  BYTE    1000 DUP(?)
	 Str2                  BYTE    1000 DUP(?)
	 Str3                  BYTE    1000 DUP(?)
	 howlong_str1          SDWORD  0
	 howlong_str2          SDWORD  0
	 compare_str2_in_str1  SDWORD  0
	 start_from_where      SDWORD  0
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

	mov howlong_str1,eax			;++
	mov eax,howlong_str1			;++
	;call writeint					;++
	;call crlf						;++
;----------------------------------------------------------------輸入要比對的字串
	mov edx , OFFSET out2			;告知輸入字串
	call WriteString
	call Crlf
	mov edx  , OFFSET Str2				;指定緩衝區 
	mov ecx  , ( SIZEOF Str2 ) - 1     ;扣掉null，指定最大讀取字串長度
	call ReadString				    ;輸入字串

	mov howlong_str2,eax            ;++
	mov eax,howlong_str2            ;++
	;call writeint                   ;++
	;call crlf                       ;++
;----------------------------------------------------------------------test
ReStart:
	mov    edi  , OFFSET Str2
	mov    esi  , OFFSET Str1
	add    esi,start_from_where
	mov ecx,howlong_str1
	sub ecx,start_from_where
check_where:
    mov    al,[esi]
	mov    bl,[edi]
	.if(al==bl)
		jmp Compare_str2_in_ste1
	.endif
	add start_from_where,1
	add esi,1
	loop check_where
	jmp How_result
Compare_str2_in_ste1:
	mov    compare_str2_in_str1,0
	mov    edi,OFFSET Str2
	mov    esi,OFFSET Str1
	add    esi,start_from_where
	;mov    eax,[esi]
	;call  writechar
	mov    ecx,howlong_str2
Compare_loop:
	mov    bl,[edi]
	mov    eax,ebx
	;call writechar
	mov    al,[esi]
	;call writechar
	.if(al==bl)
		add compare_str2_in_str1,1
	.endif
	add esi,TYPE Str1
	add edi,TYPE Str2
	;call crlf
	loop Compare_loop

	;mov eax,compare_str2_in_str1
	;call writeint
	;call crlf
	
	mov eax,howlong_str2
	mov ebx,compare_str2_in_str1
	.if(eax>ebx)
		add start_from_where,1
		jmp ReStart
	.endif
	mov edx , OFFSET out5			;告知比對相等
	call WriteString
	call crlf
	jmp Connect_next
How_result:
	mov edx , OFFSET out3			;告知比對不相等
	call WriteString
	call crlf
	jmp Connect_next
;------------------------------------------------------------------------輸入連結字串
Connect_next:
	mov edx , OFFSET out4			;告知輸入要連結之字串
	call WriteString
	call crlf

	mov edx  , OFFSET Str3				;指定緩衝區 
	mov ecx  , ( SIZEOF Str3 ) - 1      ;扣掉null，指定最大讀取字串長度
	call ReadString				        ;輸入字串
;---------------------------------------------------------------------輸出連結字串之結果
	mov edx , OFFSET Str1			;告知輸入要連結之字串
	call WriteString
	mov edx , OFFSET Str3			;告知輸入要連結之字串
	call WriteString
	call crlf
EXITTT:
call WaitMsg
	INVOKE ExitProcess , 0
main ENDP
END main