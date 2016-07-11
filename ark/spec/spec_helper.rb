require 'chefspec'
require 'chefspec/berkshelf'

at_exit { ChefSpec::Coverage.report! }

RSpec.configure do |config|
  config.color = true
  config.log_level = :info
  config.alias_example_group_to :describe_recipe, type: :recipe
end

shared_context 'converge recipe', type: :recipe do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(node_attr)
    runner.converge(described_recipe)
  end

  let(:node_attr) do
    {}
  end

  let(:node) do
    chef_run.node
  end

  def attribute(name)
    node[described_cookbook][name]
  end

  shared_examples 'installs packages' do
    it 'installs necessary packages' do
      installed_packages.each { |name| expect(chef_run).to install_package(name) }
    end
  end

  shared_examples 'does not install packages' do
    it 'does not install packages' do
      packages_not_installed.each { |name| expect(chef_run).not_to install_package(name) }
    end
  end
end

# puts $LOAD_PATH
# ... define test helpers and content in this file

