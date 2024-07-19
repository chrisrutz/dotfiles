begin
  require 'pry'
rescue LoadError
end

if defined?(Pry)
  Pry.start
  exit
end

IRB.conf[:USE_SINGLELINE] = true
IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:EVAL_HISTORY] = 0
