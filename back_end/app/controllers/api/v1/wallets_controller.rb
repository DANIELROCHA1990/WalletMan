class Api::V1::WalletsController < Api::V1::ApiController
  before_action :set_wallet, only: %i[show update destroy]
  before_action :require_authorization!, only: %i[show update]

  # GET /wallets
  def index
    wallets = current_user.wallets
    render json: wallets
  end

  def show
    render json: { message: 'Wallet Carregada', data: @wallet }, status: 200
  end

  def create
    wallet = Wallet.new(wallet_params)
    wallet.user = current_user

    if wallet.save
      render json: { message: 'Wallet Criado', data: @wallet }, status: 200
    else
      render json: wallet.errors, status: :unprocessable_entity
    end
  end

  def update
    if @wallet.update(wallet_params)
      render json: { message: 'Wallet Atualizada', data: @wallet }, status: 200
    else
      render json: wallet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @wallet.destroy
    render json: { message: 'Wallet Excluida', data: @wallet }, status: 200
  rescue StandardError => e
    render json: { message: e.message }
  end

  private

  # Pasando parametros permitidos
  def wallet_params
    params.require(:wallet).permit(:name, :public, :transactions, :dividends)
  end

  # Verifica se wallet pertence ao current_user
  def require_authorization!
    render json: {}, status: 401 unless current_user == @wallet&.user
  end

  def set_wallet
    @wallet = Wallet.find_by(id: params[:id])
  end
end
