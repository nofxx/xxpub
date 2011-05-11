#
# Shared functions
#
#

# Easy log to STDOUT
log = (all...) ->
  for txt in all
    console.log txt

log "Hey"