class Kirupload < ApplicationRecord
  mount_uploader :datafile, KirFileUploader
end
