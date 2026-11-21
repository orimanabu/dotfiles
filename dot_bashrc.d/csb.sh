###
### for GSS
###

alias sswireshark="xpra start ssh://mori@supportshell --start-child=/usr/bin/wireshark --idle-timeout=0 --exit-with-children"
alias sslibreoffice="xpra start ssh://mori@supportshell --start-child=/usr/bin/libreoffice --idle-timeout=0 --exit-with-children"

oc500() { export KUBECONFIG=~/.kube/50-kubeconfig;  oc login -u kubeadmin -p $(cat ~/.kube/50-kubeadmin-password)  --server=https://api.50.tt.testing:6443; }
oc422() { export KUBECONFIG=~/.kube/422-kubeconfig; oc login -u kubeadmin -p $(cat ~/.kube/422-kubeadmin-password) --server=https://api.422.tt.testing:6443; }
oc421() { export KUBECONFIG=~/.kube/kubeconfig-421; oc login -u kubeadmin -p $(cat ~/.kube/kubeadmin-421-password) --server=https://api.421.tt.testing:6443; }

###
### for AI
###

function unset_virtex {
	export CLAUDE_CODE_USE_VERTEX=
	export CLOUD_ML_REGION=
	export ANTHROPIC_VERTEX_PROJECT_ID=
}

export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION=global
#export ANTHROPIC_VERTEX_PROJECT_ID=itpc-gcp-global-revenue-claude
#export ANTHROPIC_VERTEX_PROJECT_ID=itpc-gcp-xe-eng-claude
export ANTHROPIC_VERTEX_PROJECT_ID=itpc-ca-8a647ee312

[ -f "/home/mori/.config/claude-code-vertex/env.sh" ] && . "/home/mori/.config/claude-code-vertex/env.sh"
