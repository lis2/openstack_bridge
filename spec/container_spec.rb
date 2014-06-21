require 'spec_helper'

describe OpenstackBridge::Container, :vcr do
  subject {
    swift = OpenstackBridge::Swift.new('http://192.168.0.11:5000/v2.0/tokens', 'admin', 'q1w2', 'demo')
    OpenstackBridge::Container.new(swift, 'test_container')
  }

  it 'checks if object exists' do
    subject.exists?('no_file.txt').should == false
  end

  it 'creates object' do
    subject.create('test_file.txt', 'test content')
  end

  it 'gives list of container' do
    subject.objects.should == ['test_file.txt']
  end

  it 'reads objects do' do
    subject.read('test_file.txt').should == 'test content'
  end
end
