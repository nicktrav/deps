dep 'maven', :version  do
  requires 'curl'
  version.default!('3.6.0')
  met? { shell? "mvn --version | grep #{version}" }
  meet {
    url="https://archive.apache.org/dist/maven/maven-3/#{version}/binaries/apache-maven-#{version}-bin.tar.gz"
    tarball='maven.tar.gz'
    install_dir='/usr/local/src/maven'
    # TODO(nickt): verify the sig
    cd '/tmp' do
      shell "curl -L -o #{tarball} #{url}"
      shell "mkdir -p #{install_dir}", sudo: true
      shell "tar xzf #{tarball} -C #{install_dir} --strip 1", sudo: true
      shell "ln -s #{install_dir}/bin/mvn /usr/local/bin/mvn", sudo: true
    end
  }
  after {
    shell 'rm -rf /tmp/maven*'
  }
end
