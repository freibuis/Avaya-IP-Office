module Avaya
  class UserInfo
    attr_reader :user, :login_name, :full_name, :ext,
                :forward_unconditional, :forward_unconditional_number, :forward_unconditional_all_calls,
                :forward_me_to, :forward_busy, :dnd, :voicemail

    def initialize(user)
      @search = user
      get

    end

    def self.get (user)
      user_info = self.new(user)
      user_info
    end

    def get
      @user = Avaya::TFTP.read(:"user_info#{3}", @search)
      @user = @user[0].split(',')

      @login_name = @user[0]
      @full_name = @user[1]
      @ext = @user[2]
      @forward_busy = @user[3] == "1" ? true : false
      @forward_no_answer = @user[4] == "1" ? true : false
      @forward_unconditional = @user[5] == "1" ? true : false
      @forward_unconditional_number = @user[6]
      @dnd = @user[7] == "1" ? true : false

      @forward_unconditional_all_calls = @user[25] == "1" ? true : false
      @forward_me_to = @user[8] == "1" ? true : false
      @voicemail_to_email = @user[11] == "1" ? true : false
      @voicemail_count = @user[11]
      "updated"
    end


  end

end