dep 'all' do
  # TODO(nickt): System update
  requires 'layout.fhs'.with('/usr/local')
  requires [
    'core software',
    'deps-dir',
    'development dir',
    'dotfiles',
  ]
end

dep 'core software' do
  requires [
      'ctags',
      'certigo',
      'curl',
      'fzf',
      'go',
      'java',
      'maven',
      'personal:git',
      'protoc',
      'ripgrep',
      'rust',
      'rusty-tags.rust',
      'shellcheck',
      'tmux',
  ]
  requires {
    on :debian, [
      'debian-backports',
      'debian-common',
      'fonts',
    ]
  }
end
