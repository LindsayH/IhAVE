class User < ActiveRecord::Base
  rolify :role_cname => 'Public'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :locations, dependent: :destroy
  has_many :items, through: :locations, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  #Get the picture from a given url.
  def avatar_from_url(url)
    self.avatar = open(url)
  end

  # google auth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
      # user.avatar_file_name = URI.parse(auth.info.image) # assuming the user model has an image
      puts "\n********************************************************"
      puts "#{auth.info}"
      puts "\n********************************************************"
      user.avatar_from_url(auth.info.image) # assuming the user model has an image
      # raise error
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
