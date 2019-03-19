# USBLAN

## Overview

USBLAN for Windows allows for the simple creation and management of a USB link from a PC to a vendor device, using industry standard networking over USB protocols. When a matching device is connected, USBLAN is loaded as driver for the network function, and creates a virtual network interface, which functions like an Ethernet or wireless interface, but using the USB network link as a medium.
The USBLAN driver is provided with an easy-to-use installation kit that can be distributed as-is by  OEM’s, or, customized further as part of the installation of other software. 
For each connected device instance, USBLAN creates a layer 2 network interface. The underlying medium is a USB transfer containing one or more IEEE802.2 frames.

## Features

- **Plug and Play** - drivers are installed automatically for each device, either from a local driver store or via the Internet from Windows Update
- **Windows 10**, 8.1, 7 and XP support -  x64 and x86
- **Power Management** – The driver supports Windows power management allowing the host to enter standby, sleep and hibernation modes, and subsequently resume
- **IPv6** – Fully supported
- **IPv4** – address can be assigned via DHCP, Auto-IP or can be a static IP address
- **DHCP Service** – an optional built-in DHCP server can be used to coordinate and assign the IPv4 address of both the host and device network interfaces
- **Composite function** – USBLAN transparently supports a composite device with a network sub-function. It is only necessary to identify the matching interface (MI) value of the network sub-function.
- **HCK/HLK** – drivers are fully compliant and qualified with Microsoft Windows Hardware Certification tests and procedures
- ***Multiple devices*** – Sixteen devices may be connected simultaneously to different USB ports on the host.

## Installation

- Please read `License.txt` for the end user license agreement.

- For best results, run the `setup.bat` file BEFORE plugging your device in.

## Uninstallation

- There are two methods of removing the USBLAN driver. These two methods should not be mixed: if one if used, the other should not be.

- The `setup.bat` script uses `DPInst` from Microsoft to pre-install the drivers required for your device. `DPInst` creates a USBLAN entry in the `Programs and Features` list. Uninstalling this program/feature will uninstall the USBLAN driver.

- Installed devices may be removed using the Device Manager program.  There is an option in the Device Manager to "remove driver software". This option will remove USBLAN and all device instances from the registry.

## More Information

### Driver Documentation

- http://usblan.belcarra.com/p/updating-usblan.html
- http://usblan.belcarra.com/p/uninstalling.html


### Development using USBLAN driver

- https://www.nuget.org/packages/datalogic-ce-sync/

### Apps that use USBLAN

- https://github.com/datalogic/device-sync
- https://datalogic.github.io/dxu/