# ADDT – Autonomous Driving Digital Twin

ADDT is an open-source **digital twin and hardware-in-the-loop (HIL) framework** for testing autonomous driving systems under **realistic faults and real-time constraints**.

The project focuses on **system-level evaluation**: how perception, planning, and control behave together when sensors or computation fail, slow down, or behave unexpectedly.

ADDT is designed to be **modular, reproducible, and research-friendly**, and can run fully in simulation or in closed loop with real embedded hardware.

---

## Features

### Digital Twin Simulation
- Built on **CARLA**
- Scenario-based simulation using **OpenSCENARIO 1.0 (XML)**
- Configurable maps, traffic, and sensor setups
- Deterministic scenario replay

### Autonomous Driving Stack Integration
- ROS-based perception–planning–control pipelines
- Supports both **modular** and **end-to-end** AD systems
- Runs on:
  - Desktop / server
  - Embedded platforms (e.g., NVIDIA Jetson)

### Sensor Fault Injection
- Camera frame drop
- Timestamp delay and jitter
- Camera shake and extrinsic perturbations
- Faults can be scheduled, parameterized, and replayed

### Compute Fault Injection
- CPU transient faults via LLFI
- GPU transient faults via NVBitFI
- Control over injection time, location, and fault type
- Suitable for fault propagation and resilience studies

### Hardware-in-the-Loop (HIL)
- Host–device split execution (simulation ↔ embedded board)
- Networked ROS communication
- Latency-aware evaluation under real hardware constraints

### Experiment & Evaluation Tools
- Scenario sweeps and fault campaigns
- Metrics such as:
  - Mission success rate
  - Collision and off-lane events
  - End-to-end latency
- Scripts to reproduce published results

---

## Repository Structure
```bash
ADDT/  
├── sim/  
│   └── CARLA integration, maps, and scenarios  
├── faults/  
│   └── Sensor and compute fault injection.  
├── ad_stack/  
│   └── Reference autonomous driving pipelines.  
├── hil/
│   └── Hardware-in-the-loop deployment and networking
```

## Prerequisites
To build ADDT, we need to depend on the following libraries:
- CUDA >= 11.0
- CUDNN >= 8.2
- TensorRT >= 8.5.0
- libprotobuf-dev == 3.6.1
- [Compute Capability](https://developer.nvidia.com/cuda-gpus#compute) >= sm_80
- Python >= 3.6

---

## What This Repository Provides
- Digital-twin simulation infrastructure  
- Fault-injection orchestration and interfaces  
- Reference AD pipelines for reproducibility  
- Experiment scripts and evaluation tools  

---

## What This Repository Does **Not** Provide
- Commercial vehicle dynamics models (e.g., CarMaker)
- Proprietary datasets or licensed assets
- Production-ready autonomous driving software

Commercial or licensed components are supported through **pluggable adapters**, but must be supplied by the user.

---

## OpenSCENARIO Support
- **Baseline:** OpenSCENARIO **1.0 (XML)**  
  - Chosen for maximum compatibility with CARLA
- Scenarios are parameterized and can be generated programmatically
- Advanced authoring formats (e.g., OpenSCENARIO 1.1 or 2.x) may be supported via exporters

---

## Intended Audience
- Autonomous driving researchers
- System safety and fault-tolerance researchers
- Embedded and real-time systems researchers
- Graduate-level coursework and benchmarking