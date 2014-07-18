require 'tempfile'
module Avaya
  attr_accessor :file_data
  attr_reader :random_file

  class TFTP
    def initialize (file)
      tftp = Net::TFTP.new(Avaya::Configuration.host)
      temp_file = Tempfile.new(random_file)
      tftp.getbinaryfile(file, temp_file)
      @file_data = temp_file.read
      temp_file.close # close instead of unlink to prevent rails for breaking
    end

    def self.read(file, var2=nil)
      tftp = self.new Avaya.endpoint(file, var2)
      tftp.file_data
    end

    def file_data
      @file_data.split("\r\n")
    end

    def random_file
      (0...25).map { ('a'..'z').to_a[rand(26)] }.join
    end

  end


end