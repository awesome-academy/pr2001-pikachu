class Admin::PaymentsController < Admin::BaseController
  def index
    @payments = Payment.paginate(page: params[:page], per_page: 8)
  end
end
