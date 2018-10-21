dep 'ripgrep', :version do
  requires 'cargo', 'git.local', 
  version.default!('0.8.1')
  met? { in_path? "rg >= #{version}" }
  meet {
    shell <<-HERE
      rm -rf /tmp/ripgrep && \
      git clone https://github.com/BurntSushi/ripgrep.git /tmp/ripgrep && \
      cd /tmp/ripgrep && git checkout #{version} && \
      cargo build --release && \
      sudo cp ./target/release/rg /usr/local/bin/ && \
      rm -rf /tmp/ripgrep
    HERE
  }
end
