class Game < ApplicationRecord
  belongs_to :developer
  belongs_to :genre
end
