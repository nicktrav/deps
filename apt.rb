meta :apt do
  def apt_installed?(package, version)
    shell? "dpkg --compare-versions $(dpkg-query --showformat='${source:Upstream-Version}' --show #{package}) ge #{version}"
  end

  def apt_install(package, version)
    shell "apt-get -y install #{package}=#{version}", sudo: true
  end

  def apt_install_channel(package, channel)
    shell "apt-get -y install #{package} -t #{channel}", sudo: true
  end
end

dep 'debian-backports'  do
  met? { shell 'cat /etc/apt/sources.list | grep stretch-backports' }
  meet {
    shell "echo 'deb http://deb.debian.org/debian stretch-backports main' >> /etc/apt/sources.list", sudo: true
  }
  after {
    shell 'apt-get update', sudo: true
  }
end

dep 'debian-buster'  do
  met? { shell 'cat /etc/apt/sources.list | grep buster ' }
  meet {
    shell "echo 'deb http://deb.debian.org/debian buster main' >> /etc/apt/sources.list", sudo: true
  }
  after {
    shell 'apt-get update', sudo: true
  }
end
