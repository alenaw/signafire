# Seed sqlite database with users and elastic index names
elastic_indices = %w(foo_index bar_index baz_index buzz_index)

elastic_indices.each do |name|
  ElasticIndex.create(name: name)
end

%w(foo buzz).each do |name|
  User.create(name: name)
end

# Seed elasticsearch database with results
