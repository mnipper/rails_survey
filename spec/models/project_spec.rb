# == Schema Information
#
# Table name: projects
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text
#  created_at        :datetime
#  updated_at        :datetime
#  require_consent   :boolean
#  consent_form_text :text
#

require "spec_helper"

describe Project do
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:require_consent) }
  it { should respond_to(:consent_form_text) }
end
