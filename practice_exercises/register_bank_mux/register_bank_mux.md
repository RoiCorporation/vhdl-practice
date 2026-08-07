
# Entity: register_bank_mux
- **File**: register_bank_mux.vhd
- **Title:**  Register bank MUX
- **Author:**  Roi (r.lopezbarata@gmail.com)
- **Version:**  1.0
- **Date:**  07-08-2026
- **Copyright:**  This work is licensed under the MIT License.
- **Brief:**  Register bank multiplexer that outputs the value of the selected register.

## Diagram
![Diagram](register_bank_mux.svg "Diagram")
## Description

This entity implements a multiplexer that selects one of the register outputs
from the register bank based on the selector input.

## Ports

| Port name    | Direction | Type                                                                    | Description                                                |
| ------------ | --------- | ----------------------------------------------------------------------- | ---------------------------------------------------------- |
| selector     | in        | std_logic_vector(register_address_width - 1 downto 0)                   | Selector input to choose which register output to forward. |
| bank_outputs | in        | bank_ports_t(register_amount - 1 downto 0)(register_width - 1 downto 0) | Array of register outputs from the register bank.          |
| output       | out       | std_logic_vector(register_width - 1 downto 0)                           | Output of the selected register value.                     |
