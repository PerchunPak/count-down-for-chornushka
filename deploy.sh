#!/usr/bin/env bash
bun run build
ssh botulism 'rm -rf ~/configs/data/h4folks/*'
scp -r ./dist/* botulism:~/configs/data/h4folks
