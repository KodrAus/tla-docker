#!/bin/bash

set -o errexit -o nounset

OPTIND=1
JAVA_OPTS="-XX:+IgnoreUnrecognizedVMOptions -XX:+UseParallelGC"

function dobuild () {
    java $JAVA_OPTS -cp /opt/TLA+Toolbox/tla2tools.jar pcal.trans "$args"
    java $JAVA_OPTS -cp /opt/TLA+Toolbox/tla2tools.jar tla2sany.SANY "$args"
}

function docheck () {
    java $JAVA_OPTS -cp /opt/TLA+Toolbox/tla2tools.jar tlc2.TLC "$args"
}

function doeval () {
    tmpfile=$(mktemp)
    echo "$args" > $tmpfile

    java $JAVA_OPTS -cp /opt/TLA+Toolbox/tla2tools.jar tlc2.TraceExplorer -expressionsFile $tmpfile -replBis
}

if [ -z "${1:-}" ]; then
    kind=""
    args=""
else
    kind=$1
    args=${@:2}
fi

case "$kind" in
    build)
        dobuild

        exit 0;;
    check)
        if [ "${2:-}" == "--build" ]; then
            args=${@:3}
            dobuild
        fi

        docheck

        exit 0;;
    eval)
        doeval

        exit 0;;
    *)
        echo "Interface to TLA+"
        echo
        echo "build ARGS"
        echo "runs PlusCal translation and checks with the semantic model checker"
        echo
        echo "check [--build] ARGS"
        echo "runs the TLA+ model checker"
        echo
        echo "eval EXPR"
        echo "evaluates an inline expression"
        echo
        exit 0;;
esac
