dep 'git' do
  on :osx do
    requires 'personal:git.osx.src'
  end

  on :debian do
    requires 'personal:git.debian.apt'
  end
end

dep 'git.osx.src', :version do
  version.default!('2.20.0')
  requires 'layout.fhs'.with('/usr/local')
  met? { in_path? "git == #{version}" }
  source "https://github.com/git/git/archive/v#{version}.zip"
end

dep 'git.debian.apt', :version do
  version.default!('1:2.19.2-1~bpo9+1')
  requires 'debian-backports'
  met? { apt_installed? 'git', version }
  meet { apt_install 'git', version, 'stretch-backports' }
end
