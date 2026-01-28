
Simulation Workflow
=========================================================================
- The images are categorized into Left and Right views. Each view is further 
  divided into two scales based on the image pyramid. (The subsequent modules 
  are identical for different scales; only the dimension parameters need 
  to be adjusted).
- This design utilizes Time-Division Multiplexing (TDM). Therefore, verifying 
  a single scale of either the Left or Right image is sufficient for 
  functional validation.

1. Use scripts to convert the input simulation images into unsigned 8-bit 
   binary .txt files (one pixel per line).
2. The Testbench (tb) inputs the grayscale value of the corresponding point 
   based on the provided address (addr).
3. Use scripts to perform visualization conversion on the output results.
=========================================================================

FAST simulation result



![fast_result](./fast_result.png)

compute dscriptor simulation result



![descriptor_result](./descriptor_result.png)
FAST software result 1(python)



![fast_PurePython_1](./fast_PurePython_1.png)

FAST hardware result 1(verilog)



![fast_verilog_1_v2](./fast_verilog_1_v2.png)

FAST software result 2(python)



![fast_PurePython_000094](./fast_PurePython_000094.png)

FAST hardware result 2(verilog)



![fast_verilog_000094_v2](./fast_verilog_000094_v2.png)

FAST coordinates text file by verilog



![fast_result_coor](./fast_result_coor.png)

