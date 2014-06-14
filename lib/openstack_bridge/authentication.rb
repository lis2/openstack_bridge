module OpenstackBridge
  class Authentication < Struct.new(:host, username, password, tenant)
    attr_accessor :response

    def initialize
      request = HTTPI::Request.new
      request.url = host
      request.body = auth_hash.to_json
      request.headers['Content-Type'] = 'application/json'
      self.response = JSON.parse(HTTPI.post(request, :curb).body)
    end

    def auth_hash
      {
        "auth" => {
          "passwordCredentials" =>{
            "username" => username,
            "password" => password
          },
          "tenantName" => tenant
        }
      }
    end
  end
end
