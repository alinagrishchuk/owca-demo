# encoding: utf-8
# copyright: 2018, The Authors

control 'GuineaPig-01' do
  impact 1.0
  title 'Login Banners'
  desc 'Guinea Pig Systems must display a login banner notifying users that only authorized use is permitted.'

  describe command('run-parts /etc/update-motd.d') do
    its(:stdout) { should include 'Guinea Pig Systems' }
    its(:stdout) { should include 'AUTHORIZED USE ONLY' }

    its(:stdout) { should_not include '* Documentation:' }
    its(:stdout) { should_not include '* Management:' }
    its(:stdout) { should_not include '* Support:' }
    its(:stdout) { should_not include 'Get cloud support'}
  end
end

include_controls 'linux-baseline' do
  skip_control 'os-08'
  skip_control 'package-08'
end