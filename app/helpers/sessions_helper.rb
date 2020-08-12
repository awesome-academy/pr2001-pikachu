# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
 end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def store_location
    if params[:previous_url].present?
      session[:forwarding_url] = params[:previous_url]
    else
      session[:forwarding_url] = request.original_url if request.get?
    end
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  def current_user?(user)
    user && user == current_user
  end

  def check_coin(booking_tour)
    if params[:bill].to_i > current_user.coin
      store_location
      flash[:danger] = "Not enough coin!
         Please nap coin! You need to nap at least #{params[:bill].to_i - current_user.coin} ! "
      redirect_to current_user
    else
      current_user.update(coin: current_user.coin - params[:bill].to_i)
      booking_tour.pay!
      Payment.book.create(user_id: current_user.id.to_s, coin: booking_tour.price_total.to_i.to_s,
             tour_id: booking_tour.tour_detail.tour.id)
      redirect_to tour_booking_tour_path(booking_tour.tour_detail.tour, booking_tour)
    end
  end
end
