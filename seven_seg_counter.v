`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2026 12:45:15 AM
// Design Name: 
// Module Name: seven_seg_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_seg_counter (
    input clk,          // 100MHz On-board Clock
    input reset,        // BTNC (Reset)
    output reg [6:0] seg,  // 7-Segment (Active Low)
    output reg [3:0] an     // Anode Control (Active Low)
);
    
    // 1. 1 Second Timer (100MHz ? 1Hz)
    reg [26:0] counter_1s = 0;
    reg tick_1s = 0;
    
    always @(posedge clk) begin
        if (counter_1s == 100_000_000 - 1) begin  // 100,000,000 clocks = 1 second
            counter_1s <= 0;
            tick_1s <= 1;
        end else begin
            counter_1s <= counter_1s + 1;
            tick_1s <= 0;
        end
    end
    
    // 2. 4-Digit BCD Counter (0 to 9999)
    reg [3:0] digit0 = 0;  // Unit
    reg [3:0] digit1 = 0;  // Tens
    reg [3:0] digit2 = 0;  // Hundreds
    reg [3:0] digit3 = 0;  // Thousands
    
    always @(posedge clk) begin
        if (reset) begin
            // Reset ??????? 0
            digit0 <= 0;
            digit1 <= 0;
            digit2 <= 0;
            digit3 <= 0;
        end else if (tick_1s) begin
            // 1 Second ?????? ???????
            if (digit0 == 9) begin
                digit0 <= 0;
                if (digit1 == 9) begin
                    digit1 <= 0;
                    if (digit2 == 9) begin
                        digit2 <= 0;
                        if (digit3 == 9) begin
                            digit3 <= 0;  // 9999 ? 0000
                        end else begin
                            digit3 <= digit3 + 1;
                        end
                    end else begin
                        digit2 <= digit2 + 1;
                    end
                end else begin
                    digit1 <= digit1 + 1;
                end
            end else begin
                digit0 <= digit0 + 1;
            end
        end
    end
    
    // 3. 7-Segment Multiplexing (Refresh Rate ~ 1kHz)
    reg [1:0] an_sel = 0;
    reg [16:0] refresh_counter = 0;
    reg [3:0] current_digit;
    
    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
        an_sel <= refresh_counter[16:15];  // 2-bit selector
    end
    
    // 4. Digit Selector & Anode Control
    always @(*) begin
        case (an_sel)
            2'b00: begin
                an = 4'b1110;        // Digit 0 (Rightmost)
                current_digit = digit0;
            end
            2'b01: begin
                an = 4'b1101;        // Digit 1
                current_digit = digit1;
            end
            2'b10: begin
                an = 4'b1011;        // Digit 2
                current_digit = digit2;
            end
            2'b11: begin
                an = 4'b0111;        // Digit 3 (Leftmost)
                current_digit = digit3;
            end
            default: an = 4'b1111;
        endcase
    end
    
    // 5. BCD to 7-Segment Decoder (Active Low)
    always @(*) begin
        case (current_digit)
            4'b0000: seg = 7'b1000000;  // 0
            4'b0001: seg = 7'b1111001;  // 1
            4'b0010: seg = 7'b0100100;  // 2
            4'b0011: seg = 7'b0110000;  // 3
            4'b0100: seg = 7'b0011001;  // 4
            4'b0101: seg = 7'b0010010;  // 5
            4'b0110: seg = 7'b0000010;  // 6
            4'b0111: seg = 7'b1111000;  // 7
            4'b1000: seg = 7'b0000000;  // 8
            4'b1001: seg = 7'b0010000;  // 9
            default: seg = 7'b1111111;  // OFF
        endcase
    end
    
endmodule
