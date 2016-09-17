# things we want to run at the beginning of each session.
# close over status because i don't really want to expose it...

fn %sessionrc {
	if {result $#ES_SESSION} {
		ES_SESSION = 1
		noexport = ($noexport ES_SESSION)
		prompt_prefix = $^ES_PROMPT
	}

	GPG_TTY = `tty
	. <{cat ~/.gnupg/gpg-agent-info ~/.gnupg/gpg-agent-info-* >[2] /dev/null}

	let (status=) {
		fn %dispatch cmd {
			let (pwd=`` \n {pwd >[2] /dev/null}; cw=<={~~ $cmd \{*\}}) {
				# While we're running a command, set the xterm title to
				# PWD - command args
				echo -n \e]\;^$pwd^' - '^$cw^\a
			}
			let (result = <={$cmd}) {
				local(r2=) if {~ $result *[~0-9-]*} {
					# Replace whitespace with visible characters.
					for (rr = $result) {
						rr = `` '' {sed -z 's,\n,'^\e^'[34m\\n'^\e^'[0m,g'<<<$rr}
						rr = `` '' {sed -z 's,\t,'^\e^'[34m\\t'^\e^'[0m,g'<<<$rr}
						rr = `` '' {sed -z 's, ,'^\e^'[34m_'^\e^'[0m,g'<<<$rr}
						r2 = $r2 $rr
					}
					echo \e[31m^'# '^\e[0m^$^r2
					result =
				}
				status = $result
			}
		}

		let (host=`hostname;uid=`{id -u};user=`whoami) {
			fn %prompt {
				if {result $#ES_SESSION} {
					%sessionrc
					%prompt
					return
				}
				let (pwd=`` \n {pwd >[2] /dev/null; true}) {
					if {~ $pwd ()} {
						echo \e[31m^'# current directory disappeared!'^\e[0m
					} {
						echo -n \e]\;^$pwd^\a
					}
					if {! result $SSH_CONNECTION} {
						echo \e[34m^'# '^$host^\e[0m
					}
					if {! result $status} {
						ES_PROMPT=\001\e[31m\002^';'^\001\e[0m\002
					} {~ $uid 0} {
						ES_PROMPT=\001\e[30m\e[41m\002^';'^\001\e[0m\002
					} {%outdated_env} {
						ES_PROMPT=\001\e[30m\e[43m\002^';'^\001\e[0m\002
					} {! ~ $VIRTUAL_ENV ()} {
						ES_PROMPT=\001\e[34m\002^';'^\001\e[0m\002
					} {
						ES_PROMPT=';'
					}
					ES_PROMPT = $prompt_prefix ^ $ES_PROMPT
					prompt = ($ES_PROMPT ^ ' ' '')
					status =
				}
			}
		}
	}
}
