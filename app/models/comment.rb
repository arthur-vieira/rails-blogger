class Comment < ActiveRecord::Base
  belongs_to :article
  # the objects on the "many" end (in this case, this class itself) should have a foreign key referencing the "one" object (article);
  # that foreign key should be titled with the name of the "one" object, then an underscore, then "id" (in this case, "article_id")
end
