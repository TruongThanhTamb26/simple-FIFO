`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2023 08:49:46 AM
// Design Name: 
// Module Name: FIFO
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


module FIFO(clk, rst, data_in, data_out, write_en, read_en, empty, full, count);
    
    input  wire       clk, rst, write_en, read_en;	// clock, reset, write enable, read enable
    input  wire [1:0] data_in;

    output reg  [1:0] data_out;
    output reg        full = 0, empty = 1;
    output reg [3:0] count = 0;


    reg [26:0] countclk = 0;
    reg Fclk = 0;	
    reg [2:0] write_ptr, read_ptr; 				//pointer to read and write
    reg [1:0] mem[7:0];


    always @(posedge clk)begin        	  			//change clock frequency

        if (countclk == 26'd62500000) begin
            countclk <= 0;
            Fclk = ~Fclk;

        end else
            countclk <= countclk + 1;
    end

    
    always @(count) begin
    
        full <= (count == 8);      				//check: buffer empty or not
        empty <= (count == 0);      				//check: buffer full or not
        
    end
    
    
    always @(posedge Fclk or posedge rst) begin  		// COUNT
    
        if (rst)
            count <= 0;
            
        else if ((!full && write_en) && (!empty && read_en))
            count <= count;
            
        else if (!full && write_en)
            count <= count + 1;
            
        else if (!empty && read_en)
            count <= count - 1;
        
        else 
            count <= count;
            
    end
    
    
    always @(posedge Fclk or posedge rst) begin  		//READ
    
        if (rst)
            data_out <= 0;
            
        else begin
            if (read_en && !empty)
                data_out <= mem[read_ptr];
                
            else
                data_out <= data_out;
        end
        
    end
    
    
    always @(posedge Fclk) begin               		//WRITE
    
        if (write_en && !full) 
            mem[write_ptr] <= data_in;
            
        else
            mem[write_ptr] <= mem[write_ptr];
            
    end
    
    
    always @(posedge Fclk or posedge rst) begin     	//POINTER
    
        if (rst) begin
            write_ptr <= 0;
            read_ptr <= 0;
            
        end else begin
            if(!full && write_en)
                write_ptr <= write_ptr + 1;
                
            else
                write_ptr <= write_ptr;
                
            if(!empty && read_en)
                read_ptr <= read_ptr + 1;
                
            else
                read_ptr <= read_ptr;
        end
        
    end
    
    
endmodule
