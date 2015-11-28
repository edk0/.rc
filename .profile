# ~/.profile: executed by the command interpreter for login shells.
#umask 022

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -f "$HOME/.esrc" ]; then
    eval "`es -l <<x
        sh <<<'export -p'
x`"
fi
