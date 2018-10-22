dep 'git.apt', :version do
  version.default!('1:2.11.0-3+deb9u4')
  met? { apt_installed? 'git', version }
  meet { apt_install 'git', version }
end
