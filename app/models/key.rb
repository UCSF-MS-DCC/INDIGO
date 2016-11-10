class Key < ApplicationRecord
  mount_uploader :keyfile, KeyFileUploader
end
