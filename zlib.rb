dep 'zlib.debian.apt', :version do
  version.default!('1.2.11')
  requires 'debian-buster'
  met? { apt_installed? 'zlib1g', version }
  meet { apt_install_channel 'zlib1g', 'buster' }
end

dep 'zlib' do
  on :debian do
    requires 'zlib.debian.apt'
  end
end

