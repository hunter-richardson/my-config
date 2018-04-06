#!/usr/bin/fish

function parse_ms -d 'calculate seconds, minutes, hours from milliseconds'
  builtin printf '%u:%u:%u.%u' (math -- (math -- $argv[1] / 3600000) % 24) (math -- (math -- $argv[1] / 60000) \% 60) (math -- (math -- $argv[1] / 1000) \% 60) (math -- $argv[1] \% 1000)
end

