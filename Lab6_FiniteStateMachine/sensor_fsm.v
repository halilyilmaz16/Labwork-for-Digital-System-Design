module sensor_fsm
(
    input clk,
    input nRst,
    input D1,
    input D2,
    output reg enter_pulse,
    output reg exit_pulse
);

reg [3:0] state;
reg [3:0] nextState;

parameter S_IDLE       = 4'b0000,

          S_ENT_10     = 4'b0001,
          S_ENT_11     = 4'b0010,
          S_ENT_01     = 4'b0011,
          S_ENTER_DONE = 4'b0100,

          S_EXT_01     = 4'b0101,
          S_EXT_11     = 4'b0110,
          S_EXT_10     = 4'b0111,
          S_EXIT_DONE  = 4'b1000;

// State register
always @(posedge clk or negedge nRst)
begin
    if (nRst == 1'b0)
        state <= S_IDLE;
    else
        state <= nextState;
end

// Next state logic
always @(*)
begin
    nextState = S_IDLE;
    enter_pulse = 1'b0;
    exit_pulse  = 1'b0;

    case (state)

        S_IDLE:
        begin
            case ({D1, D2})
                2'b00: nextState = S_IDLE;
                2'b10: nextState = S_ENT_10;
                2'b01: nextState = S_EXT_01;
                default: nextState = S_IDLE;
            endcase
        end

        // Entry direction: 00 -> 10 -> 11 -> 01 -> 00
        S_ENT_10:
        begin
            case ({D1, D2})
                2'b10: nextState = S_ENT_10;
                2'b11: nextState = S_ENT_11;
                2'b00: nextState = S_IDLE;
                default: nextState = S_IDLE;
            endcase
        end

        S_ENT_11:
        begin
            case ({D1, D2})
                2'b11: nextState = S_ENT_11;
                2'b01: nextState = S_ENT_01;
                2'b10: nextState = S_ENT_10;
                default: nextState = S_IDLE;
            endcase
        end

        S_ENT_01:
        begin
            case ({D1, D2})
                2'b01: nextState = S_ENT_01;
                2'b00: nextState = S_ENTER_DONE;
                2'b11: nextState = S_ENT_11;
                default: nextState = S_IDLE;
            endcase
        end

        S_ENTER_DONE:
        begin
            enter_pulse = 1'b1;
            nextState = S_IDLE;
        end

        // Exit direction: 00 -> 01 -> 11 -> 10 -> 00
        S_EXT_01:
        begin
            case ({D1, D2})
                2'b01: nextState = S_EXT_01;
                2'b11: nextState = S_EXT_11;
                2'b00: nextState = S_IDLE;
                default: nextState = S_IDLE;
            endcase
        end

        S_EXT_11:
        begin
            case ({D1, D2})
                2'b11: nextState = S_EXT_11;
                2'b10: nextState = S_EXT_10;
                2'b01: nextState = S_EXT_01;
                default: nextState = S_IDLE;
            endcase
        end

        S_EXT_10:
        begin
            case ({D1, D2})
                2'b10: nextState = S_EXT_10;
                2'b00: nextState = S_EXIT_DONE;
                2'b11: nextState = S_EXT_11;
                default: nextState = S_IDLE;
            endcase
        end

        S_EXIT_DONE:
        begin
            exit_pulse = 1'b1;
            nextState = S_IDLE;
        end

        default:
        begin
            nextState = S_IDLE;
            enter_pulse = 1'b0;
            exit_pulse = 1'b0;
        end

    endcase
end

endmodule 