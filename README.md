# OpenstackBridge

Basic integration with Openstack swift


## Installation

Add this line to your application's Gemfile:

    gem 'openstack_bridge'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openstack_bridge

## Usage

```ruby
  swift = OpenstackBridge::Swift.new('localhost', 'lis2', 'password', 'dev', 'container_name')
  swift.exists?('readme.txt')
  swift.read('readme.txt')
  swift.delete('readme.txt')
  swift.create('readme.txt', 'new content')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
