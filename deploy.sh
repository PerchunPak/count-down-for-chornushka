#!/usr/bin/env bash
bun run build
ssh botulism 'rm -rf ~/configs/data/count-down-for-chornushka/*'
scp -r ./dist/* botulism:~/configs/data/count-down-for-chornushka
