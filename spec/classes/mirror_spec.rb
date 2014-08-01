require 'spec_helper'
describe 'apt::mirror', :type => :class do
  let(:file_mirror) { '/etc/apt/mirror.list' }
  let(:facts) { { :lsbdistid => 'Debian'  } }

  it { should contain_package("apt-mirror").with_ensure('present') }
end
