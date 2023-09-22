Sentry.init do |config|
  config.dsn = 'https://b535d12a89f70b557eecf247e64ed70d@o4505922779545600.ingest.sentry.io/4505922787540992'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.enabled_environments = ['development']
  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda { |context| true }
end
