control 'packages' do
  impact 1.0
  title 'confirm package installation'
  desc 'confirm all desired packages are installed'
  describe command('apk -v info') do
    its('stdout') { should include ('bash-5.0.11-r1') }
    its('stdout') { should include ('curl-7.67.0-r0') }
    its('stdout') { should include ('openssl-1.1.1g-r0') }
    its('stdout') { should include ('gnupg-2.2.19-r0') }
    its('stdout') { should include ('docker-19.03.5-r1') }
    its('stdout') { should include ('openrc-0.42.1-r2') }
    its('stdout') { should include ('gcc-9.2.0-r4') }
    its('stdout') { should include ('g++-9.2.0-r4') }
    its('stdout') { should include ('python3-3.8.2-r0') }
    its('stdout') { should include ('build-base-0.5-r1') }
    its('stdout') { should include ('musl-dev-1.1.24-r2') }
    its('stdout') { should include ('libc-dev-0.7.2-r0') }
    its('stdout') { should include ('libffi-dev-3.2.1-r6') }
    its('stdout') { should include ('openssl-dev-1.1.1g-r0') }
    its('stdout') { should include ('python3-dev-3.8.2-r0') }
    its('stdout') { should include ('make-4.2.1-r2') }
    its('stdout') { should include ('jq-1.6_rc1-r1') }
  end
end

control 'docker version' do
  impact 1.0
  title 'confirm docker version installed'
  desc 'confirm version reported by docker matches the desired version'
  describe command('docker version') do
    its('stdout') { should include ('19.03.5') }
  end
end

control 'secrethub version' do
  impact 1.0
  title 'confirm secrethub version installed'
  desc 'confirm version reported by secrethub matches the desired version'
  describe command('secrethub --version') do
    its('stderr') { should include ('0.38') }
  end
end
