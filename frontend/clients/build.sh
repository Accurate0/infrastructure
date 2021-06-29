#!/usr/bin/env sh

for dir in $(find . -maxdepth 1 ! -path . -type d); do
    (cd "$dir" && yarn && yarn prod) &
done

wait
