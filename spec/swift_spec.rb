require 'spec_helper'

describe OpenstackBridge::Swift, :vcr do
  subject { OpenstackBridge::Swift.new('http://192.168.0.11:5000/v2.0/tokens', 'admin', 'q1w2', 'demo') }

  it 'creates container' do
    subject.create('test_container')
    subject.containers.should == ['test_container']
  end

  it 'has end point' do
    subject.end_point.should == 'http://192.168.0.11:8080/v1/AUTH_21ac529de0e0437eb2a6de6c779c178c'
  end

  it 'creates container object' do
    subject.container('test_container').class.should == OpenstackBridge::Container
  end
end
