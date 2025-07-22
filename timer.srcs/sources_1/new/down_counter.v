`timescale 1ns/1ps

module down_counter(
    input clk_1Hz,
    input reset,
    input control, //on or off
    input [3:0] tens_mins, ones_mins, tens_sec, ones_sec,
    output reg [3:0] out_tensMins, out_onesMins, out_tensSec, out_onesSec,
    output reg done
    );
    
    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            out_tensMins <= tens_mins;
            out_onesMins <= ones_mins;
            out_tensSec <= tens_sec;
            out_onesSec <= ones_sec;
        end else if (control && !done) begin
            if(out_tensMins == 0 && out_onesMins == 0 && out_tensSec == 0 && out_onesSec == 0) begin
                done <= 1; 
            end else begin //countdown logic
                if(out_onesSec > 0)
                    out_onesSec <= out_onesSec - 1;
                else begin
                    out_onesSec <= 9;
                    if(out_tensSec > 0) 
                        out_tensSec <= out_tensSec - 1;
                    else begin
                        out_tensSec <= 9; 
                        if(out_onesMins > 0) 
                            out_onesMins <= out_onesMins - 1;
                        else begin
                            out_onesMins <= 9;
                            if(out_tensMins > 0) 
                                out_tensMins <= out_tensMins -1;
                            else 
                                out_tensMins <= 0;
                        end
                    end    
                end
            end
        end
    end
endmodule