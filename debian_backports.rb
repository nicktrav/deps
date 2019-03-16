dep 'debian-backports'  do
  met? { shell 'cat /etc/apt/sources.list | grep stretch-backports' }
  meet {
    shell "echo 'deb http://deb.debian.org/debian stretch-backports main' >> /etc/apt/sources.list", sudo: true
  }
  after {
    shell 'apt-get update', sudo: true
  }
end

meta :backports do
  def apt_install(package, version = nil)
    package_str = version.nil? ? package : "#{package}=#{version}"
    shell "apt-get -y -t stretch-backports install #{package_str}", sudo: true
  end
end
