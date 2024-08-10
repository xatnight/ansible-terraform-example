# Ansible

All my ansible stuff is only run against Ubuntu/Debian thus I cannot say if this runs on non Debian based distros.

## What is this

Small collection of roles I use for all my VMs. In the real setup they are also hosted on gitlab and installed via ansible galaxy when the pipeline runs but here they are just local.

### user

Setup my default personalized user with ssh keys and password and configure sshd. Also cleans up the packer user used to install the VM template.

### ufw

Install and configure ufw on the host. The ufw role has three main dictionaries: `ufw_default` `ufw_host` and `ufw_group`. These three are merged together in the end, this way you can define some defaults ports (for example 22, ssh), add ports to ansible groups (webservers, 80 and 443) or on individual hosts (for example 27017 on a mongodb host).

### rke2

Install and setup rke2 either as a single host or as a cluster (currently dedicated worker nodes are not supported thus all nodes are master+worker). Ansible fetches the generated kubeconfig and saves it locally to use with kubectl or terraform.
