# Use this file to do HW4.

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
		L6:			#this is not a branch, L6 is just for a for loop
			cmpq %rsi,%rcx
			jge  L7		#condition check for the for loop
			movb (%rdi,%rcx),%dl
			xorb %al,%dl
			movq (%r8,%rdx),%rax
			incq %rcx
			jmp  L6		#go to check the condition of the for loop when it is done
		L7:			#this is not a branch, L7 is the end of the for loop
			popq %rsi
			popq %rdi
			nop
			retq

	
	crcInit:
  		# char remainder  %rdi
  		# int dividend 	  %rsi
  		# char bit	  %rdx
		# crcTable        %r8
		# condition(%rdi&0x80) %r9
		# second remainder to store the data temporarily %rcx

			movq $0,%rsi		
			movq $(crcTable),%r8
			pushq %rcx
		L0:			#this is not a branch, L0 is just for the outside for loop
			cmpq $256,%rsi
			je   L3		#condition check for the outside for loop
			movb %sil,%dil
			movq $8,%rdx
		L1:			#this is not a branch, L1 is just for the inner for loop
			cmpb $0,%dl
			je   L2		#condition check for the inner for loop
		#------------------here is different from the hw3----------------
			movq %rdi,%r9
			movq %rdi,%rcx

			salq $1,%rdi
			xorq $0xD5,%rdi
			salq $1,%rcx

			andq $0x80,%r9
			cmpq $0,%r9
			cmove %rcx,%rdi
		#----------------------------------------------------------------
			decb %dl
			jmp  L1		#go to check the condition of the innder for loop when it is done
		L2:			#this is not a branch, L2 is the end for the inner for loop
			movq %rdi,(%r8,%rsi)
			incl %esi
			jmp  L0		#go to check the condition of the outside for loop when it is done
		L3:			#this is not a branch, L3 is the end for the outside for loop
			popq %rcx
			nop
			retq

.data
	.comm crcTable,256




