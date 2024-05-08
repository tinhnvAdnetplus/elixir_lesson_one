defmodule Sample.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :address, :string
      add :phone, :string
      add :email, :string
      add :birthday, :date
      add :department, :string
      add :contract_type, :integer
      add :start_date, :date

      timestamps(type: :utc_datetime)
    end
  end
end
