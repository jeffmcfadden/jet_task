#!/bin/bash

# TODO: Use a command withing jt to export the code to eval

# Define a function to generate completions
_jt_completions() {
  local cur prev cmd
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  cmd="${COMP_WORDS[0]}"

  # Call `jt get_completions` and pass in the current word and context
  # The jt script will handle figuring out what completions to offer
  COMPREPLY=( $(jt get_completions "$cmd" "$prev" "$cur") )
}

# Register the completions function
complete -F _jt_completions jt