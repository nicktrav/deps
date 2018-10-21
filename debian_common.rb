require_relative './helpers.rb'

dep 'autoconf', :version do
  version.default!('2.69-10')
  met? { apt_installed? 'autoconf', version }
  meet { apt_install 'autoconf', version }
end

# TODO(nickt): Move to own target
dep 'curl', :version do
  version.default!('7.52.1-5+deb9u7')
  met? { apt_installed? 'curl', version }
  meet { apt_install 'curl', version }
end

dep 'dnsutils', :version do
  version.default!('1:9.10.3.dfsg.P4-12.3+deb9u4')
  met? { apt_installed? 'dnsutils', version }
  meet { apt_install 'dnsutils', version }
end

dep 'file', :version do
  version.default!('1:5.30-1+deb9u2')
  met? { apt_installed? 'file', version }
  meet { apt_install 'file', version }
end

dep 'gcc', :version do
  version.default!('4:6.3.0-4')
  met? { apt_installed? 'gcc', version }
  meet { apt_install 'gcc', version }
end

dep 'host', :version do
  version.default!('1:9.10.3.dfsg.P4-12.3+deb9u4')
  met? { apt_installed? 'host', version }
  meet { apt_install 'host', version }
end

dep 'htop', :version do
  version.default!('2.0.2-1')
  met? { apt_installed? 'htop', version }
  meet { apt_install 'htop', version }
end

dep 'make', :version do
  version.default!('4.1-9.1')
  met? { apt_installed? 'make', version }
  meet { apt_install 'make', version }
end

dep 'net-tools', :version do
  version.default!('1.60+git20161116.90da8a0-1')
  met? { apt_installed? 'net-tools', version }
  meet { apt_install 'net-tools', version }
end

dep 'pkg-config', :version do
  version.default!('0.29-4+b1')
  met? { apt_installed? 'pkg-config', version }
  meet { apt_install 'pkg-config', version }
end

dep 'software-properties-common', :version do
  version.default!('0.96.20.2-1')
  met? { apt_installed? 'software-properties-common', version }
  meet { apt_install 'software-properties-common', version }
end

dep 'tar', :version do
  version.default!('1.29b-1.1')
  met? { apt_installed? 'tar', version }
  meet { apt_install 'tar', version }
end

# TODO(nickt): Move to own target
dep 'vim', :version do
  version.default!('2:8.0.0197-4+deb9u1')
  met? { apt_installed? 'vim', version }
  meet { apt_install 'vim', version }
end

dep 'debian-common' do
  requires 'curl'
  requires 'dnsutils'
  requires 'file'
  requires 'gcc'
  requires 'host'
  requires 'htop'
  requires 'make'
  requires 'net-tools'
  requires 'software-properties-common'
  requires 'tar'
  requires 'vim'
end
