require 'spec_helper'

describe 'ssh' do

  it { should contain_package('openssh-server') }

  it do
    should contain_file('/etc/ssh/sshd_config') \
      .with_ensure('present') \
      .with_owner('root') \
      .with_group('root') \
      .with_mode('0644') \
      .with_require('Package[openssh-server]')
  end

  it do
    should contain_service('sshd') \
      .with_ensure('running') \
      .with_enable(true) \
      .with_hasstatus(true) \
      .with_hasrestart(true) \
      .with_subscribe('File[/etc/ssh/sshd_config]')
  end
end
