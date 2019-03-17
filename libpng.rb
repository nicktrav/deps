dep 'libpng.debian.apt', :version do
  version.default!('1.6.34')
  requires 'debian-buster'
  met? { apt_installed? 'libpng16-16', version }
  meet { apt_install_channel 'libpng16-16', 'buster' }
end

dep 'libpng' do
  on :debian do
    requires 'libpng.debian.apt'
  end
end
