class Article < ActiveRecord::Base
	has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  #has_attached_file :image # this method is part of the paperclip library.
  # paperclip will understand that this model should accept a file attachment and that there are fields to store information about that file which start with image_ in this model’s database table
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  #validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"] # Paperclip raises MissingRequiredValidatorError error if you do not do this
  # As of version 4.0, for security reasons, all attachments are required to include a content_type validation, a file_name validation, or to explicitly state that they’re not going to have either.
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def tag_list
    #tags.join(", ") # doesn't work 'cause the array of tags is an Array of tag instances. To make it work, either add a "def to_s; name; end" method to tag.rb or use the method below:
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end
  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
