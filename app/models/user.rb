class User < ApplicationRecord
  rolify

  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email, :affiliation

  before_validation :set_default_sent_approval_email, on: :create

  after_create :send_welcome_message, :assign_default_role

  after_update :send_approved_message, if: :approved_and_not_notified?

  has_many :notes


  def is_super?
    self.has_role? "superuser"
  end

  def send_welcome_message
    AdminMailer.new_user_welcome_message(self).deliver
    AdminMailer.new_user_admin_alert(self).deliver
  end

  def send_approved_message
    AdminMailer.new_user_approved_notification(self).deliver
    self.update_attributes(sent_approved_email:true)
  end

  def active_for_authentication?
    super && approved?
  end

  def approved_and_not_notified?
    self.approved == true && self.sent_approved_email == false
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

  def set_default_sent_approval_email
    self.sent_approved_email = false
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
       "Besta Institute",
       "Guthy-Jackson Foundation",
       "Kyushu University",
       "MJ Fox Foundation",
       "Mayo Clinic",
       "NIH",
       "NIMH",
       "Oslo University Hospital",
       "Oxford University",
       "Stanford",
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
