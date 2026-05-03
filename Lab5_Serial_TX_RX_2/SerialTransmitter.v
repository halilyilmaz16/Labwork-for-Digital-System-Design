
module SerialTransmitter (
    input        Clk,        
    input        Send,      
    input  [7:0] PDin,       
    output       SClk,       
    output reg   SDout       

    
    assign SClk = Clk;

   
    reg send_latch;          
    reg send_latch_prev;     
   
    always @(posedge Send or posedge send_clear) begin
        if (send_clear)
            send_latch <= 1'b0;
        else
            send_latch <= 1'b1;
    end


    reg  send_reg;          
    wire send_pulse;         
    reg  send_clear;         

    always @(posedge Clk) begin
        send_reg   <= send_latch;
        send_clear <= send_pulse;   
    end

    
    assign send_pulse = send_latch & ~send_reg;


    reg [9:0] shift_reg;   
    reg [3:0] bit_cnt;       
    reg       busy;          
  
    wire parity_bit = ^PDin; 

    always @(posedge Clk) begin
        if (!busy) begin
            
            SDout <= 1'b1;          

            if (send_pulse) begin
               
                shift_reg <= {parity_bit, PDin[0], PDin[1], PDin[2],
                              PDin[3], PDin[4], PDin[5], PDin[6],
                              PDin[7], 1'b0};
                bit_cnt   <= 4'd10;
                busy      <= 1'b1;
            end

        end else begin
        
            SDout     <= shift_reg[0];
            shift_reg <= {1'b1, shift_reg[9:1]}; 
            bit_cnt   <= bit_cnt - 4'd1;

            if (bit_cnt == 4'd1)
                busy <= 1'b0;  
        end
    end

endmodule
