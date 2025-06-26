$env.config.show_banner = false
$env.config.buffer_editor = "vim"
$env.config.use_kitty_protocol = true

$env.EDITOR = 'vim'

$env.PROMPT_COMMAND = {
  let path = (pwd)
  let home = $nu.home-path
  let host = $env.HOST_DIR

  let shown = if $path == $host {
    "(HOST)"
  } else if $path == $home or ($path | str starts-with $home) {
    $"~($path | str replace $home "")"
  } else {
    $path
  }

  $"[CDN10] (ansi green_bold)($shown)(ansi reset)"
}

$env.PROMPT_INDICATOR = " -> "

alias ll = ls -ls
alias l = ls
alias v = vim

def --env mdcd [folder_path: string] {
  if not ($folder_path | path exists) {
    mkdir $folder_path
  }
  cd $folder_path
}
