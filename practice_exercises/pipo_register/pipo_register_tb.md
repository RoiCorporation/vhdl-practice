
# Entity: pipo_register_tb
- **File**: pipo_register_tb.vhd
- **Title:**  Testbench for the PIPO register
- **Author:**  Roi (r.lopezbarata@gmail.com)
- **Version:**  1.0
- **Date:**  07-08-2026
- **Copyright:**  This work is licensed under the MIT License.
- **Brief:**  Testbench for the PIPO register implementation.

## Description

This entity implements a testbench for the register entity. It generates a
clock signal, applies reset and input stimuli, and observes the output of
the register. Furthermore, it contains test cases to verify the correct
behavior of the register under different conditions.

## Signals

| Name   | Type                                          | Description                                |
| ------ | --------------------------------------------- | ------------------------------------------ |
| rst    | std_logic                                     | Synchronous reset signal.                  |
| clk    | std_logic                                     | Clock signal.                              |
| load   | std_logic                                     | Load enable signal.                        |
| input  | std_logic_vector(register_width - 1 downto 0) | Input data to be loaded into the register. |
| output | std_logic_vector(register_width - 1 downto 0) | Output data from the register.             |

## Constants

| Name           | Type    | Value | Description                                  |
| -------------- | ------- | ----- | -------------------------------------------- |
| clk_period     | time    | 10 ns | Clock period for the testbench clock signal. |
| register_width | integer | 8     | Width of the register in bits.               |

## Processes
- p_clk: (  )
  - **Description**
  Process to generate the clock signal. It toggles the clock every half period.
- p_stim: (  )
  - **Description**
  Process to test the register behavior. It applies reset, load, and input stimuli to the register and observes the output. It contains test cases to verify the correct operation of the register under different conditions.

## Instantiations

- dut: work.pipo_register(rtl)
  -  Instance of the PIPO register.
