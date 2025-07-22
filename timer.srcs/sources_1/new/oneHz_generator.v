`timescale 1ns/1ps

module oneHz_generator #(parameter MAX_COUNT = 99_999_999)(
    input clk_100MHz,
    input reset,
    input on,
    output reg enable_1Hz
    );
    
    reg [27:0] counter_reg = 0;
    
    always @(posedge clk_100MHz or posedge reset) begin
        if(reset) begin
            counter_reg <= 0;
            enable_1Hz <= 0;
        end
        else if (on) begin
            if(counter_reg == MAX_COUNT) begin
                counter_reg <= 0;
                enable_1Hz <= 1;
            end 
            else begin
                counter_reg <= counter_reg + 1;
                enable_1Hz <= 0;
            end
        end else begin
            enable_1Hz <= 0;
        end
    end
endmodule
