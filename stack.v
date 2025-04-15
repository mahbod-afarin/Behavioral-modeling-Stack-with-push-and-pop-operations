module Stack (
    input wire clk,
    input wire RstN,                 // Active-low reset
    input wire [7:0] Data_In,        // Input data
    input wire Push,                 // Push control
    input wire Pop,                  // Pop control
    output reg [2:0] SP,             // Stack Pointer
    output reg [7:0] Data_Out,       // Output data
    output reg Full,                 // High when stack is full
    output reg Empty                 // High when stack is empty
);

  reg [7:0] Mem [7:0];               // 8-element stack memory

  always @(posedge clk) begin
    if (RstN) begin
      // Reset logic
      SP <= 0;
      Full <= 1'b0;
      Empty <= 1'b1;
      Data_Out <= 8'd0;

      // Optional: clear memory
      Mem[0] <= 8'd0;
      Mem[1] <= 8'd0;
      Mem[2] <= 8'd0;
      Mem[3] <= 8'd0;
      Mem[4] <= 8'd0;
      Mem[5] <= 8'd0;
      Mem[6] <= 8'd0;
      Mem[7] <= 8'd0;

    end else begin
      case ({Push, Pop})
        2'b10: begin // Push only
          if (!Full) begin
            Mem[SP] <= Data_In;
            SP <= SP + 1;

            Empty <= 1'b0;
            if (SP == 3'd7) Full <= 1'b1;
          end
        end

        2'b01: begin // Pop only
          if (!Empty) begin
            SP <= SP - 1;
            Data_Out <= Mem[SP - 1];

            Full <= 1'b0;
            if (SP == 3'd1) Empty <= 1'b1;
          end
        end

        2'b11: begin // Push and Pop at the same time
          if (!Empty && !Full) begin
            SP <= SP; // No net change in stack pointer
            Mem[SP - 1] <= Data_In;
            Data_Out <= Mem[SP - 1];
          end
        end

        default: ; // No operation
      endcase
    end
  end

endmodule
