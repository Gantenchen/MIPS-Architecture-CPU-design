.text
#mult div
ori $1,0x00ff
lui $2,0xff00
mult $1,$2
mfhi $3
mflo $4
addu $1,$1,$2
addiu $2,$2,1
multu $1,$2
mflo $5
mflo $6
div $1,$2
divu $1,$2
divu $2,$1
mthi $1
mtlo $2
mfhi $2
mflo $1