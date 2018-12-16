dep 'dnsutils.apt', :version do
  version.default!('1:9.10.3.dfsg.P4-12.3+deb9u4')
  met? { apt_installed? 'dnsutils', version }
  meet { apt_install 'dnsutils', version }
end
