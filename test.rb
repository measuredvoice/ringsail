lines = File.readlines("language_list.txt")

output = File.new("output.txt", "w+")

lines.each do |line|
  elements = line.split("|")
  output.write "\"#{elements[3]}\",\n\r"
end