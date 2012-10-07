# == Schema Information
#
# Table name: tokenizers
#
#  id         :integer         not null, primary key
#  uid        :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# Temporal token for the PDF Kit to access the system without a session
# 
# You can get a new token using the usual ActiveRecord constructor.
#
# You can use the uid accessor to get the key PDF Kit can use to 
# roundtrip, or use the Ruby built-in to_s.
#
# url = "/reports/1?url=#{tokenizer.key}"
#
# When PDF Kit comes back, it can use the key to get back your token:
#
# tokenizer = Tokenizer.find_token_by_uid(key)
# 
# Be careful: the token expires after a time (use expiration_time static 
# method to know much time they take to expire). If yor token has expired an
# error will be raised.
class Tokenizer < ActiveRecord::Base
  attr_accessible :uid, :user_id

  belongs_to :user
  
  validates :uid, :presence => true, :uniqueness => true
  validates :user, :presence => true

  after_initialize :after_initialize

  # Token timeout in seconds
  EXPIRATION_TIME = 60

  def after_initialize
    random_uid = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
    self.uid ||= random_uid
  end

  # How much time takes a token to expire since it was created, in seconds
  def self.expiration_time
    EXPIRATION_TIME
  end

  # Gets the tokenizer bt a uid
  # @param uid the uid token
  # @returns the tokenizer
  def self.find_by_uid(uid)
    # Expire previously created tokens
    self.expire_tokenizers

    tokenizer = Tokenizer.where("uid = ?", uid)

    if tokenizer.length == 0
      raise "Tokenizer #{uid} cannot be found or is expired"
    end
    tokenizer.first
  end

  def to_s()
    self.uid
  end

private

  # Run through the token database and expire those that are old
  def self.expire_tokenizers
    created_at = (Time.now - EXPIRATION_TIME)
    Tokenizer.delete_all("created_at < '#{created_at}'")
  end

end