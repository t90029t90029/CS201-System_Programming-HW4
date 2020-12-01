# Use this file to do HW3.

#####################################################
.global     crcFast     #  Do not modify these lines!
.global     crcInit     #  Do not modify these lines!
.local      crcTable    #  Do not modify these lines!
#####################################################


# Write your code below this line, in the appropriate sections.

.text
	crcFast:
		# unsigned char data  %rdx
		# long byte           %rcx
  		# char remainder      %rax
		# char * message      %rdi
		# long nBytes         %rsi
		# crcTable            %r8

			xorq %rax,%rax
			movq $(crcTable),%r8
			pushq %rdi
			pushq %rsi
			movq $0,%rcx
		L6:
			cmpq %rsi,%rcx
			jge  L7
			movb (%rdi,%rcx),%dl
			xorb %al,%dl
			movq (%r8,%rdx),%rax
			incq %rcx
			jmp  L6
		L7:
			popq %rsi
			popq %rdi
			nop
			retq

	
	crcInit:
  		# char remainder  %rdi
  		# int dividend 	  %rsi
  		# char bit	  %rdx
		# crcTable        %r8
		# temp(%rdi&0x80) %r9

			movq $0,%rsi		
			movq $(crcTable),%r8
		L0:	
			cmpq $256,%rsi
			je   L5
			movb %sil,%dil
			movq $8,%rdx
		L1:
			cmpb $0,%dl
			je   L4
			movq %rdi,%r9
			andq $0x80,%r9
			cmpq $0,%r9
			je   L2
			salq $1,%rdi
			xorq $0xD5,%rdi
			jmp  L3
		L2:
			salq $1,%rdi
		L3:
			decb %dl
			jmp  L1
		L4:
			movq %rdi,(%r8,%rsi)
			incl %esi
			jmp  L0
		L5:
			nop
			retq

.data
	.comm crcTable,256



