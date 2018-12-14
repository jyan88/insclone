class AddUserRefToBlogs < ActiveRecord::Migration[5.1]
  def change
    add_reference :blogs, foreign_key: true
  end
end
