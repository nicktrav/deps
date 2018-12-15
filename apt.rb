meta :apt do
  def apt_installed?(package, version)
    shell? "dpkg -s #{package} | grep 'Version: #{version}'"
  end

  def apt_install(package, version, channel = 'stretch')
    shell "apt-get -y -t #{channel} install #{package}=#{version}", sudo: true
  end
end
