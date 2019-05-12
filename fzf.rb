dep 'fzf', :version  do
  requires 'go.lang', 'personal:git', 'make.bin'
  version.default!('0.18.0')
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
