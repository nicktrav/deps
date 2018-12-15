dep 'debian-backports'  do
  met? { shell 'cat /etc/apt/sources.list | grep stretch-backports' }
  meet {
    shell "echo 'deb http://deb.debian.org/debian stretch-backports main' >> /etc/apt/sources.list"
  }
  after {
    shell 'apt-get update', sudo: true
  }
end
