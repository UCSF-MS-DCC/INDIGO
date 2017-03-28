class Hlaupload < ApplicationRecord
  mount_uploader :datafile, HlaFileUploader
  validates_uniqueness_of :version
end
