class UsersController < ApplicationController

  def read
    user = User.find_by(name: params[:name])

    if user.present?
      render json: read_response(user)
    else
      render_error(404, 'user not found')
    end
  end

  private; def read_response(user)
    {
      name: user.name,
      authorized_indices: user.elastic_indices.map(&:name)
    }.to_json
  end

end
