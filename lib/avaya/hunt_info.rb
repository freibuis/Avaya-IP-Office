module Avaya
  class HuntInfo
    attr_reader :members

    def initialize(group)
      @members = Avaya::TFTP.read(:hunt_info, group)
    end

    def self.get group
      hunt_list = self.new(group)
      hunt_list.get

    end

    def get
      list= []
      members.each do |row|
        list << {
            ext:    row.sub("*", ""),
            active: ((row.include? "*") == false)
        }
      end

      list
    end


  end

end