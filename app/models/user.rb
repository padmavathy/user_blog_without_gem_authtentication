class User < ActiveRecord::Base
  has_secure_password
  has_many :articles
  has_many :comments, :foreign_key => :user_id
  has_attached_file :cover_photo, :styles => { :medium => "840x375#", :large => "1920x1240#" }, :default_url => '/images/Profile/default_image.jpg'
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\Z/
  before_create :confirmation_token
  validates :cover_photo, presence: true,  on: :update
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
            uniqueness: true,
            format: {
                with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            }
  def to_s
    "#{first_name} #{last_name}"
  end

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

end
