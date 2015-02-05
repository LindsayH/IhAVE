class Item < ActiveRecord::Base
  include PgSearch

  belongs_to :location
  belongs_to :user
  has_many :records, dependent: :destroy
  accepts_nested_attributes_for :records

  
  has_attached_file :avatar, :styles => { :medium => "250x250!>", :thumb => "100x100>" }, :default_url => "Logo.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :name, :description, presence: true

	acts_as_taggable # Alias for acts_as_taggable_on :tags
  # acts_as_taggable_on :skills, :interests

  pg_search_scope :search_items, against: [:name]
                  # :if => :search_valid?
                  # :if => lambda { |item| item.user_id = current_user.id  }

  paginates_per 12

  def item_search(search_input)
    Item.search(search_input)
  end 

  def search_valid?
    user_id == current_user.id
  end





  
end
