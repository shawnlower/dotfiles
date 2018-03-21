################################################################################
#!/bin/bash
#
# Bash function to start working on a project
#
# Assumes projects are rooted under $PROJ_DIR
# Running 'pj proj_foo' will do the following:
# - Export 'PJ_NAME=proj_foo'
# - cd $PJ_DIR/proj_foo
# - source any $PJ_DIR/.pj/common.sh
# - source any $PJ_DIR/$PJ_NAME/.pj_init.sh scripts
#
################################################################################
# Example .pj_init.sh:
#     cd rest-app.git
#     
#     activate=./venv/bin/activate
#     if [[ -z "$VIRTUAL_ENV" ]]; then
#       source venv/bin/activate
#     fi
#
#     git status
#
################################################################################


export PJ_DIR=~/projects/

# This script is used to modify our current environment, so
# fail if we're called as a subshell.
if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
    echo "ERROR: This script must be sourced." >&2
    usage
    exit 1
fi

function pj(){
    if [[ $# -ne 1 ]]; then
        usage
        return 1
    fi

    export PJ_NAME=$1

    dir=${PJ_DIR}/${PJ_NAME}
    if [[ ! -d "$dir" ]]; then
        echo "Missing project dir: $dir"
        return 1
    fi

    cd $dir
    for pj_init in "$PJ_DIR/.pj/common.sh" "$dir/.pj_init.sh"; do
        if [[ -f $pj_init ]]; then
            echo "Found project script: $pj_init" >&2
            source $pj_init
        fi
    done
}

function usage(){
  echo "pj: Start work on a project." >&2
  echo "Usage: pj my_project" >&2
}
