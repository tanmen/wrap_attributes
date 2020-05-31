module WrapAttributes
  VERSION = ENV['VERSION']&.match(/^refs\/tags\/v(\d\.\d\.\d)$/)&.[](1) || '0.1.2'
end
