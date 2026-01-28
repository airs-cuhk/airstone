ORB Extractor and Matcher (Verilog)
==================================

A high-performance hardware accelerator for ORB feature extraction 
and matching based on FPGA.

1. Key Modules
-----------------
- FAST Feature Detection: Includes orientation calculation for rotation invariance.
- Descriptor Generation: Hardware-based BRIEF descriptor construction.
- Feature Matching: High-speed matching unit for feature correspondences.
- Boundary Extension: Handling image borders for robust processing.
- Scale Recovery: Mapping features across different pyramid levels back to 
  the original scale.

2. Core Verilog Files
---------------------
- ORB Feature Extraction: Primary module. Provided in three versions, 
  choose the one that best fits your requirements:
    * ORBExtractor.v 
    * ORBExtractor_L1.v 
    * ORBExtractor_hc18.v 

- Feature Matching:
    * SAD.v (Sum of Absolute Differences logic)
    * Searchbyband.v (Band-based search acceleration)

- Top Module: 
    * top.v (Designed for easy switching between extraction versions)

3. Key Parameters
-----------------
- Pyramid Scaling Factor: 1.2x
- Image A Dimensions: 640 x 480 (Extends to 678 x 518 after boundary processing)
- Image B Dimensions: 533 x 400 (Extends to 571 x 438 after boundary processing)

4. Others
---------
- Simulation: To run simulations, please prepare your own input image data 
  for both left and right cameras, as well as the descriptor coordinate 
  templates (bit-pattern masks).

==================================
