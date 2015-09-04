class Api::BaseController < ApplicationController
  def index
  end

  def response_success(message = "")
    render json: {status: "ok", message: message }
  end

  def response_fail(message = "")
    render json: {status: "fail", message: message}
  end
end

