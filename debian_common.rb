dep 'autoconf.apt', :version do
  version.default!('2.69-10')
  met? { apt_installed? 'autoconf', version }
  meet { apt_install 'autoconf', version }
end

dep 'cmake.apt', :version do
  version.default!('3.7.2-1')
  met? { apt_installed? 'cmake', version }
  meet { apt_install 'cmake', version }
end

dep 'dnsutils.apt', :version do
  version.default!('1:9.10.3.dfsg.P4-12.3+deb9u4')
  met? { apt_installed? 'dnsutils', version }
  meet { apt_install 'dnsutils', version }
end

dep 'file.apt', :version do
  version.default!('1:5.30-1+deb9u2')
  met? { apt_installed? 'file', version }
  meet { apt_install 'file', version }
end

dep 'g++.apt', :version do
  version.default!('4:6.3.0-4')
  met? { apt_installed? 'g++', version }
  meet { apt_install 'g++', version }
end

dep 'gcc.apt', :version do
  version.default!('4:6.3.0-4')
  met? { apt_installed? 'gcc', version }
  meet { apt_install 'gcc', version }
end

dep 'host.apt', :version do
  version.default!('1:9.10.3.dfsg.P4-12.3+deb9u4')
  met? { apt_installed? 'host', version }
  meet { apt_install 'host', version }
end

dep 'htop.apt', :version do
  version.default!('2.0.2-1')
  met? { apt_installed? 'htop', version }
  meet { apt_install 'htop', version }
end

dep 'libtoolize.apt' do
  met? { in_path? "libtoolize" }
  meet {
    shell 'apt-get -y install libtool', sudo: true
  }
end

dep 'make.apt', :version do
  version.default!('4.1-9.1')
  met? { apt_installed? 'make', version }
  meet { apt_install 'make', version }
end

dep 'net-tools.apt', :version do
  version.default!('1.60+git20161116.90da8a0-1')
  met? { apt_installed? 'net-tools', version }
  meet { apt_install 'net-tools', version }
end

dep 'pkg-config.apt', :version do
  version.default!('0.29-4+b1')
  met? { apt_installed? 'pkg-config', version }
  meet { apt_install 'pkg-config', version }
end

dep 'software-properties-common.apt', :version do
  version.default!('0.96.20.2-1')
  met? { apt_installed? 'software-properties-common', version }
  meet { apt_install 'software-properties-common', version }
end

dep 'tar.apt', :version do
  version.default!('1.29b-1.1')
  met? { apt_installed? 'tar', version }
  meet { apt_install 'tar', version }
end

dep 'debian-common' do
  requires 'dnsutils.apt'
  requires 'file.apt'
  requires 'gcc.apt'
  requires 'host.apt'
  requires 'htop.apt'
  requires 'make.apt'
  requires 'net-tools.apt'
  requires 'software-properties-common.apt'
  requires 'tar.apt'
end
