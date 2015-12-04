class AddNameLocationCompanyDescriptionTwitterGithubToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :location, :string
    add_column :users, :company, :string
    add_column :users, :description, :text
    add_column :users, :twitter, :string
    add_column :users, :github, :string
  end
end
