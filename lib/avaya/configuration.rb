module Avaya
  module Configuration
    attr_accessor :host, :port
    extend self

    def config(&value)
      #@host = 'hostnameorip'
      @port = 69
      instance_eval &value
    end

  end
end