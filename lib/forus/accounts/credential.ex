defmodule Forus.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Forus.Accounts.User

  schema "credentials" do
    field :email, :string
    field :password, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
  end
end
