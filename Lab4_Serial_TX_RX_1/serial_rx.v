module serial_rx (
    input        SCin,        
    input        SDin,        
    output reg [7:0] PDout,   
    output reg   PDready      
);

    reg [2:0] bit_count;
    reg       receiving;
    reg [7:0] temp_data;

    initial begin
        PDout = 8'b0;
        PDready = 1'b0;
        bit_count = 3'd0;
        receiving = 1'b0;
        temp_data = 8'b0;
    end

    always @(posedge SCin) begin
        PDready <= 1'b0;  

        if (!receiving) begin
            if (SDin == 1'b1) begin
             
                receiving <= 1'b1;
                bit_count <= 3'd0;
            end
        end
        else begin
            case (bit_count)
                3'd0: temp_data[7] <= SDin;
                3'd1: temp_data[6] <= SDin;
                3'd2: temp_data[5] <= SDin;
                3'd3: temp_data[4] <= SDin;
                3'd4: temp_data[3] <= SDin;
                3'd5: temp_data[2] <= SDin;
                3'd6: temp_data[1] <= SDin;
                3'd7: begin
                    temp_data[0] <= SDin;
                    PDout <= {temp_data[7:1], SDin};
                    PDready <= 1'b1;
                    receiving <= 1'b0;
                end
            endcase

            bit_count <= bit_count + 1'b1;
        end
    end

endmodule 