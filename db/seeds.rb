# Seed sqlite database with users and elastic index names
foo_index  = ElasticIndex.create(name: 'foo_index')
bar_index  = ElasticIndex.create(name: 'bar_index')
baz_index  = ElasticIndex.create(name: 'baz_index')
buzz_index = ElasticIndex.create(name: 'buzz_index')

%w(foo buzz).each do |name|
  User.create(
    name: name,
    elastic_indices: [foo_index, bar_index, baz_index, buzz_index]
  )
end

bar_index = User.create(name: 'bar', elastic_indices: [bar_index])
baz_index = User.create(name: 'baz', elastic_indices: [baz_index])

# Seed elasticsearch database with documents
documents = YAML.load_file('db/elasticsearch_seeds.yaml')
uri = URI(Rails.application.config.elasticsearch_url)
http = Net::HTTP.new(uri.host, uri.port)

documents.each do |document|
  index = document.delete('index')
  id = document.delete('id')
  request = Net::HTTP::Put.new(
    "/#{index}/docs/#{id}",
    {'Content-Type' => 'application/json'}
  )
  http.request(request, document.to_json)
end
