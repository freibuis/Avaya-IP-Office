module Avaya
  class UserList
    attr_reader :user_list

    def initialize(list_id ="")
      @user_list = Avaya::TFTP.read(:user_list, list_id)
    end

    def self.get(list_id = "")
      hunt_list = self.new(list_id)
      hunt_list.get

    end

    def get
      list= []
      user_list.each do |row|
        row     = row.split(",")
        new_row = {
            name:      row[0],
            ext:       row[1],
            full_name: row[2],
            user_id:   row.last

        }
        unless @list_id == "" or @list_id == "2"
          new_row.merge! ex_directory: (row[3] =="1")
          new_row.merge! active: (row[4] == "1")
        end
        list << new_row
      end

      list
    end


  end

end