The value of the signal "add_mult" in matmul_main.vhd should be set according to the desired operation.
'0' corresponds to addition and '1' corresponds to multiplication.
The signals a and b hold the matrices to be used in multiplication, while l and m hold the matrices to be used in addition.
The values of the constants num_rows_1, num_cols_1, num_rows_2, and num_cols_2 in the library mat_mul.vhd should also be set according to the dimensions of the matrices to be multiplied.
The values of the constants num_rows and num_cols in the library matadd.vhd should be set according to the dimensions of the matrices to be added.
After uploading the program to the board, press btnU to display outputs. Since btnU is used to latch the communication between the encoder and matrix operation unit, outputs display after x presses, where x is the number of elements in the result matrix.

To run simulations, comment the indicated sections of code in matmul_main and uncomment the other indicated sections of code in matmul_main.
Also, the values of the constants num_rows_1, num_rows_2, num_cols_1, num_cols_2, num_rows, and num_cols in the libraries should be set according to the matrices used in the testbench.
