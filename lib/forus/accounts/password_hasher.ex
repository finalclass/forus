defmodule Forus.Accounts.PasswordHasher do

  def encode(password) do
    :crypto.hash(:md5, password) |> Base.encode64
  end

end
