#!/bin/bash

# Update & Install Dependencies
sudo apt-get update -y
sudo apt-get install -y wget curl unzip tar

# ------------------------------
# PROMETHEUS SETUP
# ------------------------------
PROM_VERSION="2.52.0"

# Create user and directories
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir -p /etc/prometheus /var/lib/prometheus

# Download and extract
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz
tar xvf prometheus-${PROM_VERSION}.linux-amd64.tar.gz

# Move binaries
sudo cp prometheus-${PROM_VERSION}.linux-amd64/prometheus /usr/local/bin/
sudo cp prometheus-${PROM_VERSION}.linux-amd64/promtool /usr/local/bin/

# Move config and consoles
sudo cp -r prometheus-${PROM_VERSION}.linux-amd64/consoles /etc/prometheus/
sudo cp -r prometheus-${PROM_VERSION}.linux-amd64/console_libraries /etc/prometheus/
sudo cp prometheus-${PROM_VERSION}.linux-amd64/prometheus.yml /etc/prometheus/

# Set permissions
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus /usr/local/bin/prometheus /usr/local/bin/promtool

# Create Prometheus systemd service
cat <<EOF | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
ExecStart=/usr/local/bin/prometheus \\
  --config.file=/etc/prometheus/prometheus.yml \\
  --storage.tsdb.path=/var/lib/prometheus \\
  --web.console.templates=/etc/prometheus/consoles \\
  --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=default.target
EOF

# Start Prometheus
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

# ------------------------------
# NODE EXPORTER SETUP
# ------------------------------
NODE_EXPORTER_VERSION="1.8.1"

sudo useradd --no-create-home --shell /bin/false node_exporter

cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
tar xvf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
sudo cp node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

# Create systemd service
cat <<EOF | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# ------------------------------
# GRAFANA SETUP
# ------------------------------
sudo apt-get install -y apt-transport-https software-properties-common
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

sudo apt-get update -y
sudo apt-get install -y grafana

sudo systemctl daemon-reexec
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

# ------------------------------
# FIREWALL & COMPLETION
# ------------------------------
echo "Prometheus:  http://<your-ec2-ip>:9090"
echo "Node Exporter: http://<your-ec2-ip>:9100"
echo "Grafana: http://<your-ec2-ip>:3000 (admin/admin)"
