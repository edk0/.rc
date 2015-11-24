highlight='#fefbec'
text='#a6a28c'
urgent='#d73737'

fn dbus-send a {
   command dbus-send $a >[2] /dev/null
}

fn net_conn {
    dbus-send --system --print-reply\=literal \
          --dest\=org.freedesktop.NetworkManager \
          /org/freedesktop/NetworkManager \
          org.freedesktop.DBus.Properties.Get \
          string:org.freedesktop.NetworkManager \
          string:PrimaryConnection \
    | sed 's/.*\s//' && echo
}

fn net_conn_id path {
    dbus-send --system --print-reply\=literal \
              --dest\=org.freedesktop.NetworkManager \
              $path \
              org.freedesktop.DBus.Properties.Get \
              string:org.freedesktop.NetworkManager.Connection.Active \
              string:Id \
    | sed 's/.*\s//' && echo
}

fn net_device path {
    dbus-send --system --print-reply\=literal \
              --dest\=org.freedesktop.NetworkManager \
              $path \
              org.freedesktop.DBus.Properties.Get \
              string:org.freedesktop.NetworkManager.Connection.Active \
              string:Devices \
    | sed '1d;s/^\s*\(\S*\)\s*]\?$/\1/'
}

fn net_device_if path {
    dbus-send --system --print-reply\=literal \
              --dest\=org.freedesktop.NetworkManager \
              $path \
              org.freedesktop.DBus.Properties.Get \
              string:org.freedesktop.NetworkManager.Device \
              string:Interface \
    | sed 's/.*\s//' && echo
}

fn net_device_ap path {
    dbus-send --system --print-reply\=literal \
              --dest\=org.freedesktop.NetworkManager \
              $path \
              org.freedesktop.DBus.Properties.Get \
              string:org.freedesktop.NetworkManager.Device.Wireless \
              string:ActiveAccessPoint \
    | sed 's/.*\s//' && echo
}

fn net_ap_signal path {
    dbus-send --system --print-reply\=literal \
              --dest\=org.freedesktop.NetworkManager \
              $path \
              org.freedesktop.DBus.Properties.Get \
              string:org.freedesktop.NetworkManager.AccessPoint \
              string:Strength \
    | sed 's/.*\s//'
}

fn net_state {
   local (conn   = `{net_conn})
   local (device = `{net_device $conn})
   local (ap     = `{net_device_ap $device}) {
      if {~ $conn '/'} {
         echo '^fg(' ^ $urgent ^ ')disconnected'
      } {~ $ap ?*} {
         echo '^fg(' ^ $text ^ ')' ^ `{net_conn_id $conn} ^ ', ^fg(' ^ $highlight ^ ')' ^ `{net_ap_signal $ap} ^ '%'
      } {
         echo '^fg(' ^ $text ^ ')wired'
      }
   }
}
