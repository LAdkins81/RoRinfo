class Song < ActiveRecord::Base
  has_many :playlists
  has_many :users, through: :playlists

  validates :title, :artist, presence: true
  validates :title, :artist, length: { minimum: 2 }

end
