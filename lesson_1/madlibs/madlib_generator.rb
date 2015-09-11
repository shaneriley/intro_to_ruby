dictionary = {
  nouns: File.open("nouns.txt", "r").read.split(" "),
  verbs: File.open("verbs.txt", "r").read.split(" "),
  adjectives: File.open("adjectives.txt", "r").read.split(" ")
}

filename = ARGV[0]

if filename == nil
  puts "No input file specified. Run using `ruby madlib_generator.rb`"
  exit
end

if !File.exists?(filename)
  puts "No file with the name #{filename}"
  exit
end

source = File.open(filename, "r").read
source.gsub!(/NOUN/).each { dictionary[:nouns].sample }
source.gsub!(/VERB/).each { dictionary[:verbs].sample }
puts source.gsub!(/ADJECTIVE/).each { dictionary[:adjectives].sample }
