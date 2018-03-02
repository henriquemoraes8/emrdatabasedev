require 'rabl'

Rabl.register!

class PrettyJson
  def self.dump(object)
    JSON.pretty_generate(object, {:indent => "  "})
  end
end

Rabl.configure do |config|
  config.view_paths = [Rails.root.join('app', 'views')]
end