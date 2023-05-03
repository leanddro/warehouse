require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      user = User.new(name: 'Leandro', email: 'leandro@email.com')

      result = user.description

      expect(result).to eq 'Leandro <leandro@email.com>'
    end
  end
end
