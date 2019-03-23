dep 'git' do
  on :osx do
    requires 'personal:git.osx.bin'
  end

  on :debian do
    requires 'personal:git.debian.apt'
  end
end

dep 'git.osx.bin', :version do
  version.default!('2.20.0')
  provides "git >= #{version}"
  installs {
    via :brew, 'git'
  }
end

dep 'git.debian.apt', :version do
  version.default!('2.20.1')
  requires 'debian-backports'
  met? { in_path? "git >= #{version}" }
  meet { apt_install_channel 'git', 'stretch-backports' }
end
