# Digital Logic Design Project: Development of an Electronic Lock System Using Password Authentication on FPGA Arty-Z7

This project implements a synchronous FIFO buffer as part of an electronic lock system with password authentication, designed and tested using Xilinx Vivado.

## Project Structure

The project includes the following key files:

- `FIFO.v` - Core FIFO implementation
- `FIFO_tb.v` - Testbench for FIFO verification
- Vivado project files for synthesis, implementation, and simulation

## FIFO Features

- 8-entry buffer with 2-bit data width
- Synchronous read and write operations
- Status flags: empty and full
- Counter to track number of elements in the FIFO
- Clock divider to generate a slower operational clock
- Support for concurrent read/write operations
- Reset functionality

## Technical Details

### FIFO Module

The FIFO module implements:

1. **Clock Management**:

   - Input clock divided by a counter to produce a slower operational clock (Fclk)

2. **Status Management**:

   - Empty flag - set when count = 0
   - Full flag - set when count = 8 (buffer full)

3. **Count Management**:

   - Tracks the number of elements in the FIFO
   - Increased on write, decreased on read
   - Maintained when both operations occur simultaneously

4. **Read Operation**:

   - Activated by read_en when FIFO is not empty
   - Outputs data from the location pointed by read_ptr

5. **Write Operation**:

   - Activated by write_en when FIFO is not full
   - Stores data at the location pointed by write_ptr

6. **Pointer Management**:
   - read_ptr and write_ptr track the next read/write positions
   - Incremented after respective operations

### Testbench

The testbench verifies FIFO functionality by:

1. Initializing the FIFO and applying reset
2. Pushing data into the FIFO
3. Popping data from the FIFO
4. Testing concurrent push/pop operations
5. Testing full and empty conditions
6. Displaying operation results

## Usage

The testbench demonstrates how to use the FIFO:

```verilog
// Push data to FIFO
push(data_value);

// Pop data from FIFO
pop(data_variable);
```

## Known Issues

There's a data width mismatch between the FIFO implementation and testbench:

- `FIFO.v` uses 2-bit data ([1:0])
- `FIFO_tb.v` uses 8-bit data ([7:0])

This should be resolved by matching the data widths in both files before simulation.

## Implementation Results

The design has been successfully synthesized and implemented on a Xilinx Zynq-7000 device (xc7z020clg400-1). Implementation statistics show the design uses minimal FPGA resources:

- LUTs: 25
- Flip-Flops: 40
- I/O Buffers: 14
- Distributed RAM: Used for FIFO memory

## Simulation

To run the simulation:

1. Open the project in Vivado
2. Launch the simulator with FIFO_tb as the target
3. Run the simulation to view FIFO operations in the waveform viewer
