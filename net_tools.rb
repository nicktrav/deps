dep 'net-tools', :version do
  met? { shell? 'dpkg -s net-tools' }
  meet {
    shell 'apt-get install net-tools', sudo: true
  }
end
