# Lab 6 - Finite State Machine

A bidirectional counter driven by two sensors. The input pair D1D2 going 00 → 10 → 11 → 01 → 00 counts up, and 00 → 01 → 11 → 10 → 00 counts down. `lab6_top.v` is the top module with a user-encoded state machine and a 4-bit `count`. `sensor_fsm.v` (outputs `enter_pulse` and `exit_pulse` from D1 and D2) and `samplestatemachine.v` are separate state machine modules.
