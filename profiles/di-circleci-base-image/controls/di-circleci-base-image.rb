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
    its('stdout') { should include ('libstdc++-9.2.0-r4') }
    its('stdout') { should include ('nodejs-12.15.0-r1') }
    its('stdout') { should include ('npm-12.15.0-r1') }
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

control 'snyk version' do
  impact 1.0
  title 'confirm snyk version installed'
  desc 'confirm version reported by snyk matches the desired version'
  describe command('snyk -v') do
    its('stdout') { should include ('1.321') }
  end
end
