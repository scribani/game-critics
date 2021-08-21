class AddDefaultValueDeveloperPublisherToInvolvedCompanies < ActiveRecord::Migration[6.1]
  def change
    # change_column_default :involved_companies, :developer, :publisher, default: false
    change_column_default(:involved_companies, :developer, from: nil, to: false)
    change_column_default(:involved_companies, :publisher, from: nil, to: false)

  end
end
