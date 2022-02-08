require 'rails_helper'

RSpec.describe 'Wallets', type: :request do
  let(:user) { create(:user) }
  let(:wallet) { create(:wallet, user_id: user.id) }
  # let(:wallet_params) { { name: 'Gringo Cabron' } }

  # Actions Tests
  describe 'GET /index' do
    before do
      sign_in user
    end

    it 'returns all wallets' do
      get '/api/v1/wallets', as: :json
      expect(JSON.parse(response.body).count).to eq(Wallet.count)
    end
  end

  describe 'GET /show' do
    before do
      sign_in user
    end

    it 'shows the requested wallet' do
      get "/api/v1/wallets/#{wallet.id}", as: :json
      expect(JSON.parse(response.body)['data']['id']).to eq(wallet.id)
    end
  end

  describe 'POST /api/v1/wallets' do
    before do
      sign_in user
    end

    context 'succes' do
      subject { post '/api/v1/wallets', params: { wallet: { name: 'Gringo Cabron' } }, as: :json }
      it 'create a new wallet' do
        # quando a requisicao for feita a qtde de wallets seja alterada dentro do bd
        expect { subject }.to change(Wallet, :count)
      end
    end

    context 'failure' do
      subject { post '/api/v1/wallets', params: { wallet: { name: nil } }, as: :json }
      it 'fail to create a new wallet' do
        # quando a requisicao for feita a qtde de wallets não seja alterada dentro do bd
        expect { subject }.not_to change(Wallet, :count)
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      sign_in user
    end

    # let(:wallet) { create(:wallet, user_id: user.id) }

    context 'success' do
      subject { delete "/api/v1/wallets/#{wallet.id}", as: :json }
      it 'destroys the requested wallet' do
        expect { subject }.to change(Wallet, :count).by(0)
      end
    end

    context 'failure' do
      subject { delete "/api/v1/wallets/12345678", as: :json }
      it 'fail to destroys the requested wallet' do
        expect { subject }.not_to change(Wallet, :count)
      end

      it 'returns error message' do
        subject
        expect(subject)
      end
    end
  end

  describe 'PATCH /update' do
    before do
      sign_in user
    end

    subject { patch "/api/v1/wallets/#{wallet.id}", params: { wallet: { name: 'Gringo Cabron' } }, as: :json }

    it 'updates the requested wallet' do
      expect(wallet.name).not_to eq('Gringo Cabron')
      subject
      wallet.reload
      expect(wallet.name).to eq('Gringo Cabron')
    end
  end
end
