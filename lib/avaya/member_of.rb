module Avaya
  class MemberOf
    attr_reader :groups

    def initialize(ext)
      @groups = Avaya::TFTP.read(:member_of, ext)
    end

    def self.get ext
      hunt_list = self.new(ext)
      hunt_list.get

    end

    def get
      list= []
      groups.each do |group|
        group = group.split(",")
        list << {
            group: group[0],
            ext: group[1],
            queue: group[2] ,
            group_id: group.last

        }
      end

      list
    end


  end

end