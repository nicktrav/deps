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
      'fonts',
      'fzf',
      'golang',
      'java',
      'rust',
      'shellcheck',
      'tmux',
      'openssl',
      'curl'
    ]
  }
end
