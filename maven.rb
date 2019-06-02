dep 'maven', :version  do
  requires 'curl', 'dotfiles', 'java'
  version.default!('3.6.1')
  met? { login_shell "mvn --version | grep #{version}" }
  meet {
    url="https://archive.apache.org/dist/maven/maven-3/#{version}/binaries/apache-maven-#{version}-bin.tar.gz"
    tarball='maven.tar.gz'
    install_dir='/usr/local/src/maven'
    # TODO(nickt): verify the sig
    cd '/tmp' do
      shell "curl -L -o #{tarball} #{url}"
      shell "mkdir -p #{install_dir}"
      shell "tar xzf #{tarball} -C #{install_dir} --strip 1"
      shell "ln -s #{install_dir}/bin/mvn /usr/local/bin/mvn"
    end
  }
  after {
    shell 'rm -rf /tmp/maven*'
  }
end
