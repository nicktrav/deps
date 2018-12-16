dep 'all' do
  # TODO(nickt): System update
  requires [
    'core software',
    'deps-dir',
    'development dir',
    'dotfiles',
  ]
end

dep 'core software' do
  requires 'personal:git'
  requires 'rusty-tags.rust'
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
