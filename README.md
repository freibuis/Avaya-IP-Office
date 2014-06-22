# Avaya Ip Office integration

This gem gives limted read only integration from your IPOFFICE (only tested on ip office 500v2)

## Installation

Add this line to your application's Gemfile:

    gem 'Avaya' , :git => 'git://github.com/freibuis/Avaya-IP-Office.git' ,branch: master
    
And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Avaya

For rails support just run the following command. This will create the initializer for you to edit

    $ rails generate avaya:install

## Usage

1st create the connection 
   $ Avaya::Configuration.config  {|config| config.host = "ip_office_server_ipaddress"}

Once you have set up the connection. you can use the helpers to get data out

### Helper-ish

#### DirList: directory list

    $ dir_list = Avaya::DirList.get

This returns an array of :name, :numbers

#### UserList: list of phone system users. if type is 3..7 then :ex_directory and :active is returned
````ruby
   user_list = Avaya::UserList.get
   user_list = Avaya::UserList.get(2)
   user_list = Avaya::UserList.get(3)
   user_list = Avaya::UserList.get(4)
````

#### HunList: list of phone system groups. 
````ruby
   hunt_list = Avaya::HuntList.get
````

an array of :name,:ext,:queue,:voice_mails,:hunt_id is returned


## Todo:

Currently CallList not working as I need to reverse engineer the values from the phone platform
 
 
## Contributing

1. Fork it ( https://github.com/freibuis/Avaya-IP-Office/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
