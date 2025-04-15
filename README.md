# Behavioral-modeling-Stack-with-push-and-pop-operations

### Objective

Design and implement a **stack** using a **behavioral description** approach.

## Stack Specifications

- **Depth:** 8 entries
- **Width:** 4 bits

## Inputs

| Signal    | Description                      |
|-----------|----------------------------------|
| `Clk`     | Clock signal                     |
| `RstN`    | Active-low reset                 |
| `Data_In` | 4-bit input data to the stack    |
| `Push`    | Push command                     |
| `Pop`     | Pop command                      |

## Outputs

| Signal      | Description                                |
|-------------|--------------------------------------------|
| `Data_Out`  | 4-bit data output from the top of the stack|
| `Full`      | Indicates the stack is full (`Full = 1`)   |
| `Empty`     | Indicates the stack is empty (`Empty = 1`) |

## Behavior Description

- On a **Push**:
  - If the stack is **not full**, the input `Data_In` is pushed onto the top.
- On a **Pop**:
  - If the stack is **not empty**, the top element is removed and shown on `Data_Out`.

The design should handle:
- Overflow and underflow conditions
- Proper updating of the `Full` and `Empty` flags

## Tools

- Verilog HDL
- Simulation (ModelSim, Vivado)
- Optional FPGA demo
