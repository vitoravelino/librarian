class Thesis < ActiveRecord::Base
  attr_accessible :author, :text, :title, :year, :file

  validates_presence_of :author, :title, :year, :file, :message => "Can't be blank"

  after_destroy :delete_file

  searchable :auto_index => false, :auto_remove => true do
    text :title, :boost => 3.0
    text :author, :boost => 2.0
    text :text, :stored => true
    text :year, :boost => 2.0
  end

  private
    def delete_file
      puts "@@@@@@@@@@@@@"
      path = Rails.root.join('public', 'uploads', "#{self.file}")
      path.delete if path.exist?
    end
end
