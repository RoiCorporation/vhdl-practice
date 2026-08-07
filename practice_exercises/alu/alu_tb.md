
# Entity: alu_tb
- **File**: alu_tb.vhd
- **Title:**  Testbench for the Integer ALU
- **Author:**  Roi (r.lopezbarata@gmail.com)
- **Version:**  1.0
- **Date:**  07-08-2026
- **Copyright:**  This work is licensed under the MIT License.
- **Brief:**  Testbench for the integer 32-bit ALU implementation.

## Description

This is a testbench for the ALU (Arithmetic Logic Unit) that performs basic
arithmetic and logic operations on two 32-bit inputs. The testbench applies
various test cases to verify the correct functionality of the ALU by checking
the output against expected results for different operations determined by
the 7-bit opcode input.

## Signals

| Name   | Type                                         | Description                                                       |
| ------ | -------------------------------------------- | ----------------------------------------------------------------- |
| opcode | std_logic_vector(opcode_length - 1 downto 0) | 7-bit opcode input that determines the operation to be performed. |
| a      | std_logic_vector(data_length - 1 downto 0)   | First 32-bit input operand.                                       |
| b      | std_logic_vector(data_length - 1 downto 0)   | Second 32-bit input operand.                                      |
| c      | std_logic_vector(data_length - 1 downto 0)   | 32-bit output result.                                             |

## Constants

| Name          | Type    | Value | Description                                  |
| ------------- | ------- | ----- | -------------------------------------------- |
| data_length   | integer | 32    | Length of the input and output data vectors. |
| opcode_length | integer | 7     | Length of the opcode vector.                 |

## Processes
- p_stim: (  )
  - **Description**
  Process to generate test cases for the integer ALU. It applies different opcode values and input operands, and checks the output against expected results, asserting errors if the output does not match the expected value.

## Instantiations

- dut: work.alu(rtl)
  -  Instance of the integer ALU.
