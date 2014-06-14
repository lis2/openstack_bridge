module OpenstackBridge
  class Swift < Struct.new(host, user, password, tenant, container)
    attr_accessor :authentication_response

    def initialize
      self.authentication_response = OpenstackBridge::Authentication.new.response
    end

    def token
      self.authentication_response['access']['token']['id']
    end

    def end_point
      self.authentication_response['access']['serviceCatalog'].detect {|s| s['name'] == 'swift'}['endpoints'].first['publicURL']
    end

    def file_path(path)
      "#{end_point}/#{container}/#{path}"
    end

    def exists?(path)
      request(:head, file_path(path)).code == 200
    end

    def read(path)
      request(:get, file_path(path)).raw_body
    end

    def delete(path)
      request(:delete, file_path(path))
    end

    def create(path, content)
      request(:put, file_path(path), content)
    end


    def request(method, path, params={}.to_json, httpclient = false)
      request = HTTPI::Request.new
      request.url = path
      request.body = params
      request.headers['Content-Type'] = 'application/json'
      request.headers['X-Auth-Token'] = token
      HTTPI.send(method, request, (httpclient ? :httpclient : :curb))
    end
  end

end
