class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.integer :number
    	t.belongs_to :user
    	t.belongs_to :comment
    end
  end
end
