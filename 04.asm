INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
SWAP PROTO,pValX:SDWORD,pValy:SDWORD
.data
	 out1		  BYTE    "�п�J�r��G", 0
	 out2		  BYTE    "�бq�ĴX�Ӧr�}�lŪ�G", 0
	 out3		  BYTE    "�nŪ�h�֭Ӧr�G", 0
	 out4		  BYTE    "���G���q�G�q�r���", 0
	 out5		  BYTE    "�}�lŪ�AŪ", 0
	 out6		  BYTE    "�Ӧr", 0
	 out7		  BYTE    "��X�N�W�X�̤@�}�l��J�r�ꤧ���סA�G�u�N�r���X��̫�", 0
	 out8		  BYTE    "���G���H�U�G", 0
	 out9		  BYTE    "�_�l��m�w�W�L��J�r����סA�G�פ�{��", 0
	 Str1          BYTE    1000 DUP(?)
	 howlonhinput SDWORD  0
	 begin_where  SDWORD  0
	 howlong      SDWORD  0
.code
main PROC
	call Clrscr ;�M���ù�

	mov edx , OFFSET out1 ;�i����J�r��
	call WriteString
	call Crlf
	mov edx  , OFFSET Str1				;���w�w�İ� 
	mov ecx  , ( SIZEOF Str1 ) - 1     ;����null�A���w�̤jŪ���r�����
	call ReadString				    ;��J�r��

	mov howlonhinput,eax
	;mov eax,howlonhinput
	;call writeint
	;call crlf

	mov edx , OFFSET out2 ;�i���q�ĴX�Ӧr�}�lŪ
	call WriteString
	call Crlf
	call readint
	mov begin_where,eax
	
	mov ebx,howlonhinput

	.if(eax>ebx)
		mov edx , OFFSET out9 ;�_�l��ܶW�L�r�����
		call WriteString
		jmp EXITTT
	.endif

	mov edx , OFFSET out3 ;�i���nŪ�h��
	call WriteString
	call Crlf
	call readint
	mov howlong,eax

	mov edx , OFFSET out4 ;�i���q�ĴX�Ӧr�}�lŪ
	call WriteString
	mov eax,begin_where
	call writedec
	mov edx , OFFSET out5 ;�i���nŪ�h��
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
	  mov edx , OFFSET out7 ;�i���N��X�W�L��J�A�G�u��X���J���̫�
	  call WriteString
	  call crlf
	  jmp MORE_THAN_INPUT
	.endif

	mov edx , OFFSET out8 ;�i�����G
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

	mov eax,begin_where        ;�վ��X�ƶq
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