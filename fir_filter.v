`timescale 1ns / 1ps

module fir_filter #(
    parameter N = 4  // Number of taps
)(
    input clk,
    input rst,
    input signed [7:0] x_in,
    output reg signed [15:0] y_out
);

    // Filter coefficients (can be customized)
    // Example: Low-pass filter coefficients
    reg signed [7:0] h [0:N-1];
    initial begin
        h[0] = 8'd1;
        h[1] = 8'd2;
        h[2] = 8'd2;
        h[3] = 8'd1;
    end

    // Shift register for inputs
    reg signed [7:0] x [0:N-1];

    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y_out <= 0;
            for (i = 0; i < N; i = i + 1)
                x[i] <= 0;
        end else begin
            // Shift input samples
            for (i = N-1; i > 0; i = i - 1)
                x[i] <= x[i-1];
            x[0] <= x_in;

            // Compute output
            y_out <= 0;
            for (i = 0; i < N; i = i + 1)
                y_out <= y_out + x[i] * h[i];
        end
    end

endmodule
