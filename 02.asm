INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
Get_frequences PROTO,temp:DWORD,Str2:DWORD,Table:DWORD
.data
	 out1		           BYTE    "�n�ت��r��G", 0
	 out2		           BYTE    "��", 0
	 out3		           BYTE    "�Ӧr_�ƶq���G", 0
	 Str1                  BYTE    1000 DUP(?)
	 frequenTable          DWORD   256  DUP(0)
	 which_char            DWORD    0

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
	call crlf

	INVOKE Get_frequences,ADDR Str1,ADDR frequenTable,eax   ;�ѩ�o�˼g�Ĥ@�ӰѼƷ|�Ǩ�ĤG�Ӧ�m�A�H�������A�G�N��אּ��

	mov ecx,256
	mov esi,0
L1:
	mov edx , OFFSET out2			;�ĴX��
	call WriteString
	mov eax,which_char
	call WriteDec
	mov edx , OFFSET out3			;�ƶq��
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
	mov esi,Str2			 ;��Str1���_�l��}
	mov edi,0
	mov edi,Table			 ;��frequenTable���_�l��}

	mov ecx,1
	.While(ecx>0)
		.if(al==0)
			jmp Outttt
		.endif
		mov ebx,4            ;Table �ODWORD		
		mov edx,0
		mov eax,0
		mov al,[esi]      
		;call writeint       ;A��X�|�O65
		mul ebx
		;call writeint
		mov ebx,edi
		add ebx,eax          ;�[�W�_�l��}
		
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