module serial_tx (
    input        Clk,         
    input        Send,        
    input  [7:0] PDin,        
    output       SCout,       
    output reg   SDout        
);

    reg [7:0] data_reg;
    reg [3:0] bit_count;
    reg       busy;

    assign SCout = Clk;

    initial begin
        SDout = 1'b0;
        data_reg = 8'b0;
        bit_count = 4'd0;
        busy = 1'b0;
    end

    always @(posedge Clk) begin
        if (!busy) begin
            SDout <= 1'b0;  

            if (Send) begin
                busy     <= 1'b1;
                data_reg <= PDin;
                bit_count <= 4'd0;
                SDout    <= 1'b1;  
            end
        end
        else begin
            bit_count <= bit_count + 1'b1;

            case (bit_count)
                4'd0: SDout <= data_reg[7];
                4'd1: SDout <= data_reg[6];
                4'd2: SDout <= data_reg[5];
                4'd3: SDout <= data_reg[4];
                4'd4: SDout <= data_reg[3];
                4'd5: SDout <= data_reg[2];
                4'd6: SDout <= data_reg[1];
                4'd7: begin
                    SDout <= data_reg[0];
                    busy  <= 1'b0;  
                end
                default: begin
                    SDout <= 1'b0;
                    busy  <= 1'b0;
                end
            endcase
        end
    end

endmodule 