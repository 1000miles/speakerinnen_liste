#If you would like to remove unused tag objects after removing taggings
ActsAsTaggableOn.remove_unused_tags = true
#If you want to change the default delimiter (it defaults to ','). You can also pass in an array of delimiters such as ([',', '|']):

ActsAsTaggableOn.delimiter = ([',',';'])

ActsAsTaggableOn.force_lowercase = true

class MyParser < ActsAsTaggableOn::GenericParser
  def parse
    ActsAsTaggableOn::TagList.new.tap do |topic_list|
      topic_list.add @tag_list.split(/[\,,\;]/)
    end
  end
end

#ActsAsTaggableOn.default_parser = MyParser
#

ActsAsTaggableOn::Tag.class_eval do
  has_and_belongs_to_many :categories
  has_many :profiles
  #attr_accessible :name

  def merge(wrong_tag)
    # update all taggings on any of these wrong tags to now point to the correct tag that we keep
    Profile.tagged_with(wrong_tag).each do |profile|
      profile.topic_list.remove(wrong_tag.name)
      profile.topic_list.add(self.name, parser: MyParser)
      profile.save
      profile.reload
    end
  end

end

