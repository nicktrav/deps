meta :gcloud do
  def dir
    '~/google-cloud-sdk'
  end
end

dep 'dir.gcloud' do
  met? { dir.p.exists? }
  meet {
    shell "mkdir #{dir}"
  }
end

dep 'google-cloud-sdk.gcloud', :version do
  version.default!('253.0.0')
  requires 'curl', 'dir.gcloud', 'tar.bin'

  url_base="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads"
  url=''
  on :debian do
    url="#{url_base}/google-cloud-sdk-#{version}-linux-x86_64.tar.gz"
  end
  on :osx do
    url="#{url_base}/google-cloud-sdk-#{version}-darwin-x86_64.tar.gz"
  end

  met? { login_shell "gcloud --version | grep #{version}" }
  meet {
    cd dir do
      shell "curl -o google-cloud-sdk.tar.gz -L #{url}"
      shell 'tar xzf google-cloud-sdk.tar.gz --strip 1'
    end
  }
  after {
    shell "rm -rf #{dir}/google-cloud-sdk.tar.gz"
  }
end

dep 'google-cloud-sdk', :version do
  requires 'google-cloud-sdk.gcloud'
end
