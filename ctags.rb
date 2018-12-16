dep 'ctags.osx', :version do
  version.default!('5.8')
  met? { shell? "ctags --version | grep #{version}" }
  meet {
    shell 'brew install --HEAD universal-ctags/universal-ctags/universal-ctags'
  }
end

dep 'ctags.debian', :version  do
  version.default!('9d32534c')
  requires 'autoconf.bin', 'g++.bin', 'make.bin', 'personal:git', 'pkg-config.bin'
  #met? { in_path? "ctags >= #{version}" }
  met? { shell? "ctags --version | grep #{version}" }
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

dep 'ctags' do
  on :osx do
    requires 'ctags.osx'
  end
  on :debian do
    requires 'ctags.debian'
  end
end
