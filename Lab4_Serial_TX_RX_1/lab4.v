module lab4 (
    input        Clk,
    input        Send,
    input  [7:0] PDin,
    output [7:0] PDout,
    output       PDready,
    output       SoClk,
    output       SDout
);

    wire serial_clk;
    wire serial_data;

    serial_tx TX (
        .Clk(Clk),
        .Send(Send),
        .PDin(PDin),
        .SCout(serial_clk),
        .SDout(serial_data)
    );

    serial_rx RX (
        .SCin(serial_clk),
        .SDin(serial_data),
        .PDout(PDout),
        .PDready(PDready)
    );

    assign SoClk = serial_clk;
    assign SDout = serial_data;

endmodule 