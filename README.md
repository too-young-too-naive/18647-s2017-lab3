# PowerDué Acoustic Sensor

This repository contains basic firmware for performing distributed, time synchronized sensing of analog channels on the PowerDué. Captured events are sent to a webserver over TCP. Additionally, Matlab scripts to post-process the captured data are also available.

## Requirements
* PowerDué Board
* [Arduino IDE](https://www.arduino.cc/en/Main/Software)
* [PowerDué Arduino Board Definitions v1.0.5+](https://github.com/cmusv/powerdue)
* [PowerDué Acoustic Scope](https://github.com/ccceeefff/powerdue-acoustic-scope)
* An analog transducer (e.g. microphone)

## Acoustic Sensor Configuration

The firmware for the acoustic sensor can easily configured in `ADCConfig.h`. The following parameters must be set properly:
* **Device and System Parameters:**
  * `DEVICE_ID` - an 8-byte character array uniquely identifying a device.
  * `WIFI_SSID` and `WIFI_PASS` - credentials to access a WiFi network.
  * `SERVER_IP` - the IP address to send captured events to.
* **Clock Synchronization Parameters:**
  * `MASTER_CLOCK` - specify whether a certain device holds the reference clock which slaves synchronize with. (`1` for master, `0` for slaves).
  * `MASTER_CLOCK_IP` - IP address of Master Clock device.
  * `SYNC_PORT` - UDP port to run time synchronization algorithms on.
  * `SYNC_FREQUENCY` - the period between synchronization attempts (in milliseconds)
  * `NTP_TASK_PRIORITY` - FreeRTOS task priority for NTP tasks to run at
* **ADC Parameters:**
  * `ADC_CHANNEL_MIC` - the ADC channel number to sample
  * `ADC_SAMPLE_RATE` - the sampling frequency of the ADC
  * `NUM_BUFFERS` - the number of DMA buffers to cycle through
  * `BUFFER_SIZE` - the number of samples per buffer 
  * `BUFFERS_TO_SEND` - the number of buffers to send for each event
* **Triggering Parameters:**
  * `WINDOW_COUNT` - the number of buffer statistics to keep around for statistically analysis
  * `MIN_WINDOW_COUNT` - the minimum number of windows to collect before triggering
  * `TRIGGER_DEFAULT_STD_DISTANCE` - the minimum std distance from the mean to detect outliers in the signal

## Post-Processing Scripts

Some Matlab scripts to post-process captured data in the `scripts/matlab` sub-directory. These scripts will be updated over time.