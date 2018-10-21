require_relative 'helpers.rb'

dep 'fonts-powerline', :version do
  version.default!('2.5-1.1')
  met? { apt_installed? 'fonts-powerline', version }
  meet { apt_install 'fonts-powerline', version }
end

dep 'fonts-inconsolata', :version do
  version.default!('001.010-5')
  met? { apt_installed? 'fonts-inconsolata', version }
  meet { apt_install 'fonts-inconsolata', version }
end

dep 'fonts' do
  requires 'fonts-powerline'
  requires 'fonts-inconsolata'
end
