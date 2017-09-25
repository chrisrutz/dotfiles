require 'awesome_print'
require 'irb/completion'
AwesomePrint.irb!
IRB.conf[:AUTO_INDENT]=true
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 10000
