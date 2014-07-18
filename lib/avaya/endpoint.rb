module Avaya
  def self.endpoint(end_point, var2 = nil)
    endpoints = {
        who_is: "nasystem/who_is",
        licence_list: "nasystem/licence_list",
        user_list: "nasystem/user_list#{var2}",
        hunt_list: "nasystem/hunt_list",
        dir_list: "nasystem/dir_list",
        extn_list: "nasystem/extn_list",
        accountCode: "nasystem/AccountCode",
        user_info: "nasystem/user_info/#{var2}",
        user_info2: "nasystem/user_info2/#{var2}",
        user_info3: "nasystem/user_info3/#{var2}",
        member_of: "nasystem/MemberOf/#{var2}",
        call_list: "nasystem/call_list/1/1",
        call_info: "nasystem/call_info/#{var2}",
        call_info2: "nasystem/call_info2/#{var2}",
        hunt_info: "nasystem/hunt_info/#{var2}",

    }
    endpoints[end_point]

  end
end