`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2023 10:18:32 AM
// Design Name: 
// Module Name: FIFO_tb
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


module FIFO_tb();
    reg clk, rst, write_en, read_en;
    reg [7:0] data_in;
    reg [7:0] tempdata;
    wire [7:0] data_out;
    wire empty, full;
    wire [3:0] count;
    
    FIFO UUT (clk, rst, data_in, data_out, write_en, read_en, empty, full, count);
    
    initial begin
        rst = 1;
        clk = 0;
        write_en = 0;
        read_en = 0;
        tempdata = 0;
        data_in = 0;
        
        #15 rst = 0;
        push(1);
        fork
           push(2);
           pop(tempdata);
        join              //push and pop together   
        push(10);
        push(20);
        push(30);
        push(40);
        push(50);
        push(60);
        push(70);
        push(80);
        push(90);
        push(100);
        push(110);
        push(120);
        push(130);

        pop(tempdata);
        push(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
		  push(140);
        pop(tempdata);
        push(tempdata);//
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        push(5);
        pop(tempdata);
    end
    
    always
        #5 clk = ~clk;
        
    task push;
    input [7:0] data;
    
        if(full)
            $display("------FULL------");
        else
            begin
            $display("Pushed ",data );
            data_in = data;
            write_en = 1;
            @(posedge clk)
                #1 write_en = 0;
            end
    endtask
    
    task pop;
    output [7:0] data;
    
        if(empty)
            $display("---------EMPTY----");
        else
            begin
            read_en = 1;
            @(posedge clk)
                #1 read_en = 0;
                data = data_out;
                $display("Poped ", data);
            end
    endtask
        
endmodule
