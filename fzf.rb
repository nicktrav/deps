dep 'fzf', :version  do
  requires 'golang', 'git.local', 'make'
  version.default!('0.17.4')
  met? { in_path? "fzf >= #{version}" }
  meet {
    shell <<-HERE
      rm -rf /tmp/fzf && \
      git clone https://github.com/junegunn/fzf.git /tmp/fzf && \
      cd /tmp/fzf && git fetch -t && git checkout #{version} && \
      make && make install && \
      sudo cp bin/fzf /usr/local/bin/ && \
      rm -rf /tmp/fzf
    HERE
  }
end
