dep 'dnsutils.apt', :version do
  version.default!('9.11.5')
  met? { apt_installed? 'dnsutils', version }
  meet { apt_install_channel 'dnsutils', 'buster' }
end
