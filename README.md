# LinuxPerformanceTools
<a name="top"></a>
 
# Table of Contents
1. [IncreaseSwap File Linux](#1-increaseswap-file-linux) 
    
    1.1 [Usage](#usage)

2. [Average CPU Load](#2-average-cpu-load)

    2.1 [Usage](#usage-1)


# 1. IncreaseSwap File Linux

This simple script is designed to increase the swap file size on a Linux system. It's a straightforward way to expand your system's virtual memory, particularly useful for scenarios involving memory-intensive tasks or when running low on physical memory.

## How to Use:

1. **Create a New Swap File**: Adjust based on your needs (`30G`): `fallocate -l 30G /swapfile`. 

2. **Set Permissions**: The script sets the necessary permissions to ensure that the swap file is secure.

3. **Verify the Swap Space**: Finally, the script runs `free -h` again to show the new swap space amount.

***Note:*** **After Rebooting your system everything goes back to default**

## Prerequisites:

- A Linux system with root access.
- Ensure you have enough free space on your disk for the swap file size you are setting.

## Usage:
```bash
cd LinuxPerformanceTools
chmod +x IncreaseSwap.sh
./IncreaseSwap.sh
```
[Back to Top](#top)

**Note:** The script requires your system's root password. Replace `<SYSTEM-Password>` with your actual root password in the script.

---

# 2. Average CPU Load
This script allows you to monitor the CPU load of a specific process over a defined period. Begin by identifying the process you wish to monitor. You can use the `top` command to find the name of your desired program.

### Parameters:

- `-n`: Set the name of the process to monitor. Default is 'top'.
- `-d`: Specify the duration for monitoring in seconds. Default is 60 seconds.
- `-p`: Define the interval in seconds for printing the average CPU usage. Default is 10 seconds.
- `-i`: Set the interval in seconds for reading the average CPU usage. Default is 1 second.
- `-h`: Display the help message and exit.

### Usage:

To use the script, provide the necessary arguments as shown in the example below:

```bash
cd LinuxPerformanceTools
chmod +x AvgLoadCPU.sh
./AvgLoadCPU.sh -n top -d 60 -i 1 -p 5
```
[Back to Top](#top)

This command will monitor the CPU load of the process 'top' for 60 seconds, reading the usage every 1 second and printing the average every 5 seconds.

---
