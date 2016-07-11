require 'spec_helper'

describe_recipe 'ark::default' do
  context 'when no attributes are specified, on an unspecified platform' do

    let(:installed_packages) do
      %w( libtool autoconf unzip rsync make gcc autogen )
    end

    it_behaves_like 'installs packages'

    let(:packages_not_installed) do
      %w( gcc-c++ seven_zip )
    end 

    it_behaves_like 'does not install packages'

    it "apache mirror" do
      expect(attribute('apache_mirror')).to eq "http://apache.mirrors.tds.net"
    end

    it "prefix root" do
      expect(attribute('prefix_root')).to eq "/usr/local"
    end

    it "prefix bin" do
      expect(attribute('prefix_bin')).to eq "/usr/local/bin"
    end

    it "prefix home" do
      expect(attribute('prefix_home')).to eq "/usr/local"
    end

    it "tar binary" do
      expect(attribute('tar')).to eq "/bin/tar"
    end
  end

  context 'when no attributes are specified, on CentOS' do
    let(:node_attr) do
      { platform: 'centos', version: '6.7' }
    end

    let(:installed_packages) do
      %w( libtool autoconf unzip rsync make gcc xz-lzma-compat bzip2 tar )
    end

    it_behaves_like 'installs packages'
  end

  context 'when no attributes are specified, on Debian' do
    let(:node_attr) do
      { platform: 'ubuntu', platform_family: 'debian', version: '14.04' }
    end

    let(:installed_packages) do
      %w( libtool autoconf unzip rsync make gcc autogen shtool pkg-config )
    end

    it_behaves_like 'installs packages'
  end

  context 'when no attributes are specified, on FreeBSD' do
    let(:node_attr) do
      { platform: 'freebsd', platform_family: 'freebsd', version: '10.2' }
    end

    it 'installs necessary packages' do
      expect(chef_run).to install_package('libtool')
      expect(chef_run).to install_package('autoconf')
      expect(chef_run).to install_package('unzip')
      expect(chef_run).to install_package('rsync')
      expect(chef_run).to install_package('gmake')
      expect(chef_run).to install_package('gcc')
      expect(chef_run).to install_package('autogen')
      expect(chef_run).to install_package('gtar')
    end

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '/usr/bin/tar'
    end
  end

  context 'when no attributes are specified, on Mac OSX' do
    let(:node_attr) do
      { platform: 'mac_os_x', platform_family: 'mac_os_x', version: '10.11.1' }
    end

    it 'does not install packages' do
      expect(chef_run).not_to install_package('libtool')
      expect(chef_run).not_to install_package('autoconf')
      expect(chef_run).not_to install_package('unzip')
      expect(chef_run).not_to install_package('rsync')
      expect(chef_run).not_to install_package('make')
      expect(chef_run).not_to install_package('gcc')
    end

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '/usr/bin/tar'
    end
  end

  context 'when no attributes are specified, on RHEL' do
    let(:node_attr) do
      { platform: 'redhat', platform_family: 'rhel', version: '6.5' }
    end

    it 'installs necessary packages' do
      expect(chef_run).to install_package('libtool')
      expect(chef_run).to install_package('autoconf')
      expect(chef_run).to install_package('unzip')
      expect(chef_run).to install_package('rsync')
      expect(chef_run).to install_package('make')
      expect(chef_run).to install_package('gcc')
      expect(chef_run).to install_package('xz-lzma-compat')
      expect(chef_run).to install_package('bzip2')
      expect(chef_run).to install_package('tar')
    end
  end

  context 'when no attributes are specified, on SmartOS' do
    let(:node_attr) do
      { platform: 'smartos', version: '5.11' }
    end

    it 'installs necessary packages' do
      expect(chef_run).to install_package('libtool')
      expect(chef_run).to install_package('autoconf')
      expect(chef_run).to install_package('unzip')
      expect(chef_run).to install_package('rsync')
      expect(chef_run).to install_package('make')
      expect(chef_run).to install_package('gcc')
      expect(chef_run).to install_package('gtar')
      expect(chef_run).to install_package('autogen')
    end

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '/bin/gtar'
    end
  end

  context 'when no attributes are specified, on Windows' do
    let(:node_attr) do
      { platform: 'windows', version: '2012R2' }
    end

    it 'does not installs packages' do
      expect(chef_run).not_to install_package('libtool')
      expect(chef_run).not_to install_package('autoconf')
      expect(chef_run).not_to install_package('unzip')
      expect(chef_run).not_to install_package('rsync')
      expect(chef_run).not_to install_package('make')
      expect(chef_run).not_to install_package('gmake')
      expect(chef_run).not_to install_package('gcc')
      expect(chef_run).not_to install_package('autogen')
      expect(chef_run).not_to install_package('xz-lzma-compat')
      expect(chef_run).not_to install_package('bzip2')
      expect(chef_run).not_to install_package('tar')
    end

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '"\7-zip\7z.exe"'
    end
  end
end
