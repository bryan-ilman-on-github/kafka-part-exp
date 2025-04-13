## Experiment Documentation

Based on:
[EFFICIENT TOPIC PARTITIONING OF APACHE KAFKA FOR HIGH-RELIABILITY REAL-TIME DATA STREAMING APPLICATIONS](https://www.sciencedirect.com/science/article/pii/S0167739X23004892)

#### 1. Clone the Kafka Partitioning Experiment GitHub Repository

The first step is to clone the GitHub repository for the Kafka topic partitioning experiment.

```
git clone https://github.com/bryan-ilman-on-github/kafka-part-exp.git
```

#### 2. Navigate to the Experiment Repository

Next, navigate to the newly downloaded GitHub repository and make sure the scripts have the correct execution permissions.

```
cd kafka-part-exp
chmod +x run-experiment.sh
chmod +x collect-experiment.sh
```

#### 3. Prepare Docker on the Host

Ensure that the host has Docker and Docker Compose installed. If not, follow these steps to install Docker on Ubuntu:

```
sudo apt update
sudo apt install -y docker.io docker-compose
```

After installing Docker, enable and start the Docker daemon:

```
sudo systemctl enable docker
sudo systemctl start docker
```

#### 4. Build Docker Images

Run the following commands to build the Docker images:

```
docker build -t kafka-cluster-image -f kafka-cluster-dockerfile .
docker build -t kafka-clients-image -f kafka-clients-dockerfile .
```

#### 5. Run the Experiment

Run the experiment with the following command:

```
./run-experiment.sh -n <number>
```

Replace `<number>` with the experiment number you want to run (1–4).

#### 6. Collect Experiment Results

After the experiment finishes, collect the results using the following command:

```
./collect-results.sh -n <number>
```

Replace `<number>` with the experiment number whose results you want to collect (1–4). If `<number>` is omitted, results from all experiments will be collected. A folder named “experiment-<number>” will be created containing the experiment results.
