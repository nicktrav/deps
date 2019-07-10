dep 'helm', :version do
  version.default!('2.14.0')
  requires 'curl', 'tar.bin'

  url_base="https://storage.googleapis.com/kubernetes-helm"
  url=''
  platform=''
  on :debian do
    platform='linux-amd64'
    url="#{url_base}/helm-v#{version}-#{platform}.tar.gz"
  end
  on :osx do
    platform='darwin-amd64'
    url="#{url_base}/helm-v#{version}-#{platform}.tar.gz"
  end

  met? { login_shell "helm version -c | grep #{version}" }
  meet {
    tarball='helm.tar.gz'
    # TODO(nickt): verify the sig
    cd '/tmp' do
      shell "curl -L -o #{tarball} #{url}"
      on :debian do
        shell "tar xzf #{tarball} #{platform}/helm --strip 1"
      end
      on :osx do
        shell "tar xzf #{tarball} --strip-components 1 #{platform}/helm"
      end
      shell "mv -f helm /usr/local/bin/helm"
    end
  }
  after {
    shell 'rm -rf /tmp/helm*'
  }
end
