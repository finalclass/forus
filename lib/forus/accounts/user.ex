defmodule Forus.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Forus.Accounts.Credential
  

  schema "users" do
    field :name, :string
    has_many :credentials, Credential

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
