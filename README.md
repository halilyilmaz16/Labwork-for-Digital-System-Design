# Digital System Design Labwork (Verilog)

Verilog modules, simulation waveforms and lab assignments for the Digital System Design course (EE342) at İzmir Institute of Technology. Each lab is in its own folder with the top module, its sub-modules and a Quartus vector waveform file (`.vwf`) used for simulation.

## Labs

| Lab | Topic | What it builds | Top module |
|---|---|---|---|
| [1](Lab1_Module_Instantiation) | Module instantiation | A 3-bit counter and an AND/XOR block, selected by a `Select` input | `Lab1.v` |
| [2](Lab2_BCD_Counter) | BCD counter | Three cascaded BCD counters (ones, tens, hundreds) with an enable chain | `lab2.v` |
| [3](Lab3_Switch_Debouncer) | Switch debouncer | Two debouncer designs built from a four-stage D flip-flop chain | `lab3.v` |
| [4](Lab4_Serial_TX_RX_1) | Serial transmitter/receiver 1 | 8-bit parallel-in serial transmitter and a matching receiver | `lab4.v` |
| [5](Lab5_Serial_TX_RX_2) | Serial transmitter/receiver 2 | Transmitter and receiver with a parity error output | `TopModule.v` |
| [6](Lab6_FiniteStateMachine) | Finite state machine | Bidirectional counter driven by two sensors (D1, D2): entry sequence counts up, exit sequence counts down | `lab6_top.v` |
| 7 | Bidirectional data transfer | Not added yet | – |

## Repository layout

```
LabN_<Topic>/
├── *.v      Verilog sources (top module and sub-modules)
├── *.vwf    Quartus vector waveform used for simulation
└── README.md
```

## How to run

1. Open Intel Quartus Prime and create a project in the lab folder.
2. Set the top module from the table above and add the `.v` files.
3. Open the `.vwf` file in the Simulator Tool and run a functional simulation.

## Notes

- Lab 6 comments are written in Turkish.
- Lab 2 has two waveform files: `lab2.vwf` and `lab2250.vwf`.
