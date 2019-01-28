namespace :db do
  desc "Add a list of centers to the centers table"
  task create_or_update_centers: :environment do
    centers = [
      "Kigali",
      "Lagos",
      "Nairobi",
      "Kampala"
    ]
    centers.each do |center|
      Center.find_or_create_by(name: center)
    end

    p "Completed....."
  end
end
