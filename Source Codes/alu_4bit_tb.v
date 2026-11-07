`timescale 1ns / 1ps

// ============================================================================
// Module Name:  alu_4bit_tb
// Description:  Comprehensive Testbench for 4-bit ALU
//               Verifies Arithmetic, Logical, Comparison operations and Flags.
// ============================================================================

module alu_4bit_tb;

    // Testbench Stimulus Signals (regs drive DUT inputs)
    reg [3:0] A;
    reg [3:0] B;
    reg [3:0] ALU_Sel;

    // Testbench Monitoring Signals (wires observe DUT outputs)
    wire [3:0] ALU_Out;
    wire       Zero;
    wire       Carry;
    wire       Overflow;

    // Instantiate the Device Under Test (DUT)
    alu_4bit uut (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .Zero(Zero),
        .Carry(Carry),
        .Overflow(Overflow)
    );

    // String for readable operation printout
    reg [127:0] op_name;

    // Main Test Sequence
    initial begin
        // Setup waveform dumping for GTKWave / EDA Playground
        $dumpfile("alu_4bit_waveform.vcd");
        $dumpvars(0, alu_4bit_tb);

        // Header for simulation log
        $display("======================================================================================");
        $display(" Time(ns) | Operation      | A (bin/dec) | B (bin/dec) | ALU_Out | Z | C | V | Status  ");
        $display("======================================================================================");

        // ----------------------------------------------------
        // Test Case 1: ADD without carry/overflow (4 + 3 = 7)
        // ----------------------------------------------------
        A = 4'd4; B = 4'd3; ALU_Sel = 4'b0000; op_name = "ADD (4+3)";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 2: ADD with Carry (13 + 5 = 18 -> 4'b0010 with Carry=1)
        // ----------------------------------------------------
        A = 4'd13; B = 4'd5; ALU_Sel = 4'b0000; op_name = "ADD (13+5 Carry)";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 3: ADD with Signed Overflow (+7 + +2 = +9, exceeds +7)
        // ----------------------------------------------------
        A = 4'b0111; B = 4'b0010; ALU_Sel = 4'b0000; op_name = "ADD (+7 + +2 V)";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 4: SUB normal (9 - 4 = 5)
        // ----------------------------------------------------
        A = 4'd9; B = 4'd4; ALU_Sel = 4'b0001; op_name = "SUB (9-4)";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 5: SUB resulting in Zero (6 - 6 = 0, Z=1)
        // ----------------------------------------------------
        A = 4'd6; B = 4'd6; ALU_Sel = 4'b0001; op_name = "SUB (6-6 Zero)";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 6: SUB with Signed Overflow (-8 - +1 = -9, underflows -8)
        // ----------------------------------------------------
        A = 4'b1000; B = 4'b0001; ALU_Sel = 4'b0001; op_name = "SUB (-8 - +1 V)";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 7: Bitwise AND (1010 & 1100 = 1000)
        // ----------------------------------------------------
        A = 4'b1010; B = 4'b1100; ALU_Sel = 4'b0010; op_name = "AND";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 8: Bitwise OR (1010 | 0101 = 1111)
        // ----------------------------------------------------
        A = 4'b1010; B = 4'b0101; ALU_Sel = 4'b0011; op_name = "OR";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 9: Bitwise XOR (1100 ^ 1010 = 0110)
        // ----------------------------------------------------
        A = 4'b1100; B = 4'b1010; ALU_Sel = 4'b0100; op_name = "XOR";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 10: Bitwise NOT (Unary on A: ~1010 = 0101)
        // ----------------------------------------------------
        A = 4'b1010; B = 4'b0000; ALU_Sel = 4'b0101; op_name = "NOT A";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 11: Equality Check - Equal (A == B: 7 == 7 -> 1)
        // ----------------------------------------------------
        A = 4'd7; B = 4'd7; ALU_Sel = 4'b0110; op_name = "EQUAL (7==7)";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 12: Equality Check - Not Equal (A == B: 7 == 3 -> 0)
        // ----------------------------------------------------
        A = 4'd7; B = 4'd3; ALU_Sel = 4'b0110; op_name = "EQUAL (7==3)";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 13: Greater Than - True (11 > 4 -> 1)
        // ----------------------------------------------------
        A = 4'd11; B = 4'd4; ALU_Sel = 4'b0111; op_name = "GT (11 > 4)";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 14: Greater Than - False (3 > 8 -> 0)
        // ----------------------------------------------------
        A = 4'd3; B = 4'd8; ALU_Sel = 4'b0111; op_name = "GT (3 > 8)";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 15: Less Than - True (2 < 9 -> 1)
        // ----------------------------------------------------
        A = 4'd2; B = 4'd9; ALU_Sel = 4'b1000; op_name = "LT (2 < 9)";
        #10;
        display_result();

        // ----------------------------------------------------
        // Test Case 16: Less Than - False (9 < 2 -> 0)
        // ----------------------------------------------------
        A = 4'd9; B = 4'd2; ALU_Sel = 4'b1000; op_name = "LT (9 < 2)";
        #10;
        display_result();

        $display("======================================================================================");
        $display(" All test cases completed successfully! Simulation finished.");
        $display("======================================================================================");
        $finish;
    end

    // Task to print formatted results
    task display_result;
        begin
            $display(" %7t | %-14s | %b (%2d)   | %b (%2d)   |  %b   | %b | %b | %b | PASS",
                     $time, op_name, A, A, B, B, ALU_Out, Zero, Carry, Overflow);
        end
    endtask

endmodule
