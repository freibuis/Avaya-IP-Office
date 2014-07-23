module Avaya
  class UserInfo
    attr_reader :raw,
                :user,
                :login_name,
                :full_name,
                :ext,
                :forward_unconditional,
                :forward_unconditional_number,
                :forward_unconditional_all_calls,
                :forward_busy,
                :dnd,
                :logged_in,
                :connected_party,
                :phone_state

    def initialize(ext)
      @ext = ext
    end

    def self.get (ext)
      user_info = self.new(ext)
      user_info.get
      user_info
    end

    def get
      @raw       = Avaya::TFTP.read(:"user_info#{3}", @ext)
      @user_info = @raw[0].split(',')

      @login_name                      = @user_info[0]
      @full_name                       = @user_info[1]
      @ext                             = @user_info[2]
      @forward_busy                    = @user_info[3] == "1" ? true : false
      @forward_no_answer               = @user_info[4] == "1" ? true : false
      @forward_unconditional           = @user_info[5] == "1" ? true : false
      @forward_unconditional_number    = @user_info[6]
      @dnd                             = @user_info[8] == "1" ? true : false
      #Phone State "no" on hook ,"og" off hook
      @phone_state                     = @user_info[19]
      @connected_party                 = @user_info[20]
      @forward_unconditional_all_calls = @user_info[25] == "1" ? true : false
      @logged_in                       = @user_info[44] == "1" ? true : false
      self
    end


  end

end