### Factor Graph FPGA Accelerator Source Code

This is a hardware accelerator, which combines localization, planning and control. Specifically, in this accelerator, all applications share the same QR decomposition module and Backward substitution module.

-----------



1. Core Verilog Files

backsub.h:  Backward Substitution Unit
BaseMatrix.h:  Basic Matrix Computation Unit
Collsion_free.h:  Collision-Free Unit
InitialMatrix.h:  Initialize Map Unit
QRD.cpp:  QR Decomposition Unit 
QRD.h: Parameters Configuration for QR Decomposition Unit
RotationTrans.h:  Rotation Computation Unit 
SDF.h:  Signed Distance Field Computation Unit
Smooth.h:  Smooth Unit
TOP.cpp:  Main Unit
TOP.h:  Parameters Configuration for Main Unit

------

2. Key Parameters

In TOP.cpp, we can set the configuration parameter NUM to choose different factor numbers. We also need to change R_ROW to suit the number of factors. 
