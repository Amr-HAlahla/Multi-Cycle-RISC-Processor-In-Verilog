# Multi-Cycle RISC Processor (MCRP)

This repository contains the Verilog implementation of a Multi-Cycle RISC Processor (MCRP). The processor is designed to execute a subset of RISC instructions and is organized into five main stages: Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), and Write Back (WB). The processor supports various control signals and operations, providing a flexible and extensible architecture.

## Processor Specifications

- **Instruction Size**: 32 bits
- **Registers**: 32 general-purpose registers (R0 to R31)
- **Special Registers**: Program Counter (PC), Stack Pointer (SP)
- **Control Stack**: Used for saving return addresses
- **Instruction Types**: R-type, I-type, J-type, S-type
- **Memory Organization**: Separate data and instruction memories.

## Modules

1. **MCRP (Main Processor Module):**
   - Inputs: clk, reset
   - Outputs: Various control signals, register outputs, ALU, and memory results.

2. **State Machine (IF, ID, EX, MEM, WB):**
   - Determines the current state of the processor and transitions based on the instruction being executed.

3. **ALU (alu):**
   - Performs operations like ADD, SUB, AND, SLL, SLR based on the instruction type.

4. **Memory (mem):**
   - Handles memory access for load (LW) and store (SW) operations.

5. **Stack Memory (stack):**
   - Manages the control stack for saving return addresses.

6. **Control Unit (ctrl):**
   - Generates control signals for various operations in the processor.

## State Machine

- **States**: IF (Instruction Fetch), ID (Instruction Decode), EX (Execute), MEM (Memory Access), WB (Write Back)
- **State Transitions**: Based on the type of instruction being executed and the current state.

## Features

- Supports a variety of instructions (R-type, I-type, J-type, S-type).
- Flexibility in ALU operations and memory access.
- Separate data and instruction memories.
- Control signals for register write, memory read/write, ALU operations.

## Usage

To use the MCRP processor, instantiate the module and provide appropriate input signals. Ensure that the clock (clk) and reset (reset) signals are connected properly.

## Testing

Thoroughly test the processor to validate functionality and correctness. A testbench code (`new_tb.v`) is included in the same folder for testing purposes.

