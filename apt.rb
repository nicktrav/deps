meta :apt do
  def apt_installed?(package, version)
    shell? "apt-cache policy #{package} | grep 'Installed: #{version}'"
  end

  def apt_install(package, version)
    shell "apt-get -y install #{package}=#{version}", sudo: true
  end
end
