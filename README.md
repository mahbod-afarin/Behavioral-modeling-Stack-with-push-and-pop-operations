# Behavioral-modeling-Stack-with-push-and-pop-operations

### Objective

Design and implement a **stack** using a **behavioral description** approach.

### Stack Specifications

- **Depth:** 8 entries
- **Width:** 4 bits

### Inputs

| Signal    | Description                      |
|-----------|----------------------------------|
| `Clk`     | Clock signal                     |
| `RstN`    | Active-low reset                 |
| `Data_In` | 4-bit input data to the stack    |
| `Push`    | Push command                     |
| `Pop`     | Pop command                      |

### Outputs

| Signal      | Description                                |
|-------------|--------------------------------------------|
| `Data_Out`  | 4-bit data output from the top of the stack|
| `Full`      | Indicates the stack is full (`Full = 1`)   |
| `Empty`     | Indicates the stack is empty (`Empty = 1`) |

### Behavior Description

- On a **Push**:
  - If the stack is **not full**, the input `Data_In` is pushed onto the top.
- On a **Pop**:
  - If the stack is **not empty**, the top element is removed and shown on `Data_Out`.

The design should handle:
- Overflow and underflow conditions
- Proper updating of the `Full` and `Empty` flags

### Tools

- Verilog HDL
- Simulation (ModelSim, Vivado)
- Optional FPGA demo

---

### Parameterization

- Stack **depth** and **width** are controlled via parameters.
- The parameter `AddrWidth` sets the address width, and depth is calculated as `2^AddrWidth`.
- The stack memory is implemented using a **Verilog vector (array)**.
- Stack pointer `SP` is **one bit wider** than `AddrWidth` to handle overflow conditions cleanly.

### Control Logic

- `SP` always points to the **next empty location** ready for `Push`.
- A **reset (`RstN = 1`)** clears the stack, sets all outputs to zero, and activates the `Empty` flag.
- **No change** to `SP` occurs if both `Push` and `Pop` are asserted together.
  - In this case:
    - The input (`Data_In`) is written to `SP - 1`
    - The same address is read into `Data_Out`

### Push Operation
- Executed **only if the stack is not Full**
- The `SP` is incremented (`SP + 1`)
- The value from `Data_In` is written to the memory at `SP`
- `Empty` is deasserted (set to `0`)
- If `SP + 1 == Depth`, `Full` is asserted (set to `1`)

### Pop Operation
- Executed **only if the stack is not Empty**
- The value at `SP - 1` is assigned to `Data_Out`
- The `SP` is decremented (`SP - 1`)
- If `SP - 1 == 0`, `Empty` is asserted (set to `1`)
- `Full` is deasserted (set to `0`)

### Notes

- Stack handles all boundary conditions gracefully using combinational checks for `Full` and `Empty`.
- `Push` and `Pop` signals are prioritized to maintain stability and predictable behavior.
- Both operations dynamically update the `Full` and `Empty` flags.

### Example Simulation Scenarios

| Action | Condition                | Result                                |
|--------|--------------------------|---------------------------------------|
| Reset  | `RstN = 1`               | Clears stack, `Empty = 1`, `Full = 0` |
| Push   | Stack not Full           | `SP++`, Data written, flags updated   |
| Pop    | Stack not Empty          | `SP--`, Data read, flags updated      |
| Push + Pop | Valid if not empty   | Simultaneous update at `SP - 1`       |
