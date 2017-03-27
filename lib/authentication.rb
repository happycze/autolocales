# General strategy to authenticate user
Warden::Strategies.add(:password) do
  def valid?
    params["email"] || params["response"] || params["nonce"]
  end

  def authenticate!
    if user = User.authenticate(params["email"], params["response"], params["nonce"])
      success!(user)
    else
      fail!("Could not log in!")
    end
  end
end

# Strategy to authenticate user after successfull registration
Warden::Strategies.add(:registration) do
  def authenticate!
    if user = User.authenticate_registration(params["email"], params["response"])
      success!(user)
    else
      fail!("Could not log in!")
    end
  end
end

Warden::Manager.serialize_into_session { |user| user.id }
Warden::Manager.serialize_from_session { |id| User[id] }

def logged_in_as_admin?
  login
  unless user.role==255
    redirect "/"
  end
end