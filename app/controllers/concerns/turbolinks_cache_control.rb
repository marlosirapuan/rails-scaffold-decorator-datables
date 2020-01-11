# frozen_string_literal: true

module TurbolinksCacheControl
  extend ActiveSupport::Concern

  included do
    before_action :disable_turbolinks_preview_cache, only: [ :new, :edit ]
    before_action :disable_turbolinks_cache, only: :index
    # Tiny hack for Decorator (format .json)
    before_action only: :index do
      params[:start]    ||= 0
      params[:length]   ||= 10
      params["columns"] ||= { "0" => {"data" => "" } }
    end
  end

  private

  def enable_turbolinks_cache
    @turbolinks_cache_control = 'cache'
  end

  def disable_turbolinks_cache
    @turbolinks_cache_control = 'no-cache'
  end

  def disable_turbolinks_preview_cache
    @turbolinks_cache_control = 'no-preview'
  end
end
