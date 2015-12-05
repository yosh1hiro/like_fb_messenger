unless Rails.env.production?
  GrapeSwaggerRails.options.url      = "v1/docs"
  GrapeSwaggerRails.options.app_name = 'GrapeSwagger'
  GrapeSwaggerRails.options.app_url  = '/'
end
