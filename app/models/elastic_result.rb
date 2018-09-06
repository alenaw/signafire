class ElasticResult
  include ActiveModel::Model

  attr_accessor :id, :full_name, :location

  def self.where(params, indices='_all')
    indices = [indices].flatten

    query_string = []
    params.each { |key, value| query_string << "#{key}:#{value}" }
    query_string = query_string.join(' AND ')

    uri = URI(Rails.application.config.elasticsearch_url)
    uri.path = ("/#{indices.join(',')}/_search")
    uri.query = URI.encode_www_form({q: query_string})

    response = Net::HTTP.get_response(uri)

    if response.code == '200'
      results = JSON.parse(response.body).dig('hits', 'hits') || []
      results.map do |result|
        doc = result['_source'] || {}
        self.new(
          id: result['_id'],
          full_name: "#{doc['first_name']} #{doc['last_name']}",
          location: doc['location']
        )
      end
    else
      [] #TODO: render database error
    end
  end
end
