
$confirmation = Read-Host "This will creates a 4 Node Consul cluster on gloud. Okay? [y/n]"

"`n"
if ($confirmation -eq 'y') {
    "Create new project called zardoz339 and work on it"
    gcloud projects create zardoz339 --set-as-default --enable-cloud-apis       # Assumes billing is in order. Might need manual website intervention.
    gcloud config set project zardoz339                                         # Assumes it already exists

    "Setting default zone. The private IPs that I've chosen depend on it."
    "More about IP dedicated zones: https://cloud.google.com/vpc/docs/vpc#manually_created_subnet_ip_ranges"
    "."
    gcloud config configurations activate default
    gcloud config set compute/zone europe-west6-c

    "Creating VM node1"
    gcloud compute instances create node1 --image centos-7-v20200811 --image-project centos-cloud --private-network-ip 10.172.0.21
    "Creating VM node2"
    gcloud compute instances create node2 --image centos-7-v20200811 --image-project centos-cloud --private-network-ip 10.172.0.22
    "Creating VM node3"
    gcloud compute instances create node3 --image centos-7-v20200811 --image-project centos-cloud --private-network-ip 10.172.0.23
    "Creating VM node4"
    gcloud compute instances create node4 --image centos-7-v20200811 --image-project centos-cloud --private-network-ip 10.172.0.24

    "Setting internal firewall rules"
    gcloud compute firewall-rules create allow-consul-internal --source-ranges=10.172.0.0/20 --allow tcp:8600,tcp:8500,tcp:8501,tcp:8502,tcp:8301,udp:8600,udp:8301,tcp:22
    gcloud compute firewall-rules update allow-consul-internal --source-ranges=10.172.0.0/20 --allow tcp:8600,tcp:8500,tcp:8501,tcp:8502,tcp:8301,udp:8600,udp:8301,tcp:22

    "Setting external firewall rules"
    gcloud compute firewall-rules create allow-consul-external --allow tcp:8500,tcp:8501
    gcloud compute firewall-rules update allow-consul-external --allow tcp:8500,tcp:8501

    
    gcloud compute firewall-rules create default-allow-ssh --allow tcp:22
    gcloud compute firewall-rules update default-allow-ssh --allow tcp:22

    gcloud compute firewall-rules create allow-web --allow tcp:80,tcp:443
    gcloud compute firewall-rules update allow-web --allow tcp:80,tcp:443

}

"VMs currently running on the cloud. Note the public IP for Ansible provisioning"
gcloud compute instances list

"`n"
"Done!"
"If all is well, you can now copy the public IPs and do the Ansible provisioning."
Read-Host -Prompt "Press Enter to exit"