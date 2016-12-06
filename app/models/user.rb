class User < ApplicationRecord
  rolify
  
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email, :affiliation

  after_create :send_welcome_message, :assign_default_role

  def send_welcome_message
    AdminMailer.new_user_welcome_message(self).deliver
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  def assign_default_role
    add_role(:user)
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

   def select_affiliations
     return ["Aberdeen University",
       "Guthy-Jackson Foundation",
       "Kyushu University",
       "M.J. Fox Foundation",
       "Mayo Clinic",
       "NIA/NIH",
       "NIMH",
       "Oslo University Hospital",
       "Oxford University",
       "UCLA",
       "UCSF",
       "University of Bonn",
       "University of Highland and Islands",
       "University of London",
       "University of Pittsburgh",
       "University of Toronto",
       "Universtiy of Miami",
       "UT Southwestern",
       "Virginia Commonwealth University"]
   end
end
