#!/bin/bash

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/chasestarr/Desktop/google-cloud-sdk/path.bash.inc' ]; then source '/Users/chasestarr/Desktop/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/chasestarr/Desktop/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/chasestarr/Desktop/google-cloud-sdk/completion.bash.inc'; fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
