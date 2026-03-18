module IntMax (a0, a1, val, idx);
parameter wordlength = 8;
input [wordlength-1 : 0] a0, a1;
output [wordlength-1 : 0] val;
output idx;
// instantiation of DW_minmax
// inputs are concatenated into the input vector
DW_minmax #(wordlength, 2)
U1 (.a({a1, a0}), .tc(1'b0), .min_max(1'b1),
.value(val), .index(idx));
endmodule
