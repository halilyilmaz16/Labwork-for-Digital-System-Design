// EE342 - Lab Exp 6: TOP MODULE
// Finite State Machine - Cift Yonlu Araba Sayaci
// Giris:  00 -> 10 -> 11 -> 01 -> 00  (sayac artar)
// Cikis:  00 -> 01 -> 11 -> 10 -> 00  (sayac azalir)

module lab6_top (
    input  wire       clk,
    input  wire       reset,
    input  wire       D1,
    input  wire       D2,
    output wire [3:0] count      // 4-bit sayac
);

    // ---------------------------------------------------
    // State encoding (User-Encoded)
    // ---------------------------------------------------
    localparam S0    = 4'd0;
    localparam S1_IN = 4'd1;   // Giris: D1D2=10
    localparam S2_IN = 4'd2;   // Giris: D1D2=11
    localparam S3_IN = 4'd3;   // Giris: D1D2=01
    localparam S4_IN = 4'd4;   // Giris tamamlandi -> sayac +1
    localparam S1_EX = 4'd5;   // Cikis: D1D2=01
    localparam S2_EX = 4'd6;   // Cikis: D1D2=11
    localparam S3_EX = 4'd7;   // Cikis: D1D2=10
    localparam S4_EX = 4'd8;   // Cikis tamamlandi -> sayac -1

    reg [3:0] state, next_state;
    reg [3:0] count_reg;

    assign count = count_reg;

    // ---------------------------------------------------
    // Durum registeri  (sequential)
    // ---------------------------------------------------
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // ---------------------------------------------------
    // Sonraki durum logic  (combinational)
    // ---------------------------------------------------
    always @(*) begin
        case (state)

            S0: begin
                if      ({D1,D2} == 2'b10) next_state = S1_IN;
                else if ({D1,D2} == 2'b01) next_state = S1_EX;
                else                        next_state = S0;
            end

            // ---- GIRIS YOLU: 00->10->11->01->00 ----
            S1_IN: begin
                if      ({D1,D2} == 2'b11) next_state = S2_IN;
                else if ({D1,D2} == 2'b00) next_state = S0;    // geri dondu
                else                        next_state = S1_IN;
            end
            S2_IN: begin
                if      ({D1,D2} == 2'b01) next_state = S3_IN;
                else if ({D1,D2} == 2'b10) next_state = S1_IN; // geri dondu
                else                        next_state = S2_IN;
            end
            S3_IN: begin
                if      ({D1,D2} == 2'b00) next_state = S4_IN;
                else if ({D1,D2} == 2'b11) next_state = S2_IN; // geri dondu
                else                        next_state = S3_IN;
            end
            S4_IN: next_state = S0;   // 1 clock cycle, sonra idle

            // ---- CIKIS YOLU: 00->01->11->10->00 ----
            S1_EX: begin
                if      ({D1,D2} == 2'b11) next_state = S2_EX;
                else if ({D1,D2} == 2'b00) next_state = S0;    // geri dondu
                else                        next_state = S1_EX;
            end
            S2_EX: begin
                if      ({D1,D2} == 2'b10) next_state = S3_EX;
                else if ({D1,D2} == 2'b01) next_state = S1_EX; // geri dondu
                else                        next_state = S2_EX;
            end
            S3_EX: begin
                if      ({D1,D2} == 2'b00) next_state = S4_EX;
                else if ({D1,D2} == 2'b11) next_state = S2_EX; // geri dondu
                else                        next_state = S3_EX;
            end
            S4_EX: next_state = S0;   // 1 clock cycle, sonra idle

            default: next_state = S0;
        endcase
    end

    // ---------------------------------------------------
    // Sayac logic  (sequential)
    // Giris tamamlandi -> +1
    // Cikis tamamlandi -> -1
    // Tasma korumalı: 0 ile 15 arasinda kalir
    // ---------------------------------------------------
    always @(posedge clk or posedge reset) begin
        if (reset)
            count_reg <= 4'd0;
        else if (state == S4_IN && count_reg != 4'd15)
            count_reg <= count_reg + 1;
        else if (state == S4_EX && count_reg != 4'd0)
            count_reg <= count_reg - 1;
    end

endmodule
