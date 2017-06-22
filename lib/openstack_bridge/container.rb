module OpenstackBridge
  class Container < Struct.new(:swift, :container)
    def exists?(name)
      (200..299).include? swift.request(:head, file_path(name)).code
    rescue OpenstackBridge::Error
      false
    end

    def objects
      swift.request(:get, container_path).raw_body.split("\n")
    end

    def read(name)
      swift.request(:get, file_path(name)).raw_body
    end

    def create(name, content)
      swift.request(:put, file_path(name), content)
    end

    def delete(name)
      swift.request(:delete, file_path(name))
    end

    private

    def container_path
      "#{swift.end_point}/#{container}"
    end

    def file_path(name)
      "#{container_path}/#{name}"
    end
  end
end
