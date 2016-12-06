Dir.chdir(Dir.pwd+"/scripts/")
ruby_scripts = Dir.entries(".").keep_if {|a| a.end_with? ".rb" }
ruby_scripts.each do |r|
    system "ruby #{r};"
end
exit(0)