class Page < ApplicationRecord
	belongs_to :contato
	validates :contato_id, :presence => true
end
