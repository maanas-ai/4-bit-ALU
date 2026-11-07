# 4-Bit Arithmetic Logic Unit (ALU)

## Overview

This project implements a **4-bit Arithmetic Logic Unit (ALU)** using Verilog HDL. An ALU is a fundamental component of a CPU that performs arithmetic and logical operations on binary data.

The project includes a Verilog-based ALU design, a testbench for simulation, and a digital logic circuit designed using Logisim.

## Features

The ALU supports four basic operations:

| Opcode | Operation | Description |
|:---:|---|---|
| `00` | Addition | Adds two 4-bit inputs |
| `01` | Subtraction | Subtracts B from A |
| `10` | Bitwise AND | Performs a bitwise AND operation |
| `11` | Bitwise OR | Performs a bitwise OR operation |

## Project Structure

```text
4_Bit_ALU/
│
├── alu_4bit.v     # Main Verilog ALU implementation
├── alu_4bit_tb.v  # Verilog testbench
├── alu.out        # Compiled simulation executable
├── README.md      # Project documentation
└── circuit.circ   # Logisim circuit 
```

## Technologies Used

- **Verilog HDL** – Hardware description and ALU implementation.
- **Icarus Verilog** – Verilog compilation and simulation.
- **Logisim** – Digital logic circuit design.

## Getting Started

### Prerequisites

Install the following tools:

1. [Icarus Verilog](https://bleyer.org/icarus/)
2. [Logisim](https://www.logisim-evolution.org/) (for viewing the digital circuit)

### Compilation

Open a terminal in the project directory and execute:

```bash
iverilog -o alu.out alu_4bit.v alu_tb.v
```

This compiles the ALU design and testbench into an executable simulation file.

### Running the Simulation

Execute:

```bash
vvp alu.out
```

The simulation displays the input values, opcode, and corresponding output for each operation.

### Viewing Waveforms

The testbench generates a VCD file named `alu.vcd`.

To visualize the simulation:

```bash
gtkwave alu.vcd
```

Add the signals `A`, `B`, `opcode`, and `result` to the waveform viewer.

## Sample Test Cases

| Operation | Input A | Input B | Expected Output |
|---|---|---|---|
| Addition | `0101` (5) | `0011` (3) | `1000` (8) |
| Subtraction | `1001` (9) | `0100` (4) | `0101` (5) |
| AND | `1100` | `1010` | `1000` |
| OR | `1100` | `1010` | `1110` |

## Learning Outcomes

Through this project, I explored:

- Designing combinational circuits using Verilog HDL.
- Understanding arithmetic and logical operations in an ALU.
- Implementing and using testbenches for hardware verification.
- Compiling and simulating Verilog programs using Icarus Verilog.
- Analysing digital signals using GTKWave.
- Designing digital circuits using Logisim.

## Future Improvements

- Add XOR and NOT operations.
- Implement shift operations.
- Include carry and zero flags.
- Expand the ALU to support additional operations.
- Test more input combinations and edge cases.

## Author

**Maanas C**

## License

This project is open-source and available for educational purposes.
