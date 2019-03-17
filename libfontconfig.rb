dep 'libfontconfig.debian.apt', :version do
  version.default!('2.12.6')
  requires 'debian-buster'
  met? { apt_installed? 'libfontconfig1', version }
  meet { apt_install_channel 'libfontconfig1', 'buster' }
end

dep 'libfontconfig' do
  on :debian do
    requires 'libfontconfig.debian.apt'
  end
end
