#!/bin/sh

find . -type f -exec sh -c '
    for pathname do
        pathname=$( basename "$pathname" )
        printf "%s\n" "${pathname%.*}"
    done' sh {} +
