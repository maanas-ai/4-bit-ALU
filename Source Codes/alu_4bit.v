// ============================================================================
// Module Name:  alu_4bit
// Description:  4-bit Arithmetic Logic Unit (ALU) with Status Flags
// Requirements: Supports Arithmetic (ADD, SUB), Logical (AND, OR, XOR, NOT),
//               Comparison (==, >, <), and Status Flags (Zero, Carry, Overflow).
// ============================================================================

module alu_4bit (
    input  wire [3:0] A,          // First 4-bit operand
    input  wire [3:0] B,          // Second 4-bit operand
    input  wire [3:0] ALU_Sel,    // 4-bit Operation Selection (Control Signal)
    output reg  [3:0] ALU_Out,    // 4-bit ALU Result
    output wire       Zero,       // Zero Flag (Z): Set when result is 0000
    output reg        Carry,      // Carry Flag (C): Set when addition generates carry
    output reg        Overflow    // Overflow Flag (V): Set on signed arithmetic overflow
);

    // Internal wire for 5-bit addition result to capture carry-out
    wire [4:0] add_ext;
    assign add_ext = {1'b0, A} + {1'b0, B};

    // Internal wire for 5-bit subtraction result to check borrow if needed
    wire [4:0] sub_ext;
    assign sub_ext = {1'b0, A} - {1'b0, B};

    // Zero Flag: High whenever the 4-bit output is zero
    assign Zero = (ALU_Out == 4'b0000);

    // Operation Control Logic (Multiplexer Behavior)
    always @(*) begin
        // Default flag states
        Carry    = 1'b0;
        Overflow = 1'b0;

        case (ALU_Sel)
            // ----------------------------------------------------
            // 1. Arithmetic Operations
            // ----------------------------------------------------
            4'b0000: begin // Addition: A + B
                ALU_Out  = add_ext[3:0];
                Carry    = add_ext[4]; // Carry-out from MSB
                // Signed overflow: occurs if operands have same sign, but result has different sign
                Overflow = (~(A[3] ^ B[3])) & (A[3] ^ add_ext[3]);
            end

            4'b0001: begin // Subtraction: A - B
                ALU_Out  = sub_ext[3:0];
                Carry    = 1'b0; // Flag designated for addition carry
                // Signed overflow: occurs if operands have different signs and result sign != A sign
                Overflow = (A[3] ^ B[3]) & (A[3] ^ sub_ext[3]);
            end

            // ----------------------------------------------------
            // 2. Logical Operations
            // ----------------------------------------------------
            4'b0010: begin // Bitwise AND: A & B
                ALU_Out  = A & B;
            end

            4'b0011: begin // Bitwise OR: A | B
                ALU_Out  = A | B;
            end

            4'b0100: begin // Bitwise XOR: A ^ B
                ALU_Out  = A ^ B;
            end

            4'b0101: begin // Bitwise NOT: ~A (Unary operation on operand A)
                ALU_Out  = ~A;
            end

            // ----------------------------------------------------
            // 3. Comparison Operations (Result: 4'b0001 if True, 4'b0000 if False)
            // ----------------------------------------------------
            4'b0110: begin // Equality Check: A == B
                ALU_Out  = (A == B) ? 4'b0001 : 4'b0000;
            end

            4'b0111: begin // Greater Than: A > B (Unsigned comparison)
                ALU_Out  = (A > B) ? 4'b0001 : 4'b0000;
            end

            4'b1000: begin // Less Than: A < B (Unsigned comparison)
                ALU_Out  = (A < B) ? 4'b0001 : 4'b0000;
            end

            // ----------------------------------------------------
            // Default / Unused opcodes
            // ----------------------------------------------------
            default: begin
                ALU_Out  = 4'b0000;
                Carry    = 1'b0;
                Overflow = 1'b0;
            end
        endcase
    end

endmodule
