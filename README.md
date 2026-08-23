# Basys3_7_Segment_1_Second_Counter
A 1-second counter using 7-segment display on Basys3 FPGA board. Built with Vivado and Verilog.

A **4-digit 7-segment counter** implementation for the **Digilent Basys 3** FPGA board. The counter increments every second from `0000` to `9999` and rolls over back to `0000`. This project is designed for **Xilinx Vivado 2023.x** and is ideal for beginners learning FPGA basics such as clock division, counter design, and 7-segment multiplexing.

# Project Overview

This project demonstrates how to:
- Use the **100 MHz on-board clock** to generate a **1-second tick**
- Implement a **4-digit BCD counter** (units, tens, hundreds, thousands)
- Drive a **4-digit 7-segment display** using **time-division multiplexing**
- Handle **active-low reset** via the center button (BTNC)

The design is fully synthesizable and can be programmed onto the Basys 3 board using Vivado.

---

##  Features

- Accurate 1-second counting** (100 MHz → 1 Hz)
- 4-digit 7-segment display** with multiplexing (refresh rate ~763 Hz)
- BCD counter** with rollover from `9999` to `0000`
- Active-low reset** via center button (BTNC)
- Synthesizable and tested on Vivado 2023.x**

---

## Software Requirements

| Software | Version |
|----------|---------|
| **Xilinx Vivado** | 2023.1 or newer (2023.2 recommended) |
| **Digilent Adept** | 2.x (for USB drivers) |
| **Operating System** | Windows 10/11, Linux (Ubuntu 20.04+), or macOS |

---

## Hardware Requirements

| Component | Description |
|-----------|-------------|
| **FPGA Board** | Digilent Basys 3 (Artix-7 XC7A35T) |
| **Clock** | 100 MHz on-board oscillator |
| **Display** | 4-digit 7-segment (common anode, active-low) |
| **Reset** | Center button (BTNC) |
| **USB Cable** | Micro-USB for programming and power |

---
# 7-Segment Multiplexing
The four digits are displayed using time-division multiplexing.
The refresh counter selects one digit at a time at ~763 Hz, making all digits appear continuously lit to the human eye.

# References & Acknowledgements
Digilent Basys 3 Reference Manual
Xilinx Vivado Documentation
FPGA4Student.com – 7-Segment tutorials

## 📸 Project Demo

![Uploading Demo_2026-08-24.jpg…]()
*7-segment display showing the counter value.*

#📜 License
This project is licensed under the MIT License – feel free to use, modify, and distribute.

#📬 Contact & Support
GitHub Issues: Report a bug or request a feature
Email: kyawzinthant7627@gmail.com
