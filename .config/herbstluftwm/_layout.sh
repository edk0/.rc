if [ "$(herbstclient attr 'tags.by-name.1.client_count')" -ge 1 ]; then
  no_tag_1=1
else
  herbstclient load 1 '(split horizontal:0.500000:1 (clients vertical:0) (split vertical:0.500000:1 (clients vertical:0) (clients vertical:0)))'
fi

if [ "$(herbstclient attr 'tags.by-name.2.client_count')" -ge 1 ]; then
  no_tag_2=1
else
  herbstclient load 2 '(clients vertical:0)'
fi

if [ "$(herbstclient attr 'tags.by-name.3.client_count')" -ge 1 ]; then
  no_tag_3=1
else
  herbstclient load 3 '(split horizontal:0.500000:0 (split vertical:0.500000:0 (clients vertical:0) (clients vertical:0)) (split vertical:0.500000:0 (clients vertical:0) (clients vertical:0)))'
fi

if [ "$(herbstclient attr 'tags.by-name.4.client_count')" -ge 1 ]; then
  no_tag_4=1
else
  herbstclient load 4 '(clients vertical:0)'
fi

if [ "$(herbstclient attr 'tags.by-name.5.client_count')" -ge 1 ]; then
  no_tag_5=1
else
  herbstclient load 5 '(clients vertical:0)'
fi

if [ "$(herbstclient attr 'tags.by-name.6.client_count')" -ge 1 ]; then
  no_tag_6=1
else
  herbstclient load 6 '(clients vertical:0)'
fi

if [ "$(herbstclient attr 'tags.by-name.7.client_count')" -ge 1 ]; then
  no_tag_7=1
else
  herbstclient load 7 '(clients vertical:0)'
fi

if [ "$(herbstclient attr 'tags.by-name.8.client_count')" -ge 1 ]; then
  no_tag_8=1
else
  herbstclient load 8 '(clients vertical:0)'
fi

if [ "$(herbstclient attr 'tags.by-name.9.client_count')" -ge 1 ]; then
  no_tag_9=1
else
  herbstclient load 9 '(clients vertical:0)'
fi

# class=mpv instance=linkplayer
if [ -z "$no_tag_1" ]; then
  herbstclient rule once maxage=20 class=mpv instance=linkplayer tag=1 index=10
  nohup mpv --x11-name=linkplayer --idle=yes --force-window=yes '--input-ipc-server=~/.mpv' '--input-conf=~/.config/mpv/linkplayer.input.conf' null:// >/dev/null 2>&1 &
fi

# class=URxvt instance=urxvt-irc
if [ -z "$no_tag_1" ]; then
  herbstclient rule once maxage=20 class=URxvt instance=urxvt-irc tag=1 index=11
  nohup urxvt -cd /home/edk -name urxvt-irc -e mosh vimes -- tmux attach -t irc >/dev/null 2>&1 &
fi

# class=Firefox instance=Navigator
if [ -z "$no_tag_2" ]; then
  herbstclient rule once maxage=20 class=Firefox instance=Navigator tag=2 index=
  nohup /usr/lib/firefox/firefox >/dev/null 2>&1 &
fi

# class=URxvt instance=urxvt
herbstclient --idle | while read hook name extra; do
  if [ "$hook" != rule ]; then continue; fi
  case "$name" in
    _reactor1_hook0)
      if [ -z "$no_tag_3" ]; then
        herbstclient rule once maxage=20 class=URxvt instance=urxvt tag=3 index=00 hook=_reactor1_hook1
        nohup urxvt -cd /home/edk >/dev/null 2>&1 &
      else
        herbstclient emit_hook rule _reactor1_hook1
      fi
    ;;
    _reactor1_hook1)
      if [ -z "$no_tag_3" ]; then
        herbstclient rule once maxage=20 class=URxvt instance=urxvt tag=3 index=01 hook=_reactor1_hook2
        nohup urxvt -cd /home/edk >/dev/null 2>&1 &
      else
        herbstclient emit_hook rule _reactor1_hook2
      fi
    ;;
    _reactor1_hook2)
      if [ -z "$no_tag_3" ]; then
        herbstclient rule once maxage=20 class=URxvt instance=urxvt tag=3 index=10 hook=_reactor1_hook3
        nohup urxvt -cd /home/edk >/dev/null 2>&1 &
      else
        herbstclient emit_hook rule _reactor1_hook3
      fi
    ;;
    _reactor1_hook3)
      if [ -z "$no_tag_3" ]; then
        herbstclient rule once maxage=20 class=URxvt instance=urxvt tag=3 index=11
        nohup urxvt -cd /home/edk >/dev/null 2>&1 &
      fi
      break
    ;;
  esac
done &
if [ -z "$no_tag_1" ]; then
  herbstclient rule once maxage=20 class=URxvt instance=urxvt tag=1 index=0 hook=_reactor1_hook0
  nohup urxvt -cd /home/edk >/dev/null 2>&1 &
else
  herbstclient emit_hook rule _reactor1_hook0
fi
