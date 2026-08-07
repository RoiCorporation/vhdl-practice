
# Entity: alu
- **File**: alu.vhd
- **Title:**  Integer ALU
- **Author:**  Roi (r.lopezbarata@gmail.com)
- **Version:**  1.0
- **Date:**  07-08-2026
- **Copyright:**  This work is licensed under the MIT License.
- **Brief:**  Integer 32-bit ALU implementation inspired by the RISC-V specification.

## Diagram
![Diagram](alu.svg "Diagram")
## Description

This is an implementation of a simple ALU (Arithmetic Logic Unit) that
performs basic arithmetic and logic operations on two 32-bit inputs. The
operation to be performed is determined by a 7-bit opcode input, and the
result of the operation is output as a 32-bit value.

## Generics

| Generic name  | Type    | Value | Description                                  |
| ------------- | ------- | ----- | -------------------------------------------- |
| data_length   | integer | 32    | Length of the input and output data vectors. |
| opcode_length | integer | 7     | Length of the opcode vector.                 |

## Ports

| Port name | Direction | Type                                         | Description                                                       |
| --------- | --------- | -------------------------------------------- | ----------------------------------------------------------------- |
| opcode    | in        | std_logic_vector(opcode_length - 1 downto 0) | 7-bit opcode input that determines the operation to be performed. |
| a         | in        | std_logic_vector(data_length - 1 downto 0)   | First 32-bit input operand.                                       |
| b         | in        | std_logic_vector(data_length - 1 downto 0)   | Second 32-bit input operand.                                      |
| c         | out       | std_logic_vector(data_length - 1 downto 0)   | 32-bit output result.                                             |
