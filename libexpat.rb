dep 'libexpat.debian.apt', :version do
  version.default!('2.2.5')
  requires 'debian-buster'
  met? { apt_installed? 'libexpat1', version }
  meet { apt_install_channel 'libexpat1', 'buster' }
end

dep 'libexpat' do
  on :debian do
    requires 'libexpat.debian.apt'
  end
end
