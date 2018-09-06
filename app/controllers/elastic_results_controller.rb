class ElasticResultsController < ApplicationController

  PERMITTED_QUERY_PARAMS = %i( first_name last_name location )

  def query
    user_name = request.headers['User-Name']
    if user_name.present?
      user = User.find_by(name: user_name)
      if user.present?
        authorized_indices = user.elastic_indices.map(&:name)
        index_param = params['index']
        if index_param.blank? || authorized_indices.include?(index_param)
          permitted = params.permit(PERMITTED_QUERY_PARAMS)
          if permitted.present?
            results = ElasticResult.where(
              permitted,
              index_param || authorized_indices
            )
            render json: { results: results }.to_json
          else
            render_error(400, 'at least one query parameter must be present')
          end
        else
          render_error(403, 'user does not have access to this index')
        end
      else
        render_error(401, 'invalid user credentials')
      end
    else
      render_error(401, 'missing user credentials')
    end
  end
end
