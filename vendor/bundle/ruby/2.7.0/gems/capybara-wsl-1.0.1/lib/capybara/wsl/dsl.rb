# frozen_string_literal: true

module Capybara
  module WSL
    module DSL
      def save_and_open_screenshot(path = nil)
        Capybara::WSL.save_and_open_screenshot(path)
      end

      def save_and_open_screenshot_wsl(path = nil, **options)
        Capybara::WSL.save_and_open_screenshot(path, options)
      end
    end
  end
end
