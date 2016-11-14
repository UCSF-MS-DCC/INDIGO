class Hlaupload < ApplicationRecord
  mount_uploader :datafile, HlaFileUploader
end
