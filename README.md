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

- On your CE device, make sure you have enabled `USBLAN` mode by navigating to `Control Panel` > `PC Connection` > `USBLAN`. Reboot if needed.

## Uninstallation

- There are two methods of removing the USBLAN driver. These two methods should not be mixed: if one if used, the other should not be.

- The `setup.bat` script uses `DPInst` from Microsoft to pre-install the drivers required for your device. `DPInst` creates a USBLAN entry in the `Programs and Features` list. Uninstalling this program/feature will uninstall the USBLAN driver.

- Installed devices may be removed using the Device Manager program.  There is an option in the Device Manager to "remove driver software". This option will remove USBLAN and all device instances from the registry.

## Frequently Asked Questions (FAQ)

### What Datalogic devices (and firmware versions) include the driver?

Device | Firmware version required
-------|--------------------------
Falcon X3 | 2.30
Falcon X3+ | 2.30
Skorpio X3 | 2.30
Falcon X4 WEC7 | 1.20
Skorpio X4 WEC7 | 1.20

### What should happen when I plug in the device?

After reboot, with the device connected, the device should connect and use the driver you installed in Step 1. The device will show up in Windows Device Manager as "Datalogic USBLAN Adapter #1" or similar.
If you do an 'ipconfig' on your Windows 7/8 box from a command prompt, you will a new adapter similar to this:

```shell
 Ethernet adapter Local Area Connection 15:

    Connection-specific DNS Suffix  . :
    Link-local IPv6 Address . . . . . : fe80::b900:ee93:f400:5ee2%51
    IPv4 Address. . . . . . . . . . . : 169.254.1.1
    Subnet Mask . . . . . . . . . . . : 255.255.255.248
    Default Gateway . . . . . . . . . :
```

You should be able to ping the device from a cmd prompt (`ping 169.254.1.2`)
You can connect to the device using DXU by connecting to IP address `169.254.1.2`.

### Network bridging

You can install an app that acts as a proxy, for example, [Titanium Web Proxy](https://github.com/justcoding121/Titanium-Web-Proxy).

### Are there any configurable settings?

Yes, take a look at [the manual](https://doc-00-1o-docs.googleusercontent.com/docs/securesc/ckfsqjp2lcml0t8qpr5m0cpbb9tmd4qr/9luj1jja9n6pr69ljjk67p4e8ooamp15/1558036800000/09964571699406653893/04841345876767909660/0BxfiY9AWawDDLTRIRHB2blp3T1E?e=file&nonce=6jiql9klht9q8&user=04841345876767909660&hash=ob4ft0dbjia0i9gpi0r6ifgjvh84gojo) for descriptions of specific registry values.

The path to the *production* USBLAN driver registry settings is:

    \HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DatalogicUSBLAN\

### How do I remove the driver from my PC?

If the [basic uninstallation steps](#Uninstallation) don't work for you, repeat the following steps with every hardware ID (i.e. each specific device) you've used so far.

- Run Device Manager and look for your device. If you find it, right click and select "uninstall" and check the "Remove Driver Software" checkbox.
- Unplug the device and connect it again. You may find a previous edition of USBLAN matches.
- Repeat the above until the device manager reports "unknown device"
- Repeat the preceding steps for other HID's. (Cody's note: I really don't understand what this means)
- We're still not finished: connect your device to other USB ports on the PC -- make sure you get "unknown device" reported.
- Under Windows 10, there is a version on Windows Update. When the removal of local versions is complete, Windows Update will supply a new version. This can be prevented by temporarily suppressing internet access.
- For completeness, technically, the DatalogicUSBLAN folder in the registry should be removed (\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DatalogicUSBLAN\). After this the machine will need to be rebooted.

### What IP addresses do devices get?

Device connected | Windows NDIS IP address  | Device IP address
--|--|--
1st device | 169.254.1.1 | 169.254.1.2
2nd device | 169.254.1.9 | 169.254.1.10
3rd device | 169.254.1.17 | 169.254.1.18
4th device | 169.254.1.25 | 169.254.1.26
5th device | 169.254.1.33 | 169.254.1.34
6th device | 169.254.1.41 | 169.254.1.42
7th device | 169.254.1.49 | 169.254.1.50
8th device | 169.254.1.57 | 169.254.1.58



## More Information

### Driver Documentation

- [Updating USBLAN](http://usblan.belcarra.com/p/updating-usblan.html)
- [Uninstalling Driver](http://usblan.belcarra.com/p/uninstalling.html)
- [Belcarra USBLAN Manual](https://doc-00-1o-docs.googleusercontent.com/docs/securesc/ckfsqjp2lcml0t8qpr5m0cpbb9tmd4qr/9luj1jja9n6pr69ljjk67p4e8ooamp15/1558036800000/09964571699406653893/04841345876767909660/0BxfiY9AWawDDLTRIRHB2blp3T1E?e=file&nonce=6jiql9klht9q8&user=04841345876767909660&hash=ob4ft0dbjia0i9gpi0r6ifgjvh84gojo)

### Development using USBLAN driver

- [Datalogic CE Sync](https://www.nuget.org/packages/datalogic-ce-sync/) - DotNet package available via NuGet. Used to communicate over USBLAN with Datalogic Windows CE devices.

### Apps that use USBLAN

- [Device Sync](https://github.com/datalogic/device-sync) - Windows command-line app  built using Datalogic CE Sync library
- [Datalogic DXU](https://datalogic.github.io/dxu/) - Desktkop software capable of connecting to Datalogic Windows CE devices over USBLAN driver.