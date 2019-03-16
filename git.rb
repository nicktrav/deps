dep 'git' do
  on :osx do
    requires 'personal:git.osx.src'
  end

  on :debian do
    requires 'personal:git.debian.backports'
  end
end

dep 'git.osx.src', :version do
  version.default!('2.20.0')
  met? { in_path? "git == #{version}" }
  source "https://github.com/git/git/archive/v#{version}.zip"
end

dep 'git.debian.backports', :version do
  version.default!('2.20.1')
  requires 'debian-backports'
  met? { in_path? "git >= #{version}" }
  meet { apt_install 'git' }
end
