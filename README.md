# ⏱ Basys 3 Timer Project

In this repository you will find my first design prject using **Verilog**, **Vivado**, and the **Basys 3 FPGA development board**.  
The project implements a stopwatch and alarm timer with a 7-segment display output and inputs controlled by buttons/switches.  
This project was also an exercise in writing **testbenches** in SystemVerilog to simulate and verify functionality.

---

## Features

- **Stopwatch Mode**
  - Counts up every second
  - Toggles on/off using a button
  - Displays time on 7-segment display

- **Alarm Timer Mode**
  - User inputs a time using switches
  - Counts down to 0
  - Displays time remaining on 7-segment display
  - An LED lights up when time expires

- **Mode Toggle**
  - A button is used to toggle between stopwatch and alarm mode
  - An LED is used to indicate the current mode ("OFF" = stopwatch, "ON" = alarm)

---

## Modules

| Module          | Description                                |
|-----------------|--------------------------------------------|
| stopwatch       | Stopwatch counter logic with button toggle |
| alarm           | Countdown alarm with input and finish flag |
| down_counter    | Handles countdown from user input          |
| sseg_control    | Drives the 7-segment display               |
| oneHz_generator | Divides 100 MHz clock to 1 Hz              |
| timer_top       | Top-level module with mode toggle          |

## Testbenches 

Testbenches were written for each module to verify the behaviour of the modules.

## Tools Used

- **Vivado Design Suite**
- **Verilog HDL & SystemVerilog**
- **Basys 3 Board (Artix-7)

## What I Learned

- Structural and behavioural Verilog design
- Clock division and timing logic
- 7-segment multiplexing
- Writing and running Verilog testbenches
- Debugging simulation and hardware behaviour





