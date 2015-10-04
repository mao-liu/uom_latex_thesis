#!/bin/bash

chapters_tex=`find chapters -name '*.tex'`
all_tex=`find . -name '*.tex' -or -name '*.bib' | grep -v recycle_bin`

if [[ $1 == "main" ]]; then
    echo "Automatically recompiling main-view.pdf"
    echo -e "Dependencies:\n${all_tex/ /\r}"
    MAKE_MAIN="true"
else
    echo "Automatically recompiling chapters"
    echo -e "Dependencies:\n${chapters_tex/ /\r}"
    MAKE_MAIN=""
fi

touch .last_compile

while true; do
    sleep 1

    changed="false"

    if [[ $MAKE_MAIN == "true" ]]; then
        # update the main view

        for f in $all_tex; do
            if [[ $f -nt .last_compile ]]; then
                changed="true"
                break
            fi
        done

        if [[ $changed == "true" ]]; then
            make main
        fi

    else
        # only update chapter views that have changed
        for f in $chapters_tex; do
            if [[ $f -nt .last_compile ]]; then
                changed="true"
                target=`basename $f`
                target=${target%.tex}
                make $target
            fi
        done
    fi

    if [[ $changed == "true" ]]; then
        touch .last_compile
    fi
done
