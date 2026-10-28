# Kubeadm Installation

#### The tool that initializes your Kubernetes cluster and configures its control plane.

##  Calico

#### The networking plugin that allows Kubernetes Pods to communicate with each other.

---

## Use to load Kernal Modules


```
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter 
EOF
```
---

- The modprobe command in Linux is a command-line utility used to intelligently load, unload, and manage kernel modules (drivers)
- **overlay** — Loads the OverlayFS (Overlay Filesystem) kernel module into the running Linux kernel.
- **br_netfilter** — The command sudo modprobe br_netfilter loads the br_netfilter kernel module into the Linux 
```
sudo modprobe overlay
sudo modprobe br_netfilter 
```
---
-  It writes runtime kernel parameters to a persistent file so they apply every time the system starts up.
```
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1 # IPv4 bridge traffic to pass through the host's firewall rules 
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1 # Containers cannot talk to other servers or external networks.
EOF

sudo sysctl --system # apple WIthout reboot
```

## Install containerd
- Systemd uses control groups (cgroups) as its core mechanism to organize, track, and restrict how system resources—such as CPU, memory, and I/O—are allocated to services and applications.
```
sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
```

```
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
sudo systemctl status containerd
```
---

### Install Require Packages for Kubeadm cluster

```
sudo apt-get update
sudo apt-get install -y ca-certificates curl gpg
```

- downloads the official Kubernetes cryptographic signing key, converts it into a binary format, and saves it to your system's trusted keyrings directory.

```
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.37/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```

```
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.37/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

- install kubelet, kubeadm and kubectl

```
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
```
- prevents the specified Kubernetes packages from being automatically updated or modified during regular system updates
```
sudo apt-mark hold kubelet kubeadm kubectl
```
```
sudo systemctl enable kubelet
```

# Stop Here, if configuring worker node use master node generrated url & stop

- the `--pod-network-cidr` flag tells kubeadm the specific range of internal IP addresses that will be assigned to every Pod running in your cluster.
```
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
```

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

#### Remove TAint from master-node 
- bY default kubeadm master node tainted

```
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
```


## Calico 
- COntrol-plan status not ready until you configure calico, after configuring calico status will change notready to ready in 2-3 minutes
```
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.33.0/manifests/tigera-operator.yaml
```
```
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.33.0/manifests/custom-resources.yaml
```


#### Join Worker Node

```
kubeadm join 172.31.27.158:6443 --token fbqfnk.kpkf4z35eek3rz2p \
        --discovery-token-ca-cert-hash sha256:e570b8c45983a84aa2795f0ca7c723ea4b1a1364ff11c214809e1e4ab8811a55
```