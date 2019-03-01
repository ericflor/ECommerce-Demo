class Instrument < ApplicationRecord
    before_destroy :not_referenced_by_any_line_item
    mount_uploader :image, ImageUploader
    serialize :image, JSON
    belongs_to :user, optional: true
    has_many :line_items

    validates :title, :brand, :price, :model, presence: true
    validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum amount allowed."}
    validates :title, length: { maximum: 140, too_long: "%{count} characters is the max amount allowed."}
    validates :price, numericality: { only_integer: true }, length: { maximum: 7 }

    BRAND = %w{ Fender Gibson Epiphone ESP Martin Dean Taylor Jackson PRS  Ibanez Charvel Washburn }
    FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam }
    CONDITION = %w{ New Excellent Mint Used Fair Poor }

    private

    def not_refereced_by_any_line_item
        unless line_items.empty?
          errors.add(:base, "Line items present")
          throw :abort
        end
    end
    
end
