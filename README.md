# OpenstackBridge

Basic integration with Openstack Swift. Implemented simple operation like exists?, read, create and delete.

## Installation

Add this line to your application's Gemfile:

    gem 'openstack_bridge'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openstack_bridge

## Usage

```ruby
  swift = OpenstackBridge::Swift.new('localhost', 'lis2', 'password', 'dev')
  swift.create('test_container')
  swift.containers # => ['test_container']
  swift.delete('test_container') 

  container = swift.container['test_container']
  container.exists?('readme.txt')
  container.read('readme.txt')
  container.delete('readme.txt')
  container.create('readme.txt', 'new content')
  container.objects # => ['readme.txt']
```

## Status
[![Build Status](https://travis-ci.org/lis2/openstack_bridge.svg?branch=master)](https://travis-ci.org/lis2/openstack_bridge.svg?branch=master)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
