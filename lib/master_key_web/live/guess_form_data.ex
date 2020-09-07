defmodule MasterKeyWeb.GuessFormData do
  alias Ecto.Changeset

  @types %{guess: :string}

  def changeset(params) do
    {%{}, @types}
    |> Changeset.cast(params, Map.keys(@types))
    |> Changeset.validate_required([:guess])
    |> Changeset.validate_length(:guess, min: 4, max: 4)
    |> Map.put(:action, :validate)
  end
end
