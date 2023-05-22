class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def self.reverse_alpha
    find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc;")
  end

  def self.filter_status(type)
    # binding.pry
    find_by_sql("SELECT shelters.name FROM shelters JOIN pets ON pets.shelter_id = shelters.id JOIN pet_applications ON pet_applications.pet_id = pets.id JOIN applications ON applications.id = pet_applications.application_id WHERE applications.status = '#{type}';").pluck(:name)

    # SELECT shelters.name FROM shelters JOIN pets
    #     ON pets.shelter_id = shelters.id
    #       JOIN pet_applications
    #         ON pet_applications.pet_id = pets.id
    #           JOIN applications
    #             ON applications.id = pet_applications.application_id
    #   WHERE applications.status = "#{type}";
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where("age >= ?", age_filter)
  end
end
