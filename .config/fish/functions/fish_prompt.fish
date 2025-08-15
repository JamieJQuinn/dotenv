function fish_prompt
  set -l last_status $status

  set_color $fish_color_cwd
  # echo -n (basename $PWD)
  echo -n (prompt_pwd)

  set_color "#b7b7ff"

  set -l h "$(math -s 0 $CMD_DURATION/3600000)"
  set -l m "$(math -s 0 (math $CMD_DURATION%3600000)/60000)"
  set -l s "$(math -s 0 (math $CMD_DURATION%60000)/1000)"
  set -l ms "$(math -s 0 $CMD_DURATION%1000)"

  if test "$h" -gt 0
    printf " (τ=%02d:%02d:%02d.%03d)" "$h" "$m" "$s" "$ms"
  else if test "$m" -gt 0
    printf " (τ=%02d:%02d.%03d)" "$m" "$s" "$ms"
  else if test "$s" -gt 0
    printf " (τ=%02d.%03d)" "$s" "$ms"
  else if test "$ms" -gt 0
    printf " (τ=%-d)" "$ms"
  end

  if not test $last_status -eq 0
    set_color $fish_color_error
    echo -n " {$last_status}"
  end

  set_color "#f0a009"
  echo -n " λ "
  set_color normal
end
