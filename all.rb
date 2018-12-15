dep 'all' do
  # TODO(nickt): System update
  requires [
    'development dir',
    'dotfiles',
    'core software',
  ]
end

dep 'core software' do
  requires 'personal:git'
  requires {
    on :debian, [
      'debian-backports',
      'debian-common',
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
