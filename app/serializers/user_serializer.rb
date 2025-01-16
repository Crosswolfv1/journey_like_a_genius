class UserSerializer

  def self.format_user_list(users)
    { data:
        users.map do |user|
          {
            id: user.id.to_s,
            type: "user",
            attributes: {
              name: user.name,
            }
          }
        end
    }
  end

  def self.format_user(user)
    {data:
      {
        id: user.id.to_s,
        type: "user",
        attributes: {
        name: user.name,
            }
          }
  }
  end
end