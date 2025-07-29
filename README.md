# VeggieVision Firmware

A Nerves-based firmware project for monitoring soil moisture using a Raspberry Pi Zero 2W and LM393 Soil Hygrometer Moisture Sensor.

## Overview

VeggieVision is an embedded Elixir application built with the Nerves framework that continuously monitors soil moisture levels using an LM393 Soil Hygrometer Moisture Sensor. The project runs on a Raspberry Pi Zero 2W and communicates with the sensor via I2C protocol.

## Hardware Components

- **Board**: Raspberry Pi Zero 2W
- **Sensor**: LM393 Soil Hygrometer Moisture Sensor (Analog Output)
- **Communication**: I2C protocol
- **I2C Address**: 0x2
- **I2C Bus**: i2c-1

## Software Stack

- **Framework**: Nerves Project
- **Language**: Elixir
- **I2C Library**: Circuits.I2C
- **Architecture**: Supervisor pattern for process management

## Project Structure

```
veggie_vision_firmware/
├── README.md
└── veggie_vision.ex
```

## Code Overview

The main module `VeggieVision` implements:

- **Supervisor Pattern**: Manages the I2C communication process
- **Continuous Monitoring**: Reads sensor data every 1000ms (1 second)
- **Error Handling**: Graceful handling of I2C bus failures
- **Data Processing**: Reads 2 bytes from the sensor and processes the moisture data

### Key Features

- Automatic I2C bus initialization
- Continuous soil moisture monitoring
- Error logging for I2C communication issues
- Supervisor-based process management for reliability

## Usage

The firmware automatically starts when deployed to the Raspberry Pi Zero 2W. The sensor readings are printed to the console and can be integrated with additional data processing or logging systems.

## Sensor Integration

The LM393 Soil Hygrometer Moisture Sensor provides analog output that is read through the I2C interface. The sensor detects soil moisture levels and provides continuous monitoring capabilities for agricultural or gardening applications.

## Development

This project is designed for embedded applications using the Nerves framework, providing a robust and reliable solution for soil moisture monitoring in IoT applications.
