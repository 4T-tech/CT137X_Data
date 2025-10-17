`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/25 17:56:46
// Design Name: 
// Module Name: logic
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


module logic_gate (
    input   wire    A,      //������A - SW1
    input   wire    B,      //������B - SW2
    input   wire    C,      //������C - SW3
    input   wire    D,      //������D - SW4
    output  wire    F       //�����F - LD1      
);


assign F = A & B & C & D;
    
endmodule