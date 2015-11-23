# vim: et sw=3 sts=3 ft=es

# Theory:
# aliases are implemented by functions that return their command expansion.
# the reason for this choice is mostly that it'd let a more advanced `alias`
# command be defined easily; it's also convenient for implementing aliases
# that expand their argument.
# When an alias is made, said function is stored in $-alias-NAME. In order to
# make it usable as a command, $fn-NAME is set to $%runalias, which simply
# looks up the alias by the name it was invoked as, and runs that.

# locally unset fn-$0 to prevent recursive expansion
%runalias = @ { local (fn-$0=) <= {%expandalias $0 $*} }

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
   -alias-$name = $f
   fn-$name = $%runalias
   true
}

# an alias that expands the first word of its argument
# isopt and isend are predicates that by default match -* and --
# these are option detection, so we can try to expand the actual first arg
# instead of the first option.
fn %alias_expands isopt_ isend_ args {
   let (
      isopt = <={if {result $isopt_} {result @ x {~ $x -*}} {result $isopt_}};
      isend = <={if {result $isend_} {result @ x {~ $x --}} {result $isend_}};
   ) {
      return @ {
         let (argslist=$args) {
            for (arg = $*) {
               if {$isend $arg} {
                  argslist = ($argslist $arg)
                  '*' = $*(2 ...)
                  return $argslist <={%expandalias $*}
               } {$isopt $arg} {
                  argslist = ($argslist $arg)
                  '*' = $*(2 ...)
               } {
                  return $argslist <={%expandalias $*}
               }
            }
         }
      }
   }
}

fn alias name args { %makealias $name @ { return $args $* } }
fn aliasr name args { %makealias $name <={%alias_expands 0 0 $args} }
