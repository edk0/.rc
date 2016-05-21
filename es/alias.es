# Theory:
# aliases are implemented by functions that return their command expansion.
# the reason for this choice is mostly that it'd let a more advanced `alias`
# command be defined easily; it's also convenient for implementing aliases
# that expand their argument.
# When an alias is made, said function is stored in $-alias-NAME. In order to
# make it usable as a command, $fn-NAME is set to $%runalias, which simply
# looks up the alias by the name it was invoked as, and runs that.

# When an alias is defined, the (non-alias) command it replaced is stored in
# $-builtin-NAME. While an alias is running, its name is locally mapped to
# the replaced builtin.

# locally unset fn-$0 to prevent recursive expansion
%runalias = @ {
	local (fn-$0=$(-builtin-$0)) {
		<= {%expandalias $0 $*}
	}
}

# expand an alias (by running -alias-NAME)
fn %expandalias name args {
	if {! %count $name && ! %count $(-alias-$name)} {
		let (v= <= {$(-alias-$name) $args}) {
			return $v
		}
	} {
		return $name $args
	}
}

# low-level interface: make an alias out of a function that expands its args
fn %makealias name f {
	if {! result $f} {
		-alias-$name = $f
		if {! ~ $(fn-$name) $%runalias} {-builtin-$name = $(fn-$name)}
		fn-$name = $%runalias
	} {
		# special-case empty $f to unbind the command
		-alias-$name =
		-builtin-$name =
		fn-$name =
	}
	true
}

# an alias that expands the first word of its argument
# isopt and isend are predicates that by default match -* and --
# these are option detection, so we can try to expand the actual first arg
# instead of the first option.
let (
	# hack to avoid defining a self-referential closure
	isopt_d = @ x {~ $x -*};
	isend_d = @ x {~ $x --};
) fn %alias_expands isopt isend args {
	isopt = <={if {result $isopt} {result $isopt_d} {result $isopt}};
	isend = <={if {result $isend} {result $isend_d} {result $isend}};
	return @ {
		let (argslist=$args) {
			for (arg = $*) {
				if {$isend $arg} {
					argslist = ($argslist $arg)
					* = $*(2 ...)
					break
				} {$isopt $arg} {
					argslist = ($argslist $arg)
					* = $*(2 ...)
				} {
					break
				}
			}
			return $argslist <={%expandalias $*}
		}
	}
}

fn alias name args {
	if {~ $args ()} {
		%makealias $name
	} {
		%makealias $name @ { return $args $* }
	}
}
fn aliasr name args {
	if {~ $args ()} {
		%makealias $name
	} {
		%makealias $name <={%alias_expands 0 0 $args}
	}
}
