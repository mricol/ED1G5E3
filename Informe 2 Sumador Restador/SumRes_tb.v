module testbench;

reg a0=1, a1=0, a2=0, a3=1, sa=0, b0=0, b1=0, b2=1, b3=0, sb=0;
initial
	begin
		sa=0;
		sb=0;
		#10
		sa=0;
		sb=1;
		#10;
		sa=1;
		sb=0;
		#10;
		sa=1;
		sb=1;
		#10;
		$finish;
		#10;
	end

wire [4:0] outs;

SumRes dut (
	.A0(a0), .A1(a1), .A2(a2), .A3(a3), .SA(sa), .B0(b0), .B1(b1), .B2(b2), .B3(b3), .SB(sb),
	.SC(outs[4]), .C0(outs[0]), .C1(outs[1]), .C2(outs[2]), .C3(outs[3])
	);
	
	
	initial
	begin
		$dumpfile("top.vcd");
		$dumpvars(0, testbench);
	end
endmodule
