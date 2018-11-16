dep 'java', :version, :patch  do
  requires 'curl', 'tar.apt'
  met? { shell? "java -version 2>&1 | grep 11.0.1" }
  meet {
    url="https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz"
    shell <<-HERE
      cd /tmp && rm -rf java* openjdk* && \
      curl -L -o java.tar.gz #{url} && \
      sudo tar xzf java.tar.gz -C /var/lib && \
      sudo ln -s /var/lib/jdk-11.0.1/bin/java /usr/local/bin/java && \
      rm -rf java* openjdk*
    HERE
  }
end
