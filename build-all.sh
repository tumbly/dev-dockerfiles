#!/bin/bash

# Retrieve current directory
DIR="$( cd "$( dirname "$0" )" && pwd )"

function build()
{
    # Look for a Dockerfile in the directory
    for FILENAME in $1/*;
    do
        BASENAME=${FILENAME##*/}
        if [ -f "$FILENAME" ]
        then
            if [[ ${BASENAME} == "Dockerfile" ]]
            then
                IMAGENAME=${1##*/}
                echo "###############################################"
                echo "#                                             #"
                echo "# Build docker image \"$IMAGENAME\""
                echo "#                                             #"
                echo "###############################################"
                CMD="docker build -t alexisno/$IMAGENAME-dev $1"
                echo ">> $CMD"

                ${CMD}
                RETCODE=$?
                if [ ${RETCODE} != 0 ];
                then
                    printf "Error : [$RETCODE] when building image '$IMAGENAME'"
                    exit ${RETCODE}
                fi

                #docker push alexisno/${IMAGENAME}
                #RET_CODE=$?
                #if [ ${RETCODE} != 0 ];
                #then
                #    printf "Error : [$RETCODE] when pushing image '$IMAGENAME'"
                #    exit ${RETCODE}
                #fi
            fi
        fi
    done

    # Look for a "children" directory
    if [ -d "$1/children" ]
    then
        echo "Children exists"
        for FILENAME in $1/children/*;
        do
            build "$FILENAME"
        done
    fi
}
build "$DIR/ubuntu"
