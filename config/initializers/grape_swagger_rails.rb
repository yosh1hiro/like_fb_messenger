unless Rails.env.production?
  GrapeSwaggerRails.options.url      = "docs"
  GrapeSwaggerRails.options.app_name = 'GrapeSwagger'
  GrapeSwaggerRails.options.app_url  = '/'
end
