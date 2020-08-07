# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :authorize_admin!
end
