dep 'libgcc.debian.apt', :version do
  version.default!('1:8.2.0')
  requires 'debian-buster'
  met? { apt_installed? 'libgcc1', version }
  meet { apt_install_channel 'libgcc1', 'buster' }
end

dep 'libgcc' do
  on :debian do
    requires 'libgcc.debian.apt'
  end
end
