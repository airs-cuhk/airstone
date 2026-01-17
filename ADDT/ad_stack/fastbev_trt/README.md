# FastBEV (TensorRT) as a System-Under-Test in ADDT

This module integrates **FastBEV** into the **ADDT (Autonomous Driving Digital Twin)** framework as a **perception System-Under-Test (SUT)**.  
It provides a CUDA- and TensorRT-based inference pipeline for multi-camera BEV perception, enabling **closed-loop, hardware-in-the-loop (HIL)** evaluation under sensor- and system-level perturbations.

The implementation is adapted from the original FastBEV project and refactored to support ADDT’s goals of **repeatable benchmarking**, **fault injection**, and **end-to-end system evaluation**.

---

## Role in ADDT

Within ADDT, FastBEV serves as:

- A **camera-based BEV perception module**
- A **drop-in perception SUT** for:
  - Sensor fault injection (e.g., frame drops, camera noise, miscalibration)
  - Timing and latency analysis
  - End-to-end failure propagation studies
- A reference perception backbone for comparison against alternative BEV or end-to-end models

The output of this module feeds downstream **planning and control stacks** within ADDT’s digital-twin and HIL pipelines.

---

## Evaluated Task

### 3D Object Detection (nuScenes Validation Set)

- **Configuration**: `fastbev_m0_r18_s256x704_v200x200x4_c192_d2_f1.py`
- **Temporal modeling**: disabled (single-frame inference)
- **Input**:
  - 6 surround-view cameras
  - Resolution: **256 × 704**
- **Backbone**:
  - **ResNet-18**
  - No DCN

### Reference Performance (Baseline)

| Model      | Runtime Backend | Precision | mAP | FPS |
|------------|-----------------|-----------|-----|-----|
| ResNet-18  | TensorRT        | FP16      | 24.3 | 113.6 (RTX 2080 Ti) |

> These numbers are provided as **reference baselines**.  
> In ADDT, performance is typically re-evaluated under **faulted conditions**, different hardware platforms, and closed-loop workloads.

---

## Model and Example Data

For reproducibility and rapid validation, ADDT provides **example nuScenes-format inputs**, including:

- 6-camera RGB images
- Camera–LiDAR extrinsics
- View transformation tensors required by FastBEV

Example data structure:
```bash
example-data/
├── 0-FRONT.jpg
├── 1-FRONT_RIGHT.jpg
├── …
├── example-data.pth
├── x.tensor
├── y.tensor
└── valid_c_idx.tensor
```
Pre-exported FastBEV models (ONNX / TensorRT-ready) are used strictly for **inference and system evaluation** inside ADDT.

---

## Dependencies

The FastBEV SUT depends on the following system libraries:

- CUDA ≥ 11.0  
- cuDNN ≥ 8.2  
- TensorRT ≥ 8.5  
- libprotobuf-dev == 3.6.1  
- NVIDIA GPU with Compute Capability ≥ sm_80  
- Python ≥ 3.6  

> Reference measurements were collected on **NVIDIA Orin**, using TensorRT 8.6, CUDA 11.4, and cuDNN 8.6.  
> ADDT supports re-running the same SUT across different hardware targets for comparative analysis.

---

## Integration Workflow in ADDT

### 1. Prepare Models and Example Data

Place FastBEV assets under the ADDT perception stack directory:
```bash
ad_stack/fastbev_trt/
├── model/
├── example-data/
├── src/
├── tool/
└── CMakeLists.txt
```
Unpack provided models and example inputs before running experiments.

---

### 2. Environment Configuration

Set up CUDA, TensorRT, and cuDNN paths via the ADDT environment configuration:

```bash
export TensorRT_Lib=/path/to/TensorRT/lib
export TensorRT_Inc=/path/to/TensorRT/include
export TensorRT_Bin=/path/to/TensorRT/bin

export CUDA_HOME=/path/to/cuda
export CUDA_Lib=/path/to/cuda/lib64
export CUDA_Inc=/path/to/cuda/include
export CUDA_Bin=/path/to/cuda/bin

export CUDNN_Lib=/path/to/cudnn/lib
```

### 3. Build and Run (Standalone Perception Test)

This section describes how to build and execute the FastBEV perception module **in isolation**, outside the full ADDT closed-loop pipeline.  
Standalone execution is intended for **sanity checking**, **performance profiling**, and **debugging** prior to integration with planning, control, or fault-injection components.

---

#### 3.1 Build TensorRT Engines:

Convert the exported ONNX models into TensorRT engines optimized for the target GPU:

```bash
bash tool/build_trt_engine.sh
```

####	3.2	Compile and execute FastBEV inference:
```bash
bash tool/run.sh
```

In full ADDT experiments, this step is invoked programmatically as part of a larger closed-loop simulation.

## Usage in Fault-Injection Studies

When used inside ADDT, FastBEV can be evaluated under:

- Camera-level perturbations (noise, blur, dropouts)
- Timing variations and latency stress
- Sensor misalignment and calibration errors
- Closed-loop safety metrics (e.g., mission success, infractions)

FastBEV thus acts as a controlled, well-understood perception SUT for studying how perception failures propagate through planning and control.