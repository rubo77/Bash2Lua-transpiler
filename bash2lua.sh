#!/bin/bash

# this scripts needs a bash file as input argument
# that file will be converted into Lua source

# first write out some defautl Lua header:
# here a useful example to convert gluon shell scripts:
cat << EOF
#!/usr/bin/lua

local uci = require("simple-uci").cursor()
local util = require 'gluon.util'

-- return_value is optional to return the exit code of the shell command instead of the output
function shell_exec(command, return_value)
  if return_value then
    return os.execute(command .. ' &> /dev/null')
  end
  -- maybe use util.exec() instead, which does not use assert()
  local file = assert(io.popen(command, 'r'))
  local output = file:read('*all')
  file:close()
  return output
end

function logger(m)
  shell_exec('logger -s -t "gluon-offline-ssid" -p 5 "' .. m .. '"')
end
EOF

sed 's/fi$/end/;' $1 |\
sed 's/if \[/if/g' |\
sed 's/\]; then/then/g' |\
sed 's/-eq/==/g' |\
sed 's/-lt/</g' |\
sed 's/-gt/>/g' |\
sed 's/-ge/>=/g' |\
sed 's/ \] || \[ / or /g' |\
sed 's/if \(.*\) = /if \1 == /g' |\
sed -E 's/\$\{#([^\}]*?)\}/String.length(\1)/g' |\
sed -E 's/(\s*)#+\s*/\1-- /g' |\
sed -E 's/echo ([^"]+)/print("\1")/g' |\
sed -E 's/echo (.+)$/print(\1)/g' |\
sed -E 's/"\$\(\((.*?)\)\)"/\1/g' |\
sed -E 's/\$\(\((.*?)\)\)/\1/g' |\
sed -E 's/"([^\$]*)\$(\w+)([^"]*)"/"\1" .. \2 .. "\3"/g' |\
sed -E 's/"([^\$]*)\$(\w+)([^"]*)"/"\1" .. \2 .. "\3"/g' |\
sed -E 's/"([^\$]*)\$(\w+)([^"]*)"/"\1" .. \2 .. "\3"/g' |\
sed -E 's/"([^\$]*)\$(\w+)([^"]*)"/"\1" .. \2 .. "\3"/g' |\
sed -E 's/"([^\$]*)\$(\w+)([^"]*)"/"\1" .. \2 .. "\3"/g' |\
sed -E 's/"([^\$]*)\$(\w+)([^"]*)"/"\1" .. \2 .. "\3"/g' |\
sed -E 's/"([^\$]*)\$(\w+)([^"]*)"/"\1" .. \2 .. "\3"/g' |\
sed -E 's/"([^\$]*)\$(\w+)([^"]*)"/"\1" .. \2 .. "\3"/g' |\
sed -E 's/ .. ""//g' |\
sed -E 's/"" .. //g' |\
sed -E 's/\$(\w+)/\1/g' |\
sed -E 's@-- !/bin/.*$@@g' |\
cat
# fi
# if
# then
# == 
# < 
# > 
# >= 
# if =
# comments
# echo->print
# $(())
# variables autside "" 
# repeat
# repeat
# repeat
# repeat
# repeat
# variables inside "" 
