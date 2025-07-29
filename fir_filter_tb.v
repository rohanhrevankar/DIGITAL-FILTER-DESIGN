`timescale 1ns / 1ps

module fir_filter_tb;

    reg clk, rst;
    reg signed [7:0] x_in;
    wire signed [15:0] y_out;

    fir_filter uut (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .y_out(y_out)
    );

    initial begin
        $dumpfile("fir_filter.vcd");
        $dumpvars(0, fir_filter_tb);

        clk = 0; rst = 1;
        x_in = 0;
        #10 rst = 0;

        // Apply test input sequence (e.g., impulse + step)
        #10 x_in = 8'd10;
        #10 x_in = 8'd0;
        #10 x_in = 8'd0;
        #10 x_in = 8'd0;
        #10 x_in = 8'd0;
        #10 x_in = 8'd10;
        #10 x_in = 8'd10;
        #10 x_in = 8'd10;
        #10 x_in = 8'd10;
        #50 $finish;
    end

    always #5 clk = ~clk;

endmodule
