module Avaya
  class HuntList
    attr_reader :directory

    def initialize
      @directory = Avaya::TFTP.read(:hunt_list)
    end

    def self.get
      hunt_list = self.new
      hunt_list.get

    end

    def get
      list= []
      directory.each do |row|
        row = row.split(",")
        list << {
            name: row[0],
            ext: row[1],
            queue: row[2],
            voice_mails: row[7],
            hunt_id: row[9]
        }
      end

      list
    end


  end

end