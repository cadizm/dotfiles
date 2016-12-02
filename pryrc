Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'q', 'exit-all'

Pry::Commands.block_command "dl", "Dump passed object to log" do
  vars = target.local_variables.select { |v| !v.to_s.starts_with?('_') }
  foo = Hash[vars.map { |k| [k, target.local_variable_get(k)] }].to_json
  File.open('/tmp/foo.json', 'w') { |f| f.write(foo) }
  output.puts "Dumped locals to \"/tmp/foo.json\""
end
