#!/bin/bash

set -e
set -o pipefail

echo "Translating test sentences"
cat test-sentences-spa.txt | apertium -d .. spa-glg > test-sentences-spa-glg.txt

echo "Checking for differences"
git diff --exit-code
