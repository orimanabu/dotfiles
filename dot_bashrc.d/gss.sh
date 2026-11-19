alias sswireshark="xpra start ssh://mori@supportshell --start-child=/usr/bin/wireshark --idle-timeout=0 --exit-with-children"
alias sslibreoffice="xpra start ssh://mori@supportshell --start-child=/usr/bin/libreoffice --idle-timeout=0 --exit-with-children"

oc500() { export KUBECONFIG=~/.kube/50-kubeconfig;  oc login -u kubeadmin -p $(cat ~/.kube/50-kubeadmin-password)  --server=https://api.50.tt.testing:6443; }
oc422() { export KUBECONFIG=~/.kube/422-kubeconfig; oc login -u kubeadmin -p $(cat ~/.kube/422-kubeadmin-password) --server=https://api.422.tt.testing:6443; }
oc421() { export KUBECONFIG=~/.kube/kubeconfig-421; oc login -u kubeadmin -p $(cat ~/.kube/kubeadmin-421-password) --server=https://api.421.tt.testing:6443; }

