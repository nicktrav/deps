dep 'ctags', :version  do
  version.default!('64f7d619')
  requires 'autoconf.bin', 'g++.bin', 'make.bin', 'personal:git', 'pkg-config.bin'
  met? { in_path? "ctags >= #{version}" }
  before {
    shell 'rm -rf /tmp/ctags'
  }
  meet {
    shell 'mkdir /tmp/ctags'
    cd '/tmp/ctags' do
      shell 'git clone https://github.com/universal-ctags/ctags.git .'
      shell "git checkout #{version}"
      shell './autogen.sh'
      shell './configure'
      shell 'make'
      # TODO(nickt): update this to not use sudo
      shell 'make install', sudo: true
    end
  }
  after {
    shell 'rm -rf /tmp/ctags'
  }
end
