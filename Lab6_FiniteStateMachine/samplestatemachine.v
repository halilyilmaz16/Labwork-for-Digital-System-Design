module samplestatemachine
(
    input nRst,
    input clk,
    input in,
    output reg [3:0] count
);

parameter N = 1;

reg [N:0] state;
reg [N:0] nextState;
reg newPacket;

parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;

// State register
always @(posedge clk or negedge nRst)
begin
    if (nRst == 1'b0)
        state <= S0;
    else
        state <= nextState;
end

// Next state logic
always @(*)
begin
    case (state)

        S0:
        begin
            if (in == 1'b0)
                nextState = S1;
            else
                nextState = S0;

            newPacket = 0;
        end

        S1:
        begin
            if (in == 1'b0)
                nextState = S2;
            else
                nextState = S0;

            newPacket = 0;
        end

        S2:
        begin
            if (in == 1'b0)
                nextState = S3;
            else
                nextState = S0;

            newPacket = 0;
        end

        S3:
        begin
            if (in == 1'b0)
            begin
                nextState = S3;
                newPacket = 0;
            end
            else
            begin
                nextState = S0;
                newPacket = 1;
            end
        end

        default:
        begin
            nextState = S0;
            newPacket = 0;
        end

    endcase
end

// Counter logic
always @(posedge clk or negedge nRst)
begin
    if (nRst == 1'b0)
        count[3:0] <= 4'b0;
    else
    begin
        if (newPacket == 1'b1)
            count[3:0] <= count[3:0] + 1'b1;
        else
            count[3:0] <= count[3:0];
    end
end

endmodule