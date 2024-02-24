
#!/bin/bash
# LC_NUMERIC="C"
# Usage: ./AvgLoadCPU.sh -n top -d 60 -i 1 -p 5
# Default values
process_name="top"
duration=60
print_interval=10
interval=1

# Function to display help message
show_help() {
  echo "Usage: $0 [-n process_name] [-d duration] [-p print_interval] [-i interval] [-h]"
  echo
  echo "Options:"
  echo "  -n  Set the process name to monitor (default: 'top')"
  echo "  -d  Set the duration for monitoring in seconds (default: 60)"
  echo "  -p  Set the interval in seconds at which to print the average CPU usage (default: 10)"
  echo "  -i  Set the interval in seconds at which to read the average CPU usage (default: 1)"
  echo "  -h  Display this help message and exit"
  echo
  exit 1
}

# Parse command-line options
while getopts 'n:d:p:i:h' flag; do
  case "${flag}" in
    n) process_name="${OPTARG}" ;;
    d) duration="${OPTARG}" ;;
    p) print_interval="${OPTARG}" ;;
    i) interval="${OPTARG}" ;;
    h) show_help ;;
    *) show_help ;;
  esac
done

# Interval for checking CPU usage

# Initialize variables
total_cpu=0
count=0
print_count=0
temp_cpu=0

# End time calculation
end_time=$((SECONDS + duration))

# Monitoring loop
while [ $SECONDS -lt $end_time ]; do
    # Get the CPU usage of the process using top
    cpu_usage=$(top -b -n 1 -p $(pgrep -d',' $process_name) | awk '{print $9}' | awk '/%CPU/{getline; print $1}')
    
    cpu_usage=${cpu_usage:-0}

    # Check if cpu_usage is not empty
    if [ ! -z "$cpu_usage" ]; then
        # Sum up the CPU usage of all instances
        total_process_cpu=0
        for usage in $cpu_usage; do
            total_process_cpu=$(echo "$total_process_cpu + $usage" | bc)
        done

        # Add to total_cpu for overall average
        total_cpu=$(echo "$total_cpu + $total_process_cpu" | bc)
        # Increment count
        ((count++))

        # Add to temp_cpu for interval average
        temp_cpu=$(echo "$temp_cpu + $total_process_cpu" | bc)
        ((print_count++))
    fi

    # Print average CPU usage at specified intervals
    if [ $print_count -eq $print_interval ]; then
        avg_cpu=$(echo "$temp_cpu / $print_count" | bc -l)
        printf "Process '%s' - Average CPU Usage for last %d seconds: %.2f%%\n" $process_name $print_interval $avg_cpu
        temp_cpu=0
        print_count=0
    fi

    # Wait for the specified interval
    sleep $interval
done

# Calculate and print the overall average CPU usage
if [ $count -gt 0 ]; then
    average_cpu=$(echo "$total_cpu / $count" | bc -l)
    printf "Process '%s' - Total Average CPU Usage: %.2f%%\n" $process_name $average_cpu
else
    echo "Process '$process_name' not found."
fi