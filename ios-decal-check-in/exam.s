unsigned sum(bt *root) {
if (!root) return 0;

return root->val
	+ sum(root->left)
	+ sum(root->right);
}	



sum : # definition of the sum label
	addiu $sp , $sp , -12 #allocate enough room in the stack for 3 items
	sw $ra , 8( $sp ) # store the return address
	sw $s1 , 4( $sp ) # s1 = 
	sw $s0 , 0( $sp ) # s0 = 

	xor $v0 , $0 , $0 # set the value of v0 to 0

	beq $a0 , $0 , ret # if root is 0, return.
	addu $s0 , $a0 , $0 # put root address into s0
	lw $s1 , 0( $s0 ) # add 1
	lw $a0 , 4( $s0 ) # do it to the right
	jal sum 			# jump back to the loop

	addu $s1 , $s1 , $v0 # do it to the left
	lw $a0 , 8( $s0 ) #do it to the left
	jal sum				# jump to the function
	addu $v0 , $s1 , $v0 #load the sums into v0
ret :
	lw $ra , 8( $sp ) # restore registers
	lw $s1 , 4( $sp ) 
	lw $s0 , 0( $sp )
	addiu $sp
	jr $ra

