dep 'powerline.apt', :version do
  version.default!('2.5')
  requires 'debian-buster'
  met? { apt_installed? 'fonts-powerline', version }
  meet { apt_install_channel 'fonts-powerline', 'buster' }
end

dep 'inconsolata.apt', :version do
  version.default!('001.010')
  requires 'debian-buster'
  met? { apt_installed? 'fonts-inconsolata', version }
  meet { apt_install_channel 'fonts-inconsolata', 'buster' }
end

dep 'fonts' do
  requires 'powerline.apt'
  requires 'inconsolata.apt'
end
