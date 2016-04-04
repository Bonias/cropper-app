class Image < ActiveRecord::Base

  mount_uploader :file, ImageFileUploader

end
