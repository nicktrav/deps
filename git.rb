dep 'git' do
  on :osx do
    requires 'personal:git.osx.src'
  end

  on :debian do
    requires 'personal:git.debian'
  end
end

dep 'git.osx.src', :version do
  version.default!('2.20.0')
  met? { in_path? "git == #{version}" }
  source "https://github.com/git/git/archive/v#{version}.zip"
end

dep 'git.debian', :version do
  version.default!('2.20.1')
  requires 'make.bin', 'autoconf.bin', 'g++.bin', 'libz.lib', 'gettext.lib', 'tar.bin', 'curl'
  met? { shell? "git --version | grep #{version}" }
  meet {
    cd '/tmp' do
      shell 'rm -rf git*'
      shell 'curl -L -o git.tar.gz https://github.com/git/git/archive/v2.20.1.tar.gz'
      shell 'tar xzf git.tar.gz'
      cd "git-#{version}" do
        shell 'make configure'
        shell './configure --prefix=/usr --without-tcltk --with-curl=/usr/local'
        shell 'make all'
        shell 'sudo make install'
      end
    end
  }
  after {
    shell 'rm -rf /tmp/git*'
  }
end
