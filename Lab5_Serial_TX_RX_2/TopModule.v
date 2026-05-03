

module TopModule (
    input        ClkIn,         
    input        Send,          
    input  [7:0] PDin,         
    output       PDready,       
    output       ParErr,        
    output [7:0] PDout,         
    output       Sclk,          
    output       Sdata          
    
);

    wire sclk_int;
    wire sdata_int;

  
    SerialTransmitter ST1 (
        .Clk   (ClkIn),
        .Send  (Send),
        .PDin  (PDin),
        .SClk  (sclk_int),
        .SDout (sdata_int)
    );


    SerialReceiver SR1 (
        .SCin   (sclk_int),
        .SDin   (sdata_int),
        .PDout  (PDout),
        .PDready(PDready),
        .ParErr (ParErr)
    );

    assign Sclk  = sclk_int;
    assign Sdata = sdata_int;

endmodule
