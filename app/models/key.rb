class Key < ApplicationRecord
  mount_uploader :keyfile, KeyFileUploader #This will throw an uninitialized constant error if config/application.rb doesn't contain require 'carrierwave' and require 'carrierwave/orm/activerecord'
end
