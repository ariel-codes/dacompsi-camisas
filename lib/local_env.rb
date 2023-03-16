# frozen_string_literal: true

module LocalEnv
  def self.load_env
    env_file = File.join(Rails.root, "config", "env.#{Rails.env}.yml")
    if File.exist?(env_file)
      YAML.load_file(env_file)[Rails.env].each do |key, value|
        ENV[key] = value
      end
    end
  end
end
