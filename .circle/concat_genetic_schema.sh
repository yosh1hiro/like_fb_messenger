(/usr/bin/env ruby -e 'lines=STDIN.readlines; puts lines[0,lines.size-1]' >> db/schema.rb.tmp) < db/schema.rb
cat db/genetic_schema.rb >> db/schema.rb.tmp
cat db/schema.rb.tmp > db/schema.rb
