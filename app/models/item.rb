class Item < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  has_many :records
  accepts_nested_attributes_for :records, reject_if: ->(hash_of_attributes) { hash_of_attributes['borrower_name'].blank? }
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :name, :description, presence: true

	acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :skills, :interests
  
end
