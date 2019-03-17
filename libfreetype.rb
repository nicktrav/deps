dep 'libfreetype.debian.apt', :version do
  version.default!('2.9.1')
  requires 'debian-buster'
  met? { apt_installed? 'libfreetype6', version }
  meet { apt_install_channel 'libfreetype6', 'buster' }
end

dep 'libfreetype' do
  on :debian do
    requires 'libfreetype.debian.apt'
  end
end
