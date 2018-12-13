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
      'git.apt',
      'ctags',
      'certigo',
      'fonts',
      'fzf',
      'go',
      'java',
      'rust',
      'shellcheck',
      'tmux',
      'curl'
    ]
  }
end
