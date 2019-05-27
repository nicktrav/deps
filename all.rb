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
      'alacritty',
      'ctags',
      'certigo',
      'curl',
      'fzf',
      'go',
      'google-cloud-sdk',
      'java',
      'maven',
      'personal:git',
      'protoc',
      'ripgrep',
      'rust',
      'rusty-tags.rust',
      'shellcheck',
      'tmux',
      'vim',
  ]
  requires {
    on :debian, [
      'debian-backports',
      'debian-buster',
      'debian-common',
      'fonts',
    ]
  }
end
