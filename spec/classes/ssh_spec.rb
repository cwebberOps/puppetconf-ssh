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

  it do
    should contain_file('/etc/ssh/sshd_config') \
      .with_content(%r{^MaxStartups 10$})
  end

  context "maxstartups => 40" do

    let (:params) {{ :maxstartups => 40 }}

    it do
      should contain_file('/etc/ssh/sshd_config') \
        .with_content(%r{^MaxStartups 40$})
    end

  end

  context "InfoSec Requirements" do

    it do
      should contain_file('/etc/ssh/sshd_config') \
        .with_content(%r{^PermitRootLogin no$})
    end

    it do
      should contain_file('/etc/ssh/sshd_config') \
        .with_content(%r{^X11Forwarding no$})
    end

  end

end
