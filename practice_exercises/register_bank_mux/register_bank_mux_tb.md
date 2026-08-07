
# Entity: register_bank_mux_tb
- **File**: register_bank_mux_tb.vhd
- **Title:**  Testbench for the register bank MUX
- **Author:**  Roi (r.lopezbarata@gmail.com)
- **Version:**  1.0
- **Date:**  07-08-2026
- **Copyright:**  This work is licensed under the MIT License.
- **Brief:**  Testbench with test cases for the register bank multiplexer.

## Description

This entity implements a testbench for the register bank multiplexer. It generates
test cases to verify the correct functionality of the multiplexer by applying
different selector values and checking the output against expected results.

## Signals

| Name         | Type                                                                    | Description                                                |
| ------------ | ----------------------------------------------------------------------- | ---------------------------------------------------------- |
| selector     | std_logic_vector(register_address_width - 1 downto 0)                   | Selector input to choose which register output to forward. |
| bank_outputs | bank_ports_t(register_amount - 1 downto 0)(register_width - 1 downto 0) | Array of register outputs from the register bank.          |
| output       | std_logic_vector(register_width - 1 downto 0)                           | Output of the selected register value.                                                            |

## Processes
- p_stim: (  )
  - **Description**
  Process to generate test cases for the register bank multiplexer. It applies different selector values and checks the output against expected results, asserting errors if the output does not match the expected value.

## Instantiations

- dut: work.register_bank_mux
  -  Instance of the register bank multiplexer.
