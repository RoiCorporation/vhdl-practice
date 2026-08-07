
# Entity: pipo_register
- **File**: pipo_register.vhd
- **Title:**  PIPO register
- **Author:**  Roi (r.lopezbarata@gmail.com)
- **Version:**  1.0
- **Date:**  07-08-2026
- **Copyright:**  This work is licensed under the MIT License.
- **Brief:**  Implementation of a classic PIPO register.

## Diagram
![Diagram](pipo_register.svg "Diagram")
## Description

This is a classic PIPO register with synchronous reset and load enable.

## Generics

| Generic name   | Type    | Value | Description                    |
| -------------- | ------- | ----- | ------------------------------ |
| register_width | integer | 8     | Width of the register in bits. |

## Ports

| Port name | Direction | Type                                          | Description                                |
| --------- | --------- | --------------------------------------------- | ------------------------------------------ |
| rst       | in        | std_logic                                     | Synchronous reset signal.                  |
| clk       | in        | std_logic                                     | Clock signal.                              |
| load      | in        | std_logic                                     | Load enable signal.                        |
| input     | in        | std_logic_vector(register_width - 1 downto 0) | Input data to be loaded into the register. |
| output    | out       | std_logic_vector(register_width - 1 downto 0) | Output data from the register.             |

## Processes
- register_beh: ( clk )
  - **Description**
  Process that implements the behavior of the register. It updates the output on the rising edge of the clock, based on the reset and load signals.
