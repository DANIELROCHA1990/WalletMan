class Api::V1::WalletsController < Api::V1::ApiController
  before_action :set_wallet, only: %i[show update destroy]
  before_action :require_authorization!, only: %i[show update destroy]

  # GET /wallets
  def index
    @wallets = current_user.wallets
    render json: @wallets
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  # Pasando parametros permitidos
  def wallet_params
    params.require(:wallet).permit(:name, :public, :transactions, :dividends)
  end

  # Verifica se wallet pertence ao current_user
  def require_authorization!
    render json: {}, status: 401 unless current_user == wallet.user
  end

  def set_wallet
    @wallet = Wallet.find(params[:id])
  end
end
