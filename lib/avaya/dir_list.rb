module Avaya
  class DirList
    attr_reader :directory

    def initialize
      @directory = Avaya::TFTP.read(:dir_list)
    end

    def self.get
      dir_list = self.new
      dir_list.get

    end

    def get
      list= []
      directory.each do |row|
        row = row.split(",")
        list << {
            name: row[0],
            number: row[1]
        }
      end
      list
    end


  end

end