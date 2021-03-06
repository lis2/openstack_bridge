module OpenstackBridge
  class Swift < Struct.new(:host, :user, :password, :tenant, :region)
    attr_accessor :authentication

    def initialize(*)
      super
      self.authentication = OpenstackBridge::Authentication.new(host, user, password, tenant)
      raise "Wrong authentication response" if !self.authentication.response || !self.authentication.response['access']
    end

    def end_points
      self.authentication.response['access']['serviceCatalog'].detect {|s| s['name'] == 'swift'}['endpoints']
    end

    def end_point
      (region ? end_points.detect { |end_point| end_point['region'] == region } : end_points.first)['publicURL']
    end

    def containers
      request(:get, "#{end_point}").raw_body.split("\n")
    end

    def create(name)
      request(:put, "#{end_point}/#{name}")
    end

    def delete(name)
      request(:delete, "#{end_point}/#{name}")
    end

    def container(name)
      create(name) unless containers.include?(name)
      OpenstackBridge::Container.new(self, name)
    end

    def request(method, path, params={}.to_json, httpclient = false)
      request = HTTPI::Request.new
      request.url = path
      request.body = params
      request.headers['Content-Type'] = 'application/json'
      request.headers['X-Auth-Token'] = authentication.token
      response = HTTPI.send(method, request, (httpclient ? :httpclient : :curb))
      raise OpenstackBridge::Error.new(self), response.raw_body unless [200, 201, 202, 204].include?(response.code.to_i)
      response
    end
  end
end
