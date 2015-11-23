# things we want to run at the beginning of each session.
# close over status because i don't really want to expose it...

let (status=) {
   fn dispatch-error cmd {
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

   fn %prompt {
      let (pwd=`` \n {pwd >[2] /dev/null; true}) {
         fn-%dispatch = $fn-dispatch-error

         if {~ $pwd ()} {
            echo \e[31m^'# current directory disappeared!'^\e[0m
         } {
            # Set xterm title to PWD
            echo -n \e]\;^$pwd^\a
         }
         if {result $status} {
            prompt=('; ' '')
         } {
            prompt=(\001\e[31m\002^'; '^\001\e[0m\002 '')
         }
         status =
      }
   }
}
