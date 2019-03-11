class Upload < ApplicationRecord
  belongs_to :user
  has_attached_file :file
  validates_attachment :file, presence: true, content_type: { content_type: "application/pdf" }#, if: Proc.new {|a| a.info.present? }  presence: true,

  def g_iframe(dm)
  	i_frame = "<div class='row'><iframe src='#{dm}#{self.file.url}' data-uploadid='#{self.id}' style='width:100%;height:100%;'></iframe></div>"
  	desc = ''
  	reader = PDF::Reader.new(self.file.path)
  	reader.pages.each do |page| 
      desc += page.text
      desc += "\r\n"     
    end
  	self.update_attributes(iframe: i_frame, description: desc)
  end
end
