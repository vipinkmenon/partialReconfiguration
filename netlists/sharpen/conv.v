`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2020 10:09:05 PM
// Design Name: 
// Module Name: conv
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


module conv(
input        i_clk,
input [71:0] i_pixel_data,
input        i_pixel_data_valid,
output reg [7:0] o_convolved_data,
output reg   o_convolved_data_valid
    );

    
integer i; 
reg [7:0] kernel1 [8:0];
reg [10:0] multData1[8:0];
reg [10:0] sumDataInt1;
reg multDataValid;
reg [21:0] convolved_data_int;
reg convolved_data_int_valid;

initial
begin
    kernel1[0] = 0;
    kernel1[1] = -1;
    kernel1[2] = 0;
    kernel1[3] = -1;
    kernel1[4] = 5;
    kernel1[5] = -1;
    kernel1[6] = 0;
    kernel1[7] = -1;
    kernel1[8] = 0;
end    
    
always @(posedge i_clk)
begin
    for(i=0;i<9;i=i+1)
    begin
        multData1[i] <= $signed(kernel1[i])*$signed({1'b0,i_pixel_data[i*8+:8]});
    end
    multDataValid <= i_pixel_data_valid;
end


always @(*)
begin
    sumDataInt1 = 0;
    for(i=0;i<9;i=i+1)
    begin
        sumDataInt1 = $signed(sumDataInt1) + $signed(multData1[i]);
    end
end

always @(posedge i_clk)
begin
    convolved_data_int <= sumDataInt1;
    convolved_data_int_valid <= multDataValid;
end
    
always @(posedge i_clk)
begin
    if($signed(convolved_data_int) > 255)
        o_convolved_data <= 8'hff;
    else if($signed(convolved_data_int) < 0)
        o_convolved_data <= 0;
    else
        o_convolved_data <= convolved_data_int;
    o_convolved_data_valid <= convolved_data_int_valid;
end
    
endmodule
