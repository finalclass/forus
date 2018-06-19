require IEx

defmodule Forus.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Forus.Accounts.{User, Credential}
  alias Forus.Accounts.PasswordHasher

  schema "credentials" do
    field(:email, :string)
    field(:password, :string)
    belongs_to(:user, User)

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

  def update_password_changeset(credential, attrs) do
    password = credential.password
    credential = %{credential | password: nil}

    changeset = cast(credential, attrs, ~w(password)a)

    changeset
    |> validate_required(~w(password)a)
    |> validate_length(:password, min: 4)
    |> validate_confirmation(:password, message: "does not match password")
    |> Credential.validate_password(:password, password)
  end

  def validate_password(changeset, field, current_password) do
    error_param = "#{field}_current"
    error_field = String.to_atom(error_param)

    errors =
      case Map.fetch(changeset.params, error_param) do
        {:ok, new_password} ->
          new_password_encrypted = PasswordHasher.encode(new_password)

          case new_password_encrypted == current_password do
            true -> []
            _ -> [{error_field, {"is invalid", []}}]
          end

        :error ->
          [{error_field, {"can't be blank", []}}]
      end

    %{
      changeset
      | validations: [{:password} | changeset.validations],
        errors: errors ++ changeset.errors,
        valid?: changeset.valid? and errors == []
    }
  end
end
