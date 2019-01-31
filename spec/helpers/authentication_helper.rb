require "jwt"
require "rake"

module AuthenticationHelper
  def stub_admin
    allow(JWT).to receive(:decode).and_return(
      [
        {
          "UserInfo" => {
            "id" => "-KXGy3EB1oimjQgFim8I",
            "email" => "admin-user@andela.com",
            "first_name" => "admin",
            "last_name" => "user",
            "name" => "User Admin",
            "andelan" => true,
            "picture" => "",
            "roles" => { "Admin" => "-KXGy1EB1oimjQgFim6I" }
          }
        }
      ],
    )
  end

  def stub_non_admin
    allow(JWT).to receive(:decode).and_return(
      [
        {
          "UserInfo" => {
            "id" => "-KXWy0EB1oiljQgFim1I",
            "email" => "user@andela.com",
            "first_name" => "test",
            "last_name" => "user",
            "name" => "User Test",
            "andelan" => true,
            "picture" => "",
            "roles" => { "Andelan" => "-KXGy5EB1oimjQgFim7I" }
          }
        }
      ],
    )
  end
end
