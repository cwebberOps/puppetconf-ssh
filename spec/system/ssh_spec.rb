require 'spec_helper_system'

describe 'ssh' do

  it 'class should converge' do
    pp = <<-EOS
      class { 'ssh': }
    EOS

    puppet_apply(pp) do |r|
      r.exit_code.should_not == 1
      r.refresh
      r.exit_code.should be_zero
    end
  end

  describe service('sshd') do
      it { should be_enabled }
      it { should be_running }
  end
end
