#!/bin/bash

# Function to display help message.
show_help() {
    echo "Usage: $0 -n <number (1-4)>"
    echo ""
    echo "Options:"
    echo "  -n, --number <number>   Set the number (1-4) to select the experiment."
    echo "  -h, --help              Display this help message."
    echo ""
    echo "Description:"
    echo "This script sets up and runs a Kafka cluster and a Kafka client in Docker containers, "
    echo "then executes a specific experiment based on the provided number (1-4)."
}

# Check if no parameters are provided.
if [ "$#" -eq 0 ]; then
    show_help
    exit 1
fi

# Parse input parameters.
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -n|--number)
            PARAM=$2
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Invalid option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Validate that the parameter is a number between 1 and 4.
if [[ ! "$PARAM" =~ ^[1-4]$ ]]; then
    echo "Error: Parameter must be a number between 1 and 4 inclusive."
    exit 1
fi

# Define image names.
KAFKA_CLUSTER_IMAGE="kafka-cluster-image"
KAFKA_CLIENTS_IMAGE="kafka-clients-image"

# Stop and remove existing containers.
docker stop kafka-cluster kafka-clients 2>/dev/null
docker rm kafka-cluster kafka-clients 2>/dev/null

# Run Kafka cluster container.
docker run --privileged -d --name kafka-cluster \
    -p 2222:22 \
    $(for port in {19091..19250}; do echo -p $port:$port; done) \
    $KAFKA_CLUSTER_IMAGE

# Run Kafka clients container.
docker run -d --name kafka-clients $KAFKA_CLIENTS_IMAGE

# Wait for the kafka-cluster container to be fully started.
sleep 24

# Get the IP address of the host.
HOST_IP=$(hostname -I | awk '{print $1}')

# Check if IP was retrieved.
if [ -z "$HOST_IP" ]; then
  echo "Failed to get IP address of host."
  exit 1
fi

echo "Host IP: $HOST_IP."

# Define the experiment directory and log file.
EXPERIMENT_DIR="./kafka-hdd/experiments/$(printf '%03d' $PARAM)"
LOG_FILE="${EXPERIMENT_DIR}/$(printf '%03d' $PARAM).log"

# Remove existing log file if it exists, then create a new one.
rm -f "$LOG_FILE"
touch "$LOG_FILE"

# Execute commands inside the kafka-clients container and log output.
docker exec kafka-clients bash -c "
  cd /home/ubuntu &&
  eval \$(ssh-agent) &&
  ssh-add /home/ubuntu/newkey &&
  cd /home/ubuntu/kafka-hdd &&
  export KAFKA_DIR=\$PWD/kafka_2.13-3.4.1 &&
  export REMOTEHOST=$HOST_IP &&
  ./scripts/check_reqs.sh &&
  cd experiments &&
  cd $(printf '%03d' $PARAM) &&
  date &&
  ./run.sh &&
  date &&
  [ $PARAM -eq 1 ] || [ $PARAM -eq 2 ] && ./post.sh

  echo 'Experiment complete.'

  # Set locale inside Docker container.
  echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen &&
  export LANG=en_US.UTF-8 &&
  dpkg-reconfigure locales &&

  # Generate plots using gnuplot.
  cd graphs
  for plt_file in *.plt; do
      base_name=\$(basename \"\$plt_file\" .plt)
      gnuplot -e \"set terminal png; set output '../\${base_name}.png'; load '\$plt_file'\"
      echo \"\${base_name}.png generated.\"
  done
" | tee -a "$LOG_FILE"
