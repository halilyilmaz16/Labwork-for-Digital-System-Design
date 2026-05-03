

module SerialReceiver (
    input        SCin,         
    input        SDin,          
    output reg [7:0] PDout,    
    output reg   PDready,      
    output reg   ParErr       
);

    
    localparam IDLE    = 2'd0;
    localparam RECEIVE = 2'd1;
    localparam DONE    = 2'd2;

    reg [1:0]  state;
    reg [3:0]  bit_cnt;     
    reg [8:0]  shift_reg;   

    always @(posedge SCin) begin
        case (state)

     
            IDLE: begin
                PDready <= 1'b0;
            

             
                if (SDin == 1'b0) begin
                    bit_cnt   <= 4'd0;
                    shift_reg <= 9'd0;
                    state     <= RECEIVE;
                end
            end

            RECEIVE: begin
               
             
                shift_reg <= {shift_reg[7:0], SDin};
                bit_cnt   <= bit_cnt + 4'd1;

                if (bit_cnt == 4'd8)   
                    state <= DONE;
            end

          
            DONE: begin
               
                PDout   <= shift_reg[8:1];

                ParErr  <= (^shift_reg[8:1]) ^ shift_reg[0];

                PDready <= 1'b1;
                state   <= IDLE;
            end

        endcase
    end



endmodule
