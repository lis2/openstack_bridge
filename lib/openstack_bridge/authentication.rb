module OpenstackBridge
  class Authentication < Struct.new(:host, :username, :password, :tenant)
    attr_accessor :response

    def initialize(*)
      super
      request = HTTPI::Request.new
      request.url = tokens_url host
      request.body = auth_hash.to_json
      request.headers['Content-Type'] = 'application/json'
      self.response = JSON.parse(HTTPI.post(request, :curb).body)
    end

    def token
      self.response['access']['token']['id']
    end

    private

    def tokens_url(host)
      host.end_with?('tokens') ? host : File.join(host, 'tokens')
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
