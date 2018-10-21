dep 'java', :version  do
  requires 'curl', 'tar'
  version.default!('10')
  met? { shell? "java -version 2>&1 | grep #{version}" }
  meet {
      url="https://download.java.net/java/GA/jdk#{version}/#{version}/binaries/openjdk-#{version}_linux-x64_bin.tar.gz"
    shell <<-HERE
      cd /tmp && rm -rf java* openjdk* && \
      curl -L -o java.tar.gz #{url} && \
      sudo tar xzf java.tar.gz -C /var/lib && \
      sudo ln -s /var/lib/jdk-10/bin/java /usr/local/bin/java && \
      rm -rf java* openjdk*
    HERE
  }
end
