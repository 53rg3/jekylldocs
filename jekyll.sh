#!/bin/bash

COMMIT_MESSAGE="updated"

function help() {
  cat <<EOF
Helper for running Jekyll. Usage:
$0 <option>

Options:
    -h|--help : show this help

    run       : run Jekyll locally for development. Command used:
                   "bundle exec jekyll serve --config _config_LOCAL.yml"

    build     : build for git.daimler.com. Command used:
                   "bundle exec jekyll build" (won't run the server)

    publish   : publish to GitHub. Build, add all files, commit, push to master

EOF
}

function exitWithError() {
  echo "ERROR: $1"
  exit 1
}

if [ $# -eq 0 ]; then
    exitWithError "At least 1 argument is expected. Use --help."
    exit 1
fi
while [ $# -gt 0 ]
do
    case "$1" in
        -h|--help|help)
            help
            exit
            shift
            ;;
        "run")
            bundle exec jekyll serve
            exit
            shift
            ;;
        "build")
            bundle exec jekyll build
            exit
            shift
            ;;
        "publish")
            bundle exec jekyll build
            if [ -n "$2" ]; then
              COMMIT_MESSAGE="$2"
            fi
            git add --all
            git commit -m "$COMMIT_MESSAGE"
            git push origin master
            exit
            shift
            ;;
         *)
           exitWithError "Option '$1' not recognized. Use --help."
           ;;
    esac
    shift
done

