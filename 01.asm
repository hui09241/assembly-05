INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
SWAP PROTO,pValX:SDWORD,pValy:SDWORD
.data
	 out1		           BYTE    "�п�J�r��G", 0
	 out2		           BYTE    "�п�J���r��G", 0
	 out3		           BYTE    "NO found.���~���J�걵�r��", 0
	 out4		           BYTE    "�п�J�n�s�����r��G", 0
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
	call Clrscr ;�M���ù�
;----------------------------------------------------------------�Ĥ@����J�r��
	mov edx , OFFSET out1			;�i����J�r��
	call WriteString
	call Crlf
	mov edx  , OFFSET Str1				;���w�w�İ� 
	mov ecx  , ( SIZEOF Str1 ) - 1     ;����null�A���w�̤jŪ���r�����
	call ReadString				    ;��J�r��

	mov howlong_str1,eax			;++
	mov eax,howlong_str1			;++
	;call writeint					;++
	;call crlf						;++
;----------------------------------------------------------------��J�n��諸�r��
	mov edx , OFFSET out2			;�i����J�r��
	call WriteString
	call Crlf
	mov edx  , OFFSET Str2				;���w�w�İ� 
	mov ecx  , ( SIZEOF Str2 ) - 1     ;����null�A���w�̤jŪ���r�����
	call ReadString				    ;��J�r��

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
	mov edx , OFFSET out5			;�i�����۵�
	call WriteString
	call crlf
	jmp Connect_next
How_result:
	mov edx , OFFSET out3			;�i����藍�۵�
	call WriteString
	call crlf
	jmp Connect_next
;------------------------------------------------------------------------��J�s���r��
Connect_next:
	mov edx , OFFSET out4			;�i����J�n�s�����r��
	call WriteString
	call crlf

	mov edx  , OFFSET Str3				;���w�w�İ� 
	mov ecx  , ( SIZEOF Str3 ) - 1      ;����null�A���w�̤jŪ���r�����
	call ReadString				        ;��J�r��
;---------------------------------------------------------------------��X�s���r�ꤧ���G
	mov edx , OFFSET Str1			;�i����J�n�s�����r��
	call WriteString
	mov edx , OFFSET Str3			;�i����J�n�s�����r��
	call WriteString
	call crlf
EXITTT:
call WaitMsg
	INVOKE ExitProcess , 0
main ENDP
END main