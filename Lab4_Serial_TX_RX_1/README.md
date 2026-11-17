# Lab 4 - Serial Transmitter/Receiver 1

`serial_tx.v` sends an 8-bit word (`PDin`) serially when `Send` is raised, together with a serial clock. `serial_rx.v` rebuilds the word (`PDout`) and raises `PDready`. `lab4.v` connects the two.
