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
