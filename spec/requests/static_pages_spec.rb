require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  let!(:base_title) { 'sample' }

  describe 'GET /' do
    it 'return http success' do
      get '/'
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response.body).to include base_title
        expect(response.body).not_to include "- #{base_title}"
      end
    end
  end
end
