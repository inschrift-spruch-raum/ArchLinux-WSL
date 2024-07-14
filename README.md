# ArchLinux-WSL Builder for Windows 11
**ArchLinux-WSL** is a PowerShell script that sets up a mostly-vanilla Arch Linux environment for Windows Subsystem for Linux, using the latest 'bootstrap' distribution package from Arch mirrors, along with some quality-of-life improvements.

## Prerequisites
PowerShell 5 or above is required.
**A Linux installation must be already present in WSL prior to execution. Currently, this installation must be Ubuntu.** (will be changed in the future)

## Usage
0. Clone this repository.
1. Run `GrantPower.ps1` **in an elevated PowerShell**. This allows elevated execution for unsigned scripts, which is required for ArchLinux-WSL to function. 
2. Run `Structure.ps1`. This script contains the main installation logic.

## Notes
This script is not initially intended for public disclosure.

Hence, as of now, this script will install a fixed set of additional packages, along with preset configuration files.

This behavior is currently **not configurable**. This will be changed in the future with introduction of support for configuration files or command-line arguments.

## License
ArchLinux-WSL is licensed under the Expat (MIT) license.
```
Copyright (c) 2024- inschrift.spruch.raum and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software?', to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ?AS IS?, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
