#!/bin/bash

# this scripts needs a bash file as input argument
# that file will be converted into Lua source

sed 's/fi$/end/;' $1 |\
sed 's/if \[/if/g' |\
sed 's/\]; then/then/g' |\
sed 's/-eq/==/g' |\
sed 's/if \(.*\) = /if \1 == /g' |\
sed 's/\(\s*\)#\s*/\1-- /g' |\
cat
