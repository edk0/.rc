# Talk to UPower about our battery.

hilight='#fefbec'
text='#a6a28c'
urgent='#d73737'


bat = `{upower -e|grep '/battery'|head -1}
sep = ', '

fn bat_prop prop {
   upower -i $bat | sed -r 's,\s+([^:]+):\s+(.*),\1=\2,;t;d' | grep -F $prop\= | cut -f2 -d\=
}

fn bat_dbus prop {
	dbus-send --system --type\=method_call \
	          --dest\=org.freedesktop.UPower \
	          $bat \
	          org.freedesktop.UPower.Device.Refresh
	dbus-send --system --print-reply\=literal \
	          --dest\=org.freedesktop.UPower \
	          $bat \
	          org.freedesktop.DBus.Properties.Get \
	          string:org.freedesktop.UPower.Device string:$prop \
	| sed 's/.*\s//'
}

fn ftime {
   date -u -d \@^(`` '' cat) +%H:%M
}

fn power {
   state = `{bat_prop state}
   pct   = `{bat_dbus percentage}
   if {~ $state fully-charged} {
	   echo -n '^fg(' ^ $text ^ ')ac' ^ $sep ^ '^fg(' ^ $hilight ^ ')' ^ $pct ^ '%^fg( ^ ' ^ $text ^ ')'
   } {~ $state charging} {
	   echo -n '^fg(' ^ $text ^ ')ac' ^ $sep ^ '^fg(' ^ $hilight ^ ')' ^ $pct ^ '%^fg( ^ ' ^ $text ^ ')' ^\
	           $sep ^ `{bat_dbus TimeToFull|ftime}
   } {~ $state discharging} {
      local (tte = `{bat_dbus TimeToEmpty}) \
      local (colour = <={ if {[ $tte -le 1200 ]} {result $urgent} {result $text} }) {
	      echo -n '^fg(' ^ $text ^ 'battery' ^ $sep ^ '^fg(' ^ $hilight ^ ')' ^ $pct ^ '%^fg( ' ^ $text ^ ')' ^\
	              $sep ^ '^fg(' ^ $colour ^ ')' ^ `{echo $tte|ftime}
	   }
   } {
      echo -n 'error'
   }
   rate = `{bat_dbus EnergyRate}
   if {! ~ $state fully-charged} {
      echo '^fg(' ^ $text ^ ')' ^ $sep ^ `{printf '%0.1fW' $rate}
   } {
      echo
   }
}
