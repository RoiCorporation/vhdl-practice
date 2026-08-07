
# Package: cpu_types 
- **File**: cpu_types.vhd
- **Title:**  CPU types
- **Author:**  Roi (r.lopezbarata@gmail.com)
- **Version:**  1.0
- **Date:**  07-08-2026
- **Copyright:**  This work is licensed under the MIT License.
- **Brief:**  Custom types and declarations used in different files of this CPU project.

## Description

This package contains custom types and constants used in the CPU project,
including register specifications and array types for register bank ports.

## Constants

| Name                   | Type    | Value | Description                                               |
| ---------------------- | ------- | ----- | --------------------------------------------------------- |
| register_amount        | natural | 32    | Amount of general purpose registers available in the CPU. |
| register_width         | natural | 32    | Width of the general purpose registers in bits.           |
| register_address_width | natural | 5     | Bits needed to address every general purpose register.    |

## Types

| Name         | Type                                         | Description                                           |
| ------------ | -------------------------------------------- | ----------------------------------------------------- |
| bank_ports_t | array (natural range <>) of std_logic_vector | Array type for the port entries of the register bank. |
