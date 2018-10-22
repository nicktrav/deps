dep 'all' do
  # TODO(nickt): System update
  requires [
    'development dir',
    'dotfiles',
    'core software',
  ]
end

dep 'core software' do
  requires {
    on :debian, [
      'debian-common',
      'git.local',
      'ctags',
      'fonts',
      'fzf',
      'golang',
      'java',
      'rust',
      'shellcheck',
      'tmux'
    ]
  }
end
