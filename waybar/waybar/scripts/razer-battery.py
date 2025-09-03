#!/usr/bin/python3

from openrazer.client import DeviceManager

device_manager = DeviceManager()

mouse = None
for  device in device_manager.devices:
    if "Razer DeathAdder V3 HyperSpeed (Wireless)" == device.name:
        mouse = device

if None == mouse:
    exit

print(mouse.battery_level)
