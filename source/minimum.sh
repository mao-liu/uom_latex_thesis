#!/bin/bash

file=$1
f_stem=${file%\.tex}
f_stem=${f_stem/\//\\\/}
f_base=`basename $file`
f_base_stem=${f_base%\.tex}

if [ ! -e $f_base ]; then
    echo "[ $0 ] : Compiling $f_base_stem"
    sed -e "s/@file/${f_stem}/g" minimum.tex.template > ${f_base} && \
        make ${f_base} && \
        cp ${f_base_stem}.pdf ${f_base_stem}-view.pdf && \
        latexmk -c -silent ${f_base} && \
        rm ${f_base} ${f_base_stem}.pdf
else
    echo "${f_base} already exists in the root directory. Nothing done."
fi
