Plain.configure do |config|
  config.paths = [Rails.root.join('Gemfile'), Rails.root.join('app/models'), Rails.root.join('app/controllers'), Rails.root.join('spec')]
  config.extensions = %w[rb js md json erb]
  config.chat_environments = [:development]

  # initialize your vector search
  config.vector_search =
    Langchain::Vectorsearch::Qdrant.new(
      url: ENV['QDRANT_URL'],
      api_key: ENV['QDRANT_API_KEY'],
      index_name: ENV['QDRANT_INDEX'],
      llm: Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'], llm_options: {}, default_options: { chat_completion_model_name: 'gpt-3.5-turbo-16k' }),
    )
end
