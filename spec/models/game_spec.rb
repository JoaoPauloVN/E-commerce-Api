require 'rails_helper'

RSpec.describe Game, type: :model do
  it { is_expected.to validate_presence_of(:mode) }
  it { is_expected.to validate_presence_of(:release_date) }
  it { is_expected.to validate_presence_of(:developer) }
  it { is_expected.to belong_to :system_requirement }
  it { is_expected.to have_one :product }

end
