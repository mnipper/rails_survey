class AddRequireConsentAndConsentFormTextToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :require_consent, :boolean
    add_column :projects, :consent_form_text, :text
  end
end
